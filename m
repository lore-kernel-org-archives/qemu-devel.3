Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48279C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QWH-00046z-3B; Wed, 23 Sep 2026 13:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWD-00041x-57
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:12:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWA-00017W-9E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:12:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGUFhl3281277
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NVL8DScROpX5FRrNBTXD1YKsAIvozSDWDpA2JU39ztQ=; b=KqsIMxWsjMjCPuvQ
 s/Ey/C5w8+Y6MuAzSR83k3HYC2CmEVIkUT+dBFOTLlBNoKBSldRwWw+UUVvXsCZ8
 Ec/77yhf5bEfd131oKax8SulKDDYvUjp6V4p9SOmMJj7SlCneigjkGOJjjCKmCG+
 WUFtgqM4pLBL8GKvQllkQijfgt9OcSM0gy4XCL1ug6wws4Qf7a4AW7u4bZqLm1xV
 upqeul1sNyYYtCQ8ERBu0clBGx6GfN6Iq4lvKTXihWVK+tGxmSAM0NhebJU7yfVw
 WOj3FZVT8sngaPNnRjSgqJQLJeqIbrMbnqEOZ+oPEWChVbihBMymF/wkKjwaRnT8
 IrxSzw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqju7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:12:12 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78a5a291af3so1073393137.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183532; x=1790788332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NVL8DScROpX5FRrNBTXD1YKsAIvozSDWDpA2JU39ztQ=;
 b=gVhzWYFkiyYiWpGWYHL+rKaq+/tc2d0otEFD4R9WP99mjNRKO0c6JzzIYmvVAqrKc8
 BCecmUr5rMiCv8/F/m2ivgoP8qi6KPtpVKMOandaY+lnQWUrzv0wn5cK5mGP9jZR3AhF
 nnA+nvgUK5cDgveT6cZGaGrmONrpfK4N6A0JgrAspncmHCuJ+dW6fGy413Q93Kcj3wtE
 PH2CJXKeEuy6o0EWChwYwyl1ZPWlPm6YTNwsQPbJw8TCVSDtXx/2V455XG+w/ObI+Scl
 zUjHdO56Tslxy5JM8IVcHO0TcT+aXSr4DM0Y0DmJdD501mw8xwtvg2MjaPJurH8w10To
 oLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183532; x=1790788332;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NVL8DScROpX5FRrNBTXD1YKsAIvozSDWDpA2JU39ztQ=;
 b=EDwJ5DZiPB4VYXm8H47Bw6n4yia38Knyolcko5rmXIdwKmeQl1WJ8RZC3fkCskA+vs
 6oe0BgWAPu39MPYiVPCGfzMcYKgu+W7GN+eYcW7rRjc9hUMmwX2PgnsyRUSPxkT75YLO
 5QOqrn0L1R6PKeeW3Q087TycIPWWxMbreEwPWJtWY52XyWLMPmG55+n2M/HPTiAZVhD4
 /uIfaEh7fKsa+KfHgRoMdPlG4GMiNbyOxsu14IoAopTUTvj4Wpu0P12mg9LkXPKFA8/F
 GZ7bUC/FW7Isu9gFto19iqChnG5mvyLKXw5Pq9DtDb3wzNO9WmaDSowk/zI1a2Ot+QGq
 x0tg==
X-Gm-Message-State: AFuF++m/0E/cRaSwm8mCyFIl0zchK5Zz7Z6vp97c5nuDRUKEQNBa50H8
 igRfofExlqnyRZwzvywne+h4LkyQxdniSeXwWKsCZGj52W+1b21bsKZdk6y9uFBKHNVP919IJR5
 YBoT49x5Bu4lP/j0YNHBLIJxjufhRa6EY3O2aegxpgcGgbrhaXvXqCJuow9GoreDrlsFv
X-Gm-Gg: AYBFou32+kLrv3h0C2Ps7cKT/8d+stEWw4qL7MpQTvULUovPm+IuUD0p/P93Fw1sDGN
 nFYpBCf9pg784zmWjPM5SiCgGrxb7hI1LDu29j3EsmcpgCIs4i/fFiI3RNfor7dOi+wm0C+16TH
 fUHl9JWmKrzT3WpxUWQPOJjrmhG3gQ08+A38pqlRG+5byFtkIRe7cfGVQ8yXe5yH7HqF0w65Y+I
 oagWZj5czAYGjqYcbuDSegGK9J3tARIkoEMADYt1m1V9twMJsyI82GA+tWx8laWS29JsnMAhInw
 3iJUdubHmiRj6tRKUuH/1fkjv6+GQ4imhWh5H5X9FN7d5WaPkjW6Cor8JON2tsTmliko5OnRvOM
 2JGujSFObflVvkFHvYZdq3Au3+u7Yr+dKmlO8ula7plKkrkNMWbk=
X-Received: by 2002:a05:6102:2c0f:b0:7a8:1837:9eb9 with SMTP id
 ada2fe7eead31-7ac1dc3d3d4mr3241038137.27.1790183531857; 
 Wed, 23 Sep 2026 10:12:11 -0700 (PDT)
X-Received: by 2002:a05:6102:2c0f:b0:7a8:1837:9eb9 with SMTP id
 ada2fe7eead31-7ac1dc3d3d4mr3241020137.27.1790183531501; 
 Wed, 23 Sep 2026 10:12:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5b9f253sm925835e9.1.2026.09.23.10.12.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:12:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 07/21] target/arm: Kick vCPU after updating PSCI power state
Date: Wed, 23 Sep 2026 19:11:01 +0200
Message-ID: <20260923171116.31276-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: k17U4FW2vegLg-HjqBkSRTU_cYPVAjVS
X-Proofpoint-ORIG-GUID: k17U4FW2vegLg-HjqBkSRTU_cYPVAjVS
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab4086c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ZUU6x_L2PbSNHYkWwXMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX7E13lhTgEBjg
 GdSamxQo3HsdN65asNfwaMNSDKtkEqD7RsEdPEMcuBMPQrMyrVkDDQS9UVOez3zhcIiw+XNWkHO
 m1BokBzFVEz7wGE91dqHHmkGveO59JQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX60r1Uv4Fi/Cw
 hWLyiuuzeLuOfMmpXTdzxYnKtiHTx4vHgxZrD3FylnNrmDehzvLV+/06MrruGn9p8JYFUYkTF6P
 LfJkJfOC0Y0Qfat900fp/bPEWijzgypjssu87wlvfvn28mAdiVmsYzV+q/6+gAhCEhhDCM8bzr4
 y3ngjuZ7Tu6kZEkjwGIL10h6vdZAS0rgtkBE6dkvEDTWHAl91OAgIPFrgzL79TWqfLAcQFsZyLf
 1F2p7Oqvuu9vpVIt2eUvZKvGpQFmH/2zJ5ihZTm7+eUBQVuDJG5LQE9LjExtB7D3UtRYxDwHi5n
 6aB5DizSEmdL3y/Zox0FeXGtcLZMdKyLI2fHf7L19Kg4N+gloBxGmsedofQ31um9wECwcK5zNI2
 UnoDGkpnznqlh01egbLqjii0ZHhXb4D0LM2M+6aV2MOXgP5CgmiQ0Kz3WUCvMpAR7AN5UmASMKN
 jIa8g+/doQGKrmJXNdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

PSCI can update the power state of a vCPU other than the caller.
Kick that vCPU after changing its state so it observes the update
promptly.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/arm-powerctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 213e7ae056c..1bd8a549cc9 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -48,9 +48,14 @@ struct CpuOnInfo {
 void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
 {
     CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
 
     cpu->power_state = state;
     env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
+
+    if (!qemu_cpu_is_self(cs)) {
+        qemu_cpu_kick(cs);
+    }
 }
 
 static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
-- 
2.53.0


