Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29826606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DsdMebFU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bl9bDfcq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMcYn-00045Z-50; Thu, 29 Oct 2026 22:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYS-00043f-5G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYQ-0005sh-6L
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:19 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U2JsHO2933761
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6B5llGzE3Li3ncDt78a0S1Qd/D3gz2e0PVOqyGUtwWA=; b=DsdMebFUufbmzff3
 lorrO9JQqcKv3ife4lEq58t6/1u2/GfCNn3UXlA481nvxtRhRygOYa/JzM6ix+Yj
 bjcTSaQW7HJjzkoUkKi84uINcR5VuLx3WYWwu1sfyFAlfr7qxz/mUwEJEQXWyN3A
 bX8JMXcmMK+AhZEbJDRezpCnz81EkhWMNOvT4CiUNduGnSyPDmsbQI2TZ5CsD7fj
 HVPNuT1AVzDBP/CTxXqvkixzQi/KNSoWmhYPN1By32sHxtzReZsqiEaWySej6bA2
 koAG0Cgw/K0W8V++HNKP4ccGFf+a1BJ6t8vFK0VUzXE/UTLls15KjaYd8VuyiZd7
 5LjGAA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rgvjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso750679eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793328076; x=1793932876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6B5llGzE3Li3ncDt78a0S1Qd/D3gz2e0PVOqyGUtwWA=;
 b=bl9bDfcqWlfBCKTtB/+zo8MIiJOirt2qGCNAkEihbzFj2lYp/BQ8SiV/IPxmoGTwL3
 i+PldS7730y6v+vx/1bLPSQQn6zZktA7xqfHo82v0VAR8u0IWG1ELnv84ixvt46DrtWD
 +cdW5N1JuQXLorgQWYflsdv9Qqfi6ZWvWneny+FvPcy4nK9VIRzgTXfVefsLdi6jHwif
 kqZncK7zVe9FULplsXsepyOGnHgGMSZlmg48tPrWN9xXHqTV6U4aaHfBE2WTw0Ce8cCf
 nlCLf+20Tztr6TEpNEm1DdxaoAx8mnjoAPuqk81zQIaVURA29pT9zp4g92/PXw7MXTJI
 iJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793328076; x=1793932876;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6B5llGzE3Li3ncDt78a0S1Qd/D3gz2e0PVOqyGUtwWA=;
 b=wZwArLGpjSjHU4VRKGT7Dde/2+t2s/7Jdg4GSbDy/jqr2w3d6s9IO0feZPKR+V3+H/
 GRPFgC8DIchxrScyKtC21kJyDSKb4QDVv4fasFTduSLgWbT4rzWxhnXEmHxOkXE7p1vl
 PyXQyBTs8fW35THDmYzWr7yY0tixh0M05YkEt6MeqHQriaU+Edh4EuPZXHQbSyl/ZRxV
 khvKNj1aq6r4DXjtJzkSVlV3DdiBmQHXeA5aDhOR1PByVVPGkP4AGK1zf7pNo1roel9f
 hiKYDYLj0w8ojDdKXJXyWX5waYpInCTGMhjhm5rXcpYrEACIW030Hs91KGxX9aqTafIx
 d1Nw==
X-Gm-Message-State: AFq9FYILPoN0IXXM2+yio2xnnkJEKaE2BBUnNoAWkcU6byP/DxZYezFC
 90+I9Us2DI1j16kEOXbeoBEyDVuB4D5Wc+VD/+ypr4aPWQ//u8DomOAUkYgXr6EhOkhFCkAXWAW
 s12e0G+Ro7HYvFYqa9CyBlWsojqxAvEcHQyY0CsOujqbyoKg/P27KEfEdhgUv/WqycA==
X-Gm-Gg: AYBFou11yPcxpshDivXDoLe1FMwX9aaWiF858X7zLnEWClo82/7ILy8F4Nc6D/sYPQp
 GSO8RAGHocLmKccm8Z3zMPRu/7je+zSEK5lcVzMzibyRSryNr4/dyPA5WREmiq2hrDJ71d6/W+m
 CsRaYWbFffcGms3E0osco4ApkTcqn9Pjz7zkZCBz9fK0yf8Ge5HmLN66p/MUa78Sh4WFN2iB2Yj
 UL/Bx/7FvzAYfhCOYXQgO7Uw+NC41aEO3TLGSL/m8Kb2REntsOsV+qdUO8URjgsuDJN+8t0OMBB
 ycFtsMz/fWAH3tZumZmD3RKlpO3vFXmMY+FTjCwFBFW0a09tQxKE4k+OYwz7SGSVHXaLtM8iM7P
 sbz6adOojF3ujQ0cn2CQy83nixuVeuav6h8krHivjy04qoCwinu0kB2SBYIf3RyRZ9IkXDcIzBd
 4DedzeL8pGM7OSPyBdLajahw==
X-Received: by 2002:a05:7023:d0b:b0:191:ac4:55a7 with SMTP id
 a92af1059eb24-1ac5b024d1emr1416861c88.23.1793328075670; 
 Thu, 29 Oct 2026 19:41:15 -0700 (PDT)
X-Received: by 2002:a05:7023:d0b:b0:191:ac4:55a7 with SMTP id
 a92af1059eb24-1ac5b024d1emr1416812c88.23.1793328074824; 
 Thu, 29 Oct 2026 19:41:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm2704624eec.18.2026.10.29.19.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:41:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 3/8] target/hexagon: add per-CPU HMX configuration
Date: Thu, 29 Oct 2026 19:41:05 -0700
Message-Id: <20261030024110.1986536-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: r_Xe9TstgIKBKv3kXRAWnQoWGxsRmkjg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfXzjWI7csraKML
 sLTvVlruuir7xV3S6F/uJnaUjvp1XcLHbBnOXkjTesrSS952DBKNU1kstu6G1H/nKNG43TG8hlH
 7gkT8Zv/oweC/zu8rtTxw2XZkyfgIak=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae403cc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=yL6o_P92Z4u-jk1Vq6wA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX4MbfVGUpkSac
 9LdbknhLMdibnQ4jM1H5to1MMk76iQcQ9vuGck7ZEftU5UFzZOkt4/bkQ4LVRbNgoMtkuKq9TNe
 2VpXTtw34AKuZ037ngLMrwMghn2NGXJTkxgVXg+nm8y1LINmsYIeZkxH9TP5WCsWuedhmHpJpph
 xMz0E7V8XQSMLPID04tIGqFV64yc7NbWOwGmF/LlRTWGppA5iE9VEMrd6ZF76rCYyRvhZOlEyPu
 89xSZXpPO1ca4h5qP7EmjLHkhQMYRSemfk9piDtmBeHhq+AJrBxz004en/1ZiKNPzusBRoFXsBO
 bqK2E96aVV1aUnTRmBi2G0rPaCGwsRe/5Vqh9PDxrXqc3MFV6uYM7QF6drVGFnvZZIxdcqja3pi
 expIyTZ9babPPFnDIsk24vQysebA1j+MYrIV+D5ypureoIvyL2HdTuaTe1QqxZSPxG+vzjCzRlz
 whvKi5Qqar55DGHBcfw==
X-Proofpoint-GUID: r_Xe9TstgIKBKv3kXRAWnQoWGxsRmkjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300010
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

QWRkIEhteENvbmZpZyBhbmQgaG14X2luaXRfY29uZmlnKCksIHdoaWNoIGRlcml2ZSB0aGUgSE1Y
IGNvbmZpZ3VyYXRpb24KZnJvbSB0aGUgQ1BVIHJldmlzaW9uLgoKUmV2aWV3ZWQtYnk6IE1hcmNv
IExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdv
bi9jcHUuaCAgICAgICAgfCAgOCArKysrKysrKwogdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5o
IHwgMTcgKysrKysrKysrKysrKysrKysKIGh3L2hleGFnb24vaGV4LXN1YnN5cy5jICAgICB8ICA3
ICsrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICB8IDIzICsrKysrKysrKysrKysr
KysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9obXhfY29uZmlnLmMgfCAxNSArKysrKysrKysrKysr
KysKIHRhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkICB8ICAxICsKIDYgZmlsZXMgY2hhbmdlZCwg
NzEgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hteF9j
b25maWcuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hteF9jb25maWcuYwoK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgK
aW5kZXggZmViODAzNjgyMzguLjIyYWExNjMwNzY3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMzAsMTIgKzMwLDE1IEBACiB0
eXBlZGVmIHN0cnVjdCBIZXhhZ29uVExCU3RhdGUgSGV4YWdvblRMQlN0YXRlOwogdHlwZWRlZiBz
dHJ1Y3QgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlIEhleGFnb25HbG9iYWxSZWdTdGF0ZTsKIHR5cGVk
ZWYgc3RydWN0IEhleGFnb25IVlhDb250ZXh0U3RhdGUgSGV4YWdvbkhWWENvbnRleHRTdGF0ZTsK
K3R5cGVkZWYgc3RydWN0IEhleGFnb25ITVhDb250ZXh0U3RhdGUgSGV4YWdvbkhNWENvbnRleHRT
dGF0ZTsKIAogI2luY2x1ZGUgImNwdS1xb20uaCIKICNpbmNsdWRlICJleGVjL2NwdS1jb21tb24u
aCIKICNpbmNsdWRlICJleGVjL3RhcmdldF9sb25nLmgiCiAjaW5jbHVkZSAiaGV4X3JlZ3MuaCIK
ICNpbmNsdWRlICJtbXZlYy9tbXZlYy5oIgorI2luY2x1ZGUgImhteF9jb25maWcuaCIKKyNpbmNs
dWRlICJobXhfc3RhdGUuaCIKICNpbmNsdWRlICJody9jb3JlL3JlZ2lzdGVyZmllbGRzLmgiCiAj
aW5jbHVkZSAicWVtdS9iaXRtYXAuaCIKIApAQCAtMTk3LDYgKzIwMCw4IEBAIHR5cGVkZWYgc3Ry
dWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgdGFyZ2V0X3Vsb25nIHZzdG9yZV9wZW5kaW5nW1ZTVE9S
RVNfTUFYXTsKICAgICBib29sIHZ0Y21fcGVuZGluZzsKICAgICBWVENNU3RvcmVMb2cgdnRjbV9s
b2c7CisKKyAgICBIbXhTdGF0ZSAqaG14X3N0YXRlOwogfSBDUFVIZXhhZ29uU3RhdGU7CiAKIHR5
cGVkZWYgc3RydWN0IEhleGFnb25DUFVDbGFzcyB7CkBAIC0yMTcsMTIgKzIyMiwxNSBAQCBzdHJ1
Y3QgQXJjaENQVSB7CiAgICAgSGV4YWdvbkNQVUNvbmZpZyBjZmc7CiAjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKICAgICBIZXhhZ29uSFZYQ29udGV4dFN0YXRlICpodnhfY3R4W0hWWF9DT05URVhU
U19NQVhdOworICAgIEhleGFnb25ITVhDb250ZXh0U3RhdGUgKmhteF9jdHg7CiAgICAgSGV4YWdv
blRMQlN0YXRlICp0bGI7CiAgICAgdWludDMyX3QgYm9vdF9hZGRyOwogICAgIEhleGFnb25HbG9i
YWxSZWdTdGF0ZSAqZ2xvYmFscmVnczsKICAgICB1aW50MzJfdCBodGlkOwogICAgIEhleEwyVmlj
SW50ZXJmYWNlICpsMnZpYzsKICNlbmRpZgorICAgIEhteFN0YXRlICpobXg7CisgICAgSG14Q29u
ZmlnIGhteF9jZmc7CiB9OwogCiBzdGF0aWMgaW5saW5lIEhleGFnb25IVlhDb250ZXh0ICpoZXhf
aHZ4KENQVUhleGFnb25TdGF0ZSAqZW52KQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaG14
X2NvbmZpZy5oIGIvdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5oCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5jYjE0MzNmNTRiOAotLS0gL2Rldi9udWxsCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hteF9jb25maWcuaApAQCAtMCwwICsxLDE3IEBACisvKgorICogQ29weXJp
Z2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJp
ZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisK
KyNpZm5kZWYgSEVYQUdPTl9ITVhfQ09ORklHX0gKKyNkZWZpbmUgSEVYQUdPTl9ITVhfQ09ORklH
X0gKKworI2luY2x1ZGUgImNwdS1xb20uaCIKKwordHlwZWRlZiBzdHJ1Y3QgSG14Q29uZmlnIHsK
KyAgICBib29sIGhteF9wcmVzZW50OworfSBIbXhDb25maWc7CisKK3ZvaWQgaG14X2luaXRfY29u
ZmlnKEhleGFnb25DUFUgKmNwdSk7CisKKyNlbmRpZiAvKiBIRVhBR09OX0hNWF9DT05GSUdfSCAq
LwpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgYi9ody9oZXhhZ29uL2hleC1z
dWJzeXMuYwppbmRleCA0ZDlhNzljZmY3NC4uNWQyMjdjMGRiMmIgMTAwNjQ0Ci0tLSBhL2h3L2hl
eGFnb24vaGV4LXN1YnN5cy5jCisrKyBiL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCkBAIC0xODcs
NiArMTg3LDggQEAgdm9pZCBoZXhfc3Vic3lzX2NyZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0
YXRlICpobXMsCiAKIHZvaWQgaGV4X3N1YnN5c19hZGRfY3B1KEhleGFnb25Db21tb25NYWNoaW5l
U3RhdGUgKmhtcywgRGV2aWNlU3RhdGUgKmNwdSkKIHsKKyAgICBPYmplY3QgKmhteDsKKwogICAg
IG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoT0JKRUNUKGhtcy0+Y2x1c3RlciksICJjcHVbKl0i
LCBPQkpFQ1QoY3B1KSk7CiAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChjcHUp
LCAiZ2xvYmFsLXJlZ3MiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QoaG1z
LT5nbG9iX3JlZ3MpLCAmZXJyb3JfZmF0YWwpOwpAQCAtMjAwLDYgKzIwMiwxMSBAQCB2b2lkIGhl
eF9zdWJzeXNfYWRkX2NwdShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsIERldmljZVN0
YXRlICpjcHUpCiAKICAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChjcHUp
LCBuYW1lLCBjdHgsICZlcnJvcl9mYXRhbCk7CiAgICAgfQorICAgIGhteCA9IG9iamVjdF9yZXNv
bHZlX3BhdGhfY29tcG9uZW50KE9CSkVDVChobXMpLCAiaG14LWNvbnRleHQiKTsKKyAgICBpZiAo
aG14KSB7CisgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoY3B1KSwgImht
eC1jb250ZXh0IiwgaG14LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9y
X2ZhdGFsKTsKKyAgICB9CiB9CiAKIHZvaWQgaGV4X3N1YnN5c19yZWFsaXplX2NsdXN0ZXIoSGV4
YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAyODFkMjAxMjUwYi4uODNlMjM3NzVl
YTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L2NwdS5jCkBAIC00NSw2ICs0NSw3IEBACiAjaW5jbHVkZSAiZXhlYy90YXJnZXRfcGFnZS5oIgog
I2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCIKICNpbmNsdWRlICJody9o
ZXhhZ29uL2hleGFnb25faHZ4X2NvbnRleHQuaCIKKyNpbmNsdWRlICJody9oZXhhZ29uL2hleGFn
b25faG14X2NvbnRleHQuaCIKICNlbmRpZgogCiBzdGF0aWMgT2JqZWN0Q2xhc3MgKmhleGFnb25f
Y3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hhciAqY3B1X21vZGVsKQpAQCAtNTM5LDYgKzU0MCwy
NCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVy
cm9yICoqZXJycCkKIAogICAgIGNwdS0+Y2ZnLmhleF9kZWYgPSBtY2MtPmhleF9kZWY7CiAKKyAg
ICBobXhfaW5pdF9jb25maWcoY3B1KTsKKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLyog
QWxsIHRocmVhZHMgb2YgdGhlIHByb2Nlc3Mgc2hhcmUgb25lIEhNWCB1bml0ICovCisgICAgc3Rh
dGljIEhteFN0YXRlICp1c2VyX2hteDsKKworICAgIGlmIChjcHUtPmhteF9jZmcuaG14X3ByZXNl
bnQpIHsKKyAgICAgICAgaWYgKCF1c2VyX2hteCkgeworICAgICAgICAgICAgdXNlcl9obXggPSBn
X25ldzAoSG14U3RhdGUsIDEpOworICAgICAgICB9CisgICAgICAgIGNwdS0+aG14ID0gdXNlcl9o
bXg7CisgICAgfQorI2Vsc2UKKyAgICBpZiAoY3B1LT5obXhfY3R4ICYmIGNwdS0+aG14X2NmZy5o
bXhfcHJlc2VudCkgeworICAgICAgICBjcHUtPmhteCA9ICZjcHUtPmhteF9jdHgtPnJlZ3M7Cisg
ICAgfQorI2VuZGlmCisgICAgY3B1X2VudihjcyktPmhteF9zdGF0ZSA9IGNwdS0+aG14OworCiAg
ICAgZ2RiX3JlZ2lzdGVyX2NvcHJvY2Vzc29yKGNzLCBoZXhhZ29uX2h2eF9nZGJfcmVhZF9yZWdp
c3RlciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGV4YWdvbl9odnhfZ2RiX3dyaXRl
X3JlZ2lzdGVyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZGJfZmluZF9zdGF0aWNf
ZmVhdHVyZSgiaGV4YWdvbi1odngueG1sIikpOwpAQCAtNjI5LDYgKzY0OCwxMCBAQCBzdGF0aWMg
dm9pZCBoZXhhZ29uX2NwdV9pbml0KE9iamVjdCAqb2JqKQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcWRldl9wcm9wX2FsbG93X3NldF9saW5rX2JlZm9yZV9yZWFsaXplLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKX1BST1BfTElOS19TVFJPTkcpOwogICAg
IH0KKyAgICBvYmplY3RfcHJvcGVydHlfYWRkX2xpbmsob2JqLCAiaG14LWNvbnRleHQiLCBUWVBF
X0hFWEFHT05fSE1YX0NPTlRFWFQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChPYmpl
Y3QgKiopJmNwdS0+aG14X2N0eCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9w
cm9wX2FsbG93X3NldF9saW5rX2JlZm9yZV9yZWFsaXplLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBPQkpfUFJPUF9MSU5LX1NUUk9ORyk7CiAjZW5kaWYKIH0KIApkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5jIGIvdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5j
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi41ZGNjNzAwOWE5NQotLS0g
L2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2hteF9jb25maWcuYwpAQCAtMCwwICsxLDE1
IEBACisvKgorICogQ29weXJpZ2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5k
L29yIGl0cyBzdWJzaWRpYXJpZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlcgorICovCisKKyNpbmNsdWRlICJxZW11L29zZGVwLmgiCisjaW5jbHVkZSAiY3B1
LmgiCisjaW5jbHVkZSAiaG14X2NvbmZpZy5oIgorCit2b2lkIGhteF9pbml0X2NvbmZpZyhIZXhh
Z29uQ1BVICpjcHUpCit7CisgICAgSGV4YWdvblZlcnNpb24gdmVyID0gY3B1LT5jZmcuaGV4X2Rl
Zi0+aGV4X3ZlcnNpb247CisKKyAgICBjcHUtPmhteF9jZmcuaG14X3ByZXNlbnQgPSB2ZXIgPj0g
SEVYX1ZFUl9WNjg7Cit9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCBi
L3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDA2MzM4NTIzMjE3Li5mZTMyMDZlZjhi
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvdGFyZ2V0L2hl
eGFnb24vbWVzb24uYnVpbGQKQEAgLTI1NCw2ICsyNTQsNyBAQCBoZXhhZ29uX3NzLmFkZChmaWxl
cygKICAgICAnbW12ZWMvc3lzdGVtX2V4dF9tbXZlYy5jJywKICAgICAnbW12ZWMvaHZ4X2llZWVf
ZnAuYycsCiAgICAgJ21tdmVjL2h2eF9xZmxvYXQuYycsCisgICAgJ2hteF9jb25maWcuYycsCiAp
KQogCiBoZXhhZ29uX3NvZnRtbXVfc3MuYWRkKGZpbGVzKAotLSAKMi4zNC4xCgo=

