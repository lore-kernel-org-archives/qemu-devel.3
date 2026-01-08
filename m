Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22E5D1D463
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr5y-00075D-WE; Thu, 08 Jan 2026 09:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5q-000710-Q6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:33 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5o-0000gI-1V
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:30 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so24563505e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882866; x=1768487666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KVOlUvDlycuELIbU/nTcJH/sre0/0JiNhQLMY+dTJQ=;
 b=Y0G/a6s9bVo8awMVDkA/4gEmiSGYAYwEiw5uLNqsYQKRABJ/1u+cgLdbdXpeDgyBj9
 ui439s1DAwjhoKbCsxBCCdZwiNsXhSmLUfW3IrD64oLGwydK6Ye84P+tmr2lAZ1vpHVM
 uAJcXlKole2GP+/gb8HP5R3TRMQ8fp5Ic3XJOYOlhGyg1IvBRsOrG+bdm1bK5Pt0AJCd
 uXxxjQP9ujtjowymT2NdxxhE2dNqlfD5dR6q7QM0DMNqc0fTpeejhPic73ifvf49Ciwt
 jFw+jNjhjW3pAk3lAT3w+e/d4BBvktcHTn5gQkFmjHqyz+AO5TXjJKQvbHXQ85S6DWct
 qibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882866; x=1768487666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/KVOlUvDlycuELIbU/nTcJH/sre0/0JiNhQLMY+dTJQ=;
 b=XV691YzLNtg6NXiPjtmNSGyjGWYxNi0TBZeL3vphlHo57AUjD600P3Oep0xjs0mrdS
 yUTiWC1Py5T9t9WV+JVFcekVmLdFCM2hH3oO6PHcwNcN4fnnUX3c83xGlpzmnYrMNTtv
 LIiTHL4gS6ZHkFhGUhPcnSMfSH2hQoqmEdRJaU9ENSHyU8MKaq55TCFLbhr3ow4NMQ4N
 HjCvXmYcmY8M6j/XqROpx1IMHhjFqEiFTD/kSNY8zVWGv+tQdGb/aN/T/cniN7icf/DT
 syevfyf2DUTX0X3RcEaKZGmoNQV2Orxd5OF8zBgMjJnnjwYcyZQ35LK3wjftA6pf61fW
 sFww==
X-Gm-Message-State: AOJu0Yx5MRH1WfGnDIu23pWtf/bhBZ5crPjq7pO5aErFl49oJk5lipVx
 jkRbVWJOWkmH3xeScPSbHjGhHRGtsER1780KXzHdUNoeSfAk+A9wwtB5H/UajGjbF/s=
X-Gm-Gg: AY/fxX7IlSFrYrfm8UlSf9ViR1d6Xm+sU1W8DkJP53g/a7Rltb8dgsjGfvfBWvobGA3
 d6BtiOsJmR/RLj1u6yQCQOmYkvXsXKuTbgtLFup/bP6saWgisKX3d0dSUsBfgrZFUycm+RtazDX
 E7+yEFaSg+U7v6hwX+lPVR9c5NY1X+YMuEVokXp/uE5GV2iqlz+8LB+3s7cfnOGxqhRecXiHre6
 vQ36eR19RjG/L6UQUN8T8Vp/29d4k0v+LGcHthMabwhqU9+ZrLtgebj8ZGrzdzBl9DTozDVrwlw
 qDC8nbWcd/Jf2UpIAYIxc/R0XC4pdWXokDoNwVxY2F3vtAvMoGA0qh4aJzFS/EjZUtVU0ViixLw
 COQMIPx8b7C4yCH4MXGiE/MwYAaNJdRI9g4tYyyLNOOFH2ruxCVIuw2NG3qH1so+Gll/m7gCG99
 ejh4muZ/8UAWQ=
X-Google-Smtp-Source: AGHT+IFrigIMRj1Fu7UQDZqoA4+G8mVP/VMqzMDX7eqsu7W3FCGzgFfrtVM8wmwRw8nFA5cmiRpzNA==
X-Received: by 2002:a05:6000:4284:b0:432:bc90:2cfa with SMTP id
 ffacd0b85a97d-432c374f5b2mr8866039f8f.33.1767882865561; 
 Thu, 08 Jan 2026 06:34:25 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5feaf8sm16663691f8f.39.2026.01.08.06.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C5A15F8DF;
 Thu, 08 Jan 2026 14:34:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 02/12] target/m68k: introduce env->reset_pc
Date: Thu,  8 Jan 2026 14:34:13 +0000
Message-ID: <20260108143423.1378674-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

To transition CPUs to use the multi-phase resettable logic we need to
stash some information for the reset handlers. Arm does this with
arm_boot_info but for m68k all we really need is the PC we should
reset to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/m68k/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d9db6a486a8..fda015c4b7b 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -155,6 +155,7 @@ typedef struct CPUArchState {
 
     /* Fields from here on are preserved across CPU reset. */
     uint64_t features;
+    uint32_t reset_pc;
 } CPUM68KState;
 
 /*
-- 
2.47.3


