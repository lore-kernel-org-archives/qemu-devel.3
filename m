Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350EBCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOKS-0005vO-9l; Wed, 07 Oct 2026 05:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOG1-0000Mm-Cg
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFx-0000s9-LA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jehC3811031
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bizNiwm//bM7aNGSpzlakthsySIo6pWIBtQzUg45Kns=; b=T3m4040Kw9MVG/s0
 hp/x5RGMTUH/dXbT4hVqVXH+QRZ+PB3jXEiWo7xh19D51XQKejaVA5qbgdx59tt4
 46LtBEAd60o2KOSFnOsPN6iJC9z50605Spr6x1I1HSy3sdoXUEhA2F4O4sCpuujX
 l1oswB6huSJOvbwebiJ9TQCin1z7rxaJTlaTrUZ2UN9EAv1VgcjXBwBTF1qkf0h0
 kFbpdKpjW227o046arj+Wy6jlpBK0VQ6oKjuCbXPXnApD9qnY3fkoEojV7BkiwMg
 814QXvhfyWw9fayhSaWjfqzd3DEPvQKtcbikTeSgji98F6Z2gmguoWsb0XfTs4HO
 yKWCjA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5gvrrnet-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:48:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a082c014aso747113285a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366492; x=1791971292; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bizNiwm//bM7aNGSpzlakthsySIo6pWIBtQzUg45Kns=;
 b=WI/YPKeuGfhe4JJSEF/Yu9G2MiIIo94mXl+V9vbDEGYkwCgVqIg5No6E7U9tkAtWYK
 waJu6/PH1g4i8car5a/xl5wCJwJ7glFQBwlFMSyqAtDS76gqFNXsik6RiCz3Hn1xRQwe
 uhmcgwTiBSVzr2zlvufKJL3t4otVHZws276GXSrNlYRmfprNkmU8tCDQo940+dxYoL/g
 NouGBsYdygxrbj56T5hP19j5kKlXPrZVwzounIfe5QOcKUbaQZahELkuTvi4FaAXfh3g
 tTm3bvT5eFFivY1170AM9sYgFYiMcpx9HaUGI+icSmti1I3cwK+YYe5nrI+SVQ794sH5
 kF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366492; x=1791971292;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bizNiwm//bM7aNGSpzlakthsySIo6pWIBtQzUg45Kns=;
 b=FFM5vyUbDULsi78fxXSm08fZpFRRGGI1Ij7fhT0IonhOYWZpNsGdVEC5rHL/bpnkZe
 7tZIgKOqvbOiReJWfdDxTuvylv+uRHA1xK4PaMRn7JHi/VOcEu5bZXP6sZvp/d6enzXP
 SCzkbrCwuaC3VNFkcpuClSEUKGM5JLtF3hSJKesnGqbqB13sWmjRdZADirNfW94zmbrt
 tBTAR5NDo1Tt/WpZqeMwb2CrRKat/2xU21fLjHRQyFowt3E+pN3uPjAgO25HOGWx7DXM
 0UfcB1LKyMnecAaOwN7wcYxmbi3hMJeFi+eM7kEbWPsjJoTVdLQSYNv8R2Xrt7NWzUq8
 7wsw==
X-Gm-Message-State: AFuF++lxgdmz6e4/RwmAmCZLw1QetG8e9u0ltmrxePcltqGIxiotwSLM
 pKpqpVSvIqOoL65udi79ZwUAGbDKve1O7PmvNFiNZ5xS2/06upM06nEEX9BLNT+imE+afV03gnt
 4wl4qm73mvPsfsGoZ/gen16UXzYhXZGtO18inc00t5IiVdXbO9cKaXN8e88Ap4l80phAx
X-Gm-Gg: AYBFou0xUaBbioDfFMEuG3oXdc267I/Hh5k709Dq6sJQH2yJfHtR5OafEwqPX+q048K
 BnWkz6kY9BQmnWwktWxp6glg7QffaI0NhQceVWILg4NqfBxOyzKc83iw7ejlbEu/NXjr/yKeuhV
 5NuHuXY+8yxZqh8Sa/mpAr+JC4RlnpK5GBnCx4jBSgVo825FkCliNf7VG8iSw5lMoAkmhWHDVk/
 JRyFDWMZKW8LIvxd4l5wiHKLexFsNbvd/aPKTRmK+HGNvqXn7RIkUd/WNAPp0ziB7SCvFvnbaCf
 MqTL8xV0LrvI2Obe8BF7TVBlFs//JioVG9G0CT3dKBrq4KQZTHRQ942ySJkLlN7KjhSM+itONCg
 jhN+wDOFObiCkTfBK4qwUzjF7mwNaQmJVqU92sMNW
X-Received: by 2002:a05:620a:700c:b0:939:c7dc:8712 with SMTP id
 af79cd13be357-93e86041086mr991960085a.15.1791366491496; 
 Wed, 07 Oct 2026 02:48:11 -0700 (PDT)
X-Received: by 2002:a05:620a:700c:b0:939:c7dc:8712 with SMTP id
 af79cd13be357-93e86041086mr991956685a.15.1791366491085; 
 Wed, 07 Oct 2026 02:48:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71b786d8sm4568057f8f.0.2026.10.07.02.48.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:48:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 24/27] target/sparc: Remove well tested DEBUG_PCALL definition
Date: Wed,  7 Oct 2026 11:45:12 +0200
Message-ID: <20261007094516.75732-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W66txhWk c=1 sm=1 tr=0 ts=6ac6155c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=d8nHZlMCPPOsqsKe8PUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: sDaBorSgiwIgmbaC3YK3ljADuq-4vPBw
X-Proofpoint-GUID: sDaBorSgiwIgmbaC3YK3ljADuq-4vPBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX/laprKY5cx6U
 xT+WBuDF/JUxPBeBf8C/0bxFAfk45zGcUEIvN6C/TSklZI8V3gNF+s92q8XqeKH81vlnEtrTY0O
 rU98/bI5XV22a2I4SiYI6Vg15ebGlUkFmF2N8tqqccwEBiIzo5j0AkBv+YrLa+V65pPRKgseqw6
 Pete7fjmL9ihhasf0ObECkmA17futRt+AxXk0d0hWoG0D8us3uv3aQGsAFd/mAPaS4jKR5wXpfv
 PsM+gBS/TwZvy8o3kTTqx/elaDyOERQ+I7rj3z6PHQjQBl7/Wuckox2RStOchwmNoOK/NLMq9ZJ
 hGkiq+E6e/09J7KNTXWkLvi41mxLJApn5lNPa/t0wpnOzU6Uz6mUiU3/nlfnrLR5aE/juk+Ybp3
 h+1AjUXR37CjkLNfza8xhNX/T2bLp8UXBFXlnZG95cXnzdwAx5Fya66euCHMpQRS2OuLijCWD+m
 0kztoEmVx5KT74WWsEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX5g2s1Kk5r/IS
 nnArZIZBkWv2kzBpTUv+w7151r2IumgUHyQkwxf4ssBapriHQ//wRzx6gP7gxMw3xDSbRMEeq8G
 QkcpKz9lWmRcPZ479zncrjaAJnGNMmQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DEBUG_PCALL has been unconditionally defined for 14 years now
(see commit b884fc5ecaa "target-sparc: Make CPU_LOG_INT useful
by default"), so the #ifdef guards around the exception name
table and the CPU_LOG_INT block are always taken. Remove the
define and the now-redundant guards.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sparc/int64_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 60ab0478fc6..10341e0c282 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -26,9 +26,6 @@
 #include "trace.h"
 #include "qemu/plugin.h"
 
-#define DEBUG_PCALL
-
-#ifdef DEBUG_PCALL
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
     [TT_TMISS] = "Instruction Access MMU Miss",
@@ -62,7 +59,6 @@ static const char * const excp_names[0x80] = {
     [TT_EXTINT | 0xe] = "External Interrupt 14",
     [TT_EXTINT | 0xf] = "External Interrupt 15",
 };
-#endif
 
 #if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
@@ -138,7 +134,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     int intno = cs->exception_index;
     trap_state *tsptr;
 
-#ifdef DEBUG_PCALL
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         const char *name;
@@ -177,7 +172,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 #endif
         count++;
     }
-#endif
 #if !defined(CONFIG_USER_ONLY)
     if (env->tl >= env->maxtl) {
         cpu_abort(cs, "Trap 0x%04x while trap level (%d) >= MAXTL (%d),"
-- 
2.55.0


