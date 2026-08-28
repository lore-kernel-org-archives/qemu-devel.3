Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E37C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YN-0000sP-Pl; Fri, 28 Aug 2026 19:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YG-0000h3-HL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YE-0005mn-Fn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMT88l144926
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u1OidT2h7bn
 LOpcy1ivj2IXVBHTzv6v9fwdSK8JDICc=; b=Tre/IVNbnaqgIKgndB7DQXPD2cu
 AoZEQjoW0I4IoosraIAP7d+50rT/ZmDNn23UoOAVa0oZyt3vb4QSsQ+BAFbqGOAU
 KSsWVYrgjftywR7RWJTlA4M0gubFWC/Fme3UMa4lWRHKVLyKHys8anANJja8Otvj
 Oc9WvMKXFJBp+af63awDd6nwiZXkXFTZ+J9/dDPxItuT6x1zRU4YGljhr8onJBM5
 AE8/TZIoTSwttF423fWko8+BoMjVsrAWSEtGDs6jszCFh+m1NLfR3tpEB/49ESc6
 JJgpQvZ/R7jvboJC/zg1z0szSYs2N0nu3s1vrqA63qXOZDdLKFLjtb1x2xQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh2s3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso1993897a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957986; x=1788562786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u1OidT2h7bnLOpcy1ivj2IXVBHTzv6v9fwdSK8JDICc=;
 b=IQSXBuMNaRcyKVy68Nnmf8UWNGa0QZeaURkzqI6pDqsdSPK5jdqWbC2IZK1F7LH/6V
 pz5TM7UDbpyHDow37XsxYMGRVGJl7E+0aajjLk5w5sBYjpakBovZWSxynNxCs6I1lb4f
 BkiGbGYyygh19B5v/ynGepMm0rbFU0BtZ44u3uLnsKyihZu8+213oDoHk9oBAro600a8
 Tet3XhZRoMpRKbjohu8vrOHTWdAeHRC6p+9JuN7615kKYlNfl8pTcgZVLbFO5qdtTbrz
 +djQ/jCzWSvxEuImgOEgxOqIFUJcJGYoM4zVtNTp4dUWbGSh9nP9bXEguDJVz3KFMDVW
 jfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957986; x=1788562786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u1OidT2h7bnLOpcy1ivj2IXVBHTzv6v9fwdSK8JDICc=;
 b=XJlzTHUNAbWfOjyfVz6qYIQdiWAFyaQKr6KsKygQZxmIkQnZqyk+Dq/25vgOOSrS1J
 xwwpnUaaskhel6ACFMPaXdefuEjV3RmfV+deUW8fqwX08bdkd+HxXz8bNqurbLJKli43
 8F3MkAGuxCU3LaNaXvU3a6JrUHQp7l95vPvHFiroXpdoJPQDq+i2jZCrKU6zCJXcigZY
 Vw50/+wBG386FCXp2GolqVfJqiXpyVRlchxI6J7Hnh/a2vXru/cJhnpqTJKLhN4+ps/j
 Ode1x3Wr6B31f1FPeHqFebFHKgkJj7O4AqGc72Stx28kzxP4wt+FYmIlRJmz/eBclD5O
 f4jQ==
X-Gm-Message-State: AFuF++m1HYp492pmEKnpcKQ8Fp4y2/Bv4ut6vCSiGgOgbW5Ghu2CuvKD
 2HooaX+fl9vNLjOMg2HMPQyrazTAWcoWoKPP9O2THgA3fSbe1kGvdyE9/vBULourqyLD0OTpucA
 jdKdvgqhyhlgOiNdyUWRi7OEQTyYwxGHGKMxkJ47GPYMymwYX3v6Pl8BEwgTQheuKhQ==
X-Gm-Gg: AR+sD12z4JOnem7NoDwcU8t+zcseIjL6OgWQQUv5ub7Igq70TFy7Odw+ORjT2retnik
 auGEiCThRqqiYTgrkoLQz4NAmU2Dn+s8+CqoXtLBNsYNmUL+WLhTq+yRss2oW0EnWvHqxtfSe5P
 +OaWJfZFLG/ilXy9hbt7zTOQh72ArFE3Iex9SlEWcKlSnj3ZgteHL4UGm8jLR3+lbXfZfXO67ur
 X04RzHdjkhDmlSOCyqF4xBHK9skcR/YuAfMi34PdDoInrHjNjM2vguNSUpnkX8EeyQ/3FDnLFRJ
 hWCGNR9oz7OsIyCE7rb5R7pEfFkmSyRt68QcK+Zshi8NhZVy66J4Tn1nkzz6M/kjbUDzL6cLFeW
 kjYDgiEMaSFeiG5zP7MH8ucdci1TsWSfwjKmoRge2IrhuzplCIKd+/sx4Qb8=
X-Received: by 2002:a05:6a20:7488:b0:3c3:bbe6:95de with SMTP id
 adf61e73a8af0-3d266159a17mr15865181637.6.1787957986020; 
 Fri, 28 Aug 2026 15:59:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:7488:b0:3c3:bbe6:95de with SMTP id
 adf61e73a8af0-3d266159a17mr15865139637.6.1787957985586; 
 Fri, 28 Aug 2026 15:59:45 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 30/47] hw/nitro: filter from CONFIG_NITRO
Date: Fri, 28 Aug 2026 22:58:44 +0000
Message-ID: <20260828225901.367438-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _FVq9-5HJ2X1U-Isgc5lQocgVnujj2Rq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX88gkcOu16Fff
 g7LD8ucqU723k/x4/HgSpnlvZXwqTny6dLfsuqGcaWT+vv0sdgeNm0mACU6gC7WCBtb2NR8onWb
 WIEb5S+ptp7Rv2eukvQxEl25N7xP+aFk/PnONIG1I30XJneCTJP4+x3Z+TtCMCDD9a3Zx9WcV8I
 lSt817RSVqWjY6SPqrV29yF1DJfy1tWUrzF+mrthrNEGNH8eJqR8KjRc1uG6zmsta5GsEiVqzno
 W6yR61uZxBUoHWD5xfPh9LPf8D7Lq4EFz0PkPwpkLuuXSx33R1EFNjQylp5TcgwlXB1YMTyHNyX
 o94gHTNaR66lDvi+6ouXx+PUxGlRLzS13U9jR+J/nlBdvq12UIoytb2RNK9Y/NeMJ2n0mIOuhEC
 WTNUbv9PTA4oNsjtX3TxJSHk45XMfqjjOKXga+8aODInecT5Q3ekDaROtOpCLem45w5YgVk2Wop
 7xWbSxNhLLsOINHYLXQ==
X-Proofpoint-ORIG-GUID: _FVq9-5HJ2X1U-Isgc5lQocgVnujj2Rq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX/Y+At75f9M2f
 i52X8ZJhHw7opH7Mj5yyTdnPDr2tU6KnSwL0pNE3WUetWdj5NnIgI4r2l/3sV5SJJ8kcvNlBWkd
 4eF8wyhXx/yrPgHyjVzo33k4iRBBGJc=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a9212e2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=b7Cdt_Y6EdmMR2nTegkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/nitro/heartbeat.c    | 1 +
 hw/nitro/serial-vsock.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/nitro/heartbeat.c b/hw/nitro/heartbeat.c
index dc413232667..4f18bde9a68 100644
--- a/hw/nitro/heartbeat.c
+++ b/hw/nitro/heartbeat.c
@@ -105,6 +105,7 @@ static const TypeInfo nitro_heartbeat_info = {
     .parent = TYPE_NITRO_VSOCK_DEVICE,
     .instance_size = sizeof(NitroHeartbeatState),
     .class_init = nitro_heartbeat_class_init,
+    .is_available = target_config_nitro,
 };
 
 static void nitro_heartbeat_register(void)
diff --git a/hw/nitro/serial-vsock.c b/hw/nitro/serial-vsock.c
index 1d56c338049..ead27f381a2 100644
--- a/hw/nitro/serial-vsock.c
+++ b/hw/nitro/serial-vsock.c
@@ -113,6 +113,7 @@ static const TypeInfo nitro_serial_vsock_info = {
     .parent = TYPE_NITRO_VSOCK_DEVICE,
     .instance_size = sizeof(NitroSerialVsockState),
     .class_init = nitro_serial_vsock_class_init,
+    .is_available = target_config_nitro,
 };
 
 static void nitro_serial_vsock_register(void)
-- 
2.43.0


