Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0B606A33A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AMySUJmB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A9/kBF/y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhum-0007z4-HV; Thu, 26 Nov 2026 17:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhui-0007xz-0O
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:26:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhug-0003qO-Cn
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:25:59 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwksL1712701
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FfWIQOvA48hGvDH3/L9ElaJ5QgP3nRlxFpJMNYoH4KY=; b=AMySUJmBXTWKwD8Q
 +/+M1D8MsTne719FTlSLFmycC19sN+KMd45g/dfDizJrh6tu8hQWDgkbg9OvIItf
 9t6U8MvOCT4/IPndlur67RWqpKjinn+r8j1a/UJSZjZAPGWBIVkKtvbwJXyWXXpp
 cEBSrzHcewm9qEZC6JHaunLNI/cj8NWqkeg5AT1V5LDycfIGN6+LdIACUorYgc3u
 iUzd0/yu23MC6i5pI6wCZXSkkD5CBcNp+kae+GbQY3Hq6iaFp+9xVjC6nWXQFpsz
 TtK+leJhh3uh3Avc8BDuIt2z9n3/R4ZINsZQQE/c7uu9Hc1WXKF1CsPi4B/QX506
 Ut159Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2qv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:25:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2c0e6653so367283885a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 14:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795731957; x=1796336757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FfWIQOvA48hGvDH3/L9ElaJ5QgP3nRlxFpJMNYoH4KY=;
 b=A9/kBF/ySLPUgrtb0MIaZjfEJvg3dUYpcSpaV2mhDe0CsoCbKuz4q2rjWNjE4Q7HVz
 ZQHn2tHn0s2GBIKgJ31ktaiX9Qm0qq3ET8a3T0rw7bgPhf/UBS8jYxezV2JLiM9kQXWp
 F0zzs6Qo0D4a18tbis7kkhh50dpTCxvOIz3ue/jHYoNdN4c3e6SvbLOebgyIvWdi8zXW
 vqQn72BW7UaIOtNDRODrUwqpD7QF/27KjwIeeyQmak+L1/F5wA0PBSgpuQVljYby0IKL
 mY0GtLvneapuKp9XcrCnKiqWo56t+pcdM3GG+yFJ7BEyg0BHukCxvRzCeZsleBCVGZzo
 aHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795731957; x=1796336757;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FfWIQOvA48hGvDH3/L9ElaJ5QgP3nRlxFpJMNYoH4KY=;
 b=tEIlzTlZoaVRVzAbNeS80VMuhjn3gVf6Hv9EituLhpJpxWBbfO/qPkf6EAgH8tBEkt
 6/6CNzmO0e8KcOS4WvHJn+50gZtZe3ZOZZUYMncKYPI1I+TsG/T6uF1I+tvyw9oCKk7T
 2KqGOl7Dce2TXJmBizP3WJhNcB7Qu7D8K22Pfwg8B2FyZ7Lwu6LnNRl290vkesjE7slD
 6vlo2sXp/989hApHXYXeMRkp+W2I0vcXdrKSuxVQQouwYROU/cB/yHz+ZCS3pXKhpGGU
 h1kvuxpUw6L/qZxbjsrhM0HHlqRMYJDuTHJN6h5NgvdIPsE+QTK6e7iFMjOkh3eZxTLv
 mPQQ==
X-Gm-Message-State: APuU4Z+jeJDcpMEiibBktv7ZtGDxnHczxpqnjAIUUmkSAJrIJ8ZHshdR
 tLtpaJGYBe7tl0GsJbHGBQdX7KcgczkU1P+lNZowSKF+bGFmCF9RJMks2o1Ygng9LrgKKrzY/2A
 Hxhavz97/D0QZ4AhqC8iAwMcP4A9HMtZrxOzAcgiKzdrOaIWhvTuWr2+iS9o9CqOxLQ==
X-Gm-Gg: AZFdTZet9n63EiOOPSerR7co4tPsiWFE6aH02bTmvuhjqccK0b+kFx55SEzbZU1ZJjx
 t02HBqIpwnw3nSIZaJKkK31shG1+UWyoohpGhOL57TafSHf+QgPFgZw0iTwr2L0Y7iA2mul6fBi
 JNrDajj+wcJb+BSLi65G/7ti9pA1Ucci/ZnQIm+fkUmPyDzMlQP8Yneog68s91G7AQgVteSXBvQ
 WLzOU3dxO2yXt4ct7NNSwD2lqqdaMXaDTrphV3YWD0fj2nqEdLCtiHugwvsYSYWmDSKCNqFsZOX
 JLfYYLvMeYLyGFQoPBg2Cc+l3g+GulsXh2vH2l5scb/VdVZjMs7/l1iJpOAnTwBVkYDTTgpZj9z
 G2JsYnsZphB9zhRjwVzv/O/CoWb/j7meR84ypWXY4SyGNW77fh5Imx4bB1jEL/I/Am1MqdkbX/h
 9i4hI0wIgItK5K2Q==
X-Received: by 2002:a05:620a:1a09:b0:949:77c5:a58a with SMTP id
 af79cd13be357-949ba9ef1ccmr3913060785a.33.1795731956773; 
 Thu, 26 Nov 2026 14:25:56 -0800 (PST)
X-Received: by 2002:a05:620a:1a09:b0:949:77c5:a58a with SMTP id
 af79cd13be357-949ba9ef1ccmr3913058585a.33.1795731956374; 
 Thu, 26 Nov 2026 14:25:56 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989e3sm43376213f8f.52.2026.11.26.14.25.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 14:25:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 3/3] accel/tcg: Do not write qemu_icount from seqlock readers
Date: Thu, 26 Nov 2026 23:25:30 +0100
Message-ID: <20261126222530.62175-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126222530.62175-1-philmd@oss.qualcomm.com>
References: <20261126222530.62175-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08b1f5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ISvMSLdbocKUt8YgRNsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OCBTYWx0ZWRfXyFXC+QLdiJys
 /ofLfGX0yTCONeK9/lXh8EQYb5oY6aprA2XGtOCpH3Y+R+9lJEzvkEDylk+XXWcrz9GKSPoYT8F
 YVy0uOsJW+iGCoA1GtFNdpBvGKW//2z/2BKyuUFSUnl//ZzeOTlK43Q2Ng2NzcyTcdRZ+R3E5bb
 1ugriHJ/ymRNppjVIa5vQN8B8UXRyuw4/zFxWztm5Cq1aTLKv/vApQqclQZs4IyCGVEN3hN9IYe
 g6tmE5sR2D/EBuYjijqQMboSCA60Nns1ffzqAR8R5r0ARUbT2mXOMuGvEVK2lqznES+z21N6BLg
 5qfpu8DprLwDQIuwSMgCtW90bmsJz/BNFwF/a1d4r3HS2C3HXSXqmYfOPwlaj1d0e/W8XNUhk/d
 bWvIlDB6WDc/i+e2Vs0Gv6mf/EfLLw445SIkZCX66XGS68QHJfNNunFb0nVwC/cl03IrPhS2szF
 zDKI27FKkbmCpnh36HQ==
X-Proofpoint-GUID: xY3uedW5GzkztkiVsac7xmwvesIii3Sf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OCBTYWx0ZWRfX1iW2VHJeIbQM
 4mg7EzAYwkNWJp9WaUi/sFHPuhO4hfhwS+9Gqm65tG1tgHshOvRqsiSnOLco61PhtH8h4/+OPja
 rZMBjvfOhX8p1WyrebpAms5hLc50iO4=
X-Proofpoint-ORIG-GUID: xY3uedW5GzkztkiVsac7xmwvesIii3Sf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260088
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

icount_get() and icount_get_raw() updated qemu_icount inside
the seqlock read section, without vm_clock_lock.

This fixes a narrow time-skew race in adaptive icount:
icount_adjust() reads qemu_icount twice under the write lock,
and a vCPU update in between is lost from QEMU_CLOCK_VIRTUAL
(up to 0xffff instructions). Reproduced on riscv64 'virt',
whose cycle/instret CSRs read the clock without the BQL, by
widening the window with an injected delay.

Update under the write lock before reading.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/icount-common.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index b52d22f3a1cf..ababf7745b27 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -125,6 +125,7 @@ static int64_t icount_to_virtual_ns(int64_t icount)
     return qatomic_read(&timers_state.qemu_icount_bias) + icount_to_ns(icount);
 }
 
+/* Callers hold vm_clock_lock (used by REPLAY_CLOCK_LOCKED) */
 static int64_t icount_get_raw_locked(void)
 {
     CPUState *cpu = icount_running_cpu();
@@ -137,19 +138,28 @@ static int64_t icount_get_raw_locked(void)
     return qatomic_read(&timers_state.qemu_icount);
 }
 
+/* Callers hold vm_clock_lock */
 static int64_t icount_get_locked(void)
 {
     return icount_to_virtual_ns(icount_get_raw_locked());
 }
 
+/*
+ * Readers never write qemu_icount inside the seqlock read section:
+ * the running vCPU folds in what it has executed under the write lock.
+ */
 int64_t icount_get_raw(void)
 {
+    CPUState *cpu = icount_running_cpu();
     int64_t icount;
     unsigned start;
 
+    if (cpu) {
+        icount_update(cpu);
+    }
     do {
         start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        icount = icount_get_raw_locked();
+        icount = qatomic_read(&timers_state.qemu_icount);
     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
 
     return icount;
@@ -158,12 +168,16 @@ int64_t icount_get_raw(void)
 /* Return the virtual CPU time, based on the instruction counter.  */
 int64_t icount_get(void)
 {
+    CPUState *cpu = icount_running_cpu();
     int64_t icount;
     unsigned start;
 
+    if (cpu) {
+        icount_update(cpu);
+    }
     do {
         start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        icount = icount_get_locked();
+        icount = icount_to_virtual_ns(qatomic_read(&timers_state.qemu_icount));
     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
 
     return icount;
-- 
2.55.0


