Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B9ED0E3F3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 20:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t44Es-0002ci-Bf; Thu, 24 Oct 2024 16:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t44Eo-0002cR-Ee
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t44Em-0003y8-7s
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729800914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+mWP9Yoe+t/Q+V0P1ZAkdggn4g52uy+dXlfxNaukkOs=;
 b=cdpjjxngSpzJcEQov6xXASbPdN90FOIS1OPIp4uCFLAww9jWdtES/OEalMMvI6/qvClvJO
 NF0D7fEsJu3Oj/PLYkGT7H+tdU7rtdmSE74go+F2XlknfqHSGXuIKHq4xpQbevL10ow0QY
 AetsoQkRSlhNRgJZJq51jE2sugvB/Tk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-hlzycvBHP-y09MBkxLT--A-1; Thu, 24 Oct 2024 16:15:13 -0400
X-MC-Unique: hlzycvBHP-y09MBkxLT--A-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b144a054baso518259685a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 13:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729800913; x=1730405713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mWP9Yoe+t/Q+V0P1ZAkdggn4g52uy+dXlfxNaukkOs=;
 b=RIexzbVnhXuhRildxmRMmBuogAyU/MPl/8a+Ay+EBpUgUvJm9yTsLfivcplHY8T4Sp
 21iEl4nC66z38ij/utjVY0ATCirnFvb4aQz5Jf1gYaGI0G3JY6nDYUE6cCWgIt6T0umr
 Qna4xg0DVqZyZFNiKHpnjVL08RJ/UKa8WS1e6aVplBLY3+fxribFU/YjwyDgaqw+Kpwy
 J9WxzTPdom99u/BXrYEnCZQmHA+iLUz9NPtsn1nUNpO5yD+3DyMOOa0A1ExmGMW3hOu6
 SY38Yjq47cyT2DY6DlVgcEPenYE1PuCMSM4B0D0NwCrphWv3fS/7a6+gaqVouohl12sP
 IZCw==
X-Gm-Message-State: AOJu0YzHS/eNNn2wsMHyJCZip+GC7xf57QIGOCd1mIlqCtwHcURzmD3h
 1DZ1BxzjotZPOWcNW+39qrhz2xnzcjRTw4a3/DTdUyWSxHxtzu8hZ2Ta4khd5Q+9jFpV/PKFw/E
 qPf+rgK2UcU9hSjGD8ranbKxzEXbq4dKDYoJ5lhn18IdmWLxm9nBf
X-Received: by 2002:a05:620a:4410:b0:7ac:dd88:cc80 with SMTP id
 af79cd13be357-7b1865d33c2mr552212485a.8.1729800912896; 
 Thu, 24 Oct 2024 13:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKf6/jRnwDus5GIrnX00Mv9TGUumVFbnOXNSBy+AgaKI0aLK8v5BZYtwCP/VdpVhc55++liA==
X-Received: by 2002:a05:620a:4410:b0:7ac:dd88:cc80 with SMTP id
 af79cd13be357-7b1865d33c2mr552207685a.8.1729800912475; 
 Thu, 24 Oct 2024 13:15:12 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659ffba7sm514354085a.58.2024.10.24.13.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 13:15:11 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:15:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] migration: Reset current_migration properly
Message-ID: <Zxqqzh-5b4Sz6bFF@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-5-peterx@redhat.com>
 <875xphfg6j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xphfg6j.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 24, 2024 at 04:34:44PM -0300, Fabiano Rosas wrote:
> > +     * here it means migration object is gone.  Clear the global reference
> > +     * to reflect that.
> 
> Not really gone at this point. The free only happens when this function
> returns.

How about "is going away"?

-- 
Peter Xu


