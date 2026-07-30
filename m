Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32554C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZm-0005hn-F3; Wed, 29 Jul 2026 21:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZk-0005hB-8p
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZi-0005aq-MS
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1Njoe3460315
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=x33rKD5AJt14CHYPvmx76d8qJqPC6RXtU8ksUlr6PXc=; b=mn
 OtqlsxyoptgwqERvcCnXXTtO8NlmzZes0QzBrXAqRNeIfxwY1T7R2O52grK6JyNz
 dyoQpeW5aZZqVqrzsxhyKA/XNYWHYAkSIWddQNtk/YYB+dLGBzFPlYcrsSutTIrT
 Vz2n02OZp75B/GxA8twk2lncvVN6qDF1L7B8/iw1IzSnBpTskR3xpJSni3nGWCbb
 S8+SP571oVf1tBvePW4xRpz/h+wH12EBdItP5sEnW/n/T7KQpme61SFAP/Jsr7bz
 p3nZFlc4YQlzQ3vMs6vAFKDUwItQ/XDi7so8QernH+EpBvVV/+WrPNbZNQG3gY+U
 kYo2tUBGnTzRwe5mO7lA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvwpg0f7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848860def2cso1828471b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374920; x=1785979720; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x33rKD5AJt14CHYPvmx76d8qJqPC6RXtU8ksUlr6PXc=;
 b=aKke9LhxG82i28+eefKmR7qrOtSoXvr4SBh5W1bW/68sMgJI6z6+xctn/2Zg9rxcT/
 MRYQcSl2ui1o9MPS8ECenO1pJhg+SFAJmp4zNGg8Ena06dvUPSwnRziJJvF+4yMij3d6
 sDOeWdnqygKyDPJJ5untayyonAt5aSkVPNoHI4MuP414yKOzOLFONn+kBJDHrWRPHvpO
 fmkXOcR/scYsbfO7WQf46tlaNGGrVxLa/0I6NJNXbpYrLTh3VKelx+OUfSSDC/uP14KC
 zZ1nr2nVnk9o3jmPGxCFotXoPMUnMO2G2hsfdv29PxPjsoIpCItrrHlvLXjn1aClAOid
 XIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374920; x=1785979720;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x33rKD5AJt14CHYPvmx76d8qJqPC6RXtU8ksUlr6PXc=;
 b=s6QVQUH94LM2qKaLAIGzJ18uVtUttXFH0pbbFf55+H2AVQg4Y1C3Sxxa1L6vvaAhT1
 t77k8synAAfOh9FKUFkbUz2jop3pQfwDZGgh6ASk1aFClz+W0Pv9OvMzt3GRicv0fnPy
 AtxeAH8LR4Nlse4ccvtyjsK23ZwOPyI5SOvkLAbRfRCu3tYbd+fQRBjsdmgrjBi65S2k
 7IyQ/mBc/apC8X9zIYHxCBYevoEgJwEz0kh3hyOFKb+MxSuwk0Ped+JFlZkF7sBP4NQB
 Sed9TLLLrjtXXVhBDtzNid/9wbZSnEXpI/guQ6uKTOXWWlpis/2ugERO6ZCWJsYz5EMt
 31Gg==
X-Gm-Message-State: AOJu0Yxb6ECrnlwIzSXKQeUr/SyMJmQlHs8fMann7W4phBhIeN/oMrIq
 JLU3uvUzTQRxUeygW8lIITGVkir2eYj4K1cU1d2uxqtqKbj9YrzIVmBOIYGZBEdNDYgpCcMjb6G
 PueDPfvFkdMbZAGRuKgNmL29VWA+f+QaEUilMSCuOFlLDMvNofj60pw2Gk6PYTC6p2g==
X-Gm-Gg: AR+sD101fVjXOxJEvYY7cbTIskZYDz6nzWxbZ8L18v6wHRuRyrmZDrCE2c/MSb75js6
 YS3uUi29+/2+Kq0t/SuHapyoI2bEUxkPTec6NwQ2DzExjFMHW4yJnsXECZ3kug5pDqOlXhIGG0n
 VNRcVuHnIVyqVo5GPi9kSBvQ3JDCX63KEDrSaMUNxOlO1yxVeTlgSU4noUbwW1O+bMrqQrjcnlO
 mhiOICIohh+kB2qnH/kqEucQrSaosnm58BJ0XXAgQJPa8pBGVU9PBd/4HkrC679SAwvODM6EhOE
 VIlHPulv12Aaei7U1tyM0+WhEaLNHhA48BS6fjMSOfs8YyhIqcakq/K/WYoERnf2iDGirVgY1NQ
 xrKAtdkeMnnTIrK86PU408PxBoBouhAtcu231q8RBjwVENWXm
X-Received: by 2002:a05:6a21:6b10:b0:3bf:836e:876e with SMTP id
 adf61e73a8af0-3c9008adf74mr467322637.44.1785374920248; 
 Wed, 29 Jul 2026 18:28:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b10:b0:3bf:836e:876e with SMTP id
 adf61e73a8af0-3c9008adf74mr467290637.44.1785374919827; 
 Wed, 29 Jul 2026 18:28:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 10/18] hw/hexagon/virt: instantiate virtio-mmio transports
Date: Wed, 29 Jul 2026 18:28:15 -0700
Message-Id: <20260730012824.1135905-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: b86mPo57uFJb8yN2pduHToPZ4XK_Jo_t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX4si27H2YAx8A
 uTdB9DCIwmTWXDDqByx+7jcRn317HZZmNSZPDe2k6fgUNIwnWXJaY24iYCBWAovVUb7+/edPxg4
 cIjCXKfENPJsgDkZdwx8w5S8CoHbyMo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX8nZqMH2IGRk5
 zxFbk6+MMJUVoRwm+MIg8j5NzQNQa1m3ytKrfAU0XKbiGCJXLvmBtVSxfyPSXXIeBjEuYvZvLOs
 ldGmwHoSwTRlVnFdcmLvBtLKrcFEd5kBEkOn1q4B/55NModFSZrREmJul1VZMT3DgRlOW2+TfaP
 1H/pkjgC3Qlgftn0tiBUpQFS76TmgGpOW5j798Hs7YEKvjTq8poMaung1PIeGOx8SCJCXRETT/B
 4Yq1rkXgO/KoYT65KQ3TIdUM0OJ+2nVm94P3RNZI2OagIg7NVnF6/0E85lCCFLJYJ1Mt+YSmyuS
 1OymaFEphkLzKNsqkUtyP9kA63TY7oeBVZd4p267l90/XGkgP0GjDui8BuJRGxfPbieW9pCgwNq
 xYT+jc80bQOx3mA/YByLRzAdAxK0RGvutwI3LgQNREUcmdpuonHD+xyUUofxGhuAW7iowDbLFbD
 R6QCuhMwNRTbFF/oQ4A==
X-Proofpoint-ORIG-GUID: b86mPo57uFJb8yN2pduHToPZ4XK_Jo_t
X-Authority-Analysis: v=2.4 cv=WqAb99fv c=1 sm=1 tr=0 ts=6a6aa8c9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=qfYuoNLC281KTBfHwCsA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

QWRkIGEgVklSVF9NTUlPIHJlZ2lvbiBhbmQgdmlydGlvLW1taW8gdHJhbnNwb3J0cywgd2lyZWQg
aW50byBsMnZpYy4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hleGFnb24vdmlydC5oIHwgIDMgKysr
CiBody9oZXhhZ29uL3ZpcnQuYyAgICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9oZXhhZ29uL3ZpcnQuaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmgKaW5kZXgg
Y2YwY2QyZjhmMjIuLjRjYTJmMWVmODU5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L2hleGFnb24v
dmlydC5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmgKQEAgLTExLDYgKzExLDggQEAK
ICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb24uaCIKICNpbmNsdWRlICJ0YXJnZXQvaGV4YWdv
bi9jcHUuaCIKIAorI2RlZmluZSBWSVJUSU9fREVWX0NPVU5UIDgKKwogc3RydWN0IEhleGFnb25W
aXJ0TWFjaGluZVN0YXRlIHsKICAgICBIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlIHBhcmVudF9v
Ymo7CiAKQEAgLTE5LDYgKzIxLDcgQEAgc3RydWN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlIHsK
ICAgICBNZW1vcnlSZWdpb24gdGNtOwogICAgIE1lbW9yeVJlZ2lvbiBiaW9zOwogICAgIENsb2Nr
ICphcGJfY2xrOworICAgIERldmljZVN0YXRlICp2aXJ0aW9fbW1pb1tWSVJUSU9fREVWX0NPVU5U
XTsKIH07CiAKIHZvaWQgaGV4YWdvbl9sb2FkX2ZkdChjb25zdCBzdHJ1Y3QgSGV4YWdvblZpcnRN
YWNoaW5lU3RhdGUgKnZtcyk7CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL3ZpcnQuYyBiL2h3L2hl
eGFnb24vdmlydC5jCmluZGV4IDlhNjgwODUyYzNjLi5mZjA3NzBjZmM0NiAxMDA2NDQKLS0tIGEv
aHcvaGV4YWdvbi92aXJ0LmMKKysrIGIvaHcvaGV4YWdvbi92aXJ0LmMKQEAgLTMwLDExICszMCwx
OSBAQAogCiBlbnVtIHsKICAgICBWSVJUX1VBUlQwLAorICAgIFZJUlRfTU1JTywKICAgICBWSVJU
X0ZEVCwKIH07CiAKKy8qCisgKiBWaXJ0aW8gSVJRcyBydW4gZnJvbSBWSVJUSU9fSVJRX0JBU0Ug
dG8KKyAqIFZJUlRJT19JUlFfQkFTRSArIFZJUlRJT19ERVZfQ09VTlQgLSAxCisgKi8KK3N0YXRp
YyBjb25zdCBpbnQgVklSVElPX0lSUV9CQVNFID0gMTY7CisKIHN0YXRpYyBjb25zdCBNZW1NYXBF
bnRyeSBiYXNlX21lbW1hcFtdID0gewogICAgIFtWSVJUX1VBUlQwXSA9IHsgMHgxMDAwMDAwMCwg
MHgwMDAwMDIwMCB9LAorICAgIFtWSVJUX01NSU9dID0geyAweDExMDAwMDAwLCAweDAwMDAxMDAw
IH0sCiAgICAgW1ZJUlRfRkRUXSA9IHsgMHg5OTgwMDAwMCwgMHgwMDQwMDAwMCB9LAogfTsKIApA
QCAtMTY3LDcgKzE3NSwyNSBAQCBzdGF0aWMgdm9pZCBmZHRfYWRkX2NwdV9ub2Rlcyhjb25zdCBI
ZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgIH0KIH0KIAorc3RhdGljIHZvaWQgY3Jl
YXRlX3ZpcnRpb19kZXZpY2VzKEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMpCit7CisgICAg
aHdhZGRyIHNpemUgPSBiYXNlX21lbW1hcFtWSVJUX01NSU9dLnNpemU7CiAKKyAgICBmb3IgKGlu
dCBpID0gMDsgaSA8IFZJUlRJT19ERVZfQ09VTlQ7IGkrKykgeworICAgICAgICBpbnQgaXJxID0g
VklSVElPX0lSUV9CQVNFICsgaTsKKyAgICAgICAgaHdhZGRyIGJhc2UgPSBiYXNlX21lbW1hcFtW
SVJUX01NSU9dLmJhc2UgKyBpICogc2l6ZTsKKyAgICAgICAgRGV2aWNlU3RhdGUgKmRldiA9IHFk
ZXZfbmV3KCJ2aXJ0aW8tbW1pbyIpOworICAgICAgICBTeXNCdXNEZXZpY2UgKnMgPSBTWVNfQlVT
X0RFVklDRShkZXYpOworCisgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoT0JKRUNU
KE1BQ0hJTkUodm1zKSksICJ2aXJ0aW8tbW1pb1sqXSIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgT0JKRUNUKGRldikpOworICAgICAgICBzeXNidXNfcmVhbGl6ZV9hbmRfdW5y
ZWYocywgJmVycm9yX2ZhdGFsKTsKKyAgICAgICAgc3lzYnVzX21taW9fbWFwKHMsIDAsIGJhc2Up
OworICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEocywgMCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHFkZXZfZ2V0X2dwaW9faW4odm1zLT5wYXJlbnRfb2JqLmwydmljLCBpcnEpKTsKKyAg
ICAgICAgdm1zLT52aXJ0aW9fbW1pb1tpXSA9IGRldjsKKyAgICB9Cit9CiAKIHZvaWQgaGV4YWdv
bl9sb2FkX2ZkdChjb25zdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogewpAQCAtMjQ2
LDYgKzI3Miw4IEBAIHN0YXRpYyB2b2lkIHZpcnRfaW5pdChNYWNoaW5lU3RhdGUgKm1zKQogCiAg
ICAgZmR0X2FkZF9odngodm1zLCBtX2NmZyk7CiAKKyAgICBjcmVhdGVfdmlydGlvX2RldmljZXMo
dm1zKTsKKwogICAgIGdfYXV0b2ZyZWUgSGV4YWdvbkNQVSAqKmNwdXMgPSBnX25ldyhIZXhhZ29u
Q1BVICosIG1zLT5zbXAuY3B1cyk7CiAKICAgICBmb3IgKGludCBpID0gMDsgaSA8IG1zLT5zbXAu
Y3B1czsgaSsrKSB7Ci0tIAoyLjM0LjEKCg==

