Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B42BC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0Jc-0008Pv-LJ; Thu, 20 Aug 2026 06:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0Ja-0008Nx-HZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:48:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0JY-0005lp-Pd
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:48:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6eXsD2161066
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sy4vN/OTGBwXa0UO3cJvv7KQZLmMlNbXWMIg5UlIao0=; b=aznFfAC5gKt/Npt9
 FJzr7TkG0dTSyTJnsVclEmXrnZ030foF3v0h9kw9KULnDBHW5kLbdvyfMp7bt+lz
 CpTAA0bYy9tVM1qWW1RGOrvLw2bjfg0hN8UF+B2kwp0vfOy0sMlhn3K4w7wyQVlR
 kySAW0DvF8Js8AaekVdGy+KiIJk6RlWmUhsNs5ncSXMcrB+Bt3LzvN0B08s3twoI
 ZrQ1loHAqYCcDv3ruxJGrUpHV9hDog8de9Zr/utdNtxEJVYsixoApCkQVOLOE1L0
 2ioVfwBmFeYSIsuoK6pTct7loGQxrwJhbqQlXY0ySjz/sCKCNlO/uo1wx1cPQnFL
 vM0s4w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7rwwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:48:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936cadb0e8bso176956485a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787222882; x=1787827682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sy4vN/OTGBwXa0UO3cJvv7KQZLmMlNbXWMIg5UlIao0=;
 b=iSc/OVX8dtU3BVTvTgjea6MMMJJJLfY3KCOvXQBwiJ9bp8iM7bIug6855rUNc13ILr
 Zf+h/a1CiW2QLchWchQCDvYOGHyxBkX5cmV327qsFSnyAYUMrhfwI0tDQZcicSPFbKSC
 usT2mFmBzpTlswpSLcKWcfgMm0frE/wLoMT31eFO55B4KgkLUMBJRECw0nhdKSyU3+BR
 4qGpWRO68ey8oOsczSdMHWuQXdyGo73k0FN8ck3gFZRMLeqyL/XkyeRffLB958urCxVB
 zjcSpurOGueRdR3JgYbEaZS6fML34PDQq9CHOtxnkyNLGkKakyaYLZZhVgdPeu07i6I8
 viqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222882; x=1787827682;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sy4vN/OTGBwXa0UO3cJvv7KQZLmMlNbXWMIg5UlIao0=;
 b=m1o1t3yJ1CkoNJ/YCah6fd0eSSufJsXA654Mp0jzIpuJA+lpEAH618icHkyzVNQstI
 acb7AOcWLLRk1sfJjlKLZigeWS7ljqG8wsBZEBGGzDNTpsAdUGlEaL103jM9H+bCJAPa
 5qUHQDBsi2Zrb10+My78N4VCdSlxK6QgXzklBC/0s0SAdFuEfdcL3bCEN/YTtvqmHAsB
 GI2GTmWtq8I8O0U1Ef8ma/mvyaFVlMWlMELmk8ZwORNOlCW075kCVJ5zGgQAeL0iBjXN
 +XPtmTqPerEmzkgUgZxyMyS0WRr9LCChwM+mIfuBNJylLJO2Awy8Ki11zC465q/2DlIC
 Ky8Q==
X-Gm-Message-State: AOJu0YyicftQecvoNxNSkqR8J4lnaHIecLva1e0VEXM5YFRjw3FrazPp
 2430YTe5EXJkOPRlGcHMxjat9HnH6fnUx2xFjQeFlXH1DiDI+n6loKF+FFo/uczMfbN4a+Va5Uc
 soOTmt5lQaeKEVr2NimbUfPnPvYb4DfEOqtjKkb8827G7dhjuGmHPIQGim6k4pdgKgkf9
X-Gm-Gg: AR+sD12sS6xB//4AHXrvfD3VaOL8c3Fia1/w2am+Ho3A/ukQAdScEztu5cNFdVCI1Af
 MSZDmZZoCUIDzRtyaof692zeYFlTMXmSpYwdLoSb/5hXjANnYU5oUdW0MiWrsKTnpb60isnzOjW
 poXGd4/h+TX+wIHbuQN2XDXSuaPk/NOGIKXw1W14E5l1gawgmt/JN/ywo2aRGBSoVhiSwgiHVlW
 UUpj6Npho5uOF0KflejoLVW+8pEOzPmCe0bBZFlCzFE2X/34SFI5l73Fhuz8JAqlMFv9CvX4fV1
 zI5LXYSO0LTeVlOERBX5lKI+SGf57RyJIX/r7ufe0uwVsqdGXNIaB+a/L8WvkRAB5lFtu5Uokek
 uigxOAz0lViEpk5mmyMyz2gs2O6CfiLQhor/3GiPoSQ==
X-Received: by 2002:a05:620a:25d3:b0:937:1538:6b93 with SMTP id
 af79cd13be357-9371e6f0580mr985527885a.40.1787222882551; 
 Thu, 20 Aug 2026 03:48:02 -0700 (PDT)
X-Received: by 2002:a05:620a:25d3:b0:937:1538:6b93 with SMTP id
 af79cd13be357-9371e6f0580mr985524285a.40.1787222882046; 
 Thu, 20 Aug 2026 03:48:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14cf0a3sm11807807f8f.32.2026.08.20.03.48.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 03:48:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 04/13] target/mips: Constify CPUMIPSState for various cpu_*()
 getters
Date: Thu, 20 Aug 2026 12:47:20 +0200
Message-ID: <20260820104730.25462-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820104730.25462-1-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX3iCZ557leoqQ
 8TU9H9y1tuRbBF0YloiuiCNnDU3cy46kcsWAGEl7QMIG28Ih/Vm5/W3zs0VTpWXkufUJx6/aC1u
 QLD8EgVmrgg/UehUNu+uDvqIrl1UkM1/IuEsEk1ErVO/TgtGpwNIr0cfWOLX77z6cWzOO/wENxX
 5UYDyt/2viJ2p7EqM3PjuxsCjVeZ/Xpoo3ueDccZvtN/w+klBWBSfvD+70Kjo9+/ueJieROrtSc
 S+vptnrmxQA5I+swxTAPoSoWGBdukghlRonOrTGyDkPHYl6Fl4tI4Cf7bZ2gC2hiN6gDU5Aikrh
 nfbq8zjPY/0vUOvQiNa1ygnH05BPeU4cLYGOFNAQZ2rqgOnvnvcAbFonzFyku9tpyYohMwQCpLk
 ih4D2hwuR9QB9A5jTqAV5mlXBhUX0yjs+1pILFz2+l4OzzWZO3h4Ew7LDzULmdfyZkMTIARFNXr
 U0cG5k7EiK49EzvSkXQ==
X-Proofpoint-ORIG-GUID: -C0TsSDMSw-dWf3mpUDd4Bu_dPJYb1rt
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a86db63 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=OdUTIDwS7iTBxe5GiEQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX5fU41sWTeSWs
 m6JrrjwYxrzKqNLCMqC9kltNb+q1GmSwzgReOw3OT9yJNbei+cTBwujVDPGKvJCYBu/ClV3xIbO
 76Vg0Ytget0D7lFjjRYBmhWKCSwFrG8=
X-Proofpoint-GUID: -C0TsSDMSw-dWf3mpUDd4Bu_dPJYb1rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add the const qualifier to CPUMIPSState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.h      | 6 +++---
 target/mips/internal.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 319147a948c..6404b342a5d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1372,19 +1372,19 @@ static inline bool ase_3d_available(const CPUMIPSState *env)
 }
 
 /* Check presence of MSA implementation */
-static inline bool ase_msa_available(CPUMIPSState *env)
+static inline bool ase_msa_available(const CPUMIPSState *env)
 {
     return env->CP0_Config3 & (1 << CP0C3_MSAP);
 }
 
 /* Check presence of Loongson CSR instructions */
-static inline bool ase_lcsr_available(CPUMIPSState *env)
+static inline bool ase_lcsr_available(const CPUMIPSState *env)
 {
     return env->lcsr_cpucfg2 & (1 << CPUCFG2_LCSRP);
 }
 
 /* Check presence of multi-threading ASE implementation */
-static inline bool ase_mt_available(CPUMIPSState *env)
+static inline bool ase_mt_available(const CPUMIPSState *env)
 {
     return env->CP0_Config3 & (1 << CP0C3_MT);
 }
diff --git a/target/mips/internal.h b/target/mips/internal.h
index c5c286872eb..66e8c599b43 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -165,7 +165,7 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
 extern const VMStateDescription vmstate_mips_cpu;
 
-static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
+static inline bool cpu_mips_hw_interrupts_enabled(const CPUMIPSState *env)
 {
     return (env->CP0_Status & (1 << CP0St_IE)) &&
         !(env->CP0_Status & (1 << CP0St_EXL)) &&
@@ -180,7 +180,7 @@ static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
 }
 
 /* Check if there is pending and not masked out interrupt */
-static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
+static inline bool cpu_mips_hw_interrupts_pending(const CPUMIPSState *env)
 {
     int32_t pending;
     int32_t status;
@@ -281,7 +281,7 @@ static inline int mips_vpe_active(CPUMIPSState *env)
     return active;
 }
 
-static inline int mips_vp_active(CPUMIPSState *env)
+static inline int mips_vp_active(const CPUMIPSState *env)
 {
     CPUState *cs;
 
-- 
2.53.0


