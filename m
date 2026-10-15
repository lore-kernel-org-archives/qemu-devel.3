Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E650CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBg-0000Aq-Ch; Thu, 15 Oct 2026 15:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBY-0008Vl-1I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBT-0000Wl-Fh
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFfYwl4077452
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n9kzc70iEUWSCBFXl3Abl+gc9F8wJM3nqnDP4Cd2CL8=; b=cYdeDj3R1IuKxQ4t
 ZQpIfWB61VJVHB+1jUFhXvOIMpqTVZOruLxq9ZBKFEMGsmfLaxejJTOPqu8bODyi
 RpWDuGRFAUUuJ/+YQf7ksCq5L40UyijutgCpl8OKWUXe+InCtprOa1l9DQkjzl/J
 JtwPcamKePQ0B1geinzjTXvitgA/NiDUrXRKB7q2ZGePJwlM7hpPfiy3s8aZL91j
 VOMBzp9n9gaYi67TPZl6ZmF/FiKIBeeDDwCcwDfNKcBq6ZpQvhQX19wY4uj5G6v/
 P6ekpM8mqc55MC7AePPHlYHogpN/aT0Ds5qChK8vIlLTDU0BN6aDRwLVabU+xsID
 Df9Ssw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc2dne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso1813292eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092705; x=1792697505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n9kzc70iEUWSCBFXl3Abl+gc9F8wJM3nqnDP4Cd2CL8=;
 b=KlbYkKxfzRwAE/E5hcGhJfofBeCMEPGuYJRHWAeBkjvbjEnpH8hjZiuCbzcNPBsRic
 QqbHoDeuGXAX4+zPqEZ4vx6tvu5B9uEX0EI1rABXdUlCwvpxfiHl+a/5dAg7KqHHWjKe
 aGonEZKEpCfviZqAQEDQmqcs+KT9gprRXqsBKXG/Y4lcAIMsLuRMAOeQmwYpxOfzZOcj
 LMbnam8CpCRTT/4BWK1fw2HDEiCntl50QtVAv1gKDCqgUSHyc4kfmRu60OA6uOs0dJ6R
 KBLIVb3NHL+NZ8SauX29an5WaqsS3K8YgJPT2qqeRjUFvex7Mbo6LeAic75eq16g8Daf
 E4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092705; x=1792697505;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n9kzc70iEUWSCBFXl3Abl+gc9F8wJM3nqnDP4Cd2CL8=;
 b=PIakHtHwY4l3K1LQphzaBawVwCEeikL1aCYOnMS04sDmXKSwpm1U6igIxohFHZCe68
 C/UC2GkEDiPAe92RZBSPIxOOgaCdQ0cMpBSINWQ9nIP8TxoFZAE6sfGfGVe1H86p36LN
 CUV35pTC/ndGA9E2qw4duJgxlY2BCU+IAhR56O+2yNQL1XasvrmOiGGHfg72w24lEQdt
 LaurqmQ8gB6wCxvbS3laYgfN5mRqegwAsXAuMKwjr9BWynXfMBek7SK8wrFN2BxvX4MB
 sb0lO+oxco4Xm3setZ9pgBLQOUnfjo+GGbKCC8dru8qVbsCs6SpVKSm+GBlMGfgAcmnE
 5sDA==
X-Gm-Message-State: AFq9FYKFDOb2WufZdpPIVzXSe6ytpvn/FWagLygpttBdOdvx1CnUvV/8
 uhM6rvgzdNCygLm6ioXO3wDa3BrUgn6M0EnjEau9C2ypXOI8lZ5bddRS4RSammt/TSCN2B7khqq
 jfhMWMhFfsqzgvSB3YWWsi62Y7qfMjMscyYEdM7U7lDAQDbQy5eCqCysra+ZJiTNdsQ==
X-Gm-Gg: AYBFou04Vupo/YymXNVQh0xEyyv7weBjF9CqqxvLls8xqg7m5iXV40aKpc37hFPwPPi
 vwfQrv1FAiICconZemc6qVvYt0MuDkq6gdnkkdc5Qmm4Y9x/B1yDHbycUSUl9H2drnEpTpFkceN
 KXD0miizekWNEE/Wud5BwQppZUqzXmxQk0jNT2F3ryXBuO+mfkv1ITd9EyNvnrnyl6BTvNN3MNm
 Gt4Lhg99agm2ZBMvExQD+uinLtadXDY42tSpax8vyCMW2rGf8nvEua2bwBqhf3LjInWQQ0dKfm+
 U2fnnsKvd2jAgT3vZk7e+0rX54Pt00LlCaaLduJxrZ2Sv9E+4EyjGolOiUU0/5OIflP6oJt+quR
 SyLDZx5Dq9qD8sIlNNdVUSfiuUjLUQUk2Q5Ah1nHgVDev972vMpxNL+gMmqQ0
X-Received: by 2002:a05:693c:88c2:20b0:359:818a:df2d with SMTP id
 5a478bee46e88-359818ae28amr19925701eec.31.1792092704979; 
 Thu, 15 Oct 2026 12:31:44 -0700 (PDT)
X-Received: by 2002:a05:693c:88c2:20b0:359:818a:df2d with SMTP id
 5a478bee46e88-359818ae28amr19925668eec.31.1792092704374; 
 Thu, 15 Oct 2026 12:31:44 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 05/20] semihosting: declare semihosting cpu ops
Date: Thu, 15 Oct 2026 19:30:57 +0000
Message-ID: <20261015193112.145326-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad12a21 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=b0EguDeq3ost1Em-0lQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXyfW9xSqqahQg
 T1jCwGIvr1mROsphb125Nz/UN4QHEvJ5byl4CylEfgi6CYp6PW8g/+Thl0NQFuz1H/v4TCx8QgJ
 BSkyXYrT1lvlVnbcGMIl72P+IlHQWi4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX/slFVdM7QdsQ
 ZlcF98zQsxdiG+ooKeiFJNWRBzm9aIna7ThWgBcMXhC2pG1x7VGr2x4VKg6tt/J7ffFIh/OgNwe
 kTvz4zsAPAzAJAGWwqD0eoLxtHxwY5VPSQPXn+hzOZPpsqCiXhlCdxKw5SXIxgzXQJAP5viBVoY
 BlEBu3UIaQcf3APxmklftFEEZ3iiKtnj9aJgbe6MCeJzC4ow9ht60KyZ25pw8/n6SlbaSopTD1F
 HmYIZstbdJ/s0lFvaupJIJDcmX5iyQyN7a5BQiVRiUfXt6b9hL/axuPWWYB5lluZv31Jeyj97Qt
 U++BdHu07BFI9zm5qpcqwcFqnMyzA3EaSAgyT/p7pKZDuMdCGWijPGZuQz5v5YTXocklbow27rq
 ys38/xC3FuM5j3Z1y57akofwfQIcL3znq/4ADu3m49ofjYQScRoaoRPTTIb4ni92HymImvqDiy5
 C1cD2FnKElshTkws6jw==
X-Proofpoint-ORIG-GUID: CIc0LIa4NX5HqSkeaH7OUHE2PDXlofQd
X-Proofpoint-GUID: CIc0LIa4NX5HqSkeaH7OUHE2PDXlofQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150077
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This allows a specific target to declare its implementation of
semihosting.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h             |  6 ++++++
 include/semihosting/common-semi.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 76801444a16..456154df6f6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -98,6 +98,9 @@ struct AccelCPUClass;
 /* see sysemu-cpu-ops.h */
 struct SysemuCPUOps;
 
+/* see semihosting/common-semi.h */
+struct SemihostingCPUOps;
+
 /**
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
@@ -186,6 +189,9 @@ struct CPUClass {
 #ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
+
+    /* when target does not implement semihosting, this pointer is NULL */
+    const struct SemihostingCPUOps *semi_ops;
 #endif
 
     /*
diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index 1e7699d7bbd..f0f8185d8e6 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -34,6 +34,23 @@
 #ifndef COMMON_SEMI_H
 #define COMMON_SEMI_H
 
+typedef struct SemihostingCPUOps {
+    /* Return argument @argno */
+    uint64_t (*arg)(const CPUState *cs, int argno);
+    /* Set return value for semihosting call */
+    void (*set_ret)(CPUState *cs, uint64_t ret);
+    /* Set an error for a semihosting call */
+    void (*set_err)(CPUState *cs, int err);
+    /* True if the guest is using the 64-bit semihosting ABI */
+    bool (*is_64bit)(const CPUState *cs);
+    /* True if SYS_EXIT takes an extended parameter block */
+    bool (*sys_exit_is_extended)(const CPUState *cs);
+    /* Return lowest address until which stack can grow */
+    uint64_t (*stack_bottom)(const CPUState *cs);
+    /* True if SYS_SYNCCACHE is implemented */
+    bool (*has_synccache)(const CPUState *cs);
+} SemihostingCPUOps;
+
 void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
 uint64_t common_semi_arg(CPUState *cs, int argno);
-- 
2.43.0


