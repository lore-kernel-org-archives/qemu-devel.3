Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176CBCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShHO-00084v-4y; Thu, 28 May 2026 16:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHJ-0007vm-0I
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHH-0004re-FR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso15196295e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999866; x=1780604666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hz2jU7hKglzNEGsRKoKDfem+W5C6aaMFkT5aPzRFDUM=;
 b=dRpOpSap3mHTcsHC49n/991rFw4z4JBdx0ZzSGAXa95Hjkfmu22QzLy/MBosYUoCWM
 o0tbfm42WBofWoycjv1ClExCbpui2HB2ZVmjiHOZIFnGRzBLdA+qCLfvaYwyt49RpDT4
 VhMH81NPsvbzRxt3oNzNOnnDEb2ctAsXW0Lj+rcJooueppxjVLxr53CmrM5/VhOiyu2s
 TWKAIDTUYFdPE13fFMItJQbTFOYCq6FtzMM/OKGta6dVs0T8jXlmWisBBBndmGERtjnu
 MTGsCQ7ouTCiRY7Ufkz+bN01VXhUBeJJpXzngTtaBIAHh/yq1PgFS4sAufarovbEL9LP
 uWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999866; x=1780604666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hz2jU7hKglzNEGsRKoKDfem+W5C6aaMFkT5aPzRFDUM=;
 b=E0JUCw94frqo+5AmD4XaJ/VzEFdUIGn+ZC3aWg2tYk8ZnSmwmIHbOvVPK3d5zWXCg4
 vPFgrNR36VKxSJmIWtM9c0TQN6qyx12tbFRH9y0NJPR90CiO+YKEk2SkPhuLSTG5rXM1
 a9q4LNqS+LtDFh+Lxk4xFz/ozGCyG3JaOgWJo8XC0MA6phTeALXR/JnK+500MW+Evls8
 Hwbnh36LhiAVe07MWYXKTeyVU+IwO2UD8eup6/FzHDQPVQLi9LryXCTSNGCxB8gA5xUY
 U6FWJPAEiStmzoskOA+qKr5xZHLpdBdpfPXFA3no0E/OXqLzgX7q/ng4+7pi8Wp6ednj
 qmtg==
X-Gm-Message-State: AOJu0Yy0N230BNYgRkk0OKEHNfU0/lM2qhaSKO7BOE/bCUsVpOv0oB+v
 wtbh/SlY787uHlkc+EmcYbEwwLCbhkCTTxOYKBL7DaDjJOX4lAVhsmmUXyvPTMjTUpIPWuWxj7D
 KdP0RhEHA7Q==
X-Gm-Gg: Acq92OHxNqptxXGlZ5v1ipbdotOwnts3RaWVdueyqONEYOTYHjv4wanfuSUELFjzeft
 mH2cv3s2Uxum97Bd7TOp5HzsdiCjYP+xcIYLVr68xlee0rUBukYkVNO08DK15z8vwJmds1b1rnK
 Ls98eZJKEVRU2dgw3dtpZmCj+pPZffPTvjICvRipTGtlO3nMoBNfmAKsf3nN/C32uOd+nPuLjss
 WD7LsPLbotld4vDtxfKz1xlHGLqw54XXurzSOOM2sxYIWem0a3lk39+gbqvXtIEiamTSit7+3sj
 wlXLIABSRrlWkCJQnlylqFomlHldGS1vwr1u869ak1mBvGF/1BEvSr2XvckJjzWLksqbeYcw6+P
 PA0tnxy9AfemsYzDqwSvEvtj1RLu6IJ7gYgA1GzVS6OGeZaG9iukTjP84PXaSHiLOQE14Llpt0v
 GoQEcD9d/BNaHHxD3TJ9uMpa5oT7bLNvRFEAh/X/L/3IBQQ47hKBZiw5uF7JtUYUeYKA==
X-Received: by 2002:a05:600c:8a16:10b0:490:53d3:4753 with SMTP id
 5b1f17b1804b1-4909c0c30a7mr319435e9.31.1779999865637; 
 Thu, 28 May 2026 13:24:25 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092654e10sm54505045e9.7.2026.05.28.13.24.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:24:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/22] migration: use stub_ss for vfio-stub.c
Date: Thu, 28 May 2026 22:22:42 +0200
Message-ID: <20260528202253.49122-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260528051642.115721-8-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/meson.build b/migration/meson.build
index e583822dec6..0a9a5d0d374 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -50,5 +50,5 @@ system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 system_ss.add(when: 'CONFIG_VFIO',
-              if_true: files('vfio.c'),
-              if_false: files('vfio-stub.c'))
+              if_true: files('vfio.c'))
+stub_ss.add(files('vfio-stub.c'))
-- 
2.53.0


