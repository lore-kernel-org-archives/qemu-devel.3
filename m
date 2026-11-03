Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2CA606D812
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOJsT1HR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=T6blcy1t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2f-00048M-Jt; Tue, 03 Nov 2026 06:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2b-0003vF-He
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2Y-0000M7-L6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHzGHDO8IKROc4ryf1CkQKtK0sSIGe+ITrTR/Gnd9ck=;
 b=gOJsT1HRlzH3F/p8PM4V7QNSKyaVu18xmpwO4NVLWIE1CRdCfwE7i+zOn2zHEiHSWRKBxi
 B0+y1jnryRjNhY9FIJ/yrSucENT0En8xiK5I+Td37rGInTsENkPSSpeDtbyGsHWjAT3hf1
 Qqhw31TMUaCivPcUkIHvUX4M+KU9ktA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-9PeoEWqnOf2g-E9HrMBUEg-1; Tue, 03 Nov 2026 06:50:56 -0500
X-MC-Unique: 9PeoEWqnOf2g-E9HrMBUEg-1
X-Mimecast-MFC-AGG-ID: 9PeoEWqnOf2g-E9HrMBUEg_1793706655
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b01a74792so2756401f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706655; x=1794311455; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lHzGHDO8IKROc4ryf1CkQKtK0sSIGe+ITrTR/Gnd9ck=;
 b=T6blcy1tTGzYjerp3wk6FgMvt3WnkgELGYTuq8rNJM7cGpjZ4TsGSj/Ewexr+fjwkz
 9at1hxFotyvpQzlFU7XZofhofApzb6vGooQ7E+tpipi7lZktsvI+kXfXKtAXDRSGvpQn
 ge85GiMy2E28gROjiPM3cE7s5OyzEDwpjfb9x9iXlaPZ78EwLsZj9fnwJDZn+21gMolK
 t3HN3YqY+t7lRXPOMjg2fHVS/iImmmr5Bb0JyE7JZpp5Rs2DbLxnzSTvwe8qkaahOvfG
 4z038KHZrvLNxjvUKLe9TbFn4gBMQNf2M8pAt0hQCI02YLwi+0dNAgvaRHX9Gzpwze3i
 GOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706655; x=1794311455;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lHzGHDO8IKROc4ryf1CkQKtK0sSIGe+ITrTR/Gnd9ck=;
 b=Q4rdatyriDTPXBLoyeTaWKTeJT7iKTCNyH3gKHogvG28mRZO5WSAvdq2r/LY4zhoIB
 XSH9/y3/EskZuXOEWRR/u23x06mLE8yi0CJyfHYql0Z6jfwSIhZCe9RiYDUXWZXpqlZb
 qq9wjNzq1+ixhaj02hteOftRLWar/sTPMLNOhiMwsK36UOKZQFio10S61GZM+acN7Lf5
 Vw4q4Gk18oZ3RIJl1DtEK91YFgNa1k2vYpllkv0Bf+JlkTy7OJ5W5Ek+B3kuJeHM8aqY
 CnvwJ7HC89NekEOQmKn9y5CYUBoa62O1X7tBVL9YoBCHJkLkyoXZ1mGa2bGAVeZcHbLE
 MvwA==
X-Gm-Message-State: APuU4Z/JnEniyBgO8iIs0mbatbH6IK/BRZbiRfac0nSm3ZfTV0MOlspI
 JtviDMHcue1f57ug5SRE7dM2Yo9WQOkftgriKe3SeuiY+QoIInRr0+EJnN1hz8Pk61OC54qOZDl
 SH3Cahivxf3x+5w7fIUGAqvtSjd5557aFgrsJ9N485L/Xeki63nteZkU6iCnDxj/qCraNzwvf9/
 RgDFnvTfWzkB96ajuS/wbmnMQ69jRsqOQp5Q==
X-Gm-Gg: AYBFou3NmwgKjUF0gxotmN55DZHVrXfGPynyvcCPTIEw7GhskEvNKR5r5exj84M1MJx
 aat90CsvV2Je/qg4kA9zU5nBFqeNeU0lQDmc0uNBivdBzRYQ1V2rk3/09mZNnwkjO5rK+lYiT4+
 flLvZ+ErkiZtES6y0VLothdRAG/8/66oqlqg4tgHmrNiLZMHieklvXQ7iN7GOEwWzp+DY7JYcj+
 Zmz577rJxpLwrXZQPNAMRjAEsY1/nCE4073dyAKhlPIMpbDHrnAL5lAzIQkGLl4FNgATuwTTMYE
 7O6j0ipliFI34s+OGYkG7tSmaScaGHPWSwr2YXDEwo+6by8Q4q87Qh1rFqqAGLHSkseahn+qHYU
 SCd1Ph2NvWr/FBL/WFfFfc0YNq7MqWRTHDzkJbkpzgA==
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id
 5b1f17b1804b1-4ac182dca8emr282537995e9.23.1793706655379; 
 Tue, 03 Nov 2026 03:50:55 -0800 (PST)
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id
 5b1f17b1804b1-4ac182dca8emr282537365e9.23.1793706654751; 
 Tue, 03 Nov 2026 03:50:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a96fc87fsm48576075e9.12.2026.11.03.03.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:54 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Utkarsh Verma <uverma@linux.ibm.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 11/17] tests/qtest/nvme-test: fix NVMe struct field endianness
Message-ID: <b4380be275b162773bbe3ed608da09dd43e0f7af.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Utkarsh Verma <uverma@linux.ibm.com>

NVMe queue structures in guest memory are written and read in little
endian byte order, so they must not be byte swapped depending on target
endianness. Instead, read using qtest_memread/memwrite with explicit
le*-to-cpu / cpu-to-le* conversions.
Also, fix the qtest_writel call with qtest_writeb for NvmeIdentify.cns
(uint8_t) access.

Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261102035306.2291147-5-uverma@linux.ibm.com>
---
 tests/qtest/nvme-test.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index f9395cc252..edf982a111 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -223,10 +223,12 @@ static void nvme_init_cq(nvme_ctrl *ctrl, nvme_cq *cq, uint16_t db_idx,
 
 static int nvme_cqe_pending(nvme_cq *cq)
 {
-    uint16_t status = qtest_readw(
-        cq->common.ctrl->pdev->bus->qts,
-        PHYS_ADDR_OF(NvmeCqe, cq->phys_cqe, [cq->head].status));
-    return (status & 1) == cq->phase;
+    uint16_t status;
+
+    qtest_memread(cq->common.ctrl->pdev->bus->qts,
+                  PHYS_ADDR_OF(NvmeCqe, cq->phys_cqe, [cq->head].status),
+                  &status, sizeof(status));
+    return (le16_to_cpu(status) & 1) == cq->phase;
 }
 
 static int nvme_is_cqe_success(NvmeCqe *cqe)
@@ -253,8 +255,8 @@ static NvmeCqe nvme_handle_cqe(nvme_sq *sq)
     }
     cq->head = cq_next_head;
 
-    if (cqe.sq_head != sq->head) {
-        sq->head = cqe.sq_head;
+    if (le16_to_cpu(cqe.sq_head) != sq->head) {
+        sq->head = le16_to_cpu(cqe.sq_head);
         g_test_message("sq %p head = %u", sq, sq->head);
     }
 
@@ -298,15 +300,14 @@ static uint64_t nvme_get_next_sqe(nvme_sq *sq, uint8_t opcode,
     qtest_memset(sq->common.ctrl->pdev->bus->qts,
                  phys_sqe, 0, sizeof(NvmeCmd));
 
-    #define GUEST_MEM_WRITE(fn, phys_addr, val) \
-        fn(sq->common.ctrl->pdev->bus->qts, phys_addr, (val))
+    #define GUEST_MEM_WRITE(phys_addr, val) \
+        qtest_memwrite(sq->common.ctrl->pdev->bus->qts, phys_addr, &val, sizeof(val))
 
-    GUEST_MEM_WRITE(qtest_writeb,
-                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, opcode), opcode);
-    GUEST_MEM_WRITE(qtest_writew,
-                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, cid), cid);
-    GUEST_MEM_WRITE(qtest_writeq,
-                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, dptr.prp1), prp1);
+    GUEST_MEM_WRITE(PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, opcode), opcode);
+    cid = cpu_to_le16(cid);
+    GUEST_MEM_WRITE(PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, cid), cid);
+    prp1 = cpu_to_le64(prp1);
+    GUEST_MEM_WRITE(PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, dptr.prp1), prp1);
 
     #undef GUEST_MEM_WRITE
 
@@ -344,7 +345,7 @@ static uint64_t nvme_admin_identify_ctrl(nvme_ctrl *ctrl,
 
     GUEST_MEM_WRITE(qtest_writel,
                     PHYS_ADDR_OF_FIELD(NvmeCmd, phys_cmd_identify, nsid), 0);
-    GUEST_MEM_WRITE(qtest_writel,
+    GUEST_MEM_WRITE(qtest_writeb,
                     PHYS_ADDR_OF_FIELD(NvmeIdentify, phys_cmd_identify, cns),
                     NVME_ID_CNS_CTRL);
 
-- 
MST


