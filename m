Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2D606A885
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xh/r7x7T;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WVzbXoVD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTE7-00060d-G5; Fri, 20 Nov 2026 13:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE6-0005zo-0I
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE4-0000ku-8t
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:45 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKI1cGE1507166
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=; b=Xh/r7x7TPzyDUN1Q
 Uzfj6ypKKMvG6QLDEO4fgl1P6tL8jjGY9lXES/+MnFDHF/O51i6KU5Oz1TssyzMO
 aaNFLhT0SZbb+HZmJuFOk8SoX51aw+lfuwZarXKvuP6yaNdeCGRvEbf1xhVerJZ6
 C4DHpNUD/acODTSjy82FJ/akvxnktW0FAKqul1jcQNnm3EZZnULLmDSZWKFBCTUj
 HDGxBZEfM17KHfjXJud7d0TgDCamOeDRqVgIuGDZePMBxxc9u5HbF6P1F56NXWQC
 sWsBmF7sS8/mR3zXJ7xNt8EPQm7GOt0ajiwhX608fe9orsRvPhbpZDz7mCjZ/tvA
 1u7HlQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2u4fr4gb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:42 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-862ad1e3959so859881a34.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198842; x=1795803642; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=;
 b=WVzbXoVDUj0c/ZPVUuDDhLQpDTv1Vx0UuMCcW4nNALMPnHbB4sAfPDtj6FBCC1tb1V
 jYzBR1e2gpvA3E/VycXEqxg/IPv+Yj37LY+FWetDnlCkGuw/OgQeGpvruM9WmPlBRrTF
 3TqIlb8D3WHPlC9w8VFxOH4CVlNtVknODKWyfhj6xeGMWIDjblLonvWT2tj5jY4jtUcn
 k7fOxtnQMzgwg6Jv8Svs9+kBc6GMytSfDbBkrhHG8sdBjRxP0Do7XDjdx4+u5hXu/f4c
 rgFUuMkly7UWommS0MveNdEuhZp+daCGkfMAbC/CaqjpF4T6HvXqxWc5ontKnAu3bta6
 dKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198842; x=1795803642;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=;
 b=hBWQzLHcPtssimkIcGPSdgX5yHHEMUJtwiQ8kpI5TMyj11pjw1m3DO0dbxnw6hxlLJ
 LTuHq5PRAL4B3gLAJGTR+CmCHc0qqMg+AOiYfoFN9lo8TO0qhDpUYM5EE/MkOHjmkUCT
 UFSggTs4kVDuHAs1W0fKaGtu/3Uept2eL2XjZiD48U9ctdYJUsm8njNk45DF9M1ISqVF
 lUA2cnKBYl325UJYubZ5vHlWof/5bIDULrLRgbaUIdP/1xApUugYOE9HoOZuJzLQDJzP
 jzsmuADfBWZnLzK6egtAkWPTN+Gc/maWB0zpVJhjoEhV6WrUP4OLjbGovAnxagD4QnLg
 OtCg==
X-Gm-Message-State: APuU4Z9YNR2txQRWfZ0QrdJ91nJXHax1AYBu1kY8ZSHlFeGCGjTfHKoI
 6RLw/193b4L9YgfuaFBy2VrZxqlym40XBRFMO/0CEUdYmjLHQpS8aQJSHgIFPaVJnx5UONhN9o6
 T3UpDVFcI7ZThHvYwhPeHZrYRyNxt1QO3kVp/kdTqaspq8jS/kVYxhpNQ3V9810VxZQ==
X-Gm-Gg: AYBFou3sMo9JaKktbOnX2hZVKjP+oBGMm8fAT3JcEWDt0VitO1JCne1FfumoR5Vgdd+
 MXbZqldeokYCKWSYyupNHLsSUte7WoxSXNhwAzSrHLkZ1SqVW4QfPpHHsg+J/cCIjGVmTFlPyf/
 JexOkfQQLUdgvyNM0bjpGJETW1d1fd5/xs9vKyi0jv82WHxlVXCMeubfiRKHLZKq1oRScpHIi0/
 tZ0iolBcxm8uNDyWeDTdhk1jUZ4cCIM3dFFYrMGrHEA1WK1yVl4AwLsejqQETrVoxjxD6CHErhb
 qo3DqlCHPNlIiFYJpxUyeGezzSaoEbOvDXZIN741gRnV+I/NfSlbl/KuYtGI1UzSz9DXb2q92gn
 LkuwIRdx6jDN7ZaQ+gucIwqY5P81DQqI/ThTkexh0n1irwwSvTVPEPRBYmC33S87LSCp4eQXBG+
 AQoYYuCiptO4q6Wv5KSmOr5A==
X-Received: by 2002:a05:6830:6413:b0:862:abc2:9c52 with SMTP id
 46e09a7af769-8631562e308mr4840750a34.14.1795198841585; 
 Fri, 20 Nov 2026 10:20:41 -0800 (PST)
X-Received: by 2002:a05:6830:6413:b0:862:abc2:9c52 with SMTP id
 46e09a7af769-8631562e308mr4840723a34.14.1795198841137; 
 Fri, 20 Nov 2026 10:20:41 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:40 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2 v2 05/12] target/hexagon: report the faulting packet
 for stack limit exceptions
Date: Fri, 20 Nov 2026 10:20:24 -0800
Message-Id: <20261120182031.560481-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=VJBIDNPX c=1 sm=1 tr=0 ts=6b008f7a cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ctcHP5N1X2NQA3O8W1oA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: 1aWzOAQF_gWagmY1Ui25BTXMEhGRXd1T
X-Proofpoint-ORIG-GUID: 1aWzOAQF_gWagmY1Ui25BTXMEhGRXd1T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfXzg9s/LAh2Mv5
 ito/AqQgx1lLvXhM0Z7rwN8ZQ6ouMmlCnbDE17TQysHSCsuzXq7opBZta1Fcnh5wZio+V90Nt0w
 2IUjOFbYOoigbubX4pqP99ZsYGD5xnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfXyNaM+tuAXkxV
 U2SajJ648OojmBo4UX0jkOBq3bkYMqhZHCxkS1Z19NGpUx+9TJmo3TXAwk3KNZ71OtAlaLClmrd
 0eJJIJkvpqVs/N7HNG4DSThurX5Gd63IUMzsQLLcodt0vVkkShwe9orECnDH76ONAYyQbA5Uj3c
 0NcaCCK4zi7PsBR0jm2288IzeyWbrQ/Wldtqrse2aOGkNZ0B4x90HKRLwPxeqRrauu1ihOTjIuF
 7nKlEG8se2ca59kGJFhZVmlAEhc3OtRJxwngByoqLrGbE0/p2UwG15Ih3qyYZGFHICFkFTSjOYU
 XB+g3B5gJg7oeW5/3g0Lj/vw0p0WOQnF+CtmSwf/sz1ATvg1wK6vvFny97n7jzRQL4SDXpo84Kx
 eEynq95hkbrt0h2Darpy5T4XFpSp5FOQHhvCIBHfKmu55THMimyOpVq+TWOdXHkVSpn1qCCwwdA
 +gZdI9S1TfmU9r+mycg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200073
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

VGhlIHN0YWNrIGxpbWl0IGNoZWNrIHJhaXNlZCB0aGUgZXhjZXB0aW9uIGZyb20gYSBoZWxwZXIg
d2l0aG91dAp1cGRhdGluZyB0aGUgUEMgcmVnaXN0ZXIsIHdoaWNoIGlzIG5vdCBrZXB0IGN1cnJl
bnQgd2hpbGUgYSBwYWNrZXQgcnVucy4KVGhlIGV4Y2VwdGlvbidzIEVMUiB3YXMgd2hhdGV2ZXIg
UEMgd2FzIGxhc3Qgd3JpdHRlbiwgc28gYSBoYW5kbGVyIHRoYXQKc2tpcHBlZCB0aGUgZmF1bHRp
bmcgYWxsb2NmcmFtZSByZXN1bWVkIGF0IGFuIGVhcmxpZXIgcGFja2V0IGFuZCB0b29rCnRoZSBz
YW1lIGV4Y2VwdGlvbiBmb3JldmVyLiAgUGFzcyB0aGUgcGFja2V0J3MgUEMgdG8gdGhlIGhlbHBl
ci4KClRoaXMgZW5hYmxlcyB0aGUgZnJhbWVsaW1pdCBzeXN0ZXN0LgoKU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhh
Z29uL2hlbHBlci5oICAgICAgICAgICAgICAgICAgIHwgMiArLQogdGFyZ2V0L2hleGFnb24vZ2Vu
cHRyLmMgICAgICAgICAgICAgICAgICAgfCAzICsrLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMgICAgICAgICAgICAgICAgfCA0ICsrKy0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X3N5c3Rlc3RzLnB5IHwgNSArKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIv
dGFyZ2V0L2hleGFnb24vaGVscGVyLmgKaW5kZXggMjkyY2E4ZWI3YzUuLmU2NThmODA2OGY0IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9o
ZWxwZXIuaApAQCAtMTU4LDcgKzE1OCw3IEBAIERFRl9IRUxQRVJfNShpbnNuX2NhY2hlX29wLCB2
b2lkLCBlbnYsIGkzMiwgaW50LCBpbnQsIGkzMikKICNlbmRpZgogCiAjaWYgIWRlZmluZWQoQ09O
RklHX1VTRVJfT05MWSkKLURFRl9IRUxQRVJfMyhyYWlzZV9zdGFja19vdmVyZmxvdywgdm9pZCwg
ZW52LCBpMzIsIGkzMikKK0RFRl9IRUxQRVJfNChyYWlzZV9zdGFja19vdmVyZmxvdywgdm9pZCwg
ZW52LCBpMzIsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8yKHN3aSwgdm9pZCwgZW52LCBpMzIpCiBE
RUZfSEVMUEVSXzIoY3N3aSwgdm9pZCwgZW52LCBpMzIpCiBERUZfSEVMUEVSXzIoY2lhZCwgdm9p
ZCwgZW52LCBpMzIpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3Rhcmdl
dC9oZXhhZ29uL2dlbnB0ci5jCmluZGV4IDUyNjE1NjI4ZTNmLi45MGI3MWViYzAxNiAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRy
LmMKQEAgLTExNTYsNyArMTE1Niw4IEBAIHZvaWQgZ2VuX2ZyYW1lY2hlY2soRGlzYXNDb250ZXh0
ICpjdHgsIFRDR3ZfaTMyIGFkZHIsIFRDR3ZfaTMyIGVhKQogICAgIFRDR0xhYmVsICpvayA9IGdl
bl9uZXdfbGFiZWwoKTsKICAgICB0Y2dfZ2VuX2JyY29uZF9pMzIoVENHX0NPTkRfR0VVLCBhZGRy
LCBoZXhfZ3ByW0hFWF9SRUdfRlJBTUVMSU1JVF0sIG9rKTsKICAgICBnZW5faGVscGVyX3JhaXNl
X3N0YWNrX292ZXJmbG93KHRjZ19lbnYsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRjZ19jb25zdGFudF9pMzIoY3R4LT5pbnNuLT5zbG90KSwgZWEpOworICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50X2kzMihjdHgtPmluc24tPnNsb3Qp
LCBlYSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9p
MzIoY3R4LT5wa3QucGMpKTsKICAgICBnZW5fc2V0X2xhYmVsKG9rKTsKICNlbmRpZgogfQpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYwppbmRleCA3MWIyN2VmMDdmMS4uY2RiNzMxMTYwZWIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBA
IC0xNjYwLDcgKzE2NjAsNyBAQCB2b2lkIEhFTFBFUih2d2hpc3QxMjhxbSkoQ1BVSGV4YWdvblN0
YXRlICplbnYsIGludDMyX3QgdWlWKQogCiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKIHZvaWQg
SEVMUEVSKHJhaXNlX3N0YWNrX292ZXJmbG93KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3Qgc2xvdCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBiYWR2
YSkKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBiYWR2YSwgdWlu
dDMyX3QgcGMpCiB7CiAgICAgLyoKICAgICAgKiBQZXIgc2VjdGlvbiA3LjMuMSBvZiB0aGUgVjY3
IFByb2dyYW1tZXIncyBSZWZlcmVuY2UsCkBAIC0xNjc3LDYgKzE2NzcsOCBAQCB2b2lkIEhFTFBF
UihyYWlzZV9zdGFja19vdmVyZmxvdykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNs
b3QsCiAgICAgY3MgPSBlbnZfY3B1KGVudik7CiAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEhF
WF9FVkVOVF9QUkVDSVNFOwogICAgIGVudi0+Y2F1c2VfY29kZSA9IEhFWF9DQVVTRV9TVEFDS19M
SU1JVDsKKyAgICAvKiBUaGUgUEMgcmVnaXN0ZXIgaXMgbm90IGtlcHQgY3VycmVudCwgRUxSIGlz
IHRoZSBmYXVsdGluZyBwYWNrZXQgKi8KKyAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IHBjOwog
CiAgICAgaWYgKHNsb3QgPT0gMCkgewogICAgICAgICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19CQURW
QTBdID0gYmFkdmE7CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9z
eXN0ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5Cmlu
ZGV4IDYwNjU2NzIzMGI5Li5mOTk3NTYzYmFjYSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25h
bC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTg3LDYgKzg3LDExIEBAIGRlZiB0ZXN0X2Zsb2F0X2V4Y3Ao
c2VsZik6CiAgICAgICAgIHRoYXQgY2F1c2VkIHRoZW0gY29tbWl0cy4iIiIKICAgICAgICAgc2Vs
Zi5ydW5fZXhpdF96ZXJvKCJmbG9hdF9leGNwIikKIAorICAgIGRlZiB0ZXN0X2ZyYW1lbGltaXQo
c2VsZik6CisgICAgICAgICIiImFsbG9jZnJhbWUgcGFzdCBGUkFNRUxJTUlUIGluIHVzZXIgbW9k
ZSByYWlzZXMgdGhlIHN0YWNrIGxpbWl0CisgICAgICAgIGV4Y2VwdGlvbiBhdCB0aGUgYWxsb2Nm
cmFtZSBwYWNrZXQuIiIiCisgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygiZnJhbWVsaW1pdCIp
CisKICAgICBkZWYgdGVzdF9hY2Nlc3Moc2VsZik6CiAgICAgICAgICIiImFjY2VzcyBjaGVja3Mg
Ul9PS3xXX09LIG9uIF90ZXN0ZmlsZV9hY2Nlc3MuIiIiCiAgICAgICAgIHRlc3RmaWxlID0gc2Vs
Zi5zY3JhdGNoX2ZpbGUoIl90ZXN0ZmlsZV9hY2Nlc3MiKQotLSAKMi4zNC4xCgo=

