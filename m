Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8C2C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZVm-0005WW-Tv; Tue, 15 Jul 2025 02:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZUq-00052c-97
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:50:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZUn-0000wL-Jj
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:50:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so50031415e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752562230; x=1753167030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GjbkpgVw8tW1qVcNhOtlvsXRwZpiiOX9iJmrulT9vbU=;
 b=V1rdj4+fURD/1VaT/wRS3wovT31TqBB0qe/szJH/CRikFp69/5N+WwY14vAly3yeyz
 rP6ya6xcfp4VRrmJcsUlja02kFAa+jNDXYplCmN5DtZ1M5bFh+Dr0YLCWhZNoiHnw3hO
 oIRfdokNWnjHZm8NQM35wDtMcsH+lhbvd/J8OTMhrKULJCzTOldz92QH+xEUpZD7gBdZ
 ode4U/ukvVlvZRZsXcOHBD53SXMYlpxrICtWzw0VAzjRN5gUAIgdZ1eXToOsAwZqthkO
 VoiFDL1hl0eiUIgiR2KtE0QaBNVkjx2byrWEeVmplwCwdYdk9t7Ri5kUbAz7WsGpXKHt
 FJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752562230; x=1753167030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GjbkpgVw8tW1qVcNhOtlvsXRwZpiiOX9iJmrulT9vbU=;
 b=r9FrE8SHxDCpv+bEbCNn5Gny3W5jfSJrUyuo6ksJ+5r/Wd6FoO6tv/7M0/JrFcrPfo
 V8hVY1+jtqhpZRVbnJVpWuIEBdI2ZWI6nYNiLzRshf0lcwaU6iQbnE3MiLcMt8yyDmwi
 XGpVHCWigZ2BCQWQIwSF9+tGhUavP6HBLGggReVQfWVza1dfccVUgo+YSD56LnHuMelE
 Ro83WbD+LycEiRwZ6KCv+pwIEbfEwGuHTvqyo+RXhUvxmPyYRbdCAWIeAjKIKmfIrv80
 9NSEeihSVKyb+UPMlJT5IBztTForraKv4a5kKDGAtEgNs+stsSiolWa6umynV5JVNo/o
 1gIQ==
X-Gm-Message-State: AOJu0YxeeC2uVvE9LarqqwHtpAT1dA9omvgFvNccMTDHDHPvyYpX/JTr
 EPioQbLCKPlYR63nRRlnSQVAJlcSomboDHAGH2I6uNeucQWhAyuxFTaScmhBnf4yz3knvo9JbLP
 dSWDZ
X-Gm-Gg: ASbGncvaPs0O47H00XVPyZxNgDipA2vGheE7PIsPZ1IlbSfBmZiyfByXo01D/eCM2EV
 eDmI5OctX03KYYt3Qfe3jChu/oX81uEnYXCTMH/Xx271hdBFJ1hJMAZ+ACl2NluoXo3rpHAuHSz
 00QfuyU/XKO4JeGxepsm1uXHVsoTPQ/xxHSpBC8OJcrskMCmrWMpMMhuV5U2/yjLgeZGu6paTCX
 ReZOiJuBo5PuqJ2pMlhF7MOJ5Lz3CjSsZXEqiz3TGvO9MxKQSjBHt773OuZ86ueIJrLlLnevhQe
 ubvivFU3zwJhDlilat2918JWM5FYbKHO2eB3ijSVYFH7zObEAacBpcNBqm8AjIeZ/cjF4ojEVwa
 8QVW4mt8P0BRkg5jJL0Z+2uusHcAnKfywvieQ7KfLxzUBToRpON2JBPV26AQNhfgnNevikd4=
X-Google-Smtp-Source: AGHT+IG3/QVAiZ+ytMyI2J2oYX0Uba8wlW62GMr7999aqE25fSS68OQwqYCBstcmoiW7O+/WdNRfkQ==
X-Received: by 2002:a05:600c:6304:b0:450:d01f:de6f with SMTP id
 5b1f17b1804b1-454ec2639bdmr149149225e9.15.1752562230312; 
 Mon, 14 Jul 2025 23:50:30 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45614aeba29sm66812445e9.11.2025.07.14.23.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:50:29 -0700 (PDT)
Message-ID: <6a15af2d-5373-4083-899f-b237293251af@linaro.org>
Date: Tue, 15 Jul 2025 08:50:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] MIPS & Co. patches for 2025-07-15
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250715061918.44971-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 15/7/25 08:19, Philippe Mathieu-Daudé wrote:
> The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:
> 
>    Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/mips-20250715
> 
> for you to fetch changes up to 6f8ce26bb00db66e6cec632f16df3cd13e4df934:
> 
>    esp.c: only allow ESP commands permitted in the current asc_mode (2025-07-15 00:25:21 +0200)
> 
> ----------------------------------------------------------------
> MIPS patches queue
> 
> - Implement CRC32[c] (Release 6) instructions
> - Convert Octeon LX instructions to decodetree
> - Restrict ITU to TCG
> - Fix ESP issue affecting WinNT (INACCESSIBLE_BOOT_DEVICE BSOD)
> - Add missing FDT dependency for some MicroBlaze machines
> - Remove execute bit on hppa-firmware blobs
> 
> ----------------------------------------------------------------

BTW the 2 checkpatch errors are spurious:

4/17 Checking commit 23ecff81ac88 (target/mips: Convert Octeon LX 
instructions to decodetree)
WARNING: Saw acceptable license 'LGPL-2.1-or-later' but note 
'GPL-2.0-or-later' is preferred for new files unless the code is derived 
from a source file with an existing declared license that must be 
retained. Please explain the license choice in the commit message.
total: 0 errors, 1 warnings, 42 lines checked

-> no license change / addition.

6/17 Checking commit c083f1f3de93 (tests/tcg/mips: Add tests for MIPS 
CRC32[c] instructions)
WARNING: added, moved or deleted file(s):

   tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
   tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
   tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
   tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
   tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
   tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
   tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
   tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
   tests/tcg/mips/user/isa/mips64r6/crc/Makefile

Does MAINTAINERS need updating?

->

$ ./scripts/get_maintainer.pl -f 
tests/tcg/mips/user/isa/mips64r6/crc/Makefile
"Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:MIPS TCG CPUs)
Aurelien Jarno <aurelien@aurel32.net> (reviewer:MIPS TCG CPUs)
Jiaxun Yang <jiaxun.yang@flygoat.com> (reviewer:MIPS TCG CPUs)
Aleksandar Rikalo <arikalo@gmail.com> (reviewer:MIPS TCG CPUs)
qemu-devel@nongnu.org (open list:All patches CC here)


