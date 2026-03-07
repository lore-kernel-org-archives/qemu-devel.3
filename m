Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53865F513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytnV-0002lK-S0; Sat, 07 Mar 2026 10:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnR-0002ZV-NU
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:29 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnP-0002b7-MR
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:29 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso4906661f8f.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898146; x=1773502946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwnhbTdZtHuK4Wlr++WMbiNe7zENSv7DVDb8dSk7bZA=;
 b=PM4ck9XZGwseMc4s/HZ/gOzsog78xdKJUBn5rjy0+tiYSbX+0mMHxH80k2734Z2ITa
 7VPAN0d+PRi+eMGah41jTtWOpTIw/g+1T6G8JkLR0eDYApA1PSoW0XzzZSkxtCfE8BdG
 eWxsGhsHeISiXO6eIJ43038T/lkQQ+SKDcQPowJUa1WauVPcHxlCkABZxbHgFU9KfuPF
 IvYokTfeTEq1HWJBgAcORie6E+AsCG0tbCNHaBkz4mpUNVgRfixLfYDuCA+h0XRXdLIm
 kjWBo+VFK3W5jZiOaC57vkPfN8kR4XiTbnPcHj088/4aDD1ugJ1J5vVgSpiyEyiEqq/T
 ezOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898146; x=1773502946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fwnhbTdZtHuK4Wlr++WMbiNe7zENSv7DVDb8dSk7bZA=;
 b=Eh4OLaqljTL6CFelSVnm+eCsMp7htEw/d+xLzaHhMP4riKPq0UK/UhhYJFjfTWFnfu
 D5rfcE0EsobxTK8vHUkPhh4o8tyNwaVXMAoFB6+1F1o5lgvr45DT/qc6J7f7Rn6AmNvi
 J+YxbnZfMC7kV/aotuz6tSRX2JWNu/tk/EqjTQHCuMqP4W/0Hspbs43PZkivZ0rnrpy+
 PrMBtKOw/Zw2o6JyxKNLzVkp37Nud0HE+ulv9ovFgfRPQ7+c8IstFSVzkG4W+V3p09FI
 WgFjVJZ60UB8MyyaCUlSXZBd3cfcGIUdcf8IArgn9QNHTHgem0cupaIBC4gzykywMAft
 szOA==
X-Gm-Message-State: AOJu0YzPVRWhgdtZuR6AcJCILynlwDPnPgvjE2FK+OboDCHsYqVbL0dD
 05iG/L8CFqIKDlzYOaJQtOi3iTm5Q//u1SQqcAkGVVyL8Yq+fqFdai3H9quj1CLF1cdB+waQMgv
 57/oAe1o=
X-Gm-Gg: ATEYQzz+XL1n4KuYdqa/mOSVy9e7vjhx5x9CLe96R3oPpsKvTPlocGftFFFq3XUI6AB
 2GVXU2eJKFpb/NNQw+0mjOTz3OFkPjDozYHoj4nglHsM+CEbE8Ln+AR4W4U/YoURSIiF/Wn/5tq
 cZMM3qWTn9BGUSzU4+mohkO2nSlhWAJqy4Rm7vPDjrC0eOWQ9AXKKNTEUmdxZW+xxHO0j1l0BOl
 TmYovIY3kxtZLuke8dM9gQnTqOW+HKOEbSBspJnaAKVEdCwE6W3aygyvSRhZ0SMigAL2UEtm98f
 KMz9TNe8xlqWCMAxyHp5HDIRWj5oOYtwaJmAPngvPGfXV8eso1JItUJ2xBp2SVWpk0Zut3m5VTh
 6Dp8sb3i/wJ+Mrhbt/0l9BKwO1/fj+mjCcE+aEFnG2dHNMVb7N9J5P1pNBffHX5VEkVOjA7yRPf
 QeC07BTfkO8QeFKZb7iyfOfsN5779I7gfdMbPTRuZINuvvXtPoEexiOMUfkVCpc8eE+JB08kVv
X-Received: by 2002:a05:6000:144b:b0:439:ac33:5082 with SMTP id
 ffacd0b85a97d-439da66b72cmr10456241f8f.26.1772898145660; 
 Sat, 07 Mar 2026 07:42:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadac2a7sm12191251f8f.15.2026.03.07.07.42.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:42:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 3/6] hw/i386/pc: Remove pc_compat_4_0[] array
Date: Sat,  7 Mar 2026 16:41:59 +0100
Message-ID: <20260307154202.86309-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307154202.86309-1-philmd@linaro.org>
References: <20260307154202.86309-1-philmd@linaro.org>
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

The pc_compat_4_0[] array was only used by the pc-q35-4.0,
pc-q35-4.0.1 and pc-i440fx-4.0 machines, which got removed.
Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4e1dd436ab7..22325324d09 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -268,9 +268,6 @@ extern const size_t pc_compat_4_2_len;
 extern GlobalProperty pc_compat_4_1[];
 extern const size_t pc_compat_4_1_len;
 
-extern GlobalProperty pc_compat_4_0[];
-extern const size_t pc_compat_4_0_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 93d1a52d712..d8fd63bfe17 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -186,9 +186,6 @@ const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
 GlobalProperty pc_compat_4_1[] = {};
 const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 
-GlobalProperty pc_compat_4_0[] = {};
-const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.52.0


