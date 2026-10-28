Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k/sR4da0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA4x-0005DR-0h; Wed, 28 Oct 2026 16:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4n-0005AD-QI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:51 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4l-0002Hc-6y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:49 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3550c917fd3so2011907eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218606; x=1793823406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QXd7cTdadNoW+gAtLomshjaW8dLnXiShl3RlnnollHA=;
 b=k/sR4da0Eb3kQyHUrKNw3j2m3YVpoQNRQjqYG8N6HfacBMJKggQuzWfzTm9q2TqYbx
 Y3VOktJCkj3ruVIb5BCMj08ttA3zAj4jAOzvLiRS9TEBCG2dIlzAfm4ajtR3rQo/lkMm
 BqN902E6H3SaLjHihlJBqHgxwKbd73itBIcX/74uZQ3udj5vC6bQPhn4QKYQ4dM4yFlz
 xswRo9YEa5pcvz1jyO94oHceyh5AgUWIxkJeQrVWNG3vuzwkbbZNFxalVI11P9u7bu6k
 qwk0IO7H4bdSuc8aVFtF1rxVV49IG9MsPh7+rPbpyXFEEBznEkOsa37heqvD2nus15G0
 ZW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218606; x=1793823406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QXd7cTdadNoW+gAtLomshjaW8dLnXiShl3RlnnollHA=;
 b=2A9LESrGyMl7dc6ldu843hyuhvmOjoZjHndZ584Ntuq0453cU1yb1HFc+pqLUTVmve
 AZDBK7TKS26UaxcoJwZkZuOwG4yoGVV4pSILbAX+i3WssoaEG0Yi/IGghjC5xu0s591r
 qArr0zs4LV6VWpL1/I/Af9iYq5j1758AABHxlIb7iCwu+rfUjd0YR83LVjnw0X/qVL7n
 3Y7A9heg/eQGhM2WdGFLZadCo1ePrfSdKvagb2hDO47+OsPQxc14wxjWSnb8URtYmRwn
 cW5MDSllOtdATTMJwj/SnKm1BbDqcESwSlPPPDxdY22WztT/9m4j7EKEAFhodOtlE9qP
 rPjQ==
X-Gm-Message-State: AFq9FYLKrJpwFSQvzijr9VdLZ/xGGfnkQRbOmmtUuL4h9fkj+To9TxNs
 JDAO6Pnkdf1S6jzfYvQxH29S4F7PE6YQz6AcgcEomIu0Qvsnx5BYB/i2wKAdbQLi
X-Gm-Gg: AYBFou3E6y0CpGm6kEOBGXPJ0w9CnOCk8vqV4Q8E+GzUOjyH3UXIAcgSTf6lJTNG0lT
 qZ7NrsHh1by8mfwzS/xLLPzpgQR9GUazibqjTajjOYaobVtvpncuf3DOD9h+2J3aOZEj8G5VV+o
 dJ1/C6uQqD7SUoE89C98ZwYeWl9z6Oc00hpqIK7iuLpREYc+7lfAkPhWdAHHf8j9YMKHFDMGJ8Z
 4wk+fEL5XqSz8qJ7wc01Z45iXPK+KS9FBEE1rFpdDQjKqcK61Et8PhxmR/6OtYyxzqGLkSIiGwF
 82V7nadnVJreOfde7UxvNiRTjx1bXJx3zoP/Sea3ypDuKAxNsc/K2zs+gTPhiHovickPl7o0ENH
 Zzl+Mv22w5oGvc5Jn20eSWXsedwb4SSMzKobka3T+4eElN10KDNggmh4TTMDTTXVeXTFXByJvpc
 i3vAdtEsMroHlwuZVHYCEIVeKpqrxG+0ysHhB5+Dxl3IESKMgqQzFTAeJsZhMqsu2oOkiDataMH
 WlgWEIIs7M1c247aHV1A6MvSSrtpNLCwRC439Ji4bDaf61CTYEp/1ZFvj/+c+j4bS4aRbIwzhIG
 S1LdRe4RvfXO78902o64tMeArf1eQlMP8GKh5aiFOwSgguv1
X-Received: by 2002:a05:7300:2406:b0:35c:8b96:94d9 with SMTP id
 5a478bee46e88-36a203bd31bmr4635772eec.19.1793218605677; 
 Wed, 28 Oct 2026 13:16:45 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:16:44 -0700 (PDT)
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
Subject: [PATCH 06/12] target-info: add target_not_s390x()
Date: Thu, 29 Oct 2026 04:15:50 +0800
Message-ID: <20261028201557.2688-7-luoyonggang@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the negation of target_s390x() so an is_available callback can
select every target except s390x.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 1d6c6f4472c..4bc25789d8d 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -134,6 +134,13 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_not_s390x:
+ *
+ * Returns whether the target architecture is not S390x.
+ */
+bool target_not_s390x(void);
+
 /**
  * target_base_riscv:
  *
diff --git a/target-info.c b/target-info.c
index 07dc88fd366..d9e15c939d6 100644
--- a/target-info.c
+++ b/target-info.c
@@ -126,6 +126,11 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_not_s390x(void)
+{
+    return !target_s390x();
+}
+
 bool target_base_riscv(void)
 {
     switch (target_arch()) {
-- 
2.55.0.windows.3


