Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B3606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=IjO0LF7o;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kElxl6lb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThC2-0005Uh-D2; Wed, 18 Nov 2026 10:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBY-000577-Nw
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:03:02 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBG-00041P-IY
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:54 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id BD31FEC0AFD
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:02:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 10:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795014155;
 x=1795100555; bh=/AnaGI/OvXrSqErA6o+8cCBt8Kvh1v8QbFQRuVfTzSk=; b=
 IjO0LF7oQj1UY8QRHqsTExE//Zm2cIQOniOuiKhQ42AimSKOfRxIUl5oMyvLhvgw
 ZML/N28yBYJByS9leo6/X/9HorXHsLRqMNKVOlQrlj6AMJr822p20YuDHZ/bisnX
 mG/ejAARpCjFZ20hnllE5AuJ76b5xtg9s4IZl2xuZBXiVChd967bczQl71EanZOX
 mvuzC/ExGWQPoOATD6B4+q26HLv9VZzIS9BfieNUj9ESrOVRCfZLLtXQjtweGCIq
 jP+iwwt21lTl50HIabN9tq+dIIFxvGVFcCtGAQku5rSkrAAYmUzGv1D0RoUsJp8D
 azfMHPtE5bTVl5RRQ/kg2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795014155; x=
 1795100555; bh=/AnaGI/OvXrSqErA6o+8cCBt8Kvh1v8QbFQRuVfTzSk=; b=k
 Elxl6lbKvqRuTJUNYGrhuDmAeV9einrY4gEkyi1OFv2/j5DLZJUVRcuoo/PzqzHo
 Z+IuyvJOgW0YK+cl/p04pbKllN/VQaRwJLetLXx7QiGcOtT9hPnDMkETkWHrpoRC
 yLTUAcCTSIcqjL002joBtYgSDlvZr8lpiKNVdsg/NPhu6E7fpOnJbuWuHyoDyHJS
 V4Rfh/byq6kZVq1ClLbKEUTVJj1deG6MnqQ0gG/cEXyz7DKVSQGKyylf6tQXUPfG
 cxSLwFymALCILtau73G/o+io0fuDA2cVMjgoPaiooYnG+iRdoe2vS0cPhC9zjeuj
 B1ko5wGT52V0f9Wqj8kWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795014155; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:HXsW2y7nWaxJKcE7RTAW6KSgWGBdmc8GnxpK3eCc6Mq8bUk
 TQGVEzJD4CEsa3zypE/GF0Y+nWC8XpA4HrWDzkO0+dpOEk71rWUSCqHy7TPpdT7A
 9hR/IkJDF01rkMf23N4QBvFAwhh5dktBPXXsMdSUZbnNY+otqQdh+JdLrDvFumDt
 t3cbmki/78wkc0fev4IE5hJAG4hwKoe1Cs6yDOOMkvF2+AffZ/W6NSz97y7Ezd9H
 qtpwDWYxmRmugetWFMiBtKOE7+ez0fCL8LXBVn3CTIX3UNKjB8NDmZVLL78EH94n
 Lo0SpkGMa8H8wXxiBHDmDZNGYLEnTxOYqyRjhYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:/6lOfPMkySs4cPH19ds6byrbAJgqlPBUDONnEqEdBtA=:KwRkgoRYR3oKb2Xrwiy7DKzRUwo/VMwNU4Q8mZcOlbM=;
X-ME-Sender: <xms:C779aiEdhr5FRPrcOYlSME10yj_D06IOi_brWU7A9ln09kjIDAVlDg>
 <xme:C779ahRV62sQN9vujt8iyg6k3Qz7YM8gQySN2-1lgbXaal76DHOY_79rxaPcDRGXm
 5FP-yNTHyZr1z_mLzsD9R2-CYq8MvNcZ97yyUzdoKAXqZNJJ8-Go3g9>
X-ME-Received: <xmr:C779audyhB-S3VUkTt8sKfVinp1QkMTf520ZNNilCE-G7VFLyshuu9drEpJvUaraS1k>
X-ME-Proxy-Cause: dmFkZTEb3vsAhEsk+czLgVLgpYCRht1vdkohoC7UopAIGj3NwdEa7iroZHyj5SkJgWMtSZ
 1c5iEYe4KFRrorvYenfcw5rGx9fJswQlfcMx/rXj9OF/wAw/8kM5R4Y7lXuXMtjHgVNeax
 GnG6V0FQcnP2B9HFSsEUm+VJ35DFfhZIl7EdN3F+3VZ3qRRt3eVBGMqvOC0SNQ8MGyQpDJ
 rWjg3WbD4EDdi9ec2CaU2k2YVfj8kprsW3Yf5bJYnpOqh5fhzwTusvnWXuPgX3CP+xi0yO
 eXCKUtwgyyRkd3Nt1POKvbeUAKm/VTGYmXQbkstcjsd90jXGppRUMoAZM6LjQ8bSFYpMJs
 0fia8lruLfsFV4hb773rar1eLvfAuulHCLLZg9Xb2yG3fdacqWosOcZ93+YFmc5RPYfZXi
 wYXIJgmaCb1HXbF7uSOvf1/oGJkzsfbC0yLd1tic6W9++aOTb3f5hz0mmkhNdLlYCgDtcI
 GKI2ldNsthUO9n6W1sXx3xhy1I6dOxjeSOb4lZldbrzVtKe+Js84JrZ8D1VhPJimESZCFC
 RQ05qTpi+5i+kIliX0+d+8MdX8RxNVbOwhcacApI6To8wlRngHMh21grxx/hW1CarBfGbR
 bAo6BSuWG/TsOohQoMmaSZyprrA8OU+LTg9vXubUrPfOF7apL6OQXvXZVeJQ
X-ME-Proxy: <xmx:C779agrRV_Iu8PXfq-S4PsB6f7cgFoyileVrjUieEpRW7gqmwy9COQ>
 <xmx:C779av9sWFq3m911s0nyFZK3zfdkqVvY-Zc9G9YuJXQDDw6M_nyvFQ>
 <xmx:C779asdRHe1JCjokPNLOfcy_r1YvqbGsGVsDVG0AyQ50-eaye3GMOQ>
 <xmx:C779apK6mNE7qz764L0aRtZnVsc8FZWcl8hZ6bJK0mN1iLJRnIELRg>
 <xmx:C779as1y3IGs4bIci448SBASg3H0P27Gyu9YX9Wxz-ZmXLthcQX9PAbJ>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:02:34 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Wed, 18 Nov 2026 16:01:32 +0100
Subject: [PATCH 5/7] hw/nvme: get feature FDP (1Dh) fixes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-jwd-181126-fdp-fixes-v1-5-ed76fad7861d@samsung.com>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.146; envelope-from=foss@defmacro.it;
 helo=fout-a3-smtp.messagingengine.com
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
 hw/nvme/ctrl.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8fc0884fcda..d82ff6793ff 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6342,16 +6342,17 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
     return nvme_c2h(n, (uint8_t *)&timestamp, sizeof(timestamp), req);
 }
 
-static int nvme_get_feature_fdp(NvmeCtrl *n, uint32_t endgrpid,
+static int nvme_get_feature_fdp(NvmeCtrl *n, uint16_t endgrpid,
+                                bool current,
                                 uint32_t *result)
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


