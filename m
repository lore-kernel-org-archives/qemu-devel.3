Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED4CFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsJ-0000sF-Ev; Wed, 11 Mar 2026 00:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsC-0000pm-Hx
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsA-00005o-W8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B0Mxsp1265877
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 81bUFjzMZ0UAey8kEEfi002gYCid7rITUSj9q0qKpdY=; b=oZsGap60N4GTLVKP
 t2K2P7C6lPjRaEGFVUzsLpIiYOfODQysiqzpF+qYeXSU3YrBJHmjZpDmoAnARp6V
 Im+I+PD2iSDK7GzNYrUSTS7EPaVo5G4RVXNYFFSg2pgH4AIUMx4yceZk39Xf5CkC
 Uj682Q3PBBkf4X6tIz4b/ilTOEfV6eUgGqb+DOHtRS/pDxZfGokErHdkwq9GPuQl
 p49qZA+OlVy/RSR8JuPGl2XyF5royv/4DbDlEr1gpDS8LFY2syqGuRM/ve84VCGf
 A7GLt+B7dh+TRBLupflWJc9btnmdAQ9BqBi/Z/CoozZRr4lhFJjdhNkszZJZQxxO
 KmV0Zw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctpkfj7wn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:37 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4176f39cea6so6737780fac.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202117; x=1773806917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81bUFjzMZ0UAey8kEEfi002gYCid7rITUSj9q0qKpdY=;
 b=aUuO1HjzpHC99q6KMAFBH+eARrPnNM24JxjK9c0P9dOvgRThDwJgHMNuIpz1c1KA5Z
 IMy7ZV5ErdHT0oKNkZyyIwly4ejLPi0SNiPkIDTNEX/RjOXlbKGHn84UssSWD+BTs6A+
 zsule78d8vHIzv2i8FGBNp4MTNVYrK8mFgbkiM0+pN5QR8FF1VYpj9SL6BQco8C5pdWA
 fdrVV0h9CdKsAP4OnYLbYgabKp5Dy8EcKY7LdTh4kadmZMnI6qvULG/edkzLTmSbFP4H
 LLdqz0FGjpX6vgmcjff4U0b/alE5nyknorK8giGkJFmb9nL5mHqDOsZSW5HW4zCvQ/V9
 Hj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202117; x=1773806917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=81bUFjzMZ0UAey8kEEfi002gYCid7rITUSj9q0qKpdY=;
 b=gJynG2lvy0WZN+sS59ln6Ii+nav3gHRyxmToRXcD8ToLuJB3NYJ3ibucTGuRa44KXR
 7JvbXZqIB4gZOnAbfnTfIWQlEfLejARA3S6e9HqFO9d16n8m5YUVEnBlhaW2TA30wFrv
 tKBjLqtM95FPZ4Vm+G9P4urJ2TOJxzAWZ/cMmtoCppSqsQ3J0ze1mh1C57vkKer3pkDl
 yhwD8TVA92UF6ga6SKTDBtXoZRIgNpETpv4uMxakQiVbXB6DHtR67MtD6hiQqOuUwdEH
 5IZ8t3Te7OpgRRlzRCI17ZPOxzolo9QarocESS0QOHIXtIx+1260KnFU8LHksTXxLxdN
 1oTA==
X-Gm-Message-State: AOJu0YwryuUksA9NOoXjObEyuDA8KiK6xC7MZboPB6dWltLpd2eHIfzO
 V82TD2BDphKz/ZkYyOM6HiKbeNUjDdT7FhGfaoTYgisBpt4naV3K7XdcLdczenaRBR4NFMH8AAB
 pPSB8opONUawVf0TrGsCl5v63BuHG7Fd2gh18TxnnNkHMSPtq+MBVQNd5XaySUwDjZQ==
X-Gm-Gg: ATEYQzysXMdqqZv7I1jheSyl1aHrZjGOvtNTItlzplbcqlj+MDYCgl4U1ERfxvpqpXu
 ELhlHC9bFi1goBSWTIV+tY9AmjGgwe955OD8B11N3IzfZAiA6TUz1p2City28lf8cN4WY00RmKa
 nkTx2lNUUNDjqzqbOH2qbttefv7ptEKbbAZE7DeImwhCthJaPbb3W/QsuoZdAZLjt9Vw79s4Zkh
 2rxeEjb7tCFdCrlbg/9ip7OtmaLXXAoT9FCfpW/A+Ftj3llbTclvm/I3si1d0qkwBSBuWlCYxJy
 JWCc74CrLoAl4GMlLJ9q7QsbhC3ndniKuOmbug5Tag5kw9LqitAk45mfZdkjWUn9uiOAh39+91k
 xEyEMmT40Nb/9R2IVvv80TektxtiwHDUc6q9crAcxjeBh+lM5CEUnRgvr1/oKurZaQimXaw==
X-Received: by 2002:a05:6870:d8cc:b0:315:b768:bd1d with SMTP id
 586e51a60fabf-4177c5d42a6mr872209fac.6.1773202116679; 
 Tue, 10 Mar 2026 21:08:36 -0700 (PDT)
X-Received: by 2002:a05:6870:d8cc:b0:315:b768:bd1d with SMTP id
 586e51a60fabf-4177c5d42a6mr872196fac.6.1773202116314; 
 Tue, 10 Mar 2026 21:08:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 22/32] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Tue, 10 Mar 2026 21:07:48 -0700
Message-Id: <20260311040758.1068731-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 75VIOOAxlCOV3IlEOlBtA9SrkNi5ydvX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfXyF275X3FVzZH
 jTCTyyV0B25g02C4K5NuEXSpOprtvygkwBs1dm2FcdEOqbYlj8i3wCK30D0iKic20CXhd9frl35
 YHWFMEvJl5YE8y9CumZnB1FTQNaD32+V/GJfgvvamfCqLX9aFj80h/clVOqQESfs5XYkLfhKvDi
 mLwR67rDAG9wAwbmuK+fZH4bf9OKglkOjYSzj/Vsz6lmsv44zsrJsY4ADnxRJ6jbbm8qqK9TguA
 OXZbxAorkOhM+Tiz2dLqz1CP8aEdVeR0S94qUvhWGxuG+sid03h29a+wvCc88W7vwr+rNi8TMH+
 69LgDeqx1jyZ4Xe3GBmyhZV/WOeboClTY39OBrMxm27S9NnSuBKlDgKHJvRLaT+OLZMa3ABPQzT
 abSxcrV7YuBX/F9jRwVPrOWvTEYg4/ilgXrVGq+nlBVpvCK6nzwZ7hfxjIzRNX5nPVgRvkRVVNF
 6VAcYXweaezI0jHHrbA==
X-Proofpoint-ORIG-GUID: 75VIOOAxlCOV3IlEOlBtA9SrkNi5ydvX
X-Authority-Analysis: v=2.4 cv=Gq5PO01C c=1 sm=1 tr=0 ts=69b0eac5 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=w_Ktf-yQGdqK2aTfpWsA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDIwICsrKysr
KysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5o
CmluZGV4IGViY2Q0NzFlYzBhLi4xN2U3NGIxMmYzYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEyOSw0ICsxMjks
NyBAQCBERUZfSEVMUEVSXzEoc3RvcCwgdm9pZCwgZW52KQogREVGX0hFTFBFUl8yKHdhaXQsIHZv
aWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHJlc3VtZSwgdm9pZCwgZW52LCBpMzIpCiBERUZf
SEVMUEVSXzIobm1pLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMShyZXNjaGVkLCB2b2lk
LCBlbnYpCitERUZfSEVMUEVSXzMobW9kaWZ5X3Nzciwgdm9pZCwgZW52LCBpMzIsIGkzMikKK0RF
Rl9IRUxQRVJfMShwZW5kaW5nX2ludGVycnVwdCwgdm9pZCwgZW52KQogI2VuZGlmCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jCmluZGV4IDM2ODIyMjE5YjRiLi4xYWRlNjZkZjlkNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTEy
MjYsNiArMTIyNiwxNSBAQCBmbG9hdDY0IEhFTFBFUihkZm1weWhoKShDUFVIZXhhZ29uU3RhdGUg
KmVudiwgZmxvYXQ2NCBSeHhWLAogICAgIHJldHVybiBSeHhWOwogfQogCisjaWZuZGVmIENPTkZJ
R19VU0VSX09OTFkKK3ZvaWQgSEVMUEVSKG1vZGlmeV9zc3IpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCkKK3sKKyAgICBCUUxfTE9DS19HVUFSRCgpOwor
ICAgIGhleGFnb25fbW9kaWZ5X3NzcihlbnYsIG5ldywgb2xkKTsKK30KKyNlbmRpZgorCisKIC8q
IEhpc3RvZ3JhbSBpbnN0cnVjdGlvbnMgKi8KIAogdm9pZCBIRUxQRVIodmhpc3QpKENQVUhleGFn
b25TdGF0ZSAqZW52KQpAQCAtMTYzMSw2ICsxNjQwLDExIEBAIHN0YXRpYyBpbmxpbmUgUUVNVV9B
TFdBWVNfSU5MSU5FIHZvaWQgcmVzY2hlZChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICB9CiB9
CiAKK3ZvaWQgSEVMUEVSKHJlc2NoZWQpKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIHJl
c2NoZWQoZW52KTsKK30KKwogdm9pZCBIRUxQRVIod2FpdCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IFBDKQogewogICAgIEJRTF9MT0NLX0dVQVJEKCk7CkBAIC0xNzY0LDYgKzE3Nzgs
MTIgQEAgdm9pZCBIRUxQRVIobm1pKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGhy
ZWFkX21hc2spCiB7CiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KKwordm9pZCBIRUxQ
RVIocGVuZGluZ19pbnRlcnJ1cHQpKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X2ludGVycnVwdF91cGRhdGUoZW52KTsKK30KICNlbmRpZgog
CiAKLS0gCjIuMzQuMQoK

