Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734F7C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegaZ-0000Ob-6U; Tue, 30 Jun 2026 18:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wega7-0007G6-DO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wega2-0004u3-VZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDjki2879944
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p56awPU6THMjJ15KBUtvHFIwjnkrtFhsHZARiLXZCh0=; b=F59aipw0rUJXLrOz
 SBp7Jhi/rkdYfOMr0CUXotNevFltwR7oaVVWkoOL6wrctdlQ3it/qSqgErB5roGR
 ph75eaXlqmxw8lF2tYuOxcJH7sm3eIyHVY62R4sx3q8OFRfCRMK1f+FQVsb4IUf2
 UXOqxkDcx2MTwcBTTrhUpagY9k/naUX0vtTJ4jB0CJ/GWD3qReeDMwsnU7UTTI/d
 kHRN6qzxyZr2J90nQfVsaFK463VJQj3iAIXsZ6ovb9iI3AO0FxjExaQOzV74OkM6
 7CY7P7Qu7gtYoJKgkGVAbyRHemh01wucTLXGRQ9UtzzAcv5QIcWWp42nLMvGndUY
 ZKntaw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfy9csr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:05:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4f946461so585780685a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857111; x=1783461911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p56awPU6THMjJ15KBUtvHFIwjnkrtFhsHZARiLXZCh0=;
 b=OV3BnzDzZbFx5lc8Mp4clg7zZVz0hiNXsNf7phxd2vv9dmMa6z8ilbG/8B3MHlJsEE
 nZ9CGgwCpCXr2JKsG7x79BPM/qOzJoF4RHY0l+jfIIwruqY1hCH5Zlor3wJWX1lVbjuU
 EoPnMAMY1AFO+dMF3pSLaKa2uPRCA9CuLWb8+L8QFFeHAjkPGZFXWPuZCi/bFxw370+i
 xnqasb8Ti2+QogeZFSb3b6SQAxNVILbpajhnnwiLITfdgr58bC4gD8h5hqwxbhZ8I0Sz
 JuxSfkpa8Ed2EqKsu9cr0XcG+76wO64HL93KgaqQVojGzkt8Z/TRjKnYJ2KI5KA3M5rb
 gSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857111; x=1783461911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p56awPU6THMjJ15KBUtvHFIwjnkrtFhsHZARiLXZCh0=;
 b=YHS4rcdtSGLzwKrAMPkDtGiJrSDsSSHvOG3aiaam+JdIEgttspUgG1OWC05rwiM+qg
 Ww0KW/FIxnfg5SbToQNK4Q9dXUMYpJv5uBDXPZiOhsKDAFHFCfeptynJUScqNUhyZC8w
 oEqlksmHmsu9fZrhfLKMtnaCSsQ1hjtLh4HJ/RmMSklscAfemgB1ezFhYuD8N7mQzxVo
 r0ZdZJlAd1RQT6M6iy7X2npDP56XO3YygqpF8/Mc2rQhNoGjUTn8Gc/L00SdUEgitvea
 rOD+vLco4Pd40pVtwy+zLTbaWrfaaIE6ArgKed0TFgxE5n4nJikVogsJAZenZCv+QaYv
 1WVg==
X-Gm-Message-State: AOJu0YwGVnLhUVvbLqBJdkDmRkboMHeH2KaH8kzDdVOCgjpyxDWFwXLw
 BZyi0ZdBejG4QnHX+MWYEhm45d/qX74TwqkMnG/GxX6i6kK015GsV+V+bXYlfvd7Jl6JrkKn1bP
 Rt0zzeKgnRs9BzQLHgFFFFwSEaBIf2rJMYWEBt2qDjM/lLwzrRpI8p5sR/p0PZvcYgg==
X-Gm-Gg: AfdE7cnde19gd4sd73maT8oExirLqfGBcUjogrO4vO8WCa3Iqq2c2SjJH3WvzfLlqXw
 GN/+vlsORF6iLjIzrMMkHmroxYvKH1eg2myw0VLV4GBfKs8nIOuUOpCEanr/fqXCWfE1srpi2T9
 nqShonvK8hLVsxwvIpQfy0Smxk365lIR6km8Mc2ejQ4gufOwU4qMhpjTIZ2dwkxmn50OLtnfd8c
 XpIBH6hPWzMTwczRIpkgv9w70CH2xAkpoatEF/bEZ5valg1GBNpxfVgE7kayPphjKoiZWWU3lWi
 P60ahwkxMYmJhtNcu1tPBDFFmcy97qDYYZ8eKcgQ78UI3f2KwOiRokMbj7HBQ/NjpsfMuEm/A7Q
 c0qkw2f6+roVXUFTESJ+xVYTlu3iqq+NdWE8KJvwrNrtHYT8fOd+/dI67YmM6p+40f1Ys
X-Received: by 2002:a05:620a:a1d6:10b0:92e:72a4:f291 with SMTP id
 af79cd13be357-92e72a4f750mr76877585a.35.1782857111306; 
 Tue, 30 Jun 2026 15:05:11 -0700 (PDT)
X-Received: by 2002:a05:620a:a1d6:10b0:92e:72a4:f291 with SMTP id
 af79cd13be357-92e72a4f750mr76871685a.35.1782857110749; 
 Tue, 30 Jun 2026 15:05:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d19ba6sm10429431f8f.6.2026.06.30.15.05.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:05:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 33/33] cpu: Only check SSTEP_ENABLE flag in
 cpu_single_stepping()
Date: Wed,  1 Jul 2026 00:01:00 +0200
Message-ID: <20260630220100.1289-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a443d97 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=67IpyjWKbRJXbWkAkIEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Ho2_4H5BxTZyyv1bsh0hPHwZ5rbR5lKJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX0TVZUfTIz9Ym
 YYi2NAvDbgC19wkG9uUeWEjcpjfP9vN6YdYB2Yks2+ml3eVV3zKcJ61dsR+kXpWGYPXvUZQyJDu
 Kn6jRNDXCFu9DCP1EFACB94jo6GKXlw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX4J5f6kn6vc2O
 pIBgQPdCbdvhjLIQiS2TCyi5OYjdP+Hy3HSXJ5wbmDKiagi80+r6AuYM0+LXR6UJmIDryNbhjKn
 QNh4yRBGyrevbCoT5hX18eqBH0mdRLOGpqymcwjgwAmoex9yFu1tXZxZ+xu8BCEUewy6ZerJ2fN
 PJBT36MpKs4S8yUsnuZNrIBNEBF5NYDS2X6L58zuAQ0D15zXttpw9jODidd/CcEFIsq2lSd492W
 aRNd4hr1O78yUMtUCiCNMEPEXDuoAo8OkO5JXkgUECMAS5RxLqQKtUryDmBsVjPMmv/OzLFxK1a
 JyV2vC+689pAWZ5NcLTCstJ0poIvNZkw2PUC6ZkSg8cbkbmvccTr+4UqwGWqUPSo1wZwAG51omm
 8VGt5xcAqk9l7demF06begdVTiIOHRp9LdwK0vRGKfiU23P+rg6gBHKl+Mq72KGzRUCOOwar1qB
 JBkn10vKCne6r27QEEQ==
X-Proofpoint-GUID: Ho2_4H5BxTZyyv1bsh0hPHwZ5rbR5lKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Only the SSTEP_ENABLE bitmask means single-step is enabled.

Fixes: 60897d369f1 ("Debugger single step without interrupts")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 27ee0e54327..d092ab8aa5b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1146,7 +1146,7 @@ void cpu_single_step(CPUState *cpu, int flags);
  */
 static inline bool cpu_single_stepping(const CPUState *cpu)
 {
-    return cpu->singlestep_flags;
+    return cpu->singlestep_flags & SSTEP_ENABLE;
 }
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
-- 
2.53.0


