Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049C7FEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aH-0007Gu-Cb; Fri, 27 Feb 2026 15:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a9-000719-Uj
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:05 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a8-0006rZ-3B
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:05 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0HwO3944649
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=; b=ku+CMhEGsZs4+Xew
 Oo+TxrCp6XfVayrmAHHfdLSK7X2was+am6AsSOETyuz3wJLTuN8ubG6uWJS2abhl
 cA0HAvYmLBq75czV8Lbv+qjLWdwXhRCV3w5GbXGpWQxLqwpAbAfbObm0X+l28//7
 Tx1FN9Ct/N4fiPpCoQNw31AbGuPasKfmYVufozExqeq9h+P5M9c7s1D35ZOVFod3
 kxtjczKZjfBrHXxcfOFbW5Tw9j+SUI0b25nls5fEbvtiZNj7EZoBL5NxMWBkxiv4
 icS1nDQCF2yBH5tPuNB6joGYYarfZsfNvPqJsJLCAV+2/Tn7MWxn5idqB7MTYcJr
 sLiFRA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck73q2d6u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:03 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d4c2b7f4caso20723053a34.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224622; x=1772829422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=P+BZENPS0Nss0WkIt2jEOWWz7/EF+ItryyH53aGV8Z6f055CjViRCC6WZsuziAkO7s
 /7DJfaW0p2HFurpDqyV8zfv+RPEJX4eKbWAG391JvMVMIFs7sfmdZAsTkh0qKWxT2AmI
 PT/yKd2tzD3P/9clBUheom1rAmCyBgg/htloBRIDYR0JekoUZQcQlMbBMZ7s8xh9PxQ2
 S1jZxG2nFTBHus+pGq07poHZbe5UH3nwY4Ccs4ywwRLOGhfGNPYpWTHErs48bmrTFk72
 Ld4jXNB+vkVJLzwkt+Qi9II9GOvVtRcbpPu+OW2HNJTbSq4gNCN4RqMrIS3JULCezFng
 w9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224622; x=1772829422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=rPpyuDW2lUuPqamRZjwvLePsSm6pJBsNhiDfdrZWuS0zTdEfYoHmTRySXwzHh71sB/
 9LLsSk51zKdMXy2rchQcPfhQrjxEWBZOW5ZAzYogpD9Su/prVqvyyRF4mm5qLwRz10VN
 MICNdz7KVO7iEaCO7KO/HFwdYeJI4WEFHRROsFAvjdb0v4dxen9XFiT5aLGlz23Rn58d
 3rUaYz1keYL/fZZq3roH4W1PcALyuFlR9nePoAX3gu7KYqH7o9Armn4wa5gXlvDWz3m5
 Pip+mzjFdUcohFFdgW6T9RSfS3/XY/EAvkvycZEe/gkwQv0wXz6UcatR6f8++KDkah+4
 hX7A==
X-Gm-Message-State: AOJu0Ywifq5X0l1uf8jXM40RQr5yuzgTMZzsMTQPq/+ewi1bFBoUOTsn
 WPI2E5Qa735LvibmHYHXCKHdraijY+1mlNqsNDxD7bp/hXuqAyCk4G61J7vY+IEYuuswwCPJ03z
 9RVzff12okyUMafrpkfwuKuNsVlR/jTYPqfVsSk8u2TsbWcWQ7iKHFoTBxLHc1WcE1w==
X-Gm-Gg: ATEYQzwENhF4Du7IFnVRaP1Mfj5ySHUefzpvMotII9u/08CW/NLr1Dr/+38ZwVgVWlo
 rLzvhIQGCEl8lRzULhIcgpSWgTNYUm/yoGT5IwC75jr9adSiUFcr4/HAxKImlXtrapz5fAs6mr1
 HxMxj1j+DvTMmu/FJlGc4o1Kruo7YjAUpJIwE8qXCSo7DssiJ4P+RLCqQZzkNUZvWQNCbKLGIjk
 Yey7QYEH1EIYw8sN9/G1sQYbA4yDWMZLiEWaqmdaNL7LVEccIBflIIK0iQfTy0/thNxi9dM7jD+
 5ppO8ntwl9QfgU/rybXYEYTPSL1ZNQeqtcUuvz2rG2mrfwtXuSp6zgpNIS+eDpwFRqrFsJ/cRrP
 w07af1HJldWm7KpvN2NPHKY9je3g/f/4hbFF4qaq+nPsdfphtpTMuS50HKfEgkv0sYqiwAw==
X-Received: by 2002:a05:6871:289:b0:3f1:664f:e8db with SMTP id
 586e51a60fabf-41626ede05fmr2610121fac.23.1772224622334; 
 Fri, 27 Feb 2026 12:37:02 -0800 (PST)
X-Received: by 2002:a05:6871:289:b0:3f1:664f:e8db with SMTP id
 586e51a60fabf-41626ede05fmr2610102fac.23.1772224621860; 
 Fri, 27 Feb 2026 12:37:01 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:01 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 22/37] target/hexagon: Define register fields for system
 regs
Date: Fri, 27 Feb 2026 12:36:12 -0800
Message-Id: <20260227203627.932864-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfXwPJHqJ+vs1GX
 dZf/JbKsoJ1fD762OUlgmqBykfnuUMybIaWWXUt25j8X4ec+zRc6i16TeN65ErwL+s2TS4zkebF
 j2eEMXqTD67N66K2NYmodUNlDh00wCVHorHbtaAECOlC01A9cWHvG2EOqzLhsszQeYF1SoZNDG5
 h9atX8R2YdWUck3i97RCx9IYMx6lg2mboIyEpdqTNY0ttfWXuVHXhIyTm45hL2b5/2bjKmbrYJA
 eFwTRbTBpC6AnxUPTzhFobILNEzBS6m7tLZP3rByUWT0M0CdI9c8ioTIiU0+cPpvO4VjUdiLfqt
 zTpr44dh7Rs8QRcCXU0H0/VN1TiDgAYsyJb2xTpHUWRmSuBHDI6fQDx6pOrzgbL8eNkXcN0d9GE
 bKUTsIqxXyCLseFTBfVJ0NRr3/spJg3OUtqphOFeoKz7Or3c4hl9DGmmAMK79i1rhLtDqDyDzIv
 il7ziTqJCEtG3jrctVw==
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69a2006f cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: q0jjkWfUFnebro_wNCM5NuLNEYHd2h9N
X-Proofpoint-GUID: q0jjkWfUFnebro_wNCM5NuLNEYHd2h9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

