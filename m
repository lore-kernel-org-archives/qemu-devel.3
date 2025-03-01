Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4EDC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPo-0001LS-PB; Sat, 01 Mar 2025 00:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPm-0001Bb-Q7
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPk-0008Pg-4R
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:30 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MR3S026429
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mfB0EeKRtw26M5FNaa9ijXS/lZpdTLSQs/8nX4DbdCY=; b=LuXyX4XVPmwkz5Iq
 gObBoJlUew59cZysncXkHORZl/xNb0jmz6FLFHSh43rhHMdEgOCsPPMvs1oLBRu3
 3/aEpb7vlvGNVsfH9UvpScxpWC2VWKV84DFN5Qs12muGmp04xqFe5Y2B5+ArKmOw
 qi8ynMZlyYt+etnQ4nbsDP/0B2x261XH4NldEX/DA2rEkEe8HCIwMW1QEIkF5N1k
 nxjnrGWEVuSy7aEgLLC9STnBLqxmWhTxyJivYWy58tcVCC9GXdS9G6LbRvXAUQTz
 h+PLixOuArNyaR94qIc8WkU2wYeQ6UIpFsObSI6wfXG/RIodAkC76AdCf8kXZzGT
 OPNyNw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t9905rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fe8de1297eso5818599a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806956; x=1741411756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfB0EeKRtw26M5FNaa9ijXS/lZpdTLSQs/8nX4DbdCY=;
 b=bF/17LT71NctG/Thy1CGZN1EjOCwAieZQCYlOXcuhn0M9Ab7hmEOkV/PH+lgNvf7TQ
 oIY/GBT8nYB/ZGbHgB4sR8XwV7d7UEzhpYBVklJ+XFAMKoT59uykynV1t1jIA1qrCMWv
 G5SWPQODY0HzenPeOl609yWZTFiYBmNp1hFMgwkfhYRg5onqUiwlGUnz5vUhoJksmntx
 ljCLkM6feoY1jaex7dYo7jhg0/023OxbS7chqrmbcBfERXiZr/bMLU8TxKpW1EsBW+vO
 VX7FNAcW1LYtmtTgJCiGy8NBXRivLUZI8Jf26P0xzUFDLHq9TW9FKlkfF4ivcxVI90Pu
 emLw==
X-Gm-Message-State: AOJu0YwvIpZwC4LA6UF5Qm9vvniyUGjaBlQSRo3yTJe50fTFLoCM/vn6
 L8breo43dbtYgxgInrOqiDpr1gS3QW1ocFEXVSLwsgMOeiT57lPzywYyNEw/fXSKm52rLXLjvwI
 T96nmJH3VY1QI7vqdrnSWdsesJomFINsvkvgfhaHNAAkiYWCtNlkxnswpcfVdOQ==
X-Gm-Gg: ASbGncshRWVEX5b93FLVuBV5Gp1qIk9g1WxhLGflTR86UOtixAFC0m0tWPxF3Wd3izP
 rBJZLBEUqhm/uPlx59aOLiqGvx2MWqBfKu2R9tDmg6OSt1DTqM8xg+/mjR2GB4NMYZQPC4tp6vP
 Zi/5JORvmdxWRA/JXOk63VAmOij8yEh+vHDFmuBV5JmtYW5yOy1SJqYJo7/mNNFzJ1DUid7ibuE
 j44r7JmU2GXY5FyuVO3J44JuYDfiSLSDnB8tHo1ec7AHnF5/y3aJDbMy76hTCexAxZKR77+5aeR
 KZOzq9YGGtlUNhXpSJHS1gtSxWYSyp98IdBmrFeE4cjK83NdLnFiwIa6xBZ9cAAB
X-Received: by 2002:a17:90a:ec86:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-2fea12683d9mr16744219a91.1.1740806955910; 
 Fri, 28 Feb 2025 21:29:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM0c/Va/LvuaBluLZn3X6d4Tfo6FzPCf1yn791KCrOYGs+bpLxRumfEdRTazkPs3CxSSPfEQ==
X-Received: by 2002:a17:90a:ec86:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-2fea12683d9mr16744197a91.1.1740806955547; 
 Fri, 28 Feb 2025 21:29:15 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:15 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 20/39] target/hexagon: Implement siad inst
Date: Fri, 28 Feb 2025 21:28:26 -0800
Message-Id: <20250301052845.1012069-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: E4b8Znse9Ueex9CD00m0kjqaxp4mLEhX
X-Proofpoint-GUID: E4b8Znse9Ueex9CD00m0kjqaxp4mLEhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=380
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMTAgKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
IGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggNjg3ZTdmNDVjMi4uMTE4ZjExMjQ4
NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTEzNzgsNyArMTM3OCwxNSBAQCB2b2lkIEhFTFBFUihjaWFk
KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc2lh
ZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiB7Ci0gICAgZ19hc3NlcnRf
bm90X3JlYWNoZWQoKTsKKyAgICB1aW50MzJfdCBpcGVuZGFkOworICAgIHVpbnQzMl90IGlhZDsK
KworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaXBlbmRhZCA9IFJFQURfU1JFRyhIRVhfU1JF
R19JUEVOREFEKTsKKyAgICBpYWQgPSBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFEKTsK
KyAgICBmU0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFELCBpYWQgfCBtYXNrKTsKKyAgICBh
cmNoX3NldF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdfSVBFTkRBRCwgaXBlbmRhZCk7CisgICAg
aGV4X2ludGVycnVwdF91cGRhdGUoZW52KTsKIH0KIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKLS0gCjIuMzQuMQoK

