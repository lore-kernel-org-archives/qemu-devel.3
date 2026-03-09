Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552B8F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcx9-0000WS-4S; Mon, 09 Mar 2026 11:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwk-0008I1-EW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwi-0000WF-Cp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so21311445e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071703; x=1773676503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VCt2tniDnmnYi733EQKIyxEHA7/z296v1/90TDxGuK0=;
 b=sjn9hX9Wo3MitLl2YzrPWybZhVcH0DPjpJndEOv4UW7YfbpWdq9rbW/JlUPPfh0iL4
 ScIrDeFejte+xt45AWIqigyNPGERK6Igg7xmgXn3zVVqixPUK3y8aMTr6we6T1aEw8V6
 hM+FCLu+NvE8YzfXAD8AwzjlV+6X7R1Jc6G13fmFAeP0+COqtmzM7pJaB7sF9QTBZk2x
 xE34McA36cvDLvHcuIqUVhCRIzX5xV12P+sW/nWeCe+6uEplLYUKq6f4QrYDzhmXX6F+
 Vpxp2oHwEk4USx33pYkLG8cyULJ/r4kfjfsP85HYGnr1yOa5i0jpTu2Vt5BFjb0AybqE
 5u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071703; x=1773676503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VCt2tniDnmnYi733EQKIyxEHA7/z296v1/90TDxGuK0=;
 b=E34SWhohT2P0DrTDHL3WyK5KAAH6N0iK9Cw2V8Prz4pifUw+7TQ82tU+UhRNE3WlRD
 FN0PmCDHHrLumKROuSLp1QEGlqRprNWApOZM2DrVW7h7YOV8Zv9xLa1FV3xRkVDq4TIj
 Uy06clSl+hO1APD62kZ6isIp/+/bn09E3pWBKyibglvj42S1LAXTs4mItqpKAuoD6uSA
 aNpOpspAIgSmPx7VmAhOX5n6BZ6copfRLFe4GxinXyN5JglfwyIxpwLdlS3CTQFxxci/
 WDjdDaEGPnRZAy/LOYVK0kuBhga20FAxf1y7viQ6vv9QNxhMvU643if6jzKIvxGEC3wd
 zSyA==
X-Gm-Message-State: AOJu0YxWnEpZNM1BuYeGGx5idH341DPEMWzq0rA8KUxbKA/CT9Kf6NAa
 TDHa59CzXVFdj3X2ktGS4vYTpOMLEJz26k8h9cF5gEBlwftN7Rz9FcsvIkuGNJhnuSSTFkoRq1i
 MShNjIRQ=
X-Gm-Gg: ATEYQzzigLxLIOq1E0APjJ2Nn6xgjHd8iaKI2AzapgTVI26x/ounp75NOqUEtuc9CPF
 FcV60wgT5+thSVooOEww3i2c+aHcAzWSvywkvoNi4KfLqxWIQFanmfi3fJvC5YgLun5/Lmg6wTv
 n6VjVNTVA+216Qqavar/wczg7BKojpiBEbN50llu+josR4SLI7Zb1+so3LlRVkeNlJLQhCPygIx
 jI6fpWP9YdG/WCH0s7p2GNSNl/yvltte0TqLwxvInfi+JK2FaSY7GbYocemci+Z9xzdCr7Rth0S
 dBkbt0ZKwVSTcCZ8ue2Qed4KtOGmiD1RX7cV3vy9YRPxJeT4+hHLg+6wzcXn/uLfaMzsd9aVFIB
 3GdxZCjBJh62BYQ9XJwFJv9+WaJXOysiMrDlpFCDDyAgV4/h27O754re50bPFAdMxjuVgUrF+G0
 r4IdNIqp4Y+20xgg0vX4c1BH5YLd8YGOz2ekpaIuSZMulUhb/Tc/74cpHm9aMjb4xh2HclNXqJ
X-Received: by 2002:a05:600c:4510:b0:485:3c8f:e4ce with SMTP id
 5b1f17b1804b1-4853c8fe68amr47206855e9.18.1773071702437; 
 Mon, 09 Mar 2026 08:55:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d840sm30519981f8f.8.2026.03.09.08.55.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/49] contrib/elf2dmp: Grow PDB URL buffer
Date: Mon,  9 Mar 2026 16:51:54 +0100
Message-ID: <20260309155219.62400-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The buffers used to construct a PDB URL overflow when the "age" property
is greater than 0xf, so grow it. This also simplifies the logic of the
URL construction to use one buffer instead of two to avoid the chore to
synchronize the sizes of two buffers.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260305-nvme-v4-1-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/elf2dmp/main.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index d046a72ae67..a62abadcc04 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -494,18 +494,6 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
     return !strcmp(pdb_name, PDB_NAME);
 }
 
-static void pe_get_pdb_symstore_hash(OMFSignatureRSDS *rsds, char *hash)
-{
-    sprintf(hash, "%.08x%.04x%.04x%.02x%.02x", rsds->guid.a, rsds->guid.b,
-            rsds->guid.c, rsds->guid.d[0], rsds->guid.d[1]);
-    hash += 20;
-    for (unsigned int i = 0; i < 6; i++, hash += 2) {
-        sprintf(hash, "%.02x", rsds->guid.e[i]);
-    }
-
-    sprintf(hash, "%.01x", rsds->age);
-}
-
 int main(int argc, char *argv[])
 {
     int err = 1;
@@ -517,9 +505,7 @@ int main(int argc, char *argv[])
     uint64_t KernBase;
     void *nt_start_addr = NULL;
     WinDumpHeader64 header;
-    char pdb_hash[34];
-    char pdb_url[] = SYM_URL_BASE PDB_NAME
-        "/0123456789ABCDEF0123456789ABCDEFx/" PDB_NAME;
+    g_autofree char *pdb_url = NULL;
     struct pdb_reader pdb;
     uint64_t KdDebuggerDataBlock;
     KDDEBUGGER_DATA64 *kdbg;
@@ -583,9 +569,21 @@ int main(int argc, char *argv[])
     printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
             (char *)nt_start_addr);
 
-    pe_get_pdb_symstore_hash(&rsds, pdb_hash);
+    pdb_url = g_strdup_printf("%s"
+                              "%.08x%.04x%.04x"
+                              "%.02x%.02x"
+                              "%.02x%.02x"
+                              "%.02x%.02x"
+                              "%.02x%.02x%.01x"
+                              "%s",
+                              SYM_URL_BASE PDB_NAME "/",
+                              rsds.guid.a, rsds.guid.b, rsds.guid.c,
+                              rsds.guid.d[0], rsds.guid.d[1],
+                              rsds.guid.e[0], rsds.guid.e[1],
+                              rsds.guid.e[2], rsds.guid.e[3],
+                              rsds.guid.e[4], rsds.guid.e[5], rsds.age,
+                              "/" PDB_NAME);
 
-    sprintf(pdb_url, "%s%s/%s/%s", SYM_URL_BASE, PDB_NAME, pdb_hash, PDB_NAME);
     printf("PDB URL is %s\n", pdb_url);
 
     if (!download_url(PDB_NAME, pdb_url)) {
-- 
2.53.0


