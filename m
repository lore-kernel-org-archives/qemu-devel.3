Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4F9CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY38-00020H-Bw; Thu, 11 Jun 2026 01:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2o-0001cv-HI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2m-0002gW-Lm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GF8O3724582
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9y43Ijyr8SBPo2qfPyaLoLkd8A6vsacX8q4a4O/jnyQ=; b=VTZkoADCNInTLRAX
 X7tk7r68c76NpAEm5zsm7ddoUzARuEhqUa4uhvu3s/JLHSvp/KuGq7dDIWUDrIIp
 b1sL12AFwzfeKmJQywZSMC3Q4Bj4mG1kpCh+r4jb1n1//7YR6jeXb4Ldx5uqZ5Jt
 aXJPzVPXq1UeDyls7P7Obq4ifqduGyD2mciaW7GQqCemR/N2roXHWrZKerqhRDDH
 AN7BaNGijsbf6zHd/XweVsW/0Q0bcklvrtdXzcPt3FXXYncZmDpj7PuXPEKsz67R
 KJmi8PaNrXs6IF/CptfLrOhCpW1yHc4VJ3Rf2mMPY6ieU4rIsCo3on4VUTdniwAz
 W+FoNg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9qtt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30761ab3483so6234599eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156001; x=1781760801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9y43Ijyr8SBPo2qfPyaLoLkd8A6vsacX8q4a4O/jnyQ=;
 b=OAuqOP+V+4Ww6T37L87A57Qnv4a21i4JT7orNcNEeoRCZR/5kSs0fnDXZcZ6ntDIBc
 CL4EULJKUUeRYjpIYr0riIVsVEglwqJoziuchheJWICr6uGFTNyjdMMuq816Nl//rj25
 N5bh9c4PENqoTu/oY9TM7GGzcgvbb4q4wo0X4nZuhm1b9LMWgi3vnDc2iyrYAvaJhoCY
 5VMHZcKH4SYn+hQOiSa3wZECPiwMD1gFNTny1BWKf2Cg1Vz7W5I8gyWMSr1Qrfa6cXPU
 BUimWqW0gsY442IGmIE++ayOHT+BdSavd0JPhRZsuZQM7c7xjcIn36YIWjErM73fBr71
 Fugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156001; x=1781760801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9y43Ijyr8SBPo2qfPyaLoLkd8A6vsacX8q4a4O/jnyQ=;
 b=lDS7UlOFGeByDEXvyDCdzBbI8+WUjprTtHglNjqq6KCXmTDRLyZ2HyjmIscpN//0k2
 6EXyw+lGLcvHJnnFYVRiL10FgWGpGOnO05yZ2ABXv5dtSCuEwcM/nh6PioCc62FgqWnd
 sjEWUaTLdb8uRkSW862pY3t8UF/PJYelKdrJQ+prTfc3ilJzFVBOV7zcNb82Hyo26E7Z
 Z6iXcG1LrgqJDZX7lGNo9A4bdgVHWCteXHFP+5piEEreGvnjGvW+nr8zCmRSoMAtPxEf
 m0/NPvQHVQ6Lntvox0rolLltb8g+trF5Mxf3AJGPC6bP+UAT3AvxpkIaj4jRYOwvTOz9
 hNgg==
X-Gm-Message-State: AOJu0Yy1Rng2CAiaIy0IknljJXYu0eLLUnc3g4cDmcejJwP5RRzet1UR
 XJ07s5h8HK9MaqWOX3UmAUOlQkJ7McSBhCx34ImuK3IfKGwpC2UJKq0KMJpoGvYI0umCsCk9chZ
 2QnSQZi9vivqAH+Sefp4+zfvmJK6f3/TCWrsGyz0YSTOto+kafacxut59UlU080aBTw==
X-Gm-Gg: Acq92OFADlRmX9BHfZCfZPCkV2wz73lSr23nJG/vR1DHwTYRYxwu75KU3ye0vKpeyHV
 bQbMmurbgTDo7fYzsPW4n/OfyXYCbhOo0uQVP1QJdQ7i9CRuBBI6UOhlbm9Xs454SyfEOrtHhLJ
 KhvjVUvHByM2xDZv32CqThqXHW8GI98RON24+W9bbgxCD9POJw5hKbhNCn1glrjDQOg4IMKWESZ
 k6GeKjXSp2gGZLYzE9b8czYmIhr9wxra670zvX47rvAA6ioUsm0IUiwX9Dn+rZCocin+J459dGL
 ANBoy2jghWeZoAZbdbHaQYHrf4xIHgQ2L4FWEzMViumwwFXrVPRVLoTB4eDR+TBlti24aUDzxaV
 IIz91pk6ZNhTcD5sRdIEyr1D5sZFCQJ1ROwDTh3Js4s04+7dMMWvF0GHw2jq4UY7plPyLbX52MJ
 c2NhlI
X-Received: by 2002:a05:7300:6c27:b0:307:7911:c9ef with SMTP id
 5a478bee46e88-30804b8d0f6mr1101064eec.16.1781156000611; 
 Wed, 10 Jun 2026 22:33:20 -0700 (PDT)
X-Received: by 2002:a05:7300:6c27:b0:307:7911:c9ef with SMTP id
 5a478bee46e88-30804b8d0f6mr1101037eec.16.1781156000116; 
 Wed, 10 Jun 2026 22:33:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Add sysemu_ops, cpu_get_phys_page_debug()
Date: Wed, 10 Jun 2026 22:32:37 -0700
Message-Id: <20260611053249.3918491-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: eBwUO2_esO8Gn_WFNL6zJOeSs80iMDVc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX8ChRXXOBonFq
 e1uqY25dIH2KbnnlKpclCOHrwTMrQqfN/iQ5TowSyK5Qde3bFAxrrPgwOm471XfMS5+jJrQOEZ1
 qA8YYGl4m6nOfeCOd92CowfoaSgkIfY=
X-Proofpoint-GUID: eBwUO2_esO8Gn_WFNL6zJOeSs80iMDVc
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a48a1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX84LhukDC3jPU
 EpsBaFG/AgLB+sBzkb7scMPWV6A14BnbVBAh/7OpvlfcSEswlbQb3AyW3BZwKfNpcC4wRyC0Lrt
 NxFLGuLYmCyDm1nASGSJG3g9gOr/wiCcARfqa9CDAQ84hJKxqutZbpgTS/l9p1TQxaq4PI//Hty
 CvnDxDEatYu9UsWPKiEklyB2+bTMBQ019LKkvjTUO0Tz/0SkRMMuYDB9bEYc1qt+465PPFpSzTo
 JbZqMQflliqd/DR2XQrjfs7Z1Ld6bKtj5rC9+AzFuyZD1ABP++fUB2f6jKMBKBPgGwVH0qZ+3lm
 iP2NvaaR4TgqR6JgAf89hHoc8fmJsYPU0hmSQtY2nWknmYmX+4LstX5D0bd+cqGM68fhMbw1ocP
 ZMYXNaIIVSp9LXvzfJ7wBLv4oCOZtWZizVHWZs7+nJSJQXYynQBN/1S3wOsAOiMqCSqd49r8FtK
 7dru8zUwsa0EUgc1Dig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAwOWM4YjE4MmMyNC4uNTRjNTM5ZGUyZDEgMTAwNjQ0
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

