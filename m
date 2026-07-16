Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF4DC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLKO-0003Kp-Ir; Thu, 16 Jul 2026 08:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKM-0003Jv-Ew
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKK-00078w-Uw
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBisWX2730823
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FNFsdtnL58j
 EJT/xn7xwIBtZivm2KGli4fv3zj95Ick=; b=A3LiGf5awyKJRYwQCpcC8nbT47P
 nh318CAl8kA1N7kC+AQv9BxZzxIvS6nr4GaGSh8dvSSPawcspt9XR+I6G/VPE352
 ce1XUw2TEvz6cWCW/nAfofRQHBE7hkbirYziKdCcOC3mrJ2HQkq29PfyiP5mwz7b
 UTt2d1BY3wUVqD/YJDWvs08qhNKUz/GOck157n4QCtxaJg01ncACaEnv6HMxLhzt
 +8hK3HVYq7mlYWTXwfYeeUIu+l9P0TfTvu3z4GWPujidnLRKPyxpd61+W3c1cb7f
 +0480t526Q2avuN/zF3XeG7AUUwm6HF3pnE3ysEoLvvVOqaxJR75yhN2dgA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4waduk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f18c4d1f82so132866956d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205380; x=1784810180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FNFsdtnL58jEJT/xn7xwIBtZivm2KGli4fv3zj95Ick=;
 b=JU3dJfGmfj5GvBZgDH/7VDp2avzoFPtdmVIsy8qZj/X1BaCT5qsCW19TsQaz3rJ+TB
 Y8u9KYZrS7otUm7i6gRrCuEVKtunu3mvc3+WkzWd0tnJ3zRpPPgjqAxxde3iwZuHX7Bp
 ykgC2x6qmIq7pzDI/2wl0fnjxMvBAnk5jWiznpOVaXejFUi1BzrJtyPptPPmLp6qBswb
 UEdm5+o2M+XXJvMMWgvL5PITTaABrRbXmTwNLzFMArZteOkov6hR0Yx5DMvo5xdJJhYC
 jcUkcUeu8rAGoGZngsaJ2Din8LQtLTb3qNtp5/iSrRZWgoEk8/+BwQ/ZoQ8sdTyHNTz/
 N5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205380; x=1784810180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FNFsdtnL58jEJT/xn7xwIBtZivm2KGli4fv3zj95Ick=;
 b=TD/3U9vF0njC/kSrpNYqsKOWQtFdfi0gpbufF6yjRu/+LeiHL600ewegYVAlJ3pP2k
 yBfQfMqv6mUhnRKb1EoeOPvPr/BxMxqfz0Ptnwqwzi6GSbdONiwjy42PBfFXucat+b7m
 HWHXsb+NR3D/HyfBjuB0lk7fr7aONc7BbCNM5Pm77DZbi0l+6Vhf20qyt/GSOF/Gw9J+
 U8J+9mpCGupQOBhaciC5PS/JxpyQSPuYFF8P/gJTg0PiA1nhrn5daVyUmKUQXdB5A4ew
 uGNvdCxZGMWMrEsG6CiKDhztK1fk6ttUkTcMAc2F1snc4h+pfloIgAOQ4MIAJhVmkCdQ
 SGAQ==
X-Gm-Message-State: AOJu0YwouZn/FFd44aYQ7NOhtzO5nCDM1cc6cPyfa5r4zafy+cF5x5ZL
 jNIeGmg1oYdRYakfn+Au3fkqc/9Cl3NtLj1Q2lnwIh5Q7wDw00JDh2cyG33WmvdYdsgIEqaFx4A
 CHgAlgaAGIeQm2OdeKA5IpTX2icpKp+H+ttTdAy9j/ytbGkWxHt8gqBHC/AljOIahSQ==
X-Gm-Gg: AfdE7cmZrExQZGVYNAWmWoz2p1+HJPQ4YQxjHORfGTS2XiFlTi9H/bpAv88Ano/6j9L
 pIwi1lzsP8St4BINC9K3LdlmkQSFLXO873SWhwVdwmji47fC350dYSJFk1R17RH/QRnlJHoD2h2
 pLtPM/hu2V0HPG/50+VxOYOEltCwx5NhBA0l5+YgUrx3GSiooMTz/Elh776lk2Q4CqDtVJA/ZRV
 j/251C81xy1u81YohFiRCdofVHE9WqXm40LQqd16OhE4KyzqBBPO4T4PEvEiUGAlcFB5LB0IyZM
 f7519KRrZ6jDDNk496Ap8z9ojnZQhkZHjLaF3qjdoKJILgPQuRpZb9uFH15qmMbzloAbCjVY2Ed
 DyvlHwqouwW7pKbg7KX2htry5lazannOT0QI=
X-Received: by 2002:a05:6214:2e48:b0:8f4:6ffb:cb78 with SMTP id
 6a1803df08f44-90758d0d39fmr73989016d6.22.1784205379669; 
 Thu, 16 Jul 2026 05:36:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2e48:b0:8f4:6ffb:cb78 with SMTP id
 6a1803df08f44-90758d0d39fmr73988426d6.22.1784205379018; 
 Thu, 16 Jul 2026 05:36:19 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:18 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 14/17] target/riscv/debug: Insert breakpoints after
 migration
Date: Thu, 16 Jul 2026 09:35:31 -0300
Message-ID: <20260716123535.3709148-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a58d044 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=N90MVQWl6141f43dwBUA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: I9YBxIzH5o1oLDnxY8SLiyFKlcIpaK0P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXxaMg1mz+yeVX
 /oXG+cJDGUOYCDMo9rlUflsix4cOkTmOJCL/AHqG1u9hIXRDSq+qXDNG+5bHaVY5Q7GAlwJcR5x
 CFAApdYdbP5IDYZt2yKxdS40KmclkP0=
X-Proofpoint-ORIG-GUID: I9YBxIzH5o1oLDnxY8SLiyFKlcIpaK0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXz0S1oKctX/gk
 8nwGj/cWEYisRU8DgI1j07EORfLMODVirAOrfsBUsQ1wOaL6FGr6O2SqWxliNbyF7l2IJmK1kiW
 k0Kye4yA6m5wSLpunpsunhCflM/zwCRK+LoNg8nMvBKBLpJJuOGwjrzoDcHmthHlUUnbLbFOR3T
 tDej5arWJq0jSdgjiSNvwdyTP9NuZocWLp6N8Sd4slb+TJ/CfM9q1Mrl+DF877ENHNOcfP3o+e3
 m21jYRWFE4ND0VGTa7Wgp6fr/8CVHtMDxCfIgjKshggGlnT0/PArarfsFoPJyabFlWuWY+5bhQZ
 hNYzY0g/Ya6ViLkeu4TflkLOVAGkLg8TwlylwxsEmJSTFaLzo1ek5F4HyRksjCu4ICWCS8NHSgW
 8+r/w7mH6aY2GuisV2q3uhvaLHRMdzqoaHTmNMDGF8kIM/h9SSmXH0SvkFIm0xYo53x/vlnKb5a
 1Eywi73E0L3hw/DD0aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

After migration, TCG breakpoints should be re-established based
on debug register state.

icount trigger timer in the icount_enabled() path is also missing,
but that path will be removed subsequently so don't bother to fix
it.

Fixes: 577f028694 ("target/riscv: Add itrigger_enabled field to CPURISCVState")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 56f9ceb042..09d4cc03f9 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1157,6 +1157,20 @@ void riscv_cpu_debug_change_priv(CPURISCVState *env)
 
 void riscv_cpu_debug_post_load(CPURISCVState *env)
 {
+    for (int i = 0; i < env->num_triggers; i++) {
+        int trigger_type = get_trigger_type(env, i);
+
+        switch (trigger_type) {
+        case TRIGGER_TYPE_AD_MATCH:
+            type2_breakpoint_insert(env, i);
+            break;
+        case TRIGGER_TYPE_AD_MATCH6:
+            type6_breakpoint_insert(env, i);
+            break;
+        default:
+            break;
+        }
+    }
     if (!icount_enabled()) {
         env->itrigger_enabled = riscv_itrigger_enabled(env);
     }
-- 
2.43.0


