Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5860DFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Aa5-0001g0-Nl; Tue, 10 Mar 2026 23:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZp-0001aV-9r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZn-0005Cv-Mx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3bCJT3760660
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jBeLMxzqHzDOV9YUjXqHj2MYH/ki2AcUfhzyW+ALZhA=; b=W5vO3G/gzVq2uRGV
 uyn7ZsLbyCufYxJ1mEWa60Bz0Igglp/T5C6miuQR2n+zvt/Xr4U0ugUa/8H5A+SG
 yjvsO6Timagur6mGj4PuG8xgD92UkVaPwrkmJ/v7sHVp5LAYucs0uF8WiPpYdZ8n
 acGLQdJS/x+FEa/QceopRsy4fkh1HJMQv1GCm/q6n/RQn7XRaXQuNBvq3ihsQ+N3
 SR/nLuMvlOQuqqub3vSIGZiLc/grwzmzb5Exd/fZjmeopIFnV7by7+wAOYtFmnEa
 qbUHqUwzMyNm2gKpiR/k5cJJa3zNQDLS1Q8Dltz3ZC57F9t8nqvgLX4/zXnjGify
 wMITfQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctk8uk2x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:38 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d7543bc61cso23987686a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200977; x=1773805777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBeLMxzqHzDOV9YUjXqHj2MYH/ki2AcUfhzyW+ALZhA=;
 b=iikzQyYsXX91tTl6BqF+AUqv70o5T3fGlSv42oJJEfePQVeC8nlVIv7sR41WpzrslI
 rl1FpIkhBVjq2eGaeK6R3evoEzf2V3SI35N0cEO2M0JFX2K/ojmy0CWJPuqsaVc6fUvp
 P1+E9v26OWYvOFvXhc8PPO+lfTJaswbvVPthKyAc/t9YhU/JOzhgCjjFVhaeRuU/kE4o
 G7ID681YkN1TyhtlmPkLP+UcGj1uoNBU+DTNkxYQs1jyIeY5c+OqK2SNmp5Zc3p/yap3
 8p8THJ5eXSkUYjhSvf+ymedvDwxSDDI/2txE9AIRyA1FemlRD/Ei4wb40W168A/XRd7d
 zaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200977; x=1773805777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jBeLMxzqHzDOV9YUjXqHj2MYH/ki2AcUfhzyW+ALZhA=;
 b=kgR82hoqZ/x8MyaveAeKnhfk9QWMxjL37h5t80Jj9YVeLwjuE5bE+GPpbpwMHH8zq4
 Te9nYzcXAk9j7fmgW6bLvNblvb9y0GGbrUFeA7Ph1jrEwZBu34D4m6KJtmM97HI26otm
 cZe0hMq4xaKwnOtyiaPdOCVKazX44fq5biV2iX10FCkV+U/06zQR5955PkC+RSTepgyx
 wz500J1R4DQM6cUv48c8dQAk+XtzjQpJw4pcOxPMMUZ2FpsZrUME9J+rrVX4W4ijk78j
 wgT1z4TxiYca7gPiOpXfXY0Epvdi8NLScrypMJ2sMh5pkUiwmHObjrZWh7qcppanHsLF
 PoYw==
X-Gm-Message-State: AOJu0Yyagc5kkSUqdxYEE6MCSclC/OrbovIfZfvl0cWnuKsxXGaqZgfu
 InTXqIbLmC8qIhu81kycvAYVBBIz9ODaBnBPweG14+WIm3FGnf0f6uQwoYlvWHWUhfXiuDtgAr3
 Kmwlr6E3FwArJc45onRX2YB66Du9c0cGyqfrn1E1OUHv1QKnTMXLvB5J9LktyJ3k/dQ==
X-Gm-Gg: ATEYQzzU7U4sqZ9BX1sfYRXQg46kylm+jmgYBCX8QGZBuVPt1GFx0DEiy5eDQi+jLVi
 i7eIPmpO2GbxExnCbMLL1rIq+MPNaTRYXNetnmvhfY/GQZo825XSr7NYuFxieu+5W4bxh3nfPVx
 Dmpzvl1lrgme0/P7HjpcxhgdilQ8yS850buj2W3VqxXE727D/T7NIjX81zGSpTwyIedru+Wqt50
 T+xWdWUylcWbIe1nVevNTSH0mGaezzo2auPIO/IBWdkiI9M7l9yRn8HRI5Ebf6wlM9lYgVuvUh+
 c9lkuEel2Nq5ZC/5GxbFzJUBAZFa7//U4o/IJj5hXI4UyizqwoLwSOvAxPysozscJeqTBEmS/Zc
 gddKkPne1m0ohBb9sTT0sjnY858rHriQ0bdM6RWigZFwLySZ4nfbOtXCgF+SvkiNUJWFVng==
X-Received: by 2002:a05:6830:6c17:b0:7d7:57ef:383a with SMTP id
 46e09a7af769-7d76a7857efmr1008489a34.30.1773200977427; 
 Tue, 10 Mar 2026 20:49:37 -0700 (PDT)
X-Received: by 2002:a05:6830:6c17:b0:7d7:57ef:383a with SMTP id
 46e09a7af769-7d76a7857efmr1008477a34.30.1773200977118; 
 Tue, 10 Mar 2026 20:49:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 07/35] target/hexagon: Make gen_exception_end_tb non-static
Date: Tue, 10 Mar 2026 20:48:55 -0700
Message-Id: <20260311034923.1044737-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: dxVOqhPzxbT6TYuCDd0KLA0w79WzLsFk
X-Proofpoint-GUID: dxVOqhPzxbT6TYuCDd0KLA0w79WzLsFk
X-Authority-Analysis: v=2.4 cv=YcmwJgRf c=1 sm=1 tr=0 ts=69b0e652 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t4cj51CzC67JwBy76UgA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfXwZmcR9+iMcVt
 fE9FDlF85B7lvMKm7fanIBRlwYfvPiVVeTElNgqcOoaueRd0AueZvaIqZ1QthLPR8VscGf+xpI4
 B+Lt5WUf1m8VVntYnAlgJDmBGNdYbrrdX8qlGDHjPMKVs/MqnOt3m+rFDLmwOM/rmc0t+f6xUaY
 3PcqeE1Hn50nXob+Q8uy9dmfCsw9qkQztQAdb1HYR3wIIilJAkcc2C4i6UyeApcZBq0bpbr+a+M
 22Nl2mEZd+Fkuf6zFaU2dRaL+aeqlMYNbACvegSyfrYCj1KXLNjOAmVlVcbSmp6lQsVpIiKCYQ1
 6qdiYY1QLzN/DwCSgk3mu5R5gk4oFItkfpQESp8LfBFx6xCaKBGBcN0gblnc3boAe5GrR8eacKQ
 FeqUmYvH5joWSbahJc5uS/BMSMTr9tP8kbqbj+afJsZhhkusr9zuxkHXpfxHcCOdx7AsIMQcx13
 nTZ3k7wnMfQZwUuH7aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMiArKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA0ICsrLS0KIDIg
ZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRl
LmgKaW5kZXggYjM3Y2I0OTIzODEuLjI4MDRlMDhjZTU3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtMjgy
LDYgKzI4Miw4IEBAIGV4dGVybiBUQ0d2IGhleF92c3RvcmVfYWRkcltWU1RPUkVTX01BWF07CiBl
eHRlcm4gVENHdiBoZXhfdnN0b3JlX3NpemVbVlNUT1JFU19NQVhdOwogZXh0ZXJuIFRDR3YgaGV4
X3ZzdG9yZV9wZW5kaW5nW1ZTVE9SRVNfTUFYXTsKIAordm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9l
bmRfdGIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBleGNwKTsKKwogdm9pZCBwcm9jZXNzX3N0b3Jl
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgc2xvdF9udW0pOwogCiBGSUVMRChQUk9CRV9QS1RfU0NB
TEFSX1NUT1JFX1MwLCBNTVVfSURYLCAgICAgICAwLCAyKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCA4YTIy
M2Y2ZTEzZS4uMThiMzhjMjg1ZWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0xODksNyArMTg5LDcgQEAg
c3RhdGljIHZvaWQgZ2VuX2VuZF90YihEaXNhc0NvbnRleHQgKmN0eCkKICAgICBjdHgtPmJhc2Uu
aXNfam1wID0gRElTQVNfTk9SRVRVUk47CiB9CiAKLXN0YXRpYyB2b2lkIGdlbl9leGNlcHRpb25f
ZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgZXhjcCkKK3ZvaWQgaGV4X2dlbl9leGNlcHRp
b25fZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgZXhjcCkKIHsKICAgICBnZW5fZXhlY19j
b3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBj
dHgtPm5leHRfUEMpOwpAQCAtNTkwLDcgKzU5MCw3IEBAIHN0YXRpYyB2b2lkIGdlbl9pbnNuKERp
c2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPmluc24tPmdlbmVyYXRlKGN0eCk7CiAgICAg
ICAgIG1hcmtfc3RvcmVfd2lkdGgoY3R4KTsKICAgICB9IGVsc2UgewotICAgICAgICBnZW5fZXhj
ZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7CisgICAgICAgIGhl
eF9nZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7CiAg
ICAgfQogfQogCi0tIAoyLjM0LjEKCg==

