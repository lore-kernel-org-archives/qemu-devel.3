Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A24606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FEoq1zfU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kn1Tovjy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmmk-0001tD-BZ; Tue, 27 Oct 2026 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmi-0001ri-Fs
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmg-0001oy-OC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHXH02452106
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gyi1CjmSyqfOQi4NOBz4Y9CUxSm3oDSfj1iwqPA5Smo=; b=FEoq1zfU+qPl+vtz
 9yYKwml+yH6AyaA1zo0exm1F4wOCUH7aM2AcGU7W0UFk94C3eL77GxxzE34eJKhq
 lytTVdMk2wHd0ugoouVb6qEjcW0f+kP/LVQnFWjGM2XR04KzgRIAAr4R56wJi5Z3
 N5etFzzman7mjIRTOOPpmNEJig1Qgl72mnA4uK4GwOaAtj3o2a4SiTD5P+LZnV9d
 dI9RgH1oTjUAdzVVbIATzt54aI6rMIF5DGC36DLHtNkvw483RFHUgE7ISl6r21gL
 5l3R3c+4bfo3ykl7eHIeeiFJePI4mqAgE8V+YxcRat7dyjqI9zzvho7TJiZYQhxn
 A65WnA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g0uec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936aa34873bso19630385a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129072; x=1793733872; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gyi1CjmSyqfOQi4NOBz4Y9CUxSm3oDSfj1iwqPA5Smo=;
 b=kn1Tovjyzcd7t/lcYG6Iw9FJmtR0YM3jpBrtcIhjsg2ncUoAJGgzqyRZQGCYZ4l+lJ
 uMbfhojgACSCdfOk2NZAhGi7S1R2mW5PCne2U5Lyfo7EZGp2xufuEJQhpQW304fmZCxv
 XngfaSkvvRZltbfDt3AgDFc9wYNBV1WIBWkW+H+DlruDBHG6wYs4Bifescg7TLjGSPDN
 ZQRk5hUAEhEPXkaGcSYC5x2+1d1UmeRHcxJ0mlsEzQWpOcZLPnJknOoY16DbAzVfJNjg
 7QoVu7rgvw9a7+rQLaqfOIdPXzmwknIYazPeNx3wqmISAwi3dlJoDZeOBLDbFB+wXiyd
 0fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129072; x=1793733872;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gyi1CjmSyqfOQi4NOBz4Y9CUxSm3oDSfj1iwqPA5Smo=;
 b=RVlIlkAi6aTR6zgOQRa8tRPV97JECGNZkYj5BCfjRfX8PmItg+OfJFVt/l+1xaJPQj
 WnkME6Gor1GrBszBaPuXWGPQ+GGeHR0mfZbdq6eCu8ZSFdTlM+mCYEk7EDE1AhpI1egZ
 z9A0JW1jmFX84FmasIa3Xk+zlEquRO0GEFm19rSEhhnIHDr1YCax2gRLLtdqnJwOANMj
 SY8L2/0QvRjj2DNm6PQtD6HDUjGSsfEAwYgAZXO9xD50vo2Ia/X0SDLfr4gpaEuhsfFm
 ntmXGQh2aUOWcyCx8HL3WYvz9Bz8R2NI6oHl1KlA0yqby5Oc4hjzqNpNhhZdR2ytOtLN
 JEJA==
X-Gm-Message-State: AFq9FYKxQ0kjKTvU6UUuqPRVoiLKDiuRocD5gXUrsh5RDgaFYEq3sjzR
 kyv6k127ecuBeBEPopppH3sdqbpAg+iKGRki3RDQn9Ow6AMRCGh8XYbPLHXH6UowTrnWE//hsuX
 56na0wZGMdd8s6JE8/erWNkgrKEdWNVNvSLiMXtWFZUVpdFNqZhX9Ql4X9Sb5nVyOxg==
X-Gm-Gg: AYBFou1sLSDhRiKPC7K03JM2jYVByn4Wix5kQtXA4o386rIX8vk8zZRFAEBHoHF5qvD
 3wtGpyZYISfQ+y9qGhnjzFotz/Ev4PtSA/TXQQQ8stCFIEqJ7QD/jY/zaOfjzF7p4r3dcTJ7KLD
 Wgph3Ohqag2W1iJ98tfENWNEkYHEtgu1oGD98bUUT7hYjN58QDkJRCx8HkSKmXbOFl7Y/bEr+Lm
 gLNTdKJLKVFJsu3WJ7/J3aNdL4AyN+/FsT7hhOY5JXUz+5wW0SxzHKeuQ9XxqtsbxmoRoxYk5h+
 Nkdl5imQ53ELBUx5RHDxZw2+DGuEsLsC8Y7sV5ggKqeH33I1Uz61kP4w2o80GkHS1okZANtgo3H
 JSw9bJOJnZ3D0jOCk6M3UZ9z5Oe/M8IVa/KVpAObKmcp0/4mSDhHlkHgeaVwMgfA031OA5IIwuz
 8Ek84o2O5Nkawwa3HtaRh7ESEvic0y9A==
X-Received: by 2002:a05:620a:800e:b0:93c:6028:6d2b with SMTP id
 af79cd13be357-940ef955119mr1692635185a.43.1793129072141; 
 Tue, 27 Oct 2026 12:24:32 -0700 (PDT)
X-Received: by 2002:a05:620a:800e:b0:93c:6028:6d2b with SMTP id
 af79cd13be357-940ef955119mr1692631785a.43.1793129071602; 
 Tue, 27 Oct 2026 12:24:31 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm22771220f8f.22.2026.10.27.12.24.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/59] hw/arm/imx8mm-evk: Fix reference count of SoC object
Date: Tue, 27 Oct 2026 20:22:48 +0100
Message-ID: <20261027192341.9197-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfXx2zqSnsFeSas
 Di0uaFZe8aBtZRHGlpQCbdjBf8Z9oFRQykUMpm2zkf5X9EbnhZSAQ4s4enN8gD3jK9gJjtLWmKO
 XeQbo+dh0z7q8gTtJpDXBBpwKZBiJE9u39XO8cVDauwwGZTIrWdXNXAdj5P/W1n8RNj94sA9+Yl
 bmC0d4/rYPAh7+iS7JxVH7d39Jc7Hjzg61ij5rgYqZ/UiNCz4ZZkf2Ue4Ks6sbqqlQd+lo9jdMQ
 yCpPuzpnpmSjdUVahWGcUHlWTq0k0UnFahP1r5U4tWQmHtrd2lorHUupSA7pjY9hvKoJdr0aQQN
 j3c8qfXRfkFhNYF6rRy+VeXqep6y2lTBMlnwB587dmzck5LwQHEAN/QEmlh5W6TCBfxwjZBEkUo
 k4ZlLJYcIaENJlurrbpE3CkeN0fziSXQiHVe7lFAinK4/vIaQRPzFnsGmxH78KyGvKwA2WB6y16
 D9/lPuv5KqD81lfvx3A==
X-Proofpoint-GUID: jpIPex8oG_wdR4hLKzesbuE2yA-qzFH0
X-Proofpoint-ORIG-GUID: jpIPex8oG_wdR4hLKzesbuE2yA-qzFH0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX8Kbxku7IWLSF
 EcId+nUUljlv/u6zLYcjKnd2IB1k2xlpFzMzNlkPsXimxRpfCYOLzMhP69aVlD64oKtQoMtEZ6U
 Fs/h/lMS9xUPXBRfdFvei5dqGLBselk=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae0fa71 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=FRSEYCzRAAAA:8
 a=EUspDBNiAAAA:8 a=8zZHuzAtTnRjJmxMHO8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270077
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

From: Bernhard Beschow <shentey@gmail.com>

Using sysbus_realize_and_unref() requires object_new() rather than
object_new_with_props(), otherwise the initial reference count is
subtracted twice, i.e. ends up being one too low.

Cc: qemu-stable@nongnu.org
Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK board")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/imx8mm-evk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index c3215b11cb99..6de0d9c4a2ef 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -83,8 +83,8 @@ static void imx8mm_evk_init(MachineState *machine)
     ims->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     ims->bootinfo.modify_dtb = imx8mm_evk_modify_dtb;
 
-    s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
-                                         "soc", &error_fatal, NULL));
+    s = FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
-- 
2.55.0


