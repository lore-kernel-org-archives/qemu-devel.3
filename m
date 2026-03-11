Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF951FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsJ-0000sG-Hb; Wed, 11 Mar 2026 00:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As1-0000nJ-Mh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As0-0008VM-8m
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B06YES1265806
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U8kWP70Sz6vf4v/5hys6mJ76YXhz1HzYjnyFntHP1PQ=; b=W1zzJ+OhFoKVdbv7
 BP8SEKaNhr2gDrAKd/+D4hagn/nQkWu6XRWshEoyy0eY0eULhmU/0DFzNkwxNGWW
 1DKvWlikcJUYQUrru/RJLj6BfsNxRR5YYCbZljuXyLuuHbg4ZyBVbIgVcfT7GgP3
 ojh7+vprZsWxZDZFaNgZX2/yFExOzt7vDjOlpbzgXUbbjq+RJysUVkdvXMRuhXiy
 XXMcWcuwmqAneGtFLFzoH7C/J4jVx4JQ5gchVvxaVmyGIFgc8sA9qsPnjRXnRidK
 JO8k/6P9Ss5aXREgDQNB2C0gBXlSjDt+Q+DQhbNlBYYitby4Ep9/d2T2TbyZKhmp
 Oh4sDA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctpkfj7w8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:26 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-417393f319fso19127982fac.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202106; x=1773806906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8kWP70Sz6vf4v/5hys6mJ76YXhz1HzYjnyFntHP1PQ=;
 b=D68qAquCmLCbcfjLHlu3d0d6bd3yUdkajHcsFqmacuktZT2O0QGFwnw+6IEicHBDAd
 3pxPdlRyxKUzD6X7VhVLnFtTabFUU8CuXBMw+LXwqLahdXypvrOkMeCoRt11OWTqZtC7
 g4SzuVPwIlrO4hfOG9/kpYTSP83WlrFGM7W2rRqv6+bVHNCkq9nPVJEN2aJuWK/U/LlO
 p6JexyY+4/ysnmAPun2cljc+QvuLYk4kIok0ubePQgR4K0Qdjc+0YqVU35HyuvoteO8R
 S4ql/QaXOFzrdkqRQ4vm8Vpu6lHuvoj3mB/z828DMUON+FwRNMF9ksuu5J47kAj9yM8f
 ZRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202106; x=1773806906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8kWP70Sz6vf4v/5hys6mJ76YXhz1HzYjnyFntHP1PQ=;
 b=prT7er2shtZJO5UekdEq41AFUM4bffAtQfDX+JezHA8V+ckH9JdLuc6Yqkvp3xCkmt
 Migk3wLuwuymrO9XrcsznGAOvcvnSVOIeZE7spFNqw335E7vuHGUDn6LcG8QXIRY99BG
 y8hfxH6U9G+Rs6QWjvbw2UUnuOjkJ8YtgW1npD7R82tL5FFaIkdax51JM8R9zt0deonK
 OeYTjSbYlUXFMw73Wqz0RNnxLoluvXvMHNdmTpVQYTEy/hdEZP4Ag74ComGVWH2dhR4z
 z/tRrdtBEEa4Vx4HfAkIaCLyurFap6+279vBt34SyDBX3PmZ/7oHZkBr8AtNbJ13okVc
 DYhA==
X-Gm-Message-State: AOJu0YzSh5zJpMHaEWRIBHe/sFP9t+n+PjxOGCCsYEiSZRqvy9l1KSln
 RgzA53jAGu9Zf8/GfDdOWDYaSDJXPUwfrPYYRKRTN12mJT+kg/Jb6vHls4ZrEhZOOLdRX5S00l/
 Utm26OsPQzab7YR+fyxRIlhbaTXTEJ2LKBRbv6fVQAkhEFa+hsU8UfeLqvx89KAqX2w==
X-Gm-Gg: ATEYQzzsYp7ozcoeOdH9DMQuZRHgdVP5C0g87zB/rZtFMV0rgMy8ugx6XZnWJwz5+Tz
 qJ2b4LdH3M2Wj8fDGbmxoJFUy2J6vN+T8lflD6EHDn4avAp12Ljj31s1eCwXi3DfHWqTUFY+sfe
 z5hGxmMcaowQt4uP0j5gssO3F1VRrFKcAoESOmSLvZPNMmwXzSwjOagFXmt5J5IUtSwI9RVesh5
 QbE1sHK+DLpfHtXWGW4wda6CKuXEIZMGNMPStmROd9rSEgKYf4attuMNfFhH9N4dPVUK1xTGtZQ
 D8Wdeaid7CQ6w51TQm0oOrLF2mEcetfGzYfrWmGMdxSJjLxeB6XnDE1SOp69v9GANTiby1a0tTI
 mnhj4M2pqtilcf/eZXGxbdnpRmKaiK9F0UdkmdjC/TfdvPYyKOWamn8k/HlaAumLKQBgiDg==
X-Received: by 2002:a05:6870:8a2b:b0:417:5ca8:8155 with SMTP id
 586e51a60fabf-4177c951e17mr823365fac.24.1773202106086; 
 Tue, 10 Mar 2026 21:08:26 -0700 (PDT)
X-Received: by 2002:a05:6870:8a2b:b0:417:5ca8:8155 with SMTP id
 586e51a60fabf-4177c951e17mr823355fac.24.1773202105707; 
 Tue, 10 Mar 2026 21:08:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 14/32] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Tue, 10 Mar 2026 21:07:40 -0700
Message-Id: <20260311040758.1068731-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: BdTTR_-YOkhazrPabXHQytiDsvXWzeCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX31PgWjH2h/1H
 8syUjVHUcTpidRRJ1SO6QeO/FfUkn6i4gnbcdMgnZT0uT8LUvQKieNlGnPRVXVNPQZ6auWfYoB3
 A7oCJRs51CBtp+2VXjHecsXJbh/JFJYGEPDPkIF4DAuQ+L+6tnJSCfGAtG08XZRk8shh6dcCNUA
 8DcEksnqbIhVoM8s1LDMkkw/ulpLN4kCW7FGr495+l7sawhTi4SygWBIEmgsL+YGqUmqAlhre6A
 R+Z4kQQsAKn3/3UYdA8O1vZgHmOcOcoW3lywxNAYLKjQg5AEhOc8adB8r7Syiit5nSnr6MrFBLt
 ZteVqB7iS5ycA3oaAT7a9UtT02fw5ZXtjtjJoYjUmKcLuHnUFSA2M5LU6xonOz2CT7KenzLeElh
 zcq5guiDQl6EcME6WX4rfwxrBEYHuGC+mtkOvSwQcpMYg4sShrCVpFp1OT7tmn+dmdZYiiQKAtr
 y+OElMiYMmiVFUiMrIw==
X-Proofpoint-ORIG-GUID: BdTTR_-YOkhazrPabXHQytiDsvXWzeCl
X-Authority-Analysis: v=2.4 cv=Gq5PO01C c=1 sm=1 tr=0 ts=69b0eaba cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L2NwdS5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5k
ZXggY2MyYjRjMTgwMDEuLmY0MzlkZmYxYzIwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9j
cHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDk4LDYgKzQ5OCwxMiBAQCBzdGF0
aWMgYm9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRl
cnJ1cHRfcmVxdWVzdCkKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyB2YWRkciBoZXhh
Z29uX3BvaW50ZXJfd3JhcChDUFVTdGF0ZSAqY3MsIGludCBtbXVfaWR4LAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZhZGRyIHJlc3VsdCwgdmFkZHIgYmFzZSkKK3sKKyAgICBy
ZXR1cm4gcmVzdWx0OworfQorCiAjZW5kaWYKIAogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhh
Z29uX3RjZ19vcHMgPSB7CkBAIC01MTIsNiArNTE4LDggQEAgc3RhdGljIGNvbnN0IFRDR0NQVU9w
cyBoZXhhZ29uX3RjZ19vcHMgPSB7CiAgICAgLm1tdV9pbmRleCA9IGhleGFnb25fY3B1X21tdV9p
bmRleCwKICNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQogICAgIC5jcHVfZXhlY19pbnRl
cnJ1cHQgPSBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdCwKKyAgICAucG9pbnRlcl93cmFwID0g
aGV4YWdvbl9wb2ludGVyX3dyYXAsCisgICAgLmNwdV9leGVjX3Jlc2V0ID0gY3B1X3Jlc2V0LAog
I2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEKCg==

