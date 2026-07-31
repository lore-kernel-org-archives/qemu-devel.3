Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8837C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpjWJ-0005oX-5V; Fri, 31 Jul 2026 05:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wpjWG-0005nW-So; Fri, 31 Jul 2026 05:27:08 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wpjWE-0001d4-N3; Fri, 31 Jul 2026 05:27:08 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id E204D1D0016C;
 Fri, 31 Jul 2026 05:27:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 05:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1785490020; x=
 1785576420; bh=KOOMb0D5svrakPg+iU2M7ehHHrN17iSGMopvDxW6sVI=; b=b
 FSoQOiD/bP/zXRPNxvepl4YUl7//XKkUkld/9nJg4h6sWHrJ3lu1GjUE6mhd3qOy
 4ndz8XpKYzprcjMjTKpaDWqFBV2r/uGaVcGsztsBDE1fwlt8xBIDildg8N4SCQWY
 X+huwEwRfQ9adZv9YtT+MppeD00CMkIZRdGEebDmxyKzxq97MZxCHZE33G6DkQpz
 PgUBoZh10WZwWp04jWut9PJUvtnNiVTDI2/f9iu/dvoIXDfSoJkAA/5IKV2fMM1C
 QwhvmLge24U5DMtkmyvsA0zFkY1xJcdiuAyhr58io5FL9KUakrDRDqcVIKC+3NtU
 DYjBV23wNOWXfGJoGWkhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1785490020; x=1785576420; bh=KOOMb0D5svrakPg+iU2M7ehHHrN1
 7iSGMopvDxW6sVI=; b=Vr+3K2Gn22l2Ebhw9kGm4xHqARXKoBDpplaA8PhLWa4P
 whgasNYauTl08JBynnrwqq83nvEHXmK+9nRUr7CLMJIMNx+Hf208dNXhAjARg6Yc
 k7HNzcKwR5/xrh2Bn7cD9FafSvwxH/8zKyQseUbu/f2oBrPinApMsfk4sityJ65g
 FczQaS5nUtil9K2y0ESEP9yUrL/2kOGlXV1cM6dDFwXxztg9AkG7dstqb1zQcPa8
 +qrLmksVerne8ThEbtxAqb5eFIaOq9V1pzrduREi/Bs4hA2Mqe6njtzxxacEcD6W
 lNrU8XSXMnzEIpawW0wHn0Qof/G2kjUBwuHh3sC4TA==
X-ME-Sender: <xms:ZGpsajVhFpPo6k3JrKsQMi5kLyLfA9_l0kYiLdA6Y40BNmKavXVwuQ>
 <xme:ZGpsamgg6d2I_bbEPBSMPjppfLG2y5lgLxOdJKIFKUatO7Y99eqzP8XYVpjMYITUU
 J3nedWrl5VImERKYVCUfS5PnmL9lSg2Rp80nRayCMqtXjCSeKWicg>
X-ME-Received: <xmr:ZGpsauaySA1LnnRnbmtt9SgghsZLw3UwvnzAjNQU-8mEwgG5lkl0AnTZyrZxGpHTV5k0MInmqEtqZiTXOZ8OXF0>
X-ME-Proxy-Cause: dmFkZTGnuSY7SH7N5RD7QFZdanjGA5Iym/DdeThHBMuSFIEQ8E7gWOMk7P8aWVzg3c+un2
 lSqUu1Ka6lIXl6ahL5+OPgSaRQ3+KvO9nIXawUyAsGUC84Vqt3Tp+4APIcNdCFfIBYjfyW
 Yafn14p0C3wDOKp/KqNcd2esA/tg9qM6dEujkYypFDS1ZrrdK+sYUFG8RXb2JmT4dKBt6I
 t7cJ47choAzAD7uFgebzdvykcQRn/Rv8avpPMDNBYtq+uaRFjmN7mKjlJAKKXBCcJXR6ZV
 zVQg4wdHPGjbo4X5wm+IDTSoteqdQf8OlWib4K9U+8S1ZBvIvsnftvT4DL0xp9q3fFwzmr
 f/T5loVHeEUQd/lzmGehIG5D7aQ49Vc5uvo1/8oQcibtyf+bjA/jVY1QJFJ3bIcpO5+TWJ
 FGYsm5twI9MlXkUJ+z2eDnPe6vEDXuxdKFdKE0s6L9twubI/yWFO6NXXe/q1Q6LivXLjO5
 xneveDut9/Wuehl7NFonnnR0JItLU0lAhRykCTrWEdrB5QVYTI300M9dDaceK3z8NPewCy
 iE0mO/xG24J4w9p1YFZvKNGTpI5hxCaVMxYSWwoR3ZNO92Nxh8Xx8MjTQloflEbwT8EkUM
 of954WZqiBujzadZbGu/BU76DcYS6suIC7v6xZskfRI8sEovl/+CbQSZ4pHA
X-ME-Proxy: <xmx:ZGpsajrUhFc0RidOe9afZAOOCgicL0tf6EIzg2w_-rJkga2vtCdRIg>
 <xmx:ZGpsarNU9nZWOk4g8U9f2hesYEVx7g1MuPNGMS0nAu5d0_ZmMkMl-g>
 <xmx:ZGpsampQrtQg0M-Ka7vIBmmEZiHnQGIoSJy6QxVNxs9B6ZT_R1sZTg>
 <xmx:ZGpsaodN5H9TiHQPGnSg9k7E5fzI-ZYwzlHVP86i1KPqbfs_dApAHQ>
 <xmx:ZGpsaoALs8Lw-d0LOOmqNxBHSKjgNd6yxkcBS2zdTMYCVmiPVtbknnxC>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 05:26:58 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Fri, 31 Jul 2026 11:26:53 +0200
Subject: [PATCH] hw/nvme: fix leak on copy ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-fix-copy-ranges-leak-v1-1-a344434c9925@samsung.com>
X-B4-Tracking: v=1; b=H4sIAFxqbGoC/x2MUQ5AMBAFryL7bZN2UeIq4qOpxYYgbSJEenflc
 /LmzQOBvXCANnvA8ylB9i2BzjNws90mRhkSAykyqi40jnKh248b/bcGXNkuqAyV5KqmrDVBuh6
 ek/dnuz7GFw+bnedmAAAA
X-Change-ID: 20260731-fix-copy-ranges-leak-06242c584712
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=hyqdtDEF3jBDHZJDZoOVYo7ldbr1DEzs/5BLJRN7kxQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3BzYW1KV3ZMMXp3QXhDS1NuWUUralE1Y2VQCndWRWNGcXVTVHNYeVZvRlQ4
 QUFHRjRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcWJHcGl
 BQW9KRUUzaHJ6RnRUdzNwZStrSC8yNENJNVZVcm5oTDl1OEZnRjU0Snk1cGc5dHJodUlyODdUUg
 p2M3BNR3FsVHlReU9NUVRoOGhvWVpmbWVPY1NaejIvMHZwR0NoM3Y1c1hNeWdXMy9NMVdwK0xlN
 lVKOTBNaTRzCmdPNlBGOEVpcE5qcHR0ZDFubVJpbk5nUTVQemtkaEw1bUlwTGhMS0h0OWVUQWxu
 NUE4MHlnL3ZaTUhhRUJhQmYKV2czN2o5Q241SElWb0ZnN1VUdzV5SnVNVWc3K1FPcGIwUWM1OFJ
 sdFJTZk4wUDZZb0hGR3RrVkFLNGcwQ0RhSgpDM2NhYjdZaTV1THNobVlrWnQ0NVY5VWJsTHptWE
 1nQUVER2N5LzA5alk2NG5HcWVKcG90b2NmQ25LQlJUMkJVCmdXT0dZRjJBVEYwTlFxemJBTWpNN
 HFOU25RWXVNOWFkOUw2ZlFRc2hnbEJBbWhkbTdQRUh1Nm1TCj03RW5HCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.146; envelope-from=its@irrelevant.dk;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

The buffer holding the ranges for the copy command is not correctly
deallocated.

Fix this.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4072
Fixes: 796d20681d9b ("hw/nvme: reimplement the copy command to allow aio cancellation")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index bd6ad64b2000..aa98f7cf8048 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2811,6 +2811,7 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
 
     qemu_iovec_destroy(&iocb->iov);
     g_free(iocb->bounce);
+    g_free(iocb->ranges);
 
     if (iocb->ret < 0) {
         block_acct_failed(stats, &iocb->acct.read);

---
base-commit: 0345ef676befc1a180d2f63bceaf3fca1d07ee88
change-id: 20260731-fix-copy-ranges-leak-06242c584712

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


