Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9A606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZJ/uhJ4z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tb50RvJn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT627-0001UE-Ni; Mon, 16 Nov 2026 18:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT61R-0001Dx-Sl
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:22:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT61P-0007cd-Qo
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:22:01 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfAsD1573199
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zcVQ+1xGBkN
 T2unnO9wlOyFRWjaoVI5nv/jKGoY7E5g=; b=ZJ/uhJ4znbveLWOCTPO2jwO2cGF
 sq3+0AfIIvYtypIIFpZOfaSMozLVgpeJBjCCYOwYGB5iZT9lVeKG/v7M+SNgked7
 CixEOFmCgm4V74iwDq0rBpfp0xowAWDhzwQcoRdyfORdRGeHmBmyZooQwcWiJpai
 jNZ3mdl8L7K921xEc+y3MkZmqf92oqEpCft5zIF7JWghWSvDDvdb0Gi3eNwBkGNz
 KrdV9Xq8csh1ZG2smkJKa14VM+98AQch70BJpiC4E7KZZM/F2f4lWo46CqDCyeFY
 QVS3gr0l0qDKR0O9T2UC1Ntbj7IKES3It1GfFtyBJJQ97EG4hzt7w5tPpyQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgjysf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:21:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cdb8b260bb4so1994825a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871318; x=1795476118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zcVQ+1xGBkNT2unnO9wlOyFRWjaoVI5nv/jKGoY7E5g=;
 b=Tb50RvJn1VRnPxyav2sxeL2cWCJf/kW+L9+23nANYoiI3cvV6tRVHoQmV6HWCQ1xkQ
 R3B0C0sW6E54ND709mNHO6BDpUVbpWnDawgEmurNvJ+mNVdQpo3kVa1xja4HqOxIYBHJ
 FuKxAn5b76/Go7AgB64S0aQTZXrwoOEBcw8z/KliPfvHliiKj9WcmD0MRF8FERbKNf1T
 m0Cb3m75QVKqQfRrX4vhUHynKY/QoTWTvwhZaSB1yM+mCmomcMVvkjiaBvt17jnPuwsq
 uisp5m2Qo1dvSxoStFilIKrjat5ALvsdO81lOV2I3OTqxcvBzKRKdOy5At5oNTYXzgoK
 WjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871318; x=1795476118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zcVQ+1xGBkNT2unnO9wlOyFRWjaoVI5nv/jKGoY7E5g=;
 b=MYJhlUTb7eX/RhU7oAHF1G6+ZRslzXTE/+RXgFeMcrYc1GZ9zygXBX6eDm6v9thkJr
 5QmDgOBip7dSqBiSdb2ro2/xy+Ue5TohiAg2yW9UxAwbwVdzFw2W7DsBXe7gN7FvWMv2
 OqyF7/CA6fH2rbXjq+lnUM8lFgrfoaHsodkzCyeb2g71XEqhqu9SyPFCOcfUOPpV8w3T
 Tj6wsu3GwX3jlQBOtvlCiCIWRECUKo94xvIGJwPhC634EWep6VkHSsK6LwB6AKSStaYr
 jsoGI8f3IpofImFakZ5Vlr1cugkno1i50M8g38gC96ym8zZpbUg+ID9I4S55JzOpaov2
 lF1A==
X-Gm-Message-State: APuU4Z+958N2qaCOFqZojFDWuXzEcZ5lNMkLFBVslwoYdNaC3cYkneqP
 enJDFUY4+G+RIB6HzGyq91ApSjRsLI2y3fiqDwaP78/xRQdhE+9joQk5JcRYoMeqtuqGPMhpVnO
 FV0ku87R/2A/jmVcevqDwZZxZM2ZYdxtFbqCRR8Kbqz6FOjmVHHRTnEplpbTREZDtZg==
X-Gm-Gg: AZFdTZcblZYZ9jAKeXfVsClr5dxlxCQyqaj4PJsPUIQjKm4IlmxUdDwU6A4dHvcdGSV
 U2GXIBu+EE3MJh9UM9y0zNpNHjVXxlYeepVhiRF5V/yfUifHPvRO1f7fHVQIOK4LYozSZXxrGsJ
 Qt72GwKhHRwEtsFx87llKRk0BloIcw17V4tDOOnjRFJGpJhXlAglFOA+MrgP7xQm96YeoYY7Xpa
 QlGhJYleQwg2IGRZ93flS4jqTByxMxfeLjgo1f8cyLA8KuRV4ay0i+AjVuWs7y7wdc8ZpltAHnn
 5HnUxVwQBUUi5URKrd3ZlRTf++o1FFGMJzFvt+HBbPl+u8iQ3uems9kZH1tc8Ew5lcHSPdwv0pN
 NZZQ2kwXMHq8KFWXWv8elI88HGkz8AfOClXTVvZcg6ThO9Z09HPPzPpv8NVueSc4g/6NxCKCo2t
 nM8eqbEnzOy+LV1ZFGj10AJW0VkR4wUfpXKjsl
X-Received: by 2002:a17:90b:4a88:b0:3b0:a7b5:c037 with SMTP id
 98e67ed59e1d1-3b1b07fecf9mr11375127a91.1.1794871317757; 
 Mon, 16 Nov 2026 15:21:57 -0800 (PST)
X-Received: by 2002:a17:90b:4a88:b0:3b0:a7b5:c037 with SMTP id
 98e67ed59e1d1-3b1b07fecf9mr11375114a91.1.1794871317297; 
 Mon, 16 Nov 2026 15:21:57 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abe77179sm1059550a91.11.2026.11.16.15.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:21:56 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/2] tests/tcg: detect redundant exe_name/test_name
Date: Mon, 16 Nov 2026 16:21:40 -0700
Message-ID: <20261116232140.2758664-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX91ILiYEwARbE
 yGP8L6EOpSZHeSYC3wMimL04+9ux4oecBcys7elLLpX1eiSdG1SRBLmJmaWWLZtvMe66dwJp5SF
 D2J9iKx43sAFe9Ree45loPniw9ljvtU=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb9016 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=aTqnNb6tLVYCh14j0hEA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: ItSq_1OBsNGTTPYsda4D9_9A9l680s7d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX+rBsvoJuMeGq
 vT7EUA9cBF7PCjH/88m/pJVgvZkrdUcVHY9/u6Vt+LzFZKK8Zs8GLtP8OWobMNuINU+GQCqeO1w
 +hXF4CJQi3XsfHeExMZ6S4VHlH3YT6DL2JHrqBBZxSY9K6/lviblEHkkCFw+n7+SPwFj9zAceqv
 pplClK/SLNPEvSPXupXWT2qX5xSTfDrvSpiJXPhzWKS+XjlpFPvI5kDBzk4k+QFumdpHaixLsSq
 S961g7VT/9HFgA8FIYc9HWjefKoqNELaHAZLZLfvw8Dci93e1PRO6Ni1M9SeuiwSuNF3F8XfDni
 MwadrAhxoXXBcOMaERUXmzDuVsB1LRw6odhwn51F1WRLo9dXgQxbUnPoFNJ4Nu6Pq5h8R4z0vBl
 hKBPXBPEHJf1BLP3tjPFmX5xM4PdcKa5x0BUosVbAhlLnvr4s+sIDSTo1nGZkq+vJwI29Qx/Bsr
 Fc5VhqdVhk0RR7gG0gA==
X-Proofpoint-GUID: ItSq_1OBsNGTTPYsda4D9_9A9l680s7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With this, we make sure it's not possible to add redundant information
for test definition.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b61ddf80514..01c0aaf9685 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -356,11 +356,19 @@ foreach target, plan: tcg_tests
       file = files(src)
       exe_name = fs.stem(src)
       if 'exe_name' in setup
+        if exe_name == setup['exe_name']
+          error('test ' + exe_name +
+                ' has "exe_name" that matches default one, please remove it')
+        endif
         exe_name = setup['exe_name']
       endif
 
       test_name = exe_name
       if 'test_name' in setup
+        if test_name == setup['test_name']
+          error('test ' + test_name +
+                ' has "test_name" that matches default one, please remove it')
+        endif
         test_name = setup['test_name']
       endif
       if 'gdb_test' in setup
-- 
2.47.3


