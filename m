Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A81606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aeAs4fs/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UiX1fNL+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIzK-0003iq-IY; Wed, 25 Nov 2026 14:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWIzI-0003hw-FN
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:49:04 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWIzG-0006Kg-MX
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:49:04 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APJApfs1357614
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bDZFlCtMOL/iWNBYbzxBvI
 U9Ti/+fnHwMfBPoJyF7hM=; b=aeAs4fs/hXj+ySM0fDagxkmTrydBMqCzbx2hTJ
 MU5FG2jH/Ha2sdRAXLR/+sfBibz5cvy2bmRVT1j9vYDGIlhNmtQHb8ZvRtYJmkjh
 cyTtEU30SXsxysWQL6iW1ZUE0TvHm4VnTNjAM48R6LH2tQfwiBBx0CfSohEdBr2C
 ObNQhOvcwKonaykcKA6YM0u04rHkW/5wCvVOSPNqay0nP+ct0Ao78PSH2lQ/cN8e
 rcwFz8FuYZlQOijSqZnnSXpLuZw88LeDu7CO0OP6jcqDSAt9TJJpde6lNy7+en40
 q6E2ZbEA/arLzf1OXYv+8pPhpgLyHI4apDH912RgVJw2b+nQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxstdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:48:58 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b545eed566so1330866c88.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795636138; x=1796240938; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bDZFlCtMOL/iWNBYbzxBvIU9Ti/+fnHwMfBPoJyF7hM=;
 b=UiX1fNL+zVo7iPPTWQWZ/SSkRiOsU0wGryfjbYRn+ET3frTYAtHSxz4q4aulvgidbP
 UKxCPQIDV54iv1GbZbbr2R6riggeAAi3/fpjc56ylmlS1niQmc+3Cnzqiz2J4Rt69cea
 AQby8VKTFwqmIJSTSVYbQX0Ln3E/SzJf7XiqWry+StTSDjv/aitPwkISMiH1dnmr/dBw
 cV19pX+CM+fzEpgqe5WL0UIFMUnqs+QnGUllt6iloWNOqLPwheWfRl1oqyYhrovsZzF1
 sirqagIk3oWLTP4sY5l8E5GD2SRg5wYPGj/zntTXPwKl5jTG+SzIWsCTekawmucwiaN3
 WWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795636138; x=1796240938;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bDZFlCtMOL/iWNBYbzxBvIU9Ti/+fnHwMfBPoJyF7hM=;
 b=U4kG3W1x5W16UeyaP+FpLaONUOvdlSi8cG1MEE0hXJbDivZMlo5GBAVv2AYnfKRUEb
 WMFodBoMxKytf4zixx0LI9hau6ewEmQMk+TtPS1CeLAIJqgY/l+MQbdc48aMuEdlZXgs
 Yo7FTTR2+VOb8Jhko2m5QvxUqv9E3+52Hu3xro6cCc4jVNj9AMcCOpPqFb8M7DfyZDlb
 CE0tduuxppP6XDwoHHhJgjgDii9uFMNKAYEx/tZjV/r9kIf/NK11lHt6Z6ENXKixZmx/
 pIY4HHD0ddEIUIk03NeX/qbWTl62rm1k4bVvQskJ/uem2YgYqpPaRxD1gtAuBAAESdzr
 mK4w==
X-Gm-Message-State: APuU4Z84bHzsRyf9Ml+lgfIPrvxizX6+XL8a/aVYN3QkhZiiyF9ZTn2N
 01gXuMJjftdrdSBqi+H/tZmHRLj07bQuXNH3/7fsENjK5n+21vxjdSzbNHHQVJkEMDxgUPixfnj
 LCvn2H4NSA5P98Lh5BPfKu/UsJ2IqXAZbGccnNfC/lOCV7GJqxjn1E2u1NBco8sP6Qg==
X-Gm-Gg: AZFdTZd/OeOD8KDoKddcpAHiRWtGS9F0I7hpmwwRpLYoP8FKbSSJOTbpM35Au3w5kXS
 BKMHjptfRI8FEVZ9kdEvg4uOAGdpp8ZJY0807wy0/JixfPaVkRr282rVWISvXD6OCoJaVdNiSZ9
 lPRCDi2pXAwpjtxZ9v+HTQSxAPembjhw88ijUPsxI0tjib1pxQePWWyGR9G8LvEOenTXz4l+Yx8
 o7pRcNZNztlxOdwaYVUF7m7XEMs7GPKGNsfdn9itimfQfaEdI+EuhZDAWLQK/9w0U73eXYmwj7/
 as33bKt3/A2dpvPiRercUPjz9plZ45Fa6n1wCJ2IzRhvq1lIMTT9hFaSKwPGlM/6wP6KTSa+e71
 grIWiL+iZ/Jy3VX4r9cpFgLfNAemnpC2JCQqKrowBt35diA9pIZZqZqF5ECRxKqyiaBl0VMddd3
 DsoJNrJ24A01np5rcNlyI45Q==
X-Received: by 2002:a05:701b:2810:b0:159:f192:5290 with SMTP id
 a92af1059eb24-1b5524b591cmr17294389c88.13.1795636138113; 
 Wed, 25 Nov 2026 11:48:58 -0800 (PST)
X-Received: by 2002:a05:701b:2810:b0:159:f192:5290 with SMTP id
 a92af1059eb24-1b5524b591cmr17294375c88.13.1795636137578; 
 Wed, 25 Nov 2026 11:48:57 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm44407715c88.12.2026.11.25.11.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:48:57 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-12.0 0/5] dump, hexagon: add support for cores
Date: Wed, 25 Nov 2026 11:48:50 -0800
Message-Id: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: KDjGQPud1T_gMV9MWMm0grlRHnXZYnbO
X-Proofpoint-ORIG-GUID: KDjGQPud1T_gMV9MWMm0grlRHnXZYnbO
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b073bab cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=BmgYcRIU7yPiCFNHKvoA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfX2JBl6bLi4La5
 5RSP9iQg8LPf14SOQk1F71oeO/TqmznxgKK8tlJtA+JJWcQQPz9/mCu6uFSE9n8QXJF5CQChZgG
 lCPD8syDMhPxaluYusN959nhkmC5eR/vCGG2eWyMrOqzAt1htJ5QuuHWaTZGJt3BcHPS60NpBN2
 peQ7RH94MFaARcj/OeAnb7WjgkZ4D5yNEq6u5T9n46lmrazXT7NHeH9j6/wx9oeP2+y6r3H9/ld
 kD+UsAyKRGlw8wwkRAiJF2OSlmKvWg0IZuAgAHDkEIWvcVfah8Hv45sASrOot9ddawFIyZG7B2a
 pGShgmwxru40+/ccxrkUzjh58t9zbRGvfq8DjyE7TxxF4MQGoSIQ96xRemi928R22ivK+IHjS7k
 GVlosIakZ9C9Om5cjlrNtG6Afv/ZnZW7v+Iqy5/zSF0NzkcWxpFTXatFU3CGCAGu36X8fpqDBUX
 L5BH9mOPC5EYOlnIFSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfX4+kox4l3yta0
 YAM49a6wXzJ+swNsQLbYZQsKDz30kn9ZncDiBRGA+BCMR4awDx89cpfHaDj6M0PCYsnNvUCp6Y3
 cmRqbkSsh+arZP+RR2YKd0MIb19A6w0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250078
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QSBidWdmaXggYW5kIGltcGxlbWVudGF0aW9uIG9mIGNvcmUgZHVtcHMgZm9yIGhleGFnb24gbGlu
dXgtdXNlciBhbmQgc3lzZW11LgoKImZpeCBlX2Voc2l6ZSBpbiBFTEYgY29yZSBoZWFkZXJzIiBz
ZWVtZWQgbGlrZSBpdCBtaWdodCBub3QgYmUgYXBwcm9wcmlhdGUKZm9yIC1zdGFibGUsIHNvIEkn
dmUgbm90IHNwZWNpZmljYWxseSBhZGRlZCBpdCBhcyBhIENjL0ZpeGVzLiAgQ291bGQgaXQKY2F1
c2Ugc29tZSBpbmNvbXBhdGliaWxpdHk/ICBTZWVtcyBzYWZlciB0byBqdXN0IGxhbmQgaXQgZm9y
IGZ1dHVyZSByZWxlYXNlcy4KCkJyaWFuIENhaW4gKDUpOgogIGR1bXA6IGZpeCBlX2Voc2l6ZSBp
biBFTEYgY29yZSBoZWFkZXJzCiAgZHVtcDogbGV0IHRhcmdldHMgc2V0IGVfZmxhZ3MgaW4gdGhl
IEVMRiBjb3JlIGhlYWRlcgogIGxpbnV4LXVzZXI6IGxldCB0YXJnZXRzIGFkZCBub3RlcyB0byBj
b3JlIGR1bXBzCiAgdGFyZ2V0L2hleGFnb246IHN1cHBvcnQgRUxGIGNvcmUgZHVtcHMKICB0YXJn
ZXQvaGV4YWdvbjogZHVtcCB2ZWN0b3IgYW5kIHN5cyByZWdzIGluIGNvcmVzCgogaW5jbHVkZS9o
dy9oZXhhZ29uL2hleGFnb25fdGxiLmggfCAgMTAgKysKIGluY2x1ZGUvc3lzdGVtL2R1bXAtYXJj
aC5oICAgICAgIHwgICAxICsKIGxpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmggIHwgICA4
ICsKIGxpbnV4LXVzZXIvbG9hZGVyLmggICAgICAgICAgICAgIHwgICA5ICsrCiB0YXJnZXQvaGV4
YWdvbi9jb3JlLWR1bXAuaCAgICAgICB8ICA4OSArKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24v
Y3B1LmggICAgICAgICAgICAgfCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2ludGVybmFsLmggICAg
ICAgIHwgICA4ICsKIGR1bXAvZHVtcC5jICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstCiBo
dy9oZXhhZ29uL2hleGFnb25fdGxiLmMgICAgICAgICB8ICAxNyArKysKIGxpbnV4LXVzZXIvZWxm
bG9hZC5jICAgICAgICAgICAgIHwgIDE0ICsrCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5j
ICAgICB8ICAxNCArKwogdGFyZ2V0L2hleGFnb24vYXJjaF9kdW1wLmMgICAgICAgfCAxMjkgKysr
KysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vY29yZV9ub3Rlcy5jICAgICAgfCAyNDUgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgfCAgMTcgKystCiB0YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICB8ICAgMiAr
CiAxNSBmaWxlcyBjaGFuZ2VkLCA1NjYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9jb3JlLWR1bXAuaAogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRhcmdldC9oZXhhZ29uL2FyY2hfZHVtcC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFy
Z2V0L2hleGFnb24vY29yZV9ub3Rlcy5jCgotLSAKMi4zNC4xCgo=

