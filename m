Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562A60BEF77
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=D3wQ7/xd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgsl-0002Ja-Dj; Wed, 04 Nov 2026 14:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsO-0002Bd-JP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:28 -0500
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsM-0002Iw-H4
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:27 -0500
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-36cad25b8b0so1631569eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821344; x=1794426144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i7Jq/7124DeBbpOoGGLONuQ/33DpvrBcfI8nkFfw1GA=;
 b=D3wQ7/xd3RXnlmIDPScHjRDGp5EJP2DEkVM7GmqDi+2PNm88oPp8PUzyF7nrubN2g5
 GlKVLDYAtUxINZYzA8fZ+ORvnp0Gi3zFIqh67Lbdw/RaT7q7kweXQgVjYFxJqW2dp0E8
 CWuC1QNC0ntl7eyfH1dQNYB2TYkAkPXHRNNmXBSryiUJZa9EGYAk4d6+DNHEHhc3ewH7
 f9DebfpiyWHF/Cg9clnQANQBrHuPE/jECu5x/ACdzWYl1WmGdFYzn6arlKDYvv/oXVlI
 zJeP2gvLY7qQwdL8fHikHPIcpsBJEDMbiI4vDiHnArd8KYOIq75Njm5hNIlHRoZXjig6
 oAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821344; x=1794426144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i7Jq/7124DeBbpOoGGLONuQ/33DpvrBcfI8nkFfw1GA=;
 b=noCu/qRgFVy1lMFMKZy+KlJVbpaC7w8wcfRmGq72G6Hm1TdTn9cYTRes1hTeMTzxfl
 QB+gwsVZNvfINfFAbBWrQ0cqvW1e2uCzpOIllb7ovGalm3PL3g3gjqj2QIy93EiEiWYN
 1cVlpUQ0Bh0K5NvWbjh+mzrjBN22GHYlaFzyzhcWqSwZi9I3Q8KyU31E3/lXfXwqQ1lK
 /gYLjWyhNxIuiK7f/EUExMa0GNhHyABgo/kwtgHeQ6uYQGY+Bd8E28sgNDR9xe+SszM+
 4clLGPIY8jFj7M8WJLoGvEhoLeaoliVEGG2fGQ8MwH/0SRYOUzOjf0w2AsM8m1G1MHM0
 X5dg==
X-Gm-Message-State: APuU4Z+FAFegu4xffQI7r4BPD1sGm5omWDWO1Nov6bjE9I75QpBQqele
 HH9+ac2tRAFrsLkU27tV1yDpIgK6jCu4PjlxhTAqxX+d/rO5SrxMkQG9qWDiwf54fVyr25ixwvX
 4Gse7rv19er0uPewz8kBtTBcesnePHRCoFsaCUTKNiXRkjEH0x13QZjZGNjOjo6PwkiBtTlQRoT
 fK8Nrz70XFTZcuJe/bZ36CapAHT2uw7aQcaIGKylJxRQ==
X-Gm-Gg: AYBFou3vE0H4bZOcrrsuLNbUOL40Kdry+yFZ4cwQlIsLgHJzHDrxg0dvgBHEfnDK6yJ
 QxI2LiRztbPqpUcuHORaKhAPYTGd8l7LBZ2Ubw/+ulhDdN1uEFKYZ8ex3HQhoATGSmHpdLB9OrW
 kMvcbsAAa2DAKSJDq3Le0ctZi9mqod5iKmLZR/LWOcq+fKJ7aJdE/6zPodD2Pp+gA29BmRbDHK4
 hV/KHVs6zsPoUkIsl98iuBE/EDavjWYjyfqxyl9TH4wj18UdVUWTD9scwfLuCpTFghCHARcNcYj
 nqdFMn6CymH5uE/72yEj7MuGwgfnfa46ryqs/CCcjiautZ7aWlhnVCjweuSkq90ISbkHG0p6fZT
 uj54dL36mXRup2cRAvrGAW5zblS3YsLc9HMDxg7qegF/qnl1Yfr9HRhTn+rrZDrBk8T42dfR9Mu
 BtkoyaRI6cozD3kvdXuerUzJSg1/6CtDe9mVlLgOkk1pfuWvySmyJ66TqKWTW3G60voJFicZHBA
 1O91OWoSdZQEyh+OghkjVc7iiw314oPcRXlL6BwnPWRN6vlmIYvvkoCFjxSTOLXqne3PTam3kFv
 Uk4Hhjap908YbROVVJs/xi4QzT5QJ1acRKoKhC0/owtzfrER6x2Wy18AbT2Yucu9T83Hueld/v+
 UXU02K5Oq1UtlVloLvI1Ufc+vH58L
X-Received: by 2002:a05:7300:d0af:b0:36d:5fbc:8c94 with SMTP id
 5a478bee46e88-36d5fbc8f01mr1880616eec.16.1793821343483; 
 Wed, 04 Nov 2026 11:42:23 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:23 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 02/38] target/riscv: Introduce riscv_init_fp_status
Date: Thu,  5 Nov 2026 03:41:17 +0800
Message-ID: <20261104194155.679241-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Create a function to set all default controls for the float_status.
And set e4m3_nan_is_snan to false to follow the RISC-V isa extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 362e5618091..53ecce8c398 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -978,6 +978,14 @@ static bool riscv_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
+static void riscv_init_fp_status(float_status *s)
+{
+    set_default_nan_mode(1, s);
+    /* Default NaN value: sign bit clear, frac msb set */
+    set_float_default_nan_pattern(0b01000000, s);
+    set_float_e4m3_nan_is_snan(false, s);
+}
+
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -1095,11 +1103,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->xl = riscv_cpu_mxl(env);
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
-    set_default_nan_mode(1, &env->fp_status);
-    /* Default NaN value: sign bit clear, frac msb set */
-    set_float_default_nan_pattern(0b01000000, &env->fp_status);
     env->vill = true;
 
+    riscv_init_fp_status(&env->fp_status);
+
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
     env->debug_mode = false;
-- 
2.56.0


