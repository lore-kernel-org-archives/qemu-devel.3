Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5AED116F6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 05:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4DDD-0000T2-Se; Fri, 25 Oct 2024 01:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1t4DD9-0000SD-2R
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 01:50:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1t4DD5-0002du-B4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 01:50:10 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241025054953epoutp04205d4600603e3537d7304c701b856cb9~BnCALmz6-0719107191epoutp04P
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 05:49:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241025054953epoutp04205d4600603e3537d7304c701b856cb9~BnCALmz6-0719107191epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1729835393;
 bh=ssWJTMsNxAhsuhdMkvz/IJlZ/4oeFVWVnZjD5GBL9L4=;
 h=From:To:Cc:Subject:Date:References:From;
 b=dG8T6dc07d8iDJP6/Ztv3Oy6MHEvquMpOHzyxvFhOinca9L5Ephc62dgp5zduyZm/
 bTLrpVMtFmdA0qCzjQiBaKqLYCSXTmbYDvPbgY4AmyqY+uTBgyi4NvObR66VNDLSZI
 pYmlEFpM0tosW2UOWA8oj2JY1TTNnFObPt0dwTrE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20241025054952epcas5p164eb3ea6fd6fbd571bfebdae086c1d73~BnB-oqI9v1913819138epcas5p1N;
 Fri, 25 Oct 2024 05:49:52 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4XZX1C5h3Kz4x9Q7; Fri, 25 Oct
 2024 05:49:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 EF.28.08574.F713B176; Fri, 25 Oct 2024 14:49:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20241023035127epcas5p241a150fcb18cbfc6975af8a8fc29d4c6~A_IB2SDPz3108831088epcas5p26;
 Wed, 23 Oct 2024 03:51:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241023035127epsmtrp1899aec5042e02145e2a636910a2a9099~A_IB1tnjP1419314193epsmtrp1K;
 Wed, 23 Oct 2024 03:51:27 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-f7-671b317f25a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C4.CB.08229.FB278176; Wed, 23 Oct 2024 12:51:27 +0900 (KST)
Received: from open-sourcing.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20241023035126epsmtip1ae9617c34b87c21bd2752d32d1b8e0b9~A_IA-SYbC1469214692epsmtip1h;
 Wed, 23 Oct 2024 03:51:26 +0000 (GMT)
From: Arun Kumar <arun.kka@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Arun Kumar
 <arun.kka@samsung.com>
Subject: [PATCH] hw/nvme : remove dead code
Date: Wed, 23 Oct 2024 03:51:05 +0530
Message-ID: <20241022222105.3609223-1-arun.kka@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmlm69oXS6wamjOhZz7ltYnJgSZrH/
 4DdWi0mHrjFaHO/dweLA6jFl2jV2j3M7zrN7bFrVyebx5NpmJo++LasYA1ijsm0yUhNTUosU
 UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
 9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz/q45x1bwnLVi
 6atulgbGbpYuRk4OCQETiUMr7rN2MXJxCAnsZpRo7+1ghnA+ATnfJrNDON8YJdqO3mOEabn5
 +R4ziC0ksJdRYnNDNkRRF5PE+d5bYAk2AXWJtTN3MIHYIgKSEr+7ToPFmQXiJb4tWgq2W1hA
 W2LX+Q9gNouAqsSxxttg9bwC1hIb1lxhglgmL7F4x3JmiLigxMmZT1gg5shLNG+dDXaqhMA+
 dolLZx9BXeciseX9dHYIW1ji1fEtULaUxMv+Nii7XuLMzD1QCzoYJZ5+h4rbS1zc8xcozgG0
 QFNi/S59iLCsxNRT65gg9vJJ9P5+AtXKK7FjHoytJHFv60+oMRISc658hzrHQ+Ll78WMkMCK
 ldj75SbrBEb5WUjemYXknVkImxcwMq9ilEwtKM5NT002LTDMSy2HR2xyfu4mRnAS1HLZwXhj
 /j+9Q4xMHIyHGCU4mJVEeC9mSKYL8aYkVlalFuXHF5XmpBYfYjQFhvFEZinR5HxgGs4riTc0
 sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNTqoGp7Ffcv8RVG1f+eGT4Kj7w
 Z6pXyPk/3DIdrfErr4eq7HaY5Kdlts9hQobg4aZfl/Oqg7xXr4ibHD77dn1e2JTq5umnd0e8
 yT69/GG4J//nyEyWpFrVpOlClkGtrAzne6tqONZ88XT4ruy+7I3V42vVLG/36fsyNhTf4tis
 9KnZ+WIh245v9pX/tlWYXttn2vt1wr2fzCV+mVlfAr/OK9jx4GDsiflLOCze6LwxeNewj+3L
 lJLJ50LUC3L6QtQjsq2Ouxfu19Tj+LTdkyUmQyPjekjPrJdW+7t2dk4PKM38krKyn91CJ2nD
 r+DM2W3sx7Ie1Pruaf24WyHC4+miKC7ewFv3HQ6f/mv/frbzmhdKLMUZiYZazEXFiQC+lYmM
 CwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnO7+Iol0g289MhZz7ltYnJgSZrH/
 4DdWi0mHrjFaHO/dweLA6jFl2jV2j3M7zrN7bFrVyebx5NpmJo++LasYA1ijuGxSUnMyy1KL
 9O0SuDL+rjnHVvCctWLpq26WBsZuli5GTg4JAROJm5/vMXcxcnEICexmlNi/fS5UQkLix5dv
 jBC2sMTKf8/ZIYo6mCQeLN7HDpJgE1CXWDtzBxOILSIgKfG76zTQJA4OZoFkidc/fEHCwgLa
 ErvOfwCbySKgKnGs8TZYOa+AtcSGNVeYIObLSyzesZwZIi4ocXLmE7B6ZqB489bZzBMY+WYh
 Sc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4HLU0dzBuX/VB7xAjEwfj
 IUYJDmYlEV6lEtF0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJM
 HJxSDUzxX+/ud3F4OM08V2qzuODqeeZlPhLLuIpT579ISLazUytU99/i515640OU2b34FUvs
 wt8eSf6+YR6P7H3p7Ksct9+aP16hzzzv3pvQjdcnOp6qcT/xes9hZX0XgY0vNhb96rrzN4Nz
 x0ktn7L6Job6xW+XyVZozSvwP/ifZfn1HTl/Vh4WvfvLScDhifLuLwmHal5NFm0vODejg5GN
 Qdkh7oHvqdsvNwrlfc49ycTCdzVF86PMr2qeHfbHw3jENlzV6D/Df+vgvrkOIgkbi8pYpnBZ
 zuL4/YbTK/SejEGB2hml2C4vraXir3mC3hkcOhJVK+P6O2r/zd3PYr9snfVzZ5iwhfrW+9N+
 mRtIZAopsRRnJBpqMRcVJwIAXrjunrYCAAA=
X-CMS-MailID: 20241023035127epcas5p241a150fcb18cbfc6975af8a8fc29d4c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241023035127epcas5p241a150fcb18cbfc6975af8a8fc29d4c6
References: <CGME20241023035127epcas5p241a150fcb18cbfc6975af8a8fc29d4c6@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.34; envelope-from=arun.kka@samsung.com;
 helo=mailout4.samsung.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.263, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

remove dead code which always returns success, since prchk will have a
value of zero

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
---
 hw/nvme/dif.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 01b19c3373..2805128498 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -575,11 +575,6 @@ uint16_t nvme_dif_rw(NvmeCtrl *n, NvmeRequest *req)
             uint8_t *mbuf, *end;
             int16_t pil = ns->lbaf.ms - nvme_pi_tuple_size(ns);
 
-            status = nvme_check_prinfo(ns, prinfo, slba, reftag);
-            if (status) {
-                goto err;
-            }
-
             flags = 0;
 
             ctx->mdata.bounce = g_malloc0(mlen);
-- 
2.43.0


