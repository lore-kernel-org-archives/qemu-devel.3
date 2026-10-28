Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aoLre5rt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NfQCh40H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9Ha-0000hW-WD; Wed, 28 Oct 2026 15:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9HW-0000hF-G2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:25:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9HT-0006B8-Bu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:25:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPDDX2969680
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7nhNeujQqMNVCJsMuWWp//cJhFcS+HpbGBGQhKawoCY=; b=aoLre5rtqS2qgnGQ
 +kHHKk/PuTxmyq10l2aOVItO/hl+Cf4TcRp5gxtuHIJ0iPQvfVk4Up1UUVsPkk+o
 /5NXwSabUyzomw9LHax97GadqeNfS65nfjk0fxRBh+WUV7/I6jetZwi8o/VjoNZx
 LO1UTIWmLPdzVBhif87X8amEq2XUMIOmxnzQrb/2y6rzyud05nDg0K27MlTXcu/c
 Xou8b1zULknnk2V7OcU/b8ZQzUvTAQ3kn7/YET279Vo0Ttfh/5a6YVRcQiYM4q+J
 0KnKvBcasAgD0FtpMPOP+sYHDD65JsmMWitSrrmH49gs8izILSuOoz2HdawCz8oH
 PJDviA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehs5sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:25:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so269233885a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215549; x=1793820349; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7nhNeujQqMNVCJsMuWWp//cJhFcS+HpbGBGQhKawoCY=;
 b=NfQCh40HVY6cpO/yVq1sMzG5OG9wQbDMkISp8DqXTMNbptKo9ocqmTpYwAMSZ/fILo
 4tZuAyg2axUFFpa312EyRMrjk7C1pQwFd2MzvMkn6tWOal8nAoHRoBHRpd490ckxAuBv
 NlAAOaeMViaftIU5T/d/PACnjWXZwV04cXjy3kmXNbdrgljy8M+Lsv4XJ5KVWbnP6Zzs
 ekUhEaETVOOGYqyIX/ovzPJYX6PpCvuwnniAq3tLFoINXJvB10baM0xdmhEQ3ZTs67b0
 E7/FoWBmRQakZBt3bxPNBt5vxX3t2yUdWK1c8lMIBL2HMoutIjynFxNh4560yMt6kREh
 PUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215549; x=1793820349;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7nhNeujQqMNVCJsMuWWp//cJhFcS+HpbGBGQhKawoCY=;
 b=b8ekOdUKyOLJrB3SnMRpCfq2pGhIfhH+5aFq3u1VGTKN9abuefkFyq50u0AXxlepNs
 PWzRf9m42g2jpuCFztQ/oeMiv/IMYMX7MN65V3eAFKgivlag8OSa7XJASwcvNZE57ZVE
 NswThPnam5zD03MtZwMHCYRIQMXwjXTzxeROn1oLvw0Ld7tsZESitgzIT/rlapvRpEiI
 QD3WgkWp7Qg/LsanUIXdWhSgZ0BqFwxsD418FuzsvcfamM54l7A0DkTmuyy+dLD+ousZ
 j7NsXd+cuDQYtyCXop5vBhag7yGMidAL0Gg0I9LnLpRgsIB3QhgK1zjDQDlyEBw/6JKk
 V/bA==
X-Gm-Message-State: AFq9FYL9VPYQxmKSmULDrnds2MYai2UShinVOLL0GrkGqjAw1c/8Jsoi
 fYRIJW+JkDr9JtOUTCxdHv51Tss0yIkszO4hVfYveOsg/d+yQtiLxLMC0KifnSWlMHr6JbFjTBY
 h2r81lSp6n+qlyAWf+hFa/JWpY/Kw2WbKne3agAtjjHMwc3QzTPK43uZzSuYWsi0Pdw2o
X-Gm-Gg: AYBFou1QKmef4M9crWR/+Q1vCjQ0IH04lmNZ8OxyLY8A/GcSHB6j7QvVJEkT18rqrIp
 JmwkeezfJN6Yblnj4yc3Kz94Q5WxrKGkMkLXsPZl2A0eEDHTOgALJnZR1GunAfcBWdgO6xOE7lY
 yxUMM3HBa9T0FmiLSnvd1mllSDh8KnSoAearvU4xKhuhph/javJ5dlWmBUfAd9TBrpb49uPnQRH
 wfGvDHeMICnzS/hHBc5Rm94TOzHspYGSXyoYYhS/rgebLRUefLRAlS3ZdEVlQcLbXijD0FWvFhB
 7LULegHRkgd81IwaqVvInBrRVcqPwPMqq2N3F6nMQVysWH3V9shXdfu2CtJ1IYC4wrJDjo/Nixx
 Bx3D9BgEmLofeexCubkfrL3k57Sir/FXY+19lMuAVTrGWPXGPYRl7qnpPBbr19cck28Re+fKlrS
 muwh4TrqNYagLalOcrnHtyEyTY+K6Tsw==
X-Received: by 2002:a05:620a:2550:b0:93c:c538:2b23 with SMTP id
 af79cd13be357-944089895afmr517612485a.1.1793215548832; 
 Wed, 28 Oct 2026 12:25:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2550:b0:93c:c538:2b23 with SMTP id
 af79cd13be357-944089895afmr517608785a.1.1793215548313; 
 Wed, 28 Oct 2026 12:25:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm11911455e9.4.2026.10.28.12.25.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:25:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/9] target/mips: Re-introduce the R5900 CPU in system mode
Date: Wed, 28 Oct 2026 20:25:29 +0100
Message-ID: <20261028192538.31600-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FfrtCxwiahWnSeukVRNBxtwXlrdDslsd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX4Sm/4DoX6CcK
 vaLcapE1L7KdJxqSH84rVCbvpH9rPNU9b5j36OvFvPZ8i1kK0iWmLxSmWJzTVCL015EJt2A0pLN
 tzFsLHNah9fn+Ezd6n4B0CDljQcZ5F+jOzJNWpLHJop75PVpL8MwmvLVRXJ3/Igj0cWMajVHZ+Y
 YC0HG+C8oFcB5xTosEhsn7nQ7qpx9m5syrfZumZm3TB7erIll0I/RrtFEh5wkqQmRWRSiF1R2RU
 5CeL9iuCTNvcHIpqYQXi7mY6e94acknt1E0BCNEcoPc6J3V895g7DkfUCMpMfQ5I/CcLnWtM0rz
 ICt/eI8TJj51V2dsaiW8gu3MoQhDlCpRiWr8wVFutt64dWdO9fzFr5gHl66Jl1RWJficv02K/Xs
 oDEraM7myeJIi8fTfl1mbbgn2yycdAfsWfv35doIf+t7ZqLqPZdd6xwhVdDtXbFvBV1wlVrez+5
 mc2jZvhrBNRqnjDYaDg==
X-Proofpoint-GUID: FfrtCxwiahWnSeukVRNBxtwXlrdDslsd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX7X7PeregoNpT
 WktD9zlW762BSx9q2P8MuNOm91yc6deFbsl4E7qXnlE+TEBvkiMGKaIb8OmNnHL68bdfwReVk1w
 T+E6aRVvzmpdIxuWCTN2wXSp2uKRZ58=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae24c3d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ID6ng7r3AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=IRjKSA3CPs6azhI8hEEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=AkheI1RvQwOzcTXhi5f4:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Partly revert commit 823f2897bdd7 ("target/mips: Disable R5900
support"), which disabled it over ABI and emulation accuracy
concerns. Those ABI concerns only affect user mode, so keep the
CPU unavailable there. In system mode we now have enough of the
CPU (MMI instructions and bare-metal tests) to use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu-defs.c.inc | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index b2ddfa1e826a..5f6fa2900f14 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -590,6 +590,51 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS4 | INSN_VR54XX,
         .mmu_type = MMU_TYPE_R4000,
     },
+#ifndef CONFIG_USER_ONLY
+    {
+        /*
+         * The Toshiba TX System RISC TX79 Core Architecture manual
+         *
+         * https://wiki.qemu.org/File:C790.pdf
+         *
+         * describes the C790 processor that is a follow-up to the R5900.
+         * There are a few notable differences in that the R5900 FPU
+         *
+         * - is not IEEE 754-1985 compliant,
+         * - does not implement double format, and
+         * - its machine code is nonstandard.
+         */
+        .name = "R5900",
+        .CP0_PRid = 0x00002E00,
+        /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
+        .CP0_Config0 = (0x3 << 9) | (0x3 << 6) | (0x2 << CP0C0_K0),
+        .CP0_Status_rw_bitmask = 0xF4C79C1F,
+        /*
+         * The R5900 COP1 FPU implements single-precision floating-point
+         * operations but is not entirely IEEE 754-1985 compatible. In
+         * particular,
+         *
+         * - NaN (not a number) and +/- infinities are not supported;
+         * - exception mechanisms are not fully supported;
+         * - denormalized numbers are not supported;
+         * - rounding towards nearest and +/- infinities are not supported;
+         * - computed results usually differs in the least significant bit;
+         * - saturations can differ more than the least significant bit.
+         *
+         * Since only rounding towards zero is supported, the two least
+         * significant bits of FCR31 are hardwired to 01.
+         *
+         * FPU emulation is disabled here until it is implemented.
+         *
+         * Note: Config1 is only used internally, the R5900 has only Config0.
+         */
+        .CP0_Config1 = (47 << CP0C1_MMU),
+        .SEGBITS = 32,
+        .PABITS = 32,
+        .insn_flags = CPU_MIPS3 | INSN_R5900 | ASE_MMI,
+        .mmu_type = MMU_TYPE_R4000,
+    },
+#endif /* !CONFIG_USER_ONLY */
     {
         .name = "5Kc",
         .CP0_PRid = 0x00018100,
-- 
2.55.0


