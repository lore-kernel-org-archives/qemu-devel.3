Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF81BCD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 14:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYPka-0002rh-RM; Sat, 13 Jun 2026 10:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYPkU-0002rF-FP
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 10:54:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYPkS-0001Ab-8A
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 10:54:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DAwIAH2801220
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 14:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BVFfzkFdC27UB6PPiRra5l
 X3Q+2M56T17VX/mbZp2kc=; b=f1V2O90hbRTIuXegNAVYp2QiHSfLxxG4ANAhr5
 xggFQQ+m23ekKY8WSB7BztFK8S2SBuHj/jt6cEbNhQaBTMTnKWXNfzcHTgUc1i1H
 IlBX5aEM+8NO2crFqxlL+SpWOjvgre/kLpnzp8AAVKxUL7WJ9fGD377j9rWR0kX2
 bco2oJYb07rOw55jrViREmAVYgyBElZNBVgLeyYbPi08/1E0D8M2dmDyR9/FH60G
 3eKIqL5qxEShLLJPosi6xYPEXyenDnFQmviECtDnAa/rdzfePsHFTEHgLWYA2v4L
 A5MVjZE2dqDyoQ/abS/lYS4oG4FKMsUcZXIcEqJ6dBo9yjyQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryc6safb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 14:53:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157f453a27so293249385a.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781362439; x=1781967239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BVFfzkFdC27UB6PPiRra5lX3Q+2M56T17VX/mbZp2kc=;
 b=YmCiHcR75i6Q8TsfkA/6i7AXYOZJy+FWFrhTG2jsRHCMi6ccXRysyEvrCWG1ng0xZk
 73HJ48QsOTAUmjJVSKPsGNb20lzSSLiuuxi2y2WuHD+DLPAH1xuRSZlr7xV2dwnVSqVV
 Mhq6TQOPtRIV/QFdX4xKhShx0nfrc769VMXxuZQ849w5MRJUzg+0wcI29lBAUrDSSE6A
 EdkoSEL2MrMR1NFB7I7baEnZhm3lQFHBkYFYqdUNyQh2bJYQZe6CthJKolKKREoSGcuy
 dm6k8KQ6d6b+nJNIz1q41Zmn1IG/uDaYVPrWN3TzBYqrPivIJyiH7nmVUJKVuS4lrJ6B
 jq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781362439; x=1781967239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVFfzkFdC27UB6PPiRra5lX3Q+2M56T17VX/mbZp2kc=;
 b=QD7B2qtz+g1nfkMCVktXxAitFB9M/t6tOdIw+mRv8TsdLS+ZSbS4MkXZGaZ0CbaP3Y
 q3QTWvF0JA6CXVWOoZO05yEHRq7SmukbusCkitaz4AZsorGqz6dX66HP9463pqnDRrJO
 xGcllUpn07c1wXQgeiSmUCd02RdgH+WFU96/fbTXY4NE26xf0coN20EmsqZJ+uDoi/jb
 AnLM9Xh107VwpgnEjnGEL198v9ozAfqQsoygtiZxdjiwqgAnza5HS+YQ2FzRfYEPQs9g
 knCrrTmQHkdLBbBruXHg4MNKRJJHm+j2iqogQUjSbeZtY+P5xEYVS3Hweh5ee3tKvefL
 m7xg==
X-Gm-Message-State: AOJu0YwZ59FnNmwjCNqu0TEvbGX+mOfnJ56VKtEw9crBeQuBD9bPOlOS
 ZzTcxR3CofcQKuc58UTd52i3I58OwuT+WcOgDbxJRyiXgtAV1IPloynVYcgFquE9h/A0+/EG4Ut
 SICamnoWiByWrzXTz2QAUEb3EU/nd0CfxL1iFosgEoE2SJMEbFfpt1l+B/EmOJJdUWw==
X-Gm-Gg: Acq92OE8ouduOAVUV1+xUM5SX/c68nnbLT5KuC6fpCfv8zf6lsNYm0lOdYH5MKHO+Eo
 DmdbyjwmyTsUx9300/M5bx6rlflSLn6qnESdzGl3sBGifn3weOOMiLG0TXKz+7OlPTDToWsV8k7
 NueFKV5vaPp3N5upfgiqsH9zFJgLf3T1i3Suyv4eP/Uj2XnqQBHzBvNUnR2p27OABoi/oyls3r7
 Sz74/PmmUPXB8GjJEeG6IjEVoWXlCHv8WmOSrQaSfFcJALFU6mX7f0KegMcB5x3SwFKy1tpFRB2
 XsfjBBNtkKIa4oW03DRYWX7qE/IxmkcdznMsU7ElfTeiQ4EetU5fdnCg2s7FjtsaxZ+tl3eSwdq
 oVWFXmeHBNDCGdIN4PIcwFkTchgJNBTcHP/5OaHWbAQ9TmXQ+gxBlOGlo1vs3D+mbxh4VN7GjDr
 FbHvQ=
X-Received: by 2002:a05:620a:4708:b0:915:cf88:1e41 with SMTP id
 af79cd13be357-9161bf6c4bfmr1077324385a.45.1781362439117; 
 Sat, 13 Jun 2026 07:53:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4708:b0:915:cf88:1e41 with SMTP id
 af79cd13be357-9161bf6c4bfmr1077319385a.45.1781362438577; 
 Sat, 13 Jun 2026 07:53:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202edec6sm85069285e9.3.2026.06.13.07.53.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 13 Jun 2026 07:53:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] accel/hvf: Reduce hvf_kernel_irqchip_override scope
Date: Sat, 13 Jun 2026 16:53:56 +0200
Message-ID: <20260613145356.88410-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDE1NCBTYWx0ZWRfX1gCK6+yrS0Vs
 /FwvZSf6s48YIja19/50ae2HJ1BlMfyURjhmI8aUnHcMJ2eEWNVITYRZEhY79HT3iboryRbp+Hz
 Gl2soDxrqRhh0fTxdbxmtsA76vT1kJU=
X-Authority-Analysis: v=2.4 cv=Oop/DS/t c=1 sm=1 tr=0 ts=6a2d6f07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_OBq5Gq_yKkiNieWEFgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: FAlmXfwjY3nK7F97Ug-2H-VQCGEt0Jg-
X-Proofpoint-ORIG-GUID: FAlmXfwjY3nK7F97Ug-2H-VQCGEt0Jg-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE1NCBTYWx0ZWRfXx7TCjlQG4mp1
 W5KRqo2M09r3gsOCHpGYDyiK+Jkw7uNx1yLvIdtOFt076AjKdJ3IYqhgY8xL4Wao+5scWpLMigk
 LowM7yRYJ7lrK0rvxotOOj1wQ2VDx3HAFQAHcAGsNAwQS1XaA/7p892orWFCJ5WNJjA2MAmRWIp
 k4kXloMfY2qsPM5cgp44K/ijCoTMeXxQ0xh6E9pQ8GQy8OCQX5ZRubIkDtM2Ek0EEodN+Xmgwhb
 OseCRLNEwclgcDNAhoPr9cjEH0MqrgTtP7KTQrvh6V81ruqeF08XYlS2nQn06LplZJWxiaRkHMT
 qz1XHQUAf/U/fO/cuTqQKuVhJrcXE9t6MeZePDbaU2HK/eG9hubmWs8wpISO66OAcMqJ2ulDZ08
 N2eyuQtCl9yFjcsEHtkAm6oqlikvorIUsOK1/uwuae18k47788Zip9Auu6h7R9t9MY7nMkrBc0/
 Lgj69w+Fqt9S3TWP0uA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130154
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

hvf_kernel_irqchip_override is only used within the
accel/hvf/hvf-all.c file, no need to expose the symbol.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/hvf_int.h | 1 -
 accel/hvf/hvf-all.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d5eaf26dda8..58fb865ebae 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -113,5 +113,4 @@ bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
 
-extern bool hvf_kernel_irqchip_override;
 #endif
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 946dbca59d0..21b9b71a6df 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -25,7 +25,7 @@
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
 bool hvf_nested_virt;
-bool hvf_kernel_irqchip_override;
+static bool hvf_kernel_irqchip_override;
 
 void hvf_nested_virt_enable(bool nested_virt)
 {
-- 
2.53.0


