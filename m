Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B7B10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYQ4-0003yN-Eu; Wed, 08 Apr 2026 15:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXtQ-0002js-6E
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKPE-0005b6-IG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M6NO32450585
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iJlxVqc9a+esaq2TZh1GcmabM5YIXyFJZCSgwVwtsTU=; b=l87NV24KOPSSQAW1
 v4cNysAhCR0IQJwe+HgB44BSshx99OMuXhOWhpG/gbAdSfgw6di6xVEpd5+fkjMn
 VSgEuE1YQGK/TF6h2bZP+FaZVc38dTEa/9AngM+Popyh/jtaFcoeZQ16M/Hokyr7
 le8841XwqFqUnavO40tINTbuFyDskBTkypNYcM+GvfL5BPG4WFF0m6zGsrmpi8Nl
 qAml5pPuPFyskQIzvKjEwapduX9NkKPeCrVdkbJhSHuealsmETCVYkq79AP2VnPZ
 9uX7RelUB5dBLiDpAb0OJpvIHLgDnXerZ0Gh8RerzOhflCmQQWs/2pfpm7ExiWII
 9KhcIw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae68wmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:25 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12bfa367189so34583531c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622024; x=1776226824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJlxVqc9a+esaq2TZh1GcmabM5YIXyFJZCSgwVwtsTU=;
 b=ZCtlaK5tXn7iFg0Bxlf893Fbz/wheGB9n5MeAPQFQTCkK3KDmyZrbtss98rYRn25qc
 Ag3PZZfYrgBvHdi52ApsP/ggLwrMBU7585yBf9JTtHh6XP4uYBRYXikM+fe6HZX+Md75
 +/84cJHSO0vn6HCfW+s3vjyHwqfrRhUeYXyCk6W/68bX6Vh6ddwKCqoqDEA7DFYNF9p4
 Tvz3FcVSTTZahjV+S6KmAyPqD33nuFUIY+w4CNv7bnNxFsU01IS7oZGmjvGD0UBAqGsJ
 89ZH2Wntz7VGf0eekX+4YAQh7KCApJvEO+cOkLDefcAiCFb0jghXuUQDKAQ4EFIJZAnQ
 TCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622024; x=1776226824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iJlxVqc9a+esaq2TZh1GcmabM5YIXyFJZCSgwVwtsTU=;
 b=RpYbtaAfnAV19cYxa1daNUBbd7heaT8xhH7ONqsL+m4CC06uzn6a2ToVF7r9/ktssS
 l2a1MqVf2xbj9+viK+0wSgWdn/E8p7jx/8zWTxVYQQaMseNDvRwxF79jWSC8EntdtZwi
 TgN/ThZrD0Rnw9/Hcu8sv1JraKc6dw8bpMr55nCQ3AjWxyzvsVbOqjnEn06feDFy4o7e
 AHmPIDL1f1BAmFk/SrXf/sED0Mwn1zm5FZfjQ8lnZrAHPU+R3wghsyEbmTxa0pQ8v3CC
 /Pyw8yoId+9nZTum6tLiYiCIgUc6jJUrQQEmA7adzIADypDKuBxlIjgK2wZKVjYfOBGz
 SpQw==
X-Gm-Message-State: AOJu0Ywtj2WT9W9P+iX3WWaDCNBgzMexg7j72pHooCzbsxlmVffb5cSq
 /SOECeJxiNA70IhXvzybzEh7qW071D+hfNi40bEaW4jIRNmzFnAsZqnSZhZt/xw9vD4XXrE1Wmg
 fM3rgMFEk45Csao339hjeM5jVA8iiCJZL27exAlutPv4CUPmuNFu+0udwE2iiG+WcVg==
X-Gm-Gg: AeBDievFqUfAAkCL/GykP0uKruETvitKrOdSLqzB+7lZIO6GxEjxtsOrSPAA4S6D0Fh
 HKm3ItBNJQZpiImn6qcFtVR2uGsgnanXsThSpyDbNxZZe1/oCVpz1dV+2KhPquWO/lLyzGvbUWE
 bSnTcDQ2OzGaSB0D/FET7rdA6n8prGWOl9gbIKsvMo6VJiXJ5ZNokvhouvCz83mr75yLiCndpM9
 KuPxwbRbjUoaUVsZtgAm+N67Cb1DqokCXnJjtDVlF/d5JrzacHnxzJernlwS+HHmwO+OzdmLnsF
 KdZfj0GSau9L+ZbYHg5yxcQWrONiXiHqe+cJztyoLXHAIkNQuxThVSchcUJwS1mEUjt1iwADI2X
 rXfut98/9vWUjQ2Fvv+nI2K8v+JbuLW+HbVX67TyYFLYiU5hjw4FH2lTpU7yz2Lg4wvnOKw==
X-Received: by 2002:a05:7022:fe04:b0:11a:641f:ba11 with SMTP id
 a92af1059eb24-12bfb7601ffmr11058321c88.29.1775622024438; 
 Tue, 07 Apr 2026 21:20:24 -0700 (PDT)
X-Received: by 2002:a05:7022:fe04:b0:11a:641f:ba11 with SMTP id
 a92af1059eb24-12bfb7601ffmr11058298c88.29.1775622023877; 
 Tue, 07 Apr 2026 21:20:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 16/28] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Tue,  7 Apr 2026 21:19:41 -0700
Message-Id: <20260408041953.1899532-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX04iJ5kFmLmh1
 hkhBVufMyB+qsuNtu/OJe6GIqsY++98cRJWPbnfLaIbyiviMS+qbxucM4t1IcThvGNXalf+RhhB
 IFQNanFl/jrrm0e/fKWXe+2oXREc+pYtFrVSAtByNep0BWPXUtTtuMCMpUzkaJPEjR7dZeklP/U
 I0dk6cCmxsVWo+4wTbGCKMEyhqAH5MtIcKs1tBh8PnS7947N0zhJhbOYqPHG+uZR8QaNAOuemTt
 O9V3QV9m2/7qDbmQaj8G+YcSDe0YCBmqIhsd9eMS5WJKGSkXhUq73uTAmiaJVJAjGfvHraBh+94
 VxWgafXy989/jtMSqj8WMm5VapTNEqp7VYW5L7Hp3M1Xo9Ah8XDBf2pcwH6fF8CbOdcukkApfI3
 wdS6g3CWevsPBgEUWTXcT7GgxKJiOfmXHd8dwfzno3PVN1lnfYthMxpYfoELu44XicDQ1ve8JLs
 3bjHgT2Ng0lp/3QXIPw==
X-Proofpoint-GUID: EJKSeXV6XraUGmbqf2JHAJVABVtU0WV3
X-Proofpoint-ORIG-GUID: EJKSeXV6XraUGmbqf2JHAJVABVtU0WV3
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d5d789 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAwOThhMzkxOGM5NC4uZDEzMGEwMmY1ZDUgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC0yMCw2ICsyMCw3IEBACiAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiCiAjaW5jbHVkZSAi
Y3B1LmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKyNpbmNsdWRlICJleGVjL2NwdXRsYi5oIgog
I2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRpb24tYmxvY2suaCIKICNpbmNsdWRlICJxYXBpL2Vycm9y
LmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKQEAgLTM3LDYgKzM4LDcg
QEAKICNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4t
bG9vcC5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiaGV4c3dpLmgi
CiAjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjaW5jbHVkZSAiZXhlYy90YXJnZXRf
cGFnZS5oIgogI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCIKQEAgLTQ5
OSw2ICs1MDEsMjQgQEAgc3RhdGljIHZvaWQgZmluZF9xZW11X3N1YnBhZ2UodmFkZHIgKmFkZHIs
IGh3YWRkciAqcGh5cywgdWludDY0X3QgcGFnZV9zaXplKQogICAgICpwaHlzICs9IG9mZnNldDsK
IH0KIAorc3RhdGljIGh3YWRkciBoZXhhZ29uX2NwdV9nZXRfcGh5c19wYWdlX2RlYnVnKENQVVN0
YXRlICpjcywgdmFkZHIgYWRkcikKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9l
bnYoY3MpOworICAgIGh3YWRkciBwaHlzX2FkZHI7CisgICAgaW50IHByb3Q7CisgICAgdWludDY0
X3QgcGFnZV9zaXplID0gMDsKKyAgICBpbnQzMl90IGV4Y3AgPSAwOworICAgIGludCBtbXVfaWR4
ID0gTU1VX0tFUk5FTF9JRFg7CisKKyAgICBpZiAoZ2V0X3BoeXNpY2FsX2FkZHJlc3MoZW52LCAm
cGh5c19hZGRyLCAmcHJvdCwgJnBhZ2Vfc2l6ZSwgJmV4Y3AsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGFkZHIsIDAsIG1tdV9pZHgpKSB7CisgICAgICAgIGZpbmRfcWVtdV9zdWJwYWdl
KCZhZGRyLCAmcGh5c19hZGRyLCBwYWdlX3NpemUpOworICAgICAgICByZXR1cm4gcGh5c19hZGRy
OworICAgIH0KKworICAgIHJldHVybiAtMTsKK30KKwogCiAjZGVmaW5lIElOVkFMSURfQkFEVkEg
MHhiYWRhYmFkYQogCkBAIC02MDYsNiArNjI2LDEzIEBAIHN0YXRpYyBib29sIGhleGFnb25fdGxi
X2ZpbGwoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBpbnQgc2l6ZSwKICAgICBkb19yYWlz
ZV9leGNlcHRpb24oZW52LCBjcy0+ZXhjZXB0aW9uX2luZGV4LCBlbnYtPmdwcltIRVhfUkVHX1BD
XSwgcmV0YWRkcik7CiB9CiAKKyNpbmNsdWRlICJody9jb3JlL3N5c2VtdS1jcHUtb3BzLmgiCisK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgU3lzZW11Q1BVT3BzIGhleGFnb25fc3lzZW11X29wcyA9IHsK
KyAgICAuaGFzX3dvcmsgPSBoZXhhZ29uX2NwdV9oYXNfd29yaywKKyAgICAuZ2V0X3BoeXNfcGFn
ZV9kZWJ1ZyA9IGhleGFnb25fY3B1X2dldF9waHlzX3BhZ2VfZGVidWcsCit9OworCiBzdGF0aWMg
Ym9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1
cHRfcmVxdWVzdCkKIHsKICAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOwpA
QCAtNjQ4LDYgKzY3NSw4IEBAIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3Bz
ID0gewogICAgIC5wb2ludGVyX3dyYXAgPSBoZXhhZ29uX3BvaW50ZXJfd3JhcCwKICAgICAuY3B1
X2V4ZWNfcmVzZXQgPSBjcHVfcmVzZXQsCiAgICAgLnRsYl9maWxsID0gaGV4YWdvbl90bGJfZmls
bCwKKyAgICAuY3B1X2V4ZWNfaGFsdCA9IGhleGFnb25fY3B1X2hhc193b3JrLAorICAgIC5kb19p
bnRlcnJ1cHQgPSBoZXhhZ29uX2NwdV9kb19pbnRlcnJ1cHQsCiAjZW5kaWYgLyogIUNPTkZJR19V
U0VSX09OTFkgKi8KIH07CiAKQEAgLTY3NSw5ICs3MDQsMTIgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBj
Yy0+Z2RiX2NvcmVfeG1sX2ZpbGUgPSAiaGV4YWdvbi1jb3JlLnhtbCI7CiAgICAgY2MtPmRpc2Fz
X3NldF9pbmZvID0gaGV4YWdvbl9jcHVfZGlzYXNfc2V0X2luZm87CiAjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKKyAgICBjYy0+c3lzZW11X29wcyA9ICZoZXhhZ29uX3N5c2VtdV9vcHM7CiAgICAg
ZGMtPnZtc2QgPSAmdm1zdGF0ZV9oZXhhZ29uX2NwdTsKICNlbmRpZgorI2lmZGVmIENPTkZJR19U
Q0cKICAgICBjYy0+dGNnX29wcyA9ICZoZXhhZ29uX3RjZ19vcHM7CisjZW5kaWYKIH0KIAogI2Rl
ZmluZSBERUZJTkVfQ1BVKHR5cGVfbmFtZSwgaW5pdGZuKSAgICAgIFwKLS0gCjIuMzQuMQoK

