Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999D606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OpsJL0pj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jDhD5fz+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0P-0000RU-Q8; Fri, 23 Oct 2026 12:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzy-00083x-M8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzw-0002iN-95
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6rNH1492209
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /XADBiqfGEepOXL74Q/I/CjMCNR2e56/eosGamhb89M=; b=OpsJL0pj9NKiD/Tp
 E2fCyiM9axowuG7ZpCShQFB9Nwx4ndhQBQttmRC6Zcy2IJU1N0EMEWzP7AZmb4tn
 sH1EQMynZiJUpPhgSHtjh5UkN9eA9fImRoY05/oCMa2cxDsyvniWjxyaZBPEfiI1
 PvbhgCBIl1jn28tOVpU9i/UEt9xoOM0+S22yBPIMBiFzdZeae3oGUTGtqrABZnie
 wdSqhNUQQ3uwx661gasJwucUR+JzmnOxSLxTpO35waL2WRFI5nOvOeMBzgfjW0yH
 4DdsYVsLpB5QwJKNIulGlNNolsjn7li0oklvcc/dHMQ0kmkjSRjvcs6qPvCkBzx+
 idWS0g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmauyma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f3969a2a7so177819785a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772398; x=1793377198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XADBiqfGEepOXL74Q/I/CjMCNR2e56/eosGamhb89M=;
 b=jDhD5fz+9ewhCDEHRgo69EyqDBJ4uS63mr6rLBCCicgpG2Vc39CU/THdfLm2mIUDCo
 aAsHMx1atsqc6/nZZBNLalWKMCqwVWer6mwToQ/U52ImgPlM+7XT7XDoNDyCKLD0jen8
 pTMWkZjifFT4ozT466NFnBkSJClopaHUo7dQaSldqIr2tbm9dlRW68TiGxm5asQd6HGM
 gDdsuQeFFu3OH7yaeujwJ/1ldo4lb+OpLaAFIGu/LvpYotg89s/rgCF3PrUFxd1WJxjq
 Iye/bFB8Ch+il39O5z9B8wDS8utRkJ5p3a8TGYnZK+9gbzaAZp3KriNfqQ/i+ttm363I
 cmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772398; x=1793377198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/XADBiqfGEepOXL74Q/I/CjMCNR2e56/eosGamhb89M=;
 b=HfiP4emKuKdGYsgpl5teuPb15FLuz/TGqaq8zpmKj8NHgUWx/fYeHo7Y9deDWW3WBb
 gr39B7UZCu+RuexnntHnYKXqlCufellNd9E+OC2cLENv6vQrhmwpw24nMrWOw/+eDbSp
 lOJy4/bAcS51aQMT+jaHPGwgItCzIT0r7sh/mCi6cfQN2XYxvITSw98OPP3c2Bx87G/3
 yXhyOYbNRJf8msIzepL3OqHzz24a4qz2uwZyevIbV/JhsTYuRTpw0uU+R1rP5ENZx4bF
 MX9L3FWHZy267ghUicFnHCKUL7uoatf3SN5RlppyZ72EmMQV5GPdvjb9GEJDkCySDd5Q
 J1PQ==
X-Gm-Message-State: AFq9FYKiEzOAxwUK2DGpSqDSPFRJPL0pWJUvqR0/4GfQdCHErkzskt/Q
 6aajKaIqMs10RAo6IsTvqHKkAblMnq2+SLrTDk1eFJHFPEDA/2MuUhcF0J6U5Xp44GM3/hRYsl5
 R2HhBShB46Z/3o7v3g79gsBucnlxnKGJI1sCy/SZmrV2gwdnwuQM07fK8CCIPTzkOnag0
X-Gm-Gg: AYBFou3qM2HCjKfzqXczZXTs31wcBzRXVeNukAKyQC+nUI8+syPzF++28PrJN1eLxwH
 bzDrd64G3aKjJYpMxmxF7toFrGz6RG0YW3oFOLgQoZWU4Ybx+Cgxqw5ABHNJYK3hABAE8b601H9
 tM4bicPzu18uo/PN2msdiMcFxhMx7txRbn0D4Qtu8FviZ6aokcboyuQldQBuKiIlHu25NW3g7PV
 QSEKXJG1YqqV1XzGWX6zUkwfxJUXLJAKpv0LC21n3CaRdcCjZIDxJoG3RuDHQF0SUjOoUKTn2Ma
 4aWIyCYNxYNOayr/rmGe2LP9SsjrsuEUJdx5i8YEvaroMSxU9TjyzSrD7DUV6JquFNSFj0XGLSj
 tpUlc8bgXILz2r+i8cdkRlpitupGNPz58xSg47qkr
X-Received: by 2002:a05:620a:4041:b0:93e:e24b:32f2 with SMTP id
 af79cd13be357-93f6f58a47emr507571585a.8.1792772397721; 
 Fri, 23 Oct 2026 09:19:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4041:b0:93e:e24b:32f2 with SMTP id
 af79cd13be357-93f6f58a47emr507568085a.8.1792772397205; 
 Fri, 23 Oct 2026 09:19:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d41e0fesm699302f8f.46.2026.10.23.09.19.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:19:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 53/83] target/alpha: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:01 +0200
Message-ID: <20261023161332.60153-54-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb892e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=v2UZkA9Hg2A--4dwkpcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXxIYj2n4vXeEv
 D0TmcE4Q4x+/7v7kAHEdjSXyHPnQyVCjxtISg/U/PmhLv8wcVktToMP2PqbeDPLppg3lXCg0xNA
 fgX92YZFnJm3Mhfr0JBJbKqOqXiKkww=
X-Proofpoint-GUID: -6bbG4XHejm2lr9_T7XeJiw-b-HaA5pU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX7GqXDMYZ7YGS
 YsyRJ9YlAbnz3G7Sr6Vs5eX7DgxmNSA4wunEKMJmCkJGLilgC9vOh578zFVDV7Te1/TAooRIwqE
 RVJT33Ijdr0JxQqJpyVTPtFyFcvupy9M/z25RAZqKfjPzkkQDluW1ZCerxv6dsS3ATZxXIoOpoW
 OHs1eD33Qil/N5FLRZ+z1AS+HG09ihXiVAzA8HliobGoDtTQGvPXoTq/Fkt8ezmXLvRUugsJNj3
 F1rpXX61Ecez1yFo3bi5QcdBHU2vJ+GyWZXetwBTEzzqCtIcX3bpYO89AfQW48IHp70aY4QOZBL
 SWEme85nC/t09bAZsj4XwwxyBi33/1EUvVLPWF8fLssA0UGzoJutj+QUdd3QzYb4pQklViV8Ipo
 68PRuwA82Lv5RdhcUgqN8a0BC717c+tW432SDsgHDA6UeQjz17hvOi26jAO7Lry8uOYBp1d4ik4
 N2ozYICeUW2J/2YwQjA==
X-Proofpoint-ORIG-GUID: -6bbG4XHejm2lr9_T7XeJiw-b-HaA5pU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

From: Peter Maydell <peter.maydell@linaro.org>

Convert alpha to providing the translate_for_debug method rather than
the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261020122752.3651914-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/alpha/cpu.h    |  3 ++-
 target/alpha/cpu.c    |  2 +-
 target/alpha/helper.c | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 8f780502476..5b2280c6095 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -282,7 +282,8 @@ extern const VMStateDescription vmstate_alpha_cpu;
 
 void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool alpha_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                   TranslateForDebugResult *result);
 #endif /* !CONFIG_USER_ONLY */
 const char *alpha_exception_name(int exception);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 6e514dcf4cd..fd099c8e70f 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -242,7 +242,7 @@ static void alpha_cpu_initfn(Object *obj)
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
     .has_work = alpha_cpu_has_work,
-    .get_phys_addr_debug = alpha_cpu_get_phys_addr_debug,
+    .translate_for_debug = alpha_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 84997ef3a99..d59ecc0d4a9 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -317,14 +317,25 @@ static int get_physical_address(CPUAlphaState *env, vaddr addr,
     return ret;
 }
 
-hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool alpha_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result)
 {
     hwaddr phys;
     int prot, fail;
 
     fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
+    if (fail >= 0) {
+        return false;
+    }
+
     phys |= addr & ~TARGET_PAGE_MASK;
-    return (fail >= 0 ? -1 : phys);
+
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
-- 
2.55.0


