Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488C5C3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 22:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT80D-0000Kx-09; Sun, 14 Jul 2024 18:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sT809-0000K5-O4
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 18:47:29 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sT807-0007kc-NG
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 18:47:29 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6eab07ae82bso2112496a12.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 15:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720997245; x=1721602045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=whZUEvsVJ9S/NyKt5SxPqRKLahLJ8jq/q/HrJQj1Ul0=;
 b=eEn3gUIaJnFjABa7KHLVDIVSZ0CtPYd4eYY0R7Bx3bx2yxCrJ739l56cfWABuRt+In
 dcWLQ5p/GfxWVjnAsKd81xQqgs4aJR9XQ0rdIlEf9QVMOMd0DTqFPC8N4SC3fIyaRpfx
 +NdSfMo36lUJnagYtG76qVEFs3aPt/ZIK3O1oULBX9vPGrph6wGu5d1KSJKbZhvrLzNG
 wosurG3AZQN2kkppusUkMt56tHoSniYSl69iI0U//BPl2GUcRio4Znuj5Oer0bQGoR64
 pe/WOH2FFbZTlWhj/cFCLb0hN4eE42giVGJx1cw6vLD/o3Xtnwl2fO4BRH7QoNSPCuwo
 26uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720997245; x=1721602045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=whZUEvsVJ9S/NyKt5SxPqRKLahLJ8jq/q/HrJQj1Ul0=;
 b=kmUDM5sISxEy9VMc+pbuXNzA3XmB/NDMqTk72Vqn5GN8LyY9hjg4K7x/lpiND73uWF
 Pdkb1Kq7eJehDMzBorYPrVbK/NK5O2cJ9Ksl+yJkLJKfR1BEaGVdPrn/QbB1y3dMDQjT
 PrAbDefbdeyYCpAdaVBfL/f+2Vc3PsKWSIQgHaisTBEXsiLCfwLDCyz568k521cHAKJs
 0IQk/DY0V0de5UT9LMZFQNNu5DNl3Kf5ATWVWnZIix4Y88r8O5JdNPJfEzHdXPlCq8mU
 yWtx+JdWGqNWNgjE0sCCyJ9RFVh7rAljX9c9oPRVyKhlUdRPcgzQeb9SQwT6/WILVUYQ
 AUbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZFYzkK0d4/MNGOxKn0p8c6AZaqgQPAqniWOBvOyKYLlq2n5JnNKkYOuB6r+AnvlhrUat3+lxQlNB4slFvxOI7XFFFrv8=
X-Gm-Message-State: AOJu0YxYVHS1o0lTV3+n8e4Yw9B61ltcRBQPNPo4WbwUBYpFwBvHKUba
 tr74MdP+SPuQjX/oza7oOH2zUQEio42IW/5kT3gS09VuPuj8tXF75XM1e7KMHXM=
X-Google-Smtp-Source: AGHT+IFgUA4EbvGHkwNY+nH5Uaj7LrFoNwHopEZVaIRTSyfuGexGxQZs75RR53piIkm0hI0o0v6XAw==
X-Received: by 2002:a17:903:234b:b0:1fb:8f72:d5ea with SMTP id
 d9443c01a7336-1fbb6ec24e3mr134728845ad.50.1720997245067; 
 Sun, 14 Jul 2024 15:47:25 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc253b5916sm8947235ad.221.2024.07.14.15.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 15:47:24 -0700 (PDT)
Message-ID: <42dd04b8-01ba-4c1c-a729-4c96aeaae771@linaro.org>
Date: Mon, 15 Jul 2024 08:47:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] target/i386 changes for 2024-07-12
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240714111043.14132-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/14/24 04:10, Paolo Bonzini wrote:
> The following changes since commit 23901b2b721c0576007ab7580da8aa855d6042a9:
> 
>    Merge tag 'pull-target-arm-20240711' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-11 12:00:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream-i386
> 
> for you to fetch changes up to cdcadf9ee9efef96323e0b88fccff589f06fc0ee:
> 
>    i386/sev: Don't allow automatic fallback to legacy KVM_SEV*_INIT (2024-07-12 15:35:54 +0200)
> 
> ----------------------------------------------------------------
> * target/i386/tcg: fixes for seg_helper.c
> * SEV: Don't allow automatic fallback to legacy KVM_SEV_INIT,
>    but also don't use it by default

Fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7338361630

2024-07-14 23:45:07,744 __init__         L0153 DEBUG| EIP: alternative_instructions+0x2b/0xfa
2024-07-14 23:45:07,746 __init__         L0153 DEBUG| Code: 89 e5 83 ec 08 64 a1 c0 06 f4 
c3 89 45 fc 31 c0 b8 e4 f7 ef c3 c7 45 f8
00 00 00 00 e8 84 6f 7a ff 85 c0 74 02 0f 0b 8d 45 f8 <cc> 90 90 90 90 83 7d f8 01 74 02 
0f 0b b8 e4 f7 ef c3 e8 04 6e 7a
2024-07-14 23:45:07,747 __init__         L0153 DEBUG| EAX: c3e0bf38 EBX: 00000000 ECX: 
00000000 EDX: 00200292
2024-07-14 23:45:07,747 __init__         L0153 DEBUG| ESI: c3d54b3f EDI: c3d555e0 EBP: 
c3e0bf40 ESP: c3e0bf38
2024-07-14 23:45:07,748 __init__         L0153 DEBUG| DS: 007b ES: 007b FS: 00d8 GS: 0000 
SS: 0068 EFLAGS: 00210246
2024-07-14 23:45:07,748 __init__         L0153 DEBUG| CR0: 80050033 CR2: c3e0bf34 CR3: 
03f4c000 CR4: 000006d0
2024-07-14 23:45:07,748 __init__         L0153 DEBUG| Call Trace:
2024-07-14 23:45:07,750 __init__         L0153 DEBUG| check_bugs+0x900/0x91e
2024-07-14 23:45:07,750 __init__         L0153 DEBUG| ? __get_locked_pte+0x67/0xb0
2024-07-14 23:45:07,750 __init__         L0153 DEBUG| start_kernel+0x4d3/0x501
2024-07-14 23:45:07,750 __init__         L0153 DEBUG| ? set_intr_gate+0x42/0x55
2024-07-14 23:45:07,750 __init__         L0153 DEBUG| i386_start_kernel+0x43/0x45
2024-07-14 23:45:07,751 __init__         L0153 DEBUG| startup_32_smp+0x161/0x164
2024-07-14 23:45:07,751 __init__         L0153 DEBUG| Modules linked in:
2024-07-14 23:45:07,751 __init__         L0153 DEBUG| CR2: 00000000c3e0bf34
2024-07-14 23:45:07,752 __init__         L0153 DEBUG| ---[ end trace 7adaac7a13f2a45f ]---
2024-07-14 23:45:07,752 __init__         L0153 DEBUG| EIP: alternative_instructions+0x2b/0xfa
2024-07-14 23:45:07,753 __init__         L0153 DEBUG| Code: 89 e5 83 ec 08 64 a1 c0 06 f4 
c3 89 45 fc 31 c0 b8 e4 f7 ef c3 c7 45 f8
00 00 00 00 e8 84 6f 7a ff 85 c0 74 02 0f 0b 8d 45 f8 <cc> 90 90 90 90 83 7d f8 01 74 02 
0f 0b b8 e4 f7 ef c3 e8 04 6e 7a
2024-07-14 23:45:07,753 __init__         L0153 DEBUG| EAX: c3e0bf38 EBX: 00000000 ECX: 
00000000 EDX: 00200292
2024-07-14 23:45:07,753 __init__         L0153 DEBUG| ESI: c3d54b3f EDI: c3d555e0 EBP: 
c3e0bf40 ESP: c3e0bf38
2024-07-14 23:45:07,754 __init__         L0153 DEBUG| DS: 007b ES: 007b FS: 00d8 GS: 0000 
SS: 0068 EFLAGS: 00210246
2024-07-14 23:45:07,754 __init__         L0153 DEBUG| CR0: 80050033 CR2: c3e0bf34 CR3: 
03f4c000 CR4: 000006d0
2024-07-14 23:45:07,754 __init__         L0153 DEBUG| Kernel panic - not syncing: 
Attempted to kill the idle task!



r~

