Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D6EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegbk-000351-OB; Tue, 30 Jun 2026 18:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYr-0004ur-CE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYp-0004Oz-K0
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDZFn2942559
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ze3VwnuFzJ65mEN2sr5YLNMtfENgVZhXXeqCsKTvnII=; b=Gz4OKvlT8Mqe+tsI
 ChfHOa90uqY2HyYVddnJqd/734VEKSpOo+aFPaFG4Mbw0Jp5Z0Y0rRMh0/XFDWmh
 Zk49FBgM7lpRDYFkP/PK4yoVbvTXatmOktH5zaP2376VE0I/4kN0FdXxoyZqK93L
 k46FoP5C/JNdzJUWskKMArsFGh5ay0MTTqd49QxQLc3RNxE07ps5O0v6/sxdTY0r
 ARNSWod+NRjLVJlLGjiJbJG5pMQo9eOXgUHQzZbLikG/vvRwDt3NgRiUQwDjhsiX
 4V0FmHdIgOhmSxlLwMPm4LCKBqet6t4IjvOekfjJEaunC3dwJDZRN9TI9j8npP2e
 LQutqw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99h49b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:05 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-96927e59ae0so4734507241.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857045; x=1783461845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze3VwnuFzJ65mEN2sr5YLNMtfENgVZhXXeqCsKTvnII=;
 b=DfBGLDKa4qPLqb4UlRe2GqQQ5ec4afkONAufkxQp4QDKl8YqETC4Ye1pELHgMOX0kq
 kc1bVXt0XqDoSAo+40SAx31tSIH9c2ealPsA9ZM6eLIisGJAj6tjqLd/8Gc9HFm8Nx5B
 FAYLXBVldRwgBjO5rcH96a+ztu6F/bxzGGP26vFYyFiKZEE7Q1VzDKTkJUEZeinrWukM
 eJ9yhY4W0b3Vh8ELSnOWzTcNnMdCS8hrVSGUk11ok1TUTTNkLR0yzoA9ZEhy1zlnMVnx
 wbl/XyCL+TZRlufpV72SE3IIUaCluGnfoJefCBNY8xgwZLwE3ySaifwacE75Wu/p6PiD
 uCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857045; x=1783461845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ze3VwnuFzJ65mEN2sr5YLNMtfENgVZhXXeqCsKTvnII=;
 b=rpCPdW6mnsoWc+6jNpobQKwTT1dMK4pwwO4T71RsEBA9YkB7bnDKCcK7ekctSpmJlE
 5U6EcDCUPZFtKJDUP/4Q1KfvU1YU6om+XFwObFhtisSkmafhhfABnnOLlBg4RxRrexGO
 CWNQZhqmVAQQlkcQ6hWJ83XFY59oytakx8aTil2vKR01wswhYasNIHNNmbUp09Xj5mL4
 XtnuXB0YBhdPiRzftFJdAtf3iavdOTRwilK5k/O1lONp2UKJkegBVC/FjtAc6fs4W9sN
 Wgc/tklWkS7actyqxfWc0dbX/jvy7a/o2CrM5/gMFPLO0KQAVVdwQiJuIYg+rTTvNhuA
 vTDA==
X-Gm-Message-State: AOJu0Yz8hQGyDaCuq5+MNNZxs4M/8Gqva8xNm2ITaRDL/cLNcW1lTla/
 2YdJp5zNFfKmA3m1aQXwiuW3tmH5qqJjT7uLMQ/KoJI7M2yEIm3nawl9R13A/DpA99klXu5gfsJ
 6LeQBY7KweHWU/+NsvKlb6QZa2zP8nTQZ8FHBKg4s2dg+JGvYA+AKKcQa/XDyBD7q0g==
X-Gm-Gg: AfdE7cmLWES9qwGpNKl5XNfLACKtrfvMgTvlU4a9GUnSqsv8Ox4psPsgT2K2l7W212K
 5w27SyuQRZ0qFQcBjWaXGvYG4X4nop/U/GDEZ7BZyozP+b50CUmT6cmdX6dG1ixvhmKmS6W7jDT
 lwikuBYh2S+9LNg0LO6g/nZQJXCeY7n5R7zbSO4Er+PUIYWX/7Tm5/1Toacs5/ODyZF66hS5qiy
 4ReRQsJEizA2cTdCzggNOcJkSNJCxXUvH6voZwl5Yr/k5GYXc/UnyHdw8RUJynHU1qg2qMa/2pG
 lwsoo0NXjAX4GMQcjy14SMP9KD9PNcdJBaVH+TMulRAXSpSZ5U7JqcjDlvfQ4LeprRRBcN16Tn/
 VtATUxW5I1aTzhj+/OpLtKu25lx7t1nK4jnVHCdiTaVuxRfRtPLx+h8+zcQeaXwxgL9mS
X-Received: by 2002:a05:6102:5986:b0:6c6:432c:84d3 with SMTP id
 ada2fe7eead31-73a36be6ccfmr2840971137.12.1782857044571; 
 Tue, 30 Jun 2026 15:04:04 -0700 (PDT)
X-Received: by 2002:a05:6102:5986:b0:6c6:432c:84d3 with SMTP id
 ada2fe7eead31-73a36be6ccfmr2840939137.12.1782857044191; 
 Tue, 30 Jun 2026 15:04:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef183e7sm17391395e9.2.2026.06.30.15.04.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:04:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 24/33] target/arm: Inline check_watchpoints() in
 arm_debug_check_watchpoint()
Date: Wed,  1 Jul 2026 00:00:51 +0200
Message-ID: <20260630220100.1289-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfXy2exCpFZqX/L
 9kK7cGwDvTxpwcMLUF1BvKEnfDUIf7JSS1SfMYFHBj2lU/kwcqcMlamzR1Pm5RhFXvO4hEExJUl
 PQ+swNarRi38jVP8mSzt0tJ+i9uOstc=
X-Proofpoint-ORIG-GUID: PIheCbG1m7fmV85BjnwfSAq_oefhwbib
X-Proofpoint-GUID: PIheCbG1m7fmV85BjnwfSAq_oefhwbib
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a443d55 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PgT5FCoeLhrUO_exnl0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX3o+a7lJ0J4EX
 OU3tp655v29SYccIszfy/8lWJ0GEtkMrA4+wXHbtamNZ7EmsJcIrTdUJCcc9FV2HYk+y3F6RsYB
 mBNESXhq6smy4R+7Yx8mydv5B8OAEb8qT/bM24uwMkmXnbp5H3jdyP+jF52DkI72/kxnlTNdekg
 0BLJS2be0ifgy63q9uybUtIQ88/6N2IszhosMlPJ5F30uvhKuA4UY50d33orkLnmO06ZVKz0Bxh
 7sOHR6NJjle4kv6VUeSmr1FGWnnHM0EkIn62g1GCyzzuddraAX0g3k7PlWXICroWrPXhNhDq7ij
 uE40hh9JzI82qKJ61S+8sG4syxZQEvEp4MaWoFN1Py2Si0NKkI3z++kekkZmFNk+CJmcxGVHtqR
 4dgEmUQepmayUjEnLXYNIxuXGAmVoSMIwcXUiNfkv1vCqxkM5pU9J4vzQPECxU9TDpcm6Tg9FNF
 9Qr6ZRdRLJ1Y9Y71bJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
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

check_watchpoints() is called once, by arm_debug_check_watchpoint(),
which doesn't do more than this call. Merge both. No logical change
intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/tcg/debug.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 11043ecd589..7171501d400 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -351,28 +351,6 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
     return true;
 }
 
-static bool check_watchpoints(ARMCPU *cpu)
-{
-    CPUARMState *env = &cpu->env;
-    int n;
-
-    /*
-     * If watchpoints are disabled globally or we can't take debug
-     * exceptions here then watchpoint firings are ignored.
-     */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
-
-    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        if (bp_wp_matches(cpu, n, true)) {
-            return true;
-        }
-    }
-    return false;
-}
-
 bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -426,8 +404,24 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
      * is also an architectural watchpoint match.
      */
     ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int n;
 
-    return check_watchpoints(cpu);
+    /*
+     * If watchpoints are disabled globally or we can't take debug
+     * exceptions here then watchpoint firings are ignored.
+     */
+    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
+        || !arm_generate_debug_exceptions(env)) {
+        return false;
+    }
+
+    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
+        if (bp_wp_matches(cpu, n, true)) {
+            return true;
+        }
+    }
+    return false;
 }
 
 /*
-- 
2.53.0


