Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63723CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfK8-0000Fi-Mh; Tue, 29 Sep 2026 17:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfK4-0000EZ-W6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfK2-0003gN-GE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THbGNh3842772
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 82qTmvNGZPxUnq/00/luW3EtkUNNMT7YcRCCVI9kQOc=; b=oGmd9eOiD/uYlWXb
 oaXxsuvUFSSV6/tSIEb8OFdSMzfbun49Gqo4Wj8IFBiEEVSwbK47uCVUoAOiAtep
 /zWEARt6Y3g7KZ0Sb1RGONtTzlFNlkF4yJpyLIzl4eXKeZiobYpjJp39pQb/v5Jt
 FhiUNlTsRcil39imqY6teace4VD+Tw4c+5nbQCMdzM+GTI2fdU6Sw/kPtlvfoWmL
 E6IQF1k3FeZwb2gCgaTwMHUVsPrQ1M/rzSvHUw/vRTfVJQd7gPO734CHL4zQFdRr
 10DWdDudWAHEgOLcrXFFeY5fJFAIaCJHAa/mc7tqTvDQcsrWqyB6FxGAxVwVBMPS
 7KihYg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0vb0sp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34318e88ba2so3590064eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717108; x=1791321908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=82qTmvNGZPxUnq/00/luW3EtkUNNMT7YcRCCVI9kQOc=;
 b=KeAR8i5rTV06a0jqks0PTso5JZA9U6fiBEY7gvqodoqxgBzOqriLWZOEB88QKjzto8
 K8wvNA3V4M7qEl5dWlE2pY7aRUQIrNpW0ksk9yJ/p2DHXtgIbkahJUe6HkKw5my7Uar7
 TRpgqGHJLUHVEJRQ/YXcsk8UN3hAgHKq/hBvJcMZpPTWH+Izf8kLsXtgBB8c/dE/5N2U
 UYorEAvR9DezMDGsS6u5a8nybEDhFG9fa4hdGzvBkD4M5HQeYLCXy0lDW6pvB0xG+JqU
 WC+rfNIFf+ZzIjEgIpfgy8lDEJ6KWvX7dK9gcQkNArIzyG5UuuFjwzHKqRn83nMKbXIA
 TYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717108; x=1791321908;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82qTmvNGZPxUnq/00/luW3EtkUNNMT7YcRCCVI9kQOc=;
 b=CLb9tMLZoJDL1XKtLfTwSLnwcJ5T2pvfNd1yRtPy68rik8c1cMHG4N8iAQWxsFiOMQ
 2KyQCrIM33FFTsVkpI1rzgxiDGuGZPpFhYqt/ALLhle/w77uhyXwR9swxdV3hFr9Zz46
 g7eYLssiC5lA9t0uTiaDTSHIvX0mvxQfanfBk+h4O6Ckgm8Ur2Y7ITqrS0aHegi4Jx+V
 YyaXi/tWMooqXafKmvvtEu489Ipdp0XAeZ9lUdTpQjmSCB2ZLRtrXsQu1OqWPyP6GwgC
 ga2Ci3DI2WiC9v5aU/Qz+KPMNIzK6G85yQyVGFOxiujxgocjyqiDqsLRmfM7uEbKMvgD
 qhVA==
X-Gm-Message-State: AFq9FYLAaMQH7AGBEDQCNVgIGOFRmmOa7H1xaCc5iUVfSYRSkHSa8yQv
 cpX+wZPLAQhE7xoTOOKtMujxEKQBi6tQPQ5ZNshQvd1RxfPyNhj5UC0V+UJWw/6Zt3ChQqCPW2l
 Wd96MAosjtBhrFHSi5A6nE+4tylU23FZiPvzDuAhIvtUDcKLm09a9Twd2YD4lKUX/CQ==
X-Gm-Gg: AYBFou1dtGTMsiuyiJS5UcAeuMyZRJwBn2Cj7HrS2JRFupvj0U7izJbXVVs0LSMvHrk
 yl2aWik4G9N5F1eC+T13CirQeiefR1ufNpPiRecRoVm7KUs6XfHpv/5/8zk1x8IKsgrLYa6/HNZ
 QxgMKvRziynMC8QI6tADipeWEqLXfMDXOtD13ZWJAYd16fsa/KMGHT3PgtOqFJVBzltaXdA0h6t
 U03yWBg6nYsCh15UZun0Czs/yolhbY+W1KbjweMIqPGNbL96RcwQ8D28o5Ftu1T8XBfMVqYeYsK
 Z1bjJpiA6G5KdZNqhu38Way7fxI8hT/LB2hYbOXwbdXCwLOY8c3hq0e54FyUXRDaxr2uP/OgiBz
 8E5awd7kKI9V10Dl3k0cfDvvarHPMHlWm+jNFh8TJXSuflZZJAgnF4TXSVpqi
X-Received: by 2002:a05:7300:c00d:20b0:34b:6d45:de57 with SMTP id
 5a478bee46e88-34c65a7418amr735385eec.9.1790717108184; 
 Tue, 29 Sep 2026 14:25:08 -0700 (PDT)
X-Received: by 2002:a05:7300:c00d:20b0:34b:6d45:de57 with SMTP id
 5a478bee46e88-34c65a7418amr735334eec.9.1790717107205; 
 Tue, 29 Sep 2026 14:25:07 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 09/24] tests/tcg/mips64: move mips64r6 sources
Date: Tue, 29 Sep 2026 21:24:24 +0000
Message-ID: <20260929212439.110454-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SDrPo-_L7CNsMo0d6hOrND-Pnp9nORqW
X-Proofpoint-GUID: SDrPo-_L7CNsMo0d6hOrND-Pnp9nORqW
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abc2cb5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ALku5c8DAAAA:8 a=xz38mcJZfOssY3GY9MsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=Skunnq644UPbuD6fT1yj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX/RoI/QQFmPrv
 gH5gppvCPtK9fo60k661v+5wEgqPHfpku+ZOQ6TB4uPlW0hPGl9EMuqTEOzPhsCD4CxCIW8VcjZ
 xlQBotClG3k1RHObZ4S2poaZVAnV30tTKo+mWh4hQow08Jp5pwzuHs/FEbsRVIjbpW4aQVKERKa
 YmN5TAkP7uy4cRBoqmH32d5hC0wvjaFAwdGBZcYE/dtk2ycZqHVfnZfbdG78nclxBAFxfPMHMmn
 QdFxcc3lKXolvBOzroBUlF9wxRLdytBNzi/ikxNWcFFk/xBTt6q2/xgyGwNOzZCAxBS66wIAEFk
 wpDwc5Psta1B/YMkG3AAbFU4deW7oSYstNfsS+bgLsmTfC/d4B+ufo4pooMxdymgD4g1vKhSiBs
 R2tQNKbMBGKaQj0w8bl+ZOB8YkjIWYACYZrJRUYxBMlDEBRf2S1Wch69wS1FO9rHbzYlQP9whhG
 iHWHHdsUFVkLRjNKP3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX+bbtNWvG/BCQ
 fMddVLUsJjJzs62APQ2Y7r/k+QniEJct7PQFiyGfVrYgZ2lCvr+3LCQMZQn3eP0uwV27IGOM6yf
 3IP5uobmQ/8NDHE+UMeYkduuzHG3c/o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile | 40 -------------------
 .../logic => mips64}/test_mips64r6_and.c      |  0
 .../test_mips64r6_bitswap.c                   |  0
 .../bit-count => mips64}/test_mips64r6_clo.c  |  0
 .../bit-count => mips64}/test_mips64r6_clz.c  |  0
 .../crc => mips64}/test_mips64r6_crc32b.c     |  0
 .../crc => mips64}/test_mips64r6_crc32cb.c    |  0
 .../crc => mips64}/test_mips64r6_crc32cd.c    |  0
 .../crc => mips64}/test_mips64r6_crc32ch.c    |  0
 .../crc => mips64}/test_mips64r6_crc32cw.c    |  0
 .../crc => mips64}/test_mips64r6_crc32d.c     |  0
 .../crc => mips64}/test_mips64r6_crc32h.c     |  0
 .../crc => mips64}/test_mips64r6_crc32w.c     |  0
 .../test_mips64r6_dbitswap.c                  |  0
 .../bit-count => mips64}/test_mips64r6_dclo.c |  0
 .../bit-count => mips64}/test_mips64r6_dclz.c |  0
 .../test_mips64r6_dmuh.c                      |  0
 .../test_mips64r6_dmuhu.c                     |  0
 .../test_mips64r6_dmul.c                      |  0
 .../test_mips64r6_dmulu.c                     |  0
 .../shift => mips64}/test_mips64r6_dsllv.c    |  0
 .../shift => mips64}/test_mips64r6_dsrav.c    |  0
 .../shift => mips64}/test_mips64r6_dsrlv.c    |  0
 .../test_mips64r6_muh.c                       |  0
 .../test_mips64r6_muhu.c                      |  0
 .../test_mips64r6_mul.c                       |  0
 .../test_mips64r6_mulu.c                      |  0
 .../logic => mips64}/test_mips64r6_nor.c      |  0
 .../logic => mips64}/test_mips64r6_or.c       |  0
 .../shift => mips64}/test_mips64r6_sllv.c     |  0
 .../shift => mips64}/test_mips64r6_srav.c     |  0
 .../shift => mips64}/test_mips64r6_srlv.c     |  0
 .../logic => mips64}/test_mips64r6_xor.c      |  0
 33 files changed, 40 deletions(-)
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_and.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_bitswap.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clo.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clz.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32b.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cb.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cd.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32ch.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cw.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32d.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32h.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32w.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_dbitswap.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclo.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclz.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuh.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuhu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmul.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmulu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsllv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrav.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrlv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muh.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muhu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mul.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mulu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_nor.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_or.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_sllv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srav.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srlv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_xor.c (100%)

diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
deleted file mode 100644
index b7f5811a5e9..00000000000
--- a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
+++ /dev/null
@@ -1,40 +0,0 @@
-#
-#  Test program for MIPS64R6 CRC32 instructions
-#
-#  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
-#
-#  SPDX-License-Identifier: GPL-2.0-or-later
-#
-
-ifndef PREFIX
-  $(error "PREFIX not set, please export GNU Toolchain install directory.")
-endif
-
-ifndef SYSROOT
-  $(error "SYSROOT not set, please export GNU Toolchain system root directory.")
-endif
-
-SIM = ../../../../../../../build/qemu-mips64
-SIM_FLAGS = -L $(SYSROOT)
-
-CC      =  $(PREFIX)/bin/mips64-r6-linux-gnu-gcc
-
-TESTCASES  = test_mips64r6_crc32b.tst
-TESTCASES += test_mips64r6_crc32h.tst
-TESTCASES += test_mips64r6_crc32w.tst
-TESTCASES += test_mips64r6_crc32d.tst
-TESTCASES += test_mips64r6_crc32cb.tst
-TESTCASES += test_mips64r6_crc32ch.tst
-TESTCASES += test_mips64r6_crc32cw.tst
-TESTCASES += test_mips64r6_crc32cd.tst
-
-all: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-            echo $(SIM) $(SIM_FLAGS) ./$$case; \
-            $(SIM) $(SIM_FLAGS) ./$$case; \
-            echo $(RM) -rf ./$$case; \
-            $(RM) -rf ./$$case; \
-	done
-
-%.tst: %.c
-	$(CC) $< -o $@
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
rename to tests/tcg/mips64/test_mips64r6_and.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c b/tests/tcg/mips64/test_mips64r6_bitswap.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
rename to tests/tcg/mips64/test_mips64r6_bitswap.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c b/tests/tcg/mips64/test_mips64r6_clo.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
rename to tests/tcg/mips64/test_mips64r6_clo.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c b/tests/tcg/mips64/test_mips64r6_clz.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
rename to tests/tcg/mips64/test_mips64r6_clz.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c b/tests/tcg/mips64/test_mips64r6_crc32b.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
rename to tests/tcg/mips64/test_mips64r6_crc32b.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c b/tests/tcg/mips64/test_mips64r6_crc32cb.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
rename to tests/tcg/mips64/test_mips64r6_crc32cb.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c b/tests/tcg/mips64/test_mips64r6_crc32cd.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
rename to tests/tcg/mips64/test_mips64r6_crc32cd.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c b/tests/tcg/mips64/test_mips64r6_crc32ch.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
rename to tests/tcg/mips64/test_mips64r6_crc32ch.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c b/tests/tcg/mips64/test_mips64r6_crc32cw.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
rename to tests/tcg/mips64/test_mips64r6_crc32cw.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c b/tests/tcg/mips64/test_mips64r6_crc32d.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
rename to tests/tcg/mips64/test_mips64r6_crc32d.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c b/tests/tcg/mips64/test_mips64r6_crc32h.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
rename to tests/tcg/mips64/test_mips64r6_crc32h.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c b/tests/tcg/mips64/test_mips64r6_crc32w.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
rename to tests/tcg/mips64/test_mips64r6_crc32w.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c b/tests/tcg/mips64/test_mips64r6_dbitswap.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
rename to tests/tcg/mips64/test_mips64r6_dbitswap.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c b/tests/tcg/mips64/test_mips64r6_dclo.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
rename to tests/tcg/mips64/test_mips64r6_dclo.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c b/tests/tcg/mips64/test_mips64r6_dclz.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
rename to tests/tcg/mips64/test_mips64r6_dclz.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c b/tests/tcg/mips64/test_mips64r6_dmuh.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
rename to tests/tcg/mips64/test_mips64r6_dmuh.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c b/tests/tcg/mips64/test_mips64r6_dmuhu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
rename to tests/tcg/mips64/test_mips64r6_dmuhu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c b/tests/tcg/mips64/test_mips64r6_dmul.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
rename to tests/tcg/mips64/test_mips64r6_dmul.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c b/tests/tcg/mips64/test_mips64r6_dmulu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
rename to tests/tcg/mips64/test_mips64r6_dmulu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c b/tests/tcg/mips64/test_mips64r6_dsllv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
rename to tests/tcg/mips64/test_mips64r6_dsllv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c b/tests/tcg/mips64/test_mips64r6_dsrav.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
rename to tests/tcg/mips64/test_mips64r6_dsrav.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c b/tests/tcg/mips64/test_mips64r6_dsrlv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
rename to tests/tcg/mips64/test_mips64r6_dsrlv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c b/tests/tcg/mips64/test_mips64r6_muh.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
rename to tests/tcg/mips64/test_mips64r6_muh.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c b/tests/tcg/mips64/test_mips64r6_muhu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
rename to tests/tcg/mips64/test_mips64r6_muhu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c b/tests/tcg/mips64/test_mips64r6_mul.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
rename to tests/tcg/mips64/test_mips64r6_mul.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c b/tests/tcg/mips64/test_mips64r6_mulu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
rename to tests/tcg/mips64/test_mips64r6_mulu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
rename to tests/tcg/mips64/test_mips64r6_nor.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
rename to tests/tcg/mips64/test_mips64r6_or.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c b/tests/tcg/mips64/test_mips64r6_sllv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
rename to tests/tcg/mips64/test_mips64r6_sllv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
rename to tests/tcg/mips64/test_mips64r6_srav.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c b/tests/tcg/mips64/test_mips64r6_srlv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
rename to tests/tcg/mips64/test_mips64r6_srlv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
rename to tests/tcg/mips64/test_mips64r6_xor.c
-- 
2.43.0


