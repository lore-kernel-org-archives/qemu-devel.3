Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10852CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbncy-0002ra-NU; Mon, 22 Jun 2026 19:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncx-0002r6-4w
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncv-0002SA-Mu
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbA0X2122413
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=; b=FIaXpITiekwoOgpV
 9dltr9vGDPpu70DqvdL6EkLI8XKt9GsESYtUXhw6Ud77hdJihaw+/Jo99GPqu2FJ
 XAYhaudEpoLE9Ejl74/gQQr7KtU5zjIFbejCfyr0srHiFhRhZGxb2iXIx0cGt6Xd
 WIuAogIIRU/WBrwTnEBP+2aVlx3lDfd51jr3n55rPEFqwMSx784EcJC0BTsmQn8S
 NSQvwwlJL+KuY3IMxf8S0MvunEkYHIZJte++fjzcNx4nfpyOOjKmP9tWWztFKJU4
 iQUAK5v4Cb8yIEl631C5HgsrP/8VqaP9JCnTzpYVpLiM6h/pmRNfJmKYqO+Ytc24
 w02W3Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n421e8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:24 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso5230440c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169224; x=1782774024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=LABjf9JBJSHO6zoIi20t52VmM2eBBlwLyf/wJyWHUKZuFBikxh/W9btXI9D3oYELe1
 0FUaIqV3U8Im8FGRY6niqPgjCsaq+lrRxA0mg/ipY+TmVWKkK/ZPmNzZkQLonlC0NrSW
 Ys5Wf5kzAgMInDLbcPS4c0CZwi+gDvR5tie/RZvrPqdR/ovwDXknTkTbSgGKyjhZyIPZ
 MGZfk/KVVpn8Z5TQE6idzjWxIOBJKpof0p864WbuvDevjvRzbZ8TT29rpTf8aVCHdcj/
 bm/QBuO4dniPOj46r3ef9M9l+BA1Y9xnP5z6PreceEDOELRkw4LqmG2Z0EsrPdirJBZI
 0ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169224; x=1782774024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=dKa0sE3UEQvmMeoKMogRHehxhAOHAQ3KIkhXCLK3ffADbQgOigoBMcQ7AqH1ase26f
 VwN/II+hjrKBxCioB9e3RRLdy5nPGX2yOvexxOKhKdxZgOoeixkdZNyQTP5wUU9gcMXL
 ktwEChB7dSz026mCrEgQbxqqUdNHeHJsYoor/dFHBu86IhV4hVZUuu/Yz+MXoKuqw1xv
 pzQgTmF0CVntaXOWfbjnfozMB/FD/b130jEnoB+5kM6K+AOXTLBosVQS/CxlRZtM/Q6l
 5BGjYbwg27PZH0jxYmTAvSyTrHTYsCIwqKm7Qq80ZWH/GmlqAThjuIE6i7Ac+hdjobi0
 rsag==
X-Gm-Message-State: AOJu0Yxw7/Pm6u7Mgy7GwvurPZy3mECsihZH2nCEhchElIaFAENWoH96
 1hSkQDMhsqsC6nE4Tj7XjtxCdP3N0YIWhTiby88nfijI2fzyZ7n9fwn5TeDlWNNCDURNiwjgUn2
 LfedfrgiRrebK9FLS7a2j5RttQfEvTm6Q+qLGVxlz3f1BNIPcV342YsW0HfUa0oxbWw==
X-Gm-Gg: AfdE7ckTPvgfJQgan6LbhTUhf5PNSoEugRJLCn5RcLBEeZi5dvgmdG1HVS9LZHQRlER
 0RoB3gZSzy7BjnXl3MS5MvnhtQUN19JNtfpy+ZAxpqjeP6YaSR7xf3JRVonEOAKW/wIXUbT13ZW
 XWQpp216rjHVWXEoOUGFwXUf7a3LcrF/sDf9CnuPb+2IKsEI4a9gqyXs6Z6+PYFonUSm8YWR4Hr
 48oCo90mwpJvWRPOiPKyPhAWenLAHXN7XfuxvrUqUis1HV3WPub9g3gQdZYjTvMVzvIhgzvy2cq
 18kyHMdYi9FEOC1biR8oQSIUp7c6Ztp7dI3zFgQWyKhG6EjXTgVwzWJ0tg4nfMprrV0KupE85Th
 08B2hSvbQfZSPGlG/P5//CgaSqbSiZZK17GXoWLpbqL8DyvKeyQ8zSDu5g6w=
X-Received: by 2002:a05:7022:e13:b0:137:edc4:a5e6 with SMTP id
 a92af1059eb24-139a367d1aemr10297888c88.29.1782169223633; 
 Mon, 22 Jun 2026 16:00:23 -0700 (PDT)
X-Received: by 2002:a05:7022:e13:b0:137:edc4:a5e6 with SMTP id
 a92af1059eb24-139a367d1aemr10297861c88.29.1782169223094; 
 Mon, 22 Jun 2026 16:00:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 51/75] target/hexagon: Implement hexagon_resume_threads()
Date: Mon, 22 Jun 2026 15:28:40 -0700
Message-Id: <20260622222904.607771-52-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXzSEj6x659kfz
 yy6itrzq6bM9ZYP1wjaoitiqY7UwOe3bICjRg8rbcwR3YdQgLKnvk+aZJQmgj9Owftp+vahU+HR
 peZmEK9iFC+hNnlPLDhHBRgWtIp+iAI=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39be88 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uy5dMy9T3THg1DqjAFIA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PV3o8Eq18nR4dpDDFLmIOXYL4wChTFjt
X-Proofpoint-GUID: PV3o8Eq18nR4dpDDFLmIOXYL4wChTFjt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX/czKKOIG+yDV
 iSIvJJ5yuNH8Wrn4rksqZCzWdaMSCLQnURhsFgxSD3tgV/NYb+5TuVHNB7RbEkn+6BHVEnm7PQW
 YZI+f2oBiat4+/6XGcHUBcLvIzBWmXFpQg6J0BL59JNu7Ncg7OPGxzUy8f/wPujpacq2azKN7lv
 M9m06jK9I5Tto7Ap5mIn0Fn5+CXkhvS5d2zI/KnpymntYpXL7DLf/8UykRgUk350gvEqe1rPv6q
 b1ufasDL8u4kV6bXTpOgHrKKz4CgEK8BnbuaAI9UFRypm7zT/icM0nxgnnp863w9VDm7cCbWyZK
 u5trjHxJbxDLFwS1P/lo3iTjupY7D53IkH6fsAWJbwjsN694RBQYEsvQMBr5P+tAatGN5YZJp4M
 jYX7vyaQaaHp3lRXCnheswvNnvrx5WAR5Zs1bn+AIpIRliTab2ALbqTs48eXyiC0gMjCDak3uIL
 OQ2nZ5kYfhAzfpzRuSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMgKystCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggOTJkNGJi
OTcxMjkuLjZhOTVhNmJjNWIxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTIsNiArNTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCiAjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CisjZGVm
aW5lIFRIUkVBRFNfTUFYIDgKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhB
R09OX0NQVQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDRkMzE5
YTI2MzdmLi4zNGM1NWI1NjBjYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE2MDEsNyArMTYwMSw4IEBA
IHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAog
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQ
RVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0
LjEKCg==

