Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EA606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ0lVwTQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fd8VRBhN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nL-0001jn-JX; Thu, 22 Oct 2026 17:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nJ-0001j4-Vr
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nI-0000FS-Cb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLa8lg828637
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I7Axch5Ih1Zx7ZYX88b8RUp9GnB62drecR4kX6OmOTc=; b=UQ0lVwTQjqWB3EYD
 mZ4+ZnktvYPFTRcEGjfR4DgDJxBGI2smsyic5i9Ph+VAASBujfFLOB58SUWx5ucR
 EWuW4OpGUEycqL7Xvj9TYPAtkjd7VBEDYpzc0rIu7szhXRMQVppgIRYofdfpr/DM
 A+6tNAgg/epeJv11pmEYwHx0VPv0ciNMKrheefwLse3lUPMxY9ImCzLEMTG9fWdM
 FK4iN2UeAqo7WsoCLaYR1w3sl1Sp7k/a9kxaO2B7J9r9IxtZLBZrQC05k3tS621D
 1p7zbhoTNffbO5F0MwecvER+mRSNSXXr1rCUjVDwu+25PNc5WJlWH/3Gnahfw7JI
 xx1QJA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw184v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad7030e886so318347a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706270; x=1793311070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I7Axch5Ih1Zx7ZYX88b8RUp9GnB62drecR4kX6OmOTc=;
 b=Fd8VRBhNcOSiZXTSZqyMbJq47rO+4h2kb1etsQ3Nr+eIXz937Dlbfdpfd0OrPKzuwI
 icwkqc8ohFrdp1ygZboWBtuMdMrt9DL5zX8DhYe4uIrniZJFD4DoSa9Ikeu5P/N6Hkte
 cnUubCd3D9DOoaGyavh0NVtPYc0YYVQiukNZtNcSKXhj7LdBsUEd6dccTTfg7rivCXtp
 h2jcO+/be3t3DhMguNqc4xIJ+XNniVBeqnZfJ9TE5lZ1bXooSsb/ULvEqCBHQy7tL5Zp
 TGBg885PurARfTFUs/zX0KBhx3v/OpKNqIvxO+5BOb3lUf3MWkxojsyCcMnNIe0VqlaO
 0NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706270; x=1793311070;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I7Axch5Ih1Zx7ZYX88b8RUp9GnB62drecR4kX6OmOTc=;
 b=crWa/C0Q8DgcfBeWuOEjQsR88svCGqaGLg2M+FD1cprnTXx2aTum48Iz95xAP5rL5K
 6vKscELCF8L/aLurL7gISYP88JIgVZ1i9WJfk85Sk4IRs6VBtVGP7CIzoV+syMP8TDOQ
 SF6wuLHtPfbX9j+2FAJ2qdpDIimCcOYPmfvtx37NPpfVwwkyGhdCdyD+HFOAWzwob+Jn
 09sucBN/xOPEORA2bBMFDOgipgwGAuoCOli3t3MffGrPsVscAf5itR4LV/bnuonw16kH
 St2qvBSZEhqYvJYixfQI5LOqc+Dao0WAGTT+fQeQZHxgEkz0d9sRqEt2RdQ5uqcvUcxZ
 N/Fg==
X-Gm-Message-State: AFq9FYI8uG3JH+nlcmt3uQ5DlMxhOyxpTErzh2OPtkPmKrctYbBofVEd
 YEVmsYaa+abBPiQZ+0pACNsNWV5rGJN0Eanew9rj6ia/895Q2SC/BK3YN8j6JQqco1nw/ZlCV3G
 ibLXkLcwzmZpMuKC7TfabQdhY3OOxiW2aRDZ5okwk+laoKS/nGs2z8+6BtcoYsQ3tzA==
X-Gm-Gg: AYBFou39mtwjidIChQZvii1DboxkUea2OslRgtAf91J6+kAmEI7169KSzbHu0lwqNMZ
 XVY2wbIWiI5jgCK4fNtnDwseAwJ4NPdzE//0lTv/quwBAK5RTLKnixKmafIalvPlQUsv43TB+d1
 BvVNljqITNrfKM97bPYR1LIL9WlK4uxkIuZrCcwmHpW1O0PkNmfU8P/gtpHMyZ1IyCmgYVbzNZ+
 Y1TBThaDGITbbVIeAcggBXR8EkcZf9QRBMcg5dhvbPGu+o41TljMTBFHU1fca50hmz06hs2eUJ0
 ukMHSDPIYqnhcGK+Hbfk7Qt+BFsvGdXgfcJtpSxOPP9AU21RH/Z1c9maTuiSMw6XCwLZwnyPQZr
 ioFAYxPqnHyHqRNhoq68doGpAySvqfW9QwrEaKlqfgnwqf5W1eL2308eWrsikAE0=
X-Received: by 2002:a17:90b:3810:b0:3ad:6090:a183 with SMTP id
 98e67ed59e1d1-3adce02e00emr231622a91.16.1792706270316; 
 Thu, 22 Oct 2026 14:57:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3810:b0:3ad:6090:a183 with SMTP id
 98e67ed59e1d1-3adce02e00emr231612a91.16.1792706269841; 
 Thu, 22 Oct 2026 14:57:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 01/27] target-info: add target_heterogeneous
Date: Thu, 22 Oct 2026 14:57:20 -0700
Message-ID: <20261022215747.2479440-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0q1jvzBMlZxBc5ZwxVQC14KBXWbfsk6s
X-Proofpoint-ORIG-GUID: 0q1jvzBMlZxBc5ZwxVQC14KBXWbfsk6s
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada86df cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3q1FPIo8JGfx5WVhvewA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX10nGA9fDzJFi
 F+9melscdY5Eo1CCF6WvXHFzmGf4DNFZolsFnZUaHIZuwVoeIw80dGGI1DxzpKgHE8mfAmTYbyA
 R6Y17lNFJYi/u7pFbE0EoNxFe/XEPE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX/v0id9/DljRM
 NG37qkHK2XpcDGFolC9TcpPZxJDC/XBZf/h6ApPkJh6cHXO0+aXXwo+Mg+no2oO/l5pi7djC2ii
 cONLJvfrXcWyzGUT6ldUyK8bV+ZeMEgX/+OuWitWORT4BrBrlX69fsmDbmCHX7fXlKBGnfU/S0e
 xyronY8BPBk0KWS2/CAmZP6+iQMuPfwUU/IPX2KiCcDdRtc9ZU1pTvOg5WrjNiuF4GwDvafCRpA
 JQhGvMUXoi6v59CDtPUtheEHfh2oq2G37yh0z6fOq7/6BRCVpeE9dfFLHDv4s9H7BvWVbJ96IUn
 MCOWkRQ3ldDVKTLv2H8LISFl0eaKMmbEJb32JBvSMWaqi12c0H+d1WXL6ltub182mewESsuM7lF
 u3Ec6bQxuwqdhRYsVUwlG9/0FveGkXHwC88rgIadk5odh5Iv0PlP81DS6B+4a+Wz6i/zCkekMM6
 7Qk8xl/nr92VcTCglFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

For now, this function strictly returns false. We'll turn it to true
once heterogeneous emulation in supported. Meanwhile, we can use this to
add various checks and asserts over the codebase as reminders about what
we'll need to modify.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 8 ++++++++
 target-info.c              | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 862097c6c63..923c00c917c 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -42,6 +42,14 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_heterogeneous:
+ *
+ * Returns true if current binary has support for running several target
+ * architectures at once (heterogeneous emulation).
+ */
+bool target_heterogeneous(void);
+
 /**
  * target_base_arm:
  *
diff --git a/target-info.c b/target-info.c
index 254530d8ea5..b8a4a7ebf7a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,6 +42,12 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_heterogeneous(void)
+{
+    /* For now, we only run a single target at a time */
+    return false;
+}
+
 bool target_base_arm(void)
 {
     switch (target_arch()) {
-- 
2.47.3


