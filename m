Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5740CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc8Sh-0000tP-2F; Tue, 23 Jun 2026 17:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wc8ET-0007XT-8b
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 17:00:33 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wc8EQ-0008KG-Uk
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 17:00:32 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-13809223fd4so351944c88.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782248428; x=1782853228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4uoKg1YrhAkoCgheeLUr7IpZw82pHFuO8rnAG0gDnQ8=;
 b=eCdJFoz1VX5SHeQ2lyd0znQC4jOyTWHF/Qpi0EnrdzV6JZKTF36G/lDERt9euxrCvu
 vq8ERMw77QLZnrAcJHt6jWyREdUUmIx4shaFVva00kKE2sdGbDiFDL1XgLWcom0CwGwF
 RzS8cbQs7mb72D5GUeQANKwy+9G3CKD0kh4cFUCKQJHUES9JdTLnCeU0XomdqSdt4Pq5
 UYv6zG9IN0xtqKtTRhZJIOzrZ85+UEedyhar07vBrBkZWwX0fW33G7jjUzmKD2NCzvza
 gnL3jdn5IbvxZWXlfl13tlLb0M/jJyxMxwvTRFaOo6KIG3mEWaTv1epC9h1PhishcrD+
 MFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782248428; x=1782853228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uoKg1YrhAkoCgheeLUr7IpZw82pHFuO8rnAG0gDnQ8=;
 b=Uqi8eZ5IzXSCAdG+UQ4G1MSYTr7s6vFFONRcelPiklAuRwF30hDDK81GyK2hPPzB5M
 WkI33fM9t75tmoni59PfpaWUnT+U0zHYPa+jBKDjOX+KvgSXze/ztlNY5O2gsrLJPLtd
 Fh60gtAe0Ylx70tB3h/t4q+Cf/zwOeR/5MbkiT+yNKFVS8L74K0vAvR6utN1zUyANtvk
 CWTp+0KXmbhNZH7F3YNFPPrIkqKhj/LA9QdOyXvP+fOq2F/h+zRumqifLCPlrb00jGmg
 ajLwEnNLIbxGj7Og8HMQ5ITsuNKqvXRyZXKaVCd9cFMooT6NtCTvDY6Ip/g/XoHa+iEJ
 R9uA==
X-Gm-Message-State: AOJu0YwBdKK01EqrHJ3BpdGUpXkBhHx4MOSm3ZP5X9ZYYlHUXco16dTR
 iQnx49VDcs9zXLTHsmeMJI6KtNjBA8ilRy6krbiGWncHPECf/FDZlix/p8t7p41/
X-Gm-Gg: AfdE7clQIOFaNyY4DsulZds+4rjxnia196hK0Zdc6jytJUqVc6tFHoaRBgGhKCUz5iV
 KrjJxp6mwq+KPeOGLRsGp61ubBDbGiuNl457SoRecihhoeQUh4COIW4j/Cu2lepLtTglpOW47CZ
 cK6aR7L4Sp7PShfR05VEKNhBSWH1jW4nnhb9Iuqrp63Nfsj2yAIxcC6iohDP6njcDV0RBKiaIpi
 E4Lmyet5yBMtr9M8XzNpSQr0278XcFtTrdQsXNFLleHeQiSYogTGmGxFWm4cTaRyglNsljApJ+/
 8bi9da56Io1ePHK/XDu/UHc1At67MXGquTT76lX1xGIJADR+ujEsNXdE0tFbzBhmokOsOpBbsSe
 ivlu3Jm45rCPkGUs8qeRd2QHppXIV/O4Dqv+9fLgMU5QLT5TgU2q8Pj7z24A9tveTOPsq9IOutn
 pro9/vAyE4KartAz0rLtE8MxbCnekDk+Jg0l4/LKI9UPiPxWfmvoSS
X-Received: by 2002:a05:7022:f687:b0:138:177c:b971 with SMTP id
 a92af1059eb24-139d0c97996mr329950c88.29.1782248427753; 
 Tue, 23 Jun 2026 14:00:27 -0700 (PDT)
Received: from localhost.localdomain ([103.171.172.220])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcb7a94sm15044035c88.4.2026.06.23.14.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 14:00:27 -0700 (PDT)
From: Linisha <linisha232@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 mjt@tls.msk.ru, philmd@mailo.com, Linisha <linisha232@gmail.com>
Subject: [PATCH] docs/system: clarify pflash0 and pflash1 are virt-only options
Date: Wed, 24 Jun 2026 02:28:39 +0530
Message-ID: <20260623205839.1294-1-linisha232@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=linisha232@gmail.com; helo=mail-dl1-x122a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Jun 2026 17:15:13 -0400
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

The pflash0 and pflash1 machine options shown in the Aarch64 virt example are only available for virt machine types on Arm, RISC-V, and LoongArch architectures. Add a note to clarify this for users who may try these options on x86 machines and be confused when they are not available.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3254
Signed-off-by: Linisha <linisha232@gmail.com>
---
 docs/system/introduction.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index bec7291e47..0c400aefb6 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -158,6 +158,12 @@ virtualisation so we can use KVM inside the emulated guest. As the
 ``virt`` machine comes with some built in pflash devices we give them
 names so we can override the defaults later.
 
+.. note::
+   The ``pflash0`` and ``pflash1`` machine options are specific to the
+   ``virt`` machine type on Arm, RISC-V, and LoongArch architectures.
+   They are not available on x86 machines, which use ``-bios`` or
+   ``-pflash`` for firmware instead.
+
 .. code::
 
  $ qemu-system-aarch64 \
-- 
2.47.0.windows.1


