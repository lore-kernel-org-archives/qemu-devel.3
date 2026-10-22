Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EB606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J/a8WnL8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lp+b8xol
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0ny-0002VR-A9; Thu, 22 Oct 2026 17:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0np-0002GP-Jj
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nn-0000Lh-Rh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKWlJQ3413268
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oHuoUrPP4FO
 nzON9fey4nSuGHyv/SLoiUS3gipH7DEs=; b=J/a8WnL8FVSS1n3ZiGWxw5B1H9m
 kqBRdFcHM04GRbDFX8QZ8FWtYtqV8scSxKW4SjnMyYNAj2XGeyyllM/qtjt8mk1A
 Ws7rr2gobup7xQtdDAOwcDIyhJO5DspoYbhe5tYAoUa8Zx6XPjVSPFootyvLZ7f9
 TwFRQcWSlDE8dG3qatY+8Th1r3zx6OfWP12hQMrittUe1Wl7ISeRqQ9p/f9NRhPs
 FB4HEylz6F6c53g35x7yYttBrpsNeySpPzIf0jyi/PuJXbApYYjuNzcGAL4wLNsp
 FSSOA/0rInBAOXeOyLz4DCmg3i3Ct8LEslj1J+dzyrSEYj0wOoe8rO1H3Dw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmar8e2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3abfcf726dcso384718a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706292; x=1793311092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oHuoUrPP4FOnzON9fey4nSuGHyv/SLoiUS3gipH7DEs=;
 b=Lp+b8xolb/+czGivnKM9hMPFvzEl4ZjTzWyz2XvOUQZBbESUUbsN/nBWMJn/eCOLJQ
 ZJzofE8G3/9zJfspluwXDyNITin7YigFEvKF5ODnE1wym96jUzRGzj15p4gjtyXJwoTR
 M22UAkRuIPOVNSSlGgQvmcWrZmCfk/AwfiFxZ3fpfq20SpyDghWR6gsac1pSMwIiRwxt
 GbkdX1L+RsrC3C7Av+lkqgGawBUGUCUGakJOVIyR1Hzaj//LudwmorLsPvNpXQ/COLea
 PHXiudofN2dVeOtoJ2phIr5qxdsefD/CVPrdXnHEiKUZqVj02Fhq4siRdrmQR4b1k9qd
 1vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706292; x=1793311092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oHuoUrPP4FOnzON9fey4nSuGHyv/SLoiUS3gipH7DEs=;
 b=yBGtCmuWmNwN1tt1Mbh65HCIDBIrjkB7jnteNof1p6J6DJ5NLyhvS2IcJj1uoF3232
 bkBYYnjINrs8ks5qzcIvhrJoILCPaFSwSODFa1n69Xndx+/MrYNeleO7lQecVfu566DD
 hKrLtYFUcxa6XgKndQ7rzhXe9cD7El4dWEKtO2b9Psh7smeFHXkUQW5Dj+Vm99ch21AI
 XJd4TGakuvOtB82oFRU9oYaMSnHZN7yvZrFSoqgd8jEdBYKeS5sy+dbSCLg9Eu4VD9NC
 bNPvBNx2r45+1/4wr+pTTnnmWWHDzWgZb0XFoY/bq0xHAIT+gMUPajjlXu9gHYwVJV8r
 NByw==
X-Gm-Message-State: AFq9FYJl7iXmgWR2dMhjDbYmMwxxpLGLOq+GOKurHw7viRR6ZSZLYcWh
 nqfdR26DLh8cF6/NeCZRn5GbJuYgNPGZ4a1Bxu3fyBUGWRG22/6unF1cTx47DfKSLgIbxWowG4b
 vbsqqQ2y8JnY3JOXgGFzRer6FsGBBKadYVgK4G0nEVcwgUBKrfb7mqECcxmSthn3Ipw==
X-Gm-Gg: AYBFou0hd9hcgK2Ra2TbQ4BpJs2see27JCAEGqi/glWnWexOUkeu7Uj4oEzBKsGi3fz
 1aK3NqkIq6N7+8duij6MWI5rbo4DrmgnwGwuEEhOvREt1yNSlfiu3rGtJqvXZQmuIT7uayw4Y90
 Hvt3Jz4JrJc7jfuugYTK//27N+m03k6R7f56R5tdPSdqJnaciQNhA11ODG6BDJUcwkIV+W1KJG3
 V8JvBitXsvbOiTe7KXG8ZsDaBtqmswpn98muoIL+/6mGh9skh4L/UPzfWeoFQh0EHmWWwqKnMm5
 mta24ve6GcKJnmDUGehllwdQTg/InJ/uunV+q5WPBKorDcBBwE7z2a2BD+6D6FpUdumJ0sIFeXx
 uKlOsLXWGNuwG6Sd5EN2eRzMP5+grIoc3FA6ZYZWldAuhHfCMfwErqU1qJU86bqY=
X-Received: by 2002:a17:90b:3c88:b0:3ac:397c:574b with SMTP id
 98e67ed59e1d1-3adce13ab8fmr194641a91.54.1792706291672; 
 Thu, 22 Oct 2026 14:58:11 -0700 (PDT)
X-Received: by 2002:a17:90b:3c88:b0:3ac:397c:574b with SMTP id
 98e67ed59e1d1-3adce13ab8fmr194628a91.54.1792706291213; 
 Thu, 22 Oct 2026 14:58:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 24/27] target/loongarch: rename to
 qmp_query_loongarch_cpu_model_expansion
Date: Thu, 22 Oct 2026 14:57:43 -0700
Message-ID: <20261022215747.2479440-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6ada86f4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7UvLiwb0lT3xj6fr-RYA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXykIu3P7IAnR7
 fmnuawikczViYIfmWsi2ZQk4D3LcjmlqG2AYljQ1fhHXOFFo8cMqoa+2TWB4AUA80iCioZdzBN7
 fVYJ/jHYvxOFNDBV/tUyILXnW7sPFXg=
X-Proofpoint-GUID: q48Z_UtUh-_-BfxbT66kqpFe_n0PNAYh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5LWL8SOdIl8w
 2rtFjhDo7bf0VhaIKDvTvMN+L4Oq/7vUCGm8UTGHI148c0UyvzxXD/xi+CYPZVjk57D15oOQLiV
 ljgaOzL5iKv7ARQVSl3QAnlc3av83sF1VXKhv17y/GzpGkmrVTWTUya9ANeeggD5oHOkIQRbxow
 i27Vs3X1LuXg1of/LpAmHqQdcFSJVIpPLxdNb2uyUj8j89nqkhDYSq27pLPWIaQdJD401zWeuKu
 K765qtciYkNS8tH1ly6r7Go+KOqg8iE1fToouS0kb1UhJwhi9wYxN0mXYAucCvgwZHqepSzgMZl
 AmGgsj013HGlOFJA8plgeGtFqztHqEAB8/qMeVLXrY171OyoAyEAap9d71TGLHGI5Rt7V7kgtO+
 PbFXWqnpEK5eSzc7IhohBEwRnMtLDZ1Vph5C5e9lzj3rEN8EpKH5MknBl8KxRHZuBAa91v5leya
 IBIpQAYk9PmowCa4c8Q==
X-Proofpoint-ORIG-GUID: q48Z_UtUh-_-BfxbT66kqpFe_n0PNAYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261016162509.24854-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h              |  4 ++++
 target/loongarch/loongarch-qmp-cmds.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index cbf8ae7867a..6a199dcf616 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -25,5 +25,9 @@ CpuModelExpansionInfo *
 qmp_query_i386_cpu_model_expansion(CpuModelExpansionType type,
                                    CpuModelInfo *model,
                                    Error **errp);
+CpuModelExpansionInfo *
+qmp_query_loongarch_cpu_model_expansion(CpuModelExpansionType type,
+                                        CpuModelInfo *model,
+                                        Error **errp);
 
 #endif
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 351b6aed7c8..59f8069d8f2 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -46,9 +46,10 @@ static const char *cpu_model_advertised_features[] = {
     "ptw", NULL
 };
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                     CpuModelInfo *model,
-                                                     Error **errp)
+CpuModelExpansionInfo *
+qmp_query_loongarch_cpu_model_expansion(CpuModelExpansionType type,
+                                        CpuModelInfo *model,
+                                        Error **errp)
 {
     Visitor *visitor;
     CpuModelExpansionInfo *expansion_info;
@@ -134,3 +135,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
+
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    return qmp_query_loongarch_cpu_model_expansion(type, model, errp);
+}
-- 
2.47.3


