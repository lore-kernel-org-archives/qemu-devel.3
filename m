Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5F606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gx6dKgys;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F6gC2f9Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWeMZ-0006an-4z; Thu, 26 Nov 2026 13:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWeMQ-0006Xr-NK
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:38:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWeMO-0008Ny-Oj
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:38:22 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQGbwWV595610
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 18:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZuuKX3a7uGMSVMwRaCSuQ9SrUwzZg9q5wsIpTvhiL6E=; b=gx6dKgyse8OLx2Ay
 +OwNcFBt71gf6P3KbnQkNKiDmW8L3gJiZo5HwMR5mfE/X9G8jvh0EF2wDZ0R4OD3
 N992PbBtFjkw0Fsa3PEIkYURjn/jT10EwfQ1oiUoA5KgcjmjHhILJxq5ILb+BsaJ
 ui5MtprOfzSM6UI/KsAMMYD+i5Sg93hRGVexF9FZ2RQ/O6HLji++bi8T34n0Fb19
 fbBbMPF/5Ggzx5quuA+5xmD+oRRz0ugnWdNdHFTv5vfr+3RqhQN9eOeTy5c6ef+5
 PRKLHmQFv5gzr8fn1hsDtmaouyIQgXrUfJVHeZqgOH1lxxgaKvv535zoKKE4o77G
 koPSaQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf90c08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 18:38:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-383ec96a7deso7720809eec.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795718298; x=1796323098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZuuKX3a7uGMSVMwRaCSuQ9SrUwzZg9q5wsIpTvhiL6E=;
 b=F6gC2f9YZ2NLyWDhuJIMmpq3Ci3jjagTdSQKsGZjr2r1rMIpXsn5F26b4yg5Wci0RU
 QdkqwP2YP+ccswBXj44zFGumUOlQ3Cjo0czbRwBJyFPYlmzsQWK6peCcro+XImgp894h
 7Jgql68cj96CVwBaY3xZLmZTJ5K3E+VhddYzHxlF7TURSTCzt6mfkdZNAZbWrVZcYpho
 Ld881d3GseYmR+3En66CzExG/fZfNTs1Kv0F/GKFumOeznQ5SFdZdbXWuZxKx39R9AWB
 94Jj5bbSyzAspwZSfDSUNBECq7MBpOUPwmvFEi1scbWRbKBsxm0UHzYFvI02okK238+y
 qUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795718298; x=1796323098;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZuuKX3a7uGMSVMwRaCSuQ9SrUwzZg9q5wsIpTvhiL6E=;
 b=Nifz7M3sE3P0cEjgPHjq1BiZws4L3X5SaRF3LSaOxkwIc6MK+KgE5H8a0Gn678ZymA
 HdBkgCuYliguQK6nUPWwB8haRaEaIuKmZHL7KCtLRbJNg0BUjLMDmYaGnph1SOS6NCAA
 9Mk94gXiPbaoOg0alRXk/xhKhHec7eAOJuE/LTDHtwdfAdWNqYgvhhipad2g7Nem4tEh
 VACl39N7JImofJ8dxUuu7lGWAMmoN6BFu79YgcbndU73/nKxuY3JIqvXBXyNUnG3CgxS
 i95wc6AIh9nhF0OLd3DF5vQIGOh/uJq9eZN4k8XcpxxrpGWkCa9HoO5Buy3vxhpd637M
 kszQ==
X-Gm-Message-State: APuU4Z/5ebFR+xXPO/oPPuZm4obb37ZXKND65Ohm2+5m0UnBGNIIynzn
 mBbaZpo7TC2SytJPJTt7jBRoVCpE0x70SnLSmj9KgpJovadYnuWSdQRtvdVjJOyxHzPdnBYE0JM
 Ix0C6cpM2/zpluqwv+LmJ5eZD+jq73gNfvmM4TRHFemYB3ZbmNgbTO69sZxTgMwo8yw==
X-Gm-Gg: AZFdTZc8fzKZDQw6+OqGcaX0jocnR2PrXEXkMQ0mjWWFTK6wm/WRkQBfYgkVrK037Fk
 98PJ6YihPMJl8VNSF/ZcrQFvDhtT6BlJ8+JvFlzpD3y1/UwHZO8suO0JmdDVPaAvR29nZHXHEfI
 z0Syub6AYm639du77r4iH4lH8ablHdb6iq1G7XdbkBdRLOJmzpwQvl7wI4UvfSp4MKiNn6OjCoE
 3RFs/qUKPgb418tDbmhvykzQT3EH7Hh/5o9kSeSAliV2oeTE4MdczQVm8v5UcY42D+9XaJvExvC
 ytV2+Uo7bdL3Zn1b9tYALolckGjC4KnJZv1KY47+ZnM1T3eQs4zINdsd9hYr+myUOO+YGiw4oAD
 eYK9vK8vsTDAYFHSVECquQmcoslj/OIqW6VDXYEOT3cE+sgFLnbAQwSF9kbqmCGBDbj4CqiwGAY
 VAdPrUPf/Bqv8/rtCtJ80TeA==
X-Received: by 2002:a05:7301:2e30:b0:376:19bd:2af9 with SMTP id
 5a478bee46e88-3856c2c4a0dmr24520060eec.5.1795718298272; 
 Thu, 26 Nov 2026 10:38:18 -0800 (PST)
X-Received: by 2002:a05:7301:2e30:b0:376:19bd:2af9 with SMTP id
 5a478bee46e88-3856c2c4a0dmr24520040eec.5.1795718297722; 
 Thu, 26 Nov 2026 10:38:17 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm78687512eec.4.2026.11.26.10.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 10:38:17 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH for-12.0 3/3] docs/system/hexagon: document PMU and limitations
Date: Thu, 26 Nov 2026 10:38:12 -0800
Message-Id: <20261126183812.1366883-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126183812.1366883-1-brian.cain@oss.qualcomm.com>
References: <20261126183812.1366883-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: DLBqz8pCNB3MG7yUnx35DYsh9JxVX5ms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3MyBTYWx0ZWRfX2g6oTBKl3hAT
 CKtVAGjSdQIQW+UwWiSL2nHUpSBX+6I89hEyyas9j63+y/CaDsRXrjH32H4jbHa9Uawcu2cMHP9
 ZNaMI4BLTZ1/LimM3YcM2kiy4Cl6cd2T1QEW4ovKtRgkK5vPqP7IUymUCTPTeHeJVX2A0ffxybl
 NBvc5GNcDLqep5BCqLhk/f8drH5OZ4E9wde63wlHQP4bCFTK6T6pm6HlgbxXrZd2ZdUntB4AgAR
 mxcw3OiezIq5IiUBer6nKDEM5TaWDrNyvwaO2RLWMskix5skoLZ1b2WOHD3sDK3XRDl/Luz+fV4
 PpY9QFcjDQBKzsPWC8wmFetgKnr57+WynHmKrFIBKNINvnqZUY6r9FbSSJlFdJoSuU2ZqCMxhtZ
 x/4ST3uzBmuyQ8b229zEXIScbnb33blpI3vQlBiDWZREMW+Wi4pgEyXL14hkF5SB3IkLf4BXQPc
 0VtzB6oxCEyTwP8D6Ag==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b087c9b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=J0RjullpXTW1Yh16hb0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3MyBTYWx0ZWRfX05uODg36o1yc
 sUQ/X3rCA7Oa25bvCkoi8CgQNUdT9SAzpK2b6OzOjg8324D7UE1uXrjCJU3EC/Ht1oKuF56UtP9
 BA2s6d1I9WhSxO9NsgQnKsbEVYR4rPs=
X-Proofpoint-GUID: DLBqz8pCNB3MG7yUnx35DYsh9JxVX5ms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260073
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

RGVzY3JpYmUgdGhlIFBNVSByZWdpc3RlcnMsIHdoaWNoIGtpbmRzIG9mIGV2ZW50cyBhcmUgY291
bnRlZCwgYW5kIHRoZQptYWluIGxpbWl0YXRpb25zIG9mIGNvdW50aW5nIGZyb20gYSBmdW5jdGlv
bmFsIGVtdWxhdG9yLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCB8IDM0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0
IGIvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CmluZGV4IDQxYTlhODQ2N2Y5Li5i
MjY0OWUxNjY3OCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0
CisrKyBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApAQCAtMzMsMyArMzMsMzcg
QEAgSFZYIHVzZXMgMTI4LWJ5dGUgdmVjdG9yczsgNjQtYnl0ZSBtb2RlIGlzIG5vdCBpbXBsZW1l
bnRlZC4KIFNlZSA6ZG9jOmAuLi8uLi9kZXZlbC9oZXhhZ29uLXN5c2AgYW5kCiA6ZG9jOmAuLi8u
Li9kZXZlbC9oZXhhZ29uLWwydmljYCBmb3Igc3lzdGVtLXJlZ2lzdGVyLCBUTEIsIGFuZCBpbnRl
cnJ1cHQKIGRldGFpbHMgcmVsZXZhbnQgdG8gT1MgYW5kIGZpcm13YXJlIGF1dGhvcnMuCisKK1Bl
cmZvcm1hbmNlIE1vbml0b3JpbmcgVW5pdCAoUE1VKQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQorCitFdmVyeSBIZXhhZ29uIHN5c3RlbSBtYWNoaW5lIGhhcyBhIFBNVSB3aXRo
IDEyIGV2ZW50IGNvdW50ZXJzIChgYFBNVUNOVDBgYAordG8gYGBQTVVDTlQxMWBgKSwgc2VsZWN0
ZWQgdGhyb3VnaCBgYFBNVUVWVENGR2BgLCBgYFBNVUVWVENGRzFgYCwKK2BgUE1VRVZUQ0ZHMmBg
IGFuZCBgYFBNVUNGR2BgLiBUaGUgYGBHUE1VQ05UYGAgYW5kIGBgVVBNVUNOVGBgIGFsaWFzZXMg
YXJlCityZWFkYWJsZSB3aGVuIGBgU1NSLlBFYGAgaXMgc2V0LiBDb3VudGluZyBpcyBlbmFibGVk
IGJ5IGBgU1lTQ0ZHLlBNYGA7IHdoaWxlCitpdCBpcyBjbGVhciwgbm8gY291bnRpbmcgY29kZSBp
cyBnZW5lcmF0ZWQsIHNvIGFuIGlkbGUgUE1VIGNvc3RzIG5vdGhpbmcuCisKK09ubHkgZXZlbnRz
IHRoYXQgZm9sbG93IGZyb20gZGVjb2RpbmcgYW5kIGNvbW1pdHRpbmcgcGFja2V0cyBhcmUgY291
bnRlZDoKKworLSBjb21taXR0ZWQgcGFja2V0cywgaW4gdG90YWwgYW5kIHBlciBodyB0aHJlYWQK
Ky0gc2NhbGFyIGxvYWRzLCBzdG9yZXMgYW5kIG1lbW9wcworLSBIVlggcGFja2V0cyBhbmQgdGhl
IEhWWCBBTFUsIG11bHRpcGx5LCBzaGlmdCBhbmQgcGVybXV0ZSBpbnN0cnVjdGlvbnMKKy0gSExY
IHBhY2tldHMsIGxvYWRzLCBzdG9yZXMgYW5kIHRoZSBITFggZXhlY3V0aW9uIHNsb3RzCisKK1do
ZW4gZ3Vlc3RzIHNlbGVjdCBvdGhlciBldmVudHMgdGhlIGNvdW50ZXIgZG9lcyBub3QgYWR2YW5j
ZS4KKworTGltaXRhdGlvbnMKK15eXl5eXl5eXl5eCisKKy0gVGhlIGhhcmR3YXJlIHRocmVhZHMg
b2YgYSBtYWNoaW5lIHNoYXJlIG9uZSBiYW5rIG9mIGNvdW50ZXJzLiBFdmVudHMgdGhhdAorICBo
YXZlIG5vIHBlci10aHJlYWQgdmFyaWFudCBhcmUgc3VtbWVkIGFjcm9zcyBhbGwgdGhyZWFkcy4K
Ky0gYGBQTVVDRkdgYCB0aHJlYWQgbW9kZSBhbmQgYGBQTVVTVElEYGAgZmlsdGVyaW5nIGFyZSBz
dG9yZWQgYW5kIHJlYWQgYmFjaworICBidXQgbm90IGFjdGVkIG9uLgorCitGb3IgdGhlIGZ1bGwg
ZXZlbnQgbGlzdCBhbmQgcmVnaXN0ZXIgbGF5b3V0LCByZWZlciB0byB0aGUKK2BIZXhhZ29uIFY4
NSBQTVUgRXZlbnRzIHJlZmVyZW5jZQorPGh0dHBzOi8vZG9jcy5xdWFsY29tbS5jb20vZG9jLzgw
LU4yMDQwLTYwL3RvcGljL3BtdS1ldmVudHMuaHRtbD5gXywgdGhlCitgSGV4YWdvbiBWODUgSFZY
IFBNVSBFdmVudHMgcmVmZXJlbmNlCis8aHR0cHM6Ly9kb2NzLnF1YWxjb21tLmNvbS9kb2MvODAt
TjIwNDAtNjEvdG9waWMvaHZ4LXBtdS1ldmVudHMuaHRtbD5gXyBhbmQsCitmb3IgdGhlIEhMWCBl
dmVudHMsIHRoZSBgSExYIHJlZmVyZW5jZSBtYW51YWwKKzxodHRwczovL2RvY3MucXVhbGNvbW0u
Y29tL2RvYy84MC1OMzA0MC0yMy90b3BpYy9obHguaHRtbD5gXy4KLS0gCjIuMzQuMQoK

