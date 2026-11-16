Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3CE606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=WClJmsR7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dCk26i+E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4bJ-0000Ox-EJ; Mon, 16 Nov 2026 16:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b1-000098-FU
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:41 -0500
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4ax-0004rM-ML
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:37 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 057BF7A00C6
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:50:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 16:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794865834; x=1794952234; bh=eE4xwjoKzAG+Ylgwflzjt6IvuhW0E1XA
 T9NuQWZ3jEE=; b=WClJmsR7zwN9YzhT7vM36Gsy5Yl1g9LiQUkF25lkqpllzk6G
 kY9O3zhsE8LN3IYaq9HtNHWb1J/e2bUO1gNoAj7p4REIBYwrevLmMmknwAI8yHph
 ud6rgsWU8rTHkH8clmHJG9vj9CyufTCoFdGOPbv4Gh6C3Hq0KzuU+AHFajWUuei3
 9EEFRjIdaJc+3i9o8ONxu9ItCmThT/E/M3dBsM702Xwd8kZxqr+16BFWq75a+vzD
 gpW+3mmi9Q3i9hjyPrd1y5a5Q2l5lOknUc3EVB63qHs0/RaCmbtBMoVk7YBpIAY6
 M/9DE0KpVDSlSnUPnOQp6jQzDi3Q9OUSuua7iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794865834; x=
 1794952234; bh=eE4xwjoKzAG+Ylgwflzjt6IvuhW0E1XAT9NuQWZ3jEE=; b=d
 Ck26i+EuXVK3kqoW81XmP2Oiw50GqMCS0ffdp5PHjbSpotKsLUxgjrc9Ybb8VfSo
 7B3+u3RR/Q/rJheBrSLZ9nKfXzBTYaxfN2zt7cKmKSxVC+mDRwbe2F4+Z8kLDezC
 o6QuQFl0EaIgifMERGPEI9Cv6JyTLfLLZoETQ1G+nNcGfYHQ/VJ+/NvlOEybW7e+
 DKm5+HWfnThhM/x2y5kIMI0d6BAwPtuyWw7VTrVcMxHC7NxhWoYrO2h1lbebktNU
 wE5HPNG8Bzkf+PZwMy2CVwWK8wVBaBXK7YLAbk1ZLehyDMIGzduX63Op+DIk6GMm
 qeih7gdu1EI+810+gvIiw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794865834; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:AMA8e8m25r1+U4hhQ3l1wZYo5LPhFk3ZddpcMLgr198HCad
 OI+CkPjy+NvlToBMQKbDuCy2OHvQ/B4WfYp5ueUw4/iLu5k6NQsTH4u+Z2kG4PTo
 IzGgbVJqQ7xrQjtjmwymljodC3R7VEdA8vvZ5o4J+tAhsTH8OV7xZDcy5OQwhaLp
 OY/su68g9JvlUQipyiotytTqopDjEaHmc2JgyLBB6hGuI0g4ms9okvYQmZIzhMrh
 KH35l8m0FZR+klYZgWATfWiErw41gkR+6NmDvsztXGK3TI2g4pM+/6Hr1QM6QDe2
 VMb6+B0rHDMIFQwAaE6deMaIvMUv1p4kCz4L09g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:g+QVZvVuqiO4tnm1pUYewakBGAYXrbqEkwhu+6PU3IE=:KyCt5hE/JYIaLwcHj5WH5ivnjrE4i0kobIaoVbZvw0c=;
X-ME-Sender: <xms:qnr7akXcZz4dAqmISx3WdDyjzd4DICQUMzqqayDrvMRNo8DsmGQgnw>
 <xme:qnr7aknFcqh06kmap5qTv9ufX9KQxXXnFobKX1xAM8cxBl01ALCefW_YEqWepriZN
 q14ZoFEUbc71wf3X3rbIRbhVojnN7i89EZbSKytv9CSFNnp5nIazgtd>
X-ME-Received: <xmr:qnr7aqnmLIbVkN3SE853IE8-qzsW2QAADP0toUmlHpyF-kBwPe8QefXwGMy9VMKE4qIJF4LlKyCKB6jbaQaeB1Y7A9IRUQBOV80NW2hThRlDpIz0oB1ODeE96w>
X-ME-Proxy-Cause: dmFkZTEOTEsRhshwhFhjGm0XmTp8Zk3rpv3WK1ppJyRPrpT2j0EYQcbyI7e8QRql8kaTJb
 tRNriysCz8DIG6YaRalW/jIfFJO5QkQzQdcdOPUvs9TBMP5MGBovYTCm5QIC6MhperCZy6
 C5gBRDj+CTj34knB28w5xR0SyLo840auzLqb8rUUvaBi7msJsk4wSei8+stZCDXcuGvJ6j
 6UTxvdGJ6FBwpjjzfGYE2DWkobeknWhtC0aVUuOr2Z3Vn1DJ72j0DB4nMvXV8Tv+3QYUOQ
 /kn7BPCLM4cybsOiLvAHfXGUCNBAsifUM75P9GfPBlE2YetPNtOD/3cqARq9HskToQ5ArG
 eUBl80bbNA52Uj0ay0dJD7n5lKK4MSt4C4gJA6uJ8+fb03SfiMJnplAI6E9K7KBQeQtNAE
 js1ewOhWXHQatPE1ZlLCBQku6DC/ZbzdFzy2WIYjlXop9wPpaJzNt0z/om+Z6Ha07OHQJs
 2BjREGHzGeLda1tRmNakodkj6ynp5ugoM1P+qmimv6mUwhxSnKjPhPpMT8Mbfa9NRoCMXA
 opYmoV3e1awp9MZNH+zChLDDF35XjdyebIdvHdIsZnUkGtzpr5rGTZsywAb+CKAwP1ptRQ
 mjXGHmZrnf8f5UWR2hDlBWTcWL/m4HLOwxXwaxLGsiqdd18g3mLGuHcph4nw
X-ME-Proxy: <xmx:qnr7akbs2dyP9UfpQw9AzcMfQnec0XqT9VQxmzDFhoqzFrDKw6mcPA>
 <xmx:qnr7asRStt5nGO53RQdMMtt2zAH9BTEbPJK5PnL3pvyZNSDaGD8AmQ>
 <xmx:qnr7ausKOvQu599_otZpONsClkVplvPA-qXWnLqOxrFKiI9GSK6h6A>
 <xmx:qnr7auH3qX4XE4M5w8Yn4GrxXTF-V-3Z_BuK90cK3uC_e-X0NyoI8Q>
 <xmx:qnr7aks6Sp9-5LxfKS1xdBK3Ir7FN4g2mM6ll7KE5qGy_zXEbfrZXuHR>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 16:50:33 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?= <mankku@gmail.com>,
 qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 2/7] hw/nvme: fix missed CQ updates
Date: Mon, 16 Nov 2026 22:50:08 +0100
Message-ID: <20261116215014.59993-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116215014.59993-1-its@irrelevant.dk>
References: <20261116215014.59993-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
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

From: Markku Ahvenjärvi <mankku@gmail.com>

When doorbell buffers are enabled, CQ head updates may race with
completion posting. When a CQ doorbell leaves pending completions, the
event index may become stale and cause the guest to suppress the next
MMIO doorbell write. QEMU may then fail to observe that the CQ has
been drained. With legacy INTx, this can leave the interrupt asserted
indefinitely and cause an interrupt storm.

Update the CQ event index as part of doorbell processing to ensure that
subsequent head updates notify QEMU.

Cc: qemu-stable@nongnu.org
Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
Fixes: 2e53b0b45024 ("hw/nvme: Use ioeventfd to handle doorbell updates")
Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e591842a4a33..52fa4b327c1f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4789,6 +4789,7 @@ static void nvme_cq_notifier(EventNotifier *e)
         return;
     }
 
+    nvme_update_cq_eventidx(cq);
     nvme_update_cq_head(cq);
 
     if (cq->tail == cq->head) {
@@ -8633,6 +8634,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             }
 
             nvme_irq_deassert(n, cq);
+        } else if (n->dbbuf_enabled) {
+            nvme_update_cq_eventidx(cq);
         }
     } else {
         /* Submission queue doorbell write */
-- 
2.53.0


