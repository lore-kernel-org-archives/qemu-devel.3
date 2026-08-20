Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057FAC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0Kh-0002Zt-8c; Thu, 20 Aug 2026 06:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0Kf-0002R3-No
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:49:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0Ke-000643-6k
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:49:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K9JBJw2927086
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1lPeDKWhyf6BBMuDNMEYdwwD11UjrKI3mpFnJczn7hk=; b=QsrPST3Z0OBcdsu0
 WTJXX+fYwCkzXhsEIWuSxIfppN6sS+cd87fqKcY+4vK7XU4RAcxY98Nf3TeC7LQr
 +1UZHzl4FeB3D7yVvjtAZFJWR6iNxq9Ts3pNtXrc53pwDeX4JL3+AFP3lf8MCNg0
 7s/Ztb8I9TyBPFNY7bfxIsQURmuyroecgUMuYekr7f1xn0TD0PwINyp9wXp9Fsqp
 xOINRWDdJHIoklFHrb1WpVhjU50tVt31RgT1YOo8t3GykPpXiRkZQzh+zl/keQSv
 9gLzJPYgQJDfDcxJYV33u5bbV4oGRVDhn9sSsQXlp9ixC95XoMqUb4epe5Y/3LcS
 tTs63A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk0bde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:49:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936d067836eso249117985a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787222941; x=1787827741; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1lPeDKWhyf6BBMuDNMEYdwwD11UjrKI3mpFnJczn7hk=;
 b=U8OHbOoT/M7r4ANofqgZ4co5mUoQTulfNweyxfJRCojZWCijrQ2B+vAxWDSF/ddBUJ
 tEkUPjQyDs99EVMmtuTvAxsiIje5hBYEh4k3D/TX85DbdDb9TnUVNiYFHk9gDbmYSlTj
 ePcIU08NZSs0N1wk4FHWqTitMHWppHIiCXYF0iZXeDq3cI1X3E7yZqexxb6YGZeYTRs5
 JqwXdTvyuYmtle/AqwmHJGpZRI0uopxUym56fBhg+w0l2/dO2zKkVa9o5JEfUT0BA1N7
 faUbCHhENrvtto6+RvtOoEb7FEUwc1UnDf1D1KIM9zD7yrXzxsy56F3laE/fd2mRsBsH
 4SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222941; x=1787827741;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1lPeDKWhyf6BBMuDNMEYdwwD11UjrKI3mpFnJczn7hk=;
 b=E/kZM7TERcUDgtwx4gc0OWdSY4Sopz6hkvWIJUllTZaq+7fIbB5HwOgWziTuMvwmoy
 z3LT8nXEIcY7lG8ngBPrfwF/+QUZlwaCToJGGyoZ3sE/9wwy2P1P1aM3IzjFyiLO9uzS
 0tODrkebgjFkXSCHEcOe3k2nggcaQ1pViZCtTovMpkc7L8DhnvHJDrkaJ0A6bVkW2LE4
 qzJgykHN8JBlg2Kf0imyoIU8R5UXCq6qy5++zcCqt+GWQuS2EfJBWnPp9tlZCt08MdiG
 TaRmaegLekssQVFqWY/uo1A9aJZxnzfzF4xHlxfzjgb8nFixJ+QhfeP4M2Qpb4n9b3ra
 FkrQ==
X-Gm-Message-State: AOJu0YzLSVOotn1b3VhIZwIOzHeqVXIwLbPdZ4VCzhGCaw2Z+1phz6Pu
 znzSUOMMY9JX25V5SYqJbYbJW6pIQXLqXRak/pIwCjQWaMWhJrhhjTv7parJA5InPQLWykxBg/A
 1Rc4zB94K1A7hSAPMcbKXGmFaSXZJ/rUwVG1seiTJ79YMfrfhiU+6iReiQHPZUj/64izA
X-Gm-Gg: AR+sD10xTpnw3uUioA5hA4tX8ODECOnyeXT/Xkq6AWxrVIiG8uRtN9cy967dFGXfXjL
 KLpulPNRdS85opqQhhD5Be1SdODvSe6F4U4NhSuTQxzy/sOWlBaF4iqNT+/CsMpihkaUF9mDWX2
 x7AoIEkz6NAhlIlPjoO9zV9TMdO2snrP8BbN81Ws1m8EI8Vkp/cspwA9Hsa4pupL35+p0f7/RWT
 RsGWpzSPALyZmXgoO15uUhG6rVcTrK+wiDKfi5tu3frC/YnYIJnCQ6o6S9vXX0y1zBPq0Ol8O2L
 xjMoWgq5byDqEdrQ/ZhoIq57unLtEkP3mOBxefrupglQMXc/d4BvcrKCH4GJ4WsWEr6S9YVgOw2
 mnSYpRxhK88nwOzJ1HCotuG07/ETU4BXKAkGKqMlJBA==
X-Received: by 2002:a05:620a:284a:b0:937:11c9:37f1 with SMTP id
 af79cd13be357-9371e29f5bcmr1056238485a.16.1787222940814; 
 Thu, 20 Aug 2026 03:49:00 -0700 (PDT)
X-Received: by 2002:a05:620a:284a:b0:937:11c9:37f1 with SMTP id
 af79cd13be357-9371e29f5bcmr1056235785a.16.1787222940440; 
 Thu, 20 Aug 2026 03:49:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17f202sm128147945e9.13.2026.08.20.03.48.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 03:48:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [RFC PATCH 12/13] target/mips: Constify CPUMIPSState in
 mips_vpe_active()
Date: Thu, 20 Aug 2026 12:47:28 +0200
Message-ID: <20260820104730.25462-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820104730.25462-1-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Yxa5RLhLcmuDvJX61nrkMqvVajyStOk2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX5STI0/keJdxB
 sDJ9anLm47a6JFVy3KWo6uijS3ZveEwkrBuFFq6ZmlYRAZWs1IRimR+ylokWbj4CD5H4dKdLeYS
 dBoT47xn7uANm8vRhL/1x2xYvfUMp7o=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a86db9d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=fHZv-jQ_ZcGm2iaiupAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX+I8hzVQGZnjj
 JEiHOhABRB8bbMzzYDxqUZeZpcl6671n/VFPP1IYEqGEGqqBs729Cr0OJx9Y+N0NU1kx7JOBtWp
 jmTByMigprBGzGj2biA+oXBQq2RfXSpe8wCIr/7JcmSyMB0BYKlisiTML5SnpvT89A41JoxNb+r
 Lq5FeYnOjtXtej8pMfzUuvTbx6BYpLcaKjRd4TbztLXWGHY4WgIXu0ZbBza9vkM1CQRsWBDqGbb
 jLA+T57x3GWmgnLJVPagozwA59RsuMXzPlDpA5GaYJLRrzbLtAHtzbp2vg9TMwvqLvP/W89qxwL
 BYb/wmHnQ2PnAIszNxjRegllqpzIiLiG7ymrk4EEu/Nz9AIoluvn6gOZjzjySBsp1lcEwQyCN/K
 DonQfqEfHqRoF2poPgiiQzxubIpzMTRK9MGByTIqGVdNmiLGvlZgS9sU+cVQKbjPsWNyYN1jnrI
 s8CqPUU4BLPFN+VKgYQ==
X-Proofpoint-ORIG-GUID: Yxa5RLhLcmuDvJX61nrkMqvVajyStOk2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Use the recently introduced env_archcpu_const() helper
and qualify @env as being const in mips_vpe_active().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 66e8c599b43..88459539866 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -247,9 +247,9 @@ static inline void restore_pamask(CPUMIPSState *env)
     }
 }
 
-static inline int mips_vpe_active(CPUMIPSState *env)
+static inline int mips_vpe_active(const CPUMIPSState *env)
 {
-    MIPSCPU *cpu = env_archcpu(env);
+    const MIPSCPU *cpu = env_archcpu_const(env);
     int active = 1;
 
     /* Check that the VPE is enabled.  */
-- 
2.53.0


