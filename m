Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE5606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gSaCTMfM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HGIgCY3w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMcYr-00046a-JL; Thu, 29 Oct 2026 22:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYR-00043M-IR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYP-0005sa-65
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U2K2QV1602786
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7NYNPIhhTl72+Hi96dkXNNcldCv/4ymMOVQgfJnTgf0=; b=gSaCTMfM82fjcSMM
 tJ5BwaaPavkvJkJRLZIzveqsg7A3SNrFoCH44sPI/db89Hvia1rVzNglLC+Q40Je
 tl9tPUIl2L2CDTgqhNE4LlstnIr8bA14l4nIDhFx3lzu4RJThqa6mE/1N56f/K+9
 FtVEzVOuxpVXL9ZQEHkXNR7LvL9KPCA4bLWmmVP0jOCtlwnfNYme+SMvRvs9Atoo
 0lZFOsdN6C4GuPBvXoChzzbKZgTMN9eX7cMuXBwmjP7rwlJZ3Lus8MVdQUvsvYwX
 pBnlJ20OPrgx71fq02h+kG/EaXGYiGZDVICJxtUDT0+1NQgHD9tXIPpMj1J22FTF
 WUZ7LQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qgue8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3692c5b061bso852333eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793328075; x=1793932875; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7NYNPIhhTl72+Hi96dkXNNcldCv/4ymMOVQgfJnTgf0=;
 b=HGIgCY3wPOYKXw2CADtsjyVFI/ZFBuiNSF5Z6+j4glQw1OsHb0t/07d/BAAkLMZ0ue
 FL/oKH9hJf1eF3MXJY+zXKXNlTCg98Cu76cyeQUtYtX6kdgmvmyw16Y7ha8GRE6GJ6YP
 cyrBC7y5olf3ZVR4QFbxUA6rECw0bq+OZ4BHXM1mfxCpm/9UmLZ+ltSUpKe7sXR90bEs
 cGgdhZbpyS3u2lbprQnj2tM5jPy735CbUiaYZSyCdM3MjKLPOH+A6nHVpzOoqZ2liGIo
 Wr8KRgVVuQuiwSrRIapWH1R9MN4XdieDnTNcjbOR6ij8/Q2+vi3MlEJHQR833Q4qwYQE
 xgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793328075; x=1793932875;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7NYNPIhhTl72+Hi96dkXNNcldCv/4ymMOVQgfJnTgf0=;
 b=NtuAvEkodvFe7/ywqudFAPlB6n4OvhVvzyJWcFzsrryZmEEHclToE2MkeHEdRNN2p+
 QLQD3ssfZWCPLuemDoDanyS7XdXZvxIc9nwJ06NomQId4fFqhSNZlmnyI/OvCQtYv8/J
 orGMZY7V5SUqWXhkVTo8V/WADbG9srZd2gbMbhph3bebnC/X6+yhPjqocQZqyZ8gv1oj
 OUMk9Uv6/U9AfEmjKVSBogte+q1T0HfSkh9zgaeCBMHqXFyG+BIp0cR5s8wD8/iJhmbh
 bzT4hGtqiakA1z8+STwZojgCpDcP0WfgpVW9OQW6PaAklf4cVOO8h9mdxP3Us5ThEQmu
 Vk2A==
X-Gm-Message-State: AFq9FYLcgiOLU5VT9p5UH4ujAUdy9kULck6DqNZ8ufhVc1/cpku9W7Xj
 LJlt8DgKsN19RnyT9X9k1uDDQHhLSW/ZC0Vhv/o0+9orVexQhOO0FMvz6bR4INEcYZFvd6IymRB
 SOKnWozuqUyEakzwkCs0NXI+80W4GIKBwfpjxRO06LnGdA57E8rntdOVGCW1MxnNLdQ==
X-Gm-Gg: AYBFou0GDLGhHbPMBVWMqmTM2JEQzCTA2w1GZoaAYnDBH84r+CYTqKG4mAWPdzL/+IC
 ZKfKdPt1UmCyL2G2oAADIJXwjlg2S2cvKQguU2n4R3GkNg7l26IpgIVyMgjiC8977LA19AMEOU4
 R49u6L529Jrkxsx9CUpKk51NXAW7AvcssyfjRpDbAQaX6Yyxq0goqzchTH0slkoPTTxUK3NJK9g
 7cfGqekrZt938kv9PYcKM/kvkFj3fXSdpQhHAKpXs/Ef1W7NrTHCQri1gFXzyC3HCg5f9heQlRW
 M052bdrBx4R5Uct1lUQk/AS3WMnbuMGlhgyVgPXGp5q9nQ+k27fPvZ+/6yrfASCs3Y97oVHZhkh
 W/kvdislYRY8dRY5VC7BZhlNiIbU/NkBh4EeMgnwCAfBRXbR5rOqV8LQPEhJNZxLXXxFGlbaa+o
 y/0xPFa7Es/IJ+hWSCQxTKnA==
X-Received: by 2002:a05:7301:710f:b0:359:2edc:e1d8 with SMTP id
 5a478bee46e88-36a422039fbmr1543066eec.5.1793328074825; 
 Thu, 29 Oct 2026 19:41:14 -0700 (PDT)
X-Received: by 2002:a05:7301:710f:b0:359:2edc:e1d8 with SMTP id
 5a478bee46e88-36a422039fbmr1543016eec.5.1793328073682; 
 Thu, 29 Oct 2026 19:41:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm2704624eec.18.2026.10.29.19.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:41:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 2/8] hw/hexagon: add the HMX context device
Date: Thu, 29 Oct 2026 19:41:04 -0700
Message-Id: <20261030024110.1986536-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae403cc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=GkCZVEeUe3Q-cCnmmhAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: TADyUeH9PBsebp8AOZbJvKis45n6Rc1f
X-Proofpoint-GUID: TADyUeH9PBsebp8AOZbJvKis45n6Rc1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX2LOLNo6K/VlL
 SOzDmjkaj/vhK7C6vtd1FgiZWb3AUMzNeqldjodGihtdHcvZpxLulshPE7ud2UFH8TyhaGWZts0
 GWeUu7BCL7sLeb2JXBX/RH9Lx+vk4C/WU1FnFpxuEd+28N2lLR0Ok+yE0YthRsyUdiBq5kg0KPK
 w77meySAHiBsRsCBg8+8rG7geY0Gl3Iy7oI4Mh1J/6SfRI1pTHvxcKyU00jYoxWWtGYu1yFJ1vE
 2nTT6Nq85mWJt66aI0UaqcqvaJJVG3jGf8UubmetFyDsO7/ko0mj48/QJ+mpeCnxg11KhNqpXGE
 CwZz1vYSMEX4xv/N1wGytZpb5CExLt7pbEnBIj++6P1lpaOmDkWOjeahtAmo9dtWip+dWn9lKMI
 7wqgebn3ufcusFnqPxKCI9Iv6vL35ZzIOJ8Bk6Ggq2pjEpBIzE1kif/r8F078xPw5Nowe8v0BZE
 Aqwm+oHuZdAZboXBb8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX3aOAVKB4X1Ly
 muL3RoS3N2Z22bZ8Wzk2QzJBo0cHpDzgU7Jll0krO/VcxJSgb7FpwOps+oKjRcpBIwnCou0ofAU
 dzhujb9rScS+56q5K3wOSDpTc9Q8qrM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300010
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

