Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AA606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kc1uuZOd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=URUy5oNv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHua-0004T6-Ol; Fri, 23 Oct 2026 12:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuO-0004IF-01
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuK-00025W-7b
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE63LT4064343
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JGuSDdbF+gKq1CjGy8ZOCv1di4B5ChfDXsMTbBiueuU=; b=Kc1uuZOdzsn17Ss/
 8mggoNZWRzxNgRvf3qGM6JX33zIvxA4hPGVT+tMtG6R8t36Ygtbl4otU/gP53Owv
 i3wxK6wywlmmwlMzqp17bvQa9HEg+OhR2pYtDC1ikB2fyRgAKJ/yKkSWkNez+uXW
 +heJ6KWU/BvVr6U+YmPZSWo5Wh0dbpe/EDaTPLEFYt8IKVoxmVfeKSKigaCZ9Agn
 9S1tUotY3krh87o1p7Wyys0PlJg/A06dLIXecQzPqyqJb4gEKnPlJckmf4BCiLMy
 tDx4bJfxTK19r0acfcqhZVj3hVFT1f3P+2KWhKg8LxyIgqvsreFbtHLdxdN7fXx2
 bkSvMA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcgeh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so214314385a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772052; x=1793376852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JGuSDdbF+gKq1CjGy8ZOCv1di4B5ChfDXsMTbBiueuU=;
 b=URUy5oNvhCvBrK4FQUe0jg0iU7cAS/7CTuhRfC+RpwV2LiarmR0ZCNR4dvRW976w+X
 +oTOANKbSqhzNZHklSJFUBt7S9Fs2gqntkVVuPVkiste68atYFoMLzAuacFGRj48jpjn
 LoWkTUhBW42HCJI+J90tOqqOv+k5SJR4bt4oH/cuzX4u+zEtiexYtdajGrLMhjgS4DDx
 jbE7IwIBrww1OExa+iKrK0tjCasHkJomfN8Wg6UlYu/GZCQudaIrgJOE51jVnlwyQu0+
 /ULCiLaIkzLyynb7Ylps1KQQnzKRJe7dl1Fyub3jdx9xJYZ69rv0gtEA9Im+8LIAT+0+
 OsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772052; x=1793376852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JGuSDdbF+gKq1CjGy8ZOCv1di4B5ChfDXsMTbBiueuU=;
 b=0HxPsM3YMX+uWutUH97/rNUGdpLMXO65OpJ6kwdeJMDVUbKFZXDIvrWGqnMKZCP/gm
 Ou7a1K5Sgayt1MBVrfu0r0V8Xe9EN22ZDObnC+E4NJCkHxyyj3lO1Hifx37T1sFyZJSr
 Nq9zZ0f2+OanToXKS5VP87c/LZM/n6RYGOzOADGT+jKBAsGDfj2DqrrgRzKNo99bxcjQ
 98eMLtwzAaGHv3X8cbWyOC4JEzg54ydqyZHEl0nQwvyh302liqQR1Yg4++mu6lK0IP6a
 mMhOS/YCTP9/Ge05BurI4145e6jOS0JsxzJfomri+H7G5UWK/3C8PkDPMi4cV8GQxzn2
 Xiyg==
X-Gm-Message-State: AFq9FYKnxKYfMpdYTCWwHQiOOrFHsle8ix1csvzo/xQgNC3JssJADmSv
 spETTavD41P2qBdjPcuQrTOJcoiwtFMiDrWSf5jWpYaROLP/tXQ+uxWU+goE79zcNPCqkHaH1Ov
 oqCN0mz6kI0eO+WULhNUc5FowAp+OwOR+ZJ+QwMEaXwTrf1VpV8SAm3ac13bJf/VzIVkQ
X-Gm-Gg: AYBFou0Xa1D3V0vWxG8NIvBcClYwas+mY4zMOM7SkLNfhY7xIS31VwyE4Ljg8olZ71q
 bosc7D3Ize2Acwh+fNjhHINJcvi5ONi5opn5oKsFkVKfDPt42c1xBusa0YscBaNpKQlYYOrdsrr
 Ok7FU8ntStUYnStDkcO8zW6Uca8QWWK0TnDA/aPZbW6yFMsCe5f/dio6zblOPjekln3+1OcQFb7
 AMi5p0Mt8cjbFU5bTu6+zVSCtQ3PQ+oe2tWUJX5mT69FxAxffDkgWJ32llGOrS1Pph/R67AAFP7
 k7PCNAOp896m3ayJ5IFoijnbRx3nHcZnwt7fuEt8CzWN6gOtZyB0qSW6jHO8GFD2s9Xiy1i88hB
 iO5yjIDEOomgp+EU5UOxAcn4occIp2mnKZgO2Swfz
X-Received: by 2002:a05:620a:3949:b0:93f:2479:2b4 with SMTP id
 af79cd13be357-93f626db296mr1010202585a.10.1792772052533; 
 Fri, 23 Oct 2026 09:14:12 -0700 (PDT)
X-Received: by 2002:a05:620a:3949:b0:93f:2479:2b4 with SMTP id
 af79cd13be357-93f626db296mr1010196985a.10.1792772051936; 
 Fri, 23 Oct 2026 09:14:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3f9f28sm737553f8f.21.2026.10.23.09.14.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:14:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/83] target/i386: Split APIC polling from x86_cpu_exec_halt()
Date: Fri, 23 Oct 2026 18:12:13 +0200
Message-ID: <20261023161332.60153-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6IExVtEhXWlp0eLjvhWeFzTaKdnA2wOc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX0fjtfYz9s9BI
 CoQs+R8XdN/V150WmX0nvAJZWOmK3KmMdgGJBDAZYQVKoqH7aW9w6PDlruzBJs9He5eoweDdJNb
 uYmCLAoSHsJDdpG77A9CvOrrM3Xq1dE=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb87d5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=h7OMh5kjI76PbTVxvEwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX5LEFHRoAPA6i
 VnGPMAm2Cm3+H/0gOccGNjr0lrF9pVsQZa4uGyzP4r8KsEzBuFfiGnel1lcRBY0L4pHsNCJBEup
 A/yK+3tUwy47ME4ZDDnZ+G3wK7ryu4lNXmI9kijGH9qjlX1pWKXcrKBAzWZWISxOUjrOHV0xv50
 uesORbH98cuh8k6RCtUx9UDBJMo4NUZABMr5hhU1SFSfkIhT//cmr238xe3cmrQBdumuOC9vTBc
 gFohKfFRkOp1eaPQ+SYg+VZdLl3D1dMlnMmyI3Wp/Ku8SMP1KhehpeHxWs8aUzyYa1QIcFKzxmG
 pLeHgWIAjgxbGXTSXnhCGypz0mGNk27/TiChXhJhZoh7zqjZKieNFtQ+TTP4VY/HYYBqcT6bcWw
 7XvyOXqFT5FDiFxNmbjwRBxFvtJEqhAr98vhbBDbnJtmUj309xqHgHUyYEUJQRw8v/7g96RA9dp
 ysRHSGuZpov7QEiyM4A==
X-Proofpoint-ORIG-GUID: 6IExVtEhXWlp0eLjvhWeFzTaKdnA2wOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

Move APIC polling into x86_cpu_poll_during_halt() while
keeping the remaining halt handling in x86_cpu_exec_halt().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930174946.82195-6-philmd@oss.qualcomm.com>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index f4b2ff740d5..58e8ca0bc1b 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -37,6 +37,7 @@
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+void x86_cpu_poll_during_halt(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 8c7856be81e..9ce608a0bb7 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -128,10 +128,9 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_poll_during_halt(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         bql_lock();
@@ -139,6 +138,14 @@ bool x86_cpu_exec_halt(CPUState *cpu)
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         bql_unlock();
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    x86_cpu_poll_during_halt(cpu);
 
     if (!cpu_has_work(cpu)) {
         return false;
-- 
2.55.0


