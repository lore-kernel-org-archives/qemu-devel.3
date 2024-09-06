Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D231CE7B01
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWfo-0003FP-9p; Fri, 06 Sep 2024 06:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfR-0002o1-Pa; Fri, 06 Sep 2024 06:58:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfP-00063G-AN; Fri, 06 Sep 2024 06:58:17 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2055a3f80a4so14716895ad.2; 
 Fri, 06 Sep 2024 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725620286; x=1726225086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLN3uUD+x3NX+Z9x06IutEforArgUnqlFafVmqXGbqY=;
 b=KdaDgWz7nvM2rSJy1Cik07cK/J3nAo80kZThz9GXBUUgJZ3wWyDQys16EjyyUAHs2g
 khNFgn3VylbQ8e3QxwCEtA1p56EdJEizUaWaHHxh+3ecdns9Akfat7aoBIPBFdRJ9xho
 9u1ciaMDY8eibE/MnYrnD7e5rnaGb42XjICRvWzDkNtMy6XWCX4fohOIUcB54X8864Si
 hN0TKoy64HFE3QxnWmUbNsZfi0qxfgKQc5Ajn1GyS9EBNEp90d64bF0weleHf1DQYWnE
 CpSo+HbalLAj+TUEt2S64wiwDIi1r+YbHZob3NcFfucuKznPJKyevo3SruoJS6vlC+07
 R0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725620286; x=1726225086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLN3uUD+x3NX+Z9x06IutEforArgUnqlFafVmqXGbqY=;
 b=gV4rd+RwKVFtSnfufVPfh9HEYqzYjj1GPQ+rD3LGem1KOuk9FXk7pI6flqWfsPFF1m
 xJP1OT6OhiSqwLOom6y0o9xX1MtW30wYPFtpXqYUnEovvL8uw5rUY7Rzp8Mbd8u5Kwzn
 vxnhSPTd6wD0hwbSK/bciLMc6Kiu1h/aiU0fqSIGVcaZIjuKcp7Db0LQfUg/iRfdsBjf
 ytB6QgXsaWfb5EQTNLE5dNh0prT2XPn61drxFuSoUJb6DJQw1Y4qTRFGg5HD7khF5wNA
 v7yx9hRaXY9oiguIMveDbo/Ql8WwuqQBiqEtWeRhAHMmLz4AYp5L8TGOa8cJb7FOsivO
 3zDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCBwKgKYdMa39Pl0E/pJpbrr1NxzfwovsNTFje1Bfykklgl4wzHnPhJja716PWnSqZH+I7U0ShJSlz@nongnu.org
X-Gm-Message-State: AOJu0Ywy01CCPAstMAv5cOe40lVyDAQLNstQDRqZy81U0c9otVcTL6NT
 YmxIHjMsmlU7+lk5YR0F/oiSy7nvf8HQPOjGf+5RoCkTtTbsuI6cZ1xwZQ==
X-Google-Smtp-Source: AGHT+IHkrm6xcHaE5isttG7ua/IY1cgm+p72/9EtWuvEhivUtz/vo+fM8gaKYk84/9/5kFe6CosKuA==
X-Received: by 2002:a17:903:2406:b0:202:51ca:9831 with SMTP id
 d9443c01a7336-206f0654f3bmr25019505ad.49.1725620285621; 
 Fri, 06 Sep 2024 03:58:05 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea67bc6sm41134575ad.258.2024.09.06.03.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 03:58:05 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 jeongyuchan0629@gmail.com, Kyoungrul Kim <k831.kim@samsung.com>,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PULL 1/5] hw/ufs: add basic info of query response upiu
Date: Fri,  6 Sep 2024 19:57:38 +0900
Message-Id: <de2cc4078240f8b745a7caeed461b02f2577e2d2.1725619134.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725619134.git.jeuk20.kim@samsung.com>
References: <cover.1725619134.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Kyoungrul Kim <k831.kim@samsung.com>

Modify to fill the opcode, idn, index, selector information of
all Query Response UPIU. because attr and flag operation of query
response upiu need these information too.

Signed-off-by: KyoungrulKim <k831.kim@samsung.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 13 +++++++++----
 hw/ufs/ufs.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 945a0ea127..ce2c96aeea 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -851,6 +851,14 @@ void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
     req->rsp_upiu.header.data_segment_length = cpu_to_be16(data_segment_length);
 }
 
+void ufs_build_query_response(UfsRequest *req)
+{
+    req->rsp_upiu.qr.opcode = req->req_upiu.qr.opcode;
+    req->rsp_upiu.qr.idn = req->req_upiu.qr.idn;
+    req->rsp_upiu.qr.index = req->req_upiu.qr.index;
+    req->rsp_upiu.qr.selector = req->req_upiu.qr.selector;
+}
+
 static UfsReqResult ufs_exec_scsi_cmd(UfsRequest *req)
 {
     UfsHc *u = req->hc;
@@ -1327,10 +1335,6 @@ static QueryRespCode ufs_read_desc(UfsRequest *req)
     if (length > req->rsp_upiu.qr.data[0]) {
         length = req->rsp_upiu.qr.data[0];
     }
-    req->rsp_upiu.qr.opcode = req->req_upiu.qr.opcode;
-    req->rsp_upiu.qr.idn = req->req_upiu.qr.idn;
-    req->rsp_upiu.qr.index = req->req_upiu.qr.index;
-    req->rsp_upiu.qr.selector = req->req_upiu.qr.selector;
     req->rsp_upiu.qr.length = cpu_to_be16(length);
 
     return status;
@@ -1411,6 +1415,7 @@ static UfsReqResult ufs_exec_query_cmd(UfsRequest *req)
     data_segment_length = be16_to_cpu(req->rsp_upiu.qr.length);
     ufs_build_upiu_header(req, UFS_UPIU_TRANSACTION_QUERY_RSP, 0, status, 0,
                           data_segment_length);
+    ufs_build_query_response(req);
 
     if (status != UFS_QUERY_RESULT_SUCCESS) {
         return UFS_REQUEST_FAIL;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 6c9382cbc4..4bcc41f53a 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -228,6 +228,7 @@ static inline bool is_wlun(uint8_t lun)
 void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
                            uint8_t response, uint8_t scsi_status,
                            uint16_t data_segment_length);
+void ufs_build_query_response(UfsRequest *req);
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
 #endif /* HW_UFS_UFS_H */
-- 
2.34.1


