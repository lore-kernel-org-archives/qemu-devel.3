Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B71606A8AB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MxRU+Ctc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FjoWpZqK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYlW-00084Y-LQ; Thu, 12 Nov 2026 12:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRYlS-00080E-6V
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:39:10 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRYlQ-0008Bk-Fd
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:39:09 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZsJR2594936
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 17:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mAmgxng6QsaxviVufYMODTm7SMF1D5pcfDD1zPV8rL8=; b=MxRU+Ctc6b7hubsn
 1NEjZ6LRCzcvhEmgADYgmXQ+rWTLWBhFW6vAsdMZB86OR4Imf6N/2P5nCRelrKWD
 RHMInljgg00hh5ApCxpL9VljXP6I4MpGvucZ/wJXq6ignF+Cof9a+ce62icruriR
 Z5id9jZJPfUDIKvu5hiyTHjBa8YMT0S3SeLQ/2SDhGaDdFd1glmY9YEOM9wWrfAR
 33Bu0JzywSJ8ZJVbIK96Sk3+N61RQ9fqgLwkkJuGofnT6z52xKHMyzfZixAel+dU
 fQo79RUV5A6Y6+1AlXFc6ipO2vig8M8znqAhNrQ+xuNRN/WWWeOz7A27lnsCO9bj
 P5FDOg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx31ju3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 17:39:06 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so1734875c88.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794505146; x=1795109946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mAmgxng6QsaxviVufYMODTm7SMF1D5pcfDD1zPV8rL8=;
 b=FjoWpZqKR3CdvZ4SkU/XBBa7Uy9Uw7PdmPrt5Dirxet/I15dmk6o1HjRw2QGp6/LYA
 gKLzKeC5nSfWdjvmnaT40kOwbonZIOk35pAhAbRGOxBv9gF1fLpmbRkLN2FGM7tcAz7F
 HWWkHs7I1gZ9BWVJUUfkbc3S7nZ/yUDTZ/1c2NMNiOD+/BGyawr3Q0O5Quo3kbNNeHGG
 CLc3XEo8EQXVM14xf3oeVe3TPCCgDFMp/q1UxNEhb5VQWQG5dq9lWZnGR2NnLIgeIJZE
 txpaVBZm1yUTWetCWKCrFbxRMmyR+WfrTkwOYUOzwUuXZ7pDu2OydEoPBA3w1UtLHL5q
 MgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505146; x=1795109946;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mAmgxng6QsaxviVufYMODTm7SMF1D5pcfDD1zPV8rL8=;
 b=gmyeH1mzpLk8w4QZp7PZkylhMErSvrdbihZvHXME0fQF+fVtn6zc3JLQmPeO8mnyqW
 MuRwFN8X18Waoor0KMQBwTqNAaE9c8tVCKHXu1n4n/p/OaVF/gd44wbGlMdcvz8S2qfk
 mFChLVD1qlX7Z4UK4XQotdDf2llLsxALtmT3Wa154pVkoTEfSY6N7g/bYztjWxzXY4HY
 kZQrG/FrbQ+W0GquYDrpO4GlygcyfMBKsxr2fIkiIOjFMVKPTHxQYDcfBqGZNh6lYok8
 OmfNwh6Nw9f227kc1Bjr2WxRc954qGSOzZI3NRhGZwky3DnbARSo9vjgKqzeVd1G4Otw
 TCrA==
X-Gm-Message-State: APuU4Z91Hh3cdHmUaOrCWPEiqP85TpG6rfLaFbAB1f5Y79TVD3eo8yxH
 7RXK2aksTEHp/qbF4vRtiAnPW02ucaFPS3ql8TYiQvujyCxSfDrOHyHM/7GLK1RldNIju4o7fGY
 uxnC5eM7zDVKxV+iGSP18IPzKNQIWS7uMYu7b4lnn6oDIumbEyw7zPrxNwu9HsAWABg==
X-Gm-Gg: AYBFou3XcchNOiQNCC6Yeg5AQzqQ+U82K5n6cDca7XoeUYAuHM9+36F96WXqy3CDMCw
 Ec34Swy31TjbQsga6cGp8Kd+KP53TpZUqwYiT599dx3GThnmHNSJfQRsCodnXbcFvy+AXzkRrat
 P8bO+g4GoJaHps5/cdnaI2xbLgbSsqY33BOu1/KaoghtY+nMot9eC61660wwfwvLuWR7qzX/Jt2
 Dr7sSTsOMHTn2887thqMUaO9ojbxAd7EOlqh8zb4mjPqkcCWwWo78ncTtNA9AVLOU3Ml/N/O5Vw
 5U+cJWSpGndoS7Yvk2tTV+RhQ2q84QdY54aj7CUqCkSqW+GpBOm6tb+A8Zvc58RDfiqFVfEm8o4
 S5HeSdzxkkD4h7G+H5i6BM4mxVbbAgHsiPUbr47SjlREmrdrLAQKAQ/MDOHxZe1TiBB+acNhgFJ
 hvYW2zaDStV83DO3JNBz2r
X-Received: by 2002:a05:7022:ea8b:b0:1b2:60ab:1e9d with SMTP id
 a92af1059eb24-1b503179d36mr164778c88.37.1794505146011; 
 Thu, 12 Nov 2026 09:39:06 -0800 (PST)
X-Received: by 2002:a05:7022:ea8b:b0:1b2:60ab:1e9d with SMTP id
 a92af1059eb24-1b503179d36mr164707c88.37.1794505144139; 
 Thu, 12 Nov 2026 09:39:04 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm693020c88.9.2026.11.12.09.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:39:03 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 1/2] roms: record the H2 commit in a file
Date: Thu, 12 Nov 2026 09:39:00 -0800
Message-Id: <20261112173901.3748880-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112173901.3748880-1-brian.cain@oss.qualcomm.com>
References: <20261112173901.3748880-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af5f9ba cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=XaHQkwRCKzGNWppSFL0A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfX5qLv4z+/X/WI
 XcsCcd0UiqP8WA8lfcgHK7pd3d867ve+4T/aSw3+sXbkc5tei6PtNxa5ecA+JWBUZBT62ImUpT1
 9Z4t3zCTeSR7C2lKP4oNr+fKSZwMwFuQVtfXrVDsKvVwJSK6r+NYBYgV+puKacExq2Kwt4j+8nB
 U0EmG8rUGb1na3l2lfJzKTh1DyvicsPuFaZmVX7uz9/ZbbVAmN0bHOjp1mfkzQw/f1DZjN6FF3O
 JPFVmcztWzMUT7cEFVaWklzYNbkLQ1+aqwhOSBTngwnqQLA2I8acvVluLfR0N4QDFgH9VYgxANw
 J7HSmP4VGi28d071jiKNaCQybCK4+z248++AX7T4mjvSARSi4oi1o+y+kjmIpEoUW+80zX3IjxJ
 +UGFKANif4eJsdum8UjpbhTiByA8ipADHLLV8bxy91XCVe5wsk5SW2GLX/u7yoKCTteH+vSlUWv
 1dcmnmoS0782cVLqnHw==
X-Proofpoint-ORIG-GUID: lRnBQOn-dGMBNvQM2TZcYbrLdXMoF4Be
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfXxX4DtCdxDPAA
 hhNT3p5PQEJdRPtfx3CfzTSpFH4v3/nIG20DLVXu98C4AcYrXaVzieoEWa6cJGzLmgv5j4nIYdc
 zBY1fYyCOD91o+7Zr2oS4TuLljX/aVg=
X-Proofpoint-GUID: lRnBQOn-dGMBNvQM2TZcYbrLdXMoF4Be
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120070
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

VGhlIEgyIGJ1aWxkIElEIHdhcyBkZXJpdmVkIGJ5IHJ1bm5pbmcgYGdpdCByZXYtcGFyc2VgLCB3
aGljaCBmYWlscyB3aGVuCmJ1aWxkaW5nIGZyb20gYSBzb3VyY2UgdGFyYmFsbC4gIExlYXZpbmcg
SDJLX0dJVF9DT01NSVQgYXMgIjB4IiBkb2VzCm5vdCBjb21waWxlLgoKSW5zdGVhZCB3ZSdsbCBr
ZWVwIHRoZSBjb21taXQgaW4gYSB0cmFja2VkIGZpbGUsIHJlZ2VuZXJhdGUgaXQgd2hlbiBpdCdz
CmEgc3VibW9kdWxlLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
CiByb21zL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKystLQogcm9t
cy9oZXhhZ29uLWh5cGVydmlzb3ItdmVyc2lvbiB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMTMg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCByb21zL2hl
eGFnb24taHlwZXJ2aXNvci12ZXJzaW9uCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUwppbmRleCBmYTBjNmQwYzliYy4uZGYyNjRjMzA3NTMgMTAwNjQ0Ci0tLSBhL01BSU5U
QUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0xMzk5LDYgKzEzOTksNyBAQCBGOiB0ZXN0cy9x
dGVzdC9xY29tLWRzcC10ZXN0LmMKIEY6IGRvY3MvZGV2ZWwvaGV4YWdvbi1zeXMucnN0CiBGOiBw
Yy1iaW9zL2hleGFnb24qCiBGOiByb21zL2hleGFnb24taHlwZXJ2aXNvcgorRjogcm9tcy9oZXhh
Z29uLWh5cGVydmlzb3ItdmVyc2lvbgogCiBMb29uZ0FyY2ggTWFjaGluZXMKIC0tLS0tLS0tLS0t
LS0tLS0tLQpkaWZmIC0tZ2l0IGEvcm9tcy9NYWtlZmlsZSBiL3JvbXMvTWFrZWZpbGUKaW5kZXgg
YmFlOGYzYjc2NmIuLjJjYmFiMmQxOTkzIDEwMDY0NAotLS0gYS9yb21zL01ha2VmaWxlCisrKyBi
L3JvbXMvTWFrZWZpbGUKQEAgLTIyNiwxMSArMjI2LDIwIEBAIGhleGFnb25faDJfYm9vdGVycyA6
PSBoZXhhZ29uLWJvb3Rlci1xY3M2NDkwLWNkc3AgXAogaGV4YWdvbl9oMl9sb2FkbGludXggOj0g
aGV4YWdvbi1sb2FkbGludXgtcWNzNjQ5MC1jZHNwIFwKIAloZXhhZ29uLWxvYWRsaW51eC1zbTg5
NzUtbnNwIGhleGFnb24tbG9hZGxpbnV4LXNhODc3NXAtY2RzcCBcCiAJaGV4YWdvbi1sb2FkbGlu
dXgtc2M4NDgweHAtbnNwMCBoZXhhZ29uLWxvYWRsaW51eC1zYTg3OTdwLW5zcDAKKy1pbmNsdWRl
IGhleGFnb24taHlwZXJ2aXNvci12ZXJzaW9uCisKK2hleGFnb24taHlwZXJ2aXNvci12ZXJzaW9u
OiBoZXhhZ29uLWh5cGVydmlzb3IKKwlpZiB0ZXN0IC1lIGhleGFnb24taHlwZXJ2aXNvci8uZ2l0
OyB0aGVuIFwKKwkJZWNobyAiSDJLX0NPTU1JVCA9ICQkKGdpdCAtQyBoZXhhZ29uLWh5cGVydmlz
b3IgcmV2LXBhcnNlIEhFQUQpIiA+ICRAOyBcCisJZWxzZSBcCisJCXRvdWNoICRAOyBcCisJZmkK
KwogaGV4YWdvbl9oMl9jb21tb25fZmxhZ3MgPSBVU0VfUEtXPTAgVEFSR0VUPW9wdCBOVUxMX0FO
R0VMX1RSQVA9MSBcCiAJSE1YX0hMWF9TVVBQT1JUPTEgXAogCUgyS19MT0FEX0FERFI9MHg5Yjgw
MDAwMCBIMktfR1VFU1RfU1RBUlQ9MHhhMjAwMDAwMCBcCi0JSDJLX0dJVF9DT01NSVQ9MHgkKHNo
ZWxsIGdpdCAtQyBoZXhhZ29uLWh5cGVydmlzb3IgcmV2LXBhcnNlIC0tc2hvcnQ9OCBIRUFEKSBc
Ci0JSDJLX0dJVF9DT01NSVRfTE9ORz0weCQoc2hlbGwgZ2l0IC1DIGhleGFnb24taHlwZXJ2aXNv
ciByZXYtcGFyc2UgSEVBRCkgXAorCUgyS19HSVRfQ09NTUlUPTB4JChzaGVsbCBlY2hvICQoSDJL
X0NPTU1JVCkgfCBjdXQgLWMxLTgpIFwKKwlIMktfR0lUX0NPTU1JVF9MT05HPTB4JChIMktfQ09N
TUlUKSBcCiAJSkZMQUc9LWokKHNoZWxsIG5wcm9jKQogCiAuUEhPTlk6IGhleGFnb24tcWNzNjQ5
MC1jZHNwIGhleGFnb24tc204OTc1LW5zcCBcCmRpZmYgLS1naXQgYS9yb21zL2hleGFnb24taHlw
ZXJ2aXNvci12ZXJzaW9uIGIvcm9tcy9oZXhhZ29uLWh5cGVydmlzb3ItdmVyc2lvbgpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNGFlYWJkYzdkMGUKLS0tIC9kZXYvbnVs
bAorKysgYi9yb21zL2hleGFnb24taHlwZXJ2aXNvci12ZXJzaW9uCkBAIC0wLDAgKzEgQEAKK0gy
S19DT01NSVQgPSAyM2Q1YmRlNDMxM2MxZTYzYmE2NGRkNWQ3ZjU0MmIxMDU1MTg4ZWY4Ci0tIAoy
LjM0LjEKCg==

