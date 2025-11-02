Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803F7CCFA02
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 16:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFaoX-0004mb-0w; Sun, 02 Nov 2025 11:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vFaoM-0004mF-RN
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 11:20:11 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vFaoK-0005oE-GU
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 11:20:10 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3307e8979f2so633687a91.2
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762100406; x=1762705206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pg/KJwWnn55z2ZIqg9emeflcQJoNX1QOlDzhzAR01oo=;
 b=WorJJymyewDMbzbTcpQi4zM6dHA4mcwAinZ/KKlMbKItTO9HD6ehHK1zf87W4rSJMZ
 hVv5zBIEMWw3xdIwYcaNjAriBWZGckIqhp5TXnmtWMaBaUy5w1tDVIW8Gn72OQZvejwk
 meQjVEhTDVDOS4Vae2WAmONBZFVVCyinsdc0mzWx1yOCblC4n94msUcHgap8vzxM47VK
 U8H6EzdA7G3q7SZ41ndqSR0leXnY+VkKTnY9FcuLLvKN0eiP5Yj+wmtCbr9/QplaRTyk
 RFfzW40KqFjumSV5WVyqR/axLXvwrnKGOHJ9FBlbWm6xt04F/VVr+XUZ4oAzn6fUhxvC
 26Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762100406; x=1762705206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pg/KJwWnn55z2ZIqg9emeflcQJoNX1QOlDzhzAR01oo=;
 b=cBom39Zw4FBWdW8dh4S8jcycfkJwHUHOBWF6YMcXoBn+cLdvkx0xPAt7VRVIe7fyR4
 FR9nv757VFqlGQGSBB/3Dg5BQKcXOj6p1g50WpbRC3aAzFj4QFkfkwjmb4V6qSOyCPQh
 7VDaydb76O+BP+/mESxrqzUP/NO91CqcVebsHRyMtxjmZTpWJXCmdu+BA7dM5BknfV/U
 ICjUDPdSbVecsnYoJgJt1ECWjMy6R+cgVaJYbnvMg+vy548HNsblPhNCmhW+9VM5CMrq
 O0d82whVoK5ASxEZyBCaroVlfqsDbdt13y2gy76NS7Pp+MQOcSvC2bDjkIij5vWrTGsm
 5TsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa3Acwjbufk3z/q0dKJ3FUKrmvuQXugjHLrtnDflbP9MsBWjMJTfs9D8bnuxr/Dr1FQsdVu5Q/eKJk@nongnu.org
X-Gm-Message-State: AOJu0Yxy+3r5XShT5m+6dLpfgQgGSUsmcdaOd6urBf205dBDqVvtam8T
 ePXej6NSGtUsAM/6P+evFo2CNZPE/hk4L+oip99ZgGTj3TpjKXzlTdUU
X-Gm-Gg: ASbGncteI9gt1byBb+18HCnk63lFHw84yKml7gfbRlv7qS2soxT5PYeldNRzRznWJ9x
 tSi8pc2ItWIib/hasmX0nT71bnEiQA0hn/lPABNvdR2oYbQD5V3GEXdNNaLD24N9q6fvHkIQvbt
 x/oiotws37js+qU+/UkqUIjGu6/ib4PfcBKdlsmSFiCbeS3KynBpQ+pADlo1Rdv6WMAb164/Kxb
 w1WoTUxjI53MLfWkIut+UlA+cnpjYnfXMDHvPz0XXKf1ssfMjsI87dzAPCX0JNX/rAqtqy4P0+b
 ZOym3Q+I8/aQFKOxYKYB9omWyqfezzIO+OyZrxvsd5wY1Ubl5YBmWF+3cKP9MuLZOxyURtlinvJ
 fUA6BzwUr/6A4MDzTHFWF0CEeLed4JisM6FbolcsTXWtBhWUCWk7KkML6gs5QrSW56uzKFVxVmD
 dOmHbN0Yxxx/KCj/KhODYOqPQ/zTn7RFbvO3gmwBwozc9yxg==
X-Google-Smtp-Source: AGHT+IFOkNan78CCVBxUbOju9tGf3qbaGcAF1ZkcZvWr4myRVIQMnTC/6ynGDVtnginBm5h98UveEA==
X-Received: by 2002:a17:90b:1644:b0:341:124f:4745 with SMTP id
 98e67ed59e1d1-341124f559bmr803683a91.6.1762100406178; 
 Sun, 02 Nov 2025 08:20:06 -0800 (PST)
Received: from ?IPV6:2402:e280:2177:35:a77f:15f7:4845:1af9?
 ([2402:e280:2177:35:a77f:15f7:4845:1af9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db0a019csm8262509b3a.42.2025.11.02.08.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 08:20:05 -0800 (PST)
Message-ID: <2fd10834-cfb4-46f8-ad64-8a54b8a00ca0@gmail.com>
Date: Sun, 2 Nov 2025 21:50:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for PowerPC e500 little-endian pages
To: Chinmay Rath <rathc@linux.ibm.com>,
 Danila Zhebryakov <d.zhebryakov@yandex.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
References: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
 <d52da8d1-3d9c-46c4-99db-b22bd597db27@linux.ibm.com>
Content-Language: en-US
From: Yogesh Vyas <yvyas1991@gmail.com>
In-Reply-To: <d52da8d1-3d9c-46c4-99db-b22bd597db27@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=yvyas1991@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Danila,

Could you please share steps (including links to images used) to test 
these patches.

Regards,
Yogesh Vyas

On 10/31/25 6:11 PM, Chinmay Rath wrote:
> 
> On 10/27/25 18:00, Danila Zhebryakov wrote:
>> These changes make powerpc booke206 mmu pass TLB_BSWAP flag for pages 
>> marked as LE, and also fixes all the issues this causes.
>>   - added TLB_BSWAP to non-MMIO flags
>>   - inserted additional check for LE page when bswap-ing instructions
>>   - removed assert for cross-page TLB_BSWAP accesses
>>   - added gdbstub fix to account for TLB_BSWAP of the currently 
>> running code
>>
>> BE- and LE- atomic operations (used by load-and-reserve and store- 
>> conditional instructions) were unified to support TLB_BSWAP
>>
>> Some of the fixes are based on what is done in https://github.com/ 
>> YetAnotherMod/qemu
>>
>> V2:
>>   - Removed usage of PAGE_USER bit for LE (comment on previous version)
>>   - Refactored MMU code so directly setting TLB_BSWAP is possible
>>   - moved translation LE page detect to occur 1 time per translation 
>> (comment on previous version)
>>   - Removed redundant assert in atomic_mmu_lookup (comment on previous 
>> version)
>>   - Added assert on cross-endian accesses (ideally, there should be an 
>> exception)
>>   - Changed atomic need_bswap handling (comment on previous version)
>>   - Rebased and fixed atomics
>>
>> V3
>>   - unfix assumed typo (if vs iff). Everything else unchanged
>>
>> V4
>>   - fix leftovers from BE/LE atomic op tables
>>   - fix uninitialized CPUTLBEntryFull full in mmu_common
>>
>> According to RM, unaligned accesses between LE and BE pages should 
>> cause an exception on e500.
>> However, (as I understand it) supporting this would require adding a 
>> new callback to TCGCPUOps, likely just for E500 or maybe a couple 
>> other CPUs doing this.
>> Such accesses are clearly not normal and usually don't occur in real 
>> applications, so I think just placing assert is OK here.
>>
>> Danila Zhebryakov (4):
>>    accel/tcg: Unify big- and little- endian atomic ops
>>    target/ppc: refactor MMU helpers
>>    target/ppc: Add support for LE pages on PowerPC booke206 mmu
>>    target/ppc: fix GDB stub to work correctly with LE pages
>>
>>   accel/tcg/atomic_common.c.inc       |  36 +--
>>   accel/tcg/atomic_template.h         | 326 ++++++++++------------------
>>   accel/tcg/cputlb.c                  |  29 ++-
>>   accel/tcg/tcg-runtime.h             |  48 +---
>>   accel/tcg/user-exec.c               |   2 +-
>>   include/accel/tcg/cpu-ldst-common.h |  51 ++---
>>   target/m68k/op_helper.c             |   4 +-
>>   target/ppc/gdbstub.c                |  17 +-
>>   target/ppc/internal.h               |   3 +-
>>   target/ppc/mmu-booke.c              |  67 +++---
>>   target/ppc/mmu-booke.h              |   2 +-
>>   target/ppc/mmu-hash32.c             |  30 +--
>>   target/ppc/mmu-hash32.h             |   3 +-
>>   target/ppc/mmu-hash64.c             |  14 +-
>>   target/ppc/mmu-hash64.h             |   2 +-
>>   target/ppc/mmu-radix64.c            |  20 +-
>>   target/ppc/mmu-radix64.h            |   2 +-
>>   target/ppc/mmu_common.c             |  75 ++++---
>>   target/ppc/mmu_helper.c             |  15 +-
>>   target/ppc/translate.c              |  42 +++-
>>   target/s390x/tcg/mem_helper.c       |   6 +-
>>   tcg/tcg-op-ldst.c                   |  51 ++---
>>   22 files changed, 374 insertions(+), 471 deletions(-)
>>
> Hey Danila,
> 
> This series is failing on QEMU_CI. You can check it here :
> https://gitlab.com/rathc/qemu/-/pipelines/2131344109
> 
> <https://gitlab.com/rathc/qemu/-/pipelines/2131344109>
> 
> Here are some logs for quick reference :
> 
> |configuring with: '../configure' '--enable-werror' '--disable-docs' '-- 
> cross-prefix=powerpc64le-linux-gnu-' '--disable-tools' '--enable-kvm' 
> '--disable-tcg' '--without-default-devices'
> ...
> |||
> 
> |[1690/1838] Linking target qemu-system-ppc64|
> |
> ||
> FAILED: qemu-system-ppc64
> ||
> powerpc64le-linux-gnu-gcc -m64 -mlittle-endian @qemu-system-ppc64.rsp
> ||
> /usr/lib/gcc-cross/powerpc64le-linux-gnu/14/../../../../powerpc64le- 
> linux-gnu/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_gdbstub.c.o: in 
> function `ppc_maybe_bswap_register':
> ||
> /builds/rathc/qemu/build/../target/ppc/gdbstub.c:96:(.text+0xd0): 
> undefined reference to `probe_access_full_mmu'
> ||
> collect2: error: ld returned 1 exit status
> ||
> [1691/1838] Linking target qemu-system-ppc
> ||
> FAILED: qemu-system-ppc
> ||
> powerpc64le-linux-gnu-gcc -m64 -mlittle-endian @qemu-system-ppc.rsp
> ||
> /usr/lib/gcc-cross/powerpc64le-linux-gnu/14/../../../../powerpc64le- 
> linux-gnu/bin/ld: libqemu-ppc-softmmu.a.p/target_ppc_gdbstub.c.o: in 
> function `ppc_maybe_bswap_register':
> ||
> /builds/rathc/qemu/build/../target/ppc/gdbstub.c:96:(.text+0xd0): 
> undefined reference to `probe_access_full_mmu'
> ||
> collect2: error: ld returned 1 exit status
> ||
> [1692/1838] Generating pc-bios/edk2-arm-code.fd with a custom command 
> (wrapped by meson to capture output)
> ||
> ninja: build stopped: subcommand failed.
> ||make: *** [Makefile:168: run-ninja] Error 1
> |
> Thanks and regards,
> 
> Chinmay
> 
> 


