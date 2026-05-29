Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33162CD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5EL-0005yp-QY; Fri, 29 May 2026 17:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5E6-0005q1-IR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5E4-0000vr-Js
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIdlN7203284
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dVAWAQOUEPCDn6RYUsIoXW4LWB1iufowpmmkRsJbAic=; b=U2JBzgKO/dABO/4O
 wN3H8e4UeJD4C234R32uvtAO7M2zFPUJaAgy5e3bQGtcsa/Q40OSvg5aEjxrAHxd
 f2/dlxUbzPZoVXKn40ECQYl6oYMZBXyMSNVINBx2TKUBjan5eRw+37J08n1eIGU0
 5/O84NI06yTEELet6hY6fDHMMqGLPNbT1uBH5IOiBTo3zlxjtC/74YFzdI6zql7u
 h63HejZ/fec8Z2OtbhImdVsSqSGeSx4OOYKcWZv6jLKJvtcFpTLmvNnCFGyAzavW
 hh0YaWHb0uZzsnjZsC6rqzk2cRJJ6NzrSf8lhOlCx6AJlO34P4UaQzFdOW0jTCEe
 ATzFmg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9c8r6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304f1820babso1365997eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091913; x=1780696713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVAWAQOUEPCDn6RYUsIoXW4LWB1iufowpmmkRsJbAic=;
 b=NfDAvf/wU9a+hs4VRIoJtBOTdL5Np80H73w0aRRxzrfy+DOtgp8Y79zSbuH5VE+3IU
 uFEA1jl4BtkYDj5SGAoEAOFCsx2jst7SSNUbyHwRstPcx29O5armu+TyOcfHd7i+d2rB
 jEvEORKYgCaQz+CMFw/2fOY+g21sgqEL3QqsybWq4XFwlokTjwPv8gELYD7HGyTSkK5M
 HrQeGfk9xfDlZykTmwQi5N+FlJYhHw0e299b4NJAKdzxqtEVNpBfjejDO0O4hEX3b8wP
 sLFdmf0uQEP3xnqT5HPk2txOr1xjv9G6K7oJHczlz/SdghxhNh2zMftBF51yjYk0xgpB
 pENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091913; x=1780696713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dVAWAQOUEPCDn6RYUsIoXW4LWB1iufowpmmkRsJbAic=;
 b=djMWhljrh9qKa/PGSvfZrZXxdqD6Uu1yWTdJ97DZDneUNC5THPR4BwUNe/DPKK5v9T
 GI0H357gtalLKQ2YpumZriAmIpT9m4Nzrb2ugTFUUEaY92nnKj8l0fTMskGraO4JP+zU
 dc2cUphXWDN0pM/ULRqCULfr2Ti/RB1MVM4og+V8pG6vw3guoujyJhDboaBQYHZ++DqE
 vGwVpGygzRowVvtfc9HnWa+DV6xUN29tAWCRcxZx7ojhTLhF1NLmyaWHse1vVYvEvPKi
 lGjdokANpQZPvZRAlsxHrdHuT6FVdY7thUCPLf8REYrcnlT7pOsnmZxeNanWu2fCiHg7
 NJPg==
X-Gm-Message-State: AOJu0YzitEp9G6OyuTmk82/p6nDsa6Cuh00i2ki9GuHXAvweRpOCgVjA
 3l/J9rzxSU0vbogqTMR3lUreuqEzNKB45vZeFFAi01FjLVWfpyhwRzCaNB7OCYRItcPjZaT2nd8
 B5B2/5F56LcArOrkeZzOapzBSytc3eg+UmIHgqCYc8x5pUIUhYfjszuFdvcvqioabbw==
X-Gm-Gg: Acq92OGAt0E6y/pdnWmFO1v1VJYyUYOD5RVD/tnUIGo0Hg14tVe92OiUK9e0LRzESM+
 p/muAE3DsDwVLmlLr+9ejqLBU3TiPPSlSlLMusWS02MtwjczJbcOxWfBladBszh3rlSJN5DtOki
 34kasKWrcC1neYXNq+NYRgcr6wiOkz48b9yPMn97FIdfqfZPrrCUa6d1BaZ4qhtQD/zQFdrrMRZ
 1RDgjLj8P4IFANDv3NnR7HfxhBYZKlw6Y8HQYJTWfvK9LdFdyhTHi+eodO2ftJoiIFxHhgLYXCt
 WMYIaTHcJ81l8GI2CiEQYVXPpqom+lVdvh0Ln+97jELgVnw7fyXSwrgSpveei4K3xEXAwStdfcs
 jHtbqOFOAprVgQ/lIsCBjzWSHof/ghN8QzEFeeKhsm+VChmGWuZpMHy85zx2o0ZBFBkTPgKkFmC
 1RwNdX
X-Received: by 2002:a05:7300:cb13:b0:304:819f:5029 with SMTP id
 5a478bee46e88-304fa4b7178mr785693eec.2.1780091912689; 
 Fri, 29 May 2026 14:58:32 -0700 (PDT)
X-Received: by 2002:a05:7300:cb13:b0:304:819f:5029 with SMTP id
 5a478bee46e88-304fa4b7178mr785680eec.2.1780091912120; 
 Fri, 29 May 2026 14:58:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 16/28] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Fri, 29 May 2026 14:57:54 -0700
Message-Id: <20260529215806.608770-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX5uXUzPVQACaU
 lTBUKiXvFGE5h/rK9J7wHEV9BEACaJC48caGD/87LPhyeTqUfqE7AbgWSLaBkEzf4EuVj+YqqbH
 5AV6CBU6XaCeTVvnEf5vEQr1rWg21paSlFtGbtHV+XHy7nBu010aKnJksmeb7s2qpwhUxXEVE57
 iX4V5z2NDDe4dmyR+pticDcyzmSK5oMRrIuoBZhibPqV0omsg73OmBfDJEmeHJpV7d1jDr0b1Kp
 AuX4UqPyjQfDAY5tGa8ydOzhwDEtsiseccsK9hSepzO5Q8RWkbg98qLm/LWYXpcAl0GIbAasVC3
 UwGAqNxWKqUh/M+Tpa0dgiSNy+GhRywKBgoLle9yIo73jI1hcrkOYhKYbYeZ99yRWK+f8VHimDy
 q0cJrsphdb5Bgh/4eeY/+n88neyXwLDr/vzsN2/c8pVzxkHQFsLduuzoCRfTRxcFwLHRXp4qHev
 U8LpnRod/cx40Vb+E0Q==
X-Proofpoint-ORIG-GUID: rDlzsO8jJwFg1VpmCmbBAGR7Eh-x3LX8
X-Proofpoint-GUID: rDlzsO8jJwFg1VpmCmbBAGR7Eh-x3LX8
X-Authority-Analysis: v=2.4 cv=SKxykuvH c=1 sm=1 tr=0 ts=6a1a0c09 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBhN2YxYTc1YTE2NS4uZDdlNGM4ZGVjYmYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC0yMCw2ICsyMCw3IEBACiAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiCiAjaW5jbHVkZSAi
Y3B1LmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKyNpbmNsdWRlICJleGVjL2NwdXRsYi5oIgog
I2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRpb24tYmxvY2suaCIKICNpbmNsdWRlICJxYXBpL2Vycm9y
LmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKQEAgLTM3LDYgKzM4LDcg
QEAKICNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4t
bG9vcC5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiaGV4c3dpLmgi
CiAjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjaW5jbHVkZSAiZXhlYy90YXJnZXRf
cGFnZS5oIgogI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCIKQEAgLTUw
Myw2ICs1MDUsMjQgQEAgc3RhdGljIHZvaWQgZmluZF9xZW11X3N1YnBhZ2UodmFkZHIgKmFkZHIs
IGh3YWRkciAqcGh5cywgdWludDY0X3QgcGFnZV9zaXplKQogICAgICpwaHlzICs9IG9mZnNldDsK
IH0KIAorc3RhdGljIGh3YWRkciBoZXhhZ29uX2NwdV9nZXRfcGh5c19hZGRyX2RlYnVnKENQVVN0
YXRlICpjcywgdmFkZHIgYWRkcikKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9l
bnYoY3MpOworICAgIGh3YWRkciBwaHlzX2FkZHI7CisgICAgaW50IHByb3Q7CisgICAgdWludDY0
X3QgcGFnZV9zaXplID0gMDsKKyAgICBpbnQzMl90IGV4Y3AgPSAwOworICAgIGludCBtbXVfaWR4
ID0gTU1VX0tFUk5FTF9JRFg7CisKKyAgICBpZiAoZ2V0X3BoeXNpY2FsX2FkZHJlc3MoZW52LCAm
cGh5c19hZGRyLCAmcHJvdCwgJnBhZ2Vfc2l6ZSwgJmV4Y3AsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGFkZHIsIDAsIG1tdV9pZHgpKSB7CisgICAgICAgIGZpbmRfcWVtdV9zdWJwYWdl
KCZhZGRyLCAmcGh5c19hZGRyLCBwYWdlX3NpemUpOworICAgICAgICByZXR1cm4gcGh5c19hZGRy
OworICAgIH0KKworICAgIHJldHVybiAtMTsKK30KKwogCiAjZGVmaW5lIElOVkFMSURfQkFEVkEg
MHhiYWRhYmFkYQogCkBAIC02MTAsNiArNjMwLDEzIEBAIHN0YXRpYyBib29sIGhleGFnb25fdGxi
X2ZpbGwoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBpbnQgc2l6ZSwKICAgICBkb19yYWlz
ZV9leGNlcHRpb24oZW52LCBjcy0+ZXhjZXB0aW9uX2luZGV4LCBlbnYtPmdwcltIRVhfUkVHX1BD
XSwgcmV0YWRkcik7CiB9CiAKKyNpbmNsdWRlICJody9jb3JlL3N5c2VtdS1jcHUtb3BzLmgiCisK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgU3lzZW11Q1BVT3BzIGhleGFnb25fc3lzZW11X29wcyA9IHsK
KyAgICAuaGFzX3dvcmsgPSBoZXhhZ29uX2NwdV9oYXNfd29yaywKKyAgICAuZ2V0X3BoeXNfYWRk
cl9kZWJ1ZyA9IGhleGFnb25fY3B1X2dldF9waHlzX2FkZHJfZGVidWcsCit9OworCiBzdGF0aWMg
Ym9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1
cHRfcmVxdWVzdCkKIHsKICAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOwpA
QCAtNjUyLDYgKzY3OSw4IEBAIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3Bz
ID0gewogICAgIC5wb2ludGVyX3dyYXAgPSBoZXhhZ29uX3BvaW50ZXJfd3JhcCwKICAgICAuY3B1
X2V4ZWNfcmVzZXQgPSBjcHVfcmVzZXQsCiAgICAgLnRsYl9maWxsID0gaGV4YWdvbl90bGJfZmls
bCwKKyAgICAuY3B1X2V4ZWNfaGFsdCA9IGhleGFnb25fY3B1X2hhc193b3JrLAorICAgIC5kb19p
bnRlcnJ1cHQgPSBoZXhhZ29uX2NwdV9kb19pbnRlcnJ1cHQsCiAjZW5kaWYgLyogIUNPTkZJR19V
U0VSX09OTFkgKi8KIH07CiAKQEAgLTY3OSw5ICs3MDgsMTIgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBj
Yy0+Z2RiX2NvcmVfeG1sX2ZpbGUgPSAiaGV4YWdvbi1jb3JlLnhtbCI7CiAgICAgY2MtPmRpc2Fz
X3NldF9pbmZvID0gaGV4YWdvbl9jcHVfZGlzYXNfc2V0X2luZm87CiAjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKKyAgICBjYy0+c3lzZW11X29wcyA9ICZoZXhhZ29uX3N5c2VtdV9vcHM7CiAgICAg
ZGMtPnZtc2QgPSAmdm1zdGF0ZV9oZXhhZ29uX2NwdTsKICNlbmRpZgorI2lmZGVmIENPTkZJR19U
Q0cKICAgICBjYy0+dGNnX29wcyA9ICZoZXhhZ29uX3RjZ19vcHM7CisjZW5kaWYKIH0KIAogc3Rh
dGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3NfYmFzZV9pbml0KE9iamVjdENsYXNzICpjLCBjb25z
dCB2b2lkICpkYXRhKQotLSAKMi4zNC4xCgo=

