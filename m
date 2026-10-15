Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3494ACCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRfx-0003Ra-CX; Thu, 15 Oct 2026 16:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRft-0003LF-6Y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfq-0003EO-1s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFd1uv2416945
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s3ooICaj01Zvsubfx0Nme1qs6VRzP6EX60pJq4RBxv4=; b=Pfn9kehI6UcwEqkO
 A1gO14PQzq+XSXcbioFGBziCgoeVTR2/xd4la59T/v6zFdSh/es8WHA/C80QbCCQ
 2DFTi+y+EbL6UFj2Pq+Xc4A2aQVEzHhCTKY1yHmQj/vXtRiRaZfdeQdBdzfgupxL
 rkM5LDq4IgfIzLu5rGTGjsk9qIhGlnrnY20J8WX1IG8vFKmKDmEiilHqAWMDx9C6
 cu2UZt0DymlDtPLAxW3VcU8RcwmVt0KuwK8i1Os0s94NdByBjdwLPYjf8y249jqY
 tKTEG2TJVPSPNEUNCdI9mheVqABzSdMt8CXABvplFzziNOq7XpkeDaD/9DVxBG2O
 Kej8ww==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhkv9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:32 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso4662539c88.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792094612; x=1792699412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s3ooICaj01Zvsubfx0Nme1qs6VRzP6EX60pJq4RBxv4=;
 b=heIOlB0YrFJCJ5/bpIiiEgGZC4ESM3kuVkCWsYhfj6wIVA2yn9CdhecGkxlLqV3L9Q
 nJiHHuOET0mB45jYigYabqfFBYD0AeRe8twBuVe8zYeJGSdGWiOeyT0yl9QvvzxWV/rW
 YYRHX49drwdtogvPsS22jhGuM2hcHGSqnGlxtzBb1jsvv9ixejh9ZUjgMJw7aXxubmD2
 TAlWB5aqxekvkhEVgqP+3s7VjZuSJkh62/VMclLQ8usWcoATdbtrHFWgjDVlY9iFHjip
 SiDQoQt0xS5H30+CdUcD2fsidu0tkpmvUd+OP8AvROZuc5sO9uW3YS1oO930q6zWoUow
 bVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094612; x=1792699412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s3ooICaj01Zvsubfx0Nme1qs6VRzP6EX60pJq4RBxv4=;
 b=BgYq1/SpzY1FKekEiQTz+NMwMpyk3RMQVyRMGCUWiveWagM+AqWMaD6/kvLmM42Jev
 6ze3GoTylnpabzKcUA60g7F3DlmU7QYwaeiO6blOz6OS6Pu6kmmVkzdvM/zybhkpPcNg
 /J08AHnfyXsDarBvUphiZTOpHAdhB8v8FsNUGfHRs0i7hcQnmMF3uhrmswGXbWAUmm/H
 ysK3Aw6nJMEoN2G5Pejd6PZAcJJxfxWQaYhs5/PA9DJnjPcXNuuBK8cll/jA9e5CFStY
 xsABNAhEe3wMYtTB+v+ntknCccepS++arH/gdepd2Jad9HCaYMSMygFs9vRQdA38sVPQ
 Utyw==
X-Gm-Message-State: AFq9FYIEQFf8VMzB/a88tE1l774SpdMIQDjJKJHEOHDuiu7L/XQHUGO5
 +CUYc584Qni17kvE1L0/JXaWPJ5nc6COZF8W8auyd6iqzQpLkAL/OhvqgcxLWfGKQK4lcxog1xd
 IstMewzAovWYGE6E5ccKaP/7OQCA9/e9NA6yoLRc+6wcmuJNn/3HLLz3WXnVHOp2S/g==
X-Gm-Gg: AYBFou3nER1aVbBUGGHb0D54rmMygWK6d4uqmorCbaE+JVhxvnII+pABhfWyMvcDjoj
 AwtFOfKZlf3wI2mcPAhhwqo+dKtfQLEVgjtGJkqk70CXQMeRUof8ChhsOTGVpRuVUvHRDoZiari
 v8V/Vl3kDval/zfW/Ukujunxl7VaRkW3C8CSOVLL70LxIZb22MIFKKVCCZZFef3+4RvBHrz6DMB
 5rxqrIn3W03Wf7+0ds7EOewLNjtAG29vWP7MxsNMI0rV7U6wYk/HdmNx8isPAZiHEg303jol90Y
 Bf6HdZVft2zs/WFvB+lKvIQdKyPHJ11Sod96NfT7/AEbUXQq9+gkaW4e8zofduiHXhhDMUN71jp
 vc50a9/uTYMMGky+jfrVuQZfseRoWBLtd6dh1UxcJd3bkRq8=
X-Received: by 2002:a05:701b:2612:b0:14f:8d59:edcc with SMTP id
 a92af1059eb24-16a5faa7b2fmr23805815c88.12.1792094611800; 
 Thu, 15 Oct 2026 13:03:31 -0700 (PDT)
X-Received: by 2002:a05:701b:2612:b0:14f:8d59:edcc with SMTP id
 a92af1059eb24-16a5faa7b2fmr23805723c88.12.1792094609513; 
 Thu, 15 Oct 2026 13:03:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a6d6969asm1347058c88.12.2026.10.15.13.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:03:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 5/9] target/hexagon: check privilege mode for system
 instructions
Date: Thu, 15 Oct 2026 13:03:02 -0700
Message-Id: <20261015200306.1602540-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
References: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX2KcGIDtTQHJD
 1T2XK4rOtS6NzrGul7L/8KyGL0depz52D5gV4zcy7WVaxEE85TUFEREMLV2bRqi4tpjOw5+o9A9
 yLnymBF4zSxn5Vx8dCzAt4WyfZgz2MlhbipwXvK1GWKYSRX5Ua3neW3T9GlfQi6XwyF2ZYqKQbY
 jAoKKcodwkqUSsWc8aqtu2t4Xr8n1e8ae00qhfiy6tKrVQPBfE4o8h7eAJ3Er2df1lgPe+nMZb6
 Y+jYgR+WbKOVDejuVUJYiumPQtZuaifH7G2sLsiLto1etHDVQR1zwNuW/jBlcvCnrSydox87NP3
 FYd1nc6iiSf+WVEicjuGJdgYKsLJkZNgsidVYVJKj9y11QVUo1d4zJveyNs0BXWwaONhcLhA00q
 KMsghlhwWrZpl3bsmkhVkmES1OTUe+BULiNXzHqEwJ93BLKMDTqrajz1YK9w3fDHbW4HLMPkumr
 cG0YgscF/lWKkBEAsgA==
X-Proofpoint-GUID: wycbmQVzeLc2167TqHVsdQp843sKzAuX
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad13194 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=BTrIe76cHL4Dmed7cV0A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX0l7QBSH0CYiy
 DDE+zwei8Y/eiuUrZlElKB+EIMyDpQ332QIVEw9QbPtby//meo7TJ9Lcq7xv4sfhPDTL18NCQmO
 eYfH8+iwyOyZGVMU0yl4McyWRbOtaQg=
X-Proofpoint-ORIG-GUID: wycbmQVzeLc2167TqHVsdQp843sKzAuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150079
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

Rml4ZXM6IDk4MzFkM2NhYjE2OCAoInRhcmdldC9oZXhhZ29uOiBBZGQgcHJpdmlsZWdlIGNoZWNr
LCB1c2UgdGFnX2lnbm9yZSgpIikKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJy
aWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAg
ICAgICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgIHwgIDEgKwog
dGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYyAgICAgIHwgMTUgKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9nZW5f
dGNnX2Z1bmNzLnB5IHwgMTYgKysrKysrKysrKy0tLS0tLQogNSBmaWxlcyBjaGFuZ2VkLCAyOSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMmRhM2I1ODZiNWEuLmMxYTk0NDky
MGU4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuaApAQCAtMjI2LDYgKzIyNiw3IEBAIHN0YXRpYyBpbmxpbmUgSGV4YWdvbkhWWENvbnRl
eHQgKmhleF9odngoQ1BVSGV4YWdvblN0YXRlICplbnYpCiBGSUVMRChUQl9GTEFHUywgSVNfVElH
SFRfTE9PUCwgMCwgMSkKIEZJRUxEKFRCX0ZMQUdTLCBNTVVfSU5ERVgsIDEsIDMpCiBGSUVMRChU
Ql9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVELCA1LCAxKQorRklFTEQoVEJfRkxBR1MsIENQVV9N
T0RFLCA2LCAyKQogCiBHX05PUkVUVVJOIHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJy
KENQVUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50MzJfdCBleGNlcHRpb24sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IGNjZjlkNTI5
OTdhLi5kYzBjNmIxOGJmMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgK
KysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTQ1LDYgKzQ1LDcgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChncHJfdW5jb25kLCBU
T1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRlOwogI2lm
bmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgdWludDMyX3QgY3B1X21vZGU7CiAgICAgaW50IGdy
ZWdfbG9nW0dSRUdfV1JJVEVTX01BWF07CiAgICAgaW50IGdyZWdfbG9nX2lkeDsKICAgICBERUNM
QVJFX0JJVE1BUChncmVnc193cml0dGVuLCBOVU1fR1JFR1MpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA3OTZiYjZkZjlkYi4u
NDc0YzRiM2M1NTAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jCkBAIC0zNTIsNiArMzUyLDggQEAgc3RhdGljIFRDR1RCQ1BVU3RhdGUg
aGV4YWdvbl9nZXRfdGJfY3B1X3N0YXRlKENQVVN0YXRlICpjcykKICAgICBoZXhfZmxhZ3MgPSBG
SUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIEhWWF9DT1BST0NfRU5BQkxFRCwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNwdS0+aHZ4X2N0eFswXSAmJgogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgR0VUX1NTUl9GSUVMRChTU1JfWEUsIGVudi0+dF9zcmVnW0hFWF9TUkVHX1NT
Ul0pKTsKKyAgICBoZXhfZmxhZ3MgPSBGSUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIENQ
VV9NT0RFLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2V0X2NwdV9tb2RlKGVudikpOwog
I2Vsc2UKICAgICBoZXhfZmxhZ3MgPSBGSUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1N
VV9JTkRFWCwgTU1VX1VTRVJfSURYKTsKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCBiZWVlMDli
YzRjYi4uZTJhNTAzOGExYTUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0xMjg5LDYgKzEyODksMjAgQEAg
c3RhdGljIHZvaWQgZGVjb2RlX2FuZF90cmFuc2xhdGVfcGFja2V0KENQVUhleGFnb25TdGF0ZSAq
ZW52LCBEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgSEVYX0NBVVNFX1JFR19XUklURV9DT05GTElDVCk7CiAgICAgICAgICAgICByZXR1cm47
CiAgICAgICAgIH0KKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgICAgICBpZiAoY2hlY2tf
Zm9yX2F0dHJpYigmY3R4LT5wa3QsIEFfUFJJVikgJiYKKyAgICAgICAgICAgIGN0eC0+Y3B1X21v
ZGUgIT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgICAgIGhleF9nZW5fZXhjZXB0
aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9QUklWX1VTRVJfTk9fU0lOU04pOworICAgICAgICAg
ICAgY3R4LT5iYXNlLnBjX25leHQgKz0gY3R4LT5wa3QuZW5jb2RfcGt0X3NpemVfaW5fYnl0ZXM7
CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICAgICAgaWYgKGNoZWNrX2Zvcl9h
dHRyaWIoJmN0eC0+cGt0LCBBX0dVRVNUKSAmJgorICAgICAgICAgICAgY3R4LT5jcHVfbW9kZSA9
PSBIRVhfQ1BVX01PREVfVVNFUikgeworICAgICAgICAgICAgaGV4X2dlbl9leGNlcHRpb25fZW5k
X3RiKGN0eCwgSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19HSU5TTik7CisgICAgICAgICAgICBjdHgt
PmJhc2UucGNfbmV4dCArPSBjdHgtPnBrdC5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKKyAgICAg
ICAgICAgIHJldHVybjsKKyAgICAgICAgfQorI2VuZGlmCiAgICAgICAgIGdlbl9zdGFydF9wYWNr
ZXQoY3R4KTsKICAgICAgICAgZm9yIChpID0gMDsgaSA8IGN0eC0+cGt0Lm51bV9pbnNuczsgaSsr
KSB7CiAgICAgICAgICAgICBjdHgtPmluc24gPSAmY3R4LT5wa3QuaW5zbltpXTsKQEAgLTEzMjEs
NiArMTMzNSw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fdHJfaW5pdF9kaXNhc19jb250ZXh0KERp
c2FzQ29udGV4dEJhc2UgKmRjYmFzZSwKICAgICBjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCA9CiAg
ICAgICAgIEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVE
KTsKICAgICBjdHgtPmh2eF9jaGVja19lbWl0dGVkID0gZmFsc2U7CisgICAgY3R4LT5jcHVfbW9k
ZSA9IEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgQ1BVX01PREUpOwogI2VuZGlmCiB9
CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkgYi90YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX2Z1bmNzLnB5CmluZGV4IGIwOWNlN2MyODVmLi42MWVmZmEzOGNmYSAx
MDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weQorKysgYi90YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX2Z1bmNzLnB5CkBAIC01OCwxNiArNTgsMjAgQEAgZGVmIGdlbl90Y2df
ZnVuYyhmLCB0YWcsIHJlZ3MsIGltbXMpOgogCiAgICAgZi53cml0ZSgiICAgIEluc24gKmluc24g
R19HTlVDX1VOVVNFRCA9IGN0eC0+aW5zbjtcbiIpCiAKLSAgICBpZiAiQV9QUklWIiBpbiBoZXhf
Y29tbW9uLmF0dHJpYmRpY3RbdGFnXToKKyAgICBpZiAoCisgICAgICAgICJBX1BSSVYiIGluIGhl
eF9jb21tb24uYXR0cmliZGljdFt0YWddCisgICAgICAgIG9yICJBX0dVRVNUIiBpbiBoZXhfY29t
bW9uLmF0dHJpYmRpY3RbdGFnXQorICAgICk6CiAgICAgICAgIGYud3JpdGUoZGVkZW50KCIiIlwK
ICNpZmRlZiBDT05GSUdfVVNFUl9PTkxZCi0gICAgaGV4X2dlbl9leGNlcHRpb25fZW5kX3RiKGN0
eCwgSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19TSU5TTik7Ci0jZWxzZQogIiIiKSkKLSAgICBpZiAi
QV9HVUVTVCIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ106CisgICAgICAgIGlmICJBX1BS
SVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgorICAgICAgICAgICAgZi53cml0ZSgi
ICAgIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsICIKKyAgICAgICAgICAgICAgICAgICAg
IkhFWF9DQVVTRV9QUklWX1VTRVJfTk9fU0lOU04pO1xuIikKKyAgICAgICAgZWxzZToKKyAgICAg
ICAgICAgIGYud3JpdGUoIiAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCAiCisgICAg
ICAgICAgICAgICAgICAgICJIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX0dJTlNOKTtcbiIpCiAgICAg
ICAgIGYud3JpdGUoZGVkZW50KCIiIlwKLSNpZmRlZiBDT05GSUdfVVNFUl9PTkxZCi0gICAgaGV4
X2dlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwgSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19HSU5TTik7
CiAjZWxzZQogIiIiKSkKICAgICBpZiBoZXhfY29tbW9uLm5lZWRfZWEodGFnKToKLS0gCjIuMzQu
MQoK

