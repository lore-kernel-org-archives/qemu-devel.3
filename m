Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC29C282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPR-0008GI-PM; Sat, 01 Mar 2025 00:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPP-0008Bw-L9
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPN-0008OG-Sc
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:07 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213YXof030222
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 re5D2KJqUvhVHf1xOvqQmsUG78ul/CjshFNorVWxI4c=; b=pLntmXz2ywHxsK4z
 yxo0cRykGdyYKkDR8vKcUpG6Lsl7vrDDAe1EqTpupIUqXI9h/T7PSAq/zE0FXsI7
 RTmPtrbHwIpaUxiSw9/tuJX1JPccdFZF9WTDBH9NxhbxH5bPk8hBK/TthOqtPxrY
 TwQ08hy99lmwR4FO4ySQaXM/fTnQfNNmcU7DRZJ8SrijTPGqNOJRSjYSNO0mKBwm
 IxYnpvO00kYjIX/C7DRtBZRwFrZvShecSiZhJYWWWQPiwR7XHnbe1vZiWkodjN+q
 zQlw55OHozsfdaaJ9itqj4xr6hBDcMcCCsPSu8hunxo2Zb6hflVfbUSaDLwGHCAD
 /TFuig==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tf0g5cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fed0f307ccso1246044a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806943; x=1741411743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=re5D2KJqUvhVHf1xOvqQmsUG78ul/CjshFNorVWxI4c=;
 b=NHCAcVebMl7MSn/ly5keHe6ebJxMrBP3b6mZqF8juExQcIxeWpIwYffSNA5uOpf4sO
 42zitTmhesTwpLwuibdQ6vicI1qGqH9/k2Z0YCUPy+NQTMpzBgu1CKMkOL906afBMA6c
 o5gHfitoGFCzC2Vwss3TYl4LoXik7e1nxmcL0OBGDsKYxa4ebdBI5tSk+lgyAT9N2No+
 obktgCsJFW1tdYW0LlJYu6UuMWTWS6mtKXoZIJqii/FDy+r0+vY3eBpk69nqjgsBG3rj
 xhVXmWJFeXgLMc2BFNs2oDhhMlv/Xi9gay3WJNehi9DdUlu13y1EckdXNms0SuVroSh+
 xG+g==
X-Gm-Message-State: AOJu0Yx7EoJmYh0tMktWKEQ6tyNdebhhv50mmZ91tkW+q3oPWrE6QDoW
 TxE7tkQFTDtughvTjwl4DLcTUhfXDBjQxfP7YpMMhqRTO6nffFfXhFc6kmPjcEJuJa/n4kC+nmu
 aSPbwbZ6ziwpo13tcguxaUzPHUc2CU8n+yCnMKdhRVL+YXhH0vnp1ZfNt6Pu+rQ==
X-Gm-Gg: ASbGnctD2B99lSN9uhqrUWjFGP/n3ua5xgodreAdePaRdTjTSc0JZxYu5oKJGLGc1xd
 P2vIF8qnJF3OKQXj2n3D8blmV7xt4DJe1icVvaUDsvwwGNZCKCEnJMuCN9Vl0/Jzse5XLEuFhEd
 Muf2Q/Gola3L/kh80LUquPFi6maOiAfTarXIqQhTIPtz7GIai6cQWyvaOakMS0VcHodWwDZZGjw
 WxgXwuDqW63iRJ+L1Vq4MKL7x7GiwN4+o+ba8yAefBnzcpzSpUUJ+ITcIwO5a1y2ZlLiQrLwupH
 OYR0UJ5xWbWLdWjB+VqraiLuPE+fIzW0WLFut6rPpRfor5jMJswiKLjsZPa/EbTD
X-Received: by 2002:a17:90b:3e84:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2febac046a6mr7735585a91.23.1740806943550; 
 Fri, 28 Feb 2025 21:29:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkT1/KYmVXi+7t1NmGb62EsUbFVofWUpcD6dWMYzcUbo3c7NpGO+oKPDmQKaccquEzqbnNww==
X-Received: by 2002:a17:90b:3e84:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2febac046a6mr7735565a91.23.1740806943206; 
 Fri, 28 Feb 2025 21:29:03 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:02 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 10/39] target/hexagon: Implement arch_{s, g}et_{thread,
 system}_reg()
Date: Fri, 28 Feb 2025 21:28:16 -0800
Message-Id: <20250301052845.1012069-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Gh2Rd7d79JLjXu2ydOA0LMBCavIoLt7M
X-Proofpoint-ORIG-GUID: Gh2Rd7d79JLjXu2ydOA0LMBCavIoLt7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=688
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1X2hlbHBlci5oIHwgMTMgKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oCmluZGV4IGU4ZDg5ZDg1MjYu
LjFjZGY0ZjhkZDAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKQEAgLTI2LDIwICsyNiwyNyBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgYXJjaF9zZXRfdGhyZWFkX3JlZyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgcmVnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgdmFsKQogewogICAgIGdfYXNzZXJ0KHJlZyA8IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7Ci0g
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBlbnYtPmdwcltyZWddID0gdmFsOwogfQog
CiBzdGF0aWMgaW5saW5lIHVpbnQzMl90IGFyY2hfZ2V0X3RocmVhZF9yZWcoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHVpbnQzMl90IHJlZykKIHsKICAgICBnX2Fzc2VydChyZWcgPCBUT1RBTF9QRVJf
VEhSRUFEX1JFR1MpOwotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgcmV0dXJuIGVu
di0+Z3ByW3JlZ107CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogc3RhdGljIGlubGlu
ZSB2b2lkIGFyY2hfc2V0X3N5c3RlbV9yZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZh
bCkKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIGdfYXNzZXJ0KHJlZyA8IE5V
TV9TUkVHUyk7CisgICAgaWYgKHJlZyA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgeworICAgICAgICBl
bnYtPnRfc3JlZ1tyZWddID0gdmFsOworICAgIH0gZWxzZSB7CisgICAgICAgIGVudi0+Z19zcmVn
W3JlZ10gPSB2YWw7CisgICAgfQogfQorI2VuZGlmCiAKIHVpbnQzMl90IGFyY2hfZ2V0X3N5c3Rl
bV9yZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZyk7CiAKLS0gCjIuMzQuMQoK

