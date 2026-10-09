Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5538CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEyb5-0001Vk-6Y; Thu, 08 Oct 2026 20:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEyaE-0001US-5u
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:35:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEya9-0002OO-BV
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:35:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990YKID1252691
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 00:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=IBJWhRAmkk5h9AejlFIr/w
 V6Y67RpP+9754E6g38CjU=; b=h+Z5EYBiDH1vA8o8QAmzo2B6pZbBEhG3YFKZKj
 tN8hdJPZOfMQKoHDPl4g/SggDLc8ZxqFVPfItRVwuoRx1tBi637ZrAL9exvqokd4
 3kcXD32tYm42fNU1jIfdWrG3j0zUI9F7K84T/RmhLVj5WxxTEtU5T3bzKTE4ZJws
 OO4irWLGn6zm0RSWIrASe+hQCkcIu0MDg8RmGjXGDs9gvFYx1aJ9rHklOnvS2YZP
 Z1G90r3BouXsuMAO8GW9qeqnUevQQTFEL1XsU5smBNrtglsA/dYidCPC4ks0GY4I
 z1b/9XrLR0T/5D261sgS6xAqy5uTJYg3UTKetzCdpWgVqqcQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nufr030-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:35:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139b62317d0so20464393c88.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791506124; x=1792110924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IBJWhRAmkk5h9AejlFIr/wV6Y67RpP+9754E6g38CjU=;
 b=ed4py2iXYAIRFiz6StIHQiiTM7s5QALnYKMVpo/6AT3j6C7hP5IYQGkVw0lWGw5wVo
 ih3Ymfr1Kx3pDj4eXmSNF5zTEklVkITEnsgTdcay3V6Pji/cRr91FOUQG9BrYQ0ops6x
 iT5RDGronFNRDHbhQEV2GlHQbFMq8P1yGIOBNtbPBeFh0X4/4Aww2MluAB7DSxpXPdbs
 UPLbomQeZSYqorztxfj1DHuFIXFXYugCjsoZSEL2ml+fZxGS/oFcndAVQ5a6Ye6zRTTp
 oNADMdEnhrGe7i4OHl922aFkdVPT6YUkE6Kn/YN03npMxpGyiO7MtfITpPeesPplM6so
 hfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791506124; x=1792110924;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IBJWhRAmkk5h9AejlFIr/wV6Y67RpP+9754E6g38CjU=;
 b=ktd9xst2irN9Nox/7uPL0QtZ9fhZPWJxkkqr1fqty252ddWQ7UP6rPHYYVpN/XWMaK
 bQwfknovY931m4XV31SUiefpZI93sPRHequcs11WNRv1MelJaJrKucADDD/zdujyr9dq
 U1G6SFuZ9c7EcPwCtGDWGbqYaonNDM6t4WGiSzTPXoMBpIznuOkDRNoJBymUbCNgfrph
 tvovhYbPxc3dOG0hMZwLcgG2H2U8W3aFecqGCIEsokzei+TkCVH1MBQ1MZbO3TZStAkj
 FBESK7bTVZKcOXA5fHBsfWyeCIT08osXV8TbMmoiaZUs7mXubZzendSvXChttFbifRmh
 M+JQ==
X-Gm-Message-State: AFuF++mYgdFqc+xb0Qk2PhEzYUDyRbQjtXJ/OjpIoTvjYXKxg8F3oXzx
 CttkRG13Yk9BDv2KrPWdyAi+gG4824RqEtvr50gF6XvZCOQz6FKqm7HDbgvtyoscTetIfu4zM3g
 1FBGmch9ZkvTLVIa+kOOajYkO5Gnm4nfnMIr8CDN6BLhaLGBKLMA9o5VGKNp38L0bMg==
X-Gm-Gg: AYBFou3LbWVbctdGsTGOfKpSOQccD6RRlczOqT2oKyiCHqEQQjmJdai97JEQ9PHpIBx
 ukObzC30P3oaKw1lZ+OgAGVpk32lRsnw4nJtpCEM04xdmqKhIM5M/s1C/gYpyimNaWdAEhQzvFa
 n5RJPOEpLmp6aIQj2lPg3WhuKoqSboiU2KWEHY110Ku6hEL5jt425Oqon3OppeyA7cO7wHkdqLZ
 NcKvW/+XpMve14yTQ+7ofQ4x9adnFg1shZL5RGvfdn+z7s6X9AXM+COYy/nOd4B5dhiOhdH56nx
 aPZNPW0sqyeP5QMKIYqgVXjO0GuIuadPOwWByQlcrPjcBt0A4AowH+GbvjJyJtj910ZxaHKgFxu
 yaLSKqsg9xVLXlNapdXfBaic6hqCqUDbhhS6BvivlStBbABI=
X-Received: by 2002:a05:7022:1718:b0:156:6676:d0f3 with SMTP id
 a92af1059eb24-16a58b6eef4mr310156c88.6.1791506123802; 
 Thu, 08 Oct 2026 17:35:23 -0700 (PDT)
X-Received: by 2002:a05:7022:1718:b0:156:6676:d0f3 with SMTP id
 a92af1059eb24-16a58b6eef4mr310126c88.6.1791506123109; 
 Thu, 08 Oct 2026 17:35:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm1615893c88.22.2026.10.08.17.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 17:35:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] hexagon: model the PCYCLE registers
Date: Thu,  8 Oct 2026 17:35:19 -0700
Message-Id: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac836cc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=aR7yBkeLOpF5d8fs63sA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwMSBTYWx0ZWRfX9RxelfCv5twC
 qOonU4+4WoypJvFvmL3GmRp3XUgHrjPbq3i87XPItv5gELTX1oQmnjimb5hGGXGd4KgXMTObQFi
 3eJqr+g/TOWcsQ6AnzLGv5WFBtrWh+0=
X-Proofpoint-GUID: Vs4dkkidjq6HWrYqPVrh5760NZH7QqXZ
X-Proofpoint-ORIG-GUID: Vs4dkkidjq6HWrYqPVrh5760NZH7QqXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwMSBTYWx0ZWRfXw6lvlES1jajr
 jpHkYSZAFFm0PJTFiTiRTq5Z11vyXaQIhV+hc8nF2PMRY9YoLJ/xC9FK9YendXihtwkc1KBJUB1
 Q2Dy4xqCvSQrnNiskRWx5ViyIL8rJAh+S2BVqyJvvjMbgE8HBUvPO1UFAxadjS5DSuwEUfxEDSl
 JYhqi+hgmaus4pTGeqzIV+LmAXwJqfNFk//zJItrhlnLXI+ePKAruoxLSxYb8gKUs2w8oCQNRZz
 LQqNhTi6x5RLEoCk8Tc6DGxRalKREZvWRhNh85psewEGLlXV/nqSRdkRdgdARwihvf/mUtYJd+7
 VpXyR4BmhtsMLhBFZeJmju5O2VXuTqoQaXExbzHJ8sEDf4SDuKjAEytaj0FASqZvY5mszFZlrED
 P1TxUcq39qCLSZI5vTb6BOOMKG9l3AzuAiT62N96Owm0cnXJRz75CqxqnFtBSbpg4T729dvXo2V
 B9SAm8RJZYgfsz23k7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090001
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

VGhlIHBjeWNsZSByZWdpc3RlcnMgbWVhc3VyZSBhY3Rpdml0eSAtIGEgdmVyeSBjb2Fyc2UgYW5k
IHNpbXBsZSBQTVUtbGlrZQpmZWF0dXJlLiAgVGhlIGJhc2VsaW5lIGhhZCBhICJjb3VudCB0aGUg
aW5zdHJ1Y3Rpb25zIHBlciBUQiBhbmQgc2NhbGUgYQpjb3VudGVyIiBtb2RlbCAodG8gYmUgc3Vt
bWVkIGFjcm9zcyB2Q1BVcyB1cG9uIHJlZyByZWFkKS4gIEJ1dCB0aGF0J3Mgbm90CmEgZ29vZCBt
b2RlbCBhbmQgaXQgYWRkcyB3b3JrIHRvIGFsbCBUQnMuCgpJbnN0ZWFkOiB3ZSdsbCB1c2UgdGlt
ZSBhcyBhIHNsaWdodGx5IGJldHRlciBtb2RlbCwgYnV0IG9ubHkgYWNjdW11bGF0aW5nCndoZW4g
dGhlcmUncyBhY3Rpdml0eS4gIFVzaW5nIGEgY2xvY2sgaXMgdW5mb3J0dW5hdGVseSBsZXNzIHN0
YWJsZSBhY3Jvc3MKaG9zdHMgYW5kIGNoYW5nZXMgdG8gdHJhbnNsYXRpb24sIGJ1dCBzdGlsbCBh
IG5ldCBpbXByb3ZlbWVudCBhbGwgdGhpbmdzCmNvbnNpZGVyZWQuCgpCcmlhbiBDYWluICgyKToK
ICBody9oZXhhZ29uOiBtb2RlbCBQQ1lDTEUgY291bnRlcgogIHRhcmdldC9oZXhhZ29uOiBtYXJr
IGNsb2NrLWJhY2tlZCByZWdpc3RlciByZWFkcyBhcyBJL08KCiBpbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbl9nbG9iYWxyZWcuaCB8ICAgNiArKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAg
ICAgICAgICAgICAgfCAgIDIgLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oICAgICAgICAg
ICAgfCAgIDYgLS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggICAgICAgICAgIHwgIDEy
ICsrLQogdGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAgICAgICAgICAgICAgfCAgIDIgKwogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgfCAgIDIgLQogaHcvaGV4YWdvbi9o
ZXhhZ29uX2dsb2JhbHJlZy5jICAgICAgICAgfCAxNDIgKysrKysrKysrKysrKysrKysrKysrKysr
LQogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0KIHRhcmdl
dC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAgIHwgIDc5IC0tLS0tLS0tLS0tLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICB8ICAzOCArKysrKystCiB0YXJn
ZXQvaGV4YWdvbi9oZXhzd2kuYyAgICAgICAgICAgICAgICB8ICAxMCArLQogdGFyZ2V0L2hleGFn
b24vbWFjaGluZS5jICAgICAgICAgICAgICAgfCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jICAgICAgICAgICAgIHwgIDQ1ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYyAgICAgICAgICAgICB8ICAyMSAtLS0tCiBody9oZXhhZ29uL3RyYWNlLWV2ZW50cyAgICAg
ICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICAgICAg
ICB8ICAgOCArLQogMTYgZmlsZXMgY2hhbmdlZCwgMjU5IGluc2VydGlvbnMoKyksIDEyNyBkZWxl
dGlvbnMoLSkKCi0tIAoyLjM0LjEKCg==

