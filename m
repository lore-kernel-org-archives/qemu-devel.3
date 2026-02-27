Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4981039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aF-0007En-6a; Fri, 27 Feb 2026 15:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aB-00075Y-QO
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a9-0006qY-T3
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:07 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIeop2373465
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0f+FJCFsf70CC5AAEHTrBHtVYoTcDTK7Ue15AlmnhwE=; b=CI/mrZeRdTifcTZK
 SnCIYBniz3r5aqXoXmuU3RIj7QZ66Mq4NMMNqO1bSAM024vWJduD3UCDyyUczUWG
 51U16mISWkH1bzYO+1TTQTPB7VnOgmxoX0+nuirequrX1IAXxoe1IHSvy+l8F5Wa
 QURz4AggOTdyqEcelHpNauL2MBkQBJN8dryLab5H6NvXlH65rnVrylYpJjhnatXk
 1wOJX+M9PqowLou7YgX5MMtNA+DZRO7SMnEh7vtejJatYt0eoIv/Q7Qegt9l0dTc
 CP9SS3wZA6FnjpvdcbQ/33BIFExvwFo+IweAabmxjHMqrpTANLYD+C8Xom+WVjpZ
 2A4thQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgrtrauf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:54 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-66b612efb4aso36283148eaf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224613; x=1772829413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0f+FJCFsf70CC5AAEHTrBHtVYoTcDTK7Ue15AlmnhwE=;
 b=hHLnAWYgjt0WtrQZEeW1WlLX3KC4KfzJNa6iR16N0kSJGo7X/e5lr2blguTlqZvsUi
 Df5lDz2VB7vRvtsTViW+CCpwfHp3mZs+X40L4tMMMz1KsanmHc5t8fYFkgqUUrrUmtik
 h8xaERxxuvq9+UJljArImjGgKGZ+ZYPX8k+RNKrpKILe7eqiXXZbk5Spq0/ZKk2BVQfX
 TO8Dux81hzHHAvEgnGqylc1Y8YhMlKJQP701sTvpVIS2DsoVp+pbjAdxkc8nwNPHrbnH
 8C9P8cM9mou8AkXkq+nf0bNnKZ240iJzu4ABPN1cKRM6ivAxOCMj9XfUCjjLN1XtM6/v
 49lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224613; x=1772829413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0f+FJCFsf70CC5AAEHTrBHtVYoTcDTK7Ue15AlmnhwE=;
 b=v/MN8F128D+42bbYXl/Gp3A7cNwEsZh80zfd9r18gUl1AvjhoHb2qDpV5kKdSI48j8
 /oPfpTsZIYpdn3Es9LT1/+PgSXAgjhLyiYkvkHgA/w7maRxV57ju+Iuu6f6h1tNONtqG
 KQORKXxDI16TRD6zD2dWD5IXi6oZljafJZv7hTKB3tkTOKeg8443oIhEU0HylOmxhF4V
 dSIRIHDe0Uld4I/TF5DWBeIoOcf4TsxUMysO4AdHk7RRTLRhy/nMbXiWAA63cRihGgRo
 VhzLZ72OWIsyDueoa5VNtYk62I1rrNRanY2Q8a9ICD5lEGDbXY0cWHPNvng/tTqbaV2I
 6DVQ==
X-Gm-Message-State: AOJu0Yw03KlT9rBVU1eqK7FDtsLM0QepepcbhbTRtvVtPq7NIQpcuMZi
 JcKsCbHH54PolLUY4uetlNGpDCIYept1A/HUAFkY6VQN3SjNO65UyprvEZKS+Ca9cxuZqQT/FCs
 VUzkjW6toAMtpuee6TgwuHsO8gVeDTThZjF6JMSyD3nAXmpijFkwPZdsJeaJT3f6cLA==
X-Gm-Gg: ATEYQzxQNwk7q7xuJWlJwt965RUAt7oYI0FaDp5Mvyk9H7E8P52PH51YsWjTIXI/DP1
 yUZIeHJq6Xf6xYck2P7SpANgWCgiUA5NT9T+fq3SLB9xy/aFn2vIAPB9iTBbzwFKxsQwuV19KUj
 LU240DAihv1AxVoLC932M7EmWzzVufmZrUOshXEpV/mtz+kT9Dr2+7IJn5oosyE9e/i2Ona2r1+
 Vp7ti1wcSKCQkqvCv2x3hZt97Ess5TyS9HYMHQOTIZ5ucQSADK2QD2Kd3e9wGhb/ai8f9jfiRMk
 hjjpze2YGCklOWoqCs258w++n37MetgLd2slDSE142pH4O43QyrAZp2NUir93sihJNqtvlb7kG2
 9w0X7kOqPLN2uOT0WLqO9Im+5sQkdnhpeaACqZAGCPvc5LPlIsf5acZ7+03hOREgzEtV2Lw==
X-Received: by 2002:a05:6820:208b:b0:679:e58d:bb54 with SMTP id
 006d021491bc7-679f2213e1cmr4843170eaf.5.1772224613680; 
 Fri, 27 Feb 2026 12:36:53 -0800 (PST)
X-Received: by 2002:a05:6820:208b:b0:679:e58d:bb54 with SMTP id
 006d021491bc7-679f2213e1cmr4843150eaf.5.1772224613328; 
 Fri, 27 Feb 2026 12:36:53 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:52 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 15/37] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Fri, 27 Feb 2026 12:36:05 -0800
Message-Id: <20260227203627.932864-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=C8jkCAP+ c=1 sm=1 tr=0 ts=69a20066 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gRvwf9TOsZpvvkEGe4oPgopjPpvVPzAt
X-Proofpoint-ORIG-GUID: gRvwf9TOsZpvvkEGe4oPgopjPpvVPzAt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfXw2lUYeI2PLXn
 53L9g3FCjSglrftGwx+SS6+U9chxQMjMTIfPnV4T+Ovh4OrbQVYn2fLJqh6CH2W2zNQll/Vgo0e
 L8HSHADOcFcmY58tokdIUybvme2Dv2+MN3dOP0/PYACoKqrJ/WB0xHsSdKQBn+5TuhvfXsB/LEO
 5ZN3Tv80ePh+HhEJxBuPQ17gsiQL0JSgY841K+5Mmj5Z5gBQoOVfjBaoB7RyjUvOdy9G/wXrirZ
 r64zl/kOSnQvJ/GQAdTx1EaybfPvv8BghzAZSEr7q3GZMS3S3xN2NfaXBb3ZlmA0kR5gpzd360Y
 wWqBBgJIHNLyd3izNY++LV6mrNIsF+HhWDpL0pfbIiWdzqygZLLKpadK/9frBxhqG8BRDioxsGW
 S4ARarR/nNJHwmS4rgU2ls8i5c8JCwFrjKJEsu5MQSYj2KT/yg5ZgBtFrKH0ywDZG0G4BoEYvjh
 1KVgavcEV72Q5oxMobA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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
YW5zbGF0ZS5oIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggZjgwODMwZjVm
MTYuLjZlMTAwOGIzNjNhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDAsNiArNDAsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4s
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9y
ZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRl
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaW50IGdyZWdfbG9nW0dSRUdfV1JJVEVT
X01BWF07CisgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklU
RVNfTUFYXTsKKyAgICBpbnQgc3JlZ19sb2dfaWR4OworICAgIFRDR3YgdF9zcmVnX25ld192YWx1
ZVtOVU1fU1JFR1NdOworICAgIFRDR3YgZ3JlZ19uZXdfdmFsdWVbTlVNX0dSRUdTXTsKKyNlbmRp
ZgogICAgIGludCBwcmVnX2xvZ1tQUkVEX1dSSVRFU19NQVhdOwogICAgIGludCBwcmVnX2xvZ19p
ZHg7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZ3Nfd3JpdHRlbiwgTlVNX1BSRUdTKTsKQEAgLTgw
LDYgKzg4LDM0IEBAIHR5cGVkZWYgc3RydWN0IERpc2FzQ29udGV4dCB7CiAKIGJvb2wgaXNfZ2F0
aGVyX3N0b3JlX2luc24oRGlzYXNDb250ZXh0ICpjdHgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKK3N0YXRpYyBpbmxpbmUgdm9pZCBjdHhfbG9nX2dyZWdfd3JpdGUoRGlzYXNDb250ZXh0
ICpjdHgsIGludCBybnVtKQoreworICAgIGlmIChybnVtIDw9IEhFWF9HUkVHX0czKSB7CisgICAg
ICAgIGN0eC0+Z3JlZ19sb2dbY3R4LT5ncmVnX2xvZ19pZHhdID0gcm51bTsKKyAgICAgICAgY3R4
LT5ncmVnX2xvZ19pZHgrKzsKKyAgICB9Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBjdHhfbG9n
X2dyZWdfd3JpdGVfcGFpcihEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0pCit7CisgICAgY3R4
X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSk7CisgICAgY3R4X2xvZ19ncmVnX3dyaXRlKGN0eCwg
cm51bSArIDEpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19zcmVnX3dyaXRlKERp
c2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBjdHgtPnNyZWdfbG9nW2N0eC0+c3Jl
Z19sb2dfaWR4XSA9IHJudW07CisgICAgY3R4LT5zcmVnX2xvZ19pZHgrKzsKK30KKworc3RhdGlj
IGlubGluZSB2b2lkIGN0eF9sb2dfc3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBp
bnQgcm51bSkKK3sKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUoY3R4LCBybnVtKTsKKyAgICBjdHhf
bG9nX3NyZWdfd3JpdGUoY3R4LCBybnVtICsgMSk7Cit9CisjZW5kaWYKKwogc3RhdGljIGlubGlu
ZSB2b2lkIGN0eF9sb2dfcHJlZF93cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHBudW0pCiB7
CiAgICAgaWYgKCF0ZXN0X2JpdChwbnVtLCBjdHgtPnByZWdzX3dyaXR0ZW4pKSB7Ci0tIAoyLjM0
LjEKCg==

