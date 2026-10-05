Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1604DCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhLF-0001Xp-6v; Mon, 05 Oct 2026 07:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKp-0001Uh-R5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:25 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKo-0002yE-18
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:23 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 360447A012E
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2026 07:58:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 07:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1791201501; x=
 1791287901; bh=B7FvqKu3aFiGVZTos9xZIqlwk17QZCSqTyNct9jdkMI=; b=7
 IBInQ9iRVcObp+hrc96eonid8wPJeUlzDOUkwC6WyCHrKRgBwaI3kHG0o76QJpO7
 ir1p63T8UuH0EearS2n2YUOPzkoZFn1FMGV6ZZZIBUyO+AlrwdvmARcBE8lWfcmD
 JOMYhFcZUFQhZE49XDDlM6YRvFLNTFFgo+opvKBL7MKeYQ1qk53irvrgCg0A4NW8
 ZQVuddq2PTfgP9Kkpbf58ZNqJOh2btecwrxrz6ztQ+Ir9vRulfms0fi1hgfhTb4j
 k3+I+y7AJ9qY/I/wF8pWvrgk2Asecq8/doavknC2CmriXoaJ8NNqWVTCKJjBsKPa
 SvNkKzZBz0SR6qy6Sy8Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1791201501; x=1791287901; bh=B
 7FvqKu3aFiGVZTos9xZIqlwk17QZCSqTyNct9jdkMI=; b=MP+wUnqvg8tv7deRp
 JYfOufsneiw6vNd4DWm4hkHAsKN/u4Y9O4Iswj/rqNRB1ldyB2c41pbtRhwVK0XA
 6S3CiP3lZtpaNbvU7cJvoNvy9uQpf+HhuqfYIoPPFqaxmtSZqKRAGaG+KkBPEtsx
 WfeTEfr5wfatht84e/LORneQ+28ENqHJKIkR9KA17AHYICXGy6ojm4FDnNEb+oT7
 ZP7ZPyUNaEmOHAbr4dwt8837yEDbbl1wphXoSoTxZYKrjUYbqAEfLxpXqiMKQLQE
 VSW/KP4JgBf2TGU57jSK9CurtSrBKD9hm94lPxymUUpW9F6LFA/WdVnhNzC51g+s
 9dvIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791201501; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:j1zNoXypwtclkm82PIdGbqaF+sqBNQany7GWfI9d0zwjNVL
 PyOwA2hnILNFea9nsuVAHbtLtVpGBoYDfaZlgmEYzYHYy8qRyKbfZliZV6JwISR1
 Lhp8JfwRkcGQJL0bi6DRYwM7XLY4sg57x5+Tdg4jreNyEPGq/n2W+VFrNM1Wxx98
 etmkQrJxfYeLowS9T6+ftR1a6ihoYSPjGimaefYp/+xF5Ad+Jd/FAt8ggugFsAx2
 Az6wfpoudky2PpBZYwYWm+jKuxhpFyyEJ+4MeUBmyFbg7bNTsHu9YMHNOio+0u3k
 V5Jd1PZ5eZj0cMkdzRLODzzaRkxGNZIGUiiYNCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:nS3487K64OKgAWuPIDuF5qe3eFI+cQq06a0zhl0Uh4g=:GuHmSuPo4pgdznOI8ol8QJF0irKZ0dhV/BfYVqcGknU=;
X-ME-Sender: <xms:3JDDamxWk6kW3-RFfXgbdiKXHtJpzQW_mgdO0ax03sS7tjTBz_KQcQ>
 <xme:3JDDauTRqMess6v7K46zhjr_kphKprGi12QriFNxHshJCJiBsu3HvrvuilZKbOO7h
 kJSXJTQjf6yqU2Fe2s7wUs6L1MmXDi94dequmTpSy8yLiPHF0tx5C4>
X-ME-Received: <xmr:3JDDaqiGZ2iazQPu0q5JydEohRNOfZ0i4WENZw2ttgN60q7wRTqpvJfzt5HvtdJe-mDOmSzCD2RaTIQHciah61py>
X-ME-Proxy-Cause: dmFkZTEr+xmrqVGlVQGKS+bQ19SBCupADr7Hdv3MLlYOmJJ0MHpcGBVX7wqD5lzPTIvynB
 3Z7xCzf/9N09kBvoXTuT/jDvRF8pgZiXd8K7UF45X63MTAjNTmzBXogOUz2NqoJ/AIU0ui
 QVACBXTrXIFHdjQxbdPBca+AbDua3wZNoq8iqf7GWb8Rpl5PWnY1cpPh9s6B1Djg0gXYjJ
 iuexN2Z4QEn6q4Pqa7RSW1oF5+CdzLm0KydieObKFnQL5JMZ5ROLoF5dosd/2BfT/YKZmJ
 Pxl/3KtExYI0YoOpy2pHP658F+mvvlGXHM6P39dTEl5srih6JlOC+ix6hCTMWogIDu43iO
 iaKeZ3ug2j06JII12Np0/CvXKKOgnaKRRN+XGJDvxFEfAffAZPbiTiX3jvX4geBXysLddy
 Ofg1/6Q/cFbfFh/G2iX2snwq4UXB+zj6pqehWJFj2VqezHPx+LfYo2pQmHKAbaDDwA27aV
 4ckiuqhQbtDGl9fOQHwhKYjNbZ/y/Bvfyg39fluDEdq2PNtBvUOM2UKuLwTVg7c1lvk9eX
 uU/0MVrdNzTr2d0tKSHMCeaHAlGix/TXeZ5Hjd8kZ8Dd5usx0G0AyeQ6Ibs/Xk7ahjWY0Q
 balIv/gb2+kMNBGmxFEUSjg4xmlP7n9lPU3jIJ9vXJqEhm/fKleL5yKxG6AQ
X-ME-Proxy: <xmx:3JDDatklo3wsAwSXDp1-c_N0ES4HwU8VswwTojN2uz4FyuplY-0ztQ>
 <xmx:3JDDalvooT5XrfwUM0CWe83HRRlm2vHQoM0YEnyJlPnev3l6Wu2XDw>
 <xmx:3JDDajZmIk3UOKa7KDCqzm-u5UjxrHEPmMVRRJMmZK8n7FPyAsxfTg>
 <xmx:3JDDatA4wk4jV9Lt4qjYcVngL0Na8aps5je81Jj0QQGJfKpDItFopw>
 <xmx:3ZDDambWQuoGcrgg0MEO6krWjMWdqjeDPd-upD9kQRn9mO3Ht7w3iuuW>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 07:58:19 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 3/5] hw/nvme: fix assertion failure on sr-iov capable nvme
 controller removal
Date: Mon,  5 Oct 2026 13:58:03 +0200
Message-ID: <20261005115805.99042-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005115805.99042-1-its@irrelevant.dk>
References: <20261005115805.99042-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-b4-smtp.messagingengine.com
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

From: Daniel Paziyski <danielpaziyski@gmail.com>

In a nvme subsystem, the ctrls array maps controller IDs to nvme controllers.
The value of the array elements can either be NULL (no controller present for
this ID), SUBSYS_SLOT_RSVD, or any other value, representing a pointer to the
nvme controller structure.

The SUBSYS_SLOT_RSVD value is special: when a nvme controller physical function
is being created and is reserving the controller IDs for its virtual functions,
it indicates that the slot is soon going to be filled by its corresponding
virtual function when it is realized, and on virtual function removal, it means
that its controller has been removed.

When the physical function is being removed, it goes through its list of
secondary controllers (virtual functions), ensures that their slots have the
SUBSYS_SLOT_RSVD values, and then frees up the controller IDs by setting the
NULL value. This traversal occurs before the virtual functions are destroyed,
causing an assertion failure because the slots contain as values the pointers to
the secondary controllers.

Destroy the virtual functions (and therefore, the secondary controllers) after
they are offlined in the nvme_ctrl_reset call of the physical function, but
before releasing the controller IDs of the secondary controllers in
nvme_subsys_unregister_ctrl.

QEMU command line (boot with a hotunplug-aware OS, such as Linux):

    qemu-system-x86_64 -M q35 -device pcie-root-port,id=rp -monitor stdio \
    -device nvme-subsys,id=subsys0 \
    -device nvme,subsys=subsys0,serial=ctrl0,sriov_max_vfs=1,\
sriov_vq_flexible=2,sriov_vi_flexible=1,max_ioqpairs=4,msix_qsize=2,bus=rp,id=ctrl0

In the QEMU monitor:

    device_del ctrl0

Message in stderr:

qemu-system-x86_64: ../hw/nvme/subsys.c:49: nvme_subsys_unreserve_cntlids: Assertion `subsys->ctrls[cntlid] == SUBSYS_SLOT_RSVD' failed.

Cc: qemu-stable@nongnu.org
Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 3e8a1c8b77b1..1047961b03c5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9732,6 +9732,10 @@ static void nvme_exit(PCIDevice *pci_dev)
         }
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
+        pcie_sriov_pf_exit(pci_dev);
+    }
+
     nvme_subsys_unregister_ctrl(n->subsys, n);
 
     g_free(n->cq);
@@ -9756,10 +9760,6 @@ static void nvme_exit(PCIDevice *pci_dev)
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
-        pcie_sriov_pf_exit(pci_dev);
-    }
-
     if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
         msix_uninit_exclusive_bar(pci_dev);
     } else {
-- 
2.53.0


