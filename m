Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E34606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K6+G4mbn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xp5+NH2s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVON-0000IR-CG; Thu, 29 Oct 2026 15:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOC-0000HY-D3
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOA-0003yn-FD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDGn4227428
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Ssnmz+/FXf0zv6yFH2/yv9J2QVEXA9mzrBmom9cLo4=; b=K6+G4mbnGbXL15hB
 eyQCxYIDvfGiRSW+7VqYfjwAIPt4aZrXIIKjH0Sfzicpu3fOswmYwdl/vpXwyYHu
 uZU5rEhSXLMedkDhdETg6kQbHvzYTs3Dho/a2VLAB7mNuGBh2vJ3FV0BkmAWQzzs
 u30DcPlw3Ad6Iw/2/JeH0foTy1tFGQ0T/aNwMykZDOwenSgCdC6MebAJ5VZD+ZEI
 1EOK2KHVVGFNBGxawp2AzU04l/uJGh9zUcQQgjJOFSMbFGpv3sRFOYKw3qP4YdzF
 JdgNnsw1vqjJLDmJoco7MAF4SB/VikhsK9fwmVu9q5t8s/QirjYksPDJCbpF7VqP
 Y5lPzg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fkccs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a190c53a3so1462500eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793300532; x=1793905332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Ssnmz+/FXf0zv6yFH2/yv9J2QVEXA9mzrBmom9cLo4=;
 b=Xp5+NH2s68HwMMpICadRoNsztHwdz5u/R9ZsQNXB3UQGyWXKv7iGXa3QYynv6UAbPN
 V7dJFGZ3THPAgB5zeNpKKD0eepw/Ld/4PdX6ZZGRXhb5GRXQ+vOx34qyoF8QCqFawY9U
 juMgJlTZkuihMcPPfe1PZOc/UyXV/Z7y/WexYCeHkueayHFNnD1OVV3yNvnhtOzlmyEs
 9q4ZZz4Ugjpj9yYryBrXoS8QhtPxNvnC37iw/E4E4agWnjd7t4A2Gae9bB3vMTMk4EX5
 yUubwnwOl3p+GSO9EaAMZFSSTi3EvsmZsIRQApozQ8jLp4oEsSJZK9a3ycB4UQVaYUmZ
 1XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793300532; x=1793905332;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Ssnmz+/FXf0zv6yFH2/yv9J2QVEXA9mzrBmom9cLo4=;
 b=kLsq+EqRR1JasRvDjFv+yvxen+m9ayWo9/8NoRBftBxGzgiwjvIvmSJZjmRfb16Jan
 dTnoRU7riJQW/xHtW9U1bqHxVIVRoH90nYw+rVaTcMnZX38RPt90Au++teGJsAYV1mAf
 twxfpOqws9vAwfRPhVJTdfgto2GPDZLK4zHZv4nBqznKcxWd12rQeHQ/2ZhOdQKxTlMV
 eYYuxaMas4HRNrqItaBiMIRDgaSY4MdG0LedxFEFc+tT3X5J2Khz/ZwSmwlaijzUhDEy
 UcE/Se6Rnl9GFm0KTxWKiusgOzio0UA4kRvf57HOA7vXWVK5qn4+Gfo7jSqFnvB0vAcP
 CeFA==
X-Gm-Message-State: AFq9FYLdXa1YVN554h+YtXvv0sMAylqpnd7FFx9oy5foSzSoTL6kGdQc
 sGy2lhqvpF6T/u2KgPjCQTeX4cDgvv4v0Nmcq19dpQbbh0PL6sXmeUViwWcaEilqEN14zgn1TIA
 M0RrqTbSA/mJZ5dUqHzwxseiT1WA76lOOCNCchZdjV8VuH6KSa8wXIM1A5Rw8sD9w9w==
X-Gm-Gg: AYBFou3MvM85bkukWmAwc/I97yFvcdFQ2gONECQtoKHZ/DiNOcJSBaaWe/mtFjzDqVB
 5FNAHpkydpe2Vc5583fAIAFoCbB9o4/Seynqns90GmymrLn19210ee3fqdMlqfcYdPO365/2rN3
 w4XkBb1zS1d9dM6dazTXk0UrlyJRp7+08oDRdKSbT59XRDzi89SkoI9TcgMt6gJW6tMBEU9tTr7
 6r8Qyv9F2M8Y9teVOyBS2O4WO6d2SYM8l/Vq1xsm3PLkOSZuvR2G2on5XRNT2Q1203b3UYniKT9
 NN7ZIqGAf59X1hjZ0p+3xDwYFznsxgvBVsz2TXK+9fpUwvsH1voj/tz62ILP4YsKFs3y/OMQK3C
 5iPSUo+fGTziQjRLcpxHYVD2Iwi4bbGPCEOXeUvrWJQiV7EhM7NbNHZlKZ6xDBj8mv/Hxmusk7F
 rEixU8pPbRu8U2ro3VDUXNlw==
X-Received: by 2002:a05:693c:69c2:b0:36a:37:1404 with SMTP id
 5a478bee46e88-36a4241b6f3mr274048eec.13.1793300532160; 
 Thu, 29 Oct 2026 12:02:12 -0700 (PDT)
X-Received: by 2002:a05:693c:69c2:b0:36a:37:1404 with SMTP id
 5a478bee46e88-36a4241b6f3mr274012eec.13.1793300531215; 
 Thu, 29 Oct 2026 12:02:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm480598eec.28.2026.10.29.12.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:02:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/6] target/hexagon: don't take the BQL to find the MMU index
Date: Thu, 29 Oct 2026 12:02:03 -0700
Message-Id: <20261029190208.1169519-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX5QrWiJtceK1A
 A0Yo8rJn2qavO3Yj2LM5IswArGwygkzzrjP8OVQSgnFxbXx82i4ElrJ0h/9xtPaInJxzpQnrxcW
 FhSZGth1GiPMzOW+5xHYo2+oVZQdVlMDVlA3FVeV1aQNiryvnrdqRojRg2FwmW9aE0HBn+KdCso
 9YQtgZWs5gkhiRxj2pvPevQCxyNyAUFtl010p2KVPeFQMxQJDdt3ytVVOa3Yx8AUQPYh4IZtRlz
 6b+cZ5L6ZzHTMq3J4BeIS6fi7ZWxi/u+fjvCEV1S6pl+r3RR9rLJH2ojaoS3LidIVJ/RXZyJgOq
 fe7hM4nRsoRIJm1JKhezPN5WrcdH6IU1aL1E7DimD03HxTfXvdOLgfSRpADqqRNqpNfHEiA/rnN
 ZcQd+DNI6rjdupoZWaFLiZ+ydT94Vg==
X-Proofpoint-GUID: V3x-chigsTjjMHBSel4ra7w6hpK33HT_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX6/Vnb+dp1331
 R6mMaa0DaAs1SpmoVPaJXWkLEBAzHfjn/j3nuIZjDT2MXDnUKI8FRZtMSnZkDU7Lxk62BQHsebt
 5UZxRS7Da24dl3JJUpGqkP2MLjdWROo=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae39835 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=hd0I6R_-cxdpsw1IhpQA:9 a=omMCSS7BoUW7-8Yn:21
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: V3x-chigsTjjMHBSel4ra7w6hpK33HT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

aGV4YWdvbl9jcHVfbW11X2luZGV4KCkgcnVucyB2ZXJ5IG9mdGVuIC0gZWFjaCBUQi4gIFRha2lu
ZyB0aGUgQlFMIHRvCnJlYWQgc3lzY2ZnIGlzIG92ZXJraWxsLgoKU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaGV4
YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5oIHwgNiArKysrKysKIGh3L2hleGFnb24vaGV4YWdvbl9n
bG9iYWxyZWcuYyAgICAgICAgIHwgOSArKysrKysrLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jICAg
ICAgICAgICAgICAgICAgIHwgOSArKysrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbl9nbG9iYWxyZWcuaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJl
Zy5oCmluZGV4IDJkNWMzYzE2NmIxLi5kZmQyMWU3ODY2MyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9o
dy9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmgKKysrIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hl
eGFnb25fZ2xvYmFscmVnLmgKQEAgLTU5LDYgKzU5LDEyIEBAIHVpbnQzMl90IGhleGFnb25fZ2xv
YmFscmVnX21hc2tlZF92YWx1ZShIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJl
ZywKIHZvaWQgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGVfbWFza2VkKEhleGFnb25HbG9iYWxSZWdT
dGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDMyX3QgdmFsdWUpOwogCisvKgorICogU1lTQ0ZHLCB3aXRob3V0IHRoZSBCUUw6IGZv
ciB0aGUgdHJhbnNsYXRvciwgd2hpY2ggYXNrcyBmb3IgaXQgb24gZXZlcnkKKyAqIHRyYW5zbGF0
aW9uIGJsb2NrIGxvb2t1cCBhbmQgY2FuJ3QgYWZmb3JkIHRvIGNvbnRlbmQgZm9yIHRoZSBsb2Nr
LgorICovCit1aW50MzJfdCBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkX3N5c2NmZ191bmxvY2tlZChI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMpOworCiAvKiBHbG9iYWwgcGVyZm9ybWFuY2UgY3ljbGUg
Y291bnRlciBhY2Nlc3MgKi8KIHVpbnQ2NF90IGhleGFnb25fZ2xvYmFscmVnX3JlYWRfcGN5Y2xl
KEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcyk7CiB1aW50NjRfdCBoZXhhZ29uX2dsb2JhbHJlZ19n
ZXRfcGN5Y2xlX2Jhc2UoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzKTsKZGlmZiAtLWdpdCBhL2h3
L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyBiL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxy
ZWcuYwppbmRleCAyMmVjNDAyMDY2NS4uOGI1MGZlYzc3MGEgMTAwNjQ0Ci0tLSBhL2h3L2hleGFn
b24vaGV4YWdvbl9nbG9iYWxyZWcuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVn
LmMKQEAgLTI1Miw3ICsyNTIsNyBAQCBzdGF0aWMgdWludDMyX3QgZ2V0X3JlZ192YWx1ZShIZXhh
Z29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZykKICAgICAgICAgcmV0dXJuIHJlZyA9
PSBIRVhfU1JFR19QQ1lDTEVMTyA/CiAgICAgICAgICAgICAgICAgKHVpbnQzMl90KXZhbHVlIDog
KHVpbnQzMl90KSh2YWx1ZSA+PiAzMik7CiAgICAgfQotICAgIHJldHVybiBzLT5yZWdzW3JlZ107
CisgICAgcmV0dXJuIHFhdG9taWNfcmVhZCgmcy0+cmVnc1tyZWddKTsKIH0KIAogc3RhdGljIHZv
aWQgc2V0X3JlZ192YWx1ZShIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywK
QEAgLTI2Niw3ICsyNjYsNyBAQCBzdGF0aWMgdm9pZCBzZXRfcmVnX3ZhbHVlKEhleGFnb25HbG9i
YWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAgICAgICByZXR1cm47CiAgICAgfQogCi0g
ICAgcy0+cmVnc1tyZWddID0gdmFsdWU7CisgICAgcWF0b21pY19zZXQoJnMtPnJlZ3NbcmVnXSwg
dmFsdWUpOwogICAgIGlmIChwY3ljbGVfZW5hYmxlKSB7CiAgICAgICAgIHMtPmdfcGN5Y2xlX2Jh
c2UgPSAwOwogICAgICAgICBpZiAocy0+cGN5Y2xlX3J1bm5pbmcpIHsKQEAgLTI4MSw2ICsyODEs
MTEgQEAgc3RhdGljIHZvaWQgc2V0X3JlZ192YWx1ZShIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMs
IHVpbnQzMl90IHJlZywKICAgICB9CiB9CiAKK3VpbnQzMl90IGhleGFnb25fZ2xvYmFscmVnX3Jl
YWRfc3lzY2ZnX3VubG9ja2VkKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcykKK3sKKyAgICByZXR1
cm4gcyA/IHFhdG9taWNfcmVhZCgmcy0+cmVnc1tIRVhfU1JFR19TWVNDRkddKSA6IDA7Cit9CisK
IHVpbnQzMl90IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpz
LCB1aW50MzJfdCByZWcsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IGh0aWQpCiB7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhh
Z29uL2NwdS5jCmluZGV4IDI4MWQyMDEyNTBiLi42MDdkZGRmN2U3YyAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTU3MiwxMSAr
NTcyLDE0IEBAIHN0YXRpYyBpbnQgaGV4YWdvbl9jcHVfbW11X2luZGV4KENQVVN0YXRlICpjcywg
Ym9vbCBpZmV0Y2gpCiAgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOwogICAg
IGludCBjcHVfbW9kZTsKIAotICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgLyoKKyAgICAgKiBO
byBCUUw6IHRoaXMgcnVucyBmb3IgZXZlcnkgdHJhbnNsYXRpb24gYmxvY2sgbG9va3VwLCBhbmQg
dGhlIHZDUFUKKyAgICAgKiB0aHJlYWRzIHdvdWxkIG90aGVyd2lzZSBxdWV1ZSB1cCBvbiBpdC4g
IFNZU0NGRyBpcyByZWFkIGF0b21pY2FsbHkgYW5kCisgICAgICogdGhlIHJlc3QgaXMgdGhpcyB2
Q1BVJ3Mgb3duIHN0YXRlLgorICAgICAqLwogICAgIGlmIChjcHUtPmdsb2JhbHJlZ3MpIHsKICAg
ICAgICAgdWludDMyX3Qgc3lzY2ZnID0KLSAgICAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3Jl
YWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19TWVNDRkcsCi0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpOworICAgICAgICAgICAgaGV4YWdvbl9nbG9i
YWxyZWdfcmVhZF9zeXNjZmdfdW5sb2NrZWQoY3B1LT5nbG9iYWxyZWdzKTsKICAgICAgICAgdWlu
dDhfdCBtbXVlbiA9IEdFVF9TWVNDRkdfRklFTEQoU1lTQ0ZHX01NVUVOLCBzeXNjZmcpOwogICAg
ICAgICBpZiAoIW1tdWVuKSB7CiAgICAgICAgICAgICByZXR1cm4gTU1VX0tFUk5FTF9JRFg7Ci0t
IAoyLjM0LjEKCg==

