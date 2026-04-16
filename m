Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F504F8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVvP-0000la-4D; Thu, 16 Apr 2026 19:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVvN-0000kw-CE
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:15:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVvL-0004OH-TI
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:15:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GIs9sW1668219
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=U/g6i4Tg9Qb
 jKTrA936ZcxkwLGNQXFsBPF7vxs0MkS8=; b=eI3gd3KRvbhWMLzER06xy8BPrpf
 7qQqczxKV6ADIVUG932tuhGBrV7+Db0EcROYf8Vcthb6EpKToi/E+14HShPMLNw7
 bkRmyBUX/3AMwsflt8ztlbJr98U51GOJMpfpK4/9gRZb5TX/YCbncNGsFHHeLTTG
 b9LsVii6tk0UotGrJTn6U01/duGIPpaoluA3JL8F6svS/WMllb03umXdb+Mj6F2A
 /dF0Ak4kZdtyAvZJYyQ+SL5eBOJu8UKFrJT3vzyUu/4+PT8f/negs36FzL+dgECR
 jgrfOMD2s8A0XKXfzBda/+1t3yor+i45ouimPbyugiEMaCuf4TjTQWgGQ/A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtd93hny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:15:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so1043065ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776381301; x=1776986101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/g6i4Tg9QbjKTrA936ZcxkwLGNQXFsBPF7vxs0MkS8=;
 b=CscRNR5lAnYUqhPEptrTUtiFQ98Oh8tKubpjqjtfPhiG7O+JmsqoTe2CzvwEJLzH8G
 Mu4g2PB0E6xL2gtGc/zW7yhEemkN47j6yQWHnXgYy2E2r6hcpUiDOI84Nbu03hcW3LNp
 hGu6xGfGbw0TjzNW6zjLoMzOwdnc5sff2WcsCmXlja1Lmm3RC5bTTITrWrOyXnILdHBV
 y+ejzr6iNHey4T9HqrcDTyIeDVsTB0a5gqKYl1BO2RBKlXzKkQxGBfTFw8RtFuJXBIyr
 RPJcnoNsiY+8G3W3VuE4FoLGSbW1oXeQ2r/7eI3x5KOGdtTxU1mwcOVxo9gNe4o2FpHJ
 zaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776381301; x=1776986101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U/g6i4Tg9QbjKTrA936ZcxkwLGNQXFsBPF7vxs0MkS8=;
 b=CRKOJdxhni/w+NT3+eH7i4Onwn8jV/oSln7NqPYl+TlHMcnSU6MivOXZqLg7Ey9p1Y
 ZScfWbOQr8Nn8vK+Be5B+ciUC+HSaaXeTBKHg8ks6L4CQ0BFPcrhTws0PU2SpCmXY/WF
 oePABvzXiSL/dsY2qyIEsWhG92YdbuxJDcfiTsZH3fI6CjQvw8n2KSfS8w9hK1I2g0Ws
 emAj5P0zZ1NSaN4FO7KdFTkPj1JXBF+CKgwESu2/PUwOgPy5CvhjhQNM3lKOz4bp9Hbm
 tDR48UYy41y4DHyxKzfYr5NGn5ZyTXb3L9OStdO3C6bPrcIG1BcsDMtp0JHDc2ezSqKa
 dWDQ==
X-Gm-Message-State: AOJu0YyXgZ3tB6eHrmqawYdkFab8c1aQ+UB6doI3d2f2+9rjUWrv5KPB
 fbFgqJmUxr2az29AxpyersnIpFu5r2McPs+15SO1hbUNlyeVISIdd/ocafPyuBIsJAJdGLSUtUA
 kI/lnFxoDRpJ0zRlYBnCVAIPaJJWf9ueWMzo9K3mcdzpq3WfGPN2DOsFukuJab3i7TQ==
X-Gm-Gg: AeBDieuXaScDRM9FOlOb7E4WPXfAEjNClfpIew5FdMIjO+9U9I56AENlX0mK8aZp2eD
 nt7yl742kgJCmgxCFKSDqbQzrtbXhW0LHV3kOHQTrODopiQMqpbtN+eO8IRP3LCyhrTBHyNpKn2
 E7sADOurLgSk/6GSQCquudB8UeWVsZrfLUROOqg0zqLjqncvXujvISXGgBarQYuE/CVzzSKQwCy
 Rj7Jv+x8mpn/11aAMuN7JSE0QRyQDzHsytinKpjJw15QOXFldCeIari8qhNndKCLc15dQg28wpj
 RdjCWfue2Re8bx+8SWcjShLTZ8QOMOIj1Fh778GGowSnhCbT/Zb2YIfeRWxlH45wSeoQ018+zpy
 WxU+HoHD6CpEUdxYTehni+LOm1Zc9N1gtbUgul2azfFJN622hFMPljxJxwA/EbBp//1VFZEdRe4
 yz7LTHotgG85IH3kcHOg==
X-Received: by 2002:a17:903:b8e:b0:2b0:b258:2a57 with SMTP id
 d9443c01a7336-2b5f9ef72bbmr2844615ad.27.1776381301061; 
 Thu, 16 Apr 2026 16:15:01 -0700 (PDT)
X-Received: by 2002:a17:903:b8e:b0:2b0:b258:2a57 with SMTP id
 d9443c01a7336-2b5f9ef72bbmr2844245ad.27.1776381300195; 
 Thu, 16 Apr 2026 16:15:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff8d6sm11615ad.1.2026.04.16.16.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 16:14:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 manos.pitsidianakis@linaro.org, Mark Burton <mburton@qti.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 2/2] MAINTAINERS: add new reviewer for Hexagon target
Date: Thu, 16 Apr 2026 16:14:54 -0700
Message-ID: <20260416231455.346504-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416231455.346504-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260416231455.346504-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIyMCBTYWx0ZWRfXyHPGIz4w8PDD
 zVGKneaYsyN3doK0MTTiz5qxAUW7Z/ml6nnIfFxK3cDTRaCg6rTQlOiEsdlUQ3Na3oMMKTsfYJK
 TA7cw68HITPcX8mlRmDovr54+pGHUT9P2dcJBKGRi+QKpZRoO9ZXqocBysaui8rjtQq/RD/rXXg
 x1HH4NacSt5xdN8SURIgmP5mexP7PQ5qTXHeAPbADrNLT75UbLfxKZVAwm5MlGxfilWDv9zKqWR
 4MZGdRMLR/F+cUlPbFuUxbYRj0rjBZy36+8zp3NYFV5vtyTJM/zw37mJoM3PwcN3aL4myd8cQ50
 es7egxabj26PR/n41FGQ25lbgGbqfJd34Q8TjLQr70axAIPeBxwzpj0mBAWpzMw88GIT9dMvJny
 BBpYri5Ckvlsg3NTVCXtmkmOu56biimThHDMdaowPoXJToMUqWIhM9inemom6k8nvxlYywJe9UV
 9PVVsNRRy8CCPZP2I3A==
X-Authority-Analysis: v=2.4 cv=avuCzyZV c=1 sm=1 tr=0 ts=69e16d76 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=nALo0oUpoisStWfNGnoA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: dg9b7ktWhubrHu0Z3o2cMXlCz-myQhLI
X-Proofpoint-ORIG-GUID: dg9b7ktWhubrHu0Z3o2cMXlCz-myQhLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160220
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14bd822ddbe..0a90204ae93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -244,6 +244,7 @@ F: tests/functional/avr/
 
 Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
 X: target/hexagon/idef-parser/
-- 
2.47.3


