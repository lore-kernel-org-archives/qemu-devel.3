Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492F606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cu9JgKTx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CIfRbkQP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Ye-0002t3-Qy; Thu, 19 Nov 2026 15:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YW-0002pK-HL
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YU-0000sy-VU
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:28 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1LnG3655793
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rP5KFfKFgBy93H239WRP7Escww7/PQa0uMZOFKHOh08=; b=Cu9JgKTxlUtNW6Ou
 mGYF3SQzdj+PUdHEhP086x6Vcjk4fHyuFKo5C+4Uhan9h5GSlsrGHG4C3Te2tewY
 lr4BcBkCxKFvlCfTWUNARIroHsaDBqC/4YP0aouf1srI+0GcZXJn7OxkGu/KbubI
 8VP4iSk2E/xHI6i5V+LXUzlGnJbVOriZhlZtW6FVtHAi9TXN2w9pRqyeTGVUmKA6
 qMdE7D//Ez5+R9mU8BFH95dlyQf+epvj3QXEahPyJ6Xc/pUSBJr9V2X71almzmx/
 HV9xuvAssYndZcGC/UuKbSHYg/5eFOK9qiyGugL8TBDiLSCHvhrYFju1YqqQYq1V
 xT/HZQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j20guajj4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-383f2d05c73so334086eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119385; x=1795724185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rP5KFfKFgBy93H239WRP7Escww7/PQa0uMZOFKHOh08=;
 b=CIfRbkQPgM95MPwqKdup8C1qrqrKMHd47qmMyeTfVYkiqCQtEFBUm938/fJSiiSb+O
 zxQj3TuwAU5E23VoZ2T8hbBxjgs+K004QNVYr/di0/2elMFCGB0cLXxV0p8Uy1g5uvyn
 USD5S/m/10+YYsAugUtffAHMOHdZhtEmbzUGyCdGZWQSnIYRtdeg0XlbOdcafWsE/Zrt
 WEcfvaBL2883rz6RPNNuTSyx81EKPbvLpABT0t5Yu12zKXwU7bd50DK/iAz2lRKIaxcn
 Wrp15buHqkCKORTOTDXScl/Mva6Wcel389EtM7/M7iK3NYxA9rrNskGvYD3tMGlu8tIy
 n6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119385; x=1795724185;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rP5KFfKFgBy93H239WRP7Escww7/PQa0uMZOFKHOh08=;
 b=ooNVE5R0hVSolSuJnWxhWeK482AZqBw+p8tgX8J99DP1CRbxtHZIDirGW7X7+4zVH6
 ENLpaNIbNVWqJQPLSU9hCD6Z9gllhiJQWcF3NkGLvudqACqRH7Jywnmco8fdrTUUiIft
 P/T0D35Rxt0Ohm3WW+g7Fa0ycHaiaivCCTXr3CEa7asuxLVU61OFlWUVqcDFMUB4CvPO
 Wo2GZCz0GAmZ8hEHCslrM6ORW57iy6Mwf03afASWIqb2eyTlhJM2k+nBBuu7v8qGOoCn
 DJEgrmNCpbYDYeSiZkFxi/P51cAixe2Vf739GqOpzZkFQtgJpAckyIjYrM4OuKO/P4XX
 XdIQ==
X-Gm-Message-State: APuU4Z+cDnyJIJf5s7u0mt7DoAjynFTBMecG4/USk4LHInwa3P0HH7Mg
 qdasMNTNwwFu3UfvRE1p+ysoYuyNa/qOISdtiZPO44vSRqktmteG41rlomMAUZtm+46l/XSSEom
 VC2+itXwlB4hmfaHB4B5/SMvMkGbkt3offBelj7tW75omPiBCeJeEvyrNXZmKg5TVdQ==
X-Gm-Gg: AZFdTZee0SRWQIqZz1788kNeGun3nVtdlxThGc8fcRWyyIxVxggIwiWmNpWiyOi/LAv
 xLATlmqr4gviwlGgehG4qJDuc8d/zNp9grpx9uwYUvJVlyCeYEqHqKE/+9kvBucgQiNtT5PV1Yk
 F6rw5naBvIVPHBNqQbsvMSl774qpp7tWfQv91Rdz9RTLZFoiyMBxy7L9ecwa13FcBtE96Aoc2Ny
 B6XAqyHsCQVuSbB2tgB5IHAOCN1HjI66AIv5BDNURxnMeAVkq7ukn6diFbDlrdscCugngg8VA5w
 SFjVvAAeL78pPdorYgqEH7XdrwsR1HKOYyefINelCogIpIV1pmhQCeoOC1FADYTXN4A/oMaIExO
 Ie/z9Y0nHksxkPB7I/ghE0fk9iXgbneLGrKATIyTsE7OlUOO2zFXPrrbvqMayT+9ygu1yvmcnaz
 c0/1hZf8wQFJ9Zwbv+0uEGqw==
X-Received: by 2002:a05:7300:8a9f:b0:36b:d3dd:2e9d with SMTP id
 5a478bee46e88-38570354704mr390774eec.19.1795119384682; 
 Thu, 19 Nov 2026 12:16:24 -0800 (PST)
X-Received: by 2002:a05:7300:8a9f:b0:36b:d3dd:2e9d with SMTP id
 5a478bee46e88-38570354704mr390736eec.19.1795119383927; 
 Thu, 19 Nov 2026 12:16:23 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:21 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 12/14] hw/hexagon: version the virt machine type
Date: Thu, 19 Nov 2026 12:16:01 -0800
Message-Id: <20261119201603.2377989-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfXzjRlrh8/AkqF
 Y2ei0Xe4Y+Wu2Ufao6EE+Dd+SIBQBpGgccAxnc/DO7Q56KXvhgkL0eRCW/3y4W3ns3K7uf+k9D+
 GebmU8LcfGiggzHgTpdgwpgmhL8y33Y=
X-Proofpoint-ORIG-GUID: CHhDSIhS3V64DqtpuSZVJplWlq5bUB9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX1NfMOQz+X739
 PaAGdxeqiD3Kc3bMLKYG/dT0DDtLVCe+I+YkfoWz/ff9BUQTk5WzHNznb84MWEAzmuvQwyPXJcc
 oVAH3DLg5/3S1QrxxBiCLBZdx+3fAamfUHA69Uryn7p+6lws4IevoMxAx9ZEAknljzpdz9APWNC
 jmYOJwiWXVitGm6QHRHDnt99TB8A+ZlynsbPJgwuFpn/6Vwe+iGBTwf/t+UL/SMFdzUT6ucBQKv
 ffWVtnnix6UKJN6jhO39G1zGXLpFHbo2ibBHSxf7QrUkjfxdat31+a+dLIUnQdKy0VXVTs0FiDg
 yk3NNfmhhV2+AXcIb7NB2MCB3MBaofuUdMcMytYD1dZaPmGYzStehfisDWBc1SRXCkovy6LgRla
 MTwn+F1VOVkRMSiMEVKlqTsRttVBNfBOyU2MkoRmCQ46fRL4eNvnVnFHRCVKJNEBz53AGcnFm+m
 k7QEUymHfgm6EBdNIJQ==
X-Proofpoint-GUID: CHhDSIhS3V64DqtpuSZVJplWlq5bUB9R
X-Authority-Analysis: v=2.4 cv=XutvqlF9 c=1 sm=1 tr=0 ts=6aff591a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=RWXkQjlZBxIzdYGjihoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190080
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

TWFrZSB0aGUgZXhpc3RpbmcgdmlydCB0eXBlIGFic3RyYWN0IGFuZCBhZGQgdmlydC0xMS4yIGFz
IGl0cyBvbmx5CmNvbmNyZXRlIHR5cGUsIGFsaWFzZWQgYXMgInZpcnQiLgoKU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lz
dGVtL2hleGFnb24vbWFjaGluZXMucnN0IHwgIDMgKysrCiBody9oZXhhZ29uL3ZpcnQuYyAgICAg
ICAgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9oZXhh
Z29uL21hY2hpbmVzLnJzdCBiL2RvY3Mvc3lzdGVtL2hleGFnb24vbWFjaGluZXMucnN0CmluZGV4
IGE0NzYwYjdhNWIxLi4zYmRmNWVhYzI2ZSAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdv
bi9tYWNoaW5lcy5yc3QKKysrIGIvZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5yc3QKQEAg
LTI5LDYgKzI5LDkgQEAgaGFyZHdhcmUgYXZhaWxhYmxlIHRvIHRoZSBndWVzdCwgaW5jbHVkaW5n
IENQVXMsIGludGVycnVwdCBjb250cm9sbGVyLAogY29uc29sZSwgdmlydGlvIGRldmljZXMsIGFu
ZCBhY2NlbGVyYXRvciBjYXBhYmlsaXRpZXMuIFNlZSA6ZG9jOmBib290YCBmb3IKIGl0cyBib290
IHByb3RvY29sLgogCitgYHZpcnRgYCBpcyBhbiBhbGlhcyBmb3IgdGhlIGxhdGVzdCB2ZXJzaW9u
ZWQgbWFjaGluZSB0eXBlLCBjdXJyZW50bHkKK2BgdmlydC0xMS4yYGAuCisKIEJvYXJkLXNwZWNp
ZmljIENEU1AgYW5kIE5TUCBtYWNoaW5lcwogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiAKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92aXJ0
LmMKaW5kZXggMzMyN2UyOGQxMjEuLjdjNzk4MjIyYmE2IDEwMDY0NAotLS0gYS9ody9oZXhhZ29u
L3ZpcnQuYworKysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtMTYxLDcgKzE2MSw0NCBAQCBzdGF0
aWMgY29uc3QgVHlwZUluZm8gdmlydF9tYWNoaW5lX3R5cGVzW10gPSB7IHsKICAgICAucGFyZW50
ID0gVFlQRV9IRVhBR09OX0NPTU1PTl9NQUNISU5FLAogICAgIC5pbnN0YW5jZV9zaXplID0gc2l6
ZW9mKEhleGFnb25WaXJ0TWFjaGluZVN0YXRlKSwKICAgICAuY2xhc3NfaW5pdCA9IHZpcnRfY2xh
c3NfaW5pdCwKKyAgICAuYWJzdHJhY3QgPSB0cnVlLAogICAgIC5pc19hdmFpbGFibGUgPSB0YXJn
ZXRfaGV4YWdvbiwKIH0gfTsKIAogREVGSU5FX1RZUEVTKHZpcnRfbWFjaGluZV90eXBlcykKKwor
I2RlZmluZSBERUZJTkVfVklSVF9NQUNISU5FX0lNUEwobGF0ZXN0LCAuLi4pIFwKKyAgICBzdGF0
aWMgdm9pZCBNQUNISU5FX1ZFUl9TWU0oY2xhc3NfaW5pdCwgdmlydCwgX19WQV9BUkdTX18pKCBc
CisgICAgICAgIE9iamVjdENsYXNzICpvYywgXAorICAgICAgICBjb25zdCB2b2lkICpkYXRhKSBc
CisgICAgeyBcCisgICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsg
XAorICAgICAgICBNQUNISU5FX1ZFUl9TWU0ob3B0aW9ucywgdmlydCwgX19WQV9BUkdTX18pKG1j
KTsgXAorICAgICAgICBtYy0+ZGVzYyA9ICJRRU1VICIgTUFDSElORV9WRVJfU1RSKF9fVkFfQVJH
U19fKSBcCisgICAgICAgICAgICAgICAgICAgIiBIZXhhZ29uIFZpcnR1YWwgTWFjaGluZSI7IFwK
KyAgICAgICAgTUFDSElORV9WRVJfREVQUkVDQVRJT04oX19WQV9BUkdTX18pOyBcCisgICAgICAg
IGlmIChsYXRlc3QpIHsgXAorICAgICAgICAgICAgbWMtPmFsaWFzID0gInZpcnQiOyBcCisgICAg
ICAgIH0gXAorICAgIH0gXAorICAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBNQUNISU5FX1ZFUl9T
WU0oaW5mbywgdmlydCwgX19WQV9BUkdTX18pID0gXAorICAgIHsgXAorICAgICAgICAubmFtZSA9
IE1BQ0hJTkVfVkVSX1RZUEVfTkFNRSgidmlydCIsIF9fVkFfQVJHU19fKSwgXAorICAgICAgICAu
cGFyZW50ID0gVFlQRV9IRVhBR09OX1ZJUlRfTUFDSElORSwgXAorICAgICAgICAuY2xhc3NfaW5p
dCA9IE1BQ0hJTkVfVkVSX1NZTShjbGFzc19pbml0LCB2aXJ0LCBfX1ZBX0FSR1NfXyksIFwKKyAg
ICAgICAgLmlzX2F2YWlsYWJsZSA9IHRhcmdldF9oZXhhZ29uLCBcCisgICAgfTsgXAorICAgIHN0
YXRpYyB2b2lkIE1BQ0hJTkVfVkVSX1NZTShyZWdpc3RlciwgdmlydCwgX19WQV9BUkdTX18pKHZv
aWQpIFwKKyAgICB7IFwKKyAgICAgICAgTUFDSElORV9WRVJfREVMRVRJT04oX19WQV9BUkdTX18p
OyBcCisgICAgICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGljKCZNQUNISU5FX1ZFUl9TWU0oaW5mbywg
dmlydCwgX19WQV9BUkdTX18pKTsgXAorICAgIH0gXAorICAgIHR5cGVfaW5pdChNQUNISU5FX1ZF
Ul9TWU0ocmVnaXN0ZXIsIHZpcnQsIF9fVkFfQVJHU19fKSk7CisKKyNkZWZpbmUgREVGSU5FX1ZJ
UlRfTUFDSElORV9BU19MQVRFU1QobWFqb3IsIG1pbm9yKSBcCisgICAgREVGSU5FX1ZJUlRfTUFD
SElORV9JTVBMKHRydWUsIG1ham9yLCBtaW5vcikKKworc3RhdGljIHZvaWQgdmlydF9tYWNoaW5l
XzExXzJfb3B0aW9ucyhNYWNoaW5lQ2xhc3MgKm1jKQoreworfQorREVGSU5FX1ZJUlRfTUFDSElO
RV9BU19MQVRFU1QoMTEsIDIpCi0tIAoyLjM0LjEKCg==

