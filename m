Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C436ECD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQgQ-0006q2-AR; Wed, 10 Jun 2026 17:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQgP-0006lT-3u
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:41:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQgL-00032I-3b
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:41:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJaCm12621653
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pZIAO/tzWro
 CgEzjpoZj5lnjJ7EetIqK5We7SK6ra5M=; b=nNQFwXvGYTOfrjGM/o9XkJmv0Ak
 eQZ4dh1FZgN21meXmkzT4ufQb+qsrrWEwNhYD1g5RbNHpi7lqd+rh7ru72G6Qly3
 cgxzBjupaSQqWQeIm2V4GUnmK05niPQUd87nEO7OZTyjegEDBqVyvSc9v82lDXtQ
 JC9RHpjbxqsa1tu1f/C3jRB53GOK1cq+1nA2clQzgVxlbbBLM1o7JyswcK6dwgbd
 zqKEjJrEY0LEzH7RnTKoDpCJp4h1y3ibt3r+GUBL2X/pMt9+IDIoyqvxZ4Hb55GW
 DUuNSl4fywyMl0wl5hPXTCfk9ntidbjqZSVgoM6bbR8CIrvwwl7elju1inw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sggc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:41:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517e054fe07so28713861cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781127710; x=1781732510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZIAO/tzWroCgEzjpoZj5lnjJ7EetIqK5We7SK6ra5M=;
 b=CvA6zVWhBPkrUm1GChsDuOFpF8xBfR90aaIBrxeqNe8uvHm4AOuRo1paLGyEQt9esa
 rJQdV5FBpIFLbwSRYbkEO4f+vFpSzdhJDGjh32aPvVKxYWITzwhix1AkbtcsMkyaDe2U
 YaIz8QvTaywarEDsxZNA2AURnIG/JRViLttLgNWw0hzINJ/H8lcWmJaJxNSilJfJ5SgM
 JLWKzn3ivURlzNgrY2f97glCiBtDyTMGF1Fvei7OeWvn4wjzxFQe2wlHyPu6plNKkn2b
 Eu/Pu8/Qt7cJH9J0GCGamDB9+MHDN34YEz82voy3MOCx4BEVbomU1B5ikDl4uFZsMacZ
 ys7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781127710; x=1781732510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZIAO/tzWroCgEzjpoZj5lnjJ7EetIqK5We7SK6ra5M=;
 b=EMl7gjEaAGDzWu8oZvB74VZXF8er03Dx4odglCvbUzzqrjqOeTIy5xBAHGGk/BD/Mm
 Sr5g+xS0/1fkgVZo43p+dujzHuwoPccb4bb1kdcJ5euItjGdvtkvyIQiNIGfL9OV4SKQ
 Uw6Juid1wX3E8a9Gef+N3SEJKU9nrNT7nGljk4xEajNN+PkNyzNIyupp3wTq/PVzh7ya
 m/lDYx3PATVi8SjDEYFCEJrdP2VnY6X7o+tAA8oz4tLdA0VBzyfukHBMmq8DqOpPoD90
 yx5rpXFCx4HDZaNcgrjWRzRQo4avCJG3vdX7NNR7TofhncL7Xpc0fu9eKB7Ga/45C/Iq
 MyTQ==
X-Gm-Message-State: AOJu0YyE+nXU8jXsUhhS37GZXlADfgfHQkaaz4JRcpZFGa5KX9mhO1NT
 JSJIt1KUEbGJThXcMBdvDUGfTphvZcGgULyEIu0+vhu0uHp9MRgrXMgMSQDmX5Dp7wfi20XkqLo
 ZQG6GYUoYYxYsddjo04smFmST1lprqiQynoV+/mVyYKTPUQmaV2TNM6OgEPs9GMuygQ==
X-Gm-Gg: Acq92OGxWlbed4YekQANXCNk2h+1mcFMf5XJzmGClxfsJw7Q3f2QpxXpHLS2Zu0oELf
 L0ieW3iKxp1fs+cLMJvGqfjmol3EOAymAymRTynE4avfiJEoE4RvvX+dKT/IUXouj4ACNDe06w7
 +SFDLjAmX1hZI2bgp622XZnKJ84N973JrQAEvUmRtr58s40pNXpICYbl0im7Q2qwZO10s9vCA87
 qShMsX1yBjdTgg9UG5PaVubd5qeE7R5UTvTHLmqKsPEWmBMI8LZNoWYzSaSM7KCo00CNASjqz9X
 R3HcbE0nAdaVjzEvOw2mq+G8EqoTVr9RAj0UyOosWD7MpMUooEtkBq2kB37YSW42A30M7pGO3hF
 pGwtKdP4zqCcknFUT3TZgB4ks9SOxVT/VUoYaFDA1c4gF3BxPY6XX2hqB66kB0v1Afa5+TQ==
X-Received: by 2002:a05:622a:511:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-517ee28dbdcmr521001cf.41.1781127709790; 
 Wed, 10 Jun 2026 14:41:49 -0700 (PDT)
X-Received: by 2002:a05:622a:511:b0:517:57f5:e21a with SMTP id
 d75a77b69052e-517ee28dbdcmr520491cf.41.1781127709293; 
 Wed, 10 Jun 2026 14:41:49 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d777996csm20766280e0c.7.2026.06.10.14.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:41:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 1/7] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Wed, 10 Jun 2026 18:41:27 -0300
Message-ID: <20260610214133.1882563-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hHFKR_GB4V4xOjyHh_peSByl2zTtEor2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfX9aRTfxmhLn84
 KH+5lBLwdREtNGBJ87oP88Maw4O5kVvtpJ+Gb/1nV6H9rEpDxv61Mr+UlzlWrlkAEBexVV1Ryi/
 V1DEgQBZWReW1MpH+Gz/697TsfynrOE=
X-Proofpoint-ORIG-GUID: hHFKR_GB4V4xOjyHh_peSByl2zTtEor2
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a29da1e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=GhL2bEVCvcqOW28JNKkA:9 a=uxP6HrT_eTzRwkO_Te1X:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfX2IEH2806jy6V
 rfNXwQJvv3dKFqSLfsM8ReHgkzE0KcjNrqKAk3DMpSiJoXoTNEaYkqms0v/7fd0njFDEXKQMM7e
 3w1cq9vRYb8Zv4vXq2rYVnlobvO6uxT0lBiWbr0zNWp8E+fELhPrX/Gg/+/h4xF/uoweb73AVR1
 xGTeCuKFZF5Py9I0rYTrDJfvibfwOlDrdc4lisKek35bWH0Y3taE+IGVIZu5S23G7TwepHN+WXI
 GtKUVvD0pauFmDe5LrHhWG0mFHxW0FkqLmlZfAnz05YZTDhS0ZZCl9sBkit545myNvkzC9WkUJ8
 nQjJE9LsSzfV9zUOuh8cnwlbSPjBzMC2XULlFEneRwaEhmeeTGKdeeHFi0xVK+W2tAPH4yEA6XO
 QEkFs6jlugZaI9YiCBFs85iLUiGh9BXiwdGcGQrooSJ87ivfpUSrRC/PrcVrNi/K8+1ncehXjaj
 5h2zwVsS0UxnRIsJZHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606100207
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6423f2d548..e02d53cbba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2744,7 +2744,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0


