Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED6C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB7U-0005gP-Au; Wed, 12 Aug 2026 11:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB7O-0005In-BG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB7M-0000Td-LD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDc5cl3875922
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NGriTnLoz2RElF9KQ1Lq7rPTXvqV1eVC9zv9DU0v1dY=; b=Dx7RIuzAPwAlPMeD
 3m5AkWoOGb28slYi5QPa0/R4tjouz3w7yo6RLUbRdyG/0HwbKDxTGtkx7sBtq85M
 VHGX9qL0a7Zcf/i/hVzeXmpAw6lXp+/5xzoWC6yYXyD3uZGvsOT1egI1wUZ0DB+b
 l1q+p2b7N/ucsYAofiU38Cqj7u12ytDx2wqac9vwxEhUBXSP5X429jd9CLPhA94C
 jmNIGNixMAXVHSp42O5YI4mjzPdBR+jKDvrYzibaQd0g6QEcw3WGZG5L0VjBPFVn
 OzX7rkz1MMSyXOVb+Cza7M01dGqE24f+gLaXQ2FIPpxnTdIzJLWERr1Fb8LVk0DQ
 kVOSbg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1jsvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ce7fabf76so1635122a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549417; x=1787154217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NGriTnLoz2RElF9KQ1Lq7rPTXvqV1eVC9zv9DU0v1dY=;
 b=BIbOktY3K6gcY5VrMB6QnPliBsYmlkIS7vK/3DB2utt2TfFGjHU+OptA+nrZFTBhP4
 Ml2MGPIs5HZn3oFcjXpq+LVM/aQJuj5a8Mt0TqXqiJcDGXViAREuSxxJmSK/RncSbbsK
 FKTsRT9eqLnMvlz3bDxOYQfGAeTiXvqx8FEstHeFoEhopITUZU0iXRMAYGlfopW+mPpw
 b6xX/uw6TbUvLuGY6eZWOzgV0d5LNHauUgUSAlkgzcJzPv53w2DE8ufkGketVgWlbkUW
 SaofPT0aFNnaAwL+x0tSpVLVSwQfuCK3cPBLYZHuMDy0awU6SH0noVV8OOoSGmYpL26d
 rBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549417; x=1787154217;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NGriTnLoz2RElF9KQ1Lq7rPTXvqV1eVC9zv9DU0v1dY=;
 b=pxHyDKH0YPrx8fq9PJHHlEi4j046GfbclNR1UelSYX06SUIcxgdoMXqraal2tBDcYw
 ckS7DKQNnl9HEnRhir2UJ+I7mfMyX3GF/N6viU0Z2dxgRgJtgViZVf8C9+QqmCISgGCW
 8wJbl3jrdORnJGK4rI1RAuhDa6Iy5zjdafxdrYzVgME9jvt4KpaTtN3ukIMQ69AHAgRi
 0QURAmShdNa9e7RAAy2SEeKalsdj3uSh0sThLb443wMINKDfLYH69kG2aqTpZAR4Ho5M
 41ciG6nrG4KEYZRkHW+/xd1rIG1MRGYdp9KAJoBLV0COu4JMngulyLEhgmVIF3U0YaON
 upkw==
X-Gm-Message-State: AOJu0YxEdZD6jYAETECm/3jOj8Y/v+NecOYQe4mIQEWHM2fRihY2orPL
 AHxhymV7s1cCD9AkMeuH2qv7BajAJtL736qXFJB639j+yMLg31W4TM2N11E1Pl9SDQ5c475bG5E
 xTqEceLKx/9lEJMD+KX5EKBGzIq5LhgTVCqxqYlvRquEJGRVbnYPX3bdBLR/Z2iRzTg==
X-Gm-Gg: AR+sD13u25a0Th++q2SP4bFB3n1zucbeSbHbUmJQsuuWcKuQIrV9V5EgBFfCqA8TXPT
 ZiADb1YAN8jWRh0DNSccQr6QdqLPwLP1guW7BO1BQ4Mw3Kkiwo6c1O9m1VbvzkuHBE9GBONsYs3
 slafvryhEjRh8DoZh1Su6nyDyK/320Kh19QDqd8036rAY/flWFx7YjmL8ZJEATYgpN/3jztkHH7
 Dr277wdqYIrpCQ7L8lCecZtFdXsB6TfkT38lIRudPQ7AJRuKUqLuXGduOT+08raYkSNQFPiMdB2
 EzvxQejVaWFVhgUqas+L9/zrrzzhr0IWCJUM/rsDUm98AnqYLW+8GlmCux/Mf1uw2NbXQ4nRmK2
 gtb8z1VkLLzuh4fscN634O9/XkPr8+CViHCAvU2AWFhuBjutf
X-Received: by 2002:a17:90b:164c:b0:38e:740f:9764 with SMTP id
 98e67ed59e1d1-393016a76cdmr6819837a91.18.1786549416665; 
 Wed, 12 Aug 2026 08:43:36 -0700 (PDT)
X-Received: by 2002:a17:90b:164c:b0:38e:740f:9764 with SMTP id
 98e67ed59e1d1-393016a76cdmr6819788a91.18.1786549416181; 
 Wed, 12 Aug 2026 08:43:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 38/41] tests/hexagon: add tests for v68 HVX IEEE float
 min/max
Date: Wed, 12 Aug 2026 08:42:17 -0700
Message-Id: <20260812154220.1029828-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: PF5JlROWzR4XZ8x3O4ukAd-2SXjjOrZI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX32gf/Szai8uh
 ftIlapff+6n5bnOSYYKgEY5i1qq3ntARIGT2ECvYgrlrHFopIG+PPK97RrsEMRto8Vx1x7WWJ4E
 VwH+EX0Rw7tgb4JsBqx8s5HEiERnu6ap/RzVAMhPOX+e5eVbTIprFNULKbWOeYQ35QZrYuOK5gy
 SRTzRSQP01m1TEknXb5HzS2L/3HX2bIZJZow9WNHt/XyBEUmtM0icPsWY2CjiRil2HTSWDEbrkJ
 48hTQHxbp7NeREdl/1J8g3mVFrDE56/jW7ipA1jZAMOEP+5gz2udwSGKnCNpscTeXNQWw7B8zIt
 c0UqHEFJBYL2ce1/kuKFBCp2AgmSXGtUJz8E9gWeQWO6P7xQhPANuPgmDbjLHMqcCGf91S7iMfQ
 JNnHCIdK8YM/8m9gRZ7xn7GidNnm0UPRdoHSTgXI3Ib0e2Sd/XXUitEg+h7XG6hb+H0a0y0wfZQ
 wZkhRdzakiSLeXrf36Q==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c94a9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=kx3085Z4g_GOeJDqwkIA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: PF5JlROWzR4XZ8x3O4ukAd-2SXjjOrZI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX/WfFh6HidesT
 gzxb8rcvvgU1NQ/q122aH7J3ZnX9VZOJEiJXpLhHeNZZo5mEPc+xpimhvSxrtwLuhD2MPgS9ebm
 o1pZXoP6DqhiMj/nL0DijczEp2fYkIc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120128
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNv
bkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxt
YXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC83ZmRiYzEyZWQ0YzYyYTE2MDY4YzM4MGE4NWVlMjM1NjA1MWU2MWVh
LjE3NzYzMzk0NTEuZ2l0Lm1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
ZXN0cy90Y2cvaGV4YWdvbi9mcF9odnguYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0
cy90Y2cvaGV4YWdvbi9mcF9odnguYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ZwX2h2eC5jCmluZGV4
IGEzMDk2NTRlZDc4Li5kZWUwNzgxYmQ3MiAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24v
ZnBfaHZ4LmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vZnBfaHZ4LmMKQEAgLTczLDYgKzczLDMw
IEBAIERFRl9URVNUX09QXzIodnN1YiwgU1VCX0hGLCBoZiwgaGYpOwogREVGX1RFU1RfT1BfMih2
bXB5LCBNVUxUX1NGLCBzZiwgc2YpOwogREVGX1RFU1RfT1BfMih2bXB5LCBNVUxUX0hGLCBoZiwg
aGYpOwogCisjZGVmaW5lIHNpZ25iaXRfZnAoWCkgXAorICAgIChzaXplb2YoWCkgPT0gYnl0ZXNf
aGYgPyAoKHJhd19oZihYKSAmIDB4ODAwMCkgIT0gMCkgOiBcCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICgocmF3X3NmKFgpICYgMHg4MDAwMDAwMCkgIT0gMCkpCisKKyNkZWZpbmUgU1RE
X01JTihYLCBZKSAoKFgpIDwgKFkpID8gKFgpIDogKFkpKQorI2RlZmluZSBTVERfTUFYKFgsIFkp
ICgoWCkgPiAoWSkgPyAoWCkgOiAoWSkpCisKKyNkZWZpbmUgTUlOKFgsIFksIERFRl9OQU4pIFwK
KyAgICAoKGlzbmFuKFgpIHx8IGlzbmFuKFkpKSA/IERFRl9OQU4gOiBcCisgICAgICgoWCkgIT0g
KFkpKSA/IFNURF9NSU4oWCwgWSkgOiAoc2lnbmJpdF9mcChYKSA/IChYKSA6IChZKSkpIC8qIC0w
IDwgKzAgKi8KKyNkZWZpbmUgTUFYKFgsIFksIERFRl9OQU4pIFwKKyAgICAoKGlzbmFuKFgpIHx8
IGlzbmFuKFkpKSA/IERFRl9OQU4gOiBcCisgICAgICgoWCkgIT0gKFkpKSA/IFNURF9NQVgoWCwg
WSkgOiAoc2lnbmJpdF9mcChYKSA/IChZKSA6IChYKSkpIC8qIC0wIDwgKzAgKi8KKworI2RlZmlu
ZSBNSU5fSEYoWCwgWSkgTUlOKFgsIFksIE5BTl9IRikKKyNkZWZpbmUgTUFYX0hGKFgsIFkpIE1B
WChYLCBZLCBOQU5fSEYpCisjZGVmaW5lIE1JTl9TRihYLCBZKSBNSU4oWCwgWSwgTkFOX1NGKQor
I2RlZmluZSBNQVhfU0YoWCwgWSkgTUFYKFgsIFksIE5BTl9TRikKKworREVGX1RFU1RfT1BfMih2
Zm1pbiwgTUlOX1NGLCBzZiwgc2YpOworREVGX1RFU1RfT1BfMih2Zm1heCwgTUFYX1NGLCBzZiwg
c2YpOworREVGX1RFU1RfT1BfMih2Zm1pbiwgTUlOX0hGLCBoZiwgaGYpOworREVGX1RFU1RfT1Bf
Mih2Zm1heCwgTUFYX0hGLCBoZiwgaGYpOworCiAvKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgKiBP
dGhlciB0ZXN0cwogICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwpAQCAtMTUwLDYgKzE3NCwxMiBAQCBp
bnQgbWFpbih2b2lkKQogCiAgICAgdGVzdF9uZXcoKTsKIAorICAgIC8qIG1pbi9tYXggKi8KKyAg
ICB0ZXN0X3ZmbWluX3NmX3NmKCk7CisgICAgdGVzdF92Zm1pbl9oZl9oZigpOworICAgIHRlc3Rf
dmZtYXhfc2Zfc2YoKTsKKyAgICB0ZXN0X3ZmbWF4X2hmX2hmKCk7CisKICAgICBwdXRzKGVyciA/
ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/IDEgOiAwOwogfQotLSAKMi4zNC4x
Cgo=

