Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nzfGdFj0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA4K-0004xz-N6; Wed, 28 Oct 2026 16:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4I-0004wa-Ry
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:18 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4H-0002Cd-AM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:18 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3535a54bed9so2028564eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218576; x=1793823376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cWoyICeXIEDcF+ntNhHWZ5R9npUPu6GPUvFCsQk32MY=;
 b=nzfGdFj0vJIWSJvBIPhLSlTeBUhNFF7qz5xNDRrDzqAdvPSTRagPsONybug+PW5r0g
 tfeLIzUmqcRtqgbSzRwegr/EQCP69k3YmD3Fy+ABD4WXxTw9+ngFldiAw1IlmpSYNfyO
 yIMh6h5nslMQuo4VES2xMsw9w+aVoQ/j5Ax19k5euGwK2k0AnXWXAo+ciTnBB9dWqzNr
 YeNuEQEWGkZPiW7W1NCv3qlEezpo6zsNyxLZtzsa9b50t3wjDT7Aztkv9ZQAENlLBfhQ
 /mJWqGjlvU+c9tN3NOvIFqwEqVc+byljC8ok4L+ysEqIp7PqVUnEvqErKGAbeBk4QYL2
 D3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218576; x=1793823376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cWoyICeXIEDcF+ntNhHWZ5R9npUPu6GPUvFCsQk32MY=;
 b=dni60uT+BBhAJMomqV+T6Sofo+bb730/BuLgyWWQP7z6XT/3GXRmRc6LQjw0DFqD/N
 qZkGAltUks3PTyBRgC7GVyLkx6kJ03WO5rucdoZqlSOt88rTzKzk9MCT4B0NtYC3q2Hl
 mHYshx6AkiY+/KVV88X9FU+fOsQAF4Q93qiDxIq4dClPo/p7AX4DP6FbyC8RTPwDW5rv
 hVMg2G91t0Dq7iSQnk5Lj9UhmLqu+RKZDRAZJmWMhfoTaCZutOydkglauXvAyQkoUGWL
 MCU1q/Wgl/9r1kH8zj67SOH74d/LBLb5v864765ifSoUz+L56DcBcEvUIuEEdofp2bpH
 EONg==
X-Gm-Message-State: AFq9FYI6VWC/1LP6K2fH45Eq8Z7hS/TgoGLUmrm7wvNzW5uO1+BYU4YT
 nF3Ja0tCdQLtnU9fqoaMHU62ElcVcckoHWexhw40WvN/t08/pd4IGj5+72mX+Ba6
X-Gm-Gg: AYBFou1YrZW8bYYCBGZG83boUGCk1YL7SlXrGsLUKFcZIhz9KVqF55Wrbkc5uKvRGyN
 ulP2WAyZMFtHyG+AJ80FU2rtbGS4IhfPAuSWrsh3FZYLkKjnICPoTpbod2pPLsYaSioqg8MebBj
 wfAR7jAeHkkwq6iwGWXuElPKwTAPkCxphRCiH4OWMrpHso36yUrGejnd4l/g2pFgvVMNLGH3ftN
 9WHvtsuJZTbpwxroymTz8KNollcSzpY/30RgwQ0OVks3uZefhxYiZK++by9CyKGlM2G1unYjcKT
 CVikv9D8j01Td7T2uihtuIKN052eo4OQw1Ofn0zQ+nUH9Z1y4wRT0eXJVkK/Rh2DExfRde4A1RP
 2SlA+/kYor46sx0JLqsKqowT8ahGzlwbXWufYcB6BvTQ/aOuK0jJTIvp9XsZRBAeWUJzeOVUE+o
 ASyoSwKTFVY5/LgIUOO36PWbObUciumyBNzUZgZfXMvgrC0k3Y8yT3Q3p0NRO3pIWCG/05e2Dxs
 NjJKgO9+H7R4XNqS2TXBopMNccmvsUMbqd1fJoeag8gAZ17saTHuu9cDRSaAAM4ORB+4JOjYHgQ
 k8xqKqFo+/WpCpCieXwhhADiAEAqW7dkhpumrb9oWQdLD+N2
X-Received: by 2002:a05:693c:20c8:20b0:369:ef63:ea90 with SMTP id
 5a478bee46e88-36a203fe357mr4711973eec.28.1793218575593; 
 Wed, 28 Oct 2026 13:16:15 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:16:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 01/12] target-info: add target_loongarch()
Date: Thu, 29 Oct 2026 04:15:45 +0800
Message-ID: <20261028201557.2688-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report whether the selected target architecture is LoongArch.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 2cd4cc5671b..6c4e2809ad3 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -92,6 +92,13 @@ bool target_hexagon(void);
  */
 bool target_or1k(void);
 
+/**
+ * target_loongarch:
+ *
+ * Returns whether the target architecture is LoongArch.
+ */
+bool target_loongarch(void);
+
 /**
  * target_base_ppc:
  *
diff --git a/target-info.c b/target-info.c
index e67d7bed520..b6d9cd8d97c 100644
--- a/target-info.c
+++ b/target-info.c
@@ -84,6 +84,11 @@ bool target_or1k(void)
     return target_arch() == SYS_EMU_TARGET_OR1K;
 }
 
+bool target_loongarch(void)
+{
+    return target_arch() == SYS_EMU_TARGET_LOONGARCH64;
+}
+
 bool target_base_ppc(void)
 {
     switch (target_arch()) {
-- 
2.55.0.windows.3


