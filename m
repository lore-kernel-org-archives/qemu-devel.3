Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A19606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KxQk+0UV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BwrW/9rN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoq4-0007dg-J1; Sat, 24 Oct 2026 23:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoq2-0007d5-Ky
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoq0-0001S0-BK
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16I3O3075161
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pa0ToFoGOt/Sykqkcf/WiQRAjKQRHjFdC3ueMJvHqQs=; b=KxQk+0UV9rPjvCWz
 wb3CgIubcB2Oj2tpU+IyyVC1S7lE3cF2Wom6A9CBDU7Nel4QK4lbn3uPXbK77sBe
 vmnNZ+WbSvQqYCAhcVRw2wLw0JxVCxpXBFAxTbhHrIDDkc5Zy2C1kk9l/SqPUqo0
 RAoXKHphGCAlUPvS7oY9JXB6Nw0IOfXlnbymoJJFfL/DL1KuaYpOFYzw7CvAwiul
 aO3sHdNdvroHQGCHcs8ACHgrf5tVzwBOakgz5nqfNaaM0fF2bUHtU9XqSa0q4g43
 DFCU0oZuAqg2IvWtWEKNv9ATjSOg3fMrUYYqQx2S3jG5eB9dsYpFfFbbarmqVO/x
 ajEnnQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrujahu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:23:59 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-151ba226e1bso3903492c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898638; x=1793503438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pa0ToFoGOt/Sykqkcf/WiQRAjKQRHjFdC3ueMJvHqQs=;
 b=BwrW/9rNjD16hdTc81Ep9d4OcAG5qWXfjLqEzqMOpc6oQS+C245hvUtS9vSKvTPInI
 uTEmKmoI6bTYqaCi7xTpnivNQbSDXuvFSUpXqeSvtVfGcnzcEVHDaGpTwPEYiw+j1qcF
 Ca0nDMj+DbklXhYpo1UcxBRvQ9wQTS4Y7Gqe2PtjDCPtREgElo9yzCmnFddXBC5C44Ed
 CasFmVD6qiRsP3jmwwAFzJptLvQF0MtwxIRki/BStMKhjcqSvhlWXQpDLt6AmsL/HcGT
 uZOn5Zs/m5XNyxFWqv38eiwscdch6JcSW+LJlrS+2rGLXZefbHo7OaaNdUI4wjkitOJt
 Jptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898638; x=1793503438;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pa0ToFoGOt/Sykqkcf/WiQRAjKQRHjFdC3ueMJvHqQs=;
 b=LLxXp6Q4zttW2fUDHF1SbAKIAmp7s5U3MoTXyKUPTlkzB9tcd0rbBIbTfblqJ3o1or
 zHFUm567EYY23w1RHIeBJieE4DyEX6xvPc+UXjAWGS3Xm1pEueP2A0UrT6anHugDi0zR
 2dgylJexSImrqIn+voTvC2iSlXIgQAhGF/zARslZYCDSqAD7u6E/OV+T95Y45x30KwNE
 EtBjP/osO43F7DTP1+yrmuaSekJParrppDi2eFHNRozyBBDTjVRhBIAnN1QioKIInaz6
 KNA5y++Z5dBTt9q1JxJ9H+0s12eQr7/SRzEJtsmbOQhxPM2691qSmme3u1oFo3Oltb2c
 Qf5Q==
X-Gm-Message-State: AFq9FYKJPxO+T0knfzb4h7PP3QSeQksNt91Lu6Jm+dTDDE9TxJfc5ed1
 3g0vIJ8EnPa2k1xUXYlAr1q8G43aGCy97OUxdKM2HvO8F/BHAJ2giq6MQZ9+BvxUIYUSbMqpDtE
 pVrQYb/XYjvyDXBgN3NqP3uPp03t38wS0m67MayoMu3Od9oW/TUqClSdGPMJw4h/eSg==
X-Gm-Gg: AYBFou2YdRM3Djq7hnBZFsrBoQo9HU+kJVcsY+240WYbLY3azTddl8vyNKwfxmzhIFY
 kI3LtWCVTCABrF9wjVon9V1s+AQqOCe4GPQ6vnGxqQ/gth4PyvPmmdUTrBYW0WZUCoMU5VpozoD
 8YBf2e/hAxE21CWYByrVVolqtgKGS5VQxMpin6XOruDJuPiyAya0H8jlVybvIpFC+6ZzBXCCPZd
 NpBGii0YODyNE2Ud7+8/X6bdjHffYsGwXLI2F9g5Mk+Ksl4wrokyW3SXeUvMnFyNcM/sZR48Z/+
 eIpXmuLlia9i2M7WJ3Eu2sVpxoDcU8oVLOMqYaOXcUv8Oyfl3gYKFlawK06MW/QUpSLjLPS30rm
 DedJvaYhiy6t9DtAzGM2Sn++1SBn5NM6JjJN+LRDfu/nHqvg=
X-Received: by 2002:a05:7022:321:b0:144:e246:a0b2 with SMTP id
 a92af1059eb24-1993f3ee454mr6790370c88.44.1792898638345; 
 Sat, 24 Oct 2026 20:23:58 -0700 (PDT)
X-Received: by 2002:a05:7022:321:b0:144:e246:a0b2 with SMTP id
 a92af1059eb24-1993f3ee454mr6790324c88.44.1792898637776; 
 Sat, 24 Oct 2026 20:23:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:23:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 03/40] target/hexagon: implement SSR.SS single-step
Date: Sat, 24 Oct 2026 20:23:09 -0700
Message-Id: <20261025032346.2917451-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfXzNXXymTogRmv
 pgterDKiX9I21wJTwS5x65ekj3IZMlYeVLQvT+Uewi0iJfxUS4Qn0lP4k83VvxAJc/9x4/5uAd5
 401O73lyHmfTR57eT+WjCPRpShIUdpcqbHXKLJwyUVAOvz6dvtuH1Vv9vQRKuTBhGr6oIWiIKD0
 xcY9MO1YnisALfp+3UXIG0gEXlv/D4o2lf28B8BCmmSOWFDHS0Ct4OZIlR79nawTD//Tlr7voyB
 2h4KD83w+HiWxiBKr0OGJ0Fb8XFogsH1KSJRoXOBEequE6N+07A6wPnMfGG6skJ0zugxXWshErh
 MbRUVDX6afzP9U58PF/gA0gD4WJ1HXJK0RRzUR8ikoFJed+0P9sFKq4C7oulmxM/mpuxcrfbcqL
 GZaIggvA83XBnYZqXCtZnVvRrmv3U8NVvT3PNKqaBwrp9Mg20vwR9O9bYVnwxY66drWnfQnJtGA
 jko1blcyLHjX0lGpz0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX1hHVQnZ0z+/4
 ftTluIDZQTY+2LZZsaZgL24VcYlDJ8jOHR5/DNMdXmeNMb+5U8L7g5KcWUT5xWrPQcE/nfAkb//
 usI6rqAuwNpZcVB6GtGwpMWI8LpPs54=
X-Proofpoint-ORIG-GUID: NhTF9j3q2vxOAND2obwXz08fkw2saH9-
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6add764f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-bET1PmNKTMLzfqnlL4A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: NhTF9j3q2vxOAND2obwXz08fkw2saH9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U1NSLlNTIGVuYWJsZXMgYSBzaW5nbGUtc3RlcCBkZWJ1ZyBldmVudCBhZnRlciBlYWNoIHBhY2tl
dCBleGVjdXRlZCBpbgp1c2VyIG9yIGd1ZXN0IG1vZGUuCgpDYXJyeSB0aGUgc3RhdGUgaW4gYSBu
ZXcgU1NfQUNUSVZFIFRCIGZsYWcuICBXaGVuIGl0IGlzIHNldCwgdHJhbnNsYXRlCm9uZSBwYWNr
ZXQgcGVyIFRCIGFuZCByYWlzZSBIRVhfRVZFTlRfREVCVUcgdy9QQyBhdCB0aGUgbmV4dCBwYWNr
ZXQgKHdoaWNoCmJlY29tZXMgRUxSKS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUu
aCAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5o
ICAgICAgICAgICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAg
ICAgICAgICAgfCAgNCArKwogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAg
ICAgfCAgMSAtCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICB8IDUw
ICsrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9z
eXN0ZXN0cy5weSB8ICAzICsrCiA2IGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5oCmluZGV4IGMxYTk0NDkyMGU4Li4xNWFlNWQxZDAwOSAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTIyNyw2
ICsyMjcsNyBAQCBGSUVMRChUQl9GTEFHUywgSVNfVElHSFRfTE9PUCwgMCwgMSkKIEZJRUxEKFRC
X0ZMQUdTLCBNTVVfSU5ERVgsIDEsIDMpCiBGSUVMRChUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFC
TEVELCA1LCAxKQogRklFTEQoVEJfRkxBR1MsIENQVV9NT0RFLCA2LCAyKQorRklFTEQoVEJfRkxB
R1MsIFNTX0FDVElWRSwgOCwgMSkKIAogR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhj
ZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRl
eCBkYzBjNmIxOGJmMS4uOThhNWIzOWRkNzYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC00Niw2ICs0Niw3
IEBAIHR5cGVkZWYgc3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgYm9vbCBpbXBsaWNpdF91c3Jf
d3JpdGU7CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKICAgICB1aW50MzJfdCBjcHVfbW9kZTsK
KyAgICBib29sIHNzX2FjdGl2ZTsKICAgICBpbnQgZ3JlZ19sb2dbR1JFR19XUklURVNfTUFYXTsK
ICAgICBpbnQgZ3JlZ19sb2dfaWR4OwogICAgIERFQ0xBUkVfQklUTUFQKGdyZWdzX3dyaXR0ZW4s
IE5VTV9HUkVHUyk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IGViZDc3ZTBmN2RkLi5mMzgzZmZkODhlNiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTM4OCw2
ICszODgsMTAgQEAgc3RhdGljIFRDR1RCQ1BVU3RhdGUgaGV4YWdvbl9nZXRfdGJfY3B1X3N0YXRl
KENQVVN0YXRlICpjcykKICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdFVF9TU1JfRklFTEQo
U1NSX1hFLCBlbnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdKSk7CiAgICAgaGV4X2ZsYWdzID0gRklF
TERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBDUFVfTU9ERSwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGdldF9jcHVfbW9kZShlbnYpKTsKKyAgICAvKiBTaW5nbGUtc3RlcCBhcHBsaWVz
IG9ubHkgdG8gdXNlciBhbmQgZ3Vlc3QgbW9kZSBwYWNrZXRzICovCisgICAgaGV4X2ZsYWdzID0g
RklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBTU19BQ1RJVkUsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxEKFNTUl9TUywgZW52LT50X3NyZWdbSEVYX1NSRUdf
U1NSXSkgJiYKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGdldF9jcHVfbW9kZShlbnYpICE9
IEhFWF9DUFVfTU9ERV9NT05JVE9SKTsKICNlbHNlCiAgICAgaGV4X2ZsYWdzID0gRklFTERfRFAz
MihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBNTVVfSU5ERVgsIE1NVV9VU0VSX0lEWCk7CiAjZW5kaWYK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4
c3dpLmMKaW5kZXggMTk0Mzk2NTgzOTIuLjkyNTA2YzI2ODE3IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwpAQCAtODQ2LDcg
Kzg0Niw2IEBAIHZvaWQgaGV4YWdvbl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcykKICAg
ICBjYXNlIEhFWF9FVkVOVF9ERUJVRzoKICAgICAgICAgaGV4YWdvbl9zc3Jfc2V0X2NhdXNlKGVu
diwgZW52LT5jYXVzZV9jb2RlKTsKICAgICAgICAgc2V0X2FkZHJlc3NlcyhlbnYsIDAsIGNzLT5l
eGNlcHRpb25faW5kZXgpOwotICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgInNpbmds
ZS1zdGVwIGV4Y2VwdGlvbiBpcyBub3QgaGFuZGxlZFxuIik7CiAgICAgICAgIGJyZWFrOwogCiAg
ICAgY2FzZSBIRVhfRVZFTlRfUFJFQ0lTRToKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggMmMxOGY1ZWViZmYu
LjgxNzFhZmI5N2Q0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMTc1LDEwICsxNzUsNDggQEAgc3RhdGlj
IHZvaWQgZ2VuX2dvdG9fdGIoRGlzYXNDb250ZXh0ICpjdHgsIHVuc2lnbmVkIHRiX3Nsb3RfaWR4
LAogICAgIH0KIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisvKgorICogUmFpc2UgdGhl
IHNpbmdsZS1zdGVwIGRlYnVnIGV2ZW50IG9uY2UgdGhlIHBhY2tldCBoYXMgcmV0aXJlZC4gIFBD
CisgKiBhbHJlYWR5IGhvbGRzIHRoZSBhZGRyZXNzIG9mIHRoZSBuZXh0IHBhY2tldCwgd2hpY2gg
YmVjb21lcyBFTFIuCisgKi8KK3N0YXRpYyB2b2lkIGdlbl9zaW5nbGVzdGVwX2V4Y2VwdGlvbihE
aXNhc0NvbnRleHQgKmN0eCkKK3sKKyAgICB0Y2dfZ2VuX21vdmlfaTMyKGhleF9jYXVzZV9jb2Rl
LCBIRVhfQ0FVU0VfREVCVUdfU0lOR0xFU1RFUCk7CisgICAgZ2VuX2hlbHBlcl9oZXhhZ29uX3Jh
aXNlX2V4Y2VwdGlvbih0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdGNnX2NvbnN0YW50X2kzMihIRVhfRVZFTlRfREVCVUcpLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaGV4X2dwcltIRVhfUkVHX1BDXSk7CisgICAgY3R4LT5i
YXNlLmlzX2ptcCA9IERJU0FTX05PUkVUVVJOOworfQorCitzdGF0aWMgdm9pZCBnZW5fZW5kX3Ri
X3NpbmdsZXN0ZXAoRGlzYXNDb250ZXh0ICpjdHgpCit7CisgICAgVENHdiBwYyA9IGhleF9ncHJb
SEVYX1JFR19QQ107CisKKyAgICBpZiAoY3R4LT5icmFuY2hfY29uZCA9PSBUQ0dfQ09ORF9BTFdB
WVMpIHsKKyAgICAgICAgdGNnX2dlbl9tb3ZpX3RsKHBjLCBjdHgtPmJyYW5jaF9kZXN0KTsKKyAg
ICB9IGVsc2UgaWYgKGN0eC0+YnJhbmNoX2NvbmQgIT0gVENHX0NPTkRfTkVWRVIpIHsKKyAgICAg
ICAgdGNnX2dlbl9tb3Zjb25kX3RsKGN0eC0+YnJhbmNoX2NvbmQsIHBjLCBjdHgtPmJyYW5jaF90
YWtlbiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF90bCgxKSwgdGNn
X2NvbnN0YW50X3RsKGN0eC0+bmV4dF9QQyksCisgICAgICAgICAgICAgICAgICAgICAgICAgICB0
Y2dfY29uc3RhbnRfdGwoY3R4LT5icmFuY2hfZGVzdCkpOworICAgIH0gZWxzZSBpZiAoIWN0eC0+
cGt0LnBrdF9oYXNfY29mKSB7CisgICAgICAgIHRjZ19nZW5fbW92aV90bChwYywgY3R4LT5uZXh0
X1BDKTsKKyAgICB9CisgICAgZ2VuX3NpbmdsZXN0ZXBfZXhjZXB0aW9uKGN0eCk7Cit9CisjZW5k
aWYKKwogc3RhdGljIHZvaWQgZ2VuX2VuZF90YihEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBn
ZW5fZXhlY19jb3VudGVycyhjdHgpOwogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBp
ZiAoY3R4LT5zc19hY3RpdmUpIHsKKyAgICAgICAgZ2VuX2VuZF90Yl9zaW5nbGVzdGVwKGN0eCk7
CisgICAgICAgIHJldHVybjsKKyAgICB9CisjZW5kaWYKKwogICAgIGlmIChjdHgtPmJyYW5jaF9j
b25kICE9IFRDR19DT05EX05FVkVSKSB7CiAgICAgICAgIGlmIChjdHgtPmJyYW5jaF9jb25kICE9
IFRDR19DT05EX0FMV0FZUykgewogICAgICAgICAgICAgVENHTGFiZWwgKnNraXAgPSBnZW5fbmV3
X2xhYmVsKCk7CkBAIC0xMzM2LDYgKzEzNzQsMTIgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl90cl9p
bml0X2Rpc2FzX2NvbnRleHQoRGlzYXNDb250ZXh0QmFzZSAqZGNiYXNlLAogICAgICAgICBGSUVM
RF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIEhWWF9DT1BST0NfRU5BQkxFRCk7CiAgICAgY3R4
LT5odnhfY2hlY2tfZW1pdHRlZCA9IGZhbHNlOwogICAgIGN0eC0+Y3B1X21vZGUgPSBGSUVMRF9F
WDMyKGhleF9mbGFncywgVEJfRkxBR1MsIENQVV9NT0RFKTsKKyAgICBjdHgtPnNzX2FjdGl2ZSA9
IEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgU1NfQUNUSVZFKTsKKyAgICBpZiAoY3R4
LT5zc19hY3RpdmUpIHsKKyAgICAgICAgLyogU3RlcCBvbmUgcGFja2V0LCBhbmQgbGV0IGVuZGxv
b3AwIGJyYW5jaCB3aXRoaW4gdGhlIHBhY2tldCAqLworICAgICAgICBjdHgtPmJhc2UubWF4X2lu
c25zID0gMTsKKyAgICAgICAgY3R4LT5pc190aWdodF9sb29wID0gZmFsc2U7CisgICAgfQogI2Vu
ZGlmCiB9CiAKQEAgLTE0MDMsNiArMTQ0NywxMiBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3RyX3Ri
X3N0b3AoRGlzYXNDb250ZXh0QmFzZSAqZGNiYXNlLCBDUFVTdGF0ZSAqY3B1KQogICAgIGNhc2Ug
RElTQVNfVE9PX01BTlk6CiAgICAgICAgIGdlbl9leGVjX2NvdW50ZXJzKGN0eCk7CiAgICAgICAg
IHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPmJhc2UucGNfbmV4dCk7
CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICAgICAgaWYgKGN0eC0+c3NfYWN0aXZlKSB7
CisgICAgICAgICAgICBnZW5fc2luZ2xlc3RlcF9leGNlcHRpb24oY3R4KTsKKyAgICAgICAgICAg
IGJyZWFrOworICAgICAgICB9CisjZW5kaWYKICAgICAgICAgdGNnX2dlbl9leGl0X3RiKE5VTEws
IDApOwogICAgICAgICBicmVhazsKICAgICBjYXNlIERJU0FTX05PUkVUVVJOOgpkaWZmIC0tZ2l0
IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgYi90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQppbmRleCAwNDg5ZGIwYWY5MS4uMWMxZDU0
NDBiYjYgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3Rz
LnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CkBAIC0x
MTEsNSArMTExLDggQEAgZGVmIHRlc3Rfc3RhbmRhbG9uZV92ZWMoc2VsZik6CiAgICAgZGVmIHRl
c3RfbG9ja192ZXJpZnkoc2VsZik6CiAgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygibG9ja192
ZXJpZnkiKQogCisgICAgZGVmIHRlc3Rfc2luZ2xlX3N0ZXAoc2VsZik6CisgICAgICAgIHNlbGYu
cnVuX2V4aXRfemVybygic2luZ2xlX3N0ZXAiKQorCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18i
OgogICAgIFFlbXVTeXN0ZW1UZXN0Lm1haW4oKQotLSAKMi4zNC4xCgo=

