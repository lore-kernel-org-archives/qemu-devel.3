Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A3FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we399-0001Y7-To; Sun, 28 Jun 2026 23:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we396-0001WX-Gw
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we392-0006C1-DA
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d1Gr1519059
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=; b=c/3RGnWiMzaA5lZ0
 ux4WTwxVUv8FxUj/0/hmTsT8yUJm4/F88CnyDVHMYMdn4iiR48X7f6n+7h/WtkMr
 aRXc7L+m/4LwSVWcPMpvBKMhIKGnG66nCLDw9hAoxbamOZXM8VwWuxrCoP2fFJ6s
 a9rwupd/Q2RuPYd3GIXkAVmRYRMRbAVSsy0A7Xv1BfqS4eq4RjR+X8DwlOuSKM0v
 oCDlKUeBVLMme/pJhPAfOm2S8ifPr8i27rQaAP669UVXK8M43QTqM1ok+XmYCXda
 vc2rRGB41jYh68sz7+smWbzPLVOVjGcsVaHCkdvoUzt+TQ8RD1subSIzaKWJXbXD
 H5SThQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734cdc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:51 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so6677465eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705530; x=1783310330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=;
 b=EOTfeAcHqm9URz+GJ/i1ud78OcuFjfnoArCTJmzLvJ/4/QYO/9+Pg42SnngUI8rhLV
 lDi6y8ckeXUlacIkoaxcBEFFo9B0TkkbM9TAxA8RTYmn6R8zMzX1gqkBW8hgCkkNdXbW
 49zj0opc/XBupBpzS1mONvDsBwwdmVVBnxl+0lwWawAPhSTXEUc0ncVUrJH+UgM6gyjq
 NrBTyD8ajwoYVRArNULlMaW4vi+c8tyydfHqjG3RHpEz/LccLUAFXpJAxOK8EMSNj7DC
 jaLBGfmUeEOvkyo2oD3pJu3rBRUJtGsAEjU4nX3gcqhoGKmMb86x/FQDDo9pkYlx7Pyl
 HoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705530; x=1783310330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=;
 b=M59rPK5O4PpiWJo2iBACPZZo4iG4nX3Q5s8P4bgXIQUoSfpdKcWbcOvCMaWeLPVpcr
 tZvSwijA9QUNyzwcCHgsAcimLavfz2N057HXPXNDSiyZQWjWY2/esGoVFn+skBCsgsZT
 6LsrFk6KouErdDqyrmVemPMtxNK0GL0sd7PwHMuavCycP+D1AfDBFHubrUdlm5nG6GVR
 BfML1bVfxXFzqFWQSGHR8sG0/Xs2x00Hn93C+STrWyYdNZbw2eP9lHP1WKM/XTBLCLs1
 YO+LJQ0syTTm0LnphDpWp/3T3KEU3TlyBVQn690ZmGVqjN2lFP5b/MF4tVCaeA/Lr8rl
 RA0w==
X-Gm-Message-State: AOJu0YxXTpPPjZt6cwtauU5oD9k0X+az4GHRg9UGq6l5KsdGJ/Nqla0x
 xVRPG9cgN+FShaZdX+rbdQqDSkHy8ROw57VTFODCUTbfGf2YjbmhLh8h8/DaAkK3EX5RTORtVvV
 K7SJocE1EGdfpHgiLX9rQEwnfjzV7ykMcqFcAoPX0ex8Zy98SLLiHaK7F0rIgLlSUwg==
X-Gm-Gg: AfdE7cn2BBtJw7BFexlCWcxuKRd09wfQh34d4yvyiDUWYYqMu5zCYW+DlThs7wtoc6P
 KtfalsqpiaMk0zKXym4v/JSzxcJBZUpDAr07M9E5fIfgXk7Y5H+McdDmVKkQ8o8GDvk5tJeORFn
 1MEGDoE6Y8LS5RO4BI3QXG1TRXUt2yu1sEaaUwM+RBZwEDnjfHweX0InfjXDDrKn2ps624kyqlY
 QddzvyH5amcoybo0bdwcrlT7teNjGZ+RCFxX3ij+fyfhZV3kBNWxycMA/EDXLin1XYA91Qyu2Kw
 f30qYkksPSHxjd2C+48iHViMxCBZMiLIEri+SffhXlGk8rUBjmipJ2fJR8OHjVeGQj6/1YiNPfS
 ZTXn5u3288zTzdweMTh3flu2iT763N9WbHa719RqDsrtH7uA5CSK3soePNjA=
X-Received: by 2002:a05:7301:e8d:b0:30c:ab4d:3833 with SMTP id
 5a478bee46e88-30cab4d3cb4mr7058426eec.42.1782705529987; 
 Sun, 28 Jun 2026 20:58:49 -0700 (PDT)
X-Received: by 2002:a05:7301:e8d:b0:30c:ab4d:3833 with SMTP id
 5a478bee46e88-30cab4d3cb4mr7058406eec.42.1782705529460; 
 Sun, 28 Jun 2026 20:58:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 06/77] docs/system: Add hexagon CPU emulation
Date: Sun, 28 Jun 2026 20:57:19 -0700
Message-Id: <20260629035830.1520296-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: f2_8Ils9tI_HPjYqxYWF_NDf6c86y452
X-Proofpoint-ORIG-GUID: f2_8Ils9tI_HPjYqxYWF_NDf6c86y452
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXzkeLqpUlIG5h
 vVIfWMfgIDX+LH9p7tejkd1vKoI1b5Dd1MQRbKzhAgjhIz1LfrtRm5qVAlJL7GCxd/wLKKu+XNZ
 e3leRUElKXe2wqkS22NlAt6Kj4G8/IM=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a41ed7b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=14gtCLEoMj5qQ5-DTC4A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX8sYqXs7t0jr3
 lK89acWaHsf+EDcVH4LFDh0mkFXYuxAikzmIHWW7kiR8xh5SisnIzmOcGY71HsXBvRxiB0b/8Pr
 q1dEas7hhdeCj0AGDCesDAHnhtamliKYh7pq3GGCuhq6P2YVXPkmRLWGonAPSf379YViJoXeAKc
 3NWsztL8V1X12w3xIGgnoIJbGNHECamTfmLOM/WzMn8WuttbaHyq+iLfLc9sxrOfId1UmeAnW0/
 Tw0XoycAAq/KjCPoN1E1j2f71R8lqPxC+FenJdFVl/OCCQ/AqbyABN68sLD/wy+nutAN2Eg6Gbv
 ZYulk9YrbwfPoHTrtHFc7BT5NfKs4Fs0BgvqxnYtZV0goyaTRR9uhtfSKRCS9fF3SQeOi1Gb7QJ
 IS64zFwbt6OiMeZc13JEYF9suFs1ooqZQcR5XMcu3UXq+uPF7GrApWpisLc/8JT875oXgPqgYN1
 TArqefoyPEbcj6B7iIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290031
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdCB8IDE1ICsrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0ICAgIHwgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdAoK
ZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCBiL2RvY3Mvc3lz
dGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwMDAwMC4uMzZmNTRmMDU4YWYKLS0tIC9kZXYvbnVsbAorKysgYi9kb2NzL3N5c3RlbS9oZXhh
Z29uL2VtdWxhdGlvbi5yc3QKQEAgLTAsMCArMSwxNSBAQAorLi4gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworLi4gX0hleGFnb24gRW11bGF0aW9uOgorCitIZXhh
Z29uIENQVSBhcmNoaXRlY3R1cmUgc3VwcG9ydAorPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KKworUUVNVSdzIFRDRyBlbXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBmb3IgdjY1LCB2
NjYsIHY2NywgdjY4LCB2NjksIHY3MSwgdjczLgorSXQgYWxzbyBoYXMgc3VwcG9ydCBmb3IgdGhl
IGZvbGxvd2luZyBhcmNoaXRlY3R1cmUgZXh0ZW5zaW9uczoKKworLSBIVlggKEhleGFnb24gVmVj
dG9yIGVYdGVuc2lvbnMpCisKK0ZvciBpbmZvcm1hdGlvbiBvbiB0aGUgc3BlY2lmaWNzIG9mIHRo
ZSBIVlggZXh0ZW5zaW9uLCBwbGVhc2UgcmVmZXIKK3RvIHRoZSBgUXVhbGNvbW0gSGV4YWdvbiBW
NzMgSFZYIFByb2dyYW1tZXIncyBSZWZlcmVuY2UgTWFudWFsCis8aHR0cHM6Ly9kb2NzLnF1YWxj
b21tLmNvbS9idW5kbGUvcHVibGljcmVzb3VyY2UvODAtTjIwNDAtNTMucGRmPmBfLgpkaWZmIC0t
Z2l0IGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0CmluZGV4IDY1ODY2Mjk2NzI0Li40MTZiOGY3YmU3NiAxMDA2NDQKLS0tIGEv
ZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1o
ZXhhZ29uLnJzdApAQCAtOTgsNCArOTgsNiBAQCBpcyBub3QgeWV0IGltcGxlbWVudGVkIGluIFFF
TVUgaGV4YWdvbi4KIEhleGFnb24gRmVhdHVyZXMKID09PT09PT09PT09PT09PT0KIC4uIHRvY3Ry
ZWU6OgorICAgaGV4YWdvbi9lbXVsYXRpb24KICAgIGhleGFnb24vY2RzcAorCi0tIAoyLjM0LjEK
Cg==

