Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA25606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mOg2p7F4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jDvpF4Cy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzEU-0004XL-E0; Thu, 22 Oct 2026 16:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzER-0004WD-6j
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:17:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzEO-0006Zw-Dg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:17:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHAGe3741647
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=wQyz6JHh7t8QXQB16sTxbA
 V4mq03CO1nEEdazf0qcCk=; b=mOg2p7F45CCwqKoXjcXdkzKwfY2pYJciQ0rW9b
 y6nmuRgB9hTeCEvSai4w+MZrD0CT/s8/CGA148mtAT8UUPBgVQDFwiMa/Dh36r0+
 /W4O69XAttMO3Gz2WvEniMnuMHBjKuTAQp61j4PGLAzc6dRh0zokZ6Y7IWbK2fIW
 8eagG5APkaAa81mNk6LvDdJpTt3Va8S+OmMC+1Li3JjfFaeRiQRgqvowtf8LRbhJ
 3iAkMrHwhlLmjhhQjJByrHweCsAiugJJFjFe1WoZQvfZVUQ6jsMlT/jTYZs4bcSf
 euz4+7N9PKLPT+mJhE29l/5ipXz96YSjFWW3UB7a2QdNdCXw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0ddr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:17:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-89e6ddd4554so153244b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792700260; x=1793305060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wQyz6JHh7t8QXQB16sTxbAV4mq03CO1nEEdazf0qcCk=;
 b=jDvpF4CyhYSK4eEEVIBpyKC8fjRSz8vMT8gJ3Pu1G6skLmTI0fnQn5+EqC4QN1K/sN
 vMATHpAGRURteOJDKXwYII1ewwzGPaohh8sRC5lFNHqK34WZlMpkA6MlJwCto4TWX3Yt
 1enVeNOC7nPSEcRchJCr6hzhB07Ck4/2k0zdAqUyA2G3KkuyA0ElOTy59U8uqYiAG4w4
 ikI1B/8OdtblqQGUkCU2cVVFa1m6FMnesG/4060fmSmkUF283JlDrRUCilrySbbTTMZU
 uHO/jWgJrzzPte6CvNFB1x6W10MNhZJtniIbDKvnmXOeTTYNXbfSsv8gKVHmFDj4C+aP
 6tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792700260; x=1793305060;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wQyz6JHh7t8QXQB16sTxbAV4mq03CO1nEEdazf0qcCk=;
 b=JP98XaZW23PoxWGYDm1veaFMuN/7AMGjeTRKTQl+pPZan3cq/Z3xjkrN7z1rWkJam4
 z4nyNDr+FqRG17hCAYLauls7e6Rpre2wPnnZyKTtc3DLk+Sf77968RoTKHkevKU4pxeo
 9ed+rwJC2MsoVfsb2EPbYTIWjxjeViCb+UI0Vt2xozdCuxlo32ZT9JN/nGa4fhwunelQ
 VQM3G8GuQmQ2HcTkzRZAtjXnzdRlUXhfDI9hHIQvCmyyb1QT6LF6irvKBJE9BcXh2+WT
 yTWGaQATo9bOkPJy28PDAqtRq2AESja5iXRqXfXbGNks3K/EvLU/Ro6RfVFES1Y1lDSW
 T/Uw==
X-Gm-Message-State: AFq9FYLEoKXawNo4gxINbxTlryfsWHjyUhxfVsXrBeQxgwV2NX7IGVem
 +15+nyZLjPNGhh0SNnz0yoH01Px3sD0vnHkIbvdC9SECBDS3qz52j6HBmvukj/8czrMmjbu5rcz
 fbW6zMeOLbsquiQAuYIcs2l3J+7jRwEgaVz0f0eBnhcmhUKfSKGGTOq2aCJk2vpwUYQ==
X-Gm-Gg: AYBFou3oeUkTUf2yAPS1gasMpHDYL14a2Xrrk6sPn5iT3aCkocOuXckEBceLLXGcFzW
 7Ml6Bd4Psi2nvgtakLuFw5azbzlTBFbRcv9Tev2C+iF/8va7qgd8L6i8PKgvGEx8VtJg0iiy5ba
 uA8lGWDTBQNZAm0rjp4QYQyuhqpVGXgpaBVs802Ms+lQHwoGRVvmi8ee9/xQDydxIetfROc5Rk0
 2wyQ4CJ7o3KEaxUcumW5N4V5oaJ9xCqgdJjp55/F5DvFdpTY5gZWyTR7kvwDmftWXy/H/ddoXMj
 TQI4w2p8bTQzz53lCq+sZcrEjovlnWyn5iftiBFYSAOnAEFDRf+yc0qwpdVBJtSdIJnVT+PciMm
 +HgJs44gFrAJHTme+hh4idVIiNSLsq9UZhXggikheCKiOD2w/RSZ5PfEL71/bgWM=
X-Received: by 2002:a05:6a00:13a5:b0:886:15e3:df99 with SMTP id
 d2e1a72fcca58-8a2c5e33d45mr271492b3a.17.1792700259911; 
 Thu, 22 Oct 2026 13:17:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:13a5:b0:886:15e3:df99 with SMTP id
 d2e1a72fcca58-8a2c5e33d45mr271466b3a.17.1792700259407; 
 Thu, 22 Oct 2026 13:17:39 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a2c89d8138sm55163b3a.18.2026.10.22.13.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:17:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/3] tests/tcg/loongarch64: fix hang with softmmu-gdb-memory
 test
Date: Thu, 22 Oct 2026 13:17:30 -0700
Message-ID: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfX8Ktdkjw15vMX
 b99aFx3Hj/eJidP6nh2mfdEzZ3ovDFWyWDeNAKGS3wH3Lq3eN5u4ZwGy4aPSIAI1BesND9vcHmZ
 p0LaiVVoswULNCCbbjpweIu27t+i+nAV0HomhMLb4+UDud9f4f714cKJDFAqwOnpU8ADE5RChPV
 dLQlr+m2TrqxKzzCQ3TfCgDqYwCxzAlQrEigoyCcfu7HXFLVrSHi71hfNYfz9K1i1CJaAnj6fIR
 414IEXES6Hmf4SMMH+Zd6pL3ooTOHnOWceWJGpuZy3ztAjfxV/knoTYhpbshewfl0IEN3H4Wnv9
 afQUpF8aCeZdCf8BaLAgJyQHSc+ONNOJmoREDA3osj27FXw/0uFie+ydcbf6jGqK4dHOJC/InCo
 fyIva/XdFvzJwKhyU2t/4c86LwAPfXb51g6j5uFYIORL+3Q4Lm9nwMg8T4R8vgKgnBSuOnwQ/ml
 FvxU24GISyaR3QGSN+g==
X-Proofpoint-GUID: 0GuWIE949jdET1GcHXF0-8rY5XrA7hra
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfXxDpDz8l74igZ
 y+aryPrQRweTMNpfF6V8so0CYQN77D12YHOs8evhcDCFMGJQit3bjn6PjoJWtc+Qiw6+bqDds9l
 GCfUFuViRmqRuZ6DN3/RcAuXxw3feDs=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada6f64 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ueUjau4Nas0SyqkfhAYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 0GuWIE949jdET1GcHXF0-8rY5XrA7hra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series address an issue reported by Peter:
https://lore.kernel.org/qemu-devel/CAFEAcA846O2jbpDvy+zUnxrpfxKLQpjhHq14zBOGQMC6caXOJw@mail.gmail.com/

This series introduces a minimal gdb version requirement for loongarch64 gdb
tests, due to a mismatch between target definition for our gdbstub and gdb.

This issue was already exposed, but I wrongly assumed it was related to host
(aarch64 vs x64), instead of gdb version. After reproducing on a x64 host with
an older gdb, the same problem was found.

Also, I added a cleanup on top that was on my mind for some time.

Tested on x64 and aarch64 hosts, with debian stable and ubuntu 24.04.

Pierrick Bouvier (3):
  tests/tcg/loongarch64: restrict gdb tests to gdb >= 16.1
  tests/tcg/loongarch64/system: reenable gdb-memory test on aarch64
    hosts
  tests/tcg: remove global meson variables

 tests/tcg/aarch64/meson.build            | 46 ++++++++++--------------
 tests/tcg/aarch64/system/meson.build     | 16 ++++++---
 tests/tcg/aarch64_be/meson.build         |  1 -
 tests/tcg/alpha/meson.build              |  7 ++--
 tests/tcg/alpha/system/meson.build       |  4 +--
 tests/tcg/arm/meson.build                |  7 ++--
 tests/tcg/arm/system/meson.build         |  4 +--
 tests/tcg/hppa/meson.build               |  1 -
 tests/tcg/i386/meson.build               |  7 ++--
 tests/tcg/i386/system/meson.build        |  4 +--
 tests/tcg/loongarch64/meson.build        | 21 +++++++----
 tests/tcg/loongarch64/system/meson.build | 17 +++++----
 tests/tcg/m68k/meson.build               |  1 -
 tests/tcg/mips/meson.build               |  1 -
 tests/tcg/mipsel/meson.build             |  2 --
 tests/tcg/or1k/meson.build               |  1 -
 tests/tcg/ppc64/meson.build              | 11 +++---
 tests/tcg/ppc64le/meson.build            |  5 ++-
 tests/tcg/riscv32/meson.build            |  3 --
 tests/tcg/riscv32/system/meson.build     |  4 +--
 tests/tcg/riscv64/meson.build            | 10 ++----
 tests/tcg/riscv64/system/meson.build     |  6 ++--
 tests/tcg/s390x/meson.build              | 21 ++++-------
 tests/tcg/s390x/system/meson.build       |  7 ++--
 tests/tcg/sh4/meson.build                |  1 -
 tests/tcg/x86_64/meson.build             | 10 ++----
 tests/tcg/x86_64/system/meson.build      |  6 ++--
 tests/tcg/xtensa/meson.build             |  6 ++--
 28 files changed, 100 insertions(+), 130 deletions(-)

-- 
2.47.3


