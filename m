Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE44C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFOF-00041S-T1; Sat, 01 Mar 2025 00:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOE-0003pM-8h
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:54 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOC-0008BU-Ik
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:53 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214jQp5007534
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A9gNZELgJqbbUPM1U1dqZ4plaRvgvVErlAnhKG0UXw0=; b=SDykqwM/GzY7YQUw
 zvRRzT6YS1LzN3Lc0pJG+V7mIaQlGXVLSbYDa2SOSIr2MExMsQKJuX1xko0QvWYw
 fe+ZLZRm1H9gg4cgyiGv/V/CoovnSuHw6BaD6kxOS/QDG7o5fIUyA63PBzr5vT0n
 0GxltZpGMthRVgMB2TQ7LqWanbsZsSrr0MoaJ/zc5CMxF/HoHnirCSf5poBGtHLW
 iMO74dDS6LHBCkBWUJV3yHs6cuGhgC1C1amG8d+UwMBWpXnBe1MGELEklSdNIlhp
 +DfYZ7kNAmCFIVCnydj2WL5BCstb0z+kgaaq+KEBRwtaGWRF+QF8oDdGT2ltORGC
 KLnT6w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t89r64v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2234dddbd6fso63070395ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806849; x=1741411649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9gNZELgJqbbUPM1U1dqZ4plaRvgvVErlAnhKG0UXw0=;
 b=WuiVQLhpWa42QMjXLhr7o2ZwiGqVlpfjRlq7mrBIiczae77W0D1bZa1DljRKjmt411
 F6Np5zZRwXIAvvPkBDECdxdTiPar2s7qQYGXLlEyMnPMcdJzJC8UWAA08uoIOvPZ/4vK
 ClXaAXk1ZHKeJnVNarhLUPbd6ntw8PrAPZFlSGbxkphbW3cF2ql57vhE8OjJ1xO2szVD
 Eiz3oSrkvOpHr1Eq9MXlgigP7D7pt40eO82aCmSCzIn6YkczlFz6HKdyVH9ACNUuFhTm
 P4LOhfpJDybO4WKrgcVGsMREQyV3YfZ3ClJk4cxW/8nPNd5iW7hPy55+OVYb4CFANfQ2
 QczA==
X-Gm-Message-State: AOJu0Yxg1TsbzOe0qhGF4ITURcg6/EdXnqMnth+faDbG/nvKQj7kHvvL
 9HjBkddNxaxLoR1vKnb4k7MHjNqEgLgTq7tzfwQpfZCjNP8qgUNbswRkXnRxC/hFFSKRqyOUi7s
 8xKgWydJT59EFkfxJHR5GFJt6Kv0c/HFH9HzQw7XexOHcLTaP9lxY6p3GUozYxA==
X-Gm-Gg: ASbGncsDXNCiZlJ4MaidiELXjN8DPeolCMUIZFxfNyMx+DGKVNnS37hn6/2/R9IL/Jf
 SE0BC16xpowzHTuaLKeEM3sCj4XKJqIt7hMt22RoNY9Qi5d2jEEE2jqHAF52R5jB3q9iK6eGjtD
 aCqxiqTqd87c6TAz1GrDBg1qzRaby0NWyE+GdDlLc1wHJHjXnLGJGbhj3LoFQu9VgwvvcaRQiAQ
 YInqEt29bAs92X9XcHU+8mqSn8oLqD2/Cbh5x7+H93ocnxy0zQeBJMUTXZ7SYe2L1CITt8b7/XK
 tRkcEOSV5R1TX3+IgepNWygey118YsRIVciNk5R5kuhGcDmEuiqpcONL49f6kAi+
X-Received: by 2002:a17:903:1987:b0:223:517a:d5a9 with SMTP id
 d9443c01a7336-223517ad897mr154986955ad.15.1740806848958; 
 Fri, 28 Feb 2025 21:27:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoIZhCT7adNhTg9L95IFVfdhmsY8zgZ9Y0wNqbxqeFhRWVO41G3U2nxfwuPbbmoHKwehbaGQ==
X-Received: by 2002:a17:903:1987:b0:223:517a:d5a9 with SMTP id
 d9443c01a7336-223517ad897mr154986625ad.15.1740806848559; 
 Fri, 28 Feb 2025 21:27:28 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:28 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 31/38] target/hexagon: Add {TLB, k0}lock, cause code,
 wait_next_pc
Date: Fri, 28 Feb 2025 21:26:21 -0800
Message-Id: <20250301052628.1011210-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: qcNWxMsBjDcnzoKEkqaYmv128pm5zf4d
X-Proofpoint-GUID: qcNWxMsBjDcnzoKEkqaYmv128pm5zf4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=999
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7VExCLGswfWxvY2sgY291bnRz
IGFyZSB1c2VkIHRvIHJlcHJlc2VudCB0aGUgVExCLCBrMCBsb2NrcyBhbW9uZwpoYXJkd2FyZSB0
aHJlYWRzLgoKd2FpdF9uZXh0X3BjIHJlcHJlc2VudHMgdGhlIHByb2dyYW0gY291bnRlciB0byBz
ZXQgd2hlbiByZXN1bWluZyBmcm9tCmEgd2FpdC1mb3ItaW50ZXJydXB0cyBzdGF0ZS4KCmNhdXNl
X2NvZGUgY29udGFpbnMgdGhlIHByZWNpc2UgZXhjZXB0aW9uIGNhdXNlLlRoaXMgd2lsbCBiZSB1
c2VkIGJ5CnN1YnNlcXVlbnQgY29tbWl0cy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAg
fCA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDQgKysrKwogdGFyZ2V0L2hleGFn
b24vbWFjaGluZS5jIHwgNCArKysrCiAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5o
CmluZGV4IDA5NTdmYWVhZDMuLmRkYzExNThkOGUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0xMDMsNiArMTAzLDcgQEAgdHlw
ZWRlZiBzdHJ1Y3QgewogdHlwZWRlZiBzdHJ1Y3QgQ1BVQXJjaFN0YXRlIHsKICAgICB0YXJnZXRf
dWxvbmcgZ3ByW1RPVEFMX1BFUl9USFJFQURfUkVHU107CiAgICAgdGFyZ2V0X3Vsb25nIHByZWRb
TlVNX1BSRUdTXTsKKyAgICB0YXJnZXRfdWxvbmcgY2F1c2VfY29kZTsKIAogICAgIC8qIEZvciBj
b21wYXJpbmcgd2l0aCBMTERCIG9uIHRhcmdldCAtIHNlZSBhZGp1c3Rfc3RhY2tfcHRycyBmdW5j
dGlvbiAqLwogICAgIHRhcmdldF91bG9uZyBsYXN0X3BjX2R1bXBlZDsKQEAgLTExNiwxMSArMTE3
LDE0IEBAIHR5cGVkZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgdGFyZ2V0X3Vsb25nICpn
X3NyZWc7CiAKICAgICB0YXJnZXRfdWxvbmcgZ3JlZ1tOVU1fR1JFR1NdOworICAgIHRhcmdldF91
bG9uZyB3YWl0X25leHRfcGM7CiAKICAgICAvKiBUaGlzIGFsaWFzIG9mIENQVVN0YXRlLmNwdV9p
bmRleCBpcyB1c2VkIGJ5IGltcG9ydGVkIHNvdXJjZXM6ICovCiAgICAgdGFyZ2V0X3Vsb25nIHRo
cmVhZElkOwogICAgIGhleF9sb2NrX3N0YXRlX3QgdGxiX2xvY2tfc3RhdGU7CiAgICAgaGV4X2xv
Y2tfc3RhdGVfdCBrMF9sb2NrX3N0YXRlOworICAgIHRhcmdldF91bG9uZyB0bGJfbG9ja19jb3Vu
dDsKKyAgICB0YXJnZXRfdWxvbmcgazBfbG9ja19jb3VudDsKICAgICB0YXJnZXRfdWxvbmcgbmV4
dF9QQzsKICNlbmRpZgogICAgIHRhcmdldF91bG9uZyBuZXdfdmFsdWVfdXNyOwpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBjNGI5
ZGYyZmMzLi43YzM0ZDAxNWEzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzEyLDcgKzMxMiwxMSBAQCBzdGF0aWMgdm9pZCBo
ZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKICAgICBl
bnYtPnRocmVhZElkID0gY3MtPmNwdV9pbmRleDsKICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID0g
SEVYX0xPQ0tfVU5MT0NLRUQ7CiAgICAgZW52LT5rMF9sb2NrX3N0YXRlID0gSEVYX0xPQ0tfVU5M
T0NLRUQ7CisgICAgZW52LT50bGJfbG9ja19jb3VudCA9IDA7CisgICAgZW52LT5rMF9sb2NrX2Nv
dW50ID0gMDsKICAgICBlbnYtPm5leHRfUEMgPSAwOworICAgIGVudi0+d2FpdF9uZXh0X3BjID0g
MDsKKyAgICBlbnYtPmNhdXNlX2NvZGUgPSAtMTsKICNlbmRpZgogfQogCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgYi90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMKaW5kZXgg
ZGM5MDA0MjJmNC4uOWZkYWZiNDU3MyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjaGlu
ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwpAQCAtMjIsNyArMjIsMTEgQEAgY29u
c3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4YWdvbl9jcHUgPSB7CiAgICAgICAgIFZN
U1RBVEVfVUlOVFRMKGVudi5uZXh0X1BDLCBIZXhhZ29uQ1BVKSwKICAgICAgICAgVk1TVEFURV9V
SU5UVEwoZW52LnRsYl9sb2NrX3N0YXRlLCBIZXhhZ29uQ1BVKSwKICAgICAgICAgVk1TVEFURV9V
SU5UVEwoZW52LmswX2xvY2tfc3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJ
TlRUTChlbnYudGxiX2xvY2tfY291bnQsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJ
TlRUTChlbnYuazBfbG9ja19jb3VudCwgSGV4YWdvbkNQVSksCiAgICAgICAgIFZNU1RBVEVfVUlO
VFRMKGVudi50aHJlYWRJZCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVFRMKGVu
di5jYXVzZV9jb2RlLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UVEwoZW52Lndh
aXRfbmV4dF9wYywgSGV4YWdvbkNQVSksCiAgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQog
ICAgIH0sCiB9OwotLSAKMi4zNC4xCgo=

