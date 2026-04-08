Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C0310F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKH-00038r-OO; Wed, 08 Apr 2026 15:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAYIy-0007Je-5v
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOm-0005Z5-A4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637J81dc3362677
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fr3r1l7govQ0n2tgYo7tIfg3KvIKEMQ0pqpyUPHfVc8=; b=pD8uVQnGfLzRoYKj
 n06zRY9N/4780ZX1HU4Xnfslh97achh1026fk6inUT9dILEtexOgAhZjEys5xfEm
 BjHhI9ikFlBaG4RQ2Q65BbTQXi+DnBWQfjDWIH40vTvtAme4HLIkwNCEHuJG10J/
 XtWw+/GLevwuEiehiO76iJvahH5QhKnszKrYv1nGYmfDL6ssrf9ORO/HpE0GkPFD
 2F8VgUO9P3UgV8F6UFuv6u/NTT551/8RRvSCFkFuHWPYMYAmGTnOBfH/R3mtPGzZ
 QgUjDaV0heP9qxySBJ/zotb6IApJ8MjY6fScpp+KM4NxJPMOgM/QTpkD3fWRMes2
 DXy96A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7tkhexe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso8188875eec.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622014; x=1776226814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fr3r1l7govQ0n2tgYo7tIfg3KvIKEMQ0pqpyUPHfVc8=;
 b=Dy0sQR3QjDDbBXEJVNR5cEFG5MyM1RvMxbA0S0h29UtH33DdOW8KGeRrhMKybtsHPL
 ZenPkmG7sb9myHKRR/G558lEpwHQjBi68qdND8yVvbiDQnfK822mHgl/uohn5xcmnumg
 qs70n3Y0rp/LTj6dYpvd+yzTqiLKS6UKwoLIa4mbmNaUSTmBdTkubM3Ly7y2XvB3pwnY
 iehJ6CN0Ptcu0u+YYB3+yJ45rcPPzwgTjdXkE0pDu6L9N3cGWuXbkCzoble7KThOJKES
 8Z2v0VRL9ODxPcykKc0csnOB+ZI4mq64yzQ6MJAnrO/uVJsLBhGDF5Lu4iKTQleXMoho
 2RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622014; x=1776226814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fr3r1l7govQ0n2tgYo7tIfg3KvIKEMQ0pqpyUPHfVc8=;
 b=HDADqoKi3THq2gNM3WuqNnFDXZNRpiKMDMFthZ524TPBUzi2XK8IYfw+1bp+8AEBa9
 cu2GaIE22rL5hq0rfBYp+1EpbaC1xoH8ehuoVkLnr3nA+Jb+j/E9CNCq51M80jlT/kLo
 KywW+2V2JVSAmOh4Cs1eB0aL3wK2ZceMii3MPlgsK/m4UoqSU4jOxEx+jsOr5eDJNE8D
 /zoekYIYlKEtzVjl/vglimlOxmiEI23T1GIfBXPjonfZuzTKaj7c5vjPpjnYk4sUMP/7
 JNgjfTH1D49/JNfzIv9MxOTimmIAzziq55bwC93cqJP6LzbkgKjmw/PAWEy2q4GnOW18
 n/tA==
X-Gm-Message-State: AOJu0Yx79e6zzV92UrY6hExPQe681U7z8Xo7ugmvxf+MsEeB5WQ4GYJb
 ZbA68ughPMHgUbnE4Lz3/cuJfvGDpcQLAn5/4ySE48AIEXTQbQvjSuGscqk6rg5lG9G7a41sEe4
 LAiNThbeP3ZC9U/Gbbtkvb66RWVs1IaZkT2lcfYFvrQsZLW28YSqGQPviJ3A/ZZhaow==
X-Gm-Gg: AeBDieuFLEvfa4DVDrTEP/4G3A1C3w4cIzpPaVaUdiOvdIEHFywCISkxbNkcSSgRw7h
 Sdjq1R5rAFoBb92MRbbV4xjAtAyF57Niwdd7SOBSOpxBZMy+QRM3i5xtaB26zDjU4mj3PTllmAZ
 g81RX3iH+NApnwz9Ld3B14wrD8HNwtWNPRmE/LmQO4awb4HRWA9q8YkbGZLvwIoMTvjIBeO1UQf
 3+PbuaX4gyluzInv5LCzmAQgHhibYVkueeHVmuCchyOw+rwWBb1krIw4ANAQsGMlAdZhLJeMd2k
 wI9Kw4YMdT1uUj7Juhb/m3/kFXeZGEoLpvhypw6+o31wxbE68uM1nsKiFii2YhPZzRMwjbLnVfq
 ZIqKCp/xxv5W+79xvhunEJC+dXEv8Q5oggLKU5gOXP6h45MAz/RWRMlWh3t24YMFmrrcAYg==
X-Received: by 2002:a05:7022:325:b0:12b:ebb9:1c0b with SMTP id
 a92af1059eb24-12bfb77ecedmr9784860c88.31.1775622014057; 
 Tue, 07 Apr 2026 21:20:14 -0700 (PDT)
X-Received: by 2002:a05:7022:325:b0:12b:ebb9:1c0b with SMTP id
 a92af1059eb24-12bfb77ecedmr9784840c88.31.1775622013502; 
 Tue, 07 Apr 2026 21:20:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 05/28] target/hexagon: Implement wait helper
Date: Tue,  7 Apr 2026 21:19:30 -0700
Message-Id: <20260408041953.1899532-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=drPrzVg4 c=1 sm=1 tr=0 ts=69d5d77e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mC-DEzHI51w1bzGme9gVkDUetycQ2t2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX8LLNzwR6iNuV
 lkdHxfjs3cUmW1C8ZI+Hsvpxu8sZaaVMQKTP8HqzcEaI8U245K1SisEOYuXK7sZnOSrVRBA2VxL
 NjDHwtUbt/meERielFcKo6bLGSPFV772SJy67eZwwS5UyAcPmmUINym9IINmh6FPVTL2NcYifoZ
 YHu2iogVXQiDZR8yLnqSY3dH2j9DlfRqpVxFWYMfMn473bA3w3CozWUQVlF7CdhgY8zxSki6H6u
 1aDLAA496+BfANozH4Ep9vE0eWFOTP7Mztf648TER1fk32NDoX1uRgE/if9V5Z8i7tpLESp4ACg
 cEmfRZWVhgEXStdbIWSr/HWDblM0y3q/iwAzCYTFIRvXCysxlF/UQyVKe4DVeseslYNG7fYlGei
 NMu2uDrd7Lszz3It66DenzCr/qna9fDG0CTwlLaGZFcTOUjBbEaxQpCwSuS5CYG7fdb+1UlIzrN
 Ti8iSlnmEY5kMG3FNUg==
X-Proofpoint-GUID: mC-DEzHI51w1bzGme9gVkDUetycQ2t2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgNjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKaW5kZXggMjM1YzcwZjczNzAuLmQ0MDA2MWRlMDZlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQ4
Niw5ICsxNDg2LDY1IEBAIHZvaWQgSEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQog
ICAgIGhleGFnb25fc3RvcF90aHJlYWQoZW52KTsKIH0KIAotdm9pZCBIRUxQRVIod2FpdCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBQQykKK3N0YXRpYyB2b2lkIHNldF93YWl0
X21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKKyAgICBIZXhhZ29uQ1BVICpjcHU7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50
MzJfdCB0aHJlYWRfd2FpdF9tYXNrOworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKwor
ICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7CisgICAgaWYgKCFjcHUtPmdsb2JhbHJlZ3MpIHsK
KyAgICAgICAgcmV0dXJuOworICAgIH0KKyAgICBtb2RlY3RsID0KKyAgICAgICAgaGV4YWdvbl9n
bG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgdGhyZWFkX3dhaXRf
bWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX1csIG1vZGVjdGwpOworICAgIHRocmVhZF93YWl0X21h
c2sgfD0gMHgxIDw8IGVudi0+dGhyZWFkSWQ7CisgICAgU0VUX1NZU1RFTV9GSUVMRChlbnYsIEhF
WF9TUkVHX01PREVDVEwsIE1PREVDVExfVywgdGhyZWFkX3dhaXRfbWFzayk7Cit9CisKK3N0YXRp
YyB2b2lkIGhleGFnb25fd2FpdF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IFBDKQoreworICAgIENQVVN0YXRlICpjczsKKworICAgIGdfYXNzZXJ0KGJxbF9sb2NrZWQoKSk7
CisKKyAgICBpZiAocWVtdV9sb2dsZXZlbF9tYXNrKExPR19HVUVTVF9FUlJPUikgJiYKKyAgICAg
ICAgKGVudi0+azBfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19VTkxPQ0tFRCB8fAorICAgICAgICAg
ZW52LT50bGJfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19VTkxPQ0tFRCkpIHsKKyAgICAgICAgcWVt
dV9sb2coIldBUk5JTkc6IGV4ZWN1dGluZyB3YWl0KCkgd2l0aCBhY3F1aXJlZCBsb2NrIgorICAg
ICAgICAgICAgICAgICAibWF5IGxlYWQgdG8gZGVhZGxvY2tcbiIpOworICAgIH0KKyAgICBnX2Fz
c2VydChnZXRfZXhlX21vZGUoZW52KSAhPSBIRVhfRVhFX01PREVfV0FJVCk7CisKKyAgICBjcyA9
IGVudl9jcHUoZW52KTsKKyAgICAvKgorICAgICAqIFRoZSBhZGR0aW9uIG9mIGNwdV9oYXNfd29y
ayBpcyBib3Jyb3dlZCBmcm9tIGFybSdzIHdmaSBoZWxwZXIKKyAgICAgKiBhbmQgaXMgY3JpdGlj
YWwgZm9yIG91ciBzdGFiaWxpdHkKKyAgICAgKi8KKyAgICBpZiAoKGNzLT5leGNlcHRpb25faW5k
ZXggIT0gSEVYX0VWRU5UX05PTkUpIHx8CisgICAgICAgIChjcHVfaGFzX3dvcmsoY3MpKSkgewor
ICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULAorICAgICAgICAgICAgIiVzOiB0aHJl
YWQgJSIgUFJJdTMyICIgc2tpcHBpbmcgV0FJVCBtb2RlLCBoYXZlIHNvbWUgd29ya1xuIiwKKyAg
ICAgICAgICAgIF9fZnVuY19fLCBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgcmV0dXJuOworICAg
IH0KKyAgICBzZXRfd2FpdF9tb2RlKGVudik7CisgICAgZW52LT53YWl0X25leHRfcGMgPSBQQyAr
IDQ7CisKKyAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOworfQorCit2
b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgUEMpCit7Cisg
ICAgQlFMX0xPQ0tfR1VBUkQoKTsKKworICAgIGlmICghZklOX0RFQlVHX01PREUoZW52LT50aHJl
YWRJZCkpIHsKKyAgICAgICAgaGV4YWdvbl93YWl0X3RocmVhZChlbnYsIFBDKTsKKyAgICB9CiB9
CiAKIHZvaWQgSEVMUEVSKHJlc3VtZSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1h
c2spCi0tIAoyLjM0LjEKCg==

