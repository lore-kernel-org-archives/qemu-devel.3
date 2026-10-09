Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DC3CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFGEH-0007Ns-OJ; Fri, 09 Oct 2026 15:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGE8-0007MV-LI
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGE7-0007de-8e
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZZCe2870436
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 19:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q+z5M8hsKVn0/G5nooMb8C4quXa4PfN/N/zU2UYHLBM=; b=PjBqzp7ZffnVkXkM
 dAF56hD/hizfA198gJ8mwHM99+FHp/ZW0tnd0TOyjuCNqchQPxnlOP1IXdQhQ+Sm
 7vbQX+7xjiooaFyy9V5PhkoUL5g2hJ7k+zfqubMoviycdjMxmlRFKuOfeJR4/Xo5
 cyhBeRfFWSdGIUDsGpfobSqwc0OdnU5/ezA/46K2H+LDn1Psk7hXWozYDi5tIh+n
 cokP3wCpETjMu4Vwc1CTSwi6DccTrLp6cIkkWEg20AQcAXvgOoErDpgp8U7pYCMZ
 /oPPSEUU938KB/54f7RaTdwDbF44390enR7hlHhR25HgvIvNnSk67a2xT8Dctex+
 2xz4cQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7gev8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 19:25:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so91187eec.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791573953; x=1792178753; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q+z5M8hsKVn0/G5nooMb8C4quXa4PfN/N/zU2UYHLBM=;
 b=bq3LsqK7uoJWFHGfqohs6WumcJC8CWn4t9xNX0y2Xmr0Q5p5zoCmX2sjs1cj1TGuEa
 kuf1Cf5Tns+0GnxjYG2fRAy9nT/XLj4vuwANaW5eAjB0Dh+ZZTq5zN9uYc9zQ0oetbD2
 xMBtSSNzll5Uz414l/NuGhhHhL3vPPNAqqkKu2r87kUcdZOp3Ad1bWsGqR+t99ZNroGA
 2b/CFDgZS4X+HYXnzaHH5RZsnowfKuGkL0mFiHJjNor3IrJ/omOvHtxoXPHrlzvIxsZv
 QImfG77NXmERUPc8v7RmFmeJzkLTSE0WsWrpMdeKyDtm9K3qcQLnnMCH7GzG1T0OeIvm
 7VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573953; x=1792178753;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q+z5M8hsKVn0/G5nooMb8C4quXa4PfN/N/zU2UYHLBM=;
 b=w1Xw6mujwSioiLk6yRxDPphyhKaG9DLp4VbF8fMQVfdZLQJxZH+jeuwxBp2orILSbN
 XX5t7VYjtrfJ32NYx4HaI0g4mQJYbrBP4NjlJvN1dol9SXCW6Lg1s8qX9xlLXY7YucUn
 CFsjbrDNM0Axeq6KBd3VX1YuRoMVlJorIc2JUjQFxkmLETMphmuqAuv5gSiNzOJLpD8l
 XdIC5fp+kKwcro4BMq4zTw6ah+b1Y0bEQye11ViuWeav3EeoWHdI0EBsN1SsWLd4cwMB
 +l9mrBibAAOhjwCRv79S1OUgkNgZUyQ9+kWTzPToCaOqScfNw9VyxWGEQrnIoolCa4Yn
 9ksw==
X-Gm-Message-State: AFuF++myZd0N/HAZACtengraaIvIzek82Mjy2SVp+LYLUqs+CeMPh6/Q
 fM+AbeQDKpaJ6PjaU029gl3jKi/mMZSBL3vsEZ+A05ilURUIXl+N4XsufE9qts618OY2ZxlSAQs
 ZCqbX/zLoN6T1dzCsVmb2qtFTiMpIincm+0REsmGyqgS7fuDIJLIo4t3BmA4P9fMQlA==
X-Gm-Gg: AYBFou3S4asU4blbLUjvZ61tstXVQESuE69d43/w4u4bSphXZQ5VwLYkVVLnGI8U/WS
 /ig20lWDbbWUHpGskeDeqSG7j72WvLQhkv/Fg02ZMxrKsikPftqehvXK4s3UUygFowBVA+zZOj+
 NlBpc6q4YYqcLXq9AKAYMMHP0DEv/JmPIBRgC+r6Z8zthAqo3swv/ty5sb57n8hR495zjj8WH5T
 MFXhl9ANnD3oct5dmVv3o4B6U495YPAqSGeWCgUnAwry3Bg0UDOTv0ywGcOeHdKCLolQ444T8Q5
 UFlIZtGQpmEN5lqhfJfGOW/kwe/1gwS/H5ZFUI9q4ZwLlhzQspkF8Zn+ovSXsFbV1hQyoYHWNkp
 7oOvyBn/VfKXv885NJ20FTht3ndTih2gnCQvhyl4ckPwq0L8=
X-Received: by 2002:a05:7300:fc12:b0:351:2f08:8547 with SMTP id
 5a478bee46e88-3537dde5db3mr3734320eec.3.1791573952921; 
 Fri, 09 Oct 2026 12:25:52 -0700 (PDT)
X-Received: by 2002:a05:7300:fc12:b0:351:2f08:8547 with SMTP id
 5a478bee46e88-3537dde5db3mr3734288eec.3.1791573952420; 
 Fri, 09 Oct 2026 12:25:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7652822eec.13.2026.10.09.12.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:25:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/6] target/hexagon: fix stale PC on k0lock wait resume
Date: Fri,  9 Oct 2026 12:25:37 -0700
Message-Id: <20261009192541.4163758-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=W8atxhWk c=1 sm=1 tr=0 ts=6ac93fc2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=3l8XzFyHuKoT-FFnaxoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 4kMMJleSszKFj0U3KIHNhXb-eJfDoea4
X-Proofpoint-ORIG-GUID: 4kMMJleSszKFj0U3KIHNhXb-eJfDoea4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX3bzXjezX8V0U
 Tc+Y57BVENdUCrNth3ar1OWidmAc0LYpamuVx1lDsizXAVOkOjjlVcQ/QNxE6/O2p+BS70cJBLY
 kNkB6kgsrOzeH8AM96Nv2seJZvsRRAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX/1wcoIduHkHo
 ot2rFhVoZtP2s8GGXb9qeKI34hZADy/LpKnaqw3CQtLxNF2L9FWzynEMtDRr67qHToEEJmYhN/J
 8QURSO6xPL1HaLPg14E61jbzSOcZ0lTmbYq6gQHyuGL199yTqBD3o3MSeJe6RyxB8Bw1YsGe7KQ
 hERAlm/LonVyWzeQa/zzhCI6fiZmzX/jOimI0S7JYDq85Yg16HfKNWhG36rKBSHC93F6PA41TSK
 np0lauMgzQuubPle3MV2oGJmGyYjDt8Y/dSjFBu3h3a0eKUPEo2rjlL5Ww3kyaG1eKzQ2vvnX71
 2/TvFBdMWLkbNFahf37PHZItTJAF08Boxg6qGidUao5eA9OlsTyyiLLOh1RnlViRtYU/RAzU5Uf
 A8PC8UZ5M3w2KNAzHelXk38vI0KV2X6ksOAf41zU6fny3iAeCOSbcRLEwIpORGqTMknDeydx1c1
 XkpxDhRfkLYBMp5gz/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090077
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

U2V0IFBDIHRvIHRoZSBrMGxvY2sgaW5zdHJ1Y3Rpb24gYmVmb3JlIGhhbHRpbmcgYSBjb250ZW5k
ZWQgdGhyZWFkLiBBIHN0YWxlClBDIGNhbiBza2lwIHRoZSBhY3F1aXJlZCBsb2NrIG9yIHJlc3Vt
ZSBhdCB1bnJlbGF0ZWQgZ3Vlc3QgY29kZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRl
eCA2Nzg0ZWZkZGM5Zi4uNTZjZjYwMWVmMWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xMzE0LDYgKzEz
MTQsNyBAQCBzdGF0aWMgdm9pZCBoZXhfazBfbG9jayhDUFVIZXhhZ29uU3RhdGUgKmVudikKICAg
ICAgICAgICAgIHJldHVybjsKICAgICAgICAgfQogICAgICAgICBlbnYtPmswX2xvY2tfc3RhdGUg
PSBIRVhfTE9DS19XQUlUSU5HOworICAgICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGVudi0+
bmV4dF9QQyAtIDQ7CiAgICAgICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFM
VCk7CiAgICAgICAgIGNwdV9sb29wX2V4aXQoY3MpOwogICAgIH0gZWxzZSB7Ci0tIAoyLjM0LjEK
Cg==

