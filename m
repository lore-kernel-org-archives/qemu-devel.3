Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F52ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3V-0002dW-0P; Thu, 11 Jun 2026 01:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2s-0001gb-Jg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2q-0002oa-PG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GJpl3843681
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=; b=TKl2MJXzXQBgrU8J
 qC/x2PxZw7C5V/U4IXMN14h7YnHL6BHVOoh6Kou3Ft3Ubizn/52ijR/oQgODdni7
 56mS3TB/WBnNh8iIA5WeTNEsj5Afj/4foXYSqB0anW0zJ1yn7jBrqCYubzXMe6JX
 fSaMgAPSHoaP2ZhfMxw62IkM1X6fzWqcazz0lHdL2uhN3Sn1S5jn8sslP/e+QbX1
 wIwVDYIjXYI61NdtHIGKsZ5IN6T66SsmOvv+qO09DX6dxJTDqGdUM6J7/1FZzqDo
 VAtrlz34ZKVTwjqo6IWRHaFjcrHMz3OHsjzpbH+JKoHbK0VdJsuKU2ICMAFBZ5Ib
 IukH4w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701ru0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d8613efbso8106936eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156014; x=1781760814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=dN7/EvOeZMbj1rZ7LZPWLkWYk1wyxW229HvcRAm8TEVMOQiKf1E8TyuADVekc+OoO6
 EINTBV7bjPGWJVQFgpJE4LM/OAcKzhB6dFojvcoRAn2NFssErVTCYKUikCXsKkuexDRW
 nMgwRWzPtH4mLrF+TAO9OAt6CejTptxUShlQJj/0VHo2qbKa/RX4qhlntXH5vAKprMY3
 zR30veSLOdjCaCzmFG0mwYbBISxrzZ4jq9vLO6lVjc8+e67rzJTnMFmqovL/2Az+pbUf
 F5kn0Z9gduBEtJIynBVF5bGR9cFhdx2A3aoOYZr5n3Z9mFoeLXosIN1CktkYGxNG5lrf
 F2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156014; x=1781760814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=tAf9pSxtMCSaSu0hQVRImyeOb2CC5F9AHONIO24zyozKitgsRPLiaMPd+48uTaF2fD
 aNRbkixaQyTFO/wKhPuTE8UDLSQL7EkUX4GfQg1WFuxMVorP1sxW+1Q6vVkgenLxHwAa
 D8kXlK3Xnai/jZuT3OGUiVeCXPF+xhGWwmU6Ih/dhH4bA8FhFETkc5FXgkrb8bUYcszj
 gh8v0VhtB3a5gKpB/a644uO+SWFTTisSUs1IH0bBrVm9lykLTxzV+Bcv8/PZl7o17IYn
 8Tb7/B/Pp9S1zqojYVGyk/YQoAJwJw2ZKldo4fSCgPsU/KHbPXVRtL8hzihciiH4sTvB
 R6pw==
X-Gm-Message-State: AOJu0YycaDtPB3iDKQ7KEDpOGaONMerjbPczqLGJfrPd/TRrGkuFymAA
 iJgUPWKjzy+ZVxCDv6KMJsT6MupXO43QOQTtANMk4Aj0/LLWVD4NBO2IDV0sV9gdKLd8NXbIEYq
 v8RvYCdVSsqgJv/oKMhfsR38Dmitf/Zxn3oTMD3J1YIC3J3oaKZCjbDKCpg9LHn3zFg==
X-Gm-Gg: Acq92OFw5yk0UPxdpCYgJmchFQt5Xgx1NPb9FGFL+0GdMG1tfaUGUGBBfyOGZYX3JkX
 VQ+mNei01JU31bIlinSUzPcGsYprK6lfffH5IAH92Oqy6btRyI5165EOFWE2c9Nv6Kgm1BSzV8V
 HN3xhrHt/T5sFvnGFmzNE+XCDDrIkyr6dmn5J5yivtQ/eQ/pz7gIYn8LqUgkxyXyCVp727X7Cqd
 ibOxv2o03ekX1vU15DfmPqZY9x6QiQZ8wbrMSgmJfC9Ro+hCW/qfI80tGyJIhLGxM5PVCYP5K6v
 is9TkHyWd82EnV2fXuzdITZT/vq3I3Yvp1Ifc00oPVZt7Vf3oZ+3G/AuwXl9ipvOQn+pLQ/SrIw
 OSX+yu8iJLFr3NMpdkn+MsHoUu0CUueKGQ28VBuadzVO76v58APv8kcihRPLqFvUbKnmPaKD2ie
 7LxN6p
X-Received: by 2002:a05:7300:4353:b0:2d8:7302:d3d with SMTP id
 5a478bee46e88-3080464ddcfmr1100863eec.8.1781156014193; 
 Wed, 10 Jun 2026 22:33:34 -0700 (PDT)
X-Received: by 2002:a05:7300:4353:b0:2d8:7302:d3d with SMTP id
 5a478bee46e88-3080464ddcfmr1100838eec.8.1781156013721; 
 Wed, 10 Jun 2026 22:33:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Add TCG overrides for transfer insts
Date: Wed, 10 Jun 2026 22:32:47 -0700
Message-Id: <20260611053249.3918491-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: lupg6jWHng6m6MeREzYXaF2k_nc7IRTF
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a48af cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX2wq90osRGbPF
 Gtg5sJV8Yf8PXyOBQy+LgVdhiuWM6j3qI/yevgiPmT17xAzMzI9dUsd0auLzKTaNYm34//0Sozu
 T4XpAQ9mVJHcdKiWSSEhoTKCBH9X48vGecPHSkDDYw1EldBD/VRqFgWxie4H1NQUHnYiNcaQyr1
 BF5JnASj1xMZWhAfw7D2BKaR5geaqYKu/WVkwN+h9FzNHZyh3sJoNn9ia9O/SobWAHumlbyxkl4
 jgC2KQWLIXxl5w0++//v+yq0zldliLnInbLi4+3q0YTQsa8Xw36V603OrAemypPWn+l2cu0cPCy
 2aipV2nBGDyXWPuQ3yoO1rV5y/v68IwwMTsYB1TG9TAaijcW+mgmNfm3rnz20yGPJ5s5QxhVqMn
 68nqsFg+5Ese0DcjGPnpFYnJsDgAKsrEOlE7qIofrGwXdIFafpva6Z9lg5pw4ZIcTwEybtuFFpc
 EGFuIuVfNyyYp6BIfmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX4nZkQxreIQoA
 o1OxLm6pmUvtIyXwY1s/nr4QAEuCeVoy5+b3Lmkq+T1jP++uaxHQt3/2ROSQrmDUIrJlPrdUFv3
 DrqRZsb3B1GJPCxVg7LLMRpqrwlhFC4=
X-Proofpoint-ORIG-GUID: lupg6jWHng6m6MeREzYXaF2k_nc7IRTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDY4YjIzODk1NDI4Li5h
ZjUwMzIyMTRjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC05NSw2ICs5NSwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

