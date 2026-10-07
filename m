Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793A1CA600A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEb06-0008Dw-4q; Wed, 07 Oct 2026 19:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEb02-0008AX-DO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEb00-0001QW-SH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtmtG1466980
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PyrVazVg2ILwvk/uJX9ZwLiX0Dw0xfAYEtSge0I7qp0=; b=G2zZeXp1+ZGBvl5e
 UAwhrBGVrzLUUR5EpdhHoTDZb/98kyjFn1b7Guqa8ddDro57DS3Lp8JUXgN4oMJ5
 dh5PyKyCYsqKUYkv4l4CsDAK6FMkIoAm7oiYldYB2J+/tLj0lp6l1dXoF6ShQvqt
 x23pzR2Uc/FCvxTaPvSmf8usgdgn56Aa08OrDiitZ+o523jMzlaeBlUWBKhbdC2Q
 O9VE2fzHDyPTtdTgzojxp+aMFxRJST3MOZGaLCWUwp7rkuvBEXqSqw/0GIQYs1R2
 0yWSmtuY6GdgasDa3WN9h1NjQuzJnwcYY/6SgO2WD/tVL0/Msr8YMlkuf7f+SYte
 hoRVFQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe409p8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:24:25 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-919879b09b7so48374226d6.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415465; x=1792020265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PyrVazVg2ILwvk/uJX9ZwLiX0Dw0xfAYEtSge0I7qp0=;
 b=QR+YYvTLe4Olhlf+1g6rtKwpoyYKH4Bub3+XsA8kJkFllOUVmYbMExMbgVCLIjzz3k
 r/HB5Vx0p0VEJLekdW6WQ7CO9Q/oe70rxND8xFHeqhy1h7uu78hV3pM921ttVoZgM94l
 nVGMedLsH02m9Y8tdnQuwjK/huG1vQnN8H8wsaFSlcSXsf8R2Yy4qDI7HaXgzVwLsN91
 zxLgcHZbusgJc13oSrf9Y3UxpFlQIjQvDygtDWHKhk5mEmbUQnjT61E7CLx6D9AR0Fou
 4lMJl4sjFZgkkMIGbpcU5C2SFBIKU39AeGwfs11afIjYT8v2YO5PeDyvIQdQ9wACfxxa
 i8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415465; x=1792020265;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PyrVazVg2ILwvk/uJX9ZwLiX0Dw0xfAYEtSge0I7qp0=;
 b=X01yMWNA6qvjWsMg+0lYb8rzQyby9lx2OX3msaiRuONpeTCr+sD1AYSVU+e8jdX/ff
 6IYba9HRlzHBzpH3CGtYeLJfdHHaSNwFUsS8VTKkvKIQavT2YnNiZ1g0BCo4gMAuzyfH
 SXtzXpCHBNp0RnvLkC4EW3OuZgJs52opB1/9FBbaOWbPJDJ6xL866mIq5LXxTw7gYlkM
 WCMgqqyxzfqTx7nblBXzOGMXLacprP2OiMmsNjkSnolKi6kIvcMN/aGo1lgcF4I49Xh5
 X4MuyuFuFNVcZBvJG37ZGUzFPlFh2kMObSsVBNZYeYvOibLnXYT61z2Xwk3zLC/CU74g
 dq5Q==
X-Gm-Message-State: AFuF++mwVaFtMQMlhtnTurtIs8FvRImCqxbWC7L3YzxsNSUwM+Jaaosq
 iH1uf6H18gH2hRVIp7fGYwT7aDt0TDZUl1Z5fUXnXTe8Mi8fw9OhI68YZ4amUhElZn9do9rETOw
 W4gcLIBNtiDA+4T+5tL7aa9ZyENeFhq9wPIf99aZKEVMacE7JsuNMPMWZUpQn03pr9ph8
X-Gm-Gg: AYBFou0SkVTy32AlN00YYNNKHikbKo+vlEZIV9IVKHuKmP0EULsBTgwCM5lcte+S8w9
 Lxu6fZDVC+so+nApnLYnpvg9lQ3HmbFq5K6saXMsXK1RaSNFHcPsAUmyD8fyS9Yv0ie35F/O/uy
 fNAu5fFrTujoZKLrawWdqHLX1f8h3jAbE07CuZnzC6wqjxEm5yOZo1sfNDdTRwKpuD3lnmMob7A
 e4U+kaHSRBgra2Ot3UlD8owII0xxAlSDNwqPIpq2NkCusGYG1KyrP4aQP/LZEjmTJOqj4solPI0
 24nE62LAqqVOCdFuvkwSizSGO4epUKAoXy8QQvq1GSnD8EMpETFM1z/Q0VzdeVoONhIPN8u1+ef
 AycuyESo+tpfUqkk1DST1l8yVvVch1e8KwN29VHJm
X-Received: by 2002:a05:620a:4710:b0:93e:6100:2f96 with SMTP id
 af79cd13be357-93e9b7be130mr734851085a.50.1791415465261; 
 Wed, 07 Oct 2026 16:24:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4710:b0:93e:6100:2f96 with SMTP id
 af79cd13be357-93e9b7be130mr734849085a.50.1791415464835; 
 Wed, 07 Oct 2026 16:24:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71bd7961sm7838912f8f.4.2026.10.07.16.24.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:24:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 07/10] target/riscv: Factor riscv_gdb_get_reg_mxl() out
Date: Thu,  8 Oct 2026 01:23:22 +0200
Message-ID: <20261007232326.66240-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _oMzpj88q5uEy-sD6bDegvoUy2_3Cl8e
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac6d4a9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=v7q07ZOhGuMP-4ww41MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX6Dm/701ph3CV
 6lZUqoa3zPCU4tE2zB5aC8Zby7aQBiG6mua6ewYIC6D8hFl2FQzNkVzvPF8PD+l2oQjXbXwEWHk
 3JvPVHhbv8swCDt3GMNax3Dxq839Irk=
X-Proofpoint-ORIG-GUID: _oMzpj88q5uEy-sD6bDegvoUy2_3Cl8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX6khYb07qQ0yI
 cDM1g37IhCD0/bCTEW6/s9Sg+5sraspePDLxaydbzhdnZXerPvcp+3dRCnjJtnDk+NTuwPl+PJB
 qYVK9XFMGSPnnO5oj+0Jh1ONE4Y5Lm92KDghWFxfjutux9vC3oVQB0SJT8j4KU61Kvb9+0znrkq
 CT5kkJlXPm9VcJ2IG6GJ989/L6MfruT9By/ULag79oEHflcbWUAueM/u4O/yQENtxowLDPoj4k/
 fmquFzAW8Wp0Ha+pGorAvu3OjaNnSxOQxpA2/G5n2wGUWTsPDaXH5l8nzCgp8Gi2Vd9UqdyCdHO
 i0oSFHKdt8I6KC32DtCI4D5rnCLDOQIVV19DAmoNN7XlEArgZzvpRULceh0ZTgxIvhrbv0CZEVZ
 bJavsJF4q6ao0wYGaiGb9DRuRRYbgxXcp3ZxlX7XS/AQhXaf0hEzdWbSm8CbkK2Lqkr0ER4aFdw
 FSwm5i4yyQ94VHxiJug==
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

Move the MXL-based selection of the register width out of
riscv_cpu_gdb_read_register() into a helper, so it can be
reused by the following patch.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/gdbstub.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 9abbf5bcdf0..b3c11db5397 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -54,9 +54,25 @@ static uint64_t ldn(CPURISCVState *env, uint8_t *mem_buf, size_t regsz)
     return (mo_endian_env(env) == MO_LE ? ldn_le_p : ldn_be_p)(mem_buf, regsz);
 }
 
-int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+static int riscv_gdb_get_reg_mxl(CPUState *cs,
+                                 GByteArray *buf, uint64_t val)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
+
+    switch (mcc->def->misa_mxl_max) {
+    case MXL_RV32:
+        return gdb_get_reg32(buf, val);
+    case MXL_RV64:
+    case MXL_RV128:
+        return gdb_get_reg64(buf, val);
+    default:
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
+int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     uint64_t tmp;
@@ -69,16 +85,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return 0;
     }
 
-    switch (mcc->def->misa_mxl_max) {
-    case MXL_RV32:
-        return gdb_get_reg32(mem_buf, tmp);
-    case MXL_RV64:
-    case MXL_RV128:
-        return gdb_get_reg64(mem_buf, tmp);
-    default:
-        g_assert_not_reached();
-    }
-    return 0;
+    return riscv_gdb_get_reg_mxl(cs, mem_buf, tmp);
 }
 
 int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.55.0


