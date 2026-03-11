Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6CDFD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsF-0000rC-Se; Wed, 11 Mar 2026 00:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As0-0000nG-Qy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arz-0008V2-4k
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AIn5G33759633
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rLV/zM3zAmLxLishqc9hXGVjxmC0Q8W1LuAK1tyP9EU=; b=guWgQxHAq5ttaw4e
 kSjn/Oa5G1ruSy5p9oKuNxie98/qbVzy2hrR/4JpBImCN5nSW8r9hXiy4DfK+f1q
 ybz5Ug1CCY/+D9NB/9651TU6n3aP3o6tYcXKo9pGDfpgwNIZ8jTuSZGfXwEic4tO
 2/OAXdFkvFfmOKj7jsuckO1yEzkMlZ6owyW73Cy0k3gLHnykmXhEI8eDTbGiaw1S
 WSRjo77UiQv2is7eTCkptuznoFoKO6lx03XK9VOcQaKs353kg5imyHamXxsR9eH1
 mm8U+4Ke/pSn76ea8/Gya5vACcIsfmjSyppmmH4tEDS7vk0ABHMEy6uGYjOvAJ4n
 3TRi7Q==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctk8uk4he-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:25 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-40aee511210so53525979fac.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202105; x=1773806905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLV/zM3zAmLxLishqc9hXGVjxmC0Q8W1LuAK1tyP9EU=;
 b=aR0/yX3JNwV+LGctXYnK/pNBo9r1e4OcGjPw8yheWmjPiJIkS5QWjDx+NvobuV4skz
 kXl0b7MFMh3J7bPABEXYrq4wDE/QBlWrQLYNfjlpX84FWXYmLVdHA7aICn+eoGYkXY/9
 Dw791Co3Sh1gPFVs/gAnlGetIAXISYaH1/+c+AoloYJPHE2OZDZaOv7jEgbHf+mCJIsy
 +AQn0ZYWgpwyA9dAdhKTg5nO2h+LT/goizFRw4e/DaxsH8pQKouTT5UxIBDvrZOI+cGB
 io0uDrLyhaCgNWev38X5vZKZchpU8GNM8fyEZFiSq2rQ/GNGWNT9W2bUAJ6uI0aHNhWi
 oRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202105; x=1773806905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rLV/zM3zAmLxLishqc9hXGVjxmC0Q8W1LuAK1tyP9EU=;
 b=N8M9+j9SM2eJnVY+xDHJrade6G9MZG/G57gg5mVGaKAxIT4XobGDLhrAts9cQrtSr4
 reMpUFPB3n1oclCJ6DQK3NF1KMOHGO7YY7mb9k8QaT2ivWd6FHoSq40vm6BZfkDT9kGt
 m+MQabwNhxReyhpzfX8ZWmR16jhvZMxK/FAdwuiIDWVaOH7tkabJ9siIJBoPAWzxLDLf
 yOwhwMqqdY4q+7IwECyYOXqZLTxtWGzw9a2JC6mM6i6M3nqrKW1JxX48s4eCd/VPmmY2
 4zwE9iPiRY75ngwYQOCsTMWDFfe3KqhVaXHjcacrm+6udXgpzu5rVScu6a7n/X/FZeW2
 GFMg==
X-Gm-Message-State: AOJu0YwTj6GctjgPZNNu3si/VYxISceSFCjYP5fOItpEoG6F1Sqi8LjZ
 5Ctb4R7sJR869A48iZ/MvG2TsEYQfyPhqCVLUy8jKJGZmGPjn14LypOlCPlqsC00b5MSq5V1zd9
 sSDG+eRuHEfFPWwNryDisyk2Scu6mpJkPGUrCfuvWELn5x33r0KgLin+pzAgEXgngHw==
X-Gm-Gg: ATEYQzyBZ52WGGrn0UdZqMHXi9MVwHsY1sH6XdM6fCwTeSmcLlXhahzZxV4AdQiJo4b
 Y+kx3QtduS/GtNmtIMXlpAJRNq1YiNcwQk9VLFlzNEb7ApNQmb2RBOi16UrC1+bNKW89792BEDD
 cYG8ZNHA47J5erAQnjS/FLNE723gKLJU/bCjIOA9kSU1AZptqdVwGa0gUWcYnXingXEYBFPyziv
 0oxdWeDdeZJsOekX5kNJeObMht10gqD+/EicUHsuCHUiBtowu/4nDJzgZy56jXCYL/hXvtuHi4G
 mAUVpkvuohYrBCFVlrlvYN8LT1iJnL+04HGL69XfRAXxITOJv/5my4oRLTYRX0uj2XJgBWEen0e
 6CbzCquPqNntEUdf+EAsmj88e2EOIONPI7ZqdafLB5ErhqhgEsyLO2SVFDVE/SvXdW1jBMg==
X-Received: by 2002:a05:6871:7418:b0:416:414:bbd7 with SMTP id
 586e51a60fabf-4177c695356mr902364fac.21.1773202104847; 
 Tue, 10 Mar 2026 21:08:24 -0700 (PDT)
X-Received: by 2002:a05:6871:7418:b0:416:414:bbd7 with SMTP id
 586e51a60fabf-4177c695356mr902342fac.21.1773202104434; 
 Tue, 10 Mar 2026 21:08:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 13/32] target/hexagon: Implement exec_interrupt, set_irq
Date: Tue, 10 Mar 2026 21:07:39 -0700
Message-Id: <20260311040758.1068731-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: RKRlXfI1DjsZ5nMXUXM-94GOEcP3oXpE
X-Proofpoint-GUID: RKRlXfI1DjsZ5nMXUXM-94GOEcP3oXpE
X-Authority-Analysis: v=2.4 cv=YcmwJgRf c=1 sm=1 tr=0 ts=69b0eab9 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rIkxbyxcx7-xiWOMinkA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX0tn7sybT1pMx
 VV4bnyrP85B6ecELg2bbr8KBClP3k/B5ctb0Nyyi1ChCaD17RQsUzflvdqq/kx69tKBRX9bob5x
 3E1WUCth5uIv1JBQW7eeqyG/RQwpbfVNMShpdWdgwoJrgPaWFzhZ40ozlJ2hskt+TfrF7r5i61F
 mysykalpt7q6oW07/q6eQmIHNRmbyh+8rXJEF0WqtxU0QJPKd1eP3LQAFU1p/IE8nIWFMGAYt2x
 +EXZPhlOOfe//7/VZR5Rs7Z7S+K/8QQqFfyb6vQkWbHPiEOWhRbPITCqmc+0qivY1fYQG2VWNl7
 A0fIyZP2PpooiQXhSuVEYFYcXnIsd9C9klc7YQUP3PQAbOy/TRFMBrYYOUsiTaS6BDh2xtyT16J
 Tr9sn1VpmKLJkm/wZIMhkqiddBRw0zl6sJhA65JYLbJVLjCglDc9VNpeHTGnnS3wXsNEn2pF8dY
 eWG5LyuaM0vkYQB3kJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
dS5oIHwgIDUgKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8IDgwICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDg1IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29u
L2NwdS5oCmluZGV4IGRhOTZiNTJiZDJhLi4zNDQ2OTEwZmViNiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTIwOSw2ICsyMDks
MTEgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhh
Z29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludHB0cl90IHBjKTsKIAogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisvKgorICogQHJl
dHVybiB0cnVlIGlmIHRoZSBAYSB0aHJlYWRfZW52IGhhcmR3YXJlIHRocmVhZCBpcworICogbm90
IHN0b3BwZWQuCisgKi8KK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChDUFVIZXhhZ29u
U3RhdGUgKnRocmVhZF9lbnYpOwogdWludDMyX3QgaGV4YWdvbl9ncmVnX3JlYWQoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IHJlZyk7CiB1aW50MzJfdCBoZXhhZ29uX3NyZWdfcmVhZChD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKTsKIHZvaWQgaGV4YWdvbl9nZGJfc3Jl
Z193cml0ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwp
OwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUu
YwppbmRleCAyOTY0ZDhhNjNmNi4uY2MyYjRjMTgwMDEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0xNiw2ICsxNiw3IEBACiAg
Ki8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJxZW11L2xvZy5oIgogI2lu
Y2x1ZGUgInFlbXUvcWVtdS1wcmludC5oIgogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImlu
dGVybmFsLmgiCkBAIC0zMSwxMCArMzIsMTIgQEAKICNpbmNsdWRlICJoZXhfbW11LmgiCiAKICNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUgIm1hY3Jvcy5oIgogI2luY2x1ZGUgInN5
c19tYWNyb3MuaCIKICNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJx
ZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAi
ZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjZW5kaWYKIAogc3RhdGljIHZvaWQgaGV4YWdvbl92NjZf
Y3B1X2luaXQoT2JqZWN0ICpvYmopIHsgfQpAQCAtMzI0LDYgKzMyNywzMiBAQCBzdGF0aWMgdm9p
ZCBoZXhhZ29uX2NwdV9zeW5jaHJvbml6ZV9mcm9tX3RiKENQVVN0YXRlICpjcywKICAgICBjcHVf
ZW52KGNzKS0+Z3ByW0hFWF9SRUdfUENdID0gdGItPnBjOwogfQogCisjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChDUFVIZXhhZ29uU3RhdGUg
KmVudikKK3sKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBlbnZfYXJjaGNwdShlbnYpOworICAgIGlm
ICghY3B1LT5nbG9iYWxyZWdzKSB7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICB1
aW50MzJfdCBtb2RlY3RsID0KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmds
b2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZW52LT50aHJlYWRJZCk7CisgICAgdWludDMyX3QgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdF
VF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVjdGwpOworICAgIGJvb2wgRV9iaXQgPSB0aHJlYWRfZW5h
YmxlZF9tYXNrICYgKDB4MSA8PCBlbnYtPnRocmVhZElkKTsKKworICAgIHJldHVybiBFX2JpdDsK
K30KKworc3RhdGljIGJvb2wgaGV4YWdvbl9jcHVfaGFzX3dvcmsoQ1BVU3RhdGUgKmNzKQorewor
ICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisKKyAgICByZXR1cm4gaGV4
YWdvbl90aHJlYWRfaXNfZW5hYmxlZChlbnYpICYmCisgICAgICAgIChjcy0+aW50ZXJydXB0X3Jl
cXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJEIHwgQ1BVX0lOVEVSUlVQVF9TV0kKKyAgICAgICAg
ICAgIHwgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sgfCBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0sp
KTsKK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBoZXhhZ29uX3Jlc3RvcmVfc3RhdGVfdG9fb3Bj
KENQVVN0YXRlICpjcywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29uc3QgVHJhbnNsYXRpb25CbG9jayAqdGIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IHVpbnQ2NF90ICpkYXRhKQpAQCAtNDE5LDEwICs0NDgsNTggQEAg
c3RhdGljIGludCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRj
aCkKICAgICByZXR1cm4gTU1VX1VTRVJfSURYOwogfQogCisjaWYgIWRlZmluZWQoQ09ORklHX1VT
RVJfT05MWSkKK3N0YXRpYyB2b2lkIGhleGFnb25fY3B1X3NldF9pcnEodm9pZCAqb3BhcXVlLCBp
bnQgaXJxLCBpbnQgbGV2ZWwpCit7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUo
b3BhcXVlKTsKKyAgICBDUFVTdGF0ZSAqY3MgPSBDUFUoY3B1KTsKKyAgICBDUFVIZXhhZ29uU3Rh
dGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisgICAgc3dpdGNoIChpcnEpIHsKKyAgICBjYXNlIEhF
WEFHT05fQ1BVX0lSUV8wIC4uLiBIRVhBR09OX0NQVV9JUlFfNzoKKyAgICAgICAgcWVtdV9sb2df
bWFzayhDUFVfTE9HX0lOVCwgIiVzOiBpcnEgJWQsIGxldmVsICVkXG4iLAorICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBpcnEsIGxldmVsKTsKKyAgICAgICAgaWYgKGxldmVsKSB7Cisg
ICAgICAgICAgICBoZXhfcmFpc2VfaW50ZXJydXB0cyhlbnYsIDEgPDwgaXJxLCBDUFVfSU5URVJS
VVBUX0hBUkQpOworICAgICAgICB9CisgICAgICAgIGJyZWFrOworICAgIGRlZmF1bHQ6CisgICAg
ICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgfQorfQorI2VuZGlmCisKIHN0YXRpYyB2
b2lkIGhleGFnb25fY3B1X2luaXQoT2JqZWN0ICpvYmopCiB7CisjaWYgIWRlZmluZWQoQ09ORklH
X1VTRVJfT05MWSkKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBIRVhBR09OX0NQVShvYmopOworICAg
IHFkZXZfaW5pdF9ncGlvX2luKERFVklDRShjcHUpLCBoZXhhZ29uX2NwdV9zZXRfaXJxLCA4KTsK
KyNlbmRpZgogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKworc3RhdGljIGJvb2wgaGV4
YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVl
c3QpCit7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKyAgICBpZiAo
aW50ZXJydXB0X3JlcXVlc3QgJiBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0spIHsKKyAgICAgICAg
Y3MtPmhhbHRlZCA9IGZhbHNlOworICAgICAgICBjcHVfcmVzZXRfaW50ZXJydXB0KGNzLCBDUFVf
SU5URVJSVVBUX1RMQl9VTkxPQ0spOworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisgICAg
aWYgKGludGVycnVwdF9yZXF1ZXN0ICYgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0spIHsKKyAgICAg
ICAgY3MtPmhhbHRlZCA9IGZhbHNlOworICAgICAgICBjcHVfcmVzZXRfaW50ZXJydXB0KGNzLCBD
UFVfSU5URVJSVVBUX0swX1VOTE9DSyk7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAg
ICBpZiAoaW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJEIHwgQ1BVX0lOVEVS
UlVQVF9TV0kpKSB7CisgICAgICAgIHJldHVybiBoZXhfY2hlY2tfaW50ZXJydXB0cyhlbnYpOwor
ICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKKyNlbmRpZgorCiBzdGF0aWMgY29uc3QgVENH
Q1BVT3BzIGhleGFnb25fdGNnX29wcyA9IHsKICAgICAvKiBNVFRDRyBub3QgeWV0IHN1cHBvcnRl
ZDogcmVxdWlyZSBzdHJpY3Qgb3JkZXJpbmcgKi8KICAgICAuZ3Vlc3RfZGVmYXVsdF9tZW1vcnlf
b3JkZXIgPSBUQ0dfTU9fQUxMLApAQCAtNDMzLDYgKzUxMCw5IEBAIHN0YXRpYyBjb25zdCBUQ0dD
UFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gewogICAgIC5zeW5jaHJvbml6ZV9mcm9tX3RiID0gaGV4
YWdvbl9jcHVfc3luY2hyb25pemVfZnJvbV90YiwKICAgICAucmVzdG9yZV9zdGF0ZV90b19vcGMg
PSBoZXhhZ29uX3Jlc3RvcmVfc3RhdGVfdG9fb3BjLAogICAgIC5tbXVfaW5kZXggPSBoZXhhZ29u
X2NwdV9tbXVfaW5kZXgsCisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKKyAgICAuY3B1
X2V4ZWNfaW50ZXJydXB0ID0gaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQsCisjZW5kaWYgLyog
IUNPTkZJR19VU0VSX09OTFkgKi8KIH07CiAKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCi0tIAoyLjM0LjEKCg==

