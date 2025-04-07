Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BABC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 19:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1s8i-0001rS-LN; Mon, 07 Apr 2025 15:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7t-0001gx-F6
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7r-0002kM-Cm
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537IQe0D003206
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 19:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nPoyTPeZ2tLujlV8Tk9LZrILptSj9Wah/+UCQ5kzrzs=; b=carBK43AvfglKtyC
 QmJMOjsDs5xe4DtReNWkPxhoc1BOkaPCbBuSA1ik8o5slwIjTqtXZswerh7uTXXL
 Ta5CGDa5WAfWsoSDLVjOW2wfLiCse3ju9hmqxZ7CLQ4sHCYE5zwas1FHkztF+uc7
 y1jpAp9a+B87uo6C0fMALMqfnPCMgudehdzlnyNwfSgs9si5U2YC/oeDSybRnT4i
 rPq/PmU/RG/dhON1QOFZ0iCdBoSOBnlWZqT7sD/WhcpgUeN/AckOrB/5yDN1WAcH
 oBOcoBoc0IksxG9BLjW2iE27xo/8TpZHoiuCII2DYpSiqQqNVG/jtPfiDMtZQ/wB
 ALVQPg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftd9b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 19:27:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-736c89461d1so7198328b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 12:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744054036; x=1744658836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPoyTPeZ2tLujlV8Tk9LZrILptSj9Wah/+UCQ5kzrzs=;
 b=eCNuysIm3OBIab9RGCXqetVL9eJj7rSVPqhP+tdJBnU5Hix0kJwpSoF/a+jpPmIeLr
 USup5l++lHUJMJBdaFSoaUGfMdricCfI/rNjRB5DJ2kwuFYp+x8LG0PS2WKh/4zup3jA
 cu5U1jvUh858ZaF6jeLxApXgSUKGOjNTuXgcviscB9nVco2grwyQqjB3a/T9lTihupgv
 AEW5XN0VMkt9insKbaWgnPrmkShSyy68L3KmH83vo1OeMnZtUQbMOtKbq1KN/TjaXkRY
 mhdzG49zlsCFKoL4RizMPgt3f3/WKxi6pmGD6+6ZsxCsK1ztaTsmbSVCq+vC56z1D/qk
 E4cw==
X-Gm-Message-State: AOJu0YzetQlf5JF5gx3tJXcGKPkpiJZRWVnCRJ/pLcLfehLGDZW+gec4
 7Tfty8nCrdP6Pin2aJ+68jVJZBOPBnmSm9YTqD//ryxf3MRYuhUO9CjNTXKPue4HkwSvLj+wpi7
 COsLtGgojcLRzCG1xDtONCcqe3rjpeaRYmi12CThcNRVIXioAPgXyNqgsoDWKcQ==
X-Gm-Gg: ASbGncvu9cVSZ8qkuFnz902CHThtRS+Hd1kwUh7HN0Hc3eHvDiyjBbDs928Gq1DbwTf
 WYcH3L+sULhrx/F2UsQ6B3e15jiaiIhKmtov0IdhEIP1rQ6FHEwuCMCYhLEgh5W9N9sQkI+EcDX
 xY7yGJ9Yb7wTTmo9ouJ2mE7GYRRmDnxRzwtxh0PXYL5fbib8xprwkVj1B8YMCWwLKbYaeL0er1A
 pRV92dvx0z89f7BnHtBMWt94u8rXBolT/HWUPisnHGhNlCGwpDTQNfV6/QjwHz6uPt8D6Rg35e7
 gTTMmzGz3ccEKGDyfHsZJUyPwh7znjgjk9JDWH410iGe67xUf2wevf68QoJPclYV
X-Received: by 2002:a05:6a00:1485:b0:736:728b:5f1f with SMTP id
 d2e1a72fcca58-739e7113b63mr17008707b3a.19.1744054036264; 
 Mon, 07 Apr 2025 12:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGkXf6ENOEvr5GUYc91y26Cqim8ceErbpBPKe6h8h0PzqvJuWdJKymmbUou3QMbshWAkb2gQ==
X-Received: by 2002:a05:6a00:1485:b0:736:728b:5f1f with SMTP id
 d2e1a72fcca58-739e7113b63mr17008685b3a.19.1744054035896; 
 Mon, 07 Apr 2025 12:27:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee619sm9206559b3a.52.2025.04.07.12.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:27:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH v3 3/5] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Mon,  7 Apr 2025 12:27:03 -0700
Message-Id: <20250407192705.2605614-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f42715 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=ExrS_PMGiXDxMcIyg5oA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 1jepcVmVsmSrji2iqAfnTqHCfc63NAGe
X-Proofpoint-ORIG-GUID: 1jepcVmVsmSrji2iqAfnTqHCfc63NAGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=715
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgfCA3ICsrKysrLS0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5k
ZXggNjgwMzkwODcxOC4uYTJkY2IwYWEyZSAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4
X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0yNDcsOCAr
MjQ3LDExIEBAIGRlZiBuZWVkX25leHRfUEModGFnKToKIAogCiBkZWYgbmVlZF9wa3RfaGFzX211
bHRpX2NvZih0YWcpOgotICAgIHJldHVybiAiQV9DT0YiIGluIGF0dHJpYmRpY3RbdGFnXQotCisg
ICAgcmV0dXJuICgKKyAgICAgICAgIkFfSlVNUCIgaW4gYXR0cmliZGljdFt0YWddCisgICAgICAg
IG9yICJBX0NBTEwiIGluIGF0dHJpYmRpY3RbdGFnXQorICAgICAgICBvciAiSjJfcnRlIiA9PSB0
YWcKKyAgICApIGFuZCB0YWcgIT0gIkoyX2hpbnRqdW1wciIKIAogZGVmIG5lZWRfcGt0X25lZWRf
Y29tbWl0KHRhZyk6CiAgICAgcmV0dXJuICdBX0lNUExJQ0lUX1dSSVRFU19VU1InIGluIGF0dHJp
YmRpY3RbdGFnXQotLSAKMi4zNC4xCgo=

