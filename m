Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E034C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIe-0004xk-Em; Mon, 29 Jun 2026 09:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHj-0003nR-1i
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHh-0006H1-8K
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATMfN2647667
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=; b=TmfRbjc4bBFea72p
 Mwifieeu2rbNrbhrZ/LO8n3UhFcM6A/wiFv1Y2NR3+0fzQc7A3Sita7/j1EOh7TH
 npXj9Xvz8zRA0qqC52bxLF/Mls5Jz5BEfXIYUSB/ZBh8TH4Hj58smkwvO9g6uatK
 wnTZbhh4qOA/HXFLWIN+6U1KrGAvAluVO05BKff1TjMq2LQaXsUEaTF0m4QsE3nw
 YAgqtLIeIDXitehb3WgqIT9uVrs1G6QJEjKD0JlQYAH75NyMzqQtZdC5i7Jpy7ux
 MA6UFpSN1Jxn1WD8mrTtqBfSM/qU2OWv1ggth0WUVDCEl/cklnI7EUP+aAaFNGMV
 sTGe6g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tshgv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c81db324caso23881935ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740652; x=1783345452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=iQRpaS2goaPbcB73zUQF3wHNSknIx4RB3dIghvCYfWDr5tqL2X506MHOcfanSl5EVs
 TVsnt4HB/aRstsiy6f2OxALwLQKMJ0Do/ngh1rQRlT+enjX+ZU5VuXBfqQ0DeaY/uJe8
 bUp/h9HioFZ77RBOtAmMKJHADyR0FIunW7Z80ANifLYOyAJ2GsEqgJnkqMCQNgQV0Sm8
 FoCZuK6V5MLBV3jqEtrNZZ4w7TLGSv68s3X8DOQQheJ1HoVm2glCpccnk5TXLPVAc+/Q
 gCGSXShXSGKRlzfwC508x68sMNsXN1AAUeMJENMITh7Q0MT6r85GKibjNIUVryqkkw1g
 jCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740652; x=1783345452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=RqPdSmY+tCdrXK0MmoGneNlqlbkScOyUd3e+DJgZZG8/pmepsGJuD4HP7kXLZNojRV
 fQpjQiARfIGoT/YLv68GNoV8SQMNAoHJoop642PtvG6ljA0C9v63LVUDBuzTqvtyJayA
 oe3vlY1EOvKqzxjTBKa3/x6Hk1GJ4/ocpxvU21LW2WwCxKTokyoctLCIZiuAbY8WgHNG
 mJSjAOSic2yDrJ7rbY7jvWKeKlTe4Bj2zkCGTeXYHM/ITTx42utnnMR7ho4RzGqQ6YIW
 kJkzaG8TmBEYPfYHVa8tK1vXLJ41Y5ZhQyb5aqnSb7ar42hiuAKKwjzucZvWQ2teoWDl
 Nvig==
X-Gm-Message-State: AOJu0YyvM+GjbKa7U1cIx7Zh2dWiMJnaNanco7rjT4JZLa8cavT3HO87
 /LCKDwtKQXrIcJiN1zT8ivtSkrCTRauYjgImZ47Kxy1KAodCPbmxBwPbMZOqHqI5J7VWyd1pm7U
 ywCUUTvwnljrB5iPAeMhJrH4yvAVUpceHkhuB2oYAA1UY1Jurgbl/wBvVVFEyDhubDw==
X-Gm-Gg: AfdE7clg9m1eAeozAE5l5SzOHpY+76shVL5t1fNblSBApeVmUH0gO0w/omSnaueKDxO
 z7g1oCAvxqTDEhOrVpAN8oO0i0pS1vnKME+8plCNsiZ4WRDxcafXmkT3QN0sg6w5llgfK8Qr6L4
 4KAQoQDTEFpBSskWuFxi1E4xDPxMmYVRw0QuYLYlWkbBFRGcC+qg0rV0ZTJdqLb9c3hZyWsPmLq
 dH250e6RYQtqj4PuE04VfBeOG0iAgCQ8VN8YlNxHhfbZ1UcM7uSNKIIKgu1ArwbFeoUG097YeVW
 f55kBxvg2c3l9A82d6ltyQP38rX1zjfclMn1RlsNeptCtcoYEv/D5q6J3OMeHGtIux3hwM0BEhH
 hJOXjs+nnrgTxorJXZt3nE7fEH9QkhGExfC+Kj0sRNXOD8jt2hrAm5zfyOAQ=
X-Received: by 2002:a17:902:e80f:b0:2c6:8d95:fd6d with SMTP id
 d9443c01a7336-2ca261cf71emr3944225ad.21.1782740652100; 
 Mon, 29 Jun 2026 06:44:12 -0700 (PDT)
X-Received: by 2002:a17:902:e80f:b0:2c6:8d95:fd6d with SMTP id
 d9443c01a7336-2ca261cf71emr3943865ad.21.1782740651642; 
 Mon, 29 Jun 2026 06:44:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 60/77] target/hexagon: Add pkt_ends_tb to translation
Date: Mon, 29 Jun 2026 06:12:15 -0700
Message-Id: <20260629131232.2487780-61-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX8zJl/Q465s0h
 R5D5XEw3BR+PBjLCjGGNlH/zQ7rdDXHO/tbPXdd6LC2ZiSgdXBRALP5le0oTGraVsPZ70YIz/9T
 Lx6xk5YYA0tvSHXc2dRXZhqTf/Q33J/dwLRDXZGL3jhepCi1qkA716pVVKORl62X9GGlndesVpF
 wfACS9BsdzeBL3Qfl2uyldAiCPm4B0MkRSd6zonOiNbeqTR1VzUniCC6qXRps6rkiA5dLhZCya3
 LXsKELyizbtPzcdgDhDbiHbqjxI3heOB3NJGPJnNpBkl6XNKilP/0U9pqL9Rr5NBCtr9Oir8ND2
 8tU9ieWFUwPrw5FcWNcOJnxayHnKexNA3lrn4YkNAdnF9DRcMZmuQ7PGLvTSIjBXmq7rLtCb0A1
 tCe9/yhrGasubyhpld2MVY3uBQ92oejQO7t1Mlb6xNi5LiqEzFnJyDKRKi4XZtPNhN3363cd6IE
 9IgNdSy9G+fUVmEADTg==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a4276ac cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PUAfe4L2FItr89aHCx8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXzGt7ye8Ab7og
 OtHU6uWbqapapJN8jVtSmR3UwZ1UIWCxecqX3I5p87MhUjaZJrsn7O+Y95Mk7kHh9tYUlNdQ2lQ
 vim8xLIbKwxHf68Cr7NaoJ6EeH2/eZo=
X-Proofpoint-ORIG-GUID: PZATgKgtPNNp3VBwzKjezv0CwdI_xkbK
X-Proofpoint-GUID: PZATgKgtPNNp3VBwzKjezv0CwdI_xkbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgICAxIC0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTAyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTAwIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBmNzliZGVkZDdi
Ni4uZmVhODhjYjJkYjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04Niw3ICs4Niw2IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOwotICAgIGJvb2wgcGt0X2VuZHNf
dGI7CiAgICAgdWludDMyX3QgbnVtX2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCmluZGV4IGNlNWJiZTkyZDVkLi4zNWU5MDM2Mjg4MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTI3
MCw2ICsyNzAsMTYgQEAgc3RhdGljIGJvb2wgY2hlY2tfZm9yX2F0dHJpYihQYWNrZXQgKnBrdCwg
aW50IGF0dHJpYikKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyBib29sIGNoZWNrX2Zv
cl9vcGNvZGUoUGFja2V0ICpwa3QsIHVpbnQxNl90IG9wY29kZSkKK3sKKyAgICBmb3IgKGludCBp
ID0gMDsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKKyAgICAgICAgaWYgKHBrdC0+aW5zbltp
XS5vcGNvZGUgPT0gb3Bjb2RlKSB7CisgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAg
fQorICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRpYyBib29sIG5lZWRfc2xvdF9j
YW5jZWxsZWQoUGFja2V0ICpwa3QpCiB7CiAgICAgLyogV2Ugb25seSBuZWVkIHNsb3RfY2FuY2Vs
bGVkIGZvciBjb25kaXRpb25hbCBzdG9yZSBpbnN0cnVjdGlvbnMgKi8KQEAgLTI4Myw2ICsyOTMs
OTAgQEAgc3RhdGljIGJvb2wgbmVlZF9zbG90X2NhbmNlbGxlZChQYWNrZXQgKnBrdCkKICAgICBy
ZXR1cm4gZmFsc2U7CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIGJvb2wg
c3JlZ193cml0ZV9lbmRzX3RiKGludCByZWdfbnVtKQoreworICAgIHJldHVybiByZWdfbnVtID09
IEhFWF9TUkVHX1NTUiB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX1NUSUQgfHwK
KyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JFR19JTUFTSyB8fAorICAgICAgICAgICByZWdf
bnVtID09IEhFWF9TUkVHX0lQRU5EQUQgfHwKKyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JF
R19CRVNUV0FJVCB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX1NDSEVEQ0ZHOwor
fQorCitzdGF0aWMgYm9vbCBoYXNfc3JlZ193cml0ZV9lbmRzX3RiKFBhY2tldCBjb25zdCAqcGt0
KQoreworICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgeworICAg
ICAgICBJbnNuIGNvbnN0ICppbnNuID0gJnBrdC0+aW5zbltpXTsKKyAgICAgICAgdWludDE2X3Qg
b3Bjb2RlID0gaW5zbi0+b3Bjb2RlOworICAgICAgICBpZiAob3Bjb2RlID09IFkyX3RmcnNyY3Ip
IHsKKyAgICAgICAgICAgIC8qIFdyaXRlIHRvIGEgc2luZ2xlIHNyZWcgKi8KKyAgICAgICAgICAg
IGludCByZWdfbnVtID0gaW5zbi0+cmVnbm9bMF07CisgICAgICAgICAgICBpZiAoc3JlZ193cml0
ZV9lbmRzX3RiKHJlZ19udW0pKSB7CisgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CisgICAg
ICAgICAgICB9CisgICAgICAgIH0gZWxzZSBpZiAob3Bjb2RlID09IFk0X3RmcnNwY3ApIHsKKyAg
ICAgICAgICAgIC8qIFdyaXRlIHRvIGEgc3JlZyBwYWlyICovCisgICAgICAgICAgICBpbnQgcmVn
X251bSA9IGluc24tPnJlZ25vWzBdOworICAgICAgICAgICAgaWYgKHNyZWdfd3JpdGVfZW5kc190
YihyZWdfbnVtKSkgeworICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICAgICAg
fQorICAgICAgICAgICAgaWYgKHNyZWdfd3JpdGVfZW5kc190YihyZWdfbnVtICsgMSkpIHsKKyAg
ICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfQorICAg
IH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisjZW5kaWYKKworc3RhdGljIGJvb2wgcGt0X2VuZHNf
dGIoUGFja2V0ICpwa3QpCit7CisgICAgaWYgKHBrdC0+cGt0X2hhc19jb2YpIHsKKyAgICAgICAg
cmV0dXJuIHRydWU7CisgICAgfQorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLyogU3lz
dGVtIG1vZGUgaW5zdHJ1Y3Rpb25zIHRoYXQgZW5kIFRMQiAqLworICAgIGlmIChjaGVja19mb3Jf
b3Bjb2RlKHBrdCwgWTJfc3dpKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
Y3N3aSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2NpYWQpIHx8CisgICAg
ICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNF9zaWFkKSB8fAorICAgICAgICBjaGVja19mb3Jf
b3Bjb2RlKHBrdCwgWTJfd2FpdCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFky
X3Jlc3VtZSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2lhc3NpZ253KSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfc2V0aW1hc2spIHx8CisgICAgICAg
IGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNF9ubWkpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNv
ZGUocGt0LCBZMl9zZXRwcmlvKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
c3RhcnQpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9zdG9wKSB8fAorICAg
ICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfazBsb2NrKSB8fAorICAgICAgICBjaGVja19m
b3Jfb3Bjb2RlKHBrdCwgWTJfazB1bmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUo
cGt0LCBZMl90bGJsb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxi
dW5sb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfYnJlYWspIHx8Cisg
ICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9pc3luYykgfHwKKyAgICAgICAgY2hlY2tf
Zm9yX29wY29kZShwa3QsIFkyX3N5bmNodCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShw
a3QsIFkyX3RsYnApIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl90bGJ3KSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTVfY3RsYncpIHx8CisgICAgICAgIGNo
ZWNrX2Zvcl9vcGNvZGUocGt0LCBZNV90bGJhc2lkaSkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7
CisgICAgfQorCisgICAgLyoKKyAgICAgKiBDaGVjayBmb3Igc3JlZyB3cml0ZXMgdGhhdCB3b3Vs
ZCBlbmQgdGhlIFRCCisgICAgICovCisgICAgaWYgKGNoZWNrX2Zvcl9hdHRyaWIocGt0LCBBX0lN
UExJQ0lUX1dSSVRFU19TU1IpKSB7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICBp
ZiAoaGFzX3NyZWdfd3JpdGVfZW5kc190Yihwa3QpKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKyNlbmRpZgorICAgIHJldHVybiBmYWxzZTsKK30KKworCiBzdGF0aWMgYm9vbCBuZWVk
X25leHRfUEMoRGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgLyogQ2hlY2sgZm9yIGNvbmRpdGlv
bmFsIGNvbnRyb2wgZmxvdyBvciBIVyBsb29wIGVuZCAqLwpAQCAtNDM5LDcgKzUzMywxMSBAQCBz
dGF0aWMgdm9pZCBhbmFseXplX3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKIAogc3RhdGljIHZv
aWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKIHsKLSAgICB0YXJnZXRfdWxv
bmcgbmV4dF9QQyA9IGN0eC0+YmFzZS5wY19uZXh0ICsgY3R4LT5wa3QuZW5jb2RfcGt0X3NpemVf
aW5fYnl0ZXM7CisgICAgUGFja2V0ICpwa3QgPSAmY3R4LT5wa3Q7CisgICAgdGFyZ2V0X3Vsb25n
IG5leHRfUEMgPSAoY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2swbG9jaykgfHwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxibG9jaykpID8K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPmJhc2UucGNfbmV4dCA6CisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5iYXNlLnBjX25leHQgKyBwa3QtPmVuY29k
X3BrdF9zaXplX2luX2J5dGVzOwogICAgIGludCBpOwogCiAgICAgLyogQ2xlYXIgb3V0IHRoZSBk
aXNhc3NlbWJseSBjb250ZXh0ICovCkBAIC05NDQsNyArMTA0Miw3IEBAIHN0YXRpYyB2b2lkIGdl
bl9jb21taXRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPnBrdC52aGlz
dF9pbnNuLT5nZW5lcmF0ZShjdHgpOwogICAgIH0KIAotICAgIGlmIChjdHgtPnBrdC5wa3RfaGFz
X2NvZikgeworICAgIGlmIChwa3RfZW5kc190YigmY3R4LT5wa3QpIHx8IGN0eC0+YmFzZS5pc19q
bXAgPT0gRElTQVNfTk9SRVRVUk4pIHsKICAgICAgICAgZ2VuX2VuZF90YihjdHgpOwogICAgIH0K
IH0KLS0gCjIuMzQuMQoK

