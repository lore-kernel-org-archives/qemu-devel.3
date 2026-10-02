Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A59CA5FE6
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjl6-0007qd-55; Fri, 02 Oct 2026 16:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkl-0007c0-6p
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:11 -0400
Received: from mail-pj2-x2a.google.com ([2607:f8b0:4864:39::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkj-0005rM-8M
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:10 -0400
Received: by mail-pj2-x2a.google.com with SMTP id
 d9443c01a7336-2e2dd05994cso15353125ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972468; x=1791577268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
 b=fMQ+wvZsDZehH2h9ejK45wu7VvCodeTrD92LiZWSwqCzhr9cMCRRAjFUBZLrLr+YCa
 eqEzh0GzFrPOtHWrQ74BzqDpnJF7I3vghhfd0azggkExbWq8DSHpdzSLVbYTibEXZ0HE
 8ApcKrMT4FM8yog5xXZBvtTXb+mnyfJsfaUUSi1e4VT3kJcMDuEgYK7PdFI+fWMzw1kp
 sY9FfCWRHyF3G4YueC2JvIN3OMhESsBZSiZQA3BD4fwhfo/k3Eils9o8ZIZEFeAAC5xS
 8BlPulicDISbyJNxtNqVYIwi18MJ13WrcWjfUUCIu8qFKSiz1mnQQBXAoi2WDoleSPgm
 Y4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972468; x=1791577268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
 b=UC0bXTsX2Qj/KcqVBpY3n7VPlOh40+++tAVtnDn4uEeU1qCbriMGLoFhkrXp7+4XiJ
 sBUGfUEhMx5c87ofDzPYrRGh1YEQvxAmg0UmjeLkUFBVj6nT7rAGc+xBHfKIz0EVcoAO
 Yz7btCVA17/Txac8xzYt6p5Z71pFLQPC3i6UWW31N4ZQvoFvO3f5uCDLPWDL5wpXib5k
 l4d4LT8KYyKlvoq/IroKW06mqApQxEbieKZHlaV47+MvvfLKSqBCHjTEtYSvl/aGgB6L
 Adwc61hMnTz3LVjTZ6HJ/uGbYHZZkKCdrgL9F9/2bw97EtJvMQpY90CoM/8TSf/Hy14W
 DFAQ==
X-Gm-Message-State: AFq9FYKg87VE82qNLiUTW9pfipb3T/4jg7pETZZw1/3I6DOqpPTZOzke
 W2xKo7cuTHVvt8yHU7g6gMGhPZjazkl/VemyCLWM7H/Wg85F8sGmjtLKQ+oRMFbpPRU=
X-Gm-Gg: AYBFou34iCve5Q4Gi+ls6rtBLRud6c+M/DAjeSo+Irh/mqcyRkugNxYi+TdbrlNFs3L
 dxU6Yn3iGO277O+O66K27JKBUabJFSvyjel9rwH6ocfxI0qMozp2tbxmwKfGigXsnTesA9XDXs7
 kZR6EgLsKA3ZeTJCQe8QPfEmAZN/Zqhpd+zcyGgbqBnXp3ZX3dIb0eNNHu7/hR2e26DOrQH8or8
 KhO+gcV2sztdG9Tdtxv1zE3+qVuoIAXFJLcP8e/dZO+SXfNpKKZp9Z6R0x/ruTkous4OCtA4Tdm
 GDsIdzDnpBLotNswUPW/2zlegVpV/aFaALeD/aIWeZmTV0GmxwBtIal+r3+SHP2RTpHsQiQOLgQ
 Wf/F+i7fxwUiaJEnGYLKjsqfcW16PNdKthqR/jmssc5prckKU6CPPjZ0lIBE5DJOqaxMBKu/SOB
 zSysOlkGw7hLMlYYltLzZsiYyRNGMm+S0a6d5+LW0spg0usKi+vrjQxi5d0zQc5VYgkbV7Guo2I
 pzUnxVxtjra9eZm1rhFwX3QiA==
X-Received: by 2002:a17:903:1a2c:b0:2e5:3451:56f with SMTP id
 d9443c01a7336-2e5345107c4mr705995ad.47.1790972467740; 
 Fri, 02 Oct 2026 13:21:07 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:21:07 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 21/22] hw/arm/boot: Load DTB as is for confidential VMs
Date: Fri,  2 Oct 2026 14:20:25 -0600
Message-ID: <20261002202026.1204110-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Load DTB without modifications when provided.  That way it is possible
for a verification entity to reconstruct the Realm's initial measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e8efada209f..9b3d3558bcbc 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -477,7 +477,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     g_autoptr(MemoryDeviceInfoList) md_list = NULL;
     Error *err = NULL;
 
-    if (binfo->dtb_filename) {
+    if (binfo->dtb_filename && binfo->confidential) {
+        /*
+         * If the user is providing a DTB for a confidential VM, it is already
+         * tailored to this configuration and measured. Load it as is, without
+         * any modification.
+         */
+        return rom_add_file_fixed_as(binfo->dtb_filename, addr, -1, as);
+    } else if (binfo->dtb_filename) {
         char *filename;
         filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
-- 
2.43.0


