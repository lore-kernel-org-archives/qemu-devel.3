Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1615CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEazW-0007g7-5G; Wed, 07 Oct 2026 19:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazU-0007e1-Iy
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazT-0001Np-26
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LuZBp945436
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v6WxGlXAGOXViamIERqIusclJ3BNcUYXt+pmadRs3hA=; b=BC3qPRX1Nch7pWGu
 3XNQQlEJw3eksF/t+cOPu/kqMthUL5xsWP7NEPnhwmVRjVBPJV2wiQkVf/UOnG5E
 W0MIdiUNGEfe3HyRiCuhnHW7z/1jl+Q+CalKGqw+qBdEofrOGlbbUjCmqqwOKhrv
 Gwgh4bLdhYzZuZynudcTzPXV/XMviZhyiFD0kEAGAj+EYh0oxcSFM9AGqxQlYamS
 tK/QgKNx4UZMprYu30DB1XtS3LhT7wNrTmLEYGSz1E3IxDL47dAo4HwF4Ke3ioDW
 me8S82tJ/AcRtlCgb9Nq7qIvIopsn3xTYork/QhiCzzheOraxNvuXkl6zeatPzhP
 yjC/Lw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2rc9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:24:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf7856ffso837719485a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415441; x=1792020241; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v6WxGlXAGOXViamIERqIusclJ3BNcUYXt+pmadRs3hA=;
 b=MSaLJCgqNxAaerwHa5XtkimCzo3xy8CjVGTRvvURqR7d4OIOZSiWVBzLwY3d+zYIis
 +sqTy4ooY/VcXNqpZ6zcDKwmqVCabW62+h+5BRbFoJOKJjzjnubMqucs8SEc8VF7LETV
 YnquZcluRsjvJ+YSF6sqJM2z2D1dvhu7CDPoUcvAEdWO0Z07Cw/dAUnxuY8bnTvlSHuZ
 X52uchJZ8JGjsEatwE9A3NGoT7bVS34KcjJSrOUwdj94ULDCM2hBYIsYX6On3WjqLOjL
 ITVUfKzfjqf72sKTWqP/Cv1kcg0germKsMA5Fx+pRGpGHmM2ucSfW0KTYlczP7RDVZj7
 oWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415441; x=1792020241;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v6WxGlXAGOXViamIERqIusclJ3BNcUYXt+pmadRs3hA=;
 b=FOson0L18TKlVorqrKWbxNZaFuTZRoUcaz+D35SvF++oe/SIJZgFjqetJ53r2PQkjz
 krOY3IWh+cFsi1Mxvp11/ij84JnIFPjViFwOd1VLHvrFLYHK157ISIWv+31TV48N3sQx
 lLRPXKzSIUUR+PIM9SM2aw3NnDto+Y8iKEfURdpblBKyrhvk7QaA4/4cUICT3QfoDyOU
 rNjlaFQ7gCm1H5UrKb0a0bYqSGWn+26JRH/2wZDGMskjTMw1ehQC1hach/14GdzoGqrw
 5P66LL9c8Kg7+AorO9Q33aQc2xrRbtkDmY7EDjSzwV14ZhGVHa+CtJjUPgFTCv2t8Kra
 EhQw==
X-Gm-Message-State: AFuF++m6CQ8aTnA530lAboIjykRHu1iLKZfyPsWB4HWZRR8w82Edn5nS
 O+I0j/IX72UqCa/bWo8BuiKCxwc1wb4H995She/FqZYuvfQi4nTayHs/B8h8I/4k/ZiR5G7wb5D
 WuKStE6kVhQ8rLAvt74VXzNsGpnvqCKBNrkD6u5mIkCvuuvgqhSfb/CAhMLYMM5axXz5Y
X-Gm-Gg: AYBFou0neGwwK2IUktUhrzvS33SSvCCn2NGV9yK5eCWJHevjJOKyHvk9Yl5Mgbet3nT
 o77I57lzdAlJ8d8jtr4p+jV1bxXevzzJNo+g7SNg6XREP1fMc4Jc0Fg4PM4yGU7O55ZeiGyHgpz
 GXb7Qcj798p4E3L+b9cvOXn8k1FMiNBINj8FuJZm+kLQPJYNqUV+wTQBsQXRF203Ursn67JlRv7
 +qaRbhxkdT/RNCwFQ8Tqfmh9QExPlx5QXPlcgic8UvedgALKQZ3LHNvwhVhpcY0ZjcWb1ayyDuv
 V1tvVKvDD57JPEbThtO+CJ3Yd32Eee4Bev29Eg7yNxUjSCAEu6272OemOGnWWzKRI95x1fCAvvE
 wOOdWQu6HVfsTKjQrqUb2KcfkAAXvCbmGj/zfBRzA
X-Received: by 2002:a05:620a:2943:b0:93e:5247:f61e with SMTP id
 af79cd13be357-93e9b77655emr789312985a.25.1791415441344; 
 Wed, 07 Oct 2026 16:24:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2943:b0:93e:5247:f61e with SMTP id
 af79cd13be357-93e9b77655emr789308285a.25.1791415440836; 
 Wed, 07 Oct 2026 16:24:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c75b53fb7sm4870712f8f.58.2026.10.07.16.23.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:24:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 04/10] target/ppc: Factor ppc_env_is_64bit() out
Date: Thu,  8 Oct 2026 01:23:19 +0200
Message-ID: <20261007232326.66240-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac6d491 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ykyb-77VhxOW5aOtIs4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 6vYWATCqjMJV8RxV-6eYTVC_MmYUoKsO
X-Proofpoint-ORIG-GUID: 6vYWATCqjMJV8RxV-6eYTVC_MmYUoKsO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX1u+8lAMoywIa
 prRRR1k9YXM50lGcxj3VMCnV/EaLH+P938ZbWW495Yuy4KS1RroxNlkqR8k8bV17O7UnyGmueNb
 5ON1ukBBFwZMMGfa/d1FgNE05ET40ZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfXx9yv8xZELetz
 0Ck79U8vai0cvI2NzuNrqIZsTDfpfr7PYL4I8qmgJ3yYdJyZ+D3LT9TuaW8jleEtt6hnJU5J2wD
 hxtpaqP0CM1ql4DMBarCQB3hQ3HjpCZUgtKkcPgR9uYa0YCOcSsSLKBcXawTWXCPwVTlC8XRTLR
 HKXS2wN/Nzd0fXuKlKD3W69OtZExiqKILCQcS031HkelvDkMheujJC37vRi4+E516V2qgKD4Pz1
 Esltt6AjPgGa/t51gi4wHQBnu7j58eEK+GK76S7wcMNO4BcVgfSaolMYHwqZYsv8rbEl2S4gGxR
 oBPbUrP229pXyxFMwdOS+X+s9EYgKpBvxqCgUO7YC1RBJuYVZGlIL1TlrXR1lcZbMtl1R8qRF6c
 uo51oJzaB6uqAB5wusAjx+lv9VlaMDSKYGk6cIgZaKl/ghWd6lOWUcB8Osgmpe5qVbJC/eJ42Rv
 ubBY7hqHr23Ay2v4LdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Replace the open-coded PPC_64B test in register_BookE206_sprs()
by a ppc_env_is_64bit() helper for re-use in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/ppc/internal.h | 11 +++++++++++
 target/ppc/cpu_init.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a20a0f9f7e0..11476692616 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -23,6 +23,17 @@
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
 
+/**
+ * ppc_env_is_64bit:
+ * @env: the cpu context
+ *
+ * Return whether the CPU is a 64-bit implementation.
+ */
+static inline bool ppc_env_is_64bit(const CPUPPCState *env)
+{
+    return env->insns_flags & PPC_64B;
+}
+
 static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
 {
     return FIELD_EX64(env->msr, MSR, LE);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b711f9c0a85..a43ef47acd2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -869,7 +869,7 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
             spr_register(env, mas_sprn[i], mas_names[i],
                          SPR_NOACCESS, SPR_NOACCESS,
                          &spr_read_generic,
-                         (i == 2 && (env->insns_flags & PPC_64B))
+                         (i == 2 && ppc_env_is_64bit(env))
                          ? &spr_write_generic : &spr_write_generic32,
                          0x00000000);
         }
-- 
2.55.0


