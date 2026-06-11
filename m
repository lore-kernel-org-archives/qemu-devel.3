Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D04CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdUz-0001Qa-HH; Thu, 11 Jun 2026 07:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUw-0001Jd-MZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUu-00016k-Pu
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so5479847f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781176975; x=1781781775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srlFZliq3fb8dZ8MUjWEZdk1nX+hqV3YhWF/DVUMbMs=;
 b=NgkDMS0TOuzSzvoTsqm4YZG+jt0mq5tmrSoTm6z6xd8qpELZuuSwX/LkxGCWPAgtaV
 DvySGC/zbG4f4k4cX44Spdny/F8bnf7IvmZ26LtdtEZVS+qk1kbdyYB5cS5qRPMbjB84
 mbwmJ/47+OKp4E3l2SIbWrKf1EPdsUDLzzHpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176975; x=1781781775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=srlFZliq3fb8dZ8MUjWEZdk1nX+hqV3YhWF/DVUMbMs=;
 b=f1E8ImCxNYuljHDj9NvAmffsOzk4Igqimo8b1xiu9wYopPE0K1Fn8EuaaHiPeMIsn3
 oUZScGJ5sOoE3rTXr8Z/kI52H3oNFYk8xt4P+NPNa0GYHn4rZYlkTwR8ABVYeH17J5o0
 B1/cftmVMd7hPSY7ONgHpGAMgQFGhAVg1U8fn4jzQWD5Zx01/QGHPWfbcGaKg6QeVara
 7QHEEBmVkkK66yFW4FxHKDD/s2qDJLO4Ld6nQIWFsLJK9V0es7PeiqFZs4TmSjOKRnap
 v7h4D9Idgeh/eknvAktE5nDrDiRqwkVCMf7L4MEybinqnkSzfYTZTcHQ/WKC7PPyiab5
 yO0A==
X-Gm-Message-State: AOJu0YxMAsebiCXZoDSlhVZfOcoRy5aDWKdUj8C0lLBCW6fKsryP1HH+
 VM04mQfsIBtElBLtXEEmV7rvxUORRsYPwGnJ9pDJf0kceBw+iVzPIMtM4ez4CkrZVzLKJBkKHAr
 4UkM/qDo=
X-Gm-Gg: Acq92OH+u2clJFU0qYxEzbhZP3h73gcdMn2cYaJ53RWhf2YeMUSttmAO3WH7eCnHAl2
 s41a7ydk0BGO55PygBL5IDCv2n4QuZKNIRmEdZ3/iSSuTqQjTsusAPTgBAxBwvzdoAvwb4SKK0x
 hjRkWfVDFNVYSqX5vyBKogeZXG8FwanEP2EyElWOpguRWcCwbHwjazHC0FRqVAdoVwXmJ8dLUka
 /AhgVzdkrFbcNBqcbsSkW8OjYJcpOmqNN/Umqv/neK+pktIFav6cfWataRfLLzNVOGEDI0Uq05F
 8WkHTg9THBUCcR75nS/JnnkTMDLfpgnJ93YbYt1hdZmwL6Otyg3kK8qlkGPZwFQzy1vDFXVKPcz
 w3LUvjk1HKWURgiOsvWIa3mB0bfxQ3Qkvrz3XZkkJs5tpwZX0/VxTHHvkOU3Nk+Fs1A/qwe49As
 SDEFhIfP/lhHarwBpuGGVbmeE26qCQyWbBRwdoiAdazHoWKbJYyR+mrQXT6o5rHbFnNwVpWTHGl
 xsdW62AjpyRLxAK7GulSTKepUnqyIPH8g==
X-Received: by 2002:a05:6000:18a6:b0:43b:5097:6f62 with SMTP id
 ffacd0b85a97d-460677a92bcmr3772519f8f.36.1781176975279; 
 Thu, 11 Jun 2026 04:22:55 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006c26edf58ff062dc.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6c26:edf5:8ff0:62dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fb24sm86375554f8f.34.2026.06.11.04.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:22:54 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v9 4/8] hw/nvme: set CQE.sq_id earlier in nvme_process_sq
Date: Thu, 11 Jun 2026 13:22:45 +0200
Message-ID: <20260611112249.165012-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611112249.165012-1-alexander@mihalicyn.com>
References: <20260611112249.165012-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 26bb4b52d4d..5569e6872d6 100644
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


