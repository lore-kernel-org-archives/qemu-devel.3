Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C294606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NoFxAO9L;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TqNPyQtu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHw8-0006yk-UO; Fri, 23 Oct 2026 12:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvr-0006tC-M8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvp-0002O1-Su
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:51 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3rsp3812359
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6AGZHCQeTUU67ihVsIauohAaOiNnxF0CtzyifIyxgNs=; b=NoFxAO9LNvImknYt
 K8f1U4ENvjToC0Bu+PHCm0bQNcqAC6FqAUTtOkn6n+o7c/btenY+ROmfgDu06Hyx
 OaUgAKoM4LCewIiClPq3DudujPtFR5Jxm2L4eVGv3zfQj6yLKCfG9gdPKOrQOB8R
 ISs/euW7N3qxvX0dABWvu5SReyh4chVXCmpfjAHUoHy+7c9SOR2b8EOag5Umry0X
 mwRG9pjLTBRnf7Sera/2tCqX3GZiKnSKIjCf73yHSe/B3hL3eN6SfRD4snvAaPmA
 Rb8ZO7oekQDhSCQI+2cdDiB7nq0sB9TaRXCqe5lVHtWdewUn0gcAhE+pRN0EYmPV
 aIVNHQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas881my-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f322ef7d3so238002185a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772148; x=1793376948; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6AGZHCQeTUU67ihVsIauohAaOiNnxF0CtzyifIyxgNs=;
 b=TqNPyQtu/VGorHT/3AOhl0fiulGe+9wkTpDdTbqm6qVLgfmcxuBCQxg4zJXSHJRVAU
 8ZgYuJcsA69QMIfVi5HNyOEwgH17Vl76VeciCtCQED2uiJdLaVNaw/lvGXju5Z+KRQ17
 JqzrjrGWjpN/sl3Il+NCmU+/B5O1Omu8Y4UyftQFALUw/Bf3RpCArd29lAv7wPGQ1YkF
 kCTu2n7aSN2VbMKo1QDjeXSr927icIdsyf/g/8jFGpHjoJ1Ep1kcWYEn50LAYsuBaS6I
 RtYRxUnXgkg/dxVXTpRvheLjs9bMU+2YkHaLVYByRMKrQsaUSuJsd0AR6KyaweaxQkEK
 bfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772148; x=1793376948;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6AGZHCQeTUU67ihVsIauohAaOiNnxF0CtzyifIyxgNs=;
 b=mre/Vjx3S9+VGr6GyVjg3FY5yccLzAtQeT48cZltCqkLPLSNHhTB6bzQ9uo9uWJzcr
 mWxAiQ9IYFfUGyo4wRi2yHvHdleqS9WzkDpNuQ6oQDrV9JVviRj0+lm1CUbtWhyIiade
 5pWUZk/13GwkPc0iltLV9EStcrDhqjFd2HYNqOL4FgDVG0i5GycrVUNWNDbr0aTbHlTx
 4RRXhT5dXVVZNnTV8gOOHL6/VMhQmR0g5u6Qdb6HgnlixEQb8AV+wy36wIjMHLQ166TX
 GQhE7GEvuDBCSgJyFZV5JwFZQpC/MCvhxZfyD9vwKlsvRwJGiTIDnzMbb81MveB6GznY
 nCmg==
X-Gm-Message-State: AFq9FYJSp4buJQxHsRRj3Ri1T9p9IzTlcEuzm1Eo8yKAP6jvEFTXHo+6
 3xQHOCeUzVFoiSM2i3Pdn/7PJEuZgoNi/c20vKgRtjcEBbEOKrd0gXC3S0pOwy2weYqb0xfabJf
 +NViaeMMoRqyyk0Ve8IvgcNsTJspZQXwD/n6lxsMNKnynqRAsp1F5mkP9mxh8FU7UVZkM
X-Gm-Gg: AYBFou1qWdoTh0RcmNrD2VTrcSEzRz+MOfifFLNIOQwALrY5Tf14Z9/J6OYXPkREbZ9
 c4Y1miHhaEeOvS8wXJtVtnCW15XxWgOgzW09aqz+8SqVDXpIUVbGpBJXSAUP7guqqj+/RTPBiXS
 +L7zPDsLy943KirO2E9SHNgW2U4AJyqVT3JVZ3l+VZ1R5XUGjt/spcIenZpzAyu0i1rR3dOtrkv
 aDPvjgxcw7h6ZRPdG4eQhLqMcKQYshfsZyTUhggdGC9XReLmT06LzHk8RCceTiU3s0FM99uFFrN
 yq6n5O8Dy0BeLE83yjvt7l4KxX1jwVE0kvXZybKryF8ash2CI2o8st+u0JAOmO07iLyqpiKLut/
 y75OGhwcEw5CYPy43ZE01prbgVHTRPXnYg1gzrDRZ
X-Received: by 2002:a05:620a:2803:b0:93e:c12c:9b6a with SMTP id
 af79cd13be357-93f6f85421bmr471385685a.69.1792772148227; 
 Fri, 23 Oct 2026 09:15:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2803:b0:93e:c12c:9b6a with SMTP id
 af79cd13be357-93f6f85421bmr471379985a.69.1792772147751; 
 Fri, 23 Oct 2026 09:15:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b066685dsm14531235e9.15.2026.10.23.09.15.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:15:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/83] gdbstub: Remove unused gdb_get_regl()
Date: Fri, 23 Oct 2026 18:12:26 +0200
Message-ID: <20261023161332.60153-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX8DkMk5Q5BKov
 NVaFf67ICxSdQt6S1T+dPCk4DrQ6g+UcYGMPRIkTaaIWFAT9nnp+6HdbWmh8d6RjzHL9u1N8osP
 639fFUXZLXceSUUsALIhcP2UpZEO9xc=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adb8834 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX9i2SgQjwSuMR
 20gtvgySMWJ8AJTHg+zgbj1eIH7pLpLxUeHZSMf3XNUs56tqK0Gbw2okvIq9h7O1uPN2VCmKnYO
 4FzPJRmFZcDbiac4vJ9lkcD3lxDyYMDFl0kkT4CNjr8kyWE6g+CTVJdg0WAUot4gNLMCurmbw3v
 05Q14IpPoiXFC5NfuxyhCBQLfBvNqeBHSWEIcry5EjTPyS3WiAyKEMhxU9UHTcLTK7eEcADWf5A
 +J6nkitIueh+2Xk0A6tukVsC2erHMSBQxIqGU24agUjhPcM7O+7kCssaMUo4xmOMIL07JylibML
 AxnSwN9Ke2I3giQNuJGIkcltVVqWffrx0VliKTKsRWvBcPr96NgT8tnWkZF4i9Ok3VH0LzYERJ7
 Y60ydy1R9/MmRqg4R+qGqyY7E3LhU96BkkC3DSzkksliUoicwnTEE+/m/sUFxCb2lte54xsCvF9
 dlrnKqat8VoSIY6pFQQ==
X-Proofpoint-GUID: G9wFGjIPhNtFBBcy1RklDzZVWVFS_kF-
X-Proofpoint-ORIG-GUID: G9wFGjIPhNtFBBcy1RklDzZVWVFS_kF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
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

All callers have been converted to target-specific helpers, so
gdb_get_regl() is unused now. Drop it, together with the
"cpu-param.h" include that only provided TARGET_LONG_BITS for it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261007232326.66240-10-philmd@oss.qualcomm.com>
---
 include/gdbstub/helpers.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index b2f41d6d280..9833725b611 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -15,10 +15,6 @@
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu-param.h"
-#endif
-
 /*
  * The GDB remote protocol transfers values in target byte order. As
  * the gdbstub may be batching up several register values we always
@@ -88,20 +84,6 @@ static inline int gdb_get_zeroes(GByteArray *array, size_t len)
     return len;
 }
 
-/**
- * gdb_get_regl: append @val in @buf using 32 or 64-bit, depending on target
- *
- * This function is legacy and deprecated, thus should not be used in new code.
- */
-static inline int gdb_get_regl(GByteArray *buf, uint64_t val)
-{
-    if (target_long_bits() == 64) {
-        return gdb_get_reg64(buf, val);
-    } else {
-        return gdb_get_reg32(buf, val);
-    }
-}
-
 /**
  * gdb_get_reg_ptr: get pointer to start of last element
  * @len: length of element
-- 
2.55.0


