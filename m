Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE31DFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Aa9-0001it-Mt; Tue, 10 Mar 2026 23:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa6-0001gR-76
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa4-0005GT-JI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AJ37FU3417072
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=; b=BrRj3Mb9dEE0uLBN
 QsJDNciWj7B4qlfUD1Qd3eyKAPgUwS+ldOWZb/333S0ZTFBZ12ajqOSTGe9K8fJP
 M/OUnrO00iRrbHVeJBOJRaM4tffMFZnNxZAmx0nFc3EX4mMm9tZH9TJO+8nBAKwU
 rx5vm0VBjC8f5B5IX/FHKjgH0OSbaQck6VOWqopI+HPwIozabFUgrCkUZO2t3/qV
 fvxDkzvhS3IgmvHXawDHuV6WBcCaz7BDaOOCNbaAHBHcS9O6l+GQJbZjr9XgvjXD
 iY4el6gOrQ6awxHh0565eA9u3R9Jo13IMmiUT16pNVXjyyg9/tGbaUz7gjQvAYed
 ErQOUA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2b8k8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:55 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d73bcdba71so39002268a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200994; x=1773805794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=U4a703qPYxrEGbQaSwIBwD/dfNFp5ALWk9TX3tRCLUgtYJ7awz9DbI78O/+pD280X8
 WvKAlAgmbhTe688yrSb+4FQFP6MYglhh/2l0G6vkZUnnFPuda9moUJ52jpTRI9qJhtTM
 RqY6X4PsZ9t1AunaK7uGDbKdtn/pacBEHkjJgKOxgp2JBtBTNHv7zoDpYVxFfVwJ6imz
 U6vMDWpu6NwQ7rHIOEZp/sOx5c2NJrzXAi+NwzVJE2CmN6j+5aZt+VIO6toUW3bHVXOR
 Vfh9rIDWl55umNMfe4BxzDrgPfmM3TeNyqitxqcYyGHSSXg6p9USYyptvS7jowKMTNZU
 E5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200994; x=1773805794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=RbweauzEZvz6PXeZKtsfhZRlJ82StyUK7yU96bIcIOwm06nu6NWWayedpJds5c/tb8
 mHs22a4ZHUWswX2zcWlTenRoAbe+tx6543E/sBB54UBWKLKDVILBhxg+9pVgAKnSNAed
 L3jDIkvaJb9l+Vrowc3KQc5KhaKw3nhtsYpVaHfE+kc8iQeYLszFIwozeTwlp1HzStWC
 UFwpWt25t53U/Whgrr7TnrO18eIoHQXPaD8FQcBKAUbECh/lP95IDPSwn6k2pZD38wDk
 NEyQEmch7Q6J2MOEJPt0arZnvrfqAqvNh6uYByNSqZ4vfaH3/xzERpnUW9Mc+eJc8K8B
 el1w==
X-Gm-Message-State: AOJu0YxVLsgdXYzimC/Qo2ntyU00y5Edv8gQWqhwaQIXJaWRArQxR33j
 +ZoT+aeh3aXbKJVcOmb3lk+r+fOYOvUOW3ou1q882g1EODgFDsrqLycJApy8zc1evybsa3vGDIl
 FCXpYte21aiLSZ7nLpFLiuLbBEvsbkITFUZHY4XkMMDG2NC5lqVNqV6GIbdZARNI33w==
X-Gm-Gg: ATEYQzz7uJkjey9FM+TifrJfSVYQOT+cCUhtDFHv9VBNutlbj/d4jsXE6RbgcR0h/1O
 g2tWn6KuvfStDA097vkHJNFWJQ3rbY5A8x7uQ+KxAiNEDZfhDH+Fsn3sCWJwuAJ7/6pMEcA9qmu
 ApBtv+8RWINCB4vDGcthh/irEL5+6B99Ex6RQw9DSPT/9GJptxQoDYnPhuqfskYTFT8ITkcS7Fe
 i7uQxr83r6Fvttlf4V3bx1N4/zUME0/H3Y3+PDf7GQvxNDZ5TS9UrqqIUKaCqEO6QS+0mc+oODw
 mwnVQ10nu7ZO7Nl59gILPZryiuWBVzDfgBFVuI8Eljy1bGjVzYfLK7j//5m6CbvuzPrHL03VEMy
 u2DF2xojWfy74xs2+KPVuqoy57UF5hjOscGAOJDqmDeKCVjYAdj2hcqUxy2yfkUebxr95pQ==
X-Received: by 2002:a05:6830:4392:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7d76a84427dmr903685a34.21.1773200994362; 
 Tue, 10 Mar 2026 20:49:54 -0700 (PDT)
X-Received: by 2002:a05:6830:4392:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7d76a84427dmr903665a34.21.1773200993952; 
 Tue, 10 Mar 2026 20:49:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 21/35] target/hexagon: Define register fields for system
 regs
Date: Tue, 10 Mar 2026 20:49:09 -0700
Message-Id: <20260311034923.1044737-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b0e663 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XvPKEBqsnXohp_pS3vIZ5ssSrXGqtKmb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfXzdabfJQrb56c
 gG7z9zfkHEZ6v4K6iVbsccP23boNDQqIRG2UaORmfBaPDOKOoA7e5/4wyvfMV/37ypr+7LGsgjo
 lWqwFPxMMQL6t8PF/IqjkVYJn0tLWxor529hmQW/1ZD6brCA7ClV9JQslfzZB03rzCYsswjvCUj
 abU9Xud/6BlP62OjC7vJhRpw26TD9OxXUxnP9sfq7E5WZm6qs9fxkxRGrnDjSKF0LAbYMKM7lwd
 Od/l2rMEUIPVINRGmycg/nQEG8MKvuv/1f6UfKky3DTW0zbqpBwPmD27I4Cqf1bKIYMJ8NENwMc
 L6sqMl+3TXVCbLsBS7g5OZ+6ZNG8EH6lHE4WCkdXghV/jOXs6piZlohULRx+rVpMIeLHEPZYq3Y
 wP6AGp2BByK9inUaWwKjVo1szs7svjQOBY/cTIaH2xQpA7Fwzs9x4Zf2YRCmu4un5siUV9AVPUn
 ANn9mRa0x5Lj8UWjF1g==
X-Proofpoint-GUID: XvPKEBqsnXohp_pS3vIZ5ssSrXGqtKmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgdGhlIHJlZ2lzdGVy
IGZpZWxkcyBmb3Igc3NyLCBzY2hlZGNmZywgc3RpZCwgYmVzdHdhaXQsIGNjciwKbW9kZWN0bCwg
aW1hc2ssIGlwZW5kYWQuCgpEZWZpbmUgdGhlIGZpZWxkcyBmb3IgVExCIGVudHJpZXMuCgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyB8IDk2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24v
cmVnX2ZpZWxkc19kZWYuaC5pbmMKaW5kZXggZjJhNThkNDg2YzUuLjliMTEyY2NlYzY0IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYworKysgYi90YXJnZXQv
aGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwpAQCAtMzksMyArMzksOTkgQEAgREVGX1JFR19G
SUVMRChVU1JfRlBEQlpFLCAgICAgICAgMjYsIDEpCiBERUZfUkVHX0ZJRUxEKFVTUl9GUE9WRkUs
ICAgICAgICAyNywgMSkKIERFRl9SRUdfRklFTEQoVVNSX0ZQVU5GRSwgICAgICAgIDI4LCAxKQog
REVGX1JFR19GSUVMRChVU1JfRlBJTlBFLCAgICAgICAgMjksIDEpCisKK0RFRl9SRUdfRklFTEQo
SVBFTkRBRF9JQUQsIDE2LCAxNikKK0RFRl9SRUdfRklFTEQoSVBFTkRBRF9JUEVORCwgMCwgMTYp
CisKK0RFRl9SRUdfRklFTEQoU0NIRURDRkdfRU4sIDgsIDEpCitERUZfUkVHX0ZJRUxEKFNDSEVE
Q0ZHX0lOVE5PLCAwLCA0KQorREVGX1JFR19GSUVMRChCRVNUV0FJVF9QUklPLCAwLCA5KQorCisK
Ky8qIFBURSAoYWthIFRMQiBlbnRyeSkgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKFBURV9QUEQs
IDAsIDI0KQorREVGX1JFR19GSUVMRChQVEVfQywgMjQsIDQpCitERUZfUkVHX0ZJRUxEKFBURV9V
LCAyOCwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX1IsIDI5LCAxKQorREVGX1JFR19GSUVMRChQVEVf
VywgMzAsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9YLCAzMSwgMSkKK0RFRl9SRUdfRklFTEQoUFRF
X1ZQTiwgMzIsIDIwKQorREVGX1JFR19GSUVMRChQVEVfQVNJRCwgNTIsIDcpCitERUZfUkVHX0ZJ
RUxEKFBURV9BVFIwLCA1OSwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX0FUUjEsIDYwLCAxKQorREVG
X1JFR19GSUVMRChQVEVfUEEzNSwgNjEsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9HLCA2MiwgMSkK
K0RFRl9SRUdfRklFTEQoUFRFX1YsIDYzLCAxKQorCisvKiBTWVNDRkcgZmllbGRzICovCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19NTVVFTiwgMCwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0lDRU4s
IDEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19EQ0VOLCAyLCAxKQorREVGX1JFR19GSUVMRChT
WVNDRkdfSVNEQlRSVVNURUQsIDMsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19HSUUsIDQsIDEp
CitERUZfUkVHX0ZJRUxEKFNZU0NGR19JU0RCUkVBRFksIDUsIDEpCitERUZfUkVHX0ZJRUxEKFNZ
U0NGR19QQ1lDTEVFTiwgNiwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX1YyWCwgNywgMSkKK0RF
Rl9SRUdfRklFTEQoU1lTQ0ZHX0lHTk9SRURBQk9SVCwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU1lT
Q0ZHX1BNLCA5LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfVExCTE9DSywgMTEsIDEpCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19LMExPQ0ssIDEyLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfQlEs
IDEzLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfUFJJTywgMTQsIDEpCitERUZfUkVHX0ZJRUxE
KFNZU0NGR19ETVQsIDE1LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJDRkcsIDE2LCAzKQor
REVGX1JFR19GSUVMRChTWVNDRkdfSVRDTSwgMTksIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19M
Mk5XQSwgMjEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMk5SQSwgMjIsIDEpCitERUZfUkVH
X0ZJRUxEKFNZU0NGR19MMldCLCAyMywgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyUCwgMjQs
IDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19TTFZDVEwwLCAyNSwgMikKK0RFRl9SRUdfRklFTEQo
U1lTQ0ZHX1NMVkNUTDEsIDI3LCAyKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJQQVJUU0laRSwg
MjksIDIpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMkdDQSwgMzEsIDEpCisKKy8qIFNTUiBmaWVs
ZHMgKi8KK0RFRl9SRUdfRklFTEQoU1NSX0NBVVNFLCAwLCA4KQorREVGX1JFR19GSUVMRChTU1Jf
QVNJRCwgOCwgNykKK0RFRl9SRUdfRklFTEQoU1NSX1VNLCAxNiwgMSkKK0RFRl9SRUdfRklFTEQo
U1NSX0VYLCAxNywgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0lFLCAxOCwgMSkKK0RFRl9SRUdfRklF
TEQoU1NSX0dNLCAxOSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1YwLCAyMCwgMSkKK0RFRl9SRUdf
RklFTEQoU1NSX1YxLCAyMSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0JWUywgMjIsIDEpCitERUZf
UkVHX0ZJRUxEKFNTUl9DRSwgMjMsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9QRSwgMjQsIDEpCitE
RUZfUkVHX0ZJRUxEKFNTUl9CUCwgMjUsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9YRTIsIDI2LCAx
KQorREVGX1JFR19GSUVMRChTU1JfWEEsIDI3LCAzKQorREVGX1JFR19GSUVMRChTU1JfU1MsIDMw
LCAxKQorREVGX1JFR19GSUVMRChTU1JfWEUsIDMxLCAxKQorCisvKiBtaXNjIHJlZ2lzdGVycyAq
LworREVGX1JFR19GSUVMRChJTUFTS19NQVNLLCAwLCAxNikKKworREVGX1JFR19GSUVMRChTVElE
X1BSSU8sIDE2LCA4KQorREVGX1JFR19GSUVMRChTVElEX1NUSUQsIDAsIDgpCisKKy8qIE1PREVD
VEwgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKE1PREVDVExfRSwgMCwgOCkKK0RFRl9SRUdfRklF
TEQoTU9ERUNUTF9XLCAxNiwgOCkKKworREVGX1JFR19GSUVMRChDQ1JfTDFJQ1AsIDAsIDIpCitE
RUZfUkVHX0ZJRUxEKENDUl9MMURDUCwgMywgMikKK0RFRl9SRUdfRklFTEQoQ0NSX0wyQ1AsIDYs
IDIpCisKK0RFRl9SRUdfRklFTEQoQ0NSX0hGSSwgMTYsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9I
RkQsIDE3LCAxKQorREVGX1JFR19GSUVMRChDQ1JfSEZJTDIsIDE4LCAxKQorREVGX1JFR19GSUVM
RChDQ1JfSEZETDIsIDE5LCAxKQorREVGX1JFR19GSUVMRChDQ1JfU0ZELCAyMCwgMSkKKworREVG
X1JFR19GSUVMRChDQ1JfR0lFLCAyNCwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX0dURSwgMjUsIDEp
CitERUZfUkVHX0ZJRUxEKENDUl9HRUUsIDI2LCAxKQorREVGX1JFR19GSUVMRChDQ1JfR1JFLCAy
NywgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX1ZWMSwgMjksIDEpCitERUZfUkVHX0ZJRUxEKENDUl9W
VjIsIDMwLCAxKQorREVGX1JFR19GSUVMRChDQ1JfVlYzLCAzMSwgMSkKLS0gCjIuMzQuMQoK

