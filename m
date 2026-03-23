Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AECEC01A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4b9P-0008Nj-M7; Mon, 23 Mar 2026 05:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4b9N-0008NY-KR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:00:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4b9M-000457-4m
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:00:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486ff201041so20109275e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774256437; x=1774861237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OpzyS52KDTEiOfmW7BzL5YNFwD5uwgop8OGVyuq2qHg=;
 b=FpwbHpu7YQAOHj6EvLfPuEkVcnd9CGyQzio6Cz5N90kOcRluYQSvwAtmpfpQ0u+HMk
 Kq8S/ScwJmaTh/VZeTA/bw47zSL22u+jQFS5mLeWAUZIUlVqefhZcBWi7ehJPaqXjz+P
 NFWQarbk1+sqYsyXgQ5BoxQlJ1paRhLhta7lMFzegxMRbhluP2Sr+d4tK/GXpvFeIks4
 EHn+M0pj0mYy7qxS5rS7joKETKneWmQaDgwA+daHJS4niVazYBR6hrASMgjHm23mCbiP
 p4bNH/S16nBJNLNw1nLdl0maK+PlFutfy7aTrvN5+OLW9qo7z4UtYSewXxXmnNfit7kx
 c3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774256437; x=1774861237;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OpzyS52KDTEiOfmW7BzL5YNFwD5uwgop8OGVyuq2qHg=;
 b=J6ebzfCo1Yxq4gQy2ujjA97tHptrcx8s9/5NEa9km0nfe80xn/l7M/rHf6r+ftxtAi
 QxDMPfpXYN6R2VewYVTpoJGJnvrW09NNaDPHQpPV4TZpiK+Y2RA/pYukPH4Vrn2/8SXT
 sDh/TF+wkkrRhO0ACsN/dimduFp0nawWA+9BLSy8wzNyOdYCcqeAizsXTceDoFf/fCf/
 DoCr4tQ9W0fv7lfewLTgM5K2Jtb+rvpw8gQDaO5QUcPWzRiT4oB0mhydyhpCN3ggedCv
 xsbDPIfZZ2dq5pk1P4W3DagraTMb0FzB2fhMKjehOgmnEi62UzVgY2luGqPWTQUHSOd0
 Ukxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5cruz0RBJLgf2VvDusqc+m7m7vHVN5iEmpbGnF906Y7eMu6H46nVxb5ok0YrtTmBu4F7tDhVlanUR@nongnu.org
X-Gm-Message-State: AOJu0Yx8U5XK+04hEEg4i5mPsy16SzJUi46/F9KY4R5MgwTL28BLGqpH
 QD153dUfsA0VNiSk4olyzq5wdd5g04W7u5aQdPRubQJLYqdiN1uMksbWrdDrl7F9za5i8mzAZc6
 sADLV8O1/BA==
X-Gm-Gg: ATEYQzzVnGC695tS2gPAv/ahOOLTrQrEkt9pRLYxMRZS53cCoEsZEOwefOjqwWDDSsM
 hA/vmrgUFFpWnduytL1qs47Jy8Oze73OD1OGrTgcq4/JqyJnSFY1sUquXgbZzBNrFOuO53XJ0/a
 xzth1nS6hBblxi2aKAx/jZqRMkYeGD5Zz8KMsCqzTMyw0krc35WrXrYCPRm1OyPn6/si1FNdqAM
 F5+/f3hqNf5gjol+82iKCsA5LlUD081c3aN9ZHhE3vBJ5iaabMTyITSingYjDlUhPsjuenOIguB
 qmyVzHvScPuhy5Vnv77CcIWDn6idMBlqsPwh/KaIIOfTaP2AEGTiX6yxI9vw1h/6X89BuTCkTw/
 rHHgDE7Zmg+b6eZvmToBHUipCc5Fxz/0jlsKPjT0E8SEjS/RxLurcoAPwhPnBRmouLSi9Wy3TjL
 YVQBXcQTQRs6aTk9+ZJ5kgJv+pPVpegQadc7NliB/HGihQe83nsc3vGa/6a2oWG1Ts0pGqs85Wz
 oBO
X-Received: by 2002:a05:600c:3d97:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-486febb5989mr157357945e9.4.1774256437273; 
 Mon, 23 Mar 2026 02:00:37 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe6d9896sm287039195e9.2.2026.03.23.02.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:00:36 -0700 (PDT)
Message-ID: <32d3d036-77dd-414e-9cf5-45044c98069f@linaro.org>
Date: Mon, 23 Mar 2026 10:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Monitor address printing
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 23/3/26 00:38, BALATON Zoltan wrote:
> Hello,
> 
> Noticed that now addresses are printed with a lot of leading zeros in 
> monitor:
> 
> $ qemu-system-ppc -monitor stdio -S
> QEMU 10.2.90 monitor - type 'help' for more information
> (qemu) x/x 0
> 0000000000000000000000000000000000000000000000000000000000000000: 
> 0x00000000
> (qemu) x/x 0xfff00000
> 00000000000000000000000000000000000000000000000000000000fff00000: 
> 0x60000000

Likely commit 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr
argument in memory_dump()").


