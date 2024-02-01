Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFC1C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYpE-0002H2-Rn; Thu, 01 Feb 2024 10:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVYpD-0002Gf-Bf
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:17:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVYpB-0005Fr-FR
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:17:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40ef6f10b56so8797575e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706800674; x=1707405474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUJvKbgUShvcNix3bLT53w7WZVTT9v8XQDwDHAtkVak=;
 b=sHj15k5WMep/bBrZRnOR3/KR0vGxcYUWGzt09ZKJhy74JTd/V0+xuGGR7V0ROOp+g+
 OQdJUnNWwl0+I/Si4BOY//jo991Iih+4hDBDgMDc/ZR919vSNZhgbt2ihRlyGWO3Pwhx
 dULaGHsnrSPF78M3zy42PMLI4xXwMs9C84VXQe7fspl5BYx4mn/fXR3FX6S+1RbbnV7n
 9GN8Fl/VNXoz+K3lPHxiUKs/px3dlfggueS2Y+OmSb1DDe2+EpVcckYziBqmGNEU/2uq
 lnXqonseVTHQJ8/s/F02gCH4iapOkJbiSLsHeSJZXiP9IwvjIRw3HpIH2k6xHpEYwMmv
 usRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706800674; x=1707405474;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FUJvKbgUShvcNix3bLT53w7WZVTT9v8XQDwDHAtkVak=;
 b=MMdc8EdCSsFa4Y7ZlvNO6sOmZvF0DAFzZqPh/bcUbR8CQRxql1Vor7EMiET9kKgHiQ
 UhdXqvVAwYpdfkHqE88aMs2h0GzjLB0ktYxjs65zXEHCfLbqS5FTXgGCph1PF8HufrRZ
 CXksDpKoSQaQ1buepE6fAOREZI9IUS18l/p7IWOInEN+j9mMav/SljP9ZXNSE8Dy0Lp9
 hQEDfBk5JVvea/zFx5l90MUb0NRlEVSfDGT1DxUw5EPAeKlqxZyo7iS9Y6PtuJbN073g
 8nHSiUI3Q1EE+/2V7tulnYprMDeWLUyGSRJSr13L7VCUiVR2+dTMxZfkU5JiJReQkqoF
 S4uQ==
X-Gm-Message-State: AOJu0Yx9bqcP2TwuLI3IOmOCOwiwjdldbgKCnwY4oGqA/UgmJMqtMJVI
 ZKO+qO4Qm9mBb2Ub/Lhz7G0NdWj+klurB9iLZaXnm/JZo69esPNPy+GrLyQqRgg=
X-Google-Smtp-Source: AGHT+IHqNwbRTDKuNiWXp7JHfZveH2s2JcoTDYTaoUHFAp2OjWDl1l6e2VV1HDTAk/opSHtq1uXvtA==
X-Received: by 2002:a05:600c:358b:b0:40e:af03:5f8d with SMTP id
 p11-20020a05600c358b00b0040eaf035f8dmr1847495wmq.8.1706800674616; 
 Thu, 01 Feb 2024 07:17:54 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUwc5clXq2gzWSAW4WkBMQ3Rd7Wh/mSXpU5AAOkNNm4b3xrwJaIRZUQMBRubhJk87/NO5ZUUkLzSB6nJCH+rFR9OcohTIhDWN1TDdVk4QgFbQxF4lhlFfpgtzi5pWljpmOBobzfqnWJBFfSW+xMC+5p0UVXLPSkZ8I6ZPGYH0D5uAW3y+Km0jk+vhYgk3wDqqkEJVYOtWAAuENEx1Swrw0pJCIA4ETONZ74dRAeEAAcATVjAcVP5b9IBAaOGV1rDaNE02SUAjE3qcUNh/U=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m39-20020a05600c3b2700b0040fb7695620sm3086165wms.0.2024.02.01.07.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 07:17:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CCD655F7AF;
 Thu,  1 Feb 2024 15:17:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Sajjan Rao
 <sajjanr@gmail.com>,  Gregory Price <gregory.price@memverge.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
In-Reply-To: <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 (Peter Maydell's message of "Thu, 1 Feb 2024 14:35:56 +0000")
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 15:17:53 +0000
Message-ID: <87msskkyce.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 1 Feb 2024 at 14:01, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>> > Can you run QEMU under gdb and give the backtrace when it stops
>> > on the abort() ? That will probably have a helpful clue. I
>> > suspect something is failing to pass a valid retaddr in
>> > when it calls a load/store function.
>
>> [Switching to Thread 0x7ffff56ff6c0 (LWP 21916)]
>> __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<optimi=
zed out>) at ./nptl/pthread_kill.c:44
>> 44      ./nptl/pthread_kill.c: No such file or directory.
>> (gdb) bt
>> #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<op=
timized out>) at ./nptl/pthread_kill.c:44
>> #1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>) at .=
/nptl/pthread_kill.c:78
>> #2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@entry=
=3D6) at ./nptl/pthread_kill.c:89
>> #3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps=
/posix/raise.c:26
>> #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
>> #5  0x0000555555c0d4ce in cpu_abort
>>     (cpu=3Dcpu@entry=3D0x555556fd9000, fmt=3Dfmt@entry=3D0x555555fe3378 =
"cpu_io_recompile: could not find TB for pc=3D%p")
>>     at ../../cpu-target.c:359
>> #6  0x0000555555c59435 in cpu_io_recompile (cpu=3Dcpu@entry=3D0x555556fd=
9000, retaddr=3Dretaddr@entry=3D0) at ../../accel/tcg/translate-all.c:611
>> #7  0x0000555555c5c956 in io_prepare
>>     (retaddr=3D0, addr=3D19595792376, attrs=3D..., xlat=3D<optimized out=
>, cpu=3D0x555556fd9000, out_offset=3D<synthetic pointer>)
>>     at ../../accel/tcg/cputlb.c:1339
<snip>
>> #21 tb_htable_lookup (cpu=3D<optimized out>, pc=3Dpc@entry=3D18446744072=
116178925, cs_base=3D0, flags=3D415285936, cflags=3D4278353920)
>>     at ../../accel/tcg/cpu-exec.c:231
>> #22 0x0000555555c50c08 in tb_lookup
>>     (cpu=3Dcpu@entry=3D0x555556fd9000, pc=3Dpc@entry=3D18446744072116178=
925, cs_base=3Dcs_base@entry=3D0, flags=3D<optimized out>, cflags=3D<optimi=
zed out>) at ../../accel/tcg/cpu-exec.c:267
>> #23 0x0000555555c51e23 in helper_lookup_tb_ptr (env=3D0x555556fdb7c0) at=
 ../../accel/tcg/cpu-exec.c:423
>> #24 0x00007fffa9076ead in code_gen_buffer ()
>> #25 0x0000555555c50fab in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555556fd9000,=
 itb=3D<optimized out>, tb_exit=3Dtb_exit@entry=3D0x7ffff56fe708)
>>     at ../../accel/tcg/cpu-exec.c:458
>> #26 0x0000555555c51492 in cpu_loop_exec_tb
>>     (tb_exit=3D0x7ffff56fe708, last_tb=3D<synthetic pointer>, pc=3D18446=
744072116179169, tb=3D<optimized out>, cpu=3D0x555556fd9000)
>>     at ../../accel/tcg/cpu-exec.c:920
>> #27 cpu_exec_loop (cpu=3Dcpu@entry=3D0x555556fd9000, sc=3Dsc@entry=3D0x7=
ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1041
>> #28 0x0000555555c51d11 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x555556fd9=
000, sc=3Dsc@entry=3D0x7ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1058
>> #29 0x0000555555c523b4 in cpu_exec (cpu=3Dcpu@entry=3D0x555556fd9000) at=
 ../../accel/tcg/cpu-exec.c:1084
>> #30 0x0000555555c74053 in tcg_cpus_exec (cpu=3Dcpu@entry=3D0x555556fd900=
0) at ../../accel/tcg/tcg-accel-ops.c:76
>> #31 0x0000555555c741a0 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x55555=
6fd9000) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
>> #32 0x0000555555dfb580 in qemu_thread_start (args=3D0x55555703c3e0) at .=
./../util/qemu-thread-posix.c:541
>> #33 0x00007ffff78176ba in start_thread (arg=3D<optimized out>) at ./nptl=
/pthread_create.c:444
>> #34 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64=
/clone3.S:81
>
> So, that looks like:
>  * we call cpu_tb_exec(), which executes some generated code
>  * that generated code calls the lookup_tb_ptr helper to see
>    if we have a generated TB already for the address we're going
>    to execute next
>  * lookup_tb_ptr probes the TLB to see if we know the host RAM
>    address for the guest address
>  * this results in a TLB walk for an instruction fetch
>  * the page table descriptor load is to IO memory
>  * io_prepare assumes it needs to do a TLB recompile, because
>    can_do_io is clear
>
> I am not surprised that the corner case of "the guest put its
> page tables in an MMIO device" has not yet come up :-)
>
> I'm really not sure how the icount handling should interact
> with that...

Its not just icount - we need to handle it for all modes now. That said
seeing as we are at the end of a block shouldn't can_do_io be set?

Does:

modified   accel/tcg/translator.c
@@ -201,6 +201,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *t=
b, int *max_insns,
         }
     }
=20
+    set_can_do_io(db, true);
+
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);

do the trick?

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

