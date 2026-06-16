Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD73ACD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJEy-0002SN-9Y; Mon, 15 Jun 2026 22:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEv-0002LL-UN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:09:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEu-000137-6Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:09:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G20GXA1801116
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1t1sMzSJShcgimWXhe+/gljdGKZWnvFZP0KWZT1sANs=; b=K4uONjuWIFYMC82k
 6rXw5wnZlbY5QR6kpTv21HBvu7LtarPh5SERVR+bVL2tefFU5qn6y72fciyZG5ut
 c7HDXbRDauqQ3b21a/0SRGcmxYnnFRie0BfwDHXMv3LCIwJFl1lDEN6a+b1TprcF
 weQjfZ65ZDRd6xSfPFRZ+M6VkDWK1OoOiUz7ucjoFYPXadnA3cYz8+vMneXgRWbE
 cJuAgoY/d0dy9+bFJ0CtJWjE+mNCvbHpTYte5BDzkeOCIGNn+olRVSoygkh8pDdb
 M8E003COi4pPEq1Aoc4xqGQ3lm1BfOtDcuCNbM743VbQYdeM5uAEX37IRurUCNoA
 6xn2ww==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa742d1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:09:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-519899abab8so12301131cf.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575757; x=1782180557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1t1sMzSJShcgimWXhe+/gljdGKZWnvFZP0KWZT1sANs=;
 b=cMwSacBPxgTk+CNcO3o9IFBRpomM+6rzZE7BBmushCPN28vZ8NM7OhR0c9uuJbQSD5
 yl3n0Z5Bo4MnclMxvd2/7W2i4fX96KRw5DKjFH6TeXjJwWfj5cdM8NYvGYUppnLv8n8U
 GIULORnMVDeEigeWDidmPE0MMsXLsQva+WyUQfdOF2PObIftiUtbhd8JIhMNtDwApsfr
 IY9LQ6F9BpXhB5vVRp6fi08S1IA6fouCVp88YvRlsqHg5AF0evxGUb8xocctjqiFBKrd
 n5lV0YOIRJlEUVorhaNcpvvjcd4UD7AiJSZxjy6ro2ouYfCHLclCuXPkgKerrkyUSuuA
 vS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575757; x=1782180557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1t1sMzSJShcgimWXhe+/gljdGKZWnvFZP0KWZT1sANs=;
 b=DJUHaH8btoPoNtfcr/dJ5tMPrJBAuXr6qSBbHnhqyLmasfQAzvas4vSeOUH5HtAPhd
 9QrLw/FzWzV8F6B0pM8oBij2C8yXYGd2aTWLBkYOJs3SHprm+XK1dUr5PouNa6RTcPcS
 q9hBlHo3tsj8874PgiUuRkQmSo4POBHLRMuzf43va2oukK5dPsWAzIGh29rCf53h1esQ
 tiFElO9LxQiwjiiOV7Nvx8VPVFd4hP7A0fG/XTeltyKwVf9jcYeWt2/FK8DFa+YExW6G
 2s+8MPRp9sN3PLmBVysjn8qNPIlt3oR0K97gG+st08znEWsK21hNFiUmgsU8R/ubpINs
 O/sg==
X-Gm-Message-State: AOJu0YwO4CzIoNlTOEvSP7g+70KeRRmHELAAtyYg7GiqIMGolybQqJyR
 t+NXPC5BMoGTCN7tQmag06OOZD48cLw7CG0VnKOK23CAHoEw0b8KtvqxHF0j8KLVoE39Qace+gn
 FXy88FfHKPvoX26hC8crB6wwsNRo9FiIKNM+WpLJAghBMBdz690YHnXc5dnzTOys31w==
X-Gm-Gg: Acq92OFYhgWcRrlMaiLBiiF6Ihz/xVYvnAvyq/Rr/5n11qeydqj790pqp38oDswqCYv
 FvU//gsVD3ZBcHwfAoG448xv+t45YEPh3AKdXh75ymKPLz2E3NB/eJ2v2wIcbQTLO24VbaQhxFP
 E8Lfq0l1CrSmYsoIcM1UBGDwp3jBYQUNEiTeR8L75OqyU1v2sr6lvJYHiBLMb8zUnG4NrjoE1WJ
 NYpvI+YVFGi4pGtK6RKczo7OLukrZ4+EvJoxnn7AUuYM/vBbSmoJ4WPVP52duLUm+I1T4jVHUWM
 yIB30I636Vyqy2We458BZr+sLXmwgflQ7Q2av0biWkZCiHcEbauSnw9LowlavaBbRx8v9E2likh
 BKfZzRBuvTqJ09x3nBgs/nRp9L1/jvWGp/WhWiy9Zhyc02wkEAKg5E1sV/Fdz2JXh+WbYoZGMKA
 fZSXg=
X-Received: by 2002:a05:620a:2b4c:b0:911:9e67:44cb with SMTP id
 af79cd13be357-9161bf512f4mr2449555485a.38.1781575757327; 
 Mon, 15 Jun 2026 19:09:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4c:b0:911:9e67:44cb with SMTP id
 af79cd13be357-9161bf512f4mr2449552985a.38.1781575756889; 
 Mon, 15 Jun 2026 19:09:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm66214615e9.14.2026.06.15.19.09.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:09:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 5/6] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Tue, 16 Jun 2026 04:08:38 +0200
Message-ID: <20260616020839.19104-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020839.19104-1-philmd@oss.qualcomm.com>
References: <20260616020839.19104-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rRNL0TrRKBRAxgpZrhe0tR534Km0JZaR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX02UtwKFXRoEk
 V80qFZGSBLZJsTFNudy3AjKm3Ss/FIIcjb+hByUBE/9b3OBaL2RUzOTlMR5UQKZd7my0eBlbEX2
 gyiFx2+nTTyy8h6d+Z6qeLtxtmXfYJc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfXysMO3XSUsvtk
 LbYgRSDHHNbGGlV5gKdxKXSFJRUFEirRmlIVNyLJ3YleyrZFceTbgu0Nb+DX6ym8/gfE33HHA6n
 GYHHFO764QoFG9sghNSmXmnalxi8G88ABUwTMWJu754NmcOws/Z1FvlZccq79YAMpYemK+IMmTe
 RO2ZqwBNzJIBsQH/l3kAHD8vYKlmf2bzqJCumF8AzyZPiQuFgLLIGDprVF1rO07RMqVDKlzrqfT
 ZlfeyHwoe8bM7E00ZBpcz2+la/b4TK/ywLWiPsE0eh1yHgAXCqWv4X3oFiQxZRJrarcR8iRArzQ
 i3sksl+YXHk2/0AF0D8Co3gDbVLpibGmNlayWVVQOERGW3AWZ5MKLy25bU5EqUgntRbaT7EFGQO
 n7xKVZhjBiE8HaAUWOlfysNoeK2GhEJlQXIwPAj/JUBvzR+hZA7HnBhBcu8iNeK4EwmKytVL+9H
 nQJVe8pUnXYQN3IiDZA==
X-Proofpoint-GUID: rRNL0TrRKBRAxgpZrhe0tR534Km0JZaR
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a30b04e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wtMswhJjl9DcAQxfHdQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160018
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace by address_space_read()
and address_space_write() respectively, accessing the per-vCPU
address space instead of the global &address_space_memory one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/diag.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index bc1791067d8..01cc802eaed 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -79,7 +79,8 @@ static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
     if (s390_is_pv()) {
         s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
     } else {
-        cpu_physical_memory_read(addr, iplb, size);
+        address_space_read(cpu_get_address_space(env_cpu(env), 0), addr,
+                           MEMTXATTRS_UNSPECIFIED, iplb, size);
     }
 }
 
@@ -89,7 +90,8 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
     if (s390_is_pv()) {
         s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
     } else {
-        cpu_physical_memory_write(addr, iplb, size);
+        address_space_write(cpu_get_address_space(env_cpu(env), 0), addr,
+                            MEMTXATTRS_UNSPECIFIED, iplb, size);
     }
 }
 
-- 
2.53.0


