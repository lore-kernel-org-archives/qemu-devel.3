Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F117C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjL3J-00036b-UD; Mon, 13 Jul 2026 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL3I-000368-DL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:06:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL3G-0006dd-S8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:06:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8UFG1803676
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4K+ocDlAE85
 321hooxQqx2ALuMnvYzwLEQVdi5i1raw=; b=dJzNZRhybAhVI9ab0bt8XZTeuQI
 pH9IxDJAVqo+l0Mxp/yt2EnauDgNncaGc6paQUOGrSpzOSCacqjEuLfa5HHX4xxq
 oGONNgmaV4LD4huRWneoDr4+w4UF7TL3VZ9fIjlf+w//5GP/yEP2K8skymGYZahQ
 6cFoeQU+gn+/LUjFS/5An3lIZDaYL/Sh0Y7FpHU/bgFARioY2bh9Af7WxxXzNj4g
 3NBxCPZO9RSF50gYE487p/MjMxJ2hf5Yx33rV2vsXP8m/chGSCT5jq9S56Gwc8Fy
 LnxWl4LDEmy+TMrRk8SCpVn4vJnyrt7noQAT1cbfq8hiVi3BGh8OftmVT3Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4sy99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:06:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8895156101so2509549a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783966005; x=1784570805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4K+ocDlAE85321hooxQqx2ALuMnvYzwLEQVdi5i1raw=;
 b=HB/lE/6uFpDFevCyqIW1n1fVxUun04puSTZsKLf+2qt6PfvZXSB+01+WBzI4J5HOwS
 TxJ+lKDWo2mdOlKffAtqyWtK6BsEbDXKqL+O8XC293IxpR/8EFThTPwoe2/xsraeKksH
 681HvyPFuJ/c55xvmG+mhqZf3vxhuL7gJMdZgkbonD/8iXhb6V7Vd9OQ3Sh3k2JoFmik
 q0CILpNOmE6SLTXm+PH4+m6uMFGy7fHFtIfU9l3BhIoIN0atrNeGoMt7P9NGri40WRXc
 +Ro1IuvWQQhW0RPgP1SlRWDRipAvCnGbNV+eCAFcbjvHzNBSE3MlWsAZzxvMnVFtjQFN
 m6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783966005; x=1784570805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4K+ocDlAE85321hooxQqx2ALuMnvYzwLEQVdi5i1raw=;
 b=D4a1sXAzw2q9qIqF7IH4MGdT6lKOEZOHuKITfh5yMcB+rV1r9q0cEyEg2B2aC+02AA
 UnAFy8rhBkSEnYaY+puOQa2FMmrORuMDqbQI9NwYIIVehZy1jQ/Vi7msCt7AQ6EPUvD2
 cFnqtB2PFQA5cvRLDlkuBa87yUOQ7FrpCIAD0qbVoqkuH/7b410cxRaD80qCMMFX7aSl
 t6p9507WTa5D9pAuj6iedvfZ9OQlJqNESMNJLOIeZYqa8BgjWtLaMppqM6HdtluWtK8G
 oRkgPSytxxo4C5wmHyaEytQwezmmusl7oYHfTRo2yDAd4xg7a/WbtTKs2lAbUv3SMyMj
 0zNA==
X-Gm-Message-State: AOJu0YwTGlIXndGO2kgGdGgL17pIsnXKEqCsyTSVMyNYSQwbukaFTzu0
 C3f/cV2vtuCR9qALI0AD3XLiMTvBH3Goj5W5nOvMIVbOTIN9WM0DckTMp8N4qC7Xhnw9MYQMHiT
 +ZKhKmkDBc5m4h96fu5GJ+tK0/V2NpDLiWHBHCuHkJPwwP2gOxGe8HfhVKM6ZebHOAw==
X-Gm-Gg: AfdE7cnXaHgfLzzgAT13WFywrxFRgaKJczed4mpyYriNKLNaTfnoQwidpDAtXiEr+LG
 ZY5glQAWbJZm0n1MNjNLSFX/If5wtvths7lUCzo2kRsjhchaaH7jh1DozQe114VeZTMldBIS5Ij
 pMpipEzugpTb4IjfEYtLIP3x+KYGRnF1lhL0RICx2HAYfioQlna72hcEu9Am9GvuUOT0/wdn+d4
 VN8i/FDiuQ/ul57BrM+10DV5FgfiodwTlgXg6z+sRdcX0Iqsdt1wyonXr3ZVNMHQ7hDErpJHNxa
 nzM2TohPJNLzSmhC+9e3KYDlPQQPTYfmPdngRwhMIE1iKqNbfaihIWNwqaMh6//q3IrZZKFIri7
 +9lErcoKkyMIfTwxwcry5AQHIE28BRkNfykMnG94pJ7X3+DP+69wLd7FgJ2ZfyMN+V8t+rw8Gd+
 zULkagyA==
X-Received: by 2002:a05:6a21:6e86:b0:3b4:9168:d9e6 with SMTP id
 adf61e73a8af0-3c1108993b5mr10077460637.37.1783966004591; 
 Mon, 13 Jul 2026 11:06:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e86:b0:3b4:9168:d9e6 with SMTP id
 adf61e73a8af0-3c1108993b5mr10077437637.37.1783966004179; 
 Mon, 13 Jul 2026 11:06:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b8a5992c9sm27501109c88.4.2026.07.13.11.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:06:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] uftrace: riscv privilege level
Date: Mon, 13 Jul 2026 11:06:36 -0700
Message-ID: <20260713180638.2228609-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a552935 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=dZbOZ2KzAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8 a=YMXLwu6otX1WtmdEadMA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfX1fyjfKwYWXrT
 QtneEo/6EQv6TyDsca20fgKwtGfPoEWSMSnV78+GD1Ra/qs1L3v+EE/CjlQcefPQ2E8TZUS42wb
 zpvb4/pU9XCGAd5GH1cF6dfHlPrOEuY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfX5S0Vfrhxpam2
 nusfqQYCr7/uZ4Wz6lU0vfmI9Rx8E85+jhAoOxLxCPv4GFSSxv/pQJWM6auHa2UuDEc1U0xkzTC
 +7z89ee46Zf/0pJ8Atla2EnfbEic30GurVSglfLOAVrmrRoBK4kYv73v0XSP5Wga6k+3AQvE7ai
 irVmFEX0XQmJPzwCmILEo1NZzQbC6d/7f/24zePwh9JGN0Fxs0VlX6qa5rgSGzpUFqwSDxKeEdV
 KJQUy/zJPS7doeqGMolFQoUN8zRGRF3KWl003QkTZ8QSMhdH3pIqH3RV0dTNbBeIQUC/oKUoubd
 74UKMVs6QvDpBXwjZmXxUHmUFaQJTWrHN3hFQsLBdcgcQnXyJ8KSEfgtZ0yObKYEYK2rYulWXv6
 HKyyXZTPI0R6XR4ScKmfx6MuKFQSpGXAj9hoCdWa/iAwMCznquOB2mANqH/xpTf2gFE32h4tIN3
 ui7/yhJ0+kJd4/kWHMQ==
X-Proofpoint-ORIG-GUID: BvswbqY5ule4PePmNI1M4oI7MUG3wcuB
X-Proofpoint-GUID: BvswbqY5ule4PePmNI1M4oI7MUG3wcuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130187
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

From: Yanfeng Liu <yfliu2008@qq.com>

This adds RiscV virtual user and supervisor privilege levels to
uftrace plugin to avoid crashing with H extension guests.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 9b0a4963aee..063e32220b1 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -109,6 +109,8 @@ typedef enum {
     RISCV64_SUPERVISOR,
     RISCV64_RESERVED,
     RISCV64_MACHINE,
+    RISCV64_VUSER,
+    RISCV64_VSUPERVISOR,
     RISCV64_PRIVILEGE_LEVEL_MAX,
 } Riscv64PrivilegeLevel;
 
@@ -153,8 +155,10 @@ static void uftrace_write_map(bool system_emulation)
     const char *path = "./uftrace.data/sid-0.map";
 
     if (system_emulation && access(path, F_OK) == 0) {
-        /* do not erase existing map in system emulation, as a custom one might
-         * already have been generated by uftrace_symbols.py */
+        /*
+         * do not erase existing map in system emulation, as a custom one might
+         * already have been generated by uftrace_symbols.py
+         */
         return;
     }
 
@@ -706,6 +710,8 @@ static const char *riscv64_get_privilege_level_name(uint8_t pl)
     case RISCV64_SUPERVISOR: return "Supervisor";
     case RISCV64_RESERVED: return "Unknown";
     case RISCV64_MACHINE: return "Machine";
+    case RISCV64_VUSER: return "VUser";
+    case RISCV64_VSUPERVISOR: return "VSupervisor";
     default:
         g_assert_not_reached();
     }
@@ -986,7 +992,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
-    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
+    qemu_plugin_register_atexit_cb(id, at_exit,
+                                   (void *) info->system_emulation);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
 
     return 0;
-- 
2.47.3


