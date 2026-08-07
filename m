Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FDCC2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMPS-0000m5-FF; Fri, 07 Aug 2026 11:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPQ-0000lY-BI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPO-0006jU-Rr
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677DdZ2E849735
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FmAyBZka4bURto3eJrRm/NoI/RI5qnZItamazTRfnzA=; b=nnfz/1EVUcu06QJw
 eUlqrzo8VcpENPd3cXAkh8F0WuPLmLZVCH+kROUzYmYyOMVEdUl6MsP0lj6kryvN
 75GfsqlwjB4JGO9cgQqdapg3VPXQ+woGkBXmng+KuttoPZcSBl3r0lOMbFcZ8CqY
 SH/lBavxxxcxBeunv0OnC8u/WKkFsdpuY38Am12t+MoLwiQO2VErl1wgCKStxLf8
 pRRh5Zi/ao7z1L8dWb8hBUy9ukv58YBFS915rMxwPpXZQIzI0o7sCVUmd2DK1lz4
 q5E5wkSTEmeTz8GR7IDXTwpbx1ydvhTDVAW6FVoYjd0J3QLcZ/epYuGPEDHIhw2n
 c9Hk1A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgem8e9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:22:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso4494628a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786116173; x=1786720973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FmAyBZka4bURto3eJrRm/NoI/RI5qnZItamazTRfnzA=;
 b=UGdSK8h7pPHaIYKbsmOCY4ZKKm7nGaBJfVU0qqQLp1HCIGy52SJP4rmG4wti/HbY1A
 sNiKNTh5BraW6Vg5APcP4LUxo++OlS+yQObzk0ZAQaKts2TsVIXu6ZjIef7E0+EZoicK
 7zE2Hh2SD/i0RYNXeADLhwhSlOZkTfC/C4ZIM6xa0FpZpnRcSj19CAxCBVVH+wMBycXF
 mk+duu/rxW3DJ7f6nSMuQP7QRdpgeDRA8pWhJGtJCXVq+x8/z7Elbl2g+aXkmYGaLd2D
 KNE1cK50KOi3S3Oshcssagev01IR94H3/TAqV1X2E55YFf2Aa8YHmDKMkxpoc1ZLYtgA
 AXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116173; x=1786720973;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FmAyBZka4bURto3eJrRm/NoI/RI5qnZItamazTRfnzA=;
 b=V9wue0zMOtoe/y4HHX4Zeq1chVd5Yo0OYU6HN7y3iThkuHCeZW+1pP7R4CzEAAARuV
 9k/nlyhIdQ6b55f0ik5gXOU1snyjG6ik8SbvIBYTAtVeFgxogyM3oDL9gHJFp7XzhfdI
 dDH7L8dqLTRVcDIcXfitzbWbd3EXRSQze8D2wRi8cXU9W/9eVITwUMX5F6cv7TLhelAM
 HMkPyi3cxJAmUv2c7q+V2+PyX9f8c03iPcuKzxsxUneDwZdTx7jn9Tqn00qW+spVGxML
 IXhM/b031YW89GGQb57gaR8lD/MkwSrXxijYnQKvxF48JA+dE8rHuQ1A7C6Aoi5UEyLl
 EGVg==
X-Gm-Message-State: AOJu0YzVt/5Nyim6v9XrN4dvFxuQxuoQWKLh/Rz8gZIH/HQcAEYLt1so
 0JfG74aHvt00sm9l/6x/0r2z0zhay0bI+03P7Do++DgElQvIZRKO8orY8oVeu3nLOnZYeZwK9IA
 zjCBrI3IzGNRSVmqFcY4YgR6rvtP4NyJPUJCYoEOJUnmBTXCFJ6a4jxwTekaHBrGUyg==
X-Gm-Gg: AR+sD12orQQoLsEUKrNh1RWQtQ/pLk5OHjC5MPvtHck7L0SIpV89E/RO6leqS9cpnzA
 m1ivkp9hVjq4lm2tyJPw0yntQXpHiHTGWmiOFNWxo3/pdZ8I56lpXoa8F5pYrzwoswCRNB6V8zQ
 35OcgqkrpTEeBpaCBm1Z8x7KddtAt+W/LoKR944ka30w0311fRYhYUprrIr1LS0RfnkthkDVHaI
 EW6Ri5aeCHo2Pq8s+9xHlaPJFkI3gqIUwVt0LbvFB6Z5qS/s4BK0FiltQaGMqRUSzcb3C6dfiib
 5uR+CakGsy2hEs72wHmoslZokkwcNzZ6H97y9dfQ2/CDmdcrRPfDnqKO21jUuifQor7gNSERtQW
 7x5mVJEMtv2eTwXKpLX9+HZ5WzlrI3eQ2vFn8Yu13KOBArfH/
X-Received: by 2002:a05:6a20:e212:b0:3c3:875d:c538 with SMTP id
 adf61e73a8af0-3cbce6cb229mr1261299637.8.1786116172677; 
 Fri, 07 Aug 2026 08:22:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:e212:b0:3c3:875d:c538 with SMTP id
 adf61e73a8af0-3cbce6cb229mr1261241637.8.1786116172080; 
 Fri, 07 Aug 2026 08:22:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb883d9sm8604756eec.15.2026.08.07.08.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:22:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 7/7] tests/tcg/hexagon: add HVX tests for vabsdiff
Date: Fri,  7 Aug 2026 08:22:41 -0700
Message-Id: <20260807152241.1576334-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
References: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 4SUbH6vRUzchcYLSn39K0bJuMlhFuy6-
X-Proofpoint-GUID: 4SUbH6vRUzchcYLSn39K0bJuMlhFuy6-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX6fZeLAgtObxR
 ldIoJqkQ+lAzkcGRJsCSWshlmK/dP8GtPZvzxUOb/XK183a1qPapQVwNXkh97M+AzZLtytWCWMM
 YHnYHOIuZAo9CfQ5DlF01HkAb2V9Drc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfXzbS6MOFo/hxQ
 ASV90sVJoQ2/ePi/zThCF1yviwTxukWIvdQ2ysiiil3/CtVvvLu5Uj5fnjc9ir+e46QKzS+NLxV
 pNfMllKM1heM3oVlWazhRqsTKPESDg+pikI8Sv2zz+qQCrC/wykZYNBGKGSnnPVeokl6PHHxLNP
 GAxjySOi6E25zB0K2J44P9mdVvBpo8gQDmsL2fYa+kEM9fWTce0oCcuGpbrMAhcnzh1rmxzFNwK
 HfteNmGl8cPb8qX++YKf1zNRpA3g9BdVcnKrsJ0Zn4o88XAvSy+v89nHUsxiBxBGDoAzR52h8NN
 ggclHxnpLhsX/yoRUcOdwBlC3XyDQn89acX2NgAxKoBW24Im8F1yt/nZavsqO8YSWkAjFXbtvDq
 1gE2SDNGAbrqAYaoqI7fLaGmz0uZOqqB7yyStDf62UFCUcFIAH20VX/kJ5LsIuctcGCO9XT43La
 Mn9ZIzvziGIVc9tMppQ==
X-Authority-Analysis: v=2.4 cv=X9Ni7mTe c=1 sm=1 tr=0 ts=6a75f84d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BpNi1cdwbXwK4F8ztrgA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070119
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

Q292ZXIgdGhlIGZvdXIgdmFic2RpZmYgdmFyaWFudHMuCgpUaGUgZXhwZWN0ZWQgdmFsdWUgaXMg
Y29tcHV0ZWQgaW4gaW50NjRfdCB0byBhdm9pZCBvdmVyZmxvd2luZyB0aGUKc291cmNlIGVsZW1l
bnQgdHlwZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIHwgMzMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgYi90ZXN0cy90Y2cv
aGV4YWdvbi9odnhfbWlzYy5jCmluZGV4IDY0MWNmZjU5YWJhLi4zMmEzNjYxYTg2ZiAxMDA2NDQK
LS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYworKysgYi90ZXN0cy90Y2cvaGV4YWdv
bi9odnhfbWlzYy5jCkBAIC0zMTcsNiArMzE3LDM0IEBAIFRFU1RfVkVDX09QMih2YW5kLCB2YW5k
LCAsIGQsIDgsICYpCiBURVNUX1ZFQ19PUDIodm9yLCB2b3IsICwgZCwgOCwgfCkKIFRFU1RfVkVD
X09QMSh2bm90LCB2bm90LCAsIGQsIDgsIH4pCiAKKyNkZWZpbmUgVEVTVF9WRUNfQUJTRElGRihO
QU1FLCBJTlRSSU5TSUMsIFNSQ19GSUVMRCwgRFNUX0ZJRUxELCBcCisgICAgICAgICAgICAgICAg
ICAgICAgICAgQ0hFQ0tfRklFTEQsIEZJRUxEU1opIFwKK3N0YXRpYyBpbmxpbmUgdm9pZCB0ZXN0
XyMjTkFNRSh2b2lkKSBcCit7IFwKKyAgICBIVlhfVmVjdG9yIHYwOyBcCisgICAgSFZYX1ZlY3Rv
ciB2MTsgXAorICAgIEhWWF9WZWN0b3IgdnJlczsgXAorICAgIGZvciAoaW50IGkgPSAwOyBpIDwg
QlVGU0laRTsgaSsrKSB7IFwKKyAgICAgICAgbWVtY3B5KCZ2MCwgJmJ1ZmZlcjBbaV0sIHNpemVv
ZihNTVZlY3RvcikpOyBcCisgICAgICAgIG1lbWNweSgmdjEsICZidWZmZXIxW2ldLCBzaXplb2Yo
TU1WZWN0b3IpKTsgXAorICAgICAgICB2cmVzID0gSU5UUklOU0lDKHYwLCB2MSk7IFwKKyAgICAg
ICAgbWVtY3B5KCZvdXRwdXRbaV0sICZ2cmVzLCBzaXplb2YoTU1WZWN0b3IpKTsgXAorICAgIH0g
XAorICAgIGZvciAoaW50IGkgPSAwOyBpIDwgQlVGU0laRTsgaSsrKSB7IFwKKyAgICAgICAgZm9y
IChpbnQgaiA9IDA7IGogPCBNQVhfVkVDX1NJWkVfQllURVMgLyBGSUVMRFNaOyBqKyspIHsgXAor
ICAgICAgICAgICAgaW50NjRfdCBkaWZmID0gKGludDY0X3QpYnVmZmVyMFtpXS5TUkNfRklFTERb
al0gLSBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAoaW50NjRfdClidWZmZXIxW2ldLlNS
Q19GSUVMRFtqXTsgXAorICAgICAgICAgICAgZXhwZWN0W2ldLkRTVF9GSUVMRFtqXSA9IGRpZmYg
PCAwID8gLWRpZmYgOiBkaWZmOyBcCisgICAgICAgIH0gXAorICAgIH0gXAorICAgIGNoZWNrX291
dHB1dF8jI0NIRUNLX0ZJRUxEKF9fTElORV9fLCBCVUZTSVpFKTsgXAorfQorCitURVNUX1ZFQ19B
QlNESUZGKHZhYnNkaWZmdWIsIFE2X1Z1Yl92YWJzZGlmZl9WdWJWdWIsIHViLCB1YiwgYiwgMSkK
K1RFU1RfVkVDX0FCU0RJRkYodmFic2RpZmZ1aCwgUTZfVnVoX3ZhYnNkaWZmX1Z1aFZ1aCwgdWgs
IHVoLCBoLCAyKQorVEVTVF9WRUNfQUJTRElGRih2YWJzZGlmZmgsICBRNl9WdWhfdmFic2RpZmZf
VmhWaCwgICBoLCAgdWgsIGgsIDIpCitURVNUX1ZFQ19BQlNESUZGKHZhYnNkaWZmdywgIFE2X1Z1
d192YWJzZGlmZl9Wd1Z3LCAgIHcsICB1dywgdywgNCkKKwogVEVTVF9QUkVEX09QMihwcmVkX29y
LCBvciwgfCwgIiIpCiBURVNUX1BSRURfT1AyKHByZWRfb3Jfbiwgb3IsIHwsICIhIikKIFRFU1Rf
UFJFRF9PUDIocHJlZF9hbmQsIGFuZCwgJiwgIiIpCkBAIC01NzUsNiArNjAzLDExIEBAIGludCBt
YWluKCkKICAgICB0ZXN0X3ZzdWJ1d3NhdF9kdigpOwogICAgIHRlc3RfdnN1YndzYXQoKTsKIAor
ICAgIHRlc3RfdmFic2RpZmZ1YigpOworICAgIHRlc3RfdmFic2RpZmZ1aCgpOworICAgIHRlc3Rf
dmFic2RpZmZoKCk7CisgICAgdGVzdF92YWJzZGlmZncoKTsKKwogICAgIHRlc3RfbG9hZF90bXBf
cHJlZGljYXRlZCgpOwogICAgIHRlc3RfbG9hZF9jdXJfcHJlZGljYXRlZCgpOwogCi0tIAoyLjM0
LjEKCg==

