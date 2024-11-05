Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC9ED2B922
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JFJ-0001OY-OH; Tue, 05 Nov 2024 08:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JF9-0001Ig-Ai
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:16 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JF7-0002Ne-6u
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4314c452180so39885605e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811907; x=1731416707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDSm43fdf8jLcDNMuepzzXNnXrf+Cwp4vQFZzGV7m7k=;
 b=E6JTtC2VerCypEMjEv0NrrwmyGtbzYxaYorTGfowQbVQLIK0Vr5Rgt5ExV9Wg31Hl9
 7sAasAYWjnpQBl1lAt4P/oqK4QSUxenfLpbBm+Ak2pj7uRoz4cZoKm13InPt/kGMQSlk
 ODqOLuIvOZqlleQqBTE8vN3D+1CzutbyLsW87X58VFZuOuSOtKMHHyqbn7B//eyGFJSa
 QVaGf2K7LLhxJ3+2rOA5JJJZn5Mrti6fqT0S7wtBG60FDfFbt0PFFTY2im6WUU0dewV0
 Fby0Ere3onUF7amFdR81S4myb+aeykPcXUewlqeA1EG24f3tuECAYXw2QZ7idaujgf6Y
 qAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811907; x=1731416707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDSm43fdf8jLcDNMuepzzXNnXrf+Cwp4vQFZzGV7m7k=;
 b=jYDo6OS59aBKbTRtgtFdpgzgzxAM7YVDCC+3Vp+3/5/Z22CLXKNSJmQLCxBynwEQzs
 SPDJoWIPGULoo4+Yb7jeJii49HsiL6xUSiIdxQB2LUbukbi+JDhqfmArFEEUCWn14IsF
 n/hI1SSFSa3J04ozU18kxkAwkoUxLCnpOYWOBrzrwWEZtrJaxroKk/BP8Pk3PfOiH0fD
 i/duG1CtxOtCcuowkf2wD41UqxVzp8L0XEoIVZcXxDCl7fN17aA1xOqBRTnlGvj21fXp
 cuMdHmOyl50cJiv735Cz4BTqVYN8O9OAqS6kD5Onrd1AuuznfXHYGTTib9onSLyrxWRV
 kzSw==
X-Gm-Message-State: AOJu0Yz6quC6ClHIsLzq1ikHsMCq/dBqozI+Uf73xffLbd0Ki0yl3cLN
 T9jhiMtS/v9Syi3smvZneilrhs4tVIwNyqac6xElFKHOg24p0xv6V4Szu1QwChPwcV/c0sGBjJy
 ise8=
X-Google-Smtp-Source: AGHT+IEiZ+IDWk575+v438vJMAhRsdBUOU98Ww81Y2HZMPtHqqxfIeUMIqmHOKdx/eypJcQFCkf2Gg==
X-Received: by 2002:a05:600c:4ed4:b0:428:b4a:7001 with SMTP id
 5b1f17b1804b1-43288c32703mr112566525e9.15.1730811906941; 
 Tue, 05 Nov 2024 05:05:06 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e687sm16288378f8f.84.2024.11.05.05.05.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:05:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/19] hw/microblaze/s3adsp1800: Explicit CPU endianness
Date: Tue,  5 Nov 2024 14:04:15 +0100
Message-ID: <20241105130431.22564-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

By default the machine's CPU endianness is 'big' order
('little-endian' property set to %false).

This corresponds to the default when this machine was added;
see commits 6a8b1ae2020 "microblaze: Add petalogix s3a1800dsp
MMU linux ref-design." and 72b675caacf "microblaze: Hook into
the build-system." which added:

  [ "$target_cpu" = "microblaze" ] && target_bigendian=yes

Later commit 877fdc12b1a ("microblaze: Allow targeting
little-endian mb") added little-endian support, forgetting
to set the CPU endianness to little-endian. Not an issue
since this property was never used, but we will use it soon,
so explicit the endianness to get the expected behavior.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index dad46bd7f98..37e9a05a62a 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -71,6 +71,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
+    object_property_set_bool(OBJECT(cpu), "little-endian",
+                             !TARGET_BIG_ENDIAN, &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-- 
2.45.2


