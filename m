Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD0FC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwV9o-0008J8-KX; Tue, 18 Aug 2026 21:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9n-0008IL-5x
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9l-0008CK-Ja
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkW3j3326029
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L9WLTzAR5QQIEqa6U1cnwEpkayQKs0shsmk6gXJWIns=; b=CTm5xT6bCB28xDaR
 bdokJ3r4q6wm6Gzap9iBBdz73vDP3LAKeO6OgJOc9RsSCHWTsJhpHEGJtDlWCmnz
 ES2Vp6i1+5+00544r6V/KbbP8Ka8TwgMd7F12lwpw/oaEHvvjcp3A5K0DHYs0oxX
 XKA49359G6VMtvCQcRxO+5QZWjKP8emzOu66mrK3KSIYUUquXFDXJ2xA+ImYschW
 pRZt55DYcP8IYA4toVa/g+pe/6pLwNFrwb+qMe8wIoqGq1va3KEBT9Ysk1Df8ree
 Kn5yJfgVzR4ilV2UHWtvmp/eKeSB2920UXvDCN6hcCDw58cnobfRcXUHrPtHtP1+
 41VMLw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfprq8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb92868263so288810a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103111; x=1787707911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L9WLTzAR5QQIEqa6U1cnwEpkayQKs0shsmk6gXJWIns=;
 b=AteYwJ76kEBBKrhrqEQF8eiyoJLnNHRPrph48UjUkJ3bLnHr9SIcbv4UB3W8urN65G
 HsQpZY+Ude2jyFOT3RhQTttsiOIIoq74MqHpFNiFihK9IVjHBTISO4bpasGBhRQxsO+4
 5ZPTlose08F+BZ6yTXikOmOl3H4g7TBpsey6ybUbyQFDqVjPRxHWmtL5zKq2mBk/jvas
 NopDYpPw6pGvBfjH7whElZiKzPnejbDmhEC9OPaeSe8aB5gN/tYISyrh1hH0i0UlBmOe
 1drpErjduEVGMNPtd/TiHYQ4e84icDGJ5rBrkrYv44+/QS7qvtylZiplgzoeIvVRvoSW
 c5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103111; x=1787707911;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L9WLTzAR5QQIEqa6U1cnwEpkayQKs0shsmk6gXJWIns=;
 b=myaPoEvwry3m1gg8xwlQJAFFoS9mAPQ91zGckXymD2gxFdXObYzd0EzXcka3CiM4BI
 1ZJGQEcdMCFbnZJpV73ZJUr7YhU0uCDygp53tl2L0pBJn/TAHjcOEsixKiCPYa7Llhlx
 Y3w/mxHyBdC7/tLIeOHsxUE/g6fYN65hga1oTmqE7VGKzQZg8pd9HwEqr3G6cDqLbaiV
 8TwFlhdDarLIUNn2qiTlWil48iTe0jRi4uNM4fe13romianCFtsf3fJIWbytPrLhTual
 7CzKycDEmKdmuUTxIM/G/hBvMJLvEdMXDTU5dTOMu34RZggCr91Im1Ls8JA4rpQfqzXL
 jy5g==
X-Gm-Message-State: AOJu0Yze3mxyy0k/xAHstKWJfR1hq8ZD46PFDgmVCoJU00sP1WCix4Le
 Atw3zy0gjtZ7EmG/zXT5JpcYpyhkKUpLUz7v5O7CIY3DtEOxHT0mNahNg3QZiwQ4LS5dceh2LHw
 3ll5n0bXNYZ316mT5Ji/rctXkZ7NY+owjnncCUi+P1/L/CO1s4OkNP3Z/hAdUcomSGg==
X-Gm-Gg: AR+sD126Hox3+o5gSrdtblDeXoC9W3HSPuiaq5tdOqNUBU+mGjDxn3KiFxy+86fbAZS
 iV4eruLOK+Xky3harOYkYWYuRjC1AcDICW6NhgXld0hjD94lVuKrlHsmLrN7H+DKDL7+tI9EL1t
 EnpA8n99198Opfa0UtoKXpqBM3N7/WH6pCNdmQjpykinmgPf0dY77kLDK3rKgz1rT9I87ms+cV4
 xO5/u18FlaA8lz+drd9Jcvc7NiPFw3kumftLByQUqgk3TukivCU0LJdAeGdDrfKaSrOpNBoC0DA
 uMd8a40b/W3wwg4VCYjDESz4kQuLfS8udfbzSlZPJkvt9Y1UXDv/xm3aKyeWej9LoT4ddE8i+6j
 L6mV2rUvXAvTgg0fpA6SmeyjngxB8JzUtBngCi1COY5kvW+MQ
X-Received: by 2002:a17:90b:1dd0:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-39580f3bcffmr1978345a91.9.1787103110686; 
 Tue, 18 Aug 2026 18:31:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1dd0:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-39580f3bcffmr1978255a91.9.1787103110132; 
 Tue, 18 Aug 2026 18:31:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:31:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 02/11] tests/tcg/hexagon: check priv instructions raise SIGILL
Date: Tue, 18 Aug 2026 18:31:35 -0700
Message-Id: <20260819013144.3264096-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ZYzecFk7Iv0qawZ4qoFnGK0EBHwbKDyA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfXy475dCXfyfUE
 cSlu8HaE6eyPqUMlpK4pzbfjImmVi3aUr0lWuzesY8fvVHEmqiVexB0eHK65d9hQBeRL2emswRe
 41GVJrpiE8oNSg1QFRmZoDe7FwRHBUOiaQYy+l6nFWA2EbZPtJhA3bD+twd1geyc0i3HRtFtTAg
 sgOqbFHwRXo8DIWvOqaONLF0aYuoKBdYn1nAHRfXyu56KXpW6GpfsbM/+PyzfJUR+UC7gYhv0B9
 Q1yVJNtrHad7f4+HdzQborxeXRET1S4HXc7HFb3B2Yr3OXMb6HhEsExpLTyY61FuRttJEqU5W+9
 cOwIyK2UjEXlkfrX+UwiVf5QlzbmxHzgiBbnN58+n7OdI/n/YUyT5K8V9OqbrHLBEF7H+3FZ5b4
 RpWAQ5OTAAWjGQhOCfcU2oKvyiz5iIr0SG4b8pAEHSxChnrzg5Ewy/WgHVs06mwJdgGS3bHmmku
 DRF/AWlJSFqztdVEjQQ==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a850787 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=brjt2USROf7zqxP8TNAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: ZYzecFk7Iv0qawZ4qoFnGK0EBHwbKDyA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX91TrJPdwoRFq
 8NrvbcBqCd/Cf6eqaOaSTDw6tH9vBHGhiu2cGI/FZaQEuHmtGAKDk/LzSlcWA1my55FwJDqpwLx
 /hwY/hswzmvgcmzqMkdCgtz1Zerw044=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190009
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

QV9QUklWIGFuZCBBX0dVRVNUIGluc3RydWN0aW9ucyBleGVjdXRlZCBmcm9tIHVzZXIgbW9kZSBy
YWlzZQpIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX1NJTlNOIGFuZCBIRVhfQ0FVU0VfUFJJVl9VU0VS
X05PX0dJTlNOLCB3aGljaCBhYm9ydGVkCnFlbXUtaGV4YWdvbiB1bnRpbCB0aGUgcHJlY2VkaW5n
IHBhdGNoLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL3ByaXZpbGVnZWQtaW5zbi5jIHwgNzkgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRh
cmdldCAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vcHJpdmlsZWdlZC1pbnNuLmMKCmRpZmYgLS1n
aXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9wcml2aWxlZ2VkLWluc24uYyBiL3Rlc3RzL3RjZy9oZXhh
Z29uL3ByaXZpbGVnZWQtaW5zbi5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAw
MDAwLi4zMDZkNDU0MmVhNAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3By
aXZpbGVnZWQtaW5zbi5jCkBAIC0wLDAgKzEsNzkgQEAKKy8qCisgKiBUZXN0IHRoYXQgcHJpdmls
ZWdlZCBhbmQgZ3Vlc3QtbW9kZSBpbnN0cnVjdGlvbnMgcmFpc2UgU0lHSUxMIGluIHVzZXIgbW9k
ZS4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQv
b3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgPGFzc2VydC5oPgorI2luY2x1ZGUgPHNpZ25hbC5o
PgorI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8c3Ry
aW5nLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisKK3N0YXRpYyB2b2lkICpyZXN1bWVfcGM7CisK
K3N0YXRpYyB2b2lkIGhhbmRsZV9zaWdpbGwoaW50IHNpZywgc2lnaW5mb190ICppbmZvLCB2b2lk
ICpwdWMpCit7CisgICAgdWNvbnRleHRfdCAqdWMgPSAodWNvbnRleHRfdCAqKXB1YzsKKworICAg
IGlmIChzaWcgIT0gU0lHSUxMKSB7CisgICAgICAgIF9leGl0KEVYSVRfRkFJTFVSRSk7CisgICAg
fQorCisgICAgdWMtPnVjX21jb250ZXh0LnIwID0gU0lHSUxMOworICAgIHVjLT51Y19tY29udGV4
dC5wYyA9ICh1bnNpZ25lZCBsb25nKXJlc3VtZV9wYzsKK30KKworc3RhdGljIGludCB0ZXN0X3By
aXZfaW5zbih2b2lkKQoreworICAgIGludCBzaWc7CisKKyAgICBhc20gdm9sYXRpbGUoCisgICAg
ICAgICJyMCA9ICMwXG4iCisgICAgICAgICJyMSA9ICMjMWZcbiIKKyAgICAgICAgIm1lbXcoJVtw
Y10pID0gcjFcbiIKKyAgICAgICAgInN0b3AocjApXG4iCisgICAgICAgICIxOlxuIgorICAgICAg
ICAiJVtzaWddID0gcjBcbiIKKyAgICAgICAgOiBbc2lnXSAiPXIiKHNpZykKKyAgICAgICAgOiBb
cGNdICJyIigmcmVzdW1lX3BjKQorICAgICAgICA6ICJyMCIsICJyMSIsICJtZW1vcnkiKTsKKwor
ICAgIHJldHVybiBzaWc7Cit9CisKK3N0YXRpYyBpbnQgdGVzdF9ndWVzdF9pbnNuKHZvaWQpCit7
CisgICAgaW50IHNpZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIK
KyAgICAgICAgInIxID0gIyMxZlxuIgorICAgICAgICAibWVtdyglW3BjXSkgPSByMVxuIgorICAg
ICAgICAicjAgPSBnMFxuIgorICAgICAgICAiMTpcbiIKKyAgICAgICAgIiVbc2lnXSA9IHIwXG4i
CisgICAgICAgIDogW3NpZ10gIj1yIihzaWcpCisgICAgICAgIDogW3BjXSAiciIoJnJlc3VtZV9w
YykKKyAgICAgICAgOiAicjAiLCAicjEiLCAibWVtb3J5Iik7CisKKyAgICByZXR1cm4gc2lnOwor
fQorCitpbnQgbWFpbigpCit7CisgICAgc3RydWN0IHNpZ2FjdGlvbiBhY3Q7CisKKyAgICBtZW1z
ZXQoJmFjdCwgMCwgc2l6ZW9mKGFjdCkpOworICAgIGFjdC5zYV9zaWdhY3Rpb24gPSBoYW5kbGVf
c2lnaWxsOworICAgIGFjdC5zYV9mbGFncyA9IFNBX1NJR0lORk87CisgICAgYXNzZXJ0KHNpZ2Fj
dGlvbihTSUdJTEwsICZhY3QsIE5VTEwpID09IDApOworCisgICAgYXNzZXJ0KHRlc3RfcHJpdl9p
bnNuKCkgPT0gU0lHSUxMKTsKKyAgICBhc3NlcnQodGVzdF9ndWVzdF9pbnNuKCkgPT0gU0lHSUxM
KTsKKworICAgIHB1dHMoIlBBU1MiKTsKKyAgICByZXR1cm4gRVhJVF9TVUNDRVNTOworfQpkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0IGIvdGVzdHMvdGNnL2hl
eGFnb24vTWFrZWZpbGUudGFyZ2V0CmluZGV4IDYxYWRmNjM1NmU0Li42NDFmNmJjMTBlNyAxMDA2
NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CisrKyBiL3Rlc3RzL3Rj
Zy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldApAQCAtNTgsNiArNTgsNyBAQCBIRVhfVEVTVFMgKz0g
aW52YWxpZC1zbG90cwogSEVYX1RFU1RTICs9IHZhbGlkLXNsb3RzCiBIRVhfVEVTVFMgKz0gaW52
YWxpZC1lbmNvZGluZwogSEVYX1RFU1RTICs9IG11bHRpcGxlLXdyaXRlcworSEVYX1RFU1RTICs9
IHByaXZpbGVnZWQtaW5zbgogSEVYX1RFU1RTICs9IHVuYWxpZ25lZF9wYwogSEVYX1RFU1RTICs9
IHVuYWxpZ25lZF9kYXRhCiAKLS0gCjIuMzQuMQoK

