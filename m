Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5A9F99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquZ-0007Mi-2d; Thu, 23 Apr 2026 06:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquC-0006Zp-Au
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu9-0002RB-HV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so5190985f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938608; x=1777543408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OT7gO6UF1PSEXEGRWiSsG3xtgIQqj47ZJLCPKk7AwyY=;
 b=ftKpKNwlutIklYc69XXXaVZtyzVtxixc7YfmW6zUGn3HZi1IhYPd8ei5Pb3FIXGe0P
 Zqsnsgwds3lmtPqcZRHC5x5psTv7BKAog8KMqgN1rYHwDA3OAKnipnt5Y3vcbM06Z3Dm
 S+i6KLRkKAU3Q6BaDRuwUIrHVBH0k5n580uoKkmpE2FmXF1m4k64VrI4jPHGNBL+XRaQ
 RHXU/vmqv5o4vNQThPKzbTHwB8G3+zdIa8mQUWAxxeWgvmf2vsaAHNm6FqWnpRtHPXBj
 30czLua53jBLGu+PsTd3FF96z5YDHNF6Z8+Y8goH6legn6EIRRyjgcFdHUG9glHcMXyk
 xYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938608; x=1777543408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OT7gO6UF1PSEXEGRWiSsG3xtgIQqj47ZJLCPKk7AwyY=;
 b=WkKUVT6Vx3UbGLFTuyFHsSHfu3knC1uLPb6agaYU6oIpMM51KeIQ9AVs15+AQ8fEGc
 3m0bdCzWK25QWWZpshS37hPU8HTEzdEx1qSCIEYlnluyMGAVEjoPtrAXVkHoPE5xml7P
 PtsLh4sZoTvbocletj6BuqZ/jFUFrJrPMLYWLWutJ6sjCEs2LkMnDXyPR9XpyPoICClc
 6kA4LHG0vo+/kmyuiSX3Q+nO+G745Z9Ol76q4EVq/2EgpGEUDyrjKoxrW+Glvok1lXqw
 J/yXV72DpVUZxwbdzMEHlntzWSpZjqdngtX9Gk2kyC7u30bQvF4uKjySvA+/bFJtbVGt
 0lrA==
X-Gm-Message-State: AOJu0YyUJMLe2B9KDGbAzXmSGcIBxpC0t9LR8y+SDoZCl/TG02slsBXi
 B2sdaZ98NtGZOe2r53SYM2cxRVVCRbaYJuBuDYVznkkEfRedYnvte56iv3Ks/ONC1eA0lKpvgBc
 fMBUR
X-Gm-Gg: AeBDieuy37/Pthf9FxdMzO6XmWizwR7y9bA74wFJJasYgpXhkyEDCA68TdhWwHaE5S8
 zVLE5oMilH8C4EL0gExA9Wma0ESKMFcZ/8z1r81+wOqMNl6T8DZWxqiv9wehlZyZ9j4fzoraOQN
 zlXRjsLTLE3e84e2xhG5o7j+mdfYXRf8xOkmahkTn0AEEtbTEg+BfLT0Fi3Gz0hlR79ExELIiJx
 t4e1dyu1auXxWzpY5jZyjyuMHZK2RD8bY83TqiFN+0Z312m78bA1Gr1UQXvcHuut4Bm76LsR4mE
 GCkOG+goiyA4BeL4zbhVThhKHXRuScr+88NH7kcnGK9OkJWBbXyQL90DVwmYEYLRnuLiVvlm3JD
 Nx0rnOOvQdroGtBT8ZtsMxYu1UM7fP9vLB2ag/ajxk1C+q1N0ElUWXlOCfEAJuWIK/Rda4fJcQz
 P1Rthw5sGXfV2QKAAoDKbDYJDGyRtSruzTUdEgT58KnIiJjsiykSsWgKKZsszjX+MlrVLUjidyf
 7K4S4IAqNtriyDBi2kcH31W6UABlHlR3QPu5W7NkQ==
X-Received: by 2002:a05:6000:1849:b0:43b:9416:1aeb with SMTP id
 ffacd0b85a97d-43fe3e25681mr41590259f8f.45.1776938607633; 
 Thu, 23 Apr 2026 03:03:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/59] MAINTAINERS: Remove Ronnie Sahlberg
Date: Thu, 23 Apr 2026 11:02:21 +0100
Message-ID: <20260423100229.2941820-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Ronnie Sahlberg has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-21-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1537b0db2..bb05deefbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4182,7 +4182,6 @@ S: Maintained
 F: block/blkio.c
 
 iSCSI
-M: Ronnie Sahlberg <ronniesahlberg@gmail.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Lieven <pl@dlhnet.de>
 L: qemu-block@nongnu.org
-- 
2.43.0


