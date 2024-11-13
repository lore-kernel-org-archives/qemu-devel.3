Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392FCD637C7
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 21:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBKk5-00074h-Ek; Wed, 13 Nov 2024 16:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBKk3-00074S-O2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 16:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBKk2-0004Nn-5o
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 16:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731532652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdlFFCtVbGnKU/AHZi9vDqMJTP3Z9h1MF4iLsMS50GM=;
 b=WxT8iPt4sz0DM1CK8gtRlMy2TXhowK+t+85K4xqrsHFHdLb+brs+V599/fUET2IABDpabu
 fipxi5aVuQrZsM7kt5LcOjCYIKfXHnbgDmEBGVbGLWdotN7tr7q5Eh3etPYH7H7g6sq1sp
 2qQAppaO5yEeKNUxaL9mihqBDxLKPq0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-2pdItdgyO8yqTc-JXJvdmg-1; Wed, 13 Nov 2024 16:17:29 -0500
X-MC-Unique: 2pdItdgyO8yqTc-JXJvdmg-1
X-Mimecast-MFC-AGG-ID: 2pdItdgyO8yqTc-JXJvdmg
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d390ceaba4so24522416d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 13:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731532649; x=1732137449;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdlFFCtVbGnKU/AHZi9vDqMJTP3Z9h1MF4iLsMS50GM=;
 b=HmHEM/Gcvtha9bq+SkENB4D9TC7Ox8cc6UC3xcQZDXkZgQe5yVoZkHHIbnGrKwRBgi
 CZs2+ovS/Nxrdtr4WCcZQhOiXGQOIFBaG7sZGFqEEA5BSyG5gsYqHXyAN2mVDpAZ//Vk
 2QtJ9nAvEHOlsnti0KXdppu0z40fc+3+GXKVf2vO3CylDJy9aboY8FjzIoIV+0J+od7n
 A+ayCQGeZaax7TNciu6+6gY38wEB551DaGJGq2t6n9hOCQrphdu/c7cSmPkKbTIUHcuw
 AKZROWPGvK3mMYlJZ1ogqMV+k5a+KZmzDxr5rCAtdmWuI1c5Fb65eTyLfVS6I28C1Ue/
 5/ww==
X-Gm-Message-State: AOJu0YyyScUrCekOpfv42Jp5C8Xb53RICqyaDHx/uACmGKidosiyb6Er
 MJHw9FUKHDDG2+ONveMm+5w+0XAhv+ttOkK7IZVhuCliGl+i+7WpOu+7XnLaetKSRj5YTryKQL4
 cwak1ynVdkU6Z0TFZT2xVSKIqN93/Vf/KoF6m3L5w/BIZ8uy3vbR8
X-Received: by 2002:a05:6214:5bc2:b0:6d3:44b5:a6ca with SMTP id
 6a1803df08f44-6d3e904886bmr14716376d6.6.1731532649291; 
 Wed, 13 Nov 2024 13:17:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+ry0t6Rn4ygKOGlugk3F8B4yl+2RiV6HxQMdbzo6Tzlw+n9iyvir8Qx0GGJ1UT38mB75aJQ==
X-Received: by 2002:a05:6214:5bc2:b0:6d3:44b5:a6ca with SMTP id
 6a1803df08f44-6d3e904886bmr14716066d6.6.1731532649008; 
 Wed, 13 Nov 2024 13:17:29 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396643764sm87312206d6.131.2024.11.13.13.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 13:17:28 -0800 (PST)
Date: Wed, 13 Nov 2024 16:17:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Dmitry Frolov <frolov@swemel.ru>
Subject: Re: [PULL 2/2] migration: fix-possible-int-overflow
Message-ID: <ZzUXZmYwuznOWCQ4@x1n>
References: <20241113201631.2920541-1-peterx@redhat.com>
 <20241113201631.2920541-3-peterx@redhat.com>
 <f7ff08a4-30f8-47f6-a3e8-a1cb4e996ee7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7ff08a4-30f8-47f6-a3e8-a1cb4e996ee7@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 09:40:50PM +0100, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 13/11/24 20:16, Peter Xu wrote:
> > From: Dmitry Frolov <frolov@swemel.ru>
> > 
> > stat64_add() takes uint64_t as 2nd argument, but both
> > "p->next_packet_size" and "p->packet_len" are uint32_t.
> > Thus, theyr sum may overflow uint32_t.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> > Link: https://lore.kernel.org/r/20241113140509.325732-2-frolov@swemel.ru
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   migration/multifd.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 4374e14a96..498e71fd10 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -623,7 +623,7 @@ static void *multifd_send_thread(void *opaque)
> >               }
> >               stat64_add(&mig_stats.multifd_bytes,
> > -                       p->next_packet_size + p->packet_len);
> > +                       (uint64_t)p->next_packet_size + p->packet_len);
> 
> I am not familiar with this area, but quickly looking I can't
> find a code path accepting 4GiB payload, so IMHO this hypothetical
> case is not unreachable. My 2 cents (I'm not objecting on this
> "silence this warning" patch).

Thanks Phil, for taking an extra eye.

Yes, the solo goal is probably to silent it, if that helps anyone at all.
I left similar comment when replying to Dmitry when queuing this.

If it could overflow, we have more troubles, e.g., we have plenty of places
caching these values in 32bits.  When this overflow could happen, we should
simply switch everything to 64bit..

> 
> >               p->next_packet_size = 0;
> >               multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
> 

-- 
Peter Xu


