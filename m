Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCF4FC9EFF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyt9T-0005Ko-5i; Sat, 07 Mar 2026 10:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt9F-0005IE-Ry
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt9C-000548-Fh
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:00:56 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so85432055e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772895652; x=1773500452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoM27mpvLD+kD5h2ebJHgBOSBD0IZgVkj+2pZeVCMbg=;
 b=KgZNKTt3eyen+WZIx3lP1foCiga3qHeV8OSPDoIv7yd/SvunrYy4qPr//90VuFfPtg
 MiimZvmmK+HkHajQ/sU+yulSdLJCkOI/InQGFIDxZdTQaWCKcO80fx2QxGr1mjiCShrp
 2gd2VhBXVUhyzm1x2SiOb0u97nrqjXxc3k4SD+mFkoqa988mbqeT+INRueyXrgmjF6ah
 0yjfRTEEiaC1SD96V4UsIhEK/d5vN+UmxLM+yryYSsTmF4K0sqrX2pCueYVdTUzrq6LH
 WgruJhmfeYZ9yc+Kac/1cQYsVL63bPG2sst2ijCR0Vh2tkasEnpevj/JYK2sLDNx5LVj
 pDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772895652; x=1773500452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EoM27mpvLD+kD5h2ebJHgBOSBD0IZgVkj+2pZeVCMbg=;
 b=qqHpGmxScdZAYkgxdU7kF9DimboaSCAnlFzVCcKGUk2YwHvudTZk4xwRY1Sgo5ZDb9
 GyulxRYaxRCFEbGwN8QnicxXtAe+Q8ITZmdDlCyqJsSimXMEMfOdGoiNgVbLZy4+BvMm
 UH0mIZeVCHDPxFP929v90/b6OFc/DT2D6GTIpXNqy8aN7Zr+8twQVSkHvrW4gkkQlMAo
 NMZk/CQqOfXXPZRAAv3X4TV0VVw4Dz/Ha8GZ/eMsgKMH0oUZ+7QD5z75dU1r1tNAltJc
 AIfibnOGW638JAeRYUaDz10sWcrc6hzpMSj1Ek4r1FUd6850uZ59pWGC5/lb8iN32LDS
 nIpw==
X-Gm-Message-State: AOJu0Yxqqiz+nIYkvg9qxkM5pvplAkbg8sIpqZqIqolTkpJyFS92zYHj
 mBhAZUzJO/ADDAx8mgPPWfzzcICDvJk46pkYpuarEdQiLs0FQM2LZ4xSHuO5JpvDcLqptC8WmQI
 OnmZY0Ro=
X-Gm-Gg: ATEYQzzRRi1HDcp1QqfE6k0dphk5AFQiKbmSGNqYYGxkTfwhmFMaBkDTrTjUKiFZBeG
 JQ3XAcIHY1N+rpY1EoF+tzPgu1mNxyKo2Q0pKhSgD6cOMbokKx6myuaa+dqua8Dru1Zo7ghEUsX
 fGnlTil0z24lohrSbtS8Wj9P0+MQ0Dt1Br10F8HwhVT5tq73VUCjhDXEmGMpY3hh7KiWB1winIy
 /mwtolHNLRhEy+vXfDMMYYFaFcussJVxDorWYoOyd5Fvwla/W5+4aSoBoLXIxVzDUnjlzyMpVhe
 nqbEhaU6CON5kfuwYJGy/K2hnSWUbXiYTXtbzFgoy9G6tqoq4YEAlybS4QvTSft889GhSvSwf9w
 5mOOea+Gp3IYjZ2bTk6agulNwBEOZKdfFgoKDCFvwWxWCb3ALGPw+ppbGIWu3BwExUR4xtFJ9wl
 xQO3Vghl1ZsNBc9JSsVeFI+Yp8ZERIlYsj6jSRtzTAXytDuKRUaaw2Kp7n/1xLKeauZAN/CB/p
X-Received: by 2002:a05:600c:1e85:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-4852691c657mr97647775e9.6.1772895651592; 
 Sat, 07 Mar 2026 07:00:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686bcesm188751675e9.7.2026.03.07.07.00.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:00:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 1/4] hw/i386/pc: Remove deprecated pc-q35-3.0 and
 pc-i440fx-3.0 machines
Date: Sat,  7 Mar 2026 16:00:39 +0100
Message-ID: <20260307150042.78030-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307150042.78030-1-philmd@linaro.org>
References: <20260307150042.78030-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 9 ---------
 hw/i386/pc_q35.c  | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 961432176cf..29c8e997131 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -668,15 +668,6 @@ static void pc_i440fx_machine_3_1_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(3, 1);
 
-static void pc_i440fx_machine_3_0_options(MachineClass *m)
-{
-    pc_i440fx_machine_3_1_options(m);
-    compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
-    compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
-}
-
-DEFINE_I440FX_MACHINE(3, 0);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 261d759a223..f102da8e4a1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -614,12 +614,3 @@ static void pc_q35_machine_3_1_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(3, 1);
-
-static void pc_q35_machine_3_0_options(MachineClass *m)
-{
-    pc_q35_machine_3_1_options(m);
-    compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
-    compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
-}
-
-DEFINE_Q35_MACHINE(3, 0);
-- 
2.52.0


