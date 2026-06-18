Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1134CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBtb-0003DK-Sx; Thu, 18 Jun 2026 08:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBta-00038w-GP
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtZ-0000dC-1O
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAtbIJ1516173
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VqFjD9lpUx4uf7O56rUBgVhq/whI57u337FGGuEMkcM=; b=fRSBb5VFxJKJj7ft
 BpVM93/YWACbhxYeoDbJDENBiA8dZVVxuy6Y3Q7pLIGvO3NZl5WxFfU2mTFp/hT+
 WbTE86OFKZqBWXdV6xNOWmpehyJSJdUhjCYUbWSxuyGQeSDgHYwaY0WO4sg2I+no
 p7Dz9RCyETJI3nZ38lz899NgBRqLk+Uqz9Q+doUqjvL7vYV/gmjpWtSstWcUHi/G
 w9oppdvy1bYicK0s9TuFYDzlutX8eEbN3NXv8De4bLSkgRwxqSOvpQvYwLmnWpb5
 cEvjUl8PiYCbk7LIOaSkMtQQj0p9mjGnwNPzsURwwO9iMW8g0UL68CmmZ6ll6aBC
 4krguw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a3akc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157d38ab37so112934385a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785855; x=1782390655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VqFjD9lpUx4uf7O56rUBgVhq/whI57u337FGGuEMkcM=;
 b=TEQR/BRpx7bi8FhgpURyv2zDt3R039EvLFr7j8qTUk4LIUhtbigDuPhtBxsyFLNBkJ
 U3D92VFTrdpXzVtzoMawaSYCM8i/hrwgtcD2tRawhll23+KVUraCnhDYo3qvPEU+K7OK
 K0qZeO9YmJTjq0+48pZaebe6dOAzSFFunt0H1TaWdpsNiVD/An8W7/3Z+HOK6OdxxQsP
 ElJNG9NSa0cXpUOClCPGxBnffeW/3aV+GPLUQeMQfT8/Fuu/EFxJ9v54mayStgi8so0j
 UW4xquqJwYZyAiIkt1sa695RM50q7UuxOyIVeTjmPh8oOMWGeBmHLCrGNxCBoJrpDKvO
 uLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785855; x=1782390655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VqFjD9lpUx4uf7O56rUBgVhq/whI57u337FGGuEMkcM=;
 b=JzsgDMllRD6QZ8QPcohY5mRCCCUc533Cj8tm/6jyPdil5Hwj8qp97lN1xXl0BiEdbe
 XeoearOZQ07HS3uGit5tR/MsKtYW29kk3/eZBvsUg7+GqNNyQoEyVa91ai4nVqO7tonw
 unq5amDjzV0s1dPzL8bwhgEIWabxcdf0nq3i7x94E+eEdy5FIC6v4mi4Fx4RjsaLkXlg
 LKJpZjOJDDPJxLxNzQMIbfy2E8Ljv3Ec/sFPsaQZIV4MNjZK0YDPi5/OB/bxpFbahJpJ
 Oo4uL/0F4Ce67kQA1HU7Gg7jDETVCsFTHFf6EMUBzHDePTEGMF6cwaqKZW7mE/MVQqpe
 ygEg==
X-Gm-Message-State: AOJu0YzEi9XdB2/vcYBFV/go0rHuXbW70h8Rom58A+0xoIwyJ82cIhmQ
 Fp7u+Un9IYFaQXAHK3FfQXgSFqFT6Ywpwruh0P6Te19jZIq9AGXbBFv1pj+Wo0c2Vcr500zcRe+
 lhVI865qcmhSRvFtCeEFoW/pBMW1rC0EYrYyToJEWDFCiUPOYRsGMpiXXweXIy/fC5g==
X-Gm-Gg: AfdE7clW+72fckZEydv0H3/yL6aVBhbqrpevVU5KUR/O7QU0KSIrsMzJEsrKXA/7lrP
 LzPF69h/tTiDTy1JSL5Q6lGZtS5FEEgl93yVgMuc3FJs/SkJkEfnBoP2b0yfnypqV0JVqOhz4KJ
 AYwplPGEjPTQHZ9gQxGi57GloY3LjEytv1i1T9ox2PHpLOMhEfwspKmeO6DQYhVac8+qe5EVPQ1
 wk/fDMbpUdBe0QoNLEwh0ogaJTXzCeyumqCHPLm1Y+GF22rvM9qcjq4FtU3fEGmBopHzqmvt0Ke
 aw9raTHmCY2/nj3m+ZdMNji/A2BGhM2VFY4VSEletZVTkX1uW369nEAvk+Dbc1E6t1wF8tr68XN
 /AERW+0B1o6nlOoUoS2xLA9PPCSMU00DyAf9Txcy66vwXEKydsvgRBnsZxnLZ8aBRxk00
X-Received: by 2002:a05:620a:444d:b0:915:5576:df09 with SMTP id
 af79cd13be357-91d8a7f688amr1422068585a.3.1781785855398; 
 Thu, 18 Jun 2026 05:30:55 -0700 (PDT)
X-Received: by 2002:a05:620a:444d:b0:915:5576:df09 with SMTP id
 af79cd13be357-91d8a7f688amr1421648985a.3.1781785830819; 
 Thu, 18 Jun 2026 05:30:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47da9sm292476585e9.5.2026.06.18.05.30.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:30:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/48] target/i386: Report TPR accesses to HVF
Date: Thu, 18 Jun 2026 14:27:54 +0200
Message-ID: <20260618122825.90331-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a33e500 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=QmJFIuqrbizWVE_1DuYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX4dimJA21JW6U
 TGjy8pverGeO/3gHstHOtThatqGC5U4rcFYlYYoyn5f2mRJyasOuOWXanVWZQy0gVfjDYInZA8z
 5KYeS1k5NN3d4my6MYqvJwH3CE1cev0=
X-Proofpoint-GUID: YK78nE6F0g-ToNc_aWyEUQ4YMJbzENWB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX9eVLsUXOngqL
 oXfVTCW8BnFR5PCMB900qchJgcGZBpttLn33ktQpMNDGb/DjliOVfCAUdz+1WH5HScH0LRqFKdm
 LC7/dCfLOKz5MNQyKwRlL/4tAWm8svT0pDAc/fELwRuBjQQUp3QccuEdGelS7xf9ZBRT6iQjJQm
 gN4Jn4NjCNsugWKoQFAAOCSQUp/igbTEcOmMQosZ6NE+JdHElpyYtTIyvSGbxwoQcBjPsDqroK2
 32a2vm1CNOaGOAuSJ7/x+jeXMfd3k+KEVB8jWKQzk4LFcyN3cQlL6bRK5ALwRR/4bJVRpmd975m
 XpUfeb0IXH50TFALDvfM9dUeINbTz2OkwhIdtF8mDwY+uv3Hv+Sy8wvlcVNfbBXl/eb9ZrsHSWY
 NQhufgga6QjToqE3nAhGzUfD2yA68XgRU2Fu+VNzsaNcdAGBwR2FaFf/UmHQvbOG/r5jEeIgbk/
 K9mM88KDtbxnCA46ojw==
X-Proofpoint-ORIG-GUID: YK78nE6F0g-ToNc_aWyEUQ4YMJbzENWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

HVF should be able to handle task priority register accesses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250616090632.55214-1-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 30f1fa41b32..c3cba04e142 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -566,7 +566,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
     X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
 
-    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
+    if (kvm_enabled() || whpx_enabled() || nvmm_enabled() || hvf_enabled()) {
         env->tpr_access_type = access;
 
         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
-- 
2.53.0


