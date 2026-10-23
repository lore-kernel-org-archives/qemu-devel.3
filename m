Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E8606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NrJhFsHd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YtmWn5fD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHu5-0003pr-Gn; Fri, 23 Oct 2026 12:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHu4-0003pb-8e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHu2-00024m-Jy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:13:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3hfF2931009
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d5GalUR0CbSEpC1GLCKW/ZNqBCp/ZFfGLVsPpJHc4mc=; b=NrJhFsHdZ8S4k9az
 TBi0qQw1JraXZJiJyr6HITDzs/ajxnXagXCoSVvBEt4TdaHfWdXPk+dU4MBY+9BU
 mkVrdk3Y7vE5x1V5pnJcD9C8j7cSKxje5pAoGsoxwy/yhEBj+z+nMkI+omL9vf9K
 dqH2scotMwZeiOef+O2NaQo1cJsjbKEs5VSqJRcFK9vbCWhQ5zPjcL7cqKPPuPlF
 QCLZean/ODDT5B6j7/GHuuguK4CdBQLAiA9bSyClSpob6DQ8A1eyFYW6a9+67dQB
 opGCI1xsRxzK11mIXBZUl+fnySOGWGegqH11iu6f3eDWE2k5GahMRwEWQdc3z9i4
 2eTsNQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas6r1bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:13:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844cb60so192982185a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772037; x=1793376837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d5GalUR0CbSEpC1GLCKW/ZNqBCp/ZFfGLVsPpJHc4mc=;
 b=YtmWn5fDa3Lw+nDxdCMLBdLCS8Dg5tvIK42QWISI5bjWwD12lf/60oM8zhV2NZ5Rzp
 isbDKdOBEJLiDrSUQStWrQ8QsuWqgTsFlHvP/x5AZ4jBUiwYbqG8Pc5pfVdWv06Ggde0
 F0IHTwMsH4hZn1CtXphvhnty8SFTHbr4k36xN0zGLnDK6/MHHlp8PiSzzGD354Tinu0s
 cUKjTuE6HaA9lHJllajX8z1/yfvMnA7xVTbH7vOVwKawtkaKGixHDCfEpFAuiLxm65rg
 YwyYFjHDln6FXDX7njHcehjH/G/ntL0gisblXwpVCliO//ANFk4YWag+TYw4p+PhnGJ7
 wylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772037; x=1793376837;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d5GalUR0CbSEpC1GLCKW/ZNqBCp/ZFfGLVsPpJHc4mc=;
 b=daH2tWOGYaqt+eVFxSbNyzg540daUCGq7qrCoRCaxYx/38bRXPBTJETvFPrI+F6gm2
 VNXE3GcCRaZA79Dh88HTfCg2nTURv/Ebok2EOToleocU1mOMaRrfi9auERC76w4iYV6S
 jTjBQIw3Fl0ukQgD2LchLj2YgO+OJQevIzz1h+s4gbyEokEj3o/7LYa1hY7lC+CWOSVg
 yxNWBb4ZJ0qy7z6YmR8JBAH1umsPto/BoZ3GqfXZEGqsWx1o8TaSOmxoAynnZrS3heUq
 nbzcDOakU3aiFsDEi6NONMSlwf5A6FXFHvDR6j3WcHJGC1t0I9SB10UJKyJ6xyyL243k
 AZoQ==
X-Gm-Message-State: AFq9FYKV0wu484xM8tqBVEovVLRPdW0bLlei3uqAl/SJhbf5d38LSDHE
 thpxUKEQa57TEQhu1SIwNmp6hB93IXRxWaMM1HQu44DxJgQXSLlG02SzZWzHav0KzAq3/8EEZGd
 XbQg7P8GiUKXMR67bVF1+VGAe9Jwe3l/+I4418tIa9Wvr278DekCVE4XuFENtDAwdX8iZ
X-Gm-Gg: AYBFou1TBgT2EvqeZLCVI2OlpTq3M36E7v5DXkCi27K6zgPpmOIAhq0NBuBFpNcUKGd
 U1F5PH5hTMOSE233hSBoZbFocxT6SknCF5LULtT0Xs+6bag/w2UpkD7rufuOg4xDlp74OlNBVhR
 H0PTXEp0glNImm7k8ts8qQYkOA6nj16z5o60fqP6aV2jTPH1LkRDnTseNiCsge4kT3GgKXlfNi4
 tnkXZ36dCsbJP59xS59rBaRWNAzleBU+rSAuDU54KMS1TOc7LOqHXhXQmL1la/ePAAmGYNbcJUG
 nkxbu42B6wvlpqde8Ui/EG6ipvafFGRKhd0ebKQQDK7j1a09IyklepwtpCKwmjcoF2fo01Xzhhb
 OZHcOs/h2P4le24AXHjAt24dBrZR0zmTWEIYB8s+2
X-Received: by 2002:a05:620a:1786:b0:93c:d209:4ea1 with SMTP id
 af79cd13be357-93f627549fcmr961218385a.24.1792772037013; 
 Fri, 23 Oct 2026 09:13:57 -0700 (PDT)
X-Received: by 2002:a05:620a:1786:b0:93c:d209:4ea1 with SMTP id
 af79cd13be357-93f627549fcmr961214685a.24.1792772036577; 
 Fri, 23 Oct 2026 09:13:56 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d37ca1dsm994517f8f.6.2026.10.23.09.13.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:13:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/83] target/arm: Split leaving-halt handling from
 arm_cpu_exec_halt()
Date: Fri, 23 Oct 2026 18:12:11 +0200
Message-ID: <20261023161332.60153-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfXxR7fO4tWjeJS
 itJPNxzm4F+fSMGli0aSKI9lM4SyLhOn3HWhHI18tNBIKJrThhNFfu2S5MXWXOCIGEQwEZABcgW
 UMgPY2QP9jyn8qGlkeCW/K+R70q3K7+2Txsw8iG81DsWzs2mt4oFb6IIZ2xXo3noqdOJmuALiYn
 EnRStqbw5lmPMuGiP0Dq2eC134zbEA1uG+c9XwGLjmX2BQkjcekTQhk6F9vBR9OyeqaxkkMzoZw
 LHPLzKqczLSPR55ZbrYw4sODSukyMzd+bQzieK+i69QhCmbsYMbC38Iteq75oC7S+KoAH6P27vi
 rfsFYS8d70nuWmp5OWZdZ1GgsM3ZKrzre+L1auZvPUFfz6as7+7gHHFj+YBRBsq/GeQxQmKTcTo
 h64DUmo57xROtEzMjXCoXuu8lLtUXEdaaSP4bHHH/RECKNCGQtUeYO5rt2M9zbZtyfPGsYAd0EY
 9D++DkTHapiVrb4Ftpw==
X-Authority-Analysis: v=2.4 cv=DK0acCNb c=1 sm=1 tr=0 ts=6adb87c5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Z-zrMdKwXTDJOmNx3EMMj1t5o7ql4lPm
X-Proofpoint-ORIG-GUID: Z-zrMdKwXTDJOmNx3EMMj1t5o7ql4lPm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX0YJbHSsZ3e3G
 to0+v0Yd6o1hCwDpwXq9GjWtkonsHBU5EUwy+JvXnRCAH70N5fM7NsMM3VUJQ07yd4khqfUQDVT
 wapxS26lCxBJatky+LdpPgUPTY8CmIE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
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

Move WFxT timer cleanup and halt-reason reset into
arm_cpu_leaving_halt(). Keep arm_cpu_exec_halt()
focused on deciding whether the CPU can leave the
halted state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930174946.82195-4-philmd@oss.qualcomm.com>
---
 target/arm/cpu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 73fdc6e460f..af0c64d196e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -872,18 +872,24 @@ static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
+static void arm_cpu_leaving_halt(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    /* We're about to come out of WFI/WFE: disable the WFxT timer */
+    if (cpu->wfxt_timer) {
+        timer_del(cpu->wfxt_timer);
+    }
+    /* clear the halt reason */
+    qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
+}
+
 bool arm_cpu_exec_halt(CPUState *cs)
 {
     bool leave_halt = cpu_has_work(cs);
 
     if (leave_halt) {
-        /* We're about to come out of WFI/WFE: disable the WFxT timer */
-        ARMCPU *cpu = ARM_CPU(cs);
-        if (cpu->wfxt_timer) {
-            timer_del(cpu->wfxt_timer);
-        }
-        /* clear the halt reason */
-        qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
+        arm_cpu_leaving_halt(cs);
     }
     return leave_halt;
 }
-- 
2.55.0


