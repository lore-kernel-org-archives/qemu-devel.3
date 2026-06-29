Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2505CC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39z-0002Ua-H8; Sun, 28 Jun 2026 23:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39u-000239-Av
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39r-0006MM-Rb
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cnuF1539263
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dY/1s85TBUfEZ6DKxNXbQLtO9YNnO553PDpX0fAztOM=; b=KD9GkpLOzfVifX3X
 ReRh9svH5WnB+3ByQOmWFWEzQASA2Rs/2dyLfq6mXzfwmJJvaVUNCNPDqOg0rl+9
 arzIISyFA0BgBmcyZDO7iGVmEt11j8it1E0NMcx2FQx/LkzkBB4qbZXdSXGgtLP5
 aEBgiaWfLMW7phkAKQ4Y9TADd+qI/zXCqQEycB0wAZ3MMQZFOe7TqGTFwhICrUXY
 7U47tAWBxMDucpWewDNei4cZipjvc0SdnkQ71zexesttIb5J/DLXg10yS2RjhGkR
 hEBCzEBoTV1yf1/vJM20NPr6VMs0+FxgwAOCtg8U1PtjVjaciER+wW+42gE1M8gP
 Pm/fkQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a4ddb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:32 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139af2bd2c8so4831513c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705572; x=1783310372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dY/1s85TBUfEZ6DKxNXbQLtO9YNnO553PDpX0fAztOM=;
 b=GeM4XDVzcE8y+JRdstoOEQeqmPoiAKsAEDTT0Ia7zB9GPRgTXBcvrHGtKAtKlqC9YI
 SsXmTLDQCdevc/yLf1mR5L0rbSzzCtl+DhHnCLV0g5I4h27CA+vK5tlx8gcF35qLuJYc
 h3lalvYG2KwyoyXQq8F3b5gnHqrH/FOAfiO2s7HZKCX4qCGtvaWH0EE71LDbQz15DuQ1
 0LokUcdmb9eidx8q2a6nHSBK+6NDWF3MZO1mS7JhUA6qY6FlCWuXL7Bsr5I14SfFFZby
 XcReAvMLAiPEnHqCu8kWnM9/kpOPVm16UDV+vvgE+fo+S/kTF1VTtCD3XE5dyIp+1YXG
 PVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705572; x=1783310372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dY/1s85TBUfEZ6DKxNXbQLtO9YNnO553PDpX0fAztOM=;
 b=hZtkrDf48erZjOaMh1aZJPdltX4hnn5uYXK+4iYWxyiCh9y4BJm+lTjodSyffJVjjC
 XUUzBG1vOsshy/BdXgTqHWdm1HhG/XWiHlJ4v87GWXL2Jo41s8/NdZGYIAQvEA/85Bpd
 8tKg+NdwC4ZZ+SSWBJpFH2pPY7UCR+ppkIxdz6Wng0AZtPGWY6QqswpJOIMBAZphzrnG
 iFOc0H9sW49DKGDGso7rjl69DUqTFMzGiRJ4lnir+WYTf3EnTgpZxRHQBxZ+2GdubLvy
 8FVMhWgUY03+3EoZ0aKSYpmPDx/PVvAlWwaIDxTpHqSHt/TkLTZxki7LYJsmkFoebEDF
 nErw==
X-Gm-Message-State: AOJu0YyKRgP1Yw+f0VZ6I/hVfbzJ+6unxS+LiKlFAzEZlR/qRcGu1EFj
 p9FpATI0x1HDsRFqu8F2/AC+8Gj/XCCWfX8jn7W9n28qMALBkNq64QXWpR+EMoZavh9az5xtuTt
 Mg4UO5kAK6BHtma8IuvTd5/+dROswf4F+tInKtfA77aeC2fCtZbtrSiEH//2LiPWFxw==
X-Gm-Gg: AfdE7ckdXKAovnI4wC3Hza/MCBJ+BReoO1SSE0DhF6V2EsdsZRpqU3BQ79SaVV+/o7s
 pHu8pT0Z9RJXlDTgnWVxdXYvuBdgGXSGqohNNibi1l/q/wqLEtHWB4tzpfr3/RJHOhDKsFXQLFF
 I5uaNjs3V1LR2cD2I2v2tOgV7tuMehXTEIxwFfJYgDG7cxhvy+d8FhS3ED2fj2rOC7bFUG9TXJn
 xIbjTB0XFBRCHenUWpQ4j9ROBlXi8C9q3Zb4ro7A28qjaXHDIIAYO1ks6a+/p8ci7bq+FarM/Wx
 TqLQOoUlph4NMpw2hKdZ9tEEWpn3b0H699iEcbVpMIoJY2w+BIQT3MO/bE0+FtOXF8MOnPOb/xZ
 HAapeAy7PXOJuc0GxJNd9/AVLuEOQjnoTm+iD8H7l+Gu3ID1THPyWQcpmdKg=
X-Received: by 2002:a05:7022:923:b0:139:ed5d:7564 with SMTP id
 a92af1059eb24-139ed5d9492mr6331437c88.43.1782705571833; 
 Sun, 28 Jun 2026 20:59:31 -0700 (PDT)
X-Received: by 2002:a05:7022:923:b0:139:ed5d:7564 with SMTP id
 a92af1059eb24-139ed5d9492mr6331415c88.43.1782705571341; 
 Sun, 28 Jun 2026 20:59:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 34/77] target/hexagon: Add implementation of cycle counters
Date: Sun, 28 Jun 2026 20:57:47 -0700
Message-Id: <20260629035830.1520296-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXwhjJtOI36fTO
 y42uFXnXNzYpZxB8vrYll6BLr2mrPtgi/JppjSX0v29kKTVVyX/FZUU+NkM5z7u/vEvlH4MVZJ1
 Dym6xBTifeATo0YfOyfSEPVB+S5hysHSOhgR2wRllUqPxQ2alBpHAx4G7GJW5EkjY08KmdX/cG3
 gvnnri+LTm0Vr54+RT7iTvw9hwNpRLSGvqOaRJE0GR5WjpAw6pDiGhNnWZsH4qcgNGLRM0LzqOu
 mVIcIkEZ4rOxbJYtOgce3lIerA2jylqNkAsOJj63p7S7XEnijlyS0sQIsLfE3ZQ1uoknf7EFy3R
 b89VGZH8CBwQEV2NqM8lgfc0m/UBwVVkverJ9ndnGVhdOfPplCm2V/LOYcHhgtuzuPHIbyimWqc
 vj+omweCJp0uBO+SnZqEvmFFXGKl8uWeWIxweX7RzKFSDwlpq8kpRUq+X060VSYiZVLVSlYuQiz
 cvsnhs7ezPbnNNVxHkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX80az8om0Gugj
 EOmjPq/2f+GmsZT9NODyaB9fQX+j+H1NVT4IaEzv6u2cAMojIIAAoOlbkRUpyC9aLsnzrtsNKtg
 0rrWd9KHNhcknlJIMgZU+yGAI41G+VU=
X-Proofpoint-GUID: MKgG8BAMlq1KSrAFNLKPdacoAOI1ZtAR
X-Proofpoint-ORIG-GUID: MKgG8BAMlq1KSrAFNLKPdacoAOI1ZtAR
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a41eda4 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Bw4caLd0n_0OF-yX4NUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

QWRkIGN5Y2xlIGNvdW50aW5nIGluZnJhc3RydWN0dXJlIGZvciBzeXN0ZW0gZW11bGF0aW9uOgot
IFBDWUNMRV9FTkFCTEVEIFRCIGZsYWcgdG8gZ2F0ZSBjeWNsZSBjb3VudGluZwotIGdlbl9wY3lj
bGVfY291bnRlcnMoKSB0byBlbWl0IGN5Y2xlIGNvdW50IGluY3JlbWVudHMKLSBSZWFsIGltcGxl
bWVudGF0aW9ucyByZXBsYWNpbmcgcGN5Y2xlIHN0dWJzIGluIGNwdV9oZWxwZXIuYwotIGhleF9j
eWNsZV9jb3VudCBUQ0cgZ2xvYmFsIGZvciB0X2N5Y2xlX2NvdW50Ci0gcGN5Y2xlX2VuYWJsZWQg
Y29udGV4dCBmaWVsZCBpbiBEaXNhc0NvbnRleHQKCkFsbCBwY3ljbGUgY29kZSBpcyBndWFyZGVk
IGJ5ICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWS4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNv
biA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggIHwgIDMgKysrCiB0YXJnZXQv
aGV4YWdvbi9jcHUuYyAgICAgICAgfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVy
LmMgfCAxNCArKysrKysrKysrKy0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgIHwgMjYg
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBi
L3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDI1NDA0NThiMzcwLi5kZGY2ZGE3OGMxOCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgK
QEAgLTE2NCw2ICsxNjQsNyBAQCBzdHJ1Y3QgQXJjaENQVSB7CiAjaW5jbHVkZSAiY3B1X2JpdHMu
aCIKIAogRklFTEQoVEJfRkxBR1MsIElTX1RJR0hUX0xPT1AsIDAsIDEpCitGSUVMRChUQl9GTEFH
UywgUENZQ0xFX0VOQUJMRUQsIDQsIDEpCiAKIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNl
X2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgK
aW5kZXggNTc3NjdhY2YwMDIuLjIwOGNmMTQxZTdlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtODUsNiAr
ODUsOSBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIFRDR3YgbmV3X3ByZWRf
dmFsdWVbTlVNX1BSRUdTXTsKICAgICBUQ0d2IGJyYW5jaF90YWtlbjsKICAgICBUQ0d2IGRjemVy
b19hZGRyOworICAgIGJvb2wgcGN5Y2xlX2VuYWJsZWQ7CisgICAgYm9vbCBwa3RfZW5kc190YjsK
KyAgICB1aW50MzJfdCBudW1fY3ljbGVzOwogfSBEaXNhc0NvbnRleHQ7CiAKIGJvb2wgaXNfZ2F0
aGVyX3N0b3JlX2luc24oRGlzYXNDb250ZXh0ICpjdHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBhMDgwODNlYTI5MC4uMDc3
M2VmOGZlNzkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCkBAIC0yNjgsNiArMjY4LDEwIEBAIHN0YXRpYyBUQ0dUQkNQVVN0YXRlIGhl
eGFnb25fZ2V0X3RiX2NwdV9zdGF0ZShDUFVTdGF0ZSAqY3MpCiAgICAgICAgIGhleGFnb25fcmFp
c2VfZXhjZXB0aW9uX2VycihlbnYsIEhFWF9DQVVTRV9QQ19OT1RfQUxJR05FRCwgMCk7CiAgICAg
fQogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBoZXhfZmxhZ3MgPSBGSUVMRF9EUDMy
KGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9FTkFCTEVELCAxKTsKKyNlbmRpZgorCiAgICAg
cmV0dXJuIChUQ0dUQkNQVVN0YXRlKXsgLnBjID0gcGMsIC5mbGFncyA9IGhleF9mbGFncyB9Owog
fQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggYTJiNDg2ZjRiYjUuLmJiOTkxYTY3MWU4IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jCkBAIC0zMywxNyArMzMsMjUgQEAgdWludDMyX3QgaGV4YWdvbl9nZXRfcG11X2Nv
dW50ZXIoQ1BVSGV4YWdvblN0YXRlICpjdXJfZW52LCBpbnQgaW5kZXgpCiAKIHVpbnQ2NF90IGhl
eGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7Ci0gICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50NjRfdCB0b3RhbCA9IDA7CisgICAgQ1BV
U3RhdGUgKmNzOworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBDUFVfRk9SRUFD
SChjcykgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSBjcHVfZW52KGNz
KTsKKyAgICAgICAgdG90YWwgKz0gdGhyZWFkX2Vudi0+dF9jeWNsZV9jb3VudDsKKyAgICB9Cisg
ICAgcmV0dXJuIHRvdGFsOwogfQogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2Nv
dW50X2hpZ2goQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICByZXR1cm4gKHVpbnQzMl90KShoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudikgPj4gMzIpOwogfQogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
X2xvdyhDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworICAgIHJldHVybiAodWludDMyX3QpKGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52
KSk7CiB9CiAKIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCB2YWwpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDk3ODQ5YWI4NjFh
Li5lZDk2ZDlhNjZiMyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysr
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTYxLDYgKzYxLDkgQEAgVENHdl9pNjQg
aGV4X3N0b3JlX3ZhbDY0W1NUT1JFU19NQVhdOwogVENHdiBoZXhfbGxzY19hZGRyOwogVENHdiBo
ZXhfbGxzY192YWw7CiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OworI2lmbmRlZiBDT05GSUdf
VVNFUl9PTkxZCitUQ0d2X2k2NCBoZXhfY3ljbGVfY291bnQ7CisjZW5kaWYKIFRDR3YgaGV4X3Zz
dG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIFRDR3YgaGV4X3ZzdG9yZV9zaXplW1ZTVE9SRVNfTUFY
XTsKIFRDR3YgaGV4X3ZzdG9yZV9wZW5kaW5nW1ZTVE9SRVNfTUFYXTsKQEAgLTEyOCw2ICsxMzEs
MTUgQEAgc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlvbl9yYXcoaW50IGV4Y3ApCiAgICAgZ2VuX2hl
bHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihleGNwKSk7CiB9
CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgZ2VuX3BjeWNsZV9jb3Vu
dGVycyhEaXNhc0NvbnRleHQgKmN0eCkKK3sKKyAgICBpZiAoY3R4LT5wY3ljbGVfZW5hYmxlZCkg
eworICAgICAgICB0Y2dfZ2VuX2FkZGlfaTY0KGhleF9jeWNsZV9jb3VudCwgaGV4X2N5Y2xlX2Nv
dW50LCBjdHgtPm51bV9jeWNsZXMpOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBn
ZW5fZXhlY19jb3VudGVycyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICB0Y2dfZ2VuX2FkZGlf
dGwoaGV4X2dwcltIRVhfUkVHX1FFTVVfUEtUX0NOVF0sCkBAIC0xMzYsNiArMTQ4LDkgQEAgc3Rh
dGljIHZvaWQgZ2VuX2V4ZWNfY291bnRlcnMoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAg
ICAgICAgICAgIGhleF9ncHJbSEVYX1JFR19RRU1VX0lOU05fQ05UXSwgY3R4LT5udW1faW5zbnMp
OwogICAgIHRjZ19nZW5fYWRkaV90bChoZXhfZ3ByW0hFWF9SRUdfUUVNVV9IVlhfQ05UXSwKICAg
ICAgICAgICAgICAgICAgICAgaGV4X2dwcltIRVhfUkVHX1FFTVVfSFZYX0NOVF0sIGN0eC0+bnVt
X2h2eF9pbnNucyk7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBnZW5fcGN5Y2xlX2Nv
dW50ZXJzKGN0eCk7CisjZW5kaWYKIH0KIAogc3RhdGljIGJvb2wgdXNlX2dvdG9fdGIoRGlzYXND
b250ZXh0ICpjdHgsIHRhcmdldF91bG9uZyBkZXN0KQpAQCAtODEwLDYgKzgyNSw4IEBAIHN0YXRp
YyB2b2lkIGdlbl9jb21taXRfaHZ4KERpc2FzQ29udGV4dCAqY3R4KQogICAgIH0KIH0KIAorI2Rl
ZmluZSBQQ1lDTEVTX1BFUl9QQUNLRVQgMQorCiBzdGF0aWMgdm9pZCB1cGRhdGVfZXhlY19jb3Vu
dGVycyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBpbnQgbnVtX3JlYWxfaW5zbnMgPSAwOwpA
QCAtODI5LDYgKzg0Niw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9leGVjX2NvdW50ZXJzKERpc2Fz
Q29udGV4dCAqY3R4KQogICAgIGN0eC0+bnVtX3BhY2tldHMrKzsKICAgICBjdHgtPm51bV9pbnNu
cyArPSBudW1fcmVhbF9pbnNuczsKICAgICBjdHgtPm51bV9odnhfaW5zbnMgKz0gbnVtX2h2eF9p
bnNuczsKKyAgICBjdHgtPm51bV9jeWNsZXMgKz0gUENZQ0xFU19QRVJfUEFDS0VUOwogfQogCiBz
dGF0aWMgdm9pZCBnZW5fY29tbWl0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKQEAgLTk3OCw2
ICs5OTYsMTAgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl90cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlz
YXNDb250ZXh0QmFzZSAqZGNiYXNlLAogICAgIGN0eC0+aXNfdGlnaHRfbG9vcCA9IEZJRUxEX0VY
MzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSVNfVElHSFRfTE9PUCk7CiAgICAgY3R4LT5zaG9ydF9j
aXJjdWl0ID0gaGV4X2NwdS0+c2hvcnRfY2lyY3VpdDsKICAgICBjdHgtPmhleF9kZWYgPSBIRVhB
R09OX0NQVV9HRVRfQ0xBU1MoaGV4X2NwdSktPmhleF9kZWY7CisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBjdHgtPm51bV9jeWNsZXMgPSAwOworICAgIGN0eC0+cGN5Y2xlX2VuYWJsZWQg
PSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9FTkFCTEVEKTsKKyNlbmRp
ZgogfQogCiBzdGF0aWMgdm9pZCBoZXhhZ29uX3RyX3RiX3N0YXJ0KERpc2FzQ29udGV4dEJhc2Ug
KmRiLCBDUFVTdGF0ZSAqY3B1KQpAQCAtMTEyMSw2ICsxMTQzLDEwIEBAIHZvaWQgaGV4YWdvbl90
cmFuc2xhdGVfaW5pdCh2b2lkKQogICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGxs
c2NfdmFsKSwgImxsc2NfdmFsIik7CiAgICAgaGV4X2xsc2NfdmFsX2k2NCA9IHRjZ19nbG9iYWxf
bWVtX25ld19pNjQodGNnX2VudiwKICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBs
bHNjX3ZhbF9pNjQpLCAibGxzY192YWxfaTY0Iik7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkK
KyAgICBoZXhfY3ljbGVfY291bnQgPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTY0KHRjZ19lbnYsCisg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgdF9jeWNsZV9jb3VudCksICJ0X2N5Y2xl
X2NvdW50Iik7CisjZW5kaWYKICAgICBmb3IgKGkgPSAwOyBpIDwgU1RPUkVTX01BWDsgaSsrKSB7
CiAgICAgICAgIHNucHJpbnRmKHN0b3JlX2FkZHJfbmFtZXNbaV0sIE5BTUVfTEVOLCAic3RvcmVf
YWRkcl8lZCIsIGkpOwogICAgICAgICBoZXhfc3RvcmVfYWRkcltpXSA9IHRjZ19nbG9iYWxfbWVt
X25ldyh0Y2dfZW52LAotLSAKMi4zNC4xCgo=

