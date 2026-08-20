Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A41CC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx99q-0005Yn-NM; Thu, 20 Aug 2026 16:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx99p-0005YI-HI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:14:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx99m-00024g-RC
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:14:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7dw5587763
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=; b=TtpABNBi3HVQUY2M
 62KJdbbEqaf9DmpqjB3iapOnhmeHeDI7Woy1jzs4o7KO/lK+fvN6gjR+QrojpfeX
 V8lW7adOVEpV65469o1y0+x64bRmoLJY8CajuLQUny3hK7ku9GovgIti98VgNytE
 SPKuTXGYZsYXZh1oacEZeEufDN+naLNAQ6x1wkbuUQt5+vRqZfUla0UFlGtIGRGG
 8HvWJgnba+lbjPr1/qv86xFVblL94nQz7mle0EKsnga9Aa6Q33stg4++BinoLtxX
 dBUItiUyO5dqM5xb20v/Q/SaO4ONKtD37eRI3rcoItcKJ51DgYA6g8P4g+5P9Rjr
 42wE9Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8asdm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c083f1818so2661791cf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256863; x=1787861663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=;
 b=A099Jc0mFnsXmEtk38ssisOJ18El1FQXJ/MT7cxawx4toxoH7h49d7gcoi9Oqkuzd7
 QoVLE9cIlMcRsxztGp9DNWbRpWcyAy1JZpOcOgGJpzvIrOORcNapbT35FtCXrYyyM9eR
 PmmxoRjiB2883W4DQ8vzwhoxD+oMseQsYWydf98zBSxayM4FV7tEOM9t3PvtPLWkJp0J
 4NpAqnqZjd6VXF27jdQv93Gi1X9PvGvdcE0CEZhTSjYw1/jy7HSXEn1gXFFA/GyD9LI5
 Y3j3oMXJuJ205y92jvzrHW9Q6xNQVkjmjaYu0T52lsCzln2adJEbTu2zkvhmSkMrsB04
 QwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256863; x=1787861663;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=;
 b=Ot5kU1Xif24t9yYgbdVTaKh4K4dktedwGs5nRYY52+jdoCyvnCtkPvRK5LntxQYIwY
 K+iqmJ+++L5rruYFBemiIn+0eYaFOJIufkxnRLu5SCoWCDgaie2rDv9/hSXNgLrcUL+5
 I2/HtScmxt+bnhNsVGH0g+k/JpTDiYRp/ZdTAtSt25IWwY4WQez0L7WMw19JZ5SY8ZbN
 dGdb/rYAlUb388OfSLsywY+mOOXcxFDup3PGr8a+qKEP89ENCM7Kyx1WqeTYYjtPIR81
 ME+pfQejsIedwRnHq85KDiV/l1HHD55bvV6ISZXtj97Qhfv2O07s5ld0/aofO3aYj8Fx
 N5JQ==
X-Gm-Message-State: AOJu0YzNUzwyt6VFCkcjvdJ+7mK2Wl5D0gsj6S2EKQJLcij2IPf0G/nq
 dztdWgsFVX7JZcVufTZvnDrj1cHK3KuRM2rPvHTFhtwM9xfNC73DrPxbc80G0ElsNHT+JkVDMpV
 cRLdIz36ze/WYmKFr1Zw9ckvJQnLf0bacQUxX5kaAfUJpWh1nrNzpTJDVqpNNNoXRhzeS
X-Gm-Gg: AR+sD10hOivrn27Ao7sck5sVhqcOmoiV8StgWv8xfRUcQuaVzBqq5JQ+QOiSB5pVk07
 DzTYcKb+kxxZ9kXQKqOCPfRYAIh5IJK/iL+s4iuxxJzLbRhG0QRk5sZML0fjd0XQtNh8ZIMUhMG
 TDEbqQwCWWiDAoRwntvqIc8xcvPYNvktDF8IMvnVtsE92cNjMPblitlIwQYemEdouxsx/NMuwwV
 s+VVfEzBPV+2W6FMcj3Z5GFdLXcAXe+ijSqWkuYR4Yzx1MdNwv81WIdkIvwAFhnjgz5tN2pl2gb
 gqwMVXmNo1U+gClPt7GP1a2CGTU/1ZLLQ65rCxIUj0pn2JV6p3pOgZebne1RQ/nU0nSwrQJCKMT
 MuWTCrcSNqHNmmAikCXy/OKU54GMes2ZzQ7NbhQRwyw==
X-Received: by 2002:ac8:610a:0:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-52df56e48ebmr12101591cf.2.1787256863143; 
 Thu, 20 Aug 2026 13:14:23 -0700 (PDT)
X-Received: by 2002:ac8:610a:0:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-52df56e48ebmr12100911cf.2.1787256862673; 
 Thu, 20 Aug 2026 13:14:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90d297esm3831355e9.2.2026.08.20.13.14.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:14:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 03/15] target/avr: Constify CPUAVRState for some cpu_*()
 getters
Date: Thu, 20 Aug 2026 22:13:43 +0200
Message-ID: <20260820201356.29775-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX644rylCzSoip
 3dZnObHIicKDFfC6QA+r+kE9B/s54dujX7f36fuGDYnNPpuTvkOHMzxjlfZA9ayqnqtYWkmiXLz
 TiXSPvM1vjBGorsllp91/JdXtxI+ssc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX67g51itMCV+t
 GLFDE0STW2hrLwk5n89r4SaZmDqoPBirMmwBeNb9+4ltlXEM7wXpbc1LSZRaTm1YO4NOG6tVyLC
 Oc9br9/XD9hTCVwwelEtf6pauoYqUFBGsdUMgHpi47Pm0nJ4JzLh8h2sZdA/pP/h3uRW2un8O+A
 w/J0TsoNSUB7qZf6aUTHqAhjHmutcWdR5PWq3GquRsdIeb72JCjUXVRKmimrSaGrsP5mu9P7t/6
 7W3qCYI/cbUnagD7eg2Hce38+b3zL4DT96i+LBF2Y8PflWqh5hz2TzCUxRMHXydmEVqR4OBs7Yx
 U6fj75aA1oUmnSsqPfEfaRheMR56J4CIMSV5p7vaWcO6+m0yu/Jwtt6Ca6oHsiTK9vQB1nzW1ej
 gXUjPHJiR03/+tH1U5RztxCn6+8NbgaKvJq8TzhpPFVeFI1UUVJhqHcTtEjDtbzC6wpKfP9fCim
 YA8W6n3JI8mSq2tIDng==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a87601f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=064F3_fa85QpgnnSfTgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: YpOoHnK2I2LzpsiF1n4MxyO9aDFyUkKs
X-Proofpoint-ORIG-GUID: YpOoHnK2I2LzpsiF1n4MxyO9aDFyUkKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200152
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Add the const qualifier to CPUAVRState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/avr/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a818db753b2..1e4e839bd83 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -183,7 +183,7 @@ int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
 vaddr avr_cpu_gdb_adjust_breakpoint(CPUState *cpu, vaddr addr);
 
-static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
+static inline int avr_feature(const CPUAVRState *env, AVRFeature feature)
 {
     return (env->features & (1U << feature)) != 0;
 }
@@ -204,12 +204,12 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-static inline int cpu_interrupts_enabled(CPUAVRState *env)
+static inline int cpu_interrupts_enabled(const CPUAVRState *env)
 {
     return env->sregI != 0;
 }
 
-static inline uint8_t cpu_get_sreg(CPUAVRState *env)
+static inline uint8_t cpu_get_sreg(const CPUAVRState *env)
 {
     return (env->sregC) << 0
          | (env->sregZ) << 1
-- 
2.53.0


