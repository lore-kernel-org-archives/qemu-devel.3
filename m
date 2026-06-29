Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3F9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39g-0001hB-RT; Sun, 28 Jun 2026 23:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39W-0001dy-0c
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39U-0006HZ-Ax
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2dSI01546748
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=; b=MkfXMNYPCslDDLiR
 QPTkanVYX8NgQS0NInkMENZRNCiQgCq5PPvVYk0ESdihIQlUXK8dDoDi11zROJrl
 HEso62tPNC/yEaBjGEu2NDkimU0iO6qvUZ40mYVekB2aEn7J+ZF26BU2cfBVM1a5
 B6/zvNEljJd+1bIFhjf1+q5d9zSY4z1M/Oil+KbDpSYQKKc4nUfIcQB2CEoNBkBQ
 DF/ANRKsNzO7YBNqYLyx4mIteB4yetc6BWnUMjaYZSn6IpXm2Wa6jOEqiMuU73Kj
 P26BcEZdUcg3QFoMf1IMsUiXXYh43aWK4NZR8VuHrJEPoNhKGAv9J3qlothwmngL
 Zk2pyA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27084b05-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:18 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1370417c0bfso3341655c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705558; x=1783310358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=;
 b=Gl3lRFTnn8aS6CdOGtFfIKRaYwbVoIri6k7dAyew3D1Fa6ZMihW335KqagegjCB4M8
 RPhycywSR6rDo1JEQoTAVNEHQ1bELQ+XBtj+fWRxJMRQkcjTzmxYOyEPzeKTGL6rdmhU
 nsQWdYDwJJ/nqeUjbjZr8IM7XN50dhyLWoqLOEyBPrAtidmrjwVdVAGeRW1cuxaAH6uR
 TNgywnAuIibpbjFOuhx745wf7L8xv03Kb2brv3j4eYk6+p2rGL5Q8Ap0AoE2Ug94rufv
 yrvsh/q69QqBvQOUqwNk3LiRjEKafxL+qzhpi11+LlSt/GxDxlVFj5TLWzZ92pdkrbF6
 qi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705558; x=1783310358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=;
 b=X5VNdZWfQj6hUWcNFKGlGpxOGL6ItoaQI7rvGvJ0Yaefw59GdIBAlwXgL9lmhr9d40
 xEXj9Fh4KjWqtfL6YqERWcmmsXpzvCJGzSOmyynsHge64LiHcmsn3M0wxFwmCZVDkDZl
 w+CZaeIjer7BP755nrjemf7XsiWnWMh1Z1Hq1OC2cZ3iRBDqpLZBaTyfhNqWoeJORMof
 TNZ9IOzMXVX4jWX3Iv/ND2Aq+9d3lkkBT20pmh6LVI8+JuvAI7sJ21lcGcsjtZn6CEUB
 tjQSYc3d7M0qBDaVUwGf9b3fSsycs7CRIiJ03+mCP7/VO1auyxvGU0FmehpEsdAlG+Tc
 oK1g==
X-Gm-Message-State: AOJu0Yyga7fUAl2KUY0iN3lvt93jG2P6Z/ecfsaHWfB3SG8AfT08TMWl
 lbfVsp7Co5mBYeTwd3ToUtKb/rr8aaMBnoQiUSABcNHKYRjwPfA+QTd9POAvSzgonzWqt85uNWN
 XCAGA8wJGlt2fU5/26KX8RJZx9gtFYuUrx7yyXeTxxw+CIAkFSIuL6CORqeVxMXj/0w==
X-Gm-Gg: AfdE7cnREUOV6nkNpePNdV4BGJoLBGMK66hWIWTQTVlVInqQ6hgRlEsgoJT27LulyGi
 tLMDqFtdlZhNQJ4xQCQmBZ7ayILU+UhtPG6fja/MouNLBnNxGlRceg7xs7A2itADiySGgMQQncC
 t/RlXnyo7sKTG+qxR4BQZqyb4yphUX6ew9BhR0jV7CYgswRrOCSNED4kc3jh0GyUo0RzmC1MIQe
 /93m3YhUln76TrDhWFPUfkcrxW/EkGQEEhDFxsi/v0x6D/xpOBKemADZc82GB7bJi30CJ7WWtQZ
 6EymSq9UiZClvKjRuxBNkjaAi8R1kNHiwOvyM6KypTKnD7kwb7AzHpA4tGsPY5wPQj4sakOWTNp
 +uI7q494iEsSurQ0ewDSrvogBqyJa5Rki4v+OunJqVhvGbOcXLNZlYgtCJyw=
X-Received: by 2002:a05:7022:981:b0:138:40b4:6cf9 with SMTP id
 a92af1059eb24-139dba1b972mr12538276c88.19.1782705558073; 
 Sun, 28 Jun 2026 20:59:18 -0700 (PDT)
X-Received: by 2002:a05:7022:981:b0:138:40b4:6cf9 with SMTP id
 a92af1059eb24-139dba1b972mr12538240c88.19.1782705557577; 
 Sun, 28 Jun 2026 20:59:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 24/77] target/hexagon: Define register fields for system regs
Date: Sun, 28 Jun 2026 20:57:37 -0700
Message-Id: <20260629035830.1520296-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a41ed96 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX0seQTDh0EEyb
 fHsFUHwCYYvqqmKxLesKM2hFE5EOcJpdJv7RYGV5TQe7AwQnW652k3wwWSoZ6doKgvNDSd/xQu4
 Vm1F97LTJOLfCkBWsjN8YmRhpug2qqVgc6xml9zlcOdWn+NHoJMEgj37+fhTISTD57sXINUTxx5
 yp5ODRXpYkvvrytRVt1breCxxj11IV5iYjKlHLcQZYsy00QBQ7GvAZs23wb/fANmU+34HdUaLnc
 SrLcCWxbgvOI6AXjSAgFwFxtLgljwSJJk07s95d2Y0dJOY5URQGWm0JWXD5ro6NJFJzwWYqwRQh
 vqI9p+SsUjqksObL5+oDOxDpO6gegT/xeeZu1DdF0hZ5l5QtEW52VaE0vLMIHN86IQyrxzPZ+0R
 yjBJI89+FUv3aY739iER+SZbz4bUg4C+130ypXjzu7cHwHgzg6Uy5c0Siu8evz3x9Vub9ZEUckc
 EBAB2kPpKoEgHm8oPgQ==
X-Proofpoint-ORIG-GUID: qB7R_IbZr0A3S8PcyeSFwpoPF5V7-NW7
X-Proofpoint-GUID: qB7R_IbZr0A3S8PcyeSFwpoPF5V7-NW7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX05p134scvmgx
 emiWi+p49d9peRVMKpAfBiDygXB9fIG/lbCB62jmL6s8wSanF3av0I8S+8ePoIuT4EI99azvLXo
 iIBmvvGbLYFN5YHmGpU3VOcVUPEZhNM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgdGhlIHJlZ2lzdGVy
IGZpZWxkcyBmb3Igc3NyLCBzY2hlZGNmZywgc3RpZCwgYmVzdHdhaXQsIGNjciwKbW9kZWN0bCwg
aW1hc2ssIGlwZW5kYWQuCgpEZWZpbmUgdGhlIGZpZWxkcyBmb3IgVExCIGVudHJpZXMuCgpSZXZp
ZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIHwgOTYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgYi90YXJnZXQvaGV4YWdvbi9y
ZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCBmMmE1OGQ0ODZjNS4uOWIxMTJjY2VjNjQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0zOSwzICszOSw5OSBAQCBERUZfUkVHX0ZJ
RUxEKFVTUl9GUERCWkUsICAgICAgICAyNiwgMSkKIERFRl9SRUdfRklFTEQoVVNSX0ZQT1ZGRSwg
ICAgICAgIDI3LCAxKQogREVGX1JFR19GSUVMRChVU1JfRlBVTkZFLCAgICAgICAgMjgsIDEpCiBE
RUZfUkVHX0ZJRUxEKFVTUl9GUElOUEUsICAgICAgICAyOSwgMSkKKworREVGX1JFR19GSUVMRChJ
UEVOREFEX0lBRCwgMTYsIDE2KQorREVGX1JFR19GSUVMRChJUEVOREFEX0lQRU5ELCAwLCAxNikK
KworREVGX1JFR19GSUVMRChTQ0hFRENGR19FTiwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU0NIRURD
RkdfSU5UTk8sIDAsIDQpCitERUZfUkVHX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIDAsIDkpCisKKwor
LyogUFRFIChha2EgVExCIGVudHJ5KSBmaWVsZHMgKi8KK0RFRl9SRUdfRklFTEQoUFRFX1BQRCwg
MCwgMjQpCitERUZfUkVHX0ZJRUxEKFBURV9DLCAyNCwgNCkKK0RFRl9SRUdfRklFTEQoUFRFX1Us
IDI4LCAxKQorREVGX1JFR19GSUVMRChQVEVfUiwgMjksIDEpCitERUZfUkVHX0ZJRUxEKFBURV9X
LCAzMCwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX1gsIDMxLCAxKQorREVGX1JFR19GSUVMRChQVEVf
VlBOLCAzMiwgMjApCitERUZfUkVHX0ZJRUxEKFBURV9BU0lELCA1MiwgNykKK0RFRl9SRUdfRklF
TEQoUFRFX0FUUjAsIDU5LCAxKQorREVGX1JFR19GSUVMRChQVEVfQVRSMSwgNjAsIDEpCitERUZf
UkVHX0ZJRUxEKFBURV9QQTM1LCA2MSwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX0csIDYyLCAxKQor
REVGX1JFR19GSUVMRChQVEVfViwgNjMsIDEpCisKKy8qIFNZU0NGRyBmaWVsZHMgKi8KK0RFRl9S
RUdfRklFTEQoU1lTQ0ZHX01NVUVOLCAwLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfSUNFTiwg
MSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0RDRU4sIDIsIDEpCitERUZfUkVHX0ZJRUxEKFNZ
U0NGR19JU0RCVFJVU1RFRCwgMywgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0dJRSwgNCwgMSkK
K0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0lTREJSRUFEWSwgNSwgMSkKK0RFRl9SRUdfRklFTEQoU1lT
Q0ZHX1BDWUNMRUVOLCA2LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfVjJYLCA3LCAxKQorREVG
X1JFR19GSUVMRChTWVNDRkdfSUdOT1JFREFCT1JULCA4LCAxKQorREVGX1JFR19GSUVMRChTWVND
RkdfUE0sIDksIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19UTEJMT0NLLCAxMSwgMSkKK0RFRl9S
RUdfRklFTEQoU1lTQ0ZHX0swTE9DSywgMTIsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19CUSwg
MTMsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19QUklPLCAxNCwgMSkKK0RFRl9SRUdfRklFTEQo
U1lTQ0ZHX0RNVCwgMTUsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMkNGRywgMTYsIDMpCitE
RUZfUkVHX0ZJRUxEKFNZU0NGR19JVENNLCAxOSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wy
TldBLCAyMSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyTlJBLCAyMiwgMSkKK0RFRl9SRUdf
RklFTEQoU1lTQ0ZHX0wyV0IsIDIzLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJQLCAyNCwg
MSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX1NMVkNUTDAsIDI1LCAyKQorREVGX1JFR19GSUVMRChT
WVNDRkdfU0xWQ1RMMSwgMjcsIDIpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMlBBUlRTSVpFLCAy
OSwgMikKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyR0NBLCAzMSwgMSkKKworLyogU1NSIGZpZWxk
cyAqLworREVGX1JFR19GSUVMRChTU1JfQ0FVU0UsIDAsIDgpCitERUZfUkVHX0ZJRUxEKFNTUl9B
U0lELCA4LCA3KQorREVGX1JFR19GSUVMRChTU1JfVU0sIDE2LCAxKQorREVGX1JFR19GSUVMRChT
U1JfRVgsIDE3LCAxKQorREVGX1JFR19GSUVMRChTU1JfSUUsIDE4LCAxKQorREVGX1JFR19GSUVM
RChTU1JfR00sIDE5LCAxKQorREVGX1JFR19GSUVMRChTU1JfVjAsIDIwLCAxKQorREVGX1JFR19G
SUVMRChTU1JfVjEsIDIxLCAxKQorREVGX1JFR19GSUVMRChTU1JfQlZTLCAyMiwgMSkKK0RFRl9S
RUdfRklFTEQoU1NSX0NFLCAyMywgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1BFLCAyNCwgMSkKK0RF
Rl9SRUdfRklFTEQoU1NSX0JQLCAyNSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1hFMiwgMjYsIDEp
CitERUZfUkVHX0ZJRUxEKFNTUl9YQSwgMjcsIDMpCitERUZfUkVHX0ZJRUxEKFNTUl9TUywgMzAs
IDEpCitERUZfUkVHX0ZJRUxEKFNTUl9YRSwgMzEsIDEpCisKKy8qIG1pc2MgcmVnaXN0ZXJzICov
CitERUZfUkVHX0ZJRUxEKElNQVNLX01BU0ssIDAsIDE2KQorCitERUZfUkVHX0ZJRUxEKFNUSURf
UFJJTywgMTYsIDgpCitERUZfUkVHX0ZJRUxEKFNUSURfU1RJRCwgMCwgOCkKKworLyogTU9ERUNU
TCBmaWVsZHMgKi8KK0RFRl9SRUdfRklFTEQoTU9ERUNUTF9FLCAwLCA4KQorREVGX1JFR19GSUVM
RChNT0RFQ1RMX1csIDE2LCA4KQorCitERUZfUkVHX0ZJRUxEKENDUl9MMUlDUCwgMCwgMikKK0RF
Rl9SRUdfRklFTEQoQ0NSX0wxRENQLCAzLCAyKQorREVGX1JFR19GSUVMRChDQ1JfTDJDUCwgNiwg
MikKKworREVGX1JFR19GSUVMRChDQ1JfSEZJLCAxNiwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX0hG
RCwgMTcsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9IRklMMiwgMTgsIDEpCitERUZfUkVHX0ZJRUxE
KENDUl9IRkRMMiwgMTksIDEpCitERUZfUkVHX0ZJRUxEKENDUl9TRkQsIDIwLCAxKQorCitERUZf
UkVHX0ZJRUxEKENDUl9HSUUsIDI0LCAxKQorREVGX1JFR19GSUVMRChDQ1JfR1RFLCAyNSwgMSkK
K0RFRl9SRUdfRklFTEQoQ0NSX0dFRSwgMjYsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9HUkUsIDI3
LCAxKQorREVGX1JFR19GSUVMRChDQ1JfVlYxLCAyOSwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX1ZW
MiwgMzAsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9WVjMsIDMxLCAxKQotLSAKMi4zNC4xCgo=

