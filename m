Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803EAC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05bT-0001Vs-TT; Fri, 28 Aug 2026 19:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bJ-0000wq-Cr
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bG-0006C3-GX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMU6pF170106
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=X/HavCRScZP
 SzLLGgj7kCSUdvF+tlBG6BSRHE6v9TFU=; b=kZ6mXX1f1z6Xl7hji47REYeB1KL
 EZecWmHPavSx6NF3Tg4TmzXWkUKNKkdkaTUlmR1UyVW2J4FEfAb0r+KFEt4BbAkM
 E8D0FLEz7HMUyRs4lA+CNETW9Kqf31tEeNEFuLyX5sZEoOwC0/+FlSDF3jMHG/rI
 C3IM3/P8l+4Ibx6IDE0/3FKAap72Hkpyg5ygVchKNSkNr0otP9zoMUJYdhQshqQ9
 z/a5w8wLvKyyCi7WcTfd44IvEsCfok8kp8V4alXGbeYd/6rqM/uVXnI7HsTfZiJk
 OgQNA98yU2qTeSxawOpW6KzOyE0acTWaKoqxRTabrnPmVn5jKCAFqLG3Qow==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbhgq8crr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6fb956002so21038815ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958185; x=1788562985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X/HavCRScZPSzLLGgj7kCSUdvF+tlBG6BSRHE6v9TFU=;
 b=kHCFND/a0I1vAkYhl5w684U4WJGtuL3TgM7YMh/YvYkgqDtBT1ijw1ylm3NmGzFopt
 FPNagTF0gnP733U69zAMP1sRp1Kdd+nls8d/XQzklZII9UHB9Fef9u/s2K0x3K9pBzCj
 kv3gBbqM5FrEuz79V/kNeo+eamCYqTHhTGP2gSLePImHojXDAfOs+R70e4nMdLHIiaA/
 pidqB5JINF39m/K8jMM/FYdn6alMivm5PUJr7SajUL7lXQ9Xz4jBf2v7ftqKiSTYRrJA
 w0nhI62s/x8Bcdz2hog7Z1YFMLBFmiYgqDIMSy71qWzxQd5HBi3DQHV0OIA3Tzkkt/iV
 +p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958185; x=1788562985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X/HavCRScZPSzLLGgj7kCSUdvF+tlBG6BSRHE6v9TFU=;
 b=hpjuCi2zzK0hDgHkSJ0pRggDhYEfOboWrgfkOCVnvKJFsS6d4fTqph9PmjEq84uO4f
 ujy6ChUp8YJ2MpkIgRsmlv8Q/jvP5q/G28hFxrCMsaLwEEh3hc5nt/V6iOzf0L17YZGK
 p04TOZBNCzIUEN+WeQOm/tHoru5jOSbDjKAG2eKjxFzQ3SpEHhLROoJ5SVRbNXvPdCBY
 yXO1FHBZ/wZ4esiifAZibv5v+SO8QXLNVQKKpizT1Q3Oy9UinSlIC4fPhrdkSzq1nPCg
 +sxxsANYeQxuViBIXAZOmAEC3NaVRlIk3mEAKF1P+4ixs1xMbPI1OfD+QRNvlmCuZbVr
 JD4w==
X-Gm-Message-State: AFuF++mj49bERQTZ/ZublcJ46LZ2gcrrDnYiVcEqWceZ5ZNqtiRsZDP7
 USUSb79x2YLWwJXAz+1MK8vukOx4SUgPQO+rRM1Ttjj6ZMz9wI96BlEtAHuQtnVNpx0ExgYDN5Y
 xaafhMjL2NAvIdoHr98pYtZ6dQsgixevbHqAbzXsGlpj30An/yX0IKvnOh4pFbh9yPg==
X-Gm-Gg: AYBFou0OsKuqJfPA0e7rkyK5RwV4jdHqH/Wa7XdE9IX+zHAOwgGguWY2uZ7L0aRNQYW
 Z1LqicG3UTMSc+jt+jx2+e9bP3j8PK+tgq4TqTUVRxHgFKWE4DAUiUD3diiTAhXr/DYLn5f26So
 49Sh7CwtG/CS4Ov7/I2dNiMyOU+1na1Sr4HH8LEyk3e1h74pBTHaPq10Vpq7YRuI7NVIZ9akVv+
 F9VDUKfwnH3+26ksHWxwWlBxs7FqtKuEvva7sC3p1WJmWAZcSvT0mV2Vz4zMcJDUJnv3mDSMFfM
 /iKYpmILYn3jxEMyEzoTTm6PGEle4xR+C4LRYzGkkO0ygBVpyJ3lwD4yhLu77k1YtydmsqMwaic
 VPHxZyBUvFoEBx8HxDI7JhiOG3q3zc/RbIsX/GZ7IfT4DnnFnK/vYbrEoaqc=
X-Received: by 2002:a17:903:390f:b0:2d8:d4d3:3fbd with SMTP id
 d9443c01a7336-2d8d4d340a4mr44520835ad.17.1787958184654; 
 Fri, 28 Aug 2026 16:03:04 -0700 (PDT)
X-Received: by 2002:a17:903:390f:b0:2d8:d4d3:3fbd with SMTP id
 d9443c01a7336-2d8d4d340a4mr44520195ad.17.1787958184174; 
 Fri, 28 Aug 2026 16:03:04 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f99585csm8448569eec.21.2026.08.28.16.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 16:03:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 44/47] hw: filter arm devices
Date: Fri, 28 Aug 2026 22:58:58 +0000
Message-ID: <20260828225901.367438-45-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9KiHU7HjhpdjVEZNEoazCHEYwmrIo_4z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX8gTxjSzR9aI8
 ieHONjPbUNoRrc6+e5Z6ZTYLvzNCbxGeUpctLdSW1AMdXvplMEHK90gamPoDHjDgaIXIMXuDXdk
 GJkRWfmklmd/tcJ2rAB0OSO3WIZa2WE=
X-Proofpoint-ORIG-GUID: 9KiHU7HjhpdjVEZNEoazCHEYwmrIo_4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX3d/EpZxs39JI
 mxuRXrH/xjPWSO3Sg5xiMtQy2HcoIQAYep7ZSFqqtBKbUAkD3dTBy/cxvxKfNbEVQ6BILvN61cu
 bPmXfCZ+7StQcp3lg0b2gHBwSdN6sJoWALz+BWrD6mPZG29XkhDTuZqjWpXRmc7pOITW+Ie05KN
 WuioOGY/2KcGNwkOhPAbk/+IKH2OCzKT+wJPC/QZ57obzkea4nv4da6ogG70A1XGzUfRICOW9af
 c9a6IkSckoWz4zQhGilJJi+/QBlOtQw+5zw4OBYrXywyZSPLj5xP3QoPE0UwqUMs7EBHfo/CeFF
 hnrs04clV0nsax+v+ZtNZ7CrxyZiE6Gm+fymxlvbKPuDehuE2Pam6ni3XGAJpchzpoo+vkgY+Cp
 QZPx/yku4aC2GmIHIImqGrl59bfKckEAvnftWvGb0UsDBEafENy6AaszQ3ILID97pEJWRhSXprB
 Mh5jyJP3o0MTxhvkXyw==
X-Authority-Analysis: v=2.4 cv=CsGPtH4D c=1 sm=1 tr=0 ts=6a9213a9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=puOgDgsJGWQbpN4s_bYA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/pci-host/aspeed_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index b46eb74234b..6a9afd9403b 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -936,6 +936,7 @@ static const TypeInfo aspeed_pcie_types[] = {
         .parent = TYPE_PCIE_ROOT_PORT,
         .instance_size = sizeof(AspeedPCIERootPortState),
         .class_init = aspeed_pcie_root_port_class_init,
+        .is_available = target_base_arm,
     },
     {
         .name       = TYPE_ASPEED_PCIE_CFG,
-- 
2.43.0


