Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FBECC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBV-0008Op-5B; Thu, 15 Oct 2026 15:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBI-0008Lf-MY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBC-0000Wh-Fd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3X9x406220
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XxB/ePn+sDiUe6QJaoDCQIIXDr+XoOYNGxdBVKzH/MU=; b=dYztg3RIhIs+r1e/
 C649+gpUl/1p5TdI/cLZCYwW0+pbZLBQpr3ttywMftZPkQmkhKyBx/L5sEeDBDFR
 B6nVINYfTXtcs3RO7FkrGiKSlui6KN9fQEUjIimSXrMf/9ZZdtm5pZiltkImMu/P
 J3fCou6SrLRwufEuBWm7JfYwTQH8ixVSskw/p9P1podVzu/SJHsvlhZPE1epGn1N
 R52XTx3Y/NvJxGvSEt+VQVp9EVtjrWBAZVhenEna285R7Qq26N3HQ4/HyxF2ffxI
 MQDpSebOoTRzms4fDyB/iqR+GckHIpxpM+ny2Fa/7NOwcGBqFDEL3P1I75V+lAla
 4g05yg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa09r6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso8864650eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092702; x=1792697502; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XxB/ePn+sDiUe6QJaoDCQIIXDr+XoOYNGxdBVKzH/MU=;
 b=E4O0BOqJ3VynmlrWkHI3csXhPR86UJk//FDEghajmlcV9NKd/kmhx02m29hOErDk14
 3EpiCV987dFUHiCIPXJFE8oaV4J8K7nbtNK71XW3q8Uoma1iPff90mGtkHVrP8++CKr4
 nhaV+QThz7TL4BDNbgPHB+oTGMosJob7ID3CWQqPtcUhEAw/9oq0owT1yQb9H8Ikmatq
 ZjRqiEUM/5j9FmnUnlt4WnsE9a+gftYmzvMJeKndh+ASU1gukZ+FVLyfCLlYd/j0HXwz
 lk7huOwohYFc1xlvyD81An5f35ukDvcsTotVT58ZKtS835z9o2VNTiG14/ucm+Jhp2LF
 biow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092702; x=1792697502;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XxB/ePn+sDiUe6QJaoDCQIIXDr+XoOYNGxdBVKzH/MU=;
 b=W5bhqsnKPodnWpsuvZqHwxs6zTYprcZwCHTqDMLG6EzMrOmegD2la0HS3tGB7mFO9N
 A0vO3uOb8tZloob3AqYy3y7JeKtNtINK5dQl+zouP/pt9S3D6DraSOXmUvTDkncH0XYH
 ZNrI3+QVw/v2imJh1dm0LQhYCvLfr1AwiFsri9mXdEtEdeT4xEHM3Nz2g7BqXAYAVhbu
 RRp+CBUuahOHoiUfzDGzW1wf5XAPC3w30q3Ho5yVRtfy/ILIPQh4aGy2iLY3GquPB97x
 SAUEn9P0jN2YodxCkI+1fJlML4uzg9rsOXwF79iI2XK/XKbzqO4PIwJOlYXVdjVumoqR
 hCZQ==
X-Gm-Message-State: AFq9FYL9qSZOZrYJqhFVdxuQsL2l99133ph1cyZvZ47FbCPA18SNk0tk
 yXSrEk8xOvYbYyQLmiJPOI2n9VqtyBrzEgHGVpw0eZi6ltM3f0V0bOcrMn/7FQW6KzOYG0n3qyx
 x+/kYKqyGVVfzAd/ZQ0IU+iN6qklwwT4NZJsT1X5d+NOnI2W4TJjxmwmxThM7s2SL+g==
X-Gm-Gg: AYBFou3BjqImiB+nYqAR7j3sB0Cg7QCwT0urCErKMwbX533rql8YCynaL9DHSuWIEy/
 vHqTn255o2CHlv13RGpnTCka1jR0bA9grnKrwym5BE/zaXMvzsoP14AVM9xJIbwGwuZffmICtjX
 Arau2rniRRw6B0f5FhJDuhy1NgWEMYCs0ILW2aJ3b5tfBNAueYCtDpX562gYhh+MAY2faXLGHga
 HgLzdvu7M+3tMHtrdWgbH4ntkD6Qsc4gJbvuBnnSQoHb4Kt44wLI1u0aVmvAIEJoth7fCYFA99L
 ittTXxk236y3uBlZIGMjs7IBPCYOYdkknuE1s4qydFZnLmR39ea5wCrPMKHlai5WX6pT7ukDNTc
 VGbslsn3iQwnwU95GSInSLJZq+zxafU2Gbt84Y7P8bpvkFg+Zm7FTklvYMPMN
X-Received: by 2002:a05:693c:60d4:b0:359:2f0b:aa89 with SMTP id
 5a478bee46e88-3592f0bc083mr23822223eec.10.1792092701774; 
 Thu, 15 Oct 2026 12:31:41 -0700 (PDT)
X-Received: by 2002:a05:693c:60d4:b0:359:2f0b:aa89 with SMTP id
 5a478bee46e88-3592f0bc083mr23822185eec.10.1792092701224; 
 Thu, 15 Oct 2026 12:31:41 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 04/20] hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
Date: Thu, 15 Oct 2026 19:30:56 +0000
Message-ID: <20261015193112.145326-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX9MK6eXna6Cl1
 Sgn5UtBUlm/2sfxebih+BrC8FSuNA484rB4YmBTbeaiC9qsosGqje2ru6gF22vKxA4OF/tebc+D
 w0O9QzI+Yq3Bsuc+h8WXa9Kaqh3FQug=
X-Proofpoint-ORIG-GUID: BueratQPX91cLn752_5FJFljQSycp7Wk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXyEggY6VLfxH+
 MtMOtX2IDuf22hUT/x5DwAAidRlbfyQz3j3Oet4IkBleZkZ/5AknmTORpPMu9TVFxsbHKpORngR
 ybVWzPryi1hrQ3r+70bxv8nVn1fMVveQTtilNS9hWrJG15R15IwOqovRLEjrAQcvurLAWcKlVL8
 C6bVnOYDSAuxrzg5hDNJqemD03EPbcc2KOy0JGYvxqPAlXatqgFM/GO+5kWo3tVjOug7F1IfD9L
 A5fAY+u/NSA0ZX/k17um4F2wGAvt8tGs1q8s7xqwwXS949Fgjui+Pa5qv4z9tafarPjorlMGl6a
 sAJalCyqDYW5OExXOyRzPvA7HlE/Gb/CYSaylXio3iiyzyB8PCjzo72t3J2GbKqeJxkTVRHH+oA
 ucMgtux7h5JXDI11d7vFo4LDt2A3+16BbBzDnH5OO1t8nzgMm7YrU2CcDJidc1R6VKUPNp5zwpC
 tc/szAMG3x8+hHI9J1Q==
X-Proofpoint-GUID: BueratQPX91cLn752_5FJFljQSycp7Wk
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad12a1e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=m6vfh2jtweNnR3fUmdIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
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

We introduce this since upcoming semihosting ops will be in the same
ifdef.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ae66f5e33e3..76801444a16 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -183,8 +183,10 @@ struct CPUClass {
     /* when system emulation is not available, this pointer is NULL */
     const struct SysemuCPUOps *sysemu_ops;
 
+#ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
+#endif
 
     /*
      * Keep non-pointer data at the end to minimize holes.
-- 
2.43.0


