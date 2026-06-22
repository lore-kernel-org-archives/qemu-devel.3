Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B58CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbncl-0002mh-MO; Mon, 22 Jun 2026 19:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnci-0002mR-Lc
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncg-0002Cp-QO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbCD82122430
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=; b=j9mbEMWm0LjQZvUY
 3z3SDHrNmv9uGTXTI39HO4qG8HqSIQFEU9PX0C9+v03EnkTbD0ITqomfVAmdiiN5
 UCfG3RezrsPUGSRy11wxPRLz+oIxUC736NPGlIqDDkKiGYsikXtxwmDnOzhwsBq0
 dqjnBSoXyAIwWKqxjrBvmak/GZF23EXumZmdDDnyVG1OkAXp2woV6pXAkFjQ5Qlh
 s7Rgn/FDu56VkdwoqZVt0jWRsSGFE73CVBBgq7D9V0WyWEo4aZSCZnS04K7aNEtZ
 u3c3HCWGSFwUdN2nmmJrVmKw5Rzx0VhFifG0NHHuOvqPZg3PeZZkd30i2LZQD+v1
 A+0zrQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n421d6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:08 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139553dd8acso21355946c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169208; x=1782774008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=DN1Aor6+9kUyUNG0v+dCygQ1/gww0P1tE63jmp6Z+5JSlsbzT12beawPW4IzOZIsXs
 zL22nl/A9g/Y5sN0mB1FPx2QLleBowUPvf3nHPy8ZOI16+hHg3mvUHY9xLqI2SXAKYz9
 b/Nw5jUNTX7ttIhAnlYr+qGNqyqwcyR3trHcGhtj85TnUKfcm3rg1vpOUDFmt0aogXDz
 Kl2BcLVLfjBpjmyQemN9qe5wAM/ND8fT971vlE261Mpy0xqVC6OBazkk1hGCqQeM0UIu
 S9/v2chSXx0Evjv5Z/WUrtI5Kf53hz0+Q4ObBiQkY0HmgS1gMDDcGrlvb73sIojnUX7z
 ASnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169208; x=1782774008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=HPv0kLQ/J3RScfkBuvUJEumGKED96OF6fpwbe3D99Y/lg/n4Szt0tMDRpOY49OEyIp
 4V5QeHX57wK40W+PJBBKyZjrTztm8LsSadMC9iFeqNXn7tM4GzLm2c56rNx7AQN3siBu
 3eISWQlymeY/8MheEOa64Aqoxq+jjsD3y+S2u0OZUhDczJWqulPrzRVtDg51npvVDnn5
 BoLQpY3xHn3RN9ZOISVsCb9Q0RQYCE8pyGq0FQBX7ym18kxGMLtCQjsSYBx7qnXfgEPL
 SARDhdD08CqoHxtvhOKPS7i1dsNkk9VYz4ZGtoJhntrHKXok8CU/cOsy/4LairYsSc4Q
 9BXA==
X-Gm-Message-State: AOJu0Yy9uiNrzKi9auFKLVDn5n712p4P0lUfJvEbqVemSFJdmibRtxQv
 VuyCMrB5LyQZQ+PdmS4E5y9riea59QYhihJLgHt4rZwGcQ7QEzeCK4Oa7v1KMzzyn4cZTJalv4P
 jJNNURWrE+91SGd5xblTM4no7zD5YoRH1WDZ2CxZI4o26Pf8D3/kVGb3zuWFLA5yMdw==
X-Gm-Gg: AfdE7ckjpKfZm32VzccqNBK5esDypAuxUCDlk+D+ZoHauxPmIoYp07Y9Nr2a3u3DaKa
 cVi28MftxKMUYhIw/0YuTTucCBNOw8pORiBYRPS0Zu4s0udg/aJVtKODKRD6N0wM7CQRALweRek
 JjO1IiE7I0x6KaJ6b6kXu3P/OF1FLc2XvcyGSZZm93+vj1JMvvOMScCIGfBbMtqWtaYJHsWNRMq
 VP7HX+O7yqDfI5RTl4C/gkUi+17EKWiqo+a6a78q04lw8FO5g0kCdnF7GgJmhMN6lEUDxyOS2cE
 ImxKD6y6WRKVoUKHcdqDRmir07P5Pfpqg0RloWq843CzOR6GuiCV7BNiqJJ7ZFdzG3IdZ7Uqj00
 btsqKPkCEOhVlgFGefl3wCQDta9ZIaRZ5AHo9/ortvl5bVjeYWIO8NjH08T4=
X-Received: by 2002:a05:7023:a4d:20b0:138:4023:8b6 with SMTP id
 a92af1059eb24-139a34f527cmr6788089c88.10.1782169207928; 
 Mon, 22 Jun 2026 16:00:07 -0700 (PDT)
X-Received: by 2002:a05:7023:a4d:20b0:138:4023:8b6 with SMTP id
 a92af1059eb24-139a34f527cmr6788074c88.10.1782169207180; 
 Mon, 22 Jun 2026 16:00:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 40/75] target/hexagon: Implement start/stop helpers,
 soft reset
Date: Mon, 22 Jun 2026 15:28:29 -0700
Message-Id: <20260622222904.607771-41-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXwsUYv1xVkXiA
 Rh4U79m4/o50QHzRkTT6W1rTanUiT/US7H3JqTJEKKeIB19Gs9oaacbtY4VSRAU36u84a/aBweu
 Si+Bgvckug67XohfrA0cXSA6PjVuPtU=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39be78 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mCWuZxMSpaUKZHDxuVkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mz0xB-fNs-TMBKVD8ge57S7sYrlq1pFR
X-Proofpoint-GUID: mz0xB-fNs-TMBKVD8ge57S7sYrlq1pFR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX5nRGkJu7r8I+
 w+C3GBRU/9ihBjnKDYOEU5rBtsNPe3udAjuk0eqzE3/PIGPH7KYRWOg3qDzvICHKA0JXp8gZ2NE
 MwfI3hKRJeu12M+5UDUSDpwYL+vvQthPCYvYA5DUowkizJ2f2YJeKR+9OgTtSkAw3TnM/3X2hy4
 TMC54rPD/SKLonAdPmvy47XL56CHWxKKXXQbroAXXwiRTDAiayJWQAIuOSC/ESEmBTU6o8P7wnw
 DG/cTD1TVQBh3M8b27G28UEVm6Q5V3JfD/CGpC9aHs411fROaCAKaiWlhibjniz3MhY9IX4Wcw0
 GVOSRNJD17u4npsYOz2m8W9cEMseYc2webzov752wasmsxK7waWPnXfM7g20jjA3VUmotqbe5pg
 J0Ot4nhHCd72hRK5MEuGB+bq4w3dQrZCUUlV2AJT8yKvk4UF8rRZToHg1o9nEHUYKkxKQfobx0w
 RhFdDwJszpFaKfRM21w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vY3B1LmggICAgICAgfCAgOSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5j
ICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKystLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJn
ZXQvaGV4YWdvbi9jcHUuaAppbmRleCAxYjIyNWUzNWFiYy4uOTJkNGJiOTcxMjkgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0y
MTMsNiArMjEzLDE1IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9l
cnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludHB0cl90IHBjKTsKIAorI2lmbmRlZiBDT05GSUdfVVNF
Ul9PTkxZCisvKgorICogQHJldHVybiB0cnVlIGlmIHRoZSBAYSB0aHJlYWRfZW52IGhhcmR3YXJl
IHRocmVhZCBpcworICogbm90IHN0b3BwZWQuCisgKi8KK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNf
ZW5hYmxlZChDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYpOwordm9pZCBoZXhhZ29uX2NwdV9z
b2Z0X3Jlc2V0KENQVUhleGFnb25TdGF0ZSAqZW52KTsKKyNlbmRpZgorCiB0eXBlZGVmIEhleGFn
b25DUFUgQXJjaENQVTsKIAogdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpOwpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRl
eCBlYjFmNzA0OTI5OC4uMjdmMGVmNTBkZjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0zMyw2ICszMyw3IEBACiAjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKICNpbmNsdWRlICJzeXNfbWFjcm9zLmgiCiAjaW5jbHVkZSAiYWNj
ZWwvdGNnL2NwdS1sZHN0LmgiCisjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKICNlbmRpZgog
CiBzdGF0aWMgT2JqZWN0Q2xhc3MgKmhleGFnb25fY3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hh
ciAqY3B1X21vZGVsKQpAQCAtMzEwLDYgKzMxMSwyOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3Jl
c3RvcmVfc3RhdGVfdG9fb3BjKENQVVN0YXRlICpjcywKIH0KIAogCisjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKK3ZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVIZXhhZ29uU3RhdGUgKmVu
dikKK3sKKyAgICBIZXhhZ29uQ1BVICpjcHU7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAg
IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl0gPSAwOworICAgIGhleGFnb25fc3NyX3NldF9jYXVz
ZShlbnYsIEhFWF9DQVVTRV9SRVNFVCk7CisKKyAgICBjcHUgPSBlbnZfYXJjaGNwdShlbnYpOwor
ICAgIGlmIChjcHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgdWludDMyX3QgZXZiID0KKyAgICAg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19F
VkIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpOwor
ICAgICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGV2YjsKKyAgICB9IGVsc2UgeworICAgICAg
ICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworICAgIH0KK30KKyNlbmRp
ZgorCisKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJl
c2V0VHlwZSB0eXBlKQogewogICAgIENQVVN0YXRlICpjcyA9IENQVShvYmopOwpAQCAtMzM5LDkg
KzM2MiwxMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKIAogICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0hUSURdID0gY3B1
LT5odGlkOwogICAgIGVudi0+dGhyZWFkSWQgPSBjcHUtPmh0aWQ7Ci0gICAgZW52LT5ncHJbSEVY
X1JFR19QQ10gPSBjcHUtPmJvb3RfYWRkcjsKLSNlbmRpZgorICAgIGhleGFnb25fY3B1X3NvZnRf
cmVzZXQoZW52KTsKICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfRVZFTlRfTk9ORTsKKyAgICBl
bnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworI2VuZGlmCiB9CiAKIHN0YXRp
YyB2b2lkIGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvKGNvbnN0IENQVVN0YXRlICpjcywKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMKaW5kZXggNmYwMWYzYjkxZDguLmI5Y2YxZjE4OGJiIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpA
QCAtMTQ3OSwxMiArMTQ3OSwxMiBAQCB1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiAKIHZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgaW1hc2spCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICBoZXhhZ29uX3N0YXJ0X3RocmVhZHMoZW52LCBpbWFzayk7CiB9CiAKIHZvaWQg
SEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQogewotICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CisgICAgaGV4YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCiB2b2lkIEhFTFBF
Uih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQotLSAKMi4zNC4x
Cgo=

