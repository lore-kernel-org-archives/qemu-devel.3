Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92077C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HLZ-0004Ne-L1; Mon, 14 Sep 2026 20:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLX-0004Mu-PQ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLV-0004Ah-SD
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxlL22826253
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BTXXcS6bESA
 dJ0p36A9W4mJ9Z1NegyY9b0+ZlZ6wnvM=; b=oQMHxk3u5j9Q4+ENLhkhXiuouVw
 GRMhQfrIWR2w9WbhOzn0imeGM+9GlszP5PFedXjX+G6Pz1TnJVHgFIrES74rQHbl
 ZagZeIaf/7VCozPVqfYVykqNyPrg+dbzvZEGGnXwRVwIA78+hUOxktI0tSuvkf7n
 gi7er79yo/mn4Gmq6tV1pXLImjG2TUZS1CnXuS/S1S/C9q1RyhSMO70ryx4IaEuw
 eDktBmCJu9kW0DjBXuSm1XqwM4nMT2Hn6tpBhtH/PyvOOBr3Jj27lgS9j8EMjbbQ
 akHhj0uqs3xd1JvawWWNQMycDsoDoyNgIEVrbopY9oeNXdujkoSXATaWhJQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpn41sdtc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d6f80c76e6so71385695ad.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433294; x=1790038094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTXXcS6bESAdJ0p36A9W4mJ9Z1NegyY9b0+ZlZ6wnvM=;
 b=JXChU7Vp7nf3Zuku12L7MLeeQVFckGvK5WEc9QNWXDCfftnlaxjrsHgvpubK2YhGqZ
 o9VWBOztXzqVbuaqIH4uR85zrcPNQDmmc6W+gG6BL+HrT2qMWrL3izUSE0/qFoOEjle5
 TeWBMfhZtZreRx0BYlAsGJh8dbrGHQO6NJyKhoG2SrR+YZCK1DCL3b2uhuGEM3qYnOol
 +GQ+QPd+uYkc8c2NTbWeSMxHSHg+Mq2NmTJ7j1EBNz1robqexqkFHtXe3ExCoPkAQXOc
 dAzagdhVZ2rXhky48DGnDinEmpV3wJodn8ma8KOFeBR+w1RiAvyGBnjg/WeUTOJdJ4rk
 WYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433294; x=1790038094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BTXXcS6bESAdJ0p36A9W4mJ9Z1NegyY9b0+ZlZ6wnvM=;
 b=ZK6HGIMuLiO9PcG1XpGBRY5BgwRIEDBpMV4MzpnlVAg0IzEjaC+6fzJCq+pQ6P0RQN
 3qIWGlqhHhVIcefYbtHGX0JNVQGPPEbAiaYfcjwf2jvooGFlakAOqY4XUbMM+aoKIEzm
 ZyTE2QRM0mOxtulP/f38+XlW0+jaU13rPii+hJFZXVwTHS+IQ5q1+nfiFEjFndadT5Xc
 yK2PIW7vS3QH0hDBh4mnSTGA9wOqgMXP3ExQdEPpZQ4B+VSKVFoYG4JBqRImoy0yWsNm
 KPWl4hnEmyNnuOmRnCdiwG0Por0uNblm38ERoHd50DhThZH3NvxBzyXuoSCELUvm75yc
 XWEQ==
X-Gm-Message-State: AFuF++krectH2KYSycXBgPiU0Jh6w7od1sAA2sTPEYS9tYEtML2dIDwb
 a0ZFb3SqQv45zA8e+c/lj0wNlFs/tJJ7Vf9xLUhKcs8JfD1RpJWJ7G5AGpdCysdIb51FRuE7BpP
 MD65aNet8pj8/8EFwgvigIM1A2OXNo/O7kEt2FmBSaF8chTRHZKbrS31OWiGzdWBCHg==
X-Gm-Gg: AYBFou0lsjrsSt/+vsIJ/WKF1lGDeM16RFWy6LP9PE4YNmm0WwnqKoEkwcCunWYBeUj
 GaFitQcPEy0/XqMQmaUkrt+6lwzHM5EgqWSdAjARBJydT3OshLpgCw9Wghw2wGIFFAU4R6G6egs
 v+RHKjlA2KrwVXSEuz0ZLdxQQIH6dM1A8rYM92yk+XDBrrf3plkcrUCIfIOcvuFO60CLyjfhaMO
 JtvAYeJdIOH0NLOVyG2o+KM1DR6KOHptqSgPUd8eVZq/KtbaN97JPmtGukjxHNXHH1k6xovRJ5p
 4UUq93RE5OX7HRQEiLau3GuWXVtKj8juajiWomgz6sbQKMi5t3T+XKJZJ/QixEDdgsY4/U7y9o1
 WHT/0ICwYiRABQiDmp+Wf4c4kFyciOklPTB78GNmTqEx1HiKMLut3Yoa1Hlc=
X-Received: by 2002:a17:903:1965:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2dd6c5ef019mr122750535ad.6.1789433293795; 
 Mon, 14 Sep 2026 17:48:13 -0700 (PDT)
X-Received: by 2002:a17:903:1965:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2dd6c5ef019mr122750245ad.6.1789433293427; 
 Mon, 14 Sep 2026 17:48:13 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf015csm31978309eec.4.2026.09.14.17.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:48:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-ppc@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 3/6] roms: move optionrom from pc-bios
Date: Tue, 15 Sep 2026 00:47:59 +0000
Message-ID: <20260915004802.5749-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX+EA18dc83Zjj
 bk0T5Uzyp5E1XFcjTkWfXlYCMCY5qxuh93uZiLlS0AaqyFnlnkFIg+iXaY8HzwrBPT2bU/Cxt4l
 yoyU3N4MqFbZQxEvY2mTt+PUVnRtb7WQguq4vjDzi8uPqta/nxSdp2M3aRN5uw6Y/pwWPW0/5mC
 0InsX6O/Xcyb5yzjA3MTSeiAE6IJVaNDMnHT6mhLKsRra9xr/+HFlytMLddMdKq0ykEgg+JoqJT
 6QwJygfQ/Jok6VADHrBqoB1w6GSNpm2x7IyqDqPDrtJY6mNq349PyWSvI/pQ9CRiiQ7a86W3bbs
 JW7qbU0Nqu0orBcE3hH+yBli4n1Xxd2qRxRnIqRQpsL7Q02+29hZk/kUETzeiSKwA/z/KLbbcUb
 ACCOPuOtN6WuDB/O+PhyHcOEUHkL95bIebNHFZhwdj+M/rqkViB1wFov2+aUZ1Y+UzzwALK+qZO
 OH2zMaV+pkEuaZ6bm9w==
X-Proofpoint-GUID: GKbcAfDUOmvaWaHAsEQ6pi_HBh5-Ye-H
X-Authority-Analysis: v=2.4 cv=cqQOAF4i c=1 sm=1 tr=0 ts=6aa895ce cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=3qtoDJxBsQnwwpl5T48A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: GKbcAfDUOmvaWaHAsEQ6pi_HBh5-Ye-H
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfXx0Nd1JuoekpP
 YRgnLJWgHUckRIra8u7a1WS1NZuw1ZXQYeMBppz6kB42Uo42RUd9YFUd/CtQ8AxJiNnxzDuYdD7
 ekzQLnISrl29RoAEi2ZAkiIw6e9y0vg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 {pc-bios => roms}/optionrom/Makefile        | 0
 {pc-bios => roms}/optionrom/flat.lds        | 0
 {pc-bios => roms}/optionrom/kvmvapic.S      | 0
 {pc-bios => roms}/optionrom/linuxboot_dma.c | 0
 {pc-bios => roms}/optionrom/multiboot_dma.S | 0
 {pc-bios => roms}/optionrom/optionrom.h     | 0
 {pc-bios => roms}/optionrom/optrom.h        | 0
 {pc-bios => roms}/optionrom/optrom_fw_cfg.h | 0
 {pc-bios => roms}/optionrom/pvh.S           | 0
 {pc-bios => roms}/optionrom/pvh_main.c      | 0
 10 files changed, 0 insertions(+), 0 deletions(-)
 rename {pc-bios => roms}/optionrom/Makefile (100%)
 rename {pc-bios => roms}/optionrom/flat.lds (100%)
 rename {pc-bios => roms}/optionrom/kvmvapic.S (100%)
 rename {pc-bios => roms}/optionrom/linuxboot_dma.c (100%)
 rename {pc-bios => roms}/optionrom/multiboot_dma.S (100%)
 rename {pc-bios => roms}/optionrom/optionrom.h (100%)
 rename {pc-bios => roms}/optionrom/optrom.h (100%)
 rename {pc-bios => roms}/optionrom/optrom_fw_cfg.h (100%)
 rename {pc-bios => roms}/optionrom/pvh.S (100%)
 rename {pc-bios => roms}/optionrom/pvh_main.c (100%)

diff --git a/pc-bios/optionrom/Makefile b/roms/optionrom/Makefile
similarity index 100%
rename from pc-bios/optionrom/Makefile
rename to roms/optionrom/Makefile
diff --git a/pc-bios/optionrom/flat.lds b/roms/optionrom/flat.lds
similarity index 100%
rename from pc-bios/optionrom/flat.lds
rename to roms/optionrom/flat.lds
diff --git a/pc-bios/optionrom/kvmvapic.S b/roms/optionrom/kvmvapic.S
similarity index 100%
rename from pc-bios/optionrom/kvmvapic.S
rename to roms/optionrom/kvmvapic.S
diff --git a/pc-bios/optionrom/linuxboot_dma.c b/roms/optionrom/linuxboot_dma.c
similarity index 100%
rename from pc-bios/optionrom/linuxboot_dma.c
rename to roms/optionrom/linuxboot_dma.c
diff --git a/pc-bios/optionrom/multiboot_dma.S b/roms/optionrom/multiboot_dma.S
similarity index 100%
rename from pc-bios/optionrom/multiboot_dma.S
rename to roms/optionrom/multiboot_dma.S
diff --git a/pc-bios/optionrom/optionrom.h b/roms/optionrom/optionrom.h
similarity index 100%
rename from pc-bios/optionrom/optionrom.h
rename to roms/optionrom/optionrom.h
diff --git a/pc-bios/optionrom/optrom.h b/roms/optionrom/optrom.h
similarity index 100%
rename from pc-bios/optionrom/optrom.h
rename to roms/optionrom/optrom.h
diff --git a/pc-bios/optionrom/optrom_fw_cfg.h b/roms/optionrom/optrom_fw_cfg.h
similarity index 100%
rename from pc-bios/optionrom/optrom_fw_cfg.h
rename to roms/optionrom/optrom_fw_cfg.h
diff --git a/pc-bios/optionrom/pvh.S b/roms/optionrom/pvh.S
similarity index 100%
rename from pc-bios/optionrom/pvh.S
rename to roms/optionrom/pvh.S
diff --git a/pc-bios/optionrom/pvh_main.c b/roms/optionrom/pvh_main.c
similarity index 100%
rename from pc-bios/optionrom/pvh_main.c
rename to roms/optionrom/pvh_main.c
-- 
2.43.0


