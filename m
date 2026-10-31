Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5817606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ns6zmN0N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CzJi2kUN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxwf-0006aQ-3h; Fri, 30 Oct 2026 21:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxwC-0005Tg-Ll
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxwA-00038d-D4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1C8uK758719
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dc8bJANto9UT23NCIiqmYENecx/Hqzi7yDRb04bFCA0=; b=Ns6zmN0NslMwdj6C
 b/w6R+zRXYc0MfKRa+ZGV5YEvdtAhkgTQJA9LAbNwJ3E1M8vBGX6l3lTbc4OQb4e
 14IyZudqcL+Skfdte+jtivY4Fo5abviMh9SrrvJtjeO3ozpMfTC+H9rVxRgQI7sT
 WlTUQ6qubbqwZF+HN1ICZ/Givh6frxUNt5IGj3Qh5O+yvC7H8KFO5swt4mydxlHY
 LxlZ14y6iUbJHMKzlCu1RQWPzrnjzLsMm8HMt9QJfvwQ/yYDMCeiqeSAPPJaQVAw
 fbPCwfKCtHTw/um4od6nv+v4ZqhqjzcWCvdDruWjLoLzcdJGUFNqUOkwdacmeqCu
 hHkE2Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkg4d1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so2461755eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410262; x=1794015062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dc8bJANto9UT23NCIiqmYENecx/Hqzi7yDRb04bFCA0=;
 b=CzJi2kUN+ExeOukJcPQL6Tm+duFykeFJ8l2RiwvnAgMgSYl/rjSwZAWMgsWXsQW49+
 K2moV80ku596FThrfuaDKJdW/FwQ1zwbWiOWcCHlKXqKhWp4eJ1X7bZ6SLdZjSuesU+s
 iPSfIi1yCK3Ftmjt+FWvd+EXwuhwTNmEn4Cvw7zT57APRyDhwDiEmY5PSbDHS77rq7nb
 TELWM7FAihgPLwzQn/V/2ZkS0iWI5IGaaLsuhcIE2dgrxIMrvauu858TYlk51kiR8KOT
 sCYwg+nM/w/1qD102Kfr04jWjAbxiIyVRgIWdN4wyI3uW5PhuKeEpgWdLyMssVqLM0Ob
 563w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410262; x=1794015062;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dc8bJANto9UT23NCIiqmYENecx/Hqzi7yDRb04bFCA0=;
 b=TKNosGCr0NRnV2DZSC55I+YoqopUwAa+1cQXmXCA1d/Up/fyUgxedwknCMHH0a59+Q
 ePOf9ij8RvrLJWwg+dQj5mKA9mksFaUt4n/UEu3vb4KbMVkOkL8SrJhH+PAIo+U+Eaxq
 wIxvTCUlT7+Gma0Q9W55LKkZU30Kj8Sr1qscnXsIXfORdRo+kyTocoJtQDLBMY+k3DTf
 ZhgqXjYqYHW3vI96nDNPzTFmqHyNiw4YtVtHdXIdu/C6DABBkmRIus6LsMbjHpi3pRnS
 /jLkkhH4zMGwx/Qr4kLVRD745vCFGQwum5qr0MFnNUtEM47XuJnJ8feBMOjyCw30gWgg
 Fguw==
X-Gm-Message-State: AFq9FYKTbmfC4QYhps3u5CZmhx5PtIiYEyjRYSG0Rwxy6YvF5DtuGYw/
 7L8w+DKEYtTEfl6Z1ASk23OjgMew6S77dIOMuB6PPG6ic1K0sQTUTqzUlSzTkzpPsSpsru1iRb1
 xtzc2wTP/SRLuLUQKbklwp2aM7j5q1QNjl83lrbZdYkcz1BhFE0LvX8aaCXuRqWzF3A==
X-Gm-Gg: AYBFou3v61Fr+w5j7EaW8dG+cFJbKsFRgD37Zqn+DEKX1ij+CceCTdl1znKjAYll8tE
 ln3eVBk628i+taASBvlQDf9D9Mn7ipmsyuuJW8xOp7mN4JqfheKgcZepxNaA/4VUUEEk97WTIgA
 BQdZ3KwctirfHS06ibK7JRara/ZWEZ0eDR+a9L2V67BtNt9klMm37mp76MFDSD5Uj4Dai8IDwD0
 QGUHIhtmhYcNno7HeVib1ht4hlldAzu6kTaaYQvRM9+NxIzTe7IPh1CnU204Gcm0R/5FYdr4nGQ
 Ta64I8g0PDEAiLiKMK6xsTSJ7C57dGU2n5FsZJxKfgyydAA5RoscEhj70CPV+R6X2MaUwqoyTqk
 xFOrH+lXfIerRAmS0Ah2gehWraFHi7EPKXgm4qjAvHJqoubQqbpBMAFrGEcBre0RTM5FQbW09/c
 UU9Yec+txBcirjijy1Fovunw==
X-Received: by 2002:a05:693c:65d3:b0:36a:a10:ab95 with SMTP id
 5a478bee46e88-36a423cd4admr6153366eec.29.1793410262267; 
 Fri, 30 Oct 2026 18:31:02 -0700 (PDT)
X-Received: by 2002:a05:693c:65d3:b0:36a:a10:ab95 with SMTP id
 5a478bee46e88-36a423cd4admr6153332eec.29.1793410261732; 
 Fri, 30 Oct 2026 18:31:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:31:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 34/40] hw/hexagon: add the HMX context device
Date: Fri, 30 Oct 2026 18:29:35 -0700
Message-Id: <20261031012941.339141-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: cSB6UTDsHl0oU8HrvkK4MALtvNE_nv8l
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae544d7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GkCZVEeUe3Q-cCnmmhAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX/jmFr4mfKPAA
 SbP5xoAfBUF1LygeONucOZwyuRzKGlKG2aZHixT0oe5Ot70cW95cHRs2sv5silFALplzrcTozKp
 i/0ZJ3YHJX92clf97KAQFAa36yIQfoc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX3SYgqQO7dA8E
 426HsHN97lfBHvEOCSDP35tk38Snw9vF8QO/HEcytthHUQKlTv90T9q21iI3aM3E2l2SJ3GQy4i
 9w9EydXwOS/P3ozdG3PqT0Ymmp4fKYJZ4U7ReBJlLq7BvFJF65Kc2nYNUsrRJFXgk5tEV1PAVp0
 unt3cUpA+sgKs06R0LYyCIRv/J9mB6GvDAJTvqMtbaSIpGJFI0juG9zZcwCKB9sDYmcSwZPQjV5
 jZGminwiQPBVzHb6DS+29wasaYRYJa4TjQQPc9o5YNuxcNtTr+uNenJvLhbyt9Pv+Gck9Jn5LkH
 dKgTw7XELx2Yt5uxbX1lSkLJopUcLb01zlIWajQ5bpNcnnG1OrZH1r/42qm49CUqmp3hlV6aHDn
 FvOoZ081chmhwQSIpdc8ekLT2ZmecqCsCPwzdfC3pQPUY2K0POezQAYhL/3R/Uz5I2rmCELys7I
 rlxuSEo1aXcNVHe/y3A==
X-Proofpoint-ORIG-GUID: cSB6UTDsHl0oU8HrvkK4MALtvNE_nv8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310005
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

QWRkIGEgc3lzYnVzIGRldmljZSB0aGF0IG93bnMgdGhlIEhNWCBzdGF0ZS4gIEEgY29yZSBoYXMg
b25lIEhNWCB1bml0CnNoYXJlZCBieSBhbGwgaXRzIHRocmVhZHMuCgpSZXZpZXdlZC1ieTogTWFy
Y28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcv
aGV4YWdvbi9oZXhhZ29uLmggICAgICAgICAgICAgfCAgNSArKysKIGluY2x1ZGUvaHcvaGV4YWdv
bi9oZXhhZ29uX2hteF9jb250ZXh0LmggfCAyNCArKysrKysrKysrKysrKwogaHcvaGV4YWdvbi9o
ZXgtc3Vic3lzLmMgICAgICAgICAgICAgICAgICB8IDE2ICsrKysrKysrKysKIGh3L2hleGFnb24v
aGV4YWdvbl9obXhfY29udGV4dC5jICAgICAgICAgfCA0MCArKysrKysrKysrKysrKysrKysrKysr
KysKIGh3L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgfCAgMSArCiA1IGZp
bGVzIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2h3L2hleGFnb24vaGV4YWdvbl9obXhfY29udGV4dC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcv
aGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmMKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2hl
eGFnb24vaGV4YWdvbi5oIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaAppbmRleCBlMDFl
MmJiNDY0Zi4uMmNhNGE1MThkYmUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhh
Z29uLmgKKysrIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaApAQCAtNDAsNiArNDAsMTEg
QEAgdHlwZWRlZiBlbnVtIHsKICNkZWZpbmUgSEVYQUdPTl9MQVRFU1RfUkVWIHY4NQogI2RlZmlu
ZSBIRVhBR09OX0xBVEVTVF9SRVZfVVBQRVIgVjg1CiAKKyNkZWZpbmUgSEVYQUdPTl9DT1BST0Nf
SE1YICgxVSA8PCAyKQorCisjZGVmaW5lIEhFWEFHT05fQ0ZHVEFCTEVfSEFTX0hNWCh0KSBcCisg
ICAgKCh0KS0+Y29wcm9jMl9yZWcwICE9IDAgfHwgKCh0KS0+Y29wcm9jX3ByZXNlbnQgJiBIRVhB
R09OX0NPUFJPQ19ITVgpKQorCiAvKgogICogQ29uZmlnIHRhYmxlIGFkZHJlc3MgYmFzZXMgcmVw
cmVzZW50IGJpdHMgWzM1OjE2XS4KICAqLwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29u
L2hleGFnb25faG14X2NvbnRleHQuaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9j
b250ZXh0LmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjhkZWQ5YWQz
ODVkCi0tLSAvZGV2L251bGwKKysrIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25faG14X2Nv
bnRleHQuaApAQCAtMCwwICsxLDI0IEBACisvKgorICogSGV4YWdvbiBITVggRXh0ZW5zaW9uIENv
bnRleHQgUU9NIE9iamVjdAorICoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9n
aWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyAqLworCisjaWZuZGVmIEhFWEFHT05fSE1YX0NPTlRF
WFRfSAorI2RlZmluZSBIRVhBR09OX0hNWF9DT05URVhUX0gKKworI2luY2x1ZGUgImh3L2NvcmUv
c3lzYnVzLmgiCisjaW5jbHVkZSAicW9tL29iamVjdC5oIgorI2luY2x1ZGUgInRhcmdldC9oZXhh
Z29uL2hteF9zdGF0ZS5oIgorCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9ITVhfQ09OVEVYVCAiaGV4
YWdvbi1obXgtY29udGV4dCIKK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEhleGFnb25ITVhD
b250ZXh0U3RhdGUsIEhFWEFHT05fSE1YX0NPTlRFWFQpCisKK3N0cnVjdCBIZXhhZ29uSE1YQ29u
dGV4dFN0YXRlIHsKKyAgICBTeXNCdXNEZXZpY2UgcGFyZW50X29iajsKKworICAgIEhteFN0YXRl
IHJlZ3M7Cit9OworCisjZW5kaWYgLyogSEVYQUdPTl9ITVhfQ09OVEVYVF9IICovCmRpZmYgLS1n
aXQgYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYyBiL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCmlu
ZGV4IDFhMDQzODE4ZjZiLi4wYWZmYmY1NTM0NSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXgt
c3Vic3lzLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKQEAgLTExLDYgKzExLDcgQEAK
ICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmgiCiAjaW5jbHVkZSAiaHcv
aGV4YWdvbi9oZXhhZ29uX2hseC5oIgogI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9odnhf
Y29udGV4dC5oIgorI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9obXhfY29udGV4dC5oIgog
I2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl90bGIuaCIKICNpbmNsdWRlICJody9pbnRjL2hl
eC1sMnZpYy5oIgogI2luY2x1ZGUgImh3L3RpbWVyL3FjdC1xdGltZXIuaCIKQEAgLTEzMyw2ICsx
MzQsMjAgQEAgc3RhdGljIERldmljZVN0YXRlICpobHhfY3JlYXRlKEhleGFnb25Db21tb25NYWNo
aW5lU3RhdGUgKmhtcywKICAgICByZXR1cm4gaGx4OwogfQogCitzdGF0aWMgdm9pZCBobXhfY29u
dGV4dF9jcmVhdGUoSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnICpt
X2NmZykKK3sKKyAgICBEZXZpY2VTdGF0ZSAqY3R4OworCisgICAgaWYgKCFIRVhBR09OX0NGR1RB
QkxFX0hBU19ITVgoJm1fY2ZnLT5jZmd0YWJsZSkpIHsKKyAgICAgICAgcmV0dXJuOworICAgIH0K
KworICAgIGN0eCA9IHFkZXZfbmV3KFRZUEVfSEVYQUdPTl9ITVhfQ09OVEVYVCk7CisgICAgb2Jq
ZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChPQkpFQ1QoaG1zKSwgImhteC1jb250ZXh0IiwgT0JKRUNU
KGN0eCkpOworICAgIHN5c2J1c19yZWFsaXplX2FuZF91bnJlZihTWVNfQlVTX0RFVklDRShjdHgp
LCAmZXJyb3JfZmF0YWwpOworfQorCiBzdGF0aWMgRGV2aWNlU3RhdGUgKmNsdXN0ZXJfY3JlYXRl
KEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgKmhtcykKIHsKICAgICBEZXZpY2VTdGF0ZSAqY2x1
c3RlciA9IHFkZXZfbmV3KFRZUEVfQ1BVX0NMVVNURVIpOwpAQCAtMTgxLDYgKzE5Niw3IEBAIHZv
aWQgaGV4X3N1YnN5c19jcmVhdGUoSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zLAogICAg
IGhtcy0+dGxiID0gdGxiX2NyZWF0ZShobXMsIG1fY2ZnKTsKICAgICBodnhfY29udGV4dHNfY3Jl
YXRlKGhtcywgbV9jZmcpOwogICAgIGhtcy0+aGx4ID0gaGx4X2NyZWF0ZShobXMsIG1fY2ZnKTsK
KyAgICBobXhfY29udGV4dF9jcmVhdGUoaG1zLCBtX2NmZyk7CiB9CiAKIHZvaWQgaGV4X3N1YnN5
c19hZGRfY3B1KEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgKmhtcywgRGV2aWNlU3RhdGUgKmNw
dSkKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9obXhfY29udGV4dC5jIGIvaHcvaGV4
YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAuLmUzZWE3YjcxNDc0Ci0tLSAvZGV2L251bGwKKysrIGIvaHcvaGV4YWdvbi9oZXhh
Z29uX2hteF9jb250ZXh0LmMKQEAgLTAsMCArMSw0MCBAQAorLyoKKyAqIEhleGFnb24gSE1YIEV4
dGVuc2lvbiBDb250ZXh0IFFPTSBPYmplY3QKKyAqCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21t
IFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgInFlbXUv
b3NkZXAuaCIKKyNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuaCIKKwor
c3RhdGljIHZvaWQgaGV4YWdvbl9obXhfY29udGV4dF9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBS
ZXNldFR5cGUgdHlwZSkKK3sKKyAgICBIZXhhZ29uSE1YQ29udGV4dFN0YXRlICpzID0gSEVYQUdP
Tl9ITVhfQ09OVEVYVChvYmopOworCisgICAgbWVtc2V0KCZzLT5yZWdzLCAwLCBzaXplb2Yocy0+
cmVncykpOworfQorCitzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9jb250ZXh0X2NsYXNzX2luaXQo
T2JqZWN0Q2xhc3MgKmtsYXNzLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IHZvaWQgKmRhdGEpCit7CisgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNF
X0NMQVNTKGtsYXNzKTsKKyAgICBSZXNldHRhYmxlQ2xhc3MgKnJjID0gUkVTRVRUQUJMRV9DTEFT
UyhrbGFzcyk7CisKKyAgICByYy0+cGhhc2VzLmhvbGQgPSBoZXhhZ29uX2hteF9jb250ZXh0X3Jl
c2V0X2hvbGQ7CisgICAgZGMtPnVzZXJfY3JlYXRhYmxlID0gZmFsc2U7Cit9CisKK3N0YXRpYyBj
b25zdCBUeXBlSW5mbyBoZXhhZ29uX2hteF9jb250ZXh0X2luZm8gPSB7CisgICAgLm5hbWUgPSBU
WVBFX0hFWEFHT05fSE1YX0NPTlRFWFQsCisgICAgLnBhcmVudCA9IFRZUEVfU1lTX0JVU19ERVZJ
Q0UsCisgICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoSGV4YWdvbkhNWENvbnRleHRTdGF0ZSks
CisgICAgLmNsYXNzX2luaXQgPSBoZXhhZ29uX2hteF9jb250ZXh0X2NsYXNzX2luaXQsCit9Owor
CitzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9jb250ZXh0X3JlZ2lzdGVyX3R5cGVzKHZvaWQpCit7
CisgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmhleGFnb25faG14X2NvbnRleHRfaW5mbyk7Cit9
CisKK3R5cGVfaW5pdChoZXhhZ29uX2hteF9jb250ZXh0X3JlZ2lzdGVyX3R5cGVzKQpkaWZmIC0t
Z2l0IGEvaHcvaGV4YWdvbi9tZXNvbi5idWlsZCBiL2h3L2hleGFnb24vbWVzb24uYnVpbGQKaW5k
ZXggNDZlOWY4ZGU5YzguLmM1NmNkYjA4MWUxIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL21lc29u
LmJ1aWxkCisrKyBiL2h3L2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIsNiArMiw3IEBAIGhleGFn
b25fc3MgPSBzcy5zb3VyY2Vfc2V0KCkKIGhleGFnb25fc3MuYWRkKGZpbGVzKCdoZXhhZ29uX3Rs
Yi5jJykpCiBoZXhhZ29uX3NzLmFkZChmaWxlcygnaGV4YWdvbl9nbG9iYWxyZWcuYycpKQogaGV4
YWdvbl9zcy5hZGQoZmlsZXMoJ2hleGFnb25faHZ4X2NvbnRleHQuYycpKQoraGV4YWdvbl9zcy5h
ZGQoZmlsZXMoJ2hleGFnb25faG14X2NvbnRleHQuYycpKQogaGV4YWdvbl9zcy5hZGQod2hlbjog
J0NPTkZJR19IRVhfRFNQJywgaWZfdHJ1ZTogZmlsZXMoJ2hleC1zdWJzeXMuYycpKQogaGV4YWdv
bl9zcy5hZGQoZmlsZXMoJ2hleGFnb25faGx4LmMnKSkKIGhleGFnb25fc3MuYWRkKHdoZW46ICdD
T05GSUdfSEVYX0RTUCcsIGlmX3RydWU6IGZpbGVzKCdoZXhhZ29uX2RzcC5jJykpCi0tIAoyLjM0
LjEKCg==

