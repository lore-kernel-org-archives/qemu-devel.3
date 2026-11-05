Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21595606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J5pUME3O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2H4OStV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwyH-0003PR-Ta; Thu, 05 Nov 2026 07:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwxo-0002wa-Kg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:53:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwxm-0005l9-22
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:53:07 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5B3L6s3193502
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8RQFiS3B/Xrb3cheKwttSffUdesHjxQtQjW4IYgw7+I=; b=J5pUME3O35817qWf
 66Yz02BkwUhXmNovnID82dCwrRNkZpK9RpjqQVFo+Vztx6bcBNH7vgTqr7ncXGvZ
 CJHPnMlVyTGfMs3KJNLzrZevS79G04O6LsujraIR70AfbHcbPFVA1692GEwEDHJb
 sJuOvYCz7LWQLzRzeogFSnaSjtodcy0sGPISqAFcjVpmpKPBiG+bDMybRksCYJU7
 L0RAm93iwwgs3fEC9dNbHvrNmbhlaKyHC1XDOH1SccHnhz4r5ErWMKhXWcL+coyX
 X+cRaI3D6jMm9cYHhVtTumVyrT/OXXTUSD4YpkT1F92WthL1zvQLCGcqYpZgsdtv
 7C6Nzg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdreqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:53:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-944138ed63fso330418885a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883184; x=1794487984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8RQFiS3B/Xrb3cheKwttSffUdesHjxQtQjW4IYgw7+I=;
 b=I2H4OStVczDcOj68i/zADNgdNwYU/fazNSBN4po9kKAEF/xf5Ob34zfW92j3FQUASZ
 EmEgWLRpF65Hh76E+BQ9EpJ4/ilrK41qv9C1/0tvzzecterXE2AkzkhtI1tJ33CTaugY
 TvATjvVSg2kaOJYV2/D2Wsb1Bf9hrKU19FvzXlaNcL/uDO9qBgGSaZMiAmr0c8XoyEkk
 iyY1CSPC2SneXHkL1tg1W8SEz6XQtQEKTTOY+y/8pdBAkt2HFm0n1cdACV0Ysmuf5wI4
 HsUh2k/KWM18o2GOTJyr0/8PJrdEUG4MmCu1osEF/pZX8vM5cxfZtecd1+TKEfzcVB3U
 NXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883184; x=1794487984;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8RQFiS3B/Xrb3cheKwttSffUdesHjxQtQjW4IYgw7+I=;
 b=CZJiSpgMhg0hDxyQ5r/JYMhP5yqBVYKt/yaCUAMQTJljB2NRzIWaZ2DjhoCfUPcnCD
 +YSto9iPeeXOpTZtOKYMBx7QD4CpvPlcq5bgaIOn4+S7W0Hc99J5OCS8YNayLRphJets
 E10qkyk3fLUrlx0UEN8ygVPWOr5U5mrx7ms1bqrnyQnDW9XLi1PpZhR4/vTuhU6gGU56
 oRw2AHELPy7Vu7wFUbFqIT8PR9zCZdROm//+wZA8DqXdu2ZOSPPOwnzlUUU/SbdoeX6k
 TV+QUnwk++smps+ziaH0Q86tM1i/IzXT2PooZNi1RXWxamNMDs+BneZFhKS5fRweZk+7
 poTQ==
X-Gm-Message-State: APuU4Z++MiGwUCs0ycwSFVrl/LCilBe7e6ALe55uz9f+sxI3c0MNPHUy
 KXsG/9SWcaefs0v47ENL2kn8uAlWy8MmGeu9R8G1iNlzmGrAWJ5kMLcczz5qU+Y0hzNO9y4UslV
 DQV/5g4u5eslKWPoI0ZvdWibS0oF+F35r8qLH/Z4/igJvDDb+NauzCLREfY6Ms+Cf+Q==
X-Gm-Gg: AYBFou0Ro0mDlVVWFit+BEZwIvIrEjzJcPbz2IshiMERTyYR1wkMnnOrrQ3AgsCZut7
 2r3lHK/j6RrP7ySrB+zm7Cj2lHD6/ANsUX84OfeFfNoO+efPifH5fmAEKjOeI5vIittgZ4nBrEM
 3lFmU8IRbTp7PS/Ph/VRi9fY9tvGJ2bIu84YwFvVhSxN39NJlhpN1Iy+UN/7MQhDDMdXLqcn1AH
 +Xgv+fNa+ZMjfVdVHKV/aRMJE4151nKuu8FzKAT4J8i2tAbNc31WKdYiZlQrF2fNjod944BJW7X
 oppb5dIiAvRqEFEyLlYReApnk3QkfwvnYzlg7ShfXg/HTKV9LDn9Pgt3v56sbd2BK+DkcEq7ORT
 T0elxZeLqja+iEO3jrIV6Jjz5spoVo2bQxFghfIww+2RHMzWLiHnEw+KYFr8zIAm7u0DS9Whtz8
 /s4N3+2soXJ0ZsSEU++Ulf8vfUDWm4dg==
X-Received: by 2002:a05:620a:a7dd:10b0:945:e74c:b1c5 with SMTP id
 af79cd13be357-945e74cbd3bmr107526385a.77.1793883183590; 
 Thu, 05 Nov 2026 04:53:03 -0800 (PST)
X-Received: by 2002:a05:620a:a7dd:10b0:945:e74c:b1c5 with SMTP id
 af79cd13be357-945e74cbd3bmr107524085a.77.1793883183080; 
 Thu, 05 Nov 2026 04:53:03 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b5719cd68dsm991650a12.37.2026.11.05.04.53.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:53:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v2 05/17] hw/ppc/vof: Replace deprecated sprintf() with
 snprintf()
Date: Thu,  5 Nov 2026 13:51:50 +0100
Message-ID: <20261105125203.40320-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aec7c30 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=IZgCprETnBKUNf_ylIwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: yb2Cihiye-PVSKOF9xKmELD3K_ErQvaq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX9ZbyXrX0XrnU
 cfL5eoYt1YHFK/EQ5VxkORFguB/PlwLI2sBolfOaG6dNxLUrGi1GCXJ9DSc+yqWdNZ/BF/ShFiA
 A8JvgyJWLsW5VFiAwNpdCDV6SyTzJ4U=
X-Proofpoint-GUID: yb2Cihiye-PVSKOF9xKmELD3K_ErQvaq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX/1Hr6Q5BiTvB
 8y/SVoXyCQwF6bfZ7vHjUAzxfiirS38wc9QkZYdFCIwsDScfxJKp9hV1qHfGdcgGDCbif9BvA4N
 hq2jLAHd6PmG/gSm+/eHEfZW0o3aqHE0PE2Hslx7nOahjHhS4TcmorqcovAVyS6wZcio1wVwaO6
 koKW9sbW+wCNRvfPvjXfaR/poEQpV/6qxsVpscUGhLePP1n4zpVh9pQ+X290B9Hdqw6wqq6WGPY
 h48P17RgiLkjqy3LZv+QbpGshVoOQ0bv742f1wleqgWBnorzfT6UTvMzgORi0CAghk6H0SsNd65
 5b1Yl6LGDMrMESBiXQfTJLM1rkLaR/f4yaRpf/qgbk87FaWGDljfEUwLHJRQn6egQ8U4cPiImeu
 aMjyRiIxCvy2uQiqRuiAaz9uRMDrfk/FURWFV8YwNZNXd+ci9eT2ewrOunab6zMn0kk4iq/ApAY
 Hi5Bzl/XbXLjeXCbK9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to avoid when using
Apple clang 17.0.0 on macOS ARM64:

  ../hw/ppc/vof.c:104:14: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ppc/vof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 873e967f1e4d..ef89b71f7336 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -101,7 +101,7 @@ static void prop_format(char *tval, int tlen, const void *prop, int len)
             strcat(t, " ");
             ++t;
         }
-        t += sprintf(t, "%02X", *c & 0xFF);
+        t += snprintf(t, tval + tlen - t, "%02X", *c & 0xFF);
     }
 }
 
-- 
2.55.0


