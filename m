Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD032C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrgJW-00009g-3w; Wed, 05 Aug 2026 14:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIz-0008VY-1L
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIw-0007fx-68
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSIS83889922
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 18:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=blTv4mizGpD
 GEZidjgr/H7vbQ68dRdp26PLrvP7to6A=; b=A07+AXgPi0qXTgKScvJC/Ll+ByC
 m0T97M3Oos517xUQuGt/d5M8w6Ogc840vSuVUHwxfPbVNXhUog0k7z1DY6v0ncJP
 dA6GkpV0fU8I81It2LHoWcYK0jJD6mS0RV6YD4npHSFHtoEOcEAoIuOtXQ8g3Gi4
 8fFWaCkUlnoyXBb5bonomjEprlPUOg8As+//HrnDhiFVE9/oFTX7d5Emh1vhT5bB
 fIBPJmTK/A0wvC7jnGytsKnlXs6GO8Hf8Jelb8aARShwP4nmioLu4mzLyMXn0gOv
 Pz//A5UZTtHwFDexXOavoDM2XymlZB92zt3MlUq9YV+mh/W2VyNLqzeDnKg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv14waxam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 18:25:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930dda91cbdso218758385a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785954324; x=1786559124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=blTv4mizGpDGEZidjgr/H7vbQ68dRdp26PLrvP7to6A=;
 b=AcjDD7e0cdIsVjtD4HoFiY/gJwIuJULqJMoFq/E6cchOcNShKqO8OebktPCoeNng1y
 gUjoISVDc9nArg2eWXnn8pTDE7JCmUhsg4PS6j2lSymVIVaJ7cJBTZ9BVv/EgISsOGdc
 rviB7+PRc4q1Y2/ZH7HBBaHmmSU54m+DQ/5yRJMoZ0xgL42xvaCu4zPvQnUUWVu1SDq0
 zc71YJlYi+GeSp21Ac1xqCg9jKhrboFVS0Aminj48Z3vxfXhD62lL6tiElfo0FmeNqXe
 bG8QjlaBQ+dWkgXd2ibAq92v+uctbiQiClpD+cRZC7HHCAsX0gFlrswRww5anVDHaccS
 B57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785954324; x=1786559124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=blTv4mizGpDGEZidjgr/H7vbQ68dRdp26PLrvP7to6A=;
 b=fiEnNUi8ppK8v0f5/LAT4sdj3tQpDnMK16ttNVciAgGTnZyKhMe7lB4P29Y31Q+JBM
 biGYj4yOmi+AU3/JR/wA26ejM2qq3YbHY2MAPTtGRlsRSYC7FZ2OHL8xdO45esI5L+Fq
 P0oGWG4ZkIRlpWWqqbcGvHz2HoSdM01nKJfyvTxl5vy7tMNHxy9bIPAn6tsBQ/Cd2aj2
 28iIY4k3njAGzui9RbCb0m9AVcwgILH/xd9U+m564Av/rKJutPIw/sPC7NjJMVHq82U8
 vqSdPF+g0KL2Vvs+dRvwxPliER94SlgUw96/Urn+Yz6epM1gUV9R+whFKeFrE5HTcxgA
 3c0g==
X-Gm-Message-State: AOJu0Yz6MCfxHGzkhDlpzTDUKqCrKpmK+QwJ1O5k62eeLO/m1r+zTpz8
 b6rak+IKwpL322XFI8NcMkUVSuGElcbjUdN/1wYxiiGsiUkF9wgcq/nGpx+QiC74ZqfeU1paTU7
 Mhd0kexq1U+ZyN97I8At4NAtWzXa8FZto2U3l4e9YP8nSAl7KJhvL3q3O1w8flfNdaQ==
X-Gm-Gg: AR+sD11FTQhGUYc+03LzdNVOsf/QKnbvZ39hCgz9m7ulzkTHUaWU/pGS8sJ80LWNaoL
 wmXkfM5r3hQv5W6l0hn440Ke+QARvLEq7jORVZuw8k3Lhl24fYpFSEL1fnw7hdAK9n6g0f6LKun
 NyuyBq6sjhVOnRzHnQcH9KWL9WWnm8bc34pof50UaYRt3fOjHnHI8lqFJI0e9v9Hcs0vra3k0S9
 PdY9BKSTbQfNY2JNWDuzK5UTzp7hD79vCSunqoo35L+fLf5JT7imhtqcj/h4GMeISmUdi5q9bwc
 WHLk8t4ow1/FkuGCwPhckB/NE5O+9qWCAELwijXWJOPpfc//MsJcjbo95BQs/5oGwwR03HlrXkY
 wfWJ5xM4lb/8OsU1iIZOreYg/eSGRw3q7S929rA==
X-Received: by 2002:a05:620a:8807:b0:92f:362:8097 with SMTP id
 af79cd13be357-936490579c2mr937407885a.8.1785954324260; 
 Wed, 05 Aug 2026 11:25:24 -0700 (PDT)
X-Received: by 2002:a05:620a:8807:b0:92f:362:8097 with SMTP id
 af79cd13be357-936490579c2mr937400585a.8.1785954323742; 
 Wed, 05 Aug 2026 11:25:23 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a3fc901sm209387885a.6.2026.08.05.11.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 11:25:22 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 4/5] target/riscv/tcg/debug: set tinfo version if sdtrig
 enabled
Date: Wed,  5 Aug 2026 15:25:05 -0300
Message-ID: <20260805182506.2943757-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX5LXZmibsapzb
 sCZ1MF5kTyVvIRKiHXhsduJ3M18fVkww8/TGAaxW818bm9GjgV1OqVWawm+CoHraKa9rmObyA9c
 LB/eQ1bcbtHRMNYfoIkix5Xf5bqBCCg=
X-Proofpoint-ORIG-GUID: zyblSl9PWidiuqFLo2uJ32C_NGejuBfe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX2RjrmzqIUEOq
 aSwY//rcS93oAyM/42tkqCONK2jBGQfhy36iDFj4Iqu8KmJMzpX9B1ip1/SbGJZGvPk3ReDwKH+
 COx7UncRixzK4v0QCnTGchF6sC06sURs3o+1Lxa99RQx9kSkrb4R5Imz/JwjHVAf+AUeecRv4EM
 QwToL54FT8dF4ylsLHskfK0bTV5q9aVFIbTy373qcq6OlLS7zRPAtT5mHE01EiMBXUA1ufVDDYv
 puSA2g4kPmztOxEzonisxiioeuq25ZeESvKqfOCjC26i/LFHmbJ5dif8sQCfPBR1+2XloxUmmut
 SpI18jTcqoE5qg3EPjhDZDq+1kBe6VIVB1bwKnrY8ViCKcmGHIplD5IclKk/WJzJkhpXRS1o5hZ
 R6YpBOpImjDuDpSZ95pRMD3EFRzdXwhTe9FuibOWrLX5GtcYhAh2XE+8HSf4p8yqPwtiUkB/NNH
 ZQXi4H+X37kVUd6Ifvg==
X-Proofpoint-GUID: zyblSl9PWidiuqFLo2uJ32C_NGejuBfe
X-Authority-Analysis: v=2.4 cv=Cu+PtH4D c=1 sm=1 tr=0 ts=6a738014 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=9MmTmf_e1JsxRL0EyGgA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Set 'version' to 1 if we're running Debug 1.0.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 11 ++++++++---
 target/riscv/tcg/debug.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 8b23c8d045..06573c7b3f 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -957,9 +957,14 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
-    /* assume all triggers support the same types of triggers */
-    return BIT(TRIGGER_TYPE_AD_MATCH) |
-           BIT(TRIGGER_TYPE_AD_MATCH6);
+    target_ulong val = BIT(TRIGGER_TYPE_AD_MATCH) |
+                       BIT(TRIGGER_TYPE_AD_MATCH6);
+
+    if (debug_trigger_version_1_0(env)) {
+        val = deposit64(val, TINFO_VERSION_OFFSET, TINFO_VERSION_LEN, 1);
+    }
+
+    return val;
 }
 
 void riscv_cpu_debug_excp_handler(CPUState *cs)
diff --git a/target/riscv/tcg/debug.h b/target/riscv/tcg/debug.h
index eb635bc277..fcd92b768c 100644
--- a/target/riscv/tcg/debug.h
+++ b/target/riscv/tcg/debug.h
@@ -45,6 +45,9 @@ typedef enum {
     TRIGGER_TYPE_NUM
 } trigger_type_t;
 
+#define TINFO_VERSION_OFFSET 24
+#define TINFO_VERSION_LEN     8
+
 /* actions */
 typedef enum {
     DBG_ACTION_NONE = -1,           /* sentinel value */
-- 
2.43.0


