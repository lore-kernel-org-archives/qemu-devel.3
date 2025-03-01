Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06187C282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPO-00089A-OT; Sat, 01 Mar 2025 00:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPM-00086l-SA
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:05 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPL-0008Nb-53
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:04 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214E6Do030641
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eiekoLL7gr5td0wkXCBh/rRbE+ZSV6VcR92m6VgCUw0=; b=ARrmYGTnLvHYLr3e
 ejQljD+0yUfsE6E2RD9CmyOFoFyTqA4joF8kQMvt9Fg7gfQhpEW2tur6WSU5syRI
 x67J6AXM9ls0X21F1kt4hKxM/5/lI//cxFLUX8AbRv1Mwb7UEhSK4l2Bcy88p/Eu
 bJI5tm5gBd6rrrD5XomfjtMrmlMn/tmfMDulX3TC6WHCQauuQvkWEL1MI79E+fld
 mzpsE8A1owMe6zVvmC2wQmqqHUeXiRcKHL4U5u5YRs0Z64izMZ35XYJ6LddOZZOI
 Tp6lWYqTpDO96orc4EdwF3rtpeBDHu4sLZJNF71JyQ6bk0o13dtvDaXr/r9Vk05b
 takCPg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d037a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22334230880so39443325ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806941; x=1741411741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiekoLL7gr5td0wkXCBh/rRbE+ZSV6VcR92m6VgCUw0=;
 b=vRH0qgUd5sDnz1NXj2NwOGnZccRkwxFxId110qYz5/BbxUwCFlwvLYg2tS1QYhY5Z/
 WVZBH1agrjK4bRM6TuSx9rqgA3A0xefIfdeikOvT1i79pEwn5WQ18n4crbC00TRO7xXQ
 DNFfCrH1eW+LIuGqfB0BPsaJK0ePT+9hhi2I/CAwpkSO7jRRE3bHSvEbNpu3XsCA8uSM
 Z387nx9NHJHHG6YVMaLDGozw0lAwoIyyqtfQDiIdiEpKkB2KIuRs7cWQEfPU6VWaGRpX
 U2Uewv6M4j3aWH8SDeLR8OUXRZD2d/56Ab9yvup1ANK5cd2SaZuga4qjSvptNA5RZHz7
 thrw==
X-Gm-Message-State: AOJu0Yw1AV+8quomQk+NwN/wzDVk32moPRzB3CbjYKIsbCpELFmkrm6H
 JBbDyyv8Kd9ptUWaVFQ2oEibKMN+ks6dlsmYGGHM2/xnkGB63FVTG/EvMtQ7f/k36y34AycIVC5
 9eqYL7ZPsctvcm1hYZ3bxRAg2AERrB4hFC6ZvCkv0j9/13yAXQtjak8UvQqi3Tg==
X-Gm-Gg: ASbGnct0tO9jKcvSjO9xDQGd3BqVaHThrU14sj4od3yuaSPCpVovPDpmwyZmhIHJoL1
 Yi3V6+jWWiEfDMkE1cvsGbWkPcJFqLK4ve+c8GzEOZqXm6KYypMltTem3310j2+qrc5h2+aYmdt
 eZIEjUi+kWNMcmytTCHTpnvZ25mJaFCp/I2TspImSHsfInS6uR/1IbdQFZ5m/qpq73n50eusId6
 l211SBkJ2w9TQRlxNjxQhGM3qP7fcKPLpfWTrh4Ly1cUP3whI8EQOAe+sNkIrLdsmt0BA71326Y
 oMOm9pqmTe/ECFK32kdll1LwEBTv/Et1huPPmNoUJr0THd13Mymv789EIld764wi
X-Received: by 2002:a17:903:230c:b0:223:7006:4db2 with SMTP id
 d9443c01a7336-22370064ea3mr67165225ad.31.1740806940831; 
 Fri, 28 Feb 2025 21:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ+7DXIXcMC+zzf3hwna0fyMOTGjC75mvJdEnNCgzRN7ydyvCA1BpoBJtJneugJ//CM4ql/g==
X-Received: by 2002:a17:903:230c:b0:223:7006:4db2 with SMTP id
 d9443c01a7336-22370064ea3mr67165085ad.31.1740806940498; 
 Fri, 28 Feb 2025 21:29:00 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:00 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 08/39] target/hexagon: Implement get_exe_mode()
Date: Fri, 28 Feb 2025 21:28:14 -0800
Message-Id: <20250301052845.1012069-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7IW3aro-KkTnC6zlSiOZJqTEoA9la8DF
X-Proofpoint-GUID: 7IW3aro-KkTnC6zlSiOZJqTEoA9la8DF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=671
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
cmVnX2ZpZWxkc19kZWYuaC5pbmMgfCAxMSArKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jICAgICAgICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMg
Y2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMK
aW5kZXggMTU2YTM1MTRlNy4uNTBiOGMyNmY4YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
cmVnX2ZpZWxkc19kZWYuaC5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMKQEAgLTEzNSwzICsxMzUsMTQgQEAgREVGX1JFR19GSUVMRChDQ1JfR1JFLCAyNywgMSkK
IERFRl9SRUdfRklFTEQoQ0NSX1ZWMSwgMjksIDEpCiBERUZfUkVHX0ZJRUxEKENDUl9WVjIsIDMw
LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYzLCAzMSwgMSkKKworLyogSVNEQiBTVCBmaWVsZHMg
Ki8KK0RFRl9SRUdfRklFTEQoSVNEQlNUX1dBSVRSVU4sIDI0LCA4KQorREVGX1JFR19GSUVMRChJ
U0RCU1RfT05PRkYsIDE2LCA4KQorREVGX1JFR19GSUVMRChJU0RCU1RfREVCVUdNT0RFLCA4LCA4
KQorREVGX1JFR19GSUVMRChJU0RCU1RfU1RVRkZTVEFUVVMsIDUsIDEpCitERUZfUkVHX0ZJRUxE
KElTREJTVF9DTURTVEFUVVMsIDQsIDEpCitERUZfUkVHX0ZJRUxEKElTREJTVF9QUk9DTU9ERSwg
MywgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX01CWElOU1RBVFVTLCAyLCAxKQorREVGX1JFR19G
SUVMRChJU0RCU1RfTUJYT1VUU1RBVFVTLCAxLCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUkVB
RFksIDAsIDEpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJn
ZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggZTY0NTY4YjlmYy4uZTBkZDEyMGNkNCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L2NwdV9oZWxwZXIuYwpAQCAtMjM3LDYgKzIzNywzMCBAQCB2b2lkIGhleGFnb25fc3NyX3NldF9j
YXVzZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgY2F1c2UpCiAKIGludCBnZXRfZXhl
X21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7CisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgp
KTsKKworICAgIHRhcmdldF91bG9uZyBtb2RlY3RsID0gYXJjaF9nZXRfc3lzdGVtX3JlZyhlbnYs
IEhFWF9TUkVHX01PREVDVEwpOworICAgIHVpbnQzMl90IHRocmVhZF9lbmFibGVkX21hc2sgPSBH
RVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsKKyAgICBib29sIEVfYml0ID0gdGhyZWFkX2Vu
YWJsZWRfbWFzayAmICgweDEgPDwgZW52LT50aHJlYWRJZCk7CisgICAgdWludDMyX3QgdGhyZWFk
X3dhaXRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX1csIG1vZGVjdGwpOworICAgIGJvb2wgV19i
aXQgPSB0aHJlYWRfd2FpdF9tYXNrICYgKDB4MSA8PCBlbnYtPnRocmVhZElkKTsKKyAgICB0YXJn
ZXRfdWxvbmcgaXNkYnN0ID0gYXJjaF9nZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX0lTREJT
VCk7CisgICAgdWludDMyX3QgZGVidWdtb2RlID0gR0VUX0ZJRUxEKElTREJTVF9ERUJVR01PREUs
IGlzZGJzdCk7CisgICAgYm9vbCBEX2JpdCA9IGRlYnVnbW9kZSAmICgweDEgPDwgZW52LT50aHJl
YWRJZCk7CisKKyAgICAvKiBGaWd1cmUgNC0yICovCisgICAgaWYgKCFEX2JpdCAmJiAhV19iaXQg
JiYgIUVfYml0KSB7CisgICAgICAgIHJldHVybiBIRVhfRVhFX01PREVfT0ZGOworICAgIH0KKyAg
ICBpZiAoIURfYml0ICYmICFXX2JpdCAmJiBFX2JpdCkgeworICAgICAgICByZXR1cm4gSEVYX0VY
RV9NT0RFX1JVTjsKKyAgICB9CisgICAgaWYgKCFEX2JpdCAmJiBXX2JpdCAmJiBFX2JpdCkgewor
ICAgICAgICByZXR1cm4gSEVYX0VYRV9NT0RFX1dBSVQ7CisgICAgfQorICAgIGlmIChEX2JpdCAm
JiAhV19iaXQgJiYgRV9iaXQpIHsKKyAgICAgICAgcmV0dXJuIEhFWF9FWEVfTU9ERV9ERUJVRzsK
KyAgICB9CiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KIAotLSAKMi4zNC4xCgo=

