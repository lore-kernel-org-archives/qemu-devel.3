Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B25CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waife-0003vk-3F; Fri, 19 Jun 2026 19:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifc-0003u3-Uv
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifb-0007R0-Bk
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYcBA4086912
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=; b=W59544d3sCXmGygD
 fDZSaRryFYKWSYm25ah27z/aH12133JGNntAJQJmPdcGy+OdSYGw869nxO0iijS5
 59kzgNA1vCry2bl2V5mCUmCfNPZbfvWeCU520Ahyx6EIxX0pJ/6ggfgq+SseQ25N
 r7pI2PeNPXqE/LML8yTxqIFhu0USNwNQGgkskSbhuV0VXcQGOUzHhxT0xKUEnvj0
 u5EAB7ezOcahqsDIx5BpDN4bmvDOvqNimJ32e/DZQ9eCKpnWZNKn2YcnfFslbB5e
 SP5QxB6+ydzTn0BhBbfNuIXFDzQzxZpRsjNgLfmI5MKTPC9cxQvvcHSIW0QPavBs
 dKtNdw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmyrdm9k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bfe262ef0so1143435eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911831; x=1782516631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=hfy9Wpy8CLP2qZ77F+1P/pZp6qAy8GWIBZKe/1gVm8QMY1WDxJxndaxjTycuOFxRC0
 yHbmiU7iThL3KcdndMsO8asIt8yyz4uw/Ta0cIMzT49VSDYQeWqKGSo9V+xkL4kecUoM
 G1y/r/yCeDx/yMQRfoX4L9cBb9SrsiwHGEtgF9B9udPCU5Wf8X9PV7PpDZjtwsgDi0E6
 +MtF7r8bK/5AIKN8LXqkCsJyWmCWjR3UOQW79X+wGnXL+kQeUvRCRUgHiREIi5vBBou5
 US7NRnNKibPeELa04mkeeCMS8biF2beyRBcrv1lj/zCZXM3I+dOdUVvOp5xBJzC9gEBr
 qFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911831; x=1782516631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=GNmn5ktTMFxDNp8ZASAlPwGQYCbikAnO6LudY0W97OspC90mwcgEhvPEQMGNOyVFYY
 DQAGV1F2wzt+tS+yicF3N7tYFRY/kYKiyWzwWMcy+3ksHs697oYrnZKiw4fGEOE6bBpo
 qDDg2ZhbXDlnSBCVkxdgIAymx0+5szFBTZABduuvHQSpMqZILLCP2Fqn7yAXMPm9UGg2
 ew79N1xNDw6yxnnn9rhi84WcAewrGDyK35549reZNrhmIlTtC8fdvbyt+cYUxzlIA2ff
 ATcoaPuDpp4KxNolXAXiEZKU7C4m08tkpKakUBUB/f8s0kr3ircqcMxpt+peqRtAPBNt
 gAJQ==
X-Gm-Message-State: AOJu0Yxu3f3pOp44EmLGzW1Hbwh5usySGCBWps25p3GfsCmlU9RZnwEB
 obo7MlsX/LeVSI3G3X4Ks8rrd4tUHm4RdHbXzWFeWZ/2QZct3Cz4btpYbqChCEgl2bOl/x9pld9
 OWw+ecPNOHMA23izF5wpoNPmvVwofKwY3U5HY5b1T1UujEAGc5hU6+YOrUH81zHvEUA==
X-Gm-Gg: AfdE7ckidjI7YFVtodbPbSYZniRlmNTFSPFRqqI2/Hr+gLqRPF421i8rJImWLWrEZTf
 SAYtMTkQl2ZZV8jj3NvqxL+r8zCr60roLGKFkokp1iAcBQymUs12Q0bRlGbxbU0ZkYbjFGFdaHV
 rCZOvkElC1QxZCQQmylQp8H/AYEA0Imm9mT3QDs7GOJm4d02HhYG3FcVdqjh4UMOr2lkdcpTzVk
 K+JVpzU5fbOw9aaZEdLDn3H+jOYLZYT7JLHr2QXyLbnuAkpIUiMjrEWhbWQwqzeRhNvsZqtpBii
 5xV8CsWv8JS0CVSxmP6kywKeH8TUwxW+7tDtJb91klBKu305bfNz8O/MGxAVI49eePhXo57t3Zf
 HxTW036IDQHWOv6ESIPRBy95OT+Pag6sURvQiUi8ND8PeSv/s69sm1T7f7+M=
X-Received: by 2002:a05:7301:100f:b0:30b:fb88:f059 with SMTP id
 5a478bee46e88-30c079dac1emr2579660eec.15.1781911830775; 
 Fri, 19 Jun 2026 16:30:30 -0700 (PDT)
X-Received: by 2002:a05:7301:100f:b0:30b:fb88:f059 with SMTP id
 5a478bee46e88-30c079dac1emr2579641eec.15.1781911830010; 
 Fri, 19 Jun 2026 16:30:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 52/74] target/hexagon: Add sysemu_ops, cpu_get_phys_page_debug()
Date: Fri, 19 Jun 2026 15:58:49 -0700
Message-Id: <20260619225911.159473-53-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RZWgzVtv c=1 sm=1 tr=0 ts=6a35d117 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iG5Jvm5Q_bWKWGnfzsh21avLAJRVfUaY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXw8X2f7pLgpnk
 /92WnVj8vwRjdhXI/3fW5DRfcld21EtVzBSe+lGjHA4hvY8L/K17PBu/CDjEnLI77neKG1JM4+V
 S/PPULMX8LR6XMeh3qo2b3mP95QF15nRXN2dILRriboz4hY17DjsyEu+BU8mTXdK0yDivomKI75
 BugqNvAx9FC52DTkVPp5MS90/C0PiSGAxmLtLFsODBuuJJHddnfK2zH+3FZ9L3aCncGphBIDkEi
 R9m1w4jEuBK2ZxU6l7KPEmUA7RGUtKhv4AqYhbZnnhhAJSo37s1ISHtmhQOIjHIE60QRS/qX2oS
 xHmk5hjvl/eBZD+RiTvPQwyHqJbs8Ze8MKCfqAit5B2GQQhc4aTDz4P5OZmJn00g+DFrlerUI75
 JTJvd9hAM8wQrMNeGJmZCuCxw5LFfQUavQ02a9AvqYqjC87a6ws/LKvFiL1FEoaDyjW/GQvWXT0
 4pqYYG95ey9q5kSs1wg==
X-Proofpoint-GUID: iG5Jvm5Q_bWKWGnfzsh21avLAJRVfUaY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX/jKt3wlCOjIN
 MCJvcd1bgpyUuKwAksAY8T4TuHQ/FuJWIh7gVVbVc5gyLxiowKsL1t+YGLesalPEhxh++sSpjEK
 ggysWVL0jLZIcT3FHuUVdV8tD+vM7EA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA0ZTVhMjU3NDRhMS4uNjcwNjY4ODA4YTggMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC0yMCw2ICsyMCw3IEBACiAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiCiAjaW5jbHVkZSAi
Y3B1LmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKyNpbmNsdWRlICJleGVjL2NwdXRsYi5oIgog
I2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRpb24tYmxvY2suaCIKICNpbmNsdWRlICJxYXBpL2Vycm9y
LmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKQEAgLTM3LDYgKzM4LDcg
QEAKICNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4t
bG9vcC5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiaGV4c3dpLmgi
CiAjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjaW5jbHVkZSAiZXhlYy9wYWdlLXBy
b3RlY3Rpb24uaCIKICNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCkBAIC01MDQsNiArNTA2
LDI0IEBAIHN0YXRpYyB2b2lkIGZpbmRfcWVtdV9zdWJwYWdlKHZhZGRyICphZGRyLCBod2FkZHIg
KnBoeXMsIHVpbnQ2NF90IHBhZ2Vfc2l6ZSkKICAgICAqcGh5cyArPSBvZmZzZXQ7CiB9CiAKK3N0
YXRpYyBod2FkZHIgaGV4YWdvbl9jcHVfZ2V0X3BoeXNfYWRkcl9kZWJ1ZyhDUFVTdGF0ZSAqY3Ms
IHZhZGRyIGFkZHIpCit7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsK
KyAgICBod2FkZHIgcGh5c19hZGRyOworICAgIGludCBwcm90OworICAgIHVpbnQ2NF90IHBhZ2Vf
c2l6ZSA9IDA7CisgICAgaW50MzJfdCBleGNwID0gMDsKKyAgICBpbnQgbW11X2lkeCA9IE1NVV9L
RVJORUxfSURYOworCisgICAgaWYgKGdldF9waHlzaWNhbF9hZGRyZXNzKGVudiwgJnBoeXNfYWRk
ciwgJnByb3QsICZwYWdlX3NpemUsICZleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhZGRyLCAwLCBtbXVfaWR4KSkgeworICAgICAgICBmaW5kX3FlbXVfc3VicGFnZSgmYWRkciwg
JnBoeXNfYWRkciwgcGFnZV9zaXplKTsKKyAgICAgICAgcmV0dXJuIHBoeXNfYWRkcjsKKyAgICB9
CisKKyAgICByZXR1cm4gLTE7Cit9CisKIAogI2RlZmluZSBJTlZBTElEX0JBRFZBIDB4YmFkYWJh
ZGEKIApAQCAtNjExLDYgKzYzMSwxMyBAQCBzdGF0aWMgYm9vbCBoZXhhZ29uX3RsYl9maWxsKENQ
VVN0YXRlICpjcywgdmFkZHIgYWRkcmVzcywgaW50IHNpemUsCiAgICAgZG9fcmFpc2VfZXhjZXB0
aW9uKGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRleCwgZW52LT5ncHJbSEVYX1JFR19QQ10sIHJldGFk
ZHIpOwogfQogCisjaW5jbHVkZSAiaHcvY29yZS9zeXNlbXUtY3B1LW9wcy5oIgorCitzdGF0aWMg
Y29uc3Qgc3RydWN0IFN5c2VtdUNQVU9wcyBoZXhhZ29uX3N5c2VtdV9vcHMgPSB7CisgICAgLmhh
c193b3JrID0gaGV4YWdvbl9jcHVfaGFzX3dvcmssCisgICAgLmdldF9waHlzX2FkZHJfZGVidWcg
PSBoZXhhZ29uX2NwdV9nZXRfcGh5c19hZGRyX2RlYnVnLAorfTsKKwogc3RhdGljIGJvb2wgaGV4
YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVl
c3QpCiB7CiAgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKQEAgLTY1Myw2
ICs2ODAsOCBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9IHsKICAg
ICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9wb2ludGVyX3dyYXAsCiAgICAgLmNwdV9leGVjX3Jl
c2V0ID0gY3B1X3Jlc2V0LAogICAgIC50bGJfZmlsbCA9IGhleGFnb25fdGxiX2ZpbGwsCisgICAg
LmNwdV9leGVjX2hhbHQgPSBoZXhhZ29uX2NwdV9oYXNfd29yaywKKyAgICAuZG9faW50ZXJydXB0
ID0gaGV4YWdvbl9jcHVfZG9faW50ZXJydXB0LAogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZ
ICovCiB9OwogCkBAIC02ODAsOSArNzA5LDEyIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2Ns
YXNzX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9j
b3JlX3htbF9maWxlID0gImhleGFnb24tY29yZS54bWwiOwogICAgIGNjLT5kaXNhc19zZXRfaW5m
byA9IGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvOwogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
CisgICAgY2MtPnN5c2VtdV9vcHMgPSAmaGV4YWdvbl9zeXNlbXVfb3BzOwogICAgIGRjLT52bXNk
ID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CiAjZW5kaWYKKyNpZmRlZiBDT05GSUdfVENHCiAgICAg
Y2MtPnRjZ19vcHMgPSAmaGV4YWdvbl90Y2dfb3BzOworI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lk
IGhleGFnb25fY3B1X2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAq
ZGF0YSkKLS0gCjIuMzQuMQoK

