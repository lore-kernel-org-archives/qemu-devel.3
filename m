Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9F606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oql72vYH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iAIR/c76
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBax-0000fk-NA; Tue, 20 Oct 2026 11:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBaj-0000dm-Mm
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:17:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBah-0005Nh-T4
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:17:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDA5vX1575223
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=; b=oql72vYHaiiyzQgX
 46p1wAcVeZNeaq1G8/eFoWeZJSj5pbIu8NIM8BAW/jvHHLZ7NY+yO8kU994sxhXC
 EYy3UmJwsAL1HzxfApf0K+H+a1mGz2aRg472w+Fk4FiMLl0J74DvAYM7iQ8wlPDu
 MsvkOsc5bjXQj2fmRPO4M0GIeWVurO9nIP2a2eEIZfZIU7IqHEG985oFq7bc58WX
 4NQyaBjlwgq7Fqo0tNjXgxwVDugwgfwkt33/Hi9pwoNXcJdGHHO0IlPBhDFmHXBJ
 Y5aOB8M2JdMM1oLsoxk8HbOEs5rwQop4EX+qaFP2gGdtvFmG5GM8OmCMsnXiMa0W
 uN4BBA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n33t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2df375fb9b2so32663715ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792509444; x=1793114244; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=;
 b=iAIR/c76CQjvcP+bhyST8bI4bqo6rU07ktJsmQO3M+mH2rER+ubn8kP9LkpgibeuOw
 EQwYKZw/At+sXxQg+K4hjqo+pQeeyi6SxviAMuogSreCFbV2Gu6sCvKju/qlQskWi6W/
 cafRu9sFr17waCEA/7+pj5GF+eZxGfTlJTQ94APuWedR1/DgaDnpzxXT62/IoN65rsPX
 M94pYyIueU3pB2hkZwfM0FpeNn+8L/UNohqydcATkNz7T0wLcXsoGuUmBKHtXytuQIuy
 J0u9dizxhNMtbF0KBSQ9CBWI3ihqxznqMoLsJtC5WmXiH/TcGbXV5l5UkXdBati2keLf
 Ma9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509444; x=1793114244;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=;
 b=VEidAPN5esXD8RU7hxQuLzIdhOZUkHnUYfc7d3OeCtF7QNlJAk6f703zkwfEF004Nu
 uRHlueLwddzA7SaNe4QK/fJCBV1VO8JeNJqzSpz9Hl44/Gq7TOTYybpBjfGb8rxQ1apS
 A5TqGKrM8ZLQlSkNxk9ruB+X6Mn8bKAKg9ifP69vx3zM1ZQiFo/biXMQQEllk47v5y5N
 4GrBTp/6qZhYymEnlocMAXWpZYXJbgOsOx+9NsF84U3WnJX48IaMDo5kYbV4DNDVDq1G
 e4kLALK4+xZFSC//b0EOeK5peM33NUn0QJwb7VTkyz0HpREKblM89MpRoXbkY79sLRve
 BbsA==
X-Gm-Message-State: AFq9FYIiGzZR3FjYtxJ+LAVWEqb5aRQxgM7UQmwxHIhbUFh/q0gVx0HE
 Le50maF2ZJtU+6znywct5MCIHy2igCBU8Q0PETq5gNUs9jpo9kx3AB19ZrlpT0u6SJHbFi7Ilyu
 VScFcwDZ3RzMGche6GDt8eKTzfzvwGyKp7kI+MmD/U1A1oQJg/MNLO5lI210Tn13kNg==
X-Gm-Gg: AYBFou32WFlFVDDdojFiNnsEMbT4g//nQFZagcU8Cl6E93FBCrPdZTKFYg70gsVVIoK
 KPEeoOuqFlM8up97A3xGIs9RYpdRA1fr2E+N8C4CU0hUBRvjOmzWSVwKKNrmT5BT+KAHVV/z3WQ
 NPBP1swpzYRbfVT4wQa3ZpFdOIYlWUnOnXAARkHyGutlKXPkpKhWDsr/9+m2dcEpDm55v9mnc3g
 0Sc7EwejE5lUsFZh7neA9JdpkwuCRyFI7apXsnQfOgHVn6cA0S0y+FbRvPNxLc/dCR0Q1odyyh6
 2vb4h9v96pvyKUY7GqEZlnwRTs2jssT83Ku1BDvh+C3lyCvbtyYUre8BRN41Jr4IfSrPfoHL4V3
 jNYn6T73C7yoruLWK3DLroMGdEpVLkOD628n5OxgRK0OR5Is=
X-Received: by 2002:a17:902:ebc6:b0:2dd:c053:82f1 with SMTP id
 d9443c01a7336-2e9a69f292amr91136615ad.40.1792509444182; 
 Tue, 20 Oct 2026 08:17:24 -0700 (PDT)
X-Received: by 2002:a17:902:ebc6:b0:2dd:c053:82f1 with SMTP id
 d9443c01a7336-2e9a69f292amr91136435ad.40.1792509443679; 
 Tue, 20 Oct 2026 08:17:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b410626sm656815ad.20.2026.10.20.08.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:17:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 1/3] target/hexagon: assert qfloat shift
Date: Tue, 20 Oct 2026 08:17:18 -0700
Message-Id: <20261020151720.728888-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
References: <20261020151720.728888-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: lLP9MUCJpq-_9EmD_VXUlZXBEZRJrHHC
X-Proofpoint-ORIG-GUID: lLP9MUCJpq-_9EmD_VXUlZXBEZRJrHHC
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad78605 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7yAfEa69Y000KskGGPkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfX1rUlV2suM0nm
 ivwb15OAAeTe8/QeEOQ4tYyKdPzQ1il8zzckFw+DuYFKTmmDxmgTJs+8Fp+DUw8uxEQkiBwHnNj
 SP2Pj5yYbvcMw8tYj0d8hwlZt4/tZiexJ9WT1CVRM/XBkjauLkHAehJm+m3tnZkjOHWlKloNrYI
 tzu+NUWgGtdBK5mXIjd764zMtgXoR5Y5XxKwaORo3EtIDvzePyc6ua4/mNi7d4dJTuMiu2Yr/BC
 p5IHB+dSMyqDFiTQNPn7rHAigNqbqPAAuuStXZtihXEUF1yRT5nDGZLpln4MPCLgNAGofNqMCw7
 0R3EN/Fn2uB3kFEg6lsMT9/q3kOwfesxnRDhy3w/wewYJJAI8VEx0gJ76FPool0nTMaMtznWkPp
 07Gz6U5xvjkvYEXrIa2iW0no1KsGn7Na+/nsy7jYemESs0BuarINl306E7DUWvELr0ST1Wbh9PM
 xqVMO6LAEYOeFXf43Kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfX5sAZSMYRbDJd
 NZ7amLgFVkktrXlyv/ULW7LBRcdNTcu3Eei4QS2PdvGe5dY9bC5iYc6s/r41fo2ki7yzEXh6saF
 LEZP7gz32gWUcSiEfEpGaS+99a4C3zc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200060
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

VGhlIG1pZHBvaW50IHJvdW5kaW5nIHRocmVzaG9sZHMgc2hpZnQgYnkgInNoaWZ0IC0gMyIsIHdo
aWNoIENvdmVyaXR5IGZsYWdnZWQKYXMgcG90ZW50aWFsIHVuZGVmaW5lZCBiZWhhdmlvci4KClRo
ZSBsZWdhY3kgYWRkIGFuZCBtdWx0aXBseSBwYXRocyBzZWxlY3QgZXhwIHN1Y2ggdGhhdCB0aGUg
bm9ybWFsaXplZCByZXN1bHQKaXMgYXQgbW9zdCBvbmUgYml0IGFib3ZlIGl0LiBXaXRoIHRoZSBs
YXJnZXN0IGxlZ2FjeSBmcmFjdGlvbiB3aWR0aCBvZiAyMyBiaXRzLApzaGlmdCBpcyBhdCBsZWFz
dCA0MS4gIFdlIGNhbiBzYWZlbHkgYXNzZXJ0IHRoaXMgaGVyZS4KCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FGRUFjQV9XSi1QWUNmaWl1NDR1VFFpRG9jNThfOUt5
M3VFZC05ZzE0blBnRFBUX19nQG1haWwuZ21haWwuY29tLwpGaXhlczogMjYzM2RhMWUxMjdmICgi
dGFyZ2V0L2hleGFnb246IGFkZCB0aGUgUUZsb2F0IGxvZ2ljIikKUmVzb2x2ZXM6IENvdmVyaXR5
IENJRCAxNjg4MjQwClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0
LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jIGIvdGFyZ2V0L2hleGFnb24vbW12
ZWMvaHZ4X3FmbG9hdC5jCmluZGV4IDQxY2M4MjdhYTg3Li4zNDViZGRjZDM2NCAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L21tdmVjL2h2eF9xZmxvYXQuYwpAQCAtNzIxLDYgKzcyMSwxMSBAQCBzdGF0aWMgaW50NjRfdCBs
ZWdhY3lfcm91bmRfbihGbG9hdFBhcnRzNjQgcGFydHMsIGludCBleHAsIGludCBmcmFjLCBpbnQg
YWRqLAogICAgIH0KIAogICAgIGlmIChtaWRwb2ludCkgeworICAgICAgICAvKgorICAgICAgICAg
KiBUaGUgbGVnYWN5IGFkZC9tdWx0aXBseSByZXN1bHQgaXMgYXQgbW9zdCBvbmUgYml0IGFib3Zl
IGV4cCwKKyAgICAgICAgICogbWFraW5nIHNoaWZ0IGF0IGxlYXN0IDQxLgorICAgICAgICAgKi8K
KyAgICAgICAgZ19hc3NlcnQoc2hpZnQgPj0gNDEpOwogICAgICAgICB0aHJlc2hvbGQgPSBVSU5U
NjRfQygzKSA8PCAoc2hpZnQgLSAzKTsKICAgICAgICAgaWYgKGxvdyA8PSB0aHJlc2hvbGQpIHsK
ICAgICAgICAgICAgIHJldHVybiBiYXNlICsgMTsKLS0gCjIuMzQuMQoK

