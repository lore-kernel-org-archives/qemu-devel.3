Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C5BC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAo-0004sO-BZ; Sun, 16 Aug 2026 10:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAO-0004Wm-BQ
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAL-000116-UT
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:51 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDmShb3952895
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k2vztmyd+ito8pBxnQA32kIPy6gCaOEGn0qxtiZeRd4=; b=QCy7qtI9E2Qei7hf
 iPoI3PrvhInWhreFAzVc179Xl+8G/NBJ4D/XJjvMOPrCVNucrPSvCyyHq4YDPutl
 WKVl6kzD1n8Y5ZrYfBIi8whMK2BIdeQ4mxIsrvmGFnDEG8GlN6D/rW3lc/VxSPRY
 LSnUiy0IInAjN+exB6PJ62pXSYWRmNrc5XBgNKn4/K07Xiqyj0uy4XQG6BZl3pmj
 158O702ZT47ukYKaixC4oJoCWGGZmT6ojxprqdLM3AlvOeF8DCQAzc5ORDjQB2Tv
 +CUVB9M4UQ8T+Kp1rPyJdxzz+CsSd9HiaDJuikVhmKYzzNIL0TIrWA+iBHxPx1qZ
 TXUREA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnumar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso51118021cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891728; x=1787496528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k2vztmyd+ito8pBxnQA32kIPy6gCaOEGn0qxtiZeRd4=;
 b=Xift5/2hzFetn7kQtzqVcA1eIhmwS7UUvn9SrqTPDjssBjYExVDWpXwmnTPBWB5fB7
 aOsbPVNnCcBvTtR2AChlSXCPSMhZqn5FKfX2vqr1tFZKLpiuJobwZrJGVoVIeCHgwFTJ
 IT3iL0Opn6C6/IUvWhMEzKq23qWm+hSq9iMhhaX8ZZsylSx5erioTlwHEUnVBCNsL0xo
 Y5K+ARiLjmCIkgT1MMZ6tFShKboKbJXDinpC6cJtje0GIJFoPfnArkZzq+0JtlSu0YPz
 tgjy/N06PBrCpVkGG9RfOrXua7w8LfYh4TN9ZvJINmr+Qy0ANR/NOI3/RCwjAVbwS3em
 phvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891728; x=1787496528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k2vztmyd+ito8pBxnQA32kIPy6gCaOEGn0qxtiZeRd4=;
 b=h9tDBq/uAFheiiX1fPP59DzOAorFS8mT1rKd9C0+vspyibDQEj7qMYjIyUc6L10OPV
 hxaFp4e4MQJ3MlFiDVc3mssvqas7XL3MH0rggTkWiDDKvo5DXfkrwYADM1QNG1v2B248
 Pmt0+V2CQrKwb1MHmnKHiN07HH52qAGqzPsqjIbL5EePDis2inYG0fmqljLhaQIa/Cpd
 K6VudsGCgYgU10eP319nkxCIOrjyQ7n6gDPCw4mcjStiaDU62vbsBZ4bj7etoxpCYQSI
 Dwi/L5xAgw/6Jaybcb5ojORvt7oPFHnfLOJhkTp8/UhztC2alBoX0kddGaPTHh1HCPKx
 cLwQ==
X-Gm-Message-State: AOJu0YxoK0382SmqHapWTv+5+Y2c4hMJuyBOokO8j9X3SpMgvulxSQl4
 l/ki/9nPssUJE+7NScRF0LjcJmp7rvVNDC7YSJOUyFD7NA1/tROTDlTsGDZKlRkqm7NRuiyNC0B
 +EgqV0tepe8kkSxQs7pWGeVTYwQ9FoOxSK0dcD7WdAXTAJYSV43WM1bQBRdM74w+97g==
X-Gm-Gg: AR+sD13mvAj72FzqRv+ECKiG3VXnwoOJpb5VkpSiiDfz6C84SN67GTopfGdlze9HeHx
 AX9lfe8zPViR4av80VxsCtv6mhlbFmCnbiwELT3NEV4xG4XehRfzirKXZ+lMwJ/AIv9MWN5195j
 EvPGG8fOvd/k+rqkelI48xtwAZ2zp6GXl13W81HMvMTcwNbhUvWZ8Ulp/vJo5lO+YPNaAHe7YQg
 JDw5gmHkycE7DW4zPYFL0B95vg6YvKQBwpwHFIsl60Jc0O6tbOikU88+N2HFPbNe+kGAPnNwiRP
 JjuE7y/sLBG2vtNulnR4bcrNWTfK60HRq683zgfOlfEM172jbX8gDoVZ3Np2CWZAyyNkxdksV+m
 qvWr0jUSTC6wkjEqyghVejeolLCSxToEab+Wx1FAr+Q==
X-Received: by 2002:a05:622a:4819:b0:52c:cc14:ff63 with SMTP id
 d75a77b69052e-52d854d0e0dmr222118991cf.37.1786891727868; 
 Sun, 16 Aug 2026 07:48:47 -0700 (PDT)
X-Received: by 2002:a05:622a:4819:b0:52c:cc14:ff63 with SMTP id
 d75a77b69052e-52d854d0e0dmr222118721cf.37.1786891727475; 
 Sun, 16 Aug 2026 07:48:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499960ff072sm71369665e9.3.2026.08.16.07.48.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:48:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/56] hw/nvme: add SPDM_SOCKET Kconfig dependency
Date: Sun, 16 Aug 2026 16:45:19 +0200
Message-ID: <20260816144556.69009-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXyTs/kg6rVkzZ
 P4ZeYAwGgxoxpqELlQnxRWqiH8Nx31VMEvnsJFanpS/OLE4tGqrJiTfQdRX/1ShMF8gtI3EEQrs
 +qRGKOW9xGTTAVxO3aAKUZSe27MtvMkGHeFuc4/uWKH2FGFNluPmyVwrBMhAPKkr3dgxZfEoqpM
 IKz3n7seY0kAb/hYZ4WIHxYbfpQchNTmAJfUesKd7bQCq4o/UFY5XNa3Qk7MG/90xCxw1JJar8m
 JoreLmj9qJThw+9QK6wmdP19vLfIhlSwM7PQK55ePZWMItfD/4Q7aEHY2h5lp/VrMKSu+agWCiq
 7CP+h8thxiT/FEoJ0mn9bUI8FPi0D1VgLAlFLHEDCgoNS5hEmdMA1kSrj2mTQNaqJYjqAwx6JrB
 KGygNAiVS0Io+HdN0tRDXuKGYzO5ouN+kymUNyxUw0tcz2e5DmMsUhKyhUUexP/yRxLwCyRmakJ
 Puy9iDMS3Vgz/tqq68Q==
X-Proofpoint-ORIG-GUID: 35bYeeuYFzO2CUO0tEPAHayTmVFkIavp
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a81cdd0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=XpcZagfQ2RrtaB3tMhQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX4k4G7u3ZEyuC
 c3fE4GLczv+D0xIY9oYZ4CzsMsf9RDHwDtmrjNGEyKx6o8r90tvWEVsEmIXyvvKj5LUdg0yhZVL
 rvwNQVpJ5y5RpcMBOgRZOTgU1d+hhNE=
X-Proofpoint-GUID: 35bYeeuYFzO2CUO0tEPAHayTmVFkIavp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The NVMe emulation code unconditionally calls spdm_socket_*() APIs. Add
a Kconfig dependency to avoid build errors when NVME_PCI is enabled
without SPDM_SOCKET.

Fixes: 4f947b10d52 ("hw/nvme: Add SPDM over DOE support")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260810214846.76805-1-stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/nvme/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
index cfa2ab0f9d5..cfeeed64cd7 100644
--- a/hw/nvme/Kconfig
+++ b/hw/nvme/Kconfig
@@ -2,3 +2,4 @@ config NVME_PCI
     bool
     default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI
+    select SPDM_SOCKET
-- 
2.53.0


