Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91660606B20F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rw9fQkeA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iB1dMGWi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTE3-0005yy-Kn; Fri, 20 Nov 2026 13:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE0-0005yH-Fd
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTDy-0000Pw-RV
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:40 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfRIB304434
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 byb0vmH/3wGll+KpRvSprNYwDL9NDUjqZEYPf+zZmLU=; b=Rw9fQkeA6eYD26lE
 xCZnKI+L+FrZq8F/rmsvkKnGop3GU+AA9GGqosBBIme392Id1pEjNxFDO8+jpsVb
 IDitH+B3DUpzuQfq9cm8cPCg7TfqeJbAsc9QNVQ2WMHJ1SXNg8Xg/If21xoYM6Ge
 +s+Lmaa9t7EHTyi6Gg0bHUjBe83hXWVwWQ7wcq75RYumsRcWNY1LK/hm6L9RVvy9
 +YxQG1cVrQm/uqlnnOZfqPA2/UtTGvE01stY2r7ocRB2GacqTv5OT21ylNQbI5gw
 ecCw7sJxbug8elwNbGBAi9JpL1EhEqUVO/rKGDdh9IBqiDO+NE72mA+De4asCHoc
 lQ2pHg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu82ybx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:37 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-862b2e1885cso1429613a34.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198836; x=1795803636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=byb0vmH/3wGll+KpRvSprNYwDL9NDUjqZEYPf+zZmLU=;
 b=iB1dMGWiQY1dMNDDPU6zUZ8LdIpXNzW8FVlP5Mjh79kl40bXPVmpn5ok3TpZNkwJ2C
 /m/5qv3/iURPkb1Oxb22B0x1FePJd/ZbLxEFKgJXonsAPnyy9x/5uRIGe/9FV/nXmboi
 Pujb1Ja8WhJS9qQp28SkclZffTiG+e8XmMMrOWJctd5QssaaYdQ6gfvqmASspxgohm5m
 1Y1KL4pHMyhjgMM4sLa9ThIjXNgdqgWbO4I3Nd9jV+Jh2z6en/njPTkINS1aSUPGauk9
 kgIFzHJWt0LBe0U0LpQwXe1O/zJnkshrWsKBv07rQR/msnfZNHBgJemdGlS/TjzO9wBE
 pWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198836; x=1795803636;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=byb0vmH/3wGll+KpRvSprNYwDL9NDUjqZEYPf+zZmLU=;
 b=UqMnrU3R+rJ9E4JHUnby809h5Y0dmat/w8A2fg+sZmd3C4KgLihqEEfOWB3BzBCLDO
 vCht/JXT83GgmLoAt5jdlFqu+tPZMU57IIaQrZe8R9etijMbKKB2b3I72JWlLnOzq27w
 G5+8pQHI435ZHSdDT5W/coBGlMFnASRLkPugBU/L6H/rY2EidaBrXJtGYAmLKqIfbH50
 NsY7/tk2ibxa4clNa132vEYcSh3Fpqfmn/wvs3sPTAHxEDR/6BxhMasaEcjhBKO35xoD
 eNYQApDvPovYcNL4Qx3mYuCC8S/5aG4RsDuLgvKObjYHYW59cC4R9VjMF5SUXfr4vnHZ
 NUNw==
X-Gm-Message-State: APuU4Z/gNAwf6eQl2ubjXfvauQ41IfVByIztB1TJm5pGaNtvQwhDU2NV
 wFKb5tCCpu3rbL/R2VHTjgLTvL3J8e8xzQVIKqLAVnnNv0TJqZ91ty/tUeqi/b2veowxee3/1zP
 Ha9je9ogc+k8nlzDekh4O87CIQoWUGiczFz4anwVW5qLU0pogu6iuFbwd//gZew4erw==
X-Gm-Gg: AYBFou306VxKeDSMJRibklGsHzFaLgsB1CV+lutz0rXKMrT76OARiN+y3BmpYEzJHGT
 0bsvNyFZSsGolhraq98axJfHJqRATEdV9KTJdAkg1lr++mxJXJEgmtlnKpCpBIeZ7mNlXiGwVB6
 2jTY8rVRfEUN5QPSE531oa26qYI3D68AiXqwsjbQT0iDp11Zj3ZcdnD5Ea3wXGmkuRsWtifSy7d
 j4J0uFi0C3zX9rsz9Llpdq13q4RQWjLiehxl7wIkUKXgN9PrQJOPHIC0Law8RARgJAX30rHtLFP
 6g8d+ygh6gPRMGNAOS01KC5UDo6rBOhwBsG9wnI6oQEwO5QgldrHE9OWajK0KSiTR2TJTZV/+r+
 xsILRtuy1g6kHHhj2QbzvBWthRSD38Xj62XU5JUZ8K75mjh8Bu5WFrluaCArY2d36WNfwwsRj/g
 9VlXTCAyDrWChQfnCJmc621Q==
X-Received: by 2002:a05:6830:3150:b0:862:a097:ab4c with SMTP id
 46e09a7af769-86315932389mr5923355a34.22.1795198836472; 
 Fri, 20 Nov 2026 10:20:36 -0800 (PST)
X-Received: by 2002:a05:6830:3150:b0:862:a097:ab4c with SMTP id
 46e09a7af769-86315932389mr5923311a34.22.1795198835948; 
 Fri, 20 Nov 2026 10:20:35 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:35 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v2 02/12] target/hexagon: bound packet lookahead to
 the current page
Date: Fri, 20 Nov 2026 10:20:21 -0800
Message-Id: <20261120182031.560481-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX3hbtruVUhz3v
 RVGt/TkfpS/c3LUgWVFAYG/APIACtPZj5tB8O/C7bUJKJ+cIiWMMsIXbNwKpGU++8aVTkvhxcJR
 /bE4lWJn9ew4QWMCvx2+dheArDUGuoP8JTouZwAb+X3kwSQKqPW++mXYgoldB4Xc2bwrFgbuR8z
 02+QhK+g04Jc8XHEQ7+dDwkKmqGvlO7W8Uzj7wJI41hi2D+SsKMp8vxp1OCSY/YtXfuOz33EpO4
 SZX0gvDG7VSxl0ARG2hJanSeJI3okGUEiht2ZLG6PTiTfnadrxfGtmA9Tg7wlcEc1TMDKQLNPtC
 myQx/Z1SJwt5hrc/TzrguwplsBL/8GMe8I7I4WIxO/sLOoKn2riUhCY2Ailhw+jrYlNOWnDOBih
 bqJkU1AqZbNZkaqBY8p6+4j3VdLaCTtQj3igmvBeBrKF430u0oKczGTvyndrkELazreLqJeaDnJ
 ggo6H536AA4HWrrELRg==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b008f75 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LOdbtK4x63e5lU4mKCMA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: WYzxsgiSoRIKsbKaDCQlqgTzSXNIN2Wa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX4XklPwMTxW6a
 Z1r9TtscsrdSZAp1EJn5H3j5FIDVRZhjy4/ymzW+dyqcYgWjq2HznR9hvqhunoItjESjkeLKpzs
 BXMgT8Q4KPaL3gHiUgZy2IzlWSMoztI=
X-Proofpoint-GUID: WYzxsgiSoRIKsbKaDCQlqgTzSXNIN2Wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200072
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkRvIG5v
dCBmZXRjaCBhbiB1bm1hcHBlZCBwYWdlIHdoaWxlIGRlY2lkaW5nIHdoZXJlIHRvIGVuZCBhIFRC
LgpUaGlzIGxldHMgY29tcGxldGUgcGFja2V0cyByZXRpcmUgYmVmb3JlIGEgc3RyYWRkbGluZyBw
YWNrZXQgZmF1bHRzLAphbmQgcHJlc2VydmVzIHRoZSBjb3JyZWN0IHBhY2tldCByZXN0YXJ0IGFk
ZHJlc3MuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVh
bGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA1ICsr
KysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCBl
YzFkNzllMzFmNi4uNDFhMGYyYjA4NTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0xNjIwLDYgKzE2MjAs
MTEgQEAgc3RhdGljIGJvb2wgcGt0X2Nyb3NzZXNfcGFnZShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
RGlzYXNDb250ZXh0ICpjdHgpCiAgICAgaW50IG53b3JkczsKIAogICAgIGZvciAobndvcmRzID0g
MDsgIWZvdW5kX2VuZCAmJiBud29yZHMgPCBQQUNLRVRfV09SRFNfTUFYOyBud29yZHMrKykgewor
ICAgICAgICAvKiBMb29rIGFoZWFkIG9ubHkgb24gdGhpcyBwYWdlOyBhIGZhdWx0IG11c3Qgbm90
IGRpc2NhcmQgdGhpcyBUQi4gKi8KKyAgICAgICAgaWYgKGN0eC0+YmFzZS5wY19uZXh0ICsgbndv
cmRzICogc2l6ZW9mKHVpbnQzMl90KSAtIHBhZ2Vfc3RhcnQgPj0KKyAgICAgICAgICAgIFRBUkdF
VF9QQUdFX1NJWkUpIHsKKyAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICB9CiAgICAg
ICAgIHVpbnQzMl90IHdvcmQgPSB0cmFuc2xhdG9yX2xkbF9lbmQoZW52LCAmY3R4LT5iYXNlLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+YmFzZS5wY19u
ZXh0CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKyBud29yZHMg
KiBzaXplb2YodWludDMyX3QpLAotLSAKMi4zNC4xCgo=

