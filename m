Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250AFC3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 10:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0IH5-0001tU-Nr; Thu, 03 Apr 2025 06:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0IH3-0001sl-AR
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 06:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0IH1-0000lx-3Q
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 06:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743677890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=axnUTY8CivkJX296f0Qt5IAn6nRCP1F2CoKiwDCF+ek=;
 b=BPyOGs4ffJkQkieU/L8ja3L2TrL6+9UggJ5yz6rRv2n3x/cWHxGV8GhYbSK74IExHe12AM
 LIm0KZX7mahmUliE9C9VfMoNMtbHlfD4exqlNcxULZdqNH5Y57xHT9r1uB55rYjl+Ampih
 lOFHnWh7SlxFmXkNJkYSu6MlPLYwaYk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-8NxH_8mAMjuxYCqiKlcNlQ-1; Thu, 03 Apr 2025 06:58:08 -0400
X-MC-Unique: 8NxH_8mAMjuxYCqiKlcNlQ-1
X-Mimecast-MFC-AGG-ID: 8NxH_8mAMjuxYCqiKlcNlQ_1743677887
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so6120505e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 03:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743677887; x=1744282687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=axnUTY8CivkJX296f0Qt5IAn6nRCP1F2CoKiwDCF+ek=;
 b=JHuu6ly8HUFIDZbhDmm3DQSJM6ASlzqilqMAn0hq1dfPNtinSdnR0YC+EDOJCUKIU5
 OfZn9z6cd6/79nQj6+eOJW1raIRUBDGSJX4sPSu5M32XhD2+N+ehtHfI7Giopc1lb6u/
 FIjbUO0sgG31vZOxjiWX5yxXAokM9we7+jcPmZ1XPzrgdhzPFqN85hz015eCPlTm4kFw
 +ubwOsuZW81i4GQ17gYTq05FJYKsDYboybbKZxDBgo6yC3vPHpO78+s9Ko3J+ETEHD9E
 pnP2QDy+r0p56N/JNcFXfHOjTiFit29hFNdGL33BjJ4rvSU1d8kzt8zFLXgkp/f+j5nY
 IApg==
X-Gm-Message-State: AOJu0YxAv+tbEg4DHGVK6bo/AREO86i9NJ3dSi/BlzCjWINUPv0N+PL8
 QjLfIPVoGkQ4tFdEEHrzDPVAph3qiOsG8AAzuzgjD2zpLbjOg3ck56DVEvGmJrE0lpyY4Bv63Es
 zk5OXRBc9KtkQNtIQ34T+FVWeqz3e257o+dP4ja44cLftG5ypIvygEYrpFVr9iO+6/wazKHAwYi
 aQ6wQ4h2rab6pOkyxuKhu6QsXOcAA=
X-Gm-Gg: ASbGncvUJfNBBq+KA/nYffe6s3MJT/TYsYIElCF/L5hyNUVqCwhwHlJeXNbehr7r/yr
 YEOx9R6kW1yz8oFtgbkB6OocFR/iOUwZv9/Kz+/2VGmCkZpgfrQPeWSWhSxDXg2SfolBYAF/GWy
 w=
X-Received: by 2002:a05:600c:154d:b0:43d:738:4a9 with SMTP id
 5b1f17b1804b1-43db62be3bbmr180324145e9.27.1743677887479; 
 Thu, 03 Apr 2025 03:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiL5LrSCj5fL9/LH9mn0UQpb4PgoJCCdW0kxNSF5UcmEQtuE3uPSMH1W0CdJy0Utuae/1BuQpTT2aXtuKCeDM=
X-Received: by 2002:a05:600c:154d:b0:43d:738:4a9 with SMTP id
 5b1f17b1804b1-43db62be3bbmr180323975e9.27.1743677887120; Thu, 03 Apr 2025
 03:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-4-ppandit@redhat.com>
 <87o6xhkyot.fsf@suse.de>
In-Reply-To: <87o6xhkyot.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 3 Apr 2025 16:27:50 +0530
X-Gm-Features: ATxdqUE_JUMJ1FTQk9fiz0lHiMyZjnq8Oh6Y5t-5JfeCGuApZLiPlUBeyjti624
Message-ID: <CAE8KmOzXMrdkgk+VH4_2s6p=UsP+ttr7TMyqT-fVFGB7DgyTfA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] migration: enable multifd and postcopy together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 31 Mar 2025 at 20:57, Fabiano Rosas <farosas@suse.de> wrote:
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1297,7 +1297,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
> >          pss->page = 0;
> >          pss->block = QLIST_NEXT_RCU(pss->block, next);
> >          if (!pss->block) {
> > -            if (multifd_ram_sync_per_round()) {
> > +            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {
>
> I'd rather not put this check here. multifd_ram_flush_and_sync() will
> already return 0 if in postcopy.

* IIRC, without it migration did not finish or was crashing. I don't
recall if it was on Fedora or RHEL systems.

Thank you.
---
  - Prasad


