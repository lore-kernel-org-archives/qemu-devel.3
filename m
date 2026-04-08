Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CF510F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsx-0002AJ-JZ; Wed, 08 Apr 2026 14:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXsu-0001sU-UI
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:44:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKPE-0005bt-Hg
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M5HD72862613
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F0uONMjef3ECBM5NuvfwWgVpAn5g+wZiTF4jIWcu5S8=; b=Ib3iEJnHbaRfPU7D
 yne44RGStVvr826Gj7lhd/B+/fOVbtQT1QCt1n7iqWHKbaLR1NhyCT55e0JE2mlB
 A2aATpdN1DkALm3GYxKMVzwW6IcSK1yJo72ifW7ihOeEC8I5RQSUurUFJsJz/q+q
 wV00FJcsinrptNAxJdJ1n9RQQjFO9PDQNUKeHzsumrw+JB2f7RfbnEGr8UDPN9o+
 WYvYVprLwVIUY87k6gFdqG4K3CTF3dDuMbzQOxYl3Ke49/0ldqkgZQVg3HXrhZaD
 dr9AVKFEihoe436c1w5zzrmMUbeIPQAID/95jG4ITCBqPqpI+eLYK3uvaJIDbeOY
 slxuDQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddad8rwva-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c16233ee11so8180146eec.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622032; x=1776226832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0uONMjef3ECBM5NuvfwWgVpAn5g+wZiTF4jIWcu5S8=;
 b=SGZjEC7EVgM+9Brv6T6c4bl/poOUKM8P9zjb+kSoS/NSwL1OlKOx7+mXS3FvIDsHQt
 9K05OVlzrbV9k4ZhWg5rNo11Bqhh9UycXFpsj5Te/ghVpXnmLIqCcHgxDHhivexUb9N1
 MQJahdHnn6SSnq5994prF2GwUbNjnI3wuJmu5aKw80srkg6Bx05kj7B1yOl2E+Tx5DkM
 rMB8Ue+LH96EdSNC9JL8CDlsJfVezBSMNJR0WwvMXKx5GLmfbUev/C5PlN+MSwAR5kSi
 Zy4myipAYbqf7i3LvsOTWVnJCERPNGH04+HCpmloXk/bmaX/sLaO8kzx93KHMmOcIGYd
 qyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622032; x=1776226832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F0uONMjef3ECBM5NuvfwWgVpAn5g+wZiTF4jIWcu5S8=;
 b=EV4p0ZONN4G3mA6EbU0bbTGQRujDm4ySFKe4w0HCANjEY1VJneu8gynxlD2Lms8qOu
 dRUKaX1GHNoI7anAR+66o9mEruiGt9A0mClP+xl0chzei0xXdLlaFL3UXSg5l3P1PZP+
 k7nhFbDLcMNxqyN7alpN38cHCECzZKNrQRD7pGYo84w5nwwLwSfD8EdHaSHFrw0vLA+b
 5l1KhWBSuChVSqsSYs6dELugadjhvCp9K/WWrKIxz90MNaL5nnUJmc1av1d2zjizN8qP
 755saO5DalTuhldCblVHG9MVOuN+/fpe0lHcCnCfgs/rOIzKheRnMezyaRCcyEYoastz
 JYPA==
X-Gm-Message-State: AOJu0YwHmnDA9Ycw9RntieGv1O4Q/Ai+nQmE1h+1+g78t+I8WkCh9dUQ
 fx7w9v6BYlXQKeQeQ3+mEZXdbQf/p6355tVGeyQDh2HqwfuPPd+oaBpimogrmzYxNF6JOWmzTEK
 2wx0YeC3AHyLZaFHMc3TSBrx7xi+lxDelA2uHsgBM6Twky4rspZoYfcKw0xW6zbU4rg==
X-Gm-Gg: AeBDietUFmbK1UCHkrb0lwoPglUcY7W0yeSNqX97M08hrN5+MHgnG441IAOPNtiqpud
 PxpwcsIfhxNVx8rNY94tKj40G4becosF6n1ZAB+m3dxqEkUQKvnbTqNfQSnSogT3FtEenZuwXfp
 jitjtwCMwBfPKJXofGWqyKn4zjhOaZZPPRzF0pr/W+90SmR4Hsu/HiqPlyfd1+aGVz8BK0ODmQN
 WPtRl2Im/5Xp9jKMAS4jcnwPzarHXZTOpQH58mU60zQvLDdsBjGCVox236lvWLmhd170kCd0bG2
 vaRogDT42oL/L/zSnVhYHQHyDSbb1mbBAu2k+8waOvHd3jKTyWNEPD6IakuJsZ77Ej5mIfnug+r
 Umi0dHoG2Em+rktOzGRkPMUMa4BDDj2F+pgaIUk2RnAAX0y4EdMYnwSdfIZX0wWtz7NkF0g==
X-Received: by 2002:a05:7022:388a:b0:128:bf8d:44d2 with SMTP id
 a92af1059eb24-12bfb6ec558mr9186486c88.2.1775622031849; 
 Tue, 07 Apr 2026 21:20:31 -0700 (PDT)
X-Received: by 2002:a05:7022:388a:b0:128:bf8d:44d2 with SMTP id
 a92af1059eb24-12bfb6ec558mr9186480c88.2.1775622031308; 
 Tue, 07 Apr 2026 21:20:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 22/28] target/hexagon: Add implicit sysreg writes
Date: Tue,  7 Apr 2026 21:19:47 -0700
Message-Id: <20260408041953.1899532-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ztNxnN5XWqJvgjYoY-Xaxe8ywsSe3jsY
X-Proofpoint-GUID: ztNxnN5XWqJvgjYoY-Xaxe8ywsSe3jsY
X-Authority-Analysis: v=2.4 cv=EoDiaycA c=1 sm=1 tr=0 ts=69d5d791 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX8MfEgaSpzKs1
 gOju99h29CZt3g/pki+2Cwnr7LniqtgsvivtfSfJcUF1ZL2paliZoLKr2HYuRR0JDg2I0ijYkBy
 EthqnfUbN0pkhCfcuNgIsFGOzJcS1liGE7153liaTeOfhfrlbk89DqaOzI/l+3GI91HNSLt+pZ7
 YV8wcWLvh5e1gB7eKK+qp5Bk5B0rSlltrSKe7ERKHY9IlD4Jyvv9P7HWshqVP+eO68CsZpOWCR/
 Lwho/y9KEgn4ptdygfrdddCf2xCnOePvaMkgYk0dJ+byamcqbVKJISxGfCXJcJxHxNdw2GPef0b
 CTaMKasDZniqENc8uXyNcwu26ghRh+GUEurRT1D6AztJg6DG7FWYCeWlDW01y1KYsqCbWS+cqd/
 1bCLC+q9TDfyoavFlkP2Z3PKaGNbuZjBvXY4vYbrJEmQrV/azSarfMNv/8bjEpf+7eOy4JCSszN
 4oGBSngwzRaq02HSSPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
YW5zbGF0ZS5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGE0MmZkNzcxZjI5Li4zODcyMWQ3NDAwNyAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyOCw2ICs0MjgsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF91c3Jfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIpCiAgICAgfQogfQogCisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRfc3JlZ193
cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYiwgaW50IHNudW0pCit7CisgICAgdWlu
dDE2X3Qgb3Bjb2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisgICAgaWYgKEdFVF9BVFRSSUIob3Bj
b2RlLCBhdHRyaWIpKSB7CisgICAgICAgIGN0eF9sb2dfc3JlZ193cml0ZShjdHgsIHNudW0pOwor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19GUCwgIEhFWF9SRUdfRlApOwpAQCAtNDQwLDYgKzQ1MCwxMiBAQCBz
dGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAK
ICAgICBtYXJrX2ltcGxpY2l0X3Vzcl93cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX1VTUik7
CiAgICAgbWFya19pbXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0ZQT1ApOworCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJ
Q0lUX1dSSVRFU19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdf
d3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBt
YXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9T
UkVHX1NTUik7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dy
aXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

