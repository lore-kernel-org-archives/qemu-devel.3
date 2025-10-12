Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C3ECCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 18:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v80wY-00040t-13; Sun, 12 Oct 2025 14:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v80wW-00040X-2b
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 14:37:16 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v80wR-00059e-54
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 14:37:14 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b67ae7e76abso679741a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 Oct 2025 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760294228; x=1760899028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=A4PdcUy4EXoCTSRCdNBQUsA8o1cz8lvvvcQGvegCZ8I=;
 b=KNcwylOYiewlQV0D7cS3FpmxD/RAiTzUnqL88HhKq38G6EKx2pjMt6HlW8KRlfWFPg
 Xu7+WtlcIma/qfn5rfHrOC5vhhlDAWecL6g9lozBTTV0h+KCbeiO6IJAL8KT9kz4sz/r
 t5RhuqeVwK9zcjU4U2Cj5dsRSTrrtDxAlfhFiBCYkpsroZHYdcTrzJv1XREtnteIfoYP
 PL/uHM9zyLkrTv1gpGS6VtQaZ3XXTNLI+aZenjcsuXAnY3IQO4gZORIFluf+H3atasNN
 hpEQ5BMGOQxzLyT/42u9Eo1w1STV8cujvuE2AgmiULpQQC7Q+oc8AX/ETzMOYesooDqd
 VFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760294228; x=1760899028;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4PdcUy4EXoCTSRCdNBQUsA8o1cz8lvvvcQGvegCZ8I=;
 b=oiAHpi4IpbRENXLuUfSABDZ+Jr+ueiUmi/jsmettjbFn3EWdeL8YjpGS45+vmJaxR5
 tH9DxnuAGPm2nh11Ftmhe0Y27N4Vsk+Gdz5cpFw8fSs+I0/hLyU11Sl5KpFCoITtA1kG
 r6XjsyWLGTbKGL0r5cpisj7PyRRcPLMmjH5W84h1gAiy2cWSVvdwg9DJZsfJorIIQkUM
 EzTXjtFYjIPb1QR7l19R2tABrN5+pMHbWy7cCTeTi5UUytkMYrJN1VD3tzlULIuiYhye
 88D+Fgl5NH1o00uJGSHNl9IxkkOWm3Eh9qtrr1UDzwh09Dpyzu1y/vFUAYHKV4d3exKU
 nSGg==
X-Gm-Message-State: AOJu0Yy/NqfI4SbixkLV9A7HFkSHunkXD2UZNUVfgJkx9Q2bM8CxGkDv
 SYwlqVE69y+DYdUXeDmFkBaIkk/TGnsdZIjLf5mnTbBu+4A7Hm3DLKAO
X-Gm-Gg: ASbGncs1qRJLYRFaoA6/IEP/7aDvAAq5Nl0adOZYU2lkMc6NJirJhTD5WT0XJShh+eL
 zEflbgf5bvz9QRnWY6UJZymU4rJNaJk9RrOsnzO/BzDHt6E84c1fzMkaUevriGyyvIAOl/oWkdf
 nqK7iyaMj24KMlknV8inmEnCW/hDPIvyZ4Afo37Uw2Ij2bpCXML9TN6jMdkgNvb71402xrfNr7Y
 bSdN2t/EvfekuwxTH9vdthNNM3MrU/vFtXX1bPkA+uzlYOXeOM3MQw08mnyPwlWsP8DSits41To
 va3jf0JDQoDxEPN6uXEqW5OLcWaWkJm3jZL3hWUU+RLfs6BDTVE2fHl48BOiwyn9Wq/W0lUAp6v
 MSv1Q4+ZnQduW3yBqcm57yzUZX8sauhypgtst3l8i+tsdo78bHbBFq/JuTS/wlqHaH+gNuoPi2G
 BNKmisd94duTNEAA==
X-Google-Smtp-Source: AGHT+IFVpwB1+mRxXvTzksvcLdSfb26mtQNJCDK5kM7k5O4vyq6XdoMmdbvwtLd2LYKnL8Vmal6b9Q==
X-Received: by 2002:a17:903:2343:b0:248:fc2d:3a21 with SMTP id
 d9443c01a7336-29027290194mr189904295ad.4.1760294228497; 
 Sun, 12 Oct 2025 11:37:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e1cc53sm111805705ad.46.2025.10.12.11.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Oct 2025 11:37:07 -0700 (PDT)
Message-ID: <f9500f38-eb15-446d-aaec-91ee6bc67112@roeck-us.net>
Date: Sun, 12 Oct 2025 11:37:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: Use MO_ALIGN for system UNALIGN()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ysato@users.sourceforge.jp
References: <20250503212708.3235806-1-richard.henderson@linaro.org>
 <46ea9b87-cc73-4408-82c4-2de96dddca0a@roeck-us.net>
 <6c23f546-c135-4345-93a4-25d75a038902@roeck-us.net>
 <b95bf540-0b6e-4812-9393-9b7991ed501a@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <b95bf540-0b6e-4812-9393-9b7991ed501a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/5/25 11:30, Richard Henderson wrote:
> On 10/5/25 08:43, Guenter Roeck wrote:
>> On Sat, Oct 04, 2025 at 05:14:45PM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Sat, May 03, 2025 at 02:27:08PM -0700, Richard Henderson wrote:
>>>> This should have been done before removing TARGET_ALIGNED_ONLY,
>>>> as we did for hppa and alpha.
>>>>
>>>> Fixes: 8244189419f9 ("target/sh4: Remove TARGET_ALIGNED_ONLY")
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> When trying to run sh4 emulations with qemu 10.1.0, I get quite interesting
>>> error messages. Bisect points to this patch, and reverting it fixes the
>>> problem.
>>
>> Actually, it is worse: Commit a4027ed7d4 ("target: Use cpu_pointer_wrap_notreached
>> for strict align targets")  claims that "Alpha, HPPA, and SH4 always use aligned
>> addresses" which just is not true. At least sh4 generates an unaligned trap and
>> handles the problem in the trap handler. Result is
>>
>> ERROR:../accel/tcg/cputlb.c:2944:cpu_pointer_wrap_notreached: code should not be reached
>> Bail out! ERROR:../accel/tcg/cputlb.c:2944:cpu_pointer_wrap_notreached: code should not be reached
> 
> Yes, I posted a fix for this one yesterday.
> 
> https://patchew.org/QEMU/20251004192414.1404950-1-richard.henderson@linaro.org/
> 

With the above patch applied, I still get the below backtrace when trying
to boot upstream Linux on sh4 with qemu 10.1. Reverting the MO_ALIGN patch
as well fixes the problem.

Guenter

---
ok 14 bitfields
     KTAP version 1
     # Subtest: blackholedev
     # module: blackhole_dev_kunit
     1..1
delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#1]
Modules linked in:
CPU: 0 UID: 0 PID: 298 Comm: kunit_try_catch Tainted: G                 N  6.17.0-12907-g8765f467912f #1 NONE
Tainted: [N]=TEST
PC is at test_blackholedev+0xc6/0x1c8
PR is at test_blackholedev+0xca/0x1c8
PC  : 8c228d16 SP  : 8d40bed0 SR  : 40008001 TEA : 8cce4026
R0  : 00000000 R1  : 00000000 R2  : 000000d2 R3  : 8cc77b80
R4  : 8cc77b40 R5  : 0000000e R6  : 8c228cea R7  : 8cce400e
R8  : 8cc77b40 R9  : 8cc77bbc R10 : 8cc77bbe R11 : 8c4b46b0
R12 : 8c78310c R13 : 8cc29cf4 R14 : 8c6e3a88
MACH: 0000d80d MACL: e554cb0f GBR : 00000000 PR  : 8c228d1a
Call trace:
  [<8c05b378>] pick_next_task_fair+0x94/0x164
  [<8c5c2bce>] __schedule+0x306/0x6ec
  [<8c21fa68>] kunit_try_run_case+0x58/0x174
  [<8c221df8>] kunit_generic_run_threadfn_adapter+0x0/0x24
  [<8c04a8e4>] to_kthread+0x0/0x1c
  [<8c0896a8>] ktime_get_ts64+0x0/0x184
  [<8c5c2fce>] schedule+0x1a/0xf8
  [<8c221df8>] kunit_generic_run_threadfn_adapter+0x0/0x24
  [<8c04a8e4>] to_kthread+0x0/0x1c
  [<8c221e08>] kunit_generic_run_threadfn_adapter+0x10/0x24
  [<8c221df8>] kunit_generic_run_threadfn_adapter+0x0/0x24
  [<8c04a8e4>] to_kthread+0x0/0x1c
  [<8c04aca8>] kthread+0xb8/0x1b4
  [<8c0241c4>] ret_from_kernel_thread+0xc/0x14
  [<8c020698>] arch_local_save_flags+0x0/0x8
  [<8c054198>] schedule_tail+0x0/0x58
  [<8c04abf0>] kthread+0x0/0x1b4
Process: kunit_try_catch (pid: 298, stack limit = (ptrval))
Stack: (0x8d40bed0 to 0x8d40c000)
bec0:                                     8c05b378 8d40bf10 00000000 8cc29bb8
bee0: 00000000 8cf03c00 8cc2c000 8d40bf10 8c5c2bce bbc23be9 8c21fa68 8cc29bd8
bf00: 8c221df8 8c04a8e4 8c0896a8 8cf27cc0 8c78310c 8cc29bb8 8cc2c428 8cc2c000
bf20: 00000007 00000000 364df8f1 00000000 00000000 00000000 00000002 bbc23be9
bf40: 8c5c2fce 8d40bf60 8c221df8 8c04a8e4 bbc23be9 8c221e08 8c221df8 8c04a8e4
bf60: 8cc29ab0 8cf843c0 8cf843c0 8cc29bd8 8c04aca8 00000000 00000000 00000000
bf80: bbc23be9 8c0241c4 8cc35f1c 8c78e25c 8cc2c77c 8c020698 00000000 8cf03c00
bfa0: 8c054198 00000000 00000000 00000000 00000000 8cf88080 8c04abf0 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 40008000 00000000 00000000 00000000 00000000
---[ end trace 0000000000000000 ]---
     # test_blackholedev: try faulted: last line seen lib/tests/blackhole_dev_kunit.c:35
     # test_blackholedev: internal error occurred preventing test case from running: -4
     # test_blackholedev: pass:0 fail:1 skip:0 total:1


