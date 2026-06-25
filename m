Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07DECDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcksz-0006et-RW; Thu, 25 Jun 2026 10:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksx-0006dt-Dn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksw-0008QV-0h
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9ju5x1723259
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=; b=Hc
 c2Rv7dq2UDP+pqZI2YhRtRuugsTGTRuxx9yWJqm/uewYlbgh3JL3kJHlxSp28urb
 v4dNyN2HVmoax2X1iFs4XDvm4x+6/s6/9jH1qPd8BLc17QRC0deIwb/LbTkd+NqK
 2WYAWSh28+S0ucFdO6dT5ujC/Kip6bkROfPqwpK6nO34EHgD8HNLXQuhYSLGFa1Q
 C6ksytieUoklXti3J2S4gNqFwOsyLhV0b6mlxwJD6j9VauiffatQJLTNsQ1UVhUK
 UbRvHBvJgFOUcppdsxdeXZCBPBd/ybA5coAjaRMWs2I3zmUwZkItIDH6GH2vRUAM
 pl0ovCXOr6YRHTZ5Y50Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dvnpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c50cd6cbcso2570242eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397012; x=1783001812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=SUXDcRKj0pWT4eSPDQ3kOAu1kbePHBuHUL8H9Bx50VVEsWwixk4VQ5iehEgSqPq0v4
 /gX4yoqMbPklhSN6JvnR+ir24prAVoOR0xqYxrQodu3UMLNCL0Olxxyr58CZ66gJqa9w
 gbMFtgkkORdvALAeaqDIqyfkmkxsS0KIYNXu0S3N2czdKYkJvcCL6Fj6496Fu2gaCmXI
 yPerqBvsfp1Mk09A+9saemmggUrTV8G2mP1dFBr2wTT3jv/wzf3Wu93cm2BrUZ4VnqQ7
 YZemkWwSEaklF7u+O0M9CZmNGI3WHv42IGM39nVwcAgc2MClAtiWR0bX8C7oHS10lHrF
 dGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397012; x=1783001812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=X4QYGot+Y+f2/soAt2TQc1cFAxFtoEWUT26u9zmQ5BaxtV/uEr6hqSEzlk6iiIdaEM
 mEL4zQkjkllcbAAcJWFJXyCIKkky9xBTDfr+AaQ6dbBGcbcW+Sr9q3UA0jfZlhX1c/JK
 KHHWF55jveVJ9j/v19cNYV8vs6R1Jjt7uZFMTioa2XbZqKlTbX04fpkSzbcHOywZSdYv
 k/bF8DKYkMp8fs/uAkt/Ur/n7j99n8ZyfUfY4po0RYqI1wuS/SGCV1uwA18oeiUzmN85
 RshmgYWwgSBPH9QrVdW15cMksi17GvnkKa/uVX0o8LGM+SBV9BZzCPuqPhCzz0R/avBj
 oemw==
X-Gm-Message-State: AOJu0YwnzEIHe5J1hN1rCD4wB3yafoH6l22LCoaXwlBHeU5Lis55Nxyk
 6ZNA5W7PaxPqkfNEEzqR+yGAd/EC3CMfKZ6hJkG5skkgTHy/cyNg6WguDxTloVvTFwpLgNEAHsW
 Mo4BkLKfh0N90k1ke9MFmOWuPVPTgdAPCJyxECh5e9W2bwcqa0KMY9flg8rroetdKFw==
X-Gm-Gg: AfdE7cl0Fha2kU5K0QEflOYu3XIztr7R0RSI+hvv+J4ISgH2CZHtTluBCYLV1wk3XeA
 wp4bCaIgM7Fw9lUTia6hUpKxeFjiHg5XvuLlpcLIjQXitfgMy5dg+TuKIEYNmMWtZke4oeAt+uk
 TV43mEcZzvaBKtA9MW/O6fgsyU4tnSCvZ4N6srgzGcsnbcS/cyTxQ/tfsCiEJlv+VqbPJ58IIs3
 2WR3nAdnw7f3iEpCyiG+N882fiNb2OiOAJOsQeH6rCGdKtadpgv6lsu9mwux3U+dU/CrC/ABlaE
 NCo/z2EEjNXzhGEtXhQ8YWFLFm7IagNaCIGhzW+7QQPq10WrsuzsyrRTS+CbLR5Y4sWaFPHB4NU
 0F1X4WMTNTiMNSrcthooNzoQXYOPhdTK6ijCojz8KbtfrOmvXUIUnOO6hZ98=
X-Received: by 2002:a05:7300:f108:b0:30c:5807:abbb with SMTP id
 5a478bee46e88-30c84cb1ab9mr2643417eec.20.1782397011915; 
 Thu, 25 Jun 2026 07:16:51 -0700 (PDT)
X-Received: by 2002:a05:7300:f108:b0:30c:5807:abbb with SMTP id
 5a478bee46e88-30c84cb1ab9mr2643352eec.20.1782397011245; 
 Thu, 25 Jun 2026 07:16:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:16:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 06/76] target/hexagon: Fix badva reference, delete CAUSE
Date: Thu, 25 Jun 2026 07:15:23 -0700
Message-Id: <20260625141633.449487-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: nmUwSEJKLOs7ZRzJWzrxoZHcUJZtNRhG
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d3855 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX+H3/MuZkO5x3
 SSO7tXc8RZlkUgzIRigMTYNa9okvZLqGHwW8Ida8fzVtdCwklv1LglQxN1bbnDkuX0sj16dMj4d
 b2+hhAW7GFkAW/kxM+rRTctAyh0tmGA=
X-Proofpoint-ORIG-GUID: nmUwSEJKLOs7ZRzJWzrxoZHcUJZtNRhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX+B0zac38bGwi
 Hk7ku+WMDkfHa3FV9gwZYJqvLHYxY/ErFTGTOL5P/RhUjYR1MGTCQ/S4L76JJSHMPd4oNYpyaPe
 n3606/bIZVs85eiHeUrnr/4ADh2A7L6IU9e+bBmY/Qb0VTutDsFs3OZzJAdlINnGR65PA3exjXu
 WHPzW2fdaVK8TRr65I8vEGNTNfAnMdXrfp3oIR84PTRtFSfHOHc4IPnGPNcSy/I0COQuTTaM2Yj
 WmQl1sYocuqliPxIMf6VdOaP6KoY6eUQ209DzeIokviZdQaY5zmvrU/Ne2IxbbTh9P83x67mKDY
 Vurt2vk1CFZiTJyVxTzOdAmOOyS5on4eyUrx2ROW+a4kElf38jsXbD0BoCDJgA0mYVfnhyUpSGn
 PxLncgOC2Ql+GNxn4ukKdC+dDQwGfh8wVLx/rjrXzzfeqVKrvQbm23iV0Rc9HUAXxbtOnqhOZgD
 g7uw6T5D34T6kDXGGAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMTEgKysrKysrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAy
YzUzZjJjMjgzNi4uYmQ1NjhiZGQ4NzEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0xMTAsNiArMTEwLDE0IEBAIHN0YXRpYyB2
b2lkIHByaW50X3JlZyhGSUxFICpmLCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkK
ICAgICAgICAgICAgICAgICAgaGV4YWdvbl9yZWduYW1lc1tyZWdudW1dLCB2YWx1ZSk7CiB9CiAK
KyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgcHJpbnRfdF9zcmVnKEZJTEUg
KmYsIGNvbnN0IENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQgcmVnbnVtKQoreworICAgIHFlbXVf
ZnByaW50ZihmLCAiICAlcyA9IDB4IiBUQVJHRVRfRk1UX2x4ICJcbiIsCisgICAgICAgICAgICAg
ICAgIGhleGFnb25fc3JlZ25hbWVzW3JlZ251bV0sIGVudi0+dF9zcmVnW3JlZ251bV0pOworfQor
I2VuZGlmCisKIHN0YXRpYyB2b2lkIHByaW50X3ZyZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGludCByZWdudW0sCiAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc2tpcF9pZl96
ZXJvKQogewpAQCAtMjA5LDggKzIxNyw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fZHVtcChDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgRklMRSAqZiwgaW50IGZsYWdzKQogICAgIHFlbXVfZnByaW50Zihm
LCAiICBjczAgPSAweDAwMDAwMDAwXG4iKTsKICAgICBxZW11X2ZwcmludGYoZiwgIiAgY3MxID0g
MHgwMDAwMDAwMFxuIik7CiAjZWxzZQotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ0FV
U0UpOwotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQkFEVkEpOworICAgIHByaW50X3Rf
c3JlZyhmLCBlbnYsIEhFWF9TUkVHX0JBRFZBKTsKICAgICBwcmludF9yZWcoZiwgZW52LCBIRVhf
UkVHX0NTMCk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVYX1JFR19DUzEpOwogI2VuZGlmCi0t
IAoyLjM0LjEKCg==

