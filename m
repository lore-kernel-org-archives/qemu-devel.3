Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318C3C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3do-0002xF-KJ; Mon, 29 Jun 2026 00:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dN-0002fe-FJ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dH-0000oE-5X
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NI6A1737533
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=; b=HvvpOVQprC+gWZPl
 u08RwB9iLH60HIwADcwsoAfyL8KrNC0woxN9kuk8rIraGYNMk66sgxtUQVW4v/yQ
 5RFd+//+yfvSiNc6K/FlozmSFZG4OAUVQx4TTmsO8x4REl2JAzJ6BFL8EjxqZIYN
 eM8GdT1XdbY2YRZmpF33RJlTPaxkH5aNcEvO15R4jxu2u1ar6iC7GQ86kPS7WlDT
 Tz0bBqW/V9eJKjTYIHf6ghgx+k+2QuvsbvkyULDin5PSzMyeaF4XgeajyeIv58Zi
 IBMS1ITspmQW9oRmQ10BeMqrubmN1POHEAnvh/VFVyaZg63EZQ0DmHwjoir6g3RU
 AcFZsg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cmbbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:05 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so6739444eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707405; x=1783312205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=ZFnEcbmL72cBe7GHKWxbvm5iiS0eHKSEk7ZmJAiawgDU7LMq4jCY4CO+MD4sEQ3Ljq
 6NrsK+VAw6uRN8v9qP1X/6kN0m3u3BDH2uPzIBBdEkqYt0suHXLFm7vPlNtLI4nift+m
 ynp20g4BAhszE4K3MVxD8jMOy0XTwYmaPehc+b7mVa/BBRn1uKQjCdWtu2vc1RG5rsl/
 FnObwdNoufcAB9wn5DMLX46KeBRaivWM44E7JnVy3SpTvfPyeDskTb9uDgcsRSdAsnNz
 WbO1LkxwT35K82vEgt/+nEdrXyYTjzpUDuA2CQpKsaGfRRrbku+3EkhB0qc1WnEkOHi5
 VvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707405; x=1783312205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=D9VXSrnELdhiTbE1etDDi7remM+SmwEgMYMxWgopQeVumSasYFVtg45B+oR4txOdMV
 ZE+qDZg9vzJAnMS8hMK9VRuF0oghgAIETj/QzAo3uHgwOFXuGnPKJPAPV1/4vfUZMBYD
 6Aq0WTmS6jVNSQy0dAiYtO5laUm2h/i6NB1VbRtYYh7y52Wa5G8g1vbhLGIP2iBvqk3n
 y1+WJffq1vH8+ospzMtjoIJYL5yK6rzFcI8WHBUhOnc52BOkoYa8smPVR4SI6u1i7ki9
 2JwDD56gUdnayO5Hzgh1skurmuW2VUYDWsoYrTyKMt/7BoHcdqfvQp3ipTfLuzYF0D16
 HGRg==
X-Gm-Message-State: AOJu0Yx4ucLTIPyJowv06ixNhKFsRwNCYdTD/igylH/ZQKDZCwmnv5B8
 s1GHpoMFzJnk0EZnagYOGxyPm9nTGrwKekqBwSQbyOaKvZ7/9WrSQwq7p+cWC1QShYD2uBHw2pd
 fx++03ZaPudJwymhxjcersd1S2+RrjmiCzp4ZICUlPssJ1XxKVwXFZWcDQpzPL8+qLQ==
X-Gm-Gg: AfdE7cm2biuIywpcNsNtbODBI6TqblTJqcAe6RLTcIMorpdo68JS7JaZP/8FspDkLY2
 vReRAvAHYNBuCs6SsGQdfOHBnwYigUTT1APmfAcLaZVjOrfi6v9R/pJZ1QOCZmF+BvW7ZZeTaQX
 a5Q35CsjEerzKcc80LFR57CUzmvqVyY5gF35NhGHI79syn4ewfcQxHOkdVTKc6UG200OQukWzlK
 XoxKaaTsivwxtgKIzcc9Oh3kRvMlry9FCF3NExK0WHGkhjtL/8URrAj/WdYIYA1ZW1/Ow6JmPZv
 nWc/sgXzU2cBO74UjPeYeu0zaWL5gv8usBMb/xiwLVX0zKCVxCrD7ES51udyNB5w/5JS3EbaFHr
 8Ir/3zP8HM0EhGrPgR1l3efeHTIUwOTB6kk4cplVT797qvDiKeo+FPexavSk=
X-Received: by 2002:a05:7300:df41:b0:30c:ab4d:3835 with SMTP id
 5a478bee46e88-30cab4d3bb2mr7880018eec.44.1782707404683; 
 Sun, 28 Jun 2026 21:30:04 -0700 (PDT)
X-Received: by 2002:a05:7300:df41:b0:30c:ab4d:3835 with SMTP id
 5a478bee46e88-30cab4d3bb2mr7879997eec.44.1782707404186; 
 Sun, 28 Jun 2026 21:30:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 58/77] target/hexagon: Decode trap1, rte as COF
Date: Sun, 28 Jun 2026 20:58:11 -0700
Message-Id: <20260629035830.1520296-59-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a41f4cd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX5ec94RSye3Qv
 hlIAGaE/2VPVovWJQUdFTnxY85vtuLnyliDOdt1oZ61gqU0FhMBeSK3ZuYhp6Ta1LN4IOUT29yL
 zOnjKGolWCnQZd27xqlfBEi5y2QsC0w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX/MKzYImeHXVM
 S9RNQShf0dnuhb+TrN3vBXe0evfYfKJFvySmG/kx1Pph3018yJmCd+/oeAkTbAxACsaEnAuy6Z5
 NxJhQb9BhBlA6AOZHM3aGb/zstaMAOhsedHBuf6gsZJd56zQgBMYbDr/4Ez0Ypgq5lw1yfTqe0d
 UPo858Wi0ifHCjB5gyA7iR5LeTWqoBO06mEqeH+PgoRjLiBm7gnQ14P6CVk0FDl1RLiNYchV3vX
 XIYnpc7daF3QZo2mH5P8xpC2Kq6g22vAlwBGeyH9H6tn6IgMCski4MQ86DkyhpHe8Mj74KVGNUp
 BQxltfwg/UyGoZGbxBujirCgztP0EK0cVvWZ7e3GIspg/HRiKvCPzX0Bfcu5Du0sDxN2O2crrHw
 fsiIvizqElTcKHi8dpFFdkp9v6UZOfUBa46MlAJZ1GKsVTw0emq89GZVtCwVZY7g8iWDbdYJIw+
 UXGvD7WCblKkqct+4YA==
X-Proofpoint-GUID: qLfbdxH2UcUc--3AvpdTZ0ndb0C3G_0h
X-Proofpoint-ORIG-GUID: qLfbdxH2UcUc--3AvpdTZ0ndb0C3G_0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

