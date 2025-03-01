Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D03EC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFON-0004Xf-Pb; Sat, 01 Mar 2025 00:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOH-0004AK-PY
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOG-0008Cn-2J
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:57 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KcRG007742
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OHzT/K66SV1Aiwd/eWNqtB7QLdrvg/gthpRD6975qGs=; b=fOe7KFgIHigluRn2
 it0Rg9jRSksNSt+4keR1kiRTvxJqu2gWhXRnuBp9Wx1GP5+2ozy/0R14aKwx9RRt
 EaWbPo0cRYTCDyqHiiHBZv7a06FSj2Wr+A8Vmjoy3V2c85i4kVv0gBalXGXmgmGn
 aGu1Cu3S4tpHeOfQp+btxpd8tBSXFHEcnvZLefaOmWKj9anVV3TW6Od2pl3ebeLL
 wkkQg6uxJUeCrmG7K+6Ax1j8fd3A8sR8+gXt8KqBCYraG0BBfXukQSRfEhk6Lezq
 ghmhvl7zL/tACoUK45gjxJRbMlML4kT0WRKgjslBS2YNdzmirS3iV75KHxCqSL1H
 4xPr5Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r6a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fec1f46678so4135357a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806848; x=1741411648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OHzT/K66SV1Aiwd/eWNqtB7QLdrvg/gthpRD6975qGs=;
 b=ClA4lCbFKSvnCNwDojwxKHhvPjsh7806LgpsMs67m8zXB12pITKG6TBPH0NUKGqg4j
 FA7dpunCFN8npP9Im5Z/62D+3EYbizHE0E1IPyhK2AGWrtwdzS41liUgk8lumrKpTbWo
 5uKt3UoLdn6USt7h/xErXeAzYjGRB6MCgLoNcn+HeQ+UmsNfSpCNxZjGKogv64Eu0Ld+
 de8YaHRMdUnBU9EL4F3wJeH7w9hWKs/49GBcKTKAwtbMg49g4DjKw6KO/IZjnvb2Uhwx
 u8V7IWNqKgqeToKXJ9F2hJUaXaOtgiy7d/ia+uujeglw8sUV4b56ZNbGTMpLcIZ8XE74
 vDZg==
X-Gm-Message-State: AOJu0Yyv3YfXU5XFQ6hb0lNK+dHJaUIaYOjwp4LzsZWy3UBfmU9DXRc4
 YFpDbinUsqf4nvlxqUytvtfWirnAja0wIa9VGUaulIfz36Pp8SbmVXJUbYgNchrWG1k55i6eK9A
 Q1UuTJuNNLyLJc5jnZCYP9945FodAoJ+lzN0T4FE8WeRTMvHZ4u1LxCHB+7HpKw==
X-Gm-Gg: ASbGncsBcIXwGiEUT9BGwFJRIIGIqdBvKIygzA6QHreZ4Vj6UkqMuVrL5vWyCCZjHtY
 S4l9VXOzzFYdS46ysN34w9uTGiAbg4T9htosyHr8jpN3L0W2zcLZ4xxZ37HCUgJiy3wT8jv8pP5
 M/y/DfLEJlA7lGik9UOq8m3RAa2HCBwb1XC0exFLudF00MhT17jistllUrKskBge5E6ReQn5TSM
 1m8qDWFvifFcYejt+r7inZfnxgYWzDcjVlgglTWcph0y0E6K6S88f/tbwi7V9u03+zF9dWdiMiE
 XMuuoKi9DrjEwkSa4RI0okpG0KVqrxbjMs2NKLcXPAh0af1V4hyHZl7flzeI3QHy
X-Received: by 2002:a17:90b:574c:b0:2fa:b84:b304 with SMTP id
 98e67ed59e1d1-2febabdc1fdmr8509019a91.22.1740806847710; 
 Fri, 28 Feb 2025 21:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHsIXiLGq3MeqAHOSk8P81wBV8WO4C6aG7pEGHYD/mRsUkY8W/YJM1VfUQjvDFckYnrIzTeA==
X-Received: by 2002:a17:90b:574c:b0:2fa:b84:b304 with SMTP id
 98e67ed59e1d1-2febabdc1fdmr8508996a91.22.1740806847394; 
 Fri, 28 Feb 2025 21:27:27 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:27 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 30/38] target/hexagon: Add a TLB count property
Date: Fri, 28 Feb 2025 21:26:20 -0800
Message-Id: <20250301052628.1011210-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: OhiRJgkGT4441bNVY7ag1MfkUQ0ms1HE
X-Proofpoint-GUID: OhiRJgkGT4441bNVY7ag1MfkUQ0ms1HE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmggfCAgMSArCiB0YXJnZXQvaGV4YWdvbi9tYXguaCB8IDI2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8ICA0ICsrKysKIDMgZmlsZXMgY2hhbmdl
ZCwgMzEgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL21h
eC5oCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9j
cHUuaAppbmRleCBmYjY2MTUxYWM5Li4wOTU3ZmFlYWQzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMTY4LDYgKzE2OCw3IEBA
IHN0cnVjdCBBcmNoQ1BVIHsKICAgICBib29sIGxsZGJfY29tcGF0OwogICAgIHRhcmdldF91bG9u
ZyBsbGRiX3N0YWNrX2FkanVzdDsKICAgICBib29sIHNob3J0X2NpcmN1aXQ7CisgICAgdWludDMy
X3QgbnVtX3RsYnM7CiB9OwogCiAjaW5jbHVkZSAiY3B1X2JpdHMuaCIKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL21heC5oIGIvdGFyZ2V0L2hleGFnb24vbWF4LmgKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uMGY1OTViY2I3MwotLS0gL2Rldi9udWxsCisrKyBiL3Rh
cmdldC9oZXhhZ29uL21heC5oCkBAIC0wLDAgKzEsMjYgQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMp
IDIwMTktMjAyNSBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJl
c2VydmVkLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyAq
LworCisjaWZuZGVmIEhFWEFHT05fTUFYX0gKKyNkZWZpbmUgSEVYQUdPTl9NQVhfSAorCisjZGVm
aW5lIE1BWF9FWFRfQ09OVEVYVFMgOAorI2RlZmluZSBNQVhfTDJfSU5URVJMRUFWRVMgMgorI2Rl
ZmluZSBNQVhfVkZJRk9fQ09VTlQgNAorCisjZGVmaW5lIFNMT1RTX01BWCA0CisKKyNkZWZpbmUg
UkVHX1dSSVRFU19NQVggMzIKKyNkZWZpbmUgUFJFRF9XUklURVNfTUFYIDUKKyNkZWZpbmUgU1RP
UkVTX01BWCAyCisjZGVmaW5lIExPQURTX01BWCAyCisjZGVmaW5lIE1BWF9QUkVEIDQKKworI2Rl
ZmluZSBQQUNLRVRfQllURVNfTUFYIDE2CisjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0Cisj
ZGVmaW5lIERUTEJfRU5UUklFUyAxNgorI2RlZmluZSBJVExCX0VOVFJJRVMgMTYKKworI2VuZGlm
IC8qIEhFWEFHT05fTUFYX0ggKi8KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIv
dGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggOTA4MzM5YzA1Mi4uYzRiOWRmMmZjMyAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAg
LTI3LDYgKzI3LDcgQEAKICNpbmNsdWRlICJ0Y2cvdGNnLmgiCiAjaW5jbHVkZSAiZXhlYy9nZGJz
dHViLmgiCiAjaW5jbHVkZSAiY3B1X2hlbHBlci5oIgorI2luY2x1ZGUgIm1heC5oIgogCiBzdGF0
aWMgdm9pZCBoZXhhZ29uX3Y2Nl9jcHVfaW5pdChPYmplY3QgKm9iaikgeyB9CiBzdGF0aWMgdm9p
ZCBoZXhhZ29uX3Y2N19jcHVfaW5pdChPYmplY3QgKm9iaikgeyB9CkBAIC01MSw2ICs1Miw5IEBA
IHN0YXRpYyBPYmplY3RDbGFzcyAqaGV4YWdvbl9jcHVfY2xhc3NfYnlfbmFtZShjb25zdCBjaGFy
ICpjcHVfbW9kZWwpCiB9CiAKIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSBoZXhhZ29uX2NwdV9wcm9w
ZXJ0aWVzW10gPSB7CisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKKyAgICBERUZJTkVf
UFJPUF9VSU5UMzIoImp0bGItZW50cmllcyIsIEhleGFnb25DUFUsIG51bV90bGJzLCBNQVhfVExC
X0VOVFJJRVMpLAorI2VuZGlmCiAgICAgREVGSU5FX1BST1BfQk9PTCgibGxkYi1jb21wYXQiLCBI
ZXhhZ29uQ1BVLCBsbGRiX2NvbXBhdCwgZmFsc2UpLAogICAgIERFRklORV9QUk9QX1VOU0lHTkVE
KCJsbGRiLXN0YWNrLWFkanVzdCIsIEhleGFnb25DUFUsIGxsZGJfc3RhY2tfYWRqdXN0LCAwLAog
ICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfcHJvcF91aW50MzIsIHRhcmdldF91bG9uZyks
Ci0tIAoyLjM0LjEKCg==

