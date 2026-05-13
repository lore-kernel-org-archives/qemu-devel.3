Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0655CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4Ks-0000z3-Kl; Wed, 13 May 2026 03:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Kq-0000ym-Q2
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:48:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Kp-0003cX-8B
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:48:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso4128701f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778658529; x=1779263329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UerYm6b2Z3yY8W3Pc16lGAPFBiqbGIQwj+tuPPjT5qU=;
 b=VOFpAoXT6+ZSLiaS2Ayim5GhD79Tc+IyqE63rD1U4QUangGw1kpfyzCEi5dP+ARAX6
 /Slh+60xUn7EV+9rlIBnrWlC7cx2pXHpSnat/YHRm7QKh9ak+92CAuggVOKmQsi0Jtob
 XGgfi5tD9GJPGuA+7e5DQ3CT9UoFr6FWS7xz0sx6hJfJaKJWvbHw2mUNYpiqUzGMm71t
 D2b3D18wFhMBJjQ0dxb0M4JRjQFsXaLxLvgruqsoClEya3oqJru2W4Q2lo4gZ48j2mAE
 LvsChDOJVTSN6IpCU9BBugLQN0gab3oEezIpAl4LaAHbTiB/mbl9QmJtlTzO77atBVUf
 d9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778658529; x=1779263329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UerYm6b2Z3yY8W3Pc16lGAPFBiqbGIQwj+tuPPjT5qU=;
 b=PGBTUd3n45jGgkVrlizkw7CStjRlGo99QIzhr0Wft0hMqXtC48AhLU8A7a4Uwo7sga
 tqF6ub84yV8frxRYCUrH2H0nUTqVl2TFa82XYGQRjxWLUXQJxUdmw7iXajOYnyBF3Vvl
 JpNs91arn5vqfC/W1G4NC6OevRgyiHfG2PIGs1oQY8fdMRF21xC5R89aBKwDIOoSbOKQ
 /8urxYsVyUVf3E71mQcPQC8Pg1ZivvAawx6aXmqMI5F/SGECEnkt0ZyAmNP47ITjMd1B
 XOdUBC7zFHIPB2CRzdrMp+H86rg/Ien58J0X9hZKlDm64qOgmFYuSBjcvHIGoJkHev0D
 NW0w==
X-Gm-Message-State: AOJu0YxOtnrww2KVc/x6xz4hGz2KSk1A81gnsHBcGKyKNfMFsF+Wtiue
 PVqRlBuZ4LPDwpE30s4yQIwLWbJ7GslbzpxDOkSTh9H8PDQ6YBygBYKMyrN/ahrcxZj4DDrfrmn
 he1WzMoE=
X-Gm-Gg: Acq92OGFvEFfsko3SCR2wFUnRdibK8ql4ybEUE5dKO2cDMz7sd6pavc+Hhfj9Ipi8YI
 tFSCSe1RPlBaCG5FHjq5UcXvuU36ZYcH0a0rDI5BUEssknqL7jw6cx+IfnK+T/Ul79aGpZtgcKD
 7+llSNAArbdVbjEa9R/7u1oGURqXG3xEuxan6B8VJ4b4l995UFPXH3KY/6ubRnzoWcpAtnGLm+O
 9VJoh21/0WmFMY73aDVevcqwZ1YjKreATS1L4Se1Mx02d8Lape+JYMTbGHvzFU07Ezg0mF6Y+5L
 q9P2ToofD/ts2zO5EIinGkm/+oWzFqRbKTK2W++iTzu8e25qM+jRvJi2NkJOeLq2MeWWR4JQfuO
 KeTA/raOyAthvSjBg31E0yWbR8C9VrFTTGsiCET9ZsjPZfQ/Fe4yi5KGOWtobAYOwDPpAtpgrZQ
 EoW90g0DSJk5N+v5O+r0OQrMkk2RWeXBJ87KNfoaf9Wy2plpxviTudk5oRWDXI/cYEoqXWle6l
X-Received: by 2002:a05:6000:26c2:b0:45a:1b61:9f9a with SMTP id
 ffacd0b85a97d-45c580cdfccmr3079463f8f.1.1778658529387; 
 Wed, 13 May 2026 00:48:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491bae13csm37249819f8f.29.2026.05.13.00.48.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 May 2026 00:48:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/alpha: Use DisasContext::mo_align in system
 emulation
Date: Wed, 13 May 2026 09:48:38 +0200
Message-ID: <20260513074840.11398-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513074840.11398-1-philmd@linaro.org>
References: <20260513074840.11398-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Rename 'unalign' as 'mo_align' and use it in system emulation too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index d2d1467a812..120ef5f8ab5 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -46,9 +46,7 @@ typedef struct DisasContext DisasContext;
 struct DisasContext {
     DisasContextBase base;
 
-#ifdef CONFIG_USER_ONLY
-    MemOp unalign;
-#endif
+    MemOp mo_align;
     uint32_t tbflags;
     int mem_idx;
 
@@ -73,9 +71,9 @@ struct DisasContext {
 };
 
 #ifdef CONFIG_USER_ONLY
-#define UNALIGN(C)  (C)->unalign
+#define UNALIGN(C)  (C)->mo_align
 #else
-#define UNALIGN(C)  MO_ALIGN
+#define UNALIGN(C)  (C)->mo_align
 #endif
 
 /* Target-specific return values from translate_one, indicating the
@@ -2867,9 +2865,10 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
 #ifdef CONFIG_USER_ONLY
     ctx->ir = cpu_std_ir;
-    ctx->unalign = (ctx->tbflags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
+    ctx->mo_align = (ctx->tbflags & TB_FLAG_UNALIGN) ? MO_UNALN : MO_ALIGN;
 #else
     ctx->ir = (ctx->tbflags & ENV_FLAG_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
+    ctx->mo_align = MO_ALIGN;
 #endif
 
     /* ??? Every TB begins with unset rounding mode, to be initialized on
-- 
2.53.0


