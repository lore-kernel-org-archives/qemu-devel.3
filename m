Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0DECD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 16:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYnyE-0002m7-Ie; Sun, 14 Jun 2026 12:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wYny9-0002ls-Ne
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:45:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wYny8-0000GR-64
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:45:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c0bb4a94b8so19843415ad.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781455554; x=1782060354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4cCLg47hLwJ4CYQjm4ktIV8yK/PB4cTVp3KtVq1u6Mw=;
 b=DP+DTiuWlePJaInTENXtbZU5FBmWAuIMQQUg2a4muUnpFDS1+Ai15M6xs6KMxMlvlI
 inCUQL2cfobzFUOIk0DJxa7gNfrcm10WfVZ+DpI+KFSAdxdFptNsYc/UBNfuGmSV1DEu
 hV0pSeGPneG/pIl3h+IIJKkn2APe5Q82X0LRsVOWOLAPNuKEkXElFLgotOYl5vgexPRo
 qD7fgx/a5Cd7lpFcTdlKSJzraPAFXO/Km2ylO3CU34CavLAVCO1Q7ICGWvWy4pH9psp3
 jClzMVZ0Dr1OdKakVK8eOl6bHtn+m2cEnfccLBbv8G+TXny9g8cFIT/89C9UmdwAgffF
 uWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781455554; x=1782060354;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4cCLg47hLwJ4CYQjm4ktIV8yK/PB4cTVp3KtVq1u6Mw=;
 b=D1r3YKxQIJSjACvxlu9p+yRU/baGpG/bLm0eiWuGKD3rGBfg/sWIjq13mvq3n5eFJM
 4wc3uPwCGJ9zFr39wjN5xXli7I5vTl/oWT2WidiXNHVesTYuGzCpMfxNw4VqAn343prM
 XmG6U1p2Sk96W6F4xnvf1lZaVDyiSHBXKD5cVc6Azj7KgHNJKAJ1jFSeNBsiJ1mgQYja
 ZANqm1st6gaPuV0koIiZ6kdbLh/mDI6TaDjrGEWepDvc+8CGGrdFySFjGMPEDP0k+9CK
 FzOAiobQRqwo9BZCFz1Fut+aIXONAYDEtEyleMS3jWN3qvjB70L5r3bttbDJPmY0/965
 xavg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+m5ZdA6QYURr73b26yMrst6SZMKg+LtdRf4ZK9tVA6v3tjm9lHspBW2CYZN7N+yRCxkpBgVXKwu+73@nongnu.org
X-Gm-Message-State: AOJu0YxCciEWOuPb/rvpwhjgU3rpw4TcXDmyz8TxFjWQl/vQOxk/Ru4q
 s/xPSlkbfUSuKo1JJ8dD+cE0BRopeyLH0zWDdywfiqF9kM6EPDbfRzCSvxH3+NjMH20=
X-Gm-Gg: Acq92OEexmcXFFqO3/994UfPG7F87Gft+5l13cWpPxHtUMBaEfSALCLC9ERVD1HDFpL
 NlavPkt+uOMAdCCTjhc/rQiSdRLxP2KhXJugMW86bajXg58uNy2xsjNZw05suVEokbbUaESWdY6
 C0IttBQA+PF3LzFo9X1fJljp+a30x05C6D6ToIxuuFmVbKTm7WlzjoEYV05ZJ84PGlzLWf9AobS
 Noyzi9gl7VpTjbh7l4e9+CoFPRuC0HgWH/JIPtU7tatI43bK3+ZMIiPktEECJFs1UpMkL4D4NEg
 wcl8NS/6sivNy9g2EgmSbGq7P9WNBnW6n2WI6YkmaebHdSDG0Va0w7MCMOXWe4VkVS6+StXHTMj
 CZXPDKkzJblas16Tb5oHdrAjMY9SWOP57+4b6WAmkQ5sNu6odiZxSGNwo5POkhNIGTGLTB1eBTZ
 K1nNfnyAlTBd/VAGu04gYouJ82GkZHNGCSEuPN
X-Received: by 2002:a17:903:3887:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2c40e0350d2mr121177555ad.0.1781455553889; 
 Sun, 14 Jun 2026 09:45:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433079999sm72961575ad.66.2026.06.14.09.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2026 09:45:53 -0700 (PDT)
Message-ID: <02d809b0-6396-40dd-a2c5-866028b7cc4d@linaro.org>
Date: Sun, 14 Jun 2026 09:45:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 berrange@redhat.com, david@kernel.org, alex@shazbot.org, clg@redhat.com,
 pbonzini@redhat.com, philmd@mailo.com, phrdina@redhat.com,
 jugraham@redhat.com, shan.gavin@gmail.com
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
 <CAFEAcA-TgP_BM0WQo3rysZmvhNN17Gc_nrSYB6pXn-mvs5w13g@mail.gmail.com>
 <123d9e80-d731-42c7-81cc-71de47bb13d3@linaro.org>
 <20260614084004-mutt-send-email-mst@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260614084004-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/14/26 08:13, Michael S. Tsirkin wrote:
> Yes, I think it does work because we use -fno-strict-aliasing.
> For bigger sizes we'll need packed because the addresses
> could be unaligned.
...
> For most host/guest pairs things simply work even for unaligned.
> 
> And yes, guest drivers do do this.
> 
> On classical pci, there are no transactions as such and
> an unaligned access will be split anyway.

I'm saying, if you're talking about pass-through to real devices, that won't work. For 
instance, AArch64 will trap unaligned accesses to Device memory.

You need to actually handle unaligned.  Perhaps something like

     /* Find unit to fit size and alignment of dst */
     uintptr_t test = (uintptr_t)dst | size;
     uintptr_t lsb = test & -test;

     switch (lsb) {
     case 1:   // loop over uint8_t
     case 2:   // loop over uint16_t
     case 4:   // loop over uint32_t
     default:  // loop over uint64_t
     }

with the expectation that normally we'll have aligned addresses and size such that the 
loop will iterate once.


r~

