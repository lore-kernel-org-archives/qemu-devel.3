Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB176CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdoV-0005Q7-9K; Mon, 11 May 2026 23:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoS-0005Oj-Hg
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoQ-00004x-R3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6REP1183966
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+nLbY8JMJdA
 iDui26QXsdA9zNJ+aiOby0h3EfFX61gE=; b=f90+RV9qBNVuI36BM8PCjK/n1tq
 Qfyvn+WrAWMFy0qY3iWWjs58NCqXWMzna4FVll9uD5Rt23P++eT5qTzK3gmylQfv
 Ou1hOiHvSeLpwVeMrTnaZ62n2uDu5M4OFojY7m1uAOAxD5k48KyLxnBpR6j90ops
 9BpHlpVSfBew5wzmSR7rYzGldAsk2wvnGo1QQPfHhJ+p85n1YBxoimeblSonoRxJ
 bA4fg1tue6ViFAcz2n1Sq0hBIWwBi29PCRjGe9hZ4yJQstZzhbpGsGm6hd++exS4
 SfmIy0RNs0m+GG1r4//q62IEUJAv1elQ40js4WP20wq3L8L3LlQBJxzMeog==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuy98vv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee5b73c5f2so7180275eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556576; x=1779161376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nLbY8JMJdAiDui26QXsdA9zNJ+aiOby0h3EfFX61gE=;
 b=CAdrhs4q3Kx9veTmKDkcTlbTxKTfPofLJdXs7gA1NtOFD2sOCD4LsROWJB4eN+0QoI
 auRqlorJstzVzE680hgni5egxIF6PpCzPK2R0cXQlu8N6kTRM54GDoPeJirs0Dpmsuwq
 G80JgJfw4ejgos/bgjglpuZemKMNAfwNU29zFjvWB1kk+ALNZ9JCKJSkrYCZqU8mRJOc
 7T33qizPTAOopXrganLYdAnyaQxBPryeqBIVfRXnFMiUn3JEAxdVOM+I2zPy3PT+XHCI
 pgcFWQH/yQhIVMZ5UvsymN1M0cMgfOYl+6otwX/Y73jXpLUgyrrKh3/ufGKJozy6E0Hm
 TjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556576; x=1779161376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+nLbY8JMJdAiDui26QXsdA9zNJ+aiOby0h3EfFX61gE=;
 b=LtPEftCvujqZDSqy40dR1z+AWjgn2T24wLxe+6RFbw8zgRVHSMoTC1k57mPV8OyOnb
 1lIkzBnHLZb5qjyO8zoqnVWDvbR8sNSVggRSIxO9aIHzG/WRHjfjWged7H/hWcjvoWL/
 PCJUY+hI7hV/D5XS32+CM2F8HmDSfIx9p0qjMuROpUVT5nrH7Y9/81fxyN6HIQseaqzR
 ADsZG9QoyWJvZtOMRKgNoSMiyFuj/v1BhLpF9PWbS4buI2cTY3m5bHGl8hF3uf+Fi0Tj
 uG42xNMW+EyAxPs7UiWYYt39R30wtYEUOxt9P9LdfpPZVZtvGYhLGELkAzmvaDI7NoAy
 3MfA==
X-Gm-Message-State: AOJu0Ywhddt2kcPYNZj2wSXxYIMBYEFOj9OBqIxCpzaRz09p9tQnc3/m
 szrrTKhJvcOHQrcIT5KBE21sFCjSZbTB75OnyVjdWraOdgzjbM+qAFH0/bclUG/aFP6Zh84T2c3
 zBWn9x65OgyB0srngnUJyjds1WptEED5duENHAv+shEr4M/duuflF1mQLU9VdKdrS1g==
X-Gm-Gg: Acq92OEjpe1j0G1/5GgOWeMfXJ2AGwxrhE9348LTk4C73xoTy2RpZxNbUPj2B54P3KA
 5YBA716Mb7GWqYYYxGVCO/9EyVVES+ECw3yN+Bu/1dMXECMY8vitL8lE028WweB5gz0UQk/vNrO
 V4tUUu1E1Mdfo2I7pjKozmG7aIlmTu+W9DMaBE2+c3xhmmkpvsW0fJ5QU8agiCLQHyULTxn2k0M
 uyHEyN897LWmogLYFAtVcmlsybZEHhnYtkv6oq81T2qIDw3yjUn4afXsIHa/4uSz5YkyMNugLuu
 ZO7dQIwfnW+eD5qcXrF9BSlthWxFbgxmmRd5H4zaQU8c+VfB/v7PRdlWMchsi53o/gjl2l96QYA
 /wgA/HF8x3lUlzp4rM2zzy3OhoxhkaBFRIYsuPqwjXngbA44qJjKM/aFNW6h9
X-Received: by 2002:a05:7300:d70b:b0:2ff:c5b1:2d6b with SMTP id
 5a478bee46e88-2ffd7fd6806mr698902eec.32.1778556576411; 
 Mon, 11 May 2026 20:29:36 -0700 (PDT)
X-Received: by 2002:a05:7300:d70b:b0:2ff:c5b1:2d6b with SMTP id
 5a478bee46e88-2ffd7fd6806mr698887eec.32.1778556575886; 
 Mon, 11 May 2026 20:29:35 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 02/14] target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[]
 order
Date: Tue, 12 May 2026 00:29:14 -0300
Message-ID: <20260512032926.1978818-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YfaJAhA1-K55yksSie2QBLBs-uQGM_yh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfXx1qazivKSuDS
 +TC5Md99G8HOE6EDwyv7nQdAgoFjurs+KiL2rmclLlmX30jyrpZ3WpNOdfpbcPfwf4z4OnRy310
 6wGqajSxrLEGyvillZp1aL9S7NmlDu7op1rjtCuTGTYwfFsugg8LmTKCjg3DUFXRwt7FYzyPsHH
 W2SCPNDvJzytQyxj0VQSOfgPikJdxOZ5EvZ/ztpMy+aG0X4nXGwkQ17t+2IBlH8soKCUt02HynZ
 LimYw2zMdYkFE55D2VAnehH0rEvoPDNmclmcUei9JLhcJ7wfSs2bjTLakcgCnKhtoqJ+DSZr1hR
 38f0Um8wp4rfjIx1PiGPAHLAfEpekPfS19TfFAr11luLDbGW5ku7ZGXw1C2E8HBpBP6gLAaC5k3
 NhUs1zi5RGd4iVpba0VhJNWzzKwhkRr9F0gS7H2/p0gqoFImbuU07TYS4bDKdZw+ct2OAVy1pCJ
 5UY9Ms++P17oeF5ZDeA==
X-Authority-Analysis: v=2.4 cv=UZ5hjqSN c=1 sm=1 tr=0 ts=6a029ea1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=kMeT2rDkcwzC_QZMVmMA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: YfaJAhA1-K55yksSie2QBLBs-uQGM_yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Noticed when realizing that 'svadu' was too far apart from 'svade'.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a9d9d16c1f..ee8f6e5296 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -222,6 +222,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
     ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
@@ -235,6 +236,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
@@ -246,8 +248,6 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
-    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
-    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
-- 
2.43.0


