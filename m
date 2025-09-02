Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FDFCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1a-0003Fs-A4; Mon, 01 Sep 2025 23:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1T-0002kH-G2
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1O-0004d8-Vo
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rowa029965
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +6ZAJ60HK8MdNcBE3d7EkRCI9HsC+RkYUzB7Q0859BU=; b=IWqiK7A+93jg8F36
 sYmhZ6+6TCc28+iGhz/vL1vF/RwGYhC5RbuWpVeTYcCtj+jGVBBxylfCDkMSTlL7
 /ao2BQLUuMC3i0/9nFQX4jq0DCsdOHL88DLKPcJhoAL0mJLZe4vNFwj1YETOsAS1
 +h5QMtuSlRfXoOMSU201hWxVi91ERYzDMvahiMnUcZ0g42iin7TVp2f3VlbrkY4t
 s94Pl3ikdspOLsNpSwKNrqNoRDi9l8fL3f3N1cbdtkbhC6+rZxdTgYjwHh/KZJrZ
 lWFuYUcqtBmOMwAJxfRiVHwM0nrIw6YiT2jvRrPhivdysriJ5p8qAwMa6pX2nwov
 I2UdCg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-324e41e946eso8954410a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784955; x=1757389755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6ZAJ60HK8MdNcBE3d7EkRCI9HsC+RkYUzB7Q0859BU=;
 b=k+9Mj0zRmOMjDh/ob19YrZCvEYobc/phC2WKQcNOBEAiHBQpmwlVdQT4P1xYr3m8z/
 b0UW4VdBn4wN4VGHbBixxGyVom1UGS86lEDH0XKX8q+fzupCyiNJ/cb8nvh5Y/DH9d+a
 FOziyZqvKNg/pgnFzl7WQKTB7ZcyXgQ+WQc5ekqWaHFc13stYuDnOolLbF1ZjPPDOBQi
 i6S3rcsxQlDCmx4FgJZD2QhuWQSwVKh8nVGKhgULThRneyHyL+291zo1DbqfqJK+xJKP
 ACDmND577UBmyCupgBN6MkZFR4eCAAyxT4poy8h2YesnBDDpDlq65lFV5Kc1rtUrkA1e
 yFow==
X-Gm-Message-State: AOJu0YwpyEdAM8pn2PobjFdRT57+x9v29wIWJlqO2XtxMZLFTKnTdA0F
 b4LQ4ATr/QaX97d2Jo1WHTH0NFqfhugrv+vYK+Qzp1C1yVc64x0zoIgEZQcGlSwYNuPxglT1dbU
 9i0IwbAGibw6UwnqEuFYRVK6BpjnxueUZpp7xWLswDZhXmKYhNOhOQ541rLErlhn6c+L4
X-Gm-Gg: ASbGncsRKl9BbhFea6x/bOYbfByj56b/a4GE7gvgiTgeOLUy/G2tFZJPq0PPYQh4Ln9
 VN74eilAA2elB3wYFyz1UvlyWiexpmBK0jAdlU/cArTlGAFBdS7A15ZjVkqg1wMPY721njZZNgm
 YX9VIg4HZVXuIUOPqW7pidy3qA3wpZ8D71loy+fF9MLXLkDsGuUlVDJ42PjVHj9H2Z61T4ibqRc
 IC6K9Sdjwku7O0A4KkrIOf8TtfgYXq/v7SvZXh3qBS9peCujsGN0mZ7kvf4QLyj/6RIXXAW4qW4
 UxD9pdWaAmNveQy8qPGxn82r1ET/+G3Dm0kg5msZYRzQSiAV0l//+r+3kzE6WGR5Ld8tyQRuCbD
 VfG1Ra0LxKQ9g
X-Received: by 2002:a17:90a:d444:b0:329:8160:437b with SMTP id
 98e67ed59e1d1-3298160445emr10385289a91.19.1756784954654; 
 Mon, 01 Sep 2025 20:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoUJESB0Q61KZS3fHcn0wlkA90cLHDGkvgYfMvIxclioC5Jixbx4s3LkJwma/tToy5bGD3EA==
X-Received: by 2002:a17:90a:d444:b0:329:8160:437b with SMTP id
 98e67ed59e1d1-3298160445emr10385265a91.19.1756784954177; 
 Mon, 01 Sep 2025 20:49:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 18/39] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Mon,  1 Sep 2025 20:48:26 -0700
Message-Id: <20250902034847.1948010-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b6693c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: HPTxYyM52asyQHjpv_gpzmZYZ4wMylua
X-Proofpoint-ORIG-GUID: HPTxYyM52asyQHjpv_gpzmZYZ4wMylua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX4T2SvUNgP9gD
 CbJc3UMNUtNu111pALS68vNWb+b7MG3oZKlInkljSMapQ42c+pury/eWgZhT+d1544XCvJQlmIb
 dUnaBSFKWBusYZgtUFlnPfvnVtGXK1Q1lEVe8RzcTn1SahG01XvSN5CeqZA4VJljuBD4kMZia3d
 xuNENekL2IssaURltWnlChgcnZeIElLNjq4vFiX25S3pDkWOEPQyYIHFW3tL9SbFErELVQovlV8
 rH1O5p0cfqts4z04H2ODhvm3qOA9FfOI9Qt7YG/Dc7bI8cGz4tfo2KZdelFUJbftrrXe3S1nrZ0
 4iNoxHFBs2FYFy/oYEU6to7GcMPzMpNhHsXigEW36Ol69UW/SnmKhofCRewWhKSPEcZ190rWhMr
 hl9LkZWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 85ccf9893a..0445146f2b 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -511,6 +511,12 @@ static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
+static vaddr hexagon_pointer_wrap(CPUState *cs, int mmu_idx,
+                                  vaddr result, vaddr base)
+{
+    return result;
+}
+
 #endif
 
 static const TCGCPUOps hexagon_tcg_ops = {
@@ -525,6 +531,8 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .mmu_index = hexagon_cpu_mmu_index,
 #if !defined(CONFIG_USER_ONLY)
     .cpu_exec_interrupt = hexagon_cpu_exec_interrupt,
+    .pointer_wrap = hexagon_pointer_wrap,
+    .cpu_exec_reset = cpu_reset,
 #endif /* !CONFIG_USER_ONLY */
 };
 
-- 
2.34.1


