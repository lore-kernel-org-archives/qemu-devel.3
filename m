Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFB4C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQI-0004Lp-4y; Sat, 01 Mar 2025 00:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQB-0003cv-NH
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:55 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQ9-0008W6-IJ
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:55 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214dhpY027225
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m7ve21Big8YOeoSFWM+5YYRxjYNcRFf4jgBnogSwwiM=; b=cIMtFetaX+qTPapi
 hOUf3fy2muUab4vX6Z0aJ4oyKM1HE5xr0Z2l0fK4upwwrPkxKDKVs3OlgcKCFqQY
 EPHZYtxm7NPnKlGuOCK51Isfn/u85gvnkZoASE7qYPnQ1HUkPsjynDGUoHKxvZHs
 ZMxxzbNYBpM67FLSHJZK3pdfacN+HTwuwdt79XiUFSlyTqHG6sBYCNHbhMDP3CZU
 U1KUV2fs3JsrO0AiHdocwN8W6+iQsxqQko73FPKIFgxg4bkeTAWYJzODNx54JLSD
 9g/hotCWiGi/ePwb9UQ0Prdnp+jeAIV7+XpxmvHsQ3ElcfWRf78qGyQgMSqYDbYW
 FBn14g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453udgr2b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22379af38e0so14447755ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806981; x=1741411781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7ve21Big8YOeoSFWM+5YYRxjYNcRFf4jgBnogSwwiM=;
 b=AjmCyRXSnJf6Vtc3Dv1sb2KrPNH1SQtj5aTHsTXtSQcbf+g9ICdlcFmQWQnMsMveEi
 327VHlxnC9VYIhgtOF8xbAfkoxumEi+bGzjdkEqzZLfOmFokCrU38g8nEd+X8EbKahPm
 yXto03v6Vhoe2bBhFpjJagr2CYjud7UVT7sBnI1nAnr25mZ+alXQKqnuqQ03v4UuG5FC
 BYG32miO4dmvvPMsO3Bbr2g3WPLiHOi3Fcf9MuiwqD0lcxXhAbY4+kzTWQEsDdWbQDlz
 QH1cQeDSG1H4JMbQdVJnkr8r5jcrzC2KOcGS+gkyqqPYd1bBimlTX3Z+h7zZBvhybqds
 4vNA==
X-Gm-Message-State: AOJu0Yzll0BYxo0U5tCHOmSRWKd5bbAMkNidCETbwhDGYC5tWo3pei5j
 U3mV4w/EqLaSgz6gbLtrdSwfzbIf9RtBtNszfK3xr6JdhHGLm/huvYq2y4ZQ43bAP7MCNZ0WIrI
 dZmSOurvzTBEXnEMBgukGwA2yqq0AvXQRyDA/W/uX0Nudgz9UHo1s+y14gw+okg==
X-Gm-Gg: ASbGnctvxPP1AhwNE+/m8I5iVj8MVFk0X9detPBsYXMGDMQkd/lnzJdUphWBFAFb3bE
 d5XTq2wsyw/982a79o30xZBwB4UzQ0Hk0wzPihq01XshCTYPnuWzjgN2LQxSM8tZmg3hFbzH3Kt
 MojgLgw+sedth6JGpmdww7TdMBEnK1FNrWObqNA4JV0P9BQylEVzVmZl7IcwuHbGzNLkQibKMRy
 yMmOA+swFUHcF9Jg3UTMTsKlvPL0iZgKFx7MHa++rLJULv/gDoTJYXVhSbjNL3aegWBe1qMo6VS
 /kjXPonSjAC41EZKfUcfRIkxbDDBcVsxKjcENIYHRIYmmnMxhmLJQp9aZ9zbgH/8
X-Received: by 2002:a17:902:d48f:b0:223:570d:b4b1 with SMTP id
 d9443c01a7336-22368f6ddf8mr105826935ad.1.1740806980985; 
 Fri, 28 Feb 2025 21:29:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK3n57yX3zMm3esW9LJrcdklibuQQw/TKXx3kaekWPw4l77ey3tyoevlcSPpUqlHlUTEqktQ==
X-Received: by 2002:a17:902:d48f:b0:223:570d:b4b1 with SMTP id
 d9443c01a7336-22368f6ddf8mr105826645ad.1.1740806980656; 
 Fri, 28 Feb 2025 21:29:40 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:40 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH 39/39] target/hexagon: Add pcycle setting functionality
Date: Fri, 28 Feb 2025 21:28:45 -0800
Message-Id: <20250301052845.1012069-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: RBjK4fBCfTX1B8BOYAX0sX9pHrND_-8S
X-Proofpoint-ORIG-GUID: RBjK4fBCfTX1B8BOYAX0sX9pHrND_-8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=544 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpT
aWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRoYmVybkBx
dWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgfCAxMCArKysrKysr
LS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAxNyArKysrKysrKysrKysrKy0tLQog
MiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
ODBmNWUyMzc5NC4uNGNhNmFkZDgzNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMK
KysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQ0MCwxOSArNDQwLDIzIEBAIHN0YXRpYyB2
b2lkIGhleGFnb25fY3B1X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQog
I2VuZGlmCiAKICAgICBxZW11X2luaXRfdmNwdShjcyk7Ci0jaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKICAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworI2lmbmRlZiBDT05G
SUdfVVNFUl9PTkxZCiAgICAgaGV4X21tdV9yZWFsaXplKGVudik7CiAgICAgaWYgKGNzLT5jcHVf
aW5kZXggPT0gMCkgewogICAgICAgICBlbnYtPmdfc3JlZyA9IGdfbmV3MCh0YXJnZXRfdWxvbmcs
IE5VTV9TUkVHUyk7Ci0gICAgICAgIGVudi0+Z19wY3ljbGVfYmFzZSA9IGdfbWFsbG9jMChzaXpl
b2YoKmVudi0+Z19wY3ljbGVfYmFzZSkpOwogICAgIH0gZWxzZSB7CiAgICAgICAgIENQVVN0YXRl
ICpjcHUwID0gcWVtdV9nZXRfY3B1KDApOwogICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmVudjAg
PSBjcHVfZW52KGNwdTApOwogICAgICAgICBlbnYtPmdfc3JlZyA9IGVudjAtPmdfc3JlZzsKLSAg
ICAgICAgZW52LT5nX3BjeWNsZV9iYXNlID0gZW52MC0+Z19wY3ljbGVfYmFzZTsKICAgICB9CiAj
ZW5kaWYKKyAgICBpZiAoY3MtPmNwdV9pbmRleCA9PSAwKSB7CisgICAgICAgIGVudi0+Z19wY3lj
bGVfYmFzZSA9IGdfbWFsbG9jMChzaXplb2YoKmVudi0+Z19wY3ljbGVfYmFzZSkpOworICAgIH0g
ZWxzZSB7CisgICAgICAgIENQVVN0YXRlICpjcHUwID0gcWVtdV9nZXRfY3B1KDApOworICAgICAg
ICBlbnYtPmdfcGN5Y2xlX2Jhc2UgPSBjcHVfZW52KGNwdTApLT5nX3BjeWNsZV9iYXNlOworICAg
IH0KIAogICAgIG1jYy0+cGFyZW50X3JlYWxpemUoZGV2LCBlcnJwKTsKIH0KZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIu
YwppbmRleCA5YzQ0Y2I3OTUwLi4wOGM3NDllOWZhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCkBAIC03MCwx
OCArNzAsMjkgQEAgdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coQ1BV
SGV4YWdvblN0YXRlICplbnYpCiB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfaGln
aChDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgdWludDMyX3QgY3ljbGVzX2hpKQogewot
ICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3QgY3VyX2N5Y2xlcyA9IGhl
eGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICB1aW50NjRfdCBjeWNsZXMgPQor
ICAgICAgICAoKHVpbnQ2NF90KWN5Y2xlc19oaSA8PCAzMikgfCBleHRyYWN0NjQoY3VyX2N5Y2xl
cywgMCwgMzIpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBjeWNsZXMp
OwogfQogCiB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25T
dGF0ZSAqZW52LAogICAgICAgICB1aW50MzJfdCBjeWNsZXNfbG8pCiB7Ci0gICAgZ19hc3NlcnRf
bm90X3JlYWNoZWQoKTsKKyAgICB1aW50NjRfdCBjdXJfY3ljbGVzID0gaGV4YWdvbl9nZXRfc3lz
X3BjeWNsZV9jb3VudChlbnYpOworICAgIHVpbnQ2NF90IGN5Y2xlcyA9IGV4dHJhY3Q2NChjdXJf
Y3ljbGVzLCAzMiwgMzIpIHwgY3ljbGVzX2xvOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVf
Y291bnQoZW52LCBjeWNsZXMpOwogfQogCiB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291
bnQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQ2NF90IGN5Y2xlcykKIHsKLSAgICBnX2Fzc2Vy
dF9ub3RfcmVhY2hlZCgpOworICAgICooZW52LT5nX3BjeWNsZV9iYXNlKSA9IGN5Y2xlczsKKwor
ICAgIENQVVN0YXRlICpjczsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBDUFVIZXhh
Z29uU3RhdGUgKmVudl8gPSBjcHVfZW52KGNzKTsKKyAgICAgICAgZW52Xy0+dF9jeWNsZV9jb3Vu
dCA9IDA7CisgICAgfQogfQogCiBzdGF0aWMgdm9pZCBzZXRfd2FpdF9tb2RlKENQVUhleGFnb25T
dGF0ZSAqZW52KQotLSAKMi4zNC4xCgo=

