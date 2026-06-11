Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979F6CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2P-0000Gx-RX; Thu, 11 Jun 2026 01:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2N-0008VU-Dn
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2L-0002R5-Iz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GSxn3761534
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ueeASlFVa2zuKe+z8bT4IdfK+5UBl3bW6lxBxuVovJQ=; b=n9UAi0HoJTGxbsdL
 qY8SsHBAZj3wUAmzsOvDqmIrL3q7lO1hcZY4UYxiH2Z+OWKxzni7JMSihwhC8lAS
 sHi/11Uew4fiskH7MLliPFcoovIBlKctbG19LEBrsw+NYN+rGhnFffF38gsY8Fnb
 ux3ocTgrXj4CcUktUPKxSXJntml19VcfP+3ip8n0IVZvUJNcMT9dJwW2UZsVv0+J
 pwLFp0rkGwyZa3Mhh77d3r7vhjeKnuKmefYE8Ns/MqQ/Qavlp61Zz2gkDaRxrYDV
 nuUtZr6qqhrNKaYk33vzm/Nz4QlVyn9NTA40hNWYcrYE+L6nSG3rI/EZgyDUB575
 iPQiow==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6shu5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:03 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13825e1dc0dso15847160c88.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155983; x=1781760783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ueeASlFVa2zuKe+z8bT4IdfK+5UBl3bW6lxBxuVovJQ=;
 b=JiUXmbTs4Fy8e9GGiawiGsD0SF+UZNbR4Wp/AJhRnq8IVxz0YO8O/mtz4dgh8l/GZ5
 y0MKypOw0c9ZohtRvC6GZkLPwueoy3zLl5AkMI39bwcMCXRnaQsyG7A1+NWsvG0jrFWf
 CNctc2Y7S8p+y74egoQX45RAr/pLecS65KImEJzsZzGnScVhFsHiaR1Cv0ZDJGeH0+SI
 /BePvD+VUA8plkpKlCFGfo/I85hr1VKkNcgFKGk3Qmk1gZoZyHNnSS72lGmv1NWbwzC2
 zHE+VSnkfmegzUJ3a6xy17vcPWVPX/1qnjoSLli/MtGgEhjOGDjUPHFt8LANzaVdX8XP
 NjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155983; x=1781760783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ueeASlFVa2zuKe+z8bT4IdfK+5UBl3bW6lxBxuVovJQ=;
 b=Q5BaAeSsve/+NV8wrIiHEb9a2Yr4z5Fua+XlgarM+9JjQhOGBUL3wyFMj9VZ1EGMQ5
 XZCzQbx8his+qNCy+q8pNvxse9N3hVerthtBu8AQycRFGQz3EHHpurXsnDTlXK6xBAY7
 9Sp3gUIwiXjVsPUzgkH/EsHVey8uggvFBV7T7c4zh2Fu6SY6LkGo+YInCBBAPwu+LMT4
 ZtdcO+GiO//bHDjL3LnLglJ1elAc4mRMY5EIM8XzVUkFk08c5Fa2xm+olyrAQtVQXeWt
 SsL3cMvCXCCz614hEFH6GPcnwJplLCJ4FEiXZV8JVyChK4M5W6x62Qcbq1BNOA8nX/26
 96Cg==
X-Gm-Message-State: AOJu0YxERwbQ36Gq7484KP7EHmwTVBRz4vJy1QSMmGO4+udpWCOvUTJP
 cJTOgQd6jNzmUw8EoFMcm0JOc2U0gP184LpwoPzLWuNLSt3tcNLPetneI2dvB3vMlKPzx8zdsfN
 EXMZIEfcXbmRzTbgs2NuMMq5cWcDSSluhG5MACJduOQjG6rseoUj0XvP48+RS/Zu3VQ==
X-Gm-Gg: Acq92OEZSOpsUWj81pVpPTVGJ40YmSutiNZH489WF6qXK5ALEKbKqYGpAE7xgtNmzHr
 g6En16ZRIC/3TLss3mkUGWCuSW+rdZJXa7IKULUIUL20CCNKjPjP037584+dyLlwhKWeP970l89
 Y7LfQPI3qU6VE44yZGYMY9Zpp+r6g8Lohz3XIJZPXJ7KfFcGFc70WKnXLiR5xE1qBEvbgnuGmKj
 UnO6idoIW67a1kIgCrzMwH320xfbgsKYK090yavy+3kSAKgD4KHIes0IWBuwx6UyUca/MVC4mKO
 5cZ9YEtV76NqyvgMyk+7SrzByCuSNP2VyYERucTVctnbwV2dm/BqeST1o0C/ePr9rBTg0UTnlB5
 WdHIfYB5kNPaxba7quyO9tVQX0AH48SuqsMJa7eosc0zv1CVwbx41lhEiLdOuJzE0USlLUAECRr
 VpB8s+
X-Received: by 2002:a05:7022:439d:b0:138:36f:4288 with SMTP id
 a92af1059eb24-138421a0d3amr903887c88.15.1781155982614; 
 Wed, 10 Jun 2026 22:33:02 -0700 (PDT)
X-Received: by 2002:a05:7022:439d:b0:138:36f:4288 with SMTP id
 a92af1059eb24-138421a0d3amr903872c88.15.1781155982091; 
 Wed, 10 Jun 2026 22:33:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement start/stop helpers, soft reset
Date: Wed, 10 Jun 2026 22:32:24 -0700
Message-Id: <20260611053249.3918491-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a2a4890 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mCWuZxMSpaUKZHDxuVkA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yyDo_2Nq7d6NvJrF058fTVqBZcJYf13w
X-Proofpoint-GUID: yyDo_2Nq7d6NvJrF058fTVqBZcJYf13w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX4rYY6NePyvyn
 gZIhUY3HGKhyFS8ajjspB4q0Eu09Pzv1DBQN2osqUIi1l5Kz5hz/8KrlK4dkVnXOwfK10Vcb339
 cqqTeTdk5LElSuO8x+YL4DVohu6gr6ItcEH/Df+YBL/OJzuGBt9FZ4tjXFDHPfngpuLOtXshxR1
 4rF+3UULkX77SBUX559XvznxdR58vhlvXMxhra7NTT7F0Ipod6cLiqA9uo/qJk2sl0Z96EWFHRM
 g5d8wlPVletWxaO1v3/bMX4VbdRdF0GcPbPkWrfADlCnxgAelhAPSP4IKoA5DtWgFBXZ7FWEqFb
 4qSWvfzV4j8kVflEb8JFBH6STujuz+6q95sSl1Dm8MDK6QMa3hOrbA8yJ56UXvGXmeEabNERErZ
 vLCPaD15L8E2Whv4cFQbGkcbXrV6I8aml04jrK0bdDinqoGowHt/iq7NnfQ99eJifGrNa9zYgg9
 8kQLbEt+1gpk0EfDJow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfXzqZsilXOnEKk
 1/fvk5/dhbxLh775rZcs37HRYE7Fj5uVWM3qs+fDb3xPoK35SU6v8PnlcrkXJAcssMiN0K447+y
 6dA4ddX5U3EWGCcKJjgNLbCZME0sYEA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110052
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
aGVscGVyLmMKaW5kZXggN2ZhZTljMjA1NDQuLmJlNTQ2NjNmMjhhIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpA
QCAtMTQ3OCwxMiArMTQ3OCwxMiBAQCB1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiAKIHZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgaW1hc2spCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICBoZXhhZ29uX3N0YXJ0X3RocmVhZHMoZW52LCBpbWFzayk7CiB9CiAKIHZvaWQg
SEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQogewotICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CisgICAgaGV4YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCiB2b2lkIEhFTFBF
Uih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQotLSAKMi4zNC4x
Cgo=

