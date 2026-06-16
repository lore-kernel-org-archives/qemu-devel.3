Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5B5CD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJEp-0001rT-My; Mon, 15 Jun 2026 22:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEn-0001nM-6m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:09:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEl-00011o-EI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:09:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xkfc2271219
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l6rA47rYC3d0EmECbWkz3hngfiJ6ms7dhG+I9P8sgNY=; b=QE0HV6hEOAxhAwp4
 erpR3mipF3Vjts07d0htZ1E7W7e46DtaFarXyfVlJiok3kuZ/PoMjsy1kxi6+okU
 EZ11I3RcUwKtsmALulOxod0DrwtbWsP6OXWdmkzPVA1S2R/az0t49rPW02wM+M4X
 x+StPhAOJAP4w866NhdYtBwu4eSvuKNUvGvQ1RmCkMSnQHrMImwb6rtv29UHTWkv
 jqFjcHOMtOhGLwn0W16bXVPG9jE66UtUVPdpBJ8Y9xo9hQlJSn5LpHTo4uvnwh+S
 W+TZLlRXVB4I92gKAjixwrlW8UGLfKevLS2qFgLwgcueJvwhLDq9eG0nKk9/ojdR
 gLJINQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteguv5jh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:09:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915f7bd027eso1062056185a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575750; x=1782180550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6rA47rYC3d0EmECbWkz3hngfiJ6ms7dhG+I9P8sgNY=;
 b=dlmUQU5JWI8XPpMk2Ut/iARhuahfjW4eDkw9TlaDhvBJwCxQePlwn4FM+GpKLL7cHp
 knebJQJdILF5Iep+9aDUD88+wtKnzCtVoPh35Li8tZ/NzWivoFUw7pcgPxqplfZsb+zF
 lRSHcyRigoAyxxSDe+ZCF1ZinaLcLHoJIfRly0JHoiVVpfgjdfsIri/w7oBzfexno1aO
 kXzxzyIqoI2vLuJEz0SFPcQAdqeWcBiqTvEZi6U2S0NNPy9btn/+YuUwlMFBvdfFkr/X
 VNypmBGVAyoCenGikHImTkdYh7p1q1HJtnCWeNmMINx2TtH2Kn4hA8FbnMRG5FuwqVxp
 mN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575750; x=1782180550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l6rA47rYC3d0EmECbWkz3hngfiJ6ms7dhG+I9P8sgNY=;
 b=UNZrrRervkvGEUYkjSyTg5ZTgvmvEzDCAlCq2xvd9wmXqliv4sIW6JtrDPZJEGr6v8
 mF2KIIUtIei+rcBmbGbzwUSx5Gn22xtyVb2QZDO7niI7p4bS+5/U/D6g02szEMpqOPjB
 6ZIsx69tnj9ynSCBEdu+CGba7I0RteQYnT1jU/O+0NW76DdLWU0/FULDss//9i8xJdtA
 DgkYz3aNSQO/11Ny0q6lEF4/VZ7Noh+f+gO2Q6lMqELhRxJQqIxd/4sCQnT2EoRhztvi
 kziGO2v2/pyaVNS6CZ7Iitkh/bBSqKLJzLfDpgy+vaLPlCo22n2YQWd2ILTqsaukllBY
 k2FQ==
X-Gm-Message-State: AOJu0YxiroHr84CzMZ3SWzxukfGX87SRgJYMCuyQVRwH70iX3nfDkuLc
 7bLMKzD/Z5J/TJfy7MdUvJsaocPNEo8gl0phBS6PgsG1IYxMHlaB4gvxuP2IS2R+/A9Ed7tLfGC
 TG7QURAF4mdu00XY3Xvbb8g0uDUYjzee71VE8bJGzIDJWthSqmNRBk5lsSgab4IHsjA==
X-Gm-Gg: Acq92OFbvrz0BRuWNuRpQJOlhtbDXFpAhZKP09ubm74tbA6BmgJKoZEOwTP8BP2u1Io
 /yns0f1nvejaygSIu0vh1OXFMNBXxrT54oOYDP/h2EKdDiSK5prGF+6KhoK6m7XrkPEgWzYHQwW
 9DuKSbi2j/VJE96G2TAVQM6q/ldBBIsplDuCUyNgINl6znYsQk2zPDlmaCslW+FkIfcgiEE1grb
 55iDHubU/02fu945S9rossq3nts6mRrkbPgxe7MoE4/KjrBq5PsQbj3+8f+fJMHZgIu/tloi+l7
 Mofj3TmJ+EKrgkFHgaA7dYIDtgU+c+nDm8mnoIE28Psu2g8EpoL+qSfJPx0OEpdQEvRy5tu1jeA
 ry2amwf62yT9OoI/n2CmrnYXTSpLvk5YsKR4HCfXB+f54aDWFoXcc6XzbP65w3RjSgxmKWoUTv0
 /ynvs=
X-Received: by 2002:a05:620a:1986:b0:915:4211:baa1 with SMTP id
 af79cd13be357-917f1f49bd0mr2178807985a.33.1781575749917; 
 Mon, 15 Jun 2026 19:09:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1986:b0:915:4211:baa1 with SMTP id
 af79cd13be357-917f1f49bd0mr2178805685a.33.1781575749557; 
 Mon, 15 Jun 2026 19:09:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm42686174f8f.36.2026.06.15.19.09.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:09:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/6] target/s390x: Factor common s390_ipl_read/write()
 helpers
Date: Tue, 16 Jun 2026 04:08:37 +0200
Message-ID: <20260616020839.19104-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020839.19104-1-philmd@oss.qualcomm.com>
References: <20260616020839.19104-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX7JGYkkahPWfT
 2Odslh2kGRorhtRNjvFLJkNRXl4orzwiUUficLIednejlMVD+N9/owglyk7Nu7JUinI61jtoJhB
 8fmXcuqhp6lw2WfIHxgan4gQLIPuBnda2CkMUlLIbLj77pfCevZ6qN2nwfARfvHFwnLdQM5FbFr
 d2+oHNxUKesRPsJ3OH5iF1mwqPxo9hm5a+n9bGabo1KeU4KgpIoYBix3P2bjAFGmKcxYOYwVJGu
 DX5L35VuDaymD11fs/bAR4SwyNtAxIjNPy7wsMsfZoXYju9ds79PCRVMbq0Vn84S/b5hLUqwPFm
 FC/avzqPct26xin23gGOazk2O1mryGvB/LwTnX42m2EDUtbHp9+tyq4sVRF8N9+QGFE8TnvRJzv
 0OO7KwUE5JOI9qaGFe9wzrcKZuK+mXhMgPOV4bNJdJ3i9vU5Kxt+PW2Pc290QljL0bSJ/wAdijn
 B3iYxENjXTL3O/M1LPQ==
X-Proofpoint-ORIG-GUID: j7IAVkZtabyHAdy-E8T5b56TS5curZU5
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30b046 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yJueZXV2tivX90BAKnoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX17+hICHYjlqO
 ak588Wnyy05yoRJqyo4IOtuLRAV0JazjvYmTzMLn1tpiq4yyQ0f7bueLL4jpYa1P2w/r2E26nZG
 TAgpE3BHOIPKav90N3kk89n61NCyw9E=
X-Proofpoint-GUID: j7IAVkZtabyHAdy-E8T5b56TS5curZU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160018
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Prevent duplication factoring common helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/diag.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index da44b0133ed..bc1791067d8 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -73,11 +73,30 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
     return 0;
 }
 
+static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
+                          IplParameterBlock *iplb, size_t size)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
+    } else {
+        cpu_physical_memory_read(addr, iplb, size);
+    }
+}
+
+static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
+                           IplParameterBlock *iplb, size_t size)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
+    } else {
+        cpu_physical_memory_write(addr, iplb, size);
+    }
+}
+
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
-    S390CPU *cpu = env_archcpu(env);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
@@ -114,22 +133,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
-        }
-
+        s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
-
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        s390_ipl_read(env, addr, iplb, be32_to_cpu(iplb->len));
 
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
@@ -164,11 +173,7 @@ out:
             return;
         }
 
-        if (!s390_is_pv()) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
         env->regs[r1 + 1] = DIAG_308_RC_OK;
         return;
     case DIAG308_PV_START:
-- 
2.53.0


