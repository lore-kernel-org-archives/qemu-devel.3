Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97084CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNR-0002bj-Gh; Thu, 25 Jun 2026 10:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNJ-0002aP-IS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNH-00004z-Sb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k1Mw1398519
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=; b=O9gmozmyTR6Dez7Q
 /BzmQHtzVd5q7sNVOnGLmP8ODLZIwQ2HtP2zDRujXrHEJwXyVcDfmphxYU44NK86
 CgEy3JCf05JvX6HCesWaYkekWSd9UDU6dELB4XyrYCbLTYqHkJiiL1liMevbORwk
 MDfXHoJy0upqNYqYko/Q3tumehdtTRurIGqVXWdkzNuhE6q7L/rb9bYgDiqiGxLw
 Fjgjei9jMaW7ldrYQ+NOBWuvAoRCLPEpauxq6OG5XtGCanJUUYFMDVmzaew3Iyd0
 5T8aycAFFpvjpdfuZPmsjC4R9zkVXA2n85/wn0XVbgKnwW8opfHQdH5SgACaJwUk
 M3eRkw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uudjmp6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so7001699eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398892; x=1783003692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=YDIEVu2zR8FaDlrkWF9oXrDa+AzSzBTOtAqzWq4fRwjvxgajuE48QIrXioxWENKH1Q
 39rc9LeLhWhQC+eFnzb0Fn1jUKKdJk6R5jtsT0YL2eeUxAx6f3Qj7Nc/qSTyjdhpp46D
 otvAIzD6zCZDFHjRBCyG4JMIXHyJLIX0GaofvE+La5GwaMyrDGNGjBtw47n2EXlXpf8u
 x3lSa0J4y90L/1S4h8PURjgnzfCypiJ2jfHseZm7tAH6na6XWWuDgcZNn/aI0q8XJJgn
 L9OwzauHwN25PNmO61ibDVlz/VxRq/4RgpnCyI98ThFu2nD39PixXAWaair+Q8gCpE1b
 S/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398892; x=1783003692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=Q+rHlx0XlyKLavRuNZJKx//awymvxVNurboGb9eZjonk8QkATOtww1omX25L9f1ADN
 FrG6ENob00tB5g3MyLvW4TYeD/MlYHbhpJc61Q5ffpNfxL8rer5nATdPynONWrHzbKyM
 i+DkspgqqQbNJSEuWCF4I5DsvMFsriLVhxoOAL6BEjwcrzPEYqg6oDDFMD0qBo0hL3Mn
 hHQXY5ZYOJD5ZSx95kisi9I4r1LxG0Ir4eBiS2W1Vk3zb6xfvFvTyvGzZufAhbZM5vca
 HjUL36hQUMK8axJ876zyoiedFWeRWb9qPRZtGggLimwEl3Gwvmwu/AOGP/CnV7ZCr7Sj
 LyJg==
X-Gm-Message-State: AOJu0Yxc72f23pEBrwSArYR+z4N0Cu/M1VprXnsY/1oiZKOYTL1lONHW
 IJpcjv3R0uq7wIF87QtmWG8+XWNZOiIkW1FQW9rTsQSKTgGLVhVBPS/dle9CfgkPoBVdKykkfNw
 KjtD1PXhLvDnyfnyK8bi3x0H6WUduJj0POnNLD9SXFw+LeYtEzdbhYmJ3HMjPcfCFwQ==
X-Gm-Gg: AfdE7ck0kjuqtutNxwKFoNeDiDxiW+vFZr3Orcmz5W+Kc0fX1OJWJUnVoiR1XwQFY9y
 oPBCNSsrjtn2ikRCnFgctVSqkKc3bVybPy6CXhKZMw4X2Oddv4V72yWQ+S8+DsTAehZBfWlZRqw
 C3iOuMNa27nmKC9SfJSFNDBqt3QAG9K2BYzU4fNximOKj+QVSCNO2WVGHppycVQy3P48xmMyXlK
 h5I6rHalBgT5BSQbX4DQhBAoa2l6g0S8Jk+PSzaKKNIfXd4PwqzTCotlsn/DgG/wnStmvaE+7Et
 bQv0uknO8XsHGQeLAsAp0LmvxjSIN7IHE6C+MS5xxIeeQJC2x8hi9tORgbXxalITjYWz74ItREP
 VkS80Ki0cMtkDaPyb1yDd0pEthYeqqy2XSleApNGp98eM1fO2lR8VFmxXplo=
X-Received: by 2002:a05:7300:430f:b0:30c:5ebf:63c9 with SMTP id
 5a478bee46e88-30c84d9ba29mr3445716eec.5.1782398892384; 
 Thu, 25 Jun 2026 07:48:12 -0700 (PDT)
X-Received: by 2002:a05:7300:430f:b0:30c:5ebf:63c9 with SMTP id
 5a478bee46e88-30c84d9ba29mr3445682eec.5.1782398891798; 
 Thu, 25 Jun 2026 07:48:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 42/76] target/hexagon: Implement start/stop helpers,
 soft reset
Date: Thu, 25 Jun 2026 07:15:59 -0700
Message-Id: <20260625141633.449487-43-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfX60tdqSpFE8Dr
 kOdxRXZXyO5vb4ej6zekbxQQ/D3okNbYyrj9U3vkNiBr06Y0/VI7BQACj1r/MNgpFSTrxx+Nfjm
 Jsg/Z9hevWU5RhcRyLn9yJMDLguK0qI=
X-Proofpoint-ORIG-GUID: zQLsP7_N8QrtnVmBD5CZpdxSmCa8U8SR
X-Proofpoint-GUID: zQLsP7_N8QrtnVmBD5CZpdxSmCa8U8SR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfXyl6uMeyJSkCs
 PAKv+wN0GqbYdT/MRkAw5njOSMndK/lP/XjvKoRg4kjou6bYHPYjcicQKmirx7UlVfiw6ninfn1
 eWcPNoNiUBdv26i7PVk6DhxQVEFamF4kT6eea3VT8O9NxXC0xr82MXx9vdobwgS/Ncj/0RZM/eK
 6MT4JsRIvqhcUTm3ysz++FSjQq8SQE+vtadh6kZBYS4Ue1y6QTvisP26APyH9jSGX5+uSU5uCT1
 y7qi7ewyn3DasA3nmr6Gt6sZqm9oONiH1lx+OC9KP86eDXoS8QOLOFKfDBzKmxPDb+6mnkYVclR
 CfZjXOJFhhSY5mDw0DYshzh3rBt8o0gr6RRho9qmAvx+3dhPa3U3DNGIMOdqfbPxastGlRHKk7v
 7JBgaThabZywGv0R1cysIDfLNJe+seOYccSzf36ub0uDvR8OzU8CYqaqnSTRpF7juTUfMEg8ckl
 zrfOWN9B2JhixLzuVaw==
X-Authority-Analysis: v=2.4 cv=HdckiCE8 c=1 sm=1 tr=0 ts=6a3d3fad cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mCWuZxMSpaUKZHDxuVkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250126
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

