Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A313CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CT-00069G-IA; Fri, 29 May 2026 17:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CL-0005mx-U8
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CK-0000Vu-4X
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIdmDH203287
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+acMbo/C4i2O//kllAUg/Ia3Ltqbfkk1HizCSwYn1c=; b=htK/fRp+CtFSCtg/
 jSOpJVw2m1eJoK1rWh8Zw+fys9uzzYoGPAAhEpHTbc7NEdE5CXpW4/7b8s8NCWze
 m0/1yCI2TmlYF3g68nC9kUJ2R7c0DJTi9dzbnWzn7yhMFRX5B7xMNIqN3QNZf6zX
 470GkFQewpKpzvoOKQZK4VHCmplooiA+TgcME/0YFE3ljVSWdCjROXN51wWn269y
 GLX8iIrfmDCfb9ST9XaafFTaFeRBAc0LeACKWhCl743h/uE8Ko+yxQSU/IC2NCGH
 QGZRNaaAfQTNFQCspdCV76vLY5cT1TE74k/ZuP+3IAwWAUJI7BflQD7Wsae8tkJ5
 wbfOLg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9c8r08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f1820babso1364363eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091804; x=1780696604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+acMbo/C4i2O//kllAUg/Ia3Ltqbfkk1HizCSwYn1c=;
 b=ZtpYuKXqBni71rmNEEYNBkqCVkxgB5co5hD2VieV15t5i8e3rEmbQLmm63Y61cxg1R
 cb6zxINcAFNtS8X/xJVrC+oTE2JlSlyZnaHCdL/joBDsYLwIuVtRXhm/EOx4Dw3p4mKf
 p5CSKeC1ZInRL2lJGQTUgqKiPZrAhM1bhnKqORmvi21rnhW2m6lcD3eWiZo/+UOChq8g
 AwnUJPJW/cwdVF5cwNU93yqdVAg8UVo1QHsAKIJWo7Ppwqs3kdUReT2pGDsaQY+tbWwo
 cyFAeLc/K6tEK6YObCTyClGtHc9q5Z230uK8eozBLdyqU8n51RAmFbwOriwHRYRwe1Wy
 NPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091804; x=1780696604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4+acMbo/C4i2O//kllAUg/Ia3Ltqbfkk1HizCSwYn1c=;
 b=Odu31SaXFdN36V0rOUSibBjHkAw/dZsQ8oBaYJtZ68GlvrXSKNbXoonLDcEIkf0sQr
 5MLp5IJYPrBv5JwKVEmrWP43wRZWoSPFFqufmGSckoIIAJjt37ZO3p9tcRDkYHmBzOZj
 9Xc+tWoI4mhUtyLUsaC1szBpMFn6t5eCCe9niYtD3lMULzf36gQhv5NNqnZ+kdbGd5GC
 ZfMxPui8jXbpWJ0XjrDAQmNMsKYo8w6RrVtE7QsEkOwA+j4lm9tXrHY9l57GvzI35q01
 cEKkoWicQDrxYy+1PyCTc94+/oO4phXHFuo4pZDdUTJu3+bLTgvi9h6sqECqS0PcxFKP
 PZzw==
X-Gm-Message-State: AOJu0YzDUdAsnTg/g0oQHTEpccoFtURmvqzTyQluGNWLCswgFF4kwWfi
 43oS5BXpQ/ScYRnZoiTkPzLYEvKdfsiauD1m+uWJnC8yKtUBG6RtY8CANREMaJCV0JS18FI6gVc
 6w5x4IGUPPWDQocRjrhG0fzoWEHmdL5j5KVW/MQrWr5pIJYc52Uvhjjl9iMzexlV2aQ==
X-Gm-Gg: Acq92OEzfBuAxf/njjOHme9VjeG8YLP0DaVTIdTizciE4Co3v4o1kUHHf/bkgWYI7Rl
 o9vzXkBzb0MyW5B30q4/AlomUQ4dGvhP3RzVqmqZgvIzDpoHEZVCDTd8r0V5zZcOhtiNzy8Wl97
 HJHADnLCE11rfKTY/3uEq7aS17uvh330VOYDytMYPp1mlh/P6pkXJ4f2dAjIPzTF2NoBCCY8MzO
 IkioQ6IgIJ2ryRn9/TYjUbtNNATMTNnHNm/7q2e9acXGvvW1nkB4VcZjys03lA19UR0dk33kVZa
 Fl3Z8ORKLadQIWHyNOxyvKBgo9O7aKvswTpAM76eNtEMv02sBmbOrrZj9ydQK9eifGb1QyJ+UE7
 fM5YBCbAv7I9ivBoe5pstj7RJ9jRNy0qnbaMk+G9XGnvh9SLSrVLgUzmRSgggpwYjd7gy4ODsRE
 k8/V6x
X-Received: by 2002:a05:7301:5f12:b0:2f4:3a9c:819c with SMTP id
 5a478bee46e88-304fa65bcebmr664753eec.25.1780091804095; 
 Fri, 29 May 2026 14:56:44 -0700 (PDT)
X-Received: by 2002:a05:7301:5f12:b0:2f4:3a9c:819c with SMTP id
 5a478bee46e88-304fa65bcebmr664746eec.25.1780091803503; 
 Fri, 29 May 2026 14:56:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 27/38] target/hexagon: Add TCG overrides for thread ctl
Date: Fri, 29 May 2026 14:55:43 -0700
Message-Id: <20260529215554.606133-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX9+IfX9KiCU49
 UvMRsA+W3uZ9GjFsvJh6rAvrh3ajve1Dhr7eQ9DUlVBtqToIVGs30rY7IH3c7wG1eqOErrclulv
 6wrq3VIaPINrGTilFiQJU2FyEqq7pxNITeCUPXg1XH9efN46QQndZxiWAWvGe2JmUWtI2xKBTon
 AIVQTvbVD2XlU8+WXQynrZf49ZC03gJ9Dux8kHpPetwxeQvLhN4s6I8nFrO+8VFFNZ9MPZXirma
 9j3u8YfmpZKLlZ+lggXEpWgOlSFe499y5NPeb7aOGW3XnoKCm2HaVIrzmtK6o0HJMKMSCEcmmYO
 MU0pNmnyCPHTdz2+Q2p4XmzpmvWTPtXtS3vAPOQRUKI1fCvcgyJFcRF6oZKKiXn+w5J+h+qpUZ/
 zovhItpZGyF7IonPQihn/L2Q/9uYw7ILziQCsSor1+g4NBB5YyCkFP9OOO6DrmQ4Q+V5w4bULCL
 eR4fDMoVtoSAIzzAUKQ==
X-Proofpoint-ORIG-GUID: Tcq4QPRyi4phGSxTf9juQDjAlk8M9bMF
X-Proofpoint-GUID: Tcq4QPRyi4phGSxTf9juQDjAlk8M9bMF
X-Authority-Analysis: v=2.4 cv=SKxykuvH c=1 sm=1 tr=0 ts=6a1a0b9d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgoKUmV2aWV3ZWQt
Ynk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMTggKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaCAgICAgIHwgIDQgKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
ICB8IDIwICsrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCA0Y2JiZGQxZjcwYi4uODY1MGY2NGE2ZDQgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19zeXMuaApAQCAtNzcsNCArNzcsMjIgQEAKICAgICAgICAgfSBcCiAgICAgfSB3
aGlsZSAoMCkKIAorI2RlZmluZSBmR0VOX1RDR19ZMl93YWl0KFNIT1JUQ09ERSkgXAorICAgIGRv
IHsgXAorICAgICAgICBSc1YgPSBSc1Y7IFwKKyAgICAgICAgZ2VuX2hlbHBlcl93YWl0KHRjZ19l
bnYsIHRjZ19jb25zdGFudF90bChjdHgtPnBrdC0+cGMpKTsgXAorICAgIH0gd2hpbGUgKDApCisK
KyNkZWZpbmUgZkdFTl9UQ0dfWTJfcmVzdW1lKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJf
cmVzdW1lKHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZMl9zdGFydChTSE9SVENP
REUpIFwKKyAgICBnZW5faGVscGVyX3N0YXJ0KHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VO
X1RDR19ZMl9zdG9wKFNIT1JUQ09ERSkgXAorICAgIGRvIHsgXAorICAgICAgICBSc1YgPSBSc1Y7
IFwKKyAgICAgICAgZ2VuX2hlbHBlcl9zdG9wKHRjZ19lbnYpOyBcCisgICAgfSB3aGlsZSAoMCkK
KwogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2hlbHBlci5oCmluZGV4IDk1NTI4NzEzM2U0Li42ODJmMGM2YzI2ZSAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgK
QEAgLTEyMyw0ICsxMjMsOCBAQCBERUZfSEVMUEVSXzIoZ3JlZ19yZWFkLCBpMzIsIGVudiwgaTMy
KQogREVGX0hFTFBFUl8yKGdyZWdfcmVhZF9wYWlyLCBpNjQsIGVudiwgaTMyKQogREVGX0hFTFBF
Ul8zKHNyZWdfd3JpdGVfbWFza2VkLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8z
KHNldHByaW8sIHZvaWQsIGVudiwgaTMyLCBpMzIpCitERUZfSEVMUEVSXzIoc3RhcnQsIHZvaWQs
IGVudiwgaTMyKQorREVGX0hFTFBFUl8xKHN0b3AsIHZvaWQsIGVudikKK0RFRl9IRUxQRVJfMih3
YWl0LCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihyZXN1bWUsIHZvaWQsIGVudiwgaTMy
KQogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IGVlMjgyZTY2ZTg2Li5kYTAwZGZkNjVjMyAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMKQEAgLTE0MTksNiArMTQxOSwyNiBAQCB1aW50MzJfdCBIRUxQRVIoaWFzc2ln
bnIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiAgICAgZ19hc3NlcnRfbm90
X3JlYWNoZWQoKTsKIH0KIAordm9pZCBIRUxQRVIoc3RhcnQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBpbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2
b2lkIEhFTFBFUihzdG9wKShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdGFyZ2V0X3Vsb25nIFBDKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisK
K3ZvaWQgSEVMUEVSKHJlc3VtZSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2sp
Cit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwogdWludDMyX3QgSEVMUEVSKGdl
dGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGlkKQogewogICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7Ci0tIAoyLjM0LjEKCg==

