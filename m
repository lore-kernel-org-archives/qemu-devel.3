Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB09C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3ev-0006Xa-PL; Thu, 20 Aug 2026 10:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx3eu-0006Ww-Ct
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:22:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx3es-0001Mv-JY
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:22:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KE8ITw3147070
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GV8dpwIczy05Xf13OcxLw/
 HUV3OJt16gzvfs8yBZmvE=; b=pEBgUb2zAz0X/YMqkD+FaLuZoVL9Mt+zgNih93
 lMRmxIwJAFxci1mtCiTmK31ktuSOslKtKRh12PSrObivMf/VVO0H5qZf4N1gN0Pj
 /JuedBnwupu23MEU+YQQ4+7uUfRH+9m7msnlWPg/Onlq2pniksTLsM59crAObQer
 ZC60pgEYm2cetjMaic1kIS03VFcdA2eJWTLaAaz3H6PehbjQRBC6GY33aOXSSotB
 71tbVAtT1w4XNPT0pgoANHwiAIdnqvL0OOfxhHsg9PVDTeDjoyTNz8tAR/3+0wG7
 /zbJ/k1928/jdtxrvlryAVwy4IXkLfxpB16ehCXdlsZgpyAw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7srw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:22:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so302935185a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787235735; x=1787840535; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GV8dpwIczy05Xf13OcxLw/HUV3OJt16gzvfs8yBZmvE=;
 b=O6HYGlItYP9GDZafvtxrwkuKZr0xG8MXCQREkFcEWkC08FA4qrNC9HV+9wYD3ERkJ+
 vdQxIgQ8PJOpSpDWutNAkOS//DHC0a+MKlfaCHhGTPM2oitno4OLBylL6T7JC6ybUrwS
 y9EaoyieyROjEURaHg6Ccc4i2JEc6mQqN2ifgD8RwCpIAjZb7ppIllMJhnA4PcP+xuWR
 MLgYDdJO6vsC0pEVs6SGmnvbFQiCXoiZGfT+fijTgd9IrII92Yi/8Pcge+9ZJyirH8vI
 esDvwuqq09rEjdcYc8zk5qCFhFPHQaPhGKcsNscXP3ubnQvU1XVywuv6xYfB7MX1GSmj
 ekjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787235735; x=1787840535;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GV8dpwIczy05Xf13OcxLw/HUV3OJt16gzvfs8yBZmvE=;
 b=ERKih2xm6xiZmeJQE8UoSEeWFZ2ssGx5XpggH4WgED+IdyxjXEJqsNYHYvkxIfFTbE
 ENKk2SVhKmjNS/AwfoEKtHnRLr6Ae+hpzEEHKooxPiCIhna3crcBO6BttMMgmGFER0bR
 x9XsdVlaG7Fa8AriRa8zAl67pHbi58HTiyW2wcEPe76jYXvOkfWcZUvhU+96PrGQaM56
 1RybhFGMxSKr/n8ZYKrtMx6t9A+vfPDkF23IOjB/QyQrcFYvDu5RLtXO+6zZyt0HtuTg
 iw6mriOa/DMD8SwP736ktvfifoDcPOEvXLuYpp4gYAzJPiryyghDsVPrGkmz8J3BiQHs
 fwRA==
X-Gm-Message-State: AOJu0Yx+xR71VX2zgrhw6g0kY/YxWKK3g9anDSuHXrQE7A5157jsbfeT
 UmSc9RXUJEHJr8KlHoC2WzYXg8eyWFx7UXnZvjyRlNsdG4KmqcjRWnGtobEz6M06M2i9Ei0v7Wr
 +k8TXF8QANhxDdrk9y2CjGFq8kY3dbTKQw/mdJ4Pcf59q0+6ptqFd5BO+QA==
X-Gm-Gg: AR+sD11sdt0F+QAKzq9ZTklzB1reHyUQjJhB7CaUO0AmFCnXJeS8+kR87Tx1MhAKQEW
 eCSCoIhdfHI5xUiqz/3FDp/gv0OO9nMFVZ1F9iyhLaK8j4GeNcCjkavryxB+rdfrhkygwQrGzR1
 YT+vrI9dKC8/pFQpr9UYiBvrJydgkOziF46CNR741XgBvk6rKmWTwAPSDzecUtrWE2BsPqEdtON
 Pai7Sd4uz40IWwFsUOr60vwBrVsQDG2c8RoWHSMWC7NiGTbhNnT5HSsRjwlEDGCZBBfwjA+cdXb
 x/WnASZchvd2zB1o1xUqODlnJNxt4n/+ZN/vn5ea/8NeiCjlNTVlz5+nOc1cth5fbaV/zR7+ZA=
 =
X-Received: by 2002:a05:620a:4886:b0:92e:76a1:96d3 with SMTP id
 af79cd13be357-9371e6ee8b7mr1110351485a.34.1787235734960; 
 Thu, 20 Aug 2026 07:22:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4886:b0:92e:76a1:96d3 with SMTP id
 af79cd13be357-9371e6ee8b7mr1110343485a.34.1787235734317; 
 Thu, 20 Aug 2026 07:22:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17f202sm138321775e9.13.2026.08.20.07.22.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 07:22:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: Cover pflash QTest in pflash section
Date: Thu, 20 Aug 2026 16:22:12 +0200
Message-ID: <20260820142212.27537-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOCBTYWx0ZWRfXzcZ7W/TBO/FC
 YyG9/fMVMSo5BCN83z/TbBHveELDjJgEasckJWKEmfgvjIhc4K908LnDu73RMnjoKEtxcfDOGHw
 5g9LKeLciwWZ2mhSth42NJi8lah+b5qAmcHZWnAOsUIEATHADCPjRaiZuQ8LHE++nsHCJpOv3Om
 lMst/QdXoDpRWhHYKkX0RKzlsuU7H4SA8mIkYAz6yKiyy24vmXI2I7/fW8l4Fxn9P1ALyUKcBYR
 H70aUWXnidjjmcKdxr/WFUEliQOSsbcl0t7KoL9L6vakjIwHbBea8Kd44i3B15LqXHUj1vl6A2B
 iLrRM5zQHdtmbIIEwZth6BaxCVh6v8NL+B63EJIDdfEwYGCLIO5nSCfGiKX1THFb351JvwXEha4
 DfdaVnioOcmjPbhdSds365tjBrqX4g2+8hVOcn2qKgO2Z2k4qhSxokri1v2KD5Fj3N/UXcNyAvJ
 bmzgA6/edYACkdP5/dQ==
X-Proofpoint-ORIG-GUID: zbrPbgnnRK1um7kCi_n_6BG94ymVR_JM
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a870d98 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=20KFwNOVAAAA:8 a=tqVpZ52y12xuJfn1US0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOCBTYWx0ZWRfXzy6BI5e99lCp
 5CAKUWODFk60M1fllm2dWVCRrHRzgcvudYq7d07L69jFxYPfW+GDmMn5BPdSjpp5K2oFAgUH/UR
 pnvZLzY0cuAT1NGkNp4v0t//480ZXAw=
X-Proofpoint-GUID: zbrPbgnnRK1um7kCi_n_6BG94ymVR_JM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200108
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Include the pflash-cfi02-test.c test in the "Parallel NOR
Flash devices" to be notified when patches modify it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e602..0361909b72f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2354,6 +2354,7 @@ M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: hw/block/pflash_cfi*.c
 F: include/hw/block/flash.h
+F: tests/qtest/pflash-cfi02-test.c
 
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.53.0


