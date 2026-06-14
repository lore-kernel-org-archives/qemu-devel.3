Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7332CD98C7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 17:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYoYD-0000KW-2d; Sun, 14 Jun 2026 13:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYoY9-0000Jy-Oc
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 13:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYoY8-0004fo-B6
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 13:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781457786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HGs2h+lMn0M3AiOOwvFy6S0QGjQprX44OL7WY5rr53s=;
 b=InBOuhwP/clVScK4Nee96eK9dtV1dsP6NRPJ5ie5AccH3MyO5Cv+1yVniipTAW7U5PqmQP
 R5Nvw+EZk2bKm3qOoyjjB9H63zPPDXhtLec8aTpfxPMBs+8Uakd5f3GqSsHMmVmqDy9Har
 kpf/6Jdm0IFUmZ96xFm91ShnkPxl+Ko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-iTQ3xkYhMGOs5oH0qNItng-1; Sun, 14 Jun 2026 13:23:05 -0400
X-MC-Unique: iTQ3xkYhMGOs5oH0qNItng-1
X-Mimecast-MFC-AGG-ID: iTQ3xkYhMGOs5oH0qNItng_1781457784
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so21703215e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781457784; x=1782062584; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HGs2h+lMn0M3AiOOwvFy6S0QGjQprX44OL7WY5rr53s=;
 b=uFbXNkh/leyTpq200b0+BYTNU+LjwVHJaQXR6FMP2NilO4UsEhvZjnWOJTYqwMmKMb
 vDqFrjHDFFuS+bbTgEeKwxvwgva65ySlvd59BvzEzOA4ulCQUPPZfuZu5idXL3zRy3si
 8y6uKZJYKbFTt9Y0SLvMXB9PqNctfg94e2NdhsnaHpZWFB5VDuZqjVMy+6d0HPC7Px9u
 YWXpMB5pgS/qQhVsx/NjlfxIY0eLSv45DE9rC0DG/wQaGLzeT26u6LoT7Pe+RGGrYuAr
 KwGv8mlPTNcAapnKv3hgK08V354X0BJntFZkjwvjNA6A348Hr+T/RLLbdihkGe/T+wop
 QvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781457784; x=1782062584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGs2h+lMn0M3AiOOwvFy6S0QGjQprX44OL7WY5rr53s=;
 b=I2ZB7/biBGfj/HMPfTHDBqS4aHG3ucFGyyiaLh7SdkuKF0/MK9KBRnEe1raPzajFdf
 n1BCTb5blzB0Jxb4d4N7JybUogxl59VHRHf8yelum9glrBVJUuMRhVmgoY2AbvForY8i
 mMu6p6wBc4gNfZY0KPgwzoEWbHN0ESBseyDtvSOz+YR/cBxiThtYR8ooyXlYJC+HcYum
 ArYLpL5JrzLMbEY3QAcWfKY9ZC97+OiMBMkJ/eh64u+SiRfRL/AUhDnHV2AkGoy3ocvD
 ZiW9IO+4QY8HpmuA8OAR9BjKX86Z4+1VqgupMzZJ+7KBVQg8JvK1r4sjlM5TjxlnfSdj
 6AkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PxCr7bYcJAs8HDo8HSMNircQRIM/b1CuZ8mOYTYZrXI8i/GHUai0uE8ssIrWQ1yhAUWTgCn3o/6yT@nongnu.org
X-Gm-Message-State: AOJu0YxyCdHjOEvYVESyg0ldf8W+Jlb3gfIYw/BsYNTlEdfrXY9/Ol9z
 Y4jEELbARLu5VaoMcjPi/58XO6VprkloKvgKeHjLcOpckY5qH664izYi7XDexvERx8zQNx8Hvn2
 S7zXiCniNPNZX7pJlUbkOnk8rbJLfUn+G/SgOBsg4r2/kxQThSp3a4BqU
X-Gm-Gg: Acq92OFchtQGozV5SufZ+tGOXDIFrRYPG8GYVYP+HbEY9DckdfM22y+7LUJWnsAeCuU
 8xkXwy5SVZ2wWVZ6TlkN2JTTqg5PuQCYi6apHV+y+t+fzcTbMt1JWYbiemPwa49kmuko39Z8di7
 Uffb+/2nAvscd8QgNMXaQsAO6APrsb0QxLXwpS68dp9adWpI8pY438/JWM+IaVUfHX37xlP1mNp
 2PNaQl8TTe0gJFCrSvBMyetXp1ZP5BEeb0eOMfQr/fmqHex+F8ZqQYYMOeFUOQWo++3CLxvZSEq
 cFhWdh0HCstE175au/OtNRHm08My+B83Wc5bf4IvwTgxyMFs1xfBC7LqAqyn/0+AiDZy26T4g+y
 6vYbubGW1GewjXAllidJ79cZJ1THB9RNQKP4xO2wIJYs=
X-Received: by 2002:a05:600d:8497:20b0:490:ba61:7981 with SMTP id
 5b1f17b1804b1-490ec4ee151mr97774915e9.23.1781457784057; 
 Sun, 14 Jun 2026 10:23:04 -0700 (PDT)
X-Received: by 2002:a05:600d:8497:20b0:490:ba61:7981 with SMTP id
 5b1f17b1804b1-490ec4ee151mr97774595e9.23.1781457783620; 
 Sun, 14 Jun 2026 10:23:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm26656918f8f.8.2026.06.14.10.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 10:23:02 -0700 (PDT)
Date: Sun, 14 Jun 2026 13:22:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 berrange@redhat.com, david@kernel.org, alex@shazbot.org,
 clg@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 phrdina@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
Message-ID: <20260614131704-mutt-send-email-mst@kernel.org>
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
 <CAFEAcA-TgP_BM0WQo3rysZmvhNN17Gc_nrSYB6pXn-mvs5w13g@mail.gmail.com>
 <123d9e80-d731-42c7-81cc-71de47bb13d3@linaro.org>
 <20260614084004-mutt-send-email-mst@kernel.org>
 <02d809b0-6396-40dd-a2c5-866028b7cc4d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d809b0-6396-40dd-a2c5-866028b7cc4d@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Jun 14, 2026 at 09:45:51AM -0700, Richard Henderson wrote:
> On 6/14/26 08:13, Michael S. Tsirkin wrote:
> > Yes, I think it does work because we use -fno-strict-aliasing.
> > For bigger sizes we'll need packed because the addresses
> > could be unaligned.
> ...
> > For most host/guest pairs things simply work even for unaligned.
> > 
> > And yes, guest drivers do do this.
> > 
> > On classical pci, there are no transactions as such and
> > an unaligned access will be split anyway.
> 
> I'm saying, if you're talking about pass-through to real devices, that won't
> work. For instance, AArch64 will trap unaligned accesses to Device memory.

Presumably, AArch64 drivers don't do unaligned at all then?

> You need to actually handle unaligned.  Perhaps something like
> 
>     /* Find unit to fit size and alignment of dst */
>     uintptr_t test = (uintptr_t)dst | size;
>     uintptr_t lsb = test & -test;
> 
>     switch (lsb) {
>     case 1:   // loop over uint8_t
>     case 2:   // loop over uint16_t
>     case 4:   // loop over uint32_t
>     default:  // loop over uint64_t
>     }
> 
> with the expectation that normally we'll have aligned addresses and size
> such that the loop will iterate once.
> 
> 
> r~

And ifdef for arches without unaligned support?

-- 
MST


