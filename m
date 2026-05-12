Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079D6CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgVt-0000gX-DH; Tue, 12 May 2026 02:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVO-0000eI-Su
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVM-00045N-Qe
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:10 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so3185992f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566926; x=1779171726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HuuYKa/kjUo7WM3wtJMj9mulhPP2Z1kO/T6hVsMPENA=;
 b=OJdo/fuE2uVmLgAKXZSiH+OkLEBOt5ztIsGN08iUC/Ea7mumHdmWGoYxc9XLJS0tZ0
 VN9g6OTU0rrL5fuuWI2qdxJJW1iz5vYe2UwpRsNSQ1W0nQPdurHmrdL+KXV/nQ6cZ4yA
 iMD9biDcmdwj0tmmcqTPxh8g5TUlzdsmZXVIaB8k1z+SKIBRrGJpTAH9S+z893cmcyD1
 DNXfx/qNhuXKaJO0FYEEaNJnVlQEkrIDnE/P0+Z3ttkuxSfBPUL0Ksvb3Prd23fwKrMb
 qIJ8QAgIF7nslEfKwMd9Rz8Dgzh3gNhjrCWfFNZ5VPzcphWA0HMhNypUej8iVZ2s8QyQ
 hsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566926; x=1779171726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HuuYKa/kjUo7WM3wtJMj9mulhPP2Z1kO/T6hVsMPENA=;
 b=tSyJqrupWCrQC8JZQ+ftN0i3yFLG4mNl3MTAtRdOL4XqLwylraf71nauONI28w8Vr7
 VaaWHX2GbpnDw4faZXPVln+ghqKfsw+MLQJEcoROOAifiurSBS9tZicji6JHuqqLP84l
 WTEsj/5osDAjSV3r8uPrBUddrRFGZLL5i/9+Alh41Mo8Ms/yds4RbSDSGpArMHcQW2Mf
 Mj+ncY9u+0qaSSvRIT/zTcDzjutNtGVypivcoyXOPrnVUcfRjJzCP8WTTtTeDbgFYKmm
 ls1b4RfPhiq82SHnHV0pKatI3KMuGcQNOzK88wUux8jIW7lSVPXFPmCXFRvrE9HYLJA8
 zirQ==
X-Gm-Message-State: AOJu0YwVhq4dYgAHuohMSWwjsZHfBMQM3a7MIXnJVomiu5sZ1cTdk1+n
 vKaG4LRrUuummUgngA9K3dzb4dE1MMxk5Ae/pcQaBVwaTATt/qahbk+tyfBLY+PbVaIvbxPqCal
 Y3IHdb5Q=
X-Gm-Gg: Acq92OFBnUuN1iuziptSHZo8ABIXHVkKDalUR9gb7RB83o+zZ0YOR4QLDh61bkoNVu2
 wRc5sbCg7zt7rsndY576dBd2btoljcp/G1WUc893D2elDwM43OM6GvHvnYPsJ4j+Z08jrAOwdsV
 znfj+UCu4FCmWALEILVgwVjVTeYRx+OtyjlbBEqfZWRejcP//2niRxgOzmpWXpWpCbWmwPQqKMT
 4SAMhgd7Y7FWG0Z8cSQbTM0j7uVMBYylimZu7cXJgVUJHbISy4Jt5/nxQFOdNhQEJhnNbcOU6RR
 UmgrMYG0fcqHyryC15ru5AtqL6pJbRpcpaNV6QJ4yqWvXsSMUw5ZfKvEHj5XYnDgu7maK4L497J
 fBaXhD5fd+pOua3JlVK5RF5+V86rEiwJiFPeOJDcDdli/ANsg1lddqRK0mQToU0YbDoHbX6q5IF
 sE2cpAvcPwOAN0aaod4y2ON/Io/GT6cqhHnrzS3ErLI9gJhEwYrxaBG70+sWMcDIU/obXGf8OZ
X-Received: by 2002:a05:6000:3103:b0:44f:da83:2030 with SMTP id
 ffacd0b85a97d-45463d88e5dmr24896701f8f.41.1778566926189; 
 Mon, 11 May 2026 23:22:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6aea4sm35355504f8f.10.2026.05.11.23.22.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:22:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/41] scripts: mkemmc.sh: Fix output pollution on missing
 images
Date: Tue, 12 May 2026 08:21:04 +0200
Message-ID: <20260512062142.67998-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Reorder the redirections so that the 2>/dev/null can actually take
effect.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>
Message-ID: <b9d603b7396719f38e03cd969a4ac1b48f5ea96a.1776231967.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/mkemmc.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
index 429388213c6..3d8546cdaa6 100755
--- a/scripts/mkemmc.sh
+++ b/scripts/mkemmc.sh
@@ -40,7 +40,7 @@ process_size() {
     alignment=$3
     image_arg=$4
     if [ "${image_arg#*:}" = "$image_arg"  ]; then
-        if ! size=$(wc -c < "$image_file" 2>/dev/null); then
+        if ! size=$(wc -c 2>/dev/null < "$image_file"); then
             echo "Missing $name image '$image_file'." >&2
             exit 1
         fi
@@ -102,7 +102,7 @@ check_truncation() {
     if [ "$image_file" = "/dev/zero" ]; then
         return
     fi
-    if ! actual_size=$(wc -c < "$image_file" 2>/dev/null); then
+    if ! actual_size=$(wc -c 2>/dev/null < "$image_file"); then
         echo "Missing image '$image_file'." >&2
         exit 1
     fi
-- 
2.53.0


