Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DCE606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GkpZ4ek/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RthYlTyM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMumL-0000e1-GA; Fri, 30 Oct 2026 18:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumJ-0000dB-CT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumH-0003pb-En
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtIqU1349185
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7NYNPIhhTl72+Hi96dkXNNcldCv/4ymMOVQgfJnTgf0=; b=GkpZ4ek/zil+UHOB
 h9AkJADzXwi4PxVSnSqGlqPBI9KArL9RcDikXVwPVCEvzlWrrfYImbmgu1qVXCVA
 jJ4VBtuYZgYF1MA5Symtmz4Ra/0zwxebmJ25j/dLCYqJgA3sajxhzc98/vWCvw7+
 l0X7tyrihEjkqZbUisXlZoWRpbQebVlyaskdoDj+t85TbzsqPkeus0yMkVF+/vZR
 bGDPrWt/aO1v00fg98r0kSxZaCYwGZdXOj+P3hjvXaKY+O1NdyLgq6838khxTNjx
 6RJ7b+JRCtxHJQdoY+IYPN9FFAffb7RBOm5rcdrGuOKHoWVnfjahMta9WlLJ23Rs
 DnKYIw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x005vf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so1978255eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398127; x=1794002927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7NYNPIhhTl72+Hi96dkXNNcldCv/4ymMOVQgfJnTgf0=;
 b=RthYlTyMLgkv+MBDhc7FUB67cICjzbtWk8mAdmeCADcKp2LwFG0GPcP6xoShNpJZwo
 qFxXsjFrleDh/fBCKUuzJfN4TNB5FW4To7lpe3s8pTy6zCthxfiJxnenc4GcPyis1LZk
 0BjIXfo72tSfgb09n3xDRUmxNBMZOdIPGb+NSDhemwJ0w1Te4M9gbwMAH9QV53m4b08W
 yInhU1H9gv9miQnlFnrWKccVTC9Lgcg9m873Aia4EGSvtHR4s9HZA8Wx9osWV7tAB1iB
 kUYXcSdV91RndAvGZBAjjwhwtuH6thXfFltMAp8/PmAxMxfgFSp20TzkTjkjHfIJU6Op
 lK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398127; x=1794002927;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7NYNPIhhTl72+Hi96dkXNNcldCv/4ymMOVQgfJnTgf0=;
 b=q0fDoL5XsJmpnZZCgwi78TOO5t0FMdkDB29O71zHSozjIZ5H4DChefP5kpeLbcI4Rz
 Jz18vWrhEe3nqnUszMCyNzk71pMOe8TFauD3Ri7ne4TVux3RHegl+TPrS1lj9JanGn22
 mj6Z11G0hyv6jDimLEv67JHPRBfCPzMl4qr9wvG2VqjAaMGipijaxmFNYkIzzMZ1tfGc
 7UtSoZtn6rAfr7Fj4I+IxismZKaMwaKvn/ia8p+sLMyhu2VaIRYcWw0sGHS1Jptqd8Ed
 gCpmcO1XfmNmY/BnbIeYSmYMHiyt0AKilwNjb5v1w85Vb8Q8t/lxgczbDQ+X0KQGenBz
 R2Vw==
X-Gm-Message-State: AFq9FYLZXryh6VRMSH74vnnTIu9zCJ54b33SC4lP4eJqbjMitaIla3BT
 bqOuhl05KwP8PZSdFLEpN6tZmq19kR9fIqLw39ZlZp0+COBdjWJ/4eVhIrEZ7962Cmhv6KQQIZA
 kB53mH+ih3XI+t0ak76pRTztYNOEIDwSdhxOeVtw5S0ecHwMrPImu4iCVuaMbPKFiaQ==
X-Gm-Gg: AYBFou2dPGZ23I94nkoJxEFTbV1bYImdP2eam0ltW2d6rXZvuo3G33dzMb8SeWFsurZ
 20mqFphrkdkVZIkh1CCEO6i36oUu2Q0ZMTjBhyZ2FG1T14gw+W5ZXIU/lHy85UAyxAwjPcDIUaM
 URUJCv3uCI8xQp1FlTPlliwBqg3VjpUcVDqc1a6ljmizJdvzx0pvaF4yjV+9RGpoDjBDC6y7YmK
 WlUCEFKajlx6p6Pp3Th7MVKtatAMkpofIR5W5FvsXkrV7eu577rvsTdQmkqPf3qA730i9dUlQqH
 8stVvKgbJMTtINI0TRxaBfI1r6QeUVWugMkWJJ74Lb0T08B2/jwOmMtpu6sitNDo9jFvkj5GyyN
 eyiwKUOAtsB/NUWnHGWfF83OMTsqKh5vyTUzV5KDBLkmBa6G7a7cmZApZymesN6ppTW2CTEN/AS
 t5p/UW/+GM8+UgKMYWkeIc
X-Received: by 2002:a05:7300:f281:b0:369:f64e:7feb with SMTP id
 5a478bee46e88-36a4220128dmr5413958eec.2.1793398126961; 
 Fri, 30 Oct 2026 15:08:46 -0700 (PDT)
X-Received: by 2002:a05:7300:f281:b0:369:f64e:7feb with SMTP id
 5a478bee46e88-36a4220128dmr5413938eec.2.1793398126385; 
 Fri, 30 Oct 2026 15:08:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm9965691eec.19.2026.10.30.15.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:08:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 2/8] hw/hexagon: add the HMX context device
Date: Fri, 30 Oct 2026 15:08:34 -0700
Message-Id: <20261030220840.4142885-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
References: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: pHu2bHfSnWpI47LAvYn7Maulf_oDTCkJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX1Lz6Ob7ytmdW
 5gyI4Qk5P1oSR8BObpbU3ZTUR6GUFcvfXdwQjHesLCNLAkNq/Y/iUPHGTWI2SV8Y7I+Ni6d4HEC
 INlm1lW25FX9OlQEQP8r6/O0vs0DfK4OKDk3iA+tbpHNbeTznNnQbHHS8OlqtuVab6M/RqVgszH
 JC+IdTk+ZdTlpFKJGmHEtzaGaPwvfAzjdzo94fWzHH1vFevXDsaLXIFBye+/gX3nUkzHEmMUU3W
 5BNP6sh45DBG1NlkeY7CC/YL9ybzvg3xuQ8pfv/rK47buRNvH+bOQ76xLJhn5oh2fBJAzQrHPNW
 VRUTKJdHUVtC+vYvXH17lwZhSVTqrwcsYDo9MoKsdHje4/ofW5RDEg8JQ54fguKNkgXN+dTOLQd
 P0Jb414PKCGV3nYp3PGPcmML+wpw1jDV5T3MlkSEW4xbNuNmopBXUVz2HTFXjLP0W17iuc3mTWQ
 exXDVURNpTprRxso5PA==
X-Proofpoint-GUID: pHu2bHfSnWpI47LAvYn7Maulf_oDTCkJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX33JF1XPA/hpK
 mLZ8Ue5y1QJPzeib+H7rtUwxZQvTOMO+MnZBRJ7+O6gaH32MwHLYnJ8bwFNBPmvlwISCwX3JRNr
 6kT/kkUvVs0NoBEH1QJoMQ2d4MejECY=
X-Authority-Analysis: v=2.4 cv=FvOQbGrq c=1 sm=1 tr=0 ts=6ae5156f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GkCZVEeUe3Q-cCnmmhAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088
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
eGFnb24vaGV4YWdvbi5oIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaAppbmRleCA2Nzhl
NjU4YTZkMy4uYzQ1YzJiZWZhNTAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhh
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
ZGV4IDFlNjU3ODI1NWViLi40ZDlhNzljZmY3NCAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXgt
c3Vic3lzLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKQEAgLTEwLDYgKzEwLDcgQEAK
ICNpbmNsdWRlICJody9oZXhhZ29uL2hleC1zdWJzeXMuaCIKICNpbmNsdWRlICJody9oZXhhZ29u
L2hleGFnb25fZ2xvYmFscmVnLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9j
b250ZXh0LmgiCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmgiCiAj
aW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oIgogI2luY2x1ZGUgImh3L2ludGMvaGV4
LWwydmljLmgiCiAjaW5jbHVkZSAiaHcvdGltZXIvcWN0LXF0aW1lci5oIgpAQCAtMTIwLDYgKzEy
MSwyMCBAQCBzdGF0aWMgdm9pZCBodnhfY29udGV4dHNfY3JlYXRlKEhleGFnb25Db21tb25NYWNo
aW5lU3RhdGUgKmhtcywKICAgICBobXMtPm51bV9odnhfY3R4ID0gbjsKIH0KIAorc3RhdGljIHZv
aWQgaG14X2NvbnRleHRfY3JlYXRlKEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgKmhtcywKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5l
X2NvbmZpZyAqbV9jZmcpCit7CisgICAgRGV2aWNlU3RhdGUgKmN0eDsKKworICAgIGlmICghSEVY
QUdPTl9DRkdUQUJMRV9IQVNfSE1YKCZtX2NmZy0+Y2ZndGFibGUpKSB7CisgICAgICAgIHJldHVy
bjsKKyAgICB9CisKKyAgICBjdHggPSBxZGV2X25ldyhUWVBFX0hFWEFHT05fSE1YX0NPTlRFWFQp
OworICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoT0JKRUNUKGhtcyksICJobXgtY29udGV4
dCIsIE9CSkVDVChjdHgpKTsKKyAgICBzeXNidXNfcmVhbGl6ZV9hbmRfdW5yZWYoU1lTX0JVU19E
RVZJQ0UoY3R4KSwgJmVycm9yX2ZhdGFsKTsKK30KKwogc3RhdGljIERldmljZVN0YXRlICpjbHVz
dGVyX2NyZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMpCiB7CiAgICAgRGV2aWNl
U3RhdGUgKmNsdXN0ZXIgPSBxZGV2X25ldyhUWVBFX0NQVV9DTFVTVEVSKTsKQEAgLTE2Nyw2ICsx
ODIsNyBAQCB2b2lkIGhleF9zdWJzeXNfY3JlYXRlKEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUg
KmhtcywKICAgICBobXMtPmdsb2JfcmVncyA9IGdsb2JhbHJlZ19jcmVhdGUoaG1zLCBtX2NmZywg
cmV2KTsKICAgICBobXMtPnRsYiA9IHRsYl9jcmVhdGUoaG1zLCBtX2NmZyk7CiAgICAgaHZ4X2Nv
bnRleHRzX2NyZWF0ZShobXMsIG1fY2ZnKTsKKyAgICBobXhfY29udGV4dF9jcmVhdGUoaG1zLCBt
X2NmZyk7CiB9CiAKIHZvaWQgaGV4X3N1YnN5c19hZGRfY3B1KEhleGFnb25Db21tb25NYWNoaW5l
U3RhdGUgKmhtcywgRGV2aWNlU3RhdGUgKmNwdSkKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4
YWdvbl9obXhfY29udGV4dC5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmMKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLmUzZWE3YjcxNDc0Ci0tLSAvZGV2
L251bGwKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmMKQEAgLTAsMCArMSw0
MCBAQAorLyoKKyAqIEhleGFnb24gSE1YIEV4dGVuc2lvbiBDb250ZXh0IFFPTSBPYmplY3QKKyAq
CisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRz
IHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJody9oZXhhZ29u
L2hleGFnb25faG14X2NvbnRleHQuaCIKKworc3RhdGljIHZvaWQgaGV4YWdvbl9obXhfY29udGV4
dF9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKK3sKKyAgICBIZXhhZ29u
SE1YQ29udGV4dFN0YXRlICpzID0gSEVYQUdPTl9ITVhfQ09OVEVYVChvYmopOworCisgICAgbWVt
c2V0KCZzLT5yZWdzLCAwLCBzaXplb2Yocy0+cmVncykpOworfQorCitzdGF0aWMgdm9pZCBoZXhh
Z29uX2hteF9jb250ZXh0X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQgKmRhdGEpCit7Cisg
ICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsKKyAgICBSZXNldHRhYmxl
Q2xhc3MgKnJjID0gUkVTRVRUQUJMRV9DTEFTUyhrbGFzcyk7CisKKyAgICByYy0+cGhhc2VzLmhv
bGQgPSBoZXhhZ29uX2hteF9jb250ZXh0X3Jlc2V0X2hvbGQ7CisgICAgZGMtPnVzZXJfY3JlYXRh
YmxlID0gZmFsc2U7Cit9CisKK3N0YXRpYyBjb25zdCBUeXBlSW5mbyBoZXhhZ29uX2hteF9jb250
ZXh0X2luZm8gPSB7CisgICAgLm5hbWUgPSBUWVBFX0hFWEFHT05fSE1YX0NPTlRFWFQsCisgICAg
LnBhcmVudCA9IFRZUEVfU1lTX0JVU19ERVZJQ0UsCisgICAgLmluc3RhbmNlX3NpemUgPSBzaXpl
b2YoSGV4YWdvbkhNWENvbnRleHRTdGF0ZSksCisgICAgLmNsYXNzX2luaXQgPSBoZXhhZ29uX2ht
eF9jb250ZXh0X2NsYXNzX2luaXQsCit9OworCitzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9jb250
ZXh0X3JlZ2lzdGVyX3R5cGVzKHZvaWQpCit7CisgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmhl
eGFnb25faG14X2NvbnRleHRfaW5mbyk7Cit9CisKK3R5cGVfaW5pdChoZXhhZ29uX2hteF9jb250
ZXh0X3JlZ2lzdGVyX3R5cGVzKQpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9tZXNvbi5idWlsZCBi
L2h3L2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggZmE1YmM1ZWI5ZjEuLmU3YWJhZDFjMjM0IDEw
MDY0NAotLS0gYS9ody9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL2h3L2hleGFnb24vbWVzb24u
YnVpbGQKQEAgLTIsNiArMiw3IEBAIGhleGFnb25fc3MgPSBzcy5zb3VyY2Vfc2V0KCkKIGhleGFn
b25fc3MuYWRkKGZpbGVzKCdoZXhhZ29uX3RsYi5jJykpCiBoZXhhZ29uX3NzLmFkZChmaWxlcygn
aGV4YWdvbl9nbG9iYWxyZWcuYycpKQogaGV4YWdvbl9zcy5hZGQoZmlsZXMoJ2hleGFnb25faHZ4
X2NvbnRleHQuYycpKQoraGV4YWdvbl9zcy5hZGQoZmlsZXMoJ2hleGFnb25faG14X2NvbnRleHQu
YycpKQogaGV4YWdvbl9zcy5hZGQod2hlbjogJ0NPTkZJR19IRVhfRFNQJywgaWZfdHJ1ZTogZmls
ZXMoJ2hleC1zdWJzeXMuYycpKQogaGV4YWdvbl9zcy5hZGQod2hlbjogJ0NPTkZJR19IRVhfRFNQ
JywgaWZfdHJ1ZTogZmlsZXMoJ2hleGFnb25fZHNwLmMnKSkKIGhleGFnb25fc3MuYWRkKHdoZW46
ICdDT05GSUdfSEVYX0JPQVJEJywgaWZfdHJ1ZTogZmlsZXMoJ2hleC1ib2FyZC5jJykpCi0tIAoy
LjM0LjEKCg==

