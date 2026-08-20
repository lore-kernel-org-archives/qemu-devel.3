Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D12C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx9Ay-0007JM-2M; Thu, 20 Aug 2026 16:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9Aq-00075c-61
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9Ao-0002jn-H9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7Y393491355
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=; b=E0GZc+gJszC2ZA8t
 6i1yAjDOHPQf7Ezv3GJdsqJsIpwjx1eLyZjONKxIWDfvmPa8lCHMJ65a7K5q0Hlx
 SGgKyPhWMuiFKJNTYcLus/xvHFDmrEBnHt1Lj3c4alc0zmIkMIDWXQaGT12rShCb
 oX54p2EXW2hGMX0FGPXzXoEpNCMsI+8r5l47FV5y1j/OC09SCy9chTfcjx8mFHPv
 7juvCV6MJkN8aFq1CPQSbCyd0J4T227Pd2o3ucY1EU72SALpDcigTXqPXGiRgZ6a
 ynEEfOhfinuJRntmXKCUS4YB6n6LwO4MoE3k72RbXHmCXoiOVpGm4JL+SmQhYQp3
 ZyYrzw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytcaqjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:15:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so3979771cf.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256926; x=1787861726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=;
 b=DfVB1eRTJNuR1k1pb4YFnQ9ptJmVvqRjnhmF72uA7XWjJ3KkAwq7gBe560krTKkR+F
 FMxCLp25+dJYKYEcO7HpWG+6fZ+r6oSzudW43d/9mfBdv430cLfMBuumTQUqpO8bfoL/
 3MdU1nP1naARtJ47Yd5dTIYEXxPOroO0M6XYMGWFE7Easifjh0zpZ7MOgeKTItOQMWZg
 D1YV+3A2Y8KSN8AHu7er20R86+QJwzKlOBDW9XcqwQDnHTZc+X/RP6lcRLxK74vDQ9h2
 rHV5OV/5+tL/fwagbYapIk4/pkdfZZfDO58bsqFWUhS7bWOywEkdV3BmEENE2O/AS0wO
 xXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256926; x=1787861726;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=;
 b=jtgDdpHCqnpQpMkH3tY2bqHcirz2JETP/MZyCr6POgk8l61YVKa4Ab5oYBD/p97aCn
 y8aMQIyxDtzNQsw3BsDg6epKvx6C2qM9x+WU4Q43ZW4+M668oGGdCq489JsvX0mE+3AX
 lnxSEQHm6R053P5ReUS4EQ8TAOoM9qga9GpPAYg80sz5GnM1wlvG/7hoQCLrjel6h8KH
 89129/v0Pevc05q8/JcoRsOzFyf06lBULKj0whjkONf7QAwoxneT+lghKzoEXOsV+Bx5
 KTarAYS9OJZn5IawlBKQA3okIsAqXhptLpCVe4Z5XiWZx7pQTXvQth5q9kRjRfJTQ/CC
 dZ5w==
X-Gm-Message-State: AOJu0YwoVNCafpKfut49O7nRBV7PJ6O5MJugxLJI34ciL7k5uEtu5jYL
 OliLSjomOIvNom5JIV8UAJaBJ8SdHm9FlVYOQrGPNUTWrZCcJPCpb/31qGPpvo0s8vWHVrXyGwk
 nAxGwbpvaJFqyesn7JSF7lgkJwiHgmt4TtmaVDFe/wO0exXe32UOSgulYWD7PYQBug9N/
X-Gm-Gg: AR+sD13ZWx9NMRJjNJB6MWPs00uJQgy3um3xm1Yt9WRYo5W6cxLn09EWrIZi7S8nyJP
 SBWQq2Ofi+XN6AbmTnVy+WSTNubI4cRzU2KLmj3KaaubVWj9au0d7PwePIvXWGhLOgESpWbRq8A
 mTwMmJbZnkOp9Rt70kMrcHtiBYjCc2IcW/4vNillqZ9EqkFYBOt77lEZggjCyOoMyh4RQJlFwib
 tXS2GN3nDK7yZ5IMiU+LxBX+nzcPwCK+JiuoaoI9wSXJlZSn1eKoYMh0oPH8vEvnbil2ioDexVT
 XL9DdfoYO5P91y7ppgRliKG2+gMH1H2BsudWTzvGjM/bsgcSKbuxThaQcsWTZwIQYU821H9ZKtD
 6J7pTiF+2u32l+Q9iF0Rpx8DQHWgJZnyjJO5JuxrfEw==
X-Received: by 2002:a05:622a:118d:b0:52d:9a3f:85bc with SMTP id
 d75a77b69052e-52df571351dmr9555511cf.18.1787256926022; 
 Thu, 20 Aug 2026 13:15:26 -0700 (PDT)
X-Received: by 2002:a05:622a:118d:b0:52d:9a3f:85bc with SMTP id
 d75a77b69052e-52df571351dmr9554451cf.18.1787256925371; 
 Thu, 20 Aug 2026 13:15:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm3822715e9.5.2026.08.20.13.15.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:15:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 11/15] target/sparc: Constify CPUSPARCState for various
 cpu_*() getters
Date: Thu, 20 Aug 2026 22:13:51 +0200
Message-ID: <20260820201356.29775-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a87605f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX6Jrxxu+dPX2f
 lBpPW6fyKDs6hxCZ7swpapt7gwP4f6exrMuQECBMf4BwqST58ecJd2R7o338a6HEPWnO9qfNhUR
 w4s6tVK2Jpgy2Wz5s9hMmwoOfm1ONp9m4ti91sd9MXFeCvZ2p5/jN4dE96V8TLM61XqR0BsvghA
 42x2jEtDkgMug5uQfifq/JghISB5evrgVFZDIBVrid6V08/442fPOrvxg0kzHdFVRrj77srqTS5
 0cVFp52dQ/j6epExRWt89eeiSZDIv1pCbr7eJkig2MeNEmiRRaif3xfVKy8fjNbtY93JzB1kfLJ
 Y0+Flh3cOiKM1IaELMHSGPkEUlG5n54s/2U+L9kxEK2YeDBbstf5o7N44MqUV5zxl6Jrqp1+2hN
 JxqXhg7DNfDrStox3AzSkwMcs6LiHMIr+8fZlfY8PS+QCrL/D9rL/6hIJix+YPLCLwdxUro57h+
 aFRp3njUphes+q2+mDw==
X-Proofpoint-ORIG-GUID: d21YfhI-QdWZiExWqvFY7JDIKyPSdvnT
X-Proofpoint-GUID: d21YfhI-QdWZiExWqvFY7JDIKyPSdvnT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfXxIefDw0CX1sq
 Vd/4wvJVVgiPwEe8CM2iXOawD+Lk50v/XAdlj2JTWL/pRLo8FsF061aivskj0KxKaVrGWmPSr9Z
 BdRDi9Q0s1ZWWlnicH78cOBIyd3C+b0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200152
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

Add the const qualifier to CPUSPARCState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/sparc/cpu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5f583ed9de2..31a16c2af03 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -680,28 +680,28 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 #endif
 
 #if defined (TARGET_SPARC64)
-static inline int cpu_has_hypervisor(CPUSPARCState *env1)
+static inline int cpu_has_hypervisor(const CPUSPARCState *env1)
 {
     return env1->def.features & CPU_FEATURE_HYPV;
 }
 
-static inline int cpu_hypervisor_mode(CPUSPARCState *env1)
+static inline int cpu_hypervisor_mode(const CPUSPARCState *env1)
 {
     return cpu_has_hypervisor(env1) && (env1->hpstate & HS_PRIV);
 }
 
-static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+static inline int cpu_supervisor_mode(const CPUSPARCState *env1)
 {
     return env1->pstate & PS_PRIV;
 }
 #else
-static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+static inline int cpu_supervisor_mode(const CPUSPARCState *env1)
 {
     return env1->psrs;
 }
 #endif
 
-static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
+static inline int cpu_interrupts_enabled(const CPUSPARCState *env1)
 {
 #if !defined (TARGET_SPARC64)
     if (env1->psret != 0)
@@ -715,7 +715,7 @@ static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
     return 0;
 }
 
-static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
+static inline int cpu_pil_allowed(const CPUSPARCState *env1, int pil)
 {
 #if !defined(TARGET_SPARC64)
     /* level 15 is non-maskable on sparc v8 */
-- 
2.53.0


