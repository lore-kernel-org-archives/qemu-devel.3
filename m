Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59253C5DF9C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtLw-0003cZ-1U; Sat, 22 Aug 2026 17:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtLv-0003c9-0a
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtLt-0000f2-Lb
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2caea3f742bso35189875ad.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434448; x=1788039248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GKPbyoUsJ8IzjDSZ/9gIj07Iz6lN96BBEtJXGjNiovA=;
 b=SdA8p74APHQ7SYzsPQvpF6ZesS0qcAbjKDVVzvLuvm9zkF4HemVSNnfhc19uWh15rz
 w9LOvFOH9YSB/xJeLKldxcIYmZW3RUx5zMGT7seeiGy9Zu5cV4OKkkMEw0HXXcbagEHU
 Qg6g5kPmX54bg+5im7uze+vUrB/GCJGV0VPPkqwNjD0HYoThR5hUPgivOmWI1fF4xpQg
 jNh/kCRfjn9pfwuM09n9v7J+qgXqjmRbJVOqpKZ7K8XR85sldH/Y1zCZ8UoDNQgci3oj
 l2D7rRYA/siSOf5Ika5Uoo7wB8ogvaXuer6xU3pSBZUXO8QRo/3/sdwFfz8s1ws7CUee
 ZahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434448; x=1788039248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GKPbyoUsJ8IzjDSZ/9gIj07Iz6lN96BBEtJXGjNiovA=;
 b=tJGYFPcYAq0l+SpM8P6JhwGR23AdQo+WrITS3ABL5j2z5vnUzGqNgWKhuW+mvBemej
 YV5S6wX1clCqbeJUt/a3n9qj8pzF7NGPgi826pZOVmqTmRUiprFGrA/5pxMsXSA/j9Fd
 AiwNjlGnTYJHrcB7ZgEWY4m00k36Kfa3TG1/F/I0rPTiR6Ovxg0hKkdShpP3iFj8NgFf
 RBHN/w/tjxtK5QC2FY6VzIkU4Lss3C7sqv2RY2oCvVUxkOR/xHWSVLh+dBS+PP/oLamI
 PBexaJ1h7mwF2ID6Xq0dErQRm48VUTCUbQUSAA2+6OhFouzVor7AKVTa+nnorDFAyUfY
 HYDA==
X-Gm-Message-State: AFuF++k3XjtqYh7KByD3W/QwSKxdkA+iMFUQ9CZ7v83HwTJzptVnrFbr
 LAAUTy3jUnOWAHJIluAByRkLK3GFXYF7AQEpJAGAPGWIkJ6FsgXkHadz/iHU6WahByouCYgd
X-Gm-Gg: AR+sD10+5T7qkfFpsnDFvFcNb6TKJV/TFHI1ip5GrO8XZGmDCDroNyK6vdtFqpI0M6h
 +WWQJsmN7FdyHwpxOPX5UneClK4vnP+RlP0OGxlSpVBvO4oVZDAasVcsR99OWFeq3bdgfuECBNE
 aiUmZaG3q46mNiXEOr5JmQZ+BVxzZAV9VzuWCCz3MlZUmZwSL196z7BqO8HQrfVHKxwkqSVUS3S
 0aDeV1cZCBHxz0FixoDenzB48I/hkdF4e2jmlMLq16wKG+zxKFsb9skUTT7eSW4xTGjiIswoOds
 IOPkNbizKBUbLsdoPzyWfgQo9e+d2ylBfoIrkSVUmmkGg6HAy1Jh86t/lxhEkJ1QLdTOSz059ei
 rxQv7QFZFDf0j5qeig2Ph+rM2vMRaOjHVkr/Tw3bda7wqkNZpFrME7fUR9RTw1wrpTmaL3oHytb
 EvTXMa1qGdE7nf5ZjZv981vgIZ44Ecusybd+pLR3P2qvjWmxMU77MbTN9rMusEYJws8gVk/8y1G
 VsanCCU
X-Received: by 2002:a05:6a20:43ac:b0:3b4:8f18:33a with SMTP id
 adf61e73a8af0-3cd2fd8e233mr32283538637.1.1787434448283; 
 Sat, 22 Aug 2026 14:34:08 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:07 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V13 01/15] qapi/misc: Fix missed query-iothreads items
Date: Sun, 23 Aug 2026 05:33:24 +0800
Message-ID: <20260822213343.661939-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f..c71a5fe657 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -123,11 +123,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.55.0


