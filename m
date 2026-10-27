Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF85606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QZcr/FZQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tp9pMZPe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrO-000518-SG; Tue, 27 Oct 2026 15:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmr7-0003x5-Cr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmr5-0002Qc-MU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHEco2087937
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 253dRkduAVc/eEwh/kxEYX+xTtZVH9d9xeh7sb3jD18=; b=QZcr/FZQezbfemJA
 FY/ivnLAvoQB0xs7Ed3DvXWHwvrhWZOk3olN2599eVcEphFLlhECBeJn+EUWqUKC
 6GRGmBREzRYtq4GLGo4v1ol2ZV1tmTPampXMM9ftqziWRTmzEhCkc9Lqv+oEgLwq
 8Y18kIYBrBi1jgUtlOWNVpNKOp/IALNJELDNZ5izOee6yI9622v0xgbJAACq0lc3
 zfbNPIEDCSPRuQYlj1t4ZpmiWL+1tOKUj5KAUtDTEEx0T+s0ZYWvUPwdwTwxx2iK
 s0nbjxrjJXasMqx0k+ylC3PVVOHa9DCM6yKzDCXmBUXK68kzx6k/fRHP8Q+whaPu
 uO1UmQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2tbb97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so20731085a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129345; x=1793734145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=253dRkduAVc/eEwh/kxEYX+xTtZVH9d9xeh7sb3jD18=;
 b=Tp9pMZPeYa/VjtJgVc/mm0Izut1bA4p1HwAaKevrJ1EFJChYf4JoA+KyOwT8kc44JD
 TLzYv1YW7odpN/qF2JxbI96SLZg1Kd6q3GsD5bplO19cDDSnbXi6ATdwb9xZo35IdOeA
 mbihK0LcITkQcRxFrLQLMAUb6oJHGJNUpsQqj3bs+lJHsbRhPFWtVirnvZqDgP71intV
 Fr2YsHCDhlmQNQM+XO8G2MFJRWzxeABo3END2j8RVhPPBICnBfBQjhQNIl0Y5Nx4VO5N
 AdHrV5koOr6otOMtwOy0WbSPK/H2N4LmzHsnECCOPHGrSvutWhtSrAY5ywDAKKIpkziJ
 H0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129345; x=1793734145;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=253dRkduAVc/eEwh/kxEYX+xTtZVH9d9xeh7sb3jD18=;
 b=lc43WHXMSylTpJKmrXafkXmUm98bnc0h3SbETvFrE4HjVCoavCa3puTZYy7zPQuLW0
 gRzWF75dUdH/p9MwRR82Per95TTDLzjnVEXlO5lX5AqmuKw4iVwXbm0LlyhFsV9KSY5T
 YY2KCicmCaputKVK3RGhH4lbXrKPCkqVgXjcH1o3dOxMamqKcVW6iSpsUoOSj7RORyMC
 NJ+V+tOIViGLJNXISC7FevglcE3yjRLuggFO6fQeq/UQD7OSN58RIhiuYDLHPxrtpe1O
 wkbFmBUBOAIkhFA6MipWEMY9zRsD+Aw88mDixyJcUz1yDVClc6TPSbM6+DRCeS+oLmk9
 x3JA==
X-Gm-Message-State: AFq9FYIfXam/kHTQy4aWt9YEE3MkkMTsCqVQfW0yRvqUq6xViFEneWbg
 hrEsHTfER26VXsKqYk964nR6mhy1rnSHYdZ5BlWjE0As/azeZznF49Ru2746DXAz8LcnZB9F+DG
 JnCXQfBen2R9GxYh6Uoq1AhlDoBTJ51IK+3IjVD5EWdTXenMOgnoGTICwYF1me3JzqQ==
X-Gm-Gg: AYBFou3AURgliutQk+4DgRcVQ4TshFNZYnwj7C5afLbpY+GvLyxKOPG6VsemsTYf4eB
 9vxlgUegiFkkGUbn4+7eKsH59ABINv+y7Q0ZpeocZs+bJsKwNhBL6ZHHXcapL4mwFt4WfUehvJE
 lRy+oL2kZ65rQHiM6+8sGBrqWCkKbJgUibmniSlmpibNQeHKlLHaP9b/kD4HrHHD/DV8EQAWuKA
 p7mzqDu7IEvlRBJPkYUzbkPqzeAdYncZgjMuEwJ+qZILrunCWdACuQkfeTvIH+PG3bmtD4023JK
 dVAQRQTxbo9ycV6klF1hrxp8eg0o2z38IG2GIXchWujHLtwxtQSReaWEz648OAHmXmMq5lO4VgP
 KREt48QxTfgp8fNsZCz/prkfKh4YxmEUoSpMJfrUCzz8gN1I5k2Qdxsch
X-Received: by 2002:a05:620a:6499:b0:939:7683:33d5 with SMTP id
 af79cd13be357-940ef914b1emr1624155985a.19.1793129345197; 
 Tue, 27 Oct 2026 12:29:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6499:b0:939:7683:33d5 with SMTP id
 af79cd13be357-940ef914b1emr1624151485a.19.1793129344602; 
 Tue, 27 Oct 2026 12:29:04 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92e103d91sm4821995e9.0.2026.10.27.12.29.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 47/59] MAINTAINERS: Update Gustavo's email address
Date: Tue, 27 Oct 2026 20:23:28 +0100
Message-ID: <20261027192341.9197-48-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0fb82 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8
 a=PksdBkdXNVpGbhbxESsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: q8zvC3mndRK3Bepe-6GNCk6vQ6xxrzkj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX85qujnwtxjl1
 P51XuSvoRiVHo3s9yQICfoRFr6fIfBFEDMDrySrmMYGimTQuWdPPRRRfCWyosZrq2RJuLMfXn9V
 cOEZLLWlZ+zTzHaqRNVMi9xw9YYFQZs=
X-Proofpoint-ORIG-GUID: q8zvC3mndRK3Bepe-6GNCk6vQ6xxrzkj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX9ThC/voMz9qb
 FZZv09XkgOwfMSkYeLFXctVybv3ky8un01sfZqQhdSD/VcVE50JKDpcRFgVO7jFys6AT3re4LFT
 ucLRxN0Rv4KfIQF+yHpSbRBMzN5LD5SZ1yTj+fSILZ/704R7jPXA3NGORqk2sJRnJjDza5Qp7+s
 OzNur+cpJ04aCzGD26G12avk+r/6yUvm6y+nBXis1g6qvtUZKq3oOXCTBr/LFDlvQORfQ/Ym5MI
 z0ZdPAf8xLMYpzcILQpAoW3/6lW+nOwQUf2FfH/3lyHGTfmQmXcCPK9+Ux1bBO/c2YQ/rMKZV0u
 W5TQNFYbGEfWvIbOwKK6BSVOCVAkqgrkOpCGN0Q797wJHfmMSQWCOpposVI59Z38mFXALWB19gW
 4HuqgilYpsl1SVZozeOmAm6A/IchLVFU86nd27LHkeBTdll6bERcSK6uw2g4aBRFe64zm31FTRw
 YReEepshE+BUvfBVIwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Gustavo Romero <gromero@redhat.com>

Update my email address to my current Red Hat address.

Signed-off-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261002185538.1020233-1-gromero@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 78d1663f09b4..13c21595e61e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2307,7 +2307,7 @@ F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
 ARM PCI Hotplug
-M: Gustavo Romero <gustavo.romero@linaro.org>
+M: Gustavo Romero <gromero@redhat.com>
 L: qemu-arm@nongnu.org
 S: Supported
 F: tests/functional/aarch64/test_hotplug_pci.py
@@ -3183,7 +3183,7 @@ F: include/hw/hyperv/dynmem-proto.h
 F: include/hw/hyperv/hv-balloon.h
 
 ivshmem-flat
-M: Gustavo Romero <gustavo.romero@linaro.org>
+M: Gustavo Romero <gromero@redhat.com>
 S: Maintained
 F: hw/misc/ivshmem-flat.c
 F: include/hw/misc/ivshmem-flat.h
-- 
2.55.0


