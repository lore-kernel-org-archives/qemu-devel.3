Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD7C606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=osimilI0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NsVQWPzS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIzL-0003j5-9p; Wed, 25 Nov 2026 14:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWIzJ-0003iE-TD
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:49:05 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWIzH-0006LF-NZ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:49:05 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APJB8c1816456
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4GTXHPtkLKXncWqcUt2bdy9PRhp9Lx3kp/biz250es8=; b=osimilI05yHnX0gE
 u3rQUL+RlTeQV4bjZFAE/P3DVFd6hZJTheiKWUBSygyRDYMJ0ESzH48H7LchsDm8
 OSHGAfJhpsLKgud9xy2WA8NBopx7J/xIsESO70WMYSC5WBKl1GJUVUKL6cRyHfeP
 xfhHif6iZXEMDEWvBxs6EDN0ppLiiSwWWihOf+TW/FZ8nW5K2HOPQvwfxFjExbpM
 kxe3QvjlInqZliYqXNaP6TfYKZ7jb5Y8s3Y11krnEHErAfj6yAGGB+wpqQufKcOU
 qIU3j8FL9ncRHQEMnXu4aUWNYkcrWxImN+s85P1duVaOejjHYj7zuEoiktqJF+FC
 DEjVXA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2thqp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:49:02 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1af203073e0so6685941c88.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795636141; x=1796240941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4GTXHPtkLKXncWqcUt2bdy9PRhp9Lx3kp/biz250es8=;
 b=NsVQWPzSTt0Pnccy69exnJwbyBvCHkEaco+S+m1ioApxEXDBNoQW1V5eJFPMqteG73
 mF6wnsGK0NYN+aePcEU//HpVw/dT7CNBkMHEillmDAl1S0zCtdeMaKjYgwV2hY39jTXF
 zfLf6Gf7qC3BZatTDkGB6Pah5uGqjd09bevPNIBUPLJbAmQ07V/SLhoC/b+XCBR/ZwSU
 OdrpQGpF2CVyfF5Aj8DmWr/KvlRHPvHV5FwtNE5zbs4nq5c9buaz8Q2IND6ARKmh4POS
 MoYq+fMPGKl8v6tlclIYxr4eK9OhGlduwCj1EmTq/fHoguRZ6J/6RXMD+u2jjYM6QBuN
 nODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795636141; x=1796240941;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4GTXHPtkLKXncWqcUt2bdy9PRhp9Lx3kp/biz250es8=;
 b=F+1PIXgfcGa5+ED/f3ivtDyfqnyaB7XtK9Tm4vAc0/Zo7KO3Cf6FQKlcLbkfkSqTpL
 5VrRaRXDG9lIuLvGAUmspeLFjTiLkQdM3ypkVg9BtxGajtxDVCWDDdisUPIY7Symw4Sm
 u5L4I4apyTBddRHBOa2ylDRHojmvSWJtG+CRTGY+AEWbu/MUxz8KR2owIkO151as6zIR
 TKqJgX2OgcqHRgW2cw7nJ6NZZLI9pCSQC5Y9mzCPdgy6otjA56hXmjf/DxyH/63i1CZY
 MkrUhihmI0ctYrW1WwlaMlPkCMO+gM6qfEJFqM7WmkkQgf7N6Z7OxKP6hpm3wVrO53ZQ
 rf7A==
X-Gm-Message-State: APuU4Z8wcus3WeP/qZAAgN8LWSoffCX3Qhb8qiKyILa/1C2DegHCJEM7
 I/az9ehnqAPMn4NyKzMvG3++Xk2JHdyROlxEhPXqOy6sX9z4W5TJBRuGDIKRlxvfG8A4VNvM3tg
 ivcvphdQDh1GblWX484/4TWLdZ00wAvXYdhHTwNnZjcDqtCoCu1jJuf3c5hZOmnStmA==
X-Gm-Gg: AZFdTZdVR8JDhqDpxkquEJXFYoKoy0Md0dL4U9I+sZhJX1MmPqft0ib++9FAX0Nr37p
 SHNuQfj8E38PrONCpPi+BHU+09+Gk0K8Z05KS2AcD7DSQl1ujGq/iAD3pfo6506bs061KTqAXlT
 6puFyEgAlqI3obTF0d+f+OZiQ81YRAI8e/oVcxM2WzQQIl92pkey+Xv9fBWRZ4FTc0peuXjlWP8
 Sg0ViYfDoOlUibsE8rR6BXtz5/VTghckHzIVmoQa7//Rncoa2AhUdWYHPxRnZp82p0oK+4dj/2J
 huCrqcwnUkgyeLgVGpCa/J6SOBZKDEMu06xjTnnv7BMiHaUUTmVnkcFb+Qf5wD9mTTdohoU597R
 CRqtJgshBU0u0OKgXNY5vn3J+w/XH5f8qyQQyNXcPb2EPrf6/Oe8zJ3OZsEk5/xiaUUNLSKpQNs
 l2Ii0tEFZ8cXkDLlNAkQiHhA==
X-Received: by 2002:a05:701b:4502:20b0:152:9e88:daaa with SMTP id
 a92af1059eb24-1b55690040amr18538166c88.36.1795636141082; 
 Wed, 25 Nov 2026 11:49:01 -0800 (PST)
X-Received: by 2002:a05:701b:4502:20b0:152:9e88:daaa with SMTP id
 a92af1059eb24-1b55690040amr18538142c88.36.1795636140476; 
 Wed, 25 Nov 2026 11:49:00 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm44407715c88.12.2026.11.25.11.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:48:59 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-12.0 2/5] dump: let targets set e_flags in the ELF core
 header
Date: Wed, 25 Nov 2026 11:48:52 -0800
Message-Id: <20261125194855.3154845-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfXyn8emyReDhIh
 v6KGsx0RDPCQhtfYxRAWIhz2oLiN9f1dRgoe6LPi3+M1Hccgv2+Wpsy56dUO6iE+EN1344xSM/r
 NAyI7diVWLfzv7tWdVo/73QDbwHDv8U=
X-Proofpoint-GUID: jZAIM7bgetMgdy4OMe6WQd5JocaJ1olO
X-Proofpoint-ORIG-GUID: jZAIM7bgetMgdy4OMe6WQd5JocaJ1olO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfX0uSK/Ba/dvZo
 oe3LqvCCaiZP7Sn1HYINbtx9+uoyIumghUjshrLLdcp8ZsDHSNxKzdehDGCFKyF9Wo71ZpwC8b3
 5GtyeHayB/+Tgx+beeUrKJ7pdd1UptviGFN02KHrxrpq61zbSAqQn13ZYArNnKP27iWtwU3azj+
 pc/0uvSxSf+D1CYqQGs7ijMUw/lHC0UXNohQjBj2S//1neiQlst87r5hXwgSYlCVKA71POOS9+j
 2nczcxFBoMcaxzGKQc8DUJc35eeRfAs1Kafng5bjoul6wSwRCS3v5U/v39ec0beVL6rpJQolnoy
 ZG0qm/furJHFUbn4zl+m8e4FfEWQuVsOViHYd7yblfrloSNqbwqW8J1JxgL3j+Nu9Ooi0q+ewV5
 6P43yRmagR4Z27FgrbZ0I/zgU5fcHpPKnAeag5sLX5FYCji5GfeuEjtig38FXumimg9niC7r9FQ
 qRd+S9hAH3/BsY9DEjw==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b073bae cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=d927mnl5WceuBYyLXBcA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250078
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

U29tZSB0YXJnZXRzIGVuY29kZSBtYWNoaW5lIGRldGFpbHMgaW4gdGhlIEVMRiBoZWFkZXIgZV9m
bGFncyBmaWVsZCwKaGV4YWdvbiBmb3IgZXhhbXBsZSBpbmNsdWRzIHRoZSBJU0EgdmVyc2lvbi4K
CkFkZCBhIGRfZmxhZ3MgbWVtYmVyIHRvIEFyY2hEdW1wSW5mbyBhbmQgZW1pdCBpdCBpbiB0aGUg
RUxGezMyLDY0fSBoZWFkZXJzLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvc3lzdGVtL2R1bXAtYXJjaC5oIHwgMSAr
CiBkdW1wL2R1bXAuYyAgICAgICAgICAgICAgICB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXN0ZW0vZHVtcC1hcmNoLmggYi9p
bmNsdWRlL3N5c3RlbS9kdW1wLWFyY2guaAppbmRleCA4NmI5YWUxNWI2YS4uZjQyZTBlNDhjZjUg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvc3lzdGVtL2R1bXAtYXJjaC5oCisrKyBiL2luY2x1ZGUvc3lz
dGVtL2R1bXAtYXJjaC5oCkBAIC0xOCw2ICsxOCw3IEBAIHN0cnVjdCBBcmNoRHVtcEluZm8gewog
ICAgIGludCBkX21hY2hpbmU7ICAgICAgICAgICAvKiBBcmNoaXRlY3R1cmUgKi8KICAgICBpbnQg
ZF9lbmRpYW47ICAgICAgICAgICAgLyogRUxGREFUQTJMU0Igb3IgRUxGREFUQTJNU0IgKi8KICAg
ICBpbnQgZF9jbGFzczsgICAgICAgICAgICAgLyogRUxGQ0xBU1MzMiBvciBFTEZDTEFTUzY0ICov
CisgICAgdWludDMyX3QgZF9mbGFnczsgICAgICAgIC8qIE1hY2hpbmUtc3BlY2lmaWMgZV9mbGFn
cyBvZiB0aGUgRUxGIGhlYWRlciAqLwogICAgIHVpbnQzMl90IHBhZ2Vfc2l6ZTsgICAgICAvKiBU
aGUgdGFyZ2V0J3MgcGFnZSBzaXplLiBJZiBpdCdzIHZhcmlhYmxlIGFuZAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiB1bmtub3duLCB0aGVuIHRoaXMgc2hvdWxkIGJlIHRoZSBtYXhp
bXVtLiAqLwogICAgIHVpbnQ2NF90IHBoeXNfYmFzZTsgICAgICAvKiBUaGUgdGFyZ2V0J3MgcGh5
c21lbSBiYXNlLiAqLwpkaWZmIC0tZ2l0IGEvZHVtcC9kdW1wLmMgYi9kdW1wL2R1bXAuYwppbmRl
eCA2YjU2ODUxNjk2MC4uZGIyOTgzYzI0NjMgMTAwNjQ0Ci0tLSBhL2R1bXAvZHVtcC5jCisrKyBi
L2R1bXAvZHVtcC5jCkBAIC0xNTcsNiArMTU3LDcgQEAgc3RhdGljIHZvaWQgcHJlcGFyZV9lbGY2
NF9oZWFkZXIoRHVtcFN0YXRlICpzLCBFbGY2NF9FaGRyICplbGZfaGVhZGVyKQogICAgIGVsZl9o
ZWFkZXItPmVfdHlwZSA9IGNwdV90b19kdW1wMTYocywgRVRfQ09SRSk7CiAgICAgZWxmX2hlYWRl
ci0+ZV9tYWNoaW5lID0gY3B1X3RvX2R1bXAxNihzLCBzLT5kdW1wX2luZm8uZF9tYWNoaW5lKTsK
ICAgICBlbGZfaGVhZGVyLT5lX3ZlcnNpb24gPSBjcHVfdG9fZHVtcDMyKHMsIEVWX0NVUlJFTlQp
OworICAgIGVsZl9oZWFkZXItPmVfZmxhZ3MgPSBjcHVfdG9fZHVtcDMyKHMsIHMtPmR1bXBfaW5m
by5kX2ZsYWdzKTsKICAgICBlbGZfaGVhZGVyLT5lX2Voc2l6ZSA9IGNwdV90b19kdW1wMTYocywg
c2l6ZW9mKCplbGZfaGVhZGVyKSk7CiAgICAgZWxmX2hlYWRlci0+ZV9waG9mZiA9IGNwdV90b19k
dW1wNjQocywgcy0+cGhkcl9vZmZzZXQpOwogICAgIGVsZl9oZWFkZXItPmVfcGhlbnRzaXplID0g
Y3B1X3RvX2R1bXAxNihzLCBzaXplb2YoRWxmNjRfUGhkcikpOwpAQCAtMTg0LDYgKzE4NSw3IEBA
IHN0YXRpYyB2b2lkIHByZXBhcmVfZWxmMzJfaGVhZGVyKER1bXBTdGF0ZSAqcywgRWxmMzJfRWhk
ciAqZWxmX2hlYWRlcikKICAgICBlbGZfaGVhZGVyLT5lX3R5cGUgPSBjcHVfdG9fZHVtcDE2KHMs
IEVUX0NPUkUpOwogICAgIGVsZl9oZWFkZXItPmVfbWFjaGluZSA9IGNwdV90b19kdW1wMTYocywg
cy0+ZHVtcF9pbmZvLmRfbWFjaGluZSk7CiAgICAgZWxmX2hlYWRlci0+ZV92ZXJzaW9uID0gY3B1
X3RvX2R1bXAzMihzLCBFVl9DVVJSRU5UKTsKKyAgICBlbGZfaGVhZGVyLT5lX2ZsYWdzID0gY3B1
X3RvX2R1bXAzMihzLCBzLT5kdW1wX2luZm8uZF9mbGFncyk7CiAgICAgZWxmX2hlYWRlci0+ZV9l
aHNpemUgPSBjcHVfdG9fZHVtcDE2KHMsIHNpemVvZigqZWxmX2hlYWRlcikpOwogICAgIGVsZl9o
ZWFkZXItPmVfcGhvZmYgPSBjcHVfdG9fZHVtcDMyKHMsIHMtPnBoZHJfb2Zmc2V0KTsKICAgICBl
bGZfaGVhZGVyLT5lX3BoZW50c2l6ZSA9IGNwdV90b19kdW1wMTYocywgc2l6ZW9mKEVsZjMyX1Bo
ZHIpKTsKLS0gCjIuMzQuMQoK

