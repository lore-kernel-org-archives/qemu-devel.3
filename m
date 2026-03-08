Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301AFEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMhz-0007dS-Bo; Sun, 08 Mar 2026 18:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMhy-0007dK-52
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:34:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMhw-00033M-Kw
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:34:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so7613951f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009282; x=1773614082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I3iCPUqgY5scKVR3y8X/ei0qlp8YojJCAKqyusz3u98=;
 b=aqVZIYYd/+/sxBA7BvqnEGE4MB8GHdHRgWuoMT2j0c+7xI+Hk9IDbIlbSwHSiEKi4H
 9CMjFzZM8/bM6t+MNrTkBEQeMzwlIpe3TB7kVVOgUPfD8KCzH6dEbBM2w8hX/oV3IAjr
 31VYEWO1a2SHj6J5zotoJMm/aW/KejIJLvus6VMyWsxEndmG2aG6aesGdKFnnU14CLTF
 4RxI3QBY+hF4WIYYnjWj/XLY76bZCKzHlM9OARrfbrvyCsL9uBYxR33/kc4kxabtS9i9
 tVqUm2/JJL+x/setUtRDUAjLUdLgbClijdIhp6s9YNDo5JTarOWyAw2sGujUHpkr31wy
 qbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009282; x=1773614082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I3iCPUqgY5scKVR3y8X/ei0qlp8YojJCAKqyusz3u98=;
 b=fxm6XPSynUBvz8nCqkWao7aNdja/5TBI8FqQJu5ilyyQqzlnBWg/fY8OgL7rH4iCUk
 V2MlHyTSNJFZB83Zjoxf+/Kq8msdXf83x0NgLq+pnM5NuCbt+zqi+pKrpTe3YJbuEmc2
 d7+vIdG9kdmL7BycNXWs7k3Z+u9d3UHkuP4mwAaHVAsiCUqKbhxK8wUESqtVvu9yOKYD
 F26qPgPcgt86C9KvAZby8rLIN4ocsGGr2YgV3YDAgCE1jmbQ1ZBJ+1gANrQmzE5jS1ff
 nJF+O1Yg9yAHGiXA4UoYGRTpq93wfwwNPmHnbFTXPG1q1/8dM5KWoa1lI6GhbaTKfZkH
 EYEg==
X-Gm-Message-State: AOJu0Yx7tnYxczi6Etvxad/M//MYd4qETir5uQnvlPVVvQTLKMhTBPfc
 OI3WALdCI8U05xspCAwscsvG3/BkA1I/xgeJQFqDFvyxGso81TyRkLrYuF8dHfCpxoAW/G8ZC6n
 Qf7hEqAE=
X-Gm-Gg: ATEYQzz0Qlrm1U/bCB++78jF6e/U0HJa+4f2M3qZ6///l8SL940Z623oYRILU9L/whc
 luShzW39S66VwzCQ2Q+HOtZ2tZPVfAB2wTpRJQVQugo8aHvu+aqzGZTT+8Idb7GUHMJqRBWZ77J
 DbU1sz/uxuf28uWph5KislsMEDpX+6VkBOPwcxGjmEodJWxnFvs+1L+oRyFyFDlxvrHGsGwYtaC
 R5JROMLeF2iblUNSlW9L0126VKvOJuvYB1OhiZsDXWLNH+WqvxfqqjUqmwsjiaoWqrXNJST76+r
 t/xrlyjrChLmOniNBrbZumoXDxQ2JVyTfQ7jtw32157XMvzsjpNUjSkafYO7G0bVNcPT06BkCLp
 rjGyc9oxFDmLVyMaWYlzgdeYAYhY1ICpLPd/GNniuNG4aJDaPafF64WYTnfRtgD4nK/yRy/yE94
 uqvjQLBW2OGMX0G8cAZxgM/qJnpLZGY3qTsq8xPXh4JV4RoaD9phd2Nvpd4CknF3ESzWF6cCWVe
 BH3dQ==
X-Received: by 2002:a05:6000:2893:b0:439:b6d6:71a with SMTP id
 ffacd0b85a97d-439da89ec91mr15310687f8f.51.1773009282377; 
 Sun, 08 Mar 2026 15:34:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d95dsm22917415f8f.7.2026.03.08.15.34.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/49] hw/i386/pc: Remove deprecated pc-q35-3.0 and
 pc-i440fx-3.0 machines
Date: Sun,  8 Mar 2026 23:33:45 +0100
Message-ID: <20260308223433.25503-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307150042.78030-2-philmd@linaro.org>
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
2.53.0


