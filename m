Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41757CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq2R-0007v9-Ua; Tue, 26 May 2026 07:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2D-0007rG-4D
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq25-00024v-HN
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so6365658f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1779795188; x=1780399988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mT7QbTaANGil/CNOI49YqDveWeG282+xDD5iAGOaDs0=;
 b=dkDJ+jBD3bBFH1Yxsv5WH8t0bPB+jkj9UEwkZ/YtN9u4eT5sP/oj1p4Pv1ukt3RsoZ
 LGRp+tBcc51pit4UkELh9TRHI2qkf9ykY8ktGwpq4wqXukQ0hSGFJcf+ULwSkpdLQtlk
 cs8PgiLYEdU29xUzUEz2D5VB6JVenFgM6zbbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795188; x=1780399988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mT7QbTaANGil/CNOI49YqDveWeG282+xDD5iAGOaDs0=;
 b=D9teT+pt1IMn071HjV7KmQ6uJ43jObUcBXxkE/OAKSAkRUhxq+gQAGyQUk8NO1xewy
 weyLhnlDh5vyeZi31bsQy8z9nBahXiTWK09jR54fYNDpZFZziqEE7R37QGVfi4YOkTlk
 6OZ661wIifvdrFk5seoCCyk8ZkoRPHCsnFJtEdelD3HXtK8UAZOTJ7GocOGT9Xo/4pDA
 CBlxq3t+252YMtjO83ot8Ao32Hv3v0XQe1BcJWs/xQ7yXPIB92mGLnCJmNhB239K3tVX
 Pe7dam4GvNX0HfVY1DqjSv0B+hZBuNhUR85ZqUJtlc2NSiXy/BfTDCU8gpSyRH23NNGw
 Dzcg==
X-Gm-Message-State: AOJu0YwssK6G5D1dWAFNOfbhG8ogLDyZngPuxP0DzRWrRodkIVdXyIzL
 x6MKT6+/sADn0hiKW1WaqoSBQByapVyRPUJnEDug96PAbF/ERVeB/BdJmLuhINKD7B+6gkxZlSu
 esyivm9k=
X-Gm-Gg: Acq92OE/rbTnt4yzMS2ENxuGwDrjdf1fJQbaFbv074tBQ9Fxv9nYCLF/roNHW3kORuo
 PaSTJXT+H4dCTOYWJp4b6gzjNEYt91OCDWcQogpbxSPSQeyQbceb63XY7D2Y//jaDuowqf6DKJE
 sDO/KVVqC+Tod6pHrqzp5tVT2FcW20hqyCSkpGIwGPfs2Ro6yEb3r/C1XTc80kBE3mCBT5gE4tT
 oJH1UpXVdAxodLeYbCMbf64G5y4TsoP1vGJfEgzBiaWadZdZej8d2OlM2vr8lW7pRTqESN3z6wy
 FBILTX3e/JsdBUDR0+BMc6UFoV7zbLYFSH0ZdxXLG1grpPZomSOQJBBfGtjOCQ4Umuq21ymGT9f
 TNo7kb8e6FlsghMSKIXT/qfPcToKU/SeEd3Hrw9QiCfin+phGrhJSar96IdpbQk7o63+mNMdKQK
 Fu9LRpn/Y+kFnx8ShQ1wNloPZA0XnR7Fe2MaVLte83TSVJQ/Enju3eUeMZjbmpSFYxt4TxaK1NG
 3AyXAnqONOVlVEPqBAPMzk=
X-Received: by 2002:a05:6000:2003:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-45eb38e4b46mr31371621f8f.38.1779795187691; 
 Tue, 26 May 2026 04:33:07 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00840292fb31d0d80a.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:8402:92fb:31d0:d80a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4ca0dsm34366870f8f.18.2026.05.26.04.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:33:07 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v8 4/8] hw/nvme: set CQE.sq_id earlier in nvme_process_sq
Date: Tue, 26 May 2026 13:32:57 +0200
Message-ID: <20260526113301.91492-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526113301.91492-1-alexander@mihalicyn.com>
References: <20260526113301.91492-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Instead of filling req->cqe.sq_id in nvme_post_cqes, let's set it earlier
in nvme_process_sq.

This shouldn't cause any issues, because req->cqe.sq_id never changes
during lifetime of req.

This will help us for migration support.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 718459ae1e3..066fd2865c9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1522,7 +1522,6 @@ static void nvme_post_cqes(void *opaque)
 
         sq = req->sq;
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
-        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
         addr = cq->dma_addr + (cq->tail << NVME_CQES);
         ret = pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
@@ -7852,6 +7851,7 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         nvme_req_clear(req);
+        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.cid = cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
-- 
2.47.3


