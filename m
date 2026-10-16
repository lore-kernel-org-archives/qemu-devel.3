Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADEFCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkkN-0007pL-Qv; Fri, 16 Oct 2026 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkM-0007oR-N2
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkJ-0002if-K4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG3YnN3260303
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/yj6B/fXiZr
 Ft4VGqQlAahqj1zDZncFmJ7T3SHrOxzo=; b=JBwgTNR5AATZhxFMAyqHwZ2Wp2E
 hCp2mOoDV7c/HtVe1lXjAVl/zWejWv38x7+NusLvm9zJrzZt/aMN3maRZeVNz5gA
 Q5FC8iDV3E4yES3BumZBlvFCS/Xz5e8ww1K6Koul9paQFPcsatD/FWIr7VNciMiF
 IJmSeXQyuob2lzzEXkrdHMtCzTqXA2VXdQr+7hIff949mYbte3Gy5haIAIGfrDyW
 rxInhrwFEmkKFb7k27mQEHqf09TpmvON1mGRwZzmfe+n51UMDUFfWufzZscJYsVD
 CzdmJT6sff4lZ4GYgXNqisaVOgkZRwRM9VJu7u6BpP2RxHA4yc2Ows9DpSQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq4502u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so179281a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167920; x=1792772720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/yj6B/fXiZrFt4VGqQlAahqj1zDZncFmJ7T3SHrOxzo=;
 b=cupLhLUVTyrZ6CJVCMH3wjbJnJSR3lYBhTJHt+RnYO/hj3mTSyjp0aFOxjT6Ljytg7
 XczXILAyzLKGmDeAmhOSk0BQRD0gu3JjoYtRr2dl50ruzf2YOPABELnBLmopD70BdLWC
 kJJW8av4hzcHwWcgwgqfpEYJhpVsQFbEv954RK+KAiKY2VLDJB1XZrwSGbonBgep+1+Y
 8oFIQeJy6oqZH3p4w+oc/aig7ivg30CFVILjdsu7T5hz26BW7uysycnh0qqDsfvu+eIG
 uFLxM5/rrZvUsJ9nknPRuSUZFyY5yKEEcm9oW/mBv9jtPkOQjEemTiZUnxaV1lS0oAWy
 rEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167920; x=1792772720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/yj6B/fXiZrFt4VGqQlAahqj1zDZncFmJ7T3SHrOxzo=;
 b=Hw6qRAmoOAMbhXIc7O8dPdQCGyARixN9We3sN85wRXxr5apq+gRZFWHAB1hrqH602z
 tdQXlgg6D5QaKFGghOigrewBYOW4VdDM1FqyzHrMUfEAWr8c1Iey+0exF4OunJZS24N8
 U4c6Bb5kv4+L453g0uihHDGaDAxAJk4MF6sa9EK7m1kQEMfozwMojHskgCXx35WO3AJT
 qWY8CujjgOTDKTruSbIcaehlKXiykmo3vRsp9JrwgwMTLvomF+bkGH9Rv8yRub39zexn
 1S4REUVI+6jFh25u3AdXUkqfcrHiz9jXZC8HaLXMhnAs1ksDrRMQ3UAJMOD379Z8mGLS
 bRuw==
X-Gm-Message-State: AFq9FYKOaF2UYx24GfFh8RIC+qAyVGcmh91G5Em2UTw5ZbRK2TSYqE7T
 nmrTGS6jFyTxv8EFEe2NpXKbX+K+X2QhvhY5ArVQSHzh2xlt2RRRxAXZn/yfY/wTOUxKlb3VO8w
 ldPm6kedinQlPjhNqmKKoFTvk+0TF07DgxZ1YX+s5zcWxzJZyL7wAHMpcWV87kj1svg==
X-Gm-Gg: AYBFou0SiBwQExIDDSYqKYSAnLikucAl/qOfQVVaU/td2Tj56ERCWHh0WV1EwmCUGGM
 uGNkIIwXBRASSC1Y/VBcmsuZwsoYcCNY9Ievjne+/QtmCKDa9iQUuMRAK+9Aq5XclptVgU8gM+M
 MUpfdSKYXblhVKfGuWRX2bH9iyjoZFpzhbFuAxZGFkAlWK7NUil+gY0DRdBkgC71JAEg6oi2XaY
 F2a3gA487B8APblYHIypbxLgHDw4K885SkgObLYjJASWxZwWQ6uqPAJJshz8pO4qq7nz+F5zNXA
 cVaRmEluKwJVE0DSKZKQZBFqPHrdEXlaP+ySI/wE+dy1e4cTFuonMVW6/5sOMDByRwUx8EZzwsw
 q7UMqTHonbdERAI4OJ0Xyu50nQ8u0BKEmVkZAXGPPl8JF/m8VacXy7au1dlPxz20=
X-Received: by 2002:a17:90b:5743:b0:3a4:e934:e85c with SMTP id
 98e67ed59e1d1-3acef0f479dmr320675a91.41.1792167919575; 
 Fri, 16 Oct 2026 09:25:19 -0700 (PDT)
X-Received: by 2002:a17:90b:5743:b0:3a4:e934:e85c with SMTP id
 98e67ed59e1d1-3acef0f479dmr320634a91.41.1792167918886; 
 Fri, 16 Oct 2026 09:25:18 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4872861sm5246143a91.7.2026.10.16.09.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:25:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 3/6] target/loongarch: rename to
 qmp_query_loongarch_cpu_model_expansion
Date: Fri, 16 Oct 2026 16:25:06 +0000
Message-ID: <20261016162509.24854-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PJVBmD-TdD9iIWai-gU1WqWqTmcX_vSN
X-Proofpoint-GUID: PJVBmD-TdD9iIWai-gU1WqWqTmcX_vSN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX2McQVXiOeqJq
 CTKmdY7biubM2KvZ9HAgY4KmTHCeSqFDoKfgWofV+Z3MXl13BEz5AR2HIFcbgCo3Platv2T3RkL
 GzuFDDwkjidQ0dPqg0o7q+ZUv73qh9iMzVzn3DNUfuXlhDT4H6zfKliDCjh5JQUx7E8B7l7naOV
 Vp7iIPeWpU2IJWP2+B+jbylVECKLaZYBQnMLK0Tz+FK50zdNzTrA9sn9npwgqeCwicxx/vKKpvN
 gmXFtqcat19MsBLEqvypzsO/R7HP4X0JTkDhgCVpyG9xULurXvnorENb6+14D9MvT1XM/j3WpNj
 MSa1fzyOLPRsN2cdLHVf8L8RowOxdQZpVxXAZbg4z+Xdaw402e79hzgnx+Wf4ttShmvIJNAZtld
 kwJvKaI1XnPlXUQT8cwx/h57t++3WukIn6kMbjIQdObdQz0WniLaOq5jcMUM19vtAjRXxC4gwgV
 BlxAP/qgERBCXgexvww==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad24ff0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=fiL0ceNYQ_cCCDdTw18A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX2o4DCIvGGX8G
 QSv/H1n1OSKZRLQTBO+vMEJiC1P7oCLfN5bj/mqzzdHoCwv6PDJU8lPyZ5Ms+nc++r2n2W4Kjoe
 S9eBc1B+RzmdbLbFgjJzYyiFbKKNZbE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160065
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
2.43.0


