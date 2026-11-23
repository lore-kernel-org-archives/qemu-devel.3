Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC68606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=q/shfQ86;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wOQ8jOkD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVfL-0003sY-AI; Mon, 23 Nov 2026 10:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbZ-0001Qc-C0
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:22 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbV-0003kN-Co
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:16 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id D1173EC0BB4
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 23 Nov 2026 10:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446309;
 x=1795532709; bh=UWbpWRmchmn9lef+vNi6eP1RQdINC3VjiM7XCKTHDrM=; b=
 q/shfQ867EbKjIYwGqJUzb5w08sM3ecnHwFL49xc4T+RkeMd4LOfo54xZ2PCVuTm
 jsjY8Ee/V175diBUg858L7xju8dHh+lHHKrsoJotQ9MDOpBwTJccqH9ZcrU1vj99
 fyYRjF2EW+QcJEec8YzuYIkNxv+1F78k4NHIguKwk5KEZIX7DexXxencteAxSz0q
 n4JAW7cJq/i94+Qlg9zSbCOH6ly4oSZF2fLFvFfU/r5CWEUrHpA87I1s1FJ/LYta
 FsoKd/N2vLkcXJqT4o2g0l6WxUi8xWT49duy/bsiMIDifYtnet4BrSL1eJFJVqt6
 XAqtnVn4UUNtxa0NaL+BUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446309; x=
 1795532709; bh=UWbpWRmchmn9lef+vNi6eP1RQdINC3VjiM7XCKTHDrM=; b=w
 OQ8jOkD/6hqsbCCyWRF0Jt7PO4Dv1vmSiriNzbZpDYEenAc/1tvXNJ5znHM/Z9ag
 GjO+GzPcoUKERm/oP7zUJ8iB/KWxcPwbt0D0tW80c/q+q5nPXWFAvBJCN1RtJd2X
 dKvbu5aGbJbG5ISACtb+zpWewy/N0N5HH1VjzpyZDWbv6xzYaVE9+Cvcjsyr8xEA
 MhRFQ2LRXVmqNT70xi/S448XaaW8W5XANLFcQnQc6jT1Ao0R/1041ctbOorbWfsE
 Qku/ZJ4ND5lQqTPDbEt6haRk6bF+ROQjU+ZOcM0jSaVcnvBDiHSFmv06lLiRozMJ
 kp/M5ZbrBLsOPsDFvioTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446309; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:NdpfeMN+mjgrGKPFgKls2NOoed7hi5scDf6+Viwi6cvVr8R
 f+d7Z2MTcfU+xYJBftpEYWfNoDB14jfoy8nTzBeKliZblYTyxhOob4aDy5Jov2RH
 IPKIT4FE/9PC8IWC1ZhcUeXyw1YGInC/aj2IpNnYrigH4+QMKR3KYBE+LOP7l54Y
 OOIcAHgo1+uhnxOULdwMs5qa8WilUeLSWLRjHL+cS5tJFZFTCauAaFzacM9syubU
 ScfXTqjNIkiJs8s/HUrV05bidYDUiqlp3TPtIvwyxpDg6/NDYF7KYKK/II7i9L9m
 TtJbxICZiIDngKNkdny9s/UeNiqF3rEr6N+7A0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:cFx8T88JZvsVgkxfRIqtcdXu49m4fE0jUYYKVfIuYK0=:frTAkNYXJM3GAUIrNT0fAboLSsi7pAZrQztWcMWUH3U=;
X-ME-Sender: <xms:JVYEa3TbpvE-cjalYG9ewPwTDmCJvsoUWwwHalwxtIwB0XRoe4KUsA>
 <xme:JVYEa5Nex8UquDBLzSxQ34zxTLeiLhdpYGIafP27arlU8WTskKAMHHCmeHG_LS_2Q
 ISfiMF47I8ofW882B77uHgGFOxPz-3hCQTu7g0lUmp8cvUXas22B_0>
X-ME-Received: <xmr:JVYEa9hSZseRKbyQd6NXuOTaxn-lX6fpSokiT5rB2zVwegZ6xWZTJahbXVEkNiGr61i8l54DKcWs5FaNJGThK5KVohKWs7wCWLYf>
X-ME-Proxy-Cause: dmFkZTERDW1ohsMsfZXmd54Cc/nBRJavi3KXv8KLj9KLSE2Pb69Wtn2SdzZpPA3/jgB3Ne
 GSmdsZlhnpqMWcOzzoydqdAA3wlxLsTZ/Ggbj1SaQnH8slnax2FISfdvpUuoTMxGqk9JsJ
 +OID9IlAGpiqSEXEZviBB52kjW4UK97r4VEIqy+82y60tIdaxX80dZdpiw/Fufyc2J6I9j
 pbuxysytuX57KI9vjQkBminLlqL/3riO9KSDVll+FqInnVYNdCm3RaRv15wmfCOi/a0gM1
 m+GFyjd3Ycgi04x++J7nRMEaYBIcaOdyYFMTGBrlW0RAiAWOFHdgXMNAzQFhEveDnhvADC
 LR8DOaRhdpZl2TBX3SiZLvwKklYFWylGymfdHi03d3AptOevypv/Exr4tBPVDjvP5zhKyX
 /My1BO3CLGoCCiZj4tifBh/16HQOqrW1/AhtscQ5MvPrOvnu7aCpJmmVqJy+VhVq7aCK4g
 zxsug0pQGzYj5IZCsIytiFWste4110a1qbBAgXzyZNmYaGHHK+qfM5TGCsbVrMC8HkGrjJ
 1D3haHmrBA0x4IIbIJ9CvN5TSET7CVMqxhh/6ZURSckyN9IdUcCVtMLW1qQsf7xpVv9mKm
 BBxTEq/1uZbkpsFpyCU1nLfsY9WYtlRry9GS3jJmuv8NbUUBJfUu1/XG6IwQ
X-ME-Proxy: <xmx:JVYEa-k86_toouLPjOq92u3LOqBiE3wOE5jK7wqHeeBQNNhjqPJMtQ>
 <xmx:JVYEaxh-VESmGOcxqJYmgLACml375K6PtUlHADWXvRJEQ_C__yxtqw>
 <xmx:JVYEa5FB2D81znY6NtBLOjgT7HDlgaYiAl_B0ir3OP3bvPSP18305g>
 <xmx:JVYEa7sIxgWj4rx2dmivQT5knbRRFU3AdfD0-mBQt4HzLTbOuTHL0A>
 <xmx:JVYEa3XC7US2gk9MvtqDnDx6DFQWNMwWoORWCGJJvPOvfWGBxCuqUvdE>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:05:07 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:55 +0100
Subject: [PATCH v2 08/12] hw/nvme: NVMe FDP event data structure - ruhid is 16b
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-8-4c9893537cd1@samsung.com>
References: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
In-Reply-To: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.150; envelope-from=foss@defmacro.it;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Source: NVMe Base 2.4, figure 303.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 include/block/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 17a7c7818d7..a0caec8e441 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1897,8 +1897,8 @@ typedef struct QEMU_PACKED NvmeFdpEvent {
     uint32_t nsid;
     uint64_t type_specific[2];
     uint16_t rgid;
-    uint8_t  ruhid;
-    uint8_t  rsvd35[5];
+    uint16_t ruhid;
+    uint8_t  rsvd36[4];
     uint64_t vendor[3];
 } NvmeFdpEvent;
 

-- 
2.51.2


