Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127D6C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0hBy-0000pn-8A; Fri, 04 Apr 2025 09:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1u0h3a-0007by-6Y
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:26:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1u0h3Y-0006ne-56
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:26:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53433wiT012515
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 13:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bDuzMjiRfhY
 8qqWwbxci97RbTv25bs4o+U0P5+qscwA=; b=Sy8sPAn4B6C5Hr55psIBJbM+aZp
 CIGcJ7aAEIuz1rH+99r6kXxygdfolFhFRNb1y1gWRVYGXgjBoYbxWwwBQJxtN7SD
 jdJpElMzk1ItC8pzVHMuVII1ACl9KNqHgKV8m9PSS+AytP/qeOp+gYF/oWC6asXb
 PDskowYBEAuE6MlpImFehaT/WjRVtoTfvZ/ZwShG1M9oeOsAK7ozAzjRPoyetErJ
 vaino5jNFHKdvXw5YK6IYmJkj9MEEQXv8lQHFXPj6sDQ6gAzgZIg6cwNiw6EhD93
 DXkXt6yS84utemXLeRx80yCGBU3ZJbyCdB4avf9rhTKlNB7sJWAB8v0sfSA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d51w0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 13:25:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-af972dd0cd6so1450486a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743773155; x=1744377955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDuzMjiRfhY8qqWwbxci97RbTv25bs4o+U0P5+qscwA=;
 b=eNJI5TZigpcFUx4uoqyoHAWjuYM2yoABUNSeD7QdCYmKf1zpk//K32TVAeAMfD2jVb
 un9tTNsIDQzeqvcGxzFS8rBG3qwRqTdW3U1fNjZg9qB85YRwSuujnUnFvZLLgIMB9Teu
 jvKjfz84UbLYulyqpoAy8akXDHi4TIxfIu06UFWrLR7X1yznzLoaG4D5xXLcZjbku8VJ
 gdW0z85s/HWbI/CWdpg9pKhe+NGP+Kmwpdx6elTCT+GvPfAcOatBr92k7ppFP1SEpfHL
 aOwluRA41/425TmpCNk/kq4aNaL9OXdZCG7pVoZEsvHZCZ4Wvdr9epdnX4fUrUggy/lG
 0dDw==
X-Gm-Message-State: AOJu0Yx1BLdkfil6zRX1B559dRECat/6AXxBqGZPZR8ttpFPPEOPmAlN
 +4pKrVE2cibskTPZ5R6KJaBesw9LouyYbQRpPntyyHhxYTSul1v+YyqCf3gqYMpo0KeXFnpT6Bl
 2SWO1n2oOUIwmCO/oEDSEkOYWvD71J1a2MBfKLf9k/ga6nGww1Pj8qw==
X-Gm-Gg: ASbGncuy8rGYNiTWq/Cb75UjEi9nzAjg3xuYSw8Z2jSfe4JQG2GeWtMEzZ3CO7lW1YW
 4OEDhZccRyk+MHpFtsgldjE74sD/kXjHHPLUnyDJ+F3e78Jc2cfux/gShF/u9gHgHr7pTg1pCWQ
 KnbEjrDCqNyBwTkmjV1eGzqzTsWZBSIAtq5jxJKHm0P026b6Ey15opskJe0M1a5diV953QR46IF
 m4eSmUgf2Yc9DHLTOyyzHsePXNZpx+nnBLWRfPs49Y8T0EIVfHRloMV2IBzwCV643VCNVBhcutY
 XJaZ2hWJkGKJbLrzUOpaOTPom7coL/qx1ICt0Ht6hI672KMoPtr5yD4UaVSUhtQDe4d1jn8/HvB
 2oo8=
X-Received: by 2002:a17:903:3c66:b0:224:191d:8a87 with SMTP id
 d9443c01a7336-22a8a8739e2mr39647325ad.26.1743773154820; 
 Fri, 04 Apr 2025 06:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsfLvZzBno19442BX2raPkOVbE8JS0b17gvfWJq6vtH16DlOjPZRk8OV/aw7gQSs1/BjphLw==
X-Received: by 2002:a17:903:3c66:b0:224:191d:8a87 with SMTP id
 d9443c01a7336-22a8a8739e2mr39646985ad.26.1743773154422; 
 Fri, 04 Apr 2025 06:25:54 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785adae3sm31788875ad.16.2025.04.04.06.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 06:25:54 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 bcain@quicinc.com
Subject: Re: [PATCH 1/6] target/hexagon: handle .new values
Date: Fri,  4 Apr 2025 06:25:51 -0700
Message-Id: <20250404132551.3677006-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20250404025203.335025-2-brian.cain@oss.qualcomm.com>
References: <20250404025203.335025-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o89pGTN042XQG0wjDXq8bgDFxa-OUISk
X-Proofpoint-GUID: o89pGTN042XQG0wjDXq8bgDFxa-OUISk
X-Authority-Analysis: v=2.4 cv=Cvu/cm4D c=1 sm=1 tr=0 ts=67efdde4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=5Ev2Aso3rA0ZF-ehJDsA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_05,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=479 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Apr 2025 09:34:39 -0400
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

On Thu,  3 Apr 2025 19:51:58 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> From: Brian Cain <bcain@quicinc.com>

Perhaps it would be best to reset the autorship here to
brian.cain@oss.qualcomm.com?

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_common.py | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 758e5fd12d..242dee3731 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -349,6 +349,12 @@ def helper_arg(self):
>              self.reg_tcg(),
>              f"{self.helper_arg_type()} {self.helper_arg_name()}"
>          )
> +    def from_subtype(self, subtype):
> +        if subtype == "":
> +            return self
> +        raise Exception(
> +            f"unknown subtype '{subtype}' on generic Register class")
> +

We use this method for other reg types downstream (HVX). Since, in this patch
series, we are not really using from_subtype (get_register is always called
with subtype == ""), I think we could either exclude it from this series or
evaluate how to also upstream its use for HVX.

