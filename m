Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCE9CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rQ4-0004Yo-9Z; Fri, 17 Oct 2025 16:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPj-0004Qs-HJ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPd-00031K-34
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGDK6004525
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=ROsJMfRuO3p+CtCOqryrjZx0lH6m5QHobxOwGbayBvA=; b=dS
 1+VR2Evf4IHwGhDaId76TlcJEGp2UyJSUHz5QGbyhRDxKQwWOR9LvjKdsF/oRKfM
 jmYyoIQr2Em43ChVf3jBk23KrNg/c7ZZlXBy+uNl7Om4RyddP0M2TkqJVjEuj8sK
 ZlZIdJotQtG33PNORwPXylJH3j70Ug4dYhcRIJJ7X4y362o9hBl4QeCLOSU9Fljo
 klYir0W/h20jl1XJbELogKKcmeqYe1X9nyWBqxnAAvR5zMHstbhFL1t2QnoclQLP
 FAE3MT3W+8v6xAbLbHN2ArlIyVh5rHOFVpsMYVElZAsKGMHDqVrWuoBn25QHnoDv
 6BH22ZZBvajGCq1cXcWw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5wu9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-79e43c51e6fso1667546b3a.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 13:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760734253; x=1761339053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROsJMfRuO3p+CtCOqryrjZx0lH6m5QHobxOwGbayBvA=;
 b=g2blabWxX6uzFNaXTaw5ieymHWIutFLO5Bg1FxsTMChSf9B0C7PvjbYPF1urkmALCo
 0XP/yGgSu+Op7T9WfWjln1An7AH3F88zPl4XvxrD+T/zoGH00LyjB3qT9FQCKix3XJNQ
 90g7DV0YYiq3hnP5JwVqEkgmn1ajRYLfADR1J6xYbjBhRBnulqA9f6oVnF29yHbkIIqo
 JNgekyFX0yR+VH2jaBthqfB1i8fXSsDk+hQGm0dBtf2SXb4mPZBl2IgmEpTx4vKWDn/1
 MApYlOdMtepcgfpvbOEPJMykB3uVhegZZnNd8cAe4cZP80As/pwFORdIJnJyxMCn+bjq
 rTLA==
X-Gm-Message-State: AOJu0YwwNYXqnViMGM6ykdhbxceh4aMbsTU8XaF8mo/cYk5WByESyjjx
 7Xkk4o5y43C23XVObKaoSU1wLeYvtPVHkpEIB9xn5/kC2e2s/caYdPOdTYQStS7vJrPq6N8+mfn
 b1tJUXKkQvCMbh3YDhuhMlnJVVWjjVpTVC2bixvk3kseLKcgmG1pJf8hAa+HUL1m8pg==
X-Gm-Gg: ASbGnctwW+E6NZWEfmT8D3ubAyhtmA81DnqhK5Np9kaJ1VXfqpsID9PaEn6x4hScAjd
 JvLNGRWsscKwVbof41nKhdukQKwblU86wpvzsqMCFZHdX9AHV1KdrvA1Fcsjb8hv8JpMktJVYAy
 bVtuLb9NiHCzC6jS4Aen46dCZ6io0Xj0+m21Yf1VIXvbLoKrL5GTlRbyxuMuTYpZoxNGXhLCXWD
 TVjsVg1k8iw5T2LbtEq2jQbYbi1Q2/KIA5mWl34KnO1cNXLcy4IN0gKB6ZGcSeDWl5RgEpv/+qn
 wHqFG/MBQ6+T8r5y+ydUyjaU7QtaC7kywh8LtL3Q9haP79bFM+G7Vx3UlguNpygxuSOMAoiFR1o
 jfp6XCvIPT+Sy46KUFJjaPK47aHWh6ZSa+qp/6/MtDWj3mSE=
X-Received: by 2002:a05:6a00:1ad1:b0:783:44b9:cbc9 with SMTP id
 d2e1a72fcca58-7a210f59a7dmr11130181b3a.9.1760734252730; 
 Fri, 17 Oct 2025 13:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmAB5puoHHZHx3SMZPe7qgskd8obIfxwvuw3Q26qycuUywwsQRF9JK1OPpTh9lugXIlKcqQg==
X-Received: by 2002:a05:6a00:1ad1:b0:783:44b9:cbc9 with SMTP id
 d2e1a72fcca58-7a210f59a7dmr11130160b3a.9.1760734252266; 
 Fri, 17 Oct 2025 13:50:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f251fsm495080b3a.39.2025.10.17.13.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:50:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 3/8] linux-user/hexagon: Use an array for GPRs
Date: Fri, 17 Oct 2025 13:50:23 -0700
Message-Id: <20251017205028.1105595-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
References: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 6M_IBiLkBixHPqvycOUHOe_4-v7ifDmx
X-Proofpoint-ORIG-GUID: 6M_IBiLkBixHPqvycOUHOe_4-v7ifDmx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfXzIEQ00Ly7twV
 DzW5aWTU+eut/F0DSjlTL6jNJlrdNltT3+ZDYGUlRFqE/6gHs4KDW1o4cwQ41Sc0BWOqpTENTNM
 qFAM5CQQr0Wvh7avswDh7F7JSs8p1C5MUZIhZHZa4tzmkMM8BjR8BiyoJq3ZappTm2B1PdC6HAM
 /suJl7PJS6FChVEmY4oW07zqeF+dQDPN7c5LXyh63l4OJXHyOqxw//CnOztymdTpf2JepjZZLXs
 KAMVAARXjY1MXZcVIbsqnzkHlRXjtRCGfizOjRZNuDLLT+n4vJxSaBUQBoGT6NK1DvWb0LW4+Zj
 bvP4Y14UVG/Z0YpP6Z6GNXDFkzAwIWGad7iGBunin2gOT4LK3QZq8RqGDI+RhpQzXM8pbswki6/
 nRYBr9yQAxlMezQbgtYJdQIkN55CZg==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f2ac2e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=5-iGLm-LtT_B5TT3xKgA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8wMjNlMDFkYzM4OWMkZmFm
ODQzMjAkZjBlOGM5NjAkQGdtYWlsLmNvbS8KU3VnZ2VzdGVkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0
YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogbGludXgtdXNlci9oZXhhZ29uL3NpZ25h
bC5jIHwgNzkgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNzIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGlu
dXgtdXNlci9oZXhhZ29uL3NpZ25hbC5jIGIvbGludXgtdXNlci9oZXhhZ29uL3NpZ25hbC5jCmlu
ZGV4IGU1NTE0YjJiZWMuLjE4M2VjZmFhMTkgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdv
bi9zaWduYWwuYworKysgYi9saW51eC11c2VyL2hleGFnb24vc2lnbmFsLmMKQEAgLTI0LDE0ICsy
NCw3IEBACiAjaW5jbHVkZSAibGludXgtdXNlci90cmFjZS5oIgogCiBzdHJ1Y3QgdGFyZ2V0X3Vz
ZXJfcmVnc19zdHJ1Y3QgewotICAgIGFiaV91bG9uZyByMCwgIHIxLCAgcjIsICByMzsKLSAgICBh
YmlfdWxvbmcgcjQsICByNSwgIHI2LCAgcjc7Ci0gICAgYWJpX3Vsb25nIHI4LCAgcjksIHIxMCwg
cjExOwotICAgIGFiaV91bG9uZyByMTIsIHIxMywgcjE0LCByMTU7Ci0gICAgYWJpX3Vsb25nIHIx
NiwgcjE3LCByMTgsIHIxOTsKLSAgICBhYmlfdWxvbmcgcjIwLCByMjEsIHIyMiwgcjIzOwotICAg
IGFiaV91bG9uZyByMjQsIHIyNSwgcjI2LCByMjc7Ci0gICAgYWJpX3Vsb25nIHIyOCwgcjI5LCBy
MzAsIHIzMTsKKyAgICBhYmlfdWxvbmcgZ3ByWzMyXTsKICAgICBhYmlfdWxvbmcgc2EwOwogICAg
IGFiaV91bG9uZyBsYzA7CiAgICAgYWJpX3Vsb25nIHNhMTsKQEAgLTg3LDM4ICs4MCw5IEBAIHN0
YXRpYyB2b2lkIHNldHVwX3NpZ2NvbnRleHQoc3RydWN0IHRhcmdldF9zaWdjb250ZXh0ICpzYywg
Q1BVSGV4YWdvblN0YXRlICplbnYpCiB7CiAgICAgYWJpX3Vsb25nIHByZWRzID0gMDsKIAotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDBdLCAmc2MtPnNjX3JlZ3MucjApOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDFdLCAmc2MtPnNjX3JlZ3MucjEpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDJdLCAmc2MtPnNjX3JlZ3MucjIpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDNdLCAmc2MtPnNjX3JlZ3MucjMpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDRdLCAmc2MtPnNjX3JlZ3MucjQpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDVdLCAmc2MtPnNjX3JlZ3MucjUpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDZdLCAmc2MtPnNjX3JlZ3MucjYpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDddLCAmc2MtPnNjX3JlZ3MucjcpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDhdLCAmc2MtPnNjX3JlZ3MucjgpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDldLCAmc2MtPnNjX3JlZ3MucjkpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTBdLCAmc2MtPnNjX3JlZ3MucjEwKTsKLSAg
ICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjExXSwgJnNjLT5zY19yZWdzLnIxMSk7Ci0g
ICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxMl0sICZzYy0+c2NfcmVncy5yMTIpOwot
ICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTNdLCAmc2MtPnNjX3JlZ3MucjEzKTsK
LSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE0XSwgJnNjLT5zY19yZWdzLnIxNCk7
Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxNV0sICZzYy0+c2NfcmVncy5yMTUp
OwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTZdLCAmc2MtPnNjX3JlZ3MucjE2
KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE3XSwgJnNjLT5zY19yZWdzLnIx
Nyk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxOF0sICZzYy0+c2NfcmVncy5y
MTgpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTldLCAmc2MtPnNjX3JlZ3Mu
cjE5KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjIwXSwgJnNjLT5zY19yZWdz
LnIyMCk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyMV0sICZzYy0+c2NfcmVn
cy5yMjEpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjJdLCAmc2MtPnNjX3Jl
Z3MucjIyKTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjIzXSwgJnNjLT5zY19y
ZWdzLnIyMyk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyNF0sICZzYy0+c2Nf
cmVncy5yMjQpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjVdLCAmc2MtPnNj
X3JlZ3MucjI1KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI2XSwgJnNjLT5z
Y19yZWdzLnIyNik7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyN10sICZzYy0+
c2NfcmVncy5yMjcpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjhdLCAmc2Mt
PnNjX3JlZ3MucjI4KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI5XSwgJnNj
LT5zY19yZWdzLnIyOSk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IzMF0sICZz
Yy0+c2NfcmVncy5yMzApOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMzFdLCAm
c2MtPnNjX3JlZ3MucjMxKTsKKyAgICBmb3IgKGludCBpID0gMDsgaSA8IDMyOyBpKyspIHsKKyAg
ICAgICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMCArIGldLCAmc2MtPnNjX3JlZ3Mu
Z3ByW2ldKTsKKyAgICB9CiAgICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1NBMF0sICZz
Yy0+c2NfcmVncy5zYTApOwogICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19MQzBdLCAm
c2MtPnNjX3JlZ3MubGMwKTsKICAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfU0ExXSwg
JnNjLT5zY19yZWdzLnNhMSk7CkBAIC0yMTMsMzggKzE3Nyw5IEBAIHN0YXRpYyB2b2lkIHJlc3Rv
cmVfc2lnY29udGV4dChDUFVIZXhhZ29uU3RhdGUgKmVudiwKIHsKICAgICBhYmlfdWxvbmcgcHJl
ZHM7CiAKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAwXSwgJnNjLT5zY19yZWdz
LnIwKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAxXSwgJnNjLT5zY19yZWdz
LnIxKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAyXSwgJnNjLT5zY19yZWdz
LnIyKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAzXSwgJnNjLT5zY19yZWdz
LnIzKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA0XSwgJnNjLT5zY19yZWdz
LnI0KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA1XSwgJnNjLT5zY19yZWdz
LnI1KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA2XSwgJnNjLT5zY19yZWdz
LnI2KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA3XSwgJnNjLT5zY19yZWdz
LnI3KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA4XSwgJnNjLT5zY19yZWdz
LnI4KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA5XSwgJnNjLT5zY19yZWdz
LnI5KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjEwXSwgJnNjLT5zY19yZWdz
LnIxMCk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxMV0sICZzYy0+c2NfcmVn
cy5yMTEpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTJdLCAmc2MtPnNjX3Jl
Z3MucjEyKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjEzXSwgJnNjLT5zY19y
ZWdzLnIxMyk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxNF0sICZzYy0+c2Nf
cmVncy5yMTQpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTVdLCAmc2MtPnNj
X3JlZ3MucjE1KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE2XSwgJnNjLT5z
Y19yZWdzLnIxNik7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxN10sICZzYy0+
c2NfcmVncy5yMTcpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMThdLCAmc2Mt
PnNjX3JlZ3MucjE4KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE5XSwgJnNj
LT5zY19yZWdzLnIxOSk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyMF0sICZz
Yy0+c2NfcmVncy5yMjApOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjFdLCAm
c2MtPnNjX3JlZ3MucjIxKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjIyXSwg
JnNjLT5zY19yZWdzLnIyMik7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyM10s
ICZzYy0+c2NfcmVncy5yMjMpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjRd
LCAmc2MtPnNjX3JlZ3MucjI0KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI1
XSwgJnNjLT5zY19yZWdzLnIyNSk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1Iy
Nl0sICZzYy0+c2NfcmVncy5yMjYpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19S
MjddLCAmc2MtPnNjX3JlZ3MucjI3KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdf
UjI4XSwgJnNjLT5zY19yZWdzLnIyOCk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVH
X1IyOV0sICZzYy0+c2NfcmVncy5yMjkpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JF
R19SMzBdLCAmc2MtPnNjX3JlZ3MucjMwKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9S
RUdfUjMxXSwgJnNjLT5zY19yZWdzLnIzMSk7CisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCAzMjsg
aSsrKSB7CisgICAgICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDAgKyBpXSwgJnNj
LT5zY19yZWdzLmdwcltpXSk7CisgICAgfQogICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JF
R19TQTBdLCAmc2MtPnNjX3JlZ3Muc2EwKTsKICAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9S
RUdfTEMwXSwgJnNjLT5zY19yZWdzLmxjMCk7CiAgICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhf
UkVHX1NBMV0sICZzYy0+c2NfcmVncy5zYTEpOwotLSAKMi4zNC4xCgo=

