Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1B4CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGq-0002vP-M8; Fri, 16 Oct 2026 19:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGn-0002uM-UN
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGl-0001Sg-99
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNFGMf4085425
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I3uDPbm3Soa
 HOYAsvZTm24sXlL9f5JHWV6mY7P5y65M=; b=PBP+KwSzU0CtBYbl5nC43K2RlEQ
 YoikMNZ+ypZpbuyIT31iMQtONi6rGDHzsnPgwipxE7hL+e6K8rYcbdFSKQyqnE7E
 k9UskmNKuj/HUSLfPv3mIGa5DToVBlMrysdqL25kUOUU0ANJ5TVfCRml8YaCtdIU
 5SxWWeSN/V6yKCmz7L8+tTW2CfFyxSOpJ2cu4l7wpJAXwU6LgMAGpK/OywpfVJPO
 D02Ey0zV2E3UGoVwm93E0kRg86JixRDKfJFc3IQ27AkvptMjqyJj4uIpvIu7am6p
 AtrFt8wGB8bqKXacWQbjlc3SmhfiNIq8I574XiXeENW1G3Fc8CRDknedDAQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbmmq22qm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd66551e02cso498947a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792193001; x=1792797801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I3uDPbm3SoaHOYAsvZTm24sXlL9f5JHWV6mY7P5y65M=;
 b=Y2UOYXwv3OTwJR4JoJgxNaApR8VlU202QM3uJ3vAchR/uWewLdEsnd7wVLrWhvnMO1
 XdxjA6tPsH1r5ivbSIHjX99M+0pY0uRJd9D8aXz2LoZKzkzSB2IEmoS567/Rkphkq/Pt
 yaPOHrkjX0Agp382bAlQKkT6dCm3x9/HhiOqO9uSJLCY042xnqvP6rAqbjQl50B3WuVy
 rCU+ouprA40YJ6jTosh1+czpCiDvqQAgInw+MNUZrxanNTbvWuKk2rhlsdM1SJ9QSITB
 diO8luHB77CaODpQ23MMskf2kWJ/j13Sv+DHZOegvyiHR7Jx7AoadehE6XuGz5lSf6zJ
 v9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792193001; x=1792797801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I3uDPbm3SoaHOYAsvZTm24sXlL9f5JHWV6mY7P5y65M=;
 b=vl5oE99O8ghVCE0AISJ1Hny49eRL5DCk4AtIQQftBS15ubOFwmvUWurvDlDsB3HrYE
 vIErKSu+2vdi1apqcAPnmdVSFi44XAKD+NdWrVVSy/kTVtCDZ7GXYDE/zUdRMmSw9Ucs
 DPxrFzX1OXwQw2L5FgXxQxMq5dtMVzmJPlJ9jKOKZeYOc7OQifdP2R13MsuUeVCwYbfS
 2zsbp5TeFdqydzHFyeLeGSxuIu3stLZAY5e0FJ0ipwBtNIybPCtaikU1Z7vih16rK4gG
 +FlENSgfxvgwKGHcwksFg7VIbGrms/AqHHbLnBzGUH/BERCOdSF8vXaeuQpzS3Bfuv1W
 Elcw==
X-Gm-Message-State: AFq9FYKNAM+c7xs3Tmjzr+vghpJ3f7FRowDmduRBF9i3+l4t++QM9yk3
 +RHh1H3DL+O8OnNWw29Zgkn70p/ZNVNiCK+lSH+yebLoCag0YKWcTCAPXB3vouDQPDp3ub23eqH
 2Rgc6X3XZR6qJNi9MnF5IH0KqlPfm0Wlx4qdUxVd8ye/cLW+q7qYvNEK1/2Lxw7nZxQ==
X-Gm-Gg: AYBFou2mEd8n7aaR3rMLhpTkoRxmDlEqCE8ld1KwWsPWTyWUmjDujRQ6+tcXtas9Yk0
 7siHOVK0yvzGgBNk45qYAiqAt4ggDUk1NqBZzhl9JxjG7U4eujS1LsLSKXKpa5LzJbt+oYli2Nv
 UGMJ/3yrQvDcmUycVzFmwgOaoFEr/yzmRZuDkgCMhIG5xep3eA1SJQ6GjPNzWruLysSrnV9INXj
 WXdvFm0CkJYPCgr3oMsNtsy2w5HVs3y++vxu/db8MnmWl17m7YyBG85qKQ28tUmK+AuA2nnJbpk
 GDPUWBg0u1yglmw9b4ZHUcix+woxmScRTMLKIAWR0nmH4n4YNb7zQr8+O7jFxU4sIGGCklY11jX
 M3qBABHt2oStjB/Cd3ee9AqlSkJ0Wf+xJLZe+TJGEQucdqIw438/a7/lPVu8WyTo=
X-Received: by 2002:a17:90b:5112:b0:3ac:450a:f9d4 with SMTP id
 98e67ed59e1d1-3acef1544fdmr1195124a91.64.1792193001102; 
 Fri, 16 Oct 2026 16:23:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:3ac:450a:f9d4 with SMTP id
 98e67ed59e1d1-3acef1544fdmr1195112a91.64.1792193000662; 
 Fri, 16 Oct 2026 16:23:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 9/9] meson.build: list all remaining softmmu targets as
 comments
Date: Fri, 16 Oct 2026 16:23:04 -0700
Message-ID: <20261016232304.1215119-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfXwOn0GZvklRBf
 k3Yat/kQty9SOXkNXypDAQbnjMW/LeYACanigp3FER3WwT5S0tzvAsGy2vkJmNFexzuEqww9RK2
 wQCk37SeRYEZh5s/4YcHkNc1BaW6urw=
X-Authority-Analysis: v=2.4 cv=P9uvFSAu c=1 sm=1 tr=0 ts=6ad2b1ea cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=LxJxpx-wRgD8eadRecYA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX1IsYQ+jE6Tvk
 MMLNtecsuFQhsZdwrb2enp9W/rds2NdhKWT3ZHtecFt/89pi4tGVzYTAlZOwPeUO+p5v/UHfC7c
 8U+IojThCAf8GWkHjp2Z3kKUJAAf+PbXs+YNiWmIv2ObPKmihRAj17G5SyA4lDapvQyt/NsIlw1
 4M/EmdcnF5BP5zvrcNq67uMewFesFbCmRsmq4efX8nzqCTSAfWwLbSbr7VobQEbaVgz9TAw16i+
 b8aPGqLcM9+lCmPWGINpmsUWWZ6hBdM4/Ecv6FTI3KAh/HCERaC3Gb8/SiqiFmjG43aH1CuxEnB
 VXQD3EM71TPLfW3plFzTaZHd0OztqQmavVeFqdZgT6qYLsfYZtBoQENxQb6xrDer9nseXu9MEXV
 aDKYIO/zrSVZ3zXMJCYK6gR7r8STfeeB7H4SpCrz+7jVpQq8q2nMDX6NwStsztCsn8o51mUWv9R
 TnQ/k2nM37VrAHQYAjw==
X-Proofpoint-GUID: j_S0nRm7nvwPmQeTxIWcctILg0DCuXPe
X-Proofpoint-ORIG-GUID: j_S0nRm7nvwPmQeTxIWcctILg0DCuXPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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
 meson.build | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/meson.build b/meson.build
index ce3eb00f2da..a025cebc6d5 100644
--- a/meson.build
+++ b/meson.build
@@ -4276,12 +4276,29 @@ multi_target_supported_targets = [
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
2.47.3


