Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD60606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=ZfVAW/Xa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Nt0DQv1C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVc4-0001fD-CF; Mon, 23 Nov 2026 10:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbN-0001Mn-UJ
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:06 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbL-0003is-Ov
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:05 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 44B1CEC0BCA
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 10:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446303;
 x=1795532703; bh=22PASwItlfVZYvyVbpvPcRn6Vjqt+NQKu1LmvzL0Aqk=; b=
 ZfVAW/Xa/NKQFWOybV1Hna0FplQXHncTyaFpuwNsE/WVIn3Kee93PwzAtsPuSA5y
 bWylZConGUQSku7W4Ec4ORBmgL+DqCOjTDl0dOV6o57vBVnxZwFo9BJ+nfTYkgwe
 Sy0I4wh4U8Iz9ugUV85bNKFyWkxQB2xRpereBH22K+JRsMONuJGWpqT9pAr4AXMN
 qxJyyUuxYZtTRFXaQSKsYE6aNYlTEkYF8UAjsNj4IijAIM15qDhR2k5uuORb6B4r
 qEypUc+1tZruEL6aESt8ogvOpAsdB4vSES/lH2GawbwNRzVCdelygSWol6CbkZJK
 SaI4+N4n0aMaCRtMcj+OBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446303; x=
 1795532703; bh=22PASwItlfVZYvyVbpvPcRn6Vjqt+NQKu1LmvzL0Aqk=; b=N
 t0DQv1Cb1w6dT5TCMafXRd5KYxA4SZpdD/4mU1NfWeNCeOttelYD6rcTRbEGfYvv
 7ytcRtKFPPoMrP07QvndFfMtC5rQxqmqslkDD9tBBl8K44NqAFkQHnwYEtaBvDRT
 9nI8OOZdP0XGxJBsrLsaCZ/2N1ElXCmKBHKkK1BaXP8KhfZ85Hfz5uTv7FWM3szM
 P6PhDmZ0RwSMsM8xFNHjIhtNlzhP676SaPRaa5JNZIzNJyy/oNRLTofUl2qyCEkX
 l4JbvK6JI41tTVeT1qJvKF+bdA18C1/D8XN0q1o1GPTWNH7EN+xRT2+kjrRTUbap
 nQNb2USQeZ5Yh9pQiVCyA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446303; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:CP06njnulHAUNLh8GDQ+MbE38gbrTJYVC1E29KJc8bToUjd
 uNJD60zNWP7AffI4T1Xs7xwhqJsPxirjYrrR9zBCHoD/bhdEsYKzn72FD/GxPy33
 DbhoXRsamrJMwNuTQz8a9atkoBdMIKO+MnrRgPAjUZSOqqhJkLjUGEw5Gky9A/5b
 cyJXbyBlXahbhELyzWHOBR1zMKVC58zN47Ng2TzwevyZ+Q0JTjt20x1vXtOGAyZj
 ib+M/u8Vioo0YDsYKJVinqU18dBJHVVNWLiCX3l62jhPIrF2XQi53S0Tm3KRooo0
 P3X/I6WDPR6WeQZ0FVwal7sxLIh1KDxOs36Gz7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:FbaW0hmvNgrIsX6Uu3Z9Gn8vwgW42eKT6ErLf/v7fsY=:o/VK/uEwjwQh1cgNCp5CG/C6WyI61fIsI3iSX3byDXY=;
X-ME-Sender: <xms:H1YEa_egAgnkXUe8X1goJXmceVXbwvEzMbXIbFjeKfOx7cS3IAZ0sQ>
 <xme:H1YEa1opEtrb11shdgcmypwebC2UrYCpj13ukPmF8yOJXfEr4si0YbmBJLPub9IlW
 xKRahcGMc9SmWjXDWZq8gxTsACG9OPscHSzE5mHXAd_psFUK_YxHPrt>
X-ME-Received: <xmr:H1YEa5Nz4R5dctztn5dar3LwMFLBBnl2bN2EODXMKEPmmeIE3faNQH_gl1GPcYspLZzxBmY2iDM7fvSG8Nb8nLZdOS9BrL3WEIbT>
X-ME-Proxy-Cause: dmFkZTGB7n4iRbxkL5EKH5afsxNBGu5hKNBCu9NYeUwp8wHZTplRTS+HvL6v9Haw8wpEg8
 Zq2Qfrm6LlhHCfbTptsRIeUivsTnI7nIruVPWBJoI3pNIb8lBjYAnOrcKiv8u5fg0AODOW
 NH2AwKH1rEuKfFW/YIGG6WQn/KuGY//3Mkn+Oaw4soUPNDzzL/vBUWpJgwkDxpX5QCQk3i
 wGedWCQmOy/5wXfLQqwmF+d5VfOpIT/MIHWFIC9iR9FkbsufRA0wZL3ADXfJJgxtK91v4z
 edysda/X136m8zypSyqrCdxBUsCK/niHrGPZ+BrKOfTvrtczXoZRqTAMdSzA99Al4RSqCu
 wYWOuwc8UYfeDPbD1oSekw2BDhH0mWvheG2ugumDUJuDxCWsXNZEXfSwXi9bFW1Ivkrc1z
 lHXpFYAbualOwlh7CkfYO8nppkWJKmMsYlJ55XnGDwtJPGQ6ASbrvdXLZYHf4JSvbB/y7f
 KO1OSkK/PvhrqwQUT5cqxiKdguTJx6FR/I23G9Jm+/PkZGMWF/9AiaAXL3+FHwg7g6vduO
 tPedkF4QKC5P9Hdiqi8PXqRgeEsFVCd43IxIME73uSIVOu9AiXQTUNO0s1rHUEgiaRZPKZ
 aBWO6fBNlgccbwOanCcs3w7oP9Or5Eod6XlerdN3I3C45IzqFxyadU9VNe2w
X-ME-Proxy: <xmx:H1YEa4guJDGYPMqmH0Mq-kYIXGLrLVWjM3ZQMI4AXmM3TgPzHQ7Tlg>
 <xmx:H1YEa8s4PLcPhtfByLlLjyuPGwZHOZrsGJPMRYnNhMkri9vtwsfJ1w>
 <xmx:H1YEa8iRQ7Xaf34JkhdcoycXlTgCZb8pWp_SjewRVZSCerxsRxB-nA>
 <xmx:H1YEayaaPBO8mVc_fJkQQhouRU14CtAgl0_3-hN7Ssj5ZQL8USqIbg>
 <xmx:H1YEa1kKT2o_cR5beX8qMS44CjO0JkRFdWmUP_DigG5NjvUhnfeOZGU7>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:05:00 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:52 +0100
Subject: [PATCH v2 05/12] hw/nvme: get feature FDP (1Dh) fixes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-5-4c9893537cd1@samsung.com>
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

- endurance group is 16 bits, mask appropriately
- support reporting current/default values correctly
- use fdp enabled helper

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8fc0884fcda..7c7b31b46bf 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6342,16 +6342,17 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
     return nvme_c2h(n, (uint8_t *)&timestamp, sizeof(timestamp), req);
 }
 
-static int nvme_get_feature_fdp(NvmeCtrl *n, uint32_t endgrpid,
-                                uint32_t *result)
+static uint16_t nvme_get_feature_fdp(NvmeCtrl *n, uint16_t endgrpid,
+                                     bool current,
+                                     uint32_t *result)
 {
     *result = 0;
 
-    if (!n->subsys || !n->subsys->endgrp.fdp.enabled) {
+    if (!nvme_fdp_enabled(n) || endgrpid != 0x1) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    *result = FIELD_DP16(0, FEAT_FDP, FDPE, 1);
+    *result = FIELD_DP16(0, FEAT_FDP, FDPE, current ? 1 : 0);
     *result = FIELD_DP16(*result, FEAT_FDP, CONF_NDX, 0);
 
     return NVME_SUCCESS;
@@ -6428,7 +6429,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
     uint16_t iv;
     NvmeNamespace *ns;
     int i;
-    uint16_t endgrpid = 0, ret = NVME_SUCCESS;
+    uint16_t ret = NVME_SUCCESS;
 
     static const uint32_t nvme_feature_default[NVME_FID_MAX] = {
         [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
@@ -6528,13 +6529,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
         return nvme_c2h(n, (uint8_t *)&n->features.hbs,
                         sizeof(n->features.hbs), req);
     case NVME_FDP_MODE:
-        endgrpid = dw11 & 0xff;
-
-        if (endgrpid != 0x1) {
-            return NVME_INVALID_FIELD | NVME_DNR;
-        }
-
-        ret = nvme_get_feature_fdp(n, endgrpid, &result);
+        ret = nvme_get_feature_fdp(n, dw11 & 0xffff, true, &result);
         if (ret) {
             return ret;
         }
@@ -6579,13 +6574,7 @@ defaults:
         }
         break;
     case NVME_FDP_MODE:
-        endgrpid = dw11 & 0xff;
-
-        if (endgrpid != 0x1) {
-            return NVME_INVALID_FIELD | NVME_DNR;
-        }
-
-        ret = nvme_get_feature_fdp(n, endgrpid, &result);
+        ret = nvme_get_feature_fdp(n, dw11 & 0xffff, false, &result);
         if (ret) {
             return ret;
         }

-- 
2.51.2


