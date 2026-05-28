Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EF5CD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wST7Z-0001o1-7L; Thu, 28 May 2026 01:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7W-0001lm-Jx
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7U-0003dE-Sk
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKlxXm2621792
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/woIQPxDKSY
 CbWPtRBJbJML2dARjVm1FSDheHCl8/Uw=; b=JkLa4/VBKx9PmYZnYD4bKQq3koj
 10Z8xEvTXc7QcKiNoD3XILoxEc5JXoBq0in50nbQ69/EuSRw/MFEtFoGRboitTcQ
 rIRqmd6ngs6LKcJ/FktjcyfRQwG17Z1++9fPKaE/xfvWg2htKU16EQWi1fLChC+f
 E7TfhobA9SgodGsY38D8J+G0PJ0nHeV+YxfoxTkFJpuI8LK3wmGu2DY8aqL2Unyq
 nijGXiYzeKCDLoutJrMaBBpnjOgkkubfAWPJXWx7SFmpuRHl2j2raJz2STnRlXlc
 KrgpZmcHzlBtxFcQrppjvQQXWMN+WAAX8f/vrZjvOZQ/pZIFiWu0Kci/gdg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yf1dbe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3041ab826ddso12280056eec.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779945433; x=1780550233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/woIQPxDKSYCbWPtRBJbJML2dARjVm1FSDheHCl8/Uw=;
 b=GyBu5BD4V61PHylmU9LyienaACNN3TfumWMKnI9rC1Ko8IN8zvMNSc8Yhq4E+BwsLj
 ZSWcb4fObKAXZhGa/HrODGEvrA0y0bnEsZLs/HW5Orf0sN1wjKAmcDQyfByF8Kyakn4c
 CGUGfUDCguJhtByhJEGf7Vs8z7JJzixIAKeEoJd2jcepmu/vGQFXGNSA8sQ7khxqOWiH
 /75Q7iWcmDxcuTYHm9CIXyzJutLIblcAA6rAk+z85A7u/Zq8qjxL6W7tCFxzS0UrMtKP
 TxjMyxLUMTAMb3LEOe4PSYcjvGipZ+EefqkMCOpuJH2gFqBREd3R2dZeXumSHPjYPCFF
 VrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945433; x=1780550233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/woIQPxDKSYCbWPtRBJbJML2dARjVm1FSDheHCl8/Uw=;
 b=ES8SoLv3BoONjF5EKbgqiY3oW2RDCVJAzzBuhYaZjR8bqHV3d0+b7nwSUKjAu167bd
 2FuGSl5Z7SZfZUyr/bgjp8hFJpAgp0z7E/ufeyJJ5A/nbrJFItk/L20T4thYQbHlGOPa
 VNLUd0vK7LHLWZxFy6lUF2rNPxFLWbj3H1J9U21LQtNe/eyxpYr2dxbflft9CqNoYHW7
 xGeYOwQNThd9XUugZZA8QUOlbmOfT+FDcrKGYz3Pj2YViPS1lCfF03p4rIasp9EVFiyV
 x/UR6dKGLIdvQ0o/u9lBH+JUC+yuNEhrIzcpHLpaSD2XSpxTdHtwNxd3IQ1qmAEnEGtv
 Q/gg==
X-Gm-Message-State: AOJu0YyQ8mpVW4S9qxQvdwwmq0XaQijI4etda4/+ajahb271yKkq9KcG
 c9P7N+/HqoffE4dPy9EXsa4cHEdTsYMm2IyiJJpw4uvYQg3Qf42LtWvqNZgKFQqWsRjRusd8zcg
 4gjiOuQcSPZmGMjT7VeoeY7TTnbyZgqLhExFEj3tVy+JSgKUms0efHI5Jgu01itChtbJm
X-Gm-Gg: Acq92OGBuCzbkpMzEXfEPRkyI+gDMqe9yEwWkxL6Em4k7VQ1jIA+yQxWvF6tb7WI8PQ
 ow44WyCAaAA7+35Ep0BdLu5TkAXHa1F9/JZzD9VyPzezAc2cHTvq4ckSZoLDw/AScsvZWfZ7Byo
 Uuos19vjEu/qqAlpatozN4kBld4R4L76vlB0k/rEMuTADzSAk8wACwXeV8c/nEjTgZNJuXlRD47
 tx/rZzgg2nb1gvzX/bVe91SjQNRv/QnDYbjJwcLWkUFyowktxHB5pqub8/QaRtHHst44n3cgbf9
 OXUWKamgSOehMocdYWtDOT7/e5vUJYAEAFOSDMFw8XjNhEWJiAchAD0dHwevUu6EfygBRgTZdbI
 h5nnj2UrxXxfElHj/J4/Y3ScqyNf+wYD/d32YxEt32qfgT0l5Whmk7UqRax3ILsxGB0tB/MNwDC
 MF2mevg708KlzGSSTt
X-Received: by 2002:a05:7301:11af:b0:304:5a9c:6479 with SMTP id
 5a478bee46e88-3045a9c6ba4mr6944641eec.9.1779945432533; 
 Wed, 27 May 2026 22:17:12 -0700 (PDT)
X-Received: by 2002:a05:7301:11af:b0:304:5a9c:6479 with SMTP id
 5a478bee46e88-3045a9c6ba4mr6944585eec.9.1779945431986; 
 Wed, 27 May 2026 22:17:11 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304b984d9b5sm4094607eec.7.2026.05.27.22.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:17:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 02/10] target/arm/whpx: move whpx-stub to arm_stubs_ss
Date: Thu, 28 May 2026 05:16:34 +0000
Message-ID: <20260528051642.115721-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1EHwY_ecCOKCI-RKQGabm59tQxZ8zV4g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0OSBTYWx0ZWRfX+nVj6tdXPzTm
 JugT9cbLuTMhfzkuJNHR0ntDwa6wC7U98xq+vDwjXiTH6f5MWLPrHmnoTvNeM0xz4WN24Kx/yrb
 OLLS38nkLFX7CeUdRAOr6YBsX6n1BBjnhJw/IOJBYn6eIE5NJshi9hIkFx3tYfpJGQOOfN3VfHe
 yi44gk07ZZkCyLTaA7naL6ZUPIbMsIHUGB3xOm/Vj/LWvnhNPSkF43oFbkL0JWBEsWtZ2oJmx0D
 lw7z7i64ENoxhYdxcaQqlE8a/j8ROyVOHcu5by/8M1tURRdzzDFqZNxpVSgVQ8LXjViCgcFumuX
 RmoCTSHSYjR+SB0QmgV7aZL7tRR5YiV8Ua0k+XDacdDXtnkAP6HgN13zJq2eWVQE59veWJt9SuN
 ypxt4IpbqY9hvLbE9zk/vbVuUTc2VBwNUKkuQ1KNp2TiZCNSU7DjrKEqaGUGwVEKVfh5KHC9zpl
 2VVbPibcBHA8eMlmLyg==
X-Proofpoint-ORIG-GUID: 1EHwY_ecCOKCI-RKQGabm59tQxZ8zV4g
X-Authority-Analysis: v=2.4 cv=G8gs1dk5 c=1 sm=1 tr=0 ts=6a17cfd9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kb9KSwTJ_RVVZN_E__UA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280049
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This eliminates symbol conflicts for whpx symbols on windows-aarch64 host.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/whpx/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
index 3df632c9d30..7385c14f534 100644
--- a/target/arm/whpx/meson.build
+++ b/target/arm/whpx/meson.build
@@ -2,4 +2,4 @@ arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
 ))
 
-arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
+arm_stubs_ss.add(files('whpx-stub.c'))
-- 
2.47.3


