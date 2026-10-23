Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC637606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MwyqJTlt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C4u7xxPC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHvF-0005pZ-E3; Fri, 23 Oct 2026 12:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvA-0005Yt-Gz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHv8-0002Dv-Qt
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:08 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6Cqk2215811
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bibHLDn0S1CFBZ5JTPhtqnrS/+dx4AWZd1scb02DDkI=; b=MwyqJTltuDmWcEbu
 oll942/BnUmojXFIeNRO0L5Z9XNaHh+top2N7s4nh+Uu+LUGmdln1OGE/Jlt+QaX
 8lYoSsGeMSvDZbjvilYX25+YWI4bex94Bpk4FQ7R6O1OL0qou4RRMn5krs5VFhPt
 bgxUdnbBm1fNBbcpmF9adI2SNdm5zH3TpX/LtmX4uRHIGH+mC+y+yhpHIdCPjx9V
 evmR8ZjfPe4W5P3SXiGX2S71TzTbbaTXM73at2XZcuV3HRRq48TaefuoVkNbuzjw
 /SiV6WAINEgb6FhK5H1gYsJlWPg5vRzEApqcrQa5365Rb7me9BW1vDZZOllzBQQV
 +LVdDQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc8148-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:05 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98a9c848bf0so247884241.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772105; x=1793376905; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bibHLDn0S1CFBZ5JTPhtqnrS/+dx4AWZd1scb02DDkI=;
 b=C4u7xxPC2xOxiYO7gYqgA/0nuUaVQT7piKXqWaewpLtzaP/GJ69Nu6c0M13yRCixFf
 nWdHChpcZXIQEs8WLP3C1OwWsINpdMXPFf1tHht+vl4XVe51VA0YtMhDGTBNXJa9Oh4d
 Al8WbnkUbko/u3xAli4tv0p0YupWKEZWzTqRmXTTHZD6RucfUHJzLWglTN6rEHKrjcaZ
 QyrH61ikME/eyMABmEfrR2X1hTvsUaD96s8UjUNVp7o3BBJ0/FM1bzQ78H1PHDueDwBO
 HmlB99wKQuEFkJYSoyUj1MwW4qKIEEW+bbwv5UyAiNgs/9bnNFOAP04tWNFxL5wg5EYA
 1HPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772105; x=1793376905;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bibHLDn0S1CFBZ5JTPhtqnrS/+dx4AWZd1scb02DDkI=;
 b=kuvIYXa2ismaUEjBbnhh64gaF4ubkMMwU2H6KbJiZuHT9kE53+QtoAuhdfU9pTfEPm
 zM0pjX1Spg+aZzcapWyEaOQ8hSBdoenWXFIr2K9iWz7VkmAK7+oyo3VeQKKcN3jUzF7u
 T3r/LQv/9n+ccXr7Z0ffW9FRlrVniDzJFceaf/CNzMRNZDvh5+XV+/rCbxBDxEmoZj9+
 aW0OjR+HzqxP2KTzypItJZkmF5991QlGOWUM4p20yTHHrrAnKYqfmDsnqcGrq+wA/Oc4
 Wcmo8nDH4sdeVrBFAtqllVxereFwrq+00unF7CPub+yRYnHVNAEAhYyyHlvkDeNWIaVe
 DcRA==
X-Gm-Message-State: AFq9FYKXCdvfge+RzH4Cv8d5Azr9Y0jSf6faAFPnLtOKPlfaDP7HPZz4
 hBZr5JrAeD7byuNcWBdD2XwDpVpq+6N5lOWwK7P+JZpMDv6+22S/EIYSSzJg2DUcEHGUOLeHIQt
 T5g45WdTcFTPRBygVWmlLG0YOOX1kb1dGPU5xkJ7uaVOAYzeS+hBRk3QfH7rwH4w3jmBt
X-Gm-Gg: AYBFou1W81XQF8cOk+nhkY2XAfa7RwcSSIej5R7YYiQTkIDXNWEMheCHowmSFCpPRoS
 aUNaHztGTs7akAq/qGuuaWM3HLOID4rVJbhMci8SRayTWl3cv3BD68LmBrvz5xw9fYdo5XhDKnH
 q3BGyRlf1pRNkKLF7my/Eooao94KuEXM+52xiKjxR0tuMMSgeSeIrFb9I7eYJEF3kDBY5vrBjAb
 lp/jTL56tc4a30zCnRsfb4sxxTZHU7Sdb5rLovl4R0TSXNMsadBDierHtyiZtxp44XRgs1UINYC
 PDCk6/j/y/+4LsjVbZTdvKg3Vz/v7st3FhjvlD8eCJJ0FaI6XJaVERvdfx0gWMnjHOil/fQdW2T
 THTJHMDGWzAwEkUeVhACVt2G5pXXPRhHPHZs7E2e/
X-Received: by 2002:a05:6102:644a:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7ccc32fd429mr1074582137.10.1792772104960; 
 Fri, 23 Oct 2026 09:15:04 -0700 (PDT)
X-Received: by 2002:a05:6102:644a:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7ccc32fd429mr1074575137.10.1792772104201; 
 Fri, 23 Oct 2026 09:15:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a318c8f136sm5961655e9.3.2026.10.23.09.15.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:15:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/83] target/ppc: Factor ppc_env_is_64bit() out
Date: Fri, 23 Oct 2026 18:12:20 +0200
Message-ID: <20261023161332.60153-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXxiqD3oA5LE/e
 Se1I4ku5w/Zqjhs0SvuHR6R1DeGA+dwnKDBoEtwmIigmC91wJRuG5Fk0GgbKDsT6O7+ivm6F0A6
 L+9S5jYjO6cKP5l4q2m3G6IKHuKCGukFwB6oZa3LJDBdlJF1/+uDyCJlVbaxsQYuLaJKBWbw7of
 pG9ypR9qFp9q9Vh4h/BfrK2DzsUjcYr7oQR7LAJo/Ml0AbJk/7x934wv4CbIQQOB7Hv8WgNK4Ii
 EAnDiD/cBuiHRRz4ef/qOxFGUV1H8MrY8ek4fF8qB/avWe2EbTbpJxu5w3mhbX8IL5RuPtgD77D
 0NCVDtel3oANzkY8dQXCGktU2nAIzNPGaCSVDnGxolNVB5NE5O0n6SO11rq6WGWOxFxSp0mIFJH
 WHduC3PDr5+27FLCN9GSOMlkxDI4zJY4HK1EVxLX5HWYMCjdqW1Wlhfjx5LZX5TCttD2mWR4RBj
 s51eSeSzt9WPBzVHtFg==
X-Proofpoint-GUID: 6Fj4_gB6VwEJvaoD9rOszm5vwPFVI8Ln
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb8809 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: 6Fj4_gB6VwEJvaoD9rOszm5vwPFVI8Ln
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXxS7GhxuLVPMg
 Ot5wifhciYwTd6QfhUsCTvw7ug+XW824yh/iQ8d0Q+5hcJv1NJNWlFcFuwkLnEzxVfi8zS6hE4O
 EQttuPnhBuBBqhxEQ3enNKUmVmOLY5c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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

Replace the open-coded PPC_64B test in register_BookE206_sprs()
by a ppc_env_is_64bit() helper for re-use in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Message-ID: <20261007232326.66240-5-philmd@oss.qualcomm.com>
---
 target/ppc/internal.h | 11 +++++++++++
 target/ppc/cpu_init.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index b3ed57eaf73..11fa4ee5417 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -23,6 +23,17 @@
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
 
+/**
+ * ppc_env_is_64bit:
+ * @env: the cpu context
+ *
+ * Return whether the CPU is a 64-bit implementation.
+ */
+static inline bool ppc_env_is_64bit(const CPUPPCState *env)
+{
+    return env->insns_flags & PPC_64B;
+}
+
 static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
 {
     return FIELD_EX64(env->msr, MSR, LE);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 0431c0e0ae5..89a8b14a393 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -869,7 +869,7 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
             spr_register(env, mas_sprn[i], mas_names[i],
                          SPR_NOACCESS, SPR_NOACCESS,
                          &spr_read_generic,
-                         (i == 2 && (env->insns_flags & PPC_64B))
+                         (i == 2 && ppc_env_is_64bit(env))
                          ? &spr_write_generic : &spr_write_generic32,
                          0x00000000);
         }
-- 
2.55.0


