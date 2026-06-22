Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D333CDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9J-0003P0-RW; Mon, 22 Jun 2026 18:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9F-0003OC-Io
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9D-0006Rz-VI
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbNIp2122921
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=; b=it
 0AbP5b/hW1YBmL5dLAYsucipE7typJAnMd9QHD+vbZ8H5XI4MUnvLFWoBLpWksrA
 9L1+XwpmXAzPQJ+lNHbun8N+rVuAssfFAVXC6sOZO+bhT2429RpwbK5oFGiAA/xw
 J60gYJvP9KbzqzOkClLK8lHpGONv4khOEKLeDRR2ukNLNvJnN6B9ih1hYzwhOWXO
 Ie2gYr8gpbZeZ2/DxcCyaURmvxCkm+zH9yQm6imeU89bQtEXNdZYlddOgUO6bRxw
 DWiiPfMp/N8eT4ZOu9GYNvLolF3WUsPWvkdGr6uBViJYMtG1scIBaW1xHVwiKuvo
 UyXc1mv7kmK57g5P5t/Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n41xwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso8976508eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167372; x=1782772172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=GTMK8E9XCFEzmsNGgMpAH7m+OAqaWJJcqg28+Yn7w4gvni2jjLQ5Zl9tA+3m4HMAZ3
 HzrWmTMBhAQKeiI6o4z2WJwd0qjxoqgovhABdTAtrz7m1AktrT8y9KpoN17vZpJ8ISHO
 FUMMC9YDT0DEuhypY3LRRJjbbRBPAcuviioIse3JCvPrNNMpTZImJRptkE+jUW5QcFY2
 WKHcS+J92DDrYBFjxcCmhoDKSoX18KhgRHV79WnwLLJ+OIzL6gojLyFCZvjYSWiydXPJ
 Hi5O5r16K9hCpoFbuO0I7z/ujQHK0Vlruq7vNJGisWQyKvEMV+mqWgjXhabzubbN5IwU
 vc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167372; x=1782772172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=O9ew6VNWTgXTMsLeXCh55LjPgia1mCbGbyFy5pE2NqwYW84BNSdLhUXKeaPXDfkePC
 o0I1si1ycY9ilLRY7opNXQR/WUpiilGcoEtPPhGadSmLfiYju/J6zGFfiaFK+5Xt/s/b
 KBALGoIDggKnRjmHtj+y0FbfyHZhbWS0En6aVdPltotEvaZqv8qOEdR2VlhLDByCI5xk
 N0Mx6EmVN6BVuCB+rEorvAh0DnXW496tqlYmoftZRYLYDZ7qpR2rebUdxtVeo0mqy7Cy
 TWEipMAQIZJB8uSIXG3Mhsn2ClX52GpKQus0ZzJr7ys3B4xX14HfDCN7u5PQ6qBQuXcp
 4SrQ==
X-Gm-Message-State: AOJu0Yz8zw4roOtdzXVTM2FTJNAND8+AJdWr2tbMW8OdivscNQFEJ4YA
 SC6/ItEh0vN5x1pLP0vyhDn3XZaWT51cFXi2ohq1uvaaaGyHNQACvmIemLhd15aYzamX0G4A6yg
 Tpqu/+fnNciy9KEAlpUy9rNHaeIgrBtVN6W5PYobwmLrFR+wJNP1S8lSQ9cuLtmm8WA==
X-Gm-Gg: AfdE7clvjWbE9thDzM3cNne0WcErIEyWbUbzcUplRf0+SLaoG52KqXTczXL19Chjdvm
 KFJfn930Xar9AlvtjU+9B9bLvnbjEedmwOoVT/NuNLbGBSt3EelhHUMzQ+kY07s5/goqg0wvfdt
 tOXcix3VhmaWEzfmPLjDkEgH6Rba963SEGJtI1u4w3bBI0TACmAr+F9Q9jQBU891vb9FWdkuXSl
 DsfKXcYULspZSZo7c4pHH4sxEsX1ikxUZkrrOKgeN/vLdZUwLEPY2n43Wm8/175JSKw53CgoE1J
 GBkG01gO5A/bZ1K8NyC8yjosP+lFhC1106E5Nxe/3oJeQMuH3GaRq7CcXyVPxqJo/5CDHpbIyjJ
 lya7v/nfonqIREmFo94dy2bckX7zTGYb2AQoIhCgDloD15BEIJ/LDod01IJg=
X-Received: by 2002:a05:7301:1e84:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-30c58ca4a5amr301169eec.27.1782167372027; 
 Mon, 22 Jun 2026 15:29:32 -0700 (PDT)
X-Received: by 2002:a05:7301:1e84:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-30c58ca4a5amr301155eec.27.1782167371526; 
 Mon, 22 Jun 2026 15:29:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 13/75] target/hexagon: Add TCG values for sreg, greg
Date: Mon, 22 Jun 2026 15:28:02 -0700
Message-Id: <20260622222904.607771-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX8Vq3ihD9Cu7k
 vz2sWydBcV3Vj7c975wezNpqAKWcClv26RntKRW9gadfuX9soo9n0lsopsPOmfODIqswxF7/Fhk
 65HHapbqVTeWNX35IMvv8tFQQ5WL2n4=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39b74d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8kp5zrIFwsha1M26KQwA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: OJvdoNyOBL_mHt4kGyfKB3vkCxEIMHIP
X-Proofpoint-GUID: OJvdoNyOBL_mHt4kGyfKB3vkCxEIMHIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXwqv39iQcF6KE
 qHa0h84PUByBJiVEFbaF056C8rB+mweriNfAxGKw/EtSJjj4cVugN8GrH3uy3GTVSMer6IHGbPi
 C3tPx1VdDlMkTPmvIhCNq0aZ6I2qFcNlh+8dwn+J7ddNn+RUTgWF8tW325k1Ype5SycqGOCEblH
 ErLTnbD/okZ/xnrr+H391ZH0K1nRg6cIKI2x06o5y5BeH2B0J5tszxwY7tK9iWIbKOqWHZawZOC
 S3IQ2cG264NvR/uiTjB6VK+UjPedNvbIHHGfj0xxryBn87tkT+Ji6zGMfHnyij+gSQKWLvViwf4
 uIccsho/9JiMC2ezfLqr2P9Uq1jEx/5NMbitTys4VnZ8gFJE5ktxTKWdwUlyPhBA6LFise/eBxV
 VLJxVX5CiO02BAe50H5pBFKMGK0k1/oFsUpYjAzIRsyZHrTkW3Ej3xx1MYFT7zLptWddj2eD6N2
 FEO6MjFK1bijqLJTMTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBkODBiYzUzMmUyNC4uZDhlZWE1NjE5MWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODIsNiArMjgyLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGQ2MTY1OGE3OThjLi45Nzg0OWFi
ODYxYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDg0LDYgKzEwODYsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAg
IGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICAg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3JlZ1tpXSksCisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9ncmVnbmFtZXNbaV0pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVN
X1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYs
CisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAor
ICAgICAgICAgICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKKyAgICAgICAgfQorICAgIH0K
KyNlbmRpZgogICAgIGZvciAoaSA9IDA7IGkgPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7IGkrKykg
ewogICAgICAgICBoZXhfZ3ByW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCiAgICAg
ICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGdwcltpXSksCi0tIAoyLjM0LjEKCg==

