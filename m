Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10263CA600A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEb0L-0000CR-Du; Wed, 07 Oct 2026 19:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEb0G-0008TQ-Oe
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEb0D-0001Tx-Tj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtwnB1346098
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 At+ZoAnAYbyyH5SRpHNHONWM9IzSg9N8gSi7ahyrOFE=; b=SgvW4mjjVSahtbBl
 0ub6z7cogbQliHwCH5Rz/FIABCJ01Hs+dhCQ14dlxZsg/NGK+/iDTzrhL10eoDWH
 e9SrP79fiCrSSXujq9ldDADMdb5lomXLWtKGQ0h4LaY/CJZ4IoKjoQA8+15GnCQT
 j05o8Ey2D06ljSlbZs5f9ZLXtsOWBJ3/9ZGNrnGecdpcApGdKySrTN4BWstkK7Z8
 o8bWHYup29T6ukW0hhESu0ZcgsJKc3jMyT6WlHAzT60SAdfHScf+LG0ysaVN3JDn
 z779Z4A1Zf0DSqrIL5y97+YRxnCEhPVfcc2Penrq2cLE0bcyr5XuCXFih3Ge7WWR
 3BxJiQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe807hm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:24:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9179a556c43so104884856d6.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415487; x=1792020287; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=At+ZoAnAYbyyH5SRpHNHONWM9IzSg9N8gSi7ahyrOFE=;
 b=C8/5I8hTOOP1g2bS35PwazYNbWKQqrM4K7OnYAMTeWZxoSnASQRoJlyWG5z/lAchWE
 P1wohzRMWDsgGI8tP+ullaaKm+Mx+u5LDVNGxrJ0dcvrobMcQSuhfSkA0YxibqNA5T7t
 JkaPrN/+h9yd02WbLIewi85VU2Ir56hjCudI434Wgfw98kdo25es9vdyHT088YJ/bP4O
 14u3eMXSa0HZ7YkoA6IdO7tQgpl5Qs31fGvfnB6EoEjU7v3tu2qibFZDzt71pRQNsOA5
 BTEMehUMZ56WVM151fIRs+HDy4Ac7iFTzw7Kt4p1z/6z9kceERLwp3jBc+jBEB/k9ooJ
 wF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415487; x=1792020287;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=At+ZoAnAYbyyH5SRpHNHONWM9IzSg9N8gSi7ahyrOFE=;
 b=xXOBfySeJHuuu5Lpe3+MegN6Ayr5zChj4VoLf9faT95GkX4pZU8Wdkaz3Fy9qmJ+4F
 Hj+94Xe4hg6PKt+ZFiJ6qCbN1RuB8skdgI07VSVNaeTUJ4qs0264sUl9Q1Jq1DlmgQoD
 Z8MqNdCdG5Vj9mj8dkv3ZeLCMNlRne7VZZkDEUMRVuYR7FCSrsTqcZFqFVjaF5ndVTlL
 hyzZvuMPWF6zhLNhXN8MQMQPVQ1dTz5bdgQmziVL50dzIiqbV+oiO30wgYhEPc84/Qxf
 EM5zJamrAeNS7Dyl7PrZj8M9GmUyJ0fyECtLx3eDAQdfGujx9+xqYW9XyhjN1uPOUVNu
 UGPQ==
X-Gm-Message-State: AFuF++m4qndmRY2nCvc7wTe1QheczSIlD3wxT7aw08H9XmyztDSTVyI/
 vWoXEEuMPkvgyev5TriC485EPJOnj4+bgNsJ59XX9gdrjTvlOPMhX6wE27kX3qXOn2JjscQ/iD/
 1gFTA4rYGqG0PmMV456y2hk1y7qT221K4BIhxYebIJjM1xrPaqfb66cId4HmBjrsAphHQ
X-Gm-Gg: AYBFou0nONJAwcWCc0favNhJpIufVBri1AIjGS/6Dgw1e0WlFceAILn8ATjQKY9Ny2f
 nuQoPnZeVDnCHjQ4jmJAXTpJ+LxHWoXZ9LnP4LD1ghciHCa30SJLoiP4VrzyyKbAKwDyZeGq9PM
 g0jpqB1pYjAATVBQKFapXNpuph9spDrJLnbC+e0lKKrn28R4XzJ6kIyntL21xzjZwLpHZYBuIyn
 +F22JSf0ML7baX2AgigaJqOlGWjNroCVilrZlSIs2pQUWhZRea6g2edxFpztpybzu81cuaHErAw
 IVOV15EI0QNaEo3LGzfi5j3OtCRe/RIJ8jC7wsSUAQTQs61FdsPps6bzAUMzWl1CM7VedFNGH6X
 Jmt6s1Y6d/lTafpY+xiwCNAOTND2TdMKoBYZ/ny9C
X-Received: by 2002:a05:620a:444a:b0:93e:980a:2ff6 with SMTP id
 af79cd13be357-93e9b807938mr732619185a.74.1791415487607; 
 Wed, 07 Oct 2026 16:24:47 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:93e:980a:2ff6 with SMTP id
 af79cd13be357-93e9b807938mr732615785a.74.1791415487148; 
 Wed, 07 Oct 2026 16:24:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1834fcdaesm10730455e9.1.2026.10.07.16.24.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:24:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 10/10] include: Remove TARGET_LONG_SIZE definition
Date: Thu,  8 Oct 2026 01:23:25 +0200
Message-ID: <20261007232326.66240-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfXzpX4nRmKqMqX
 YguXc1IG+sB778ut4zaC1Qx0ry7xHn4K0934/VZqXGdzOwTdKFR0y+EQLzy5FvupWLudcPLgvlB
 HKF/hr85KR74HPmDKSXJ88rxh+pDJA06rYlXZVM799K85lrkbDlohnF9X1tsGLz9EEXca4KvPDE
 ihQWO7gsJPPUwsahvPiHgwTd6uvUibyxq++N2IXtL9dsyiNlDsytSdd6RdCk61fuLihQ7Guy/lk
 +c0CFL5Pvm0YUKLceOFCL/1JrQ5yYQW2J2fn1j6hpTpnjCehbL18gnIp+BNESQk+8TO6NXzE7fq
 SqrxEZWAFC1tqiiaGSgDrictDJeTh6JsT1sajqc8lPtVof9CNt62mh9suI+UMzOz7S8t2IaqIDt
 JPL+mOkM6oacYw9CKvjIiRJmzPbSRbAkFqzZptBhWo3CrHREOjfqS8l3db8aMG91KlyOiLXkzY/
 c+ZIBFXwjqSnU9yBl2A==
X-Proofpoint-GUID: dWs0zVJdw8C7-fo6Kx7EXqM6n9-0xPZx
X-Proofpoint-ORIG-GUID: dWs0zVJdw8C7-fo6Kx7EXqM6n9-0xPZx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX58u7X3D+ZBZI
 Sl9B1v9cXkt7GRxW8J5hNKPe1KvfzdC42k9zlPMARxi0jyaUoS6JYgHXhfCGTq9J87SKkStXxs5
 klBqqG3ic3zRIxZEF0WH2/mh04O9w40=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac6d4c0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=514NUbYOmUOWgLp1GpQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

All the code base uses TARGET_LONG_BITS,
remove TARGET_LONG_SIZE as unnecessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/target_long.h  | 8 +++-----
 include/user/tswap-target.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/exec/target_long.h b/include/exec/target_long.h
index 3cd8e26a23f..5d403c60402 100644
--- a/include/exec/target_long.h
+++ b/include/exec/target_long.h
@@ -20,17 +20,15 @@
 #error TARGET_LONG_BITS not defined
 #endif
 
-#define TARGET_LONG_SIZE (TARGET_LONG_BITS / 8)
-
 /* target_ulong is the type of a virtual address */
-#if TARGET_LONG_SIZE == 4
+#if TARGET_LONG_BITS == 32
 typedef int32_t target_long;
 typedef uint32_t target_ulong;
 #define TARGET_FMT_lx "%08x"
 #define TARGET_FMT_ld "%d"
 #define TARGET_FMT_lu "%u"
 #define MO_TL MO_32
-#elif TARGET_LONG_SIZE == 8
+#elif TARGET_LONG_BITS == 64
 typedef int64_t target_long;
 typedef uint64_t target_ulong;
 #define TARGET_FMT_lx "%016" PRIx64
@@ -38,7 +36,7 @@ typedef uint64_t target_ulong;
 #define TARGET_FMT_lu "%" PRIu64
 #define MO_TL MO_64
 #else
-#error TARGET_LONG_SIZE undefined
+#error TARGET_LONG_BITS invalid
 #endif
 
 #endif /* _TARGET_LONG_H_ */
diff --git a/include/user/tswap-target.h b/include/user/tswap-target.h
index 4719330dbbc..1c66a5b9344 100644
--- a/include/user/tswap-target.h
+++ b/include/user/tswap-target.h
@@ -11,7 +11,7 @@
 #include "exec/cpu-defs.h"
 #include "exec/tswap.h"
 
-#if TARGET_LONG_SIZE == 4
+#if TARGET_LONG_BITS == 32
 #define tswapl(s) tswap32(s)
 #define bswaptls(s) bswap32s(s)
 #else
-- 
2.55.0


