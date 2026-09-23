Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630D4C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9P0U-0003Rs-C7; Wed, 23 Sep 2026 11:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9P0N-0003Qu-Nn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:35:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9P0K-0007nf-NQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:35:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NDKfp3322172
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Oi4bCaFs3KNwyQBkJ7GPKB+4MbctQ2MgVFUD9DxJ36g=; b=VJwVWJ3OXnFfP/zB
 IFvH8zo2dwyM8YAg+ltYSswTFL1lqfJ4mzRf2XoH90QvpG/1xCodCK35jvzyEHSB
 NwKfcI9Uo5Toz3WYxsq+0R/nahemxzq5OOASkmBWd9awJ4k3GDNmPT37ZM6kCQaG
 nJ5fi22sZM/KtfC/Vr453O5wCD5DzyhFdQxWfxiHNq3c+r4Y2UiwmdDo6NAn5OuC
 woEkACHeyOntnvOOCJ18vANRFGYu/tRrcYzMp1VjqjnC+4WAbmM/RJXXBgqk7bip
 j2vILaTbTnP8bPr3XaZHsBCkqigfPXzQTENQdbRPXwfb05GqcS0orviZhWB0QF9t
 PjFy5Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjsgmdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:35:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-86a59faf521so918922b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790177723; x=1790782523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oi4bCaFs3KNwyQBkJ7GPKB+4MbctQ2MgVFUD9DxJ36g=;
 b=KYnfQusOl4/i2/ugdF/v/1zfzomOrGZnZNi+9hLh+bS4niyEvBi2Ca2YsEi4mJ4ykq
 cgLIVG2tU/tiZRU8ZasW3qlD+cVHEs6WcrTE70oOQ8zmXisO8m0nDCsPoNTeCm8gKh/K
 HA0mc7unr5DySDx8B9ijZIoFBjvjzPB6U1RuKpqOcjIPTrEbqh0VBZXv+DVgDrFlSBRW
 Lw4SxlNExnyofDD2H66aEOELxgx0FuasNpRcvLLCrKoSO0BldVjorEBh362ywhAWU8NB
 CB4PluzZ+Rf5QBk3QomCVydIcOy5r9aON3SYx1bxFhmbycIlqyUZ0SipCPlAAQIinfuU
 X1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177723; x=1790782523;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oi4bCaFs3KNwyQBkJ7GPKB+4MbctQ2MgVFUD9DxJ36g=;
 b=fr/CGbfYdxjAYtUW8LpMt9k3U860I4+LSU6EFsu7tlCKx4iE0KLRyi/ah80hKt64gs
 DubHtETeIxffL+t5/gzfJgTIeqdSFay+0aRYjUFKdzOlYgGcgG0H1pgiVSeoM4bvDtA+
 i7XFBHiu9DTaIRx2M4auRAcfIlqoCxoVF4IXzdX3Xd3uC93hDTMOeDXGpZcmdn8T8Q7J
 d4zAWLunZEOY8hjG8GgVrHryQc34dPCZ9yLRF3/HNdmIRJ/WrGXUakZwmBKqYjk46+x9
 cHUb8ZBSy8NJGpNu2nvjA+Nu0nlVY2FFphmQk+c7MNuIZWYT3Ix1xlkiauE/uUliqu1g
 26Yg==
X-Gm-Message-State: AFuF++k+4tbmhsm7ESPgjCzB2uC0yYCkz+Lf12E4z0VgmwQmbkXJyPXE
 HubkbHB77AsrKK7/NcMpGBKa84cV/4JUB22Tyb/DM4UDqUBiZd+r33J6K/FeWzFPUwpGm/GSYv8
 kOi6EL5pFQ/EdEDSeBiaadWvvg75gV7dY45dO5P3q70omm90mLozF1DxOTbkIvTdYSA==
X-Gm-Gg: AYBFou2+pbadPUq6LW9rQ08f5X/zuM8jKgdOR1d0SBDY0Q3zG7T1FxiurlCzqUVkWaw
 ENI6I5zjQw5+x7l8Oc10Mb4eoL2MdfBeN+qlpBdGnjmuAI47DC2snWZNSVzyb9/PNxsHWRe2byg
 q1qP0zKor11MkKBBD1P5rylRsYhWSS4pFvGMWHGq0K9tesxf/i6u6rxMPEQc2fmRhQRdDE96SOe
 Pp6YzLyD1OKcq5YkA4CkianJKisHbVabMmDYAddTf6BXjLEwSTvUplacDmlsG8xsSg3BeKRlWAP
 UhYeCelDu2vBQrtB5Zuu8Oblqm4pE+umW+rTzzUPx6pOZTqFCWSQPIhfUgjrO9zhbYJXyoxsVR4
 29JE2371BMJzGgeo0opS0WlAMV4Xmcl8njNulf0IVEtQ7h1U=
X-Received: by 2002:a05:6a00:1911:b0:878:1aee:fa43 with SMTP id
 d2e1a72fcca58-87d1b2b072fmr2579278b3a.33.1790177722943; 
 Wed, 23 Sep 2026 08:35:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:1911:b0:878:1aee:fa43 with SMTP id
 d2e1a72fcca58-87d1b2b072fmr2579250b3a.33.1790177722339; 
 Wed, 23 Sep 2026 08:35:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1e601b5dsm1516072b3a.61.2026.09.23.08.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:35:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org
Subject: [PATCH v3 2/4] target/hexagon: fix semihosting STAT filename handling
Date: Wed, 23 Sep 2026 08:35:14 -0700
Message-Id: <20260923153516.3615007-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
References: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfXwFZqssZPC9TS
 j2X0CVrToVp8R0lD6F4RjlARss6GoCJWxXLaQdOmP6AHkedXC18Gp1yWg1jtypSHuFE5tbpzN3G
 nfdgtisLe7HDv/x7UGel7Jr26vn2bgrrz5QSzmdgnMRmrB6zqZxY5+F25wh2eA496jRoXVC9hES
 jVpHIwlbMD64ZNI5M6vncdcjokrgb99iCafDRha+gXuS3Fr19sh1/y+RJ21nbt/HQ4rsZSZkiCs
 PSlTGopjMdAv8sFTHFGj8f3U4zichKwTqwKao3R/yCqeAUt5KzjSkj874m1wGSJYXSorcvxRyS8
 B5uQzdvOuXATjSZkATvBJdGzl68p2v+rnQ4nib1n/uz+s+uNj2rxhu8/NeNT8Cui6f23+t1GC8D
 a3lvbkJI7LIZwxYj5HIFuSF46KR0ZnkbOD5MrWiXaKvGi+Cvz+QjsierKtrM/Pz9ghy57RQtt2/
 kIi3t9yxSHWjqkJqGmA==
X-Proofpoint-GUID: EufqhgSDgnko_lbSRe5DNM6apWNcF9Qn
X-Proofpoint-ORIG-GUID: EufqhgSDgnko_lbSRe5DNM6apWNcF9Qn
X-Authority-Analysis: v=2.4 cv=K4+3jCWI c=1 sm=1 tr=0 ts=6ab3f1bb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=FZZFJ5KotruyPtQxbZcA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfX8MRaCX4X1YCa
 /6O/+wSga75J27/ba4ael5LZbvaNoex2kt8CZ7/s3xJSH3mYmNRY5FW6FW9Qr8BzRDfr1KrxIV1
 9opBKcdBQNTTOeABgHxMTUdZuibUWDs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230062
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

SEVYX1NZU19TVEFUIGNvdWxkIHBhc3MgYW4gdW50ZXJtaW5hdGVkIGxvY2FsIGZpbGVuYW1lIGJ1
ZmZlciB0byBzdGF0KCkKd2hlbiB0aGUgZ3Vlc3Qgc3RyaW5nIGZpbGxlZCBpdC4gVXNlIGxvY2tf
dXNlcl9zdHJpbmcoKSB0byBtYXAgdGhlIGd1ZXN0CnN0cmluZyBzYWZlbHkuCgpGaXhlczogNzcx
MWZkYmE4OGIgKCJ0YXJnZXQvaGV4YWdvbjogYWRkIG1haW4gYXJjaC1zcGVjaWZpYyBzZW1paG9z
dGluZyBvcGVyYXRpb25zIikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBRkVB
Y0E5TU9zNlZmSGYyVUhaOHo0Y2R2YUIrN0RZNmhKYjJlbVlaMmFMU2UtdDZpd0BtYWlsLmdtYWls
LmNvbS8KU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+ClJldmlld2VkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyB8IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IDZh
NGM0MjkxNGUxLi45ZTg4NTM0NGE3MyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTU2NCw3ICs1NjQsNyBAQCBzdGF0
aWMgdm9pZCBzaW1faGFuZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICBz
dHJ1Y3Qgc3RhdCBzdF9idWY7CiAgICAgICAgIHVpbnQ4X3QgKnN0X2J1ZnB0ciA9ICh1aW50OF90
ICopJnN5c19zdGF0OwogICAgICAgICBpbnQgcmMsIGVyciA9IDA7Ci0gICAgICAgIGNoYXIgZmls
ZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAgIHRhcmdldF91
bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB0YXJnZXRfdWxvbmcgc3RhdEJ1
ZmZlckFkZHI7CiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIocGh5c2ljYWxfZmlsZW5hbWVfYWRk
ciwgc3dpX2luZm8pIHx8CkBAIC01NzMsMTUgKzU3MywxNCBAQCBzdGF0aWMgdm9pZCBzaW1faGFu
ZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICB9CiAKICAgICAgICAgaWYg
KHdoYXRfc3dpID09IEhFWF9TWVNfU1RBVCkgewotICAgICAgICAgICAgaW50IGkgPSAwOwotICAg
ICAgICAgICAgZG8gewotICAgICAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtp
XSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAgICAgICAgICAgICAgICAgIGdv
dG8gZG9fZmF1bHQ7Ci0gICAgICAgICAgICAgICAgfQotICAgICAgICAgICAgICAgIGkrKzsKLSAg
ICAgICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiBmaWxlbmFtZVtpIC0gMV0pOworICAg
ICAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXJfc3RyaW5nKHBoeXNpY2FsX2ZpbGVuYW1lX2Fk
ZHIpOworICAgICAgICAgICAgaWYgKCFmaWxlbmFtZSkgeworICAgICAgICAgICAgICAgIHNlbWlf
Y2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAg
fQogICAgICAgICAgICAgcmMgPSBzdGF0KGZpbGVuYW1lLCAmc3RfYnVmKTsKICAgICAgICAgICAg
IGVyciA9IGVycm5vOworICAgICAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5hbWUsIHBoeXNpY2Fs
X2ZpbGVuYW1lX2FkZHIsIDApOwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgaW50IGZk
ID0gcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAgICAgIEd1ZXN0RkQgKmdmID0gZ2V0
X2d1ZXN0ZmQoZmQpOwotLSAKMi4zNC4xCgo=

