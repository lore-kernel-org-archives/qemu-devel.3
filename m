Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB55EB104B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzucB-0001XH-D9; Tue, 10 Mar 2026 06:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuc6-0001Qn-Tu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuc5-0005wg-H9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso16427475e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139615; x=1773744415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ujoRf0bcClqXhFXdVcwAONN87FJcA7bXaTWOZ3wQ6vo=;
 b=cL2vsQpv/mvWFzn9bOF/C0DgdR396OO2dyCZI4DWOA4IAz8dkee/bRztw4nyOaRHEs
 P0m527HYj9yEH3TaNgQ0/uPmaQfzfjC6g7gyrInzRI4Y9Le/cmJvEyC8/GHRwCIrwIba
 EBTvij1li78L2AHGW1ughf2D+gr6C2ewbjYelLyAkF7xeQqh+98/cDyqA8Do0OBdWsmw
 K4ppL47Sq8HGbp36RCc3J0pw1TtDK+uJcuF7rQrSHA5eqlS07UtmjhSaAILh+pZ06EcG
 X/Xay6uwAMJnGS4lM3DpmEq5Sbc2ljyTF3WZxnIK0sKZsLu1uqIiAyCxrtiCcYQAzofv
 lB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139615; x=1773744415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ujoRf0bcClqXhFXdVcwAONN87FJcA7bXaTWOZ3wQ6vo=;
 b=fSO++DdSCZe9v4z9uRCpZLe62qOyAGNd/La0dP+dg5Wl8Ze9lnkUfIlaBgiurlSULH
 u6NiA+NuuO/zEZdzg48V147xyJukdslz09F5xAJVtB90XizFn0uspogoURo+35g/4+6A
 CmjYJx+Tpe6BbBsW5MP5K/4HYba0Gq5vCtVhaG471b1sDh9I/5DO+akiT0vQeWDv4Dyd
 4GlV6qY3XErcRDe0lYgqOYx2dxZrsfywmvARDV7EzSnb2VURR/Vj5fxblkdITSw0k4N9
 Kzg6lqRfuGhjFGTuIK0tw9IrutjIiBjgKB4/ok8Aq2mC3n8vT4kHE/d75yqD9fGiwTiT
 n/hg==
X-Gm-Message-State: AOJu0Yy11uJGgy6Y3RCfRx9UWFQ3+tv0ZQ4LtAxdWVNueGPb7+WFJ3XA
 gp8JdK3pYWSzk1xDPKlQbMnPpRkppG5Eo1GkTd5zuVLQiIf5cHKWGsnjccWmZ+1fL1mPIoHJ0cJ
 Xfcyju0I=
X-Gm-Gg: ATEYQzw7hlhyFAUqM2EIA8q7iK54xB1Ok2K4QcvzNAiMYpbAfXEEoZTfOMYrF0OeXi7
 97hB78YYI3r5LboWvGKCorYRRfhpiSp3gtxeNJPbN4edne7Q4xFAXjuJ/MAiKtfudS2HSI1r/2L
 xrOc+5+feqH/DbT6z2AGOH5aQSGqItVceqUxn6veabALfya5tqg3CLk0lAuJ+gMC+n8pVhBzIge
 i95iRtCeBkuXaFJWG6KQQnjY6zADaO0qDihyu49t10w3CPsoz3jp3Q+APVDmyTeapqsyfDgRtd5
 4CoOf1Rw/ephglfz4ht7uq3R3qlUSpgvPo1fxuhKmshVzTmLmhEGy2349LQNkaTXeZhllafSu1d
 X9HFFg1NrWEfN6n9obLnBlFbwByPn+vZbtPYiniwiUViImRJJV+Q0TJGrBqX8hMBv4bNmYfi3oD
 l9mQc8/k4SHrYuw1rJg2LjMrwz6I/5JXGF8ML59hh9a3btQHxbyB/auJPnDHc0sexKNiSs6nVU
X-Received: by 2002:a05:600c:a12:b0:480:3ad0:93c0 with SMTP id
 5b1f17b1804b1-4852695d1e2mr233119305e9.23.1773139615117; 
 Tue, 10 Mar 2026 03:46:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852378e700sm196655345e9.0.2026.03.10.03.46.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:46:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] accel/xen: Build without target-specific knowledge
Date: Tue, 10 Mar 2026 11:45:10 +0100
Message-ID: <20260310104511.12670-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Code in accel/ aims to be target-agnostic. Enforce that
by moving the Xen file units to system_ss[], which is
target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Anthony PERARD <anthony.perard@vates.tech>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225051303.91614-6-philmd@linaro.org>
---
 accel/xen/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/xen/meson.build b/accel/xen/meson.build
index 002bdb03c62..455ad5d6be4 100644
--- a/accel/xen/meson.build
+++ b/accel/xen/meson.build
@@ -1 +1 @@
-specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-all.c'))
+system_ss.add(when: 'CONFIG_XEN', if_true: files('xen-all.c'))
-- 
2.53.0


