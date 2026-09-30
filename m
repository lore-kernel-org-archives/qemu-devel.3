Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C0DCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByRM-0001Pd-Tt; Wed, 30 Sep 2026 13:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRL-0001PH-2d
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:49:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRJ-0001IS-MP
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:49:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHelgD3463970
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X8K/gkHcr8Z+4uB9LSTsZhx+DdfNVx9hCiBCP7+bDiA=; b=RP2Ri7INKN41+xPY
 qcBxN0+g1zv/kcWJjCFc3ObRBt/u6AwllwmC+z+uwGfVQnLoA1UWCMWh9z9tss7t
 fpoUaleErr4ZX8wYgfM8LhdGb+jpbIV9AiNLYbYcFifP9mh41H90vXqr0j/qJbvE
 BvjZHJtJESmHWKmCXo33TS5oTtg5FDFG9i2Fsd6SnJMyrdmCQ+2+yRvBoZSCtpez
 yX13c74ayJFMGr3LFKcSj4Tt0yBRLLX4SpzsIoPQSpwO0a0eppTYeJkr7PnmOp4K
 wET+ct1JViKnaSlbp7MNM2m7hSm4WhXXUpHA+/vT3TEFoUaQMRKPf2RVuJX9eM4k
 q+HuEQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcr2pd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:49:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so872909585a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790596; x=1791395396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X8K/gkHcr8Z+4uB9LSTsZhx+DdfNVx9hCiBCP7+bDiA=;
 b=PR/A7NsafS0J5hNUpAVv9NVM8oI0fdd8Q7oJDbbipTAwZ/vwJSGiPtpKJJvYoHV2o0
 3shwz9jy91vq56LmiHya+kLQzFeJem/vIZ2dna9hHJr2RbHeuE5+bbRu4jV9HcR2Hy/W
 iFlvTdGqYK53J5N90P0fLwXBypeAWtSongPm9gWhQ+xr8f/exo9e3E6SgqC05TTq5ddB
 HCqlZsC8DozAB1A+pd4+uC5Zudn5xE2RJhTnA2TjQToDuimYV7wo4ynZCO5YmLUw/IbC
 aucHLlo4htKccZwrvm9maxDftW9D024mZO7SlDfLXKIWikYRMAlbpcIHXi4oMh5+r+xA
 +7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790596; x=1791395396;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X8K/gkHcr8Z+4uB9LSTsZhx+DdfNVx9hCiBCP7+bDiA=;
 b=F12eyY0n9ZvswKCKpBJd2w8Cmv6N3W7e+Mo/o7ZWQ2OHBa+B+iJCcuVADCikFZDzUK
 jF9/YyfbXITKm3nebsqxf7wQ6Aai7Yk4j1vDb2n4HoLWAMTkSzv+eAYxDAWCcuqiQ3k8
 2l84IxGoiB319sIMrcOJoxj7PveTaA3xgK31YIMyBCKvV5wJUMBekhHT54yoEKK+ByJf
 3AqFjsj6I2eb7lnouyhfaKjPNfsR+F0Hf/g6TEtIchzjuQV0dKDbg0byJO2VHCRD0G+E
 9IYjrfp6gxXhP6J/QBlolT5vKpoYCpN/vSh018kwXxV5T/h2AjMXDq71RLVKMYEVontu
 rONQ==
X-Gm-Message-State: AFuF++ldJGwOgDlnD8WGu+27aVl0MC0fk+Bcpu4mYe2GV1bGapE+yE5t
 mAY1TXwPJzPwHpZ3PnDMz593Hdr09rm54aLOCU9p3Y0RRExy2feMC9iCsh0EebdFQSkYCaYFTMC
 dQTy/nEMAk6ut2m4RD9CMHC67H3JZc1AqacKw2S4HAezNBsnlg7UMLof8Fx9wKFjMyw==
X-Gm-Gg: AYBFou1vk/0Snvk7IC7SqGr/EM6713Bw94Rq8FDLlxwUr/Ntj1+eRWjtjVLGf6h2mYv
 gWslZAn5uO3DXJiPEYry3Mqqfn8jznACdbFoiPZfCu0i6rZ6bN9qzjW0wgcI3w2u+G7RjeVHLlO
 cgnbCteSwbdrb4kVQFCC4ykGXYxCRnDcMIDoVckN240zLuLW7nXEpI3xbLfu1/qvkE3Y+T2o75h
 l7jfZ8Sy6+ZeZlhT48WyJ2CaLWZawsERxW+IqfU2FNLh0ZyQcJ786ErjYKh/t0PtqEELQiuudnr
 lm+wF0FOpVBJ5JMJZ+9bsJQMC/EqK0F/aUb49/UCnr5sOAsJ7h8PsL2gR7nqn7C2lbbcQJqXUYb
 ysexa2nyoIb9SRn6Usd829BGAvqmiK0ePE8YLhkLJ
X-Received: by 2002:a05:620a:4890:b0:93b:d79a:c469 with SMTP id
 af79cd13be357-93cac26261fmr353386685a.65.1790790595841; 
 Wed, 30 Sep 2026 10:49:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4890:b0:93b:d79a:c469 with SMTP id
 af79cd13be357-93cac26261fmr353380385a.65.1790790595307; 
 Wed, 30 Sep 2026 10:49:55 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0692b1c9sm632828f8f.27.2026.09.30.10.49.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:49:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 1/9] accel/tcg: Refactor poll-while-halted flow in
 cpu_exec()
Date: Wed, 30 Sep 2026 19:49:37 +0200
Message-ID: <20260930174946.82195-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX+kZk/5/R0cDm
 bjMxVxmol0kEjl51LI8UZjUq6KgaSUqbYlT8jmAy2EGp430oF1kCNG0LCalWnzHFNcc1QfYZk8/
 I0oVPOdkI02fOHapYTRqG+5z7yEEECpoEmoOmGlMGAbCKS1gBIANUCDTbM05rhp08Ce5guzJkXG
 K9cWo0pU+zEI77yGNIvpB6rmp3QFnBRIBZOSvMqfhL4Scrm6uoAiQTZXO8Nlng8w2X0WODCPMCn
 Smwx683mNgeoccum3iO5/xs/rbvmRKqt6mtRgPSgPPqql1QH/gu5qWgRE5sRikVrsvrIRRhqBo8
 b210vXizmmYwW+3xmmb28Ec7KIP5BwaA90vIlHdiL8XXXlLSUczWh0lDSkuq6eyL11mn7VID0vR
 wNuiK3LvtcKSIQpgrK3qHIQ6f1CQbEtQMmd/cjIOVWWGcJiKOWbjFcICjJmIofKT+EDhY7QvL0T
 2x4pCPNCByJONeXR86w==
X-Proofpoint-GUID: Ob7ApfpwjXzyENaYhScTGH1SDK-ZDIIG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfXwLmpnjtAKArq
 H+a85jKhCFQuGdiuKPAbbsJx5HR9kQCA1fkTPCIqLQFuiDFrbZcwkS+k/Mv4PFCsYzrci+ejdfb
 I7NblQAcql5qPqqg1uoOrIIHPOVPq3E=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abd4bc4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xF3Xt6V14tk6trZ56bgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Ob7ApfpwjXzyENaYhScTGH1SDK-ZDIIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Invert cpu_handle_halt()'s logic to read in cpu_exec()
as "if halted, poll for async events and find work; if
no work, return". Rename as cpu_poll_while_halted().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5b4bca5084f..853c4b2f67a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -656,18 +656,18 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 }
 
 #ifndef CONFIG_USER_ONLY
-static inline bool cpu_handle_halt(CPUState *cpu)
+static bool cpu_poll_while_halted(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
     if (!leave_halt) {
-        return true;
+        return false;
     }
 
     cpu->halted = 0; /* allow execution */
 
-    return false;
+    return true;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -1029,7 +1029,7 @@ int cpu_exec(CPUState *cpu)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
-        if (cpu_handle_halt(cpu)) {
+        if (!cpu_poll_while_halted(cpu)) {
             return EXCP_HALTED;
         }
         assert(!cpu->halted);
-- 
2.55.0


