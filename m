Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEA1EE0ADA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voh8U-00079p-P5; Sat, 07 Feb 2026 07:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8S-00079G-Uj
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:00 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8Q-0002sl-UI
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:00 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-354a4ef0c1eso1500407a91.2
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770466198; x=1771070998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G85lH42gCcMibdBM9mV1RiEav8F/CH9MqgVmO0gS/Qk=;
 b=FrOS+C8k1+yKx52ZeADia87/PrxwTgqEhMPvV2QR2L+omnfLjPpkT9Y9rQuLXal9uA
 RDsnO3DNQ6inSXbYuYibrTz49OR8cOaxSydmous5n5/DFuCiNA8F/AiqozvjijlnpQcB
 IhMl1FIaPjVUCGv+LnBbI4wYU+iCbnAlDkJvxzzIqGtI39F8DDFbedRWiENjFPbq+zcH
 oUEfupIFq4z7CSgw1SoUyLbyQnxvU4aLhLd6Ze6P4k/6DSBAcctW/YrbFiYYl/pMINIk
 qZzLjKzkMovlnc5pIy+2sRIl0uJ2UX7LGYTQQHNpON86JftyU8S/Pv+TRw2IA4+HnUFY
 t5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770466198; x=1771070998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G85lH42gCcMibdBM9mV1RiEav8F/CH9MqgVmO0gS/Qk=;
 b=BxjqqaDeba4T+lreO9dzt0uqeHEXbvrPvZalSt8iwGj/2MIDDmtJJwiISMCN9bsqWh
 kfTdY7EEToMNsalcm6a+/DOX++NZJpzJFXhBm4geg/5TuzwuD+28EOAlqsNRjZ7rO3SU
 7z6KJu6EzD/TF9m6NS3gVbHmY1QCAKDXMU50Jp1RP7eRQVMuiQw/hJuyVGN7y6SRPwVV
 Itkr7oNndw+KhxeVo5RPJChOc2jJl9zSc1eEue3MQLuq6sIMWHq7gk40vk2c+TH+pVE9
 /OV5G+FwVdgVIsX+HUZFAz2SmCQVyC5940DOjKEnknC/vG3sqyn6MlbbycDTrOz6sU/T
 knaA==
X-Gm-Message-State: AOJu0YwFJitdwVTOoUZshGV1bEs1K6W98nbBePJ5cO8WBn6d/y7N6Xh3
 Sim0sCfVNmd8GhF1SmuhUfwoalHv1Pj60L81oHaAEG04kApZ0Bqrtfmn
X-Gm-Gg: AZuq6aLnW8YzVCCTJ6GJp8UWZa6VTHvz89mQtibiHuwrhmMR2kWDliNyYXAB6G5QBMO
 tEy88kST7VdqxJ1Z5aFL9XJT3yKwvCYm/cthM5ZyEu7YsB+Wqv4rNlGxAiV1pfDrNtoLiDK7cFk
 NAI770FY87+aYzzd9NDm9px5VZ+8xowi5723RxTy8dVL5ZyqrX6R4DEoqm/zM8acJMHlKnWBZD7
 TB16DnlODIiG1I1ckirP1LqJ+ijNWo9VsSk1swU89+NJwii2JwTpIdFH9XLFMLP7bs8uIQhMzu3
 VXmhZiwHVjKhwArKdhDyBC47JUn6lLdylgfdQUtM6Vk+vyn4H3eqnzf21mCPMxf+O+0e+ymRA9S
 51m69+8qzuyrksp6K5q9YI/UQ05RUjjFWRWDuvbPqyvHDEkpFhK5Or+NspJTMxUUqRN7henhVv9
 WWbZYKbnicfTVWEe2+NIi2bXw7qqFYVNeqZug7
X-Received: by 2002:a17:90b:4f49:b0:34c:2f3f:d27e with SMTP id
 98e67ed59e1d1-354b3c52e02mr4587459a91.3.1770466197548; 
 Sat, 07 Feb 2026 04:09:57 -0800 (PST)
Received: from brian.. (n058152022104.netvigator.com. [58.152.22.104])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b30f899csm2178530a91.3.2026.02.07.04.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:09:56 -0800 (PST)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hibriansong@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, fam@euphon.net, bernd@bsbernd.com
Subject: [Patch v4 3/7] fuse: uring support for write ops
Date: Sat,  7 Feb 2026 20:08:57 +0800
Message-ID: <20260207120901.17222-4-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207120901.17222-1-hibriansong@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=hibriansong@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The payload of each uring entry serves as the buffer holding file data
for read/write operations. In this patch, fuse_co_write is refactored
to support using different buffer sources for write operations in
legacy and io_uring modes.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c | 55 ++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index ae7490b2a1..867752555a 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -1299,6 +1299,9 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
  * Data in @in_place_buf is assumed to be overwritten after yielding, so will
  * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
  * assumed to be exclusively owned and will be used as-is.
+ * In FUSE-over-io_uring mode, the actual req_payload content is stored in
+ * @spillover_buf. To ensure this buffer is used for writing, @in_place_buf
+ * is explicitly set to NULL.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
 static ssize_t coroutine_fn
@@ -1306,8 +1309,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
               uint64_t offset, uint32_t size,
               const void *in_place_buf, const void *spillover_buf)
 {
-    size_t in_place_size;
-    void *copied;
+    size_t in_place_size = 0;
+    void *copied = NULL;
     int64_t blk_len;
     int ret;
     struct iovec iov[2];
@@ -1322,10 +1325,12 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
         return -EACCES;
     }

-    /* Must copy to bounce buffer before potentially yielding */
-    in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
-    copied = blk_blockalign(exp->common.blk, in_place_size);
-    memcpy(copied, in_place_buf, in_place_size);
+    if (in_place_buf) {
+        /* Must copy to bounce buffer before potentially yielding */
+        in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
+        copied = blk_blockalign(exp->common.blk, in_place_size);
+        memcpy(copied, in_place_buf, in_place_size);
+    }

     /**
      * Clients will expect short writes at EOF, so we have to limit
@@ -1349,26 +1354,38 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
         }
     }

-    iov[0] = (struct iovec) {
-        .iov_base = copied,
-        .iov_len = in_place_size,
-    };
-    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
-        assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
-        iov[1] = (struct iovec) {
-            .iov_base = (void *)spillover_buf,
-            .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
+    if (in_place_buf) {
+        iov[0] = (struct iovec) {
+            .iov_base = copied,
+            .iov_len = in_place_size,
         };
-        qemu_iovec_init_external(&qiov, iov, 2);
+        if (size > FUSE_IN_PLACE_WRITE_BYTES) {
+            assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
+            iov[1] = (struct iovec) {
+                .iov_base = (void *)spillover_buf,
+                .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
+            };
+            qemu_iovec_init_external(&qiov, iov, 2);
+        } else {
+            qemu_iovec_init_external(&qiov, iov, 1);
+        }
     } else {
+        /* fuse over io_uring */
+        iov[0] = (struct iovec) {
+            .iov_base = (void *)spillover_buf,
+            .iov_len = size,
+        };
         qemu_iovec_init_external(&qiov, iov, 1);
     }
+
     ret = blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
     if (ret < 0) {
         goto fail_free_buffer;
     }

-    qemu_vfree(copied);
+    if (in_place_buf) {
+        qemu_vfree(copied);
+    }

     *out = (struct fuse_write_out) {
         .size = size,
@@ -1376,7 +1393,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
     return sizeof(*out);

 fail_free_buffer:
-    qemu_vfree(copied);
+    if (in_place_buf) {
+        qemu_vfree(copied);
+    }
     return ret;
 }

--
2.43.0


