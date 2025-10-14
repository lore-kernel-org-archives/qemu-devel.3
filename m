Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA88CCD194
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8f5p-0006Rc-QT; Tue, 14 Oct 2025 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v8f5n-0006Lo-1v
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:29:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v8f5f-00087H-GO
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:29:30 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87J3w025679
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=cXiq//Y1L2WZEjchNER208zmBOmNRHo8SJyT/mXI1X4=; b=lt
 Yj2FFWXz051Nq7KNasY9vxABbhkbKeRs/YZ7ZaZXZCkZeAS4ghvOU9EgRMqEM//H
 m8SGQCURgj93co7tvmAf82D6Hnfhxmi7ILDHjXLMdYk/Vi7iIT6vXaXB4bKZ3Fid
 9iKUyxnysYxSKqqpPIjtkJYcCuQK4O31ebxMBJaRHporPVF2iqU9zOt7DEW4STa9
 SBaz+50aLTNQIqB41q1dtOopXfEnMdjfUKyzmTHNpLe+WZl0zsX740yhr+we0jqR
 /Iz/u/iaeVMFBOoPuw7c9goD+0EZODkMnmBGOhOWMD2L5LGtpDkcoQ9tunKce9fd
 /qnd96LwBgUvq37OQY1g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg0gff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:29:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b62cdd71290so8741593a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760448560; x=1761053360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXiq//Y1L2WZEjchNER208zmBOmNRHo8SJyT/mXI1X4=;
 b=RdMckqQkPM0kFiUtB5bHIXIyk5Z/n1v/EqHCeYpvovzaHO4YnPN+n49WFLpJI88goH
 YF06aRq4W0jEgVO5xq6X13SEjg0H9ehItMSwhqWIt/t6ZYi1aaAiYL5eShHy4KGja1Ld
 Fhn+qvtWeHa5FV+ilq5rE9HW8Ni44hMBfAZQx/LWCL5kM+1hd1PACI5VmTCT2rbSuuVF
 7Pmlv8Ou2JzqGtW1WRjkcY/AyCay2tK1YBe8ieVTxV264Ycv+9ZgRDGLvZAYIg6+39n5
 1RasliSEOmHN2fkKXE/vxGiRMj3B56pqZnKbbxUpSuOVSZEOFNLNm+CU7tumQDI0OmGe
 emuA==
X-Gm-Message-State: AOJu0YwzaGEptgLG1mc9tr/G1+QWJqquVi117ZiAanDX0ZfQsr/W3xNK
 6+f+HfYTt3uR3ObBjv8YJsSe/zImabMJLAxsu0q9PjNecLd+uwD3LgS1Irh/LNRAe5nlsm/9dUG
 wWhzblFCcXrBr0PtIz6YK3xILe9IF/mmbEHdgFT36bcE0dDA4/IQUiqaoA3ZAYxvXXQ==
X-Gm-Gg: ASbGncs8+6MSKFPfeBuoi3yJaeKy6PKOTAW6scEMyRlbHLO+cyOzvOKGDpqRDijQ0R1
 x0zXuOe6zvT/5fXJB0YKaPGrGTgtmRWIfKovHP0b8n9dJEYNwXM3mB1bEAB4GPIZ64N0eoMldne
 Pi/u2HJbHOjJCN1+IDpsz+N5mu/44tENfLUe1HrFf3URS1cC6fsmrssI4DdwOkNItsah9ZxSusa
 wNlmWQicnpyBHTdchv1T3n4m7TuV+19m6UdLUSVfabFFsLeRzF8TUnZUnSXyN1BNjBPBD5TxdgR
 unIRy+lffq8W4AFuDpkRwHuyPPs2C3Gj2Ybv6tO3qGWDok5LKW0QG2JJst6afMDQFWwi/Jv8Ezm
 fv8klgp0z2iUT
X-Received: by 2002:a17:903:1b6b:b0:26a:6d5a:944e with SMTP id
 d9443c01a7336-29027f271ecmr280582455ad.24.1760448559496; 
 Tue, 14 Oct 2025 06:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRl3mPv3BIa0hEepHcMDjkNoanXXGhSIGgum8Jc176V1AlCHlIsIKbEIKkZorw73MmfH7KHg==
X-Received: by 2002:a17:903:1b6b:b0:26a:6d5a:944e with SMTP id
 d9443c01a7336-29027f271ecmr280582025ad.24.1760448558843; 
 Tue, 14 Oct 2025 06:29:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f07275sm164478125ad.66.2025.10.14.06.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:29:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 3/4] linux-user/hexagon: Use an array for GPRs
Date: Tue, 14 Oct 2025 06:29:06 -0700
Message-Id: <20251014132907.3268743-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014132907.3268743-1-brian.cain@oss.qualcomm.com>
References: <20251014132907.3268743-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfXxxhTY7IrOUM1
 iF7I6MkaA51c+k29eW7329KHTk5IVVD/mdghTY+ANxnOqmjVLzzN+MYs4N1QW8siqTRuLbpmY3X
 bm8mzfiKE1z07ghrkyecYPGQq5ZeYu4fRf9gWl1SLmu4DGIFle5Q5Rwh6I1QEcVBokHYVZ7zvni
 5k2PD0cm3Jxa9DGUmFXmiDFUMOd0Z8+Gv51Q1AGPxj15PEvDQN6uzinlRUaUrBp3UBHQpkiAS/K
 MD5G0KsfvkL7wmUVQMKeylgKcver7VwTaLd/Xp7VKUGRDWt0gOEcm1DXZk77z5wngzaU+SKjRWz
 FdeJErBEV6hMQO9oXraAoi6+Fx8TsF1SPRXeTbCiEFt7YdNnBJcAsupkjv2PvSVIQYDe1sIBm2d
 ofZL4ylJsly7UJEZZVvBWrRM0KAORg==
X-Proofpoint-GUID: fJ3ArfrjA_4kvJC2UnMvj_8TpI6XDOBO
X-Proofpoint-ORIG-GUID: fJ3ArfrjA_4kvJC2UnMvj_8TpI6XDOBO
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ee5031 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=LLBtXp-KmgwZ27-6YZ8A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdvbi9zaWduYWwuYyB8
IDc5ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVz
ZXIvaGV4YWdvbi9zaWduYWwuYyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9zaWduYWwuYwppbmRleCBl
NTUxNGIyYmVjLi4xODNlY2ZhYTE5IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hleGFnb24vc2ln
bmFsLmMKKysrIGIvbGludXgtdXNlci9oZXhhZ29uL3NpZ25hbC5jCkBAIC0yNCwxNCArMjQsNyBA
QAogI2luY2x1ZGUgImxpbnV4LXVzZXIvdHJhY2UuaCIKIAogc3RydWN0IHRhcmdldF91c2VyX3Jl
Z3Nfc3RydWN0IHsKLSAgICBhYmlfdWxvbmcgcjAsICByMSwgIHIyLCAgcjM7Ci0gICAgYWJpX3Vs
b25nIHI0LCAgcjUsICByNiwgIHI3OwotICAgIGFiaV91bG9uZyByOCwgIHI5LCByMTAsIHIxMTsK
LSAgICBhYmlfdWxvbmcgcjEyLCByMTMsIHIxNCwgcjE1OwotICAgIGFiaV91bG9uZyByMTYsIHIx
NywgcjE4LCByMTk7Ci0gICAgYWJpX3Vsb25nIHIyMCwgcjIxLCByMjIsIHIyMzsKLSAgICBhYmlf
dWxvbmcgcjI0LCByMjUsIHIyNiwgcjI3OwotICAgIGFiaV91bG9uZyByMjgsIHIyOSwgcjMwLCBy
MzE7CisgICAgYWJpX3Vsb25nIGdwclszMl07CiAgICAgYWJpX3Vsb25nIHNhMDsKICAgICBhYmlf
dWxvbmcgbGMwOwogICAgIGFiaV91bG9uZyBzYTE7CkBAIC04NywzOCArODAsOSBAQCBzdGF0aWMg
dm9pZCBzZXR1cF9zaWdjb250ZXh0KHN0cnVjdCB0YXJnZXRfc2lnY29udGV4dCAqc2MsIENQVUhl
eGFnb25TdGF0ZSAqZW52KQogewogICAgIGFiaV91bG9uZyBwcmVkcyA9IDA7CiAKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAwXSwgJnNjLT5zY19yZWdzLnIwKTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAxXSwgJnNjLT5zY19yZWdzLnIxKTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAyXSwgJnNjLT5zY19yZWdzLnIyKTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAzXSwgJnNjLT5zY19yZWdzLnIzKTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA0XSwgJnNjLT5zY19yZWdzLnI0KTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA1XSwgJnNjLT5zY19yZWdzLnI1KTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA2XSwgJnNjLT5zY19yZWdzLnI2KTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA3XSwgJnNjLT5zY19yZWdzLnI3KTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA4XSwgJnNjLT5zY19yZWdzLnI4KTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjA5XSwgJnNjLT5zY19yZWdzLnI5KTsKLSAgICBfX3B1
dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjEwXSwgJnNjLT5zY19yZWdzLnIxMCk7Ci0gICAgX19w
dXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxMV0sICZzYy0+c2NfcmVncy5yMTEpOwotICAgIF9f
cHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTJdLCAmc2MtPnNjX3JlZ3MucjEyKTsKLSAgICBf
X3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjEzXSwgJnNjLT5zY19yZWdzLnIxMyk7Ci0gICAg
X19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxNF0sICZzYy0+c2NfcmVncy5yMTQpOwotICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTVdLCAmc2MtPnNjX3JlZ3MucjE1KTsKLSAg
ICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE2XSwgJnNjLT5zY19yZWdzLnIxNik7Ci0g
ICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxN10sICZzYy0+c2NfcmVncy5yMTcpOwot
ICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMThdLCAmc2MtPnNjX3JlZ3MucjE4KTsK
LSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE5XSwgJnNjLT5zY19yZWdzLnIxOSk7
Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyMF0sICZzYy0+c2NfcmVncy5yMjAp
OwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjFdLCAmc2MtPnNjX3JlZ3MucjIx
KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjIyXSwgJnNjLT5zY19yZWdzLnIy
Mik7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyM10sICZzYy0+c2NfcmVncy5y
MjMpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjRdLCAmc2MtPnNjX3JlZ3Mu
cjI0KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI1XSwgJnNjLT5zY19yZWdz
LnIyNSk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyNl0sICZzYy0+c2NfcmVn
cy5yMjYpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjddLCAmc2MtPnNjX3Jl
Z3MucjI3KTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI4XSwgJnNjLT5zY19y
ZWdzLnIyOCk7Ci0gICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyOV0sICZzYy0+c2Nf
cmVncy5yMjkpOwotICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMzBdLCAmc2MtPnNj
X3JlZ3MucjMwKTsKLSAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjMxXSwgJnNjLT5z
Y19yZWdzLnIzMSk7CisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCAzMjsgaSsrKSB7CisgICAgICAg
IF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMDAgKyBpXSwgJnNjLT5zY19yZWdzLmdwcltp
XSk7CisgICAgfQogICAgIF9fcHV0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19TQTBdLCAmc2MtPnNj
X3JlZ3Muc2EwKTsKICAgICBfX3B1dF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfTEMwXSwgJnNjLT5z
Y19yZWdzLmxjMCk7CiAgICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1NBMV0sICZzYy0+
c2NfcmVncy5zYTEpOwpAQCAtMjEzLDM4ICsxNzcsOSBAQCBzdGF0aWMgdm9pZCByZXN0b3JlX3Np
Z2NvbnRleHQoQ1BVSGV4YWdvblN0YXRlICplbnYsCiB7CiAgICAgYWJpX3Vsb25nIHByZWRzOwog
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMF0sICZzYy0+c2NfcmVncy5yMCk7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMV0sICZzYy0+c2NfcmVncy5yMSk7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMl0sICZzYy0+c2NfcmVncy5yMik7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwM10sICZzYy0+c2NfcmVncy5yMyk7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwNF0sICZzYy0+c2NfcmVncy5yNCk7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwNV0sICZzYy0+c2NfcmVncy5yNSk7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwNl0sICZzYy0+c2NfcmVncy5yNik7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwN10sICZzYy0+c2NfcmVncy5yNyk7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwOF0sICZzYy0+c2NfcmVncy5yOCk7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwOV0sICZzYy0+c2NfcmVncy5yOSk7
Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxMF0sICZzYy0+c2NfcmVncy5yMTAp
OwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTFdLCAmc2MtPnNjX3JlZ3MucjEx
KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjEyXSwgJnNjLT5zY19yZWdzLnIx
Mik7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxM10sICZzYy0+c2NfcmVncy5y
MTMpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTRdLCAmc2MtPnNjX3JlZ3Mu
cjE0KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE1XSwgJnNjLT5zY19yZWdz
LnIxNSk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxNl0sICZzYy0+c2NfcmVn
cy5yMTYpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMTddLCAmc2MtPnNjX3Jl
Z3MucjE3KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjE4XSwgJnNjLT5zY19y
ZWdzLnIxOCk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IxOV0sICZzYy0+c2Nf
cmVncy5yMTkpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjBdLCAmc2MtPnNj
X3JlZ3MucjIwKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjIxXSwgJnNjLT5z
Y19yZWdzLnIyMSk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyMl0sICZzYy0+
c2NfcmVncy5yMjIpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjNdLCAmc2Mt
PnNjX3JlZ3MucjIzKTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI0XSwgJnNj
LT5zY19yZWdzLnIyNCk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyNV0sICZz
Yy0+c2NfcmVncy5yMjUpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjZdLCAm
c2MtPnNjX3JlZ3MucjI2KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjI3XSwg
JnNjLT5zY19yZWdzLnIyNyk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IyOF0s
ICZzYy0+c2NfcmVncy5yMjgpOwotICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19SMjld
LCAmc2MtPnNjX3JlZ3MucjI5KTsKLSAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjMw
XSwgJnNjLT5zY19yZWdzLnIzMCk7Ci0gICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1Iz
MV0sICZzYy0+c2NfcmVncy5yMzEpOworICAgIGZvciAoaW50IGkgPSAwOyBpIDwgMzI7IGkrKykg
eworICAgICAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfUjAwICsgaV0sICZzYy0+c2Nf
cmVncy5ncHJbaV0pOworICAgIH0KICAgICBfX2dldF91c2VyKGVudi0+Z3ByW0hFWF9SRUdfU0Ew
XSwgJnNjLT5zY19yZWdzLnNhMCk7CiAgICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX0xD
MF0sICZzYy0+c2NfcmVncy5sYzApOwogICAgIF9fZ2V0X3VzZXIoZW52LT5ncHJbSEVYX1JFR19T
QTFdLCAmc2MtPnNjX3JlZ3Muc2ExKTsKLS0gCjIuMzQuMQoK

