Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DC606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KzkJw1ST;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEM68oyF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0jC-0001gG-I6; Thu, 22 Oct 2026 17:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jA-0001Zf-6a
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0j7-0007eR-Hn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtT4N387594
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TIrHjwRx7aFTh4Fmlm7bI6abtTfpPAWA3k9VZSR0uhM=; b=KzkJw1STni+f25Ep
 V7droeiRS7nH7c8YPuUUa8GvdzpXceS1ZugCDGpOVZs3MCSGef0OAuTUOYIWq45N
 4Yd4No7Co95CH1ihxtDiA6ktZyWHm5fHroisk76GoThVlWjcYatGHP6d4FwWAhvi
 yU450j7lBkZADFvs2gjXGnwApUpzXFg4aK4FmSiSAqMGx4hTHQ2wHXhrEDcII2jU
 L8NitAZBxTNdbdPTW3mYZsWztbroAurgur6X9jLj5F05zBwhv1+zoJfufh79BBLT
 lsD6nhRULMLF8NuN0G5//OfNzqCLSWPb65ZVJK4yB8rgx5JFdsUm7f6H56QftS4h
 ib/VLg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4qxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f26dd2165so79786385a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706012; x=1793310812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TIrHjwRx7aFTh4Fmlm7bI6abtTfpPAWA3k9VZSR0uhM=;
 b=iEM68oyFGUMq/ARSo9FpLrH93XwFar1fcpIKaCONTIRhqu5hQPplpTIJaDFfIc9NPm
 W5WbcjzRyMpztr0rOgGdvKiIU8Z686OP0xamfKLdA0geUUuqBvRO55uSPmjkUX5aLytH
 PeIGbnLIPw3bJ6w50z2fJwwHzEZ9IkhMdogpxSoKMZZclZpcUgEPKfWcVoJXMKMYZrFL
 3SeeHuqG0BDp28DO6xz184qPDdY/83rrp2qNd3rO49pNntxOdL6m9+qwPYx/rC7er8Uo
 yfekh/v8tfP41Broj9SjNXXtIf5viyhW/m0QLT+vJSjub/OPOvHk90z2umYIA992Rvgc
 Sb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706012; x=1793310812;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TIrHjwRx7aFTh4Fmlm7bI6abtTfpPAWA3k9VZSR0uhM=;
 b=Lpuy8Lk4rZ6qU2opfJt0KlyzsAdD56gEVwLgI7PsO43lbjokgNFOA9LUAMEfP1MDGm
 YEuBuUqrlTEsIE0dcOw6isDExzR2of8d8aP86d+lOE/rSooXSFYkCmnuGK1muSkh60vE
 OoSeoxKM11WGZHAFXfdsyd6QpsTWbSuULAmzE2IcjDZ132Io2njF9Pnoojoo6CoYpniA
 VkY1F2iech+2DEWG5zLW3mus5LkKz7Zm7e+o7O30k+DfYOIQJ4FLguji+eoxYEEKEQ4c
 orJksCcr2Wk0CiNCFGIuvQt44LehLosRHkTUCmTyv22FbvgOwcDMuDim/aJyc57Hwu/F
 VdeQ==
X-Gm-Message-State: AFq9FYKVJdXxYqHlUD67kmlCM2N8jt4r5Ed3mk8JAIqyRU7d4z0mEVFj
 R7O7tpRW6+MDl7cBbTmyeiXGeOfZ9Xlny7089vYqnT43VfcrIV9HFr/rnGheoksCeLdarc3OO65
 VIqN5dVUKQc8BJ2cTL/1xfHnQtPRLmBif17fKE7hFUCY+DcKJLeMuax7e2SFYN4mHeg==
X-Gm-Gg: AYBFou0AutH1KfNqBcgcC88zXRsWNiDRzLmBbeUN6qwYSyeoagoHnXZ8kcFENMyCzPE
 EOG8ebGkWP7NmJQyogjLDGmakOfwtJqRlHgWK8QN9yMdkbvs3C0ewXQcEEp3GQnSFUsWYTX+RU4
 ABKZmWADuM+HO0QPz42ZisikzxWKfGyVqptAgzRU+SmOQSPwJpzmVZr4DWjvh5XiHo7yhHCpFbY
 fCCEeaQ6/VIU0Y8G8KQc2yeuK3qesvdRxTOWIDDk7IXVo9SgnTr/fvnvVYDUxIHZeRkoApa6+2B
 zGVxZdtmRr2Ps4w6v7BzsNSVIfDsP3P/DqA1N3Wdou+rIme+QXnonqSqeg76Rk2/UMxwTm36FJH
 VcuyJmQzoVwY/Lz4WX7D9L9e68KactnXJ30kamJa/
X-Received: by 2002:a05:620a:261a:b0:93f:e53:a56f with SMTP id
 af79cd13be357-93f6fa1f37dmr124583585a.80.1792706011812; 
 Thu, 22 Oct 2026 14:53:31 -0700 (PDT)
X-Received: by 2002:a05:620a:261a:b0:93f:e53:a56f with SMTP id
 af79cd13be357-93f6fa1f37dmr124581885a.80.1792706011416; 
 Thu, 22 Oct 2026 14:53:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38053b8asm622809f8f.42.2026.10.22.14.53.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v3 18/33] target/mips: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:50:58 +0200
Message-ID: <20261022215115.19680-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9UhDlUnN-9ywrkZdUomRPpCUXlpYlOIK
X-Proofpoint-ORIG-GUID: 9UhDlUnN-9ywrkZdUomRPpCUXlpYlOIK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzKCe9uQQFvEr
 7kNmb0auGILQsMPgS0tTEx+Jmu60QRNIyXzUVENmWBY6mJvPHQOkwnozjd9IM8i9oolSc1ohmlU
 pS9nupU8PlL1Lq5CBbAMlLMrxsVA2ko=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada85dc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IWzrOf9u_v1LvXMeo9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX7sQeDAuLtfXz
 giUO/FMsmzuNSvQsEdgvhU1/8SLokmTR9FSVJ2AQkteyRHZ8+ZM9A0hCl8FmrgDBMqPMs/uAHLc
 xynH8Dzkphb63eNdnBtEJFLWMpxPK8OIKbyzV+/war6rz60sHiQI8afgeYVTFqYOC02kw9A+BZo
 Va0ArQqPMF/Yj+E0MMGRbL8vnV1YpxddgFmCo0Tz0BP8vV+wv8nMG/non2p3BUYj5XqYP/zQ12M
 JHWeIHlzQ7vHVdoeKFxODw1FpGcE2tmZQfoZmjQhHkQ2jithaCbfCXfUkkT/Riz1sozY4crVzy9
 HTcY7aOwd/f4BAGAnQpgwAGVS/to0zVlmZF12t9fFz0DoXkKj2ZmrzqPxCGeMCvXAWqjca0P1vE
 GE6qg4Cfzdtow2lgcltiC+xFQ1G37rPVMrvdMoB7ZZkk/mEhGSEO7DV/unQlY/agzumNikFyXuY
 4rhDYKMvwDAVgqPSPew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

Register mips_exception_name() as the CPUClass::exception_name()
handler, so the common exception logging can resolve MIPS exception
codes to names. Return "unknown" for missing array entries.

With '-d int', codes without an entry in excp_names[] are now
logged as "unknown" instead of passing NULL to "%s".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/mips/cpu.h              | 2 ++
 target/mips/tcg/tcg-internal.h | 2 --
 target/mips/cpu.c              | 1 +
 target/mips/tcg/exception.c    | 8 +++-----
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 5d8b78a70b8..b080c5de4de 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1349,6 +1349,8 @@ enum {
     EXCP_SEMIHOST,
 };
 
+const char *mips_exception_name(int excp);
+
 /*
  * This is an internally generated WAKE request line.
  * It is driven by the CPU itself. Raised when the MT
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 950e6afc3f2..9f230e757d6 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -27,8 +27,6 @@ void mips_restore_state_to_opc(CPUState *cs,
                                const TranslationBlock *tb,
                                const uint64_t *data);
 
-const char *mips_exception_name(int32_t exception);
-
 G_NORETURN void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
                                        int error_code, uintptr_t pc);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0fead20d651..528d926d16c 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -742,6 +742,7 @@ static void mips_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
+    cc->exception_name = mips_exception_name;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 2f02f9be877..823866ee600 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
@@ -129,12 +130,9 @@ static const char * const excp_names[] = {
     [EXCP_SEMIHOST] = "Semihosting",
 };
 
-const char *mips_exception_name(int32_t exception)
+const char *mips_exception_name(int excp)
 {
-    if (exception < 0 || exception >= ARRAY_SIZE(excp_names)) {
-        return "unknown";
-    }
-    return excp_names[exception];
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
 }
 
 void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
-- 
2.55.0


