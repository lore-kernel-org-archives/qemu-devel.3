Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3460FFDEE5F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 02:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6PB-0006mL-RY; Thu, 23 Apr 2026 22:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P5-0006l3-EK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P3-0008L1-MN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O0POQd154568
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L7ciwO6Jf5NV8v05p0zKTmxlWptv9MnlOW6McB65lmg=; b=VKjzwx7p5PBqaXK7
 xbm5L/JiX+tAsLLtqvILtwPWUVlS7JQ8+ZTCSGgh20/PHS+XQ7uPIgaxtq9vnQ9F
 3bAW9VIx0sNq5GT6gFuAqy8D6rad+amV34yD2aMihuELEH8CfWjfEu3KGZtNNZ7d
 LLa/TpscD6f8+7o6+UT3+SHDSD6FIXCrwcCRKje8Km0b/BPSNbuFspyFOKI1zKqv
 Y53clIzfvllmDaYdfxtmOskBa/AF288Jr4YWTcWn4FF6IFkJ/3EfrwvjhNx/Pnqy
 WyeGuECuCQ83uvd4EHvSp2BK7BhRJ6e9dVutsm8WXjNO0jtM3Bk/r4bohEf2SxVl
 FsJMYQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpf629gt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2de07c12745so16310231eec.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776998183; x=1777602983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7ciwO6Jf5NV8v05p0zKTmxlWptv9MnlOW6McB65lmg=;
 b=FPYwprj76aLcLum2ZrcGJntzJJgRXyZbahBvVgMMvWgnhaV0+lL5OjEO2K/dBSE6ck
 NcPGFrJ+By9Uk2OuhyHeCCwVd5+G94Xu5A+xvjWPjmpJzUWsIsPjkwRf9gg/Ck8l4Ixv
 H9aPwX/Z4oeUm1yTfElBTagPP2+qQiBlDUEezOCq+a1qNBGgnyRX67N3tRXhGq9JAiau
 IZpWpB28iSLXlGCpP6LDcV8ozx4eprJxwTvqvCytPxL6+bcC9wH0zxZlQHTl6XG+o8ly
 RDsZ3W52lf1nle/iyJzNZ+198e8XY4HLVQx27Oa0jLAjBtGo7JA1rsWg1GwcIwDl2AB7
 yAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776998183; x=1777602983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L7ciwO6Jf5NV8v05p0zKTmxlWptv9MnlOW6McB65lmg=;
 b=ZnAroSxOlqhDYQLcJlLlbF5uLjTrDx3XTeFAz2y13pk5L7uJhWKoRt2OrsiE5ikbp3
 sCpdXoK+mTJM9VfTfv9K2vmaSSN6vVOuqtA9e/1k8j8ZxSELvDjWKiKV+wXPH5Hdd7ih
 j1/Hh+c3K/UT8hPMFP1BbctI20HxX1fP0CanegdL5ycx+SgwDniZVd1tyx6TUjn14NAe
 L+AhwSBSeOI/SqEfGkvoKPutWAE7eOqXyK36MLZODCeJO2u884iVcG7ctx6NEuxfBzFz
 8DSp8YvIiaAumtcQnTQbogeMN+3d8L8AzepwbW0iAAphWYN2kSu+Vhjd+0sIZVrwmu2F
 tzKQ==
X-Gm-Message-State: AOJu0YwFnPxHw8NeYw0P/m0IiDVYQGfARTKWjl6DCzP+jOVR8ZDmrfES
 YL67HcR/IPfTn6T6Cv7Yg7gP8rkxZKqMR5/OeeBYO+6IwKtZH10/PrqOmBinbyjXvIguX9BLLHi
 Wn1AierxVvpteOObraKHJYMF5+uwLJRTl+IiPdk3axLG0xl/++DUhMzgKFvvt9FDgzw==
X-Gm-Gg: AeBDiessNBn0PvMqFHDPflDnKNJWV8V0LESGJcULh/YUq+ZRNq1KTesUOqQjQlCXfrL
 7IRGi9RGxtkE+2TmY36vBs6ggyVdnvO0BoiQ5q3VRYRflbmcPQVYu6RoFb4d4VGZLq0RhBNEA0G
 m3l9AR/5PjGlbEFk2h6D/sKiUEtz5bHZfgCmn0h9c6cmswlBt6iyPCUnfmtBm4XHf89N5ug50gX
 EhHnNZ5lq3Hm+ZzhtfIsiOMZbSJEBRjSwI4J99IM9+v9/5gDmMrN84lIAbqCJe2OuImd/hTJ4Xu
 xIIF6YyDFkEbn8/fuSuU0aLwSTHWZNZpyMVd5FFXjLGXdxXG5Vw8fiBZhcuMfgKblgb2fMz+9Op
 EIk/rrbSoaXjTlbPyAHBe4xbZf1DwauO46PgtL4nI+G2jbwN8h9gwiuWTxvCjzBs23eS3LaVxc9
 +baI3i
X-Received: by 2002:a05:7300:8c9f:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-2e4660475e5mr15679675eec.3.1776998183524; 
 Thu, 23 Apr 2026 19:36:23 -0700 (PDT)
X-Received: by 2002:a05:7300:8c9f:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-2e4660475e5mr15679665eec.3.1776998182993; 
 Thu, 23 Apr 2026 19:36:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm31240868eec.3.2026.04.23.19.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 19:36:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 8/9] Hexagon (target/hexagon) Remove snprint_a_pkt_debug
Date: Thu, 23 Apr 2026 19:36:05 -0700
Message-Id: <20260424023606.2556830-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
References: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Iocutr/g c=1 sm=1 tr=0 ts=69ead728 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8ZBzTUssO9REyHtisiwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 798P2SToZo4UR9rpfA89EnXRbFFoA7q_
X-Proofpoint-GUID: 798P2SToZo4UR9rpfA89EnXRbFFoA7q_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAyMCBTYWx0ZWRfXwFa3/bNHaDOl
 xmiHCNSRnwja258veu6lN2YKnbjiLHTEFBcSiSJx+A9JwBA0WJyZe7CRbv9XHlYZzfzM0HXjDtF
 Mdw8DHXflc6ZqjQTvxn11pFNzWsOpH+a4dl7EVaG6eOOtgJeIchsUVzig+u7a1bEgmVAyDel0XE
 VPeIO2kSP+nrWLwM6oPtR+nnpdiPK/iqBfp8fkc0TSSNece256hk8bpu3QdkTrqarpjPnyj9FcS
 8LoXB7P/ujM9j/XxaW/ByoGoxo7ccROLzf7M+7R+QXdIoss4AxRxsr8an9PwJpAw91X5xwLxuct
 OxOa5czka7pMwNWuBMGuTVNatvZV5OagiQ8KHpX3NNoScTz43a5yZ7m3uOJdvJ6DRh99o0yKt3J
 JDCdnndJ8FxcrXog7J1Sn/5TKeU10O/16duVOHwAQEHPTDwDLh9u4DR7D3SmDQNPLalzPTrHCNp
 QjZ/77uip4E9R/JYKEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240020
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkZ1bmN0aW9u
IGlzIG5vdCB1c2VkCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBz
b25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5oIHwgIDEgLQogdGFyZ2V0L2hleGFnb24vcHJp
bnRpbnNuLmMgfCAzMSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNo
YW5nZWQsIDMyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3ByaW50
aW5zbi5oIGIvdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmgKaW5kZXggNmY4NGVmOTNjM2IuLmRl
OTYyYjVmMmU2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9wcmludGluc24uaAorKysgYi90
YXJnZXQvaGV4YWdvbi9wcmludGluc24uaApAQCAtMjMsNiArMjMsNSBAQAogCiB2b2lkIHNucHJp
bnRfYV9wa3RfZGlzYXMoR1N0cmluZyAqYnVmLCBQYWNrZXQgKnBrdCwgdWludDMyX3QgKndvcmRz
LAogICAgICAgICAgICAgICAgICAgICAgICAgIHRhcmdldF91bG9uZyBwYywgY29uc3QgSGV4YWdv
bkNQVURlZiAqaGV4X2RlZik7Ci12b2lkIHNucHJpbnRfYV9wa3RfZGVidWcoR1N0cmluZyAqYnVm
LCBQYWNrZXQgKnBrdCk7CiAKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcHJp
bnRpbnNuLmMgYi90YXJnZXQvaGV4YWdvbi9wcmludGluc24uYwppbmRleCAyMmIzMDVmMDE4ZS4u
YTdlNDZmNGJjZDkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jCkBAIC0xMTgsMzQgKzExOCwzIEBAIHZvaWQgc25w
cmludF9hX3BrdF9kaXNhcyhHU3RyaW5nICpidWYsIFBhY2tldCAqcGt0LCB1aW50MzJfdCAqd29y
ZHMsCiAgICAgICAgIGdfc3RyaW5nX2FwcGVuZChidWYsICIgIDplbmRsb29wMDEiKTsKICAgICB9
CiB9Ci0KLXZvaWQgc25wcmludF9hX3BrdF9kZWJ1ZyhHU3RyaW5nICpidWYsIFBhY2tldCAqcGt0
KQotewotICAgIGludCBzbG90LCBvcGNvZGU7Ci0KLSAgICBpZiAocGt0LT5udW1faW5zbnMgPiAx
KSB7Ci0gICAgICAgIGdfc3RyaW5nX2FwcGVuZChidWYsICJcbntcbiIpOwotICAgIH0KLQotICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgewotICAgICAgICBpZiAo
cGt0LT5pbnNuW2ldLnBhcnQxKSB7Ci0gICAgICAgICAgICBjb250aW51ZTsKLSAgICAgICAgfQot
ICAgICAgICBnX3N0cmluZ19hcHBlbmQoYnVmLCAiXHQiKTsKLSAgICAgICAgc25wcmludGluc24o
YnVmLCAmKHBrdC0+aW5zbltpXSkpOwotCi0gICAgICAgIGlmIChHRVRfQVRUUklCKHBrdC0+aW5z
bltpXS5vcGNvZGUsIEFfU1VCSU5TTikpIHsKLSAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVuZChi
dWYsICIgLy9zdWJpbnNuIik7Ci0gICAgICAgIH0KLSAgICAgICAgaWYgKHBrdC0+aW5zbltpXS5l
eHRlbnNpb25fdmFsaWQpIHsKLSAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVuZChidWYsICIgLy9j
b25zdGFudCBleHRlbmRlZCIpOwotICAgICAgICB9Ci0gICAgICAgIHNsb3QgPSBwa3QtPmluc25b
aV0uc2xvdDsKLSAgICAgICAgb3Bjb2RlID0gcGt0LT5pbnNuW2ldLm9wY29kZTsKLSAgICAgICAg
Z19zdHJpbmdfYXBwZW5kX3ByaW50ZihidWYsICIgLy9zbG90PSVkOnRhZz0lc1xuIiwKLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzbG90LCBvcGNvZGVfbmFtZXNbb3Bjb2RlXSk7Ci0g
ICAgfQotICAgIGlmIChwa3QtPm51bV9pbnNucyA+IDEpIHsKLSAgICAgICAgZ19zdHJpbmdfYXBw
ZW5kKGJ1ZiwgIn1cbiIpOwotICAgIH0KLX0KLS0gCjIuMzQuMQoK

