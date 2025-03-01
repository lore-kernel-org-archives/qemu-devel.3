Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA90C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFO4-0003RA-Te; Sat, 01 Mar 2025 00:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNv-0003KE-FM
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNt-0008AW-HS
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:35 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214ruhI014562
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R6sQ+Hs4TUF+J3sP3saPZexRfq+NNKwSmSPbT0gZTTM=; b=I3PCD3VlX9cG4rAw
 3LAO2GwLKTZmwWvkFKVK23cvPE3nOKS8rusZb7CAwc40LclnUHv9S9fxjCRJvAqq
 CU5F0gtXj3PUY0SI2yZVHU/ALWnxujElmeaXINUv1LPGMgZuu1vgfVnort6PH1zQ
 dVWfoDoBXwbfLkCe6QjTWe1a8wM0+mPBEkJpe1laHy7Mz41lCDk4tqEi94mvwigg
 nvEBWKx2qtoJZ9+Q6Z/BNncWWmo1coI6fG2XI/FQ3pnXiTnH9SvluQjgoDJLtIMF
 JURmfqujNf7t1gc9RpnF2SvTht/kTJUhZI4wuReJ/sEgdIwwru2mGrvOM4yMnFvV
 ARRbCA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t9905k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2234bf13b47so53066065ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806838; x=1741411638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6sQ+Hs4TUF+J3sP3saPZexRfq+NNKwSmSPbT0gZTTM=;
 b=NReTEbmGTD0IuQTREuxt7DFxJ1loeoKbFBvcW6yaDmyHRDbf7ev3k7V3bcpq5nOMNu
 nHcFgL9LGchzx6oZSivtPPhTsAxXy5Mm7HAg/ua/bL8TftN37jx4G2WAnVzojGRJ7s3G
 5d9tsGdF13UXW+pw3q3kZ4uLeUQRPwAhuas+wgX7UDdcfkuwNoB8QgQjWXKTI/pODyFp
 7AwMPBdKR1IsSZzbspC5iBm6IR7rG76lJnm1pk71Dco+TRjzALX3Lw2iAdu4BMKqbsO4
 LLNNQoHq5tz1BwIQfamAyJ/DlDKxtJw84CfOIQ6icGmOV6EtxGC1p/Qo54cFyl7yYciP
 GMcA==
X-Gm-Message-State: AOJu0YzB7r0i+vwFI+1sAmVGsLv7ncpterXwfYAjg1WVkV2JLhaxXOlR
 dC5tVo4CwlEQSnYPxYsBO3YPGfV3nFTpc8b5xI2u/Y+t3siRIRacwrnDL20NEMtin76s7vY2OqE
 HL2rdXPV0qQswN0kEibV5XnysnZNkf7ZQHYlZ0Csfz6b1HY1xWAEqNA5tFgPOqw==
X-Gm-Gg: ASbGncuk0uzSTE2tDxh2FGjThrPRRiJzYlm7/LrkLBiBCyKMI+5SzAlQuvc5f1fOEpb
 0pGCV/rwZKpwjf10MjWhzJvjr4mbSf0/TulY8pAfel6DOg6eTGH9ljt+7I5n/KbhHeNlqq2sV0Z
 LM4Z86Fv+wmbXC/tRDWNapl2hj9hkiunaHEA0Pw7iVl6yEel4s/mvjgoxlVKNDhUdiKi7J9fmqd
 zOxmP+bFih1WMKp4QhK9LZfyPXn1DCJoSaJOxr0yPkcekXsxBcN4Nem3dLcXMipVMcT99Ay/gC7
 EXJ4FtBOW4Ihj4Veva9OOl9l372H954qgw6ESmnSM+oDvRwO4/HptZl3VyEayrNj
X-Received: by 2002:a17:902:d48c:b0:21f:522b:690f with SMTP id
 d9443c01a7336-2236924426dmr103381735ad.46.1740806838648; 
 Fri, 28 Feb 2025 21:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNWUCYnHIMppH8meIX3MWVXSjoZ/Fo98IC/Gi8ubkxcUNIZiD+lBGR1DYWkUx1+SOrN9zFJg==
X-Received: by 2002:a17:902:d48c:b0:21f:522b:690f with SMTP id
 d9443c01a7336-2236924426dmr103381385ad.46.1740806838272; 
 Fri, 28 Feb 2025 21:27:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:16 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 23/38] target/hexagon: Add implicit attributes to sysemu macros
Date: Fri, 28 Feb 2025 21:26:13 -0800
Message-Id: <20250301052628.1011210-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 5tzmyKqYm50Cdd6_dNF4f-pQWKt6SejE
X-Proofpoint-GUID: 5tzmyKqYm50Cdd6_dNF4f-pQWKt6SejE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=740
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weSB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weQppbmRleCAxZTk0ZTFmZWY1Li43YjViYjJjZDQ2IDEwMDc1NQotLS0g
YS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9j
b21tb24ucHkKQEAgLTEyOCw4ICsxMjgsMTMgQEAgZGVmIGNhbGN1bGF0ZV9hdHRyaWJzKCk6CiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmVFJBUCIsICJBX0lNUExJQ0lUX1JFQURTX1BDIikK
ICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZTRVRfT1ZFUkZMT1ciLCAiQV9JTVBMSUNJVF9X
UklURVNfVVNSIikKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZTRVRfTFBDRkciLCAiQV9J
TVBMSUNJVF9XUklURVNfVVNSIikKKyAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZMT0FEX0xP
Q0tFRCIsICJBX0xMU0MiKQorICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlNUT1JFX0xPQ0tF
RCIsICJBX0xMU0MiKQorICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZkNMRUFSX1JURV9FWCIs
ICJBX0lNUExJQ0lUX1dSSVRFU19TU1IiKQogICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZkxP
QUQiLCAiQV9TQ0FMQVJfTE9BRCIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU1RPUkUi
LCAiQV9TQ0FMQVJfU1RPUkUiKQorICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlNFVF9LMF9M
T0NLIiwgIkFfSU1QTElDSVRfUkVBRFNfUEMiKQorICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigi
ZlNFVF9UTEJfTE9DSyIsICJBX0lNUExJQ0lUX1JFQURTX1BDIikKICAgICBhZGRfcWVtdV9tYWNy
b19hdHRyaWIoJ2ZMU0JORVcwJywgJ0FfSU1QTElDSVRfUkVBRFNfUDAnKQogICAgIGFkZF9xZW11
X21hY3JvX2F0dHJpYignZkxTQk5FVzBOT1QnLCAnQV9JTVBMSUNJVF9SRUFEU19QMCcpCiAgICAg
YWRkX3FlbXVfbWFjcm9fYXR0cmliKCdmUkVBRF9QMCcsICdBX0lNUExJQ0lUX1JFQURTX1AwJykK
LS0gCjIuMzQuMQoK

