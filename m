Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E4AC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrer4-0005sS-D7; Wed, 05 Aug 2026 12:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer2-0005sA-Pt
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer1-00034m-5c
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:32 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVKu93297599
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=62z3gxWbACLZz7HZD3+BO1
 0Zd4zr28RrU6hnB+QiaMQ=; b=D1GJoph2+fe6Nri5hmBJY0qYf5tWOYf36FyoYg
 /NQFP8BScSvuoY8jMsmzfFk/Ixeuxk38JoyHBYqs1993SZIPBaayFoA47LAn2oLy
 AwurH+ew5Ry0nRAuuoqErlWD34soSpQA8uLdQuaPI3hkQpii1idbGphq9h7Tdtgv
 GH3dwma3lQaWfpINKMfO7k+B0O4xSOcj0uTa9B5xDDkbL2QNWck+IWj7biMAdKiz
 wXeLA+DQpVjFg4UJS2l7cOugHOo7gv11StRP4A5Orex4ful9XfI+RULNdjeOAzNc
 TtbPlzg1Ou96fSeOXOUpdYhKzNFvFT4pysm636KopfiyFktw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5s44b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:52:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cccfa32670so16657085ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785948748; x=1786553548; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=62z3gxWbACLZz7HZD3+BO10Zd4zr28RrU6hnB+QiaMQ=;
 b=UC6vnZIiRJlQGpLjMXKZfrsQXZes6iih05va6EUKFoYrK3RT1z1ckOMOmaJtMYCoNF
 NFIS0W+tM5YmsHxyP8HjhqQQMO93uH7LkTwOUmA4ssAMnKvnsm+LCRG+n9F1iDhQqVFI
 uhNyVOsHtbG/sG40OxMACeUuZa3lP8ULY+/xQjhHkC4SI/y1+ZoarCJJspsseF5iT6wi
 NKZXyiWspLHLsLsyU1oRHCxQRwsvEkGZI9vFq7KDwC6lTbnSAg4CBdmoW/5qcMN1heIt
 /Tvew67npR2RvKS3RwwJX+ySOClVgZYswY5Jww5PIfqPtyKh+Ua8m6z1th24mYK98L6Z
 sobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948748; x=1786553548;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=62z3gxWbACLZz7HZD3+BO10Zd4zr28RrU6hnB+QiaMQ=;
 b=XUUrTNGABfjNQygnMoNVgRX/5a7lCcevp85NcxkEG6PAByFCvgn/JeVhpSEONRDcFv
 7DKCiWlaz8ozJMc20ZYf2twNQSb3IPnxpL1L/Jat2UV+KovZzSKAWXSETGu1kshIDSYL
 ijnQ04adUD7anD2pDFYVSC2/9UEGk3XedliJIKeRlF52AZ6RcOySjdw0/btKeF0jyVpD
 HjPTiQNFgUeFJkdhDasKgvhjH2Iqr1zzc2nwLa8Da/uyluj2qqSJCdi60/4mU/6y0lZL
 Fjzk6BOjnhNDPO0k05NsBDnnEl5aHd5QFJWMw1ZVBM3nglyu1U5UPYpzvR0gdkCQfQup
 QVzg==
X-Gm-Message-State: AOJu0Yw6leyXNSKv3bpg43T5jdB1vrOLpyhUrnbk71WgyaBU/3QFC8+7
 aA/UMVje15f5d4cXiKaZxy3GwgEP24ahdXBMOf69ppusgahke9maTmZf4BoAjyDn2sI9iZ9sceD
 5MWsUo3b+PnmZpevN2yHJbdPqseLThrPlj4cxGs20o7EjY2MtVPSOw/NSaUr29ftRMw==
X-Gm-Gg: AR+sD10ip0SEE40KR88VhHqnmf16ieyoPg1A3PKArHK5eg6PDuXgEOeHw0QfMXOu8lE
 hcf7/PpwcRBvuwFjcxlU6U90usOW3RKu9Zeu5Kp95v1Lff5K+qAOoX943ZnD8udP+pwFz5Azv0X
 1zVGIRZdjkTeNHAOCcx2szyW579QwEx+ucnW3JpAcBvdB4G/0O7EFEE9wphT5OXZZyRyiZ5oHrs
 PD7wCfh4HT5sWEh+ByAzyNC5gzU8nLEHIam0Dop29Dn1dLOYqRaETcaHJu5aDAqGqT1cNo05MJ9
 M1WFnywTIsvJKvvTUdu+pc4/LHHCx1e6zImA4cCJx0dj4nROCQSou9AMSbdK7h4D1wYOmHhJ3Jd
 QfTmDgaCvtT70SShL3YqNWL908+iM4kabZ/o6WN5IZNa8n7hu
X-Received: by 2002:a17:902:e951:b0:2ca:bf68:2a54 with SMTP id
 d9443c01a7336-2d0ca96246bmr104320595ad.22.1785948747799; 
 Wed, 05 Aug 2026 09:52:27 -0700 (PDT)
X-Received: by 2002:a17:902:e951:b0:2ca:bf68:2a54 with SMTP id
 d9443c01a7336-2d0ca96246bmr104319955ad.22.1785948747353; 
 Wed, 05 Aug 2026 09:52:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586402e53sm26429356eec.11.2026.08.05.09.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:52:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
Subject: [PATCH 0/6] Fid host-utils sat; Add GVec overrides for HVX ops
Date: Wed,  5 Aug 2026 09:52:19 -0700
Message-Id: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: L0Crz-9VfZoOfnGPP78m0IHL9wFszm3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfXxZ7wrOQqFxVZ
 MugaZz23R9eir+6fXxJR7DpYBcDLLRWlr+7pCI/zJjRyzsPxJ2oPlg/Z8V5Nm39kwLSeUrmfjs1
 WUjjgXgoQb4k2eSHAXIfJFNIYnDVYb2D+8OJqyyT4xEgBMhX4vR2gWwzjPhxLqHk0c1rwb7t8U/
 yOPvYzFJikwn+dfeoo++0tKTVHegtN+o+vqW4rVxOn5+tjSluICQ8TcgMEKgBBcmJa34QsAVD5j
 p8M837UezvNhUtOdOZ6OhhlDpH1j58IRD2IH0lVt4XeW19Mb9I+KEzQ2P0yfvqc4NGuLexdem5u
 1lrQ3dhX/EfCPRvVAHImbCOYw5l24IGuHQun5pIFi+Dy/ZGx5Nz6aETEyoQ8pSkr4wEAd9RcL8P
 zqOG1u1LCTl0TaVeVPMSe/SOPWPxdJG6Z/M5jvC/3UAKZLGi3jZXAoEHKeLeG0UyyMfmT3po87G
 P0G09LJrKeFRR03cKUA==
X-Proofpoint-ORIG-GUID: L0Crz-9VfZoOfnGPP78m0IHL9wFszm3l
X-Authority-Analysis: v=2.4 cv=RcygzVtv c=1 sm=1 tr=0 ts=6a736a4c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=CSytcpjD2ImRARjU3zIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfXzyOxfsp9QY5F
 K0y7a7SrldkynozfVZ06P0GS2rm6VPP4pvvsgow0KBZkec/c3m51kbsji6sOMP+u3Ir4Qa3wzqb
 2wsbH6hstI9IriC4EZWDJOFZhY2fOmY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050138
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

SSB3YXMgZ29pbmcgdG8ganVzdCBzZW5kIHRoZSBob3N0LXV0aWxzIGNoYW5nZSBvbiBpdHMgb3du
IGJ1dCBmaWd1cmVkCml0IG1pZ2h0IGJlIHVzZWZ1bCB0byBoYXZlIHRoZSBtb3RpdmF0aW5nIGNv
bW1pdHMgdGhhdCBlbmNvdW50ZXJlZCB0aGUKaXNzdWUsIHNvIEkndmUgaW5jbHVkZWQgdGhvc2Ug
aGVyZSB0b28uCgpCcmlhbiBDYWluICg2KToKICBob3N0LXV0aWxzOiBmaXggc3N1YjMyLzY0X3Nh
dHVyYXRlIHJldHVybiB0eXBlIGFuZCBjbGFtcCBkaXJlY3Rpb24KICB0YXJnZXQvaGV4YWdvbjog
YWRkIEdWZWMgb3ZlcnJpZGVzIGZvciBIVlggc2F0dXJhdGluZyBhZGQvc3ViCiAgdGFyZ2V0L2hl
eGFnb246IGFkZCBHVmVjIG92ZXJyaWRlIGZvciBIVlggdm1weWloIG11bHRpcGx5CiAgdGFyZ2V0
L2hleGFnb246IGFkZCBHVmVjIG92ZXJyaWRlcyBmb3IgSFZYIGFic29sdXRlIGRpZmZlcmVuY2UK
ICB0YXJnZXQvaGV4YWdvbjogYWRkIEdWZWMgb3ZlcnJpZGVzIGZvciBIVlggdmVjdG9yIGF2ZXJh
Z2UKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIEhWWCB0ZXN0IGZvciBWNl92c3Vid3NhdCBzYXR1
cmF0aW9uCgogaW5jbHVkZS9xZW11L2hvc3QtdXRpbHMuaCAgICB8ICAyMCArKy0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgMTgzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIHwgIDQ0ICsrKysrKysrKwogMyBm
aWxlcyBjaGFuZ2VkLCAyMzcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgotLSAKMi4z
NC4xCgo=

