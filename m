Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A92CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8f5r-0006V7-8o; Tue, 14 Oct 2025 09:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v8f5p-0006So-7U
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:29:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v8f5f-00087L-QR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:29:32 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87LFM008546
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mpWZ77L72MtDnY6aFBb3wvz17h863QymOKjhJeJ8LWw=; b=Kok3pOpqOq5REvB4
 mfb1lB7hMSuGxtKG1PT0yL0y74oGtSmCS913C1N71RnsOi1gWs9k4Z/NdFxw+yYT
 +Wq/NiLHxLpXuFtgzHz4CVa28NzqCDT9qchUoPMEG8Uu7cw+NEi+yl+yMJhY9vQU
 h9oljWKPcen8+Ok/fgL2V1i0Q/yL3Rvk/CaMFXWGFuKXsvMt7fxV27NfDU0xtHRs
 9Oc6No+O659z/KpywQNbEsQ7mYOyR+6uJ8csFdlWy0QDeY4skKCQqMKguF/IzSoH
 ehD9KnQ9XHQUWNnVyy2B1fndHWDGhHhkA+KQCB0wYuV2XdFG7vLNioStkVdkAgXe
 gpCENA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt5fk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:29:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-28973df6a90so98217345ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760448561; x=1761053361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpWZ77L72MtDnY6aFBb3wvz17h863QymOKjhJeJ8LWw=;
 b=qX6vdLIWb/OczOwlS0Ix5jYhc/zQjEZt43r+m2GkGFMM4Of0lFYj5F0GHymUJnxsu9
 2aCfURC9cw55e7SeHvqd+ExdBwvpVQgoBixy0UY6A65r9N5Cd198TPG2rkTXh3qtbZ5r
 jsvynHgXDv/2NXaxjbwXFU74RCDaFATIcuj/JEaFnnWBDWLq8DVT17eT/AovpY+JZqWs
 5X3vhA5RNHBjjBc3N9tIZL/ldpInUmimZjAgMPIMCOGZ7hM6QkbCPxxjxZZJ4P2sMc0J
 p2JCDfbHFJ/6VhpC4cccTsXxa4woTRJDxrAcjSwOmgjgHZJ7LnvNbv4DoTBB1CvxurXc
 5O4Q==
X-Gm-Message-State: AOJu0YwC/3Nb6V0LvGF2bGD3sha7ojStQLfqXNOvHugBnOqae9SdYFtI
 UkuAWIX/dgA/AFIr8aMDuGQA8ATu1WJT80zxMiqe1CmfQxZBc7gOp3JHNUXwrgUz/OB+ciXy5wM
 Y3jBhK8IU+SR8X3zWbjhS/O9gDyoZ/X1UFWAPJaWdhdhspkBYzpKN4KZ+Z4AelZyR5w==
X-Gm-Gg: ASbGnctWUQtBdyr7Zlt12RQXutA6xZ0wKdsGDodLKkmDN4bshaxZcGQgdTLqivJ1ifR
 R3Y9vohA5WUVf6ptY+N5CskJDExaIsPDaEE3foMJXQyg4Q6unac/QGU8aYUZZzE26mjZ6GsdKs5
 zAH7Ie4hZ8nvpc/68kidUPJMajplqMYyebeEm1e2azLG5BP0UpyIv8L5C6ramiHVL0TPyWUrkPZ
 OdGYvXRlI4iQwNPJ2V1gQ2Ak3GDep0RcWF/oz1ULPAdO9R5pHcCa4muuyYlUAnMFGr+5Kry8IeS
 C+SfKgFV4+3kKxcV0E0A9l/Qb7Tuy6AaVXMIhwB4tUSfPjfdAaJQfo9oTn1zw/T8RG9hLuBewnL
 lv3KW0c4mNUlQ
X-Received: by 2002:a17:903:8c8:b0:264:a34c:c7f with SMTP id
 d9443c01a7336-290273568famr357097315ad.7.1760448560724; 
 Tue, 14 Oct 2025 06:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/JzvAaW1h6+yfJYQW0XzciNA7lJCL1SIpnZM9Lbdc2oJuIKZiLHyUBk3oz+iEERvAsw5rZg==
X-Received: by 2002:a17:903:8c8:b0:264:a34c:c7f with SMTP id
 d9443c01a7336-290273568famr357096825ad.7.1760448560120; 
 Tue, 14 Oct 2025 06:29:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f07275sm164478125ad.66.2025.10.14.06.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:29:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v3 4/4] tests/tcg/hexagon: Add cs{0,1} coverage
Date: Tue, 14 Oct 2025 06:29:07 -0700
Message-Id: <20251014132907.3268743-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014132907.3268743-1-brian.cain@oss.qualcomm.com>
References: <20251014132907.3268743-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: QsX90ZB3MNBHuerQTozC_Qi7IFhAs0Je
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXxActbz8vgh0k
 RLZa2vd0ood1f3uQS5MSeb8r6eF/cw7l34vQzY+depVNTIgtQUEoLOXfTSAazeFgAJTOsOg6jAK
 pC6lnAgyvULjEEoKRXjlm7tyxrc04OodbBi7Fv1QEei6T2tyRVgVCN1JGYaKuBbI7LT1EkqtqBQ
 KfGe5sM/SD5mDsnHxSWFyOR8bmQyXII6BXxxF7+7PMsfA6mY/dP55vb120pzwKb3+ZP4spMBqtp
 62xxeYDunmVCPifrunJw2sR5/YVW3r9AfaYybc++vUNx4MNKk9MTAv2x8krP5Y+oNT2uRKFSgh1
 DigGDg3t3LMJolmY7voMCw4BQFarsJfnkNg8HPxNjY+SGqSv0eIOtED5Z0JSIHZqG4V9GrVJ7TR
 nBWeJ651XVhTV2JU9QFX95lBmg737g==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ee5032 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VgE1YBpVsVNxnyuYq6cA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: QsX90ZB3MNBHuerQTozC_Qi7IFhAs0Je
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022
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

Q292ZXIgY3MwLDEgcmVnaXN0ZXIgY29ycnVwdGlvbiBpbiB0aGUgc2lnbmFsX2NvbnRleHQgdGVz
dCBjYXNlLgoKbGMwLCBzYTAgcmVnaXN0ZXJzIHByZXZpb3VzbHkgb21pdHRlZCBmcm9tIHRoZSBj
bG9iYmVycyBsaXN0CmFyZSBub3cgY2FwdHVyZWQuCgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5z
c29uIDxhbmpvQHJldi5uZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL3NpZ25hbF9jb250ZXh0LmMg
fCAyMyArKysrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vc2ln
bmFsX2NvbnRleHQuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3NpZ25hbF9jb250ZXh0LmMKaW5kZXgg
NzIwMmZhNjRiNi4uMTJiNzhmMTc5MCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vc2ln
bmFsX2NvbnRleHQuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9zaWduYWxfY29udGV4dC5jCkBA
IC0yNiw3ICsyNiwxMSBAQCB2b2lkIHNpZ191c2VyKGludCBzaWcsIHNpZ2luZm9fdCAqaW5mbywg
dm9pZCAqcHVjKQogICAgICAgICAicDEgPSByN1xuXHQiCiAgICAgICAgICJwMiA9IHI3XG5cdCIK
ICAgICAgICAgInAzID0gcjdcblx0IgotICAgICAgICA6IDogOiAicjciLCAicDAiLCAicDEiLCAi
cDIiLCAicDMiKTsKKyAgICAgICAgInI2ID0gIzB4MTIzNDU2Nzhcblx0IgorICAgICAgICAiY3Mw
ID0gcjZcblx0IgorICAgICAgICAicjYgPSAjMHg4NzY1NDMyMVxuXHQiCisgICAgICAgICJjczEg
PSByNlxuXHQiCisgICAgICAgIDogOiA6ICJyNiIsICJyNyIsICJwMCIsICJwMSIsICJwMiIsICJw
MyIpOwogfQogCiBpbnQgbWFpbigpCkBAIC01Myw3ICs1NywxMSBAQCBpbnQgbWFpbigpCiAgICAg
dGltZXJfc2V0dGltZSh0aWQsIDAsICZpdCwgTlVMTCk7CiAKICAgICBhc20oImxvb3AwKDFmLCAl
MSlcblx0IgotICAgICAgICAiMTogcjggPSAjMHhmZlxuXHQiCisgICAgICAgICIxOiByOSA9ICMw
eGRlYWRiZWVmXG5cdCIKKyAgICAgICAgIiAgIGNzMCA9IHI5XG5cdCIKKyAgICAgICAgIiAgIHI5
ID0gIzB4YmFkYzBmZWVcblx0IgorICAgICAgICAiICAgY3MxID0gcjlcblx0IgorICAgICAgICAi
ICAgcjggPSAjMHhmZlxuXHQiCiAgICAgICAgICIgICBwMCA9IHI4XG5cdCIKICAgICAgICAgIiAg
IHAxID0gcjhcblx0IgogICAgICAgICAiICAgcDIgPSByOFxuXHQiCkBAIC03NCwxMCArODIsMTkg
QEAgaW50IG1haW4oKQogICAgICAgICAiICAgcjggPSBwM1xuXHQiCiAgICAgICAgICIgICBwMCA9
IGNtcC5lcShyOCwgIzB4ZmYpXG5cdCIKICAgICAgICAgIiAgIGlmICghcDApIGp1bXAgMmJcblx0
IgorICAgICAgICAiICAgcjggPSBjczBcblx0IgorICAgICAgICAiICAgcjkgPSAjMHhkZWFkYmVl
ZlxuXHQiCisgICAgICAgICIgICBwMCA9IGNtcC5lcShyOCwgcjkpXG5cdCIKKyAgICAgICAgIiAg
IGlmICghcDApIGp1bXAgMmJcblx0IgorICAgICAgICAiICAgcjggPSBjczFcblx0IgorICAgICAg
ICAiICAgcjkgPSAjMHhiYWRjMGZlZVxuXHQiCisgICAgICAgICIgICBwMCA9IGNtcC5lcShyOCwg
cjkpXG5cdCIKKyAgICAgICAgIiAgIGlmICghcDApIGp1bXAgMmJcblx0IgogICAgICAgICAiNDog
e306IGVuZGxvb3AwXG5cdCIKICAgICAgICAgOgogICAgICAgICA6ICJyIigmZXJyKSwgInIiKGkp
Ci0gICAgICAgIDogIm1lbW9yeSIsICJyOCIsICJwMCIsICJwMSIsICJwMiIsICJwMyIpOworICAg
ICAgICA6ICJtZW1vcnkiLCAicjgiLCAicjkiLCAicDAiLCAicDEiLCAicDIiLCAicDMiLCAiY3Mw
IiwgImNzMSIsICJsYzAiLAorICAgICAgICAgICJzYTAiKTsKIAogICAgIHB1dHMoZXJyID8gIkZB
SUwiIDogIlBBU1MiKTsKICAgICByZXR1cm4gZXJyOwotLSAKMi4zNC4xCgo=

