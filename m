Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12973606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MhUfU9Ru;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DMpZMV3m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQbvM-0006L0-Fv; Mon, 09 Nov 2026 21:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvH-0006KW-1p
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvD-0004Bc-At
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:22 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0j1vx1803403
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RmkZ7m9cqOEfZb8n+PkMVY
 0avKLOxATWQuHlJ69q3NM=; b=MhUfU9RuWgKrBWfMTyXHv7PPSQQkPx+uKcLCl2
 qHhp40OZWkqcPo0Hx2MEIhg0wssEq1Arhn2T3kA9kj7b9GT+lkcfDqWr1a4JJtO3
 oAJ4shGU1k88r5tEwWfj5ns5EHnV3Nt8REgHF6lJWD2zkp6KY5kPuUHxWLfhSjTU
 CSfb/WbJYLcLE0CreMkbl2fmH7cz7q6GbS4myw88+C2yRfAKXG/bbfWIY+9Dnaol
 UYlmWUJxpettXzseyBN/IF+jqNUM3HCP4jhv1OLWY3tRtcY0moFS64lHYLmNDY2G
 vwESQACxoRW0d29LqCCgZCwultN2lfa3EEo9HOiAu+TLMkTA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucapb9g6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a3451ea93so2459032eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794278954; x=1794883754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RmkZ7m9cqOEfZb8n+PkMVY0avKLOxATWQuHlJ69q3NM=;
 b=DMpZMV3mIusKm/1uxDE7iMkMx0WXwcCcUGwqY0IRGnEm95wW9EnIazHHSB05z21WDR
 LP/Uq88keRXWHxy5kckaGL2Yd7CqvMnoB242Xv1OSniy5n26mKmqnZcYUuJorDEtOtfk
 Oo0i/ZA+gghNf+nLucJuOZ6MZAv6IDD4vC7o2cgqh/Qf2g2Cpo8Aa7rm8tOkG1nsm7pO
 t0GJk6iHsvAJR1hjPTJCphH+YALVRTbXBVqH+t38oN/eGwcr8crLQdtNjyJi4S4GiVlb
 vx0Vf2bjHCQ1c1lW+BwSVTyxOknVXbzFmzyAXxhiqCAWY8M1rXopNBsBS5EyLBsL1k44
 PflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794278954; x=1794883754;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RmkZ7m9cqOEfZb8n+PkMVY0avKLOxATWQuHlJ69q3NM=;
 b=q9v7uI8szRKS6UuzcfYQ8vVBkssTk6N4xpVwfcj2ougyg72Qns2UC6RzXZUrBqqM3Q
 dCuYgGwziIYhN91j+xTMqmlf2RcZH7PZeUpTclkWM4Qrm+v3pKHyo58iMfy1MkjIPsm7
 OEKqIltP99gqKqA0azT6KhMds3rWGTo+XbxEPbzPyiJSHc8IFg9UyR/HfzpEM5JrlH4m
 t/C7Xz1JvhwmabCfIn+mJOT1i7OjlDoZPbeWPO2Vl97bE/+qMhk5aAPfX1sfBSLrMdcI
 GuJt/K1g1TT8sHb8x78lZg6R0y5II1rKK0K2fGG6zeXq+nogYJj/4UKNXCva9kI8jio6
 jreQ==
X-Gm-Message-State: APuU4Z+HudWJH4ccDIdfUiq4njL/7vEkD4u6+JhVaft/3XD9BXjJyu1V
 4uD9bT/J/OD3HB66m6OexJlvzC0Uh8xnqy4Awz/yrek8umcne8X0L8kEGym7JLN4I5xuJxQP7aa
 DIClf+nXjFi3uYZG1xubZTTx441gNqf30uXfhiZsT36b42SjKL80IuKjaxuo4KvNUNw==
X-Gm-Gg: AYBFou2z+IQxYGMG1HccizaSg6aKw2pPSiKjuXQJpXRIcZO+PhP55vnzl4pd7dlE+6G
 t3JaKGwQdNUCJ8X6scQ35JM/xLvvZoAYRk4jrheYA3K1sh1dHaVsX7pHHhDUwsB6INmXPFaGSJJ
 2psWd4fRDn1VVTKivF/lmfkfWb9X51Vmi7/qmOOqo4yDJ+SCalYaalqL8vphPB31gCoWcDQph43
 tUiqESSSI6JhVLHacmCoHxyScp/wBrJkhxnCvo6tkhCad6rwRX14OQ/sB9GMTE7QHgTr/BnUGDp
 uNyljT45WA8+rueLnsuFin2OgSBDFfWgLzSWkJlfEo6DxZosCxJLubIcZDvsTBVMmSTecSQHqbH
 dzTw7RRFI3nJl0/YyM5K3AtVsDlrLDu9NxAwrgLBlDoTtqGDCZQ9HUGrI+PKCPvJRCRN7iNw4hy
 pdwjIXVdxXeAmN3s/BszdJ
X-Received: by 2002:a05:693c:6384:10b0:370:121a:b2f with SMTP id
 5a478bee46e88-3751fb3225dmr1691340eec.11.1794278954349; 
 Mon, 09 Nov 2026 18:49:14 -0800 (PST)
X-Received: by 2002:a05:693c:6384:10b0:370:121a:b2f with SMTP id
 5a478bee46e88-3751fb3225dmr1691308eec.11.1794278953822; 
 Mon, 09 Nov 2026 18:49:13 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e9d78sm2700263eec.25.2026.11.09.18.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:49:13 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 00/11] hex queue
Date: Mon,  9 Nov 2026 18:48:50 -0800
Message-Id: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfX3cmMED/c9vt/
 bdLZcVptmcHNbOG4+7/B2oP61KmHnUg1BExm8J0tWaIR/Yxf46zKH4H8z1RfsxZfgG6GvMPaaGJ
 Nc78Kob+gkGBONymt7oXb9hiIaMapo9I54kZGfUcHiIppWXYR24A8HYtSI16SW6MxIpEbCkz7sJ
 hoafJwDubuBtz1nQ6UgaRjErcIYodMK4+QythUxYV0aBPjS3cxka3r3/nEMj///hJLB4hkqgc3r
 bXU1mEnxNKa9mIk/tVypCxTXFZO9WYypTqBbV1NYOmUHZdEtLVFSRXjXBkwc/J94X7sLsgxntHm
 I4Ei51yVr1UUFcsd+deRWU9vOeinEhFI5uw52efD61lOvUXGifKwf2bkNNB3P9Q/sFf6Qsx6Acs
 5yT51leu0VmQnbQaVjAjVJThGzuuOOEM7vlO1TIPU+4DH70jXBSPU1AkHJqm+uvVJzZWXTyyMb9
 VOzCsNMeI7Y26JWfbJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfX4gDSPeppCNzi
 rRvAUQT/eIasD0Y2CbGei5mTptaE5huB35lFh3mx31j/nG/7KJl/cXAcgLkC1SdWIubaNUMaJXt
 NsMp+GjETn4rtNPSqhqvazgmK/EBXWg=
X-Proofpoint-ORIG-GUID: 8qeOMjyjhsuDvrmpsxd-kyVKCXoLsfVB
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af2862b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=-AnQz9JOAAAA:8 a=NEAV23lmAAAA:8 a=lSHz92EuOSR2_9jI2yIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=3bnadFWGKyIZm4bBUiDd:22
X-Proofpoint-GUID: 8qeOMjyjhsuDvrmpsxd-kyVKCXoLsfVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100010
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA3MjM2MjJiZWRiMGI0MjNkZTdkMWM2
MWViYmU2ZTdhNzE5MzQ5NDljOgoKICBNZXJnZSB0YWcgJ2Zvci11cHN0cmVhbScgb2YgaHR0cHM6
Ly9yZXBvLm9yLmN6L3FlbXUva2V2aW4gaW50byBzdGFnaW5nICgyMDI2LTExLTA5IDExOjU4OjA3
IC0wODAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBz
Oi8vZ2l0aHViLmNvbS9xdWFsY29tbS9xZW11IHRhZ3MvcHVsbC1oZXgtMjAyNjExMDkKCmZvciB5
b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBhMzhlYTkxY2FkMGZjMzEwOTRjZjBjOGJmZGM4OTQz
ZTAyNGIzYzg4OgoKICBody9oZXhhZ29uOiBmaXggRkRUIGFkZHJlc3MgYW5kIHNpemUgY2VsbHMg
KDIwMjYtMTEtMDkgMTg6NDU6MzIgLTA4MDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkhleGFnb246IGZpeCB2aXJ0LCBt
dHRjZywgZG9jcwoKRml4ZXMgZm9yOgoqIGRvYyB1cGRhdGVzIGZvciAxMS4yCiogdmlydCBtYWNo
aW5lIC1iaW9zLCBGRFQKKiB2bXJ0ZSwgZ3Vlc3QgQkFEVkEKKiBUTEIgbG9ja2luZwoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpCcmlhbiBDYWluICg4KToKICAgICAgZG9jcy9zeXN0ZW0vaGV4YWdvbjogZGVzY3JpYmUgbWFj
aGluZSBtb2RlbHMgYW5kIG1lbW9yeSBtYXBzCiAgICAgIGRvY3Mvc3lzdGVtL2hleGFnb246IHVw
ZGF0ZSB0aGUgb3ZlcnZpZXcgYW5kIGVtdWxhdGlvbiBsaW1pdHMKICAgICAgZG9jcy9zeXN0ZW0v
aGV4YWdvbjogZG9jdW1lbnQgYm9vdCBpbnRlcmZhY2VzCiAgICAgIGRvY3Mvc3lzdGVtL2hleGFn
b246IGRvY3VtZW50IFNESyBzZW1paG9zdGluZyB3b3JrbG9hZHMKICAgICAgZG9jcy9zeXN0ZW0v
aGV4YWdvbjogZGVzY3JpYmUgaW50ZWdyYXRlZCBmaXJtd2FyZSBPUyBib290IHBhdGhzCiAgICAg
IGh3L2hleGFnb246IHNoYXJlIHRoZSBIZXhhZ29uIFZNIGd1ZXN0IGJvb3QgY29kZQogICAgICBo
dy9oZXhhZ29uL3ZpcnQ6IGZpeCBmaXJtd2FyZSBib290CiAgICAgIGh3L2hleGFnb246IGZpeCBG
RFQgYWRkcmVzcyBhbmQgc2l6ZSBjZWxscwoKTWFyY28gTGllYmVsICgzKToKICAgICAgdGFyZ2V0
L2hleGFnb246IHByZXNlcnZlIGd1ZXN0IGV2ZW50IGZhdWx0IGFuZCBDRkkgc3RhdGUKICAgICAg
dGFyZ2V0L2hleGFnb246IHNlcmlhbGl6ZSBUTEIgaW52YWxpZGF0aW9uIGFuZCBJTUFTSyBhY2Nl
c3MKICAgICAgdGFyZ2V0L2hleGFnb246IGxlYXZlIHN0YWNrIGV4Y2hhbmdlIHRvIHZpcnR1YWwg
U1BTV0FQCgogZG9jcy9zeXN0ZW0vaGV4YWdvbi9ib290LnJzdCAgICAgICAgICAgICAgfCAxMDAg
KysrKysrKysrKysrKysrKysKIGRvY3Mvc3lzdGVtL2hleGFnb24vY2RzcC5yc3QgICAgICAgICAg
ICAgIHwgIDQxICsrKystLS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCAgICAg
ICAgIHwgIDE4ICsrKwogZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5yc3QgICAgICAgICAg
fCAgMzggKysrKysrKwogZG9jcy9zeXN0ZW0vaGV4YWdvbi9vcGVyYXRpbmctc3lzdGVtcy5yc3Qg
fCAgNDggKysrKysrKysKIGRvY3Mvc3lzdGVtL2hleGFnb24vc2RrLXByb2dyYW1zLnJzdCAgICAg
IHwgMTU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4
YWdvbi5yc3QgICAgICAgICAgICB8ICA1OCArKysrKysrLS0tCiBpbmNsdWRlL2h3L2hleGFnb24v
aGV4LWJvYXJkLmggICAgICAgICAgICB8ICAzNiArKysrKysKIGh3L2hleGFnb24vaGV4LWJvYXJk
LmMgICAgICAgICAgICAgICAgICAgIHwgMTUzICsrKysrKysrKysrKysrKysrKysrKysrKy0KIGh3
L2hleGFnb24vaGV4YWdvbl90bGIuYyAgICAgICAgICAgICAgICAgIHwgICAxICsKIGh3L2hleGFn
b24vcWNvbV9kc3AuYyAgICAgICAgICAgICAgICAgICAgIHwgMTc4ICsrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogaHcvaGV4YWdvbi92aXJ0LmMgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNjggKysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAg
ICAgICB8ICAxNyArLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5jICAgICAgICAgICAgICAgICAg
IHwgIDEyICstCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICB8ICAg
NCArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICB8ICAxNiArKy0K
IHRlc3RzL3F0ZXN0L2Jvb3Qtc2VyaWFsLXRlc3QuYyAgICAgICAgICAgIHwgICA1ICstCiAxNyBm
aWxlcyBjaGFuZ2VkLCA3MDIgaW5zZXJ0aW9ucygrKSwgMjQ2IGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRvY3Mvc3lzdGVtL2hleGFnb24vYm9vdC5yc3QKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkb2NzL3N5c3RlbS9oZXhhZ29uL21hY2hpbmVzLnJzdAogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRvY3Mvc3lzdGVtL2hleGFnb24vb3BlcmF0aW5nLXN5c3RlbXMucnN0CiBjcmVhdGUgbW9kZSAx
MDA2NDQgZG9jcy9zeXN0ZW0vaGV4YWdvbi9zZGstcHJvZ3JhbXMucnN0Cg==

