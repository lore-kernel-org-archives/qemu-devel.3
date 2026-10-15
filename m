Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCFACC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHFJl-0003r9-Rb; Thu, 15 Oct 2026 02:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJk-0003qd-Bw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJi-0007lj-QJ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F00SZH2121448
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rvy71e22tGz
 BxKF9WgLL0P4TR+iP6f2ZIx2WjS90w2Q=; b=EKl24zTNCr3MdSVtCI/eO1WV9B7
 M25PTjImDR/XY39G8IkQFPUqIm6e2xydrcLgI0FYPkL/RzqsdCfEWXGgpMHIWuSU
 u4HgCck4xZYzGoFFy97c2efWI/ZNIE67xdyCVnEu32yIPWQcwZOWEJjWSFhcxDci
 jUMx2DgAgnBnPqCx4nu+oE5hO0+dRfdP2ycpwK4CC6mpKYr1HZh/uPTURThrIeKd
 JKqs4NjBTagCAHuehxU+Hdu8DLYbO4t0YxM4yaCKzQBJm49R2DdT8phaC2IimR0a
 e1mRR4g2dYazEHVHlAHNCZsvjVYDKkMiM/pEAUOgRMPZ3yFVYPuC7X6fJvw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn19x6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-147be78cd56so19586724c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792047113; x=1792651913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rvy71e22tGzBxKF9WgLL0P4TR+iP6f2ZIx2WjS90w2Q=;
 b=Rv1BZJBdShdW2M3l7jTgM62yOBdTv7fhWFeRuCdz8Nu8bZy+ORr5RJpRM1SGKjrLFf
 /SHmypFSiRxarXbd9A5v3NoS9wtfJabpNajn3Jf71tYUZdKfonFU2siEu5zlTxMAHsDu
 8OjC0dhc1RTT7FjAJVQPKDCULDzlvLxXb+Zofw0DsRG0whTPA8hqTTfX44BmqvAkFv8c
 oczfX/ntnIkuZ8vzc7Zx8Mf8IFHYsHxLHQ/0PLpRPrzrMcpOqnQDHT6qKAEfMXkmaNGf
 DsjxneUCIdSgYrtBd5ygX0Ox7d+xYwTBvxHH+ATWgHBhXMEfILhGtHcoX/ytFWfT8+DH
 N6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792047113; x=1792651913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rvy71e22tGzBxKF9WgLL0P4TR+iP6f2ZIx2WjS90w2Q=;
 b=pNBEdlm2wWtmEDjDI00C6ZTdv3g6Ou7RXvBuU2FWvs8Ay8Cfr4ONfxr3JXd4HpNDp0
 0YbMkosFntZnYUpjUsJdLLlx8VlHBhKfMY3Ou4sEHmZwYpHTGOqBHYmLHi/DiRKVp3MX
 m3TiA9V04tXhgmqvBHqLHTB9dR5tpL5Y/YCkJq9kufq2dIPwNPRPq/HeEsUjj6w71gCG
 43cN+1ni5khhtJpLYtNiMUjp2Unxc6Ns2Cgzg89QNJor3RzDdAgQbTkqVLoQ8kPPt6WC
 H7DFyUq9pv45D6Kzp2Sz2AzsS/Nn/YgGBOrqMQqmpJ25wA2jAPFXB+Opyf+x66TQKnPl
 bSoA==
X-Gm-Message-State: AFq9FYJUhU8xErVSeSCg1cWBmGUh22LCHrCZxRffNisH/Xcw59lvDyYm
 c5gwX2NySrYvTt9GapUWg2aAyxfOYvt8I5Cy813IiKjUcZL3VpvPNl85iuB+zJg2woL715shY5T
 Mr9BhjV9v5UM5t9V8DDGb/4VnDS3uscIamDD2DVdk2Ot6sAwhrpFjlZ6W98rOTJJqNg==
X-Gm-Gg: AYBFou1O/6fSM+WPyn81/DY754C55001+D7pHMqKAE0au3C4LfH5r9tccCldap56Oc8
 HNUaSAOod5dxOq3nMq3ZjcTtZkHijmEjEydXVFqqKx783ECHyolY+wNDKVlMdGPWvC5o6PUtQCl
 6UJEJ+O6eicocIrDXCmZfkyFc83miDYuJlKJoHrLd7ynT29hjnV3iDskzeD3PrB/V9RXufq6BBB
 Diir3fzl4Xr3SqNJB+cgdksaAuWuzxkzWFxDwBAGuF9F4+0CT13wF5EHF6LXVU2KhB4knIpHtfY
 fQFZUE2/RfRdGL7S9WIXo+7scvkNPEjtv2yCSvWtTz4P+jVQwS6/Hjhxrm3vzfKa1xPWka42VYo
 QwilkDoNdZvlnnqxz6nDGanaSXBtgNOhxRrcfntIJaesYNAbIfqOWDVMynAGWkMRuc4oOJMQX2n
 vW0s9r9gJO4bw=
X-Received: by 2002:a05:701b:2309:b0:158:7ea9:4a76 with SMTP id
 a92af1059eb24-16a6187f08amr29131220c88.16.1792047112808; 
 Wed, 14 Oct 2026 23:51:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2309:b0:158:7ea9:4a76 with SMTP id
 a92af1059eb24-16a6187f08amr29131168c88.16.1792047112138; 
 Wed, 14 Oct 2026 23:51:52 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm67451789c88.16.2026.10.14.23.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 23:51:51 -0700 (PDT)
From: Sunil V L <sunilvl@oss.qualcomm.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>, Prajwal N <prajwal.n@oss.qualcomm.com>,
 Shankar C <shankar.c@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Update Sunil's email id
Date: Thu, 15 Oct 2026 12:19:57 +0530
Message-ID: <20261015064957.4076464-5-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfXxKxzhHL9d5Xi
 YsU4EQ0nYFBok1lje4hK+quSmEMZF2o2ejzOPKYqMXY1P6PoplffoaKHWVN01u3Fm+jX9ow+av2
 PzBayR8Zoj7r8hTENvRpOgvMfMfGYYbw6N9udyFie7u9O+R5pUyRRy/94IPgcecJqYinQuq6v4t
 TAgDMHZKKTKSrTLbO+GmdHNYKA9OJS4+rWDgeJ1b2oub4jfOjAdCQp24yxl2sB9dXhRR4ehdNlI
 bW9S70LTfYJVp7YyShu18QgLCf5cQ1Lo4TbHIFd20LxGxwv9loV6g00UC4rTDEM7bHdYV8F4dZc
 ToYlV+OCTJxHkRAHrTIcoi7vqdoAO1ooyjdAaf73j/FkJqoLVHvDnTkuOxd3GNDVE81Uku4PPEA
 18KJKvgEq5wbGGBnfoVKRTRUIOw1uguvrBHliPbQ7/07buzvy2ku/pM3JVTmIsmPjUdXAdN/2Fa
 39o+/4Lwc1n1fTO8KJQ==
X-Proofpoint-GUID: z3jnnkxctQxW6uDGarCgFEZO6Kqa2LYS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfX+S1EfytCbEdM
 emJzQ3QlJ/1L/l/Rl+uydjanh9FHgYp4rVelKq20R7L7GUAnlWlbcFZUIjHX1G/Bke7RUgVk4+s
 PUMDRAr19eaS7S/FsjsJ+EuarDi54wI=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad07809 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=bDdBU3oEAAAA:8 a=69wJf7TsAAAA:8 a=9gDgMEpirKkMJTtyBl8A:9
 a=vBUdepa8ALXHeOFLBtFW:22 a=DN7SgORnOiO7RqxRx1GC:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: z3jnnkxctQxW6uDGarCgFEZO6Kqa2LYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunilvl@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Update my email ID to qualcomm.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cc426451c2f..5c2282088610 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2335,7 +2335,7 @@ S: Orphan
 F: hw/arm/virt-acpi-build.c
 
 RISC-V ACPI Subsystem
-M: Sunil V L <sunilvl@ventanamicro.com>
+M: Sunil V L <sunilvl@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: hw/riscv/virt-acpi-build.c
-- 
2.43.0


