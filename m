Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E5E10F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWW-0007It-45; Wed, 08 Apr 2026 15:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY6y-0007Q7-Ur
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKPG-0005cQ-RJ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:54 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M3Luv1619750
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JqirgD+TEHIoit8jv61QYAnhXe1FLYRvtuwMXQLWLDk=; b=a9iW065r4oupQxAM
 kOjYKtMgLZELLNshgjHIGKOeecDaVOJmtZc54FJ8HRWfTRDjtJTMVRWU1nrzzDv1
 cLyPkEeO76OMzTBOMNk+sTYQLYvWti7YcvOe+tt7oRlzDaZXOaXs1WNRCE9Y+Mt2
 G+C3fzTOpxw3GQ/z6p0ni6VVc97OZejmyOUxgtpqfKP4t7cWpSBB8/f4oIMosM8S
 b9QS6Gs5vzCN8DYdU/L0mYQS60rQawxRRkOH6VB2MDTBhUUzDqpJ6Ry07wAYNRIC
 Vbrs54+ouEeN8VZcyWGaOZJDBEnGOYyqoeXqxeDZnkVh432Pbbcd+CWeT7WlpuFI
 9H4Mrw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddacrgxjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:34 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12734af2ca4so504755c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622034; x=1776226834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqirgD+TEHIoit8jv61QYAnhXe1FLYRvtuwMXQLWLDk=;
 b=eGmhiKWCLTcYohks8bjykFa9AXKLSsucCAHV9VfHE7Fij2KO83bBUtYnm2txTtRs0+
 gyieQv/yjZWDiLvlGe28JAe8PgTeNXlGsamXcv1Y4t66ueCigEWXxtO+MOlBafCeKumX
 apSmBYYaIdZtxfQ7Sb8VkqsLrBohGy47HdwrrEmL/g9DNZQ7nLNFnlegB4pcaouN82J3
 fbKfpeEXX0YXlXQw70OayTWHupQA3MVHSyEARgJqw0XVKGaYrdnOd7IHlDq+2N9rsver
 P9ZAGgtNcBmVcoXXLbsdIOXWpaZSBR0r5Rxx4jQrgXOyxHoZJsAnv+VmyofDbEUes4sI
 qvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622034; x=1776226834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JqirgD+TEHIoit8jv61QYAnhXe1FLYRvtuwMXQLWLDk=;
 b=UwhiDxjQynkaDH0KKr1nIYIMAtKOtxYgySfnx9Oaue1a+edouikwGXZh1n9VGvLYHt
 koxWrOHRytKKa7AWmTYroh2h9vq4ZIzlufYozcevZZNtpqkA3DpOT3sNp186ROEyXKE/
 6dIG0Z+OnvFk+d8+zetXttjv/ohQ61keXGJMsESiywcVxi23zOXng/7zVC2Vpk3AN5ru
 xQff76N76smi7zUP3ujv5wme5cqmsMKJEWOls/eVOpvmpYBh5D+PmPJmDX4eyHyfTLqx
 o05LYEpQTOCqgOs7Zfdd6B9enqoEni/hvsETwUAgxAa19zGdGkCpzpEmiJuiby9X75NR
 U4ZQ==
X-Gm-Message-State: AOJu0YyelsggCmZT/N1xE4kgK+rhJ5MVCTuFS5+7mwU5/GfufnBm7+yh
 pM5hTB0HWy8wJf8SYhvfVDVO/igocZuNM86efdyplVtAf9jLBoNpteX2+qetoXJiNOqNpbS5bCO
 y6XAQSusMza5c3nb3ta3QtgUkeq7AtTwIdXB0JCQRAdLxoRUXhIEAl+RF2Ado1mcDQA==
X-Gm-Gg: AeBDieufPeou9ijcCKH2M1WB0Le5oBRJErYbOPWgmYDuvHhysRGINas5b7UI0Tu9dDm
 3Pvyti8WZukN4rNPTQNlNeLl2Xg1Vg/2HREFxqN87NpIxlfZwlqFD31yF6N1o+5vEYx0iJm3sq7
 HtOPTEtxyAI3QAL2hJKmrVoKYXLBhBLn5LbHCKUeGarqESJXggO1DrYK7WPIWMS3RJwSWKrOMqE
 GuppCQjM2IjbM+dJcJOz8+ehEB02DNmrpxetlZQg8G+T1YpRS3LNz+//0tvVomxgToc65/v1QYo
 3mJR3je5/tXTjeSVOA+OT5M89cy3YwoF3cRzf0WIklF4PUjVvZAYlyg/V9On4Y0AspHTWR+wnkZ
 NVCgJFVtACPZJ1Gd0Tg+ZtK9La57hGUjhL+S0fHbm0O3CnPrU0GBY6eJXdjHVrfk2TcQ0+Q==
X-Received: by 2002:a05:7022:628b:b0:11f:1e5b:2dd6 with SMTP id
 a92af1059eb24-12bf08803c9mr10028687c88.17.1775622033740; 
 Tue, 07 Apr 2026 21:20:33 -0700 (PDT)
X-Received: by 2002:a05:7022:628b:b0:11f:1e5b:2dd6 with SMTP id
 a92af1059eb24-12bf08803c9mr10028672c88.17.1775622033151; 
 Tue, 07 Apr 2026 21:20:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 24/28] target/hexagon: Add k0 {un,}lock
Date: Tue,  7 Apr 2026 21:19:49 -0700
Message-Id: <20260408041953.1899532-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: LWjpB9bFz6rygdDciHRf8MgLwsZjEd_l
X-Proofpoint-GUID: LWjpB9bFz6rygdDciHRf8MgLwsZjEd_l
X-Authority-Analysis: v=2.4 cv=WZs8rUhX c=1 sm=1 tr=0 ts=69d5d792 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=5qM_0fsqfvQKBOMFAjMA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX80+txtDBbVDU
 AsUbAXNvgsJwauTpOZkQXm6LiGOhKToRV/gh0weIRFTyTZ+hd1e6+HVRLTtAOit/758dU3ueQrs
 IGgextJj1kKya+U4uU1nqHAGqDG1njdMO1CQemMcFT3O7I2JIGkRsWP3DcDqzsuyTJ2I3nRSwk2
 cwCJa7LDH/mnp0XWuO8xtqJtD3N2OMrderMVEYM6nKRmZ/w7NTd/uH207YmkvoEf6u1vSEgZCtG
 AfgOpbsWbVonhxsUUF9dFTd3GMheHkNFj3CUwg6tFrgNqHkwRycs6ZX0BTXKoS/DGAQmKHz4imb
 Lrt+k6jnU3VFLWury6JblRJu7wDnUuLA5mwUcUH5BcMSW66Hx7r5maZ/2aXCruPcvoNzZSrGVf/
 GDL4GfoHgwe2o6KZyReV3Up39VS9Uv8ociwycXUQS9AwvgAP3MIQQ5aT1rVh0UOJr4iRw9qRUrq
 /MRyJhGZbNyyhGl2AAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3N5
c19tYWNyb3MuaCB8ICAgMyArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgfCAxMTkgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyMiBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oIGIv
dGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oCmluZGV4IGNiYzg1N2ZhMmY1Li4zN2FhZTcxYWRj
ZSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oCisrKyBiL3RhcmdldC9o
ZXhhZ29uL3N5c19tYWNyb3MuaApAQCAtMTQ2LDYgKzE0Niw5IEBACiAjZGVmaW5lIGZTRVRfVExC
X0xPQ0soKSAgICAgICBoZXhfdGxiX2xvY2soZW52KTsKICNkZWZpbmUgZkNMRUFSX1RMQl9MT0NL
KCkgICAgIGhleF90bGJfdW5sb2NrKGVudik7CiAKKyNkZWZpbmUgZlNFVF9LMF9MT0NLKCkgICAg
ICAgIGhleF9rMF9sb2NrKGVudik7CisjZGVmaW5lIGZDTEVBUl9LMF9MT0NLKCkgICAgICBoZXhf
azBfdW5sb2NrKGVudik7CisKICNkZWZpbmUgZlRMQl9JRFhNQVNLKElOREVYKSBcCiAgICAgKChJ
TkRFWCkgJiAoZlBPVzJfUk9VTkRVUCggXAogICAgICAgICBmQ0FTVDR1KGhleGFnb25fdGxiX2dl
dF9udW1fZW50cmllcyhlbnZfYXJjaGNwdShlbnYpLT50bGIpKSkgLSAxKSkKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMK
aW5kZXggMjZkMzJhYjlkNDcuLmFlZWE0NzE1MzcyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMzYsNiAr
MzYsOSBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNpbmNsdWRlICJ0cmFuc2xhdGUuaCIK
ICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9n
bG9iYWxyZWcuaCIKKyNpbmNsdWRlICJoZXhfbW11LmgiCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9o
ZXhhZ29uX3RsYi5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4
c3dpLmgiCiAjZW5kaWYKQEAgLTEyMzIsNiArMTIzNSwxMjIgQEAgdm9pZCBIRUxQRVIobW9kaWZ5
X3NzcikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKQog
ICAgIEJRTF9MT0NLX0dVQVJEKCk7CiAgICAgaGV4YWdvbl9tb2RpZnlfc3NyKGVudiwgbmV3LCBv
bGQpOwogfQorCitzdGF0aWMgdm9pZCBoZXhfazBfbG9jayhDUFVIZXhhZ29uU3RhdGUgKmVudikK
K3sKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBlbnZfYXJjaGNwdShlbnYpOworICAgIENQVVN0YXRl
ICpjcyA9IGVudl9jcHUoZW52KTsKKyAgICB0YXJnZXRfdWxvbmcgc3lzY2ZnOworCisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBnX2Fzc2VydCgoZW52LT5rMF9sb2NrX2NvdW50ID09IDApIHx8
IChlbnYtPmswX2xvY2tfY291bnQgPT0gMSkpOworCisgICAgc3lzY2ZnID0gY3B1LT5nbG9iYWxy
ZWdzID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhF
WF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVh
ZElkKSA6IDA7CisgICAgaWYgKEdFVF9TWVNDRkdfRklFTEQoU1lTQ0ZHX0swTE9DSywgc3lzY2Zn
KSkgeworICAgICAgICBpZiAoZW52LT5rMF9sb2NrX3N0YXRlID09IEhFWF9MT0NLX1FVRVVFRCkg
eworICAgICAgICAgICAgZW52LT5uZXh0X1BDICs9IDQ7CisgICAgICAgICAgICBlbnYtPmswX2xv
Y2tfY291bnQrKzsKKyAgICAgICAgICAgIGVudi0+azBfbG9ja19zdGF0ZSA9IEhFWF9MT0NLX09X
TkVSOworICAgICAgICAgICAgU0VUX1NZU0NGR19GSUVMRChlbnYsIFNZU0NGR19LMExPQ0ssIDEp
OworICAgICAgICAgICAgcmV0dXJuOworICAgICAgICB9CisgICAgICAgIGlmIChlbnYtPmswX2xv
Y2tfc3RhdGUgPT0gSEVYX0xPQ0tfT1dORVIpIHsKKyAgICAgICAgICAgIHFlbXVfbG9nX21hc2so
TE9HX0dVRVNUX0VSUk9SLAorICAgICAgICAgICAgICAgICAgICAgICAgICAiRG91YmxlIGswbG9j
ayBhdCBQQzogMHglIiBQUkl4MzIKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIiwgdGhyZWFk
IG1heSBoYW5nXG4iLAorICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPm5leHRfUEMpOwor
ICAgICAgICAgICAgZW52LT5uZXh0X1BDICs9IDQ7CisgICAgICAgICAgICBjcHVfaW50ZXJydXB0
KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOworICAgICAgICAgICAgY3B1X2xvb3BfZXhpdChjcyk7
CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICAgICAgZW52LT5rMF9sb2NrX3N0
YXRlID0gSEVYX0xPQ0tfV0FJVElORzsKKyAgICAgICAgY3B1X2ludGVycnVwdChjcywgQ1BVX0lO
VEVSUlVQVF9IQUxUKTsKKyAgICAgICAgY3B1X2xvb3BfZXhpdChjcyk7CisgICAgfSBlbHNlIHsK
KyAgICAgICAgZW52LT5uZXh0X1BDICs9IDQ7CisgICAgICAgIGVudi0+azBfbG9ja19jb3VudCsr
OworICAgICAgICBlbnYtPmswX2xvY2tfc3RhdGUgPSBIRVhfTE9DS19PV05FUjsKKyAgICAgICAg
U0VUX1NZU0NGR19GSUVMRChlbnYsIFNZU0NGR19LMExPQ0ssIDEpOworICAgIH0KK30KKworc3Rh
dGljIHZvaWQgaGV4X2swX3VubG9jayhDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAgICBIZXhh
Z29uQ1BVICpjcHUgPSBlbnZfYXJjaGNwdShlbnYpOworICAgIHVuc2lnbmVkIGludCB0aGlzX3Ro
cmVhZElkID0gZW52LT50aHJlYWRJZDsKKyAgICBDUFVIZXhhZ29uU3RhdGUgKnVubG9ja190aHJl
YWQgPSBOVUxMOworICAgIENQVVN0YXRlICpjczsKKyAgICB0YXJnZXRfdWxvbmcgc3lzY2ZnOwor
CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBnX2Fzc2VydCgoZW52LT5rMF9sb2NrX2NvdW50
ID09IDApIHx8IChlbnYtPmswX2xvY2tfY291bnQgPT0gMSkpOworCisgICAgLyogTm90aGluZyB0
byBkbyBpZiB0aGUgazAgaXNuJ3QgbG9ja2VkIGJ5IHRoaXMgdGhyZWFkICovCisgICAgc3lzY2Zn
ID0gY3B1LT5nbG9iYWxyZWdzID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUt
Pmdsb2JhbHJlZ3MsIEhFWF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBlbnYtPnRocmVhZElkKSA6IDA7CisgICAgaWYgKChHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NG
R19LMExPQ0ssIHN5c2NmZykgPT0gMCkgfHwKKyAgICAgICAgKGVudi0+azBfbG9ja19zdGF0ZSAh
PSBIRVhfTE9DS19PV05FUikpIHsKKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJS
T1IsCisgICAgICAgICAgICAgICAgICAgICAgInRocmVhZCAlIiBQUkl1MzIgIiBhdHRlbXB0ZWQg
dG8gdW5sb2NrIGswIHdpdGhvdXQiCisgICAgICAgICAgICAgICAgICAgICAgIiBoYXZpbmcgdGhl
IGxvY2ssIGswX2xvY2sgc3RhdGUgPSAlZCwiCisgICAgICAgICAgICAgICAgICAgICAgIiBzeXNj
Zmc6azAgPSAlIiBQUkl1MzIgIlxuIiwKKyAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVh
ZElkLCBlbnYtPmswX2xvY2tfc3RhdGUsCisgICAgICAgICAgICAgICAgICAgICAgKHVpbnQzMl90
KUdFVF9TWVNDRkdfRklFTEQoU1lTQ0ZHX0swTE9DSywgc3lzY2ZnKSk7CisgICAgICAgIGdfYXNz
ZXJ0KGVudi0+azBfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19XQUlUSU5HKTsKKyAgICAgICAgcmV0
dXJuOworICAgIH0KKworICAgIGVudi0+azBfbG9ja19jb3VudC0tOworICAgIGVudi0+azBfbG9j
a19zdGF0ZSA9IEhFWF9MT0NLX1VOTE9DS0VEOworICAgIFNFVF9TWVNDRkdfRklFTEQoZW52LCBT
WVNDRkdfSzBMT0NLLCAwKTsKKworICAgIC8qIExvb2sgZm9yIGEgdGhyZWFkIHRvIHVubG9jayAq
LworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIENQVUhleGFnb25TdGF0ZSAqdGhyZWFk
ID0gY3B1X2Vudihjcyk7CisKKyAgICAgICAgLyoKKyAgICAgICAgICogVGhlIGhhcmR3YXJlIGlt
cGxlbWVudHMgcm91bmQtcm9iaW4gZmFpcm5lc3MsIHNvIHdlIGxvb2sgZm9yIHRocmVhZHMKKyAg
ICAgICAgICogc3RhcnRpbmcgYXQgZW52LT50aHJlYWRJZCArIDEgYW5kIGluY3JlbWVudGluZyBt
b2R1bG8gdGhlIG51bWJlciBvZgorICAgICAgICAgKiB0aHJlYWRzLgorICAgICAgICAgKgorICAg
ICAgICAgKiBUbyBpbXBsZW1lbnQgdGhpcywgd2UgY2hlY2sgaWYgdGhyZWFkIGlzIGEgZWFybGll
ciBpbiB0aGUgbW9kdWxvCisgICAgICAgICAqIHNlcXVlbmNlIHRoYW4gdW5sb2NrX3RocmVhZC4K
KyAgICAgICAgICogICAgIGlmIHVubG9jayB0aHJlYWQgaXMgaGlnaGVyIHRoYW4gdGhpcyB0aHJl
YWQKKyAgICAgICAgICogICAgICAgICB0aHJlYWQgbXVzdCBiZSBiZXR3ZWVuIHRoaXMgdGhyZWFk
IGFuZCB1bmxvY2tfdGhyZWFkCisgICAgICAgICAqICAgICBlbHNlCisgICAgICAgICAqICAgICAg
ICAgdGhyZWFkIGhpZ2hlciB0aGFuIHRoaXMgdGhyZWFkIGlzIGFoZWFkIG9mIHVubG9ja190aHJl
YWQKKyAgICAgICAgICogICAgICAgICB0aHJlYWQgbXVzdCBiZSBsb3dlciB0aGVuIHVubG9jayB0
aHJlYWQKKyAgICAgICAgICovCisgICAgICAgIGlmICh0aHJlYWQtPmswX2xvY2tfc3RhdGUgPT0g
SEVYX0xPQ0tfV0FJVElORykgeworICAgICAgICAgICAgaWYgKCF1bmxvY2tfdGhyZWFkKSB7Cisg
ICAgICAgICAgICAgICAgdW5sb2NrX3RocmVhZCA9IHRocmVhZDsKKyAgICAgICAgICAgIH0gZWxz
ZSBpZiAodW5sb2NrX3RocmVhZC0+dGhyZWFkSWQgPiB0aGlzX3RocmVhZElkKSB7CisgICAgICAg
ICAgICAgICAgaWYgKHRoaXNfdGhyZWFkSWQgPCB0aHJlYWQtPnRocmVhZElkICYmCisgICAgICAg
ICAgICAgICAgICAgIHRocmVhZC0+dGhyZWFkSWQgPCB1bmxvY2tfdGhyZWFkLT50aHJlYWRJZCkg
eworICAgICAgICAgICAgICAgICAgICB1bmxvY2tfdGhyZWFkID0gdGhyZWFkOworICAgICAgICAg
ICAgICAgIH0KKyAgICAgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICAgICAgaWYgKHRocmVh
ZC0+dGhyZWFkSWQgPiB0aGlzX3RocmVhZElkKSB7CisgICAgICAgICAgICAgICAgICAgIHVubG9j
a190aHJlYWQgPSB0aHJlYWQ7CisgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgICAgIGlm
ICh0aHJlYWQtPnRocmVhZElkIDwgdW5sb2NrX3RocmVhZC0+dGhyZWFkSWQpIHsKKyAgICAgICAg
ICAgICAgICAgICAgdW5sb2NrX3RocmVhZCA9IHRocmVhZDsKKyAgICAgICAgICAgICAgICB9Cisg
ICAgICAgICAgICB9CisgICAgICAgIH0KKyAgICB9CisgICAgaWYgKHVubG9ja190aHJlYWQpIHsK
KyAgICAgICAgY3MgPSBlbnZfY3B1KHVubG9ja190aHJlYWQpOworICAgICAgICB1bmxvY2tfdGhy
ZWFkLT5rMF9sb2NrX3N0YXRlID0gSEVYX0xPQ0tfUVVFVUVEOworICAgICAgICBTRVRfU1lTQ0ZH
X0ZJRUxEKHVubG9ja190aHJlYWQsIFNZU0NGR19LMExPQ0ssIDEpOworICAgICAgICBjcHVfaW50
ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0swX1VOTE9DSyk7CisgICAgfQorCit9CiAjZW5kaWYK
IAogCi0tIAoyLjM0LjEKCg==

