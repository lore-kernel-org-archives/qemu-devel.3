Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF71606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cb0ba/zn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EoefGDRg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwp-0008Vq-U9; Fri, 23 Oct 2026 12:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwS-0008BY-BY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwQ-0002SA-9g
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vEY4063351
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QijB1C7UZUVyq/8jv1RA9tIy6oDiqJ2PPdeJ1NBZOD8=; b=Cb0ba/znXnjTlw7r
 c9yJhiGrMROOg5efDfyTOFxr/UTuaIlek301QBVryPuWSUkNjKX5Ptfuor2ieUfX
 jZhrkSecfJC56SF+VT+KweaN059hTCaCGyk88wU8+U18jzV8TCYuRYJelOr2+XKk
 7+MwPIJs7VtCgRTW0LBcJbEEt54blZaD6b16SdVJCO5HIYqInko1wigo3gLCJbYg
 z08+/D65PoylaMoThKxmMHMLV8eS/MdSCfG3uKtZ3FCH8P3CxLtCoUhJzKT2zCt5
 On3szy4CF/FcLGN4icX/Xyeg3GAIyCS3m1/RmqdUCm4cW2PM1NYZQWkmSnn9YlcS
 lR1FOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcgq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so245285785a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772184; x=1793376984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QijB1C7UZUVyq/8jv1RA9tIy6oDiqJ2PPdeJ1NBZOD8=;
 b=EoefGDRgkjtmpGplXNlmjgpjSVDRCZch9TS+1DJ1Vyn9cgwFdrMdQ+Yuej8w6dzNes
 AYojvZfcmxG+Ksl2c6MATwE6HVl0TJd1hcqYpzTWPacPYbgQqztY2jb7WsR1hGym1FcT
 ltLkZ8dFqXr8QO7axYCARSYfoajcnW4DiHhjBe/wEOVuqK/JzV9fvOH1A6o5BcNmK+Pi
 tqOECZK9cfgv9JVYk1SZcuPPireTaciiJ/ezQl3/pIlmXeJno/Qs3CVVoDxjyAIQh5M5
 8jTcQtcoMjS3fwuRfGVY1U5pa6JVu/GQFJ5EpgnUUVzUIIfOR7lNcotPOWNPSjrmtiKH
 WfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772184; x=1793376984;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QijB1C7UZUVyq/8jv1RA9tIy6oDiqJ2PPdeJ1NBZOD8=;
 b=vUrDkddkjVMUspal+UXIrzi/Oz15SUm6uZBoFNz84XHcZIyFtg02h7sm2n12FCc4jc
 gq4DEhGP2K8w8ZZ0FSvycVz8igjm+u+73/Iezfhb2hXwifj1TjSrTqgV6EXoxyl+59qH
 +HzjA+kYOLrm1LetiUM9znK9I5bEsLYqHT13jzUi98PNhf0U/XLnf5sNcjMJ5c2XWtTV
 dhtmcSRdwZu9NUCQ+txGJGeaZ8+uDmD3JnGVuHgZBXYHmqH1PRJZaUT9wxrlJZKWx279
 0wEZaDTc5EOOPEe07mpZBKzItek03+b9me2ItX/YxrrdpohjziKvvAhGfsdMFxlu4P/S
 U7Jw==
X-Gm-Message-State: AFq9FYIpR1bKUkllK1fzxa5FH7TEpyXCITu2L8fjzxI9oiHe7Xa5HGMb
 FBhq7K8CX1Oa9xfp4/U4IOfySdUTA4CXPuioC7TRXksCwf9a57pYIN/QQy8IJqcUpL+hVzrbpX6
 vN25OOwfVK/nQJK84CWIEJIwrpD5V0XfSYn6ujRCG+YK2F5iNrwSJ5bEIiqNSFJ79Cr4a
X-Gm-Gg: AYBFou0aKnXKDahBzw3YNL76f+pgYSbEvZr+k6t7x5ebYrqN/NBcWp2OjfsEmtqyNSf
 p5XcJIiAkGDsGRtYiosfkKHgVnkDKIPqRkmShueVzpCYRDtbUBlkZVY6GcvMtMQk5FxGWBt5j4R
 X6V6lS7H7Eo4QRQasMCJx5iH2/X/pZD75lJ90OOHNFIL059K+5uBaOJTmJLKxT6IV3CiL5L3ADM
 1B88ZD/ff9utir62nS69VGMAulT7bf9SuKCAAU5GpNLwvKXAiYBilAwTgArXP5V+aB5OUc/XVOj
 XKtAhrSX/92InoVbA78exXEgfUGoqkjoOVEEyTO/Nf6FvlH/br43Dl6v/rv4Pvka81eTefY4Uct
 cQpLd0iu/lj9a3zvadQNbBL6i/hp6xgQIMJyUqn3O
X-Received: by 2002:a05:620a:839b:b0:93e:9292:1b96 with SMTP id
 af79cd13be357-93f6f591f31mr480133285a.3.1792772183650; 
 Fri, 23 Oct 2026 09:16:23 -0700 (PDT)
X-Received: by 2002:a05:620a:839b:b0:93e:9292:1b96 with SMTP id
 af79cd13be357-93f6f591f31mr480128385a.3.1792772183135; 
 Fri, 23 Oct 2026 09:16:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d37c4b7sm994720f8f.2.2026.10.23.09.16.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/83] cpus: Introduce CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:31 +0200
Message-ID: <20261023161332.60153-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JVWuX7_zW_N5zPN-OpKRLtknbD9zTUHI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX/1Eg/K2nsEM9
 46HM4DQjd7NI7VJZsPAWM3DZgJDY2GEWEHZW8TbkrL7YpfeMB8HPtaqZQQAGzuOnRvtnubMigIL
 FF2tbKefNtrS1mB0VI67AsTWZMQELy4=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb8858 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VFrVLvhLpLwouTeFobcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX0oZSoXZGxCmo
 qo6Q3u9qcyeapOz4B2ZqHeJ7B6+Z/rcLTw7BZ1TbAIQgX1KQjeeSXSys75KdyosPEksbBmThC4S
 XwLu3eVC7brRhLAFG6tYScRYPs7rApfguUuMLwUF28rIyjwBY+953iyb4Y1wgmb0hgBwPw/zVVp
 IAV1phgpS0erBwbWX29PJy7pSsngSRpdusgZP5egtoWSc9Am0ZKZloUWu1iUGR5okCV9MpvDH5a
 504ZbAXge1g7pffAh0A5HDVIwDNs2wHo/1A710AL+cdR3Jpb9XVQLNh1p/aozPxZmUn0YOkj0YF
 yZTAELf6oTvxfWpc6OWN7upmiOjIg7uaNJG9NxUqmgM9SAkNsNj+1z49v1he+Uq0feRwKB6JFLC
 0hij0KPPvd4nRECku/LtiwaN1yrbqt4imIJAuYLlfus+6bnFEKwuDoVEDJNT0ncET3T+yLfSaPi
 FCtGGFscq9t1nZEQHUQ==
X-Proofpoint-ORIG-GUID: JVWuX7_zW_N5zPN-OpKRLtknbD9zTUHI
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

Have targets register a helper to resolve their exceptions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-5-philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h       | 2 ++
 accel/tcg/cpu-exec-common.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a3b4c6c08a7..5b7c330047d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -108,6 +108,7 @@ struct SemihostingCPUOps;
  * @list_cpus: list available CPU models and flags.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
+ * @exception_name: Callback for getting architecture exception name.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -178,6 +179,7 @@ struct CPUClass {
     const char * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_core_xml_file)(CPUState *cpu);
 
+    const char *(*exception_name)(int exception);
     void (*disas_set_info)(const CPUState *cpu, disassemble_info *info);
 
     const char *deprecation_note;
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index bd2cb9d6311..4e5e69649aa 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -115,6 +115,12 @@ static void log_raise_exception(const CPUState *cpu, int excp)
     if (excp >= EXCP_QEMU_INTERNAL) {
         qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
                                    excp, qemu_excp_name(excp));
+    } else {
+        const CPUClass *cc = cpu->cc;
+        const char *name = cc->exception_name ? cc->exception_name(excp)
+                                              : "unknown";
+
+        qemu_log_mask(CPU_LOG_INT, "raise exception: %d (%s)\n", excp, name);
     }
 }
 
-- 
2.55.0


