Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63B606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pMGbcflC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jd8uF543
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvo2-000707-Hx; Tue, 24 Nov 2026 14:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnf-0006o9-Jc
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnb-0006hp-Nh
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:29 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIY8Wh1651329
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=; b=pMGbcflCgVWNJtm3
 5jOzJDuVwKJEq9mI7BKunUQzpwZN51Xc8Kg38BbxSFug65l6iI2cR7iW/tlm1Hxc
 2AKgaGyVkGPIvOAmMjkhVPNyRYxvKSeIcXAlk6XJG49A2eoMMFnAvsujyRsNy7DC
 HAgzyYtXZ2JpXU4YMh7UngFjibYgvlnPS4SvzDhlYU0aZuwdJle151E6Zu72zfXu
 jl/SSpuUt0pDGi3mwrwIKpmBjmiAuFhlURKgRE2OjNuUhmnxzBdAVvgKtHfloSag
 0IkLn919m6t7JOfitAlKIy2LxK6E9H6Ueam08GJvr4feG6Syt90MIjJYvL4lONwB
 Vq+01Q==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rpkhwb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:26 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4f8281066c4so5858807b6e.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547006; x=1796151806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=;
 b=jd8uF543/eHr/UVcK6qDRdEaGPTC2duuN6UcwEn+24I2YRK7/h7EuukuylwUJ+FKea
 d4shrY8jNeGSFFD/JWXgZ6UU1Gi3EAf6P1JUC1JPLyKS6m1jkZIXtK/G94fuLrmHSxxT
 j1rrC1MaOGtsw0yBeYAfnYcYJoJY9W20LYh7tDPhzE8xGdKh+HyHkzByjj+ln8ndwYrQ
 9i8kly3N8z0jWmu+9/OJTTws37xIHsppP9aejUMfFRu0vBZ9DDFcmvh0WBiCPRQnV/tG
 zqWpLJXtGEEfPySyK2Ef5Yj6mCZPS/wYN37s9emIyRD/JSWU/84A2P9DBdItaEJUGEED
 CVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547006; x=1796151806;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=;
 b=KMXmPbhzyQpAxbCDJa986xG4YV7RNufdg4bqi/y2w36pYHChBZr68jRL2uZbGAo5tL
 U/JJSXAxPREXmtZIfoFjPSiuVFuwZPQD1pcFWEFRfRXEaQIKVwKwcyQ8JSZbw+MPBRG4
 gvGrXR/L6pj3/79hsbsSFHpAMwMkB1OIY9YL07RNTsU2DCDMrD1FCUOxMiEYt/8PrLe5
 2dY4z01+3Z5yJaIHMKHu3Ou5uBfyoSYC7gJ0WK1yHHiBQLjsjR9ulk7lyOby1jZf2Cqc
 +jCDGTGIJI4GAxRguuV5o04GHZsXbXoOuyhnuSVabGorsOyAUeu9RDIzirnJnQDpp2Y/
 kdlg==
X-Gm-Message-State: APuU4Z+G06ofg7H1R4GrGHRsSSIV4PCCpDPZ3t4fVkxZee1rEwDHewvZ
 sRQAb2IlhvrAKA7i3FXOzrjh4BfjInC6qNoe1xdTKhZMU07u5JEoWZJvxrCJ0NvmLzA7om/NEMj
 K94DNpNbPE8ODwBvP+TwJhRsjPLr2jEfT+2FJq2rrbP1aqNlqlAUObez1bAkL+tKp0A==
X-Gm-Gg: AZFdTZdRooNCy+oF6UXAalwRCCtPUPwplj8CTy13ivLbxw2EVUegUSk9moAcnlcc/IM
 fSVIGqDvRc2SbRdSTzzf24tIigixyadnRZ6eP4b63PI1vYcVWoH/BjtPFfEj+ET7iqbqBj+VLt4
 rlB1JL462ksW2OURuwRwBEhukm9KNCO4NlXEPCluk7rVy6lPhbEiWegh95Q2i9ymLY3iYK6UZE1
 t2SVeTL0EkigihC/6Mtav0hEooJYyYj4o6C5R9lp5ulkFULENALQLXcwl3oZS9OJF8I7s3KomzK
 /aHuyUVm9PHLgivGla1no6MtyVSh0qsobxpJJEaDc0PHvn5W9I2PsxCuzBzNNeyvuoaWEO58tfi
 17BMiDnuL59uFarTnxZLsBiuoVD9mWtcGR9+b7GGAWFqkM35lCEaIRRyAnU4UrUfQcqtTige9kj
 liR9JDWAeFPcWPGLvI1UMyzA==
X-Received: by 2002:a05:6809:755:10b0:57a:e9d5:f41c with SMTP id
 5614622812f47-57ae9d60120mr8928264b6e.53.1795547006042; 
 Tue, 24 Nov 2026 11:03:26 -0800 (PST)
X-Received: by 2002:a05:6809:755:10b0:57a:e9d5:f41c with SMTP id
 5614622812f47-57ae9d60120mr8928224b6e.53.1795547005535; 
 Tue, 24 Nov 2026 11:03:25 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm12343195b6e.1.2026.11.24.11.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:03:24 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v3 5/7] target/hexagon: report the faulting packet
 for stack limit exceptions
Date: Tue, 24 Nov 2026 11:03:12 -0800
Message-Id: <20261124190314.3882017-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX+IHkF7Z5VKgb
 KwTbkuUi84JLmXgKhTZo0n8z3f3RSH7u/fmqV/LWogWCtyjvSzzLbDskJQOll6lqvxD/u+vNdN9
 Rot6U37NQxm2OghZN5FXKxIM6sqCNKdtDlO09mTSJTo1TUwqZkOpMCTDmBYoxTBwRMcd01Ddsev
 0YXMwQhyRL67bMhI137BRiSEp2XdCAppfC73NIT+1TgnllKuEt5/lS/aLNN1e1Yt1Hq163SuVQJ
 iqfRG0JVZSMUeW89vpydcksUpqEFiSzi9kTu+Tk3QJ4pBFGXK+i1D+uXwbCIxB/4Go6Wmt2tnz9
 HK3Sql8rlwKO2cpf3op8e4XbmSjEu93xigJ4wnmp7eXwJ+umjrvVRXt+E/N21UUSdu4mJNf+PLJ
 XdEShanbeX+2qiuWmDsgTuRoKAi/tw/acX91xYlVqEPXl78xuxsofNWMhZez3nxUrZX+0/n8Bn6
 JBb4hZHR6OlFmGbnkew==
X-Proofpoint-GUID: rqAheZqSq76Z4rmPlLb2h2bkmclYILuw
X-Authority-Analysis: v=2.4 cv=MvbHeGae c=1 sm=1 tr=0 ts=6b05df7e cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ctcHP5N1X2NQA3O8W1oA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX91H7gD4QZDkB
 1OuW5JrgvHZRIIOp6dAhlh+04k68aBIKBeE9T+iSoOV8icq0varZld4U8TQ5LnNy/uhauL4MM7V
 MbMrnyZ1spBs01+ebA/5Cpb2e9JORW0=
X-Proofpoint-ORIG-GUID: rqAheZqSq76Z4rmPlLb2h2bkmclYILuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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

