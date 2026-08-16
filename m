Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5760FC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAz-0005QG-3E; Sun, 16 Aug 2026 10:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAw-0005L2-LW
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAv-0001CF-1S
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlt9p2762112
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tKpuyMGaRViAw5qqhhwkzkOnY6rea4H8ljzLpjQo2I4=; b=HjGbKygzYkLYg/tk
 7TkY7zEUMk/giTYozobXmNeCwPPDr/vWTDSrpWwmMyeEezdhpgjwPFA1SDZ0M9rv
 G/9E4hDynh6h79h8GkzfxPmDcfJzSKXOexK6iHh1wIiE3FJaOEicsfuaxqypEigD
 oMnlv7mUqlF3Qn4jdskwhsOGX6yIx6T+9qf07x/2cXb+0plK2+wbsFUUtCO3K0/F
 eWwNsEM/exgKqw/H50PnxT4kDLnTB3WfrKptP3TI9Pg/MgSDaREjqWOxjX8eGYuo
 uyUOzflzKO0PRYGSOKxeYzxB+o6gDywyet31ctCkelnOXgM/ODEezJMla18a3ga4
 DP+xbA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkh4f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so34231661cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891763; x=1787496563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tKpuyMGaRViAw5qqhhwkzkOnY6rea4H8ljzLpjQo2I4=;
 b=d0XNMkfF4aDFZCyJ/2EfJmTVDFqaDUJ7jYaV/dKxPzjt+PTI1mNq8V6d8n7QY5BIC6
 SNZuRMw8oNGPEMvuxDh6JnjBbNAluAfWXW8Am7NXaLIWliUy5uRyhz1qQm1lpjRBFtTx
 uQHGipAZGfT6mHceXnAZfXuKSuoSg/V81dZ1wKgBOHihEjIDAzQeKYCPYh4vk6kIlwsR
 Zxzuj+zpWpFmFEGDvMB1Xqthfa0uFbpi/ZPgxIXzdNXKgRMEOh0jr2/JIrwiOZ/RNHga
 urpbUMhRqGpVAQWyvQPHEurWk6P4cWfUcCTXc446a5Cdv/zldf927u4dq5pK74gMe+ff
 /FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891763; x=1787496563;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tKpuyMGaRViAw5qqhhwkzkOnY6rea4H8ljzLpjQo2I4=;
 b=UDho6A28IVTjuKt3kZSLcpxu/+1BtCsTdvpReFlWXyg1En6bYBoHLOgrqylcp2FQTM
 t6N9h60R3nnjcVku/NhA68Lq6ZY9tw8BEQ8pDH5XjaiDiKYRo1pjm/kyXE/fqMvjeUCN
 nVDy8fKGWoE3H2xN+desrI0ynWkYFUNydd1ixgYWLMw6htd96+zN6UFtz7ZqzLHHaUib
 Rd3Or9UKx6rdu2Vmvnm7yrTiPzJfI685tnvtPxaRLOZURIksgY72EhV8GV3MmNxtaRZd
 f5ACndd+GvBFRgmMfNU7BZhGib6QqQpAvHdAYOjbKu4KqBcmwpgXRIoV8ndKjoBmN1vH
 VPmw==
X-Gm-Message-State: AOJu0YyR5AfAnH0J3SybeXKQEsc3mTuaQk6seb4ueJm8r3EDCxDDAT94
 lTgJq2FEH144H7yNd1J7JsZ7XzeW18f+HP163N9R49KdkUklY9AcgkwUnitH8ODgWdvL0X0x48/
 JhVS9sqCxRvfkq638/IKxBelMFH2lVkQTk60FrznWIvsS3FIJ4V4KKlQ1tm+ODKyNlA==
X-Gm-Gg: AR+sD10GYXKsB6qd3DfPu00yYI2UBMDC1RicvQ/c4PRuvcKeie46I03jPuqyueFB/jq
 NNDLKEqN0OcZWPNejlyE+9WPHdCWJIbX9xJ/3jyQuzrgVPkReLFipRucfnTvDFtvdU9lI2cB3qR
 hu+8s1QkzmSpHN6ka0VdQ8+fgiegxhSjD4mSncrfjpmjSNIP5UdpdO4KF8qDcBLZl9ZUa6A/dBd
 QWmt7umoYopxY1DtzqLhCOkSPtPq3+kqxlG/zT1hkSnD5OSn5Hz7euv6nRs0euSmeo8lJqr7JuE
 EiIQvFOMXw2YG47tH9cFoUcq+2grhGxBPkzbzGVs9DQt0zEmkiGf6oUceL1eBXTJ6/rOGi48YZ3
 EdygYu9FrlhntQI6n5NVS3xTZFJxPdtYeuStnBDY1QA==
X-Received: by 2002:a05:622a:4cc3:b0:516:d83d:b28 with SMTP id
 d75a77b69052e-52d74b6ea9fmr288160951cf.17.1786891762715; 
 Sun, 16 Aug 2026 07:49:22 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc3:b0:516:d83d:b28 with SMTP id
 d75a77b69052e-52d74b6ea9fmr288160671cf.17.1786891762284; 
 Sun, 16 Aug 2026 07:49:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm70956165e9.4.2026.08.16.07.49.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:49:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/56] hw/cpu: Rename cpu_common_realizefn() ->
 cpu_exec_realize()
Date: Sun, 16 Aug 2026 16:45:23 +0200
Message-ID: <20260816144556.69009-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UGdzGIHBf_vpAs4UjWhXwQClvYxV2WTt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX1wBqPNlecteO
 UUehQrckMgRZhrnXZDA9S+6uGrvNrHQlCtTOkB8tmEWanHwt96jZwYxRRQeomFRokWalldV3XsR
 voldOXrIYgAdXPunMpdnJbQYvRWuluw=
X-Proofpoint-GUID: UGdzGIHBf_vpAs4UjWhXwQClvYxV2WTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX1ziwRzmB6CoM
 mENp5I7+wvy3TdVj//aybzYMjD6lCrmorSk5Xo/ctnBsvTdYA9gH5Jn9OROb4rWmzB8OfBIM489
 rbhya8eahZBA//fT5mA4nULrGXRiYIvD9OSABgYS4kY3r4knMBiqUZEW+x5QWTm9QhiKFopnkDZ
 gh/wsNzlE/3+NPQcZqM5sDxDSNhKSfoz47T98S3HwevwW87npvdYzfY1rAby5oGHdB+HVD8Maxr
 Sg4Vpj2jxw1CW8AIfMeMd1OOnEzOQClhz7k42NDaHZUxFzlV/IAaoagOGq4ACQeaT2fKRGA2pkI
 cawEeskNIY2BSZF4ZvjmwUfsiYA/E66dy66wfI+ZFXcNp8yI+kU2+aH1weptjfrpc3js0aGzEO2
 qFCzw/XEPViYIC3UUA3xmQoP0XX8Qw2pVlrrOsAzy9bYGVIuYdBd1wHc2NU4hN7QvJki5GHAuI3
 hkstff6ym8IDms95F5g==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81cdf3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260811183410.22428-5-philmd@oss.qualcomm.com>
---
 hw/core/cpu-common.c      | 4 ++--
 target/i386/kvm/kvm-cpu.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 17d76580930..33e349d4402 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -246,7 +246,7 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
     return true;
 }
 
-static void cpu_common_realizefn(DeviceState *dev, Error **errp)
+static void cpu_exec_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
     Object *machine = qdev_get_machine();
@@ -379,7 +379,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    dc->realize = cpu_common_realizefn;
+    dc->realize = cpu_exec_realize;
     dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
     rc->phases.exit = cpu_common_reset_exit;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index c34d9f15c7e..e164cef2036 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -63,7 +63,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *          host_cpu_realizefn()
      *          kvm_set_guest_phys_bits()
      *   check/update ucode_rev, phys_bits, guest_phys_bits, mwait
-     *   cpu_common_realizefn() (via xcc->parent_realize)
+     *   cpu_exec_realize() (via xcc->parent_realize)
      */
     if (xcc->max_features) {
         if (enable_cpu_pm) {
-- 
2.53.0


