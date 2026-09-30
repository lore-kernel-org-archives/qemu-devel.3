Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF42CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByWh-00076K-Aj; Wed, 30 Sep 2026 13:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xByWc-00075I-N6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:55:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xByWa-0001zx-No
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:55:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHeq963464018
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZL+P5t8+YVthSqcIpyQ/Ko
 g6Z3XOt7NK/ouC31bEcpA=; b=BS8IPi30EMSf8swIQSEwNykFUpzBVTQr4kHeqA
 7aXJm2t3INiWUFgsSvWD7jv2an3CkQQjjjjAULMy6fad2jScml6R6hZf31aAJHOi
 kmG07+lXsHZTUoc/KPhPMv07PwPklHkSjUURtfiQ7fXCI8+/23kFbRvWkpLO46O7
 RrfjZgkqZQcS7dv/Nq7mSnZTvDSfIe31c+PIoDW/vY1/TMU8WuPUzMMOqGRBJQiW
 1kHznFhVn1Ws7KhF/3K9efZIbfa14zEW9lCp51VaBw5XDkcaAoo8qNk32Y+OPK+c
 PGQc9QaUAAGp4lGw43OwMK/n1nyd7uX2pHqYVXxb6CSSpOQA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcr3bq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:55:23 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-147be78cd56so404421c88.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790922; x=1791395722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZL+P5t8+YVthSqcIpyQ/Kog6Z3XOt7NK/ouC31bEcpA=;
 b=LS4n2aDBrFORQIW+6+9aYe51zq+JoMxEcdZ5IAltkl/l8RDpJ0XFvMPD57NK5o9HQu
 Mw+4erXA+0voyWVi3EZ4vMmQ5xhcZXaBjgzu6XyWBvzR41xke8MgOzbBPsc+eF27ob65
 ZaS0+m553oVTjct/asaraUsBFMiqIm5SZEMVn9HJHCofT9+Yr+JC1sWYJRqJOemI2kAU
 fv/rcwV/RSx8rIHpBXCMB9MjSp7s26UDBSMS1oVKeMVWzgfgB7ruSpJVDNyF8g8zUgG/
 aMX9nj7896ZwykVivkoBaQMKWxVI2LlqcfFxbQiLvztA9NNF4xD93nQvf4IcPsfZB4C7
 vIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790922; x=1791395722;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZL+P5t8+YVthSqcIpyQ/Kog6Z3XOt7NK/ouC31bEcpA=;
 b=TIjj+6IiIUDOZL9dVIwtDaJpc96jfjqYXj0vS5iFP17rj5lE4v1sgzSzL/zubLBWoT
 BAPIYndNea3SRw4wyAK1C1RvGdgoPiejpBQGKZmSRuXVZObs1NzH2odxskLIfoz/iS/4
 rfFAkbIBO9aqR2qgUUEKmYEpvGUHPH3vomm5tNWmmiIoDQyS959TsX9Qrf5yH2nIMrxY
 ydORllXE5eFmlaIOs4mPp5isnCU55/8oUNpdD+hcihb83AxN3304qTNQoCAE2WfxCKwX
 E+ebWwWMGVKcebC1vhT943E0rAOLqSV+uL26QqfKpGHxhjTg2og4TTuC90P1rKsbVzYr
 byiA==
X-Gm-Message-State: AFuF++kKKesSKUciwbAHWcPdW+k0QmiJX8Y+dVdAk5hBzOxB5pWi/YCP
 YQYXxB11OWJ0/48/VFy+BK3owFeNEyQqw1GzNr944Vv6c3sFqK/52pTvgpwptEjrtnw0GzNJeJl
 +C2IArcaZeaa2KsPY/li//Loxwf0KMVyRzY10jyebr/YbkGDNOjAcdKMIDjOKrkv8hA==
X-Gm-Gg: AYBFou1zHxu98soucpe/sgknDTivif6nck/ofeW5Ax1mV0mytRJfQLe2BTahFLCLzp5
 iuHcWvCB65YauX/SrQkYqM74V+nfM1ygAiAnPK3g+KrBBYKh+iiVC/1Xyi7gD+GM/bMFhNWQH6H
 hcEX0yKxuo0DkCJAqSkol6QaNxJD2Wjq8wZNKaBu3AsfQwZKkgOqd39JsKGFrBCuqA2KwgX8pFV
 mX9YwzAiSIPkbQ2CajpuG5aQzHMLtBcNHTGJf2362HTF1dJ0z0DOehjkgP61Eyu/3GVXU/6gYWJ
 mj/FZD/DNQit6wUBfCK6A72gKP747wx6I6nWbnW5V0JvbLMmyRSAFRfkIaW9ab1ecpLN+GCC9kS
 +ppA+rcVVxOpJX5+aiqpFM7dGi28CiPxkQTctCopDZHKm1jY=
X-Received: by 2002:a05:7022:239a:b0:145:3a5:d918 with SMTP id
 a92af1059eb24-14d3348fdb8mr2500439c88.33.1790790921770; 
 Wed, 30 Sep 2026 10:55:21 -0700 (PDT)
X-Received: by 2002:a05:7022:239a:b0:145:3a5:d918 with SMTP id
 a92af1059eb24-14d3348fdb8mr2500406c88.33.1790790921181; 
 Wed, 30 Sep 2026 10:55:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14d08fb50f1sm8595791c88.13.2026.09.30.10.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:55:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] contrib/plugins/uftrace: add support for Hexagon
Date: Wed, 30 Sep 2026 10:55:19 -0700
Message-Id: <20260930175519.3601312-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MiBTYWx0ZWRfX74Rq6EGmYYXH
 t8GQGn5Lmglb2zCfZsfW1EcTwAB2tzD+QxLGYtomBOR3NPKtlkG3tpblXoXyuXi9xF9QygusUgH
 rxu/7HA3bEKW9heX9ws7D0vdpSWP1AarFB21997qxZRimU29pJX1LihwLK92Jc/pDZ7k/ZEh3zP
 j7Z5np1LaCldh0NrekANJZeCrLC7oWHmlGIqtIJGTMN810UNHMo5Jpir7RnK8R6+vvdVvvj42Cu
 82gU3H/jIrHU7jtFowlM1CbqN+2MRijIxwpWKIOnt4zm4FBlKBnRP7OID9S0jrLvuA5k0yQFZjo
 38Pm+8P02Ak3JPSMl97cpKr6flWLt1y162g8FFBqyD0MD3uBZRWrxh0Skyq5zqyILNFu4pojXob
 nNpjcNe+jfH+ajRxzbVvLtmNNoaxVPqdN+zBUnga5tvUu8vJFb19SO3F0llI91wlPD0GgV/oHkO
 wYJqas3dRh8gkZel0yg==
X-Proofpoint-GUID: lpaM5gPaMljtoJ0V-6o8KkUX5qeMAA5V
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MiBTYWx0ZWRfX1MYcE26w1bZ5
 oJsqOV+YPSEEMm9VcX5pj7VBjVF8TLCBevbhpIe+v4qq1jiG+Bb2al4L7Cd0R/eZVLNtmdqXH42
 1J8Szy+GNXVf2YP3sBVyJ0US6vbwV1s=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abd4d0b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=xgyr-5ruijG_Iadbgw4A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: lpaM5gPaMljtoJ0V-6o8KkUX5qeMAA5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300072
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogZG9jcy9hYm91dC9lbXVs
YXRpb24ucnN0ICB8ICAgMiArLQogY29udHJpYi9wbHVnaW5zL3VmdHJhY2UuYyB8IDEzMCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMzEg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RvY3MvYWJvdXQvZW11
bGF0aW9uLnJzdCBiL2RvY3MvYWJvdXQvZW11bGF0aW9uLnJzdAppbmRleCBjNTgxNDkwODZjZC4u
YjQwNGM1YzVlOGUgMTAwNjQ0Ci0tLSBhL2RvY3MvYWJvdXQvZW11bGF0aW9uLnJzdAorKysgYi9k
b2NzL2Fib3V0L2VtdWxhdGlvbi5yc3QKQEAgLTgzNiw3ICs4MzYsNyBAQCBVZnRyYWNlCiBUaGlz
IHBsdWdpbiBnZW5lcmF0ZXMgYSBiaW5hcnkgdHJhY2UgY29tcGF0aWJsZSB3aXRoCiBgdWZ0cmFj
ZSA8aHR0cHM6Ly9naXRodWIuY29tL25hbWh5dW5nL3VmdHJhY2U+YF8uCiAKLVBsdWdpbiBzdXBw
b3J0cyBhYXJjaDY0LCB4NjQgYW5kIHJpc2N2NjQsIGFuZCB3b3JrcyBpbiB1c2VyIGFuZCBzeXN0
ZW0gbW9kZSwKK1BsdWdpbiBzdXBwb3J0cyBhYXJjaDY0LCB4NjQsIHJpc2N2NjQsIGFuZCBIZXhh
Z29uLCBhbmQgd29ya3MgaW4gdXNlciBhbmQgc3lzdGVtIG1vZGUsCiBhbGxvd2luZyB0byB0cmFj
ZSBhIHN5c3RlbSBib290LCB3aGljaCBpcyBub3Qgc29tZXRoaW5nIHBvc3NpYmxlIHVzdWFsbHku
CiAKIEluIHVzZXIgbW9kZSwgdGhlIG1lbW9yeSBtYXBwaW5nIGlzIGRpcmVjdGx5IGNvcGllZCBm
cm9tIGBgL3Byb2Mvc2VsZi9tYXBzYGAgYXQKZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy91
ZnRyYWNlLmMgYi9jb250cmliL3BsdWdpbnMvdWZ0cmFjZS5jCmluZGV4IDA2M2UzMjIyMGIxLi5i
ZjRjYTdjNjg5NCAxMDA2NDQKLS0tIGEvY29udHJpYi9wbHVnaW5zL3VmdHJhY2UuYworKysgYi9j
b250cmliL3BsdWdpbnMvdWZ0cmFjZS5jCkBAIC05OSw2ICs5OSwxOSBAQCB0eXBlZGVmIHN0cnVj
dCB7CiAgICAgc3RydWN0IHFlbXVfcGx1Z2luX3JlZ2lzdGVyICpyZWdfY3IwOwogfSBYNjRDcHU7
CiAKK3R5cGVkZWYgZW51bSB7CisgICAgSEVYX01PTklUT1IsCisgICAgSEVYX0dVRVNULAorICAg
IEhFWF9VU0VSLAorICAgIEhFWF9QUklWSUxFR0VfTEVWRUxfTUFYLAorfSBIZXhhZ29uUHJpdmls
ZWdlTGV2ZWw7CisKK3R5cGVkZWYgc3RydWN0IHsKKyAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5fcmVn
aXN0ZXIgKnJlZ19mcDsKKyAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5fcmVnaXN0ZXIgKnJlZ19zc3I7
CisgICAgc3RydWN0IHFlbXVfcGx1Z2luX3JlZ2lzdGVyICpyZWdfZnJhbWVrZXk7Cit9IEhleGFn
b25DUFU7CisKIHR5cGVkZWYgc3RydWN0IHsKICAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5fcmVnaXN0
ZXIgKnJlZ19mcDsKICAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5fcmVnaXN0ZXIgKnJlZ19wcml2OwpA
QCAtNDUzLDYgKzQ2NiwyMSBAQCBzdGF0aWMgdWludDY0X3QgY3B1X3JlYWRfbWVtb3J5NjQoQ3B1
ICpjcHUsIHVpbnQ2NF90IGFkZHIpCiAgICAgcmV0dXJuICooKHVpbnQ2NF90ICopIGJ1Zi0+ZGF0
YSk7CiB9CiAKK3N0YXRpYyB1aW50MzJfdCBjcHVfcmVhZF9tZW1vcnkzMihDcHUgKmNwdSwgdWlu
dDY0X3QgYWRkcikKK3sKKyAgICBpZiAoIWFkZHIpIHsKKyAgICAgICAgcmV0dXJuIDA7CisgICAg
fQorICAgIEdCeXRlQXJyYXkgKmJ1ZiA9IGNwdS0+YnVmOworICAgIGdfYnl0ZV9hcnJheV9zZXRf
c2l6ZShidWYsIDApOworICAgIGJvb2wgcmVhZCA9IHFlbXVfcGx1Z2luX3JlYWRfbWVtb3J5X3Zh
ZGRyKGFkZHIsIGJ1ZiwgNCk7CisgICAgaWYgKCFyZWFkKSB7CisgICAgICAgIHJldHVybiAwOwor
ICAgIH0KKyAgICBnX2Fzc2VydChidWYtPmxlbiA9PSA0KTsKKyAgICByZXR1cm4gKigodWludDMy
X3QgKikgYnVmLT5kYXRhKTsKK30KKwogc3RhdGljIHZvaWQgY3B1X3Vud2luZF9zdGFjayhDcHUg
KmNwdSwgdWludDY0X3QgZnJhbWVfcG9pbnRlciwgdWludDY0X3QgcGMpCiB7CiAgICAgZ19hc3Nl
cnQoY2FsbHN0YWNrX2VtcHR5KGNwdS0+Y3MpKTsKQEAgLTY5OCw2ICs3MjYsMTA2IEBAIHN0YXRp
YyBDcHVPcHMgeDY0X29wcyA9IHsKICAgICAuZG9lc19pbnNuX21vZGlmeV9mcmFtZV9wb2ludGVy
ID0geDY0X2RvZXNfaW5zbl9tb2RpZnlfZnJhbWVfcG9pbnRlciwKIH07CiAKK3N0YXRpYyB1aW50
OF90IGhleGFnb25fbnVtX3ByaXZpbGVnZV9sZXZlbHModm9pZCkKK3sKKyAgICByZXR1cm4gSEVY
X1BSSVZJTEVHRV9MRVZFTF9NQVg7Cit9CisKK3N0YXRpYyBjb25zdCBjaGFyICpoZXhhZ29uX2dl
dF9wcml2aWxlZ2VfbGV2ZWxfbmFtZSh1aW50OF90IHBsKQoreworICAgIHN3aXRjaCAocGwpIHsK
KyAgICBjYXNlIEhFWF9NT05JVE9SOiByZXR1cm4gIm1vbml0b3IiOworICAgIGNhc2UgSEVYX0dV
RVNUOiByZXR1cm4gImd1ZXN0IjsKKyAgICBjYXNlIEhFWF9VU0VSOiByZXR1cm4gInVzZXIiOwor
ICAgIGRlZmF1bHQ6CisgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgfQorfQor
CisjZGVmaW5lIEhFWF9TU1JfRklFTERfVU0gMTYKKyNkZWZpbmUgSEVYX1NTUl9GSUVMRF9FWCAx
NworI2RlZmluZSBIRVhfU1NSX0ZJRUxEX0dNIDE5CisKK3N0YXRpYyB1aW50OF90IGhleGFnb25f
Z2V0X3ByaXZpbGVnZV9sZXZlbChDcHUgKmNwdV8pCit7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0g
Y3B1Xy0+YXJjaDsKKyAgICB1aW50MzJfdCBzc3IgPSBjcHVfcmVhZF9yZWdpc3RlcjMyKGNwdV8s
IGNwdS0+cmVnX3Nzcik7CisgICAgYm9vbCBleCA9IChzc3IgPj4gSEVYX1NTUl9GSUVMRF9FWCkg
JiAxOworICAgIGJvb2wgdW0gPSAoc3NyID4+IEhFWF9TU1JfRklFTERfVU0pICYgMTsKKyAgICBi
b29sIGdtID0gKHNzciA+PiBIRVhfU1NSX0ZJRUxEX0dNKSAmIDE7CisKKyAgICBpZiAoZXggfHwg
IXVtKSB7CisgICAgICAgIHJldHVybiBIRVhfTU9OSVRPUjsKKyAgICB9IGVsc2UgaWYgKCFleCAm
JiB1bSkgeworICAgICAgICByZXR1cm4gZ20gPyBIRVhfR1VFU1QgOiBIRVhfVVNFUjsKKyAgICB9
CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKworc3RhdGljIHVpbnQ2NF90IGhleGFn
b25fZ2V0X2ZyYW1lX3BvaW50ZXIoQ3B1ICpjcHVfKQoreworICAgIEhleGFnb25DUFUgKmNwdSA9
IGNwdV8tPmFyY2g7CisgICAgcmV0dXJuIGNwdV9yZWFkX3JlZ2lzdGVyMzIoY3B1XywgY3B1LT5y
ZWdfZnApOworfQorCitzdGF0aWMgdWludDY0X3QgaGV4YWdvbl9nZXRfbmV4dF9mcmFtZV9wb2lu
dGVyKENwdSAqY3B1XywgdWludDY0X3QgZnApCit7CisgICAgcmV0dXJuIGNwdV9yZWFkX21lbW9y
eTMyKGNwdV8sIGZwKTsKK30KKworc3RhdGljIHVpbnQ2NF90IGhleGFnb25fZ2V0X25leHRfcmV0
dXJuX2FkZHJlc3MoQ3B1ICpjcHVfLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDY0X3QgZnJhbWVfcG9pbnRlcikKK3sKKyAgICBIZXhhZ29uQ1BV
ICpjcHUgPSBjcHVfLT5hcmNoOworICAgIHVpbnQ2NF90IGZyYW1la2V5ID0gY3B1X3JlYWRfcmVn
aXN0ZXIzMihjcHVfLCBjcHUtPnJlZ19mcmFtZWtleSk7CisgICAgdWludDY0X3Qgc2NyYW1ibGVk
X2xyID0gY3B1X3JlYWRfbWVtb3J5MzIoY3B1XywgZnJhbWVfcG9pbnRlciArIDQpOworICAgIHVp
bnQ2NF90IGxyID0gc2NyYW1ibGVkX2xyIF4gZnJhbWVrZXk7CisgICAgcmV0dXJuIGxyOworfQor
CitzdGF0aWMgdm9pZCBoZXhhZ29uX2luaXQoQ3B1ICpjcHVfKQoreworICAgIEhleGFnb25DUFUg
KmNwdSA9IGdfbmV3MChIZXhhZ29uQ1BVLCAxKTsKKyAgICBjcHVfLT5hcmNoID0gY3B1OworICAg
IGNwdS0+cmVnX2ZwID0gcGx1Z2luX2ZpbmRfcmVnaXN0ZXIoInIzMCIpOworICAgIGlmICghY3B1
LT5yZWdfZnApIHsKKyAgICAgICAgZnByaW50ZihzdGRlcnIsICJ1ZnRyYWNlIHBsdWdpbjogZnJh
bWUgcG9pbnRlciByZWdpc3RlciAoUjMwKSBpcyBub3QgIgorICAgICAgICAgICAgICAgICAgICAg
ICAgImF2YWlsYWJsZS5cbiIpOworICAgICAgICBnX2Fib3J0KCk7CisgICAgfQorICAgIGNwdS0+
cmVnX3NzciA9IHBsdWdpbl9maW5kX3JlZ2lzdGVyKCJzc3IiKTsKKyAgICBpZiAodHJhY2VfcHJp
dmlsZWdlX2xldmVsICYmICFjcHUtPnJlZ19zc3IpIHsKKyAgICAgICAgZnByaW50ZihzdGRlcnIs
ICJ1ZnRyYWNlIHBsdWdpbjogdHJhY2UtcHJpdmlsZWdlLWxldmVsIGlzIG5vdCAiCisgICAgICAg
ICAgICAgICAgICAgICAgICAic3VwcG9ydGVkIGZvciBoZXhhZ29uLWxpbnV4LXVzZXIuXG4iKTsK
KyAgICAgICAgZ19hYm9ydCgpOworICAgIH0KKyAgICBjcHUtPnJlZ19mcmFtZWtleSA9IHBsdWdp
bl9maW5kX3JlZ2lzdGVyKCJmcmFtZWtleSIpOworICAgIGdfYXNzZXJ0KGNwdS0+cmVnX2ZyYW1l
a2V5KTsKK30KKworc3RhdGljIHZvaWQgaGV4YWdvbl9lbmQoQ3B1ICpjcHUpCit7CisgICAgZ19m
cmVlKGNwdS0+YXJjaCk7Cit9CisKK3N0YXRpYyBib29sIGhleGFnb25fZG9lc19pbnNuX21vZGlm
eV9mcmFtZV9wb2ludGVyKGNvbnN0IGNoYXIgKmRpc2FzKQoreworICAgIHJldHVybiBzdHJzdHIo
ZGlzYXMsICJhbGxvYyIpIHx8CisgICAgICAgICAgIHN0cnN0cihkaXNhcywgIlIzMCIpIHx8IHN0
cnN0cihkaXNhcywgIlIzMTozMCIpOworfQorCitzdGF0aWMgQ3B1T3BzIGhleGFnb25fb3BzID0g
eworICAgIC5pbml0ID0gaGV4YWdvbl9pbml0LAorICAgIC5lbmQgPSBoZXhhZ29uX2VuZCwKKyAg
ICAuZ2V0X2ZyYW1lX3BvaW50ZXIgPSBoZXhhZ29uX2dldF9mcmFtZV9wb2ludGVyLAorICAgIC5n
ZXRfbmV4dF9mcmFtZV9wb2ludGVyID0gaGV4YWdvbl9nZXRfbmV4dF9mcmFtZV9wb2ludGVyLAor
ICAgIC5nZXRfbmV4dF9yZXR1cm5fYWRkcmVzcyA9IGhleGFnb25fZ2V0X25leHRfcmV0dXJuX2Fk
ZHJlc3MsCisgICAgLmdldF9wcml2aWxlZ2VfbGV2ZWwgPSBoZXhhZ29uX2dldF9wcml2aWxlZ2Vf
bGV2ZWwsCisgICAgLm51bV9wcml2aWxlZ2VfbGV2ZWxzID0gaGV4YWdvbl9udW1fcHJpdmlsZWdl
X2xldmVscywKKyAgICAuZ2V0X3ByaXZpbGVnZV9sZXZlbF9uYW1lID0gaGV4YWdvbl9nZXRfcHJp
dmlsZWdlX2xldmVsX25hbWUsCisgICAgLmRvZXNfaW5zbl9tb2RpZnlfZnJhbWVfcG9pbnRlciA9
IGhleGFnb25fZG9lc19pbnNuX21vZGlmeV9mcmFtZV9wb2ludGVyLAorfTsKKwogc3RhdGljIHVp
bnQ4X3QgcmlzY3Y2NF9udW1fcHJpdmlsZWdlX2xldmVscyh2b2lkKQogewogICAgIHJldHVybiBS
SVNDVjY0X1BSSVZJTEVHRV9MRVZFTF9NQVg7CkBAIC05ODQsNiArMTExMiw4IEBAIFFFTVVfUExV
R0lOX0VYUE9SVCBpbnQgcWVtdV9wbHVnaW5faW5zdGFsbChxZW11X3BsdWdpbl9pZF90IGlkLAog
ICAgICAgICBhcmNoX29wcyA9IHg2NF9vcHM7CiAgICAgfSBlbHNlIGlmICghc3RyY21wKGluZm8t
PnRhcmdldF9uYW1lLCAicmlzY3Y2NCIpKSB7CiAgICAgICAgIGFyY2hfb3BzID0gcmlzY3Y2NF9v
cHM7CisgICAgfSBlbHNlIGlmICghc3RyY21wKGluZm8tPnRhcmdldF9uYW1lLCAiaGV4YWdvbiIp
KSB7CisgICAgICAgIGFyY2hfb3BzID0gaGV4YWdvbl9vcHM7CiAgICAgfSBlbHNlIHsKICAgICAg
ICAgZnByaW50ZihzdGRlcnIsICJwbHVnaW4gdWZ0cmFjZTogJXMgdGFyZ2V0IGlzIG5vdCBzdXBw
b3J0ZWRcbiIsCiAgICAgICAgICAgICAgICAgaW5mby0+dGFyZ2V0X25hbWUpOwotLSAKMi4zNC4x
Cgo=

