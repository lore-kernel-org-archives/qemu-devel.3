Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE90C79F9B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2wYd-0006pU-9F; Sat, 05 Sep 2026 16:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2wYb-0006mh-9A
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:00:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2wYZ-00057j-Fh
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:00:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HcXRd2988254
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=; b=lbflV3VxjM7NpP4c
 hnSwENuXKWCm682uZp1QJYx07Pp7S0RF/6SJXUyd7S6hsND7wOGuRFE2uC54mrU1
 i2neArUekDhu2mxs5XN0ysrq5fiorwC4r5MfpSdxid1RFBp5SNlpXdEnJ/iPLMqT
 cXrxjukfjJ7DfuXBgPr1WWV/JQQcetK7/NB6erzY33L0UxBPhj2uAx+OjzuaLFwb
 FyTvqiMKasaugneX8jbJLUkZdMpxYGM0fonkbJY39YNdAimPsSU4vsZxS2ZaUdnr
 veG0z5chKB0FXuh7e73dYoHyeUDVTMLKgzMDPRCzHXJoalS3RBJzLFJ2R1s29gke
 5NhhYw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggba3j4sm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:00:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so4386621a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638405; x=1789243205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=;
 b=eqjui18SJyFqNPtP8cb6uAN17RF/Ijvg+FGki86Ln3EUDapokSnA6g/Sn9wIph37fP
 R8RnFJ6ywW02z9MTE5JXTf7aVLGQrhJ12xHRWlK3HQtClvRL9+cSBjVix88s2DB5Mok6
 2gJpCslHCHmSFetaYQc5Vh8SyVL9x2zdLKLcfgZCCSI8ciOM0KYB21XR6VMhEmxV2bG6
 U34i/SsQsVGGvkLlp7qGLFDWDjvDvCo21tSerT6SriPUSg5QxMN1traIep/pxRxZ5wyp
 ncrCJ2K/7Zv6NtjVHN5amshxucAv+wW3EudfMAkIE2G5sfvqK6378LzxG4D9o8el2gcp
 Acqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638405; x=1789243205;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=;
 b=OV2DDY4QzgAmjOzbUywtvlwzvh553VLvirTRwOI3avfdBgnPrcYwHLr/oU0DtmHYOU
 O3k/2/L7TweceRPLI98B1UZcfnPSEnJrs7NOfF9k7BwwWgT3VIIdn6R9XBuPVGHZvEIf
 eKcWaeiEvHmTBiy0S+NfLiuBpEbU00RlLMFN21bn3z4NLsbIIO/azdHY8Wc5ZzSkLfa5
 3lvtFI2eA9tBm1Vif1HucCqgtaQ6Udrelnp9id6xbXVC3jYXcl2HTb0JT/T5OLjzzlR3
 2M58YE/LCtAkIca2nI04vWsMDRPX2ywsuwj+H+3wTomRNnKAa2ZJOuXYD72hDAnQdD3t
 KdGQ==
X-Gm-Message-State: AFuF++k6wkSIIArv7kIZuNmKIkB5K/AEBSGB/2ExVhyiH2HOfi7p4s9z
 NJ/AesmiE4Pj/VC7JZhzapASPVYS/EZPKYlAP3M7BEh6BOyBvSFxwKy+IHcfhsiFvTesAHqaYcx
 zactJv312jpfVjR/jZuNVVcJer5HIEDsqPEqzkqnfqflqrFF7StjPD8SmUkburJnG3w==
X-Gm-Gg: AYBFou3JaUI560SrbNw2P9+yRPAd/KDvPYhGa9L4/WjkrSVBr/WvndRCuDzuzOU51et
 rX30IUPqiom1JJlUOGSNCWVP/oKS8i/1DbVmnEcnoo703EZgIBEEJjD8M/ogZz+J5xPWtUZJrF0
 9zXhv0G0HyduxGecEyd3a0VSrtM9+NYvWzX1GU0WJYxriwSFZmfQYpYHHranpJ6EslC691FIMi9
 PS34NQ2d2cu4Ojhrwm8FCWAz4kfmuGYmTblrgXdq1ntUdcz+BxE2H13POtOkn47C1en71zQPgGH
 1kN7jVAdHdRX2l+kcAbZZwbBBC7Du5eUXhqz4omw3IP6nWB3XsZ4cntaO5b6oXwYWUeJt2jp4EI
 esghVr76wr+bY6Vo3nljj7obRQSbBE7aV+9qK2ml2QZc7cKXF
X-Received: by 2002:a05:6a20:7288:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3da397c5713mr20059626637.0.1788638405263; 
 Sat, 05 Sep 2026 13:00:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:7288:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3da397c5713mr20059583637.0.1788638404860; 
 Sat, 05 Sep 2026 13:00:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3342af0bc08sm14316431eec.17.2026.09.05.13.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:00:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 5/6] tests/tcg/hexagon: check the two HVX predicate build
 paths agree
Date: Sat,  5 Sep 2026 12:59:54 -0700
Message-Id: <20260905195955.2001304-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
References: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMiBTYWx0ZWRfXyrmyC5yBThWu
 w1VX+eckIMa6AURXrVlkQMxiNVff6ynPTAPmEL1sdntkoo1EqIXsdAaeaOMepg31SEH4UXA8RWn
 UDSHJK2XT8FYnlRrNYrZ9M86BygbrrfrPaLbl3S2x1zUphJW0lKHDWgV4yVFC75pWlssVuFlr84
 4xYAQAwc8rLA2zIVzPVrxo5sqcqAVcbcSTan5enJsp9Nx8MH5ppgDH13g4gUz9TTFI2QGF/9EB8
 OEPluM8iVSI7L9+jQrTSJ7q49lD7vy2z9H1kWuAw1ISi+ZmceweFe73bVtpfE/nqFARXk0tWIkt
 IQIX+1Z8ddR9aVT77BVAtIh48sDFHiveP35Ymh6Klhv0At6a9qfCApHPfO8Ku8PaAzCqVDVC0/s
 Fu7XSV6aRBvLzArQ+vH2HN76oynKiE1TmAKhtw/1eFAw9WDnXetgn+JJNWg6/j5XoHiUwJvAupP
 EZccE4HFTLnmMrpBI9g==
X-Proofpoint-ORIG-GUID: L2vCqq2c8iAsJ6TQ8GAMoiMXwPO1C9Kn
X-Proofpoint-GUID: L2vCqq2c8iAsJ6TQ8GAMoiMXwPO1C9Kn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMiBTYWx0ZWRfXy5dw02HE6Exx
 6IAt2nVVfo7myObcbkaDMaufGe5t16c34sY8WgKA8LaS0XoT+ThOcJ3DZ1qusJvufxSIai/JiRe
 7Kha4A2YxGt/axv4n9nYAMLt3kSKHwE=
X-Authority-Analysis: v=2.4 cv=Tf2mcxQh c=1 sm=1 tr=0 ts=6a9c74c6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jjHI2IJ3bfbFesgfRcwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050222
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

QSBRIHJlZyBjYW4gYmUgYnVpbHQgYnkgYSB2ZWN0b3IgY29tcGFyZSBvciBieSB2YW5kKFZ1LCBS
dCksIGFuZAp0aG9zZSByZWFjaCB0aGUgcHJlZGljYXRlIHJlZ2lzdGVyIHRocm91Z2ggaW5kZXBl
bmRlbnQgY29kZSBwYXRocy4gQ2hlY2sKdGhhdCBib3RoIHNlbGVjdCB0aGUgc2FtZSBieXRlIGxh
bmVzLCBzbyBhIGJ5dGUtb3JkZXIgbWlzdGFrZSBpbiBlaXRoZXIKb25lIGlzIGNhdWdodC4KClRo
ZSBpbnB1dCBhbHRlcm5hdGVzIGV2ZXJ5IGVpZ2h0IGxhbmVzOiBhIGZsYXR0ZXIgcGF0dGVybgpz
dGF5cyB1bmNoYW5nZWQgd2hlbiBwcmVkaWNhdGUgYnl0ZXMgYXJlIHBlcm11dGVkIGFuZCBoaWRl
cyB0aGUgYnVnLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgfCA0NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggMzJhMzY2MWE4NmYuLjIyNTY2NjEzN2M5IDEw
MDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9o
ZXhhZ29uL2h2eF9taXNjLmMKQEAgLTE4MSw2ICsxODEsNTAgQEAgc3RhdGljIHZvaWQgdGVzdF9z
dG9yZV91bmFsaWduZWQodm9pZCkKICAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMik7CiB9
CiAKKy8qCisgKiBBIFEgcmVnaXN0ZXIgY2FuIGJlIGJ1aWx0IGVpdGhlciBieSBhIHZlY3RvciBj
b21wYXJlIG9yIGJ5IHZhbmQoVnUsIFJ0KS4KKyAqIFRob3NlIGFyZSB0d28gaW5kZXBlbmRlbnQg
Y29kZSBwYXRocyBvbnRvIHRoZSBzYW1lIHByZWRpY2F0ZS1yZWdpc3RlcgorICogbGF5b3V0LCBz
byBjcm9zcy1jaGVjayB0aGF0IHRoZXkgc2VsZWN0IGV4YWN0bHkgdGhlIHNhbWUgYnl0ZSBsYW5l
cy4KKyAqIEEgYnl0ZS1vcmRlciBtaXN0YWtlIGluIGVpdGhlciBvbmUgc2hvd3MgdXAgaGVyZSBh
cyBhIG1pc21hdGNoLgorICoKKyAqIFRoZSBpbnB1dCBwYXR0ZXJuIGhhcyB0byB2YXJ5IGFjcm9z
cyA4LWxhbmUgYmxvY2tzLCBvdGhlcndpc2UgYSBwcmVkaWNhdGUKKyAqIHdob3NlIGJ5dGVzIGFy
ZSBwZXJtdXRlZCBzdGlsbCBzZWxlY3RzIHRoZSBzYW1lIGxhbmVzIGFuZCB0aGUgbWlzbWF0Y2gg
aXMKKyAqIGludmlzaWJsZS4KKyAqLworc3RhdGljIHZvaWQgdGVzdF9xcmVnX2FsaWFzKHZvaWQp
Cit7CisgICAgSFZYX1ZlY3RvciAqcGNtcCA9IChIVlhfVmVjdG9yICopJm91dHB1dFswXTsKKyAg
ICBIVlhfVmVjdG9yICpwYW5kID0gKEhWWF9WZWN0b3IgKikmb3V0cHV0WzFdOworICAgIEhWWF9W
ZWN0b3IgaW5wdXQ7CisgICAgSFZYX1ZlY3RvciBvbmVzOworICAgIEhWWF9WZWN0b3JQcmVkIHFj
bXA7CisgICAgSFZYX1ZlY3RvclByZWQgcWFuZDsKKworICAgIGZvciAoaW50IGkgPSAwOyBpIDwg
QlVGU0laRTsgaSsrKSB7CisgICAgICAgIC8qCisgICAgICAgICAqIEJ1aWxkIDAvMSBwZXIgYnl0
ZSwgYWx0ZXJuYXRpbmcgZXZlcnkgOCBsYW5lcywgc28gdGhhdCAiIT0gMCIgYW5kCisgICAgICAg
ICAqICJsb3cgYml0IHNldCIgZGVzY3JpYmUgdGhlIHNhbWUgbGFuZXMuICBUaGVuIGZvcm0gb25l
IHByZWRpY2F0ZQorICAgICAgICAgKiB3aXRoIGEgY29tcGFyZSBhbmQgdGhlIG90aGVyIHdpdGgg
dmFuZChWdSwgUnQpLCBzdG9yZSAweGZmIHRocm91Z2gKKyAgICAgICAgICogZWFjaCwgYW5kIHJl
cXVpcmUgdGhlIHR3byByZXN1bHQgdmVjdG9ycyB0byBiZSBpZGVudGljYWwuCisgICAgICAgICAq
LworICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUzsgaisrKSB7
CisgICAgICAgICAgICBleHBlY3RbMF0udWJbal0gPSAoKGogPj4gMykgKyBpKSAmIDE7CisgICAg
ICAgIH0KKyAgICAgICAgbWVtY3B5KCZpbnB1dCwgJmV4cGVjdFswXSwgc2l6ZW9mKE1NVmVjdG9y
KSk7CisgICAgICAgIG1lbXNldChvdXRwdXQsIDAsIDIgKiBzaXplb2YoTU1WZWN0b3IpKTsKKwor
ICAgICAgICBvbmVzID0gUTZfVl92c3BsYXRfUigweGZmZmZmZmZmKTsKKyAgICAgICAgcWNtcCA9
IFE2X1FfdmNtcF9ndF9WdWJWdWIoaW5wdXQsIFE2X1Zfdnplcm8oKSk7CisgICAgICAgIHFhbmQg
PSBRNl9RX3ZhbmRfVlIoaW5wdXQsIDB4MDEwMTAxMDEpOworICAgICAgICBRNl92bWVtX1FSSVYo
cWNtcCwgcGNtcCwgb25lcyk7CisgICAgICAgIFE2X3ZtZW1fUVJJVihxYW5kLCBwYW5kLCBvbmVz
KTsKKworICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUzsgaisr
KSB7CisgICAgICAgICAgICBjaGVjayhfX0xJTkVfXywgaSwgaiwgb3V0cHV0WzBdLnViW2pdLCBv
dXRwdXRbMV0udWJbal0pOworICAgICAgICB9CisgICAgfQorfQorCiBzdGF0aWMgdm9pZCB0ZXN0
X21hc2tlZF9zdG9yZShib29sIGludmVydCkKIHsKICAgICB2b2lkICpwMCA9IGJ1ZmZlcjA7CkBA
IC01NzksNiArNjIzLDcgQEAgaW50IG1haW4oKQogICAgIHRlc3Rfc3RvcmVfdW5hbGlnbmVkKCk7
CiAgICAgdGVzdF9tYXNrZWRfc3RvcmUoZmFsc2UpOwogICAgIHRlc3RfbWFza2VkX3N0b3JlKHRy
dWUpOworICAgIHRlc3RfcXJlZ19hbGlhcygpOwogICAgIHRlc3RfbmV3X3ZhbHVlX3N0b3JlKCk7
CiAgICAgdGVzdF9tYXhfdGVtcHMoKTsKIAotLSAKMi4zNC4xCgo=

