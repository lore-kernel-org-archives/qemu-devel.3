Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A710F9976
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYTB-0007Fu-9b; Wed, 08 Apr 2026 15:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY4U-0006PA-1K
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:56:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOl-0005Yv-NK
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M6KM32450557
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 43eht5i5NYtJP0f/h9KiBbJpH+OYgI6m0lyV0s2tzuM=; b=BY4dMjkhlA6mn2yF
 uoqX1B0UzPUPseKt5kvNX2oEqYt/4TnRWutqG8ABjNssmpwTUraEg2sZPsdkmz6W
 Mt2uVl7p7ccSfLQbZY0AohDc/rO3PX/xL+v3aBEmQTbvMuNtdM0cxKzawXqo2etF
 5C3RCtX7KyFmVjkKP9H9jAgtZK7WqZquq810jyqBOr62Rb3hqVyrAVsWMaWb+QLg
 gSlkJq95TdkyZpZks2fB1/cppxi2y/HftQbTNC1UAi3uNLDKlKzUCbaB/E9Ti6+x
 4iOAzX5o46hCCY4K3Nk1H1qxnabG8EcIB868EuXf8zzrE/wCQVS+VZBtRgQB9UHy
 fO1NLQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae68wkn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1276e71652fso3470577c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622012; x=1776226812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43eht5i5NYtJP0f/h9KiBbJpH+OYgI6m0lyV0s2tzuM=;
 b=EXAlKV5OqbXLIn/W81LSL83HWgTHFS43ClzQ+86CO+jtjc4DrCu3usnhH1FkYS3qwP
 dpn8vt/Ko17QVLBbSb5yttKKo2Nq2rocltcN6vM4WJPm6XgIeVMeBoJiH1J0BQ+PEP2C
 3+N8FRwzwtIzPJhsoqAAXShqMJrDDyD6Yi4vf0P6BXKYarftYKchoZ9BKrdYs2j3/aL0
 OtxmHaiQw3uifwoGm1rY/vTguhZ9/IW1lwFS/m07H3irjImUdVKe5DJeQQmCcvc1KbwV
 zGBrfJUvgfGz6dybi9JINW/M217iDNpfB5lhQJK5K0oWRC0xrV9v15CKv8F7czo4VloV
 hAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622012; x=1776226812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=43eht5i5NYtJP0f/h9KiBbJpH+OYgI6m0lyV0s2tzuM=;
 b=NAPSPr0J7hgF+LYs08zEdfzosvWosF/RI2Th8yiYhVBZ7M6r5Jfg+xk0wH9ryo4acb
 vevblTI+TyV6KgvGBTo/WIOfe9OiMlOE+Xuk12b+o07bqqGzzmRpqndctzyzAFcvchF0
 FAVnpT7mADQcDwUYUkB/N1X/nVJlsuMMTamMPhqJdd72G2+bngA7th6dgh3TK63pDY6+
 tMwcq9FyAyqF9YBzT8KDUQ+ri3U4dO214hwB0T4+6iW7MO2DE+IK8oEyiMN8HsDYaP5T
 421MM3TPAJ6T7Y6TddDywICgJdQoCMW2NZxxIuhEbB/YVgzPKJJaycs/7SkV3hKsB234
 ypgg==
X-Gm-Message-State: AOJu0YzbyLC09P8SDff9vGnt8hYUy5mhuRN7RQyi4CvNgj0hHG5s6N5J
 j400mUByJZpBxng9ra6doDtBfLwjiYwE8bTmhW5Hne2EX/Rezl5iDn+OLUi455lsHcfSv+yM8Pt
 zpX8bKLEeNnWRcUwjHMzGGUDtHSSFgqq/nRieEhIiOsnoe33I+mlu3nZO9r6c8p5mRA==
X-Gm-Gg: AeBDieugqxaiIEEiOb2EVQUnXqwkX2RwMjEcHwf74K1dbIb1dj6yyZgNdgm2o2kUZIq
 AD++FbRLvhPn6o618n3Uw6qo5KMVMRP6grMw3zlG4oIDhnynj6HJyls9u460BkML5441Qo5S4WP
 yYGg6DN5/KIrNY6pF5WJnI4Tb220+OcrDcuAB3eQ62f6/amZnKujFPDV9LTPtP/RoxxlXJEHePh
 rnnd6JxVhqJTHmoQ27ykVvMQm71fr/v8jnc3qetiksygb4Z4sm7VyFlMQV+hRBppdGW9GeHA9qc
 wFy7EfcNn9+tqZ0beTw0/uD7luh8LO2yN3/G8DsOpff3xybL1mu2tjPz3RC6ftVq+5jNyi/H79T
 Xm7wF6j+WPIUMP6N5ujT1My5eqLNl+UFdSDX2kWI7MrnHr7c28AlU+LGUzEWG40cWUQmCAw==
X-Received: by 2002:a05:7022:61f:b0:12a:6fb7:8801 with SMTP id
 a92af1059eb24-12bfb7074cfmr9452746c88.14.1775622012096; 
 Tue, 07 Apr 2026 21:20:12 -0700 (PDT)
X-Received: by 2002:a05:7022:61f:b0:12a:6fb7:8801 with SMTP id
 a92af1059eb24-12bfb7074cfmr9452729c88.14.1775622011517; 
 Tue, 07 Apr 2026 21:20:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 03/28] target/hexagon: Implement start/stop helpers,
 soft reset
Date: Tue,  7 Apr 2026 21:19:28 -0700
Message-Id: <20260408041953.1899532-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX+MW9ZDOTMaqP
 q14Qg8tl5oeVdHUaUbtpk1yS8wYbvnbyMsOjYz+YY6ftLHyp554CjMsSKrsB+4/rlUYegFv9XtQ
 GTEwAumJiYxilj2e4uZW9y1WgNb1F6kp86PlbM55JQv+RPGPC384a92JD9i9gxRqf8RGt3RIZuT
 y+MZ8q0jmOPBzftREw72pYKrRl6er231i/i+8YS6Uw9Me/ELBJCPvMzZIqKJCZDee2rf9vR1gta
 W02OLt8GlQISQJPypzH+q6e5TtB1z6++YfCINolQdvlFQBCC5XBC+iheGGl/JN/nJwWebTBm0PE
 htm/AzuJI+dT0mZSwHJNYqsR5bZtUGmruKkVG/hqV2QZsu/L7RF8XkZ/BYAw3AZipANizYaPM21
 9urA2ZVncSIkBLFJeeEvzQJxbGoZi1L59nPE1iEXaqC8LajOvQ5qW9mC+HPcllRzN9B7asdly4S
 1oHYZxNhGL5tJhkp8Cg==
X-Proofpoint-GUID: loFzOvGnRvLDpDwqVjG5Qd9NcO_C37Dk
X-Proofpoint-ORIG-GUID: loFzOvGnRvLDpDwqVjG5Qd9NcO_C37Dk
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d5d77d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Yg3Zx8E-q63MwIDgcCkA:9
 a=5DSkQkq5sdZ_jMUF:21 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=TjNXssC_j7lpFel5tvFf:22
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmggICAgICAgfCAgOSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgIHwg
MjggKysrKysrKysrKysrKysrKysrKysrKysrKystLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMgfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdv
bi9jcHUuaAppbmRleCAzMDQ5YjVhNDExYS4uMjkzODI5MWZmMWQgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMTIsNiArMjEy
LDE1IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4
YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludHB0cl90IHBjKTsKIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisv
KgorICogQHJldHVybiB0cnVlIGlmIHRoZSBAYSB0aHJlYWRfZW52IGhhcmR3YXJlIHRocmVhZCBp
cworICogbm90IHN0b3BwZWQuCisgKi8KK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChD
UFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYpOwordm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0
KENQVUhleGFnb25TdGF0ZSAqZW52KTsKKyNlbmRpZgorCiB0eXBlZGVmIEhleGFnb25DUFUgQXJj
aENQVTsKIAogdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpOwpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA5YWU4ZTEw
NDA0My4uZmU3YmIxOThkNzIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0zMyw2ICszMyw3IEBACiAjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKICNpbmNsdWRlICJzeXNfbWFjcm9zLmgiCiAjaW5jbHVkZSAiYWNjZWwvdGNnL2Nw
dS1sZHN0LmgiCisjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKICNlbmRpZgogCiBzdGF0aWMg
dm9pZCBoZXhhZ29uX3Y2Nl9jcHVfaW5pdChPYmplY3QgKm9iaikgeyB9CkBAIC0zMTUsNiArMzE2
LDI4IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fcmVzdG9yZV9zdGF0ZV90b19vcGMoQ1BVU3RhdGUg
KmNzLAogfQogCiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQordm9pZCBoZXhhZ29uX2NwdV9z
b2Z0X3Jlc2V0KENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIEhleGFnb25DUFUgKmNwdTsK
KworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSA9
IDA7CisgICAgaGV4YWdvbl9zc3Jfc2V0X2NhdXNlKGVudiwgSEVYX0NBVVNFX1JFU0VUKTsKKwor
ICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7CisgICAgaWYgKGNwdS0+Z2xvYmFscmVncykgewor
ICAgICAgICB1aW50MzJfdCBldmIgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVh
ZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX0VWQiwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgICAgIGVudi0+Z3ByW0hFWF9SRUdfUENd
ID0gZXZiOworICAgIH0gZWxzZSB7CisgICAgICAgIGVudi0+Z3ByW0hFWF9SRUdfUENdID0gY3B1
LT5ib290X2FkZHI7CisgICAgfQorfQorI2VuZGlmCisKKwogc3RhdGljIHZvaWQgaGV4YWdvbl9j
cHVfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpCiB7CiAgICAgQ1BVU3Rh
dGUgKmNzID0gQ1BVKG9iaik7CkBAIC0zNDQsOSArMzY3LDEwIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogCiAgICAgZW52
LT50X3NyZWdbSEVYX1NSRUdfSFRJRF0gPSBjcHUtPmh0aWQ7CiAgICAgZW52LT50aHJlYWRJZCA9
IGNwdS0+aHRpZDsKLSAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOwot
I2VuZGlmCisgICAgaGV4YWdvbl9jcHVfc29mdF9yZXNldChlbnYpOwogICAgIGVudi0+Y2F1c2Vf
Y29kZSA9IEhFWF9FVkVOVF9OT05FOworICAgIGVudi0+Z3ByW0hFWF9SRUdfUENdID0gY3B1LT5i
b290X2FkZHI7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfZGlzYXNfc2V0
X2luZm8oY29uc3QgQ1BVU3RhdGUgKmNzLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCA3ZTZlMDRlNTEyYS4u
YTI4ZWQwNjE0MTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDc4LDEyICsxNDc4LDEyIEBAIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IAogdm9pZCBIRUxQRVIoc3RhcnQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBpbWFz
aykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIGhleGFnb25fc3RhcnRfdGhy
ZWFkcyhlbnYsIGltYXNrKTsKIH0KIAogdm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBoZXhhZ29uX3N0b3Bf
dGhyZWFkKGVudik7CiB9CiAKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB0YXJnZXRfdWxvbmcgUEMpCi0tIAoyLjM0LjEKCg==

