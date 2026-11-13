Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4857606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=QhzWoI7S;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rrGODUHN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRo3f-0007pz-UO; Fri, 13 Nov 2026 04:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRo3b-0007ns-N0
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:58:56 -0500
Received: from flow-a1-smtp.messagingengine.com ([103.168.172.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRo3Z-0004Q1-V0
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:58:55 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailflow.phl.internal (Postfix) with ESMTP id 3A7181382241
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 04:58:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 13 Nov 2026 04:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794563931; x=1794571131; bh=21T89aWnyd5ZP0jdAEIu9QLYoM8VQxuy
 WsQVw7Tc8CU=; b=QhzWoI7SLJhLUp+B8M5fuVbLUzpGZw3Opvgevtku1H9PrTWf
 qcT9rFEmAB1uoVB6NhYVahiwamMnVfl7SZpN1BdxEfByLtK5BLPRclrLiTTBfrjJ
 8vSjHxxjHjOLNLrVyNPxIHF53S4Be36EAEaHtUAJWOG/rQLi1YJ7TqS30Q/vk41a
 d5RjiBiiCvSRD4uLh3Jcti3lTBxxqrGdmYMIjDHJKg/S0P/WGW5/haaTyjLo3k1W
 997WBRXXrmro+QMcP1tuDmQeOEOpk6uRZs0yul4/ePUtjqSafYqllrxoX5/R+n3P
 vx7IViqLeK/tB7EtEomjmCai0TesJTVeDlcMEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794563931; x=
 1794571131; bh=21T89aWnyd5ZP0jdAEIu9QLYoM8VQxuyWsQVw7Tc8CU=; b=r
 rGODUHNXoFbr3dJLgnj5yQbXPCVJll/XHRpEFw38j1OjzToGx1NZeiU6qqQbD+Ia
 tCRkxhch7za2qhqlyxT+UwhRDYKc/F5xEWRFPRRYjz8Mkk6Q+In/almpBre9jBbH
 fmbRaQWvYYYNwL1LhFDPwVCvKTpPdAkOGLZIvKcO8U9mDTL5uB+EIc8DLe6h2QMk
 DQ/7Qtga3IGYbWeEbHV2sh+XZNBi7M7EO6YQJsnprKKIvuAUTymwOgow3gdL2uCr
 pV//KwJEYlTlRrjeE48dpRvRmO22SCXcF4IxA/a47k5kEH0CCzAwytFzzpjo8SBV
 7bIWUkUVFV/poX7SWeMkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794563931; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:bW3tsxvMngny3RPt2mIo4zqQnP14Yi8gmmiigXeFpw/KbjB
 drpsyRjLCd7e5eLb74MPEm9ZArSgIgu810BfOxxePu2R5EJumdpUSbwdfxXkMGUb
 I+ntNfVrea+7U4OBMhuJwR0w6Omcv2Ksai2kgk6znzWRU7WHJNvjjKElZBATz6HY
 amJtX8Q1UuamOyxa7NJaXrSsInitJ+vy9wLHx3tCMODAWx6zjJTus/7WjjVNP4ul
 EiZcrVBNqFsOLaQI+ctUGpluTTZ124IpgqHj5jWXvFIWSZfw91BMU5+uuKVtiJOR
 HLP+LRRKyAFiYDI4/EyD7eWLsu4m/RlLL+PIUvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:qra4ZDZs7mvzx6XigVwoCZbOD/AXXY1PRyhhkmDFXRI=:L3YslUKPbvG5anQS4sceAIfibWp5n69d5O1OwfBIW6w=;
X-ME-Sender: <xms:W9_2ajx1c7OpOAVh9aJkB0oU8-KPT0aDj4s4Cdx2w-l5h0YCgBk4Jg>
 <xme:W9_2amPx_M0QVXUJImmpRJIwrfzihUsqyBea7nfg-eiQrSaTTKQTNBW-eLMWbu3O4
 Sd9i_sD__fPm48B10hKc_85N1p37904H6UbjKcCsisitM1SUJyDzaIy>
X-ME-Received: <xmr:W9_2asUv3mSx2ZUfXlMba-bmFzcXSQGNrWyrRMF7913fZUCBlU13vtoWInna7TRsL3CCij68H9wkapNeWIe-8uch>
X-ME-Proxy-Cause: dmFkZTGoW/r+HHkPvpDPhLJ23+QC4nYba1HxO91KJlnQiR9zkGCwEYw+hslx7rW1vDbE4+
 kz5VFVK/snpzGpHFah5+BrQC5Odi347Kgy2Mlr5HAFrBCN6MezvbAWNNiSKcqirBY4p9YX
 Ku8dAAjbQsE4uZSQQ2Syh0wYsOxS/RAvnuRHNaXbbHga8A5xc+kCsfPUk9C/MLQ0RFzI+V
 28Zx/R3JCwUdoXIA8xPHpDV9qjOGPp4XXUOEV6BJxGO/m3rCoWoHVH2BcSg1+XollOGVCj
 rAyb3zo9XG9yafFAn9+wIglY5hkk3wGupF0KxnPeauCJX1uNNPPE5qwh7TjjzAKlG28qF3
 3daJ6bYwQxiMfjPRtPyHSA2OttYFqy/8LMuUoA88C9sL5eNL/6bxUbLXCrcd3/H38efDwP
 Xt3dLY/RTE6zjwZ9Gx2uBaH/CPoSalSP64mkemC+t2Da9J3A+ACbXiQW1ipAK6oY6bpqIc
 W2H3ODBQb4z6gKbRAAsV27rJO1lo3hQnQW/ioB1ug+iv0kR7MWFJWmEjeFO2AYVTeA77yE
 ukB7g6PEhvltWOaBhOMyMjfh8Bqqg4exCKVtgbGgiZXSYi8wLt3O9vyvxp5MqSllgN9OEl
 vZ0saHvBoDeRfcUK2nEdAVwgAVdWGhTACA6W/sq/NgGWrIwV9eVnELluQOBQ
X-ME-Proxy: <xmx:W9_2ai1Z728HZ55h72kKzpZMiUoEri3YvVm5UD5GDvLrO0i_TW2pqw>
 <xmx:W9_2aipCx9n1TGtrBd63CimVaBAV9RzNGo3b1Src8C0O-5sonfld7g>
 <xmx:W9_2ahVWsLizcQ1lJP34syB7Va4joIt9UCVoYhqXSOh8UsUTDV_N7A>
 <xmx:W9_2alZZfOmI2Hx1-b2EfSU4KdzGQbP1YFWWbHYCqLs7PJZso1c58g>
 <xmx:W9_2av1gTCvyV9blXO92TlSDo_Un87bg8z1Dwj34BueijwxC-ovBIh2J>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 04:58:49 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Fri, 13 Nov 2026 10:58:39 +0100
Subject: [PATCH v2 2/3] hw/nvme: fix fdp reclaim unit accounting
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-nvme-for-rc-v2-2-e458fd0e12ca@samsung.com>
References: <20261113-nvme-for-rc-v2-0-e458fd0e12ca@samsung.com>
In-Reply-To: <20261113-nvme-for-rc-v2-0-e458fd0e12ca@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=hKQJNRCh2YoQgXpD9PI9ciotEpdMd9zKsUp/SeTUJdc=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3IyMzFXVDBkTlAxc21aZ1ZTQ2VZNjh0M0dmCkovV0Q3TGhxMWZVb1haYmp1
 UUIvQW9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcTl0OVZ
 BQW9KRUUzaHJ6RnRUdzNwK2d3SC9pWUpwSnd2aXRTQ3ZiRVl4SEZVMHEwWEtCek5IOE5ibzF2dw
 pVcUd1NG5jZ0RyVDRzWGJFUW9CSTJHbEwyREt2b2ZPOG5zMDBBZDgwWldXWEZHODl2ZEF6RGtse
 k4xOVM1S0FvCjZKUkFvVEZDNVE1NEl6OVU0V1ZzY3djV00zVHkzWklmR0krdy8rY1hBSXNEeWl5
 RDdrMGpIMW9CZDNPNjc5N1IKNGM0QVdlNmpOVVhaQlpyZkNVekFQMXJRQjNKbkhWMW96RHo1YVZ
 EVjc0cU5menNBSGhzSXE2SEJpV2xDdHpvZQpzVjlaR1ZuREtkUUFPQ0wweXY5elZoMHVvV0Z5dF
 NueURXQ3J3bE9EdHZZU083bTFIY3Y0OWhwWHVaOGFuV2JhCkxERWdHWDBtdVBXbGNZYnNsUUc0Q
 2pyOFFKQVl1VldDS2hvUUQvbEtzUVI0cjI1aUxBOElRNlJPCj15M2FBCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.136; envelope-from=its@irrelevant.dk;
 helo=flow-a1-smtp.messagingengine.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_do_write_fdp falls back to placement handle zero for a write that
has no Data Placement directive or where the placement identifier is
invalid. However, it then passes the invalid placement identifier to
nvme_update_ruh which results in no update to RUAMW for placement handle
zero.

Reset the placement identifier along with the handle in the fallback.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 685cbc2f340c..a0d22dacedfa 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3754,6 +3754,7 @@ static void nvme_do_write_fdp(NvmeCtrl *n, NvmeRequest *req, uint64_t slba,
         !nvme_parse_pid(ns, pid, &ph, &rg)) {
         ph = 0;
         rg = 0;
+        pid = 0;
     }
 
     ruhid = ns->fdp.phs[ph];

-- 
2.53.0


