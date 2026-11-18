Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45660A2613
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q4JEYEQF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GS2n4HDO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTjEi-0002KA-7q; Wed, 18 Nov 2026 12:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTjEg-0002Jf-3E
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:14:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTjEe-0002x5-6i
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:14:17 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIGwInf4043705
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xDZOgcKl8uxUvg6aJi2oMo
 mxjsG0mf9SY5QrTUeQlnc=; b=Q4JEYEQFFFMBnnzct4Xyi3dj82CD6EmsAtq5iP
 Ldm5PPe24LJk30/I0Hot7Pblqd4WynriT8DBlkkN494O7KTCIIvRm1I27dQAedmG
 f/+CGk3cnG+gPuadMZ6aGgzoimirralbBMkaXN4JpN/yA+X5YylPaZqj0oB7xbp3
 2Qly69nEW3g6p0Grq8rINAynkG1e1/hwQOaKGE2GrkbRCVUXZaqoc6dda7MFdJ6u
 TS6n2ixtIZhoBiEAaud2n/j+rK3H+O/Kv7oklhB2umEkVSKnZaXwAZCwYZMFd39H
 Omb/6Y3bVP17MF8m2OCd6OsYxTf+cdO7dvyrbInvWDFyAB+A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dfcryde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:14:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1603732eec.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795022053; x=1795626853; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xDZOgcKl8uxUvg6aJi2oMomxjsG0mf9SY5QrTUeQlnc=;
 b=GS2n4HDOKvOEzU47VC1z+pC3IbTbbcqAhCXEaTWF800cVK9MvpQSW7FYg1QtCYYsc4
 4FDCf6iZf9oQAUGusC4BPLvFFp/IMccNDVIybFbmh6HHN67xBHFB3vIfLNcpr0etm1XQ
 TKfEkOgCnzFYeIBf7cUwVzeazKGrOUiag0vge24VrKdL2q5Yw07fg+Od1A7YZcwdkfC2
 xegUpJ1TqB5qQwBtLIvtmqgHZlSYxTY+eCnyEjDUGMKEYd6ukfoJv3zprY23aikqhPcj
 QRPLSAO3yKUHehHtjkkBKBht+dkdkXvy/G6t5Uz2uG9q0yRP84QJO+rn1ij6i9CM/aSy
 gg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795022053; x=1795626853;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xDZOgcKl8uxUvg6aJi2oMomxjsG0mf9SY5QrTUeQlnc=;
 b=f7hziQnzzNKLxNdT7lWMpHerpAaP6EbECLtyGNWlMfoc4efs87SfxWfvcuqRVBda+3
 5McxwFgTsjBmNeuCRTOAke0FBLg5PMGBh3oj98oIllhTruKRqmwLYO1+ket42V9AusPp
 RQaIw31ermfQ+bIt2BZYyKnYWDaChfGwSyV1OlHCQIfetgF57ZRXzAvswEhmOxI8ehnd
 oDGGaYC/QAtGMa0ne8rURb6Xz/eL30A7Z3rSHVgbeNCoY76W7UovtPtfM5k5YLEi3iq7
 cMtDRyEQ65gnYaCNc8RURI/Q8cRrGO/BTZlOJVTQhkhkh6zyH2szbF4qwrqzGATOWXs3
 DYLg==
X-Gm-Message-State: APuU4Z+CcDCwVM4px0VAglaUgQ5uEgImq3MTdbc6ag3bctpSLcQ1CAtm
 tMHNzUy3be2vczW4zuxfJM4yY2BD0LUklXKBYrrFC387icLQf3KBVfP/SKXSZ9Rik7cJARyOkgu
 91rIfHdkuhBRrtiP2i48kL9z31GiT3BuUv4CWa13mQiijpY405c6FYwDaXoQI+Z015A==
X-Gm-Gg: AZFdTZdih4GwVFfdEY9dIWB/EiA8MWQEav/8Ul1k7C7o++jWhiGFW3syx9j5Ht36yap
 23381zpdvgy7bOa2f3cixplcj4tg2I2OYIkgccZO12VWNAi+hkuzH1wIZemdfJYeaPO8blkb0vR
 MeK7J4rtxAV6ovw658niw5pXKrtUuDp7T7eIgBvL9CcJSDFs5fAr/YfPQbBqCcJt8qSZ808/yE2
 9RXlCXO1Lb5gm3oQoeAQNpjkJG9J9xxdZXnyVNpdAvHQXGGYz2BCAlSYjKK9Nj8NdMqjMuvs0sV
 MZIIVtLh3XDxMX8sdGPQXYjz0LncFbM4sYjH+XzPPBvZ7fKJP3hR3s8dPZS4z9x3xoj8rO+Oko9
 tMWW9AUNkErkLAmsmbeJsHPThF4v3+10bY624M5cY35JH8eRxCTkUtCvBVt0Cjea+GjDakAQxXm
 sOUSQJJQseS5kvM4Hb1mw0TQ==
X-Received: by 2002:a05:7301:4d04:b0:36f:d53:cf2f with SMTP id
 5a478bee46e88-3827da13cd2mr2789207eec.1.1795022052678; 
 Wed, 18 Nov 2026 09:14:12 -0800 (PST)
X-Received: by 2002:a05:7301:4d04:b0:36f:d53:cf2f with SMTP id
 5a478bee46e88-3827da13cd2mr2789190eec.1.1795022052158; 
 Wed, 18 Nov 2026 09:14:12 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72e52easm8900707eec.17.2026.11.18.09.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:14:11 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 0/2] roms: omit the git reference to h2
Date: Wed, 18 Nov 2026 09:14:08 -0800
Message-Id: <20261118171410.3753915-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: H0i9uTVp3G1yNW88OGYakY6u0O_Z8lDX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2OCBTYWx0ZWRfX8ljjL+tCmR3L
 XrQDZdZPdiYSefT5pRbmIhMHs96hro+tH7/z/zCQpaAE9a8bkCguEWtWFmT+Dgxo3aSyuOpqNGW
 mj3G8MzPrfGcxb8DUChWkZSaYsSTeVc=
X-Authority-Analysis: v=2.4 cv=CdSdd7rl c=1 sm=1 tr=0 ts=6afddce5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=m3dqjBB6mEbZ7OjFtNUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: H0i9uTVp3G1yNW88OGYakY6u0O_Z8lDX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2OCBTYWx0ZWRfX/vohpmC8Av50
 Lh23Nf8NZ2LY2J0Vfw2HKANAQ3nBhfgFpp3+pUbX9qKzYMijSxi9skPJ/u3OFYTi5cMqMFR5U3H
 MBClwDCnHfa+O4+PaYzPCCsZ3ICCgEe2tz7mlTfEywe9WsJavNyB7RU3vlU3AheiLL0hdYtUZdZ
 y2SBpN1m0lhYHtUknQsSOPiCC3rzaQO9vntF0W1k5dTIuLiL/oeloc/RbAOBh5wQT6mUNAJfZrk
 psZAS9yYB5xZi+lqqif2pgWVrLgfOvV8Qi00N7wr3JT04y23lxMUNJSCKYc3vr9hmlB0fM3ZQHi
 4WI0COQoNqVeYJ4igiBwQfAa4OXp5/X6lpYu6nPN+0+B+SluDFUj8czNooFhC+OLC/6gDy5bunn
 Jfjb03ImTZPLWlb4e9Uqu2h9kOS/qLQKovYgRPSQH0USkxmIEsHkHdUsOuTexNVA2CVwIUDgpPr
 PI6nZznKVGEjsCg1L5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180068
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

VXNpbmcgYGdpdCByZXYtcGFyc2VgIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UgZm9yIGEgc291cmNl
IHRhcmJhbGwKZGlzdHJpYnV0aW9uLgoKU3dpdGNoIHRvIHRoZSBwcm9jZXNzIHVzZWQgYnkgZWRr
MjogY2FwdHVyZSB0aGUgdmVyc2lvbiBpbiBhIG1ha2VmaWxlCmluc3RlYWQuCgp2MTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTExMjE3MzkwMS4zNzQ4ODgwLTEtYnJp
YW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoMik6CiAgcm9tczogcmVjb3Jk
IHRoZSBIMiBjb21taXQgaW4gYSBmaWxlCiAgcGMtYmlvczogcmVidWlsZCBIMiBmaXJtd2FyZQoK
IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiBwYy1iaW9z
L1JFQURNRSAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKysrLS0tLQogcGMtYmlvcy9o
ZXhhZ29uX2Jvb3Rlcl9xY3M2NDkwX2Nkc3AgICAgIHwgQmluIDI4NTI5MiAtPiAyODUyOTIgYnl0
ZXMKIHBjLWJpb3MvaGV4YWdvbl9ib290ZXJfc2E4Nzc1cF9jZHNwICAgICB8IEJpbiAyODEyMjQg
LT4gMjgxMjI0IGJ5dGVzCiBwYy1iaW9zL2hleGFnb25fYm9vdGVyX3NhODc5N3BfbnNwMCAgICAg
fCBCaW4gMjg4OTA0IC0+IDI4ODkwNCBieXRlcwogcGMtYmlvcy9oZXhhZ29uX2Jvb3Rlcl9zYzg0
ODB4cF9uc3AwICAgIHwgQmluIDI4ODkwOCAtPiAyODg5MDggYnl0ZXMKIHBjLWJpb3MvaGV4YWdv
bl9ib290ZXJfc204OTc1X25zcCAgICAgICB8IEJpbiAyODg5MDAgLT4gMjg4OTAwIGJ5dGVzCiBw
Yy1iaW9zL2hleGFnb25fbG9hZGxpbnV4X3FjczY0OTBfY2RzcCAgfCBCaW4gMjAwNDI4IC0+IDIw
MDQyOCBieXRlcwogcGMtYmlvcy9oZXhhZ29uX2xvYWRsaW51eF9zYTg3NzVwX2Nkc3AgIHwgQmlu
IDIwMDQ1NiAtPiAyMDA0NTYgYnl0ZXMKIHBjLWJpb3MvaGV4YWdvbl9sb2FkbGludXhfc2E4Nzk3
cF9uc3AwICB8IEJpbiAyMDgxMzYgLT4gMjA4MTM2IGJ5dGVzCiBwYy1iaW9zL2hleGFnb25fbG9h
ZGxpbnV4X3NjODQ4MHhwX25zcDAgfCBCaW4gMjA4MTQwIC0+IDIwODE0MCBieXRlcwogcGMtYmlv
cy9oZXhhZ29uX2xvYWRsaW51eF9zbTg5NzVfbnNwICAgIHwgQmluIDIwODEzMiAtPiAyMDgxMzIg
Ynl0ZXMKIHJvbXMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMiArKysr
KysrKysrKysrKysrKystLS0tCiByb21zL2hleGFnb24taHlwZXJ2aXNvci12ZXJzaW9uICAgICAg
ICAgfCAgIDEgKwogMTQgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCByb21zL2hleGFnb24taHlwZXJ2aXNvci12ZXJzaW9u
CgotLSAKMi4zNC4xCgo=

