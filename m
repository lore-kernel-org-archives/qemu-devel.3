Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A2DCC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3g6-0003xN-8b; Wed, 14 Oct 2026 14:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3g2-0003wo-Ub
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3g1-000219-Bq
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbRFU3813141
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=N/fHsmRJx4f
 /bPmkNry6EqpAhS0x0CztX+FbxsbH2J4=; b=dEpCtuQu24HZvDuoY8ZBiOkh9AL
 WBGIoLxSCtp0ABq/sKzEev9m6eAUhxylGGJf2dWldhAnsVVNC5sFwcxUJmwmhoWS
 ksbMnymWaL7fg5RmSfGyq7aLwNeY5yBaB3X3uT5p7G4Kn6CuPVpl7d+TMLnJjMsS
 F1z6m+usC+nUvdECVfvBjG1cPSwZZ1mQeshG5qiNJ02u0VerZHEaccjKtAXei79R
 a+Hwm6eq5e+bs8BJoigITYB1kds9ufG0bVbUZZ/pRDy9TArpa155OowDRfY3Ac17
 POPcWf2Ptd13ozNzo4SmOvESb30sBNx2Hf0Sr+Je1N6DcVuRYvyAxFmor9g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u30jy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139b62317d0so16894883c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002367; x=1792607167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N/fHsmRJx4f/bPmkNry6EqpAhS0x0CztX+FbxsbH2J4=;
 b=cseohlVO4zf5Jn+bhoybQHq4tBoX9lhgHV/cTT5Izfp2I9Am66s71KJHaBAIIZFokI
 zaxTj9w9b+n/AvTA8yzu3MicCe7yOhSKYVcJ9UJT3ZynJUrldyxHPRqkiksZveFo0+8e
 2cpfyrq8IgW7NrsTrRdmfHC59Gy0K9qH+w1vmOJn1SAu0fCeHXc8/dr3LBHTFqqTSju6
 d3Hhq/2wEOczhohUnlT2lhh8k8tW/BmgJXVQr6Q8TW8DJxfiUU7UPId0WNAkpsLPbUX3
 Yl2oPnN3itN/h8U8PTIF8slTh+EiEmw79bLBhtwECDRl/cOZcRTG8T3MwupdabHUylSq
 s4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002367; x=1792607167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N/fHsmRJx4f/bPmkNry6EqpAhS0x0CztX+FbxsbH2J4=;
 b=d3WO40frH8bLlbIv7mHv7/PrSDxsrBNYFT78HDn3eSzRqphM55l77C6NOkAqLxD7BK
 pnXucU/RUzI3iVmEpmyETIfuAE3MoG4TWiH0y/DhBJey4yTHGG0c2lkp3R8HujnPJCAL
 yr4itLoXJY2VJEPGjIEsJ5EJGpav0ifeNMwkYiMJ0az5Fmi6wv5jduGlMMkIz4e7sTbI
 /HnPpJpPMRxGQiIa7pWJd05CmkkOqGajQBhkvRtGUh9NZsYFzuTquJrFMLGxgnj2qAWV
 pZAfRWbSqECLngsF3TMNmt6FvPACOI1AZiYRznIvNrrn+HH6c7AH3xnCaTBQWfw4PIAU
 zlNQ==
X-Gm-Message-State: AFq9FYLDs3r8X4ZBKpTn9EcnBpEEje5Q4f6V7IBB7XtK1YVOYlrMfnmE
 8oi/5Oi7y8hdB65YrX34ItTtYUHKGpnR0wizB+KRyf1zYqqLlC/pbQhu52XVwfnowywfs22sPYw
 sT/jCAALJiZDpal8NuaTV/3/vhGiNS+n+r9i0MBFTe7hojAtzFC5sa5o+8qES2MGCeg==
X-Gm-Gg: AYBFou2kaf/ZyyZ0bv+Zhc6avcjoRuqRdacod/jf1HEBTwwP72sd0yFnIJvjs9dnPvP
 u99nsFGhH4vlf54AR6despI+I297PR0Pi3jwxIpYHiYR1YXmxuJJh+4wbACqOc1Tth+lCWIsycn
 Iz7F51SP+CqdVfBT3+4KxWNLvesSak4xvBOBRGtsvrlFmvX+hOMcmTbEFSb5tAkCY5fDbtOVhWb
 hx7kd3Gj/hXPCb0YIaOjLSV7PbgfulEkSM/F784Ih9WP45bcC7LLpj8mnCMtl5Lz/0Qvwon1tRj
 VPK2SwJP+WX9pk49a3GgcUCBNJ7gwatNdFzAGRiEe7INVsu2jxqbr0esRSAwyBhqMvoM73Em1dA
 1AfvY43+b8oJugponxKxaYv16O5CkKEY8uE7B3i75E2et/NYIVN7LCUMVvdeq
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id
 a92af1059eb24-1784ab70e5cmr10710475c88.37.1792002367154; 
 Wed, 14 Oct 2026 11:26:07 -0700 (PDT)
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id
 a92af1059eb24-1784ab70e5cmr10710419c88.37.1792002366414; 
 Wed, 14 Oct 2026 11:26:06 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:26:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 11/11] meson.build: add hexagon-softmmu to multi-target
Date: Wed, 14 Oct 2026 18:25:43 +0000
Message-ID: <20261014182543.135965-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX4D7qYI55AE94
 GVTwq1zGVl+3ju2GdmwMHfTgZvz8z0LB0h8etKyIhV/2NuR1De3G6ujpZDiiADhZdQ9xgYRmdat
 3O1v3upGDP81vrBW/hfTw24o80W7haw=
X-Proofpoint-GUID: 7nttKg7Pzh4MSXi44SB_WDMH50vZph4s
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfc940 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=OcBl05HTIC1CazG9BYAA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX4KmzFSf1uynw
 3o4bynT5W6VxGnAmdPlpYYsNLNEh6B7mvoKB+XO6baGn8PIQJTBibsuQ7PfjL98wILEMCciYK1E
 hfVOQKYzsY5fteXC43YrVNiluv9bS/4L5sZLVcEFO2lUVoOteO/3ldVYxp6pnzmT9G1WFAcpQ0q
 kXPXvdqMnTMQFZX3aNOrv6dDF0N7hwcYrlvGFPXoWZ/MbHnjTvIukl0XqZd+9sCUIls6n7b8LFp
 8fvj0s29zrDHp6AniRd3Kd5y4l+ZlRhizYxfK3oOQWbE27GP+iST31BYG25jpCwdMdMVg2oe4p7
 h7qOB/brCC02f3hSbY2utjEVmbWkBVTeOcQ53+C1moJsbOOPZ4EYD4l5axf/OBV1Brqvr/Wmmh3
 hy9OoeBIWLYHm+pHBT0KwU5noSuZnJytc1fzcFr4aEFwaiiA2qfK6Ct7+pK28tB8MhgXD1NtGx4
 QiN8jsgMQdkob2gwUUg==
X-Proofpoint-ORIG-GUID: 7nttKg7Pzh4MSXi44SB_WDMH50vZph4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Now that semihosting is solved, hexagon can join the list of target
compatible with others.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 255c887e8e6..e37ed1687e9 100644
--- a/meson.build
+++ b/meson.build
@@ -4272,6 +4272,7 @@ multi_target_supported_targets = [
   'alpha-softmmu',
   'arm-softmmu',
   'avr-softmmu',
+  'hexagon-softmmu',
   'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
-- 
2.43.0


