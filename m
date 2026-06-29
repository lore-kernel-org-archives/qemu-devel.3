Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7366CC43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3dt-000375-N2; Mon, 29 Jun 2026 00:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dT-0002hK-23
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dH-0000nA-4H
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NJIB1724605
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=; b=NTu8Iz6h6za8JSTK
 kYCmDl4vBA8eyMTrFpv3xhn25nipTOCTeJ4EbT/26gn8D65Lat86FoYrPugZRVg1
 LtEk5E7A4E1PlrkVRBpDASM1Mx6aZjNECgE/iX+T6XbmUMKxDrKHUy+g5bMNQzS+
 U3M4Y++BngnpBMasev4g9J+7tUMmpQVXmv+Lqvaz6u+QApCIpd2cIg1MZ4JYG/o4
 gdwUrGSoEYLIYpujNYOYHcd4NiyNx9H+7QBUSIz/vCWWhAPZEhA6JxOZjb3FCbEl
 oRjLb9BI6knklgf/xk+QujxZmsEgM6OvRflzzBRFgFEVXqpjzhhVAwolvBn7O/vR
 y9vgSA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6mfnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ecfc5dea0so408475eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707402; x=1783312202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=ShRgrWWR7NS7S7V7xql/k9BRhgg5jJqni7QtEbQG0FxXs5cfHATcnTRw5bOpJgiCd2
 BMamcQUW4NooK2XeuDGJSRr+cB9ojhCrRVS9o10uW5dMO3oAB6OzYeHIKlrXH5RJGos5
 aTKxt/ZTAuhUqMFwmeXk4qN3wQopLDhj/GZ8pwZuPauRruB8MNPVUxf9sW6hYMbKGocH
 f6VfCc41yH0waU8EICwCIpnNz8BbrjLa9x4Aq47XJRofFBv9nBJmB9A3CLUoWf7ueAWH
 W5mCF13z6ZN1dhy6psBCwdGZ9GlaydOJr3dBt9jmj1MO2AMI1RMTFdbqe1jLVROAucN6
 WZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707402; x=1783312202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=iOGcI8EZ+er0Ek4ZYHJRYABHa5/jwqhFO3szuwGCbtPdzRV8qQxl0QAD7cHxW4fWrx
 /fupFNtdPRGxkOZnoOK/+8Yd93j8hC4sNn24scpQBKNaZxrZwaoOCFSuJDGVmJApLDUN
 VcC+XWAFQYEIeRU3nk7OkcKggJdpyRBGqzvl7DFEOEehp/AydmHAwqgaPKX4mlZ5paz/
 afUU52n6ijdZhDE+L2v/2Th9lashXVEDeDuGuw/GI9JT1Qxar3PUfBHWkoMfparCyKhf
 L2SDdtacPKVepP0mDNF3CFnpUMunISAEe+o8vOvIvIY+22d+odba9fUs01qe+Y0UnUWI
 NZqA==
X-Gm-Message-State: AOJu0YwP94Grul99j1br+Dpw61FOVPiDyU2WkE8PckDGEgrGQ5vn7vVm
 Ymz/xj/NQrN62q9QfGDaWhM2Zn81BeSdTilaxCnU2LH2I2358oIb4CaowFp8QJPa6g9k4K2ovhz
 To0lWmhvwA6jVTecUNPaV64Y5SS7TAYOj1fSymu8hsA2jpDs42Qgdi0JwHnFGCwagmQ==
X-Gm-Gg: AfdE7ck4bgLmp6wsHDwG335m9ahdIhpuslHPl4Ynz09cxLBdjTzeWwFrrVwgGH3eP38
 rJ6aTi8u0Thg066kPtg9xnR9qCizeIQ64YqRkdwPElG9zE8fFDc8YD+sQvqtd2nM2OQOYP4qF9t
 /Wi+NNfX5behyr0nZk5+Y9hhf7T/pCYGpN61fRg6mNgyIqJtQZbPXyFqZWSz7WZZzD7jBTADKYb
 CHRJMR8X5qr3r1IeIArmxqjUMb61yYixEQkpLcxPm/4uKyiGHwNfibgXs8f/0IdgGHCA12IsBW+
 hO8KjBjTu+/MuEWXCNBgZJGvC2hpza9rtRwj8Iy54zOCgkDWHqDDClqsHvv1fqhgkyEIyN1ASaV
 UoC9Bp3lYeH8laV+vZWVL6dgb6UXOkmMvKX6/RA7iMWTtK0LVy+Yrx4+mt1M=
X-Received: by 2002:a05:7300:7b89:b0:30b:d748:e7f9 with SMTP id
 5a478bee46e88-30c84bb521fmr14835010eec.10.1782707401399; 
 Sun, 28 Jun 2026 21:30:01 -0700 (PDT)
X-Received: by 2002:a05:7300:7b89:b0:30b:d748:e7f9 with SMTP id
 5a478bee46e88-30c84bb521fmr14834985eec.10.1782707400786; 
 Sun, 28 Jun 2026 21:30:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 56/77] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Sun, 28 Jun 2026 20:58:09 -0700
Message-Id: <20260629035830.1520296-57-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: it1VvmKuX6cx0Smk6e_OVjoL0VaqldrB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX6dRDMkOmr+Ck
 AxJlSWUzs1+jjh+C7IeYR7yBDT64SylQKHGPMpaluykvQgoDHbYJG6TNRPy34RRlTSmuS9YZJgD
 MHCbjLaxQrcYZBU3WIrUu+RUZFhvnp4=
X-Proofpoint-GUID: it1VvmKuX6cx0Smk6e_OVjoL0VaqldrB
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a41f4ca cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXyRLiEUuagcUI
 nWnqxV2uD5/1pRp7bEBR05Wth5EB0pApiC50DEYvzN2+K85NCH8bWTRkQIShwWzoiwBbSz1U/PS
 1EfXeA2pAhHcEyOeevn49ziCHIMZH77vyZjGgm3bnt9SgaX52uGPzQ1GsFVGSdCjI16X5Rxapga
 b7uwYuT6hRczkSp1/3974UhG4rgxRZgvAXng0M4xL+FFsLXHPXOXSPbK6FlepcJRxrfcj6X9TYJ
 /yBAAPQj6TV9RiuOU5jc3YM7qE0BjbtAwB2FbeMgtDaKn0D+aPy2WdFdpEbh65YEaWBkYTmVxNQ
 pAF2vnyu70Rn1/8h/6QEzhOU6nFjyNNky1P346bfTagUEaBaO1eVm7MDSAfJ1bkZAA2ya+S18mv
 emSrd5iv/dk+vTi/1gfmHdRy2oYV7zmT17QlAL1pMEyBmbqi6vCxDtnuzvb+FILQoh3H/YRcZrZ
 Mwk7jq9YyfONrO1YyxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

