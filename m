Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D9CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CM-0005pV-Hk; Fri, 29 May 2026 17:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CK-0005gQ-Kr
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CI-0000Vj-Rd
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIf5PE118104
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZqIR3vZ/lGQxDGirR81dOcdlf60RbF5IZkfFkhelc7U=; b=iQCsFwWsBO1j0kNJ
 +HnZFRy/gMjYoGb4iG0nxzj0pjPT0RGdyjI+8wqvhugIX22RYPNBHFnfBPN0vbXS
 sGu2hVHKa81/eLMnGlDlDLWs31klSJTZCwi+sXtj6MLgIwqPnxdduEQVuQ6PjR0E
 pHaYCjT1iDib2IK6iuSHz2CikIieyfPQzI5QyrAHqG/o7WtrRgpKzwVUbAkdWlWG
 1x70v9TuSfweZIhAZC3/M825vTSaBIlIUdp/V02pB/wPR39GVO648XkoA+2tMl+a
 x3W8iTqv5bTFHNAOVOQwcSGTaq5GcJmPl2kODEThcDoucfYIS/QwvSKPgjw3LYOB
 74KWrQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9vrqav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso2805978eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091803; x=1780696603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqIR3vZ/lGQxDGirR81dOcdlf60RbF5IZkfFkhelc7U=;
 b=XQ3/iq5os/9TzvZPBm9a5femvf9ygf2EYdQIOLZLpfWGdlZhKyMYkCdXRbdDit5DWj
 rzfUGMt0TfS3enu4cHJF7qke/IwIS3KyqTUbAjb86p509f36AziUI+hhNiXFM5OEyuqc
 Z1oY4hJ9rPKKnUSoJ5afxUpQYqKkAza/rg/i+FXsGa4+p3UOFn1+5cDRWc2zzXhQom1Z
 aPbZ9ZxYyNpN2ISM8aXq/eLUUiioBDgRqBqu9x0r4/s3pyRORO3wPvTVTXoClPzoFNND
 3Dp6thvx7vKLNhvbPR121v2jKHIVdDRTP355NVjgfZ1xArLezP/cr8NNzCdMqBFJcbq8
 rg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091803; x=1780696603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZqIR3vZ/lGQxDGirR81dOcdlf60RbF5IZkfFkhelc7U=;
 b=GvYJAJaWaZIlCqUtDUY7EHpV6p3bkSdIPGTlNQbv38bMRcMdDnq2xvgcxIwd+UG3M7
 ifJIV2ECrqUbTZEgaLCo9Kl4v0hVp/LdIBeHUXUIK6D58ej1Diow9r4ijJyBrEimg45f
 od8L8lJEanUEtJErWOXC7lSNJBldI7tQbjsvvle5SkO2vZBVgXHP+wCqu16zIDulaSG2
 y3+0GmIO5caELK2yp7LOCKQlyvSZh++CsPbFcfJz4NS4aYZf2NAEUNBahEA2rUnq8RQW
 q7/BDOeG6LU3eEbNY8HVeSTN+LRRgRuv5Bw7fgXEshQQdQ6Mkia4hApPFZcxoe9tEiDm
 S2wQ==
X-Gm-Message-State: AOJu0YzI8C3HNDSqXR0I6QO94Xtfd7wihNFVg60MqeYbPJStluqc8erH
 uBgV4DQ4cz2e3KrqJMpW1+grUJ1wmdwZcu5nUe8+KRl2SL+wyfEarEbEOvDOmwDZCx02hkAXMK9
 P0pKH89My8jLR/h8Ma30rfW0fGfqS0YOaSAJljuLhHJMuglT94cess62Nh/P5hzSYpQ==
X-Gm-Gg: Acq92OFzHitw6Z8Pj5IJo6dd68EMoPolQDJ8I7X9Xeu6ONlVlSnVtgkxhvRZ1dFOM10
 9cHUksrLzUm5H9HXZJ1t8u0RAhTPclOWq30jaxXYoUKOLaGPiobBoKfv44B2jaOJLtfL15hpKWj
 itHWIqjQe3a+UIWpo6evGxQhrvZjBOlRwy54ql+vxKBrspajJHN1D5S4f8x2PEVaeuOHCAzQXmW
 hxuMUwnFmGVvtu1uBZ1GsPdWZU9qbED9lhpNehGaSEF0LUjnDuvl9cbqkmTWkLPc+zzKljLnWkZ
 LoMv+NcJuUfBqwsrclk7iYn8edBa2BA9k83yL5o1qPl7FPuvMGIQvu6M0fF/FGpEfYkWRSJja2U
 zdSXiX9N6u6WZPHuw9dvnPkPucOKJDS04ywHrB3tFk9akiak7mInCZVhAO9DZUVEBMDMwHGxPAz
 iyAnHn
X-Received: by 2002:a05:7301:6a18:b0:2ed:e15:c926 with SMTP id
 5a478bee46e88-304fa69c7ffmr849547eec.34.1780091802782; 
 Fri, 29 May 2026 14:56:42 -0700 (PDT)
X-Received: by 2002:a05:7301:6a18:b0:2ed:e15:c926 with SMTP id
 5a478bee46e88-304fa69c7ffmr849527eec.34.1780091802211; 
 Fri, 29 May 2026 14:56:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 26/38] target/hexagon: Add TCG overrides for int handler
 insts
Date: Fri, 29 May 2026 14:55:42 -0700
Message-Id: <20260529215554.606133-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX4wHN7YfCVD9f
 8Kh1EszKTe7mmMZ0hL2Y/S5vsOLor1kAVPenTIdMIYKqtu7F3mQ9fojMSZMc9PF8TgfU3tnD5Nn
 ABpKBNaYlruQlmR+Z5i8hK0Ut0e4sGRRvVFOMsHFeTp2X0zeOl6j5niEJ9pkCv+pHz0KBRTi2zY
 AAWPE4sS+aRHeE6nW0sPhiO9nRpC9f9tZqCWpwDwOlzhdhdNe095jfSeTVEox52X/tGsXH5Nsp8
 X2itl8aGAUHJRVP5C7Edg4qsi7NJP36cfe4NTVs0bNNoo9+TQGt12kCXqzQ4K8HvF9h9MrwRdZG
 ibqZ5gZjrAqrTfKNkagKoUEMQXzmGY/cyWJqwS+AxeVzuw1Xodsc1IPkxLkZx1tlFKXNEQTGBvj
 Li2gbzHUFLgTd+8WtB0W1nTzxGn4B6KtajxDWNle/vWqbHqdLl+ZqQ6ruSJ+SrH3ErN+VI0dPIa
 01FdXp5gHJG+Is7cS6A==
X-Proofpoint-GUID: yxRpKD5bM0pIR-YRIO5bO2CRErnFLZ-x
X-Proofpoint-ORIG-GUID: yxRpKD5bM0pIR-YRIO5bO2CRErnFLZ-x
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a1a0b9b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ncxFUDX8U6Z2rYVbhVQA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Ige2MsfXN3aSB7YyxzfWlhZCwgaWFzc2lnbntyLHd9LCB7cyxnfWV0aW1hc2sKaW5zdHJ1
Y3Rpb25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFp
bC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMjUgKysrKysrKysrKysr
KysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAgICB8ICA4ICsrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Z19zeXMuaAppbmRleCBmNzhjOTYzNWMzZi4uNGNiYmRkMWY3MGIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMu
aApAQCAtNyw2ICs3LDMxIEBACiAjaWZuZGVmIEhFWEFHT05fR0VOX1RDR19TWVNfSAogI2RlZmlu
ZSBIRVhBR09OX0dFTl9UQ0dfU1lTX0gKIAorLyogU3lzdGVtIG1vZGUgaW5zdHJ1Y3Rpb25zICov
CisjZGVmaW5lIGZHRU5fVENHX1kyX3N3aShTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX3N3
aSh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfY3N3aShTSE9SVENPREUpIFwK
KyAgICBnZW5faGVscGVyX2Nzd2kodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1ky
X2NpYWQoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9jaWFkKHRjZ19lbnYsIFJzVikKKwor
I2RlZmluZSBmR0VOX1RDR19ZNF9zaWFkKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2lh
ZCh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfaWFzc2lnbncoU0hPUlRDT0RF
KSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWdudyh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdF
Tl9UQ0dfWTJfaWFzc2lnbnIoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWducihS
ZFYsIHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZMl9nZXRpbWFzayhTSE9SVENP
REUpIFwKKyAgICBnZW5faGVscGVyX2dldGltYXNrKFJkViwgdGNnX2VudiwgUnNWKQorCisjZGVm
aW5lIGZHRU5fVENHX1kyX3NldGltYXNrKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2V0
aW1hc2sodGNnX2VudiwgUHRWLCBSc1YpCisKICNkZWZpbmUgZkdFTl9UQ0dfWTJfc2V0cHJpbyhT
SE9SVENPREUpIFwKICAgICBnZW5faGVscGVyX3NldHByaW8odGNnX2VudiwgUHRWLCBSc1YpCiAK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKaW5kZXggNTQwNTM0MmY3OTguLjk1NTI4NzEzM2U0IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAtMTA5LDYg
KzEwOSwxNCBAQCBERUZfSEVMUEVSXzIocHJvYmVfaHZ4X3N0b3Jlcywgdm9pZCwgZW52LCBpbnQp
CiBERUZfSEVMUEVSXzIocHJvYmVfcGt0X3NjYWxhcl9odnhfc3RvcmVzLCB2b2lkLCBlbnYsIGlu
dCkKIAogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCitERUZfSEVMUEVSXzIoc3dpLCB2
b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihjc3dpLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9I
RUxQRVJfMihjaWFkLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzaWFkLCB2b2lkLCBl
bnYsIGkzMikKK0RFRl9IRUxQRVJfMihpYXNzaWdudywgdm9pZCwgZW52LCBpMzIpCitERUZfSEVM
UEVSXzIoaWFzc2lnbnIsIGkzMiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoZ2V0aW1hc2ssIGkz
MiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzMoc2V0aW1hc2ssIHZvaWQsIGVudiwgaTMyLCBpMzIp
CiBERUZfSEVMUEVSXzIoc3JlZ19yZWFkLCBpMzIsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHNy
ZWdfcmVhZF9wYWlyLCBpNjQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKGdyZWdfcmVhZCwgaTMy
LCBlbnYsIGkzMikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggZWQ0MzI1OGNkOTEuLmVlMjgyZTY2ZTg2IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdv
bi9vcF9oZWxwZXIuYwpAQCAtMTM4OSw2ICsxMzg5LDQ2IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEy
OHFtKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50MzJfdCB1aVYpCiB9CiAKICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQordm9pZCBIRUxQRVIoY2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IG1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBI
RUxQRVIoc2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCit7CisgICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworfQorCit2b2lkIEhFTFBFUihjc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
bWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBFUihp
YXNzaWdudykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKK3sKKyAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKK30KKwordWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdWludDMyX3QgdGlkKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3Zv
aWQgSEVMUEVSKHNldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGlkLCB1
aW50MzJfdCBpbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCiB2b2lk
IEhFTFBFUihzcmVnX3dyaXRlX21hc2tlZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZywgdWludDMyX3QgdmFsKQogewogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Ci0tIAoy
LjM0LjEKCg==

