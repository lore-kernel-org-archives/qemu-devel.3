Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E447606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kug/LdOd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YPgY19i0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKosR-0002Bn-Sw; Sat, 24 Oct 2026 23:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKorA-0008RW-5k
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor2-0001Wx-Qm
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16lkT2570155
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=; b=kug/LdOdlBXBEcoU
 m4UME1XR2hogXgnQZ3GsgSfsExX1P+2DApY7CvTDpnLg9DFykHUGgti4Ddaunbof
 OUzpr2FIY8XBcbF/7PWeUfvu03oeIqqV/hcGv7B/qLN/gfeokUkfRV8r6mzcq2V9
 VKtpsjyMgmvWHfxYl3FwJ3M7gjjgJoOX1tIY3r+TXRr4TY+UnORikY9yrDf2eKRO
 zeQQ5mwJf5XUWS25vZ/nK8AzzKYpMK8ETALQcX9b2yVj4/o0IDTwKdUKqgDwDqof
 6Iai1344URd1lvnR1ZoSPTU97dBWaC8rZeqFFfTs7upxJdh8k31kZSBWHF4Ju34R
 h1hLhw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehj80d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:49 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-169846a19aaso2584450c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898689; x=1793503489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=;
 b=YPgY19i0oOK/QaHM+OTyPPdfUXnz96sFbQrPPJHT7iD5IUnlIDcChiH2NAuFA/w9RK
 8dsU0Q5SyLkgJtmgBUVHstxgdUYSZ+G0Yz31dKpqkjCwETuDYQMXT6/5KxKBoZt8rOcn
 Is3EcPahCSN0oSuonAivK97wd3U0vXlW2KE4NLtQs4F/uKkRChPjqQ+EBlo6TRbsp3he
 zkterAvQAxV63QOcIu8N4DOnQthet0j1hcaGR3trop78OxTP/WnqlXHHcYhIHqEzDClE
 pPDQL2Mbk80UVhS58M2XHSJZm3lMp5YJIjqFhFg2hzqy4wVGfhswiV1mfn0HVZ3NSYP4
 kxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898689; x=1793503489;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=;
 b=HI2wu3vF3MhupV3ks3DfcxwIugw5V9W8kxQJZfo/it0rc6XsCoNer4V9aSnLptMu55
 TBRCnxl/8nXoYX8CvksaVXpGhBre1EO+nK21W92s6xH1e6J+XMJqFSCW4neAzVZtS8fK
 dkSFdmzsEq9Ff1K+9tpQEEHchu8xGc3mt3eXz+wosUt1cDWH3AGXUzhx2Y5KQCD4dXKu
 u2gRMLAMzBA4VRoSy2HQnilzSBC0cZ3Pwfn5LkFONum1kilmeXoXrtkx/erOn72EpphC
 210qlwNYxNMzCrC+v03VfxLIR2dVzIa9CbyrqHcFcSPrswY7xjPNJhikJRE1NQDg6bVV
 ev8g==
X-Gm-Message-State: AFq9FYIjFyn3Zi6SW7LwByqiT1nA7LKmXIFSNao/SqIuz7JfmpdwwRjp
 o5WOdqeZDVqQWjfoFqsILTgoZrdfw0mjKNWAgdmKDx1gEWWjG7IpC9p6TbKScZsVlTe8o7vz2zR
 Pj7pcxgUFyXNv7S4gU2j5LDmUmJPcuSjUbrsG+czDKo+Gh4NzZ/wELxIlHXqoai6a2g==
X-Gm-Gg: AYBFou33m0dLrA9uwhBEc7DxY62beblOuqj9SMSyHRJtz5pzCfd6JbZAqj4WgNy6E4x
 fyLggbhz2L7/hocXJYNKF6g43/zJ3uKlEm75FduiuXVlj7g1v9lEzqXByGAJNuPKV0m3YgG/mhC
 RwF9Ma46O9IDcO99Y3UK3WXZUrlcLE+Gqa6GwnMgiSdqbLdyHaVHFIpF9oBvq2oTR6iLLLRN3oX
 BoZyG4tU1C0HfhPm2ahOA3f455DDvescpwu9DtXLh4PlLe0ZAw1u6rQnoOKFR+kafJlmYpfWhlw
 YWSiUmwk7PSF+0fGniB9BoWtChNHmfqMIV9k4pGma50IBt85LuALYkFny6C1hWoLhyT9iVC3b3l
 oQj4uZqGxQwhGSeYP5VekAmb+2b15BCdbPpXNTS02vGrN+HQ=
X-Received: by 2002:a05:701b:230e:b0:18c:640f:7f48 with SMTP id
 a92af1059eb24-19936b56ab7mr4413940c88.44.1792898688936; 
 Sat, 24 Oct 2026 20:24:48 -0700 (PDT)
X-Received: by 2002:a05:701b:230e:b0:18c:640f:7f48 with SMTP id
 a92af1059eb24-19936b56ab7mr4413918c88.44.1792898688418; 
 Sat, 24 Oct 2026 20:24:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 31/40] target/hexagon: acquire BQL before reading interrupt
 state
Date: Sat, 24 Oct 2026 20:23:37 -0700
Message-Id: <20261025032346.2917451-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfXyEXU7L2YsaQV
 qT9vsJuZPYhAnFAthjsNA4l7JsUM4x09rOtKdrvEyGkB805q8h9jGmV6Wh6SHa5erC55FK+PvlG
 aXG2YSTRVse4NoDlFCCcA+0zT+Z1rwA=
X-Proofpoint-ORIG-GUID: tEyu-JjqCRiH35x5hq460uZ1CcGlZAHC
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6add7681 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=52E-7OzoYlKJP0MoAcQA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfX8DNH7DBfTNZ9
 boYARiD7N1vH1mecUKIIsuzwPnn6iLFk8beisgCKE9p/2l7Sc6rXO9TOHzmVBpRNtVJpFDKKXYx
 KATDzAY/IjOk4Gax4STSvWhlI/1HVicYXzvBYdlZetNzCDaW0WpAu43c6DaLDASBxrDFYEIECon
 VLA/UGC5ZfJkYshf7K4v1/OYCIMZTNlt27Xo4jGLptPw5Thj6TFFNk5Yk8IeWRHKHg6cZdk8aSX
 4KMiiaoWmjkR//2f/YuXoMeqNkGU5gb3xio1bR/l28PWc7i3HIeuJ1QhOlyHSBYSa7iRUSbsagR
 3dFCes1AjjmhrmC5z+hsfgJ3wKSGIDJMbV+lPnOrgV1kvuIY7Iz1Or8N9rdVAuA4NLVFIrwTRsC
 TqD5QSm/+MpTD1fyITvNqy99iTW67sV9xPUpAv0RDFeCIs5KilKVEApWk49v4bt3VNcQsellbRF
 7O6iLwcJGrFHjC1G5uw==
X-Proofpoint-GUID: tEyu-JjqCRiH35x5hq460uZ1CcGlZAHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250013
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TW92ZSBCUUxfTE9DS19HVUFSRCgpIHRvIHRoZSB0b3Agb2YgaGV4X2NoZWNrX2ludGVycnVwdHMu
CgpUaGVyZSB3YXMgYSByYWNlIHdpdGggaGV4X2ludGVycnVwdF91cGRhdGUgb24gb3RoZXIgdkNQ
VSB0aHJlYWRzIHdoZW4KZW5hYmxpbmcgTVRUQ0cuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaGV4X2ludGVycnVwdHMuYyB8IDggKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
X2ludGVycnVwdHMuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKaW5kZXggODFl
N2QwMTZjM2QuLmI1YTg3MmRiOTg5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50
ZXJydXB0cy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKQEAgLTM4OSwx
NyArMzg5LDE5IEBAIGJvb2wgaGV4X2NoZWNrX2ludGVycnVwdHMoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCiB7CiAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgIGJvb2wgaW50X2hh
bmRsZWQgPSBmYWxzZTsKLSAgICBib29sIHNzcl9leCA9IGdldF9zc3JfZXgoZW52KTsKKyAgICBi
b29sIHNzcl9leDsKICAgICBpbnQgbWF4X2ludHMgPSAzMjsKICAgICBib29sIHNjaGVkY2ZnZW47
CiAKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgc3NyX2V4ID0gZ2V0X3Nzcl9leChlbnYp
OworCiAgICAgLyogRWFybHkgZXhpdCBpZiBub3RoaW5nIHBlbmRpbmcgKi8KICAgICBpZiAoZ2V0
X2lwZW5kKGVudikgPT0gMCkgewogICAgICAgICByZXN0b3JlX3N0YXRlKGVudiwgZmFsc2UpOwog
ICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgfQotCi0gICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAg
ICAvKiBPbmx5IGNoZWNrIHByaW9yaXRpZXMgd2hlbiBzY2hlZGNmZ2VuIGlzIHNldCAqLwogICAg
IHNjaGVkY2ZnZW4gPSBnZXRfc2NoZWRjZmdlbihlbnYpOwogICAgIGZvciAoaW50IGkgPSAwOyBp
IDwgbWF4X2ludHM7IGkrKykgewotLSAKMi4zNC4xCgo=

