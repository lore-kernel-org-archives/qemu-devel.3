Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA0606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bTj5Dl5z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AiXFS/nC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOcN7-0006Rb-92; Wed, 04 Nov 2026 09:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcN4-0006Qc-Tq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:50 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcN3-0003hk-HM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:50 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4BoAFc1387861
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8RQFiS3B/Xrb3cheKwttSffUdesHjxQtQjW4IYgw7+I=; b=bTj5Dl5zfklk9AKb
 SwjIF1KWOguKR6B/trDpYDYZxX1pjDZci9nesPlZ+MZxZwL/jOVNyIh//BI8GxcQ
 R5ePvLJq7jJwwuVmhswUBOzmgminxLiiTCrCxGMgDeqOkgfBchvh1yD7jxG2Y4O9
 tq+hdAiNtJ+oDI2uB3oCRgyl4Lo9xtdSPucVd3uDr0KQjQrkZrtYyziujmxQ/hgt
 3Qti/rY7g1b2SvfFuZY2pEPdPuKONTF3ZWGUvEOMgYPbBbUt16fiqSCfxK7CePKP
 RGEp42AH64GZcAmyGKwGNS5sJEPJCwjouBsdZbaMG8F2F+b3Ah97bnRXUKezB6HH
 8OrOYQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsgambb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:53:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f559420f3so92564585a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793804028; x=1794408828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8RQFiS3B/Xrb3cheKwttSffUdesHjxQtQjW4IYgw7+I=;
 b=AiXFS/nCR/QfO+JY677WZ1DTmoJNVsj8VtU6sG8R5SCwGv+yWaZpDLWqBwtZXr2IOv
 zKmWnIXFA6a7lFxbmSOc54PzrXUenv78/16ERv7GQ1BtsmGgoan6UtXgQr2dhX4fYVeA
 I+qtJNb+AFHAuL69xx209eJJwS0bNyVdB1B3U0rUKb/maoDciySIMT+bWbzrNqPapBah
 mK2YpMGHHy5HKd2udOYHhhswtKR5TCPRbxaUxvvmH3gyfzELUz3riSYif6jd8zJxi/YP
 9ottxReo+CzzntCyzKE5odZGgtj0D7sazM5729kR4egoJSz6DlE1eAC0Oqm9WhKbEZGg
 7Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804028; x=1794408828;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8RQFiS3B/Xrb3cheKwttSffUdesHjxQtQjW4IYgw7+I=;
 b=DUFTiv9LMJ7pYh7E7xWFQmST5GDgYXbZd/vJm83Fvlh/UGX7Owt4jVTxgzj4qH/akj
 a9WoM1OhVtP9BMFdukK3bConrfUVpXG9zdI39l+rs67Q1otqQwcgxtNol/l3rwSG7ZcI
 keaoaqKPKD5r/VMu9/LJoZprTSyhejpcHbozLUWac6xhgB7825gnwvKnPLDsLhe2Omd3
 cAdvF48bzebRyaqBeyPEO1IdBP1h5MzoKug8omaZOJLVb/TvP3tcDqlZc4uJchdVAgsV
 4oq9eVAEtppxJFIp2HTfGwDlFTNXTfWDvVzjYWzrdXi8VuhNJxFxJ6+kvD8QlBuOd0Ag
 /vlw==
X-Gm-Message-State: APuU4Z+Fn0BqJ1XGumtFLvCRwU3N2Ff8hhUD3FgA/5U2veP47Mi446v9
 Ecz448lfWAZspdWrwz3YOJVH/t8dOEWCAcpPuJaNYk23X4rYJmk8lqve5CvPrqShwyV+6EuF21q
 LQ9uzcwUV9rx3fVyQIY54IbNIaRzNf0l8hJJ/G4qEcfiX7UB1A6cogjCkNr4FxQPs8w==
X-Gm-Gg: AYBFou0/ePJtwHSA0L5euc2KgsHomF8cLmNEUw6xWYlSVwLAq8xajk/qp+7JXBd/xGY
 fg5HKyWL7jGbinsRILFMM/Rp/63U9ixEo42+xDOU1HfRRWBH5JcrmE8ZVQ2XIVM/ehcSTDyz25A
 PTNdR+teyutI8Ff4urg5nk+Sd0iPskeEo94fOkWFLzRCgDtlzsPPV0vwrwwgOwveOV98nEvNbEF
 o6YBKXkXo0djAGdaMXbJlErUyS7E3T89PpMPR4xng7rmO9rHuLK7iRjCTjk3FXTdf0og0hJxxGO
 afKth03L6SqNuk3ldd/TFJ1CpOPJyacuZ96CS3ACRyWQ4Bi+wyMcFuQ869t3UHVShOrfKpKDzRi
 JQJWIzLB7sxWUjyWJCWi2YR0Be+QCeov1OgatfPJj19D4wFYmvm51Ic/+scecNIq+I/H7k/gHbg
 51MkoF7PFMMFk58Q==
X-Received: by 2002:a05:620a:690a:b0:93f:a63:15f8 with SMTP id
 af79cd13be357-94421541a7cmr2874489485a.8.1793804027560; 
 Wed, 04 Nov 2026 06:53:47 -0800 (PST)
X-Received: by 2002:a05:620a:690a:b0:93f:a63:15f8 with SMTP id
 af79cd13be357-94421541a7cmr2874484785a.8.1793804027055; 
 Wed, 04 Nov 2026 06:53:47 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4104d600fsm60180525e9.0.2026.11.04.06.53.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 06:53:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 4/5] hw/ppc/vof: Replace deprecated sprintf() with snprintf()
Date: Wed,  4 Nov 2026 15:53:15 +0100
Message-ID: <20261104145316.18841-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104145316.18841-1-philmd@oss.qualcomm.com>
References: <20261104145316.18841-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeb46fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IZgCprETnBKUNf_ylIwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 7YVVZHSCpFG8qztovOypbHYfPtHuPmWH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX7uzpAjoRhR4B
 ZP5tl+q/5GLjP+zVmHafqGXsBr/rl3X6+7CVDMpL4m/fT6OMEd3iD+U+mCIwrUU1YClvANHgtba
 2uaYe+DngWSZ/zxtT7dZA82lgrFiYfAiF5GUkskfFqgAxx1r0SO4hG/RVOzlQZIbqNodJGxZA5B
 syTDyc72p4ImoEEDZr/1iYsmmlmYaHb9ZwJzQ3i5HEH8TEaePCBJI1WVgg3Pq3K73Mrl7kidjEP
 QNGNBZ3Ugkc9+LmalD4AurzlQ6XA1OXq+DJ2Et5uvj6SfkPCHDHHztgOuAXTDlmURgMMTT3nc9R
 pRGdEjtr6oEqMoeGaot8JMSgqeHPd3ITkITHeJUcTnrfunbnh0u8SAUNR/Xf0aN12s4rd/oAzrI
 e4cXuCAJgy4ZhOkgSIdbIUPbGqp8z/NLxzAp1MvAFrCYbMAUuKiPXX9/W3GrnnwXjqSTYjX+2mi
 c5leemA8OOylBu3af9g==
X-Proofpoint-GUID: 7YVVZHSCpFG8qztovOypbHYfPtHuPmWH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX5BNrYjS3laF2
 LX1lCz+JOXH+Zff72V1s43qqQy33uP4pCanAlsPZJ4ZmU/G68wHxktUo8IgT5pwjqR9CFZW6NtX
 asB5z3aF1IrQW6v/nxa/E1XFPCfjxgY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040059
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


