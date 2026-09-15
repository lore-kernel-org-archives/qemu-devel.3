Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8AFC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4T-00067u-RT; Tue, 15 Sep 2026 12:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W48-0005y8-Tm
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W45-0003rG-FT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFANV1813359
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 guMuSpkJh4ywaheNw4BuJpOegoZiRuIVSSULtLUUsTY=; b=JDF1eODgaT1kaAvK
 HmFIM5edv9N4HLH332HBt1iqwR0mrW8dEYrozdeFQ/w6h1eG9CcBXj2POD6xx+Xy
 AuxorQa4NBNBRabvx45ljmFTz2B/R7mid7sFKMf0Xikm86Oa/uJBfgXhv8OaQLV5
 tyO9IcoasmHyhA4m7nmJPMbyUsEih+0sAceTrpg9ctQXXGAGsHNgx2hYGxVWAULA
 wv/sGzsZ5IspdWOGle0RjqBnYpRRwALhzzx9i00mnef8g3GSwkylj+Uv16SwEVSu
 CmpPjQ8oxmujDRSEp77Qumxes7bZodyHcghxWGigUCrVlto9+oIxY5X1EjIwdgWK
 DX1aDA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq6kc174d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39e087a17dfso1179435a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489883; x=1790094683; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=guMuSpkJh4ywaheNw4BuJpOegoZiRuIVSSULtLUUsTY=;
 b=Wbn1pzJedI+SNHji9ORec4WCDwYIy6CMBPTmtV8hUx7IzSqTUhkDgU8AOW1Gf+D5A6
 ohtnzHke+Rxw7D5Y2lR+rmmEmLPowvdZl28D4+jsqCdQsosDWGz4jPac4p4K0gt70jk2
 Jp/4QuOEE8LOFS1qHQT9Seh4CSrJ8ec6G/Qm30Ai/AizQVdUxIR56ySP5lx0JpjB2bCr
 iXTAgqq7zZ2hg4RLfhdPKxsWtW8f4n/VBzApDwNinN6a0k8/DQvXSddmypZam1Le9Ku5
 0kuNgv6Ae79M8hEI4W8Ybtj1r8VbG/+li5BoyCO0GXMpsXD3rWkaCxWOOu3qseDqdYmR
 GT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489883; x=1790094683;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=guMuSpkJh4ywaheNw4BuJpOegoZiRuIVSSULtLUUsTY=;
 b=iyqjPLsPa5sfyd49Wc1/Gf2oUl+J1HDahkOTQ31XxiVzv/2qfVvVDs+rqsOjhT9c/X
 ZFLf5j3OIzAG/VtO2Txyh5Wqqw1Hq9GqdRXhfZNKEU7u8+hufO28HKlZOO8ehspa/QI7
 +loZdCisiyaUoQXrz6a5sMFJEUgBRwDhr0o/beUU9rB7uZ8Qcl4PBpGjc21eRLcIgOWY
 axTzMla8teVC5qPfBUiOR+aR926jL2FUdpn00MkcnyDvzMRHHgufN+x/5Rm2o50rEgvp
 LXn7cHpiiaYiZYfAG8hknjloLqqAmrSbuJN0FqSAtNVGjStHV5AaDb9VWsDamJIgS+tj
 BD2A==
X-Gm-Message-State: AFuF++npVD7HEzal729dHhZtmfeyfUoWMJ7jJCcD5YfpwXYvpLCNETMv
 XyRVweAtquKEYFOYtDQhopZZn4cqyjS8rqXlR0CCQ3Fu3X3OSaEawcWssh5AeHIJzyr85aDDdIB
 Pt4dSt/yrmPeCKRPH27NXWcmNFRVNYIFlYk+iH44sQIZd+eS0BX2EZ2grVf7qobQ8bw==
X-Gm-Gg: AYBFou3iod1bs4QqOfqPz03liMMdmxmzcux0AeT57ZAtIXLH4xGQa6AFrBLcjvRPspT
 9yXUUSM+ZGzC4cPwhYMViANhey8IxvWHqxbEANPypxl7OjhQWckzWNp/bmFBTldDKRwvpbKZo0q
 f3oJchehGT21CQooh045y7Nlqd379eLUHcPbpJDiun1g4frDGg8yIquIhPpd+IHHTy5jinub+cS
 fQM/JxrK1FcNXmIgHsIYeL2sRzKb1+b53QXUAFnXZNitfTdobpbiJ3e1b6A+Xt9zI/d3hoTKCR9
 RQ1u3zZUS4JNrsM5DbxJNonUKoy+xiRZ4b1B333XrdHd+mzEtyN3r5fWgKCYeUoN03NXJYs5QdY
 gd70KiBcIRRaDyFKh3x7tX1BJdNCZLlLuMmKsDdtKXwc1h/OI
X-Received: by 2002:a17:90b:1dc6:b0:39d:84af:a0b3 with SMTP id
 98e67ed59e1d1-39dec09cf6dmr16214762a91.18.1789489882793; 
 Tue, 15 Sep 2026 09:31:22 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc6:b0:39d:84af:a0b3 with SMTP id
 98e67ed59e1d1-39dec09cf6dmr16214683a91.18.1789489882144; 
 Tue, 15 Sep 2026 09:31:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 12/17] tests/tcg/hexagon: add dfmpyhh
Date: Tue, 15 Sep 2026 09:30:42 -0700
Message-Id: <20260915163047.4180600-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX57zDyfRD1UGo
 RT+A4SUQk5AQzdauPvxxAjYgxHvo1fm3iVnvCFPJwZMNOLiIA+rhCzZPPGahik2I5xsVKNk5jvh
 VTPMxPN4vI2zX0SaJpSpV22WMkw5+hc=
X-Proofpoint-GUID: 0xizuJev1SYHPb1tdAzBz-owIUrW8bU9
X-Authority-Analysis: v=2.4 cv=ZINCCn7b c=1 sm=1 tr=0 ts=6aa972db cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7ev5N2rqXU9IWHHYf1oA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 0xizuJev1SYHPb1tdAzBz-owIUrW8bU9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX0g5YMZDtyqAk
 MF8eLp2KuDpo8u+0awE9K+wa9ETjZ+hvsSHn0sNlKT3fpYwA5HnKxr1N3drG9zdb+ysbj46G51A
 +bVxucCuCwncFUR+++QrBeO9wUhvWSloLdeQiSi7imtuemK8FFSlh2msunjUgiHPa8EG6ALypMa
 BoJ5Ktiy/gTA+85KRuTQqlDmBe46vfOWbMAXImXr3bcjwfXnkpOrKliZ3pDVUKfCTfTg5x2G2LH
 +n9hopIMCpR8TrfOl49yvU0nLx60FU5LEMdt/NiSpxmCKwv+Xdhi6wEOUwCrRS4i+/CzLzQGr4H
 WpqA3tWp7twpLQ6D8M0l8qIJQ1hMqy79KV6qXH/MSDGq0A+FOHc4a0psbi9ErGF9L1IdHxRSnhS
 /mSJoQbWmZgZCWGgub5nJ0SMmZo3ovVhhhR8oHAP+pkR++HP4EZjc0WHZJfEN5NzpNyliG7cH70
 yylAQCZy24acop5rq4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150239
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

VGVzdCB0aGUgZGZtcHloaCBpbnN0cnVjdGlvbi4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4
YWdvbi9mcHN0dWZmLmMgfCA1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3Rj
Zy9oZXhhZ29uL2Zwc3R1ZmYuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1ZmYuYwppbmRleCBm
ODIyNjJhYjRhYy4uMGYyOGEyMThkODQgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2Zw
c3R1ZmYuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMKQEAgLTkzNSw2ICs5MzUs
MTYgQEAgc3RhdGljIHVpbnQ2NF90IGRvX2RmbXB5Zml4KHVpbnQ2NF90IGEsIHVpbnQ2NF90IGIp
CiAgICAgcmV0dXJuIHJlc3VsdDsKIH0KIAorc3RhdGljIHVpbnQ2NF90IGRvX2RmbXB5aGgodWlu
dDY0X3QgYSwgdWludDY0X3QgYiwgdWludDY0X3QgYWNjKQoreworICAgIHVpbnQ2NF90IHJlc3Vs
dCA9IGFjYzsKKworICAgIGFzbSgiJVtyZXNdICs9IGRmbXB5aGgoJVthXSwgJVtiXSlcblx0Igor
ICAgICAgICA6IFtyZXNdICIrciIocmVzdWx0KQorICAgICAgICA6IFthXSAiciIoYSksIFtiXSAi
ciIoYikpOworICAgIHJldHVybiByZXN1bHQ7Cit9CisKIHN0YXRpYyB2b2lkIGNoZWNrX2RmbXB5
Zml4KHZvaWQpCiB7CiAgICAgLyoKQEAgLTk2MSw2ICs5NzEsNTIgQEAgc3RhdGljIHZvaWQgY2hl
Y2tfZGZtcHlmaXgodm9pZCkKICAgICAgICAgICAgIDB4MDAxMDAwMDAwMDAwMDAwMFVMTCk7CiB9
CiAKKy8qCisgKiBUZXN0IGRmbXB5aGggKGRvdWJsZS1wcmVjaXNpb24gRlAgbXVsdGlwbHkgaGln
aCpoaWdoIGFuZCBhY2N1bXVsYXRlKToKKyAqICAgLSBub3JtYWwgaW5wdXRzCisgKiAgIC0gZGVu
b3JtYWwgaW5wdXRzIChjcnVzaGVkIHRvIGluZXhhY3QgemVybykKKyAqICAgLSB6ZXJvL05hTi9p
bmZpbml0eSBpbnB1dHMKKyAqICAgLSBub256ZXJvIGFjY3VtdWxhdG9yCisgKi8KK3N0YXRpYyBp
bmxpbmUgdWludDY0X3QgZGZfYWJzKHVpbnQ2NF90IHYpIHsgcmV0dXJuIHYgJiAweDdGRkZGRkZG
RkZGRkZGRkZVTEw7IH0KK3N0YXRpYyBpbmxpbmUgdWludDY0X3QgZGZfZXhwKHVpbnQ2NF90IHYp
IHsgcmV0dXJuIHYgJiAweDdGRjAwMDAwMDAwMDAwMDBVTEw7IH0KK3N0YXRpYyBpbmxpbmUgdWlu
dDY0X3QgZGZfbWFudCh1aW50NjRfdCB2KSB7IHJldHVybiB2ICYgMHgwMDBGRkZGRkZGRkZGRkZG
VUxMOyB9CisKK3N0YXRpYyB2b2lkIGNoZWNrX2RmbXB5aGgodm9pZCkKK3sKKyAgICB1aW50NjRf
dCByZXN1bHQ7CisKKyAgICAvKiBOb3JtYWwgKiBub3JtYWw6IDEuMCAqIDEuMCArIDAgLT4gbm9u
emVybyBmaW5pdGUgKi8KKyAgICByZXN1bHQgPSBkb19kZm1weWhoKERGX29uZSwgREZfb25lLCAw
VUxMKTsKKyAgICBjaGVjazY0X25lKGRmX2FicyhyZXN1bHQpLCAwVUxMKTsKKworICAgIC8qIERl
bm9ybWFsIGlucHV0IGE6IGNydXNoZWQgdG8gemVybyAqLworICAgIHJlc3VsdCA9IGRvX2RmbXB5
aGgoMHgwMDA4MDAwMDAwMDAwMDAwVUxMLCBERl9vbmUsIDBVTEwpOworICAgIGNoZWNrNjQoZGZf
YWJzKHJlc3VsdCksIDBVTEwpOworCisgICAgLyogRGVub3JtYWwgaW5wdXQgYjogY3J1c2hlZCB0
byB6ZXJvICovCisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl9vbmUsIDB4MDAwODAwMDAwMDAw
MDAwMFVMTCwgMFVMTCk7CisgICAgY2hlY2s2NChkZl9hYnMocmVzdWx0KSwgMFVMTCk7CisKKyAg
ICAvKiBaZXJvIGlucHV0OiBlYXJseSBleGl0ICovCisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChE
Rl96ZXJvLCBERl9vbmUsIDBVTEwpOworICAgIGNoZWNrNjQoZGZfYWJzKHJlc3VsdCksIDBVTEwp
OworCisgICAgLyogSW5maW5pdHkgaW5wdXQ6IGVhcmx5IGV4aXQsIHJlc3VsdCBjb250YWlucyBp
bmYgKi8KKyAgICByZXN1bHQgPSBkb19kZm1weWhoKDB4N0ZGMDAwMDAwMDAwMDAwMFVMTCwgREZf
b25lLCAwVUxMKTsKKyAgICBjaGVjazY0KGRmX2V4cChyZXN1bHQpLCAweDdGRjAwMDAwMDAwMDAw
MDBVTEwpOworCisgICAgLyogTmFOIGlucHV0OiBlYXJseSBleGl0LCByZXN1bHQgaXMgTmFOICov
CisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl9RTmFOLCBERl9vbmUsIDBVTEwpOworICAgIGNo
ZWNrNjQoZGZfZXhwKHJlc3VsdCksIDB4N0ZGMDAwMDAwMDAwMDAwMFVMTCk7CisgICAgY2hlY2s2
NF9uZShkZl9tYW50KHJlc3VsdCksIDBVTEwpOworCisgICAgLyogTm9uemVybyBhY2N1bXVsYXRv
cjogbm9uemVybyBmaW5pdGUgcmVzdWx0ICovCisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl9v
bmUsIERGX29uZSwgREZfb25lKTsKKyAgICBjaGVjazY0X25lKGRmX2FicyhyZXN1bHQpLCAwVUxM
KTsKKyAgICBjaGVjazY0X25lKGRmX2V4cChyZXN1bHQpLCAweDdGRjAwMDAwMDAwMDAwMDBVTEwp
OworfQorCiBpbnQgbWFpbigpCiB7CiAgICAgY2hlY2tfY29tcGFyZV9leGNlcHRpb24oKTsKQEAg
LTk4MSw2ICsxMDM3LDcgQEAgaW50IG1haW4oKQogICAgIGNoZWNrX2NvbnZfdXcyZGYoKTsKICAg
ICBjaGVja19jb252X3VkMmRmKCk7CiAgICAgY2hlY2tfZGZtcHlmaXgoKTsKKyAgICBjaGVja19k
Zm1weWhoKCk7CiAKICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJu
IGVyciA/IDEgOiAwOwotLSAKMi4zNC4xCgo=

