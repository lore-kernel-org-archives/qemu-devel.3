Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0C1CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBe-00009B-Qn; Thu, 15 Oct 2026 15:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBX-0008VQ-OX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBT-0000Zk-GH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3gjE3902242
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FQNOlqedaMfQ2GXc/cH+1QWcc53cAumajMzU3WHE8Pc=; b=AAbDTgS+8Pp9Lh8p
 O7SpU0HqS2vtgKR/J+y+sPQh8s51rp6dQynXuxkKji1pMgbqxfimNxu26iNHf1lg
 ze9L4JCGOnR2ryT3SUbCOWg9LoaBGZpJ2N6Rnu7NIYea15bvSYhcpp4HpqxLmyN1
 IhsiBXhvi2B3hQB8DR6deL5ynp6+rQo+u5k8Scc9xWejvASbf1b+E+HHV2WM3rQ0
 DSzVErCHchJUhwoDr1kVZniwNFiKNBbRRdzkgZI0t5XYUHK3w7Xy/l3/jFe0bzV3
 dY3H7nxqAAE00a72s9qNlS9ClX2y8andM9EeUyQv4El/rpHYphlW/1rb4lpl0jD3
 h79VTg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3ser9r0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso8156733eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092720; x=1792697520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FQNOlqedaMfQ2GXc/cH+1QWcc53cAumajMzU3WHE8Pc=;
 b=HMHrnXoN1HMcrjZmAQzxqhrVO3vW6iskY2KOKDhTgP988+KZ9RnWYtpWfHU2mnoXLJ
 q+X3z1Aw+VX/3Le1n60Hj0tnEix2lk88PgNgB/kXhk32Rde3iY9xuJlRG/wM4eViGdcA
 4jCFUlfL4uM4qABFgnEP07F3TknnA9E0Djf07nr4Sz7HJ56GEaG1IsfyZ6Gx5R+6ha+5
 9n/3282JfgWCLUlGAe03u02xAcZQX9GxzqzbsTX2hngwq2bMreeXVgUoKHLPuIkwhUaz
 G4blj2I92vroRT7ZMMZLB9+5jBIbs5r7OEurbzoxSfUpqF1LGBk+Y/sg8XtNl/m4/MA4
 SPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092720; x=1792697520;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FQNOlqedaMfQ2GXc/cH+1QWcc53cAumajMzU3WHE8Pc=;
 b=FM7oDZ31BurYslNgC8lEw+1dI3MlyB5LTf8BVJ6jertHMeyqrW26qY42V5sNMyQVcg
 dAQOJYf4CN+qRV47JxkITeEwDAfPvb565gcyP8ak2jcjKeQYoIdO2XmLoDlhk4FgMR5x
 NWCO0/8vgIq8brNk7YV2j+dd0Hv4mfVCU8QavC++z7PKkHy8wUyqa8nELuiAY7vRQLmP
 LeAvt8x0w4ogtoO/AaIY+mTA3sGUMu3kabhsnG9jMZLEfUddiTsOtfH6XYRQ7/MZyNzP
 O3zqbpNcm89M/TBsmur48QCe9pv2VWLKUb/lOL5MNnt7ocwMUsFkKXZsGo+dmBhx7o6P
 Aa+w==
X-Gm-Message-State: AFq9FYLTa54cFlQ7dk6WfqUlc30bxNHCcRBaaeOjBR0lhre74G8ilpxM
 eUlnX1T1bNlcSNhMkQtKncz+k/V3JdAf53MjoSYcT3LtNcncJ0OvTYxd/9tKwCMuxFdCdvSogCW
 ezr90rR/VzIKOFemgcVutAlPmqe+o/nLKGag7j8e1DAIRZ5lgFVpGM9gcfVSvbErp2w==
X-Gm-Gg: AYBFou08DFCG5xqqQrO6OoNJxjx8dIKIel0U4meifL6+vMu0ToL3IzHG4p/flkoW8Ag
 eSEbelbzc3eO7Hp5PFHZ0z9FQNrZey9gS7uj1BnHz9kcO4tjxcLy+S+DMkqprUu/SgjSPijM81C
 Q2WTWCEix1/Q/Zm431sEaJxj450HoQ0mgIgWxXf8hS257yzCy8VCjZ8gLi2igg30lOcQW9UwFtw
 LboDc1QSr6+NIT1obbJeADNePsNWPr5KaWMBe4VaHjXIDQwdRF0zfFBn1NGtlMrVA2lMF6QY71V
 zuJyKd/8ENYitqEegfDUOJnrMjp/hgZqxaVBJncqun3mCMmvTHUCqL4eBwWly5cAGQZ79uCXHlA
 NRGWTRaSvBuybjDJVP4eP3lLeB85oQ6Z9L3J8K5F9P1rzx80eaEFhUi+BeaHl
X-Received: by 2002:a05:7300:3398:b0:35c:ef18:6a78 with SMTP id
 5a478bee46e88-35cef186bbdmr11283052eec.2.1792092719803; 
 Thu, 15 Oct 2026 12:31:59 -0700 (PDT)
X-Received: by 2002:a05:7300:3398:b0:35c:ef18:6a78 with SMTP id
 5a478bee46e88-35cef186bbdmr11282860eec.2.1792092716644; 
 Thu, 15 Oct 2026 12:31:56 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 14/20] target/i386: rename qmp_query_cpu_definitions to
 qmp_query_i386_cpu_definitions
Date: Thu, 15 Oct 2026 19:31:06 +0000
Message-ID: <20261015193112.145326-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kBjFmpOscAivmhgpWebjythhTZZyb4EO
X-Proofpoint-GUID: kBjFmpOscAivmhgpWebjythhTZZyb4EO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX5wMmpeFK1CpH
 rWjEC0ZF9Mm9IvQwkaYf7wIOh+I/OcCnwpGXNVFKXVq4YsJUrW/9RwER/g3s+MvQ+C7VUM49Vvx
 RR1RFBwU68acEA/GEhUDpP6YO5LPBX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX7LOt/U1C2CAz
 b62tPFnG4qwwIrYSTMgHArz1v3XE++Eamv/46QixCkWBzU6AV/p+VkjJxKpP0lSXurx+sg5bopE
 DNJWNWGFOjXUJJys6DP7cu8rgrhTKCfooZuj4iTE934YQ3sJs6zXFr8Yq0or1uH3u8d1n27LSKV
 Fe58N/d2rE8AaMdgke4/mTbkvEMIZleHgScP2VwaWdXvSvVEpTxzeacrpcgnreQGNrNqxZICtAs
 gY9O5PcbfzSSLy9EMN/rFfXVYNO1BIqm0rKnFR2XKiy20qoGuQAQurvewbnfubGsIFLVjJGIyE7
 4iE7ltieMBac+gcg0PJMXLDBllckBocSurGsYPr12qP/Qk8GL6Ili29xc2tKtfZowSKZSlnM1wm
 WG7it2DGfX1nD+rS98HQuGR8nuTBhOCj5RG4KAAANBSmbJDhjLXfj+UO3LUyx29cVqIbWHp0WEL
 GSpw4w34hgbaNV+G15g==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad12a30 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=MS-RIRMcFKpjuoZhfecA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h | 1 +
 target/i386/cpu.c        | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index e969aec667a..84b78c3a097 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -10,5 +10,6 @@
 #include "qapi/qapi-types-machine.h"
 
 CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp);
 
 #endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 74eebeabd7a..dc762b802e1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -45,6 +45,7 @@
 #include "monitor/hmp.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
 #include "hw/i386/sgx-epc.h"
@@ -8191,7 +8192,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list = get_sorted_cpu_model_list();
@@ -8200,6 +8201,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_i386_cpu_definitions(errp);
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 static uint8_t x86_cpu_get_host_avx10_version(void)
-- 
2.43.0


