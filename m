Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EB1C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coL-00006M-DA; Wed, 02 Sep 2026 00:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coJ-00005d-DI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coD-0000Ji-VP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6824MLUY3664584
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YK/XxszV1lTbhNWAE/tHQ5rhD2kql2wA4ZjsZiVAwAc=; b=oJzjakdV7dTZAqh0
 XVUAOP2pLYddAQnZpN9TTUPLwbF68q4cAvT4/3M03vpCMvs0PYPSdHRnbIg4MvzJ
 z9GCwwmWEDst8lo9NSD+5H6hdQEEHd2Cb3UslXBrRo07FslEmCESLV1ztcviJSIn
 vk0c+Zj9zGaqEMX9vrS8ZGXeXS2T6aw+0xQXA8ghEHJqOVB7j5q1WKzeF/Mr2mFo
 yespWTeotYQ5Er++m2Mlojl/cf6zt1hNrKWCm1uF8bMS8VqmwfF5edCpeRWSyEiy
 ncNS4yYnrLBD+n2ovuPziqPimHmFOu2qC+igfOfbZ1ZJAkolsOIcSYXdNwed4/c+
 nefDDA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge37j24er-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:42:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so19439345ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324168; x=1788928968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YK/XxszV1lTbhNWAE/tHQ5rhD2kql2wA4ZjsZiVAwAc=;
 b=aGDSSvyG3KXMALuA/W2DPQMX+61JHmviKn07l0u8g6g+XeK6ZMzvOcJqeWs2R/O7db
 X2kDnGcELUcI7gV9nSNqTNa8Cil2vyjh1hON2I+yVgTDXgZTGzappzc/UF7P5knKTtQD
 dpvw8xbrXAwFKT9Xjd10mq1vLBoZTG6a0rtGXL+8g6Qs5J1vRs/bZNuO3vrDH8S0A7zX
 xWyBwLiX0rlTZU1lnNnKgRK3tFc+acfidDiaxnPDVmoXL2cK2gl2Iffl6K4NtBee5C8T
 L/0ku0Jl228K7fKaAae8gUwFKOLJVoaLmAsNJXBjR1j3Bo/C2/ldbUdroZfkPn0Ew/1F
 eW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324168; x=1788928968;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YK/XxszV1lTbhNWAE/tHQ5rhD2kql2wA4ZjsZiVAwAc=;
 b=O90KGvmXeoSrRINMA35fCnbYT0pBFTKkhNksu/FQtTlCV9XWx8xeuiM+UUoo9u+aTa
 BoRxdmgOSCNWnnqfdinx6V6ry/UNQWkZcE04PjZ4n1HHsgGKNwg7Zah7MfA/G3Sq3kV/
 ICGUhO2/N3KnbCz9X99zHbuRmc6RFTiAsORl/QSfYIHSZDwjOXufZo5rPvyV3Xx8LUUg
 LyOM2NBzADeSnx1LQvuP1v3SJX3A2kp2M7KZ0otI81t24rl+a6A25jtZP9LsS8oK9Adc
 E85E8YZm5oYcG2mK60kkv7nyJ5Kpx+6RXBrU/WAQwVqD1HsVyUbZlczcKB/TlxElaXyS
 iR4g==
X-Gm-Message-State: AFuF++ls+Vg6ALLzggbMZYMF70pNUmhwAQAc1/KgiE2Z34xbY5x5FkTb
 h7MogdDbpBgTJh9MQrVZIJClS4STX6Ulg7HsGEhXK5c9lu9mQY1PguiCakxdE2oEga3dqxePN5y
 St0GiqhaS6AYAoIFNOjgNiUCF6DiT1lS7z9M1/HvmDLaGwle4h3GCBVgNIn3D1VluMw==
X-Gm-Gg: AYBFou1CMQNNhNavVbvO8c9aq6jtmqYeoTlDp5M6slE9ooL/Wj7iThjVrXExpUmtO8b
 FIFPB3oDdFmbiWGI1QlJ4NSKQmQqZd1YtBAgFW5O62AWN+466YX4lu9VnCEFSDmxu6+dgcDm+8M
 kFpCoEoh8SQmyOC016nGIN/Btq/yQNUzSWPEmvf17t3SaFfOWH5hQ0hhqckq0SgR9MbONLkijJt
 cqP1ou6EpttV8WF+Lofo/FAJxx6Ye1AveelEp8Bnf2ziMRWgJXXQ++2GMHm8mkH6E7skDN4aIy+
 17ZLB+nG65NA3sZd0uODmuhkZ86iJDA7wCNLpy6PAgW9OrLP/bsuninhzTKI1JdQCCLyAR43QUz
 zkn5ROZScXJwjW0J+qfdYUKxvRdBbcu41YP1mutHrqxF4tWTf
X-Received: by 2002:a17:902:f708:b0:2d7:1b20:e98f with SMTP id
 d9443c01a7336-2daf125a6fdmr4077835ad.2.1788324167788; 
 Tue, 01 Sep 2026 21:42:47 -0700 (PDT)
X-Received: by 2002:a17:902:f708:b0:2d7:1b20:e98f with SMTP id
 d9443c01a7336-2daf125a6fdmr4077495ad.2.1788324167330; 
 Tue, 01 Sep 2026 21:42:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/28] target/hexagon: add aux functions for guest mem
 load/store
Date: Tue,  1 Sep 2026 21:42:07 -0700
Message-Id: <20260902044231.843004-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: tuDb5KVfQ5Kf24vDuc83wI-zK1IKu8Da
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX7lzVv9vCQ2oa
 nk9R+87SJ761Ow9NptxfmFYmXe6b4rHXgDtzQvug0NdIxChJ202wG9oO5XFlrh/12Ntil7z5jDn
 qzVmlyBHraafGt+wKEHRBgwSF0x+fqk=
X-Proofpoint-ORIG-GUID: tuDb5KVfQ5Kf24vDuc83wI-zK1IKu8Da
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX+4SwkC1wfMFn
 TCr1X/1BL7MdxxDhV4eahG5NcdDG65xcZH+JXiZNqDd2UXsdBFYaIIvPRi+jKWnWPFbDweBwm/3
 SDsvFgc4+XCDQ1RS49nac+pbiwzGxMaxvjS5/Ei5FZcyHkaGa2Pn0ZZtSzfRQ1911cxmAtRHZI4
 5nSbv7thvpu1VLHCXSF8ydvqNJ6Qo2L+1E92nnTgFA6nVYyNB+r/8fAPucyrZDE77aRJKaTDrbd
 S8oXU/XyEuu7xm4oMkPxZd1YMETW7A5leNDpgDnJS5FKP1XZr6xTCWQO7xVUcGOXIgZRr7iKMx+
 JNhkyRANh14TJXqKbTn8dy6OJPnMtunuyUjz49GX5yvWqhHY9d5yIxVBhU/WgrnehXN4mI8szew
 qHWByIMgKUVpllaZlnYy61rFeGCGY6HtpJ3lbe+sqkslMisZXxSzM4WTszYGBiN14PsXQpYCxG7
 lf0J1ZDrEICdigG+9tA==
X-Authority-Analysis: v=2.4 cv=PKg/P/qC c=1 sm=1 tr=0 ts=6a97a948 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-4NnfYh-EZONJb1VZs8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKV2lsbCBiZSB1c2VkIGZvciBzZW1paG9zdGluZy4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRp
bm9Ab3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCB8ICAg
NiArKysKIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyB8IDEwMCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggYi90YXJnZXQvaGV4YWdv
bi9jcHVfaGVscGVyLmgKaW5kZXggZDE3Njc1MDMxNTYuLmNhMmUxM2FiMWQxIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hl
bHBlci5oCkBAIC03LDYgKzcsMTIgQEAKICNpZm5kZWYgSEVYQUdPTl9DUFVfSEVMUEVSX0gKICNk
ZWZpbmUgSEVYQUdPTl9DUFVfSEVMUEVSX0gKIAordm9pZCBoZXhhZ29uX3JlYWRfbWVtb3J5KENQ
VUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcgdmFkZHIsIGludCBzaXplLAorICAgICAg
ICAgICAgICAgICAgICAgICAgIHZvaWQgKnJldHB0ciwgdWludHB0cl90IHJldGFkZHIpOwordm9p
ZCBoZXhhZ29uX3dyaXRlX21lbW9yeShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25n
IHZhZGRyLAorICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgc2l6ZSwgdWludDY0X3QgZGF0
YSwgdWludHB0cl90IHJldGFkZHIpOwordm9pZCBoZXhhZ29uX3BlZWtfbWVtb3J5X3JhbmdlKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzdGFydF9hZGRyLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQzMl90IGxlbmd0aCwgdWludHB0cl90IHJldGFkZHIpOwogdWlu
dDMyX3QgaGV4YWdvbl9nZXRfcG11X2NvdW50ZXIoQ1BVSGV4YWdvblN0YXRlICpjdXJfZW52LCBp
bnQgaW5kZXgpOwogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKTsKIGludCBnZXRfY3B1X21vZGUoQ1BVSGV4YWdv
blN0YXRlICplbnYpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIv
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDY0YzU3NDZjNmQ5Li5mYWI5YTlkN2Ix
MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMjUsNiArMjUsMTA2IEBACiAjaW5jbHVkZSAic3lzX21h
Y3Jvcy5oIgogI2luY2x1ZGUgImFyY2guaCIKIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisK
K3N0YXRpYyBib29sIGhleGFnb25fcmVhZF9tZW1vcnlfc21hbGwoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHRhcmdldF91bG9uZyBhZGRyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgYnl0ZV9jb3VudCwgdWludDY0X3QgKmRhdGEsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludCBtbXVfaWR4LCB1aW50cHRyX3QgcmV0YWRkcikKKyB7Cisg
ICAgLyogaGFuZGxlIHNtYWxsIHNpemVzICovCisgICAgc3dpdGNoIChieXRlX2NvdW50KSB7Cisg
ICAgY2FzZSAxOgorICAgICAgICAqZGF0YSA9IGNwdV9sZHViX21tdWlkeF9yYShlbnYsIGFkZHIs
IG1tdV9pZHgsIHJldGFkZHIpOworICAgICAgICByZXR1cm4gdHJ1ZTsKKworICAgIGNhc2UgMjoK
KyAgICAgICAgKmRhdGEgPSBjcHVfbGR1d19sZV9tbXVpZHhfcmEoZW52LCBhZGRyLCBtbXVfaWR4
LCByZXRhZGRyKTsKKyAgICAgICAgcmV0dXJuIHRydWU7CisKKyAgICBjYXNlIDQ6CisgICAgICAg
ICpkYXRhID0gY3B1X2xkbF9sZV9tbXVpZHhfcmEoZW52LCBhZGRyLCBtbXVfaWR4LCByZXRhZGRy
KTsKKyAgICAgICAgcmV0dXJuIHRydWU7CisKKyAgICBjYXNlIDg6CisgICAgICAgICpkYXRhID0g
Y3B1X2xkcV9sZV9tbXVpZHhfcmEoZW52LCBhZGRyLCBtbXVfaWR4LCByZXRhZGRyKTsKKyAgICAg
ICAgcmV0dXJuIHRydWU7CisKKyAgICBkZWZhdWx0OgorICAgICAgICAvKiBsYXJnZXIgcmVxdWVz
dCwgaGFuZGxlIGVsc2V3aGVyZSAqLworICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgfQorfQor
Cit2b2lkIGhleGFnb25fcmVhZF9tZW1vcnkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91
bG9uZyB2YWRkciwgaW50IHNpemUsCisgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqcmV0
cHRyLCB1aW50cHRyX3QgcmV0YWRkcikKK3sKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAgIENQ
VVN0YXRlICpjcyA9IGVudl9jcHUoZW52KTsKKyAgICB1bnNpZ25lZCBtbXVfaWR4ID0gY3B1X21t
dV9pbmRleChjcywgZmFsc2UpOworICAgIHVpbnQ2NF90IGRhdGE7CisgICAgaWYgKGhleGFnb25f
cmVhZF9tZW1vcnlfc21hbGwoZW52LCB2YWRkciwgc2l6ZSwgJmRhdGEsIG1tdV9pZHgsIHJldGFk
ZHIpKSB7CisgICAgICAgIHN0bl9oZV9wKHJldHB0ciwgc2l6ZSwgZGF0YSk7CisgICAgfSBlbHNl
IHsKKyAgICAgICAgY3B1X2Fib3J0KGNzLCAiJXM6IEVSUk9SOiBiYWQgc2l6ZSA9ICVkIVxuIiwg
X19mdW5jX18sIHNpemUpOworICAgIH0KK30KKworc3RhdGljIGJvb2wgaGV4YWdvbl93cml0ZV9t
ZW1vcnlfc21hbGwoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBhZGRyLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGJ5dGVfY291bnQsIHVpbnQ2
NF90IGRhdGEsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbW11
X2lkeCwgdWludHB0cl90IHJldGFkZHIpCit7CisgICAgLyogaGFuZGxlIHNtYWxsIHNpemVzICov
CisgICAgc3dpdGNoIChieXRlX2NvdW50KSB7CisgICAgY2FzZSAxOgorICAgICAgICBjcHVfc3Ri
X21tdWlkeF9yYShlbnYsIGFkZHIsICh1aW50OF90KWRhdGEsIG1tdV9pZHgsIHJldGFkZHIpOwor
ICAgICAgICByZXR1cm4gdHJ1ZTsKKworICAgIGNhc2UgMjoKKyAgICAgICAgY3B1X3N0d19sZV9t
bXVpZHhfcmEoZW52LCBhZGRyLCAodWludDE2X3QpZGF0YSwgbW11X2lkeCwgcmV0YWRkcik7Cisg
ICAgICAgIHJldHVybiB0cnVlOworCisgICAgY2FzZSA0OgorICAgICAgICBjcHVfc3RsX2xlX21t
dWlkeF9yYShlbnYsIGFkZHIsICh1aW50MzJfdClkYXRhLCBtbXVfaWR4LCByZXRhZGRyKTsKKyAg
ICAgICAgcmV0dXJuIHRydWU7CisKKyAgICBjYXNlIDg6CisgICAgICAgIGNwdV9zdHFfbGVfbW11
aWR4X3JhKGVudiwgYWRkciwgKHVpbnQ2NF90KWRhdGEsIG1tdV9pZHgsIHJldGFkZHIpOworICAg
ICAgICByZXR1cm4gdHJ1ZTsKKworICAgIGRlZmF1bHQ6CisgICAgICAgIC8qIGxhcmdlciByZXF1
ZXN0LCBoYW5kbGUgZWxzZXdoZXJlICovCisgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICB9Cit9
CisKK3ZvaWQgaGV4YWdvbl93cml0ZV9tZW1vcnkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdl
dF91bG9uZyB2YWRkciwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHNpemUsIHVpbnQ2
NF90IGRhdGEsIHVpbnRwdHJfdCByZXRhZGRyKQoreworICAgIENQVVN0YXRlICpjcyA9IGVudl9j
cHUoZW52KTsKKyAgICB1bnNpZ25lZCBtbXVfaWR4ID0gY3B1X21tdV9pbmRleChjcywgZmFsc2Up
OworICAgIGlmICghaGV4YWdvbl93cml0ZV9tZW1vcnlfc21hbGwoZW52LCB2YWRkciwgc2l6ZSwg
ZGF0YSwgbW11X2lkeCwgcmV0YWRkcikpIHsKKyAgICAgICAgY3B1X2Fib3J0KGNzLCAiJXM6IEVS
Uk9SOiBiYWQgc2l6ZSA9ICVkIVxuIiwgX19mdW5jX18sIHNpemUpOworICAgIH0KK30KKworc3Rh
dGljIGlubGluZSB1aW50MzJfdCBwYWdlX3N0YXJ0KHVpbnQzMl90IGFkZHIpCit7CisgICAgdWlu
dDMyX3QgcGFnZV9hbGlnbiA9IH4oVEFSR0VUX1BBR0VfU0laRSAtIDEpOworICAgIHJldHVybiBh
ZGRyICYgcGFnZV9hbGlnbjsKK30KKwordm9pZCBoZXhhZ29uX3BlZWtfbWVtb3J5X3JhbmdlKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzdGFydF9hZGRyLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQzMl90IGxlbmd0aCwgdWludHB0cl90IHJldGFkZHIpCit7Cisg
ICAgdW5zaWduZWQgaW50IHdhcm07CisgICAgdWludDMyX3QgZmlyc3QgPSBwYWdlX3N0YXJ0KHN0
YXJ0X2FkZHIpOworICAgIHVpbnQzMl90IGxhc3QgPSBwYWdlX3N0YXJ0KHN0YXJ0X2FkZHIgKyBs
ZW5ndGggLSAxKTsKKyAgICBmb3IgKHVpbnQzMl90IHBhZ2UgPSBmaXJzdDsgcGFnZSA8PSBsYXN0
OyBwYWdlICs9IFRBUkdFVF9QQUdFX1NJWkUpIHsKKyAgICAgICAgaGV4YWdvbl9yZWFkX21lbW9y
eShlbnYsIHBhZ2UsIDEsICZ3YXJtLCByZXRhZGRyKTsKKyAgICB9Cit9CisKKyNlbmRpZgogCiB1
aW50MzJfdCBoZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1cl9lbnYs
IGludCBpbmRleCkKIHsKLS0gCjIuMzQuMQoK

