Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF94606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l/fiFaDO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TbxmBtBf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXsn-00027z-9j; Mon, 26 Oct 2026 23:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXsg-00025v-0i
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXse-0008IB-5P
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F05Q831570
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pa0ToFoGOt/Sykqkcf/WiQRAjKQRHjFdC3ueMJvHqQs=; b=l/fiFaDOWRH/7mlo
 F+8H4cSVzI1nPi+KG8b7TeNHFr0xOmzoaSQMJ3jpKaT1DI8lfDuPzlJfU18ohlQv
 IUiSLcAScrIWPFtbLRZbm/JAPsUFTpD5fg3ZVIwFLpFLkjvAOu+8JNHDea3cGSg6
 pHoqbJ8GSozD3j0w8Ne0R4DmNu69pJsRPj52Hfx4JaavJ8AZJKWghHKJclMl/C19
 MvuZdBL2tP4tEcUW0vxOErDhnqP2+lrBnJr+jQvhH53aGQpigY7GCFE8ij3E2J7l
 +51zTbDKhWDzoH/a/LxywZPEdFGVRsJhvJep/km8VWZES7y7Cfxihv/UxcwB1T1s
 IxxA8g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavrvh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c902e0da2so598340eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071782; x=1793676582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pa0ToFoGOt/Sykqkcf/WiQRAjKQRHjFdC3ueMJvHqQs=;
 b=TbxmBtBfg0gHgQQ4nXlOMqbFPKj86RjXyS9zX0x+PH8ApSthz6SjBi4kGt3wdxep18
 y5Syjo1vhH0vfyaP+TmVaiW86LfchkNat9er5N/Q3JStVZb+rlMFfVvCm3PCKWUxvl2s
 c4jMPqIZgBwnb/kGSmiMGuiqE87Ts26V9L+2XLRWl72yn4yrFto8aOdqufYjvYncygHM
 tBxBtjfArDLWWbSrbLGZfHJB0DLTC1/1UNcEmS3NhpuLG4ladFWB6BYvLEb9Ff0R9BDZ
 fsxhbLdi/KL+gF0H4I1H2USgkXKQXrxRBGQfCPXfYHRcAX95dgqf6RLcR0SrRMVc+A7N
 eUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071782; x=1793676582;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pa0ToFoGOt/Sykqkcf/WiQRAjKQRHjFdC3ueMJvHqQs=;
 b=M71aAzSO9e+BQdxKXM/hcUXCYNRws6m7qycUFZclFk2tTdhSAyWD6cMJ3C0iAlIBHG
 yThXOey4FdikgmuZ3Ut2F2eT9dgchsP57LvELCAF6f6l78KLYJRD7uoUBrUrAsV4A4Mi
 NSqRO3mFDC/MhA/agT3ZPTidWlZegwxTEAx04mdCqpf1u7aKlut7VCehJI0hvu6lWcqf
 G4eXqeiSujYO82Fpk2Iu8H5YfcDqqlu1c4AUb3jJcyRvXvsfadxkfeKJDNAfn5DXKCNZ
 lIUpdeq64XeETxDvUyLR4uK2kngKREMAJfG45NkhxE2AaRUmysM0I1ohILpU9S9EqzSb
 ygdA==
X-Gm-Message-State: AFq9FYLzwf2ZcCLaF9FGgDNlqgaitpt23tV9u5wn1ysxCkq0/x6SJ7C3
 oYqSk6XgSHqw8StxU+6B4vQ+ZNEzs3bFumXImHmFnf4YCaDPhhgHxZ/UsxQtnmsGYBanCNE62Bl
 QwKLz2fGKTjndTCohjNt+JkvsD3N4FzwoLCMmlFnwNDskFmHGoLMnQ8S8SKIHTQzL8g==
X-Gm-Gg: AYBFou30MQhpcio0k8aK+554ThOQqTg12u7g1SS6ldLnXQ94ApD+MunTTvDsInJBQfh
 Ci7HE9Ctny7JDnP+nlt/YctsCYNcRNoMitqroutCymv5+gK15RqC/V2J5V1f/d4GweF2uSMeCuM
 D1IdqezJ4S9qDnV6LonWg0hs5udD5/AI9OxUEuwtuLNs6rx95vxBTXuRpj29qXxVxLt66dzGrHa
 GMne09s9Y32wiKgcL+f+VmaR0OEoBJVS0FmzZ5erDCCVlC6yQx47UtgVn4gsdqNrvKVLDRMFqUE
 3cP39Rv/j11bR+3JH1BQvw1OzwqdByDPP1v/H2M4dUPDD+S3waRbredqhhNqaGz3E3Kc1jZFi+T
 ywQp2oWI73hZ2Di3EmCun3MigL3XsUrEGplqW+AbWf1TQAYY=
X-Received: by 2002:a05:7022:2609:b0:159:d448:dd1c with SMTP id
 a92af1059eb24-1a3c904ca8dmr2430368c88.19.1793071782083; 
 Mon, 26 Oct 2026 20:29:42 -0700 (PDT)
X-Received: by 2002:a05:7022:2609:b0:159:d448:dd1c with SMTP id
 a92af1059eb24-1a3c904ca8dmr2430327c88.19.1793071781474; 
 Mon, 26 Oct 2026 20:29:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:29:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 03/41] target/hexagon: implement SSR.SS single-step
Date: Mon, 26 Oct 2026 20:28:49 -0700
Message-Id: <20261027032927.3055166-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: oakMCF3o9T512Nu7VWq7sttayIhP52D6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXx8k6QHmvrA6Q
 z+mtT1jOruZUJouk/SI2ZrLvOxsachvsV2lusLE/+kPMinjMGt/MseABwUjwTp3aERepwxtGbhq
 f9mllf+YoUWsMNq1ywtLVBNpzKKtpTE=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae01aa7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-bET1PmNKTMLzfqnlL4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: oakMCF3o9T512Nu7VWq7sttayIhP52D6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX9//NX4u4V5HK
 bWPXfdS/hq+F37lpZDPiwlT8bnIUOqU70tPhfI1xosGbEQq1PE4a/e64YeTpv+hEFw6k1W4FMOx
 k/CbZ1cCzH0UUK1a53NDUgfJcUxguBS23CHy0gbUoSlnxqDzGtj2UPOoZQblcZZ3RL/ZSqKH8uI
 APeHU8m8DbqpvZW/7FJA7x/8d60d9wnVTlyXS3cyrOtJlTBF0bYu4wLHRzcwuxjdfy54tFdDOhd
 //kr7FxKAhL7eAvhjQAGjXXnn88rYnqz8q009gy4JFgKhApXqFucBBWjfmHp4xNHo1HW0JmYUTL
 rywGJIURhuouzzsVy1Mz2y8Mn/ruWYEWyWH1WnBTOOVpwgYmouT7gV3zZBVfsYsA1DccEyu/qtU
 Fqeb7prQo/0TT1KkoVEnb4n0JV8m0XOikQwsa2gUeE5YQKe2qD5u637hDFGG7MXEr6iztRQceao
 XZ+sSrCMItkxrgfamSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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

