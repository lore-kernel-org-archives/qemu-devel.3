Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA092E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiFZ-00073Y-7m; Mon, 09 Dec 2024 13:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tKiFX-00073F-Lx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:12:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tKiFV-0004HD-V4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:12:51 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AQU7w014251
 for <qemu-devel@nongnu.org>; Mon, 9 Dec 2024 18:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uFBhy6khVP1TdRABQ209KW
 4Z2whhkQEQn+8bMqJc9Qo=; b=Efwewkgwor5d/HNePg+WaBoMdqgVuPmmWoRqHf
 KeWVGH9hrb0SZTo8l2vYvy2tvZ9jJOq8LwSrMGPNtx0s6EnE/rGiE5V68xZaO14W
 QhzSM5axLNEA0s4g+wdIacOqnmy4ktyR6TQI4q2+Q5D/jtZsV7byXsDbXZicOuLZ
 VxeMH8bKdRm8VxArd90pHufFRJfXBsEOY8I74E44w4kIBETw/fkAQivJdScbHpm7
 t+F5rGuCIrRYC/8/lo0xyRIcFO2TBftVprBb8SfqJZSkVagsazjQkYGUBxuaFbxC
 8B3nnhOCmAqv7TP63uO+0Vuikcu3tSiFIvp2oId9ahe5WVfg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cfhkdmhw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 18:12:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-725dd39ebe7so1418274b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733767966; x=1734372766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFBhy6khVP1TdRABQ209KW4Z2whhkQEQn+8bMqJc9Qo=;
 b=gVK210rdRsjmsbOCucx0JFElSFnWWzR9sWkif7vo5NSojujYY9qKxMSJscy3FbUAQ1
 XGeSpWVEFdd2alilom79fE9xH9XWGwRet7ETmGpfRmFaRGJR2BEdfARFZmczwvN/p2nW
 sOA9M+OZuyUKdkNnJOfAxtVPs4jTsUqYKFAJdXCOri+f6afVTzj7YWpQh1wS83/Ilemj
 Ve0np0l67Xs83lehl6jMe9eTXu1iFQLLPByeiVdCTTPWdVAMzub6YeQULtWnvSNdPQ5o
 dFrXqOpPYTvTAKgu04iqin0o3ZFwGMrZ+6Dn8ZWoCVwVG+jOtXvj/GfHqG1UVeDY6Xpw
 OWmg==
X-Gm-Message-State: AOJu0YyROKQsLOpyUHNupR36Wqg4k6AXgj2spO6du37caClBLWACX4Jy
 eEdRz2PwWc5HoTZ9+n4YnbJWvFUmYwSlLaMY2DORAzfhe/CY/opUCirpPkLUMCQCAMQOD7qdYQL
 o264ZCDKTb0Dardd2Fdbi9tDDgfBm0R65/d6mvHP7NOPeLU1hznCGu6hhkuvRgQ==
X-Gm-Gg: ASbGncs3Ksi8pkkZVBau+VKAQyzviaWWiNwxHxw5t8bisDKECch4Ne4vJiwt7wvjrDP
 r03rOBHlnTmY73IJDKfv9GehZPHoVsjgsSpIRwNTcx+YYn0OBr/yVFkOGnUCuTZqQjIPg7XkOPA
 VkqzEj6iXhbQXfaS2fR2H50o6EnlRDyt/ZC8N6/oyrzmBFJbTX14rqdUuISrPo8sbuR238VIuuG
 TPSW5ddNhesCHpSZYSOrB5rus/Qn4Pw9P+XcnVpfbWSVjTFTdH4TmLzX9XsoQd5T0S9JGdfNgGO
 UYQwrxE9EOW1fID8OSzoVsc=
X-Received: by 2002:a05:6a00:1399:b0:71e:2a0:b0b8 with SMTP id
 d2e1a72fcca58-7273c8f5070mr1749956b3a.1.1733767965666; 
 Mon, 09 Dec 2024 10:12:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrKslEf6i7lzvoHAjaMtTkLrJq92Z1JQKfoSQpipV6Lv3Xi6REMAArTRzEVjHAWv4eoiNr4w==
X-Received: by 2002:a05:6a00:1399:b0:71e:2a0:b0b8 with SMTP id
 d2e1a72fcca58-7273c8f5070mr1749936b3a.1.1733767965310; 
 Mon, 09 Dec 2024 10:12:45 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725d899efe4sm4230493b3a.161.2024.12.09.10.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:12:44 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org, quic_mburton@quicinc.com
Subject: [PATCH] MAINTAINERS: correct my email address
Date: Mon,  9 Dec 2024 10:12:42 -0800
Message-Id: <20241209181242.1434231-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MxjgKClOp6jVJxNmA43S9WoD2yIyMvkk
X-Proofpoint-GUID: MxjgKClOp6jVJxNmA43S9WoD2yIyMvkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxlogscore=849 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090141
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

Mea culpa, I don't know how I got this wrong in 2dfe93699c.  Still
getting used to the new address, I suppose.  Somehow I got it right in the
mailmap, though.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aaf0505a21..a338a8bbcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -226,7 +226,7 @@ F: target/avr/
 F: tests/functional/test_avr_mega2560.py
 
 Hexagon TCG CPUs
-M: Brian Cain <bcain@oss.qualcomm.com>
+M: Brian Cain <brian.cain@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
 X: target/hexagon/idef-parser/
-- 
2.34.1


