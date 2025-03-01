Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABA9C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNx-0003P2-Ru; Sat, 01 Mar 2025 00:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNu-0003EO-7X
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNs-00089a-HW
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:33 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213ME9l026214
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aQTpOx5jqbkaYQSeOyg1RDpdSK2rWsfTHjWehLqh3+M=; b=bmZALErylwPU8kcw
 kPbAJ6GBAi56+s8KMg3biEkfhgH2sflrn2L8HYO+DVkXFzoHkl3l5+CM8dveF3b4
 Rc5BJLqMDRZC+4wqQfyTNEQZTSi/C356OHzd8p1p4zmunSL7HIHGGN1CGG8MsmEW
 HN/s/C46zstCB1Qmx8DsohF/8pwOe1K4DZzk13J9YVM2tEtSLh27xeoedepnkfz3
 /EJRBnugA7GV0HWLf/SsIQQDVwGeCM72lDmqIqukxssJau231KziTVrDEnxfqRIl
 fot7VQVXIOEYwLe18gSJ+RBmEkojxXc62iczu7Wj9ktJxt9RYCUkSVuoqux/uEMx
 oIeRow==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95r63f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2feb8d29740so3584999a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806840; x=1741411640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQTpOx5jqbkaYQSeOyg1RDpdSK2rWsfTHjWehLqh3+M=;
 b=qaZlX2Gt7RnBr2KkX2+drWseId0iQXdrNCiVaD/MDqFPnjz17xjJRtJz2rlkMYB/ZQ
 Aa5LLESWde7Nh21BAOPeDdZrwSDbiFxfQLfG1iX5bwhquSBGA+eRljK35SeHF6WNuNcZ
 byS3Va17gkJA4Sn05NLgtkQUU2/TYnPALcusF7smR4gRM+rWAMXUfDSlpblH8HOhNFuk
 MYIO4PXHEyKp8rOhg6WmRAB+gr3SxvHng6cLms2WL0Ti9p6GNZU/Rnupj5/CmJKWcum2
 wn/Ib0ro3fP7lDm82OMSYp2JYt7XXzOpPshYlAaSJj2+yiTQVgq+u/EMY20TGvk17kOL
 jiVQ==
X-Gm-Message-State: AOJu0Yy0OcC8pWmIADqfRV+n3Fm34ibbteB4PZiOow5nFLbikLVEk6aV
 gHzJu5POppbsou6myvtCiX4De1LT+D+fc+asEeJ41nV/oVyrMhNglxuP9e8i4d57V2onLo+OBie
 jf1rcsoHhpnFOYdgm4Dqgp1L9PhQ3T4MTuIpM8VabqnP6iJG9GCM6G4HtcJx3ZQ==
X-Gm-Gg: ASbGncs33O15dp06lWIVJGMNjToDv8e9MDNf7C4QAZ3wrE9MMv0A94A6ighWeXsbpW6
 kYJV0Crk9xVbV4/+YzWcT2DXnQYIop3mvD1AHXrvqNdFKmryh3BXBT1mBW5xeMA2BpzYR5Ay951
 ksv7wr9WL1oVUQJa3odn8AlK/sJJw2gIkwZhDt4I3WHN16dY1F5m6CvPO89kWxT1w86iT9QwedR
 25nYupTISNQMg2WUhB46PQIXuGBW0zUgLBQOVWbNli5ozv7RO32RMkK5IPSaXXA7jnUNasNsdpq
 JFFCRxZc5/Hmzsm+ETgsR8s73uUxp/AMG1Il8KPihUNCKJvQH/1fZqu1Hqqd530F
X-Received: by 2002:a17:90b:4ad0:b0:2ee:3cc1:793a with SMTP id
 98e67ed59e1d1-2febac09ee9mr9420916a91.29.1740806839958; 
 Fri, 28 Feb 2025 21:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsUQFyF3MrxCACgY5QBBnV23g1xxoF9xObq4gzbORba9PpjObTckEWzm4gvFnYJ7StwL0B6A==
X-Received: by 2002:a17:90b:4ad0:b0:2ee:3cc1:793a with SMTP id
 98e67ed59e1d1-2febac09ee9mr9420893a91.29.1740806839545; 
 Fri, 28 Feb 2025 21:27:19 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:19 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 24/38] target/hexagon: Add TCG overrides for int handler insts
Date: Fri, 28 Feb 2025 21:26:14 -0800
Message-Id: <20250301052628.1011210-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: YhL_XjbopryT-Lje7pxTF-YCBub4Hmnx
X-Proofpoint-GUID: YhL_XjbopryT-Lje7pxTF-YCBub4Hmnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=680 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010039
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Ige2MsfXN3aSB7YyxzfWlhZCwgaWFzc2lnbntyLHd9LCB7cyxnfWV0aW1hc2sKaW5zdHJ1
Y3Rpb25zLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggfCAyNSArKysrKysrKysr
KysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCAgICAgIHwgIDggKysrKysrKysK
IHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgfCA0MCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5f
dGNnX3N5cy5oCmluZGV4IDM2MjcwM2FiNDUuLjY0MmNhM2QzZmYgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMu
aApAQCAtNyw2ICs3LDMxIEBACiAjaWZuZGVmIEhFWEFHT05fR0VOX1RDR19TWVNfSAogI2RlZmlu
ZSBIRVhBR09OX0dFTl9UQ0dfU1lTX0gKIAorLyogU3lzdGVtIG1vZGUgaW5zdHJ1Y3Rpb25zICov
CisjZGVmaW5lIGZHRU5fVENHX1kyX3N3aShTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX3N3
aSh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfY3N3aShTSE9SVENPREUpIFwK
KyAgICBnZW5faGVscGVyX2Nzd2kodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1ky
X2NpYWQoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9jaWFkKHRjZ19lbnYsIFJzVikKKwor
I2RlZmluZSBmR0VOX1RDR19ZNF9zaWFkKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2lh
ZCh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfaWFzc2lnbncoU0hPUlRDT0RF
KSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWdudyh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdF
Tl9UQ0dfWTJfaWFzc2lnbnIoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWducihS
ZFYsIHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZMl9nZXRpbWFzayhTSE9SVENP
REUpIFwKKyAgICBnZW5faGVscGVyX2dldGltYXNrKFJkViwgdGNnX2VudiwgUnNWKQorCisjZGVm
aW5lIGZHRU5fVENHX1kyX3NldGltYXNrKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2V0
aW1hc2sodGNnX2VudiwgUHRWLCBSc1YpCisKICNkZWZpbmUgZkdFTl9UQ0dfWTJfc2V0cHJpbyhT
SE9SVENPREUpIFwKICAgICBnZW5faGVscGVyX3NldHByaW8odGNnX2VudiwgUHRWLCBSc1YpCiAK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKaW5kZXggMTQ2ZjRmMDJlNC4uMmZlNDQ0MGRkYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEwOSw2ICsx
MDksMTQgQEAgREVGX0hFTFBFUl8yKHByb2JlX2h2eF9zdG9yZXMsIHZvaWQsIGVudiwgaW50KQog
REVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfaHZ4X3N0b3Jlcywgdm9pZCwgZW52LCBpbnQp
CiAKICNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorREVGX0hFTFBFUl8yKHN3aSwgdm9p
ZCwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoY3N3aSwgdm9pZCwgZW52LCBpMzIpCitERUZfSEVM
UEVSXzIoY2lhZCwgdm9pZCwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoc2lhZCwgdm9pZCwgZW52
LCBpMzIpCitERUZfSEVMUEVSXzIoaWFzc2lnbncsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBF
Ul8yKGlhc3NpZ25yLCBpMzIsIGVudiwgaTMyKQorREVGX0hFTFBFUl8yKGdldGltYXNrLCBpMzIs
IGVudiwgaTMyKQorREVGX0hFTFBFUl8zKHNldGltYXNrLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQog
REVGX0hFTFBFUl8yKHNyZWdfcmVhZCwgaTMyLCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMihzcmVn
X3JlYWRfcGFpciwgaTY0LCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwg
ZW52LCBpMzIpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDg2NWU4ZWJiM2MuLjU3NWYzZmIxNjMgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC0xMzM3LDYgKzEzMzcsNDYgQEAgdm9pZCBIRUxQRVIodndoaXN0MTI4cW0p
KENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQzMl90IHVpVikKIH0KIAogI2lmbmRlZiBDT05GSUdf
VVNFUl9PTkxZCit2b2lkIEhFTFBFUihjaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBF
UihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKK3sKKyAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBFUihzd2kpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBtYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9
CisKK3ZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNr
KQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3ZvaWQgSEVMUEVSKGlhc3Np
Z253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQoreworICAgIGdfYXNzZXJ0
X25vdF9yZWFjaGVkKCk7Cit9CisKK3VpbnQzMl90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworfQorCit1aW50MzJfdCBIRUxQRVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCB0aWQpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBI
RUxQRVIoc2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBwcmVkLCB1aW50
MzJfdCBpbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCiB2b2lkIEhF
TFBFUihzcmVnX3dyaXRlKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnLCB1aW50
MzJfdCB2YWwpCiB7CiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKLS0gCjIuMzQuMQoK

