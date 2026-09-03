Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3BAC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cc2-0000YN-P3; Thu, 03 Sep 2026 14:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc1-0000Xr-3T
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbx-0000Xq-54
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3H98927995
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=Y/MYSunTi5mUcm/QhNE4eke7yzRevkd52uGsuUDqf3s=; b=I3
 VnJ2ajxisP3V9PJqOFEbFc9so8F6B/kCTsT4bqVIRWUvh1dwsN/Ub1PD7er/kOCb
 tz9rfmaeTbj/B5APsG0sES/u1uOJzIeUFgrKKo59xD+vkfQWGRWONMcDyy7teFp7
 3fuLPcjraRyRcI+0kzf0zWfyNjPg0XvBhr0NKaKzMq2YM+JCErr2DTe318qfC3xJ
 U0j0Fnsg1jmckPwI6RyFEoignmuPgkpa+szKVfOq12XKpRtG0Ls8Ak+uF4t8WY30
 Rl03/4AcGWxDAARSQjRp+19t7zl4aCMdQYdrB+zFSOIXScpxc41ve53KVTqNbUXw
 Jlocpn4IMS8qq4NV34OA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx2c4d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so234143a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461791; x=1789066591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y/MYSunTi5mUcm/QhNE4eke7yzRevkd52uGsuUDqf3s=;
 b=GWG1oP00mMXAiaEQcuA7DtZOJ/ssD42vWoTif/9mtbi47pFUjvYuGoy86eJbyyYDS+
 zK+jLCfVmRXHvxRtbXP+vxzLQGgeQLfGtWVAzVv9P8LUzqxwNDb++V6/ATP7yLoxXsJi
 VwufVOR33HQIQwSabQyeK/4Uralf9eLuqrq61Z2EPfbslV0qiinrNXfS5X4VUAGHQPMC
 Pmu3ty/iwRfOimnnTy7+j1zOxmK5R283OtixSxu1DceqiZnJLbAej2LfcevwGtH4GF6Y
 iQcGW1f6bjYlE7CQ8RtGMVnHwt8Sl8iI7ZCUxlGDpffa168QjyKGdPf5SLZnaEkf6MRZ
 2NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461791; x=1789066591;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y/MYSunTi5mUcm/QhNE4eke7yzRevkd52uGsuUDqf3s=;
 b=qblKMqosWEqcZVO6RXIVOeFj7ameVfYg10PMBoftCi0Utm9XKPhrXr+iLX6Vg2X8l5
 kLax9rn/Y0XPWaCQtC8z/nNEoh63ANOBAR02OMyDE5xYMx2yfONLrih1nT4ujR1Ff6Rc
 sMLzzuJ81T6sBAFFXu/AIwFkDe/L7VEmOhkshvNYCv+Tea3CD2lW/tIQaerrUV7/0i9j
 ZX/P5cMaUNFQ9QDtFk8YE6HNh4jYUMatkgNP9fIbXfbkHNk6b6edpmIp+ksBJCzeCOUj
 3lUD1aZ8uwPedl9MPYAs1xuP8Mg+KeSRL6OfrvOGclUOdzmRcOXDMd3JZAME3zWHJ0YB
 Xg+g==
X-Gm-Message-State: AFuF++lfDQLwkL/G/TfteAOJORmCs1XkD9mLdtzc+h/w1ynjU7E6m5NN
 7A1OqJ9Bfqal3dX4YWGwjm9jQfkiJYe9jymWtVUe8BJYtFekw7CTDech56r6z3jB6JnqGiMMePa
 L6QrTkBZtUHDQgWKaj6ehHWFHxhWnJ0zSK8+l4WRja8ABMUl4/yVMUTrka11iHk+udw==
X-Gm-Gg: AYBFou0Ga3gdwQ9pZfmr60zg1js0LlH1tc3jgmF4i3RtpZ2YxYR+r3TWJYEslYroHFd
 r/IoMhcOL+XzjlC2+QLQI7zUoRYDCiktjO9GIYBdvHe/7S+sYTpGo1lvh/2nX5/wUkHkShb8ajT
 hh8Qb386JbPhSJw0u+KXCb5DO94v2fS8RbrvCt3Ooz7fV6qz558gj07aDyHbiNtmEdkDVaY+RKY
 owM3XgNSLC8hNACeZDQX08Ovh5Q0u/1yOeNyUlrd7E+BSfK9DKfA0XyM/RNiuh9Wqvea4YPpjsC
 NPpEesDunmPRQ44IsXJ9jLy3QHaAKwU7THgpnCUqFA8iSGAvY7J313dzACFLxKgIC/RlWEgZYeJ
 36SR4vGVZ2fB8+/Xq1ql1Vb5wPKNVsoZoXW64VeVFakWbwldr
X-Received: by 2002:a17:90b:538c:b0:398:9beb:a2b4 with SMTP id
 98e67ed59e1d1-39b087992ddmr9142959a91.22.1788461791116; 
 Thu, 03 Sep 2026 11:56:31 -0700 (PDT)
X-Received: by 2002:a17:90b:538c:b0:398:9beb:a2b4 with SMTP id
 98e67ed59e1d1-39b087992ddmr9142923a91.22.1788461790656; 
 Thu, 03 Sep 2026 11:56:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/8] hw/intc: name the L2VIC edge trigger check
Date: Thu,  3 Sep 2026 11:56:18 -0700
Message-Id: <20260903185622.3234171-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: o-6uwNaIZ22JC5cB5Dy2yOd4Kw8UkibK
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99c2e0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-YUP4bkCidU9H1Stq4YA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: o-6uwNaIZ22JC5cB5Dy2yOd4Kw8UkibK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfXwcNALiHi2GYB
 sYEKLQ6X4sR5ufUD1Bigp/G80D4TAnvKolPNyim/VHEArzhYdxTS9kT8GsYQkiNRM2FCnS6a+9P
 aG/tu3VQAbouHJd0ugaISXc7bHduWmxLskxyPvMYIvr51LyPsLDhKcRshU5+4MEXYIx9Sua+tI9
 ZMAQXeq03pj1YuEuvwx0KYUiycKqKRHkgawPALDJ7FnJqSZiiq3aD3wGfvdXH55vz/6yc6VLXe/
 /2YLVTHRaZ+UwkaOPFuwhX0Souzo4Gk4K7ShE8EkqCo3Gfg7qXkNfYdYgSeJMNUOK2w5M5R9x3B
 gsg8GeDZ7rs1+oWLfrp78k7VpyD/Ay5cmgnj6LrnY2TBc1fLampAl/EyNTMzqE2K7mlbj63B0q7
 1gNuIvVLqSWknsXt42mAluPptLl9IaOci36u403SjMlYX6rQKcF8uvb8khW/Ts3kUCv3vD2D6O4
 qaxBTIW3k9zBbL+Ajmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX2R2moBX2OtQ2
 ouqTLVkpU/N8lUkr4CEA26vpNCMfeyMqDgteVeR+EmQbdF2XeJwZKWlsAjcCZ9BYNNiy/DIK3Hj
 f51igY+1x2hL++uZd/OsFMwAfgjPKmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165
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

TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9jM2YyZjRlMi03OWU5LTRi
M2YtOGJhZS04OGM2NjlhMzRjMGJAb3NzLnF1YWxjb21tLmNvbS8KU3VnZ2VzdGVkLWJ5OiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9pbnRj
L2hleC1sMnZpYy5jIHwgMTMgKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9pbnRjL2hleC1sMnZpYy5j
IGIvaHcvaW50Yy9oZXgtbDJ2aWMuYwppbmRleCBhOTg2ZjBiZGYzNS4uNzM2ZjFiZTNiMWQgMTAw
NjQ0Ci0tLSBhL2h3L2ludGMvaGV4LWwydmljLmMKKysrIGIvaHcvaW50Yy9oZXgtbDJ2aWMuYwpA
QCAtOTIsNyArOTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhMMlZJQ1N0YXRlIHsKICAgICBERUNM
QVJFX0JJVE1BUDMyKGludF9wZW5kaW5nLCBMMlZJQ19JTlRFUlJVUFRfTUFYKTsKICAgICAvKiBX
aGljaCBlbmFibGVkIGludGVycnVwdCBpcyBhY3RpdmUgKi8KICAgICBERUNMQVJFX0JJVE1BUDMy
KGludF9zdGF0dXMsIEwyVklDX0lOVEVSUlVQVF9NQVgpOwotICAgIC8qIEVkZ2Ugb3IgTGV2ZWwg
aW50ZXJydXB0ICovCisgICAgLyogMSBmb3IgZWRnZS10cmlnZ2VyZWQsIDAgZm9yIGxldmVsLXRy
aWdnZXJlZCAqLwogICAgIERFQ0xBUkVfQklUTUFQMzIoaW50X3R5cGUsIEwyVklDX0lOVEVSUlVQ
VF9NQVgpOwogICAgIERFQ0xBUkVfQklUTUFQMzIoaW50X2dyb3VwX25bNF0sIEwyVklDX0lOVEVS
UlVQVF9NQVgpOwogICAgIHFlbXVfaXJxIGlycVs4XTsKQEAgLTI0OSw2ICsyNDksMTEgQEAgc3Rh
dGljIGlubGluZSBib29sIHZpZF9hY3RpdmUoSGV4TDJWSUNTdGF0ZSAqcykKICAgICByZXR1cm4g
YWN0aXZlX2lycSAhPSBzaXplOwogfQogCitzdGF0aWMgYm9vbCBlZGdlX3RyaWdnZXJlZF9pcnEo
SGV4TDJWSUNTdGF0ZSAqcywgaW50IGlycSkKK3sKKyAgICByZXR1cm4gdGVzdF9iaXQzMihpcnEs
IHMtPmludF90eXBlKTsKK30KKwogc3RhdGljIGJvb2wgbDJ2aWNfdXBkYXRlKEhleEwyVklDU3Rh
dGUgKnMsIGludCBpcnEpCiB7CiAgICAgYm9vbCBwZW5kaW5nOwpAQCAtMjcwLDcgKzI3NSw3IEBA
IHN0YXRpYyBib29sIGwydmljX3VwZGF0ZShIZXhMMlZJQ1N0YXRlICpzLCBpbnQgaXJxKQogICAg
ICAgICAgKiBlbmFibGUgYml0IHNldCBhY3Jvc3MgZGVsaXZlcmllcyAtLSB0aGUgZmlybXdhcmUg
ZW5hYmxlcyBvbmNlCiAgICAgICAgICAqIGFuZCBleHBlY3RzIHRoZSBpbnRlcnJ1cHQgdG8gcmVt
YWluIGVuYWJsZWQuCiAgICAgICAgICAqLwotICAgICAgICBpZiAodGVzdF9iaXQzMihpcnEsIHMt
PmludF90eXBlKSkgeworICAgICAgICBpZiAoZWRnZV90cmlnZ2VyZWRfaXJxKHMsIGlycSkpIHsK
ICAgICAgICAgICAgIGNsZWFyX2JpdDMyKGlycSwgcy0+aW50X2VuYWJsZSk7CiAgICAgICAgIH0K
ICAgICAgICAgcy0+dmlkID0gaXJxOwpAQCAtMjk5LDcgKzMwNCw3IEBAIHN0YXRpYyB2b2lkIGwy
dmljX3NldF9pcnEodm9pZCAqb3BhcXVlLCBpbnQgaXJxLCBpbnQgbGV2ZWwpCiAKICAgICBpZiAo
bGV2ZWwpIHsKICAgICAgICAgc2V0X2JpdDMyKGlycSwgcy0+aW50X3BlbmRpbmcpOwotICAgIH0g
ZWxzZSBpZiAoIXRlc3RfYml0MzIoaXJxLCBzLT5pbnRfdHlwZSkpIHsKKyAgICB9IGVsc2UgaWYg
KCFlZGdlX3RyaWdnZXJlZF9pcnEocywgaXJxKSkgewogICAgICAgICBjbGVhcl9iaXQzMihpcnEs
IHMtPmludF9wZW5kaW5nKTsKICAgICB9CiAgICAgbDJ2aWNfdXBkYXRlKHMsIGlycSk7CkBAIC0z
MjgsNyArMzMzLDcgQEAgc3RhdGljIHZvaWQgbDJ2aWNfd3JpdGUodm9pZCAqb3BhcXVlLCBod2Fk
ZHIgb2Zmc2V0LCB1aW50NjRfdCB2YWwsCiAgICAgICAgIHdoaWxlICgoYml0ID0gY3R6MzIoYml0
cykpIDwgMzIpIHsKICAgICAgICAgICAgIGludCBpcnEgPSBiYXNlX2lycSArIGJpdDsKIAotICAg
ICAgICAgICAgaWYgKHRlc3RfYml0MzIoaXJxLCBzLT5pbnRfdHlwZSkpIHsKKyAgICAgICAgICAg
IGlmIChlZGdlX3RyaWdnZXJlZF9pcnEocywgaXJxKSkgewogICAgICAgICAgICAgICAgIHNldF9i
aXQzMihpcnEsIHMtPmludF9wZW5kaW5nKTsKICAgICAgICAgICAgIH0KICAgICAgICAgICAgIGJp
dHMgJj0gfigxdSA8PCBiaXQpOwotLSAKMi4zNC4xCgo=

