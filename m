Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B6D606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bPMhAzKB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dp0d88XJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI00-00084B-6a; Fri, 23 Oct 2026 12:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzY-0007Sk-AB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzW-0002g4-NJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG2uk73733893
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FJH8SjTQ9r2KQNDV3qUcOIq83looHvvZ+ni/ZdkuOwU=; b=bPMhAzKB1zFn+JzN
 k67bUPqb1LtSd3uqnjz8fJ7RgCQCedebw1UeiLNupuRGTvkCE1JevraehdTbtCTk
 bI4KroOEUhXFwZsad4lYq8LUwUwl8leCwwLGqGgyuJVlY35oVAKVWTxdbcKP2Wrw
 8BIdJV9dl9S+2k1dKWDG6e7Eh25M49rq6j+Dzk9LBmv9YIcEQ/S2oN5/j66Swwk+
 zuwcMa3vScyJSgdoQJY0Ye8fmdwG1i7Dwl1e2IGBLzjY/YGpM4EhwZvXTp4D/hKM
 6rFQpMBMzRk0BnW+AIVQEjYCvHL8ifCUdYBrrlx/euqY6Chxu8HyOpOGPWNGV3jJ
 WDL3/A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarug2fa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f3969a2a7so177763885a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772377; x=1793377177; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FJH8SjTQ9r2KQNDV3qUcOIq83looHvvZ+ni/ZdkuOwU=;
 b=dp0d88XJxgto1oaSmZn2231vWYrC0U/0bUsKV/7lzNy8auEVSUSBS2+p00VDrKC2V3
 W5NAK1fTs0RjkdTm1ZCpvwCriNtURbkccPr1iEyng8Xkrqvu69jjtv+KWslYnXxSSvAQ
 uDeUwfEbwE7tY9rbiTem+idQ6Yp9gX0e0hipJgdQbJcgxb76TxcTSpHMlVbN3I74DHXk
 n4SFghza459an2nWDl5j8JjFBIWWpU8FW/958c7BEVIAdIGGMm+S3eE7PTnaoEb2FX4I
 6JZDYnAI+VCajDUTJ2tlKp06rhGjy71CUgLc8YZ+4hNz0uM/qxzA763u+7FxyJm87wA0
 W8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772377; x=1793377177;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FJH8SjTQ9r2KQNDV3qUcOIq83looHvvZ+ni/ZdkuOwU=;
 b=1QUSrHB+XXFNssxn9FhPajkFukoDLzdpBS6TGJ0/Yf7vVtqBnX6GHLBsuo5GwqI31u
 c0eT0UCftPYqSogLkU0RgiVz57SHUWpsCVtCVezbiQXUvpdNICTRymasnPf0jDwNTDZb
 WQKjGW08OTXMstAbcnnYYAfRMsNUnp/aji+4L2EwWzpjfwaYjaSPxEVwhuXEexeBYD+f
 J/jgDdJih1bTZfAPhEPr8aIurrm3aE34QUjMSpy+GFMgKiGdsv0+bxwlakSLXrr9E97E
 iEz1ryc6Y5OrDDrWRs4L5/3owNMBL8QbuOIbVXysu9QTp8mzqlxBihW1JdbcTVKBBdHb
 QkGw==
X-Gm-Message-State: AFq9FYKdYdgtAyPnxU9KHxMLl0D4YNi6lkfllByuYyqZUeC/vJiA1Lr7
 tDT1b5HZb/x4pnW8h7iYkZP5iHTB2cj2yW2N77Wr5+71vyoaKjYT9PmK+5ueFh5o+ZkRggyB72X
 kwK2hUJQm6CUpzQUCS9tVYs3AcaBHVSqFCsyEwRhUqRi1OILgSF1denESu0G3gMVI72eu
X-Gm-Gg: AYBFou27raB6Lf2nmEjCg/jBVSjzvU48Ua9v5l+H9yZCm/2o7HlYXcek8SBt1obXA3O
 pJntB0q5jVzsFPWavXwzhAH9KJvtIhjH64trXEvG51WDwvLpb+eKcICNwpW6sfW3V/u0goSEM2b
 Y+7HINep6sTWwRpOtPU1opW2w8XaUALbbZiunTPhEyUazQ/aCb7FkJHUKN5qqBAbRhM3cVugtZr
 vMjFmCizl3GyDT0QL2SNWAchw8mpdQ3C1aaKtpWune4JWllhnb8EN7rJcTZ1QapGZ/Tfm0nwBGl
 sS0Z5Ynk1NS+PlSV4IqeaZq+FuurYZxnmXEag/9q8SIDZZSdjWqmiXWHOleZ8CTppNhye4HSF6a
 peKG2+UQYlKGrwqNYXceHGANAIohJHiBiCutT5yzN
X-Received: by 2002:a05:620a:4445:b0:93e:c12c:43f9 with SMTP id
 af79cd13be357-93f6f871ee4mr490110585a.70.1792772376896; 
 Fri, 23 Oct 2026 09:19:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4445:b0:93e:c12c:43f9 with SMTP id
 af79cd13be357-93f6f871ee4mr490103885a.70.1792772376139; 
 Fri, 23 Oct 2026 09:19:36 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a318ca7647sm5725675e9.4.2026.10.23.09.19.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:19:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/83] target/sparc: Remove always-defined DEBUG_PCALL
Date: Fri, 23 Oct 2026 18:12:58 +0200
Message-ID: <20261023161332.60153-51-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX5CjRUjTrnpiX
 B11Zoxzo0BrZ5e/sFmOVemsk8v/iLT1DtqOMiBVUh16R3qVx1sR2ckDhW6kVckTHPiXzMNNvpu5
 Xa3myPY2s6bURNeZ4M53eip/UrCb7LY=
X-Proofpoint-GUID: W5alXgwpt7no0W3FVB-ZZ32zE0DDuo7O
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adb8919 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=d8nHZlMCPPOsqsKe8PUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: W5alXgwpt7no0W3FVB-ZZ32zE0DDuo7O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX18/C5QQ+oG0h
 bjCWa9EMV5cTYBMNnJdjRq3fwy3B6NM9ZuQkXPfTY/65X1/ItBIBweCv84dEi+8mD+b+FsT1Cpd
 k9AU79cahsQ4bBCb0RXzG5BcREq8zlz0lWUm9KLR31BDqiJ5EUkpyyIh/K0HtgCeDnCWexQst/E
 s+KrMf+aTSQFHDsWMhrHdPdrMc9dRgZUgVbB/iu1RY/ETrs4uI+vQTVJPqsfNqrpQursBqtYaxv
 padfo3R0ERRdLYtWC3LqKjrS2kXOGPdy+KFOapyNfv5v+fyN3RrvpG6GNCtJBAHCRV5rMqxn7LE
 L9XuHmdck/Cx9ovWbk0wv2mNC4L7Lnf4faq+KpU1iYQTzbEsL7jPowfhQQV0fdsvaBB8g8Oki6C
 YP8lwzAXUMaIPHfhhElyLWCJMNnbHz7ct4AN2hwyujDu03LBqfOlsjAvtIdq2vgGKLbAoftMzvY
 jfguugEWusNIthwb3PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
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

DEBUG_PCALL has been unconditionally defined for 14 years now
(see commit b884fc5ecaa "target-sparc: Make CPU_LOG_INT useful
by default"), so the #ifdef guards around the exception name
table and the CPU_LOG_INT block are always taken. Remove the
define and the now-redundant guards.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-32-philmd@oss.qualcomm.com>
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


