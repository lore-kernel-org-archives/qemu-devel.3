Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1670DD35173
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV1-0001U8-SO; Wed, 01 Apr 2026 11:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUq-0001AU-SA
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUp-00089N-Cs
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631CS29D1285859
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ZHy9fjHuUJPuBnGZhpJxEYG+YhC4Fr91TldqdiZEyI=; b=VennMWgsUps3A6FF
 8IelrgvOcmgEreZiw6pMHj/NWZerGLJ4EhFBObk2U34Xd0wMn83xlDaqLMyCPqFA
 df0pmvxc0qBupddZa8Pflxi3JXV4sW0Fb6obSFKSPxlBW9jBhdkXCQ+Lxk2Dp0dN
 C2EFhaAzyotsm9OHmds5oi1vcM//qQ5XwGPx+s0eVKaeH3IFw5o+cGQreshkBlDn
 /GpxT6JDGcKSYezOh6Px2fZ3yaMLJL3L9L97gRG2ZndwdqDFKn1ek11RyiO4MexK
 ZytRjQwzwkb5L1YKWdtoZ49sDOBpUP8wtIZ4l6J3kFR7nsg4XIRx054VNGlKvSko
 KrS2lw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3t2xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c8ac8e422dso2677494eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057293; x=1775662093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZHy9fjHuUJPuBnGZhpJxEYG+YhC4Fr91TldqdiZEyI=;
 b=IuQ5HduFQrq8zzwcW2WZUKEmS7MgLB3prxXHKg45gLXdi/gzLH7Sf6aNzezSeIzQXL
 DYZ+J1YJQl/GDkZJ8gwHYR0vHGKInu7k8y9x5z+/8OQUsa0rz914bflnci7kzPuL4lsu
 pRgcGwCTB0tVsQay3eEanArqy3Nkq28GVcBk2jazHzU7nxaXGURd4aUkMvxTdsxPjVgQ
 NKpXISbDeUOoKBDKKEkH9QkHepu1IMcdcv/prWglnb+IfLFf6SLyCzOVu8Kd0UQs7kzR
 osYdOl2QiZjA5ZKROY0K1n/DOLYVZrn5RMDsKDRJxgQRua63D23T/0uP4W5eRRQDGqcw
 fcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057293; x=1775662093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ZHy9fjHuUJPuBnGZhpJxEYG+YhC4Fr91TldqdiZEyI=;
 b=bp/kCypPbTUARi19wZeblFcBqV6hi+KOwwziSGutH2ICwwk0V8Fqamo208qcqH3inE
 bjSHenzXfrnwe8wEiP/g5zlTZEPKDhhGy+K6lx+nmb5/nm8C9MCLOjR+hdwmW5l3NhtQ
 lD7wFcwhr1ZWaL9wWR4MqWVvn/WmcECz4UAgbCHbLfLLsQLK9pXuztqlFVMnw5OiX0O0
 sIZ7rDyYTFeNNYmMx2tobOk/ZZe/Nuhsh04cgaGN9bFS90t9OwQWRdCqsJKTdDB7JiTq
 uGLLcj2ZKksKu4j5SExdd/eqpX/w267LTX56f1jdvvpkRszObst+42L/oXCXQ9B4OSWu
 E5DQ==
X-Gm-Message-State: AOJu0YyajzY9eCvNfTreHN/pGaZ1hOpnsghO6kanSSWeyv6W0FqudhNc
 ys+etBJdOpyPPZs178Gi59JHN9UxwDqs5A8qkFEdrjnGJP9q1YWWF9GpNMmae/HBHMDlY8wBHB/
 nNRpKJU63b7GQzUTdAe7oocWWvAyc+TH4nWOCNuUm2ENb3erIkr7PWbv23LMSHiykxQ==
X-Gm-Gg: ATEYQzxkKqjsfOpp5DGR66F7lHsC+nNzZhhjtLeicLXLKIzYme7rCya0rL7Aa/t3xCQ
 DNcpdh50tsHhgliHGvssmhVAUJo7lsJr2fORuFWtFQgMmnsCCHoBwHhMtvJwOVS8yaFl5tVW3ex
 7iYR+Dwn2ZJuiB5b1Kday8zAi/dvBzLO5AVh1VL3mzIz47rtEMZ7G77vTEqYWoVs9rIYcQTsETd
 JjTDqVSt7HbnpLpzrky/LFz5Pws+UZ9vKy876DaSTTYp9ZkyK2pPczufsl736FaM61C2snyXGfg
 W7mDaCK6vr5bbZBiEQxKHtyX4/5zanthU541M61JJROER8ZVOVUaxG6gZ+f+J3RKw4suIhfGXir
 XZHfiiD/I/jiS9G0SUrI+/hvF9INMvC7JBPyVSZ4xhJUA67sejGJoWYqyz325EKAhjwuCfg==
X-Received: by 2002:a05:7300:cb0b:b0:2c5:9b9d:4511 with SMTP id
 5a478bee46e88-2c9334b530dmr1994133eec.32.1775057293094; 
 Wed, 01 Apr 2026 08:28:13 -0700 (PDT)
X-Received: by 2002:a05:7300:cb0b:b0:2c5:9b9d:4511 with SMTP id
 5a478bee46e88-2c9334b530dmr1994118eec.32.1775057292565; 
 Wed, 01 Apr 2026 08:28:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v6 30/37] target/hexagon: Add representation to count cycles
Date: Wed,  1 Apr 2026 08:26:50 -0700
Message-Id: <20260401152657.314902-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd399d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gmA5YO3DfmenxuRff1QA:9
 a=tsLLKIjAKpJP5df9:21 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: AcsRK7kjLeHDLDJ3aXp-gNvUJDluj89x
X-Proofpoint-GUID: AcsRK7kjLeHDLDJ3aXp-gNvUJDluj89x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX/SVlcClNBsOE
 JpC+Gle+VHv3E4SVKQeBRm0tgHsSR5a9oMQb4q9VOjGFsS74jBibY6gLAk5ZMF3dH///Kmgmrxq
 EfxVozL2dCT14eUE5MN44AAbLH7Tx3A2INsx6wFuD103Rp3Yt8BqBuml1L36nhLgdfi+4iqBUY8
 F4GNq/LWaqERPgOGJtFCD5cRGCkm1be1xwrjB9xQ38tr5Q//mdYNH6Hu/KkWdl8ZdVthDUuq+qQ
 SeYkwTOev9miD7ymhJdkzxAWQJ4PWhW2qqme8BxjEn4eKA+aHCXLh5+AIc6jj6NMR+TV6iLUdUB
 afvWUHrJljg1pEBKImcwzrCfpkpHpoG/UwaH0WhKaUtfAT7C8E3gSVOybogsWhz9zH0uhYReZRu
 Bl+rewluJFPF0y1KpwSTy/PrrPi6bsMcviPWM74HJa1JIC981SqqNe/B57+Sgivws+26r1hTjnN
 imlDus54IkKSPdgAF/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

QWRkIHRfY3ljbGVfY291bnQgdG8gQ1BVQXJjaFN0YXRlIGZvciB0cmFja2luZyBwcm9jZXNzb3IK
Y3ljbGUgY291bnRzIGluIHN5c3RlbSBlbXVsYXRpb24uCgpSZXZpZXdlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5o
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDM1NjI5NjVjODhh
Li41NmY4OTIwOTc5NSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTEwOSw2ICsxMDksNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5kZXggaXMg
dXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRocmVhZElkOworICAg
IHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3Zh
bHVlX3VzcjsKIAotLSAKMi4zNC4xCgo=

