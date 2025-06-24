Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58586C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 13:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU40q-00049V-Eg; Tue, 24 Jun 2025 09:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uU40o-000495-CX
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:48:34 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uU40m-0006IR-AL
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:48:34 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a577ab8c34so755496f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750772910; x=1751377710; darn=nongnu.org;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQh0LlcIASE0UVGS5ATj6wATE7U30h0+xwUiq1t9xn4=;
 b=CggQRyyrQuhyZZ3cclnzZ+hqlFDt/0w/fewA3VUF9lbeDPfyH+XlN17RdM7etTUGIn
 TNrQrc7sjJZQl3RiKRongTInHLGqcYfG1AR92jOlu53lUQZvwZhCLRNmNZ3v6fHD6TAB
 C08cpfcMj9V+zu39o6HP7DkGHSa3KoKRNRI0NFR3DAnmcDWfCsiNGZSIo7UCe1jYil5h
 fzmlO6s24mMdSoBkg7KRk4hRm1G6RFgsjsZMYbum/QcGqBszf7iNX5N7qd39M7KrR4tS
 FKQH23NZ39+grNGX9iqVCeIdpQeOYvgeRccEBMUvX+KsLbDv4++es8j4JiIQpik6IFQV
 QfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750772910; x=1751377710;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oQh0LlcIASE0UVGS5ATj6wATE7U30h0+xwUiq1t9xn4=;
 b=ih4Fcbhe1EWrXsfg9w5pjFQvL8/B/Femv9sCIpvbGqPqoEvO9iitWZnLrYyVCOy+pG
 YY4sKeytnJfWQaKD7jGdlGPAvjqtaT3cfx1gEts0N1O+eFnRmjWq5WPj3m2KpAE4FW8R
 28/zVz88h43QNlchXwbtd7qK5LoW8EOfI9W2fQNJONAHGYmaH6WFmnnUOJm+gvuYliSm
 AvzZKNdXUMSPgCZaNVSOC60WYIUWXt4bWI3wPfBPMQV9CWrt6KNiNqTugrVRBUz8j/Fz
 MivR7NfwMFTHg9ld29vkPyCc3SOrNvlDEqxg2Jm90fIJ+AwhYyAlRafyzbsjfAxSUfuP
 rEUQ==
X-Gm-Message-State: AOJu0YxqA8kO0bfkQBrBdNC8cgxVgQrMd4hl95+jYbzHAKHSuo+JgZdQ
 EGEOQgwgO3KTKt1bdE3sie/oRqCZCQyFeaR6oz3CPD7SSKW1gZwb2aMOGlhp37RbUt0=
X-Gm-Gg: ASbGncvUg1MZ3hY+Kjh3s9oga9YWIGqPoAslyOgy7RW9k2aJgTrbr4TGq7a8p+f1k8y
 GGZFKxwb1IxARnXwnFPnAtdoNF6zQUuHlzjIpe+l5RIIIHY2Q2HwBluvNJG7u13gf2drLE2D8OD
 OO8PpOND2PDWojhpVnQN3neIIkDeMSIiBMSWihM2x8fSOrjno9bZtDfuNbZ9q9A46qPKekPwW29
 pnj8uIje5lfaVHywbDOEAgZTQcfiuqOpQ+ZyREdHPBGTp6PZczAkU+Y0virvyVqH9OfuHs4GuSg
 JEORxPPewfGgQ08ItypyO3GNE+/aPV8ASOnzpqoXNE2Cmu+x4lN/3o313WZLdp1yrHMXXA==
X-Google-Smtp-Source: AGHT+IHHmAO172oI5BDXvSqP2mtdoG217AFPRQ7fatu+5vXhdtcKvbW+ExYK5OMJHwWlHR5xTawQHA==
X-Received: by 2002:a05:6000:4011:b0:3a4:d6ed:8e28 with SMTP id
 ffacd0b85a97d-3a6d12bbaa7mr4542681f8f.8.1750772910040; 
 Tue, 24 Jun 2025 06:48:30 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:b00d:6d5f:6e67:f5e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646d14f3sm142211175e9.13.2025.06.24.06.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 06:48:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Jun 2025 15:48:29 +0200
Message-Id: <DAUT771C07KV.2JZ4ZCRQ1MEQM@ventanamicro.com>
Cc: <qemu-devel@nongnu.org>, "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "Atish Patra" <atishp@rivosinc.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>,
 <qemu-riscv@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH 1/2] target/riscv: disable *stimecmp interrupts without
 *envcfg.STCE
References: <20250623165329.2759651-1-rkrcmar@ventanamicro.com>
 <20250623165329.2759651-2-rkrcmar@ventanamicro.com>
 <0811914e-623e-41a2-a54b-8ce42f45740c@ventanamicro.com>
In-Reply-To: <0811914e-623e-41a2-a54b-8ce42f45740c@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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

2025-06-23T18:39:02-03:00, Daniel Henrique Barboza <dbarboza@ventanamicro.c=
om>:
> Hi Radim,
>
> It seems like this patch is breaking 'make check-functional':

That is a nice command to know of, thanks!

> 12/12 qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi   TIMEOUT=
         90.06s   killed by signal 15 SIGTERM
>
> Checking the logs I verified that the problem can be reproduced by runnin=
g the
> 'spike' machine as follows:
>
> $ ./build/qemu-system-riscv64 -M spike   --nographic
> Segmentation fault (core dumped)
>
> The expected result is to boot opensbi. The problem can't be reproduced w=
ith
> the 'virt' board, so something that you did here impacted 'spike' in part=
icular
> for some reason.

Uff, mtimer is NULL on spike:

  0x0000555555c46618 in riscv_timer_write_timecmp (env=3Denv@entry=3D0x5555=
56888270, timer=3D0x5555568a61e0, timecmp=3D0, delta=3Ddelta@entry=3D0, tim=
er_irq=3Dtimer_irq@entry=3D32) at ../target/riscv/time_helper.c:49
  49	   uint32_t timebase_freq =3D mtimer->timebase_freq;
  (gdb) bt
  #0  0x0000555555c46618 in riscv_timer_write_timecmp (env=3Denv@entry=3D0x=
555556888270, timer=3D0x5555568a61e0, timecmp=3D0, delta=3Ddelta@entry=3D0,=
 timer_irq=3Dtimer_irq@entry=3D32) at ../target/riscv/time_helper.c:49
  #1  0x0000555555c6eb9e in write_menvcfg (env=3D0x555556888270, csrno=3D<o=
ptimized out>, val=3D<optimized out>, ra=3D140736012591329) at ../target/ri=
scv/csr.c:3214
  #2  0x0000555555c6a181 in riscv_csrrw_do64 (env=3Denv@entry=3D0x555556888=
270, csrno=3D<optimized out>, ret_value=3Dret_value@entry=3D0x0, new_value=
=3D<optimized out>, write_mask=3D<optimized out>, ra=3D140736012591329) at =
../target/riscv/csr.c:5579
  [...]
  (gdb) p mtimer
  $1 =3D (RISCVAclintMTimerState *) 0x0
  (gdb) p timer
  $2 =3D (QEMUTimer *) 0x5555568a61e0
  (gdb) p *timer
  $3 =3D {expire_time =3D -1, timer_list =3D 0x55555666b840, cb =3D 0x55555=
5c465d0 <riscv_stimer_cb>, opaque =3D 0x5555568856b0, next =3D 0x0, attribu=
tes =3D 0, scale =3D 1}

I'll try to figure out is going on, but `make check-functional` passes
with this hack:

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 81a6a6394502..a2092206cb20 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -44,10 +44,8 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUT=
imer *timer,
                                uint64_t timecmp, uint64_t delta,
                                uint32_t timer_irq)
 {
-    uint64_t diff, ns_diff, next;
+    uint64_t diff, ns_diff, next, timebase_freq, rtc_r;
     RISCVAclintMTimerState *mtimer =3D env->rdtime_fn_arg;
-    uint32_t timebase_freq =3D mtimer->timebase_freq;
-    uint64_t rtc_r =3D env->rdtime_fn(env->rdtime_fn_arg) + delta;
=20
     /*
      * *envcfg.STCE disables *stimecmp interrupts, but still allows higher
@@ -59,6 +57,13 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUT=
imer *timer,
         return;
     }
=20
+    if (!mtimer) {
+        return;
+    }
+
+    timebase_freq =3D mtimer->timebase_freq;
+    rtc_r =3D env->rdtime_fn(env->rdtime_fn_arg) + delta;
+
     if (timecmp <=3D rtc_r) {
         /*
          * If we're setting an stimecmp value in the "past",

