Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C743606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K3Jnms+W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d0+bnnNk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpv-0006ZT-9g; Tue, 20 Oct 2026 23:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJMoF-0004Av-SH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJMoC-0002nl-NJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F1Gx336656
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=wqBFwqBOmGVCAvk2MfrGHo
 J4ZQKj1fkKsi9NqTk2ODk=; b=K3Jnms+WW7rSgCugafMSBhw2eSTy317n+1gwh7
 MqE/QJ904o6qaefgA2KaKWPDFo+nFeLwXNLDxMW+UvTz5dNd3C/R7No6nhQIREMZ
 lXOIoA4C1M943voChakM5Wk6QPNXZ6Q3QKRFA+nv8KG7P7LtHDH7f1t7bIV/qjXs
 VXNTCewIqAlR8Fd6eZGybNfGkRjvJmTFkjE72u+XHLyHefdItqA7uH61N/mpEfSJ
 RY209zJvbmocCgf8z2YC2gAwGhHIspiDCMh3KKmkcpimgXpjP55Wdy1VrQnMyNAg
 NVe+k7umHA8Z6oKv9sxZAQXlmWRy1N/gpMFuLYt1x5FiciHA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabhrf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so587146eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552556; x=1793157356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wqBFwqBOmGVCAvk2MfrGHoJ4ZQKj1fkKsi9NqTk2ODk=;
 b=d0+bnnNk0WJkpM9qHodyZsW3s5U1LfKcYxot1zJ5vyfIIn7UbGovBI1YhzaaiZ6ET+
 v3wa/nF92dubNuV4JL2x7Q+aCQoAiVgaUF1CEBm1eFxzs0jGlJmNhVccq0n45fQ7bY32
 bR4QHKUdXOMU57vX2Acb+6DGB1tbs69dDtRkK77uOB2ZcGYMpIEQi9LL4UuVx7dWxnVN
 aQJpNEps3HWEK9TRvKs0JBUkcb2qcGinGw9RWEbn75PzTChswmbf4b2AJGU7wXg/4goG
 9furHNfyZY/aEu0Ps46p7AZi/E9t+Sve1+dn8db5K4m0TcFGmLZ8jyumj46dFyNg0Pru
 h/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552556; x=1793157356;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wqBFwqBOmGVCAvk2MfrGHoJ4ZQKj1fkKsi9NqTk2ODk=;
 b=uW/eEqRHXt3iiiVqKcr1ukFDUmpwrQUyurtGdWbzFbvQOlbQ2ydmrpdsWHU2enYmnC
 LxMfY3XBie0bncqD3NKyWEfWmiNWebCUOrm5WXkVjLoOpJYBn6R/yN4ZtbrDTe0YtVA9
 tz3viGFWT1BTlqhk2ZatDn6Htnkm/JYlcFPfUk7Q0qAxlczqcSruBTgoLaI9/1GluQ+e
 xqbVglAvlC3EZJtu2kibXkc4V+WW0nI3nD7ffn3h/lEEkUwvnaqrpyly3o6JfTUZubml
 80ZdgbDirmCVcbvBcqRUzUqKC03tfZGnWh6YMRE2V2rtbAradSHNkGbeAe9+X3+Cl2if
 V6wQ==
X-Gm-Message-State: AFq9FYI9o1NTf9Ikwc9+wFjAYTHRA7ZzzmmZKuhBAPxrEYhj2+8QYXPN
 g4AGs1vPF0WtHD1LDQnXkqZ9Kx/iPWnHa/b2wTQyb2bvs44EMkVr6LCtnlC9WSfzM7mtin2RMz9
 TyhFyW37aAvoWXHHgpXmvgwqiXMOneEkWKkqWb7FIAXzfPu7l/lHW6OlD6B+sFm/v4Q==
X-Gm-Gg: AYBFou08198z0w3UmFTlRbb2FUkYRuoiLam3J/UxwL9WQQEJRVR9d2CMz4WE+/6L9F+
 XL5Ok1ekBUZr1I+9leVre/vE98GGUjGzicQuiKB/+3iPG3dntiD8M29XMu0R+h/w7fq7fBssP1e
 Zep9/HLULAndHbN8zLhgALUpHss/Cp0IpiZ/rTnvcLEoMr/RXceM6aHGCISESP20ogdGdkaaWJZ
 CiX8jyF1t50x5tERFsAxF7BhcxHBCfFloxW4W7V2XMyxjp3x4ChwUrzsb6gPYVqMMoqxeDA7MGQ
 +heMq2GPzPaTUKbocMZT5btqbyfSHWBbFaqUGj1FgIqkgbgN5D1fh5r9qMK95CWukoMA9nB7IC8
 9Tp3S1iRQSz7H48bt1P3gd5se86/a1GnGCrLnui2kRe5+BVk=
X-Received: by 2002:a05:693c:608b:b0:35c:ef18:6a78 with SMTP id
 5a478bee46e88-3674a41869amr1746100eec.2.1792552556388; 
 Tue, 20 Oct 2026 20:15:56 -0700 (PDT)
X-Received: by 2002:a05:693c:608b:b0:35c:ef18:6a78 with SMTP id
 5a478bee46e88-3674a41869amr1746075eec.2.1792552555720; 
 Tue, 20 Oct 2026 20:15:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674198f1cdsm3208959eec.25.2026.10.20.20.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 20:15:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Hexagon: performance improvements - tlb, l2vic
Date: Tue, 20 Oct 2026 20:15:51 -0700
Message-Id: <20261021031554.1942011-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX7kc9qJ/GS97a
 C86Lqa9L2A4uYqUoOvt9jMoWPJeAZvWxSeVsQx2mPc/+Tdv1HkASkv0jF2cZ61VwQMn1l6bkGWL
 e9CYJR1Yz/9ImNZR1z4gsnrTJzzhIp0=
X-Proofpoint-ORIG-GUID: xye1bIzFrWEnb361a-9CxYLpAD4IVGJk
X-Proofpoint-GUID: xye1bIzFrWEnb361a-9CxYLpAD4IVGJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX/ftOFKBWN6Xt
 GvDfw+RTRxc0vF+FthBG9UebpcMPtHVnpNB3B9OGvAuX/ZCx97H+tGvNfXJCtx1jRTbro49Y3MY
 OzUFJauIcR2gh3l6i+op/+AWCc5sCH9t6QwmaKK9MGW8IjhCG/DItkxfgV5G9dywd7VS63bDCa3
 AJLqt13P9h0xQKM6uefmRsyRGzbyS9jHJfWuWVmhvK6/bBGqfTN3jeEbUDFhjLXWPEWguWTtEjz
 1XC7C3cj5/FLMjrUox4oSDv9jSMz+Cpv7VIjTXKEfOn44DCanSmJYnbSmeJZ2GRl0DD92kvvbTF
 xMgBHpOmOyxi4Rv+9mAKCBdFecQ10uODzoeMAHzQ7p3PDRtrrgJ1bgpuB9cxd/IS/KJfUDvg02j
 Mz7HNmRfjqBlqj+MdzYoBJ0H63mvMNMO0QPlKAKxogiY1vR90RbV4AIzmvJEa2r2/xMWFSqafbL
 C0VMxSaTbyxG7mSF04A==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad82e6d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jY8F8F7njYOI6Q6ljTcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210012
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SW4gdGhpcyBzZXJpZXMgd2UgaGF2ZSBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBpbXByb3ZlbWVu
dHMgZm9yIHVzZSBjYXNlcwpsaWtlIGJvb3RpbmcgbGludXguICBUaGUgZ2FpbnMgY29tZSBmcm9t
IGF2b2lkaW5nIHJlZHVuZGFudCBUTEIgZmx1c2hlcyBhbmQKb3B0aW1pemluZyB0aGUgY3JpdGlj
YWwgcGF0aCBvZiB0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgc2NhbiBsb29wLgoKSW4gdjI6Ci0g
Y2xhcmlmaWVkIHRoZSBjb21tZW50IGluIGwydmljX3VwZGF0ZV9hbGwoKQoKdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjEwMjAxNTE3MjAuNzI4ODg4LTEtYnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoMyk6CiAgdGFyZ2V0L2hleGFnb246
IGZsdXNoIHRoZSBzb2Z0dGxiIG9uY2UgcGVyIHRsYmludmFzaWQKICB0YXJnZXQvaGV4YWdvbjog
b25seSBmbHVzaCB0aGUgc29mdHRsYiB3aGVuIFNTUi5BU0lEIGNoYW5nZXMKICBody9pbnRjL2hl
eC1sMnZpYzogZmluZCB0aGUgbmV4dCBwZW5kaW5nIGlycSBhIHdvcmQgYXQgYSB0aW1lCgogaW5j
bHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmggfCAgMiArKwogdGFyZ2V0L2hleGFnb24vY3B1
LmggICAgICAgICAgICAgfCAgOCArKysrKysrKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMu
aCAgICAgfCAgMyArKysKIHRhcmdldC9oZXhhZ29uL2hlbHBlci5oICAgICAgICAgIHwgIDEgKwog
dGFyZ2V0L2hleGFnb24vaGV4X21tdS5oICAgICAgICAgfCAgMyArKy0KIGh3L2hleGFnb24vaGV4
YWdvbl90bGIuYyAgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKysrCiBody9pbnRjL2hleC1s
MnZpYy5jICAgICAgICAgICAgICB8IDE3ICsrKysrKysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdv
bi9jcHVfaGVscGVyLmMgICAgICB8IDE3ICsrKy0tLS0tLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdv
bi9oZXhfbW11LmMgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KIHRh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgIHwgIDYgKysrKysrCiAxMCBmaWxlcyBjaGFu
Z2VkLCA4MCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCi0tIAoyLjM0LjEKCg==

