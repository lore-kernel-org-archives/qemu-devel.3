Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC028CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZLO-00087g-Mv; Sun, 04 Oct 2026 23:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZLN-00085L-J4
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:26:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZLL-0000on-F0
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:26:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510B1J787341
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 03:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=; b=OsKAEwHpAdR9JBwR
 bocUN/+/Qi4fL9bOxVHqPyfhp3476Qatc6yMpRYg/b4x9E0LH7mqSPNMzIPlDGYN
 LRCPdz/j/WHRZ3EyroRz2N7PHeR3R060rYwLN9OnXGJvHqw8Ra6j7LkpXQpCjeDl
 YyNfbSZqlH4CtzXdPow6KxVkR/sjCD8E3lkaM6+yVb/XZ9emcTfF0VzKpK10qN7I
 KUQAxKCJkrLhAqrj591tCz6dm1gOjTA17swjEbU0UZivA+sKgoZvxbUIonUlKSdU
 AGFXXjt3Hndd1WXYSvnwsopZ44fDzVEv+EKzvjgMFnIQuFUrgaJKIwh/pMxhNiPD
 qzUzcQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa4bjx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:26:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34ef0362d95so2758198eec.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 20:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791170781; x=1791775581; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=;
 b=F0aevZ2fBo5kcl0mhwVPj3n7jvbB/IgWDWr99yaMPOMtIt3Xg9zD153Pye6udpo/po
 d3KIwCK1ig55Ei66Pm94Y3l9O1c8kETJPBv7I2LW9OhY/TbYywkIvgXZ7u9UA09DLVPq
 Oi5/2uchUMLROF2XNqjKTkhOjqpR0vPnwuYd9TgR65phq7Xg5lTEYYO8EDTL6ZSZEJUR
 V+jjY3VhaCHx6fvJiFL7UGaduHAXde9n2m3gPqQFoGMhWevYF8SdXgtD65cEdStYGl1Z
 mQ9BFDrYems54ccoCIPMZzu0aiFoE7cUO6sNa+86YFmVGm3vOsW2ztupRlITiRVEVwSM
 bGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791170781; x=1791775581;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=;
 b=x+2+KWr/bKc/b4TyW2CsbHjcRfIJzlrzqllKp+cYmpG9YnUXWHOfErOsNg+EqjMC6m
 XFddpp6nTDTx+OFJjm53CsA5BO/ECp79aP3Nv/54iTU/vNsReem3ALoai9iVjbolV5gJ
 cqrfk1mUhGpCWLqg3T/oMgZ7PPJJcERUmRozlC+GPEiXZKvYq6AtycyDaETtyU8bjjKZ
 XYzVhq09xit4OrIUo0WeBt5oE1p4F3TKzEge2ZuybpLInmTggfaR+6iCFULiB5Aux1H0
 3OfCDKqulXSY2LihbOIneGZMl6Vj5pBxApuWvjNqTifaun5NK21U1XITeXG/Pptpg4hG
 CKrA==
X-Gm-Message-State: AFuF++mgeMpVKTxACpk/gbyxAu4IdXt0mlEtpInEGITyiHvfp5e1tpHF
 AMel4e/aIj6mHdFfVA1s6rDWrRWlfx1K75w4vFw4SlRZelI3TPuJx/hpzZuJf05oB2di3w+ew7G
 6t4mxLJxuZ2X6pkdFh+kpsdHty7DS63AuWkGBpyyC9Tg4FAE5UOxIX1oK4O2nbzvncQ==
X-Gm-Gg: AYBFou2UqwrTitRqAT1guOVn4Fs6ryxkRMnYCguCyuE8sCTSPekr/y5Ydh/VzIiSa8E
 xN1h+gQrYs6OufolcWPhppzLlSO1FQ1un+CWoYgxqCajFk1VM7IhASYphqO3U7OGwqEMjTAj5O4
 bNSBXL1pDaotvKHzudt4k32C4BZ3u5LAHgZ1SdZ08ZlMFymBAvXfgaEyDtXhGQrH9FaO6qiUjbS
 VOK6cehZiQkYBz/BgO6TKuUueqOPcYxOkp7ahZ/GQnz+jCz9tORIiXrjDqdWuoPRkYorYrwH3CP
 bbwkXqNBaDvVhJY7Sn6/FkiK9t9IXEBc6Zo/yOCfyELi2thNLIHioV1pmPNpKjWNwlj8/LVBqTE
 2/cnMrhUvuI8Q7jrNMFT/x0oLk715M9FEu0XpXh0wnrXpjBM=
X-Received: by 2002:a05:701b:270b:b0:14f:5cd:f286 with SMTP id
 a92af1059eb24-151c3aa3963mr10102634c88.34.1791170781055; 
 Sun, 04 Oct 2026 20:26:21 -0700 (PDT)
X-Received: by 2002:a05:701b:270b:b0:14f:5cd:f286 with SMTP id
 a92af1059eb24-151c3aa3963mr10102606c88.34.1791170780476; 
 Sun, 04 Oct 2026 20:26:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fcd83fadsm18596255c88.11.2026.10.04.20.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:26:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, richard.henderson@linaro.org,
 Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PATCH v2 02/10] tests/tcg/hexagon: Cover HVX vector write conflicts
Date: Sun,  4 Oct 2026 20:26:08 -0700
Message-Id: <20261005032616.1293829-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
References: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfX3orVDLNCZ+2r
 /ekZJrNPUOG/ahsKNqauoIro04Tm2Lsdn4sI7LEgpbuu8OhOLiL4/6s8idCgXj5s5kFSHN13clC
 +Rv6+pLO1YjFJ2oIm1lwPgfD1v8IW67WHzLQ35Lb2eF9Yb3ucW8W3sGdAHAt6cOcs/ltbBCdSOv
 LAVf0DduCifG2GAtDzN3vmZsCleEaVw5jhk1dGQAAM+03za/yxjdyB75tyibxqMqiV/eOgGUC6q
 wV2HscrW9t/gM0h/pCDMsNETU0BNKg7/7V3O8KrWUsER/74n0kntQzBCqFUK2wc+7Z387yzsZJd
 m2YRS/gSEQnYjZXn9OZT1hQL3ZeE6Lw5UD/K+BEu4qDQpEQeY0a4U38oITymF/8QCABbW9L0btb
 8qsVMV3ibeTWZ5DCLRKr+6tsCmi70c5toTGaIpKLs82X3DDDJn5jwBAHaDIt6A5/VSE/vMVU0L2
 fDBI104V0hVFAQYv8VA==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac318de cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LU5tE7T4vROUmwdGADEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: YMD4nuXy5HSVd6gfyVPlRxVM9enmsKBj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfX/cr4k5/sH7Wg
 8jqrwRXEfcf9eTj5x96t4AJiP1z/1dNuWZWKILBZpiwzRoWgw8BUYn1hlZZktigpfHrAestz01w
 ZfIX0vXwI1OosG3froFhrIb+FjKGAcc=
X-Proofpoint-GUID: YMD4nuXy5HSVd6gfyVPlRxVM9enmsKBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050013
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

Q2M6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5
OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNn
L2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMgfCAxMDcgKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL211bHRpcGxlLXdyaXRlcy5jIGIvdGVzdHMv
dGNnL2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMKaW5kZXggYmQyYjEzODRkZDkuLjljYTVhZGY3
NmFkIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYworKysg
Yi90ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYwpAQCAtMTMsNiArMTMsNyBAQAog
CiAjaW5jbHVkZSA8YXNzZXJ0Lmg+CiAjaW5jbHVkZSA8c2lnbmFsLmg+CisjaW5jbHVkZSA8c3Rk
aW50Lmg+CiAjaW5jbHVkZSA8c3RkaW8uaD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KICNpbmNsdWRl
IDxzdHJpbmcuaD4KQEAgLTIyMyw2ICsyMjQsODMgQEAgc3RhdGljIGludCB0ZXN0X3ZyZWdfbGVn
YWxfcHJlZGljYXRlZCh2b2lkKQogICAgIHJldHVybiBzaWc7CiB9CiAKKy8qCisgKiBDb21wbGVt
ZW50YXJ5IHByZWRpY2F0ZWQgd3JpdGVzIHRvIHRoZSBzYW1lIFYtcmVnaXN0ZXIgcGFpciBhcmUg
bGVnYWwuCisgKiB2MTYgYW5kIHYyMiBhcmUgc3BsYXR0ZWQgd2l0aCBkaXN0aW5jdCBwYXR0ZXJu
czsgc2luY2UgcDAgaXMgYWx3YXlzCisgKiB0cnVlLCB2MTQgbXVzdCBlbmQgdXAgaG9sZGluZyB2
MTYncyBwYXR0ZXJuLiAgRXh0cmFjdGluZyBhIHdvcmQgZnJvbQorICogdjE0IGNvbmZpcm1zIHRo
ZSBleGVjdXRlZCBicmFuY2ggYWN0dWFsbHkgcmFuLCByYXRoZXIgdGhhbiBtZXJlbHkgdGhhdAor
ICogbm8gU0lHSUxMIHdhcyByYWlzZWQuCisgKi8KK3N0YXRpYyBpbnQgdGVzdF92cmVnX3BhaXJf
bGVnYWxfcHJlZGljYXRlZCh2b2lkKQoreworICAgIGludCBzaWc7CisgICAgdWludDMyX3QgcmVz
dWx0OworCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAicjAgPSAjMFxuIgorICAgICAgICAi
cjEgPSAjIzFmXG4iCisgICAgICAgICJtZW13KCVbcmVzdW1lX3BjXSkgPSByMVxuIgorICAgICAg
ICAicjQgPSAjMHgxMTExMTExMVxuIgorICAgICAgICAicjUgPSAjMHgyMjIyMjIyMlxuIgorICAg
ICAgICAidjE2ID0gdnNwbGF0KHI0KVxuIgorICAgICAgICAidjIyID0gdnNwbGF0KHI1KVxuIgor
ICAgICAgICAicjQgPSAjMFxuIgorICAgICAgICAicDAgPSBjbXAuZXEocjAsIHIwKVxuIgorICAg
ICAgICAie1xuIgorICAgICAgICAiICAgIGlmIChwMCkgdjE1OjE0ID0gdmNvbWJpbmUodjIyLCB2
MTYpXG4iCisgICAgICAgICIgICAgaWYgKCFwMCkgdjE1OjE0ID0gdmNvbWJpbmUodjE2LCB2MjIp
XG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIlW3Jlc3VsdF0gPSB2ZXh0cmFjdCh2MTQsIHI0
KVxuIgorICAgICAgICAiMTpcbiIKKyAgICAgICAgIiVbc2lnXSA9IHIwXG4iCisgICAgICAgIDog
W3NpZ10gIj1yIihzaWcpLCBbcmVzdWx0XSAiPXIiKHJlc3VsdCkKKyAgICAgICAgOiBbcmVzdW1l
X3BjXSAiciIoJnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAicjQiLCAicjUiLCAi
cDAiLAorICAgICAgICAgICJ2MTQiLCAidjE1IiwgInYxNiIsICJ2MjIiLCAibWVtb3J5Iik7CisK
KyAgICByZXR1cm4gc2lnID09IFNJR0lMTCA/IFNJR0lMTCA6IHJlc3VsdDsKK30KKworLyoKKyAq
IEEgZnV0dXJlIHdyaXRlIG1heSBjb25zdW1lIGEgdGVtcG9yYXJ5IHZhbHVlIGZyb20gdGhlIHNh
bWUgVi1yZWdpc3Rlci4KKyAqIGJ1ZiBpcyB6ZXJvZWQgd2hpbGUgdjAgaXMgaW5pdGlhbGl6ZWQg
bm9uLXplcm8sIHNvIHYwLnRtcCBsb2FkcyBhbGwtemVybworICogYW5kIHYwLncgPSB2YWRkKHYw
LnRtcC53LCAxKSBtdXN0IGVuZCB1cCBhcyAxIGluIGV2ZXJ5IHdvcmQuICBFeHRyYWN0aW5nCisg
KiBhIHdvcmQgZnJvbSB0aGUgcmVzdWx0CisgKiBjb25maXJtcyB0aGUgYWRkIGFjdHVhbGx5IHVz
ZWQgdGhlIGxvYWRlZCAudG1wIHZhbHVlLCByYXRoZXIgdGhhbgorICogbWVyZWx5IHRoYXQgbm8g
U0lHSUxMIHdhcyByYWlzZWQuCisgKi8KK3N0YXRpYyBpbnQgdGVzdF92cmVnX2xlZ2FsX3RtcCh2
b2lkKQoreworICAgIGxvbmcgbG9uZyBidWZbMTZdIF9fYXR0cmlidXRlX18oKGFsaWduZWQoMTI4
KSkpOworICAgIGludCBzaWc7CisgICAgdWludDMyX3QgcmVzdWx0OworCisgICAgbWVtc2V0KGJ1
ZiwgMCwgc2l6ZW9mKGJ1ZikpOworCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAicjAgPSAj
MFxuIgorICAgICAgICAicjEgPSAjIzFmXG4iCisgICAgICAgICJtZW13KCVbcmVzdW1lX3BjXSkg
PSByMVxuIgorICAgICAgICAicjIgPSAlW2J1Zl1cbiIKKyAgICAgICAgInIzID0gIzFcbiIKKyAg
ICAgICAgInI0ID0gIzBcbiIKKyAgICAgICAgInI1ID0gIzJcbiIKKyAgICAgICAgInYwID0gdnNw
bGF0KHI1KVxuIgorICAgICAgICAidjEgPSB2c3BsYXQocjMpXG4iCisgICAgICAgICJ7XG4iCisg
ICAgICAgICIgICAgdjAudG1wID0gdm1lbShyMiArICMwKVxuIgorICAgICAgICAiICAgIHYwLncg
PSB2YWRkKHYwLncsIHYxLncpXG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIlW3Jlc3VsdF0g
PSB2ZXh0cmFjdCh2MCwgcjQpXG4iCisgICAgICAgICIxOlxuIgorICAgICAgICAiJVtzaWddID0g
cjBcbiIKKyAgICAgICAgOiBbc2lnXSAiPXIiKHNpZyksIFtyZXN1bHRdICI9ciIocmVzdWx0KQor
ICAgICAgICA6IFtyZXN1bWVfcGNdICJyIigmcmVzdW1lX3BjKSwgW2J1Zl0gInIiKGJ1ZikKKyAg
ICAgICAgOiAicjAiLCAicjEiLCAicjIiLCAicjMiLCAicjQiLCAicjUiLCAidjAiLCAidjEiLCAi
bWVtb3J5Iik7CisKKyAgICByZXR1cm4gc2lnID09IFNJR0lMTCA/IFNJR0lMTCA6IHJlc3VsdDsK
K30KKwogc3RhdGljIGludCB0ZXN0X3ZyZWdfaWxsZWdhbF9taXhlZCh2b2lkKQogewogICAgIGlu
dCBzaWc7CkBAIC0yNDIsNiArMzIwLDI2IEBAIHN0YXRpYyBpbnQgdGVzdF92cmVnX2lsbGVnYWxf
bWl4ZWQodm9pZCkKICAgICByZXR1cm4gc2lnOwogfQogCisvKiBBIHBhaXIgd3JpdGUgYW5kIGEg
c2luZ2xlIHdyaXRlIHRvIGVpdGhlciBwYWlyIG1lbWJlciBhcmUgaWxsZWdhbC4gKi8KK3N0YXRp
YyBpbnQgdGVzdF92cmVnX2lsbGVnYWxfcGFpcl9vdmVybGFwKHZvaWQpCit7CisgICAgaW50IHNp
ZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIx
ID0gIyMxZlxuIgorICAgICAgICAibWVtdyglW3Jlc3VtZV9wY10pID0gcjFcbiIKKyAgICAgICAg
Ii53b3JkIDB4MWY1MDU1ZWUgICAgLyogeyB2MTU6MTQgPSB2Y29tYmluZSh2MjEsIHYxNikgKi9c
biIKKyAgICAgICAgIi53b3JkIDB4MWUwM2U1ZWUgICAgLyogICB2MTQgPSB2NSB9ICovXG4iCisg
ICAgICAgICIxOlxuIgorICAgICAgICAiJVtzaWddID0gcjBcbiIKKyAgICAgICAgOiBbc2lnXSAi
PXIiKHNpZykKKyAgICAgICAgOiBbcmVzdW1lX3BjXSAiciIoJnJlc3VtZV9wYykKKyAgICAgICAg
OiAicjAiLCAicjEiLCAibWVtb3J5Iik7CisKKyAgICByZXR1cm4gc2lnOworfQorCiBzdGF0aWMg
aW50IHRlc3RfdnJlZ19pbGxlZ2FsX3VuY29uZCh2b2lkKQogewogICAgIGludCBzaWc7CkBAIC0z
MDgsMTAgKzQwNiwxMyBAQCBpbnQgbWFpbigpCiAgICAgYXNzZXJ0KHRlc3RfcG9zdF9pbmNyZW1l
bnQzKCkgPT0gU0lHSUxMKTsKIAogICAgIGFzc2VydCh0ZXN0X3ZyZWdfbGVnYWxfcHJlZGljYXRl
ZCgpID09IDIzKTsKLSAgICBhc3NlcnQodGVzdF92cmVnX2lsbGVnYWxfbWl4ZWQoKSA9PSBTSUdJ
TEwpOwotICAgIGFzc2VydCh0ZXN0X3ZyZWdfaWxsZWdhbF91bmNvbmQoKSA9PSBTSUdJTEwpOwor
ICAgIGFzc2VydCh0ZXN0X3ZyZWdfcGFpcl9sZWdhbF9wcmVkaWNhdGVkKCkgPT0gMHgxMTExMTEx
MSk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19sZWdhbF90bXAoKSA9PSAxKTsKKyAgICBhc3NlcnQo
dGVzdF92cmVnX2lsbGVnYWxfbWl4ZWQoKSA9PSAwKTsKKyAgICBhc3NlcnQodGVzdF92cmVnX2ls
bGVnYWxfcGFpcl9vdmVybGFwKCkgPT0gMCk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19pbGxlZ2Fs
X3VuY29uZCgpID09IDApOwogCi0gICAgYXNzZXJ0KHRlc3RfcXJlZ19pbGxlZ2FsKCkgPT0gU0lH
SUxMKTsKKyAgICBhc3NlcnQodGVzdF9xcmVnX2lsbGVnYWwoKSA9PSAwKTsKIAogICAgIHB1dHMo
IlBBU1MiKTsKICAgICByZXR1cm4gRVhJVF9TVUNDRVNTOwotLSAKMi4zNC4xCgo=

