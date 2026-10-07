Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAF7CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEazO-0007aJ-Lw; Wed, 07 Oct 2026 19:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazM-0007Za-Jl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:23:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazL-0001N8-2M
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:23:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697Lu3t51467631
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9igVSNHzVAX/ye+kK1vCx0fWCh3KAJQPg2/n6kP3MQM=; b=QoFDnhuLO0QIJNqo
 TMcjaTc6hRRixFW8WYG+gNwPaad5dlygoYcoAYJ1BTXKWnai6zyIgGVjIMIqpGPt
 Cl75IPZzkbUYEnaBBlSaiwsbpgmqA6oxM19eoCBIXLMjyDGM9E0Cth7fgN0et9lB
 GiTbHFgBiIwRL3Ym9085U4ABgUA9TYWjHynBhHOK2xv40rYPbKMs4BOU1031GnoV
 qO15O9Li101WlUb/FO72oxO5hroxg0QhkByS0i6Kg2Im/JgeLaIvlMSvDcTYPwFK
 dZ41ZpKNyiplYVulF2XIf+6ZxdTrfEX7tl/L5drf2CRo/UAitxER1z5dZoqQdUg4
 xo/gHg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe409mb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:23:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb93c874bso102071185a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415433; x=1792020233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9igVSNHzVAX/ye+kK1vCx0fWCh3KAJQPg2/n6kP3MQM=;
 b=OEtXV2P4kPJX9cuIv2tAj/IRV5TavI2BpxWQO9zySJMWKGKYJEC+q1wIQxjfn6EnU+
 7U0h0rS2cwy1uD58N/oc232zk6ME8AScUhAByMrHwJGcGZEQr/lNIHX+Kq9p2tXlTtNN
 WsxPkW6DQHFZ+UX3sYgmnDphTVXeKTzaaAVBx31zWoWu7YJyCxanq7HrQ8BfaxCOiBYm
 1Ir2XUAEqawY0lERaCh4gjfnKS0LhAZOHEGvtYgibDOUV2xLvK6wVmG3WtcCK3bdV696
 IOC1hayN/Y8zhdI0xHJoZ27zR6OZ95GDg0D6+naqZHBhBTD3phKSyGvsqkKgEpHDsmN5
 knhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415433; x=1792020233;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9igVSNHzVAX/ye+kK1vCx0fWCh3KAJQPg2/n6kP3MQM=;
 b=M7hYP9oan6h1gn9KiUmfEaRBTBaH55xtLEkUlQjgUtRAFBOu2kY3P7VAjlS9WEpYca
 0nxB0ZmamALjhGyFvmECh5KhO4t7sClImEZYBvg0xsxKusPQbPCgB05niEQFoqT8GRV0
 0tZ5VQQVzeOTgWwjwWLlak0lQBVALjN2X728p1znOWk4rMoO31g8tR+mmJOF64HsXCuH
 I8PTTjwjluRoOY5RUTLCNbIDWNVvDU2t1w6bqcN71SOn2MWWThx6Lgtmv0QXmFSfNbvr
 6873Jgisv+4FbWBJhiLZ9Z5uyT3oQNhjvLgnxCK6+ksBM2s23dfSZBzj23Jw8c6TXQYG
 /ljw==
X-Gm-Message-State: AFuF++l4W2cW71h8mTI3RGcPQmSrzlMcDhtmUslHxEZFy4qv5C7Xintw
 D+/U6rcUjhJm+BJ+dTHKcQwYwlLPxx4uyA/gZt1dSU3UyrjxrTYGUfcVob+wFhQUCzARkqCb1Kz
 j7gGgwM0Tg+bxbs2hpww6hBGJqbDMHekK3PTI9ppjq7sWynlhBO8V380Kbh7nfjARmxmF
X-Gm-Gg: AYBFou0TuTVzlghEkqtF2ZgcCVRsrzvkKrpcrZ/I2CvEy1Ig6rDXZFL2llIqLJlswza
 ZWC4ARhVwayGf4eBi2U8zZJpTpHat59p42TOnWyTSbutA68DK3WE6r21OIL4IR2CcMIDVEsoBgl
 2blutJfmztVkG8QrJ2+uHmA0MAPRe0dTDOcMvIuChyCfgdh8LD17oI7N4nfkvxBRMpQdhhxXwIK
 o4nuKFzAyXHnFvikE97qY4qFQBlhUSZ4rxAgjFjjpJ4lL5Pg/nVYW7dZOz3XNkPx/E2VuODO7Bx
 Zm4YpM/ifk0TojgZSppGwT6qIvwIB+RTKKmNMSraP5XOv1JoldotB8+pVDyf294CtV2l//ERsz9
 eXH9Tqaqm2LC3wpR05/W1tYMGMSNvar7kamMbP18G
X-Received: by 2002:a05:620a:1a0e:b0:93e:9808:2e19 with SMTP id
 af79cd13be357-93eab1d0171mr132216185a.38.1791415433493; 
 Wed, 07 Oct 2026 16:23:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0e:b0:93e:9808:2e19 with SMTP id
 af79cd13be357-93eab1d0171mr132213485a.38.1791415433075; 
 Wed, 07 Oct 2026 16:23:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71bd7690sm7839405f8f.2.2026.10.07.16.23.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:23:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 03/10] target/mips/gdbstub: Replace target_long_bits() by
 mips_env_is_64bit()
Date: Thu,  8 Oct 2026 01:23:18 +0200
Message-ID: <20261007232326.66240-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QfWyf3E6Um0j_mUQfv4VJlGbEBgOHotW
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac6d48a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=4t97mPZE8VEZQuOP_ikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX7j49P+fbFjh5
 RkASGUFKsqsd6LzKmKL0dR90V+aHkxW3rnDvBVQTu3ua94euPIsh2LJbsP2p2cvlqw/K1XyBBq5
 ygtdCKiCKTLtZmWfhS9VAf7154KWwWw=
X-Proofpoint-ORIG-GUID: QfWyf3E6Um0j_mUQfv4VJlGbEBgOHotW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX4EH/q5ALNt74
 oKxIQtR28hxO8UU6xlpoqoRFCkJC+wIs+cCgVtQ3Q3zpyQpD4mlFKwkV/SQmejYtHGdia+BtU9U
 u7cb3XgMrs0PXo16efbtfcYKm6eDQ0I3kZY+tiuYkuMQNBhxUYJhOEyS4wtVqnil8IHV9P+MGGW
 IlICYvKl9m+PijyB0aKS0mkoE4NQTdWwUPOo6ATAQEGJK+fAk1ZTVQlCCkSxh1KH9iSEmnLmHwZ
 i19RazZy7AGzoL4+QoUNywX4+uO9DgRWggwyS5w5U7SmRazaJx1dzdq+CrPMxC/tm7Va9E+ep4v
 ZUnMY01gxN5f35dBB4Maoybz6gtb/PHTDnwVrcULDNLR9FMMLHO3q6Y80uRQHGy/HeUPVYh8lBR
 /Q1yxGFvHibG2y1ak+inClZVvMGBiy193iNi4EjAP1wT0EPzMcFhYCp9/WA+GgN4cBI1I5xE+a4
 WC7GBWWBsRTE97onkeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
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

Add a mips_env_is_64bit() helper and inline gdb_get_regl() as
mips_gdb_get_regl(), so that the GDB register size follows the
emulated CPU model rather than the target build's TARGET_LONG_BITS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/internal.h |  5 +++++
 target/mips/gdbstub.c  | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7dba22300b1..0c9b1335ebb 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -228,6 +228,11 @@ static inline void mips_env_set_pc(CPUMIPSState *env, target_ulong value)
     }
 }
 
+static inline bool mips_env_is_64bit(const CPUMIPSState *env)
+{
+    return env->cpu_model->insn_flags & CPU_MIPS64;
+}
+
 static inline bool mips_env_is_bigendian(CPUMIPSState *env)
 {
     return extract32(env->CP0_Config0, CP0C0_BE, 1);
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 7598aab6158..78d3e9a5b9b 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -24,13 +24,20 @@
 #include "gdbstub/helpers.h"
 #include "fpu_helper.h"
 
+static int mips_gdb_get_regl(const CPUMIPSState *env,
+                             GByteArray *buf, uint64_t val)
+{
+    return mips_env_is_64bit(env) ? gdb_get_reg64(buf, val)
+                                  : gdb_get_reg32(buf, val);
+}
+
 int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CPUMIPSState *env = cpu_env(cs);
     uint64_t val;
 
     if (n < 32) {
-        return gdb_get_regl(mem_buf, env->active_tc.gpr[n]);
+        return mips_gdb_get_regl(env, mem_buf, env->active_tc.gpr[n]);
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP) && n >= 38 && n < 72) {
         switch (n) {
@@ -83,7 +90,7 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             break;
         }
     }
-    return gdb_get_regl(mem_buf, val);
+    return mips_gdb_get_regl(env, mem_buf, val);
 }
 
 int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.55.0


