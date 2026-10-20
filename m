Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3B606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=llBmBceU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bni5TB8u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBal-0000eN-Nm; Tue, 20 Oct 2026 11:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBaj-0000dn-P1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:17:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBah-0005NW-T2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:17:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDAFh01575857
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9k8qhJbZ249bd2yrx7ySme
 GqhBj+F8tPCe0gBrXV8cs=; b=llBmBceU1En8yT9GXxL/GUxAZxvmmukr95D3w9
 n/nRf/UyPc8riN+Oh1enUCBAdEMSp57TcJpSd7cNACjoQVPxwF+7TK608jmISJs+
 0rTpcPwwqwzsQUjPoMMk9W29skb8yk7qveLejpevtGznmIq8+LQbQNqPyBtq2rPo
 dR6xycwGoJc41Ksbfb28EfX8FG9ucXQg2Lykj38ykeR5cjQ6TE7Z7tveuzTs4P40
 dLTIqtMMXIVBe2UEG0SYlwc9DWRYnM/LcGaizhguPxLQACWUJJEp0/62eQv42wwq
 U1Xaot1oM10bo3rIY5Jk4UNARd6G1U1tUt53KSDZAv+PyOmw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n33sv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e8e16d22d8so49089215ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792509443; x=1793114243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9k8qhJbZ249bd2yrx7ySmeGqhBj+F8tPCe0gBrXV8cs=;
 b=bni5TB8ur2E74O74eILIBRDwerD+qqVo3tYoZXF60Ny6aMPV573bghWcmn0ok6hQ9v
 4+K/J5Ob/Q5YDWKFkmdUY2o6Hb5QVPtp5zNVE9MC3bn/3Zdl+Kz4dTUE8WKY9eyIN9FA
 NClZirIV4080u8ol/RTfGbBkM+O9id9N8urEXnWzm6qG8RpVw2+7FPwO2oAWz7SsgeI2
 VZ0CFsd7Jsa0jCr1Pn+6glKJzYb8eSNnj3wV88bXvjyijP4D+jOPVtQcZtCQbTuL0pg4
 V9Sk5iU9lwMAsDZUSGx3LyuFlWrcWDyP6VwBZnumfr4V+yR3SDf1F1VPf90OR0HmdJDc
 zGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509443; x=1793114243;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9k8qhJbZ249bd2yrx7ySmeGqhBj+F8tPCe0gBrXV8cs=;
 b=j1Jgl+NpMbuqvFcWNLz+OLVCFj93sPfF5hcOM3ULN/88bMQleRcd7Z8OPEaTUVOWkd
 2B8gPj0j1nsEwVeReDqBHGmujr+KfkdH9FyGSuyh3HwHKhTeJ0B1Kd4uoveqBovDuTLo
 973ZfSIn2LPtkCmxO4EZFdb94tEYbBYNmnuRousFxbLhADs6Twy73HmWEsKw3g9sUxxs
 LkDze+GRQt4a6oNtybvYfWAhu2Ru2BZzYLijRAYzfkYgng6RHh6uwc2YjWCrZZDJdSE5
 XbzFroRyaEPdKgkN2V7FUjo+X1A+NRJ0cw1fBi8x2yyJJDfT3kYhtSDqtIyddHBkARgH
 9cDQ==
X-Gm-Message-State: AFq9FYL1Dj3rLAEgmjoCk5qJMMjg3vH2ueQ2+YfJwoYoWc40Y8zXviDZ
 wABlEMdHqdVtqHDRWK/3fMwCcTU+uUMpjscVG02Qaj3Y30u8wwHDdvz2py85ayqQsE5o/vSZtGR
 m9rVnIT4LO+0UDLKsX+VKbLWRKE3nbeD2l0F5sRSyg71IV4b4184oX5MG9zupvlMDnQ==
X-Gm-Gg: AYBFou0SUxs9TChI417zsrnISVD/RSBND0h/Vv4U90UB4MglQzhO0hnxX9uUeiaoXo/
 kr8B/sJUAy7HcCa3DdWjpXJPgti1Jg4W6bXaJdPD7Ivn3BU+tjXD0oenyeYy2Mk5oC+WMguQu18
 UkJjjktzLfMh3u5v6Oq6SgiSP5m1FETxW4/cz/9/AIdUMFTqlYZGkNBcDO45t8nk8pIt+5imwtC
 woY/1/T2d7LcJ14HQmf0qnCB4mAvaWPQZPJ6+C2hPNMgjErLwzQ03ysaTxObMUVLjdGxibTRTzh
 8aF6zzrTZIFL55d/rlNcofg8Q9zjuclDIP2UtmBhAxvEWrTZhhwcbsk6/QgI6LoIHaVg6QZHx2R
 8C7pEjKicqy0BChqhi+qqH+3uBdSJ3hOGH/x23oKbn/oEiZw=
X-Received: by 2002:a17:903:3904:b0:2e2:d77b:e586 with SMTP id
 d9443c01a7336-2e9a6d41400mr107093555ad.60.1792509442781; 
 Tue, 20 Oct 2026 08:17:22 -0700 (PDT)
X-Received: by 2002:a17:903:3904:b0:2e2:d77b:e586 with SMTP id
 d9443c01a7336-2e9a6d41400mr107093265ad.60.1792509442325; 
 Tue, 20 Oct 2026 08:17:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b410626sm656815ad.20.2026.10.20.08.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:17:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 0/3] Hexagon: Fix undefined behavior bugs
Date: Tue, 20 Oct 2026 08:17:17 -0700
Message-Id: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: D0Z5FJ8WtYzNiEHDSz9FQOX3wsL4jY1a
X-Proofpoint-ORIG-GUID: D0Z5FJ8WtYzNiEHDSz9FQOX3wsL4jY1a
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad78603 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_xejiSJ84wRmUESzVQEA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfXww6VdYVCMjl7
 rWn2tslAgqEvniRUsPxfU8cBUWQMjWCiLNyg2kchrnWnj2FRKu1LFkFGirM3dQsTziovSiW21JZ
 bpxntjtNIscUQyCaMN+6GrVJrI97XFEFfu3OMKJcd3YSxyq0gzJkg5xoN/ztIR70qjINp2VllUM
 iOjowcHSAXD37A/f5BGtDToiZxWqbp47RdliAOAyQ6vdZEHu4JUQFFtPXVSYOuzXuCp5m2ZOXvp
 JBVQmCz3+miK5D4dNrr9FkAV4FBRUbLl3BJYgmzTPOLRKJfrWiUywkS5fietD5pqWTHKryVStRv
 QyYETCOOwu/K/bodEghX0gNL7s2WWT0hN7gF6/5a+uVf91YsZ2uaENmAxcgDlzgiRaW/jgqh+aq
 3KQ41Jx8QV5bn1XHaOLBqlGyXdYqAlBNgM5t9yXsPuG4tMzPjLWgdvGF37AvKGo6EgFpK7E9pDW
 75DiiLm9FvP+iB9Gfww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfX9eNpXYfme/MS
 YIh8ct8jqBWVQMIrkS7kwTb7llOiEjPzpRDnj0UsdmsgcJV24BhSapSv/xxTmeuok2xz/FYTXRT
 D2hPMa2xTddr4wvWduFegKjh3RqkyKw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200060
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Q292ZXJpdHkgcmVwb3J0ZWQgYW4gdW5kZWZpbmVkIGJlaGF2aW9yIGlzc3VlIGFuZCBVQlNhbiBz
aG93ZWQgYW5vdGhlcgppc3N1ZSB3aXRoIFVCLgoKSW4gdjM6Ci0gdGVzdGluZyB3aXRoIFVCU2Fu
IGRpZG4ndCBzaG93IGlzc3VlcyBhdCB2MiBidXQgSSB3YXMgdXNpbmcgZ2NjLiAgY2xhbmcKZXhw
b3NlcyBhbm90aGVyIFVCIGJ1ZywgdGhpcyBvbmUgaW4gZGVjb2RlX3NldF9zbG90X251bWJlcigp
LiAgQWRkZWQgYSBwYXRjaAoiYXZvaWQgbmVnYXRpdmUgc2xvdCBzaGlmdCIgdG8gZml4IHRoYXQg
YnVnLiAgUG9pbnRlZCBvdXQgYnkgUGV0ZXIuCgpJbiB2MjoKLSB1cGRhdGVkIHNoaWZ0IGFzc2Vy
dGlvbiB0byB1c2UgYHNoaWZ0ID49IDQxYCBpbnN0ZWFkIG9mIDMuCgp2MjogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAxOTIyMzI1My4zMjQzMDY3LTEtYnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tLwp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC8yMDI2MTAxOTE1MzU1OC4yNDIyMjc3LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoK
QnJpYW4gQ2FpbiAoMyk6CiAgdGFyZ2V0L2hleGFnb246IGFzc2VydCBxZmxvYXQgc2hpZnQKICB0
YXJnZXQvaGV4YWdvbjogcmVzZXQgaW1wbGljaXQgVVNSIHdyaXRlIHN0YXRlCiAgdGFyZ2V0L2hl
eGFnb246IGF2b2lkIG5lZ2F0aXZlIHNsb3Qgc2hpZnQKCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUu
YyAgICAgICAgICAgfCA1ICsrKystCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0LmMg
fCA1ICsrKysrCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgfCAxICsKIDMgZmls
ZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0gCjIuMzQuMQoK

