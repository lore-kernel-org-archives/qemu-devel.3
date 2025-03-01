Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEABFC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQF-00046t-6N; Sat, 01 Mar 2025 00:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQ1-0002eH-KK
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPz-0008U6-J2
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:45 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214ngOO022276
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b3HAr2UrxHZXRRS7Rb8rVbVvwzE8SzOmOO3M6Z4w2X4=; b=lq0+mvV+BMz0Th0v
 3lo9bwTFx+NRLGyg750220ko3fwhi4aCbD6Kl5q5p6rk+ZXrwYK/kM8hWZHGz5S+
 tgeg5NjspgeLWWnRvd27iXwUm5uuqQQgHRdm5QLI7xIWzflGqE8cKsn4VxCCzbgR
 tZYjt+X4uocvJUdb1OyezJuoJj9mYWXL4nk+muBKixOc8uWfy93/6Cl+TJIw/zuU
 OKhgzLiFDSUz+uSokUbYqE6bYqEqyGKQ+v9X615WEXTot5yTRjhDy0xxo58ZbBwG
 0rNPEKHwZG7fa76vFy84kPjAmD64wOW8J3sTSJuFRkgZtZBYwEz1n66IAg48vGfZ
 jy2FQA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh70202-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fed20dd70cso1135597a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806971; x=1741411771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3HAr2UrxHZXRRS7Rb8rVbVvwzE8SzOmOO3M6Z4w2X4=;
 b=RRGc2eWXoUi+pzDnS/vP9m6ZAycsASlEChB/uh8LgvW3equemwchfNuELe8HYoOT1W
 p5DQqGJmLLSnLL3MGc+lBRn9+PMYqo4cgWgZ9dtLIQu4s8soJlfnASh16+76JGHOXL0K
 5Vi3Ddh/8RQUs42R358E3fTL09+hXyGfJOtYaFdJx8whH/2p1K5ZzBk89Z7jQoRLuIoh
 WZVu1RTMxrKe7JmGBnE8UtJOgL9cFRyrqAx4zw17ol2ik/huYHfoQ1mmjXdkgxuPho7P
 9H6yOoM3hBFKw8aEgs8Z0ELwa4sjD2tFtZXbl8bezmDLv1dKBaDrBTW5oovo/ADfI8Nh
 oshw==
X-Gm-Message-State: AOJu0Yzt766lXv4V1UJMybEAmJudRmQgfyJ/GyIlk5avyvKHB2NiX2up
 ju5ADjVvqasXggw45MQSiubkxJ/LodDtl28QUhISB+nRhOMmfxQGLeqwgsUHhhImmSsfreO2K1a
 55wp6g26CHRKRgSTO81IM62pzLr7vFst68Sa8cipZiHYbPbr8I8tVbAYKBfq5/Q==
X-Gm-Gg: ASbGnctGpgbYqjsj1mwR11ALF0l4QswoJKWAgidOzu6PiGQN9cV7XjJsS1XKVxnpZMs
 IzOJ3yKkSRsBeQ1lu/3ez9dB2pq43ddDmFf4Mh/oV/OhvJ7p9JBNAfXPQQLuc27VceOiKRTNjxW
 WYc7CFgxqghP/rWMImI2+GAd7n088Pr3uayoz/Ki7HkXjp0Om2z0iuoCZ9h+URkLiRaY0EYE2ID
 ag8jsX7/p3jMYhDWyuaRg0hqKs3ou5epC5EI7PHTRq2Du8Gn32CFfGtCcAUV02W7im1Zwjf3WWd
 pydQ9LHvqrpvL/E6aKVZTeO96iFNX8PTQM+zIyk+AgpryrMLVnh8Eow/JC4gp6Nx
X-Received: by 2002:a17:90b:240d:b0:2fe:e0a9:49d4 with SMTP id
 98e67ed59e1d1-2fee0a94d63mr658204a91.2.1740806971152; 
 Fri, 28 Feb 2025 21:29:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1q2TmtdKOvp6Dmvl4+uT94zg7TpADfOesSzlEsISqc1/l384Jo0wY9/0YBOfeSToRdgKHLA==
X-Received: by 2002:a17:90b:240d:b0:2fe:e0a9:49d4 with SMTP id
 98e67ed59e1d1-2fee0a94d63mr658186a91.2.1740806970802; 
 Fri, 28 Feb 2025 21:29:30 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:30 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 32/39] target/hexagon: Define system, guest reg names
Date: Fri, 28 Feb 2025 21:28:38 -0800
Message-Id: <20250301052845.1012069-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5aUSya_tz9S8f3oipttPAE1XUoXg9wbr
X-Proofpoint-ORIG-GUID: 5aUSya_tz9S8f3oipttPAE1XUoXg9wbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=861 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aW50ZXJuYWwuaCB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdv
bi9pbnRlcm5hbC5oCmluZGV4IDEyMGNmZGU3YjkuLmZkMjM5N2I5ZWYgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2ludGVybmFsLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaApA
QCAtMzQsNiArMzQsOCBAQCB2b2lkIGhleGFnb25fZGVidWdfcXJlZyhDUFVIZXhhZ29uU3RhdGUg
KmVudiwgaW50IHJlZ251bSk7CiB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICpl
bnYpOwogCiBleHRlcm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxf
UEVSX1RIUkVBRF9SRUdTXTsKK2V4dGVybiBjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9zcmVn
bmFtZXNbXTsKK2V4dGVybiBjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9ncmVnbmFtZXNbXTsK
IAogdm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3RhdGUgKmVu
diwKICAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBjN2M0NzBiMDk5Li4zYzQ3NzYy
MzJlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuYwpAQCAtODUsNiArODUsMzUgQEAgY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVn
bmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9SRUdTXSA9IHsKICAgImMyNCIsICJjMjUiLCAiYzI2Iiwg
ImMyNyIsICJjMjgiLCAgImMyOSIsICJjMzAiLCAiYzMxIiwKIH07CiAKKyNpZm5kZWYgQ09ORklH
X1VTRVJfT05MWQorY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fc3JlZ25hbWVzW10gPSB7Cisg
ICAgInNncDAiLCAgICAgICAic2dwMSIsICAgICAgICJzdGlkIiwgICAgICAgImVsciIsICAgICAg
ICAiYmFkdmEwIiwKKyAgICAiYmFkdmExIiwgICAgICJzc3IiLCAgICAgICAgImNjciIsICAgICAg
ICAiaHRpZCIsICAgICAgICJiYWR2YSIsCisgICAgImltYXNrIiwgICAgICAiZ2V2YiIsICAgICAg
ICJ2d2N0cmwiLCAgICAgInMxMyIsICAgICAgICAiczE0IiwKKyAgICAiczE1IiwgICAgICAgICJl
dmIiLCAgICAgICAgIm1vZGVjdGwiLCAgICAic3lzY2ZnIiwgICAgICJzZWdtZW50IiwKKyAgICAi
aXBlbmRhZCIsICAgICJ2aWQiLCAgICAgICAgInZpZDEiLCAgICAgICAiYmVzdHdhaXQiLCAgICJz
MjQiLAorICAgICJzY2hlZGNmZyIsICAgInMyNiIsICAgICAgICAiY2ZnYmFzZSIsICAgICJkaWFn
IiwgICAgICAgInJldiIsCisgICAgInBjeWNsZWxvIiwgICAicGN5Y2xlaGkiLCAgICJpc2Ric3Qi
LCAgICAgImlzZGJjZmcwIiwgICAiaXNkYmNmZzEiLAorICAgICJsaXZlbG9jayIsICAgImJya3B0
cGMwIiwgICAiYnJrcHRjZmcwIiwgICJicmtwdHBjMSIsICAgImJya3B0Y2ZnMSIsCisgICAgImlz
ZGJtYnhpbiIsICAiaXNkYm1ieG91dCIsICJpc2RiZW4iLCAgICAgImlzZGJncHIiLCAgICAicG11
Y250NCIsCisgICAgInBtdWNudDUiLCAgICAicG11Y250NiIsICAgICJwbXVjbnQ3IiwgICAgInBt
dWNudDAiLCAgICAicG11Y250MSIsCisgICAgInBtdWNudDIiLCAgICAicG11Y250MyIsICAgICJw
bXVldnRjZmciLCAgInBtdXN0aWQwIiwgICAicG11ZXZ0Y2ZnMSIsCisgICAgInBtdXN0aWQxIiwg
ICAidGltZXJsbyIsICAgICJ0aW1lcmhpIiwgICAgInBtdWNmZyIsICAgICAicmdkcjIiLAorICAg
ICJyZ2RyIiwgICAgICAgInR1cmtleSIsICAgICAiZHVjayIsICAgICAgICJjaGlja2VuIiwKK307
CisKK0dfU1RBVElDX0FTU0VSVChOVU1fU1JFR1MgPT0gQVJSQVlfU0laRShoZXhhZ29uX3NyZWdu
YW1lcykpOworCitjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9ncmVnbmFtZXNbXSA9IHsKKyAg
ICAiZ2VsciIsICAgICAgICJnc3IiLCAgICAgICAiZ29zcCIsICAgICAgImdiYWR2YSIsICAgICJn
Y29tbWl0MXQiLAorICAgICJnY29tbWl0MnQiLCAgImdjb21taXQzdCIsICJnY29tbWl0NHQiLCAi
Z2NvbW1pdDV0IiwgImdjb21taXQ2dCIsCisgICAgImdwY3ljbGUxdCIsICAiZ3BjeWNsZTJ0Iiwg
ImdwY3ljbGUzdCIsICJncGN5Y2xlNHQiLCAiZ3BjeWNsZTV0IiwKKyAgICAiZ3BjeWNsZTZ0Iiwg
ICJncG11Y250NCIsICAiZ3BtdWNudDUiLCAgImdwbXVjbnQ2IiwgICJncG11Y250NyIsCisgICAg
Imdjb21taXQ3dCIsICAiZ2NvbW1pdDh0IiwgImdwY3ljbGU3dCIsICJncGN5Y2xlOHQiLCAiZ3Bj
eWNsZWxvIiwKKyAgICAiZ3BjeWNsZWhpIiwgICJncG11Y250MCIsICAiZ3BtdWNudDEiLCAgImdw
bXVjbnQyIiwgICJncG11Y250MyIsCisgICAgImczMCIsICAgICAgICAiZzMxIiwKK307CisjZW5k
aWYKIC8qCiAgKiBPbmUgb2YgdGhlIG1haW4gZGVidWdnaW5nIHRlY2huaXF1ZXMgaXMgdG8gdXNl
ICItZCBjcHUiIGFuZCBjb21wYXJlIGFnYWluc3QKICAqIExMREIgb3V0cHV0IHdoZW4gc2luZ2xl
IHN0ZXBwaW5nLiAgSG93ZXZlciwgdGhlIHRhcmdldCBhbmQgcWVtdSBwdXQgdGhlCi0tIAoyLjM0
LjEKCg==

