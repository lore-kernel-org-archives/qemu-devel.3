Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4BA606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L8QS2/Qk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PQ8gStAY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFhN-0007qZ-MZ; Thu, 19 Nov 2026 22:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhL-0007q2-QT
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhK-0000Sq-1B
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:03 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK3VE1b2143503
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Q11qim6A68ugLybWCAxGHuZs/L6e0SswgjJt08qFws=; b=L8QS2/Qkmma7cvCS
 0zeCD8tTj5K2b9PFDjDk6Uh1WVz9YuPGwJck4QsapiM/rWg2Z/rapqCzv5ARhrkh
 CAZKIMyQ8rS6oh0UAttD+BTxC27gSWCK8Z2QFP7ApY41GkaadOe82cUhju+yhxDR
 DSG/iODBvhA4bLVDKBQYfP05KdTIgPmFwMoI8I90QGgu7mzSDPgzkqRk1FzIm8yA
 oanQ9jqGBJu1RNkiNf/GsLwUX2ErQaFQlHGU58yjYopvy1Vn45kvfjyLkhiz3uRd
 rM9QKYJ0ocvBRV5L77DqjSJo81Mknw5JTQ1jjIPftUy15IWz1XghTI3rWFe1egMn
 ESZ0Hg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au1pxv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-375bac6bd21so437475eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795146839; x=1795751639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Q11qim6A68ugLybWCAxGHuZs/L6e0SswgjJt08qFws=;
 b=PQ8gStAYzS5arQ/9SMXZ8jm9EYIY7cnV4oN0HQ9QX/GJ0hoHs7b8kczcj+Gw204cVY
 n1nHh8a3wjRxonU+n3G4F4g8uKRFmXPqvNl5vgfpk7UZPwVU58ZOV9el64VZb2V8c/Ms
 nRp251a9fCdvT1yDUAygU2bGQSfhb+HyBpg5oDmclpzkPNnkg9GaaNnqXVjZNmNLOj6p
 1LmxXWPSmcxDnF1lGpJdOd6T+O9tiroHDtl0VNgjMcEIbFPszLpuBex66Nur6kxas4FU
 v1VGFYnemDMNr3SuOQFQTGmcBRhi0yUZBNjPgODHXnOBcpIipTczoOmA+fF1FXTrCFmS
 04xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795146839; x=1795751639;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Q11qim6A68ugLybWCAxGHuZs/L6e0SswgjJt08qFws=;
 b=UQCBAq2QOoTlaQ6x5uqrBowQTpLsmW5fVWWBf4sffYUXyfVHv51g5sWMfAcgA54hM5
 fRyeu69GcIFUUSaPY90obaKC3+1vJZsiMaDUZO56DBo+/d3dlhf3b14kSBmqLQR5yiuP
 AnuEg/pxY5aZ/QEd2uw5GkhCPm9SgzLX9QeBVgDFvEzyywbkW/xXWN/PSHP0x35jaPGx
 K76kdQmDcxBKxRggtJ5HjuIcS2BL6Xyd01QyYjxKoYmFm34mHxR5hCX3FXf5H9cJ42vF
 gRfm2bXEB9bVHBW9oXhCleOIeK1UxeO+c6X98ziHeLPEpNdX8J72/Msv8HQ0qo4ZRczC
 /mgQ==
X-Gm-Message-State: APuU4Z8FXSwhNmHZRmrKapXcPFNN7wrSIATDX0g1gDhDxoHSG6Oj5Qr/
 j4z3UWHQMsxp85YWmV9io0yfMGTsJ/Q/tFHQ9OK7ke2g0g3LvKrE4i8TwvWXwucoQYBCu6sF9YN
 HWnlyROAngBBFPbz98VTnagxXUVrxokrJ2FgrMjNJ3TXKfS/sh6k5ZJH3jZ2wtW0jbw==
X-Gm-Gg: AZFdTZdFhqY0HUvF2sZy9T12z71yngJZmiLqdRLGR+2x/u9CmEth6Xj7gCg08YILuKo
 6A26hwokfIPQfC0BI5WQdecU+O3B80bqIsTFrjenZIvKxOfyCloHCEed9cgpRyMvmxCBY+zCZek
 aQYKbJ1nyiaPfJ2TKBMVB5z7gu2jiTCQ45acGc+T2RHWdo9cahWffZQ437XplvtKLXtDUMILckT
 NH5vyj8yAia47KsjBn0iulbV2MTW+EBLCdGxoPorcdfix3s36cPZGpOuXBdaJiYqWkI+OvlC7Sd
 mhGoxglVDXJp2ocQMvSsyg55AG3v5ekd4bTPV4ank/8HIurUlBQsh0eIN9b3YiwVk2nnsA6wGn1
 zeWL2KVvnnXaszSi0mrDYBCeMwKNZ8tNvZztnF2Z7UpmAfKgNUO5BqPEUVyOs2sw63Hc2WpVKBf
 fqaosAkt3MZYqBGjSOk4P7
X-Received: by 2002:a05:7300:e9c4:20b0:383:6f73:eb34 with SMTP id
 5a478bee46e88-3856c6b00fdmr1693801eec.2.1795146839133; 
 Thu, 19 Nov 2026 19:53:59 -0800 (PST)
X-Received: by 2002:a05:7300:e9c4:20b0:383:6f73:eb34 with SMTP id
 5a478bee46e88-3856c6b00fdmr1693778eec.2.1795146838578; 
 Thu, 19 Nov 2026 19:53:58 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm3854126eec.4.2026.11.19.19.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:53:57 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 1/8] roms: record the H2 commit in a file
Date: Thu, 19 Nov 2026 19:53:46 -0800
Message-Id: <20261120035353.3215703-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
References: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX8IHN8LYs4hcV
 AtDjHSdKLoeg9D2Q/wDfc/AuWOmCXmy5X4ggHn1UoME+bsgmL2EQghLmZ1pB0deBMSy7Nr2qvZi
 TdjZPUfV0LWADvS8QlKGxyKc5LC8BcU3JBqZRcwN0fhZF10ihNDlQII5uXiQM8dgJQJruDaWq62
 ebjmyJvnjR94afy49sh/Uz1jqvWPja/2AFYvXb/KxczJJCiuNTwxC/o+0MJeBeiEG0fRnT5yEWu
 J1o6Ma5hkt3NF5LClv8P0nqjDKgCTtD8ExqQgGZP2URjdpMQh2b3e3GO4LCfqPzCkJgeeO8geqw
 LKWAIjdt/q30W29TI7BL9L1D7Oi/lcszbKN0us7lf/6YMXICRtmNYe5u9ar3NVh1zLQCpEqnHLd
 1oWxJHaHDT1b6bjkM6tEgMepNPmTl7DQEBcQfrjBNcWdcgsGWTgbGZrTfsHZG7JI6UXexNgKFZN
 9iSEOCt1e+bOP5DXSJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX4zlWhJh1f8L4
 kdqbeWiJ2nU8tZybKoUzpsnSi6YCZjxPQljA1t8u0Ix8rS0wrAfeCwz60b5270wF2NZ417/a0fV
 Cc6CUuNOPX7J3q5TdZHPVirVqt0xLy0=
X-Proofpoint-ORIG-GUID: C0u5kUwLsElOnNqorxy62ObQVo1LMRgg
X-Proofpoint-GUID: C0u5kUwLsElOnNqorxy62ObQVo1LMRgg
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6affc458 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=9qUTvQc-AAAA:8 a=EUspDBNiAAAA:8 a=6TPXupxyv9tJbjdrH94A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200015
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

VGhlIEgyIGJ1aWxkIElEIHdhcyBkZXJpdmVkIGJ5IHJ1bm5pbmcgYGdpdCByZXYtcGFyc2VgLCB3
aGljaCBmYWlscyB3aGVuCmJ1aWxkaW5nIGZyb20gYSBzb3VyY2UgdGFyYmFsbC4gIExlYXZpbmcg
SDJLX0dJVF9DT01NSVQgYXMgIjB4IiBkb2VzCm5vdCBjb21waWxlLgoKSW5zdGVhZCwga2VlcCB0
aGUgY29tbWl0IGluIGEgdHJhY2tlZCBmaWxlIGFuZCBhbHdheXMgYnVpbGQgZnJvbSBpdC4KV2hl
biB0aGUgc3VibW9kdWxlIGlzIGNoZWNrZWQgb3V0LCBmYWlsIHRoZSBIMiBidWlsZCBpZiBpdHMg
SEVBRCBkb2VzCm5vdCBtYXRjaCB0aGUgcmVjb3JkZWQgY29tbWl0LCBzbyBhIHN1Ym1vZHVsZSB1
cGRhdGUgd2l0aG91dCBhIG1hdGNoaW5nCnVwZGF0ZSBvZiB0aGUgZmlsZSBpcyBjYXVnaHQuCgpS
ZXZpZXdlZC1ieTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT4KUmV2aWV3ZWQtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2ln
bmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0K
IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgfCAgMSArCiByb21zL01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrLS0tLQogcm9tcy9oZXhhZ29u
LWh5cGVydmlzb3ItdmVyc2lvbiB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCByb21zL2hleGFnb24taHlw
ZXJ2aXNvci12ZXJzaW9uCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwpp
bmRleCAzYTliNGQzNGEwZi4uNDBiZjYzNjUxYzEgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisr
KyBiL01BSU5UQUlORVJTCkBAIC0xNDAwLDYgKzE0MDAsNyBAQCBGOiB0ZXN0cy9xdGVzdC9xY29t
LWRzcC10ZXN0LmMKIEY6IGRvY3MvZGV2ZWwvaGV4YWdvbi1zeXMucnN0CiBGOiBwYy1iaW9zL2hl
eGFnb24qCiBGOiByb21zL2hleGFnb24taHlwZXJ2aXNvcgorRjogcm9tcy9oZXhhZ29uLWh5cGVy
dmlzb3ItdmVyc2lvbgogCiBMb29uZ0FyY2ggTWFjaGluZXMKIC0tLS0tLS0tLS0tLS0tLS0tLQpk
aWZmIC0tZ2l0IGEvcm9tcy9NYWtlZmlsZSBiL3JvbXMvTWFrZWZpbGUKaW5kZXggYmFlOGYzYjc2
NmIuLmJjZGU2ODM1ODUxIDEwMDY0NAotLS0gYS9yb21zL01ha2VmaWxlCisrKyBiL3JvbXMvTWFr
ZWZpbGUKQEAgLTIyNiwxMSArMjI2LDI1IEBAIGhleGFnb25faDJfYm9vdGVycyA6PSBoZXhhZ29u
LWJvb3Rlci1xY3M2NDkwLWNkc3AgXAogaGV4YWdvbl9oMl9sb2FkbGludXggOj0gaGV4YWdvbi1s
b2FkbGludXgtcWNzNjQ5MC1jZHNwIFwKIAloZXhhZ29uLWxvYWRsaW51eC1zbTg5NzUtbnNwIGhl
eGFnb24tbG9hZGxpbnV4LXNhODc3NXAtY2RzcCBcCiAJaGV4YWdvbi1sb2FkbGludXgtc2M4NDgw
eHAtbnNwMCBoZXhhZ29uLWxvYWRsaW51eC1zYTg3OTdwLW5zcDAKK2luY2x1ZGUgaGV4YWdvbi1o
eXBlcnZpc29yLXZlcnNpb24KKworLlBIT05ZOiBoZXhhZ29uLWh5cGVydmlzb3ItY2hlY2sKK2hl
eGFnb24taHlwZXJ2aXNvci1jaGVjazoKKwlAaWYgdGVzdCAtZSBoZXhhZ29uLWh5cGVydmlzb3Iv
LmdpdDsgdGhlbiBcCisJCWgyX2hlYWQ9JCQoZ2l0IC1DIGhleGFnb24taHlwZXJ2aXNvciByZXYt
cGFyc2UgSEVBRCk7IFwKKwkJaWYgdGVzdCAiJCRoMl9oZWFkIiAhPSAiJChIMktfQ09NTUlUKSI7
IHRoZW4gXAorCQkJZWNobyAiaGV4YWdvbi1oeXBlcnZpc29yIGlzIGF0ICQkaDJfaGVhZCwgYnV0
IiBcCisJCQkJInJvbXMvaGV4YWdvbi1oeXBlcnZpc29yLXZlcnNpb24gaGFzIiBcCisJCQkJIiQo
SDJLX0NPTU1JVCkiID4mMjsgXAorCQkJZXhpdCAxOyBcCisJCWZpOyBcCisJZmkKKwogaGV4YWdv
bl9oMl9jb21tb25fZmxhZ3MgPSBVU0VfUEtXPTAgVEFSR0VUPW9wdCBOVUxMX0FOR0VMX1RSQVA9
MSBcCiAJSE1YX0hMWF9TVVBQT1JUPTEgXAogCUgyS19MT0FEX0FERFI9MHg5YjgwMDAwMCBIMktf
R1VFU1RfU1RBUlQ9MHhhMjAwMDAwMCBcCi0JSDJLX0dJVF9DT01NSVQ9MHgkKHNoZWxsIGdpdCAt
QyBoZXhhZ29uLWh5cGVydmlzb3IgcmV2LXBhcnNlIC0tc2hvcnQ9OCBIRUFEKSBcCi0JSDJLX0dJ
VF9DT01NSVRfTE9ORz0weCQoc2hlbGwgZ2l0IC1DIGhleGFnb24taHlwZXJ2aXNvciByZXYtcGFy
c2UgSEVBRCkgXAorCUgyS19HSVRfQ09NTUlUPTB4JChzaGVsbCBlY2hvICQoSDJLX0NPTU1JVCkg
fCBjdXQgLWMxLTgpIFwKKwlIMktfR0lUX0NPTU1JVF9MT05HPTB4JChIMktfQ09NTUlUKSBcCiAJ
SkZMQUc9LWokKHNoZWxsIG5wcm9jKQogCiAuUEhPTlk6IGhleGFnb24tcWNzNjQ5MC1jZHNwIGhl
eGFnb24tc204OTc1LW5zcCBcCkBAIC0yNjQsNyArMjc4LDcgQEAgaGV4YWdvbi1sb2FkbGludXgt
c204OTc1LW5zcCBoZXhhZ29uLWxvYWRsaW51eC1zYTg3NzVwLWNkc3AgXAogCWhleGFnb24tbG9h
ZGxpbnV4LXNjODQ4MHhwLW5zcDAgaGV4YWdvbi1sb2FkbGludXgtc2E4Nzk3cC1uc3AwOiBcCiAJ
aGV4YWdvbl9oMl9saW51eF9mbGFncyA9IExJTlVYX0xJTktfQUREUj0weGEwMDAwMDAwCiAKLSQo
aGV4YWdvbl9oMl9ib290ZXJzKTogaGV4YWdvbi1ib290ZXItJToKKyQoaGV4YWdvbl9oMl9ib290
ZXJzKTogaGV4YWdvbi1ib290ZXItJTogaGV4YWdvbi1oeXBlcnZpc29yLWNoZWNrCiAJcm0gLXJm
ICQoaGV4YWdvbl9oMl9vdXQpL2Jvb3Rlci0kKgogCSQoTUFLRSkgLUMgaGV4YWdvbi1oeXBlcnZp
c29yICQoaGV4YWdvbl9oMl9jb21tb25fZmxhZ3MpIFwKIAkJJChoZXhhZ29uX2gyX21hY2hpbmVf
ZmxhZ3MpIFwKQEAgLTI3Myw3ICsyODcsNyBAQCAkKGhleGFnb25faDJfYm9vdGVycyk6IGhleGFn
b24tYm9vdGVyLSU6CiAJCSQoaGV4YWdvbl9oMl9idWlsZCkvYm9vdGVyLSQqL2luc3RhbGwvYmlu
L2Jvb3RlcgogCWNobW9kIC14IC4uL3BjLWJpb3MvaGV4YWdvbl9ib290ZXJfJChzdWJzdCAtLF8s
JCopCiAKLSQoaGV4YWdvbl9oMl9sb2FkbGludXgpOiBoZXhhZ29uLWxvYWRsaW51eC0lOgorJCho
ZXhhZ29uX2gyX2xvYWRsaW51eCk6IGhleGFnb24tbG9hZGxpbnV4LSU6IGhleGFnb24taHlwZXJ2
aXNvci1jaGVjawogCXJtIC1yZiAkKGhleGFnb25faDJfb3V0KS9sb2FkbGludXgtJCoKIAkkKE1B
S0UpIC1DIGhleGFnb24taHlwZXJ2aXNvciAkKGhleGFnb25faDJfY29tbW9uX2ZsYWdzKSBcCiAJ
CSQoaGV4YWdvbl9oMl9tYWNoaW5lX2ZsYWdzKSBcCmRpZmYgLS1naXQgYS9yb21zL2hleGFnb24t
aHlwZXJ2aXNvci12ZXJzaW9uIGIvcm9tcy9oZXhhZ29uLWh5cGVydmlzb3ItdmVyc2lvbgpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNGFlYWJkYzdkMGUKLS0tIC9kZXYv
bnVsbAorKysgYi9yb21zL2hleGFnb24taHlwZXJ2aXNvci12ZXJzaW9uCkBAIC0wLDAgKzEgQEAK
K0gyS19DT01NSVQgPSAyM2Q1YmRlNDMxM2MxZTYzYmE2NGRkNWQ3ZjU0MmIxMDU1MTg4ZWY4Ci0t
IAoyLjM0LjEKCg==

