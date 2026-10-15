Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45249CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHFJU-0003nH-VA; Thu, 15 Oct 2026 02:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJS-0003mu-W7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJR-0007k9-Cv
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F5mjGC500266
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=plg1LPPZ+aO
 kskdKFOc8fJPQ4e8qjplLm5ajfZm9STs=; b=D4xyLIKvxuqqp4WlFiDnSqajMpA
 Kq16NhGNW/AfqbILKECvyXSQbctF5L1JHoYZPywX1t6ceNo1QS+G+eITDmHg/pV3
 Tf+5voNEQ4L//3ZCsfHZkHtF4mo71xR1eNoG1szeaUKKrAy/xx5gotQsmsKA+3SL
 OohWQrhZfXzRPsYmsYKNkghwNiwmn0pAnSt6fPPmsN95bp60y9AwYaXP9AdJx0WU
 zgnH4OWPIovJUew67375JwSwA29agazJwms4h3PH2PCscZW1L0w0B1GHYn2HBoTm
 9/fH90kphuYGrGQj/A6drvbf39gYelJmGgxkPUAwi1U3ngsdKp+baaitzBg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf3mx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so5736312eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792047095; x=1792651895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=plg1LPPZ+aOkskdKFOc8fJPQ4e8qjplLm5ajfZm9STs=;
 b=daQWDxT+2NvyDoOg98mwX58kdbjV2rsk6OaNl5hIsujEhcp4a8q+j/wlbkuof1lMpy
 WmThpUDdd7xTBmbJYXc430PsRekfD8sZpX5WcDCRMGfa0gPvMeLl2j0Hv+I2rM3Z0lQH
 Hv261ijc//TCgKCtl4VfWqqVbsaf8wdQXQPySDj8iA+civd8LQysxzjwyawyBCUTFY3Y
 MOds0MfPJBI2BAaCilUfzqfEnxC8c6tMYLg2exwCesDjDrTBiRODan8FWKlRcO4YbPix
 QbcTP3H1ud9Q8sdH2qMgP1NYt2SjReG42RngO3Z6EEBxzOubkYXUtpCZUwYITnTr2o4s
 ysiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792047095; x=1792651895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=plg1LPPZ+aOkskdKFOc8fJPQ4e8qjplLm5ajfZm9STs=;
 b=C6yamgDrRbCZ41sQqpzKc/BCUbQpH0LN1Qv4wofEgnudDY0B5BgtUiBoJUeRAPXUny
 /yy1LJtpKMMIS1gSfFj6pmk/Me/UgcUgtlVwwQ5HUI433exPXsAPf+PfAG8sHthD0/YS
 KwBsUOSKAkNpcK+MO+pQ77zW+kqecLEMuovgCtCvUHo63j/Vi3/Sxzi6n9gpzjWrtmid
 m8LAi2hv7bz7jYd4ymlN62rS9AuVtfrkpmpM60B4TJTg1hMOkjN8lUmmEx7Cv0JZHjin
 PW/7Wrz8KiMnoD6MFOa0Umj9X/PCIN7YVqF0rKcsdatsHwHZkbBYuYm9ZUHOLnm//nBX
 EEpQ==
X-Gm-Message-State: AFq9FYLfd2cl8zWQIeBzdgiOLbXvV5iw3H3F1QMuOghdGg9DmEpGIqT2
 0+weKKYOQVXGMPy7b+aCn7NXjVK6FINtd5m6bFlubm1IPZVnSWrEeWg5xn+aSRtzFwOYPU1iekd
 e0yXcLaxPsypjO1ULRzxS+EWqoxB1BOlS20W1a0tlEejYS8mAdQV6+TepLR5Kcbtpcg==
X-Gm-Gg: AYBFou2Geral2vUIXyW5/ZWSSCW/AHWrc6zG30Mv1nfcklDUa6H1QSD3zbIQz1zGAaq
 3OYdyspwhDooJ6oYCxJ5HSJmjtmggsBWYtMHgoS6rTRdgpWBiGbJcYrDrgUWodf9izM71l4xmUD
 mOI3r+1AEcWEeWGgEqQWNG6EZlfob2+MLDNbg1/0Q3Zp63QF5jR7im6BjiPxI9vRGmLbJM0xogJ
 s+0iVIm4bacpQ1sIS3IlrW5B425m7H05V5HGzXh8Dpla2s9Y1O5jmdYofcf1oybdfyKJDMAn1DK
 KiHflD6tp48pelOQrv2OzR6agy5SfBiGejC/2L33zxa4l9g5iDeH6xg4ksOr46+fkV/EGfJkLyZ
 cps1dxot2JCZMS30oIQ8GbIs8npE3w05qdMOPIMOTKfDEPSS80+Il9jD5gCduRcD9AYAGf/GJCZ
 34liBsO3aVM5A=
X-Received: by 2002:a05:7022:eb53:20b0:170:64b:b388 with SMTP id
 a92af1059eb24-170064bb41amr19669585c88.46.1792047095037; 
 Wed, 14 Oct 2026 23:51:35 -0700 (PDT)
X-Received: by 2002:a05:7022:eb53:20b0:170:64b:b388 with SMTP id
 a92af1059eb24-170064bb41amr19669528c88.46.1792047094071; 
 Wed, 14 Oct 2026 23:51:34 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm67451789c88.16.2026.10.14.23.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 23:51:32 -0700 (PDT)
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
Subject: [PATCH v2 1/4] tests/qtest/bios-tables-test: Allow PPTT for RISC-V
Date: Thu, 15 Oct 2026 12:19:54 +0530
Message-ID: <20261015064957.4076464-2-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfX1tRYaw4Atd81
 TH3LYZdRf+y/XEVKEwRKUWUFpc4AWhQv5zGccrZp2CfMXaVqz0LurgYtOxs3DYzvDSecjsHD0kO
 SU+RFWGJUsQ6hOX4W9844ErsaFabp3Xt699vMhKV9loVWggvD0L3UnMF8R/sUDjNqAGvkocuQzN
 /xzu1+j5uNYhccJfSUT4UtzSKbDAOYBpdwN1rDaRS31TePknS1SOTN4YPqRER+a6omTxsyzy7tc
 mZ75GDhquH+kPeWhwU8CxuB6woFxXHCsIcjVGsTMSQQ+bM7kK8YssxAaolJ/ocDGRXc3UJ+pNf5
 VGRy89mn+HImxMOdfg9s89z0cl4OWUTVq1YvptkvfIj/F6sSkvoZfd+MaNWZLRTSpZ0laRW+Wml
 ighHsCI6ySTstE0fdP50f0ZZKzOuyOXnOFxLop4cxp7eZVTq/cnrVYfOFFP4k6+vZZoD8U15s0b
 BqCiIHm7sQZZQ8FP3cw==
X-Proofpoint-GUID: xNP6NzRQxcxQMhHSCBfhNH13YpT0Zbt-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfX1g9vPEzwsCrF
 A9+l2sPlvCJktZ4ScW/k9AfGreaG31xdEEcfIwixKPe7UvLTYFi6K90vjsKSXxsm6G6CpBvlmAB
 pVZHNjpkHW33AQwy/ymaEyosT7H14TA=
X-Proofpoint-ORIG-GUID: xNP6NzRQxcxQMhHSCBfhNH13YpT0Zbt-
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6ad077f7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ou02Ivcb4NLdwMP0g4sA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunilvl@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Allow changes to the riscv64 virt board to add PPTT support.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 tests/data/acpi/riscv64/virt/PPTT           | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/riscv64/virt/PPTT

diff --git a/tests/data/acpi/riscv64/virt/PPTT b/tests/data/acpi/riscv64/virt/PPTT
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..94be7a69a22e 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/PPTT",
-- 
2.43.0


