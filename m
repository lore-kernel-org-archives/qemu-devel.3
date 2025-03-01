Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA65C282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQ0-0002Ut-LX; Sat, 01 Mar 2025 00:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPl-00016H-Hg
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:29 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPi-0008Ry-1z
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:29 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213IvGr015427
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y+a+2AedEA2XxZaaxbRakRyUJKJ5FYHgnftitYsRAC0=; b=QVXXmS2Y8Vsxn+1y
 Ext2ja8NuqFkTzvWH6NXrQZUVmvxNKvnE3MR7E5eIBqUfK9NOisscvRQO86hUwQr
 ksmzWPjUl/ob02/1SqpAzhyK5BSJiruH/k8MAQr6mrVsiihQ+VdT6nBmZnp16PSU
 JMqrRN6MYmgCpt7Jjq5A+wsoIztEigYVVPeMGXbLH932XV5X4lPMu5UhRUvlARpL
 CXZUfxdcdA8J8P53530Mi8+zPz7dTVZYP9jvsgVEhDSaBCLhANfNVHokQGrlLO4U
 ZBZwiH+X1w6ImIw71Y/4jDh2xuo6kMPhNhKfhYNMx9YAn387NlVELdCldox9MD9p
 TRugxQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hr6ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2feb47c6757so3929027a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806963; x=1741411763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+a+2AedEA2XxZaaxbRakRyUJKJ5FYHgnftitYsRAC0=;
 b=PYiKGNyR5bhw1o155yOBvP27+qVpee8qdXYgOOqniUDPA1ATJ+0SVWOikg0+BNLVyO
 O9lhAoXxoaEZa297KeqBjsxepSkbCtmnwXCvWo/91Mc3CyNs42A86I/wD5spzYipwd6u
 uzJbsI0m0nW3vwqUp4hx8JfBFurjVZWr7uoy2UgklbJ1IDtAs79bh65qqo2wqNIYQ9Rp
 xfWeA77tGfO1sUlMw2RTHWxCiXuXz9sejsVgKTbWbwsSanaGvxO5DyQ6cUsUtCpEhPi7
 ojKSiJnvnBjw7M2ysXPq8HKTAvuDip802ul2lcCdQDPVQJbXXjECWcEe2U1yXsZjitvK
 zttw==
X-Gm-Message-State: AOJu0Yx0m3OmFgGmUb/HIjWHZ82MYz43kAWv9Nv1u/mHgmaLWgDrg42u
 TOP7A7IbKURcpu7PwOVnj2tB169KdR0bf5niM1DF0ge8Tl6WfeOM9ei9bhL63gnIm8SIJ8pTcre
 Vl0ANTzfDIJzRWlGjkOCMsc9PkIfu62hBe1kky2r73LE2/7QS4eMYVPid51QgwA==
X-Gm-Gg: ASbGncspGnBz829clO/3wXKtQuAFXJW0XNu8gWlI+Yam2heibFmTowbyk+dQERYEQsv
 eVuNxsqfQDVfhm8L8gpXb8a51wGYXTMFSS5kF122uIPdmISpSGbmqHUgbxxxN7sjC7i0qrzsK/Y
 9pqQFhfYDEMUgKL6Aidn4d0JcruF3kKnZBGKvWec5qBYg/yjeEKGSI/EJeaJ5Rg1yyyndjNjCdk
 xFvWE2EuDxCvhIBHVYijAlHSSpcETXEqG1xdjxfnvdtjncmJcn09YLPB25hxztVTcYhpI6qamqf
 xM+xiJOVZ8pjxbDqwgRRtveIDyGvAlMBtfJLKs7ZrC/XV/5wsqyiTxdqTJwSpVRQ
X-Received: by 2002:a17:90b:3a4c:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-2febaa861e5mr11828956a91.0.1740806963562; 
 Fri, 28 Feb 2025 21:29:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo+xIgb+Iz3sU57hGaoi7aZpzHL51HdemA0+IhvYyk2IebbSHfqmq/ioyBfwNzCUzlOsDMlA==
X-Received: by 2002:a17:90b:3a4c:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-2febaa861e5mr11828928a91.0.1740806963221; 
 Fri, 28 Feb 2025 21:29:23 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:22 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 26/39] target/hexagon: Decode trap1, rte as COF
Date: Fri, 28 Feb 2025 21:28:32 -0800
Message-Id: <20250301052845.1012069-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: aKs0gtU1ZPY3FQQTS0tIJmpq2pg3ygnF
X-Proofpoint-ORIG-GUID: aKs0gtU1ZPY3FQQTS0tIJmpq2pg3ygnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=658 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
ZGVjb2RlLmMgfCAxNCArKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhh
Z29uL2RlY29kZS5jCmluZGV4IDIzZGViYTI0MjYuLjVkMGJlZWVhZjIgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC0x
OTMsNiArMTkzLDggQEAgc3RhdGljIGJvb2wgZGVjb2RlX29wY29kZV9jYW5fanVtcChpbnQgb3Bj
b2RlKQogICAgIGlmICgoR0VUX0FUVFJJQihvcGNvZGUsIEFfSlVNUCkpIHx8CiAgICAgICAgIChH
RVRfQVRUUklCKG9wY29kZSwgQV9DQUxMKSkgfHwKICAgICAgICAgKG9wY29kZSA9PSBKMl90cmFw
MCkgfHwKKyAgICAgICAgKG9wY29kZSA9PSBKMl90cmFwMSkgfHwKKyAgICAgICAgKG9wY29kZSA9
PSBKMl9ydGUpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfcGF1c2UpKSB7CiAgICAgICAgIC8q
IEV4Y2VwdGlvbiB0byBBX0pVTVAgYXR0cmlidXRlICovCiAgICAgICAgIGlmIChvcGNvZGUgPT0g
SjRfaGludGp1bXByKSB7CkBAIC0zNzEsNiArMzczLDE4IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9z
aHVmZmxlX2Zvcl9leGVjdXRpb24oUGFja2V0ICpwYWNrZXQpCiAgICAgICAgICAgICBicmVhazsK
ICAgICAgICAgfQogICAgIH0KKyAgICAvKgorICAgICAqIEFuZCBhdCB0aGUgdmVyeSB2ZXJ5IHZl
cnkgZW5kLCBtb3ZlIGFueSBSVEUncywgc2luY2UgdGhleSB1cGRhdGUKKyAgICAgKiB1c2VyL3N1
cGVydmlzb3IgbW9kZS4KKyAgICAgKi8KKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQor
ICAgIGZvciAoaSA9IDA7IGkgPCBsYXN0X2luc247IGkrKykgeworICAgICAgICBpZiAocGFja2V0
LT5pbnNuW2ldLm9wY29kZSA9PSBKMl9ydGUpIHsKKyAgICAgICAgICAgIGRlY29kZV9zZW5kX2lu
c25fdG8ocGFja2V0LCBpLCBsYXN0X2luc24pOworICAgICAgICAgICAgYnJlYWs7CisgICAgICAg
IH0KKyAgICB9CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQKLS0gCjIuMzQuMQoK

