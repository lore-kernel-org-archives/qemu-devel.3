Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4951C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB6w-0004fs-WD; Wed, 12 Aug 2026 11:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6o-0004UK-LA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6l-0000L5-RR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDboGU3875111
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r5gOWn0iU2Np2OD0qg7EzN8uuJ/lnbIhtPfVZ0n4xk8=; b=ZbRxxVsgDKeXBgTM
 iz6I/iExvlItEUL+f9YTqfHn3dCPHajMRsM5N7rdAw8BG4SkKhV/Sa4RjqcaBKIo
 uTYR5PuLqkaP5baeKW8E9EZveOIWEZ8Fi1/AUi9ygc/71Ch3y204Dnua16VZ7izp
 d/u4DGyMCScCeY8OCg4I93bUeV5aXAs7N17m/+6Z5Hvm/57GthC+0nS0q7aOFckq
 /M4E+Qqt2/Cpz0100SS77FkiJ9aOF5XTS6VL8UFyhreVrs3v4YzXYP0ZEVvZ427N
 Y3R4RKEoTH1Xx0KAT5Ht6qtBPW1YOxNssIY4hNkMIn6bJGLuQ0Uk30AkHngGO2gx
 YXWbOA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1jssw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d04908139bso14711715ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549388; x=1787154188; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r5gOWn0iU2Np2OD0qg7EzN8uuJ/lnbIhtPfVZ0n4xk8=;
 b=eQrF7wb+BfoLcnKnJtax1qPDM1xYZStsWNsjKewHJH3roWC+JD3M43+5pzBBxEXRV3
 p6yBIZJa/bjueo1qaHXMyh8SRvlrjQlNkWBM7lxBunw8054Zd/x99cBadvcvkK6h5Tl/
 8BGHuMq9D/yFUV1rVX/nSuf+GIQOPlzLd1Z8V3jWYJ8zhSJlKyHdoKQH6yezb0LQW9kC
 AhxWWrcvxrPO+T1hgpE1UhiqJ00KwF7cue+3KngNUso3/gwSCHeZn23OdFiSNH/nhqqi
 AKam74lzBgmGoFOZaz6KPW9EETxPfG4mmQ2wFo2JiulQF9c3eROCJ4MZDBx9KYu7rAwk
 SDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549388; x=1787154188;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r5gOWn0iU2Np2OD0qg7EzN8uuJ/lnbIhtPfVZ0n4xk8=;
 b=B1QPSSD4r1N2QPKLgN5TZ9HhsMMESNH/r8tpzjo2yhbyEJUVRqekmqtG35tHg5EDe6
 SCj+L/Vdv5ldnegZV6sJXJ1d4DN0KHQF4FOEMhDmYYlSFv+OA4JaQC83KxUl6CVC94tW
 zZfJ4/RieLSukC3iyGav17x/kcFzV3F7uKO3XwwqKLdtzGOLIeevjkttxZHpxUJB4rSO
 EdFqMOWe0jQ9pwm17GittkcEyc7ydr4vj2ggBusW0KItzfEGI30mgtlNV6iAlfi6CZvX
 h7F777Zep7eBDcMpFXOPJfFZoHMhnnS850JDiuHpbdm/bWfeO976OjCUqve1Lt+udetB
 yFHw==
X-Gm-Message-State: AOJu0YwZJtKjN9Xc/RHfp24f9HWI9U2bYOMXbj7KieNhruJUmezLM4jo
 uGpds4P33eowWn0K31pCfAAb3Ye7DnuId/5OZDFQrG8cJ9D4kpnfUVJm075cFuNmt0y+TO4Xuq3
 d6o+SGyBj97/lKZmL93YhBIC2IftqELTf9PLIOnta61KTbG2I+TLJVACWHGoUxHh68A==
X-Gm-Gg: AR+sD11yPFbKxdxJurKLPw/8Ae7zUrPqSkSQQGMLWdIdm0VGnCbDsYZ/ox1jGNHy7Qs
 OBtOdNuBQu3mSXv7t3p3HKyJAj6nUp5MJ35t15OIuaCmWul3dYXh/NZIk3V9021mLmCKixXdRkM
 hDYYUJhJgIOPhjxSwSneg2TuaO9/w5DhWts5A9PpoDv2wGkLmYlr7bwbdY9E7VddnYnTrPM/r63
 eMABw1Iwi4tapNZVQO15oO/s0bOtSO6WIprb8fuzhj6nXdzP/L7cKKAbj6Up7dM2okCPSDo69kR
 YJMexMNy11vi/23rntMktze/uHwYKObSbVt3IXckWFLGaF0+WX6/J8j0k8KAIqlNmp/fziJfP7l
 jyE9tM/uWWKu96PDsklkmd2NnAlumETWd9pXNpx8VGhTYGfhC
X-Received: by 2002:a05:6a21:b90:b0:3c3:c080:71ca with SMTP id
 adf61e73a8af0-3cc3f218cc3mr8134603637.0.1786549388515; 
 Wed, 12 Aug 2026 08:43:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:b90:b0:3c3:c080:71ca with SMTP id
 adf61e73a8af0-3cc3f218cc3mr8134536637.0.1786549388017; 
 Wed, 12 Aug 2026 08:43:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 20/41] target/hexagon: add GVec overrides for HVX saturating
 add/sub
Date: Wed, 12 Aug 2026 08:41:59 -0700
Message-Id: <20260812154220.1029828-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: mhK9e6rwYBOwFnhte1wdCLxsgpShl9_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX3X728+CKg9/7
 ASGLjn4fnsjewB9JNh3tfhfdir5Y6cwGemUM9XuUBxq1VVp2yv4e8uP3NOr0bO+ajFx5ti5EJGG
 xz0upokOaX+c5UlPaCJVfZwLNrDLcjo0Oz1G9cKGVn1a2Lo0W6Bx40v8Q7EuAloDkyTFL1ZwbNT
 IRQArNsLNgp7cOcUlAnI2QYk78SvQSnlEb4zI/FcqQAbymGFYmf50DuiC11NGZaDjS+ifExR1Ew
 bHkUOl/Qx43i2+4yb8efyxgHMOH+vGQnKtzsL7WwIulaUGM+oXLSilMVv/F3yB4h1yo9oDSC4rR
 hShvaRRT5Aug5alJts/9SLdpQK21yBsnnXJ+9IE2yoWrnhN9BgDqQDE2G52SwlgysqTFM/FVIJr
 VOFnid0zVv2/5LJTOMj7Ptdd27DIU7TLWldiLWuuX2Kv1BpPrOcGqruymq4vUAvn8HDq/Mci4LZ
 yNwiziiNVNC8fVeDvCg==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c948d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CzzcSFvl921DoLjfDckA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: mhK9e6rwYBOwFnhte1wdCLxsgpShl9_A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXwMJkHWYjGWsS
 hcq8eMNBhZUn7/yaoWIhhWac0l7h/rzzbgTC+1ZBov1lPQ76Jm0npfujC6+PX/nCVVHlOvjhIb0
 Fb46EarzCWuiLZ4Dx3jefwYxUy9FyXQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120128
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4MDcxNTIyNDEu
MTU3NjMzNC0zLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Z2VuX3RjZ19odnguaCB8IDg3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9nZW5fdGNnX2h2eC5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAppbmRleCAw
ZGE2NGQ0NjdlNi4uMjg5Y2U4OTk1OTggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90
Y2dfaHZ4LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaApAQCAtMjM0LDYgKzIz
NCw5MyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXNzZXJ0X3ZoaXN0X3RtcChEaXNhc0NvbnRleHQg
KmN0eCkKICAgICB0Y2dfZ2VuX2d2ZWNfc3ViKE1PXzMyLCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2
dlZfb2ZmLCBcCiAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpICogMiwgc2l6
ZW9mKE1NVmVjdG9yKSAqIDIpCiAKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZGJzYXQoU0hPUlRD
T0RFKSBcCisgICAgdGNnX2dlbl9ndmVjX3NzYWRkKE1PXzgsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2
Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9S
X1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkaHNhdChTSE9SVENPREUpIFwK
KyAgICB0Y2dfZ2VuX2d2ZWNfc3NhZGQoTU9fMTYsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYs
IFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVf
QllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkd3NhdChTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX2d2ZWNfc3NhZGQoTU9fMzIsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAg
ICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkK
KworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdWJzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dl
bl9ndmVjX3VzYWRkKE1PXzgsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAg
ICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKworI2Rl
ZmluZSBmR0VOX1RDR19WNl92YWRkdWhzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9ndmVj
X3VzYWRkKE1PXzE2LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAg
ICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZpbmUg
ZkdFTl9UQ0dfVjZfdmFkZHV3c2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY191c2Fk
ZChNT18zMiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAg
ICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5f
VENHX1BBSVJfQUREU1VCKE9QLCBWRUNFLCBEU1QsIFNSQ19BLCBTUkNfQikgXAorICAgIHRjZ19n
ZW5fZ3ZlY18jI09QKFZFQ0UsIERTVCwgU1JDX0EsIFNSQ19CLCBcCisgICAgICAgICAgICAgICAg
ICAgICAyICogVkVDVE9SX1NJWkVfQllURSwgMiAqIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfVjZfdmFkZGJzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJ
Ul9BRERTVUIoc3NhZGQsIE1PXzgsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNk
ZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZGhzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0df
UEFJUl9BRERTVUIoc3NhZGQsIE1PXzE2LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQor
CisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR3c2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5f
VENHX1BBSVJfQUREU1VCKHNzYWRkLCBNT18zMiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29m
ZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdWJzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAg
ZkdFTl9UQ0dfUEFJUl9BRERTVUIodXNhZGQsIE1PXzgsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2
Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHVoc2F0X2R2KFNIT1JUQ09ERSkgXAor
ICAgIGZHRU5fVENHX1BBSVJfQUREU1VCKHVzYWRkLCBNT18xNiwgVmRkVl9vZmYsIFZ1dVZfb2Zm
LCBWdnZWX29mZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdXdzYXRfZHYoU0hPUlRDT0RF
KSBcCisgICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIodXNhZGQsIE1PXzMyLCBWZGRWX29mZiwgVnV1
Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJic2F0KFNIT1JUQ09E
RSkgXAorICAgIHRjZ19nZW5fZ3ZlY19zc3N1YihNT184LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZf
b2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9T
SVpFX0JZVEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YmhzYXQoU0hPUlRDT0RFKSBcCisg
ICAgdGNnX2dlbl9ndmVjX3Nzc3ViKE1PXzE2LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBc
CisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZ
VEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YndzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNn
X2dlbl9ndmVjX3Nzc3ViKE1PXzMyLCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAg
ICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisK
KyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YnVic2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5f
Z3ZlY191c3N1YihNT184LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAg
ICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfVjZfdnN1YnVoc2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY191
c3N1YihNT18xNiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAg
ICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZH
RU5fVENHX1Y2X3ZzdWJ1d3NhdChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfdXNzdWIo
TU9fMzIsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAg
ICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RD
R19WNl92c3ViYnNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNVQihz
c3N1YiwgTU9fOCwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKworI2RlZmluZSBmR0VO
X1RDR19WNl92c3ViaHNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNV
Qihzc3N1YiwgTU9fMTYsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNkZWZpbmUg
ZkdFTl9UQ0dfVjZfdnN1YndzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJUl9B
RERTVUIoc3NzdWIsIE1PXzMyLCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVm
aW5lIGZHRU5fVENHX1Y2X3ZzdWJ1YnNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19Q
QUlSX0FERFNVQih1c3N1YiwgTU9fOCwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKwor
I2RlZmluZSBmR0VOX1RDR19WNl92c3VidWhzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9U
Q0dfUEFJUl9BRERTVUIodXNzdWIsIE1PXzE2LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2Zm
KQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJ1d3NhdF9kdihTSE9SVENPREUpIFwKKyAgICBm
R0VOX1RDR19QQUlSX0FERFNVQih1c3N1YiwgTU9fMzIsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2
Vl9vZmYpCiAvKiBWZWN0b3Igc2hpZnQgcmlnaHQgLSB2YXJpb3VzIGZvcm1zICovCiAjZGVmaW5l
IGZHRU5fVENHX1Y2X3Zhc3JoKFNIT1JUQ09ERSkgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

