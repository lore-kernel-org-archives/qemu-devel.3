Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD05CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9S-0006b2-5e; Fri, 08 Mar 2024 06:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9N-0006Z8-Gr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:29 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9M-0001RM-10
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:29 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso17277795ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896346; x=1710501146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgvZkNEjDrjuamPt04chMxstCChtUwqVUEXDaGipd9c=;
 b=IyJvi2ONGFV2luGPH3I3Z4jlK8PWn1CaA6h5iAsVg7rw5Eo8aTxw4hAGqMoZ5SGHCQ
 xLpD63936bHdk8be7CwrSESolAzhj6L+PBUbhKb4KsGEy1203Tj0wkgb85xLNUMP47eq
 1y3eH1ODDfHS5vYO/HgpVcqOpRWHzImg6/NgHf7F6iezvtzx4lSZzr0m2/rTCrXkMXUf
 RfrZryRjJfNo5H90qN/FP5Ydszs21cTah9ioErxsugQwHJZgqg8ixlgwfbaJ8wGYlFBZ
 Ewar4Roy7fbyNB/yWC+NnHI448gov/uFIIy9+pcfeJuqqlkUflRkk2h2VJZ0ex+J3eBk
 lM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896346; x=1710501146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgvZkNEjDrjuamPt04chMxstCChtUwqVUEXDaGipd9c=;
 b=G7luAsrnn/1JPeYSzI/Rd8RQSDJ+bbZbbj1rEZbwELBTwKjayBwSOzNdIOMRJFokek
 tlvBbC99o6mXFbFO8rsH5tRuRhSR30vbuVOy3VI3SHlqjcPEWolSOPzMnVm0Wcd6ThHA
 hdQfcaAm5N8/vmOOsn7WdP33nP8ZeiwbAqXNHuvJR7ucEpo4+ApmxMNvOU8VooV3GZ54
 eG0eYQEKtwK81Bd3pu1EAhIBscAvXjelgmvWhRkvMbPs9Rzb30b8KP884F7FpkpuoCqN
 axNKKHsCJkcTyfOzt6RGMnEOcZXImifX/FojqNT5rQiu4EzRLyQZ2rPO6Rjh5Mm8/0Zu
 OA/A==
X-Gm-Message-State: AOJu0YyMaQbXXQ/ox7DXadC41R00/Jp9Ys6Tn1gTWx7OjetXafjlkmzT
 LBrSQk5pVfLSHcTk1yLi2Fx2rLr0XY+EkriTaFXrPlzT/gUJ00CMxe6/8ppaNSgD5w==
X-Google-Smtp-Source: AGHT+IEi2/KJQbfnvTGNBBDhOQparWy7SC/Hno8MwxdNdTa6aZAki9GvOjWU+/0Wf/gA7W8rfZs0iw==
X-Received: by 2002:a17:902:f682:b0:1dc:afd1:9c37 with SMTP id
 l2-20020a170902f68200b001dcafd19c37mr12018060plg.24.1709896346074; 
 Fri, 08 Mar 2024 03:12:26 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/34] target/riscv/tcg: set 'mmu' with 'satp' in
 cpu_set_profile()
Date: Fri,  8 Mar 2024 21:11:25 +1000
Message-ID: <20240308111152.2856137-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Recent changes in options handling removed the 'mmu' default the bare
CPUs had, meaning that we must enable 'mmu' by hand when using the
rva22s64 profile CPU.

Given that this profile is setting a satp mode, it already implies that
we need a 'mmu'. Enable the 'mmu' in this case.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240215223955.969568-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index dd5228c288..ee4c349972 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1075,6 +1075,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
 #ifndef CONFIG_USER_ONLY
     if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+        object_property_set_bool(obj, "mmu", true, NULL);
         const char *satp_prop = satp_mode_str(profile->satp_mode,
                                               riscv_cpu_is_32bit(cpu));
         object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
-- 
2.44.0


