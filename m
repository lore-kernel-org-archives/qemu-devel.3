Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACDCF3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbL-0000xQ-No; Tue, 24 Feb 2026 09:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutaj-0000HV-Vh
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:50 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutai-0001H0-G2
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:49 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4be7c4ebeso3471997a34.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944047; x=1772548847;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0R9osrusvMqOtfeu461Tq5czaq6FMTAxple3ghg+3rU=;
 b=Ew8byGq3LneNjlAXdJKzzO4hgDb5vPYIM3H/5/l0dQJFtfnmdspUaRh1SruHHuG/zz
 mH/mOIk2EvFBPKUYO3jo96bAxr64Vb0a20n+HQkfiQbNuuTo1qGGuaHvEmXB4FPdifUe
 0SkEhTsfSMyO66Hc5LKc/0s0K+mW5XoTXthcZiNEXVNDAVrKl8pKVG6IVfAcnMvqXRWA
 CmjLNe3IS7rKW5V+UeLkwCjpv+XqR6wtIShmit+WorIM6APEvISdso2c2cwgK9vyA3N4
 VIhZa0bWkqt0e32YBl2uW1jyRnQwensOgGYcTC07ZVolvgr2dUbEyFoz/0o0HPi3bLW/
 KULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944047; x=1772548847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0R9osrusvMqOtfeu461Tq5czaq6FMTAxple3ghg+3rU=;
 b=coJEZRBw3uzOIS41XYab7gZ4SFen5VmI/IXEKy50YmN0cV90n2NmijaT4C8P4AxE9I
 DjcGFMR2rnZTMk5e2A/4ojX89p+RwqQDyenesEgGjU0FVpOhQ8PaWOz+uNSGHOMmtCGv
 FPgqAHl5KWIN6blMgQgOzBeq2FfwvKJusiiqeFQWCy/7Vj3r8EU+Y406pXWA+vwzoMS8
 93wwKWIKcwEGjN2nSXwcHgx8Ux7GTQYzv3e9iR1iXxiafIAHvLxPJ+EaizG6txat+y5u
 VXUlnP/PosU9TN4R7kbcUR+yUPUJkyBnKxNVwZZE0H8u9hqRb+jesBTkJ2Sm2lpvfaC7
 Ba2g==
X-Gm-Message-State: AOJu0Ywj6SwRCdT8COnp8O82PLKy5PqnAFiEq8CYlecktYpMR2MeluEv
 OTchGfvl9FspkChZf3YjWcfghCT1yWxiN/YgIxNo9kQG8eueDHYd289ul3IH/6upsbn3JY1CSkJ
 dsUwULbQ=
X-Gm-Gg: AZuq6aIDu+7UVQPYD1I23VLI9E50Pg0odNcjyQkkFMMWtRAWwl3DpVZwSXX8zn/xGHi
 GUZrdxtLKaotOmlJ44DRVTsDDrCcYdqckcZwC2wP64xB/vmkzoeHgWS24EMPzNcyRynmykK2fTv
 2GVdSR6J1SzVsFBBcXbmzoaRRByaUdOEvGz68HUyLvBs2bLaRRCNk2tsPvuDXaksO32ZH0kTO1F
 iFYBbmitAgB9hruEYOe6B6rrhpsdEFjAtfDWcGy/fyGhJqO+KVUAJPYrTb7HUnblzp6HevfvvWU
 l+PwqRDhtB7gxTdnIVL5C70MD5MUoWVNxJj0N91NegNsdxkx/DOuzIxKs2qMCzjpzUkWfGF2l9i
 cWvRLbRrcnbq7gTx0CV/FETsf+71T54Jz3HZk4LnSDK5OWHoJ5waxLrIEipqjiSy+mXuBDn98IS
 EkNTV86YupSQ==
X-Received: by 2002:a05:6830:25d0:b0:7c7:61e0:a4ee with SMTP id
 46e09a7af769-7d52be3dbefmr9611930a34.11.1771944047174; 
 Tue, 24 Feb 2026 06:40:47 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:46 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:28 -0700
Subject: [PATCH v4 04/24] bsd-user: Add target_uuid structure for uuidgen
 syscall
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-4-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=7q8w7XEaRecIKFdkMtineBuFnLZB0KTZoHDJ/HelWDA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhm6EbdtARqqKstb4Luc/pGJnlP0sMNbNTxS
 X3aUfNYOnqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZgAKCRBsHNEofbAR
 AEknEADHYbOg25/Cpj9E8MCuFhjpSOtUIVQzyJ40aAESd1nAs1DdnGLhko54dhomHImu3KXqiM4
 mruONG+1VLDpgzcD3V6xBaH+Hrk/b0vtpHJjugeVguP6CcwNh5BF8gTtH+e9p7kgtG04iPPXDWS
 u5dMbl29Kp4du8J/BDLC/SoObdmzraEGpLp7c53RTexBD1nfua3mC8ioceWPTTDMHJKSoqBINGD
 AfuY8i5r7d9dATevAb6XV9YB/Q/MbsJ9TbYNXvs9nGxjrHyJT0XjNUeOgW4VnmN72S0r+zGYoYw
 kiuTB+zDnjVb3H5PrLJAxZ4dY0X3ktrUq44sLbfwZfldqjZGYCHrXQ2slmjvnUpAUOZGlInEFXR
 kR5tdwSYTkRjNTQyxdEHicKXW4B3aGpXjL1Yk3UBzjnnNimZFD+DKVJlTv+qVV/LSg2jKwOzj5j
 pHALKVKjhxFkZ91hFpsE/oKvli2NxUG+eGTxLKFLe8McfzX4YHQKVG29pTmS6GmxD4Uwsho5kab
 QfTq8Xd4pAMbNpgeMRXDHG+f6y9jZ1COwaDkWWRqPUvL3+encZsS33Sr1g8VBiG+UJo/vmT077W
 6JhdTrht9Srcr18j+vWEvtnhkXNmTKpA9ru393fT5W8IYwfdBL7sTVv0WaydFyd9ltAjiOS9c9g
 vhVTiPf5BBq6AUg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

Add the target ABI definition for struct uuid, needed for uuidgen(2)
syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 92fec12acd..972bcc425e 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -503,6 +503,20 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
+/*
+ * sys/uuid.h
+ */
+#define TARGET_UUID_NODE_LEN    6
+
+struct target_uuid {
+    uint32_t    time_low;
+    uint16_t    time_mid;
+    uint16_t    time_hi_and_version;
+    uint8_t     clock_seq_hi_and_reserved;
+    uint8_t     clock_seq_low;
+    uint8_t     node[TARGET_UUID_NODE_LEN];
+};
+
 
 #define safe_syscall0(type, name) \
 type safe_##name(void) \

-- 
2.52.0


