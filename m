Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963D8F34C63
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJjK-0006nZ-EI; Mon, 13 Apr 2026 12:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wCJjD-0006gl-4M
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:01:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wCJjA-00023U-DN
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:01:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DEmakX1764445
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=EGFuY5l2bXI+/DkX4i7xgpWC8yw7k6Dv3SC
 fyowaT/A=; b=TyB5u+ttwKw5iZoSgRdH9crr3EQfmTjNGfO+rvU9nx7PAfHXMVo
 gtnor8qmjNMD4ZpTb616cXWn+fHZYAwR4sOuBvEzwzIRkXRvhuWSQT3HbMzMz6pB
 BDrjJfaoprD+dxIPrfJ6FA/P7ITrygS/CIitB2C55J6i1wcwm1KD+WtuaAOSV76f
 HBFeTLj/m2zRuXNHOuMlP0IpElOqVfU/CXvv8V7PS8iDrdfW9YA39RGo7iVERDb5
 DfdTligoxeCtxXLSt/yv+uR+9MmxfGI2GUFrBFgQ4NYcJW/0s1zXXOTCEfbN0JP3
 g8MhDXvEczlbbz+Ggsw2WrWujliJPqfpMkw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh2k087jk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:01:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so6418610eec.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776096087; x=1776700887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EGFuY5l2bXI+/DkX4i7xgpWC8yw7k6Dv3SCfyowaT/A=;
 b=Zm1yvGNqQdkRHbmGJib/Ijrtg4lTfGHoSil46jP33KUKsbQGMjsrm3ri9GFszYkA7u
 YAdg59pOinwN0L3wlnAz6XlB1OfQhCdQ5lv+HbUW5KZ3LOWzClSEza8lsZ9FI3yo4zlQ
 i4Ep5I85JuECl7/Oh5PgP+ruyulTPkSmBM1J77PSE18P1nnTsXqLlltVqSXGntubx2u6
 fmHMmB/BouUtis7AU8F42XqRD1n1Z+TAhSgCuqrJoi0orAK4rATkGPNNcfWk/OcMB2Gm
 84qSFXWmhtc/12tEnAnHEiW2LsG3a46Y4QdioocMAdfprdEDFquqmoKPF2+u6zV3eeB/
 48qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776096087; x=1776700887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGFuY5l2bXI+/DkX4i7xgpWC8yw7k6Dv3SCfyowaT/A=;
 b=VUrQ/A4qZHWicg3MaBvNlbD40j2Fl4vG5N9Bxyq1YnORc5bBvKrjm2QcUdHeD1fRgj
 e0gCi7ocmMrFHbOXNycVayveDDHUFk/vOlrXg/iT3hG8yrQlYKGbHkGf8VYFfxI5qo+x
 zlx+cRPrvWyaJsb+uj3bdzXLkB+DJPC+zOySiyUdeNQhao0QGycoAymNGmATmR6M87mC
 OZ7Uh4ZRvj82Cg6nLGev5V2c/sBSOrnHq6yoMDgo60hyaVlvIBciT/139Nii/MgJP/lp
 2dGK4zS8Swi984csHS+kpnN4eOTtzu6saNVvFp+MAM6MklymmeEB25yet4V6CgWMX8+A
 F02g==
X-Gm-Message-State: AOJu0YxVRNdMCaDZodCeygYtZ2jjc2OVxNDV/w9apzkg0smPlkWCsF1d
 qZE+adlNJoTKRzDfiStAFHhd+yD95FIQPR14lg7ru/WFKK+aVTSGHTZol8N54/TY6S9tPWY39CQ
 BpIVmjVrDIgCVBuRNO2XaC35OUkSeQeA9OqwZERESxMP5rkVlVgtqMEzMaQuCKtIUL5VE
X-Gm-Gg: AeBDievEjr2i2gsIvcH/3CAPWxabgeFLDy8A4sZdU7aTX97vn6N/eBi4gYxfI1BzDjP
 j6iT1NXDLRJKHznQWuaObLBhfXEX9pwdp1tQAKbfl62rpB90Mi3Y3O8y0W7tIh4hY6Y+mJrutK4
 SkQ5xpePFVOpGCkuq1oer0+BtjkVtsZMaU38hzs9ZVXHIXaIZ5T0M8Mu6Qs/fhJTKD8I8aIZkQA
 sby3yB7DmH8pcZvS7mlipZZFk1Imh19Er9z1MlcuXmU7giFh8AGX9MlObf8gUEVGLOxMcHMcOyN
 B9hq94lyqXlSKIxpAQHOEs7vQ50IppX16U91jzMeYjHoxqtcMseuN6sQNCui8T4zsQuDefsmfQ7
 xoCZWhvnlI32XPlPhn4rUqsCXiEv5ytPdQoT9d7EPDIqtFg7qzzQolt0jdowkzYRQypkTuaM623
 /hXvdCzpV7gPMCxHIeTQU=
X-Received: by 2002:a05:7300:e207:b0:2c5:d833:a4fe with SMTP id
 5a478bee46e88-2d5876a10f7mr7948266eec.10.1776096086367; 
 Mon, 13 Apr 2026 09:01:26 -0700 (PDT)
X-Received: by 2002:a05:7300:e207:b0:2c5:d833:a4fe with SMTP id
 5a478bee46e88-2d5876a10f7mr7948163eec.10.1776096085246; 
 Mon, 13 Apr 2026 09:01:25 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55faa586bsm19837210eec.11.2026.04.13.09.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 09:01:24 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, slp@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, richard.henderson@linaro.org, mads@ynddal.dk,
 brian.cain@oss.qualcomm.com, mark.burton@oss.qualcomm.com,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH] accel/hvf: fix double hv_vcpu_destroy() causing teardown error
Date: Mon, 13 Apr 2026 09:01:22 -0700
Message-Id: <70cca2a5cdde3e6531e5c8f1e399e0b584d51ad6.1776096073.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9i5stJn1e3izGJYLhaVde7u5scZmL_jE
X-Authority-Analysis: v=2.4 cv=CsGPtH4D c=1 sm=1 tr=0 ts=69dd1358 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=NluNWX7204cXcFQq7gAA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 9i5stJn1e3izGJYLhaVde7u5scZmL_jE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1NyBTYWx0ZWRfX9pWbvNDlGWHr
 W8DEF627ADm0DWd1YKrMbY/lYF0m8E5Qtc/5QyePFpAWCaC/7wFvQ4uFFeq1qCwcYzO2jkql7ii
 kheO9w2+8w2vgRXZ2wFjxBorm3yAtqFAovp/2AKqxPqAJ1hJ5e/T39QOrwDkxd4WGZ2JVsI/MSD
 thotQnN8Ixa6nFWdTNPJwmL/LKKLlraZiWBi56UjavbX7Te3srmlmIiXMIwNxf/Zm+81fYhw0UX
 YXryqIQO94KIKDBWT3aT8QrQrUCWa3PtkMjpBqZCqGUkKgo2wbHgLujRPnBRa/QWeyFvoMYa6/9
 1ln9C9NrS8uuwlTggDKfFrCF73M1Ifl16uDsv7q+2qobMD3d8bMi/gPYznwpind5jLjOACW9Sdu
 pub2Lua8UiY0GSxLiydmEZe2di/p1fNI0vVSi94fgQJm67tyz2l8cUOWXEntzUfToMcZjuueHOJ
 qtFrcPuQDEIJMbZ0qGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130157
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following callstack causes hv_vcpu_destroy() to be called twice,
producing HV_BAD_ARGUMENT on the already-destroyed handler:

hvf_vcpu_destroy
 |
 |_ hv_vcpu_destroy
 |
 |_ hvf_arch_vcpu_destroy
     |
     |_ hv_vcpu_destroy

Let's remove the redundant call at first function.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 accel/hvf/hvf-accel-ops.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3..d1c532f7e0 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -113,9 +113,6 @@ static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
 
 static void hvf_vcpu_destroy(CPUState *cpu)
 {
-    hv_return_t ret = hv_vcpu_destroy(cpu->accel->fd);
-    assert_hvf_ok(ret);
-
     hvf_arch_vcpu_destroy(cpu);
     g_free(cpu->accel);
     cpu->accel = NULL;
-- 
2.37.2


