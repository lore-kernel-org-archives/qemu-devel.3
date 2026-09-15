Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E5FC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4O-00063N-Q5; Tue, 15 Sep 2026 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4D-0005zq-BA
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4B-0003sS-Ik
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAU704176153
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8f+YUKiUCgruigEWW6RCmqNqjaanWMaUWMcLnw3kF70=; b=MH+mMJqPEiK/oKmK
 2Cb5oQtsEwe482DHFdmMlCrMqLbibUxM/X8o5YjoqO3NK9zbLuWRR2eGQbqxvQsF
 amXIgq3AJ7R871OQsaodz4EdiPvTdAHq5DMNnSRuckI9wenWmkdyz696IXU22kPg
 AJmhaZwQoCFHC77UxMN0UJgLvBDhVARj2acBVVbmrQfGSdld0ziPaAQR0rHkDZvh
 OrZLY9dT3BM82CsfN8hHpAi1gl68cPW56AwddiayxDApvE5yc9KpuHciJxOXUNGo
 41YG+gRtmCIbXwl8ntn+fMl/Luttgs+oK3ZfdxLBpj5WDroCKtrlaQptmqT81SFY
 fA1/Ow==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc2dmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39e087a18deso1364684a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489885; x=1790094685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8f+YUKiUCgruigEWW6RCmqNqjaanWMaUWMcLnw3kF70=;
 b=KLSjTDD6wDWI3XqXtAMKoYNpjTRtzTca8To2rkLWizsqm2znuh3bPvyxk3zLmWuBwc
 Lna87xuGIKfPiHdaoybGSSiRwMv8bX9Ao7D6HdWDxvDNUxi/BSKI1N3ai0sZ76Qrpbpa
 8/WHZKQsox1bSBXOC1+d+S5Czb70O/eYUwhv9iJk8F8g7fl+9EhYzXzcWtEgrwfkjmBc
 EbVGerbJt5s6ErfVPKrHt9bNn1pOnk1ibB7MB1Wo+OwDP34waIIfeS/PZumSDC1+MFar
 XzdyJCOQqilBNldMAECQvfpQeWuYJGDJUAqgYidiKXH6tvZ5P9ASuDCysOhXbW4b139J
 ddSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489885; x=1790094685;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8f+YUKiUCgruigEWW6RCmqNqjaanWMaUWMcLnw3kF70=;
 b=Oz8uGtebyDkfyNA+lAKsNwlVt3dQPCfSHWw0j5ktK9FDmYHgqTJroEiPawbg5AiSq4
 pB6G4WIAEWuRW6DVTzlLw1IXW/1bzbFTyvfrdo1ZH0v0S67ETrSfRgZs+3H8Hzn3rAmF
 4k0mB2CNHGvmK2d3lVkaZe610KS++gTYNgVr6CQdFez+uhF5bi1HBklcUdhYYpfhhKlS
 Bw+Hkf9n+l9LZDt3HfE7/alhNU3eyW3cJfNRhsDtfRgz2jUs7AdfmZKQ5foSqa6m1Wcr
 dKg9nppLSGQOk6QTA0gtcjLzcW/Y3nhN4vivtsPGW+aNg1ZWXzhzMZkfMGRlumWO8TZ/
 tGCg==
X-Gm-Message-State: AFuF++kBkVqnQ6ExgfrGsdKanjEQdSYZy8VWuIxLRUY3iwIVcHkxcbrL
 uccBoPYLv/XNZ3HTtZiGrBz3I7oaTKXUE5p2+UfhuY8b2u59E13Tf+maavgmPy6UiAvp4R37FrE
 iTpZELufn+DBsLkg6JtfGSpbDr7G8OuQYsfdTaZ+w0GJ/0GPZ5R0qhKHyk+DJcirrPA==
X-Gm-Gg: AYBFou3Oj3ARsH3B70xXdrWIYPsyNZIejR0VW83ZCgmokI28ZrmDbFG4EdmipCsAiN9
 86Tddlm/Aa2aqjLNvyL4yjJSd1wlJY/IOTb156GcGZdGQVcPhR1h0CdH1M2eHDsGXe16rR7+11b
 fvnVJr52M4Y/j1rMMJbau+iPOlvwuz/UOR5pluzuUx0G+rZKG2SvLtOgXkqfC2tugdsUc6hSaFD
 rDRbz1DZ2Dwy4wkocqh1Kg2skLjtunjvxPF6b0DbnykO21oHnoTRN12ZSiPXF7LZ+AW8xfBB/su
 wPg/l6aWBOSs6reBgFg58enZIDdDbtisHJUo+f73MhjXk2O4Bpey7cRsaMXl41pVaxgo8mWr6JD
 u+g7T+a+VCITrxCAxhghrfobfcjf8O0Yw+5qVNodk2GyeFE+6
X-Received: by 2002:a17:90a:dfc7:b0:39d:f5ef:b1d5 with SMTP id
 98e67ed59e1d1-39df5efb222mr13595924a91.7.1789489884426; 
 Tue, 15 Sep 2026 09:31:24 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc7:b0:39d:f5ef:b1d5 with SMTP id
 98e67ed59e1d1-39df5efb222mr13595849a91.7.1789489883925; 
 Tue, 15 Sep 2026 09:31:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 13/17] tests/tcg/hexagon: add unconditional store-immediate
 tests
Date: Tue, 15 Sep 2026 09:30:43 -0700
Message-Id: <20260915163047.4180600-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: nmL3D3lzgVoYKvhn4g7H62FXJMOB2gdn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX2NL0bpcfMkrF
 ohoLLRxUDFZlCzKeHVDeO/6B/cxJ6Dukmq8t/otJX3eeXCWxt1sqvbILgt27W722nakO11P4/SE
 EEe8W+vkvisk+GUOdL4CCeGGcS/yjdA=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa972dd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0l-Zo2GwZyP_T63qDoMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX+ER58Z+aX+lE
 Fwe1XOkv1A23X342ooo61xfKx+DaNzT1VjuZqfnO5wHPTRmczeCS4ooySM/2UIbHFcME6pezaxN
 oenShQ2XUg+Z28cQeisc3DMU2JrE4aqOSDLMf03vhyWx4+bRiHNAK6kSQH3yzfij9FLqdkhqhm8
 aNw1X1PnaMlcOeWMVl1w4vtUFevQaRUshuNgAtqtBv6lyVHKniqli1XXMTqfO9X8i27TdxHaeTc
 BvsWi7HS3QE+ljynuD4MxdMbKm2o6EnQNaAG/GmOgxPz0NpB+TyD4KYrlZesLo03YkIiXES0e56
 weE+qFZiz11pvts9TVx+Wfvu5mFBPOzS6yrqpPY/92PwB7n27wVruAdhnnPlDShpOYEEeALW9wT
 ZkEPb0DI18/YvUz3zTOQwJYD6OtTXERm5EEZ4xtgPfbfOiwXv0kKNFUNABEIOwmXCdfPOWFz98L
 Teq2TS8IIZShlsyfL8A==
X-Proofpoint-GUID: nmL3D3lzgVoYKvhn4g7H62FXJMOB2gdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150240
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL21pc2MuYyB8IDQ0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vbWlzYy5jIGIvdGVzdHMvdGNnL2hl
eGFnb24vbWlzYy5jCmluZGV4IGNhMjJiYjc5ZjdiLi5jMDc1NDdiNmY2OCAxMDA2NDQKLS0tIGEv
dGVzdHMvdGNnL2hleGFnb24vbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2MuYwpA
QCAtNDA0LDYgKzQwNCw0OCBAQCB2b2lkIHRlc3RfZHBtcHlzc19ybmRfczAodm9pZCkKICAgICBj
aGVjazMyKGRwbXB5c3Nfcm5kX3MwKDB4N2ZmZmZmZmYsIDB4N2ZmZmZmZmYpLCAweDNmZmZmZmZm
KTsKIH0KIAorc3RhdGljIHVpbnQ4X3Qgc3RvcmVpbW1fYnl0ZV9hcnJheVsxNl07CitzdGF0aWMg
dWludDE2X3Qgc3RvcmVpbW1faGFsZl9hcnJheVsxNl07CitzdGF0aWMgdWludDMyX3Qgc3RvcmVp
bW1fd29yZF9hcnJheVsxNl07CisKKy8qCisgKiBVbmNvbmRpdGlvbmFsIHN0b3JlLWltbWVkaWF0
ZSBpbnN0cnVjdGlvbnMgKFM0X3N0b3JlaXIqX2lvKS4KKyAqIFRoZSBwcmVkaWNhdGVkIGZvcm1z
IGFyZSB0ZXN0ZWQgYWJvdmU7IHRoZXNlIGV4ZXJjaXNlIHRoZSBiYXNlIGVuY29kaW5nCisgKiB3
aXRoIHBvc2l0aXZlIGFuZCBuZWdhdGl2ZSAjUzggaW1tZWRpYXRlIHZhbHVlcy4KKyAqLworc3Rh
dGljIHZvaWQgY2hlY2tfc3RvcmVfaW1tKHZvaWQpCit7CisgICAgLyogbWVtYihScysjdTY6MCkg
PSAjUzggKi8KKyAgICBtZW1zZXQoc3RvcmVpbW1fYnl0ZV9hcnJheSwgMCwgc2l6ZW9mKHN0b3Jl
aW1tX2J5dGVfYXJyYXkpKTsKKyAgICBhc20gdm9sYXRpbGUoIm1lbWIoJVtwdHJdICsgIzApID0g
IzB4MTJcblx0IgorICAgICAgICAgICAgICAgICA6IDogW3B0cl0gInIiKHN0b3JlaW1tX2J5dGVf
YXJyYXkpIDogIm1lbW9yeSIpOworICAgIGNoZWNrMzIoc3RvcmVpbW1fYnl0ZV9hcnJheVswXSwg
MHgxMik7CisKKyAgICBhc20gdm9sYXRpbGUoIm1lbWIoJVtwdHJdICsgIzMpID0gIy0xXG5cdCIK
KyAgICAgICAgICAgICAgICAgOiA6IFtwdHJdICJyIihzdG9yZWltbV9ieXRlX2FycmF5KSA6ICJt
ZW1vcnkiKTsKKyAgICBjaGVjazMyKHN0b3JlaW1tX2J5dGVfYXJyYXlbM10sIDB4ZmYpOworCisg
ICAgLyogbWVtaChScysjdTY6MSkgPSAjUzggKi8KKyAgICBtZW1zZXQoc3RvcmVpbW1faGFsZl9h
cnJheSwgMCwgc2l6ZW9mKHN0b3JlaW1tX2hhbGZfYXJyYXkpKTsKKyAgICBhc20gdm9sYXRpbGUo
Im1lbWgoJVtwdHJdICsgIzApID0gIzB4MzRcblx0IgorICAgICAgICAgICAgICAgICA6IDogW3B0
cl0gInIiKHN0b3JlaW1tX2hhbGZfYXJyYXkpIDogIm1lbW9yeSIpOworICAgIGNoZWNrMzIoc3Rv
cmVpbW1faGFsZl9hcnJheVswXSwgMHgzNCk7CisKKyAgICBhc20gdm9sYXRpbGUoIm1lbWgoJVtw
dHJdICsgIzQpID0gIy0xXG5cdCIKKyAgICAgICAgICAgICAgICAgOiA6IFtwdHJdICJyIihzdG9y
ZWltbV9oYWxmX2FycmF5KSA6ICJtZW1vcnkiKTsKKyAgICBjaGVjazMyKHN0b3JlaW1tX2hhbGZf
YXJyYXlbMl0sIDB4ZmZmZik7CisKKyAgICAvKiBtZW13KFJzKyN1NjoyKSA9ICNTOCAqLworICAg
IG1lbXNldChzdG9yZWltbV93b3JkX2FycmF5LCAwLCBzaXplb2Yoc3RvcmVpbW1fd29yZF9hcnJh
eSkpOworICAgIGFzbSB2b2xhdGlsZSgibWVtdyglW3B0cl0gKyAjMCkgPSAjMHg1NlxuXHQiCisg
ICAgICAgICAgICAgICAgIDogOiBbcHRyXSAiciIoc3RvcmVpbW1fd29yZF9hcnJheSkgOiAibWVt
b3J5Iik7CisgICAgY2hlY2szMihzdG9yZWltbV93b3JkX2FycmF5WzBdLCAweDU2KTsKKworICAg
IGFzbSB2b2xhdGlsZSgibWVtdyglW3B0cl0gKyAjOCkgPSAjLTFcblx0IgorICAgICAgICAgICAg
ICAgICA6IDogW3B0cl0gInIiKHN0b3JlaW1tX3dvcmRfYXJyYXkpIDogIm1lbW9yeSIpOworICAg
IGNoZWNrMzIoc3RvcmVpbW1fd29yZF9hcnJheVsyXSwgMHhmZmZmZmZmZik7Cit9CisKIGludCBt
YWluKCkKIHsKICAgICBpbnQzMl90IHJlczsKQEAgLTU0Nyw2ICs1ODksOCBAQCBpbnQgbWFpbigp
CiAKICAgICB0ZXN0X2RwbXB5c3Nfcm5kX3MwKCk7CiAKKyAgICBjaGVja19zdG9yZV9pbW0oKTsK
KwogICAgIHB1dHMoZXJyID8gIkZBSUwiIDogIlBBU1MiKTsKICAgICByZXR1cm4gZXJyOwogfQot
LSAKMi4zNC4xCgo=

