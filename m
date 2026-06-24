Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B8FCD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9y-0008Ek-Jx; Tue, 23 Jun 2026 20:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9p-0007xi-1J
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:08:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9n-0003Lc-CE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0JHI973566
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iOTZIweGlNN
 xzxc80t3aYc0ZNrbiE2Gm5Ew+CPkkpvQ=; b=l+4xw7mLckhtEMxeFL2mT/AdKnj
 zx5hV3g2k38rSJn6HQZpyn8iozrXPEKZAX6lhR9KYOw4nDmnxdYWCOPSfLq9mDcI
 gR7POGV8RDUUdF9302Y05UJAAQaCa4O9zs0LIJXCH0c+LK08FyUgzqrBl4Efciof
 LUJnE/XG6Lyef+40YqJ0BL1MNuZUZKHK3Nq7QtFxMG+wzt8dNavLlSW5BzqK4DDf
 7+WLI6fOxrKTBVr17LHPZMQzEk3bKqVDY4rq/ggea4lkbgQr2EIAM/oBvgqE+y3V
 hz1053WcvvrE3vdlSrkjJ5vvepp954z9FVOA4yBqvAShbP3J25NvYah4/MQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f004p0smw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dc0a6ab3bbso14308186d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259663; x=1782864463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOTZIweGlNNxzxc80t3aYc0ZNrbiE2Gm5Ew+CPkkpvQ=;
 b=bLP499fxiStuNjtNqfSJw/TrFOpAbXYXHfW8q5d1Bi3NNBVKFGA/cQ9Yj+rppmI9WK
 nljpdrN75MGNqVobu+U1wXCD77M6096ybM8o+dPa1g3/dpS+fpaN6MqoTOhUmp2ftc0s
 ZF/LQy7P2LBpRy96W5+xozXmMsl2hlxFCb0JkTOR0nxV+/D+Iiisb9poWbQfvkvpDclF
 bZSk/E0r867GhuyooCbUGABFOTw7sUpindnqj9mMRzKliM3qSP1kbVRNcBI50ip66whJ
 hTWXXcbHDpnWj8996rXmhKrIGiBe4wFdEiJubFkgSGt+ABUJubcwnfBm/yU4gzbwMmoC
 oXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259663; x=1782864463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iOTZIweGlNNxzxc80t3aYc0ZNrbiE2Gm5Ew+CPkkpvQ=;
 b=s5aK6h7LEmQFZM+u6hhzqZJ3v/X5yoMr/vrEGb8Lhj8TsUdhOeRo/idtmJbzrZdsRK
 PUtWYlMXz4TcjtC9BuGM9f3qX+suQUAnA9M3fvEyCUzEA6ca2Xz5efJcGoo0HnXCxzDA
 pmVY4RPfz67tQp2Mg5NV9Dozc0gMyzh8rza6ajLfBve3WKdMf8jn6sY9Eq3j27DNZjCs
 taf0/Z2d6tI+xPNQckkZ2MxQycQeni+x+uIqgWzg3v8Qtei6s2DYH8WE25duu5eDKNJp
 4USB2eaUYL5cxAi2JhbKkC7qSBHfFxOyy/nhkjDTBEQbTzuzF4D6gCSBQ/nIUkpnmSJ1
 0mmQ==
X-Gm-Message-State: AOJu0YyjERgo+A7RP7HMyeI4Oc0F8MYB/evg2sLBY5VjY0f/6jzFmWYn
 E8VRR773lQFUTnxoUmjKVuTbSJIbp8QMOFQSUREo0ynnZ2yU+xnT0fG8wYxZIKS5iU2WWAlaUzS
 OBFncYGiDwKD3wFvFT57aq9t4tcRZSTN/KbD83wxQvVPnLl/55jhYdwSH3KdrF3kvCA==
X-Gm-Gg: AfdE7cmBaLsfXYkqSUyS+NCKBV7D5UoBJV9NAF1hrv5whRxV7kGZT7pmkevZDrBSxCA
 5aabgZOlYZJ2Ao1XuDcMEd3b8hzaFUDzJdMra57ky+g2OB9h3h+cFnsBYkNAQKQOI2TTJD4UE/t
 t61/a8yGtoDkUTpd+iyYpuwZk+VCV/UiwynJ+1xZkpEQCN/Hth0mJClQCw5oYQVBoZQhQI3yZov
 09Ta1pHXCtGjWvI2OT0jpxQLIgM4iRGzZLet6t06fOCow+/UanAE6TxQNNHDGgw5zwlIwza8rIV
 QqI2sBzmGBMreuo27wT3keYAsgnu626XtfJInrVCM3VMB1SW+rbM67icMM4eQd5nnZSmDmpGw0a
 AiFvGXxURycU3tTbBk3WuDY4K9BQaHV83Hkypi5GEwjPVbg==
X-Received: by 2002:a05:6214:8085:b0:8db:dd:4d85 with SMTP id
 6a1803df08f44-8e52fbaaf12mr24634746d6.26.1782259663296; 
 Tue, 23 Jun 2026 17:07:43 -0700 (PDT)
X-Received: by 2002:a05:6214:8085:b0:8db:dd:4d85 with SMTP id
 6a1803df08f44-8e52fbaaf12mr24634136d6.26.1782259662775; 
 Tue, 23 Jun 2026 17:07:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:42 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 21/24] target/riscv/tcg: remove unused
 riscv_cpu_get_geilen()
Date: Tue, 23 Jun 2026 21:06:28 -0300
Message-ID: <20260624000632.2149359-22-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX9E5ey12dmxlN
 nFtFEak6R8rn4S4+O+OmBIHnAF+BgskMN4dnnaY7v36Mm9CbEhOx/Zn437AIA5zAWDGuTwbTuzm
 Y9qEy56+fynUWAQ/GnFxA0m8sexf5TQ=
X-Proofpoint-ORIG-GUID: 7yjRsms32t16GKAFtcOhZ0oZf7ubks91
X-Proofpoint-GUID: 7yjRsms32t16GKAFtcOhZ0oZf7ubks91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX+2fJCOpIQNMo
 cTGRCAN4+7Tx13IwZkOxyxbVFcppbKBoUAyTnJcFzMO/IKtNOjSKfJD7dtdnmb23znMo6Qb5vZB
 jpQKGwmlo0qbVU3i0OtPlMLnwmLqVXFj7FHouZDmKxD9AQtdWO4ccKnl/qpRugY0B2Jz9yijTaj
 yxZ/mnLHo2UkofJZVS2l8UhGKFEjktI1CZkUcsnNEdEqadeS3WvXJWmjeV4EyZYYe4wsxtefw7G
 UWZ9ivVyPpkq2KgpHFDO/4KFF4A6v+mv8oFuYlVq6vk1mktmpK4sMO9Os1lVGubMcmnNFcjCDqx
 JTNWTD9wg0J078N5xswhEwBXtK7p55RA/bYqoXUYQhppa1UPtbc3aCi8f/EPsodmdksrSmYzLiz
 3GoB6AqIL7lZ3lP7/foNL78GzyBYnxqRjg9knP8XkC3BFDitQ5uHAhTWWqO3mLQ4lM7iA5qB0bM
 ZoVCYfhUiLZaS+Ive8w==
X-Authority-Analysis: v=2.4 cv=Q9TiJY2a c=1 sm=1 tr=0 ts=6a3b1fcf cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=tH4yzZzyKPjBQqKxX1EA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

No one uses it.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.h            | 1 -
 target/riscv/tcg/cpu_helper.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d6c5d6c1db..7618110412 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 822c9fe483..baf5cace2f 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -526,15 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return 0;
-    }
-
-    return env->geilen;
-}
-
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
 {
     if (!riscv_has_ext(env, RVH)) {
-- 
2.43.0


