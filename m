Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E917C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZi-0005gk-Pd; Wed, 29 Jul 2026 21:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZg-0005fw-GL
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZe-0005aV-T2
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1MGIW497083
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=12psgMGaE/AFAca7um5d5BHgu9y7A7ATuwy2bTUnMOM=; b=LY
 wwH5T9REZv6aS0JjUcClfKDpiLbRJIUNaFIQeevIE82wi81yb+LM+nJf7pMCyWQh
 QI6Yf6aPGVPSfKC7DIdc7UMXq1GbI/JjGV3FmQOL1d3tDMb5JjWpkegF/m6hIKEZ
 LApZdS8cnCROHW1pAde0jg3a/oq389R+nPxskZoCK40FcT0HEeX4kaY+UiIvKQvC
 VfXnr7zOVN45JjKRIrOg7IEh14PB4KZbFRXxVGAnmGNNeOC8PotGm1o02JRt7M1N
 TlP2NVsccoTQUJ4Dhg4YNQmUlEX+M/AxKqkQVC5yVlZCZxP2PiELiKFxZRk8HweP
 9NY2c8Lg18I8W3P2wqpg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvvy80nc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc86a9ef97so32214255ad.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374917; x=1785979717; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=12psgMGaE/AFAca7um5d5BHgu9y7A7ATuwy2bTUnMOM=;
 b=U0T6sJmGNAxjgIlkXqHF1QrdFQuVXHNQLUBxYo43A2DTfX5lIL2xM54PUtZXtPkFGf
 GOZqpPgeetloKMVZc3WNe9tfK9+zYAyH1PD5pUbRq6NLIKCpijwQ05akSGBLFZEVzzZi
 Dxzl+J2Zb8SNoyvQN75WVVLR1Tc2kqb0FUHENi9S6I4MSiHMHJf3ueCsj5Vlyrgxfwrf
 auMiHnmCDZzAZydkC2u3Eh5PD5Nry+kF+4xFfkwdn6Ya8ZapJEunh8SoP5N9mRO5z24v
 FPogtLP5TetS60oSCUtRvA17bvDnWtFLiAoTKSt6PaqKXxyGHn5tHDcFSko5ieEut8Vy
 eILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374917; x=1785979717;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=12psgMGaE/AFAca7um5d5BHgu9y7A7ATuwy2bTUnMOM=;
 b=msG64BONuSSX+PSQqHZOQ8UG1e8J5JVGCRhd3hmG301UCVlFtz3gMKktUdwcmfTaeR
 udYNCXXCOBsiyUznYyn97L7F5Bc8qBT6koFNZmKotK4NQWXRZViXmGU8MnJlhOQ+uDU8
 QOpcwBUhoZxYAz7OCOyxGZ7io0KpbY8tVVQzYFs9yndQ0qk/tbPfGTPnMs+QtlBMNzLb
 oI14F1wqdg5DyQFvyQneX2uOYZ1pSxfk10EjvxfcVmT/3zDyLgAl4BKeFDRbTxAy9TUV
 umTB/60+bkJrcFjQ1VjF+jKdgOK/p4Y/z9n4vdOBIuFll/JLC7FcVOchabQ/TsO7mZ0i
 N/MQ==
X-Gm-Message-State: AOJu0YwYVoIPu1mvOyfA20gAOSkU8+JVLcgSn0E7rRLnfnli1/6GxXuU
 nJMhQrHBokga1sgdWDxvotKsI9agso9hPLLKJZ/sMbhOx348TWdVlDVR3uG6FO0MNSovoA0RQBE
 IOic81xfKU8kXGHaazwitt8295wE60qXJ8OiqjOCJhPu9n0snDvP4o7QBMjd6/9BkYA==
X-Gm-Gg: AR+sD11er7sVx/NluEePWlPrm/Mc4s0uJ+fnYjQCkJkd74blAe4n89FYeJBD8GtE00q
 Bu8YQ/uQ6ZK/W+nZRqefY94ejKoiDxGLgoX4/uyGbOncRJ/te8nGDcxtLCN2m2ILz7EIp7jSTYa
 RbIyjYUbajA/druBHvxuczZbTprDRp0dn6tC61TNzBVq/nAb+622cFSq74Yfp8ehV+7ua2bev8D
 3+utENLI+7Y+z/U8OI0X+Exq53RRGoBXatmLLM4IJb1qiW9ZkRdCNYdBEfXtkHCOYKYK1k8ONfD
 v0YzuI8Hpg1BtztKT749mQaMWJU9MoxOuF8C8/sBGYq4wQOZDOjmcatCw9oo66jze5v3A3Xv4Nb
 hyDUHx4qrjseqmjlFT7DwBbgPd9eaDazYb4Z6B+6t03byIIiX
X-Received: by 2002:a17:902:d2c7:b0:2ca:bb5b:3c92 with SMTP id
 d9443c01a7336-2d035cd9591mr6523855ad.35.1785374916779; 
 Wed, 29 Jul 2026 18:28:36 -0700 (PDT)
X-Received: by 2002:a17:902:d2c7:b0:2ca:bb5b:3c92 with SMTP id
 d9443c01a7336-2d035cd9591mr6523765ad.35.1785374916382; 
 Wed, 29 Jul 2026 18:28:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 08/18] hw/hexagon: extract get_reg_value/set_reg_value
 stubs in globalreg
Date: Wed, 29 Jul 2026 18:28:13 -0700
Message-Id: <20260730012824.1135905-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX53mPz+nfeOib
 fuuuPOIIOvVCLvNMgZde7II4kcXkfO/1kG/WcO4HhyiukM3t5ganeWJy1XnLRDrFFKZy0KR3kUd
 z/Y9UhJfegF14KMS1OoJ3ZgaGYAqwCqNBW2JQIA+FnJsssXsgcL4e2Oa28iyjb8qqBFcbpz4uWu
 KBkjO+a8Bd3wl6EOd9j3ts/0WHRFg2wZifMCZj3PvwfVLPkNoFY2ZYacEEpujpVAKB0Itm+82xa
 FIu0NatLxz9pgl4ztER22CKuiAbU0MLq/55x42zVhnSKFfTEtxpQm3VbDITAgdy8WDiaqtdNBGE
 2hqwHmc/xaKSil7h3CW+hBIkJmI4P9Y+7JVz7Y8rJOP9YqYW375daAiwY7eFQDqQrotHMo/GxqM
 DVrOg8QQwoxX7FPA6gFyWxiTqgBmyscvYMSmc1c/ciDGF4Y9wluYr+tu7bsOZtX54jOBoYMj+3+
 QfDiZXjfbRspnj9cvTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX2Ovk1cBXSmpJ
 FyLEURklVgaHhBjpdc6JQr8PRBwoxmuZtjTPrB5Bu0QIrV7Ghy3B19MV7LTSUk2UgmWBTXUBFBm
 sVFoDqxr8nqJHWYq0x3RCYmvyPmnc+I=
X-Authority-Analysis: v=2.4 cv=U8+iy+ru c=1 sm=1 tr=0 ts=6a6aa8c5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Z4HElfRGeH4uGo3IGfcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: uDx32dEfv311ZIwQLeCjSAxpbF1u66h1
X-Proofpoint-ORIG-GUID: uDx32dEfv311ZIwQLeCjSAxpbF1u66h1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300006
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

Um91dGUgdGhlIGdsb2JhbHJlZyByZWFkL3dyaXRlIGFjY2Vzc29ycyB0aHJvdWdoIG5ldwpnZXRf
cmVnX3ZhbHVlKCkvc2V0X3JlZ192YWx1ZSgpIGhlbHBlcnMgaW5zdGVhZCBvZiB0b3VjaGluZwpz
LT5yZWdzW3JlZ10gZGlyZWN0bHkuCgpUaGlzIHdpbGwgYmUgZXhwbG9pdGVkIGJ5IGEgc3Vic2Vx
dWVudCBwYXRjaCB0aGF0IHJlZGlyZWN0cyBWSUQvVklEMQphY2Nlc3NlcyB0byB0aGUgTDJWSUMu
CgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNv
bW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jIHwgMjMgKysrKysrKysr
KysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyBiL2h3
L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYwppbmRleCBiNWU1OTEzNTA3ZS4uMTA1NDc1MjE5
YWIgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYworKysgYi9ody9o
ZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMKQEAgLTEzNSw2ICsxMzUsMTcgQEAgc3RhdGljIGlu
bGluZSB1aW50MzJfdCBhcHBseV93cml0ZV9tYXNrKHVpbnQzMl90IG5ld192YWwsIHVpbnQzMl90
IGN1cl92YWwsCiAgICAgcmV0dXJuIG5ld192YWw7CiB9CiAKK3N0YXRpYyB1aW50MzJfdCBnZXRf
cmVnX3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnKQoreworICAg
IHJldHVybiBzLT5yZWdzW3JlZ107Cit9CisKK3N0YXRpYyB2b2lkIHNldF9yZWdfdmFsdWUoSGV4
YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IHZhbHVlKQoreworICAgIHMtPnJlZ3NbcmVnXSA9IHZhbHVlOworfQor
CiB1aW50MzJfdCBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAq
cywgdWludDMyX3QgcmVnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJf
dCBodGlkKQogewpAQCAtMTQ2LDcgKzE1Nyw3IEBAIHVpbnQzMl90IGhleGFnb25fZ2xvYmFscmVn
X3JlYWQoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAgICAgZ19hc3Nl
cnQocmVnIDwgTlVNX1NSRUdTKTsKICAgICBnX2Fzc2VydChyZWcgPj0gSEVYX1NSRUdfR0xCX1NU
QVJUKTsKIAotICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOworICAgIHZhbHVlID0gZ2V0X3JlZ192
YWx1ZShzLCByZWcpOwogCiAgICAgdHJhY2VfaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChodGlkLCBn
ZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsKICAgICByZXR1cm4gdmFsdWU7CkBAIC0xNjAsNyAr
MTcxLDcgQEAgdm9pZCBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZShIZXhhZ29uR2xvYmFsUmVnU3Rh
dGUgKnMsIHVpbnQzMl90IHJlZywKICAgICB9CiAgICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdT
KTsKICAgICBnX2Fzc2VydChyZWcgPj0gSEVYX1NSRUdfR0xCX1NUQVJUKTsKLSAgICBzLT5yZWdz
W3JlZ10gPSB2YWx1ZTsKKyAgICBzZXRfcmVnX3ZhbHVlKHMsIHJlZywgdmFsdWUpOwogICAgIHRy
YWNlX2hleGFnb25fZ2xvYmFscmVnX3dyaXRlKGh0aWQsIGdldF9zcmVnX25hbWUocmVnKSwgdmFs
dWUpOwogfQogCkBAIC0xNjgsNiArMTc5LDcgQEAgdWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdf
bWFza2VkX3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZhbHVlKQogewog
ICAgIHVpbnQzMl90IHJlZ19tYXNrOworICAgIHVpbnQzMl90IGN1cl92YWw7CiAKICAgICBpZiAo
IXMpIHsKICAgICAgICAgcmV0dXJuIHZhbHVlOwpAQCAtMTc1LDkgKzE4NywxMCBAQCB1aW50MzJf
dCBoZXhhZ29uX2dsb2JhbHJlZ19tYXNrZWRfdmFsdWUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpz
LCB1aW50MzJfdCByZWcsCiAgICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdTKTsKICAgICBnX2Fz
c2VydChyZWcgPj0gSEVYX1NSRUdfR0xCX1NUQVJUKTsKICAgICByZWdfbWFzayA9IGdsb2JhbF9z
cmVnX2ltbXV0X21hc2tzW3JlZ107CisgICAgY3VyX3ZhbCA9IGdldF9yZWdfdmFsdWUocywgcmVn
KTsKICAgICByZXR1cm4gcmVnX21hc2sgPT0gSU1NVVRBQkxFID8KLSAgICAgICAgICAgIHMtPnJl
Z3NbcmVnXSA6Ci0gICAgICAgICAgICBhcHBseV93cml0ZV9tYXNrKHZhbHVlLCBzLT5yZWdzW3Jl
Z10sIHJlZ19tYXNrKTsKKyAgICAgICAgICAgIGN1cl92YWwgOgorICAgICAgICAgICAgYXBwbHlf
d3JpdGVfbWFzayh2YWx1ZSwgY3VyX3ZhbCwgcmVnX21hc2spOwogfQogCiB2b2lkIGhleGFnb25f
Z2xvYmFscmVnX3dyaXRlX21hc2tlZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90
IHJlZywKQEAgLTE4Niw3ICsxOTksNyBAQCB2b2lkIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlX21h
c2tlZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAgICBpZiAoIXMp
IHsKICAgICAgICAgcmV0dXJuOwogICAgIH0KLSAgICBzLT5yZWdzW3JlZ10gPSBoZXhhZ29uX2ds
b2JhbHJlZ19tYXNrZWRfdmFsdWUocywgcmVnLCB2YWx1ZSk7CisgICAgc2V0X3JlZ192YWx1ZShz
LCByZWcsIGhleGFnb25fZ2xvYmFscmVnX21hc2tlZF92YWx1ZShzLCByZWcsIHZhbHVlKSk7CiB9
CiAKIHVpbnQ2NF90IGhleGFnb25fZ2xvYmFscmVnX2dldF9wY3ljbGVfYmFzZShIZXhhZ29uR2xv
YmFsUmVnU3RhdGUgKnMpCi0tIAoyLjM0LjEKCg==

