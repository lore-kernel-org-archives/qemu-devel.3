Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98E2CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5V-0003q7-JL; Tue, 16 Sep 2025 14:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4s-00039w-7v
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4g-0001d1-Go
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46130fc5326so1145495e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045998; x=1758650798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MRFSvzFCChYzJp3NpcD51YiWf88/DwCTl/TXq4h9hsM=;
 b=hLV422k2kanQ1YWc0ioCmjZhBK2tK+Z5b4WOkWwb+2NbR1djer8Xn+1ECHzcjiZPED
 HMB678jTn8u7WWdyQJDFhDdARloToLD24mSauOqx7D8ZFLXBzv+V7BC0bnKlGGIAorfH
 q9eCNtEPR9OVmBRJoIiZNOf05N6i4+wII5alLCBTXthVkClIUcIZnfcRnWr0iXPljn2P
 6Y6Id1sJt1G87yBCGGT7cxR/MB+ByC5/U1UzxCnCVN5d53ooXTdcJu37ppVNiXDPRdnE
 tbaF18WcIENx9x9EHF39q//p2sxSpLYBh9BWzDiZX8nSOr945UA1U1GE8rrg8M8xA4od
 JRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045998; x=1758650798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRFSvzFCChYzJp3NpcD51YiWf88/DwCTl/TXq4h9hsM=;
 b=sRxeS+Z1EtyINIQKlz7jhw7eMFuWGIcB7vzm9lghu4CR5wPuhzHmj3YqwtxdDAfk+z
 4dA5YAiCtrKv+DwzpxGTlS/gTNUiN+P7TNIU5hhAwrRZ2C2RMvXsu6DL9vPLcjZS0HSY
 Eya3pf5KtewIc+wV4FPsf7zMFoQZh0cIjDAOK3lgFwxwdDnO9fCP3gmGg4NLK/XkJBbk
 C1TJMKudBde1XRHWjWrK0/ypsl9JIEljBsBpZkNVPY9r41wRLHzmvUmvqJs5i5l1VtgO
 yLF5PnORL41LqWk4kIniLXF3yKYNkseKxgjXjS+sA4K84v8X8RHis5Nr7J8mJ24oKWQq
 CyYw==
X-Gm-Message-State: AOJu0Yzf1AZTYkwZb0HE8kzfyJqQCfjct3s2XRWm4/yDv9lcanNFyt4P
 OAuP3we0OBwBr6/SpSErgLVr+h3JQzljSSgbDRmWi5SZsHwSRpaxJPX8/85jpKpeiyWswjUpEA+
 x7tro
X-Gm-Gg: ASbGnctPZJrSkEuF9xZURM+O7SagQOLv5EDXzCfedACZ+/p1tBWoSIY/xxcWKy4EIp6
 YZHOnLrjixP7na0EuFIUC5Ciy6zLisAoLLREn19WqbdHzBGWU37yslnOWTis2OaK33ABQxtUibQ
 IKTC4ZoqYYtJrOFOAtozR1S7owyXGIWtNJy5K+n4c5WyTMx6A01KX7J2K+9wdnLTwjjjjtVCwlr
 rPCRMogb/CtAz7f42nooutZmokzqP8VLe50nVmN1dqRcxZIY93mChsnPZEqGNRn8oyGJLrHA413
 bIDQ+9GER1IU0Dv/kMwn+ISCitQuTbuX6HLU6LTLuHWDk9ygzzbAeapFngGbmQoIKNmUdZHzP05
 xCd7Sgvw+FLCfNajYEetvmFJckh40
X-Google-Smtp-Source: AGHT+IFvuNkxlE3S11PG4LBPLfMGBCKSJ08y7vOWVR/+Y3rZ45tcOf1kXiE4Btish2XwEgk7zJjmqg==
X-Received: by 2002:a5d:5d0a:0:b0:3e5:50:e070 with SMTP id
 ffacd0b85a97d-3e765a19cbbmr14632391f8f.50.1758045998114; 
 Tue, 16 Sep 2025 11:06:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/36] target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote
 gdb debugging
Date: Tue, 16 Sep 2025 19:05:56 +0100
Message-ID: <20250916180611.1481266-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>

This patch increases the value of the MAX_PACKET_LEGNTH to
131104 from 4096 to allow the GDBState.line_buf to be large enough
to accommodate the full contents of the SME ZA storage when the
vector length is maximal. This is in preparation for a related
patch that allows SME register visibility through remote GDB
debugging.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250909161012.2561593-2-vacha.bhavsar@oss.qualcomm.com
[PMM: fixed up comment formatting]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub/internals.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index bf5a5c63029..92466b28c18 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -11,7 +11,27 @@
 
 #include "exec/cpu-common.h"
 
-#define MAX_PACKET_LENGTH 4096
+/*
+ * Most "large" transfers (e.g. memory reads, feature XML
+ * transfer) have mechanisms in the gdb protocol for splitting
+ * them. However, register values in particular cannot currently
+ * be split. This packet size must therefore be at least big enough
+ * for the worst-case register size. Currently that is Arm SME
+ * ZA storage with a 256x256 byte value. We also must account
+ * for the conversion from raw data to hex in gdb_memtohex(),
+ * which writes 2 * size bytes, and for other protocol overhead
+ * including command, register number and checksum which add
+ * another 4 bytes of overhead. However, to be consistent with
+ * the changes made in gdbserver to address this same requirement,
+ * we add a total of 32 bytes to account for protocol overhead
+ * (unclear why specifically 32 bytes), bringing the value of
+ * MAX_PACKET_LENGTH to 2 * 256 * 256 + 32 = 131104.
+ *
+ * The commit making this change for gdbserver can be found here:
+ * https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=
+ * b816042e88583f280ad186ff124ab84d31fb592b
+ */
+#define MAX_PACKET_LENGTH 131104
 
 /*
  * Shared structures and definitions
-- 
2.43.0


