Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF0AC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhkS-0000Yd-Kd; Wed, 19 Aug 2026 10:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjr-0008RM-N4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:58:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjq-0000bc-4z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbvYT135640
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5eZLFQazAYOlyhiQQKdSZi0/McKosAMWnrZPE0PQkkY=; b=EnvpZgT8SwdsK2w9
 B5WW7HHmuX5O86swJSxUr/7yVuq2ldtaqYdOX1T71txEZ091ITd+yNZ4JoVEkzKb
 LCdQ1kf3QsxM0avrrClDjAMDTDTdHpTzdqLv52hvJdBhJdbrqYxZq3mGE82xBUe9
 Icp84DDLcrjcTC+mHjgBgVEWue2x37jSGkWuoe/vh8XOT84spUkVtA3+V80jvfFy
 zoLXk7z7kC7fN8/GNA1GHO4SDTSHvOWWmaggJmNaifFb5RvFL2sFg4DbGCJ9Dfhf
 jH0RdTkRjryVjcT4SKJOjx7nABxNPBLyv8PpLrC5IE8ewSFlJTIOnxWK7koV46AV
 txVkGg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmbt2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-933023a5980so182854385a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151476; x=1787756276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5eZLFQazAYOlyhiQQKdSZi0/McKosAMWnrZPE0PQkkY=;
 b=C3tOJUhJy7WYR7Ex2KEsg2fgFIhZAVPTAIMfXn49y51RM7ph+gALWc6niGENoSpCdk
 +ZDq2ILYGwOyAnKGjNidNQ2SZWH68oOmUxrHyaHAugPOS9CVsIxJn4dsxShQO6cNpzXr
 XztwEgNaJbFLaFImIxKTPYdJGt8PURxOlJsSHf8XfsUFeTCC1t/0Va2Use9rPzs8EMnL
 Eoe5sN+zeRiw5z0V8w5qbrmz+mxK0RaOcBqjBRfKmpG+Ld3cG7dq+TWHR3ZNOkEhSxqx
 Jz1Vr0qGOFjh8tbAmK+mWk8WmwanRcGWGuaxRctMNruUXLbNStM9J46IDJ7UW+CM5xPY
 8W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151476; x=1787756276;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5eZLFQazAYOlyhiQQKdSZi0/McKosAMWnrZPE0PQkkY=;
 b=jD0LqD09hXrHMInW+irNvdF76I7dR4FZRta635q2KFgyIFyiH+tytGBJyS7ZJq69F5
 04qCQu+cvuVcjnvOYcpVIMp5+cNRbRUNwu9nNiNxd61/uOl0xiIfSpXDb5H/Sk74JROW
 72DwRNclW01hE113rHNqqSbgt0iRPRlDYpQeHjMk1a6NPvWBPcPNiUPXqGaYqaIi376X
 GyWZOjjdabA29gUf0jUeZs0HBfJbxkJm1mcrUg+z98Ba7oF6PqC8IiT+ZvaX/Jp5gUvi
 8ComQnyWWrv6K7l7mOkp+6jRHsBH2gwjx/ncAguFIAOg9MWTNiHcYeTgb5bL2wD8alR+
 kpNg==
X-Gm-Message-State: AOJu0YzBAPALHtjfANDJ2KMDnqoutomjSh3OnJWbirjdcpWE1m6en8Mc
 JlfYUNvz6P9657XFlrfWzT2ZB/c+KMmI+ZVmrS1IhMcK1pxwneDOGsPMrQYbO6ElS7zil23+wbf
 5gHqHMT7fernGOLDuXYF1RMGDsCmOMUMw0/7vDEYEl2ccf/BqnJIm1Mt+cu9ToELGbU6i
X-Gm-Gg: AR+sD127LwoasEYAvb6ucX5RwDLJaGtDoZBJ0J5Z9P/WAl951WgQ0eHHssRZFWO/7A1
 2je0J38CaT/8RwFBgvBEi5diy07JWBfkwRfbEAuWWXSq220XtYJDfxIW0AzrEJS2DO2vqRejQBw
 s8dyZlpAsSioepOvVJBh7P5ofD3SrAx9GceEiN7uWMSLDwTRdVB9g6i+7fO4pZ01FUFeQnUOmtx
 47hbJa06zaj+Jb9P2Lf8hVosP1PsWCt2K5uFpwDXa/f5ob3K10JK/48reYp4LPEY2TQTd/czzUd
 HcJMwwGx6kAvfTAiFC0uwdqU84B1cjQqVWHdu+2eKJuT+Ews4kx+cNfqk/zs6Ek4aWTDyE9QVH3
 1zNdz4+/syf+0BW7KTP9ULariFhS3K3s51+S33hCQdA==
X-Received: by 2002:a05:620a:710b:b0:92e:45e4:c6e with SMTP id
 af79cd13be357-9371e2cee33mr485530285a.22.1787151475619; 
 Wed, 19 Aug 2026 07:57:55 -0700 (PDT)
X-Received: by 2002:a05:620a:710b:b0:92e:45e4:c6e with SMTP id
 af79cd13be357-9371e2cee33mr485526585a.22.1787151475174; 
 Wed, 19 Aug 2026 07:57:55 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa175d0fsm66958315e9.9.2026.08.19.07.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:57:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 09/11] target/i386: Extract halt-to-exec transition out of
 x86_cpu_exec_halt()
Date: Wed, 19 Aug 2026 16:56:47 +0200
Message-ID: <20260819145649.23439-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX9tE9oSwgKi6U
 RyqbGL2oKod0k6d6R4cz5cQmcPElDPdCOR7d2/tf+cAX1ClCp7bFEPjj3jzCKqotA1M/9ZIrxZa
 vaLdmzmMDNtSvFyZmUeVz5QENV4LE0HP5Bf73js5XnF2CsYeXvS1F8vJLV/KhfXocHlTQWLEzY0
 KjnIXj6QX8MCvo+wZBOa4r5r1NsruAPZfSAky9hg+ek+ZAA4qwkX8X/s6PIBeMkAfdiMUicbr/I
 u0UpNbJb//aO4pWlDP0hdU8OwBepCYTCC+cDT8C3SrszmlVNYGYwhD/k3T8yNu4i/2joxdO2HCJ
 yUP0oEwAob9AntwvdbSvEzuCHnQaXsJSGvwv4kVVeNDyTZGJe+RaCWkkTO6tode8egvrq0S2GdO
 HiBkFweaILdtAofTJI2g32yNu4jm/zFs+IMmBL5O8xF92M/Nzd7k0Q2zB74Ro6dkjMKAmh81DSL
 Xi1c6jPR8jNz5bQeEyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXy2f0kt6HZZdh
 Yf27kSirZLWZnUKJE5ANNlTzrTdXghY83mws27VGPX9GD9QHwdvqVvUwoygFWC3TS5rf7OJiHZ6
 Je64k/ji4b+dB8u0e2K9w+o8cX963ws=
X-Proofpoint-GUID: 0H1NzIhRotdJz30rfxmXxv-5qztFUQJs
X-Proofpoint-ORIG-GUID: 0H1NzIhRotdJz30rfxmXxv-5qztFUQJs
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a85c474 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=D_czkL0mjgd1dNvRY3MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

Refactor the halt-to-execution target-specific transition logic
(setting trap flag in debug register and injecting debug exceptions)
into a separate x86_cpu_transition_halt_to_exec() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index cab197368b9..65819670493 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_process_async_events(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
+void x86_cpu_transition_halt_to_exec(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 4856a6b3bab..9b2adcca76c 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -140,22 +140,28 @@ void x86_cpu_process_async_events(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_transition_halt_to_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
+    CPUX86State *env = cpu_env(cpu);
 
-    x86_cpu_process_async_events(cpu);
-
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
+    assert(cpu_has_work(cpu));
 
     /* Complete HLT instruction.  */
     if (env->eflags & TF_MASK) {
         env->dr[6] |= DR6_BS;
         do_interrupt_all(x86_cpu, EXCP01_DB, 0, 0, env->eip, 0);
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
+    x86_cpu_transition_halt_to_exec(cpu);
+
     return true;
 }
 
-- 
2.53.0


