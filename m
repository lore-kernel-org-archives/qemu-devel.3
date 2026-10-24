Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EA606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QGlS4D33;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dnhZtmmk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV3r-0004hZ-DP; Sat, 24 Oct 2026 02:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3l-0004eo-TM
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3k-0004bI-9k
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O2q2H0982902
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=D22Y0MX/aen
 qdE45Gp6HI3RvQ9WhLbpg4zxEU+RycH8=; b=QGlS4D33zICg/YB5JefbyD4hCKP
 TDE9HUG3DIue/t6XWW+K7n/ZXhiZ00XC9D9au3jY/HJ52E7W0UumaPYodShF+mC0
 +5U7QtbEVgq9fVbDy9EqcyGGGGNpnc3njnOLw7Pk4orbHSBDUT1zWDOpr0RoNeZF
 C7vVabLVuMFfqC0n2xJapuNiJZTO3j2AvBfmBurHdTfMi20u/GbNJcMHk3ACt/Wn
 g0bigAWBEmnzrj58RRXMVNFKW9PTIYmCcQOu553rPHMstmudulsEDRsDeTaXwS4Y
 HAH7qqJkIuVFse+EAA0hnDVGyfdc6Rhud3mTVAgKuGg8G0WPv4sn2OfWkDA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xgc4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so1469418a91.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822610; x=1793427410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D22Y0MX/aenqdE45Gp6HI3RvQ9WhLbpg4zxEU+RycH8=;
 b=dnhZtmmkYal5w5J0Q/RasWFpfXhp+uNbAZogfmSoh3kCF8mTM/V0fq2ibxN4FnRr3q
 7Km7MWY/FAfLx7UdA/n3WoCITie1iQaMvNY0YFmrBBYZtaowtmd2RRc44XWJH71/NhPJ
 z/EXfFnWnEHGxV6MXSBGZFUFrfGQm2aDvIMjItbIEmgah1gQQ7M7F5ety+UN9FXkk1zO
 g2hakV0B44Sx05mUeQi78ejVlDrJrGHUYFXhpGwQEhNdNjrnMcSNAs3mPIkF6FzGmcTD
 D6mbAom94uz+Gj53vnZ9HKUA4cofFoOqEhafnpwxIE3XeugB85t63i7PAF5NxEF/4K1R
 dpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822610; x=1793427410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D22Y0MX/aenqdE45Gp6HI3RvQ9WhLbpg4zxEU+RycH8=;
 b=e5A8XNcObWsKya6V9DoXREajyDIvuRDPuJqFEL19NUcJ0HptFggAw+2hPNbPTPbRFc
 sLJRqiWHolxB4O9PYhXpkxsTOh3+HgzkIDMtjYSVC1TZbDVBbYqAi/Zx+MnDQrjDCYtJ
 AAn9UfwEFGegwNnygW7PRiBQBF7c9L8lDLyJIshSNyslPv74qZAKGgPshhBAagO/phBs
 CLMt5XzDySo0afKdNOLQhcL0653J0BRZrUJJFHgPQTNahL3Rbhlb/kNYRI/S+rbBprvO
 Sd+JiTeb0bxL/p2bY1xzNVap3OXjmWnlUeR4pGOZtnJgUrVNxue+usZD2Dim7t4dnrL6
 7yQg==
X-Gm-Message-State: AFq9FYLulZix7UfYAL48UoeAA/sqnSoTNjAf8+1RdgozFI94b2zS88+E
 RtcW+8G5WGWRlubGjGFaVghRYaJtSPw6+gFJf/p3Phqop2fya5zNbTM6jxNwRqMzON8YFK2b4bS
 bgW+ybo3bbUm0vp44utUjQ0IRkBT+XQJdvhWqIlzbnwSPwh96EQaSsAOZtpE1cQv/Og==
X-Gm-Gg: AYBFou28Dsw0jQfpOlj7Z7biWjaZf1kiaUUVqCLZdvVGIfhlPwDXiUOFfjWB/Lo6jhE
 IT1DDjIypxob0iKvdZYAkdatUAqaplfRsd8p/JuIv7HWUq5Tw/0TUAnGnQkLQCAFDjapiict52q
 Nlz1+2bqAx7vGDIWhZYamDlfmi/u29NJBENLPOZcZmzMPxNeg3+WpHFp1IaMWl/b55+5s5DGMnu
 HvpdTQblE/XaIPlBLxCQLmVZ5/J2ik3Vnx/p1wzsb6tcAb8HBJCnahvEnIq6OqAXrLlTXPIKH92
 C1FVWxbEJhOC41fM1t00dosRQQdgap+tGemla2CnIjyZrYfje5pMAjpStHbwcqGeQm/eAKy/ccB
 YhSVOoOXdm7lUWV1Kz4tfCPx7064Ek8VDY0eQj2kibCSJb00LWIpbjs8S7MYaFAQ=
X-Received: by 2002:a17:90b:3a48:b0:3a7:8350:3f7e with SMTP id
 98e67ed59e1d1-3adeafc4ba8mr1024842a91.44.1792822610466; 
 Fri, 23 Oct 2026 23:16:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3a48:b0:3a7:8350:3f7e with SMTP id
 98e67ed59e1d1-3adeafc4ba8mr1024830a91.44.1792822610010; 
 Fri, 23 Oct 2026 23:16:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 9/9] meson.build: list all remaining softmmu targets as
 comments
Date: Sat, 24 Oct 2026 06:16:15 +0000
Message-ID: <20261024061616.27381-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0SRX31-DiX927kUMN-1UjJfbJjb7M4p6
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adc4d53 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=JF9118EUAAAA:8
 a=EUspDBNiAAAA:8 a=v3hhfWmLWUsIRTxf-AQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfXyR+eo/xAQv8w
 2iLowbMNsBDJW0J02IBjvnGqM1vlG5GpCYpUueMNiOW83QW+nPRzNLOG6FYxqazy7tg2NLZX3UW
 xevckiRbnYBF2J3ner+G6Q2sPgcT768=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfXyGOZC0bW8XQq
 Opy7oOjGU7fETVM7w14+wFD/vyvLyLk376AlgZD1fTroAXRJSdkwQWNg6t6WrsiBnkuqY1enb4s
 ZRpKUEzfrdtdMbhq9+o0bYhEmfPd4+XreyA0eRwF0btsSmMKab3mmTKJSdKD+ItaXGV94EKHMt1
 d8cp/Cdjp8kPwLdAm1ipowffpPYvlUds6+o6ea06RxmVu07PM/9mxvmr24AOxzZgaS82cKu8wZE
 hqMMO+LnP21AxHu8rk4StIGa4dDJL1aTP59o4pvchB9ZdJJqVxMn0IG1dYKLy/jyrz8wzOi0/Hi
 ScbR93bFyVucZ+TBPFO2GuqNx0lWNGxbeCu57eXo5DyzMV11J+iQtNQWVIon0YKvC9OxKutt7zH
 61HyrMkGcL1byB8r8EJ+ntElmc95nrwoGXk1cE8vN2Hi6D96F/SwWewdFRrlBzlu/SSwKHPWkv8
 7VnJZAxkMoo7HC7Bm+Q==
X-Proofpoint-ORIG-GUID: 0SRX31-DiX927kUMN-1UjJfbJjb7M4p6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240024
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/meson.build b/meson.build
index 24f60321d35..f0e91f7943f 100644
--- a/meson.build
+++ b/meson.build
@@ -4268,12 +4268,29 @@ multi_target_supported_targets = [
   'avr-softmmu',
   'hexagon-softmmu',
   'hppa-softmmu',
+  # 'i386-softmmu',
+  # 'loongarch64-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
+  # 'mips-softmmu',
+  # 'mips64-softmmu',
+  # 'mips64el-softmmu',
+  # 'mipsel-softmmu',
   'or1k-softmmu',
+  # 'ppc-softmmu',
+  # 'ppc64-softmmu',
+  # 'riscv32-softmmu',
   'riscv64-softmmu',
   'rx-softmmu',
+  # 's390x-softmmu',
+  # 'sh4-softmmu',
+  # 'sh4eb-softmmu',
+  # 'sparc-softmmu',
+  # 'sparc64-softmmu',
   'tricore-softmmu',
+  # 'x86_64-softmmu',
+  # 'xtensa-softmmu',
+  # 'xtensaeb-softmmu',
 ]
 
 emulators = {}
-- 
2.43.0


