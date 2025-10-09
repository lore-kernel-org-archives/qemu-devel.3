Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8A0CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6woQ-0003rq-Fo; Thu, 09 Oct 2025 16:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6wnz-0003jK-Bz
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6wnt-0005Bk-Na
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EXTVD004534
 for <qemu-devel@nongnu.org>; Thu, 9 Oct 2025 19:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Isa/eockiO2T6XwpPtCm0webMPD/XLU/FpyDbbZgWZ0=; b=APZ+3TNMX1fGVGlV
 yUWJXDc+JJaLO8ibbyRtOHCdYqfwRYDunmGWJh7+Dl39kurTCmFt4bmpwFaZWrAG
 m9r4jukDajytmqqnipmYzv+9/37mATgZKWUBxX6Of/M6ptFBYGGOAGeEeXCui1jo
 RWdnwVN4aP4jF9xpoxBGyc9qADRJUSKtGGvCYVghXAa0Cc/JDNBPAL1qBnjE9o3m
 etXi5thKISP7KsHI6krzMSoTzH0PVc5VFvCexFEM7ccGoW0gWTlL20wrp8zHEmHL
 fr9JpJlvaUwqOgYPA0jhVCOFcICc6Xld+MYsyNLaawgW5idCuwMenObaZ8JAM7sW
 KdPaqw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j45wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 19:59:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-277f0ea6ee6so24865085ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039995; x=1760644795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Isa/eockiO2T6XwpPtCm0webMPD/XLU/FpyDbbZgWZ0=;
 b=a6NSiVbFhM1Q7BdetoPDfQ8MPfo2ktbDXoOc8tO5oRSrWCPYQBU6RZ/Si4wGdpSV5s
 Iea3dltw9fjm/iNPSA5OesT8X0IcPRGHB5wVcVSEYwXRAuNSkjxlTAUnD9NnzgHmT2Iy
 Lb8uuEYv1Kp9Wi7zKUuFOAuO6KH27yLV8g54YU544NXTxFcihxQnYCafzboyu4NPplvL
 HQm/EFbAx92XWLIVp5jn5Dr3knOA+Q77j8XdCGqpSwUUgiqeCCIMeU6Kfdzp0pVXU1WL
 KCX08Fz5G3yzH7qha9+2LhvUrFUzRSD8SjA6gn6PKXlAE/vj417fxO2xZZJ/c65oYhiD
 aK7Q==
X-Gm-Message-State: AOJu0YwNiqH+BEflemnZqFVj0fvL2jIzCyPgrVjC8i2rEda1Wp2XxYZ1
 Qm42JVqWsaBhhQC9y2XsuVhRYkJancLDih/urf87udHV3q99YEXQZsKTiDhd10per4CLpukTVNU
 2AwOBX2ReI2YrmHyWLDThUrgcBD/hpXSv+bt4N2uSYeF7gBgIR9obrX4Ibk7ZwImgMA==
X-Gm-Gg: ASbGnctFG9JU054D3B9r4xCEu4PByARrV7PTtI5anBPBF3DMNlOU/cDimDyZyOu4P6i
 p/NIRn33nhxqetxbcmMXObpJXzf/NjYspcT27MtSiuqZ+5hj9P1ksk6pPSEOuYXvnhWW773texy
 yX8hzVegKToN3jxROxP4RFda+K/AawqvHmHVvTlU1Bo7UftPUn6ugmiFlEKnaN6EG+TyNON7I9r
 6W8V1NMAiwWR8KnAvJAUXAd+/AO10gQLZzHRXhoYVSZzbGhFomUGRkmqXWoGwa7Sk5yQHRq8I4x
 QG19QfM/J0pqY4qJZSJOZ2rR2gAuBUckoV6mhUwWvw44AGBlOAlBgbqIJmfJOzi7PkSeNKdtUU6
 MvQxccM9kuvDDIssgqQ==
X-Received: by 2002:a17:903:a90:b0:27e:ef09:4ab6 with SMTP id
 d9443c01a7336-290270fa624mr111250685ad.0.1760039994995; 
 Thu, 09 Oct 2025 12:59:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhQGaXLOyYkxUIbE3kTVzqp971L4TQ95XJIgxe7s2EmSzuU+bisN5iYCO6kc+JOEqjvnDbYA==
X-Received: by 2002:a17:903:a90:b0:27e:ef09:4ab6 with SMTP id
 d9443c01a7336-290270fa624mr111250245ad.0.1760039994399; 
 Thu, 09 Oct 2025 12:59:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f32d6fsm36678805ad.96.2025.10.09.12.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 12:59:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 3/4] linux-user/hexagon: Use an array for GPRs
Date: Thu,  9 Oct 2025 12:59:42 -0700
Message-Id: <20251009195943.438454-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: TW_G-wUXv-RVCFTXSWoYY6aCpbiDEPov
X-Proofpoint-ORIG-GUID: TW_G-wUXv-RVCFTXSWoYY6aCpbiDEPov
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e8143c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=5cUriBZxpbMuX0570IYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX2zKzhnoz2Qna
 y3cODlc63gNU4VLVRhOwoy9dUjZtOufYJ0Jr3dFFTp0ygn6j5cL/kHngghcRkqDABWN6Qb/S1Mt
 u95mFq4eM0DmjugQDja2dmlcW3+jNP/zFFvlG06HnRhDTw95La/xGzZl255vIPeWbG4CFRue4Ee
 Y0XQ533QBtiYxa0fketppXor1LO2LZ1Ug4/mw+DYBcHFk1iKGkR+7vwkSjSHF4US24QN4HtnY5B
 ZRkfaxmRIraOobWqjMgloKzxp7S4iJ6fVo9mIHAl1X0WJhvFomw8xGbsiIYW9Iynr9FDrRixG9a
 Q6TrhGul+3c6zGflP5boQvNzsiujNomKXm0Z7qhVhRbOoDrYuEDVvVtMJzJZbYY5vId2Nw+Xr5s
 fXI9KZVGOAxg+8HjXHnk//unBJg8SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogbGludXgtdXNlci9oZXhhZ29uL3NpZ25hbC5j
IHwgNzkgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNzIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGludXgt
dXNlci9oZXhhZ29uL3NpZ25hbC5jIGIvbGludXgtdXNlci9oZXhhZ29uL3NpZ25hbC5jCmluZGV4
IGU1NTE0YjJiZWMuLjE4M2VjZmFhMTkgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9z
aWduYWwuYworKysgYi9saW51eC11c2VyL2hleGFnb24vc2lnbmFsLmMKQEAgLTI0LDE0ICsyNCw3
IEBACiAjaW5jbHVkZSAibGludXgtdXNlci90cmFjZS5oIgogCiBzdHJ1Y3QgdGFyZ2V0X3VzZXJf
cmVnc19zdHJ1Y3QgewotICAgIGFiaV91bG9uZyByMCwgIHIxLCAgcjIsICByMzsKLSAgICBhYmlf
dWxvbmcgcjQsICByNSwgIHI2LCAgcjc7Ci0gICAgYWJpX3Vsb25nIHI4LCAgcjksIHIxMCwgcjEx
OwotICAgIGFiaV91bG9uZyByMTIsIHIxMywgcjE0LCByMTU7Ci0gICAgYWJpX3Vsb25nIHIxNiwg
cjE3LCByMTgsIHIxOTsKLSAgICBhYmlfdWxvbmcgcjIwLCByMjEsIHIyMiwgcjIzOwotICAgIGFi
aV91bG9uZyByMjQsIHIyNSwgcjI2LCByMjc7Ci0gICAgYWJpX3Vsb25nIHIyOCwgcjI5LCByMzAs
IHIzMTsKKyAgICBhYmlfdWxvbmcgZ3ByWzMyXTsKICAgICBhYmlfdWxvbmcgc2EwOwogICAgIGFi
aV91bG9uZyBsYzA7CiAgICAgYWJpX3Vsb25nIHNhMTsKQEAgLTg3LDM4ICs4MCw5IEBAIHN0YXRp
YyB2b2lkIHNldHVwX3NpZ2NvbnRleHQoc3RydWN0IHRhcmdldF9zaWdjb250ZXh0ICpzYywgQ1BV
SGV4YWdvblN0YXRlICplbnYpCiB7CiAgICAgYWJpX3Vsb25nIHByZWRzID0gMDsKIAotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDBdLCAmc2MtPnNjX3JlZ3MucjApOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDFdLCAmc2MtPnNjX3JlZ3MucjEpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDJdLCAmc2MtPnNjX3JlZ3MucjIpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDNdLCAmc2MtPnNjX3JlZ3MucjMpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDRdLCAmc2MtPnNjX3JlZ3MucjQpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDVdLCAmc2MtPnNjX3JlZ3MucjUpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDZdLCAmc2MtPnNjX3JlZ3MucjYpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDddLCAmc2MtPnNjX3JlZ3MucjcpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDhdLCAmc2MtPnNjX3JlZ3MucjgpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDldLCAmc2MtPnNjX3JlZ3MucjkpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTBdLCAmc2MtPnNjX3JlZ3MucjEwKTsKLSAgICBf
X3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjExXSwgJnNjLT5zY19yZWdzLnIxMSk7Ci0gICAg
X19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxMl0sICZzYy0+c2NfcmVncy5yMTIpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTNdLCAmc2MtPnNjX3JlZ3MucjEzKTsKLSAg
ICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE0XSwgJnNjLT5zY19yZWdzLnIxNCk7Ci0g
ICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxNV0sICZzYy0+c2NfcmVncy5yMTUpOwot
ICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTZdLCAmc2MtPnNjX3JlZ3MucjE2KTsK
LSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE3XSwgJnNjLT5zY19yZWdzLnIxNyk7
Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxOF0sICZzYy0+c2NfcmVncy5yMTgp
OwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTldLCAmc2MtPnNjX3JlZ3MucjE5
KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjIwXSwgJnNjLT5zY19yZWdzLnIy
MCk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyMV0sICZzYy0+c2NfcmVncy5y
MjEpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjJdLCAmc2MtPnNjX3JlZ3Mu
cjIyKTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjIzXSwgJnNjLT5zY19yZWdz
LnIyMyk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyNF0sICZzYy0+c2NfcmVn
cy5yMjQpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjVdLCAmc2MtPnNjX3Jl
Z3MucjI1KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI2XSwgJnNjLT5zY19y
ZWdzLnIyNik7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyN10sICZzYy0+c2Nf
cmVncy5yMjcpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjhdLCAmc2MtPnNj
X3JlZ3MucjI4KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI5XSwgJnNjLT5z
Y19yZWdzLnIyOSk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IzMF0sICZzYy0+
c2NfcmVncy5yMzApOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMzFdLCAmc2Mt
PnNjX3JlZ3MucjMxKTsKKyAgICBmb3IgKGludCBpID0gMDsgaSA8IDMyOyBpKyspIHsKKyAgICAg
ICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMCArIGldLCAmc2MtPnNjX3JlZ3MuZ3By
W2ldKTsKKyAgICB9CiAgICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1NBMF0sICZzYy0+
c2NfcmVncy5zYTApOwogICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19MQzBdLCAmc2Mt
PnNjX3JlZ3MubGMwKTsKICAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfU0ExXSwgJnNj
LT5zY19yZWdzLnNhMSk7CkBAIC0yMTMsMzggKzE3Nyw5IEBAIHN0YXRpYyB2b2lkIHJlc3RvcmVf
c2lnY29udGV4dChDUFVIZXhhZ29uU3RhdGUgKmVudiwKIHsKICAgICBhYmlfdWxvbmcgcHJlZHM7
CiAKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAwXSwgJnNjLT5zY19yZWdzLnIw
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAxXSwgJnNjLT5zY19yZWdzLnIx
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAyXSwgJnNjLT5zY19yZWdzLnIy
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAzXSwgJnNjLT5zY19yZWdzLnIz
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA0XSwgJnNjLT5zY19yZWdzLnI0
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA1XSwgJnNjLT5zY19yZWdzLnI1
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA2XSwgJnNjLT5zY19yZWdzLnI2
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA3XSwgJnNjLT5zY19yZWdzLnI3
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA4XSwgJnNjLT5zY19yZWdzLnI4
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA5XSwgJnNjLT5zY19yZWdzLnI5
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjEwXSwgJnNjLT5zY19yZWdzLnIx
MCk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxMV0sICZzYy0+c2NfcmVncy5y
MTEpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTJdLCAmc2MtPnNjX3JlZ3Mu
cjEyKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjEzXSwgJnNjLT5zY19yZWdz
LnIxMyk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxNF0sICZzYy0+c2NfcmVn
cy5yMTQpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTVdLCAmc2MtPnNjX3Jl
Z3MucjE1KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE2XSwgJnNjLT5zY19y
ZWdzLnIxNik7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxN10sICZzYy0+c2Nf
cmVncy5yMTcpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMThdLCAmc2MtPnNj
X3JlZ3MucjE4KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE5XSwgJnNjLT5z
Y19yZWdzLnIxOSk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyMF0sICZzYy0+
c2NfcmVncy5yMjApOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjFdLCAmc2Mt
PnNjX3JlZ3MucjIxKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjIyXSwgJnNj
LT5zY19yZWdzLnIyMik7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyM10sICZz
Yy0+c2NfcmVncy5yMjMpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjRdLCAm
c2MtPnNjX3JlZ3MucjI0KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI1XSwg
JnNjLT5zY19yZWdzLnIyNSk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyNl0s
ICZzYy0+c2NfcmVncy5yMjYpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjdd
LCAmc2MtPnNjX3JlZ3MucjI3KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI4
XSwgJnNjLT5zY19yZWdzLnIyOCk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1Iy
OV0sICZzYy0+c2NfcmVncy5yMjkpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19S
MzBdLCAmc2MtPnNjX3JlZ3MucjMwKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdf
UjMxXSwgJnNjLT5zY19yZWdzLnIzMSk7CisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCAzMjsgaSsr
KSB7CisgICAgICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDAgKyBpXSwgJnNjLT5z
Y19yZWdzLmdwcltpXSk7CisgICAgfQogICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19T
QTBdLCAmc2MtPnNjX3JlZ3Muc2EwKTsKICAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdf
TEMwXSwgJnNjLT5zY19yZWdzLmxjMCk7CiAgICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVH
X1NBMV0sICZzYy0+c2NfcmVncy5zYTEpOwotLSAKMi4zNC4xCgo=

