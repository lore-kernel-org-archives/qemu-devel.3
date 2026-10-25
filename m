Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A75606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lI32KMsm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJND0SW/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKosN-0001rV-FI; Sat, 24 Oct 2026 23:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor6-0008Lq-O4
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor2-0001XB-Ql
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:06 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P17G4f2778726
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=; b=lI32KMsmdIVUilf0
 67evAJs7WFJdxAxnOBddHiC5VvYOu8gz3OEJ5KmQbYROIPGNV4y7PJ/Q/HTNFCsf
 PtBvjXpjgfP0xZfB2f9ZOY4OiQXTz7tvKkEm4+bc1h2yNP1reXLhyA6BHR7Dy7gE
 XJJZI6cXSZOepzcC0C9mNG9yRzFhjNchlHmNFEYpU9XE6lG5EWEwnaloIauCf313
 TANEcNxVh2wFDojDSDEuyngAhd5lJDMwLbwrinq8yvtCj1vIerKNvzGmLpe0hKHm
 0ghDE1h37eiCT9xTkE5z3FDeeN4u+cCPWVsPoiI3abTmIS6BRd9WEG1bOdHXm0lD
 GWVHDA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gje16-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-186c1aae818so7069733c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898692; x=1793503492; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=;
 b=TJND0SW/wWWAdhG6oQY3tgK3GRjD1dQwfYSTzihtn+fO2dnjf6jevz0uBK4/zZesAi
 D2PpokRmO1dPSdCJheVZHgk7IMSIfUsGiJnLSX6PHyJ52YPEHoDk0yqHbS10rsbdxB6y
 lq+0cCdLTqYg1oqf6HXHQ8BoTczbA2OkRiegAwUHr8b4IPWbZ2tCM3M8rPFjxrM+HM00
 ZG08fovF+1KYuBd5SKUf+dGb2nyn/kBz56mPB0lOYbT/v5A6SiMH6C7JzKvLm9WrT8yG
 /MPI1F0iClxLjiewuEYkZvmolqSoDoy+7v4Zrhdrymrvw/ynqTBKTmwl3uIFynkOI441
 9jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898692; x=1793503492;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=;
 b=pZYL1PZtMqiThXc2D6wGOdiyLdfjAIBxqQssL6s4lmre3kcB11NJ+tXtrVQQ0XoLiq
 oAb4dL2NDyuM7o5RslVD94SXXQ183JItOSKETjSiiH3pO+4e5nL0TiZQmHH3jrB+XgIJ
 HgxP8fjGueez71dqEE/jb3pJDysx3e9zCm+1BO+UxZrRQzrqg9HHHGSIbmqSACaxI0b4
 7XhYEHv3Nw8a8ht4/4CciWyTzQWYMLoxnY6xonYhnpRv2/T6lSr1FOxGe3TaAXGbwX1E
 lxwZe856YWazr5B1so1l/2jM2YfVc7VKJLjbj6OUAnaR9WhjHzNuW5TOGd0+6wP4d7MQ
 s78A==
X-Gm-Message-State: AFq9FYKAQD99sPBt4VztqW2H8JkMHmeqekuHX3mjejo50IMFURi6TOBD
 sE766sR0UwAzcV2s5M5RNiSKue33Rg1Ll3V/KhkTF45jZVjJTInbHMLRFsgsPd74E0QiqUiTNHv
 3JfHfCaWKR8opEyrpUGTE/xWIZjfX5U0XgbmowoCYefrbzBAJMpxmEUOQPpqXWdnfLA==
X-Gm-Gg: AYBFou3GWOBfhi/vwPLXEK6miZ6o30ha8v7Hzxpg0ZuQZz07WWyINey7I7w3M/EWME3
 6N+ok9qNY7YEgvApUKnvD6a4SQ8x2X1pcSrsgvDKilym0SzeAbMO4f6tWIS0OGwNK/bgfaRoBc9
 5AAxvMmdRR6yD1GISQnkVpNQa78SM2EEUhzFt+Tt0BV0LmJ4q3QPa2AvNhf15oLPBZNUxjlVy4T
 I+kH8FCVMVZbYVVyORSkEJ1pkAFtotL21t34AyTaNuGR8ghyVRsCk2UqF5LK5qUB97e9DzEdKuy
 ZHEnq9QNZCqM2K16WNWteUupBvFGQ9ZyOWMreXsWm2TkR8xvMAoPzgE7Bq/MuMSmaNvYqeu+YIN
 m88fIPhS3BppUZyzECGquAHrCSijoAqMH57ZbZkeiISziOrI=
X-Received: by 2002:a05:7022:3a85:b0:15a:2b63:a0cb with SMTP id
 a92af1059eb24-1993571a2e3mr5544059c88.13.1792898691815; 
 Sat, 24 Oct 2026 20:24:51 -0700 (PDT)
X-Received: by 2002:a05:7022:3a85:b0:15a:2b63:a0cb with SMTP id
 a92af1059eb24-1993571a2e3mr5544037c88.13.1792898691316; 
 Sat, 24 Oct 2026 20:24:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 32/40] target/hexagon: check exception_index in has_work
Date: Sat, 24 Oct 2026 20:23:38 -0700
Message-Id: <20261025032346.2917451-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: b4jlj_dwg4wMcp86kMlH_r7zLsXzHAsK
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6add7684 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=2Qhxk_BCo_5fC3_CN1YA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: b4jlj_dwg4wMcp86kMlH_r7zLsXzHAsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfX8YdvGjQdeZbH
 YltZyNgcn4lTqqcjPXwnr6NR/vLddOxZMV301/P83QEKZDEs1ZbEP8Y0uyAOlmhtx9MN4lu96dA
 32PM8ds57KaDxuUoILG3vWcmPAfLMNgHEYojSb7kJRuLC/1hEegkA891tPErcmnSGqor1gtvFyJ
 ezPcDQaA8hojzBXLD8GdCPMysTOyL6Jb1z6i3T9gaZcIFVomTAVqeR+V+1nj/zZ45wtDkhTyKDI
 QPdNmJJb9qG1wELfBH3bKCJpqBuAGmDHMK2PbuHZtAlhHRDc+3LiemBXuwzQuVG3sEVSl0dI9fC
 fLUhSvRpb5lSun3XSUifua0tkp8A6IQOtyUwq6fWJA3s8uFPV2pxhUIu0Ilw3p/O3HE9oqKL3Li
 9b9l+I+altfmOJ9SMVtDbuvi1zM091xx4WOQf4z3EfQEHRH5N10lSm5kvymZupjpoiffVLb9t4+
 RT8Y9CZrWcdFvFZ5kbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfX738AfAynd57F
 W46fsWNyDdG6+WycMiXZ1b6so++PYbjb3zUqqi974YNif/UHNcg9b8M4wilTDYN0k/6kmXmAnbv
 mB0SrDE5QTVuTDtmxCPWYB4NpZ24y0k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250013
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

V2l0aG91dCB0aGlzIGNoZWNrLCBhIGhhbHRlZCB0aHJlYWQgdGhhdCBnZXRzIGFuIE5NSSB3aGls
ZQppdHMgbW9kZWN0bCBFLWJpdCBpcyBzdGlsbCBzZXQgd29uJ3Qgd2FrZSBpZiBubyBpbnRlcnJ1
cHRfcmVxdWVzdCBiaXRzCmhhcHBlbiB0byBiZSBwZW5kaW5nLgoKUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CmluZGV4IDYzMmVlM2Q2MGJkLi4yODFkMjAxMjUwYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQzMCw2ICs0MzAsOSBAQCBz
dGF0aWMgYm9vbCBoZXhhZ29uX2NwdV9oYXNfd29yayhDUFVTdGF0ZSAqY3MpCiB7CiAgICAgQ1BV
SGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKIAorICAgIGlmIChxYXRvbWljX3JlYWQo
JmNzLT5leGNlcHRpb25faW5kZXgpICE9IEhFWF9FVkVOVF9OT05FKSB7CisgICAgICAgIHJldHVy
biB0cnVlOworICAgIH0KICAgICByZXR1cm4gaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChlbnYp
ICYmCiAgICAgICAgIChjcy0+aW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJE
IHwgQ1BVX0lOVEVSUlVQVF9TV0kKICAgICAgICAgICAgIHwgQ1BVX0lOVEVSUlVQVF9LMF9VTkxP
Q0sgfCBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0sKLS0gCjIuMzQuMQoK

