Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73342CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULH5-0000uV-2m; Tue, 02 Jun 2026 05:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULH0-0000iw-5O
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:58 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGv-0007p1-8x
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:54 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-304e83724bfso5376285eec.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780391931; x=1780996731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rf1sbRZ5RIrg3eme622ykejQTQoAbCXsWDkVCjzGz90=;
 b=YQ75bAo8ljZsasWKf5kqG/m7mWI5pH8gHGE0EAjUSjPk7ZFXmAtZkvGO2oNY5NERwW
 Q3WuLXPUAIUDjrq4CmZMMYihCGJIMWvjjQA/li7pk270vxexUl+PJBb0KdGdNNiFx9X0
 k6Ffmx36Mw92v+vA9uemz+dfNG0pLxFVyzR67p7fdZyagAXi6o1LeMin2g+ne14pPJwY
 9WK5iSrbiRJLfZNhTLDFckCh1+MjYbHP2KFrT7Bo2FTNYqg7LdEGDjG/bDtpZ118o85P
 rWb0YtwWGBmPS0xK+EXs4ReKaPw9hBcXc+bUuUUx8ViFtU3AXAFgEY5mwShHFjvnG08A
 5G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391931; x=1780996731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rf1sbRZ5RIrg3eme622ykejQTQoAbCXsWDkVCjzGz90=;
 b=S4ZpiIXOOFWaeja/0NRD9kHYrBrr51tFTHuVzoSD/t2L9Uf0/ZTO6nIUZzlotDMhas
 ILgJqjwCHN0HtA6yZ+tvIR3u6SS0BU3mZUY/x1rzY+LM+5BIa1ruBZD6FaM9z8ROcFFm
 1mh6xgqlg+hgjeexnKtEP1kwlA+KAka2smSvDyps18wvpDPGJWhY1p5wAU3ApIdBbZr2
 mQAEYa6LHYvf/oB+88DxeEAm/8YXJBTLBTgQfMtShn5r2h/R9DrHyuNkKm0MhOW8uQHb
 kRNP+v5tmN3FOktIjoeca/mHTgh/MSf2f4/lU+cpvf/Tnf26laXF1jTf9qiOpQwxIL/T
 vXbA==
X-Gm-Message-State: AOJu0YynWq2e6pDbGr6U+UGq4EG26sLlNZFy+yOeXhN8KTMwzSHXcq73
 z0u8K8ZcysKa1vFr2jTtDP0BluwNfHs8xU5PbCtZm2C0R29UNc+9qoZK2wzuZi5HEMuYLA==
X-Gm-Gg: Acq92OESTUqPPGdo0zv4q87C1if1c6+bK79GwQ6pWryXrSnikR1Be7avAli43BPS2sn
 usErC93VwUT9moesNFHSMvh7pMpCZSldsntEs9rZQ/zfhmREe3QFhIiAs0bNe17WVzzILllyyLJ
 TqwIX2OzguNBOUygPf2QGD81xYPy42/hCP92JInNUhqH4rBR9BNmxbtIFeeN2dLe8ATWsNz4WtT
 RXbE0bVX0yMd+NVBB41p7OJKNO84eVrkHa9RvShLXMlEg90s/XrPfI/+nSlDn9MDlBaOZ7uW+TF
 hTc+X8UWTN+rgmflAzD/zyvRWVmP5k42RNAoY9YjoKucTq3vdou/ivsG/2av0M2Xabi52S2nTc7
 rzNlByiKdVOWsqcR2mXmYz7S2zwwX5k5PoJKLM0aSPfq57vEScqY0JjgOB7dLVo2vr06JvGcQd2
 E35oTl7DumaURSuP1U/NMo9PpmPet/SdnzkpPGex4DT0VZStT/HvUeuXS6qLXoFAIBn0hHT54LX
 piRSLI80zZiksT4FbhgswiBwpY=
X-Received: by 2002:a05:7300:6427:b0:304:cefc:5fd7 with SMTP id
 5a478bee46e88-304fa6dbc01mr6528709eec.32.1780391931499; 
 Tue, 02 Jun 2026 02:18:51 -0700 (PDT)
Received: from openkylin..
 (ec2-54-176-108-193.us-west-1.compute.amazonaws.com. [54.176.108.193])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c3121sm11419146eec.5.2026.06.02.02.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:18:51 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 alex.bennee@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@linaro.org, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v3 6/6] gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job
Date: Tue,  2 Jun 2026 17:17:53 +0800
Message-ID: <20260602091753.3209261-7-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
References: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add CI coverage for a riscv64 --disable-tcg cross build. This ensures that
RISC-V no-TCG/KVM-only builds keep working and prevents TCG-only code from
being accidentally pulled into common RISC-V sources again.

The cross_accel_build_job template enables KVM by default via
--enable-${ACCEL:-kvm}, so the extra options only need to disable TCG.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index eaeeb533ce..a823aaaa21 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -59,6 +59,14 @@ cross-riscv64-user:
   variables:
     IMAGE: debian-riscv64-cross
 
+cross-riscv64-kvm-only:
+  extends: .cross_accel_build_job
+  needs:
+    - job: riscv64-debian-cross-container
+  variables:
+    IMAGE: debian-riscv64-cross
+    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
+
 cross-s390x-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


