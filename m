Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE37CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8f5h-0006AZ-JZ; Tue, 14 Oct 2025 09:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v8f5f-00066o-MH
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:29:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v8f5d-00086s-5c
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:29:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87Hwt005378
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=ehpNWDCHDel
 KDgklQhu3pSTn/s0dscDOL87rT3NpH5k=; b=itBKCiBC1O4Pj/EWhjoNg8dOKEi
 bFF+6y1tD0zA81h0HLA6ymkJqv4qgPi6Q729/RV8+zUzMSNUW/Kniy7ZNh0ohw4K
 CwLFQlSSWLRDOi+XhcI26B04YvMBm2trbyojFzYhKN+cDBFFWBeTgGqAt4iauwpn
 8TAUOJvQ+zIhb7XTCRr7TLaDGVed+Bvs9N0ys9XO1BjAZydKVunFreTrly2BMmvY
 6WHrbZCkd6uRySKnqchDUPs3iyYrcbHPY3TkAxZVKldPwTc7xv/n4+EvONXLeq9M
 r67QcT8WzKzGZ2dd9LS9Drlp1tSXgyzzJpRDpBv81O1OFYqWVAEjcMX/cLQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj0ngx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:29:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-27356178876so65836635ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760448555; x=1761053355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehpNWDCHDelKDgklQhu3pSTn/s0dscDOL87rT3NpH5k=;
 b=Aj4/cc9Wjzgi0Q8QceukEsAPyeLikQd82Ts29eQmulbfNih27y1s7nftNS2ZTVatWR
 E45Bapas/GTAcwuY66z76XP5KOB/ZIwCVG0fJqMBN6/J2JzrC+2jHFmdY6+lyt3txTxo
 1T5IZRIAaqhLEd6SbT8Pblu5Vd3WJB/nJvV99s2S0d5XXLQ2mJQxNsvAPwyugiYOxGnd
 zF1iWrubgwo0SXDy38KDFQn/N3sqYY/CWl3vN/dkx6j9Z9A1H74flf56qCDe3zptTwdK
 CTXe6jhwE0wR/aN6iB5vv+Nr4PzMh64BjJgxTs279PdzuXsIeFbNQiZ97jOdVGkaUZJG
 bSZA==
X-Gm-Message-State: AOJu0YyU1oa5RzqahDRi2lKMxyHiyhXP1q4DpPopwqmwQhCAQ8iYlj9Q
 kUE8XLBwEVFFEtgBp8WzIbAMxB7pi1XxhGU+CYjCwjn0ombPSWTEzSKqgNqLCSDmea3RtoiJijw
 yCe6DPRikaUdMHLd8cLtU3LkPRadSAqQuXY6tUGWGqgmZx1x0KPw8izJmAyJYrD2x/Q==
X-Gm-Gg: ASbGncvTOjiyf7r9jLGONUD8GdEkOr8rZ7A+LdQe/mVzU/o9pu30nZzZoTY6DtHPmOy
 aFFUJgk/sW401Fsqi0h5NopztZSbUjHUkOrJaTO3CodhoTOdALkVt0KDZzlNfZBQI6veHqLOlcN
 PxsCf63EGU4hLKTMAwuYsLrD4Co1l/kmLbtPtSz2uMx+EIb0QnbBNBVMFfrR/4w6jWKopdDyCeq
 nQIDEPS5pRTSLk72B5J6DJJQFgo7qvqkxESpCAwoeg4pG0tuT5dzOEvepl1Ef/vmicxcJ0iJLxt
 FxK4o7iDQiZEsz4jY8WfuImJi+7laT/sLpBycmRAaQZMGU/3AanoH7uSbP/kbApLwIWinOXyg+j
 cZQui2ZrGPTJd
X-Received: by 2002:a17:902:cf08:b0:275:c2f:1b41 with SMTP id
 d9443c01a7336-290274193camr318062415ad.53.1760448554633; 
 Tue, 14 Oct 2025 06:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhSJjyRQlDs2NzpNhLN5yp9pEli5TngUbS7quEJAtokuW54PBasPmZ3bPJu91hK/gCaDqTsw==
X-Received: by 2002:a17:902:cf08:b0:275:c2f:1b41 with SMTP id
 d9443c01a7336-290274193camr318061995ad.53.1760448554172; 
 Tue, 14 Oct 2025 06:29:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f07275sm164478125ad.66.2025.10.14.06.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:29:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v3 0/4] linux-user/hexagon: fix sigcontext
Date: Tue, 14 Oct 2025 06:29:03 -0700
Message-Id: <20251014132907.3268743-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXyoBRug5Ht5uC
 qDyR5u5N2soMQ4THP+N72/qtXqxSEIu6DfZLwprWGQwL4ZV9YzjDBBpKguVuaDoRSSVQXB5F2od
 Ud6HpsAns+sEkJ1QoAootwMB8dhfZtmVc6eKdyjVmTEl4ooMvTGd28QW9dlCYrK3w55KF+geCcU
 thn73b8LpezDbMKiqksE1oRV/GZxz6oblSsqJBMIoo6Ut5Y7IvUMAZWawfhWXHr64t7FdPk0Zar
 FQijRas7pRvoKh4G3fg1fg6TtSE23fSXhAh7MoW/5mfYgMAe9MCWln7a+8lI4W5b1qwtACdHuoa
 PEXmurUjx2FZ4rp2CbgpUX0fnkBizQT+O3x/nqpCVhf1pyAZvnUEvHsUylpqUtQhxqeQXZQJt5V
 jz2umEiWqpo1HLTRlJOOePZI5ExE+g==
X-Proofpoint-ORIG-GUID: owuS97dsqYmhFjCvTXn9FeniYFwAztWF
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ee502c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jBgUiILNZ4taLe3DBhAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: owuS97dsqYmhFjCvTXn9FeniYFwAztWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018
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

Rm9sbG93IHVwIGZyb20gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAy
NTEwMDkxOTU5NDMuNDM4NDU0LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKdjMgY2hh
bmdlIGZyb20gdjI6CiAgICAtIGZpeGVzIHRvIHRoZSB0ZXN0IGNhc2UsIHN1Z2dlc3RlZCBmcm9t
IHJldmlldyAobG9vcCBib3VuZCwgY2xvYmJlcnMpLgoKQnJpYW4gQ2FpbiAoNCk6CiAgbGludXgt
dXNlci9oZXhhZ29uOiBGaXggc2lnY29udGV4dAogIGxpbnV4LXVzZXIvaGV4YWdvbjogdXNlIGFi
aV91bG9uZwogIGxpbnV4LXVzZXIvaGV4YWdvbjogVXNlIGFuIGFycmF5IGZvciBHUFJzCiAgdGVz
dHMvdGNnL2hleGFnb246IEFkZCBjc3swLDF9IGNvdmVyYWdlCgogbGludXgtdXNlci9oZXhhZ29u
L3NpZ25hbC5jICAgICAgICB8IDE4NCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQogdGVz
dHMvdGNnL2hleGFnb24vc2lnbmFsX2NvbnRleHQuYyB8ICAyMyArKystCiAyIGZpbGVzIGNoYW5n
ZWQsIDkyIGluc2VydGlvbnMoKyksIDExNSBkZWxldGlvbnMoLSkKCi0tIAoyLjM0LjEKCg==

