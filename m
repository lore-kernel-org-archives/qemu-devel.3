Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B8606EE88
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C6UyE6FR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EKjxP/Mc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx1o-0007YQ-B6; Thu, 05 Nov 2026 07:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwz4-0004Lh-Oa
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwz2-0005uX-Si
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:26 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tNCG1053253
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uTpjVBrkJpT9eIFjhhgmax1Atpbe2mKbRRRpC7Fejyo=; b=C6UyE6FRgU5DvuYZ
 hwpwtP+smF5mRlpsrIhgwl4wdIZeCB0JAEaY0U+GQLO9Qi4dEJ3qozFb45n4fCXE
 3yLiD2OEsC9IOn2ZDg5sa8MG+zTmP3v+rGUm11w0qX42rs3m4PVCZKo4QOpFFJgl
 dn+dBn1cpNl0uNTog/rsHCQ9dGmUzbf9T7at/qUJmgcd5lEKWDJ79btlKlG/9ST/
 T8iYTAaj/r2Ke11Xofn+pXmOFlaZX8m6+SoFbzqE0wnXUq+i50E5inx04wFoCB2C
 DYYYI2Mmf2jesMQF8eJwmaWwToHaeHMkljCjDH46rCFTxsHWb2dJvomcX9XeZihm
 Fx1GHw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9f8s6a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:54:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f568dee56so346377085a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883263; x=1794488063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uTpjVBrkJpT9eIFjhhgmax1Atpbe2mKbRRRpC7Fejyo=;
 b=EKjxP/McYgQkuJfceta2JdJWWt/yl/R/3oePfpQIcIwozZlo7p43k8S+gP7UmbkEAH
 8LhSH7HEJFfHMAf1A3vhynTjbFs0KoPlIvgXvzDREN3dW1PloW9L5vbLEQPE2BDXBVJG
 olBXh4KhLZW+/jejWRw4F4TwcfHl2t+83UwU9cIXHfCh1Av+dXSAIA17iJMSpU1cwchg
 2hJBqFwCP2+1jysDMgtjjO+VrmwWclltq7+0aJ9rRP0IY+3gFYNS76Zbj1EYMPayLLBX
 pXLwufncSHh9EY96XykfoUilvkL7aeSBPn8wXYzpu4bG4R4OvHqWkCMlifhsJuj0ap2+
 wcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883263; x=1794488063;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uTpjVBrkJpT9eIFjhhgmax1Atpbe2mKbRRRpC7Fejyo=;
 b=vzBi0C6k48ckZ5NZKp8g6Yb/l/vK9pcOWWWZ/4GCSzF7pcHREYKWwD1HSobkIkqEDk
 vgEwHFIoeBHVfBBUTg73z6SRy6nYyrYBdx2NWu2r2aw0mJFeK0TqYJ7vJwCuxvO3Qlx0
 UMiOdmbfMJl0be+guSth6873T4rCEyKe24+eIaeq44AI44qfo3Ke54e0PcjBaQmrCIZa
 N3PLnV94V1xP2p4n3WXoOojyQ2ExWKrrUEnvtLY5czPNAJgyDPeD4LSXZeVKN2SRz4bP
 wU7VRoT3wLLKLDgWXjbAomyDK51+923n05cwa37mo/5xEcCQvNjq824rH/5p6piABSbM
 xBLQ==
X-Gm-Message-State: APuU4Z/qQV9goiDeONHMm+NHpMhQo22wv1EDLhTEL/r8QKVDz78bYj7P
 ddXOan+Z7yNcwjoXfSBssqfKNDC5aDMr4/HiNic53EeqZEGOC6OJJ1jdW819f9SvenHsz77YSBV
 /NVSWNwLmHBjwNdMULefJStyK9nb1aSTuP/UNNRMLZrhwkqgsC6Qh4HZOcIrnJARQOw==
X-Gm-Gg: AYBFou0kv0HVjZCrRH6H1Uo1nDNY8j4U2YwyknKFJDWR7qi9jejis77/PUkG82v6pXA
 Pyvog5e7F7hi+9xV14g+uEJYjeBMIPdFOvZRfbCy3JTRi9/UnPid+cB0Z47bJRk81cxhL3pVtAd
 b+As+Zyizp96132UW4/Kwq18dY3lbbMZrnQHQm7Q6CC2f/xB9nspsa/ZBotV2bSA5ne4q18S2BA
 9i3TNNK7lINoNSekBCsJ964tt8i3xx/nZ0rxxSEIihMt5NIrYXukimpeyakMK3wpJVT+HF/0Oag
 eZy6xCsl2sc8CK34BQl050Cxv7izm1HD4AgVpXACFXZdtDeFQMMiWhk4gEcN3XZC+AEu5aOP+DE
 7Xnbf2tbtuxF87PyQPR1aK4owSMhG7Lsif9mMbxkfrLCoRUmDTRklC6z0mJscshiLOAbHXMhff+
 g+mfN4lAl4+Nlhsw8ujXlKR/dUsjIXQQ==
X-Received: by 2002:a05:620a:2989:b0:939:de48:e41f with SMTP id
 af79cd13be357-9442167723amr3380676285a.31.1793883263087; 
 Thu, 05 Nov 2026 04:54:23 -0800 (PST)
X-Received: by 2002:a05:620a:2989:b0:939:de48:e41f with SMTP id
 af79cd13be357-9442167723amr3380673085a.31.1793883262685; 
 Thu, 05 Nov 2026 04:54:22 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55abd3b67sm1819881a12.3.2026.11.05.04.54.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:54:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 14/17] target/m68k: Replace deprecated sprintf() with
 snprintf()
Date: Thu,  5 Nov 2026 13:51:59 +0100
Message-ID: <20261105125203.40320-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX/CEaz7hbM5JA
 0vYQ+1jgqnu2k5OnlApuLFnGhoGM2okHEPa3dwXTxntaZ45M5qkW8m5YpKaeZ1yjh8wWIgdLgGR
 tCOJDAzZmQaTjRERzhrIWeKnZ7qC18UZjkRgxC6+F6GNGxQQ+XOhMCcqbjfm4TJ+3XTe9HaUPk9
 2C29GvgOtuSgJdqc1OsIMI4CZzOcGB5Hfrl/XzCa9dYC3D2bJ8DKzpKhSpssQYKyCzeIJDuMSQj
 bt8zESKGiA/ufHxtlLhJrwChqAKEYA9zRZygSw0l+twgzjCPfi+RaMGvMy4BE1OsY8XFnR9OoQe
 iQiqHTLQgatUBDd2u48zvNeLPjgDohc1ziccxeX3d56nyAWvPICGZzm8NIUCP9iWOgtrIY+rX9F
 tBIny5ZyGnnZTxmUoKJC3b6WWHqFQSwZ6RquPQsr2CCpE+ym0ztt1PegXLkMBeSIGUaPYIqX8xd
 36BPj51verjBqnhQUBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX4Vdno4/UY70C
 8woP8yP3Skn/8blF1q/umvc6T65UboJZ8iEGgBwp3U+fPeLIxoa+UKEUGQZbXiB6jp4fDtmEj/v
 7ZUeE4AdeeNPQfBZxlXeRj18OwKVHFM=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aec7c7f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Fo4PYDHW-kc5XFuih_cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: NkNqaE3rFjDlAegQ5uPSc70CR7nUt6cL
X-Proofpoint-GUID: NkNqaE3rFjDlAegQ5uPSc70CR7nUt6cL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to format register
name, silencing -Wdeprecated-declarations produced by Apple
clang 17.0.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 138c89d3e531..f955aae649d3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -77,17 +77,17 @@ void m68k_tcg_init(void)
 
     p = cpu_reg_names;
     for (i = 0; i < 8; i++) {
-        sprintf(p, "D%d", i);
+        snprintf(p, 3, "D%d", i);
         cpu_dregs[i] = tcg_global_mem_new(tcg_env,
                                           offsetof(CPUM68KState, dregs[i]), p);
         p += 3;
-        sprintf(p, "A%d", i);
+        snprintf(p, 3, "A%d", i);
         cpu_aregs[i] = tcg_global_mem_new(tcg_env,
                                           offsetof(CPUM68KState, aregs[i]), p);
         p += 3;
     }
     for (i = 0; i < 4; i++) {
-        sprintf(p, "ACC%d", i);
+        snprintf(p, 5, "ACC%d", i);
         cpu_macc[i] = tcg_global_mem_new_i64(tcg_env,
                                          offsetof(CPUM68KState, macc[i]), p);
         p += 5;
-- 
2.55.0


