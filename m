Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2025BCD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsH-0007px-LQ; Sat, 02 May 2026 13:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsD-0007oG-CZ
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:25 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsB-000733-Jj
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:25 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so2513892a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741882; x=1778346682;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mkPA8V+7C3m5QleVajXQsNNex2rC66SfXPEGWND4dF4=;
 b=ByqQZbR57Uf2ch5bn8oW0IgryKpxWtxxAeCZQGke5zzbLjbEUrqlAY69k56stAR1G1
 0ORE6gt5vRFMo495kg4RusynDIyVtiCbqL0zyRpPY2US3gHNVKIc9RIwPp892rcX0nVu
 AqYZstsc6GaheSnEPlusFocSXszRTsDtPdX7saHbeOwvy9CXIqmo1yWfGusHZ554X/GV
 +7Ib3Hn+PzowIjzGOirw4q5KBhjJqLTwFBGJYpVb2ghl9Pd80zLJbZNWZo14mRkDLjVG
 lBPt/qF5Lldd6aIEY+huap1GKtXRxXvtEg9AKuA8HB/8KSqhmzYyVQ1Lyf9A77QZrBm0
 4Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741882; x=1778346682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mkPA8V+7C3m5QleVajXQsNNex2rC66SfXPEGWND4dF4=;
 b=JxIvYF/xMjX3hakE0FlktFTr2hlY9zDMuzNWwuyTfIKFTf0vkA/U3GjM2MAoIWVoNu
 ocuDfOt1bNUoPVttueIfj/Z081wIT8Z97MKUEfVmW1VNOaDWyiti6/9XXtCqB5igjmiu
 z1tQmkTa0sSIBrJLuR/uvZkbyg8xxPPVzCoC0nur1w1YKtxiuFMbw6li1ne8uVHa3MlM
 1O+HlnGj9mQETl+WWUvRm29+MjM+A5detAQgq3pMXznrjHTT6SF5rV7GO7TpCJBv0N6n
 dK//TS0hMTyHLtew7JcdoEorcnTwCrrPDtEWMQBoW/HfYkusiMTyc6YbCVsmHQbRg+f2
 yFow==
X-Gm-Message-State: AOJu0Yy1PtSlxAWFAFNVd0vYO3bkxp3dswS93dDMoLEN03qooRfBYMP8
 ZXZrUYiR0H95L1N4DHJVZ/NZJSl0qT8F+ypuXdxpj+s7UW5n+vE0i7W3QhMEvX0wfKoWmEzCUix
 L1sson6E=
X-Gm-Gg: AeBDievrtMU3Y8WT16QTdFbs6xpcYuFByEYHJUwVINV/3FmdApgOSl0NeiGZqpzBfAe
 KRRodOAmNE14h+2c8MgSrkfbLtKWTP4AIeRY7Si9XZAr9zOAvv9r7gBqKAsf+cqDd2GQMfwgUwP
 MPgCQ0zmMIuzSqhZN5zF+nna+euZypbfVMr8Prr1IxpnYXdA6WoL87C5hKL/zL2FgcIBod6GWzN
 Eqb1JGU4aftU2Sa/o5XpTr5PWYJ9pYnhi1lJ12C2vKblGdW4oE63O3HNYk70OXi2qDVMAwhYPAW
 RHlEk8SA9mH/YTIMehz9q383c3Vx2HJvFFFGHXgRPcp2PrH8STpAr5D40v6VXAdQFuSuQyyBqS2
 PFJOS72u1Lc8gP7EpoZSX0BDmSwoX01VGjuquvxJjeGsL4o4sHEp62bukpU88gIpkIl0Yzvyvp3
 EPlJgumEDXnhftBPMDDTwqRED+sSVva0o=
X-Received: by 2002:a05:6830:f91:b0:7dc:d0cc:922 with SMTP id
 46e09a7af769-7dee14ca794mr2237472a34.27.1777741882096; 
 Sat, 02 May 2026 10:11:22 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:21 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:26 -0600
Subject: [PATCH v3 05/19] bsd-user: Add FreeBSD cryptodev ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-5-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3374; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=X71S9SaJ1gGgE04Y4eHmNcZhYuOt8YwUIt9DjA6obmk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/Pqdf7A1dnn98fML3D78yMJaH81y9VpLTVR
 TVFb1lbDviJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYvzwAKCRBsHNEofbAR
 ADUzEACqn7Ob1F/PqnNFzqWPGe9wa+3nrYmTwW1Wh+aytJSM6RbJdNuIZ0IodlgztLEfUcWLeIW
 P5EPpsl7pIIw9Sd0taNZsYqX8Mblwy9LR6J+Mg2PnI2SubOQu7cvDUZz/2+ia4ZTuf2WTUE4/Kv
 BoAr/2MJr9FnCol7tITqbegxo+BdR84mhbz5kBxsww45QUwkXNM6WaR03iQMtiEctU2EnGHXlrM
 DBA2SgJa2bcvuhQkDHxniOMw7q/awKu9RrPRjXBkmJF4y0OCe/nS2CKttnEFOdQQgPnIfEDI8Xd
 EcOWUrKDnqk845YeZaMn5wzpnNkuTom07sVDQDrv8FB8hsRpXcG4PHJvBRTpQUfZ8SRS/a88rUV
 BHrip/y5oVz0a2odeMjCgt4KdlWwRjeQG6f0uzYA4QoVlrm3uppJsWb8TNAfagA2Sr+wBouFIWB
 e0oooedVQuKUgeHzbtnPSuhww6zX4fXCqoH8FEwgM0LbI3KCNXq4DkSs9lYTPOsW8OOO+LBRmTn
 EukCuW53vOQL7YMb1m2oNLZo1dr9ORVkULuELUy4dhADF8HP2qIX+BYHFYz37hvhrm9+LwGtCIK
 808FRebfBcgjsDFR2+yxFC0KtkfBOYoF7m8B/5/3goVXYK3ZlvxkBgJcI+szbGI54mnOG+pRp6Y
 zVx6scBJqv/MpOQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: "Stacey D. Son" <sson@freebsd.org>

Add os-ioctl-cryptodev.h with /dev/crypto ioctl definitions including
CIOCGSESSION, CIOCCRYPT, and related cryptographic device control
ioctls.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-cryptodev.h | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-cryptodev.h b/bsd-user/freebsd/os-ioctl-cryptodev.h
new file mode 100644
index 0000000000..b81112150f
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-cryptodev.h
@@ -0,0 +1,84 @@
+/*
+ * FreeBSD cryptodev definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H
+#define BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H
+
+/* see opencrypto/cryptodev.h */
+
+struct target_session_op {
+    u_int32_t       cipher;
+    u_int32_t       mac;
+
+    u_int32_t       keylen;
+    abi_ulong       key;
+    int32_t         mackeylen;
+    abi_ulong       mackey;
+
+     u_int32_t       ses;
+};
+
+
+struct target_session2_op {
+    u_int32_t       cipher;
+    u_int32_t       mac;
+
+    u_int32_t       keylen;
+    abi_ulong       key;
+    int32_t         mackeylen;
+    abi_ulong       mackey;
+
+    u_int32_t       ses;
+    int32_t         crid;
+    abi_int         ivlen;
+    abi_int         maclen;
+    abi_int         pad[2];
+};
+
+struct target_crypt_op {
+    uint32_t        ses;
+    uint16_t        op;             /* i.e. COP_ENCRYPT */
+#define TARGET_COP_ENCRYPT     1
+#define TARGET_COP_DECRYPT     2
+    uint16_t        flags;
+#define TARGET_COP_F_CIPHER_FIRST      0x0001  /* Cipher before MAC. */
+#define TARGET_COP_F_BATCH             0x0008  /* Batch op if possible */
+    abi_uint        len;
+    abi_ulong       src;            /* become iov[] inside kernel */
+    abi_ulong       dst;
+    abi_ulong       mac;            /* must be big enough for chosen MAC */
+    abi_ulong       iv;
+};
+
+/* op and flags the same as crypt_op */
+struct target_crypt_aead {
+    uint32_t        ses;
+    uint16_t        op;             /* i.e. COP_ENCRYPT */
+    uint16_t        flags;
+    abi_uint        len;
+    abi_uint        aadlen;
+    abi_uint        ivlen;
+    abi_ulong       src;           /* become iov[] inside kernel */
+    abi_ulong       dst;
+    abi_ulong       aad;           /* additional authenticated data */
+    abi_ulong       tag;           /* must fit for chosen TAG length */
+    abi_ulong       iv;
+};
+
+struct target_crypt_find_op {
+    abi_int         crid;
+    char            name[32];
+};
+
+#define TARGET_CIOCGSESSION     TARGET_IOWR('c', 101, struct target_session_op)
+#define TARGET_CIOCFSESSION     TARGET_IOW('c', 102, u_int32_t)
+#define TARGET_CIOCCRYPT        TARGET_IOWR('c', 103, struct target_crypt_op)
+#define TARGET_CIOCGSESSION2    TARGET_IOWR('c', 106, struct target_session2_op)
+#define TARGET_CIOCFINDDEV      TARGET_IOWR('c', 108, struct target_crypt_find_op)
+#define TARGET_CIOCCRYPTAEAD    TARGET_IOWR('c', 109, struct target_crypt_aead)
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H */

-- 
2.52.0


