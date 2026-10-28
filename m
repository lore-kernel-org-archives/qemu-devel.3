Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B55606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ogAxHUST
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA5N-0005aD-Sp; Wed, 28 Oct 2026 16:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA5D-0005Nb-5E
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:16 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA59-0002LQ-I1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:13 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-3550c917fd3so2012405eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218630; x=1793823430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pd8ISBmCsatho7AhV+Cur/SqnrJPTwwxEIzKAKYv7CU=;
 b=ogAxHUSTaoIUduopi+eKeRwwr60xzFWpUmxvzAKaZDjn+qCsyC3m8xXC4wLMtdpxUu
 TNZUvve+RseQ2gLf5r12uRZ6WcDX+Zqv8obIbIp90Q4vO762S62M+fKnS+aDuPAKN42A
 Opos/uQKK5new+lPNTto84+2a1No8QJij9UP36LpFaUDR3Qf/6+pA/sxefDr/+3XP+h5
 0ZjUqgrV0ToPdr7Faw3kcm0SSslhl7Xwc2WMvphHoaKNeDd474pNJQlRPQ6lpc7nUltx
 vJzfHDRuupOxnbppTQQWkTTpxJkS/BnJ6b5uQR+y1JcrVyf2WNOnprX4Ee/aF3hvW1lW
 lx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218630; x=1793823430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pd8ISBmCsatho7AhV+Cur/SqnrJPTwwxEIzKAKYv7CU=;
 b=QWjhr5udjeodKnzil14rcB+/Q9Bbuh1E0iW89fq5fuKo/y6YUYk/mxPEIBcqfUjMwH
 F2YBqIFpuMvU/+/0z7lS0vt/QWmKFNSxhiwOSU7iHlCaUn9Xt1Z1f0F+8xex+YGGs99r
 sLoSUj8wIQBoM2mZo2EiX8aJBml1E8+KVWR5ZwC4rFziBXsKVo8OTZRAAYT4eCdDTsXp
 Al2aaifrqLAIqySESwELA8UfY9nYELnccOk4u6GApO91eGmIVHj1xhQmXLl5HFqzYPsJ
 TJwqXHOrqaRS7XUbvon/xRYmOdqrAaE+ppaMYDDMRT/sqk++Shy8Oq0mxdWxMhgaCK+I
 kvzA==
X-Gm-Message-State: AFq9FYImKyJnEMrgFmtD57g9GOdKHkphq6CUIvOKF9IgsuQalfWjKYO/
 5fmxpcaPM/PqmScLpfXpY1dnnmA545N05GxL3IqoCUQ3jC9j1LeonjHTAFs47/+U
X-Gm-Gg: AYBFou16em1oHAqVSseQrrea1JK/H04vQJmTcbn3rXhJJ+yJ9JHV5qzDgcDlxvolsDQ
 s6s1UOOpm4uPFWgcBzHWOmJlvs5F9Ba2J9LjXKVdad9KebTIap6YvWOoHqgeYHSapBbA0IiHt+p
 DttKLo5OQrLMLAawmfjZ872ePQQX9yykcUMSMJTZdXLHilzB15/dn4z68soMM70h8WMV7M/XToc
 Sh1IddPbwtq/IF3eJCsnEDvUSFUAzCDgVz+P0YnIldB8fX8O4Qvh2RlsLFW+PuTELsZap8N/FTx
 EqOYY1O7+Tn8CLsRFxBWS1dybFwlx6kMKsb1fttfMrlVfGk40wk1yZcchMeI/Wz8GMHsqPxRMgv
 YgI1hSdU21mURq31VWHoWCfD9MnBXOV4FvctQncWMjtXU++N9BBp21fQIBu14HAl7+UxHDzZnzj
 25wMCZku2yOoBM8hzqVQ8fkixrhJk3S1kbfY29IZaDQftK8zzumoqvXJMSFzo1pTaLls0IcmjXL
 3ocVcUxmruzNk6ZlDl8rXz5q+x2QqqdMKGpt6XR9yTJX5bh2OWvnmimJalzg8Iz7gbz3y0DdwyG
 XK8InAmeOf5Be01vPrYTwZGp5PGbUybPZ/OVfQjzzxKhWarN
X-Received: by 2002:a05:7300:d589:b0:35e:a225:3ba6 with SMTP id
 5a478bee46e88-36a203909ffmr4540193eec.13.1793218629989; 
 Wed, 28 Oct 2026 13:17:09 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:17:09 -0700 (PDT)
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
Subject: [PATCH 10/12] target-info: add target_base_i386() and
 target_not_base_i386()
Date: Thu, 29 Oct 2026 04:15:54 +0800
Message-ID: <20261028201557.2688-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

target_base_arm(), target_base_ppc() and target_base_riscv() report
whether the selected target belongs to a CPU family. Add the same
predicate for i386 and x86_64, and target_not_base_i386() as its negation.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 14 ++++++++++++++
 target-info.c              | 16 ++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 4bc25789d8d..48206d01ba9 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -57,6 +57,20 @@ bool target_heterogeneous(void);
  */
 bool target_base_arm(void);
 
+/**
+ * target_base_i386:
+ *
+ * Returns whether the target architecture is i386 or x86_64.
+ */
+bool target_base_i386(void);
+
+/**
+ * target_not_base_i386:
+ *
+ * Returns whether the target architecture is not i386 or x86_64.
+ */
+bool target_not_base_i386(void);
+
 /**
  * target_arm:
  *
diff --git a/target-info.c b/target-info.c
index d9e15c939d6..32ba85691b7 100644
--- a/target-info.c
+++ b/target-info.c
@@ -59,6 +59,22 @@ bool target_base_arm(void)
     }
 }
 
+bool target_base_i386(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_not_base_i386(void)
+{
+    return !target_base_i386();
+}
+
 bool target_arm(void)
 {
     return target_arch() == SYS_EMU_TARGET_ARM;
-- 
2.55.0.windows.3


