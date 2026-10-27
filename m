Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FF0o/9Xt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vbmaubzn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtw-0004SC-ND; Mon, 26 Oct 2026 23:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtn-00043N-Sx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtl-0000DL-Uh
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:55 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F3Z13521358
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=; b=FF0o/9XtqlyqH7Bo
 7FfbtN9sQBYpwsKid81Y17C1wezC3x6bOjR1aMhycd3kPNcmomus0QzCMgOuXp/p
 n6bR3cCenuHqpRFySLUAWGrfgKlaOUIkadsz1eTmmYRrnBktkzKIaVIXBzLkXH1f
 trqjrlepcaraLtDptHS/QRFvZ5Ip5NAcWgaKjffw1NpK9Y1j8bMqmLw3fgEl8Cv/
 mOCkHKd2Qbdm1b54o8Rv7tLzDT2o944ohBEtW/oNBGnDlsbvbOqrVVLFsmjGCwHb
 uomYEnpwTeCnxS1RQxWaOZ+o8POHabQTBZmQJjHRHB4hNQSHfCLk4YS0ZMoQuVHg
 TZLwCA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54huvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:48 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so1331509c88.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071847; x=1793676647; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=;
 b=Vbmaubzn+nDI+EyFHLKEkpx5ybX/fvsd0kZJ9A5iKfq6IPwUfpG35b+hjpcqdXj29v
 E3jcZ2Xoc3c1tDWBYBbBGmeaNw1jtld5ouYQMRQAQjVjdHS9pZGJo10O3Gp5XuYEfjid
 OiWIyiF19n76UeMdPUcmXuJckho2ZOvyEqvUT32c6stD/ZdjjyMO58ufXFEmxbTwctF3
 2yWUuW1DxQ+jFOqvK0Mztf+kkvg5oNPcOMm9a2sxGciDb8cFbeeb3FXU/ypfFjM8W6pb
 WsIsrRFWFGN8HyIqclw+HREU3UchL9MvBoNi8VdSu47mAcoqc+/ukjXcM9A4xt4tCO0y
 iF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071847; x=1793676647;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=;
 b=dOFj5tuEKpZV/LXNg3VbnwmL4/bVobD4tmMfcUlhfN//UVTNIMLgcxACmRebo0Z4dA
 C6CJoAVEj9AZ4pg6Bv7LUac7lEQ9Oo7k5uQGQRM5qV1KEYfYjVGyBpIPfOKg9BfB0lmM
 3TLhbTIDNWvkaZwdGiI6CnqzWpZXsQSNLgfxwbO4HUK0svVCKCUzXIVym5/RVnIvlRni
 +uelCtCu5eD0/8pPK08b8jbcHk0zMr0Q/kYliZgB/iqPo42AtwX8YSVjpszoprPtSyZc
 bRbs7FiQLIGuQ99W2blXAJ5UmxkBwZWoZb48+kTbKVjJ8p0uROR9ScL9X5bR/V4zYiQS
 wc2g==
X-Gm-Message-State: AFq9FYK5N133KXu5xaV2COyfgaIHjk35phbSXXVm1D/Ly9XLJrm+1hf+
 2YTsAP8Murr3xyhw0NypWJQmIU7X8zGRIhzIThm/+l4YZBtRtViqOqHSH4Qs2nTegrpNjDN8+Wy
 0cFbZpPmVedaD5sTofR5HtIqoXy3UfgF9T5YKawl4akVMBX16DyBPBommjsx7yZ3YIw==
X-Gm-Gg: AYBFou1+fDCwSSzgQhLAF5dgTQdP0s67qZUIhRpNHhjtYU6df18FmFI/Ly1E38x1bdG
 qCUO1F+hH7mqsm3/2yN2oiDepDoQziDqefiApVvTvZzDkSD0pdQWAsUbHzSKl9Jbv7uP9rzKx/0
 4LisYjHIqHcBCWjFe0jnpbBgSE1lhT5HLK/2evOgdA9k27nTCxdsQX+SzOvZC6DEyTvZYmj/ISY
 Yq49y1OcCcAZrqhtXMIZ/Lmu3Vi3V8Ijx5/EZFYoKqQGvOO5gUILukLqvcZqczjJPdeZpJ5UxGF
 a8ARNB4D3cSryKC3oaRc15IXhSxVJVsBjjwuwX9dsH8g0NZdIWbq3ZlU9VyztKhijl9NXRSxZWp
 vQWcpFDtxjRRmO0okEe6G0IKA2YyEq4HDTJYSMg4iBFFljS4=
X-Received: by 2002:a05:7022:108:b0:190:5edf:b405 with SMTP id
 a92af1059eb24-19936a5e7ecmr17482169c88.14.1793071847456; 
 Mon, 26 Oct 2026 20:30:47 -0700 (PDT)
X-Received: by 2002:a05:7022:108:b0:190:5edf:b405 with SMTP id
 a92af1059eb24-19936a5e7ecmr17482122c88.14.1793071846828; 
 Mon, 26 Oct 2026 20:30:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 35/41] hw/intc: ciad should forward its mask to l2vic
Date: Mon, 26 Oct 2026 20:29:21 -0700
Message-Id: <20261027032927.3055166-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX+J4HXStTJhk7
 nI32zcSTGUNUcH5vC8wvctGjoOWQfCK68iwWjt8h2bYdMY/IYNHmqbK4UHD30/eMF9wFL1qmH5n
 96BgM8K48Jgv9f+FJnWtiLFJlv7QZSU=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae01ae8 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=zi4VUfZ7aQnuQJZsh1MA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: yiLqovkDHUMhpZ4LMwHwzfP03zGvix0b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX7382dapxHzIf
 rtjTdxZIHdEx2JgfwiWWHYCdHmAE4UUuMbDPREHaMPfy5PA/JaF3KgdBSZ3Is2rlOLxQb64M6uh
 L78J+kGUaLvhhLWDDJaKMnAYeqBWXTh39ywNPRTTJeZBnSG4qYdxojMrUskb7EF6wVu7F/NT0P+
 dU08dr3f5eGQG8UYm75xwdttLrNhA4MxR2huqtSQJ1sj6eVL50YsFPE1jUxXgmEKsQHPrelhLvG
 EuIjbH6NYdcCuz1OOGHIT3S8UvnRb+JCA+b2D4U8K/XAzIjOIrKG50ch2Ab+SneSb6HlBU1H5wz
 Ot8qrrhmR9zQ+jDBwtPV+KT/vYDupz9RBvtTtReOTDnDv5pV2pcPAFgR6uoR+MZoHUY+bSi8qxS
 5yub1eo/XBO50zXQsBtyMxd51J/D6r7mTUA7oyx0W7dSjLlshB4a/x+7xlJ35mdn1MiPcnbOgfw
 pQpplBxFtzQHK52yRWg==
X-Proofpoint-GUID: yiLqovkDHUMhpZ4LMwHwzfP03zGvix0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Y2lhZCBjbGVhcmVkIHRoZSBsYXN0IGludGVycnVwdCB0aGUgTDJWSUMgZGVsaXZlcmVkIHJlZ2Fy
ZGxlc3Mgb2YgaXRzCm1hc2suICBTbyBhIGNpYWQgZm9yIGFueSBvdGhlciBpbnRlcnJ1cHQgd291
bGQgZ2V0IGFwcGxpZWQgaW5jb3JyZWN0bHkuCgpPbmx5IGNsZWFyIHRoZSBhY3RpdmUgaW50ZXJy
dXB0IHdoZW4gdGhlIGNpYWQgYWNrbm93bGVkZ2VzIHRoZSBDUFUKaW50ZXJydXB0IHRoYXQgaXRz
IFZJRCBncm91cCBpcyBkZWxpdmVyZWQgb24sIGFuZCBvbmx5IGlmIHRoYXQgaW50ZXJydXB0Cndh
cyB0YWtlbiBvciBzZXQgd2l0aCBzaWFkLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaW50Yy9o
ZXgtbDJ2aWMuaCB8IDE0ICsrKysrKysrKystLS0tCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAg
ICAgfCAxMCArKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgfCAxNCArKysr
KysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmggYi9pbmNsdWRl
L2h3L2ludGMvaGV4LWwydmljLmgKaW5kZXggZWRjMjc4MjY2Y2IuLmFlMDY3ZmU5NWViIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmgKKysrIGIvaW5jbHVkZS9ody9pbnRj
L2hleC1sMnZpYy5oCkBAIC0zMSw4ICszMSwxMyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzIHsKICAgICB2b2lkICgqdXBkYXRlX3ZpZCkoSGV4TDJWaWNJbnRlcmZhY2Ug
KmwydmljLCB1aW50MzJfdCBncm91cCwKICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHZhbHVlKTsKIAotICAgIC8qIENsZWFyIGludGVycnVwdCB1c2luZyBDSUFEIGluc3RydWN0aW9u
ICovCi0gICAgdm9pZCAoKmNsZWFyX2ludGVycnVwdCkoSGV4TDJWaWNJbnRlcmZhY2UgKmwydmlj
KTsKKyAgICAvKgorICAgICAqIENsZWFyIGludGVycnVwdHMgdXNpbmcgdGhlIENJQUQgaW5zdHJ1
Y3Rpb24uCisgICAgICogQG1hc2sgdGhlIENQVSBpbnRlcnJ1cHRzIHRoYXQgdGhlIENJQUQgYWNr
bm93bGVkZ2VkLiAgVGhlIGludGVycnVwdCBpcworICAgICAqIG9ubHkgY2xlYXJlZCBpZiBAbWFz
ayBoYXMgdGhlIENQVSBpbnRlcnJ1cHQgdGhhdCBpdHMgVklEIGdyb3VwIGlzCisgICAgICogZGVs
aXZlcmVkIG9uLgorICAgICAqLworICAgIHZvaWQgKCpjbGVhcl9pbnRlcnJ1cHQpKEhleEwyVmlj
SW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgbWFzayk7CiB9IEhleEwyVmljSW50ZXJmYWNlQ2xh
c3M7CiAKIERFQ0xBUkVfT0JKX0NIRUNLRVJTKEhleEwyVmljSW50ZXJmYWNlLCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzLApAQCAtNTIsMTAgKzU3LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMnZp
Y191cGRhdGVfdmlkKEhleEwyVmljSW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgZ3JvdXAsCiAg
ICAgay0+dXBkYXRlX3ZpZChsMnZpYywgZ3JvdXAsIHZhbHVlKTsKIH0KIAotc3RhdGljIGlubGlu
ZSB2b2lkIGwydmljX2NsZWFyX2ludGVycnVwdChIZXhMMlZpY0ludGVyZmFjZSAqbDJ2aWMpCitz
dGF0aWMgaW5saW5lIHZvaWQgbDJ2aWNfY2xlYXJfaW50ZXJydXB0KEhleEwyVmljSW50ZXJmYWNl
ICpsMnZpYywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgbWFzaykKIHsKICAgICBIZXhMMlZpY0ludGVyZmFjZUNsYXNzICprID0gSEVYX0wyVklDX0lO
VEVSRkFDRV9HRVRfQ0xBU1MobDJ2aWMpOwotICAgIGstPmNsZWFyX2ludGVycnVwdChsMnZpYyk7
CisgICAgay0+Y2xlYXJfaW50ZXJydXB0KGwydmljLCBtYXNrKTsKIH0KIAogI2VuZGlmIC8qIEhX
X0lOVENfSEVYX0wyVklDX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9o
dy9pbnRjL2hleC1sMnZpYy5jCmluZGV4IDczNmYxYmUzYjFkLi5iNzNlY2I4MjFlNCAxMDA2NDQK
LS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYworKysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC00
NDgsMTIgKzQ0OCwxNiBAQCBzdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfdXBkYXRlX3ZpZF9p
bXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKICAgICBsMnZpY191cGRhdGVfYWxsKHMpOwog
fQogCi1zdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfY2xlYXJfaW50ZXJydXB0X2ltcGwoSGV4
TDJWaWNJbnRlcmZhY2UgKmlmYWNlKQorc3RhdGljIHZvaWQgbDJ2aWNfaW50ZXJmYWNlX2NsZWFy
X2ludGVycnVwdF9pbXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBtYXNrKQogewogICAg
IEhleEwyVklDU3RhdGUgKnMgPSBIRVhfTDJWSUMoaWZhY2UpOworICAgIGNvbnN0IHVpbnQzMl90
IHNpemUgPSBMMlZJQ19JTlRFUlJVUFRfTUFYOworICAgIGNvbnN0IHVpbnQzMl90IGFjdGl2ZV9p
cnEgPSBmaW5kX2ZpcnN0X2JpdDMyKHMtPmludF9zdGF0dXMsIHNpemUpOwogCi0gICAgaWYgKHMt
PnZpZCA8IEwyVklDX0lOVEVSUlVQVF9NQVgpIHsKLSAgICAgICAgY2xlYXJfYml0MzIocy0+dmlk
LCBzLT5pbnRfc3RhdHVzKTsKKyAgICAvKiBWSUQgZ3JvdXAgbiBpcyBkZWxpdmVyZWQgb24gQ1BV
IGludGVycnVwdCBuICsgMiAqLworICAgIGlmIChhY3RpdmVfaXJxICE9IHNpemUgJiYgKG1hc2sg
JiBCSVQoZ2V0X3ZpZChzLCBhY3RpdmVfaXJxKSArIDIpKSkgeworICAgICAgICBjbGVhcl9iaXQz
MihhY3RpdmVfaXJxLCBzLT5pbnRfc3RhdHVzKTsKICAgICB9CiAgICAgbDJ2aWNfdXBkYXRlX2Fs
bChzKTsKIH0KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggNzY5ZjU2ZTI0MjIuLjgyYzBjNmExNWYxIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTY4NiwyNiArMTY4NiwzMCBAQCB2b2lkIEhFTFBFUihyYWlzZV9zdGFj
a19vdmVyZmxvdykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsCiB2b2lkIEhF
TFBFUihjaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKICAgICB1
aW50MzJfdCBpYWQ7CisgICAgdWludDMyX3Qgd2FzX3NldDsKICAgICBIZXhhZ29uQ1BVICpjcHU7
CiAKICAgICBCUUxfTE9DS19HVUFSRCgpOwogICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7CiAg
ICAgaWYgKGNwdS0+Y2ZnLmhleF9kZWYtPmhleF92ZXJzaW9uID49IEhFWF9WRVJfVjgxKSB7CiAg
ICAgICAgIGlhZCA9IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhf
U1JFR19JQUQsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJl
YWRJZCkgJiB+bWFzazsKLSAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5nbG9i
YWxyZWdzLCBIRVhfU1JFR19JQUQsIGlhZCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgd2FzX3NldCA9IGlhZCAmIG1hc2s7Cisg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SUFELCBpYWQgJiB+bWFzaywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50
aHJlYWRJZCk7CiAgICAgfSBlbHNlIHsKICAgICAgICAgdWludDMyX3QgaXBlbmRhZCA9CiAgICAg
ICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCk7CiAKLSAgICAgICAgZlNFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCwKLSAgICAgICAg
ICAgICAgICAgICBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFEKSAmIH5tYXNrKTsKKyAg
ICAgICAgaWFkID0gZkdFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCk7CisgICAgICAgIHdh
c19zZXQgPSBpYWQgJiBtYXNrOworICAgICAgICBmU0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURf
SUFELCBpYWQgJiB+bWFzayk7CiAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+
Z2xvYmFscmVncywgSEVYX1NSRUdfSVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaXBlbmRhZCwgZW52LT50aHJlYWRJZCk7CiAgICAgfQotICAgIGwydmljX2NsZWFyX2lu
dGVycnVwdChjcHUtPmwydmljKTsKKyAgICAvKiBPbmx5IGFuIGludGVycnVwdCB0aGF0IHdhcyB0
YWtlbiwgb3Igc2V0IHdpdGggc2lhZCwgY2FuIGJlIGNsZWFyZWQgKi8KKyAgICBsMnZpY19jbGVh
cl9pbnRlcnJ1cHQoY3B1LT5sMnZpYywgd2FzX3NldCk7CiAgICAgaGV4X2ludGVycnVwdF91cGRh
dGUoZW52KTsKIH0KIAotLSAKMi4zNC4xCgo=

