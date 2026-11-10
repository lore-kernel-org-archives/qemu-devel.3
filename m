Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D01606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=azdJA6GQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dThJazkl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQbvQ-0006OF-Dv; Mon, 09 Nov 2026 21:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvI-0006Kx-V4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvE-0004CC-W9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:23 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0j5AU2474590
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wu5RpHl2PCyc8rAvVdJpPH3KBukpojRNJBwv+UOJ418=; b=azdJA6GQPlzv3kmn
 a+2C/b0PkFEv1cn4lp501Zr/H+p1fLVKiM8/EbxjOF52BF8VJ+9oSJWXLFclJsoG
 5Km/y8mm8ifaBGD2mRqAmNZiPhye3HcLq9lCutDyJ4B/PQqhrvXECjovRqKqLNd4
 /iRzPAiIZN6tGA+TZZmAZPIDqG/NKy6JG+5t0UEjfoQ2MubguOdGQI46TBjvFAu3
 Ym09pE3MGoWYsMBO/Zm6JYETL/uF94OsTGv+rCo3HKMqo+bLcpI4Ta5F/dJ+Fzez
 n0CyNoTSvN4XNNnrggcd1J1HjWm3muq7kXBZFiqm5nr0IKueBxlycWX1RFRYQYw/
 XW6Osg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg1a73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-370230d93efso864371eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794278957; x=1794883757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wu5RpHl2PCyc8rAvVdJpPH3KBukpojRNJBwv+UOJ418=;
 b=dThJazklUREinurMwVHgqa78wcd4X26JToGjVvLfDpRln81tPGx3+4u3RKCMHtI9Jg
 CRgaHkQ5zJ2SvGw8VJ5J3V5DnDfIz+oDvQYwgRHbBC0FR802mBKqwLHO7maPsJMFF4yS
 xHo4WmYz/HVbUBCpvkwd89pPYcYs64jTBb2wwdUHp3R0OuKg4bOhBwZtMCxiuefG2fRo
 GGDC6Tsej99Pqy0PhbufSCHMRo+/C/K5JXhQlv72PXE5k/mlSYv5EKnbO3tfkeIVwoVY
 lQI4kYU4ZPYvwQIS3wuX/RIMr161eMXkGxATgRzFJnr9gSNCXaEA6Ygg6zr+VnO+pNxk
 ICHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794278957; x=1794883757;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wu5RpHl2PCyc8rAvVdJpPH3KBukpojRNJBwv+UOJ418=;
 b=UPEK+NBQJ1q1sn8JWCXn9NswEx8haRUdqqADMxU09t3NoccH8uLS9PjAlddjY04Huf
 BT8CrRXOJi4lpWDIR/FXxOIqzwjtPFBlj5WTOqTdBXsigxu+tECzwAnOJbQczl2SfdLL
 MS6xWnvtbThZ6a+do8RxKa4wN12iiTa3VF+mx11JSSVWaxa/ssln0PQfvCOBaiYFyF4r
 c178Lau3Y8vVP47wpvxncPPz/iacjHTQIKcvhE9HUOqY29j3th6ta9ACqxXjEYxf1oCH
 uCmEoWPdozcc8yZT3pb9Xs4YnvVLyJAQmuyynbGevTEw52vtMWvwOdc7iPdGN7EmGhW0
 ZJog==
X-Gm-Message-State: APuU4Z8jSxB+n6lpg55daqwjlMifzOMkMhCn47jItxw/jLRQi2QoiT+u
 YAUm6NQNpVWfRs2VOTcLFwwSiUFBGRfs3jYvt8/xyaebNrHOwXub4WQ23znE5SRSpr+GX48V8RT
 aNEv6YC9idt5AvP6zWp+8g65KiUukUUBge2PWSvrlHKkFrZPoq2cnRAhtqjlReDeXyQ==
X-Gm-Gg: AYBFou1kbiuEMtSI5ZOxfIj+wu8Zu1QJJoYD/jLFAKynsJLu0K/x/7gZKbNkUDDzJ9p
 o2Efj3LPmi+nzttcBCD2mBONozPDSwdTbQR2DLTDwxQuv64udhz70+5b3OpfeJGuXswGBxl8K8z
 h2RnMgCiraVnaHCrATrRjkYXXE9cPL0TQkJdZvGo0Vxaoj8Au2PfnmH/1wEbh6xvGj7kvxkBhWK
 33bC0AC1+OzV92HBP/gvvBQ3ANVnNvP3MsywUW5xbwVZC9wnYrhEGztTUZiHmgyuVPSZerb0kLv
 6hCFIfYbhn9/NYbbzBFTL5UaRrEhiTsKmHqFpz4YwmjFv8NQ8lfhSxMG05wwmyrv52yVbINQo/l
 SC6tlCaluOLDfgMIc6s8C2Id3KO3BB6ci7ZOTOEW9t32J3PrWKrom0xL00d3+YXoGFPzdykfT0p
 KHc2xvWq8oYEyaXlxYTi3b
X-Received: by 2002:a05:7301:a01:b0:36d:a466:9d0b with SMTP id
 5a478bee46e88-3751ef7c90emr1615150eec.19.1794278957096; 
 Mon, 09 Nov 2026 18:49:17 -0800 (PST)
X-Received: by 2002:a05:7301:a01:b0:36d:a466:9d0b with SMTP id
 5a478bee46e88-3751ef7c90emr1615119eec.19.1794278956531; 
 Mon, 09 Nov 2026 18:49:16 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e9d78sm2700263eec.25.2026.11.09.18.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:49:15 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 02/11] target/hexagon: serialize TLB invalidation and IMASK
 access
Date: Mon,  9 Nov 2026 18:48:52 -0800
Message-Id: <20261110024901.1610588-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
References: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfX/mO+LAg4R1rn
 Hyfxlbkuq1WKu/zXoQAbbEi450182hkI9shk0jlnSp2T96dOe67mIIndkXxlWlrsxYSI8h9Ct5l
 s8fnVIfmblA0e2dGj0usmGY4TWHbT+G/OQRYueQuS9faqIj7xwRwCxu8CkymSYOBlztVX58MI3H
 /UAPsBWRse6i7fcb+6shjhihcYRdPSHHTmpeX3OOkgCGWmYLvftdpfRC9UY+b2TocYmOPnIZycg
 1h8DWJunFbQxcIeL4ZcTP4wJde1kv6DFPxVT/fNCQvNtaz9PJiXJvFjXVQiBuipOV8DmaWhT5nz
 lNRFNER/eNty4hqcWSYdB3VQVnB3YZzTLysZo2iFpvAcTfzlfySJ7rYh6HtKDXXk4MktLCPwove
 TFF7Lk99cW1F6KtxkNZOiPeC0bsY6JGBV9Q5VB3ATIKxT/t02yGQAjbb7umsURHhhK19XdNElrb
 LgxsA1Oo1WVt61QNeOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfXyDbOQ151mz4f
 dkqzrum/RFDPqSMnvQMgxWGNZnYbQihsBovh61lwTRg/Ler10UHcR1CjU6TcP2j5wJj235eAHD8
 JmnaJLu0OpgduwtlK41GWQr2y5jfOL4=
X-Proofpoint-GUID: y0CaJwc-AbiKj81AO5RJcci9IE6OcHPf
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2862e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=DE7XvRD9089hcuUG1cQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: y0CaJwc-AbiKj81AO5RJcci9IE6OcHPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100010
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkhvbGQg
dGhlIHNoYXJlZCBUTEIgbXV0ZXggZHVyaW5nIEFTSUQgaW52YWxpZGF0aW9uIHNvIGl0IGNhbm5v
dApvdmVyd3JpdGUgYSBjb25jdXJyZW50IGVudHJ5IHJlcGxhY2VtZW50LgoKUm91dGUgbG9jYWwg
SU1BU0sgcmVhZHMgYW5kIHdyaXRlcyB0aHJvdWdoIEJRTC1wcm90ZWN0ZWQgaGVscGVycwp0byBz
ZXJpYWxpemUgdGhlbSB3aXRoIGNyb3NzLXRocmVhZCBpbnRlcnJ1cHQgYXNzaWdubWVudC4gQXBw
bHkKdGhlIHByZS1WODEgd3JpdGFibGUtYml0IG1hc2sgdW5kZXIgdGhlIHNhbWUgbG9jay4KClNp
Z25lZC1vZmYtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiBody9oZXhhZ29uL2hleGFnb25fdGxiLmMgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2dl
bnB0ci5jICAgIHwgMTcgKysrKysrKysrLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jIHwgIDQgKysrKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAxNiArKysrKysrKysr
KystLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl90bGIuYyBiL2h3L2hleGFnb24vaGV4
YWdvbl90bGIuYwppbmRleCAzZTcyMDI2ZDYyYS4uMDc0MDZjZWEzNWUgMTAwNjQ0Ci0tLSBhL2h3
L2hleGFnb24vaGV4YWdvbl90bGIuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fdGxiLmMKQEAg
LTMyNSw2ICszMjUsNyBAQCB1aW50MzJfdCBoZXhhZ29uX3RsYl9pbnZhbGlkYXRlX2FzaWQoSGV4
YWdvblRMQlN0YXRlICp0bGIsIHVpbnQzMl90IGFzaWQpCiB7CiAgICAgdWludDMyX3QgaW52YWxp
ZGF0ZWQgPSAwOwogCisgICAgUUVNVV9MT0NLX0dVQVJEKCZ0bGItPmxvY2spOwogICAgIGZvciAo
dWludDMyX3QgaSA9IDA7IGkgPCB0bGItPm51bV9lbnRyaWVzOyBpKyspIHsKICAgICAgICAgdWlu
dDY0X3QgZW50cnkgPSB0bGItPmVudHJpZXNbaV07CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2dlbnB0ci5jIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKaW5kZXggYWRkYjVkMjNkOTAu
LjUyNjE1NjI4ZTNmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtMzAyLDEzICszMDIsMTEgQEAgc3RhdGljIHZvaWQg
Z2VuX2xvZ19zcmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwgVENHdl9pMzIg
dmFsKQogICAgIGlmIChybnVtID09IEhFWF9TUkVHX01PREVDVEwgfHwgcm51bSA9PSBIRVhfU1JF
R19TWVNDRkcpIHsKICAgICAgICAgdHJhbnNsYXRvcl9pb19zdGFydCgmY3R4LT5iYXNlKTsKICAg
ICB9Ci0gICAgaWYgKHJudW0gPT0gSEVYX1NSRUdfSU1BU0sgJiYKLSAgICAgICAgY3R4LT5oZXhf
ZGVmLT5oZXhfdmVyc2lvbiA8IEhFWF9WRVJfVjgxKSB7Ci0gICAgICAgIHJlZ19tYXNrID0gMHhm
ZmZmMDAwMDsKLSAgICB9Ci0KICAgICBpZiAocmVnX21hc2sgIT0gSU1NVVRBQkxFKSB7Ci0gICAg
ICAgIGlmIChybnVtIDwgSEVYX1NSRUdfR0xCX1NUQVJUKSB7CisgICAgICAgIGlmIChybnVtID09
IEhFWF9TUkVHX0lNQVNLKSB7CisgICAgICAgICAgICAvKiBDb21taXQgdGhyb3VnaCBhIGhlbHBl
ciB0byBzZXJpYWxpemUgd2l0aCBpYXNzaWdudy9zZXRpbWFzay4gKi8KKyAgICAgICAgICAgIHRj
Z19nZW5fbW92X2kzMihjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcm51bV0sIHZhbCk7CisgICAgICAg
IH0gZWxzZSBpZiAocm51bSA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgewogICAgICAgICAgICAgZ2Vu
X21hc2tlZF9yZWdfd3JpdGUodmFsLCBoZXhfdF9zcmVnW3JudW1dLCByZWdfbWFzayk7CiAgICAg
ICAgICAgICBpZiAoY3R4LT5uZWVkX2NvbW1pdCB8fCBybnVtID09IEhFWF9TUkVHX1NTUiB8fAog
ICAgICAgICAgICAgICAgIHJudW0gPT0gSEVYX1NSRUdfQ0NSKSB7CkBAIC0zNDMsNyArMzQxLDgg
QEAgc3RhdGljIHZvaWQgZ2VuX3JlYWRfc3JlZyhEaXNhc0NvbnRleHQgKmN0eCwgVENHdl9pMzIg
ZHN0LCBpbnQgcmVnX251bSkKICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JFR19QQ1lDTEVMTyB8
fCByZWdfbnVtID09IEhFWF9TUkVHX1BDWUNMRUhJKSB7CiAgICAgICAgIHRyYW5zbGF0b3JfaW9f
c3RhcnQoJmN0eC0+YmFzZSk7CiAgICAgfQotICAgIGlmIChyZWdfbnVtID49IEhFWF9TUkVHX0dM
Ql9TVEFSVCB8fCByZWdfbnVtID09IEhFWF9TUkVHX0JBRFZBKSB7CisgICAgaWYgKHJlZ19udW0g
Pj0gSEVYX1NSRUdfR0xCX1NUQVJUIHx8IHJlZ19udW0gPT0gSEVYX1NSRUdfQkFEVkEgfHwKKyAg
ICAgICAgcmVnX251bSA9PSBIRVhfU1JFR19JTUFTSykgewogICAgICAgICBnZW5faGVscGVyX3Ny
ZWdfcmVhZChkc3QsIHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIocmVnX251bSkpOwogICAgIH0g
ZWxzZSB7CiAgICAgICAgIHRjZ19nZW5fbW92X2kzMihkc3QsIGhleF90X3NyZWdbcmVnX251bV0p
OwpAQCAtMzU2LDcgKzM1NSw5IEBAIHN0YXRpYyB2b2lkIGdlbl9yZWFkX3NyZWdfcGFpcihEaXNh
c0NvbnRleHQgKmN0eCwgVENHdl9pNjQgZHN0LCBpbnQgcmVnX251bSkKICAgICBpZiAocmVnX251
bSA9PSBIRVhfU1JFR19USU1FUkxPIHx8IHJlZ19udW0gPT0gSEVYX1NSRUdfUENZQ0xFTE8pIHsK
ICAgICAgICAgdHJhbnNsYXRvcl9pb19zdGFydCgmY3R4LT5iYXNlKTsKICAgICB9Ci0gICAgaWYg
KHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAgICBpZiAocmVnX251bSA9PSBIRVhf
U1JFR19JTUFTSykgeworICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZF9wYWlyKGRzdCwgdGNn
X2VudiwgdGNnX2NvbnN0YW50X2kzMihyZWdfbnVtKSk7CisgICAgfSBlbHNlIGlmIChyZWdfbnVt
IDwgSEVYX1NSRUdfR0xCX1NUQVJUKSB7CiAgICAgICAgIGlmIChyZWdfbnVtICsgMSA9PSBIRVhf
U1JFR19CQURWQSkgewogICAgICAgICAgICAgVENHdl9pMzIgYmFkdmEgPSB0Y2dfdGVtcF9uZXdf
aTMyKCk7CiAgICAgICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZChiYWR2YSwgdGNnX2VudiwK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMKaW5kZXggMGExNjc3OGU1ZTIuLjcxYjI3ZWYwN2YxIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YwpAQCAtMTk5NCw2ICsxOTk0LDEwIEBAIHZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfbWFza2VkKShD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwpCiB7CiAgICAg
QlFMX0xPQ0tfR1VBUkQoKTsKICAgICBpZiAocmVnIDwgSEVYX1NSRUdfR0xCX1NUQVJUKSB7Cisg
ICAgICAgIGlmIChyZWcgPT0gSEVYX1NSRUdfSU1BU0sgJiYKKyAgICAgICAgICAgIGVudl9hcmNo
Y3B1KGVudiktPmNmZy5oZXhfZGVmLT5oZXhfdmVyc2lvbiA8IEhFWF9WRVJfVjgxKSB7CisgICAg
ICAgICAgICB2YWwgPSBkZXBvc2l0MzIoZW52LT50X3NyZWdbcmVnXSwgMCwgMTYsIHZhbCk7Cisg
ICAgICAgIH0KICAgICAgICAgZW52LT50X3NyZWdbcmVnXSA9IHZhbDsKICAgICB9IGVsc2Ugewog
ICAgICAgICBIZXhhZ29uQ1BVICpjcHUgPSBlbnZfYXJjaGNwdShlbnYpOwpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpp
bmRleCA4YWIyOGQ0MGQzNC4uZWMxZDc5ZTMxZjYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC04MDQsOCAr
ODA0LDEzIEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgp
CiAgICAgICAgIGludCByZWdfbnVtID0gY3R4LT5zcmVnX2xvZ1tpXTsKICAgICAgICAgaWYgKHJl
Z19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKICAgICAgICAgICAgIGN0eC0+dF9zcmVnX25l
d192YWx1ZVtyZWdfbnVtXSA9IHRjZ190ZW1wX25ldygpOwotICAgICAgICAgICAgdGNnX2dlbl9t
b3ZfdGwoY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dLAotICAgICAgICAgICAgICAgICAg
ICAgICAgICBoZXhfdF9zcmVnW3JlZ19udW1dKTsKKyAgICAgICAgICAgIGlmIChyZWdfbnVtID09
IEhFWF9TUkVHX0lNQVNLKSB7CisgICAgICAgICAgICAgICAgZ2VuX2hlbHBlcl9zcmVnX3JlYWQo
Y3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dLCB0Y2dfZW52LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9pMzIocmVnX251bSkpOworICAgICAg
ICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgICAgICB0Y2dfZ2VuX21vdl90bChjdHgtPnRfc3Jl
Z19uZXdfdmFsdWVbcmVnX251bV0sCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZXhf
dF9zcmVnW3JlZ19udW1dKTsKKyAgICAgICAgICAgIH0KICAgICAgICAgfQogICAgIH0KICAgICBm
b3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKQEAgLTEwNzEsOCArMTA3NiwxMSBAQCBz
dGF0aWMgdm9pZCBnZW5fc3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgb2xkX3JlZyk7CiAgICAgICAgICAgICAvKiBBIENDUiB3
cml0ZSBjYW4gY2hhbmdlIGNvbnRleHQsIHNvIGVuZCB0aGUgVEIuICovCiAgICAgICAgICAgICBj
dHgtPmJhc2UuaXNfam1wID0gRElTQVNfTk9SRVRVUk47CisgICAgICAgIH0gZWxzZSBpZiAocmVn
X251bSA9PSBIRVhfU1JFR19JTUFTSykgeworICAgICAgICAgICAgZ2VuX2hlbHBlcl9zcmVnX3dy
aXRlX21hc2tlZCh0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKHJlZ19udW0pLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVn
X251bV0pOworICAgICAgICAgICAgZ2VuX2hlbHBlcl9wZW5kaW5nX2ludGVycnVwdCh0Y2dfZW52
KTsKICAgICAgICAgfSBlbHNlIGlmICgocmVnX251bSA9PSBIRVhfU1JFR19TVElEKSB8fAotICAg
ICAgICAgICAgICAgICAgICAocmVnX251bSA9PSBIRVhfU1JFR19JTUFTSykgfHwKICAgICAgICAg
ICAgICAgICAgICAocmVnX251bSA9PSBIRVhfU1JFR19JUEVOREFEKSB8fAogICAgICAgICAgICAg
ICAgICAgIChyZWdfbnVtID09IEhFWF9TUkVHX0lQRU5EKSB8fAogICAgICAgICAgICAgICAgICAg
IChyZWdfbnVtID09IEhFWF9TUkVHX0lBRCkpIHsKQEAgLTE3MTUsNyArMTcyMyw3IEBAIHZvaWQg
aGV4YWdvbl90cmFuc2xhdGVfaW5pdCh2b2lkKQogICAgICAgICAgICAgICAgIGhleGFnb25fZ3Jl
Z25hbWVzW2ldKTsKICAgICB9CiAgICAgZm9yIChpID0gMDsgaSA8IE5VTV9TUkVHUzsgaSsrKSB7
Ci0gICAgICAgIGlmIChpIDwgSEVYX1NSRUdfR0xCX1NUQVJUKSB7CisgICAgICAgIGlmIChpIDwg
SEVYX1NSRUdfR0xCX1NUQVJUICYmIGkgIT0gSEVYX1NSRUdfSU1BU0spIHsKICAgICAgICAgICAg
IGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYsCiAgICAgICAg
ICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAogICAgICAgICAg
ICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKLS0gCjIuMzQuMQoK

