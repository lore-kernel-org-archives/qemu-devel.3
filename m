Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED212606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=dPd0WooP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=urGGahQp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQtV-00062U-E8; Mon, 23 Nov 2026 05:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xVQtP-000622-TT
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:03:24 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xVQtN-0006VQ-Px
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:03:23 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 981B4EC0B4B
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:03:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 05:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1795428198; x=
 1795514598; bh=iO553wUmbCdVfJPYdNnAF5Iq2rjhtVz+pi/pEYiHtOI=; b=d
 Pd0WooPcPYN2Or99LWKQqK1/gc3Rz+tr9K9wL3vthagUhA3DUnqAkZCR/pknGaLa
 YIoDW5WZqVp+ZqPhBCUUXiLo9Io6CP7bwt5bZQiOeDYAnSwlcJSwDKkL/Bbcmhgs
 CKKYM4p5OhAm5zFWXy5idF942AMZPoMfbkhKkRS3qcgRd3zCHTfDyhF/9kxL78It
 aThSxzLtfk5dIPJvNC1qb4OVpT9ZtFr+zufDUBY1U2JATG2qI33KuQDzdWPnx0mi
 bcj92HjTNhPFmBUsL7oGbmi4b5OioOkOX7dQKkoQlsgZB5gg8cA/1ycbM0Qoq9Y8
 8CEZPZKtnPxz7xVi5Cv3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1795428198; x=1795514598; bh=iO553wUmbCdVfJPYdNnAF5Iq2rjh
 tVz+pi/pEYiHtOI=; b=urGGahQpYQl5L0Jjv+PMF28QZzm1jTLKUPuuiWffrfPW
 DyYxvRGiuD8jLHDywkdtzva1cnjRADmJ51oCiyaP+cVFhc8QYmeTFjPz+ac5siQ7
 j+3AY+Tzoui4fJ3BDXfB5EZAVKBS7aWfKgWI6g0dWuOyhaXlRy6qVUgBX5M1AFD/
 O5LyRWLAyyNovSZOs1rakQPkjhhQ7QhD15WXaqW79yiosGisZHAG75Ism9kasrFj
 A7bykxmkqs28QRdjbeDUOg2thqQ0lr9Aw9mBX7VprdFe9R1rfg/oannTcsIzjV2x
 RqTqOr2PYwTI56h4otVkIqflWOPxsPxuwpC/5LuOOw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795428198; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:HfAlK7CtpD6p6or2r2aEnFs0i59FzqTp07EhAXkXORDzUgw
 361MQFW2fagmiguZEf846nc28OgnQvxzt9EeytQdpCPXBifzni15KjWPoJ4vnWAM
 39CoWC9jc/CTiIpj9JbUAab3bJSrCzL/9A8mj0vAg2Y+Qcup6Er8Flx+HreaMdIQ
 iAgPYfjz71x8rIJfcbO9/4YU5GLMzivydISF4xqewbisYajQiuK5QuodO3SdgC9V
 oRKE977H45+kUGkfPY7c7FBnsSKv1RMJj9lcggwLoNtldt1POo2cH3KgHGIlZ9MB
 J1wgkI9Ta2ELcFPbyMGGFdvicEIMlo3ydK9vvPQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:YrFBKjiYT7i7WcwKL9WJRc6vCuDqDvfwiQBI3epAT10=:Uy9lxCgqwwCmnfkDt+4VVkM7ek4WyqhhKwQy8QZ0UsU=;
X-ME-Sender: <xms:ZQ8Ea4LTWqkzaECcjlGCEEchs61WeDOqjLPTy6r255MbHTs_pXUA8A>
 <xme:ZQ8EaxE0h3GqKTmW8chrxK7jeBWNLfEXQ9SGdaENj6ugIBLSI6YGoqbEwY5062xmX
 Fun5JK_dKAcDZouRp87EJU97GByFqpMA20WriWmOZcV9AYQkcnKfape2w>
X-ME-Received: <xmr:ZQ8Ea0S5PeP9OwjFKnC1fD0Lnth73VxmLE_UQ_mWYlCblxYYuCtRyml9x9zgWyyEey6AVVYBh0bAXEu5s8dKrZCx>
X-ME-Proxy-Cause: dmFkZTGSqzCmKciX4tCOMd8rvJXf1xY+im3kp0DxyaXSPEWg6ttK2GEOnl91dR40v48c7u
 1hoqYuOJmfbzC2dk5PyeDhctjbM2dj4bayM3m38TBxj4ESfgdcfWM+XkWJIEeXZo6znNSS
 4BdteqS6nEvl4X/mTglK4/yMy4sAR5r9y6zO0neEwZPNS8lNwYbE3uNpR/lo0MogoJTfdv
 nT5smzlqe8Eko4sBkaYZDK32sZh/AFW1Mvl0DbsJO/0+EeTE6jqfJKDuIueOui5NIDs2qE
 h+q4EMmblnwC56v3sxPXO8/hPGPDMiNn6RX4iSDUBr2McMPFp0S/zA5dX3OLZWe+Rjsuax
 Mks8hG0njARqnFCLgJJuHzl18p/yW9vC49n+k3q7ZMUX0zEI9vqtiJvYnVpS0trtGTIX/K
 usY6sP2p90Y+cImAGEI/sO5gudm4iiGDFSAMciBTNKvlwWmHpCpEL39OvZfCN4ckD1g+x2
 Z8u0s3CGkRarbQ53uFxCHGNEavIiLeIQHaaXIvAk4CAZNOZX2IHgGAVUvpHmitZIT8fkDM
 f/5HFcoX1phkOdKUNZjogqlKE1jWNhLNNnUCkwRwsrrdaK+Neb49FbH+2aJR7a5adnetBy
 VZXNyCoaI10draoX4QmSVDzvCkrupJehKPPDS3FyihjSBiOS9JI38iy7T5oA
X-ME-Proxy: <xmx:ZQ8Ea1c73O-VaujA549tMruWvVWw9OcCW4D7HjYRU20illWe51Uwgg>
 <xmx:ZQ8Ea7rIDG1Xe_ew8PAn5FEQcuOIIczouIW3PfwDTEXZpkbQEKhYGw>
 <xmx:ZQ8Ea-8CLiYOllVuQKEBMeb04TMDnxUiJD7dgCgtMk8DN-GaBejmFw>
 <xmx:ZQ8Ea_fIA_Xbf7pLsxkcwsUxlGz7NZqqso6yqpA0AfYUv_owPdeiJQ>
 <xmx:Zg8Ea8uAobEvZ_eQfmWg5RcSHHjzAFr6ma5ySMisrh0b3nRbQSdBFHaS>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 05:03:16 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 23 Nov 2026 11:03:13 +0100
Subject: [PATCH] hw/nvme: fix use-after-free on duplicate dbbuf configuration
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-fix-4902-v1-1-342b8dc00fef@samsung.com>
X-B4-Tracking: v=1; b=H4sIAGAPBGsC/yXMSw5AMBAG4KvIrDVpp+J1FbHQGowF0iKSxt0Vy
 y//I4Anx+ShTgI4OtnzukSoNAE7dctIgvtoQIm5UqjFwJfIKolCd1ZXhEaXWECsb45i9l017W9
 /mJns/u7hvh8Axj8FbAAAAA==
X-Change-ID: 20261123-fix-4902-3ac39e2b3827
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=TchdWYy2FUUcADCa0PhNYAxn514CduUaEfL8Sd3cfh4=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3NFRDJOb3dzaVQ5OTM3Y3ZSaEhmSFRCVm82Cm05VndBQnFRM0phN3IvdzRE
 YjlWZm9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKckJBOWp
 BQW9KRUUzaHJ6RnRUdzNwWDAwSUFLRjAxaWQ0dHVtUTlBTjhPL3MybXVaWEMvM2NRK0NBM0RGRA
 p6ZjQ4WURNVHFCRi9lRXRCM1kxNHZmVDZrWFhtMDROb21qR1RBazJsazBIZ052QzZsZjBidmdWc
 3dtYUZWcHR1CmYxaVpSenJ5aUdOQldTbUt3bTRWdXNaUUdxUkVMQkxkT1dDd3dXUit5aXV6Y2Np
 dkNWOFdUcEUyVVRVS3NuYmsKSGlMSlVQTjBuMUhqb015Rlh0MVJkRFVGdWZzYVVPL04rQnlSVjJ
 mZTluaWNVU3hxMzZHblNNVVJ6SHN0WjZvWQpFR0k3czc2MjFjdlR0QjZ2U0tBR0RSNVlsSjY2cV
 B3OCtseDVlSDRLSjdlT3hxeE9HMFVPRGNmRm9Pa0pjbVdjCktvRjArYldwYzNQS0ExL3BmM2d4S
 WNUVGFoSDFhcUhJQk9rM0VjWDN0SytCOTkrNzJkVXJ0NnJkCj1RbmpmCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.151; envelope-from=its@irrelevant.dk;
 helo=fout-a8-smtp.messagingengine.com
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

nvme_cq_init_notifier and nvme_sq_init_notifier does not consider that
the notifiers may already have been initialized. A second Doorbell
Buffer Config command will re-initialized the notifiers and leak the
previous fds. The leaked fd will remain registered on the doorbell
address and may be dispatched on doorbell writes, referencing freed
memory.

Make sure the notifiers are not initialized more than once.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4902
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5755aad1fa72..7b5f6178dd36 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4837,6 +4837,10 @@ static int nvme_init_cq_ioeventfd(NvmeCQueue *cq)
     uint16_t offset = (cq->cqid << 3) + (1 << 2);
     int ret;
 
+    if (cq->notifier.initialized) {
+        return 0;
+    }
+
     ret = event_notifier_init(&cq->notifier, 0);
     if (ret < 0) {
         return ret;
@@ -4866,6 +4870,10 @@ static int nvme_init_sq_ioeventfd(NvmeSQueue *sq)
     uint16_t offset = sq->sqid << 3;
     int ret;
 
+    if (sq->notifier.initialized) {
+        return 0;
+    }
+
     ret = event_notifier_init(&sq->notifier, 0);
     if (ret < 0) {
         return ret;

---
base-commit: 8f66cb79044c370e3813c56ceb7a75a5ca2d0a0e
change-id: 20261123-fix-4902-3ac39e2b3827

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


