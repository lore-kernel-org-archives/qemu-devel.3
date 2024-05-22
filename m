Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C391C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9isy-0004US-SW; Wed, 22 May 2024 06:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s9isw-0004U1-Es
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:07:50 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s9ist-00046N-TD
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:07:50 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-574b3d6c0f3so10857753a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716372466; x=1716977266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=QHnr5PA/4G/g2SGYVeid+45uKyi7cgtITKiXvIxUDsc=;
 b=OTLuUOdi8GXwk4ri4I03QGzbul910gTM0801cZaozB7ci7jwVRWZbkT7nGi01C5ZBz
 HGuvAbeGO4Yo48bXVwndgO9wYHMxgO4GoV+zTftH2VLuPra60ZoSh2GanAcr4SgYN2l6
 jrhWVQY5wH1HQE5uDiiBat+0OrZ0ng8V1SH/G8ARgrRkqeLYLi3P6XipWeE7zZztL7en
 c/m40Lg10tHYd1b82fxU9aSLJbX25mm09f8yYBnEHIMr6qvEIJsiZ65NeRlYE63fXE7z
 uTsP+dSvgR5PKuEDbwIABl0idvyC5FihN0MIquszubYeHl1WJcgLtBbDhyG6fWAKg6Ev
 fOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716372466; x=1716977266;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHnr5PA/4G/g2SGYVeid+45uKyi7cgtITKiXvIxUDsc=;
 b=oVbG1CyCIsghWpd9gKCfvVKaIrJ3BzBIHTzFgyfUR0ucAUqPY574pFHEcuVKYCDMIH
 wr1tFxSBSZuYPoeXaIAGUrWixMUk83UpdZ47cGg/RdUmqwmUj7T7LadvmJqi//LqJ8Aw
 Xq4mdbbj94c8BJQs/MrJd/xR4E2OX2epa2IiKbaCG3RuvNcnOqdWvVAV/YAz4tzCtHSw
 L6OhKJevrBVLfhasUMC+DqXkbiuN0iXeHLaS79ttPo9AG1LNnvVifGEWQvpMtQRuZIcv
 QyjXKsQ5Mfkzs7spY4VXk7wuCB5cMvmGGT+7Oev97oGF2qzOFtSnZ8yiZCZYoT7vlidg
 1WQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvTTovSxRpjqiUbD2Jb0qlzYADLR7II7m7RqQacGAxkuDWCLBv6k4xmtljm2sYg2IoWTD8f2vj7YUL2IgXny8MydrBM/g=
X-Gm-Message-State: AOJu0Yzm2LWvUGkilwFP4fAt8O2+CVf6WggwanminPqOuWqL8Xvy42qK
 o2cjS/kFHVrJyZ+xrQeBZH8BL21C6G/SFQm+9DCpQufFQGii8g0cY/Ug8A==
X-Google-Smtp-Source: AGHT+IF/kqvZlUAg6kwS/bCvRQdhF+qbvnCM6SNx0aFueCviA3LbaAy2JGKs5jMDsFv8vSMJIDZOeg==
X-Received: by 2002:a17:906:c302:b0:a59:b8e2:a0c5 with SMTP id
 a640c23a62f3a-a6228143abfmr78003066b.51.1716372465558; 
 Wed, 22 May 2024 03:07:45 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7fcfsm1740092566b.119.2024.05.22.03.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 03:07:45 -0700 (PDT)
Date: Wed, 22 May 2024 09:29:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_accel/tcg=3A_Init_tb_size?=
 =?US-ASCII?Q?_and_icount_before_plugin=5Fgen=5Ftb=5Fend?=
In-Reply-To: <20240521210604.130837-1-richard.henderson@linaro.org>
References: <20240521210604.130837-1-richard.henderson@linaro.org>
Message-ID: <4F2066EE-B0A2-49F6-9B6A-46CA709D541C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 21=2E Mai 2024 21:06:04 UTC schrieb Richard Henderson <richard=2Ehender=
son@linaro=2Eorg>:
>When passing disassembly data to plugin callbacks,
>translator_st_len relies on db->tb->size having been set=2E
>
>Fixes: 4c833c60e047 ("disas: Use translator_st to get disassembly data")

Indeed! It even works better than ever by also fixing the range of the mac=
hine code=2E So:

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

The only issue that remains is that the machine code is reversed, i=2Ee=2E=
 the first byte is output last=2E But that is a bug that existed before=2E

>Reported-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>---
> accel/tcg/translator=2Ec | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/accel/tcg/translator=2Ec b/accel/tcg/translator=2Ec
>index c56967eecd=2E=2E113edcffe3 100644
>--- a/accel/tcg/translator=2Ec
>+++ b/accel/tcg/translator=2Ec
>@@ -214,14 +214,14 @@ void translator_loop(CPUState *cpu, TranslationBloc=
k *tb, int *max_insns,
>     set_can_do_io(db, true);
>     tcg_ctx->emit_before_op =3D NULL;
>=20
>+    /* May be used by disas_log or plugin callbacks=2E */
>+    tb->size =3D db->pc_next - db->pc_first;
>+    tb->icount =3D db->num_insns;
>+
>     if (plugin_enabled) {
>         plugin_gen_tb_end(cpu, db->num_insns);
>     }
>=20
>-    /* The disas_log hook may use these values rather than recompute=2E =
 */
>-    tb->size =3D db->pc_next - db->pc_first;
>-    tb->icount =3D db->num_insns;
>-
>     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>         && qemu_log_in_addr_range(db->pc_first)) {
>         FILE *logfile =3D qemu_log_trylock();

