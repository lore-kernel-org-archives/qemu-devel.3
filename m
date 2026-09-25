Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612AFC9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9s-0005DI-N4; Thu, 24 Sep 2026 21:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9p-0005CB-Rv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9n-00066S-9Y
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1knRo3884089
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rBXlxaNGAMkAydJ5ombBnoAHAkAmT2hhBvrVhestqV4=; b=XhAtS4ABrI4DIw+J
 +iOSw4P2GwLkpApwZs5Fw71WnLoH1IGZT4+2JS7acnkOWwp7z5TsZoDZB1X6DwS/
 o8H5HD2+NgWt7LpxIcJ++yOhSY3tJyyjMOzOPp+Q+knOZekd0iBwtgPwN8Df9iL0
 9wYz5yLRLbzUtw9aEGcMfuNBdRDjFzXEo09n+aUt1lLVIMWm77HTzAmscHwXk6Hn
 iRJHUvKI4irOH4D1xuEI/fF8gBVO6NVXmA4n3GAZGLmzdxZ4cEraopp7iXa2YiGH
 7i67CMNnNt8d7WQCF1XyMa51SlcGvASRbk6uWuaLe5w5eFRqRpQ63T6mGIhcXYaP
 F9B9NQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4652s2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-333543ac378so438123eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301311; x=1790906111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rBXlxaNGAMkAydJ5ombBnoAHAkAmT2hhBvrVhestqV4=;
 b=O+rEdq5TuEZ0cg8qwarX3cafTQvCYlARu2+F7wh46+14Mf5Z0eEPrDdTEpTbWQoZ3A
 tus1sADIeChURtiushpAXqPDcd8fxBpjkDC78qVBo4eRrUNeOymAp2cFqTqwmqKruJvf
 0Wd5MpCgHAdZOZQR9/nSev/nmwJSn/CUxL2kZSEbsRyCTha1dTeWw+jrNSPrSnv22+vI
 ImCH7KS2r8OUSKevGOWxVDT7h8qbktQ7GYwnSkbjOPKXq6KMTSJQUpvIy3/Vyl9/GWh0
 CTrKxnnKZJV4GDec6svfHbK5uKf68dVI6PPv94OapuWVGk8SfJBYFrks6A7VFVJZSeMY
 srdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301311; x=1790906111;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rBXlxaNGAMkAydJ5ombBnoAHAkAmT2hhBvrVhestqV4=;
 b=MfmyV4lWTSH4AIXJnviqq30KENmYBfkJUNx7Fx9d/zI0qdlc+77NGwC5EybgLnVlF7
 o/eTmohOVaGnq6i9Kb2nBp6jZXJxkOUEuYCQX9kdwMOpNeap2l1ONYb6X3swQZzgSz4H
 nZFK2jR7TtYy9osdQfbtyM7jsvc2VEoxVB6/ohvNPrRlp0zLebja7lDrzGXG0tO8T8s1
 Vf3Q2Kx0EnNdgHEjnqHsdZGZ5CLEDL7F56wh8eChvwWosjTbFugtSAtqHzMzVlJH4N1y
 i1gtDeyRZQ0l1megrCj2+dlw/ct9AlKNxHLxVgUq+uUb3++8Ru4TfaKwvZdbuoC5FXQU
 lXzg==
X-Gm-Message-State: AFuF++kI4+0KNSOvkUqtmY+t7M5aq/CPN01k9CJGpF8Fo1I6sg7mcUW3
 VwNMe3PC3b0+HckHewtO1CjJGnI6OGOC8wvdRM6tkq3O2bU9o162zh/fosihk65IZmOC5giuL5j
 MQuM5y83QpUyT/lyq28PyQeFZiA2g47YzpfducNJrkbXRSen3PAPK9Lao7lI3to1UAw==
X-Gm-Gg: AYBFou2S0hdl8wlKlWo6CiIthXaXC1Hxc/Jt3Mi+X7QlRqEYFtCjN8UjfR4Sh1Qly+d
 zgKC0AdYdCIXFnhjBJF7+zR6sS2Xs5iovt3VOonTfM0k1TMFXFSSyHgY+AVeq99rAFwtTQmTxfs
 W0nwbWyKxUvfnkUlsjFfw/uhWkk3qvi5tadkMkJhmJ5XttJNh51THH3NXk1r0vUALQQse6QRA2s
 8/OjxO+CjUOExK2qdSv/lSz/eAZo0O7RgLFT+XPzF5rEKea1Hd1kGpLVD+oKL+t0cFQdqBZjaAQ
 iWcvBMz/0owX42vvxEVPFFD+Us6B2NXwC5M9qYCSD6lYiFzriasC2VYJCfAqS+LmszLfJ4Io/nx
 xFlFzTq9+I4Tp94c/mM15jN0Bo8Dokwb6703J+Z+6lqtmD6k=
X-Received: by 2002:a05:7301:8601:b0:33e:4475:5e02 with SMTP id
 5a478bee46e88-34002be16c1mr3160324eec.5.1790301310901; 
 Thu, 24 Sep 2026 18:55:10 -0700 (PDT)
X-Received: by 2002:a05:7301:8601:b0:33e:4475:5e02 with SMTP id
 5a478bee46e88-34002be16c1mr3160308eec.5.1790301310294; 
 Thu, 24 Sep 2026 18:55:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 24/40] tests/tcg/hexagon: add predicate register transfer test
Date: Thu, 24 Sep 2026 18:54:13 -0700
Message-Id: <20260925015429.2579174-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab5d480 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=yBA84NwwydepxRIuKt4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: RZ7lW_EMHNTVfDuYT5avDEgcvW0cz5iC
X-Proofpoint-GUID: RZ7lW_EMHNTVfDuYT5avDEgcvW0cz5iC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX75tXZcaP2dt0
 r42cvvJVZ21pONcB5X+u2dkVY1vEo1UhZZqnZxk3HgICu9UAmb9tkPXOCciv/dJ6sCgK2ki3cF7
 KQHP4u/ybU516mgOkf3BXViB3rqyjISQ77qwic9a314jRCAdRsLuzSLVQXvmxiplPccrofQVPz5
 3dOU6mhdT1LPdcdQ2+VcIWD9Qz0w1WmQ+uYTLGrpWbZoY5FxlxKNBgE+SMSK9x/Sz9mXlLeqxwj
 dxn9MjYP69Pm+axJ0glZXme8DLg/OCR3Re9DwPwNRf8YrB+WuDfs5IKGH1rwkNve4cWEycSY9DJ
 SY7/YpR1QsVvP6fOW1yvtJFsciRdG9jdjdDdEigQWhkbf8yjG5PZC8AbzYYqQRmjaI3hBH4bS7y
 sPAg6p8kyc+cdatHSif1gp7/oGgvOypRldXHgY8drj6onOqvL/NEgXIcv9pFI6HQY8d9nu6YB8T
 ff2YajlYOWat+QFV7GA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX9rsVGt4g4Swt
 1R0OaVYONLWdXl3R2Wi6LM3QwmfOzja+HyqT4GGBF7l0QhjaXKkHNVFSkTkyzB7Odixix7V3xJH
 e8SgrWL32WQINonnJUYLsT+RUprYGng=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL21pc2MuYyB8IDI2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2MuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2MuYwpp
bmRleCBjMDc1NDdiNmY2OC4uYWJiMzRhYjZhNjUgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhh
Z29uL21pc2MuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMKQEAgLTQ0Niw2ICs0NDYs
MzEgQEAgc3RhdGljIHZvaWQgY2hlY2tfc3RvcmVfaW1tKHZvaWQpCiAgICAgY2hlY2szMihzdG9y
ZWltbV93b3JkX2FycmF5WzJdLCAweGZmZmZmZmZmKTsKIH0KIAorLyoKKyAqIFJkID0gUHMgLS0g
dHJhbnNmZXIgcHJlZGljYXRlIHJlZ2lzdGVyIHRvIGdlbmVyYWwgcmVnaXN0ZXIuCisgKiBUaGUg
cmVzdWx0IGlzIDB4MDAgb3IgMHhmZiBkZXBlbmRpbmcgb24gdGhlIHByZWRpY2F0ZSB2YWx1ZS4K
KyAqLworc3RhdGljIHZvaWQgY2hlY2tfcHJlZ190cmFuc2Zlcih2b2lkKQoreworICAgIHVpbnQz
Ml90IHJlc3VsdDsKKworICAgIC8qIFNldCBwMCA9IHRydWUsIHRoZW4gUmQgPSBwMCBzaG91bGQg
Z2l2ZSAweGZmICovCisgICAgYXNtIHZvbGF0aWxlKCJwMCA9IGNtcC5lcSglW3ZhbF0sICVbdmFs
XSlcblx0IgorICAgICAgICAgICAgICAgICAiJVtyZXNdID0gcDBcblx0IgorICAgICAgICAgICAg
ICAgICA6IFtyZXNdICI9ciIocmVzdWx0KQorICAgICAgICAgICAgICAgICA6IFt2YWxdICJyIigx
KQorICAgICAgICAgICAgICAgICA6ICJwMCIpOworICAgIGNoZWNrMzIocmVzdWx0LCAweGZmKTsK
KworICAgIC8qIFNldCBwMCA9IGZhbHNlLCB0aGVuIFJkID0gcDAgc2hvdWxkIGdpdmUgMHgwMCAq
LworICAgIGFzbSB2b2xhdGlsZSgicDAgPSBjbXAuZXEoJVthXSwgJVtiXSlcblx0IgorICAgICAg
ICAgICAgICAgICAiJVtyZXNdID0gcDBcblx0IgorICAgICAgICAgICAgICAgICA6IFtyZXNdICI9
ciIocmVzdWx0KQorICAgICAgICAgICAgICAgICA6IFthXSAiciIoMSksIFtiXSAiciIoMikKKyAg
ICAgICAgICAgICAgICAgOiAicDAiKTsKKyAgICBjaGVjazMyKHJlc3VsdCwgMHgwMCk7Cit9CisK
IGludCBtYWluKCkKIHsKICAgICBpbnQzMl90IHJlczsKQEAgLTU5MCw2ICs2MTUsNyBAQCBpbnQg
bWFpbigpCiAgICAgdGVzdF9kcG1weXNzX3JuZF9zMCgpOwogCiAgICAgY2hlY2tfc3RvcmVfaW1t
KCk7CisgICAgY2hlY2tfcHJlZ190cmFuc2ZlcigpOwogCiAgICAgcHV0cyhlcnIgPyAiRkFJTCIg
OiAiUEFTUyIpOwogICAgIHJldHVybiBlcnI7Ci0tIAoyLjM0LjEKCg==

