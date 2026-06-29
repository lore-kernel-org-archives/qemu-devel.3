Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A321FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCId-0004qz-Gs; Mon, 29 Jun 2026 09:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHg-0003jj-3x
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHd-0006Gg-Rm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKds2579262
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=; b=J5D1C4Fm1+mGx2dm
 rI1vAAb8E6Q323DpIhW0E+ZnkJSEg1+Eu+CZ+hqglT9QktOOCqI0uwxM6fl0PTBR
 p9SqcsQcBOQAqDux2ErGU/No1DEg4GNlWtihNR/+m++/87PFr/IA02MzyRLguJcD
 BNSjAw55ninNh34JCFBQJ2XI1K2ALIBfs13A+t2qFKGreCZ/gdKmwdNEQBRrTqsu
 59H0DaD60WUAt1XJShWbQ3RQwuaj7PhkjgQKuWxlFxLXUFmQ/EJbQdrXa2R7oLx1
 uMH/jKjZ5U+VSRfkN4j/p/1JV2y22s9ZyYkyHO9DrrveiZZmdnAyvTthvnuZyXP1
 KGY46Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hktb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37dfe4f6924so2210256a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740649; x=1783345449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=boDAGR4GkDdM8OiIevY7O+5MyKTwK/ohH2n3wFs2JaVNzL7ZaplFlpvWO0d/3zptD+
 W04E2xMKlX7d+7Hz6/pa6FNCqq3pmpGClo9aXEnF/8XlWvGV8QQA+BrCk6zQCwco8TiK
 BbxuxPz3oFZWytJ4eGtYCVfU9vkwcJBbSo7Ej0UcoYZQTrzcI9U7gBQvphcI350a7v6Y
 97azusJtKTI1yTqFSycUuwWr5qX6vwMZKO2MWFnxvX2TLt9qxSxrvLVsSPgape76AV4J
 +pDnQ9N/6URfvx6uw/wcJ6l4zN6YrHyTwnepUf85uBfEafTVTCYtWHr2P3qg+kjDPgiN
 y4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740649; x=1783345449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=STEUP/eYhZTpFAWaW5raunomh1aeGPoDLdTzggMSmsS6VBfCe35QV5XIL3I4MbHRTe
 edaiK18jKHOzF0G7nrfHWGN1YUvWCo6wcuA2oEtmhn4PFQJJV0Dpo4FuwNAEvo/LGj0j
 Dis5oNOoEj2y8yQsXuQwwS7r+Yy8O9zstnsQwVFrkQGkJf6Ajji5eRW6wwt631pDStSM
 aQja2Ib4K9yZKRb/vhPuFe3R95egU0mrRUP6cFtrIQwZRI1YFO4n57WH+ykKsRcZE+2g
 wlMWhOoh/mKtE18ydHSfe19m8HdM9AIe+Nh7R9hK+Str+COO1H+et/hQyR3bkAY+y3P/
 0zOg==
X-Gm-Message-State: AOJu0YzAuueQ03GVqgSpMEX7mE1K+GyNe3UQ8jVP68XqLw/jIwp5DCVs
 AuyvFitdymqm5ZLbA77Mm4afMXXwkhdtMTPqc8Zns/FbO+9scuHabua8jYDxInCtX6WdgyplcNb
 ZSIl09xd5tGvude7AE79ezt+xTrGfg2tmRKlcSpOYzGVIFkotV6MookMcXIwPQ8iyow==
X-Gm-Gg: AfdE7ckCb+4StkEUuM603zfozsI4DmJ11i5W1zNnOWkv91NiKkQUxqsuPcYwavmapYH
 GBRA4ETrxRW6wS6NbXyDFABme39oNZTBhiD1hwjhgl6xlx4Yw22KPPlXYXVBD3nUNrA/Prw3YM/
 8zO57etFAgOC16qdjq3YW0kkQdyGJjMw+loxTUeDDq/FIQ9aqqOyH1G/S3s+hzA4ZC8pkU/YcsV
 rSh/hvpwtH9gdW52lT6KxevDl1/xrOV0/ymOpvJXjURcBGECz28kTJv1XYK2qgiYxdw3Yazwgjd
 jmoJc+01TGN52QujSNXUsLQqhTJtgvmnzLQ1Wv6UA7DSZosFh/iHocaUK3CVND5Qx9JOfDWl++U
 XpV8EqGTx+RAi23sg+6RFWYbkVwy2ZeZQIg3em7gak72rxemAQNSgPj4QnXA=
X-Received: by 2002:a17:902:f607:b0:2c0:a9b3:bdc6 with SMTP id
 d9443c01a7336-2c7fca37f6fmr156981395ad.30.1782740649530; 
 Mon, 29 Jun 2026 06:44:09 -0700 (PDT)
X-Received: by 2002:a17:902:f607:b0:2c0:a9b3:bdc6 with SMTP id
 d9443c01a7336-2c7fca37f6fmr156981025ad.30.1782740649007; 
 Mon, 29 Jun 2026 06:44:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 58/77] target/hexagon: Decode trap1, rte as COF
Date: Mon, 29 Jun 2026 06:12:13 -0700
Message-Id: <20260629131232.2487780-59-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX2ZmPCNZVImO4
 pTyu4mF2PylYgXo47tK7S5gYv+2iRtmBAg6czgnfi/WDqZaGK0K1yK4q3F/ujLinyr022VS1bB0
 MkU+rxUS6P2h9P1UoB+qE6XAYixKYAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX6n698iid+yj7
 iiXVQQcpakhytsG6DF8+sBtsdndfsmIUjMY3z3kZcNNx/tixgUJp44rP9j+Ft+NHx7CLE1pnmAI
 wEQUjxQFAHMoecfEtXMJToKBkmAKQrwS4Cp+0Cbtu6QvB48zs+qkNC2WV3Y3HuZO9DPAqL9NF38
 HXCt0semaJgBy9iM25iPzZKICt29Z7qSC54RtoXI/QLy5YOIroiT0Tw4swcZPEgBo8HCXFmoq52
 +jOGnCECw5VL15TGnR2VMb6hCah84GVp0zI2qOXE5RrdsGY5/54pwgcq8sF7ZKS10Nq0/2+5DXa
 XN9MTaYOqe53CAG+MDmH/+h7+KRYdupmNqJ0AGXHHYjDcYGdIEVjGbfMrjAAjj64DAEMOcCErWg
 +1CaRco2Tfv7ADgxriIgVb10aU9b0B6RiQLnfJ5qIL+H5VYbdnY8ZEY8JXoYk/ZNgmWDJCpBFnX
 LEcE48azO0u9jZIAqOw==
X-Proofpoint-ORIG-GUID: XmAVZpEXyF7xtZ3k7idZ87J6mgkWICV1
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4276aa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XmAVZpEXyF7xtZ3k7idZ87J6mgkWICV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Rl
Y29kZS5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdv
bi9kZWNvZGUuYwppbmRleCAxNTk1NDUxOGI4My4uNmVkZGNjYTI2ZWQgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC0x
ODUsNiArMTg1LDggQEAgc3RhdGljIGJvb2wgZGVjb2RlX29wY29kZV9jYW5fanVtcChpbnQgb3Bj
b2RlKQogICAgIGlmICgoR0VUX0FUVFJJQihvcGNvZGUsIEFfSlVNUCkpIHx8CiAgICAgICAgIChH
RVRfQVRUUklCKG9wY29kZSwgQV9DQUxMKSkgfHwKICAgICAgICAgKG9wY29kZSA9PSBKMl90cmFw
MCkgfHwKKyAgICAgICAgKG9wY29kZSA9PSBKMl90cmFwMSkgfHwKKyAgICAgICAgKG9wY29kZSA9
PSBKMl9ydGUpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfcGF1c2UpKSB7CiAgICAgICAgIC8q
IEV4Y2VwdGlvbiB0byBBX0pVTVAgYXR0cmlidXRlICovCiAgICAgICAgIGlmIChvcGNvZGUgPT0g
SjRfaGludGp1bXByKSB7CkBAIC0zNjMsNiArMzY1LDE4IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9z
aHVmZmxlX2Zvcl9leGVjdXRpb24oUGFja2V0ICpwYWNrZXQpCiAgICAgICAgICAgICBicmVhazsK
ICAgICAgICAgfQogICAgIH0KKyAgICAvKgorICAgICAqIEFuZCBhdCB0aGUgdmVyeSB2ZXJ5IHZl
cnkgZW5kLCBtb3ZlIGFueSBSVEUncywgc2luY2UgdGhleSB1cGRhdGUKKyAgICAgKiB1c2VyL3N1
cGVydmlzb3IgbW9kZS4KKyAgICAgKi8KKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQor
ICAgIGZvciAoaSA9IDA7IGkgPCBsYXN0X2luc247IGkrKykgeworICAgICAgICBpZiAocGFja2V0
LT5pbnNuW2ldLm9wY29kZSA9PSBKMl9ydGUpIHsKKyAgICAgICAgICAgIGRlY29kZV9zZW5kX2lu
c25fdG8ocGFja2V0LCBpLCBsYXN0X2luc24pOworICAgICAgICAgICAgYnJlYWs7CisgICAgICAg
IH0KKyAgICB9CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQKLS0gCjIuMzQuMQoK

