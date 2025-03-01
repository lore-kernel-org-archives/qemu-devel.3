Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80011C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFOC-0003lq-Rd; Sat, 01 Mar 2025 00:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOA-0003fR-E3
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:50 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFO8-0008B9-NE
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:49 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213PdbY006219
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KB65+06eYUxtG/G8WvhPuRdXJbtBfuZWhE0K8yvX/wk=; b=lGp1sZmiTDkiAjUl
 8okURVpE7tDZ4ARmChW2/SiWws2o2qbjDqtPFtof7BC6LZrxSZ4tVxfYJuhDMYn4
 YJg/Ly3i1j2X0ooCmWJfPl6PxYtFUHNcxpQjELGnCYttjiVhSG6rgZWBHUhYK+UA
 MgTbpCedqxoj/AN5gYtzc0DA69fn3EHqhIDpNrnPKgGpsowgny3dtwmTudTQ23zV
 cFTkfTb1VgxWcKpjpgMUvSlyRvH2hbKygHxAdMmSz6ur0mCNG21n7zpoqfB7K+lR
 J4HuY1Wmdn1XJ2XTV8G9lsPudbPGSqd1gNAq3w0SzKET2NawuIhSdJViOIwG/TL/
 BF+x4Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tas85qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2feda472a38so462207a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806845; x=1741411645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KB65+06eYUxtG/G8WvhPuRdXJbtBfuZWhE0K8yvX/wk=;
 b=X5BUnYjlUkUzr6zmQDKo5/Z8dav2r5BCtyGN+fjP2MnVDO0ib6ReCfsD9LpAlbOUfG
 s3KD/xwfXtFWFrZ8QCfHSdIllQVskYBz+48U7aFRoPMuuIVrubXwVKxZqtciP0uMfCcL
 cJhDh8xtKz0rUtHzFx33kyPJ5yJtuuym0Msv+aKtCgVmUBWL4yvXLQUcr1EHVwws6GBt
 A1ONqGoZYT292TvUx2dT8glWlcodHi8Dj65UXVDIm0LIjM/4JnT69Z3Ka/OIHv1o8UCN
 RqL25ZsgBZIbmrU6Agw8m8ZNNwKgPp+ekmUszzrk4HqL0HXMNmgOdACcpIaid+JEzgfM
 qr6A==
X-Gm-Message-State: AOJu0Yz+5R6LCycQMZ/tOr1WoUKHE2NwkmXWSr5Qf785TM7Jidv7Ef/f
 b1cqTOJRwQ7SSo31s9FpYJ0egNDBTWgC4wfoV16T+G3FkFvjTtMJPcN8hFunST2Q5QLXZ9SUwzZ
 nlEJQko1c9/Ce2AkRCzLpWhEF7bs+z7TxgUHrUrf2mW/vP4uL9BCazRT1h7SQkg==
X-Gm-Gg: ASbGncvXV0tGm0xPIfSxQ+bSCScn9fTbi9vlf/FlG+8QW6BlbUFCvJ3rWVLyQ6KSaRe
 PS1ZivXjLORAyW/kBhOTBl1ILlfbKk1RxEG8KR80iJk0w8UQJ73pDR/xhkYhho6tfh40OpLPpPj
 sP2K17hzYl7BYLjQWRaDCvn/UlmmwZdGO84E5RKUkI2iWccETcc4dq1S/Lk1bpGEQYlRHzdLqAh
 /wDpmCgnYG4xLkY6uFYKJoDX246EFjXS5z/zk9wVWpu4itjq89LGHC5ZkQYVkDR0XhaaH7PInma
 gYpZpcnw2NKcebOpb1BgAf2IB5+wIku88SpSVy9QFuPGlzHl3JAeze0nuPBKBqtN
X-Received: by 2002:a17:90b:1e44:b0:2ee:5edc:4b2 with SMTP id
 98e67ed59e1d1-2febab78d59mr10297166a91.20.1740806845315; 
 Fri, 28 Feb 2025 21:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl6cfIkbTKER6+u5P8iOIKT+WvELGMVv10HBCWJ5drZIMonC3RGyYY9lboAq3fA5y0/sa9qw==
X-Received: by 2002:a17:90b:1e44:b0:2ee:5edc:4b2 with SMTP id
 98e67ed59e1d1-2febab78d59mr10297142a91.20.1740806844951; 
 Fri, 28 Feb 2025 21:27:24 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:24 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
Date: Fri, 28 Feb 2025 21:26:18 -0800
Message-Id: <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 7bpgKKBvEO46kYb8z0hXe7ACAT8-O6Qz
X-Proofpoint-ORIG-GUID: 7bpgKKBvEO46kYb8z0hXe7ACAT8-O6Qz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRl
eCAzNmE5M2NjMjJmLi4yYjZhNzA3ZmNhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMjYsNiArMjYsNyBAQAogI2luY2x1ZGUg
ImZwdS9zb2Z0ZmxvYXQtaGVscGVycy5oIgogI2luY2x1ZGUgInRjZy90Y2cuaCIKICNpbmNsdWRl
ICJleGVjL2dkYnN0dWIuaCIKKyNpbmNsdWRlICJjcHVfaGVscGVyLmgiCiAKIHN0YXRpYyB2b2lk
IGhleGFnb25fdjY2X2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0KIHN0YXRpYyB2b2lkIGhleGFn
b25fdjY3X2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0KQEAgLTI5MCwxMSArMjkxLDE4IEBAIHN0
YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0
eXBlKQogICAgIHNldF9mbG9hdF9kZWZhdWx0X25hbl9wYXR0ZXJuKDBiMTExMTExMTEsICZlbnYt
PmZwX3N0YXR1cyk7CiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIEhleGFnb25DUFUg
KmNwdSA9IEhFWEFHT05fQ1BVKGNzKTsKKwogICAgIGlmIChjcy0+Y3B1X2luZGV4ID09IDApIHsK
ICAgICAgICAgbWVtc2V0KGVudi0+Z19zcmVnLCAwLCBzaXplb2YodGFyZ2V0X3Vsb25nKSAqIE5V
TV9TUkVHUyk7CiAgICAgfQogICAgIG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHRhcmdl
dF91bG9uZykgKiBOVU1fU1JFR1MpOwogICAgIG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih0
YXJnZXRfdWxvbmcpICogTlVNX0dSRUdTKTsKKworICAgIGlmIChjcy0+Y3B1X2luZGV4ID09IDAp
IHsKKyAgICAgICAgYXJjaF9zZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX01PREVDVEwsIDB4
MSk7CisgICAgfQorICAgIGFyY2hfc2V0X3N5c3RlbV9yZWcoZW52LCBIRVhfU1JFR19IVElELCBj
cy0+Y3B1X2luZGV4KTsKICNlbmRpZgogfQogCi0tIAoyLjM0LjEKCg==

