Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3A606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=jyIZJ4iW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Zvp6VO4l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNl5-0001u8-04; Fri, 20 Nov 2026 07:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkr-0001Pi-Az
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:15 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkp-000821-AL
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:13 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 9C3641D00391
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:30:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 07:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795177810; x=
 1795264210; bh=hEtpptbGToH4W80EQmqgAKwTCzagWELAqqQ+Vj+oi3s=; b=j
 yIZJ4iW6h/YOzTi4tXhIgdsH42eEpeXdaOWHOxS9mpBHXNrDYYKXf0joM3NEsRXB
 UjYF1cnXzx/T7gMb7Nnkap4h98VaW4T0HDCbjAV8JgudxNapmHaKfFWpjgZRXZ8+
 3ejouNanctvQQV7uON7Vs0V8D3glc9aNq9/AQH70mUkqcIfU1SVteC6XDeuYHY6e
 LDEE0hNvM7TRVxrk8D/xbKhglXPrjSuCOy40j1RvRehiqAMjXBo/+TlYRVgneFy0
 HiHu3H7l6IUGu+k6jY46LJ3eFwUiRWp4PKCN/U/LD5YcDqB9GhC0BmhW7DTLSS7P
 vi3O7HcaDWN0cYdoa2NSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1795177810; x=1795264210; bh=h
 EtpptbGToH4W80EQmqgAKwTCzagWELAqqQ+Vj+oi3s=; b=Zvp6VO4l4K22GBytE
 y2tDra4FC7+Uy3hHP2yaIHClFEE/VWfnk9ZemJIHXJOGz0YTNdyxVkOQVSToybLx
 TF5V3MGLcj+mzDf7+66ZhJvfiZh2iKVJQfF0IJua5dxCEZwFXpr2VKxOR7pGFHxf
 H5UmhffKoSQC4Ue/5xPf9LQUTV0ACsBKGQTBbOufSIEF9LhJwL+Ylos3VJsX6Wbm
 1f488Hb/mxg3lwaEcxcU8e7OnCq0aoE/FkZGqYoyfrK/4Pshn5RIWh6GmKBMa0ut
 2cRx71bcDE5ZpuYJasMpk/nMDpGEwsplN7ZVmjP+24xxBhOX5xkEr1Xc6Oj/ruw5
 pWHmw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177810; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:eaH3odxyT32eKKwkW1L01opqLgd25wU81hK3KwSoIqF+jvZ
 qvEDWrELlJY/5AxR3AEK9X0tXzC204x05W6Mfw5ivwkdvhusyUgMiExGuJLsbBdu
 8jjJjQId61vtLiYwo8CgaO00ODMsa06Pyy79cn4BpZm/utgqZtF3kU6FoQTA7Abc
 t4P+JdY7X3xEvPam3f76BqgoOBy2Az8hcmcpVhjiPovrxjsGxtWmSNqc/r/+fIVO
 a5UxJz9Jo3Nubg+tV69znCczXHniFcfA8oLWgHWJObNGweInf/tqO4e3vs2Fk6ak
 odW82YGoNeKwVA6PAlqZ7wkfkkhErDj842e3/qQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:rkv3wZrzX6YDD8A9vXb1VtmXmkpYfwkUvIGKb90Fy9g=:77IAaw06+fIs9plzs2D2YzicBtYuMcOmIYSx0xcaAg8=;
X-ME-Sender: <xms:Uj0Aa895AzHiWoNpD5W0jkeDR5rv5ELqMMU8zkY6viUJzsahTVcRDQ>
 <xme:Uj0Aa-w2DB1Pa2_9T4gyNKChJHpaqfFxPnYus0Cv7NM5jsdvHAOLdot9AOuPvi2Th
 o-mject0P2pwzDIAGY2g_RydzKbch27hx9fDiKhSOTU0nQ3FUpyWLHr>
X-ME-Received: <xmr:Uj0Aax7G9RSFJxd-ZwFb9Z4f1Om2KRjfRmI9vlQT3_eKbEn3qjrK-4cao86W_jXOm13UklSV1DLvy0Deil_JRvsqn8lN1vtc1RqBtK5OALHLFbj0AvLm-Lz5pw>
X-ME-Proxy-Cause: dmFkZTFExTPYgg8rgO42EmNi083fhhkydGLyZE921u8lzGuruqpOi7Ge9E8B6a/id363MM
 M8BuWLLMO4fVvHkeGeOvWlpeoA6GU35EKJN3DgbiBVzuwXF8r2cHQLJg8fU0rGl2E0dOeO
 s+Nw2MlKxrILceBWhs3BK1ffPSR4HqonM4K29WT+QrvPJ096TStn1G84JjDR/oel6TQubk
 pyaFkaRhqF5OW/axUdI48bq8biSN19b82iagHYFTHVCw0Gkg9xAKDwvCK7KO0j7WxrJBUI
 ZB+43jhea1ublyYSN1UTeSHfOMWuASCGqIz4XcJ9chfm7jLNIur7l8entiBUQTObBo0PMh
 kxlpmUh2lXVnpAUdS4fnz9eNArNbm8Fx8+HZd3Z1vntmBw6EmjCS91WZ/NpLIujZUwA7iN
 a3vwlNegXG/MeMaNJpRdchj0hfLPjN27xsSSKT1BjdEmvCN4OLxgWwFv3//a2kY1uXJvxp
 glvYgPoZ9kTzDrXG8sSablfs5oecrcfKYj9bchZAwW2q9AVBu6etF7X2q5g5+IvGLJFhHG
 s/kqTfnDa76+ko/yQ3VFkVJb2nrhhG3ZMKBtdSreErqelt7w/JVLDoPVmb8dwiMjOJ43SL
 oakxgyzZyIT76+rjbuS7l9w+3pqYX+wou6ZZKXfbdFnp7c9NnXByI1P41MDA
X-ME-Proxy: <xmx:Uj0Aa99JtfKYp0iEenUcDuJfISBYXYefuGRkk3yAKTpZBW-ISv5B2A>
 <xmx:Uj0Aa-qLr0Ybb1Ou0XjQvhVJGYE2nSoxLbkVmiO5m3jBQuJHl9ZO7A>
 <xmx:Uj0Aa2rsEy1R_DDKYAkZ_c52jS1Fe7aSJJXN3WEVIosdXmxcINW8MQ>
 <xmx:Uj0Aa51z2R3jW_Tnm6vqOU9eNIhzRYp9z5xF099byVP6U7Q9CQfUsA>
 <xmx:Uj0Aa2GuV1jxQWyy-Adtu_fbTaq3S03xpCQdZj_9bQr3GhyDkVzg2JVN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:30:09 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 5/5] hw/nvme: advance zone write pointer only once the write is
 committed
Date: Fri, 20 Nov 2026 13:29:49 +0100
Message-ID: <20261120122949.1044-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120122949.1044-1-its@irrelevant.dk>
References: <20261120122949.1044-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=its@irrelevant.dk;
 helo=fout-b6-smtp.messagingengine.com
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

nvme_do_write stages the updated zone write pointer before data is
mapped. If that fails, the write pointer update is already staged and
subsequent writes will be rejected if attempted at the original
position.

Move the staging down.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 975b64665048 ("hw/block/nvme: refactor zone resource management")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 35e2c57851ae..5755aad1fa72 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3800,7 +3800,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t mapped_size = data_size;
     uint64_t data_offset;
-    NvmeZone *zone;
+    NvmeZone *zone = NULL;
     NvmeZonedResult *res = (NvmeZonedResult *)&req->cqe;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
@@ -3893,10 +3893,6 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
         if (status) {
             goto invalid;
         }
-
-        if (!(zone->d.za & NVME_ZA_ZRWA_VALID)) {
-            zone->w_ptr += nlb;
-        }
     } else if (ns->endgrp && ns->endgrp->fdp.enabled) {
         nvme_do_write_fdp(n, req, slba, nlb);
     }
@@ -3904,7 +3900,13 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     data_offset = nvme_l2b(ns, slba);
 
     if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
-        return nvme_dif_rw(n, req);
+        status = nvme_dif_rw(n, req);
+
+        if (status != NVME_NO_COMPLETE) {
+            return status;
+        }
+
+        goto out;
     }
 
     if (!wrz) {
@@ -3922,6 +3924,11 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
                                            req);
     }
 
+out:
+    if (ns->params.zoned && !(zone->d.za & NVME_ZA_ZRWA_VALID)) {
+        zone->w_ptr += nlb;
+    }
+
     return NVME_NO_COMPLETE;
 
 invalid:
-- 
2.53.0


