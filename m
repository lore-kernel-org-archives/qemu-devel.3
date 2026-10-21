Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25100606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm1 header.b=f81U9WVD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Nx+PAXSJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWWD-0002cv-2d; Wed, 21 Oct 2026 09:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xJWW3-0002XH-Vk
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:38:04 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xJWW0-0006ID-82
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:38:03 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5E2C67A012B
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:37:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 21 Oct 2026 09:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1792589877; x=
 1792676277; bh=lE1Ue7oi5C+2Uu+sj7Lrqhq8EqGPId8oQBb9MCfrwRg=; b=f
 81U9WVDOdWC2lFKoI/mbmO2H+8f9NYE6VCnq4hksz/hKKOnoxrB9ryGRLqLRYwd1
 eqG2vhxvJwq8GL6yONruIG9WD+KtNPUG9RKY08OFJAuxGr7GlurA+IVfsUnMd9ZB
 vk27fzLc7RbW/z6OvFMDh3JfXyZAtwzREbGqJO77aWCyZ6Hk1WM6BwFN+PL0WGlr
 GQLPvvTEomiyusDj0SBmJ4q8eLn8zCx7eswbS1Kw/PksDgPYMFgYL/3xygOR82aR
 HjW/UAKz1uoFoxXX5pt8XIBMWqrPBIXxOgshHh7ElXUHZyG5kBTP2/WCIy06Uj2Y
 tVKDRpGwY9BhwByGn4MYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1792589877; x=1792676277; bh=lE1Ue7oi5C+2Uu+sj7Lrqhq8EqGP
 Id8oQBb9MCfrwRg=; b=Nx+PAXSJOtqknQLLkL0r1fkRFM9igvTuy1+bKPUFLsZ4
 9lDceNt3Hs5B0fL//F6oAQohZ7Gd/xmpipiIYyq4z7xdb8piK1JQQZwdNXcPT2Lv
 Dt51AsS2ED/9oXnVqmbRv+mWRq609NRaYr6tOcU+jsQrF3oIuypXAK92JcxRaxDT
 IxvUldUf2JPaDlzXRDPxqclTC6rJHlkvGfmxRma/BSAB0HNsXoRIqT229vYohFDv
 rPBmsOC/oTVp10JVz54CqwKr6Ylmtf3DATypGTrWy9dme4h/TtRtyM7JdtkiQmUi
 w8eU8BEji+yKQ8PNOWW612NqxhZpro9GQlXYOypvOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792589877; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:F25G5lbiF+pUcPHTBE9jrGK1xA7zRt6fu0w9uo8166gAHmL
 ESd42HcC8IOnfy1Ck6Ks74/k8D0FESParLq0pP+/IYq4dE7SJWSUAtQMpEVEBM8z
 knnr6yRJEETV1RTYaVmUYrxI9ItAt3NiwQaIfAZMVmZXDSC1h2mCiVSS0wbv4EIB
 OQZ8gn8MXEOcdjcLrgRNz50UOawSFzBiY2UBDhiLWpWq2dx3c+xECrhEzaIc4Z0T
 n10uA8Y5RM0tCG20VyGSYVN//bJ551Klj0DisH12VRJtvm4mNxw9Go4ynrztZePQ
 LTO2UOMoEqfZx/jTkDzUYvceKAll40+Y/+AQjqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:juJUAaNCxyEJdnP46k4O1vv75SuCKEK8T5VohhC90dY=:uKBdng7XEbnrwHGyajQRgiB0om2mwLXShWwwQJfNmjw=;
X-ME-Sender: <xms:M8DYalOzqtlrXSYryEBeoNzJwJ7H224iprpVXNeD2H6T4yFMpl0jow>
 <xme:M8DYai4Lf-TWDFwZNT6Ew5bYxH7KsRu4hQRog4h3iv3qMK-6KhIwxeUbRcmXSm8xL
 qjg6lKwaMOAlcdOv0hCouwRG173IZPIWWLanNi5SwLzdRjS3RMqw0zO>
X-ME-Received: <xmr:M8DYajSNk66ge21Nekr2tF8krq0AZEgeT3UuYumffz2NkowvIO8M81Bn1chZDIMJbqwa04ZRGPsS8ywyVROouL2Q4yU1c-kc5cjK63dKl31PvqT6jDvK8Ud_Lw>
X-ME-Proxy-Cause: dmFkZTF/5tGr6tZUjid/mBygzb5Xj36+xh7VLO6H8o1WDv/o07d57WC1UhrbM/cwGY5yHF
 HDyD/Io8zQ31s3Ou0kUsVjAReGr2/8DHonkUV7VfsSn4v/pL5CNY9fqKQQRrNfoNGvpOXr
 yJssnGWYy+E+T7PfB+3WhgfUdb0YquhnaO5jrryDzJ08ZNFx4c2Gosj4SU3kKKfuOiQk6B
 Mq4YxMs8kh/F6wFVTiOQzqJ31M1TzSEwQzKQan3PmE8T87vnLlOU/N65YB/wy7vVJIHbg8
 +u4+7/YVIzPpTWTb7eu7lOfBz0YCbZR/fWYzl7L0/Futk8idlnHaelvyKxrzn1j38OMvrw
 y55fscqSh8ggb6WdiwzED74a0OGK/Wu8CMEWAYGBTQGZT9x+jLuWY0maEw2I9QLE7cha3r
 Mn8o9j3C8Sww2uEoG8dj6n2oU2803OI46qckQYvMrHaO4gS1tHOv2JmNzFm1E0nH3YbKvg
 6jBUTXyjngfWoJ7GiZzCESTs+6GMTbtsgxJl3/ygtr3N3O1iL7WgR0mk7MnCl58r52x+q/
 /WMw3uwk4RQIIc7/fRnJr1y/kqhPcIZlcVKBL+Iw+0hbSdSq21kao9Aq91189GFBheJ5lc
 ClamfWT4JawcisXTk1jsu8K7KZRlAQ8Thvk52Q6wgaYj1/n5PNLLWh97pl/Q
X-ME-Proxy: <xmx:M8DYanDbbSijrM0O5eKH9frxNLKaOret5cKYgMFen1FC1HvYzEMqhg>
 <xmx:M8DYarHqcEBZfrSLRt-Ypt_6l9hZlwZwe-u5PkQQfkSdFHkunRT1lg>
 <xmx:M8DYapBhykqOoNzGNLk09xh__8TGhGikm_KZx-QgDku2QUQtQgpibw>
 <xmx:M8DYarW-R8Roj87D4XNhKp-siGsXnKhzYk_Nf5cWk6JLICUgy8BOSw>
 <xmx:NcDYavZfF8AXZ1I_xyDtgwzf3nHShE05kSGJDDt85iZUUo8wTTn5xds8>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 09:37:54 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 21 Oct 2026 15:37:46 +0200
Subject: [PATCH] hw/nvme: verify source and destination lba size for copy
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-fix-4173-v1-1-e8045545f954@samsung.com>
X-B4-Tracking: v=1; b=H4sIACnA2GoC/yXMTQ5AMBAG0KvIrDXplNC4ilhUO2UskBaRiLsrl
 i/fzwWRAlOEJrsg0MGRlzkB8wzsaOaBBLtkUFJVKBUKz6cosS6EQ60tGuW985Dqa6CUfVdt9zv
 u/UR2e/dw3w9qHIn0bAAAAA==
X-Change-ID: 20261021-fix-4173-d188c1a2ffdf
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=2pY7FNFAZLcSO/jn0x54rnWKCUCcG2SJwxp+aVwWsCo=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3JZd0RKdFA0U0FjU09LOXE0YThjdzBsYjE3CjVQS1Mva0x5QXdDakswVitz
 U01vV29rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcTJNQXl
 BQW9KRUUzaHJ6RnRUdzNweHZrSC9ST25tN05IQ0RCTFgxcWZuclRiV3cvZFo1QVJhZ04vQzVvYw
 orVCtzb2hvTHdaL1V6TWdpalVZZkVJeEtVb1J0VU5uUERrMDJPOHQ5ckRDOTZ1ZXlDd2tKWmdjZ
 DJPMUVEMjRyCm9iYVhFTGowM1dGSjBvUTQ3bE9GaEJEdXhUYlFuRi95N2t1aVpweWJXU1dIZUND
 K1lzNjhwemZhY2RrQjBKaHYKMHZRV09LNlg1andMV3NpM254ZlF3U3JFa1MxV2FpYnAyNTROMVV
 XNnhva2daOGk5cEZmOUNqd1E1WjBwaUwwOQpvVDVvd0tvWkR5a3J1d3BPQk10QzJ5SHZqQ0VqZz
 R2M0NIa1pmWVBNZHh6V1hBWmE5S0pvSGZRemdTZW4yTjMwCjZpckhmRklPcGV1aFRaZFhLSGl5S
 1NqdUtRNGdWelJVRzM2MFN2V0hieVR5V0FNbzYwU3dyNlE4Cj1EQWhrCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cross-namespace copy requires the source and destination namespace to
have the same logical block size. This is not verified, causing a heap
out-of-bounds write.

Fix by correctly identifying the invalid operation.

Cc: qemu-stable@nongnu.org
Reported-by: Feng Xue and XGPT of ThreatBook
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4173
Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 578421c21761..b48bf599b5d6 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3277,6 +3277,11 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         status = NVME_INVALID_FIELD | NVME_DNR;
         goto invalid;
     } else if (snsid != dnsid) {
+        if (sns->lbaf.ds != dns->lbaf.ds) {
+            status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+            goto invalid;
+        }
+
         if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
             !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
             if (!nvme_copy_matching_ns_format(sns, dns, false)) {

---
base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
change-id: 20261021-fix-4173-d188c1a2ffdf

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


