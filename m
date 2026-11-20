Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C25606B20D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iI24y7ze;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aIMVWcq7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTE9-00061B-B9; Fri, 20 Nov 2026 13:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE6-000600-Nt
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE4-0000Cm-TY
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:46 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfgQS2947012
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Qnp5Ofj9fnEaN6Uu6vRY1r
 IpCF1588U+S05jFzjagg4=; b=iI24y7zeR4kkjGh8okdDHyhxjm3Faz+b7Mf/P6
 bvD8ZMrVz4LO8ntFFbEQopsmWR4ela7jM2fdDjXspkVqS1F+G6Ik37/0wpjJ+AqZ
 w/JUV4L6Bp6Qk+gCI8RbQgRFcU5VY9R2wmHZT5hvBhKptCghd+SpIJVKbOHDSKMR
 n7WJKZNTsJocIl1i+tASL8UDhM5g3iYVY6qYIcfmTV+CIoPFNnBO+uOAmeW7fhcP
 wMeXJd/RbFLMiBQePl3Wbgmai2sq8SPIOTqS9hT4qHcI1cK2KNV7g4ccBlwdAKuO
 QNoh3peJF/tDbC9e0W1Yexkkg0TVIysTylhbasV8IVMWPH2Q==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjjb9n2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:34 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-862b2e1885cso1429516a34.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198834; x=1795803634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qnp5Ofj9fnEaN6Uu6vRY1rIpCF1588U+S05jFzjagg4=;
 b=aIMVWcq77ZifYsbuUa2UvLR3TiSWyWZHm/JZacokI0F+hnNrXAIRk5j9RK+X0khFVE
 J/87RJYWVci7LZopzsXVyBmVi4hkK4FnHWjPnCY4SvlPbUUR/pDonpIIXIPoOipnNuwC
 9v6i3oulhfN8wTJfzT6kj3+L1DFbakUeIsAyPE9dShoqWBA1Wfg45aegdOF3WVc77HiH
 kWf58AF+/g6c4Xdkryvk1JH/7OZu2F+aDVEztMKHBLQl7U2UBmAlNKnOK479Bg1MjXYt
 GriMi9m38s42YVhnVrDGPLm/lgl03EH4GkVFQKhQWddvzwc6JqYdOW59i4Q/ZshTdkV7
 /50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198834; x=1795803634;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qnp5Ofj9fnEaN6Uu6vRY1rIpCF1588U+S05jFzjagg4=;
 b=xvetPSFO8xhdUr5mB63Yva319g3syEZj3mN5Zh3Djl1VSyWRFXKqs9tBfiy+3GsmkE
 FIuy1WJXC5Nm4mQjqdLy/zDQh6ZVkjgv0uiDd3fe5MLaBL1hIxt2FHU8EwzCAo85WACc
 kyyiObjHqnrLAIT7WzhuieMVMgTYX+8rsQMzt+SNLK5xd++I80wDT4Kn1mS/eWyBdh4B
 iv4dp59jlnvv4Dai6KWdfYiMdh3pZnxZDQ2E/Ir2lHpYBHl1lHj+cLZh5T9EpWghUAE8
 mKHYGdsq/NcSnblKAKdYz0bKiaWNhnRfRcXpm4Bets9+rM4L+qarvKsl+dmx3DAYHXBo
 1aMQ==
X-Gm-Message-State: APuU4Z8Uokxt8COLOqJ0Gy57NRaWPwggL0Gfoej46tlXDY79KK7L+AHo
 zFq5NNCHe2eZ7ailvMRQo7E7L8WqLs1N4+kUmG70EsI6p0CJYZcHF3dfGvfY8sgVUn6qEJ12IfY
 O2ie5Qi4iYR2Wf6K+FhskotjDV1mDGH+H40iAQTRXOuyZQBbl8YUQzLAtDpJhua1ZhA==
X-Gm-Gg: AYBFou3/gOG1OwjXBHcVyPwlLMg9/r+PQOm45CT8U6R2VstDfKhnDCq817se+S6nMVr
 UrZ8+MWiCErfIPkIl75QLmIKj9E9rEkvU6SL8R7WwAitrde1KffjkOg2LkGP9RcZIjII//2Uvas
 G1UwayY9JzTOPs53Gxq3c70Rj7ST9AQl+gOCKd5PyxzotwRyYuTLs+mw0uVkCpY/GICHBA1QbW9
 jaUGjH3jOG/x0Q2dimvO8G+qm3wa1CpZ57cokPfc7/mEi/8K1iYVzgfTRkZhYrrYbKefcp3EFi3
 MB5gogB9Ln6l2A0EO1SpC435f5INELLNl2Xj0XGJJBxHyI59mXSxpCVD3sei2onkMSQAXSZpBRm
 /UIDrpEcMVUPkNuWiGfc9ThCeCo14jR2KkT7bD6qK6kcrfhTP+KIOyW5s2NnGwY0O6iOG1LenYl
 CiamU1qmYpZS20ABoSdWXMcg==
X-Received: by 2002:a05:6830:349a:b0:862:cc8d:abae with SMTP id
 46e09a7af769-863157866b0mr3992897a34.13.1795198833717; 
 Fri, 20 Nov 2026 10:20:33 -0800 (PST)
X-Received: by 2002:a05:6830:349a:b0:862:cc8d:abae with SMTP id
 46e09a7af769-863157866b0mr3992860a34.13.1795198833141; 
 Fri, 20 Nov 2026 10:20:33 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:32 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2 v2 00/12] Hexagon: fix systests + migration
Date: Fri, 20 Nov 2026 10:20:19 -0800
Message-Id: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b008f72 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Up2SH2T9wZsa8eJTtzcA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX8hyQTt38WmTg
 Zo2k+OwCRWO12Mu5MGuXrElxQOhrI5WvU+g1yxVf3Wy6JXlln9X0HUJ1Hlj6qdYG9wR3IBZaPqp
 V2so7tFQA+EiAGw8JLfrGXJFhCRlbbM=
X-Proofpoint-ORIG-GUID: w_uoAzt41uGLaZP7Bicbgc_XrDB7sRKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX4x+07Wn2ayll
 +V/Vgkh/cS3RkdFIRI8h63GpCJUPkJXQ+muYzIiDaDRxiFUqvETkvrOUH02siGmtED5Q0YnPuXn
 iPva9NKWxrcv3KZVtEXbWUwOVri/eOJzl1IjXjpEqFY1h06VzX7SAxfpqfao+LDJ6MMjl6zbes7
 jUZOEyfYeITMqVeAvpQ8D15LlrIZb6dZB5HbLLubV3ludeYj/rvmVRNbkTCTuO1LexeJk2yfTch
 DhDXEzw5gVN563+/u6ZIrT6XSfoP2iUi3FViY1nLIg52OVUcT9S8ls+wuKhgtZOgzf6up5tRjuW
 5KzB+GvMwUnPTDax3BnGfm5UBwGv0F88IFxj74e9rMa7GJC6xH8QN3aZS7sVO3IiM6XfUNdGv2g
 MbZdjLYoEi4KBAXnfpm93T8ESdzryAjw/0XUfKggpPgmJbc/77LEm4CTYuJK0sIHsiG9oChigXy
 AbVejmsY0wz5ndbAsMA==
X-Proofpoint-GUID: w_uoAzt41uGLaZP7Bicbgc_XrDB7sRKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200073
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIHN5c3Rlc3RzL2FyY2ggdGFyYmFsbHMgd2VyZSBjcmFmdGVkIHdoaWxlIHRlc3RpbmcgYSBk
b3duc3RyZWFtIGZvcmsuCgpFbmFibGluZyB0aGUgb21pdHRlZCB0ZXN0cyByZXZlYWxlZCBhIGZl
dyByZW1haW5pbmcgYnVncyBpbiAxMS4yLiAgQWRkCnRob3NlIHRlc3RzIGFuZCB0aGUgYXNzb2Np
YXRlZCBmaXhlcywgcGx1cyBhIGNvdXBsZSBvZiBmaXhlcyBmcm9tIE1hcmNvJ3MKcmVjZW50IHNl
cmllcy4KCkluIHYyOgotIGRyb3BwZWQgdGhlICdhZGQgSGV4YWdvbiB0byB0aGUgbWlncmF0aW9u
IGZyYW1ld29yaycsICdhZGQgYSBIZXhhZ29uCm1pZ3JhdGlvbiBzdGF0ZSB0ZXN0JyBjb21taXRz
LiAgV2lsbCB0YXJnZXQgdGhlc2UgZm9yIDEyLjAgaW5zdGVhZC4KCnYxOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYxMTE5MjAxNjAzLjIzNzc5ODktMS1icmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICgxMCk6CiAgdGFyZ2V0L2hleGFnb246IGZp
eCBnZXRfZXhlX21vZGUgYXNzZXJ0aW9uIGluIGhleGFnb25fc3RvcF90aHJlYWQKICB0YXJnZXQv
aGV4YWdvbjogZGVsaXZlciBmbG9hdGluZyBwb2ludCBleGNlcHRpb25zIGFmdGVyIHRoZSBwYWNr
ZXQKICB0YXJnZXQvaGV4YWdvbjogcmVwb3J0IHRoZSBmYXVsdGluZyBwYWNrZXQgZm9yIHN0YWNr
IGxpbWl0IGV4Y2VwdGlvbnMKICB0YXJnZXQvaGV4YWdvbjogdGFrZSBleGNlcHRpb25zIGZvciBj
YWNoZSBvcGVyYXRpb25zCiAgdGFyZ2V0L2hleGFnb246IHJhaXNlIGRlY29kZSBmYWlsdXJlcyBh
dCB0aGUgZmF1bHRpbmcgcGFja2V0CiAgaHcvaGV4YWdvbjogdXBkYXRlIHRoZSBnbG9iLXJlZyB2
bXN0YXRlIHZlcgogIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbjogcnVuIHRoZSByZXN0IG9mIHRo
ZSB0ZXN0cwogIHRlc3RzL3RjZy9oZXhhZ29uOiBwYWNrZXQgYW5kIENPRiBjb3JuZXIgY2FzZXMK
ICBody9oZXhhZ29uOiBob25vciBjb25maWd1cmVkIFJBTSBiYWNrZW5kcwogIGh3L2hleGFnb246
IHZlcnNpb24gdGhlIHZpcnQgbWFjaGluZSB0eXBlCgpNYXJjbyBMaWViZWwgKDIpOgogIHRhcmdl
dC9oZXhhZ29uOiByZWFkIHRoZSBvbGQgcHJlZGljYXRlIHZhbHVlIHRocm91Z2ggQzQKICB0YXJn
ZXQvaGV4YWdvbjogYm91bmQgcGFja2V0IGxvb2thaGVhZCB0byB0aGUgY3VycmVudCBwYWdlCgog
ZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5yc3QgICAgICAgICAgICB8ICAgMyArCiB0YXJn
ZXQvaGV4YWdvbi9nZW5fdGNnLmggICAgICAgICAgICAgICAgICAgIHwgIDE4ICstCiB0YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaCAgICAgICAgICAgICAgICAgICAgIHwgICA0ICstCiB0YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgICAgIHwgICA2ICstCiBody9oZXhhZ29uL2hl
eC1zdWJzeXMuYyAgICAgICAgICAgICAgICAgICAgIHwgIDEwICstCiBody9oZXhhZ29uL2hleGFn
b25fZ2xvYmFscmVnLmMgICAgICAgICAgICAgIHwgICA0ICstCiBody9oZXhhZ29uL3ZpcnQuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDM3ICsrKwogdGFyZ2V0L2hleGFnb24vYXJjaC5j
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgOSArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBl
ci5jICAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAg
ICAgICAgICAgICAgICAgIHwgICAzICstCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyAgICAgICAg
ICAgICAgICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAg
ICAgICAgICAgfCAgNDYgKysrLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAg
ICAgICAgICB8ICAyOCArKy0KIHRlc3RzL3F0ZXN0L2hleGFnb24tY29uZmlnLXRlc3QuYyAgICAg
ICAgICAgfCAgMjYgKysKIHRlc3RzL3RjZy9oZXhhZ29uL2JyZXYuYyAgICAgICAgICAgICAgICAg
ICAgfCAgMjUgKysKIHRlc3RzL3RjZy9oZXhhZ29uL2NpcmMuYyAgICAgICAgICAgICAgICAgICAg
fCAgNDIgKysrKwogdGVzdHMvdGNnL2hleGFnb24vZHVhbF9zdG9yZXMuYyAgICAgICAgICAgICB8
ICAzNCArKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lbV9ub3NodWYuYyAgICAgICAgICAgICAgfCAg
NTggKysrKy0KIHRlc3RzL3RjZy9oZXhhZ29uL3BhY2tldF91c2VyLmMgICAgICAgICAgICAgfCAg
MzggKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9wcmVnX2FsaWFzLmMgICAgICAgICAgICAgIHwgIDU4
ICsrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2NvbmRfYnJhbmNoLmMgICAgICAgIHwgIDk1
ICsrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3Vzci5jICAgICAgICAgICAgICAgICAgICAgfCAg
MzMgKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgIHwgICAy
ICsKIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAxMTQgKysr
KysrKystCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9saW51eC5weSAgICAgIHwgIDYy
ICsrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSAgIHwgMjU5
ICsrKysrKysrKysrKysrKysrKystCiB0ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAg
ICAgICAgICAgIHwgICAxICsKIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZG90bmV3LlMgICAgICAg
ICAgICAgfCAgMzQgKystCiB0ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X3BhY2tldC5TICAgICAgICAg
ICAgIHwgIDQ2ICsrKy0KIDI5IGZpbGVzIGNoYW5nZWQsIDEwNTcgaW5zZXJ0aW9ucygrKSwgNDAg
ZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vcGFja2V0
X3VzZXIuYwogY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X2xpbnV4LnB5CgotLSAKMi4zNC4xCgo=

