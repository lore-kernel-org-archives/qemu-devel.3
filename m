Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACC5CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6woP-0003r8-Ea; Thu, 09 Oct 2025 16:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6wnz-0003jI-Aw
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6wnt-0005BM-Uu
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599Eq1pr005247
 for <qemu-devel@nongnu.org>; Thu, 9 Oct 2025 19:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=9k2NTzuiRyd
 ULBorjQcMlpF1jsBY7/L4I2SUrpaWH3o=; b=Fw+xZ+sKrq41WQdy46R8MOokQTv
 TMAMu/UzpUPLBcjO40wuRwAl7dj8F+tA+uVjsZG2sGRzgV20DAQ4CyctyAWO3f1g
 B6jKSjCvO6fJFHWNvQIeoMBs3pK1DDb2doTHvZ+NnzM/URvPsoNBLaqpZLTpF91S
 aRPQuFT/5R0JWWgFJlGHhFvvHhAfLn8gOQcY8sVifAWkPw617W4z7tm5pIdEaJPL
 qARk7bipVqOdCw3HdgplAtEt4oCxg64PEfVpqHwgXRBh6hly5M4yN3jNGQW7yfqH
 V63yZm4p4ca6JgXiLTyZaHDmeWKbcLVzw4MpxrJj4QTNi34kANIm5FwaZ2g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j45w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 19:59:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-28e538b5f23so23409305ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039991; x=1760644791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9k2NTzuiRydULBorjQcMlpF1jsBY7/L4I2SUrpaWH3o=;
 b=rZuEKANEObusblNqA/msLj2KJnYzhpx5ywi8d3bJ/daH9Oee0A0049LUQbHBcMssr0
 yB8t6SSCB2UyFxQb1miEvGoEJsmZ393fJHpftJOPiekEsamauMgXnmKn0mAPYCVw7YZY
 pICyOpBLYZ3PZ1Nf3Y1FLGLPMKf9Hm9K2WEbk/VixBiFl5iEndxEaWYdSTvEsOw0/GHn
 mWKbLvAHbjbAJzNr7hy4SVs02xGOk4gE8Lm2a0Z3KUWzM0qlRPxMMKFGsDb0fQNKYBE9
 JqUoCIBEWR/nZSQfQaAMDiTAFv90rbzoByGA1jIchAIZV4YSo5f2+NJYFoMxHtmLNy29
 9/aQ==
X-Gm-Message-State: AOJu0Ywr43/MrRBeeHzEHWaXtBriGhMSK5hLl6xQp4Ax2Xmm2IUQl5Eu
 tVEcYJ8MAHKoDZm7s7wJfwdt0EDZFK/nkyYLKcT5eT9jHYnINnD87KYPnmERWPUjURCnKmSFRsx
 zl6k2icLnGiswyOil0q7MMVyBueg50uf+TaoErLW5+Ya7M6H7UFDhF6+NwRgTZ/fxlA==
X-Gm-Gg: ASbGncs1wwM/LoUTR62E7cD7qloZVFr2QRnfLEcgRXQ3IA49GzI71UIJ1NJCj8BeeEd
 B33k4xh5FOb4mlAvpV07SFSusqvMuyNe4Ci5yRPDH3hDA3ihyXNFd3Ot4qCgWT7P6/REahRS9qr
 jlNzXV6Zc4TbOU0j+bNVp6ZFOvSKH7Uh5i4MfTYiZa14ReNj5UFsi2AB2jKUynGQYpGgjefEPHj
 mCjasGrq8eQ3fY60LO4zRpBhUl0TxOdeW4GmClVztETyl/YK8GKaxiH37PJz0Zt9R4yZ8QE1RDx
 O6480cnwDogZKNEICG7GsvugK6dy7kP0KbkamhmRSjPxtvW6up706x7zPXMhpuimYc89SHxYBED
 /r+mG3ufQfLcuTwD6pg==
X-Received: by 2002:a17:903:1106:b0:264:567b:dd92 with SMTP id
 d9443c01a7336-29027303325mr110290905ad.52.1760039990962; 
 Thu, 09 Oct 2025 12:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMqlN+HD3jQ5/XDNQuNstoaoFqH4luFg07edI8dNBvP9tezgtI3GX8YNDuDDYptxzIb5qdGg==
X-Received: by 2002:a17:903:1106:b0:264:567b:dd92 with SMTP id
 d9443c01a7336-29027303325mr110290605ad.52.1760039990516; 
 Thu, 09 Oct 2025 12:59:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f32d6fsm36678805ad.96.2025.10.09.12.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 12:59:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 0/4] hexagon: Fixes to sigcontext
Date: Thu,  9 Oct 2025 12:59:39 -0700
Message-Id: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: hUrktOrhTGzjKvVbjk2XnhLNIDWQoqoq
X-Proofpoint-ORIG-GUID: hUrktOrhTGzjKvVbjk2XnhLNIDWQoqoq
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e81438 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jBgUiILNZ4taLe3DBhAA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5uWI80nygnPv
 N9MSPgbrK93GUMP0mtbEIUY9+YRR32pnMphYMPYYzzeH2d7oHLuI38XM2KQCSZSALie/YuyVv82
 zAusFGcFlWVgjqfNN7bL2DzKrXivdHRYLpBZZ2lrZLrxbRRMmiTH1UAnxji+OGbCNREcdZL/ror
 2ZM9sR9KypsytrVTSIGaArMzt2jTnlf52F80y3OqTPKeiia91t2Ei073Js0cxOwkpz8hZ9FDMg8
 fT7PrBHvyla4EyGL3jZIbyj79CmpDc6xMNCXGZtI5v32DBB3M8pZod1Wu19wwNLdsvBuGoaWZ8U
 zA+ZjtA9quK/GqrcQwWngTh/6vthMabKvSalEKzEcxV3yBi8K4jZfZaGB1IcQp5bUw3N+QonMWZ
 jgSKNv7+w0VZmD2/omIoVMzoa/vDQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
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

UmV2aXNlZCBmcm9tIHRoZSBvcmlnaW5hbCBzZXJpZXMgYXQKaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI1MTAwODAxNDc1NC4zNTY1NTUzLTEtYnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoNCk6CiAgbGludXgtdXNlci9oZXhhZ29uOiBGaXggc2ln
Y29udGV4dAogIGxpbnV4LXVzZXIvaGV4YWdvbjogdXNlIGFiaV91bG9uZwogIGxpbnV4LXVzZXIv
aGV4YWdvbjogVXNlIGFuIGFycmF5IGZvciBHUFJzCiAgdGVzdHMvdGNnL2hleGFnb246IEFkZCBj
c3swLDF9IGNvdmVyYWdlCgogbGludXgtdXNlci9oZXhhZ29uL3NpZ25hbC5jICAgICAgICB8IDE4
NCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQogdGVzdHMvdGNnL2hleGFnb24vc2lnbmFs
X2NvbnRleHQuYyB8ICAyMiArKystCiAyIGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKyks
IDExNSBkZWxldGlvbnMoLSkKCi0tCjIuMzQuMQoK

