Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350D606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xdfq2j7r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GBZuBZcK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Yh-0002tb-2y; Thu, 19 Nov 2026 15:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YU-0002p6-35
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YP-0000rF-JO
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:24 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1OdZ3814588
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E03kImDsatFVsrjOWu+28rzbswdOKqZw85wwqwk5HY0=; b=Xdfq2j7rUef3Fpna
 j2Csxc0URkhz8jG7fn5kKJkuxnbvxX/DF1NXqDx7IB0l+0ePJtykYueDrvKIL/rd
 OvZuPSMiwfaGrKVuGrLnLNfDnoxNXPgdtPVyCPGi5AtWQboL9nlBozJi5zzhY3pK
 9ZntwmhPz+Qap13dHOkD9YmZ6Zfzv/8wDhqp7pNf+q65ou9U6LTVie/SyZuhpfgk
 1iMmshTCI1C861jjDzk/R7BEUNM30iIq3kHf5ZO4d1SgXh/q2q8PLJ3B0+O89LYm
 qGtwN2vX2WT3jk3BVWwiSLu+EFIq2F2lUxfEdFkldhnjh1Hl4E5E3QpG3j6tLkUu
 EAfNRg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xc6u1vy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-38131260a5dso296525eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119376; x=1795724176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E03kImDsatFVsrjOWu+28rzbswdOKqZw85wwqwk5HY0=;
 b=GBZuBZcKDNaBAANqjMnbbTzPu5Dicf6pKVtM9KM6Q9Gz0Szb3CKZvMnlcXuiId+5WD
 xRqkrZ72fAMzzVd09XTEvMKxScKNo+ITyEBAgjkya1uQ0gk3FoonPuq/T2GlIYLgS5tX
 frqifSDo6HSpP8d8QIklP1H5f6zgheIGCl4+Om1A26awq/6J3P7R57dU68PdcU6s+kG1
 Wv7WS6dvmjU3zqvIiimT6QOTA6pSUqpws/PcNUp2JTyeoceKEQTO+XV1dEjvjSRPQ6Xx
 2lEDfoXcrmy9QEaU17pabwJtwwxcP4K/gr6s4SeDbrhd6NZDOuyNp7Wphas1IGZYFQsn
 eNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119376; x=1795724176;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E03kImDsatFVsrjOWu+28rzbswdOKqZw85wwqwk5HY0=;
 b=vM9Qgg+ky3ZdHGcYmcQbsCmgEcWplbRgshbR+T9dhtZpu41pSEOsK/rKHNK6LAqYye
 cIkitGZOkgPyZFRpAGhoaIIfFF375E0h5TV8kdsju504Z8UAczpj164454czyGEAbQMY
 HqHp9p5o6fLz50yGguvx/WJGioDv9jqM/3ZfKyOXHDQF3EekJx4NAmsgXqXsoXxD59vv
 EiSa4j5yL6glXcNUmqkeXyKtCbnaLT2dfXbsagN0EVfXnw0EXh2ZHm0Smofw+FBsHEiE
 +3/LR8Iph3GeYNn4Ma9/sH8l3VBt0xsOuG1JStXwAKeElHLC7nTAmh68YdKrX1Vt3tJg
 bQnQ==
X-Gm-Message-State: APuU4Z+dBTw0x+Cvqo9JqeX7ei5TNimiI+70U+XjqVberYAg2stm8uVp
 QCI0W8Z7BidFNgJoPdewdQ3Zl+rgOjqet6zOJKTfoW8q+ScQw1NvRIQE15rmi2RQr3h39VSaol7
 SrGE5Qqxw31Rq4E4SIrkzc8iiA3kv7nVHKWkwVtMf338vxwAYeMmlL2iAi7nmXv4dnA==
X-Gm-Gg: AZFdTZchuIBPJGw81CTA1xFKiq5q0r5dU3lUb8oJfuG3nsLTBu7jWK/w/YnhzKxDRV5
 I//+fKu53cu3AHOVkamBE36h/MSNIbUttEpNFavPOM5aaspu8od+agBc3l1xqf1AhzAf+NeBEk8
 hTP4p2OovQ2U6nxNYie0fUhTrOTpQlvDggMQRct/SKeu2TnIxQ2G9W3BZnve4ycYmJ9wPLElj2z
 2nLQCRzoKKL19waAONNcLkdmw2+YioPxm/ksadmbEctDf9GpDAi3J/VtIkw509EvigeXaSgsAA6
 y9LyJIu7H2KPNn3cmg0jIvBeZzv9eSQUeZNT3pSkxAhr84d+ekqt3/J7JxjnIag4ao9W9qq3AXk
 RbvpEGap29FzbYFcvRhZGG3N0O8k7Dc+XNKEPDvKsS5BvWGRVBIbMf4+sbuoOhtNppvP9U29sJw
 UID75dv6/JnnJtMJulRzAhyA==
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id
 5a478bee46e88-3856ef47a98mr463483eec.15.1795119375960; 
 Thu, 19 Nov 2026 12:16:15 -0800 (PST)
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id
 5a478bee46e88-3856ef47a98mr463454eec.15.1795119375364; 
 Thu, 19 Nov 2026 12:16:15 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:14 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 07/14] target/hexagon: raise decode failures at the
 faulting packet
Date: Thu, 19 Nov 2026 12:15:56 -0800
Message-Id: <20261119201603.2377989-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aff5910 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=BJZ_eTHKON5vc81CckUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX2/z0ZzgReFlH
 YTkEQORVKmYwEM6F2a6cj955JWZ+uugdFOcTS3RHMgGQn0VYKBiOXqdGtMeYft761+XopGi/yue
 TAfCvSFo2q4gVQ+3VOoYrmpy7Am3djbFRySJE31moVGAlBqOsA1VBb0ETxhgCrA1mNPUK837RER
 YPPLGpzFJmSLMvlCVhILKX8ROmUvMepTYUqluaObLLSJsbsLR6NvDjy1pkDxdqBAVMi5KG5T3F+
 6B2hjVm09GfPRNZyGr6BXbdRj/X2eHgtl98FjFdwWj6klT7ReYT687PP4vdw5JTd8ciKWUAC10I
 qPML9y834hVovCs2t3qqOOaKkrzN6KzYnv1xAWRyBPBEgZ9FKBuLecO9nLVGfqd3AmPfwBrGqMw
 vbL1xgDdSFPcRVxrAXrfJ6B38unEt0E47Y655HNzRvic8RlqCjJfsT5Iy5bncxm3SwQwJIh6GvU
 jTOqvELzBvkW/uvFQgg==
X-Proofpoint-ORIG-GUID: u5a7RYmx1c0x684hYdloeFveEMj21rpl
X-Proofpoint-GUID: u5a7RYmx1c0x684hYdloeFveEMj21rpl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX57VaVJ7KwgNM
 JOV1x40JOiJaRB4/rMI3q3Wmasmk2MdHPJCogjPFa3Ek+dShCdKdEKVWphRYjYNxddQjDnlaGNP
 UHGyyA5nMO9KU9/Nu5nM3WVGptSFfUU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190080
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

QSBndWVzdCBoYW5kbGVyIGZvciBhbiBpbnZhbGlkIHBhY2tldCBvciBvcGNvZGUgc2tpcHMgdGhl
IHBhY2tldCBieQphZHZhbmNpbmcgRUxSIHBhc3QgaXQuICBnZW5fZXhjZXB0aW9uX2RlY29kZV9m
YWlsKCkgcmFpc2VkIHRoZSBleGNlcHRpb24KYXQgdGhlIGFkZHJlc3MgYWZ0ZXIgdGhlIHBhY2tl
dCB3b3Jkcywgc28gdGhlIGhhbmRsZXIgc3RlcHBlZCBvdmVyIHRoZQpwYWNrZXQgdGhhdCBmb2xs
b3dlZCBhcyB3ZWxsLiAgSW4gc3lzdGVtIG1vZGUgcmVwb3J0IHRoZSBhZGRyZXNzIG9mIHRoZQpm
YXVsdGluZyBwYWNrZXQuICBsaW51eC11c2VyIGtlZXBzIHJlcG9ydGluZyB0aGUgYWRkcmVzcyBh
ZnRlciB0aGUgd29yZHMsCndoaWNoIGlzIHdoZXJlIHRoZSBpbnZhbGlkIGVuY29kaW5nIHRlc3Rz
IHJlc3VtZS4KClRoaXMgZW5hYmxlcyB0aGUgbGxzY19vbl9leGNwIHN5c3Rlc3QuCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKy0t
CiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8ICA1ICsrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYwppbmRleCBlZWYzOTJiMWU5Yy4uMTI2ZDdiMjlhOWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0y
NzEsMTMgKzI3MSwyMiBAQCB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IGNhdXNlKQogICovCiBzdGF0aWMgdm9pZCBnZW5fZXhjZXB0aW9uX2RlY29k
ZV9mYWlsKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgbndvcmRzLCBpbnQgY2F1c2UpCiB7Ci0gICAg
dGFyZ2V0X3Vsb25nIGZhaWxfcGMgPSBjdHgtPmJhc2UucGNfbmV4dCArIG53b3JkcyAqIHNpemVv
Zih1aW50MzJfdCk7CisgICAgdGFyZ2V0X3Vsb25nIG5leHRfcGMgPSBjdHgtPmJhc2UucGNfbmV4
dCArIG53b3JkcyAqIHNpemVvZih1aW50MzJfdCk7CisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQor
ICAgIHRhcmdldF91bG9uZyBmYWlsX3BjID0gbmV4dF9wYzsKKyNlbHNlCisgICAgLyoKKyAgICAg
KiBBIGd1ZXN0IGhhbmRsZXIgc2tpcHMgdGhlIHBhY2tldCBieSBhZHZhbmNpbmcgRUxSLCBzbyBp
dCBtdXN0IGJlIHRoZQorICAgICAqIGFkZHJlc3Mgb2YgdGhlIGZhdWx0aW5nIHBhY2tldCBhbmQg
bm90IHRoZSBvbmUgYWZ0ZXIgaXQuCisgICAgICovCisgICAgdGFyZ2V0X3Vsb25nIGZhaWxfcGMg
PSBjdHgtPmJhc2UucGNfbmV4dDsKKyNlbmRpZgogCiAgICAgZ2VuX2V4ZWNfY291bnRlcnMoY3R4
KTsKICAgICB0Y2dfZ2VuX21vdmlfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgZmFpbF9wYyk7CiAg
ICAgZ2VuX3ByZWNpc2VfZXhjZXB0aW9uKGNhdXNlLCBmYWlsX3BjKTsKICAgICBjdHgtPmJhc2Uu
aXNfam1wID0gRElTQVNfTk9SRVRVUk47Ci0gICAgY3R4LT5iYXNlLnBjX25leHQgPSBmYWlsX3Bj
OworICAgIGN0eC0+YmFzZS5wY19uZXh0ID0gbmV4dF9wYzsKIH0KIAogc3RhdGljIGludCByZWFk
X3BhY2tldF93b3JkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgsCmRp
ZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IDVkYzA1MjU2YWFl
Li5hYzIwNzE3OTVmYiAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
c3lzdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMu
cHkKQEAgLTk2LDYgKzk2LDExIEBAIGRlZiB0ZXN0X21tdV9jYWNoZW9wcyhzZWxmKToKICAgICAg
ICAgIiIiQ2FjaGUgb3BlcmF0aW9ucyByYWlzZSBUTEIgbWlzcyBhbmQgcHJpdmlsZWdlIGV4Y2Vw
dGlvbnMuIiIiCiAgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygibW11X2NhY2hlb3BzIikKIAor
ICAgIGRlZiB0ZXN0X2xsc2Nfb25fZXhjcChzZWxmKToKKyAgICAgICAgIiIiQW4gZXhjZXB0aW9u
IGJldHdlZW4gYSBsb2FkLWxvY2tlZCBhbmQgdGhlIHN0b3JlLWNvbmRpdGlvbmFsCisgICAgICAg
IGNsZWFycyB0aGUgcmVzZXJ2YXRpb24uIiIiCisgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygi
bGxzY19vbl9leGNwIikKKwogICAgIGRlZiB0ZXN0X2FjY2VzcyhzZWxmKToKICAgICAgICAgIiIi
YWNjZXNzIGNoZWNrcyBSX09LfFdfT0sgb24gX3Rlc3RmaWxlX2FjY2Vzcy4iIiIKICAgICAgICAg
dGVzdGZpbGUgPSBzZWxmLnNjcmF0Y2hfZmlsZSgiX3Rlc3RmaWxlX2FjY2VzcyIpCi0tIAoyLjM0
LjEKCg==

