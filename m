Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217E5C61DD4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVs-0004JU-2i; Thu, 27 Aug 2026 18:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVq-0004HP-SG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVo-0000FB-6z
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLp9s3848243
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wnPivJKcFz8
 beT3Njzq647EjYz0bhArjjueNm9Gx/Po=; b=XELyP4sAVF6ZpNpRyo4d+qSftuz
 d2RU7SiXrUQlMGntrCq6FknWdkV0h54xQrBiyO3q4gODXjwI0MG2HBixpjs9T3PU
 n7vXT7Usw+GtgzXajqi293h8zLU2mHeSBBsRv6O10ZvFYHE57hkqYuZl2G6NrlpH
 TmDZDUOCLQYasjEfCaFY3Z8BQAtoToNx6ggbDtifsaVbt0fOkEX5FHFNfgprTHYi
 IRNN+kX/+K611u2ByOH4kEpzYXTVEHE2tFfm/CFrJAmtvFwjiIWsioBdtU0JhoNO
 vnqkwkMsT7vXid6SYPYfcFbzNvw175ZT1M5/+5BhpICQCG58ZeJNcUlu8Ow==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0uqp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so3493975ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869424; x=1788474224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wnPivJKcFz8beT3Njzq647EjYz0bhArjjueNm9Gx/Po=;
 b=j2LsQpfs6erE5enP2t4P6jjEgIRmvdwoshfLYRzyK0fHQbbvOMCdhbwFt4Ld5jJAAG
 yt/oioit5CMcKr0rG+6CeWwYVzi63JUkiaUri5UZ5hX+satQ0HcqdBd50h3ViHePcz1h
 bq78Cr/tXFTBJ0OwjaJclJ9WVOB9fNQr2lEzXUmZOKGVRMtTCicuAc/DaBEUjRjxZ4ct
 30CMSsJDlmUwcQLf3lOUKmTavYdngq1pl20oyJsNOS59c1zvOIYueBu6JqLm53+bVSdU
 PEd2SAAKkcaRvk3yIkc1lz4DLUbXhsu6AB1bGVJjTozoO8pDh+ai2o7tDYYKyOS6Av30
 wbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869424; x=1788474224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wnPivJKcFz8beT3Njzq647EjYz0bhArjjueNm9Gx/Po=;
 b=EY9QlN/AvuG5+gIRAfujPBz6sNCte5nFpabkiB3OzBHV/Phw8nVnE8cNHb9iOzB5VA
 teecT6O13pbLskQDaoRDtPGOli2n6VRzFAmb/q97utVAGGw/aRtqgDm4tatu80YEDTws
 cIu4pDbd2maEtVBdCRKuPWtwTWD69xob0q55NG4V7LvKL4djTJwDq7yd8/kwbtegFt8x
 GQDuRETLpL+EC76PveIUbGiIUmJyT09SIqR690YQU1tztyUbfxsywI/t6F0NTAa8Hz/p
 vb23RUjd1bVR85MSG2FxRUwdq5HHrMfrMY9AiiTx6wOMjiHymfTXSdZ00nctP4CvyU7w
 0nkw==
X-Gm-Message-State: AFuF++ndxX9DwGiER5V0wBHa7Y52+iHfY7Jr2MeznKcFD+0UT9WUBsvO
 Jnrt97U0UgV1mxLZnKTQ2PvMZIDGupDZrwQ1VUffIybxcxEaaQr9ROiSJxUO0NZ1wRqYORqzJi6
 Jc+maHodIybcXNFLWEsCk86NAr2PYCT/K8TSh4eWjZrpVNQcjbTNcAo2dhnfy9ZOAyw==
X-Gm-Gg: AR+sD10uyi9jO/YmFrH2JP88DmdIYbQdSAlp1lmDw2DWsY6jFWZZ1uNWbn7D1Ox7cN+
 0yzZkM3hmmpKSiAU14r6Hf20a1ZCNOB+U8S6YytCE53GTFrz9egeFcI9iC+F5hMtii+04hWqZXQ
 5D0ou0MqB74KRzi6kYMnMS0mDRvASisqYxqJc9hBgKa3q2ZmJy3J5ET6IiXZNzKvYBBu98xAnUd
 Pf23zZYEjnR8Ve+sRWXN19o3oWhUJxh+ZfnLaY121wHrqh2VdHfyKkKRTu2gjrA+d1STu8TGGqE
 QO9Aa3zNGZGonw/Z3KaGQqlmJ5LbummQxG+iH/DJYujRCRJtnYgAl/BTi9J0SvpfKNNCc/eH0Lv
 kTKg8nJfwyxpMWjJDeDh+kF5b7TkASIsMKrN7LMT0QXLRu45A/WsbbwQ9xsc=
X-Received: by 2002:a17:903:1b0e:b0:2d3:78c2:1f19 with SMTP id
 d9443c01a7336-2d74ddc6da3mr36203525ad.9.1787869424164; 
 Thu, 27 Aug 2026 15:23:44 -0700 (PDT)
X-Received: by 2002:a17:903:1b0e:b0:2d3:78c2:1f19 with SMTP id
 d9443c01a7336-2d74ddc6da3mr36202795ad.9.1787869423765; 
 Thu, 27 Aug 2026 15:23:43 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 094/105]
 tests/docker/dockerfiles/debian-xtensa-cross.docker: add test_kc705_be
 toolchain for xtensaeb
Date: Thu, 27 Aug 2026 22:14:55 +0000
Message-ID: <20260827221506.91574-95-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX3pXKoaS/T6kr
 px7Z3h6Ugf6pWaG5zwxRHG4qdFsdTY5fASnXImPvxPPepdtv5mbr6ZpbYyuCEiVq4owPcaBLOzP
 01m4aCoUzPIBXzXhv91esOxHKwHWkH2v5tvtUCY0dRbrwKKSHLSRzWz0+Q37lpOBJ8MJ4eTYG/X
 qlTnzP3wnR18kmxOh52vnHGXwJWAHvDrQLFaebJ49N6XzzAp8z4WgfohAmIQ0MvuC/93aCuhk3h
 RqtY+hAI4r2bNGVAqX5+E8yoZ5QmnwYk1r6A/zyOuDRY+RmKssX45D5WQfqZV9UFOz0ZVo1cFLP
 SWwZzTaMIlvBJHPMIt3KWMlG7yCgF6J9svDfUbRF1lMNFasTgWSQRXh5SNpxMT402ZHC/i1Mj7+
 7UmicdMeEsslrhyvkvVVuMEaqHxDJrbSffwHOb4hVkVwrIDmU+JZb1W0LJhLRA9pCt/ysP4U5Z7
 NaTkj6Z382D8+Z29Ndw==
X-Proofpoint-ORIG-GUID: qUIFaJMT79rnB_-wtL04JTPXL0X0_7e4
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b8f0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=wlx_lthn7XJiM5nFl28A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXyxIrSVNkttSL
 x+wFXfRlGw9v0BxBkIaVSlbikVOszxB/mrCzcu5jZvlVVT+aGD6qKpSNAIaK+86E18Kd0idpnUE
 pl2pTSgi/9wVjw6zhLZ1adwHo80w0OQ=
X-Proofpoint-GUID: qUIFaJMT79rnB_-wtL04JTPXL0X0_7e4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index d9130fc3378..0eb6d98cc75 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -19,7 +19,7 @@ RUN apt-get update && \
         python3-minimal && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400"
+ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400 test_kc705_be"
 ENV TOOLCHAIN_RELEASE=2020.07
 
 RUN for cpu in $CPU_LIST; do \
@@ -27,7 +27,7 @@ RUN for cpu in $CPU_LIST; do \
         | tar -xzC /opt; \
     done
 
-ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-test_kc705_be-elf/bin
 ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
-- 
2.43.0


