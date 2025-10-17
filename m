Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E901CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rPm-0004RY-Uh; Fri, 17 Oct 2025 16:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPi-0004Q8-2K
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPc-000317-FN
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGmnV005388
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=FiZ9IvDDXNuQ1ugk8PZI7PUy/jDxsR9mlJ09zHO3gvE=; b=U/
 H6GHLK4uHIgOJX3EktH2SzXMTIqJfEN/B4P0m1MPe4owNmzHFfYTJFz8yo5BFCzq
 hNmy+AC9YWOUqUMIVA9ru7J6hy/pdbO7z1DIyYd7k5MZchQPiPZRBhoh/qlrLUIj
 8f8CVYw9N4nQyHlfLadAuhOHjA5aQQ5Mcihqp/tpo21lJoVxHZG+rk11sLvJMId3
 X8zB4mMOw9Kuec5XxQMBYtqpVM9xq8A1KON64yG9iNs37S5bnV4FmdjDNeGy4zFU
 pS4bkYW5MtrsCeIxOhXDH4YlzdnOm/51z1Lx7I0n+3Vn3Zya7fTWy7L//haNMZIP
 ClHQ7+UzX3N+2HH1MQGQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5wu9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:53 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-78038ed99d9so4154913b3a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 13:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760734252; x=1761339052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiZ9IvDDXNuQ1ugk8PZI7PUy/jDxsR9mlJ09zHO3gvE=;
 b=X+wSr93CE5hxguIIyBo+bHJMzGXqXd1V7xcysfyAw007Co0j/CiQ+/vTt7pv5JttBW
 DnuaEGpPZQacIAb5ksdmHN+l8bscWdftWqhly8P1xCgaZa6+F/cWwo4VP25mOYyjgqeb
 7egeyDeuRPonTBrhZI7QXCd2UO64xIMC3uB2xMGx9dZxbdUNikLRElGxwElwdilY226w
 MeJMHy2wsuZb+RHU3NOTo007LwvfmZv0iLQAg7j87OhZf2Dyy5t6N6Vdm2QA8mKQeKV1
 cHNlxJ4+KFOQjtQVMJCSvPlg4lgksOOOvC5qKfeJiSSDogiRpoc2qSd4PsfUnOBDXWYH
 EIEQ==
X-Gm-Message-State: AOJu0YxVcjnPj3rz70BCEqr5883eD35jadmDHfoXGAEaYiOMxZe5V9L2
 lSOglxU8jr8e3lQYaD5K1BaUBLd0GRSJgtxlraxflzhQPKHAByJLIM16lHWDoLNECEn8RwUGcld
 V29kv1/0p+kAiYEownKT8ncyV5wHOCAFZsSqWpfJMgnARdTjw2/BAM1JwnZcW4zMnYA==
X-Gm-Gg: ASbGncstLULfqpepCzfnzda9xxjR5yPHf/ov9ysgE7XdzG4EliulzVn4ugQHufHas0X
 HCGaIjOi8JW44u+IB0vmIwhtwhOnyk9BFGWvil9hX6qVKCM0BGLwAQibuFd9dFMhherWG6PID5g
 wgwnCrIR+IrftTJStqhOECgH7mWpdv4x94KbZxd8yj0NIJaBgwt0h8wlrIJ3fViZaSj8+VtEUpz
 IcyQWLXyOBa6u7ZQjHDu1NWWPzS13LdlOfo1DUZEIEYzAHJ9hPYMFTLEB6wJ1Gu3UHMroDLmxy0
 5DXT5GFzcw+Mrn3rWGT6BVtWAv4UNTjzfMDpKriB0N3PYr7OuRxAdpQFHTa/g81P6GiaPIPo5WN
 GYQHzGwyWOWGEP9B0ndvqmArtQCdGJYos4Drj3mLV2nE6at4=
X-Received: by 2002:a05:6a00:2308:b0:792:52ab:d9fe with SMTP id
 d2e1a72fcca58-7a220440d9fmr5998900b3a.0.1760734251837; 
 Fri, 17 Oct 2025 13:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzsh7tiSwSJC1rUTTZ558GN8mSOOBE7M6ec3mI7PUVKgn+m09AvAuf6q2VB8RSx87o6uO3Zg==
X-Received: by 2002:a05:6a00:2308:b0:792:52ab:d9fe with SMTP id
 d2e1a72fcca58-7a220440d9fmr5998880b3a.0.1760734251377; 
 Fri, 17 Oct 2025 13:50:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f251fsm495080b3a.39.2025.10.17.13.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:50:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 2/8] linux-user/hexagon: use abi_ulong
Date: Fri, 17 Oct 2025 13:50:22 -0700
Message-Id: <20251017205028.1105595-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
References: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: D1G1EHhF0pD9Oms6G2uvdta-xtCCS6KT
X-Proofpoint-ORIG-GUID: D1G1EHhF0pD9Oms6G2uvdta-xtCCS6KT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX4Bpk7Ts3zc7T
 x7O0rilRtNUbrFv0IutErl+H2cISoLfoq4GUMuvy+GTNtZIpW40I2AeHvJjnrV+oViINDb4+SfT
 C3/ciHe8IegqI2oeR9wTeJB0Iq6YjbfvY3KDwZxAoo2NuuHMLCrUmPGohbeXObZsq1T5wGaxvFY
 DMGSZAsRx+rRYCdcK0+hRW+xsFKLhYHK/11rITwU1HSdPnZP3eyQAesdBK6KfswM7tRl+OFGXWE
 Ue7/hbzOBINzYdm6RCpn7Ei0U8L+i7EaeJyqaxj2Kma8mupc2loc3sG02B8QKAkvf84F80TNT1o
 KGo+qpkdeEjPCfYUuQ9j+16bVR1OBl2qeaeXCQ0Of9HjxTJQLMFmE8iAtpI7RmgTqS9V7hp8JJS
 Ehwar/UQzoQXAmwhZwrQVDrKBFiZaw==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f2ac2d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=pDBHowQsxXgegazyqkAA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Q2hhbmdlIHRoZSB1c2VyX3JlZ3Nfc3RydWN0IHRvIHVzZSBhYmlfdWxvbmcgaW5zdGVhZCBvZgp0
YXJnZXRfdWxvbmcuCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzdi
ZjNkOGM1LWRmMDctNGNiZC1iYTYyLTRjNzI0NmE1Zjk2YkBsaW5hcm8ub3JnLwpTdWdnZXN0ZWQt
Ynk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpSZXZp
ZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3
ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3
ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogbGludXgtdXNlci9oZXhhZ29uL3NpZ25hbC5jIHwgNTIgKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDI2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi9zaWduYWwuYyBiL2xp
bnV4LXVzZXIvaGV4YWdvbi9zaWduYWwuYwppbmRleCAyODQ3OTUyMjE2Li5lNTUxNGIyYmVjIDEw
MDY0NAotLS0gYS9saW51eC11c2VyL2hleGFnb24vc2lnbmFsLmMKKysrIGIvbGludXgtdXNlci9o
ZXhhZ29uL3NpZ25hbC5jCkBAIC0yNCwzMCArMjQsMzAgQEAKICNpbmNsdWRlICJsaW51eC11c2Vy
L3RyYWNlLmgiCiAKIHN0cnVjdCB0YXJnZXRfdXNlcl9yZWdzX3N0cnVjdCB7Ci0gICAgdGFyZ2V0
X3Vsb25nIHIwLCAgcjEsICByMiwgIHIzOwotICAgIHRhcmdldF91bG9uZyByNCwgIHI1LCAgcjYs
ICByNzsKLSAgICB0YXJnZXRfdWxvbmcgcjgsICByOSwgcjEwLCByMTE7Ci0gICAgdGFyZ2V0X3Vs
b25nIHIxMiwgcjEzLCByMTQsIHIxNTsKLSAgICB0YXJnZXRfdWxvbmcgcjE2LCByMTcsIHIxOCwg
cjE5OwotICAgIHRhcmdldF91bG9uZyByMjAsIHIyMSwgcjIyLCByMjM7Ci0gICAgdGFyZ2V0X3Vs
b25nIHIyNCwgcjI1LCByMjYsIHIyNzsKLSAgICB0YXJnZXRfdWxvbmcgcjI4LCByMjksIHIzMCwg
cjMxOwotICAgIHRhcmdldF91bG9uZyBzYTA7Ci0gICAgdGFyZ2V0X3Vsb25nIGxjMDsKLSAgICB0
YXJnZXRfdWxvbmcgc2ExOwotICAgIHRhcmdldF91bG9uZyBsYzE7Ci0gICAgdGFyZ2V0X3Vsb25n
IG0wOwotICAgIHRhcmdldF91bG9uZyBtMTsKLSAgICB0YXJnZXRfdWxvbmcgdXNyOwotICAgIHRh
cmdldF91bG9uZyBwM18wOwotICAgIHRhcmdldF91bG9uZyBncDsKLSAgICB0YXJnZXRfdWxvbmcg
dWdwOwotICAgIHRhcmdldF91bG9uZyBwYzsKLSAgICB0YXJnZXRfdWxvbmcgY2F1c2U7Ci0gICAg
dGFyZ2V0X3Vsb25nIGJhZHZhOwotICAgIHRhcmdldF91bG9uZyBjczA7Ci0gICAgdGFyZ2V0X3Vs
b25nIGNzMTsKLSAgICB0YXJnZXRfdWxvbmcgcGFkMTsgLyogcGFkIHRvIDQ4IHdvcmRzICovCisg
ICAgYWJpX3Vsb25nIHIwLCAgcjEsICByMiwgIHIzOworICAgIGFiaV91bG9uZyByNCwgIHI1LCAg
cjYsICByNzsKKyAgICBhYmlfdWxvbmcgcjgsICByOSwgcjEwLCByMTE7CisgICAgYWJpX3Vsb25n
IHIxMiwgcjEzLCByMTQsIHIxNTsKKyAgICBhYmlfdWxvbmcgcjE2LCByMTcsIHIxOCwgcjE5Owor
ICAgIGFiaV91bG9uZyByMjAsIHIyMSwgcjIyLCByMjM7CisgICAgYWJpX3Vsb25nIHIyNCwgcjI1
LCByMjYsIHIyNzsKKyAgICBhYmlfdWxvbmcgcjI4LCByMjksIHIzMCwgcjMxOworICAgIGFiaV91
bG9uZyBzYTA7CisgICAgYWJpX3Vsb25nIGxjMDsKKyAgICBhYmlfdWxvbmcgc2ExOworICAgIGFi
aV91bG9uZyBsYzE7CisgICAgYWJpX3Vsb25nIG0wOworICAgIGFiaV91bG9uZyBtMTsKKyAgICBh
YmlfdWxvbmcgdXNyOworICAgIGFiaV91bG9uZyBwM18wOworICAgIGFiaV91bG9uZyBncDsKKyAg
ICBhYmlfdWxvbmcgdWdwOworICAgIGFiaV91bG9uZyBwYzsKKyAgICBhYmlfdWxvbmcgY2F1c2U7
CisgICAgYWJpX3Vsb25nIGJhZHZhOworICAgIGFiaV91bG9uZyBjczA7CisgICAgYWJpX3Vsb25n
IGNzMTsKKyAgICBhYmlfdWxvbmcgcGFkMTsgLyogcGFkIHRvIDQ4IHdvcmRzICovCiB9OwogCiBR
RU1VX0JVSUxEX0JVR19PTihzaXplb2Yoc3RydWN0IHRhcmdldF91c2VyX3JlZ3Nfc3RydWN0KSAh
PSA0OCAqIDQpOwpAQCAtODUsNyArODUsNyBAQCBzdGF0aWMgYWJpX3Vsb25nIGdldF9zaWdmcmFt
ZShzdHJ1Y3QgdGFyZ2V0X3NpZ2FjdGlvbiAqa2EsCiAKIHN0YXRpYyB2b2lkIHNldHVwX3NpZ2Nv
bnRleHQoc3RydWN0IHRhcmdldF9zaWdjb250ZXh0ICpzYywgQ1BVSGV4YWdvblN0YXRlICplbnYp
CiB7Ci0gICAgdGFyZ2V0X3Vsb25nIHByZWRzID0gMDsKKyAgICBhYmlfdWxvbmcgcHJlZHMgPSAw
OwogCiAgICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMF0sICZzYy0+c2NfcmVncy5y
MCk7CiAgICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMV0sICZzYy0+c2NfcmVncy5y
MSk7CkBAIC0yMTEsNyArMjExLDcgQEAgYmFkZnJhbWU6CiBzdGF0aWMgdm9pZCByZXN0b3JlX3Np
Z2NvbnRleHQoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHRhcmdldF9zaWdjb250ZXh0ICpzYykKIHsKLSAgICB0YXJnZXRfdWxvbmcg
cHJlZHM7CisgICAgYWJpX3Vsb25nIHByZWRzOwogCiAgICAgX19nZXRfdXNlcihlbnYtPmdwcltI
RVhfUkVHX1IwMF0sICZzYy0+c2NfcmVncy5yMCk7CiAgICAgX19nZXRfdXNlcihlbnYtPmdwcltI
RVhfUkVHX1IwMV0sICZzYy0+c2NfcmVncy5yMSk7Ci0tIAoyLjM0LjEKCg==

