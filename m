Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272E7C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 17:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdAR8-0003W2-Le; Fri, 26 Jun 2026 13:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdAR6-0003VT-Fm
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 13:33:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdAR5-0001si-2S
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 13:33:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QFigkr1534829
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 17:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=n9q/U3zgfgZXZBAuLDe7AJ0FMxhN27qfkoP
 hSycJXi4=; b=cjS2evNORNiOEwUSueHGjamV0VR1/S92zk0QY5+S+ZOg+J2ghtt
 D0hsm9fxOcRcNJ8Nfjt2gh7yW6PSFJJApA5C5Hp43ZI6wK5jmJN5wj/mAFQrTku9
 zly59KS+WXNeaivotDVon5gD4LB5XamUMvJwZ23xFNxNGujGImPdbRFGFgyOOMeK
 HZfncYWeWy2X3ViPqs2KdyfQ5NQ8ay6Za/YLr1W0TzguYljfTevcBq3t7TKoWcgM
 nURCLHrSUgKgCbc/+n21/MKiFO1CIPK0vFrJDrwpPNOr7epODulYVDBzaG7biMq3
 RI9BYO/Y1YgvA3kbCKV/efcml7N1s8y4cjg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2tswyd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 17:33:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so3268891cf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782495228; x=1783100028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n9q/U3zgfgZXZBAuLDe7AJ0FMxhN27qfkoPhSycJXi4=;
 b=KOmbf6MLzQ9CxAa5011dcUrsX3+QDFAWLQaVfmUy4roNWk8RMUjty+PIBCVJ9HEx8S
 LDlN8m3beZ+I8lNo8nRLuteqPkg984Di2sRqaXBDcH8QGBiNJ0JV0mog0n4IRa78PcdG
 //ZGRGG/M+fQKZCeaziH7sXhyUIwUUKxs/MqkM4U6d+b4qiXdkvyXd1W28oMVyeBRi4v
 1wZs94u8ZXVxjH6P5s0hG3BiZHjiXQ5hfqL+n8L1N9Zq3towKv0pdgWRx4SSHiYohJ9z
 UtbE5uwaRF9IGOk1/s7oUvbJ9XOhabnBbG5PANRI4ym9e8C/7VctstNqX/Lt9NZv2nG/
 ACLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782495228; x=1783100028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9q/U3zgfgZXZBAuLDe7AJ0FMxhN27qfkoPhSycJXi4=;
 b=ow28Cu3AyRnl0KqZoYULNbBoYNKSvMNEMqTOvNegYad0PtuQv4BISQnDhfGPhEC4I7
 fruXi9uP04QU5mXKtRA9qVrUgg6zbP06WFsMSJC+OgzNfT7MKF3B3vJ2KSxgsFNx137d
 ALYIpRWYs8gPl2mw9Z+fehcjS5UQtyQDKEVhTY78MFsZuJ9iL5PHajxbpQ/Pa6fT8YjL
 ou704Y4157AyNiNfUZpdK7M4j9BZC12LnTL8ME1Wnn0w1FrgWtKkZCriJ3XdHj0T0scF
 0jJ+tLRgkfxX7iKI2g03oWE5gUXZLtunGMOlSoAQfz+LxiGipJgsVlGF/j75sW9JFrrL
 w4Rw==
X-Gm-Message-State: AOJu0Yw2UmLS1UPHIDJxTvxp1xHos4lZEBlVn866ubAy/uIwmgM7L2ME
 DYWruERFLKkAcpn7KN6l7eNRDArP8M8ziTLE8ddo/StikBrk9EEd8elAh4ePnVYMom0zO3wWrkg
 Cb32VP1yy7VT0no/GCQPvkE59GLCP8pnUdx8JrxWP7/wc9XQ1UiySohm657QVzRr7Dw==
X-Gm-Gg: AfdE7cnyHVuBMT3tpxVx1SpZCm7+BSUBYDq5IMGNL/NbedNdad/hI9jk5j58NcTnmt/
 x7OAYn72e2/Bq/GwCL2gbyUuc7goxXM9aNB+kn+wquz4EuEJrc/u7Gvq94DB8MIlskpLe3g68Ku
 uRq7yOR2uE1iMWjwjQUFFvK5TgdFc54FKpLROPvn+FdRQsEnMYQ7Laa9Rh9nmU7PsLVz4oNQcGp
 iIH4OpfbZrJ3oJyGLIuDYAGznAOR6bO9lvQapBR1pfvkfrznpkF8jNZ73wqxQ2t/xK6u5IQtIob
 okPIUVUdsIqaNSTyJnQySXVShrQu2V33C1C34JPIPBXrcAoN9ExgVxDVWggOapG93zpmHoCn28j
 QjOZP1V0rk6zK9NFYR4FEU6rxABW+pSk+589PweSPFBk19g==
X-Received: by 2002:ac8:5a0f:0:b0:517:6b31:804a with SMTP id
 d75a77b69052e-51a727a03famr111691971cf.29.1782495228474; 
 Fri, 26 Jun 2026 10:33:48 -0700 (PDT)
X-Received: by 2002:ac8:5a0f:0:b0:517:6b31:804a with SMTP id
 d75a77b69052e-51a727a03famr111691321cf.29.1782495227810; 
 Fri, 26 Jun 2026 10:33:47 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df82693b9asm242556966d6.42.2026.06.26.10.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 10:33:47 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV
 appropriately
Date: Fri, 26 Jun 2026 14:33:41 -0300
Message-ID: <20260626173341.3661446-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE0NiBTYWx0ZWRfXyI8e745YSKL2
 Te9HjknyK/Fe/cxjMqhPK9N3DFYCpQKvNW9xYqhD8xQq0wRA+M66eGy+y69JnQgOvuhUgURTE/9
 Slk5uNigLB75s5psCV89ULzYm56Z/E8=
X-Proofpoint-GUID: 5lj8xy6VrSKr7afOJd66bq2GwLUn_lVz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE0NiBTYWx0ZWRfX6JOXc9oshfRp
 pVLa9VUzYAfHTy1HY/BP4QFfbBwtrZHZCKzTkO0S6hX1/f8LHazqci5vSvmvLxtzJSn4d01Z2Ls
 dZ2kHeA068XrB1d4EjZcCjezTKF2IlUKr1aEUl36F3pHtj0OVGMSh1HusY9kxgIMwwT4SG+mK3q
 hfnt1nWr9wGDbXT+6igYvfwl3S749iT4J+hKhdxkrmS3S2+Ur899XlC1XCTbmRJMoVKW3klCRqL
 e39umVeQjP7KKZgoxrgfep/pipd44ZCs6D6JhzCHja9pAoZa7/xroZ0bDeNImcyNp/WARbJrfVE
 ixT+Ol4WP17fE5oxU1+h07MO+w9QUJEb9CrW2GKX/fzuiHU3GKU7EZyOltHL5i2mJK7NnbmPpNd
 xm5ktYbkjzL115+YUqz5ky0gz3ooec3ZuLMEyyFjdh7aAiUgCefGTACtprg5WIAZc7E/cueLfmy
 xFmraTBMo6PVCQaQLFg==
X-Proofpoint-ORIG-GUID: 5lj8xy6VrSKr7afOJd66bq2GwLUn_lVz
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3eb7fd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=2kn5_a0m0FK2lE20j0wA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260146
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

We're hardcoding 'true' to FQ_HDR_PV in riscv_iommu_report_fault().  Use
the 'pv' bool the caller provides that indicates if the process_id is
valid.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3556
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index d47abf9eb3..3ea9130860 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -580,7 +580,7 @@ static void riscv_iommu_report_fault(RISCVIOMMUState *s,
     ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, cause);
     ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, fault_type);
     ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid);
-    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, true);
+    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, pv);
 
     if (pv) {
         ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->process_id);
-- 
2.43.0


