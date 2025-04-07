Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9C8C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1odH-0004y5-8o; Mon, 07 Apr 2025 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odG-0004xO-3H
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odA-0002ev-Uq
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378drk3016227
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 15:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VVcI9RwFxKt9dR+fd9xRnjviPSIR5ftsMfI4BW8etrY=; b=obSov3Nm9Dea8JD8
 4mZqEbi67tyRnoRMJ/cParW6xG2Ps3Gik4EEoea5/i63XNPmlDXY8cSS77xcQcij
 j8RcTyqabfoTOwSxdfmslaGccBsbCT+u+M+5OLmUS0LrWiBZm3NLvy11ia/X5ttC
 w2quNcdoztT87rkY/3zc1TBiuz2IbzgS0oAmidx/TaXTZEByg7/DqZDVE4KZz89j
 W6Y0LVKf25jLMu3cNMpMMxqahxCRDAPc8K9YxqcDoKwNLqg7LTZdeNQPQDce0RQs
 dIc+aGZEgrcbguXG3vYhcJJr7W4ic0SLnEWkS0KtaI3nqg76aRq9fnnlXkcfr4L4
 j5oCvA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgcrk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 15:43:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-736c7df9b6cso5927613b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 08:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744040602; x=1744645402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVcI9RwFxKt9dR+fd9xRnjviPSIR5ftsMfI4BW8etrY=;
 b=vvJyQMHM0HlNKQKHEApVJOuqfjh1GcXgggJZ4AQAdF3NC+pq5uTU7yX2thYPJTXciH
 n2CZ5wlnkODITD+dbEs8MAgzOSy+kqySEQBAWERmk9qkrsaUsX4kvwWR0VbrcYQogcse
 BAKfCDmVU1JgJWaNpurHvc67rwOX6gXyBSes/5RyqLL18/vvTgOXZOYOvuyOvCllSFdk
 QI/RJTe4bN/XXSbIsr/T7RFIMUDqviLHV/5I8R5hYmPjqeRpAT0SaNCqDJoPCniF8WL5
 OPh5RPnNXGsGJfLSw9jYSCQmGoJsDj86jAF2iz/T0RlLWCbVqB7HGDu+GJuEd7iHqO1W
 FCVg==
X-Gm-Message-State: AOJu0YzYe53hJuZ/wV01VMBWim7vhW+qT+uLfxKCDd93ji4vQGf5L8j3
 izeTy4Dxz+3zszNB26roCmy+HmNyq1KasT6bgZCKVwl24AjqarUJyMXBg5tC9OsPi33Z2cj3qa8
 mCJVlJMgnGQOFRjvjYxzSCxMhwScK4ZJRI+j99WZXX/6f/dCb7CrKxBpug5tJWQ==
X-Gm-Gg: ASbGncs2HHgkC3cBrLhU5/4eF3Fw8ObZ5h6vdzVGrDgGU8u1Wx+y+7nrqGK2xpITvRn
 O1JKtHNgwJYqQ0s33vGPtO5KwZCKrhIN3cJbpj2DUXY7M/IkoSeXNozVFz7PY/jjZ0BMM6ojF1b
 AkCszh8YLCLL7roi+b0y3BGzvoymbJsnKSnd10xrGNGWocRPlzRB6DAFaRupYF+F/l7GGogUIc/
 Y9Z6sndZAqh+w4zIWB5eMdC7DhcV2Q3nnT4ZghfGIYzFg7i+njNAdjSSM2B9AnGlhjo+7oM2bQt
 DVK13+ddCqejhDI+00y55AUOgr3LJAvYmmZfQejq5DMygUQ2GFOYQwrWdPvYpDUH
X-Received: by 2002:a05:6a00:aca:b0:736:34a2:8a18 with SMTP id
 d2e1a72fcca58-739e4f7a0a5mr20548493b3a.24.1744040601589; 
 Mon, 07 Apr 2025 08:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnUERt3XR2wUYMi+8ET/Bvg80a0qd6c1gvrYmJWUmEDC3YcoadDOZJJIB3p2bQzM5mBKGdXg==
X-Received: by 2002:a05:6a00:aca:b0:736:34a2:8a18 with SMTP id
 d2e1a72fcca58-739e4f7a0a5mr20548447b3a.24.1744040601115; 
 Mon, 07 Apr 2025 08:43:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee3fesm8681651b3a.37.2025.04.07.08.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:43:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 1/5] target/hexagon: handle .new values
Date: Mon,  7 Apr 2025 08:43:10 -0700
Message-Id: <20250407154314.2512587-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
References: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f3f29b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=G8g7tdY8SUdx2gpfVe8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: emQJB2Z6NAAt45KltGEUeJBocNedF9Iu
X-Proofpoint-GUID: emQJB2Z6NAAt45KltGEUeJBocNedF9Iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=393 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weSB8IDIyICsrKysrKysrKysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CmluZGV4
IDc1OGU1ZmQxMmQuLjY4MDM5MDg3MTggMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9j
b21tb24ucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMzUwLDYgKzM1
MCw3IEBAIGRlZiBoZWxwZXJfYXJnKHNlbGYpOgogICAgICAgICAgICAgZiJ7c2VsZi5oZWxwZXJf
YXJnX3R5cGUoKX0ge3NlbGYuaGVscGVyX2FyZ19uYW1lKCl9IgogICAgICAgICApCiAKKwogIwog
IyBFdmVyeSByZWdpc3RlciBpcyBlaXRoZXIgU2luZ2xlIG9yIFBhaXIgb3IgSHZ4CiAjCkBAIC0x
MDcwLDExICsxMDcxLDIyIEBAIGRlZiBpbml0X3JlZ2lzdGVycygpOgogICAgIGZvciByZWcgaW4g
bmV3X3JlZ3M6CiAgICAgICAgIG5ld19yZWdpc3RlcnNbZiJ7cmVnLnJlZ3R5cGV9e3JlZy5yZWdp
ZH0iXSA9IHJlZwogCi1kZWYgZ2V0X3JlZ2lzdGVyKHRhZywgcmVndHlwZSwgcmVnaWQpOgotICAg
IGlmIGYie3JlZ3R5cGV9e3JlZ2lkfVYiIGluIHNlbWRpY3RbdGFnXToKLSAgICAgICAgcmV0dXJu
IHJlZ2lzdGVyc1tmIntyZWd0eXBlfXtyZWdpZH0iXQotICAgIGVsc2U6Ci0gICAgICAgIHJldHVy
biBuZXdfcmVnaXN0ZXJzW2Yie3JlZ3R5cGV9e3JlZ2lkfSJdCitkZWYgaXNfbmV3X3JlZyh0YWcs
IHJlZ2lkKToKKyAgICBpZiByZWdpZFswXSBpbiAiTk8iOgorICAgICAgICByZXR1cm4gVHJ1ZQor
ICAgIHJldHVybiByZWdpZFswXSA9PSAiUCIgYW5kIFwKKyAgICAgICAgICAgZiJ7cmVnaWR9TiIg
aW4gc2VtZGljdFt0YWddIGFuZCBcCisgICAgICAgICAgIGYie3JlZ2lkfVYiIG5vdCBpbiBzZW1k
aWN0W3RhZ10KKworZGVmIGdldF9yZWdpc3Rlcih0YWcsIHJlZ3R5cGUsIHJlZ2lkLCBzdWJ0eXBl
PSIiKToKKyAgICByZWdpZCA9IGYie3JlZ3R5cGV9e3JlZ2lkfSIKKyAgICBpc19uZXcgPSBpc19u
ZXdfcmVnKHRhZywgcmVnaWQpCisgICAgdHJ5OgorICAgICAgICByZWcgPSBuZXdfcmVnaXN0ZXJz
W3JlZ2lkXSBpZiBpc19uZXcgZWxzZSByZWdpc3RlcnNbcmVnaWRdCisgICAgZXhjZXB0IEtleUVy
cm9yOgorICAgICAgICByYWlzZSBFeGNlcHRpb24oZiJVbmtub3duIHsnbmV3ICcgaWYgaXNfbmV3
IGVsc2UgJyd9cmVnaXN0ZXIge3JlZ2lkfSIgK1wKKyAgICAgICAgICAgICAgICAgICAgICAgIGYi
ZnJvbSAne3RhZ30nIHdpdGggc3ludGF4ICd7c2VtZGljdFt0YWddfSciKSBmcm9tIE5vbmUKKyAg
ICByZXR1cm4gcmVnCiAKIGRlZiBoZWxwZXJfcmV0X3R5cGUodGFnLCByZWdzKToKICAgICAjIyBJ
ZiB0aGVyZSBpcyBhIHNjYWxhciByZXN1bHQsIGl0IGlzIHRoZSByZXR1cm4gdHlwZQotLSAKMi4z
NC4xCgo=

