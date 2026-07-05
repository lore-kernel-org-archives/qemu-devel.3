Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB5C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUtK-0003b1-Ah; Sun, 05 Jul 2026 18:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtI-0003V5-1M
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtG-0000xF-G1
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:43 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665M0FWk2717895
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QV+aX9nOik2ueUL6+e2EZz4Xhxb9JObx3udYKE6I3oM=; b=TniCKdcl1NwcUACz
 s9GtwGOSQM2ez0MJ4PEZNoxLaz/6673uoYZY00Qf+Wop3ZWuHrJqECsQpDucU7iG
 OtW6f6mQ25lv2lPsEZkS/f8KqAGU0/FP5vrZrgYtH4c660t66BinET3VXAXq2Zpt
 UCC85gGU8UzQMOJ1jIvrykgclPMJ6bWxJZ5oNXjeYmqOX5GKNvnbDnQeyo8Q1qbG
 YxIThNNnfPfsCCvRe338m+G/eyvC/lK4g2ZdOqRYdrCvf+BrSatlGouCc+nZm3gE
 mHeyFALFxUGsY5v0YuGbzgpql20AY5U1LGjnl16IivpuUSXNJBznfVRJ2ojqjvQi
 OwVicw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txekdxp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:00:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e53b8a302so216704585a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288830; x=1783893630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QV+aX9nOik2ueUL6+e2EZz4Xhxb9JObx3udYKE6I3oM=;
 b=P/6+DgRp0ALB3T7uw3M4CXHNfaKqbJe7sVb6JpfKEq5L+oOtT6ZjM2TGIvCk2EKJsm
 zkOarZqFdM7vpmEUqrv5XtFYOfL/rkFjLnv8nkGv0Dofc6oGHIwgPx0K6YW0WVG81zg0
 tnhBw8ry+5ufUT+dZ3jLwpEX9t63tbJHEuj3XJrqk//jDw2pRGxrmOxOHOPEgbeBkiPL
 5bJT+0mlak5p/YtsqTKiEW8L42/QN6USMkUgIvWSs8/Fy78r3rDGMYSSnR//G6Iw5QbR
 0lpbUXteSl0MU4aazuuoBZ4BpDniGtuRiBXPBoBeCPZVDXroesqvPzRdcI+L2UyrTpMi
 9xZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288830; x=1783893630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QV+aX9nOik2ueUL6+e2EZz4Xhxb9JObx3udYKE6I3oM=;
 b=dapWSH8qimJbvMy6gjQDrf1BwTVCG8+UbEZBs3E0ZrwU6FBx+PsojHnm2/dOKX8rYH
 U1duaId2zULJtrFe1ZtHZJBAGX/XjxMJfxIrmdT4k+9rar/nK0HcklwQSsFO6SWxZrHH
 Qfip7chZFhnfTK7rifIQDbWBAx2PitqYZLy6zGs3MgJIwHVsdGDM7hLX07Fs5T1EY/Gc
 zN2JuEdynoRLvdJ4Jlqe2HtItTC/f/lBpdOogswXmIwnxcoScPxC7vMZ9OaxnAtvRjhc
 eOYOLmeIH7MHlU08SKtlSwnlaQj90Jw7kXYhTZdMiemgyOqDsk4xpjW7555We806uwrz
 Vx2g==
X-Gm-Message-State: AOJu0YyIBX/cmeudzZtRtNfOFPJlHN2qK7nnlrRmRVRJh6Z3Yr1Iq/Uv
 oFGcjNavM0C2CneKmzg/Xr6PiwS8gXSJn+T5Oxr44HGi1/010f3a4fosE2kNVHtkvhLz+bqofHV
 9OR5OAsPu7WsEGXNnBQRaksQt2UEmuKUQuzbUXGPjqs+ZLZUGriTBLjclLAnn/8mwWQ==
X-Gm-Gg: AfdE7clTYG1D61Rg97JifsGEC8s4b0w4W02qOg17MQ/Ui9QsC7Sl39wAWOZARVAMY4Q
 5tPKf55Ejr7QB2YWyqdirWUHaKBh9XwHyIVBYGnhxZBRA+r9w7vAIAvJp2+ivYCbwn232R32s6L
 e6WYXdEsyshodUxDRDtEfebqb2RU8Neh+GGEr5oZXQI/1PWzKZcT8rLpuuvX/KPgH0UXiwX+F60
 XKm16yjcr7zsxvsrPByydcFzFT/B5qC2V8AywL+j0oZSfIAaUWDi824q3CV/3w51pRdUUANZY/w
 bfNCBDxrP0CWjlPTXYwdx/LAyvUzjBBpvnTHZtfw4+U8aE9B64J+bZ3NHUp3HNHCDgQrGr7rY5t
 IzSZhd/0ahKqjNAHrS/1qIxuHb4eYGGWMnrM6VNHqjv9uSpW6jY6tzg==
X-Received: by 2002:a05:620a:ac07:b0:92e:9c65:da7b with SMTP id
 af79cd13be357-92e9c65dd4amr796013185a.45.1783288829710; 
 Sun, 05 Jul 2026 15:00:29 -0700 (PDT)
X-Received: by 2002:a05:620a:ac07:b0:92e:9c65:da7b with SMTP id
 af79cd13be357-92e9c65dd4amr796004885a.45.1783288829113; 
 Sun, 05 Jul 2026 15:00:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm19497610f8f.37.2026.07.05.15.00.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:00:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 23/32] gdbstub: Reduce @type variable scope
Date: Sun,  5 Jul 2026 23:57:19 +0200
Message-ID: <20260705215729.62196-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXwoB0Dvkp2OyI
 W565TW0m57y+Y53BYh/3HrrljbA382N/xU93L8hMi+oLtvkeHZh0Tq7Ef9YnaiCZ4eqAm7Ham/z
 Xbe0RC37M1SU59q+SJNx+8dhNFVMMcA=
X-Proofpoint-GUID: 02zRL2wbLWr4Y_pQPnUlUAkhZ7XhItgH
X-Proofpoint-ORIG-GUID: 02zRL2wbLWr4Y_pQPnUlUAkhZ7XhItgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXx2h6aKPqwZXT
 wiyH1ItJecvHbziOdpklds+wF5/xfIFY13HrgvQIDqgp0e4n0B3MyP+BA7hkwCrGoQngTAeUUSh
 1jv8ikcChf06r+J88FadMh7Wx3IR93uizSGMGiASxksqg34IqHnUoxXyxAWgirZq6QNhh6maS2O
 15NnaM62gRmiUOZl0RM0BXpzVOh0rWCEbyTeyA6XH6pA4WDuGBy+Z2ZHBRczNafhren7+hAkMVw
 ckVla+OtgGPR/lgcIRo6Mly/6JrrD6hAjDqxrU1j99b6D1cBH8XSgl0vLnfOoJcF5zq6z+OJHON
 srZMYh2JvLNDXl71weagZ55OcFiA/ZLdRUZ6vlRC8asOF+j650iSlpkwFE0nOvhT+X0kC6W8xAU
 xwUs7pq9VnqzzC3tgkvXmGFga8Y271b3tK//pPY397WTnlKdoJUXDPthmkUKU6XZ/e/Y6QQ8OAb
 LkcknZmMW2PhGtUY7Zg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4ad3fe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=3yY2QiCzES6IJYuWj7AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index bf7aa1ac234..9c4bd8ebcba 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -125,7 +125,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
     CPUState *cpu = gdbserver_state.c_cpu;
     g_autoptr(GString) buf = g_string_new(NULL);
     g_autoptr(GString) tid = g_string_new(NULL);
-    const char *type;
     int ret;
 
     if (running || gdbserver_state.state == RS_INACTIVE) {
@@ -151,6 +150,8 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
     switch (state) {
     case RUN_STATE_DEBUG:
         if (cpu->watchpoint_hit) {
+            const char *type;
+
             switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
             case BP_MEM_READ:
                 type = "r";
-- 
2.53.0


