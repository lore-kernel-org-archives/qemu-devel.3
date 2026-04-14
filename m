Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEDFF9D0DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCmMk-0002hC-Fp; Tue, 14 Apr 2026 18:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wCmMi-0002go-E9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:36:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wCmMg-00083e-EP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:36:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EG4S802005518
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 22:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=DhD2EA5sTpkn7jhlR3mbE3
 DJgt8iEDS/bg6FOGWZ1/o=; b=pszg6roayf3WnlcaNcotyphyInF7Syl/BqSYW9
 HXVCUocp/BYv4q03Fngpqggvb03AaALpTY1TiDE+ENvL+0AAXfhuOnyrqoWOzR7G
 OkWnlXLWsISodETP15LX2+LLMaSEY9qJPkcSTBBNOKYUbqfOsi75nBidCkYjn7Mc
 AYYE/uLtqwUpcwRNNRSItPSvHJz3nKi6WoJ61g6zNntXVn5I1Rpx5aOP+8Xvio+z
 ocJLARFXUGsCk8en3SNb4pL6svBhTGY3rlLnffEfQfdexZYB7T9nnY1DRf7dj11W
 pJkUpDi5qFOzsdbaVOYa5kdyxFHdkOMNOpj2roERIO9gWKCg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrsjs8nt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 22:36:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2d0c1ead1so96791385ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776206171; x=1776810971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DhD2EA5sTpkn7jhlR3mbE3DJgt8iEDS/bg6FOGWZ1/o=;
 b=SwWOSeO2iT5nfreuwm9fuYYgt9355F3ZXwz57ZUAoRsE435YDVSMtRrTDxVMFtverm
 ShboSfvzJjyG4JDKH4U1zVUFE7SGG3pyeuLw2lV6XiYClyN8dur4qBRYXxfsMzslLQTG
 OfdU6BEeaHX+1uiXE30Ms4c61ra0HYata0diN96SCq4rHkwpQ+ilrbIX+eoVeOKT+6Dx
 iOPbX0pgLUq0tQgxtdpAtIH9Whlo/4cZNdOLQ6a9hSeUf8SHmdKieHDLMHW1eVuK//9z
 ICdTGyoEpKtRhL6h8NF/+axiMDBObjoSnqF5+gSQM6ulHBjieO+2eoBp9twwuv6HGbeo
 clww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776206171; x=1776810971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhD2EA5sTpkn7jhlR3mbE3DJgt8iEDS/bg6FOGWZ1/o=;
 b=E2F0FkQjulAoJvunHfELi1SYtqS2EJh6Lw+PRS8/g1dSk2MhD00Z2016J7MGM9+1MM
 ASQ41F8H31OiD9KNZqSGyXHvvkj8B8cV2QLaZTO4MSbUD4t/XiXcrsRlscTr8VzCgvPZ
 atXxAtEtqizmLOdxM0ep4I3tXz4Hr69ERUi0QuhoBJhigmdHyAnJHm2/xTCbHCcN1lGe
 dVv4Hzfyk/OyFqA/ufDxoCjp9tBeno20mbFk6m1jvywrjnMHtLoWh7GPPYPnE3b5IwNZ
 NtxK8MMt/NLN4QJTxL6Qii/eeXnMnYwkWjtbjptlJGN20LZouo9304f63u4/LxU72A3W
 Tozw==
X-Gm-Message-State: AOJu0Yy7eJ/564sq+1Qs6Ha9lfCrXLtFYMtw1VxTx7uDo/gaE/tCSVGF
 jml3t/oVqu2ctAGSofxpCkFWD2iFza3U2T8j7QAyxJZvPD6YmWvZ3BqBbihi+0FDR1M+f3dkN6Y
 NX0Z4/N4uA1GDoD6Rjv0h/KWoDSmZAPO1ges6/vjUgjoVWWCQPrdn6n3xJRB7RUtZ7e9tgLE=
X-Gm-Gg: AeBDietUeaJhYg1LAmWck6ZSg876NuK/XUjy4zt1wGGjLpL3pIM1TV6FwT1XMPyDhov
 Jkd+llzt3ydoXimqRTuY/Qo/HeFwAq6AqM66OTl7YwEh2g1/4WrfQY68/+veNGc7wM+sr6zmw8x
 OwE8jyX7gBaEmZeTe+Y+hQDnKEBM5fhHsDe40KHfhojPUkuKe7Yf05yC+ZH476sGyxX3Bv8UbOC
 DXMfVuRSKaMLYOtjSmX92+dHb4C91bSE5QmCZnCWBej0rDPGhKldLCvk9hxoBzSxkGmvTxIF/3X
 C/o/HzxWKhHvGtLl70X8W+iX63Z4aENcSMdyZrqnnkjOY+QZy/HcEmfJBPnAiitjsjF8KJmbKuI
 HJT/qh12vnyazRgVPmvDWRFQo3TF6fITcp6NpJDpBkNN2Fjga2JEX+mXKebiFKw4rhSEQv3TMKn
 mzWCo=
X-Received: by 2002:a17:903:1a8d:b0:2b0:c2d9:270a with SMTP id
 d9443c01a7336-2b2d5a8ab4fmr194762355ad.42.1776206170621; 
 Tue, 14 Apr 2026 15:36:10 -0700 (PDT)
X-Received: by 2002:a17:903:1a8d:b0:2b0:c2d9:270a with SMTP id
 d9443c01a7336-2b2d5a8ab4fmr194762115ad.42.1776206170178; 
 Tue, 14 Apr 2026 15:36:10 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b46151801dsm68901025ad.78.2026.04.14.15.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 15:36:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] MAINTAINERS: update address and add Hexagon reviewer
Date: Tue, 14 Apr 2026 15:36:01 -0700
Message-ID: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WKhPmHsR c=1 sm=1 tr=0 ts=69dec15b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Qxo9fKWVEuOnevqhwWkA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: IOZ_YlgFRqPDAPlaKPM6tEiTauKoDpbK
X-Proofpoint-GUID: IOZ_YlgFRqPDAPlaKPM6tEiTauKoDpbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIxMSBTYWx0ZWRfX1zvaStHrmNaq
 xOMWOIATDaD+fo4oFO0znUCvOp2XHwDtmGf9jCMO56Gm5cofDmg1HItZi68yegQUkDf0fPyu2cp
 lstdbKap/8kuOairg3xEQ7/WXlKvtRlvox3NVHzOmvJ1AF4UjYOvEbI3hJ2rzUK5I299OdpMeP5
 znaNbO7jq9y5Zx/mG28fahLefHDOyVWtZ7SJXvg5rQv6mZWiayUydg+qOkqNmTx40NhIt1WO0Ny
 MDX9wVpUFrHXj1B9Xd/iSL5U03Pyl+TASYDmdNcGAsOMdclF1OG3macKs8mdU1jTPOjYDEdsrFr
 YB7TV4lZCoe8+tyQrZzcH1p8+/HpJpSgGP0jsH5by4BLgns7OAnBz0SI9GKyBPU8BJpgxm/vkyS
 jE/Sm+hgdrDr2O5cOlTWY5Q8OC8oDfXr0zcQfEp7bbC7hoIfiiG5KEnpzZOc3hGFuEz7+z8Mirm
 lJD02wrwyzOFXGv7/Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140211
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

This series updates my address for areas I was reviewing and maintaining.
As well, I would like to help review Hexagon target.

For top maintainers: I'll send my updated GPG key later.

Pierrick Bouvier (2):
  MAINTAINERS: update address
  MAINTAINERS: add new reviewer for Hexagon target

 MAINTAINERS | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.47.3


