Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF3F53D6E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2A5e-0004He-RV; Mon, 16 Mar 2026 11:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2A5a-0004HF-Uf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2A5T-0002KH-Cn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773675753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84JrKofzZCReOiNCD1FJQOzYY7ckvGnLeAtNCrRxta4=;
 b=SfiEXcYrKF5PqDEXvrWvElif1hqhskduXBrtp0grlON2zd+M7Fpaen5YJs+CW9YZHOJdWs
 NyKbTw3ff8gKTgZmlQEYGdW4d+Mz7s7LAR0wZBqhkzmfvyL5yUTaT0ygBQRmA8++0jOMgj
 9zWiOYSVGgABLfomwZQw4k34zw5Wejg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-28h1UtgoPne0YWlL1Qralg-1; Mon, 16 Mar 2026 11:42:31 -0400
X-MC-Unique: 28h1UtgoPne0YWlL1Qralg-1
X-Mimecast-MFC-AGG-ID: 28h1UtgoPne0YWlL1Qralg_1773675751
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89c519dbafeso93320166d6.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773675751; x=1774280551; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=84JrKofzZCReOiNCD1FJQOzYY7ckvGnLeAtNCrRxta4=;
 b=Hzrx19MZbc50bctFIOmGQVk8NB9y1t6cSvpUIImfWupSvSVVapyPaSR4mgBGno2GsY
 fKEO2Huq3dVoYMqgtlMPvi14NbfmZfN0XqulFoFU5rdpe5eO7TQaQ2L4Xfq6lTUrqGIP
 5U2oxWVfUpD347mQ06Kt9rlhgFsQSiN+tDiBibiQvVfMTd1DDDfUtE8vbc6oo+Y01RK0
 M3W/IUrs/g1Ofzm4OqUNot0Mn6yy7C7ZoaB+G9hYK+JUpDngW1aswuIzfFJJbzLDY92P
 ZHYMXuQ17AHegbIivs2yoH3HP1RQSTVWzMBIaYx6Mw0oI0Qxgbwo6ppDt2xYqo8irs+7
 bu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773675751; x=1774280551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84JrKofzZCReOiNCD1FJQOzYY7ckvGnLeAtNCrRxta4=;
 b=fQvUcoiyeQuoW5M5k2QuirwxlrYooEzSX5qTrLzoczzUpnVFbcaIpf5hKD/XRqa60L
 4k9wltZMneA1fl08ecCaFsvCGtU2yWs0HGpVeM8GN9AvAtF57dWpqAkGGqgN9l+IyAz9
 BJnkvKPn0tQwYCNG3sacfOctPVJY2OG9M1pCYEIq2yoAefr+UCM8dsgKWphHy6jmVo5K
 DLX9MI8isstZtXiQcHwcxgLoDfKWK7E2oGxIF+VAimnAHcELMAmg/Lu7a+A5orjrVV54
 Qo0e7p9IlHdYQqmAkxCOodLW+EGCEXiAhO82lzquxuXDBffIXQfZUmt5jJNgySlE1DfN
 g2cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhfetmIMZrKT4qwruReF1Dhfg/byHGVcM8U9UC6mN15CF/BpB8UkveQfwbkPy1O37ZELWH7Y/Susff@nongnu.org
X-Gm-Message-State: AOJu0YwbWFa038Dhd6JHQpdGQgZavHMYekCcxK7Yxms1TbyRb1tKfwvQ
 ESlAtxUcd10zU98Cv/+i6JY3zGc24jpUT1JVTEbrvTyfsa3unszSF4VwOooUqwjpLEep7w3rDEH
 Q85bqDh9fSZyUgmGIz+mcJglaNlBTtWwDreWXXJCkw/dRpkiIsvrPNNoe
X-Gm-Gg: ATEYQzwYNk4Uf6wuOK1Dc20ue+EEWk8W6PiL1NZdFnnkgRF1pKym0oPeLfFYnhzR/KM
 MSFIkESZZzTKYN0ohcKN+/bCcF144sN/xzUDMKZkWkgK0evlaz53+G5JU1I5nr/uk5ghznqf2FL
 73Sy4AVk2DDSK0tXyhq16p7En6EUZFvxVHCvvSbq25qKWnRRgOBUNhCXR1ZC9NnvqXR/WzsYblS
 nsHnBMCe1zMQieed2CX5nC6d2b1e8IhVIPPuOh/gR8T3hnlXmbQ2QbR4TYx+8fP+jxVyQF5TH2L
 0mmNmRR/cwtRflHyDDuvG5gLApLKM5maaxDOh43v829yRCs3RoXcuIUUJ4iGVFPpSnXddGMhbtA
 1M0I5epYbe/KxAw==
X-Received: by 2002:a05:620a:7085:b0:8cd:af31:b416 with SMTP id
 af79cd13be357-8cdb5a75623mr1568046585a.34.1773675751034; 
 Mon, 16 Mar 2026 08:42:31 -0700 (PDT)
X-Received: by 2002:a05:620a:7085:b0:8cd:af31:b416 with SMTP id
 af79cd13be357-8cdb5a75623mr1568040785a.34.1773675750390; 
 Mon, 16 Mar 2026 08:42:30 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1fe19d3sm1200764985a.19.2026.03.16.08.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:42:29 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:42:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org,
 whollins@google.com, jansene@google.com, jpcottin@google.com
Subject: Re: [PATCH v3] vmstate: validate VMStateDescription::fields upon
 registration
Message-ID: <abgk5IYccjoS6hkQ@x1.local>
References: <20260313233538.1519319-1-rkir@google.com> <87341zsvmc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87341zsvmc.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 16, 2026 at 11:21:31AM -0300, Fabiano Rosas wrote:
> Looks like we'll also need to fix some stubs that define empty vmsds:
> 
> qemu-system-mips64: ../migration/savevm.c:864: void vmstate_check(const
> VMStateDescription *): Assertion `field || vmsd->unmigratable' failed.
> 
> Maybe something like the following. Peter, what do you think?

Yep, sounds ok.

-- 
Peter Xu


