Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B2606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gStsLixE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KAR2puS3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXun-0006Uu-9T; Mon, 26 Oct 2026 23:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtp-00048M-FH
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtn-0000Da-CO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2EuYA1908806
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=; b=gS
 tsLixEue0qIhezIHHJcFigiW7AKLAw6NXld530PHPF6bVaD9fOxymGvQu4o5xw09
 1SbG2PQJFMGRb4hG4iVMjWQzir36BnnAa6s1WgHtN924dEe4GBeBKI3yXHs9mTOb
 McR2NusxsMp85Fq23ZDOrnyp+VaN5VJykDnwE0JdKLEk7+tLYmsFwAAQOmh8naG1
 tBRSQMWcCch3Gj0RevzZCiOJtL/6hhCyNV9kv2BPz0Zob+W+YgM1UisWIv44P6Lj
 Gmr06mzi9b62QwT9cskhZvueXIkE0TWnUqmeg48+lGwTN52Wf6R8YW4veg16Fv2B
 OqBpSSZTTzwyewc5kFvA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3d941p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-19dbbe4b1d8so1973339c88.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071852; x=1793676652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=;
 b=KAR2puS3q5swAx9BP5UqzbswQT0cY7HWB5Rlgno7Fb+H93naG2U1VccjktLw7+QlHj
 9gB/skYorFhhSwcv5I4YRhvuOEAr8UfXM3wtL5+fj1T0hANexgslPjPczMY/eMM65SVq
 rm9lYTvVlnsbSjGiOGTEJPo7AuBlZcrZU30HwI19K5BCOlOPvI9H2D0awH4IySvqYUun
 Tpr6s0K27zeGqf1kBgNFtgJQACz79cPeeN24DyUjLMlh7tF3mJ6N43HW3glWilHXcKfD
 ks8w6ZVwhLpEESlzN6lA/clukRi/LIzomYBj8XoB2+cH2hmcPj2xteyUHgXg9eq+Hg38
 4MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071852; x=1793676652;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=;
 b=vcal/+K2CHDkoKFFYavx4ChOftu4nAuZ/zesgTIts+UYeroJfEcTPgJUfiNl6IE9eu
 raAFYU7OSY5NOCe+xdcjH9WzNUS0Jl/4TJ35+zbMqXssNNa9fVX7keVKwzPP1cf2P5i5
 MbTgqmwismD4D6nn2PGNXImPQVJC5AExzbVsqJ91iadsXvdOvxy2JEE4lY3cuA7lPx4p
 60nkhMnbIAVS9aJYtf7aTwRkJk3kJoAszzIwENlyrOM37jY9uz7UpdlJ54Vtopn66RKt
 xxOixfDBESFXU22TfrS3KAMWc8yNhYFwAZ0cP1ZerLSp/yVQoMG7CXh8WBTFfwwzrbr+
 ABeQ==
X-Gm-Message-State: AFq9FYJEEs5hH96M0pZ5wPxfxh+vKI/LXBbQcrcae8oo4tw7bDGbWcJa
 aBnsngFhWWjNaf8mxTZ/bw/lC/ELiexMhs1jvbVshfE/udJsWW0JqZRRHxa4KOo7aVy9bhxB8UQ
 RVmElsaVneI2UptZuo6nFpaPZhKCYbh8ANtu2gz6IjfftWT7jpEpHFlMQuul7bh1Uyg==
X-Gm-Gg: AYBFou1bDqVWKuNk8IOptKrP/Ip5Hr6O3n8+UfkJrBX7LXEbUp4ajPGS0rYp7omwY9r
 RPHI2hQR44YyYhoxD/lfm5rRcdJepBly3Q6hb69mebkrgw5nGKOxLyW+Ts/8i/hbRTsKwEdVjYv
 Ghg0Mfc/ae2YNfGPv295M2LvhFJzIGmjaLJudZRv276lb5GiRjZJGMSrVYz/l7GZg1roC0w9MQa
 F53tH4ewjuz+2VaIpVizydIdi/1EByYxOK6o6G+V8nekspf7gOpFYTJxvUwEXgEQBiEXW0yoA4z
 Dnzirx/ZZANSRRLtDY4zzmhJOWR3y+RriX/J3vZoZxZmeA0UkxUnt1bOP7zk303Q+EBrF8oIn3I
 J34htKhXUpQZ6fqdn3hyXfnhfFEvb6b7+cVcyX6O7qBz7vw0=
X-Received: by 2002:a05:701b:2086:20b0:1a2:fa1d:1de5 with SMTP id
 a92af1059eb24-1a2fa1d1e29mr3401244c88.20.1793071852270; 
 Mon, 26 Oct 2026 20:30:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2086:20b0:1a2:fa1d:1de5 with SMTP id
 a92af1059eb24-1a2fa1d1e29mr3401204c88.20.1793071851626; 
 Mon, 26 Oct 2026 20:30:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 38/41] target/hexagon: avoid negative slot shift
Date: Mon, 26 Oct 2026 20:29:24 -0700
Message-Id: <20261027032927.3055166-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX1Q329gMMxnoZ
 UiPB/kDWjM0yYkehJazWsVZUuXmI3xrQjZABuZDCzCIwam0qRDq1qdWOQtaTEBtwMi82InKH3BR
 mERY2TGWpRtgkBxMCDQ6+MzP59gn+zY=
X-Proofpoint-GUID: QAwPeKUvwOIyJgP8yChsroJkeHt5HsAN
X-Proofpoint-ORIG-GUID: QAwPeKUvwOIyJgP8yChsroJkeHt5HsAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX7XmYJcu4SGe8
 BurQd8TGtuWrBV5c+yiMlBTbQ34e39fgSs7QRUf8YTd4ZDV16NMd6B936Vz7s9Gfat4USkNSAlG
 +ToywwYE/Z0GnSGm8i3mm4HaY2+hXXpJcCWP8FLPEPEPSpq9zjF7pnjGTl9pGf2wAkSAsw52vw2
 sZ+fmHmnh9x/WJMNY7VKIlvYcbKcmkdZnBOc+oaXK6UJ0BdYpqhhYBJ9CMX5BuK0arDTyKRHhqL
 1wuOARe/Uiu7bauLj3auUDN8747BdSfrzvnIgG8N6WQhRW1GAqWNexkqVNrQFuyHkkqx1RJcM6w
 hzT7F9pJU2KN3m60cZK45hL7dLquznCNU+kwkhpLZ7wmWSLDT8LF1JS3cWtqqKG16LUrfn1ZRaS
 McQpzasFqUQCaKYCdSwNLJR1OqRS5YXdsAdiSzOYyaaQqa8AqzPfGp7T3dXK8rRpxv4Ie5KA3px
 zxkq8PeRHrgdnG6FMDw==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae01aed cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
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

SW52YWxpZCBwYWNrZXRzIGNhbiBleGhhdXN0IHRoZSBhdmFpbGFibGUgaW5zdHJ1Y3Rpb24gc2xv
dHMgd2hpbGUKZGVjb2RlX3NldF9zbG90X251bWJlcigpIHNlYXJjaGVzIGZvciBhIHZhbGlkIG9u
ZS4gIFdlIHdvdWxkIHRoZW4gdHJ5IHRvCmV2YWx1YXRlIGEgbmVnYXRpdmUgc2hpZnQgYmVmb3Jl
IHJldHVybmluZyB0aGUgcGFja2V0IGFzIGludmFsaWQuCgpEZXRlY3RlZCBieSBjbGFuZydzIFVC
U2FuLgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQUZFQWNBOENZ
YUo9akF5YzI5UlNkVU1EX1NXcXVKcXo0Zk5ReVc3b0NyV2l0aFpoWUFAbWFpbC5nbWFpbC5jb20v
ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29t
bS5jb20+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyB8IDUgKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4
IDM1ZDc0MWNlODY0Li4wYWM4N2JiZWUwYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZGVj
b2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKQEAgLTYwMSw5ICs2MDEsMTIgQEAg
ZGVjb2RlX3NldF9zbG90X251bWJlcihQYWNrZXQgKnBrdCkKICAgICBmb3IgKGkgPSAwLCBzbG90
ID0gMzsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKICAgICAgICAgU2xvdE1hc2sgdmFsaWRf
c2xvdHMgPSBnZXRfdmFsaWRfc2xvdHMocGt0LCBpKTsKIAotICAgICAgICB3aGlsZSAoISh2YWxp
ZF9zbG90cyAmICgxIDw8IHNsb3QpKSkgeworICAgICAgICB3aGlsZSAoc2xvdCA+PSAwICYmICEo
dmFsaWRfc2xvdHMgJiAoMSA8PCBzbG90KSkpIHsKICAgICAgICAgICAgIHNsb3QtLTsKICAgICAg
ICAgfQorICAgICAgICBpZiAoc2xvdCA8IDApIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsK
KyAgICAgICAgfQogICAgICAgICBwa3QtPmluc25baV0uc2xvdCA9IHNsb3Q7CiAgICAgICAgIGlm
IChzbG90KSB7CiAgICAgICAgICAgICAvKiBJJ3ZlIGFzc2lnbmVkIHRoZSBzbG90LCBub3cgZGVj
cmVtZW50IGl0IGZvciB0aGUgbmV4dCBpbnNuICovCi0tIAoyLjM0LjEKCg==

