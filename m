Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB36606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MqXdufIm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eA4kJ3vw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmri-0007Ne-B5; Tue, 27 Oct 2026 15:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrg-00077X-20
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrd-0002Uz-VC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHWZh1917333
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CVhDegPFKUcv8kLWfaQdFtFZrjF/nPi0UG6I+sjHSAw=; b=MqXdufIm9zmHPh37
 MuHfQ0/v/hvk720b6sxPAeHJTEfSOj8mkJIeAiyQ5AgtRFDoCYWttzwfpFWDm4dI
 HyEJjM7dUbCrZl+0HCkxEqgkMOjM+AAy3UVNurgiZC2SpfyUqVNPqOJ3jU/o0hIZ
 VAVVxx/Ka6sRDwmCF8tbVWz3Lypzj9yEAxxqFG+0AMqElVQSGMh/b2uQS/Jjcya7
 9x22/8VxmEeNSkzZ5Qd4qIkPdhp0jQv2kFuBbWl8GSYkMpheAILKJIE/2JXmeJQg
 walSkrZqi9IytCa7+oH6A4w/wDV2XawWGcvV86VXH36J9GV0vqGbE9+ADq0ZMQ4O
 hCVyHg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux99vc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b7e7d5f56so5252626d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129380; x=1793734180; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CVhDegPFKUcv8kLWfaQdFtFZrjF/nPi0UG6I+sjHSAw=;
 b=eA4kJ3vwwKMstMZZBM2+sZ3lQCrfDpplnNQNy1RFz4DJ9JDv2+EAgj92u8LHSif1Wu
 9yVVqVui0/+/yzS4ngiDXvBkrBDMGcVH5w1AjChYttKXIPIdgudBNayCFyTp2sQS5L4n
 N+ZgFoOecvZ8iwJ3E87BJT18ouQhgrwL0WmZc84xodK1mpri46QwGcihIkUOjuMqia4c
 RhAu93XVaqVOojc9j4Lkn8Ztju5tvkXrbimF5uEeiEEjUL9a1BMYLE7MZyjMZzFLjlOp
 wE4seXwEbeoLjd2LnT9Y7Y4Re+aEyoxd4n351KKyiwNQ0aZ0ytl88uRvBzYERfOnMrCm
 yoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129380; x=1793734180;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CVhDegPFKUcv8kLWfaQdFtFZrjF/nPi0UG6I+sjHSAw=;
 b=ktjbO9KE/tYVJPD7Dtnd9lVvECI+AX63hwhDiWj0QPdDluBAV7EwlWro8mn58XS83w
 9RtClL+3s233+c/xCNwqJq1Btxi1u6Jf7EO9LPAJ/VHwqWas4rSwnEw7EXnsHhmVdBSe
 ycIbwQ4z1hRtv/lw5yO54qGK9jar68D6O3p+9ttlKOfu1wDi0iglCGXeMvlyBwQG1s94
 SPSoAytQNrEXvLQQkeBqPJUZKQMX2ghh1V+1F2Pdi+7sO+1OMn6jTBp4zeyL2PPwcQfw
 1usYGKB6PmDHwpNDW8VziuahPWDsfiRZ7HyObsoHqSogy4/J5fN8AKgNiQlODtLaFU7h
 wBFA==
X-Gm-Message-State: AFq9FYKwTNjbBmMhVEEvdcQIQfKKG5P0PK1d/prUStAaXq3KJrqMxfU3
 dH3jmypD9zeBAJ9507ntWuY78Q5E+dFbFQi9MTNmxkfZGUFM0Y4IzJDIoqEOQUtgFJV/Ab2Sukj
 x26Nf3AF92FuiJnVQRZ2nGF8w0AcEyO+EhRexzO/CmMtxjygDV7PXJPa6zGAlhrb5ZQ==
X-Gm-Gg: AYBFou17W+BpnDqN4x0VztVKJqSHXUlSajqLuT0Jlf5iaTwsb5orcCVlNd6EriplPem
 VsAowVOauIeCn9JerhTkRLEd7OYpGxz9pDaC7drqExIxD8s0h8Tu5N9b1g2SN5hfLAPt4srhkTR
 um6/OjlilNbvYUqBXUkaBY12QkBQYXggWhCFsL8hX9DO3HoSYgc7sFz9nsbXDmaEEtW53zVxS3j
 xY9bLRE8FPlOeNMLC7w+Qva0JgwAhT2lJTkTjuQuKIotOwAMQltgRdfauNsmCsqoktdtKLex4p8
 vNkXq8TivDg0bBzFa846+QMVgiOypRc0moctYXDTT0/bKPkrFTOUv6xQrM3J3kJzoWhv0i6puOf
 h7L3bNX718s6tYFv1qNOQhJRDJSyxTy65LeWKkeq+wpBOVzPI0miym0Yh
X-Received: by 2002:a05:620a:4043:b0:93f:2d10:ea44 with SMTP id
 af79cd13be357-940ef90dadcmr1676375685a.52.1793129379850; 
 Tue, 27 Oct 2026 12:29:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4043:b0:93f:2d10:ea44 with SMTP id
 af79cd13be357-940ef90dadcmr1676372185a.52.1793129379390; 
 Tue, 27 Oct 2026 12:29:39 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd49afsm24627395f8f.35.2026.10.27.12.29.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/59] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
Date: Tue, 27 Oct 2026 20:23:33 +0100
Message-ID: <20261027192341.9197-53-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0fba4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=V2NxCb60AAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=Oz4jNdGFPLS9ddvAwioA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=3L6qF29SlnrayQqPM2jZ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mWL_UYw9H37OVAmDKJey3ZSb4F9zrHZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXx8h4UXGUKzBD
 YaQ1fWLMobks/5Xn1q0piVRHPCU6YWlfZKXkkpXSV7GpkIF6VNopeCLqhVf8n6PZDB0CZJphIYM
 FjJmjNkwVF+2PCGNzoH6lV4RH1EASVfU66S+Y0beOdAcQ6zfZlDI3Z5GD7tQveQYbCWPNBUiv5E
 /PRyHFg9obX3r/rmsZO//TmbVD9UJXQ5JKLOsGsrdCX9ZfIocnV3+ZJN3d2BwCJSb2ByeHS1s1M
 3CoDYMwVE1+q2N2rPcqMkktzPZZtxBTe+cUiIZFqx+/I9eeTN/FdxlwPqmuHqswEmX548FhtgaH
 nqDATySInUZYSrh7m8FRNcz/qHawuXFUb3GJ2+aGqKxHwq6U6JNX3NFej/8/s0x+QvNHlYcr2Yn
 AMu3gQvwsGLIez0/4o/GCkIhIWrARcM6QqJs8NkmZFXRgdHpiIZlh5O+dYEL/7jrLq53t+rVQ7U
 XrIhROXpQoHZNCrjKyw==
X-Proofpoint-GUID: mWL_UYw9H37OVAmDKJey3ZSb4F9zrHZA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX1GtVwfs+rtqh
 tqchqN21wFQWU8uMxGpznsHs732pAXUFDLFt2bV4jlG2w3lyJfWXzVlNDiORyXqOBKcLBXVN/v0
 5HZh+BM3L/lqKZmQslWZMAGM/KLg27U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The ASPEED PCIe class may be registered for machines that do not
instantiate a PCIe root complex. Updating the global msi_nonbroken
flag from class_init() therefore affects unrelated machines.

Defer the update to the per-device realize handler, so the flag
changes only when an ASPEED PCIe root complex is actually
instantiated.

Cc: qemu-stable@nongnu.org
Fixes: f002aa35f320 ("hw/pci-host/aspeed: Add AST2600 PCIe config space and host bridge")
Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Marcelo Manzo <marcelomanzo@gmail.com>
Tested-by: Marcelo Manzo <marcelomanzo@gmail.com>
Message-ID: <20261020033755.2618640-1-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/pci-host/aspeed_pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index b46eb74234bb..ceb010f21338 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -181,6 +181,8 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
     g_autofree char *dram_alias_name = NULL;
     g_autofree char *root_bus_name = NULL;
 
+    msi_nonbroken = true;
+
     /* PCI configuration space */
     pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
     sysbus_init_mmio(sbd, &pex->mmio);
@@ -294,8 +296,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
 
     hc->root_bus_path = aspeed_pcie_rc_root_bus_path;
     device_class_set_props(dc, aspeed_pcie_rc_props);
-
-    msi_nonbroken = true;
 }
 
 /*
-- 
2.55.0


