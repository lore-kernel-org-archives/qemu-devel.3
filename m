Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64440C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQwe-0001i8-4s; Thu, 16 Jan 2025 09:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYQwb-0001hb-DR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYQwQ-0000w4-F1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737038029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gbh74LufudOrYSFtXmb3oZllp7Sy8cTi0/+Z40s1Rv4=;
 b=HFCHPXm/qzzVlrSejhTP4qQPIdPUUqG4ySdTI1gc2iNmdz53JcuoY/f+aDoSW3fwd7XoOu
 ekgBgVfWMEzLXgvOPnfRJHAIUvjAfuwCMWH7s1PMuBI3x9M/7/gLZYLYkh0V14UWb2JD81
 JovCLqW9RoE+bK/tFnf1NZ2oYpY1fEQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-oSLrTbaDP222OocCGZltOA-1; Thu, 16 Jan 2025 09:33:45 -0500
X-MC-Unique: oSLrTbaDP222OocCGZltOA-1
X-Mimecast-MFC-AGG-ID: oSLrTbaDP222OocCGZltOA
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4678f97242fso26477621cf.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737038024; x=1737642824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gbh74LufudOrYSFtXmb3oZllp7Sy8cTi0/+Z40s1Rv4=;
 b=e2NXBxny9K9sVaYWH/T4w8MVkEhK9XIgEFtNCDzFMq8/FPyPMZ6Heat+cXg8OFK5g6
 u9DoC3eL/JZLoo5ULxQt40ZQ24e2qdf+CQOEvSb20+ihCPuKqbaF5Vd+Iyz9p5yeSHHZ
 dh2VgNgiG6Vzo4eqw9VduGLpPbhMYxnJYK50pe4GvFZx2ky9SxhXdsGZ+dsBhSRqlFz0
 vrI92f84rzA+8LZEkG/NAoyWDd3gG3IZv+R5LafTeuSf64H/H7xtYKGmADRjuklTU5eM
 cfSVELuItdavGGbzw45ZVIK4QrZUMgyf5jRXyoVuGQigWW0njC+UY6Km204X0phiRhQX
 xpQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3712FN4WoClANR0d+dfTYF3SvUvetk72MAXKEsWfa8nudBcZrqfpBYbhbWN9+FnElFZ0B2DldSZ5s@nongnu.org
X-Gm-Message-State: AOJu0YzhKbR8U2hQ8r6MtQkXxexT/YEGXGZI/x7wehZN2gsDURKg1WqT
 Ci/lSiyoKIaBy4DPQS9Ic+1wlJmPrC3E5WEXYYHFCf870vAccQClgegvHI0xRwOWRUectAedPlw
 i412DO/w1odNJw+SnPGhfnP+ugYXowupb2Z0jf7OX12C/wn1YS3Q3
X-Gm-Gg: ASbGncvRR59vw69L89ekHWgZP0uOjstp+KEJlaNOh+mgDIYHZEiyn+uxUnxie0WCLM8
 xFxsu7jexDacKSqzQ7cdqb3HSeG/JJGXHdRIQyn2R2/ZvtK6824xqDyydtwxN94AzYKJJKiZdbC
 WEnq0FTmC836ymmWj4UBf/sTlUJ1aCCrT+vqgU6HF4s/3rz83mx+ZR9V2ZyEmZNTp0HbJN027sR
 Ty3EV9jdsUeP/dI2gWizLCuMv5FRRa7vDVEq6Vic0xzHh/pa8vB45kc51zQaD2ypjuopFI19iLd
 5gI/2icNobOH1Wjzyw==
X-Received: by 2002:a05:622a:450:b0:464:af64:a90a with SMTP id
 d75a77b69052e-46c7102c391mr577421921cf.23.1737038024038; 
 Thu, 16 Jan 2025 06:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGORs0LKnEHIGDoPysfivYnmOrcFeJQV36zQFj7GGNfdQIwFvAJPYs4A4fhqflEaDBWh2c7DA==
X-Received: by 2002:a05:622a:450:b0:464:af64:a90a with SMTP id
 d75a77b69052e-46c7102c391mr577421431cf.23.1737038023725; 
 Thu, 16 Jan 2025 06:33:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e102ec299sm96481cf.6.2025.01.16.06.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 06:33:43 -0800 (PST)
Date: Thu, 16 Jan 2025 09:33:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4kYxLsIbzq7jWzz@x1n>
References: <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com>
 <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com>
 <Z4fW_rI7Mfrtc1Fg@x1n>
 <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com>
 <Z4fezdR1ApN8ZLTS@x1n>
 <99016684-b5f9-446c-b85f-0dc21d1edae6@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99016684-b5f9-446c-b85f-0dc21d1edae6@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 16, 2025 at 02:37:38PM +0900, Akihiko Odaki wrote:
> On 2025/01/16 1:14, Peter Xu wrote:
> > On Thu, Jan 16, 2025 at 12:52:56AM +0900, Akihiko Odaki wrote:
> > > Functionally, the ordering of container/subregion finalization matters if
> > > some device tries to a container during finalization. In such a case,
> >                        |
> >                        ^ something is missing here, feel free to complete this.
> 
> Oops, I meant: functionally, the ordering of container/subregion
> finalization matters if some device tries to use a container during
> finalization.

This is true, though if we keep the concept of "all the MRs share the same
lifecycle of the owner" idea, another fix of such is simply moving the
container access before any detachment of MRs.

> 
> > 
> > > removing subregions from the container at random timing can result in an
> > > unexpected behavior. There is little chance to have such a scenario but we
> > > should stay the safe side if possible.
> > 
> > It sounds like a future feature, and I'm not sure we'll get there, so I
> > don't worry that much.  Keeping refcount core idea simple is still very
> > attractive to me.  I still prefer we have complete MR refcounting iff when
> > necessary.  It's also possible it'll never happen to QEMU.
> > 
> 
> It's not just about the future but also about compatibility with the current
> device implementations. I will not be surprised even if the random ordering
> of subregion finalization breaks one of dozens of devices we already have.
> We should pay attention the details as we are touching the core
> infrastructure.

Yes, if we can find any such example that we must follow the order of MR
destruction, I think that could justify your approach will be required but
not optional.  It's just that per my understanding there should be none,
and even if there're very few outliers, it can still be trivially fixed as
mentioned above.

My gut feeling is when we need serious MR refcounting (I'd expect due to
the current heavy code base it might be easier to start a new project if
that's required.. that's why I was thinking maybe it will not happen.. but
if it will..), we'll do more than your change, and that also means
memory_region_ref() must start to refcount MRs, because a serious MR
separate refcounting should mean MR can go on the fly before the owner.

-- 
Peter Xu


