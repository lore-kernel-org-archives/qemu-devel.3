Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78D0CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqa-0007ar-07; Mon, 05 Oct 2026 14:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqG-0007Ow-Jj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqE-0005hq-As
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HuMIb2484367
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j0v1j16hFCno7RMRv+RoCDbDSqYGSNRqX8vxb4hOzy4=; b=dXV/n7Wz9lI5sZ5t
 84Ei4t37gxCkrtDExkwqhK06IRiF11x0ccqYnZLQRDCIQgBPoOdHNFbyGrJX7ywX
 689g+tJ+tCW4HB3TxB3JTg+1XjH4WFKoD9mBJhSvlxxEmS5bVpLNyIZ9we82NMBB
 IcNhvmX/0me1FE6TcCwHcGpBkm6Bq4ggyrKDv+XTw3jawCO3HL0A4gBI7Ovtnhfa
 3rtadEQJZMyjaec7gNLqKaeJYvFhPi0kNVvPh8x8dnSk/+pgpGJZCsAbg0C2E5ot
 eUM5dsEBxXcIiDyVJu9hZmaf9JirjDlveNSUb48ucHVZa8vK2osze6ymfsWB7Fuh
 A42JAg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr087nt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d80ca2184so2766529eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226512; x=1791831312; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j0v1j16hFCno7RMRv+RoCDbDSqYGSNRqX8vxb4hOzy4=;
 b=fHNIUhEQk61wGQl4YhCJFudN0QuRP5b048fO+x+9CaNQ7q4ZViyYeEo1wVTCiDxea9
 L5wMD3UL8QN15ijuCX5mnU1JhMuA9z4IDEt318/R3LGmptKO/BA8MbNsg1dru8d4/HUp
 rE291Zh1rHAl4XF2XuWz5CuA7Tyrdmjw4Ce2vZHBEI6ertR6741UqIQT6mKnb7eKKMRp
 KqgFXkUA77HDRsHGwltGZLIHIUbrVfdMAWpfjPxcbKIYBcl2sk+k/1XB+rmUugWci2kk
 WWETdY2Jw+PQIMRbrvRs6hqW0MImRDCpBZEpprddUtnNbzMHC4cLNNjsB0uHDY6ICMci
 2NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226512; x=1791831312;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j0v1j16hFCno7RMRv+RoCDbDSqYGSNRqX8vxb4hOzy4=;
 b=0bDKsIIe2DkLPtpUjr/iPPHk3v8lRjuPX7T/QL32FpFYel4v1+18AI4ljcBsvO1ISB
 OiOgZLglvr9Sl6tRj3SpgU/Gmhkvty0/16alRJNLNBPc20pvxF3HjpfAGFjB1Jv/Ioxv
 YgEnO+tsiGwIhXEmWQG1Ysqv5MDAH9R1XEnDLSi6CIS0ssMfNPMAWuii2nDV6B8wcOjn
 bYnLwpc5yxYtwrxlfLh99A4cMqwfID3QETVSJwCBnD+vPYRMbq7r6LK10WxS4BpptO+w
 ENjFc/ynsrTebFj5mtCLZ7L5GFkKD2j9plCVI5pPPociUr31d5jmssAwrx663Y1PwhfR
 qRow==
X-Gm-Message-State: AFuF++kF6tIH+BT7wC2Xlr3av0DxGhR/wj++JKwEaKxbi9ZAz6tj08Fy
 G4acTur7DtmeIcXlpf1vqO1nrXUmk5NK5glMTTeLPUNJSj2v3l4xR+yD8IPPQyuGDrEfYdWqeQQ
 WP40V86fVFpZ4AzkSDTSE0OxtjGClP/fNbbcOB8sUrkD/QvmhmlQbeBXbrmxuJQe3eg==
X-Gm-Gg: AYBFou0ePArEBMM2hNqVcoAKf8uM+Ii1ThVvfqxl8Su+9j75yGxhyFeFd3Wk8h0eLTc
 KQS5sXCvUhHS3YN/NFp8h6tBcXl0pd7VmV8UtmDjv+dObtrgR3L1EfBNQ9HwvPWxdwizTsB2/S7
 jF3Yxif6svV3zJQo0i0KrppRcH3MjJSqP8YAdWIDMgvygLnD71nB1ZrfRFsSZxYPex6nYoH6b0F
 e3IkwVviNbXX3yaQbqtfoaSqa9+NCf59e/Xp76tEjRDwHKfLnWXK1uqweh78RfLGqIznad7DZ5o
 Bmr8Undk6Dsbzb1spJd08F1b6Ize/33LxJ+QF7Sb7AUAfbUeqGzcjwYHUeudshY3Q5QoDI4P0bH
 YEoH90cF6uq+WIko0MpNiq3B1QH5b87poRaESxPYaic3btouz1YuKa2m/pHrX
X-Received: by 2002:a05:7022:f51a:b0:136:b50c:c0e9 with SMTP id
 a92af1059eb24-151c33d34cbmr10246759c88.21.1791226511904; 
 Mon, 05 Oct 2026 11:55:11 -0700 (PDT)
X-Received: by 2002:a05:7022:f51a:b0:136:b50c:c0e9 with SMTP id
 a92af1059eb24-151c33d34cbmr10246723c88.21.1791226511196; 
 Mon, 05 Oct 2026 11:55:11 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 01/22] hw/arm/virt: make virt machines available for base arm
 targets only
Date: Mon,  5 Oct 2026 11:54:37 -0700
Message-ID: <20261005185458.405929-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXw21x2Qgkhpt0
 X/+BWhKEu48jXHiugKwbLVlff1+5AtEfWXdFsxola50zgtKL2oD+BJt6RfNSz3a9CIhH9iOvQKI
 +UYS2oiNcwYU2V+DYUnOICQvAuTzYUdK5S0CG34JcYRMPww89xz8CZgEXgDTJMuwN6k2yXBr/jF
 O8iHq5NnEEhnbZLYeh1GYFfAjM1Dca6skCmwYV7XSJbGwMlpRhBWpw784K6L+MxADfgj8P9vX61
 h8s1siei51Ip0QZ6LpB2r1qkal5UjbpycDmARUXUuONDDBcN1ofK8O0m9rdm+Vcvc3Enz2RDzyj
 fWcJRHHvn3eeZumtV1tpAsTfkA5U2g1VATWBh9deS23PidJs2ShOAAMfnAIK9JJY2MOyU2BrZko
 bvPeoqjY0d5nKi+D921ghnDTziEwvnBr5KSR6Dn16RGdBERrcuxANAh4nzaBcPkjQ3+EhU5tS9F
 1jCUGoMckjW+tmaEWdQ==
X-Proofpoint-GUID: 3IeqxMkIPKDnfmgm_-wLHhviXj1P2Y65
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX5tv5vOq9Q0B6
 zxIzHOruLAacOq26oTDm6qsaw6eKAR/uLnY5KRmXEUY6cpYmIaNTWpFPI86AwYtHP2SAIAE+kir
 abI4MWMrYjAXVu4pqF5pmY5Jh3Hsonc=
X-Proofpoint-ORIG-GUID: 3IeqxMkIPKDnfmgm_-wLHhviXj1P2Y65
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac3f291 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=SCzHgWm1MmOasogXrZYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

The virt machine type name is shared with other targets, which conflicts
in a multi-target binary.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bdac33a1de8..9d192515d85 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -132,6 +132,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .is_available = target_base_arm, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
@@ -4429,6 +4430,7 @@ static const TypeInfo virt_machine_info = {
          { TYPE_HOTPLUG_HANDLER },
          { }
     },
+    .is_available = target_base_arm,
 };
 
 static void machvirt_machine_init(void)
-- 
2.47.3


