Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941F5C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeJj-0003Si-M8; Tue, 28 Jul 2026 05:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJb-0003E9-Je
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJZ-0007VG-SS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82l3v2275985
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mQewgAGZlTwk4l+P/U0hx29q84iSX1jPkJ8+AJstAT8=; b=Yn8jHna+BR4X1/MQ
 +9ZhAQ393fwzWNslNNtJDMigmSTk3WNMY/ZzeDLt7e/xIRh6nFqUhi82kj2Xa4Ui
 Ut60W8y+REXQaFBz9Z96FnnRdZf2xFdYSytFl0St4SifQGuIXbgvNbcJgllAivlr
 lHcDJPfPRUdY11jVW8jYPxRybYEh00PlQTywcP9UvHO0nv5ez33CqIRtSNaKAHzs
 Zj/Ak45IYrO1QEctjxCOL4hSnxGpuNOUGEPy8aRwdOgPTb7VnSQHsa7/3rysUil2
 wqmUyqTX/yoFHcE22EHkMJmaqZjozS6B8NxswgiGmi4K+f0QTxWY6YP/iYB51McC
 aiM+pA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrsuha9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9309af14fd7so391616885a.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231692; x=1785836492; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQewgAGZlTwk4l+P/U0hx29q84iSX1jPkJ8+AJstAT8=;
 b=hKhR9kmhpcctWJ3PU7ytRRAlMrxmCad2LIMbVSrhk/bd2Fvc5xwo5t247ZvjpsLIBf
 BB8gwqiZYfQg/sBRi7COPvBvc2YNb6QJeLPdsNkTSj5PjDh3jlboPETq3KccXBjJQYqs
 mhZzFii1guaeiEQVhMQaCX2DnRm5p2jVs+zE0QowJM6FT4+lES7kjPMsJzIs/bwOcJ4I
 5KBnodmVxeN8Ri7aM8V3SnV4EeHdpYdIOTBnUZqzvsJtMMYxqb5LNwrMEldM3+zss5xO
 iJ2oQIFCXYQP/yPcOL7J0VXJocuhPxY/YuEqj/vCQmrkASfOXaujaLHUTUnf646ULxua
 C4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231692; x=1785836492;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mQewgAGZlTwk4l+P/U0hx29q84iSX1jPkJ8+AJstAT8=;
 b=jmNkPkrx6bU/KfRb6tyZYGX/hbWN9fKuwX0obBd7M8cta7Mi/CADt9KFCMTHMqw+Ys
 vv2ka4gz0kQ3+B15WhmIPZOOYgyM5kj9iLJ50eDkG37BUGlbtZmKdlgBlEpJqbCmWe1/
 JHv91FL+SEmtgSzlhhkrN8jPNTqKkln2CYE00ztXUXcs65a9MJPlKy3GbQb+DeEy9K2Z
 7hEm3PTOeuLOs98Jl+etF2nmZlUU/lGQZBGv8SfzxrXLF4G/iu6issfNk3rhqiycBZmX
 AGY2TX38sKltEQFrPK+y8tSDzRIn5ygd79pR3P/5JUFK07kkic0oLyYV0Q/YM3PeazRH
 HWog==
X-Gm-Message-State: AOJu0Yy74lYl8qzotRPV/ikfpaC77UJ08OfajRpdfcUnldH+akmOJd3Q
 7FRyU5c/6BcmtztyCEP33H4kc1ctJy0H6bscDDibeBWtzyXwLrGSjzcSLnvI3KS7i8AijDpuViG
 OHs/rjACO2B2MBuKMkaHrM3h/UO1S/A9s23Ch6PNAtZMyxrz4Nm4ytcpTfqHvg64cvg==
X-Gm-Gg: AR+sD12RhfVK5bfQmnrCwkbS+UZFVYrgigNg1LNIY8h8Beb8x2oeHRZG46MMQ2wwSzy
 guRzXLvA5thvFgFw9mTreQLev6Y3viHzte1ekHmcPLYW/TSFQBKvwr8Uc8QOPNl9VpBZzsk8xo8
 Ns7LHfnPFh6ZjMQv92QMIaifFhFGSJ6pkMnfvTp2GlEs/b8RfNahvNArQ/6GfXs0ULOxw3uPiw5
 0pmeCfalh0eY0C1XLHJgnEm4QiYmQUHRT5Bo/ekP8rZoS3Ew21hpw/pm7UAhsuEVk3vdd5La7zh
 6IS0pWEZhiumZ8Jl2I2Vp+Te/yCkuOUU28UKtCI4Xhl0jYdHo4E80A5bjfRycvyVec3XE19WplV
 20vB/PLlJNmOH5NJD/uVlrpzvZJB3PPODnZMlWZwpfZkAIaJppfNpgnoOhA==
X-Received: by 2002:a05:622a:1baa:b0:528:3ae6:14d7 with SMTP id
 d75a77b69052e-529d7161ef6mr11730011cf.59.1785231692087; 
 Tue, 28 Jul 2026 02:41:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1baa:b0:528:3ae6:14d7 with SMTP id
 d75a77b69052e-529d7161ef6mr11729701cf.59.1785231691436; 
 Tue, 28 Jul 2026 02:41:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5c4sm56754889f8f.8.2026.07.28.02.41.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 02:41:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] target/sparc: set reg window data structures currently
 after vmstate load
Date: Tue, 28 Jul 2026 11:40:54 +0200
Message-ID: <20260728094055.12684-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728094055.12684-1-philmd@oss.qualcomm.com>
References: <20260728094055.12684-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfX53pzND2DRwt+
 GtbwCqd/dBybkWXXa6cR5SuEU/tqhn1Pjx75dbDvedZQ3DAabu6d4+nXBViZY5bEXulXXQGrDmy
 GdfLJV1z+TC3x4jhejfbXgEzuVM3XzrdLCRBH8L1kfyQtHYXSiQU+bVN+YseSta3HtjbzK3A4/b
 zgRThO78XCoO8nsL0s0criSuXh5+VSDWiwPSkZcX/KpZ3SrxlcrsyOsjCtg/0KpTH5/UsN8bJVd
 1y07c+xXHtKZv/gJmpDuSsLswF/aoSlU/mNKOmL0nYOazYqFebl97TNlPcH18icZnrOSFauk5CE
 uQJvzGlglGJzWfNT/vzdFjvn/ulFruNc9JdfiYur6p3VoRavlu+YcNVUE6sqRJ24QboE8l7vPHP
 FVjQUxvj4VmnGMfeGnemWHis9hyGQRhxrH0S6jfL/Ft5E+qwQUwphTYNe+fJX3NoyXfo4fPUzsV
 C07PecnU2No0FUtwwMQ==
X-Proofpoint-ORIG-GUID: dFZMN16QwN6hzss9BJ_DUGWWwKN4Ls8x
X-Proofpoint-GUID: dFZMN16QwN6hzss9BJ_DUGWWwKN4Ls8x
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a68794c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pcZqCyVeAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=x5RrepDsKcNiVzbUWgcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=SGy6VSG0Ue1xmPAwIFl9:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfX/7k9lKwmjhMu
 E7e95O3fc9KV2/E7DdBcn354tfADi9f/FrKZi7D8CJ2qpwKz5N4EZaTXjL6BMZNeQd2LlHY+4JD
 KzfIazUk+OUa/jOnyAPFUwiE6CdQYak=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280084
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

In the SPARC CPU state, env->regwptr points into the env->regbase
array at wherever the architectural CWP (current window pointer) says
we are in the register windows.  We don't migrate this directly,
since it's a host pointer, so we must ensure it is set up again
after migration load.

We also have to deal with a special case when CWP is (nwindows - 1).
In this case, while running we keep the "in" register data for this
window in a temporary location at the end of the regbase[] array, so
that generated code doesn't have to special case this "wrap around"
case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
wrapped data from its temporary location into the architectural
location in window 0's "out" registers.  We then migrate only
(nwindows * 16) entries in the regbase[] array.  So on the
destination we need to copy the "in" register data back to its
temporary location again.

For 32-bit SPARC we get this right, because the CWP is in the PSR.
The get_psr() function does:
     env->cwp = 0;
     cpu_put_psr_raw(env, val);
which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
sets up both regwptr and the wrapped-register data.

However, for 64-bit SPARC the CWP is not in the PSR, and
cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
register state in a corrupted state, and the guest will likely crash
on the destination if it didn't happen to be executing with CWP == 0.

Fix this by adding a custom vmstate_cwp VMStateInfo with corresponding
get_cwp() and put_cwp() helpers which does the same for the 64-bit
case.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sparc/machine.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 5f402e098cf..0d5d79b5e7b 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -151,6 +151,37 @@ static const VMStateInfo vmstate_xcc = {
     .get = get_xcc,
     .put = put_xcc,
 };
+
+static int get_cwp(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t val = qemu_get_be32(f);
+
+    /* needed to ensure that the wrapping registers are correctly updated */
+    env->cwp = 0;
+    cpu_set_cwp(env, val);
+
+    return 0;
+}
+
+static int put_cwp(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t val = env->cwp;
+
+    qemu_put_be32(f, val);
+    return 0;
+}
+
+static const VMStateInfo vmstate_cwp = {
+    .name = "uint32",
+    .get = get_cwp,
+    .put = put_cwp,
+};
 #else
 static bool fq_needed(void *opaque)
 {
@@ -286,7 +317,14 @@ const VMStateDescription vmstate_sparc_cpu = {
         VMSTATE_CPU_TIMER(env.hstick, SPARCCPU),
         /* On SPARC32 env.psrpil and env.cwp are migrated as part of the PSR */
         VMSTATE_UINT32(env.psrpil, SPARCCPU),
-        VMSTATE_UINT32(env.cwp, SPARCCPU),
+        {
+            .name = "env.cwp",
+            .version_id = 0,
+            .size = sizeof(uint32_t),
+            .info = &vmstate_cwp,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
 #endif
         VMSTATE_END_OF_LIST()
     },
-- 
2.53.0


