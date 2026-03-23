Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05B2F4610C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8s-0000KZ-30; Mon, 23 Mar 2026 09:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8l-0000Im-Tm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8k-0000NS-DE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NADsDX3539883
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wxSDJLqM9vb
 GPEMmhLZ18CzmgBXFcFzdhXgwNgVwEN0=; b=gN8xDnyHza71EMJ5RaLPPfJkPuj
 YlL19BzVyXLhJsEFrZsLaFVfbEMH/KVOd/M8II7qk+foFnbejBzi5Swtx1W+T8ay
 +3lBhbZITFdr3Y+1jI8TTX8HlxchcfxnUhtxj/0JotliukwFKnN3eORfBXGxPAhz
 Z3kJOMskTE2OE9U83uxgasbunm9gML1ZFVb4c9cNAnjZIdQPaKJc/dBjTCrdpRUC
 GDZQz9YQKgye7kNG71t77NqJkU3qmiKILnYe2HNLMOn26Leq5obEnSeG6KdyuQbp
 jkc2N4Me2CetQAP0ZQ/4G6oew2yGacNte7s1vj603jqMRBJnhmlpCWOIrZA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k30jux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0e264d802so12705961eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271766; x=1774876566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxSDJLqM9vbGPEMmhLZ18CzmgBXFcFzdhXgwNgVwEN0=;
 b=J4QSdCoBp3kEbXjZbDYEm2w0VF53k/YotSP6A1vrRAeinlDA7a+rdayAXBiFpUDF6S
 0BNwdM5HGgFU5josiCzCHzGh57k4ucTTI79enW3UxNplKtI+RRsZDYCqbv/7ND01RtfD
 0YLlvycuVxpwyiyb+rBFsvH/LZoQp7sXMG8uh9zy79pwaz8JmUBUo4ZnWO1czDhToEQY
 fYAdrSznudGlJHePqDcEP9VaDh5tAescsc8axcDH/xJmQPHo9d7auuIxDVk4ck46KaLp
 uLG7HjCaJZljdeWSJPvpLRPhOFNwrBkl/t+6Ms6ch5Jq302QHZ5XYgrxH6MKQ9E/Ij0s
 rg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271766; x=1774876566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wxSDJLqM9vbGPEMmhLZ18CzmgBXFcFzdhXgwNgVwEN0=;
 b=ZHIiMyKjiBRfHlXwM9wLJdCwP7G+816lJWmpSBFKJmfHhrEtFeaBLal6ld1tBw3BIv
 JLVNJQ43J2bMqrLJlm/aicPL2qEG36fFEscp68BwN87oiAq1iCipxD/2Ux8VZttqnKe/
 bg3V77omZzVamOXDNNfnxAbYsQoXwjL18nlhyBbNykkHFfJo51AHiDpcl3rOrlYuNoSG
 wgoKCEP/07/pLbLxNW6AIIL4GS/YdBxDBfVh91SIrR45nDfxKMFWptu3eLl1D6HDK5aS
 Yn6gFUCwmbK9soRe6UPPpzK+jSdLak9ku3PFJgrPKiqh09Qypm+fSpaHPqsrwr2QIk/U
 4P5w==
X-Gm-Message-State: AOJu0YzeecDk4dIXvl0gnYROZfQ8TkYWjFWgJ8cQi+904pjyzMdzKj/Y
 /g+YxrORYlqpydsOE4fcYTYBR+JQJLOZAXl/i7xPXyitvAqqY65lMXI4ZJBZe2bGgOcjaTty4Rz
 WxhZpvWBnie2JbU7LXf5hUVj5cvwaUNn4pSWNUyFXbCx46+T6utlePBxCLGTfnFG5HsEK
X-Gm-Gg: ATEYQzxe2R3uc4t5Wqg1eiPZzxRpGqzCrEssw+jXTUxqxTQEtgeBsgdjAsqubWS6EvP
 /MFtlXNUBizLpz+Y825vKCi0aLPoZ6SIlO8Zqin6EF1TxbXkWtZxZH39vWDrPt7oPqwiyD6/qft
 IBKYjZFPyYUUcV3fSJTyV88lk1so7QO8ZPp0xBhuJqp3LQt85p4SLG0EzJUgj27YwFMYZxPpr06
 yyqMu4FLX2BGIgFs11COaevks4EBxGtLqH8sCrkSWd8I2UgPjpRRd+T5G2dfpFIw3hLiVSh+HWr
 jVFDXVKfQ4whI4rD2eSoK5eq9cUjUvMwVDdzb/fIA6cridzYHE2qUADJsKV1VF2CV0TO6r32QDJ
 YE6VMWCsOIlXoUTdfQfHuto79bRUzPRWMBvsXK6ZwWCzdnPgIZCvTEJlN3tuUVoIu1tc3YVAm4p
 1oIDPvny/i
X-Received: by 2002:a05:7300:a145:b0:2be:617:2ddf with SMTP id
 5a478bee46e88-2c10970ed0fmr5751894eec.16.1774271766162; 
 Mon, 23 Mar 2026 06:16:06 -0700 (PDT)
X-Received: by 2002:a05:7300:a145:b0:2be:617:2ddf with SMTP id
 5a478bee46e88-2c10970ed0fmr5751865eec.16.1774271765347; 
 Mon, 23 Mar 2026 06:16:05 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:16:04 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 13/13] tests/hexagon: add tests for v68 HVX IEEE float
 comparisons
Date: Mon, 23 Mar 2026 06:15:49 -0700
Message-Id: <76a65d4bf9062558256d29756e9e847d18692be9.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c13d17 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0FvW_baqbJdJ8tG75fUA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX5HvaAHbur8RC
 gOVUey16BS2Crib5h4mzkumuCsXDnsP1vub2DRalUCC4IIs1lLGc4n8/7+vqaJfgR4awuFTrcyB
 idQN9aJIKhLK0qN8dx6CbGkVTv/di2wfucFk7Y0uCku4tHDCot+c5+WHRucLDZyU9SY2w7Tb70e
 +KZJlSwHVEZVlktM0uS3MhSzNlLkD6H6o5/sVx0KTxsQalB20WqKJT75fRsdZ7sDrhuKEFbxmi4
 LyG+jFxCE11m/E4JeFnLgdWY8Ir5Af53vUXFqoF6KckfX3kYHQ+lm/je6bQ793TB7+ugC98eDYM
 7q7H4t6u08PUFg8ARzrAMy9++tfZ55nKdZAETS4ChkuhEA1x9x1ht2G0SrZ4TLyAgO4clRHlbsf
 MuXAd0gW+pitFir5Dj8fPtwOD2uhry68nktQMp2gpiPt5bJMQRCOg4IPlXpBQOP7vksr/QvT94n
 /BaUhGB5dADXiFc2ECg==
X-Proofpoint-GUID: usmgfBGLEWkVXRODWlVaTqppyPDsHH9q
X-Proofpoint-ORIG-GUID: usmgfBGLEWkVXRODWlVaTqppyPDsHH9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/hex_test.h      |  1 +
 tests/tcg/hexagon/fp_hvx_cmp.c    | 58 +++++++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target |  3 ++
 3 files changed, 62 insertions(+)
 create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index 28522faf04..5bc7a76a17 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -124,6 +124,7 @@ const uint16_t HF_any = 0x3c00;
 const uint16_t HF_neg_two = 0xc000;
 
 const uint32_t SF_INF =              0x7f800000;
+const uint32_t SF_INF_neg =          0xff800000;
 const uint32_t SF_QNaN =             0x7fc00000;
 const uint32_t SF_QNaN_special =     0x7f800001;
 const uint32_t SF_SNaN =             0x7fb00000;
diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c b/tests/tcg/hexagon/fp_hvx_cmp.c
new file mode 100644
index 0000000000..e925c973f3
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_cmp.c
@@ -0,0 +1,58 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <hexagon_types.h>
+#include <hvx_hexagon_protos.h>
+
+#if __HEXAGON_ARCH__ > 75
+#error "After v75, compiler will replace some FP HVX instructions."
+#endif
+
+int err;
+#include "hvx_misc.h"
+#include "hex_test.h"
+
+#define TEST_CMP(VAL1, VAL2, EXP) do { \
+    ((MMVector *)&buffers[0])->sf[index] = VAL1; \
+    ((MMVector *)&buffers[1])->sf[index] = VAL2; \
+    expect[0].w[index] = EXP ? 0xffffffff : 0; \
+    index++; \
+} while (0)
+
+int main(void)
+{
+    HVX_Vector *hvx_output = (HVX_Vector *)&output[0];
+    HVX_Vector buffers[2], true_vec, false_vec;
+    HVX_VectorPred pred;
+    int index = 0;
+
+    memset(&buffers, 0, sizeof(buffers));
+    memset(expect, 0, sizeof(expect));
+    memset(&true_vec, 0xff, sizeof(true_vec));
+    memset(&false_vec, 0, sizeof(false_vec));
+
+    TEST_CMP(raw_sf(2.2),  raw_sf(2.1),  true);
+    TEST_CMP(raw_sf(2.2),  raw_sf(2.2),  false);
+    TEST_CMP(raw_sf(0),    raw_sf(-2.2), true);
+    TEST_CMP(SF_SNaN,      SF_SNaN,      false);
+    TEST_CMP(SF_INF,       SF_INF_neg,   true);
+    TEST_CMP(SF_INF_neg,   SF_INF,       false);
+    TEST_CMP(SF_SNaN,      SF_QNaN,      false);
+    TEST_CMP(SF_QNaN,      SF_SNaN,      true);
+    TEST_CMP(SF_QNaN,      SF_QNaN_neg,  true);
+
+    pred = Q6_Q_vcmp_gt_VsfVsf(buffers[0], buffers[1]);
+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
+
+    check_output_sf(__LINE__, 1);
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index e240372fd2..ba93ffab17 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -52,6 +52,7 @@ HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += fp_hvx
 HEX_TESTS += fp_hvx_cvt
+HEX_TESTS += fp_hvx_cmp
 HEX_TESTS += fp_hvx_disabled
 HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
@@ -132,6 +133,8 @@ fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
 fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
 fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h
 fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h
+fp_hvx_cmp: CFLAGS += -mhvx -mhvx-ieee-fp
 
 run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
-- 
2.37.2


