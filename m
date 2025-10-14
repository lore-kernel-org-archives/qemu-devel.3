Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7812CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8f5l-0006HO-J9; Tue, 14 Oct 2025 09:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v8f5k-0006Cg-3o
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:29:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v8f5e-00087C-FF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:29:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87HuK001472
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=C68evWzh+Mev+7fuINO+gkYVPjxca+otzGGdUQ//QQs=; b=I9
 aMH8Jq3d2XKS3c9/rpucX+YqOEufZJXk+W16zIVNE+JbtkjJnLE74MwRoOgN+QhT
 dVqGxEAS4AE/PFsH57O9r8gciuHSRi2yP/XJIZM5PVrZ+OA/xcpFRR3dYqntzgEA
 GJtVuhtGdxZqm6aadA8958zJFI9sWZ9dEYCvVw7wNjQr1qTANjLnaWVMVDkefa8Z
 Ih6ELUgG/XNG9KsSn8Wf+uIO7I7bvJ4LVfZo/rVN5ejSEER67zdREzC2FJWz4B4e
 8qR5x8QMs63I4I2AqBeYJJbLOWq7nFNCRCed6+7W9KpKSzut9ttMSnzQ4ZPYVJAw
 EWC3AwEEflIZt75o3A4g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa88neh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:29:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-28bd8b3fa67so85180605ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760448558; x=1761053358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C68evWzh+Mev+7fuINO+gkYVPjxca+otzGGdUQ//QQs=;
 b=LaLcG65ZgS29dt2J0SgcPPwHPq7oNPIP6VET91+3lomklxwgfYdQ2PsKg/y4Qci6ov
 KsrVwPR58ek0Z/GRUzotpRVYjIdlbB8i5+3UlNgQA2Uuva6V9cJIT29u3nKsZ4W4RqUO
 JhB/1zpf0ZBWsJz7UPDsXgcWQiC2dQLaWVpjkdDa0dRvHAaiqV1hi52xlWGyp7aYDO7A
 mD9FbbQa4ERvAkTm9MlOlnEaQlOJRHmJ1MkHiZFBCvIXs7ShXndtgwOj+YKNevDsSJgv
 fzx1OQb0Qr9819FLR2zqPx9pc13qsWbSCKi+Tl49xBb3MlbVdHyB7rK0ng39xWT5bPit
 I4Ig==
X-Gm-Message-State: AOJu0YxmZ6aHI2AJXhKNKjJXqic6jJXzvgAEYBOFiYbzKTME6WIv+k7o
 n9RPdw7Wv+Kd1aSlh8rkp6kOszSiBF7L5pml9rILtGIzGmwJTxb8fRrzUemQ7rm8VSh/q0QTa6V
 eGbFsQyA/gmFeS/HQMKpdAcroT//MxKx75UEvi6xk7dN/tvallJmntvy0EEQ/wA88PQ==
X-Gm-Gg: ASbGnctFLzhktUY8C+P7DIUXrDF4zcP5GLW+Yqh4eLGnCZZ8TtmhnLHuNFIdk/20F44
 Op7De6u9h6aL+JcwTFgq5+sokFppcQo+WqRhe9g6UGLgS5KVTS7ptbX78lK0KhAFRdAzfoMweU5
 d9eXdq6Y1M+PprkkvCL9/TXP21eMtGFOR4FBR2e7LJNsV9Gz2RYaHJBhAeCCS89OXjzeLXbK/+n
 1X5OgOYm5NFxKJBv72ETptqJ+QoaNgfhngKPKd+UuYGct9NL/MgPwaPq3d4uI1+Qp1fZ+T2fIzD
 061/ERDCRjRu0mpYscr8YW7aDrK2Ep0eKmroe02hT7Ja0wSFwl3Sk9z57hWaf53FOpBD+gJWcHV
 kYyoh2yfsminw
X-Received: by 2002:a17:903:2381:b0:28e:7ab2:811c with SMTP id
 d9443c01a7336-290272e4bc1mr332852295ad.45.1760448557758; 
 Tue, 14 Oct 2025 06:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5IPG8rd1IPeDzXaZYF6p3YLr0OdKbv+Q0rplRslzQdZuiZspjDwN8vJDEv0mdqq6HiCyxFg==
X-Received: by 2002:a17:903:2381:b0:28e:7ab2:811c with SMTP id
 d9443c01a7336-290272e4bc1mr332851925ad.45.1760448557276; 
 Tue, 14 Oct 2025 06:29:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f07275sm164478125ad.66.2025.10.14.06.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:29:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 2/4] linux-user/hexagon: use abi_ulong
Date: Tue, 14 Oct 2025 06:29:05 -0700
Message-Id: <20251014132907.3268743-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014132907.3268743-1-brian.cain@oss.qualcomm.com>
References: <20251014132907.3268743-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 44594MefHqO73jWdcGBlDZpI4Vo_2_6m
X-Proofpoint-ORIG-GUID: 44594MefHqO73jWdcGBlDZpI4Vo_2_6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX8svWi/Qj+KDg
 HklzsxEs7KHk/rH/JYdPbGThaPLv++kwJ68bDdToIW05VpO0MQy599uAWu+Hu3ePgRMz9f1xPd2
 yaFIBqW+yKQueVVcekjz2lodvCQ8efu8+uP1VbjruqDfrN0I0ZgUOtDNUbBUdABwfDmtYdjfJLQ
 lmHYJQpSPz+X+2X48U1qDnpdArpIRDgJ52U4/hSM5LN1MbVvQa4FQr0ShAQb/BfHk5Gn29WTKZh
 I1Rh5ksLVRjRIElHDRJgvjwdI+8WUQx0X/LPX59to6Ti5pNKErxbOp66djU/qQODxpd17dXH2Zc
 7d5XMUvAIKwlQx4rG8gWnLgwFhFDbE2fkoqFtTQsjX7vDNwfBb43z4yZzllkaHt5U14x3hwZwtM
 LrIp9uOF73HUnMxWjnu3H/1CpQbfRA==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ee502f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=Oj8_dRLdxnToIsBgiwgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017
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

Q2hhbmdlIHRoZSB1c2VyX3JlZ3Nfc3RydWN0IHRvIHVzZSBhYmlfdWxvbmcgaW5zdGVhZCBvZgp0
YXJnZXRfdWxvbmcuCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzdi
ZjNkOGM1LWRmMDctNGNiZC1iYTYyLTRjNzI0NmE1Zjk2YkBsaW5hcm8ub3JnLwpTdWdnZXN0ZWQt
Ynk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpSZXZp
ZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3
ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxp
bnV4LXVzZXIvaGV4YWdvbi9zaWduYWwuYyB8IDUyICsrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vc2lnbmFsLmMgYi9saW51eC11
c2VyL2hleGFnb24vc2lnbmFsLmMKaW5kZXggMjg0Nzk1MjIxNi4uZTU1MTRiMmJlYyAxMDA2NDQK
LS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3NpZ25hbC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdv
bi9zaWduYWwuYwpAQCAtMjQsMzAgKzI0LDMwIEBACiAjaW5jbHVkZSAibGludXgtdXNlci90cmFj
ZS5oIgogCiBzdHJ1Y3QgdGFyZ2V0X3VzZXJfcmVnc19zdHJ1Y3QgewotICAgIHRhcmdldF91bG9u
ZyByMCwgIHIxLCAgcjIsICByMzsKLSAgICB0YXJnZXRfdWxvbmcgcjQsICByNSwgIHI2LCAgcjc7
Ci0gICAgdGFyZ2V0X3Vsb25nIHI4LCAgcjksIHIxMCwgcjExOwotICAgIHRhcmdldF91bG9uZyBy
MTIsIHIxMywgcjE0LCByMTU7Ci0gICAgdGFyZ2V0X3Vsb25nIHIxNiwgcjE3LCByMTgsIHIxOTsK
LSAgICB0YXJnZXRfdWxvbmcgcjIwLCByMjEsIHIyMiwgcjIzOwotICAgIHRhcmdldF91bG9uZyBy
MjQsIHIyNSwgcjI2LCByMjc7Ci0gICAgdGFyZ2V0X3Vsb25nIHIyOCwgcjI5LCByMzAsIHIzMTsK
LSAgICB0YXJnZXRfdWxvbmcgc2EwOwotICAgIHRhcmdldF91bG9uZyBsYzA7Ci0gICAgdGFyZ2V0
X3Vsb25nIHNhMTsKLSAgICB0YXJnZXRfdWxvbmcgbGMxOwotICAgIHRhcmdldF91bG9uZyBtMDsK
LSAgICB0YXJnZXRfdWxvbmcgbTE7Ci0gICAgdGFyZ2V0X3Vsb25nIHVzcjsKLSAgICB0YXJnZXRf
dWxvbmcgcDNfMDsKLSAgICB0YXJnZXRfdWxvbmcgZ3A7Ci0gICAgdGFyZ2V0X3Vsb25nIHVncDsK
LSAgICB0YXJnZXRfdWxvbmcgcGM7Ci0gICAgdGFyZ2V0X3Vsb25nIGNhdXNlOwotICAgIHRhcmdl
dF91bG9uZyBiYWR2YTsKLSAgICB0YXJnZXRfdWxvbmcgY3MwOwotICAgIHRhcmdldF91bG9uZyBj
czE7Ci0gICAgdGFyZ2V0X3Vsb25nIHBhZDE7IC8qIHBhZCB0byA0OCB3b3JkcyAqLworICAgIGFi
aV91bG9uZyByMCwgIHIxLCAgcjIsICByMzsKKyAgICBhYmlfdWxvbmcgcjQsICByNSwgIHI2LCAg
cjc7CisgICAgYWJpX3Vsb25nIHI4LCAgcjksIHIxMCwgcjExOworICAgIGFiaV91bG9uZyByMTIs
IHIxMywgcjE0LCByMTU7CisgICAgYWJpX3Vsb25nIHIxNiwgcjE3LCByMTgsIHIxOTsKKyAgICBh
YmlfdWxvbmcgcjIwLCByMjEsIHIyMiwgcjIzOworICAgIGFiaV91bG9uZyByMjQsIHIyNSwgcjI2
LCByMjc7CisgICAgYWJpX3Vsb25nIHIyOCwgcjI5LCByMzAsIHIzMTsKKyAgICBhYmlfdWxvbmcg
c2EwOworICAgIGFiaV91bG9uZyBsYzA7CisgICAgYWJpX3Vsb25nIHNhMTsKKyAgICBhYmlfdWxv
bmcgbGMxOworICAgIGFiaV91bG9uZyBtMDsKKyAgICBhYmlfdWxvbmcgbTE7CisgICAgYWJpX3Vs
b25nIHVzcjsKKyAgICBhYmlfdWxvbmcgcDNfMDsKKyAgICBhYmlfdWxvbmcgZ3A7CisgICAgYWJp
X3Vsb25nIHVncDsKKyAgICBhYmlfdWxvbmcgcGM7CisgICAgYWJpX3Vsb25nIGNhdXNlOworICAg
IGFiaV91bG9uZyBiYWR2YTsKKyAgICBhYmlfdWxvbmcgY3MwOworICAgIGFiaV91bG9uZyBjczE7
CisgICAgYWJpX3Vsb25nIHBhZDE7IC8qIHBhZCB0byA0OCB3b3JkcyAqLwogfTsKIAogUUVNVV9C
VUlMRF9CVUdfT04oc2l6ZW9mKHN0cnVjdCB0YXJnZXRfdXNlcl9yZWdzX3N0cnVjdCkgIT0gNDgg
KiA0KTsKQEAgLTg1LDcgKzg1LDcgQEAgc3RhdGljIGFiaV91bG9uZyBnZXRfc2lnZnJhbWUoc3Ry
dWN0IHRhcmdldF9zaWdhY3Rpb24gKmthLAogCiBzdGF0aWMgdm9pZCBzZXR1cF9zaWdjb250ZXh0
KHN0cnVjdCB0YXJnZXRfc2lnY29udGV4dCAqc2MsIENQVUhleGFnb25TdGF0ZSAqZW52KQogewot
ICAgIHRhcmdldF91bG9uZyBwcmVkcyA9IDA7CisgICAgYWJpX3Vsb25nIHByZWRzID0gMDsKIAog
ICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDBdLCAmc2MtPnNjX3JlZ3MucjApOwog
ICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDFdLCAmc2MtPnNjX3JlZ3MucjEpOwpA
QCAtMjExLDcgKzIxMSw3IEBAIGJhZGZyYW1lOgogc3RhdGljIHZvaWQgcmVzdG9yZV9zaWdjb250
ZXh0KENQVUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCB0YXJnZXRfc2lnY29udGV4dCAqc2MpCiB7Ci0gICAgdGFyZ2V0X3Vsb25nIHByZWRz
OworICAgIGFiaV91bG9uZyBwcmVkczsKIAogICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JF
R19SMDBdLCAmc2MtPnNjX3JlZ3MucjApOwogICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JF
R19SMDFdLCAmc2MtPnNjX3JlZ3MucjEpOwotLSAKMi4zNC4xCgo=

