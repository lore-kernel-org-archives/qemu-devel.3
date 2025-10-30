Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05350CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVhw-0000GI-MS; Thu, 30 Oct 2025 12:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEVhu-00007p-Ag
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEVhj-0003IW-HS
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761842447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JRr+nTXOcZCjq3JwKmcyClNn4rxgzW+z5BuR7LCjkp4=;
 b=CRYNTNC0e8IrfblkxetQ3ZafgtJTO1oJtLS6vSRrejJbAf6FfuiUax2wTGorq+08U+bwIK
 p+cX2kFW+mAOudjUBRf/NjYsQWzlvyDC4ZJjDl/YkGBONfNH9IvufJKJPdbJ6mK760vj2h
 cOnhlgI4ugld9G6CZm/v0/Fw/WUaZK8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-hKkeo0LFMSuNIoYzX9rFRA-1; Thu, 30 Oct 2025 12:40:45 -0400
X-MC-Unique: hKkeo0LFMSuNIoYzX9rFRA-1
X-Mimecast-MFC-AGG-ID: hKkeo0LFMSuNIoYzX9rFRA_1761842445
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4eb7853480dso32738631cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842445; x=1762447245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRr+nTXOcZCjq3JwKmcyClNn4rxgzW+z5BuR7LCjkp4=;
 b=pSKEBTFVDnW9vcWiG//piNN0qecOUhrbWEESFxN6Gv3XHypQCC9aD9W7x//kKuPflN
 68QRAZGYUyCX7aaBouCsVcGENd0dcD2bFZQ7GGr282/Wt8cjxGQ/zb+whhT1nxDTqdfL
 ++B8Lc7WvG3IXiWrangc0yPCnTL5s4+jJgzlw30Dh7S1vwxpuD70pBmqxAbRHTitHaiT
 UgP6ol4OfXhAGndaxU0V4N8g4k2EU8OAwetuyj4u9TtGunqLcRzbsXyLvdNdcGTyqubf
 dO55xyhQOPWCFv8ryGLYZmatjwaLZK1Xy4uZKVZtPYVViRbel3hBOUsOoeX255z21m1T
 pgxg==
X-Gm-Message-State: AOJu0Yyopx03ZSpKGdQvT3AWP5VHwDHc6Ukcb0eX9Mn2gQ1n+t6XGeV5
 gkxT7JU0V9e0GiMlEpE5eXt5utdIwe805AZV0wgy4GiXD2gDbfFNgVk0jP0rQ164qJsMzAUmJTr
 Nqaw2tt2xsiFyiuXz33BwVyojzrzXQBkaSmantyf+WI9jM08CyxHH6O8H
X-Gm-Gg: ASbGncuuxmK2IYTAs2znBzhHbjJLAjhWdcjYl66eCJn+TTQtyN4zMC2uvSkAJFn5fnT
 o/hZR2xxxdJFm5N7maCEgzje6LnfKdMyoRQouJccvBAyD4Qns4pFuqy+53mw21M9KVQjk2Ms+A+
 EwEV7m2hh53aRe26WDUSWEXEb74ZaGoomTaUO0ZDUKRe0fldhH0d/cjxLGcvpH+lj8LVDrDvJXn
 XX7WRQ2NXadEwWJnYZzhkBUGj9zr87o8TMrq1xGr4GCi7GK5n9MEn+fWIXmjwsCjeLMfPXh/Xug
 aFQRHmK0jL4pYk0fB0aFqwdnuvePpdjjQSkNnaW4AWW8xzwB57x1LTyJ73NaltlzlFk=
X-Received: by 2002:a05:622a:ce:b0:4e8:9e4e:5e4c with SMTP id
 d75a77b69052e-4ed310b3af9mr3009631cf.79.1761842445211; 
 Thu, 30 Oct 2025 09:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyinTf8S8BGlJZiD9SAybH3+SOV7iWRZxSHgru9Or7qSO4likuEt1ICrKxuS/N+xP6LPqTlA==
X-Received: by 2002:a05:622a:ce:b0:4e8:9e4e:5e4c with SMTP id
 d75a77b69052e-4ed310b3af9mr3009111cf.79.1761842444654; 
 Thu, 30 Oct 2025 09:40:44 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eba37db640sm114590461cf.13.2025.10.30.09.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:40:43 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:40:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/3] vmstate: introduce VMSTATE_VBUFFER_UINT64
Message-ID: <aQOVCnQLhxDfnH1t@x1.local>
References: <20251029093939.3251188-1-dtalexundeer@yandex-team.ru>
 <20251029093939.3251188-2-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029093939.3251188-2-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 29, 2025 at 02:39:39PM +0500, Alexandr Moshkov wrote:
> This is an analog of VMSTATE_VBUFFER_UINT32 macro, but for uint64 type.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


