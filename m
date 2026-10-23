Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DE606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WmI/4VJf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YgxyNIl2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwD-00074j-Lt; Fri, 23 Oct 2026 12:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvZ-0006eb-1G
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvW-0002LW-S4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:32 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6BcT2999843
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rn+Kq5gFD18bJTJIJ5GnQ77Z0ABChsM110IWiZWDoag=; b=WmI/4VJfHeao7HiV
 YreVdB3YtjT7junQWfFFctNDP6rrO9J9lYHCnKiLrZH3vJ/DuZrfVoU5J8+WLnU6
 1XeiFsUV8E/Ioiz79nXnUb/5yb+sj0LAKWKsev3+RBY3IHicjXJbfM+Ci9gxdNgl
 3FrMV90SoS2+Yry7BGpmNDHMOOH5q2hk+vTng/Ju0k+3y2m6I9E6Vswoh6wuUgJY
 b8BTxqHQRxB60rZryuyRO3gGpu5zseIZvirdKTHjHchuA7Ettc+MS8uw5NPnYID0
 BI69A/yBnZsbIHmvnuzsL3o+4GxUGgDj38Qd2ZM7l93MF8SMgbOkAaFnUJSW9yzs
 JPvpOQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0vqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f322ef7d3so237930585a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772127; x=1793376927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rn+Kq5gFD18bJTJIJ5GnQ77Z0ABChsM110IWiZWDoag=;
 b=YgxyNIl22C5YD7pXV0k2UjUVQBD5KifjbrPErqO8sYqFQTpzyr6JNczQfnm5yeIOGp
 3QfiHieiSEPNRCTDXINye/sZdeAoSsdmzwcCYiTz3jXm5+6YWB5jZ70B6vZZQd3iGPQ1
 5LxC82zaaWeoMb5UAI1PTw2LySu2mPJbRsEeIxiBjxXxV3U1nMnJoUr2SS4BSQBxg5te
 X9UckECqfFUvGguLXe+AZLxb9m+6u/7uAFo9VLFa953hhqfi7sdC9qeZPhVMDvKhagd+
 evUhTLQDMPC/INcKX7Vq+1t6g3nGIulSy89KBRhFNyX1wezFhGIXQe05mpc8DrMpegqL
 N3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772127; x=1793376927;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rn+Kq5gFD18bJTJIJ5GnQ77Z0ABChsM110IWiZWDoag=;
 b=xSZoKdE5chuYLkXsOAAOUlcwQLe2xo/m4rNzMDrIBmsYOgbTKIY47dDl15HohUWvg/
 TH2Y0UIWnWCSh8DmRY+IrDfTcTwQjgMY2orcFv3UVu8DgiEIc/1ROSeUD4nMb0R3bICc
 pLQzYagzsesoPfsN1YR74LkUny8G3mFyMcLAv/WMVTOO9thZs8TAkhQ0F21IgRxKelzt
 pQEpu65Y0EhFYPc82IkHpd3vQjbTR0c8VW4QUMJR88dnkqSAIGsGNs/ZfE60EUBTeSBC
 FKXlSDob0eY7RpjIJFO+Iu/HBm8LjzsOsarmV5iQ4Rf/EnOvBDtDk1CZ4IQVcn4oam6X
 fd8w==
X-Gm-Message-State: AFq9FYLugg/fQXpybBEIpioCBSsk2TGCgCVRmMAmngL+49RjwswhjS/z
 Terepp9+ftWFTXuSBH+7bjW7CgJThDWO/yA11Qtcal0oGl4NKbnaaxmAYt8qhR2CJIrD/pzjTLf
 BT0hSVh6uCOvJlrn2AB2MOvAOo8wmelG84WDiKKDrhcZxnEHK+5/b7XWoLuKgY4GAmbBm
X-Gm-Gg: AYBFou2hzZ7CZv0hKZojOlBuc1PBO11+iKR/ahwtAN+Xp9tedzpU3bTi0ISiZJoh4AN
 NB4+pYr3PdwwXThcny07TMnZ2GXNHUUHTiG1wkrdjyACl+HNtV76BhSb7fkRzv1XncI/bi8N5uI
 r2dbdlj0BYlI0CgdmcGAw2owfWT6xHCphy8isOMMy3AHrPYUI031CjW0etq3SkI1fpGWqyhE9Hq
 e9fsF0PC1NZH+nM47qAcbBG1YT6gwo/b/0vdxYu5wV93OsNaJ3JOSvZK9er7qotVFBKdfcumVJt
 krfVml8r2p7E2U6HLAD7XnNQv8d73F5ZSuHHPmvY542iVCM/+h3vt5CjkJ9m3iAhhWZeLihAyQP
 Ni4ojf4nS+c4mVPhQW89VsX0oM0nT0YvQF95xb9Dk
X-Received: by 2002:a05:620a:268a:b0:93e:c12c:9b73 with SMTP id
 af79cd13be357-93f6f86ff8amr484643485a.78.1792772127035; 
 Fri, 23 Oct 2026 09:15:27 -0700 (PDT)
X-Received: by 2002:a05:620a:268a:b0:93e:c12c:9b73 with SMTP id
 af79cd13be357-93f6f86ff8amr484636785a.78.1792772126415; 
 Fri, 23 Oct 2026 09:15:26 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29ea6817esm25937535e9.15.2026.10.23.09.15.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:15:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/83] target/riscv: Factor riscv_gdb_get_reg_mxl() out
Date: Fri, 23 Oct 2026 18:12:23 +0200
Message-ID: <20261023161332.60153-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXx9O95GZIRdOE
 JPK73KcEs/iC6gS5cZ8TltRcEQmNyFQ8rOJk0W07GKJGp0aBf3DtZK7iKE0taSBjzOT/e8z8meL
 6OIPsZJ3A2zUz8gM+PZsmp4qqPuVhf0CpSOwOeHKyspG/0SVGKd+rtt7sMrQYecO4xJ3jmvIG9x
 20JXdq5DOlJ4Fioeg70YpJeXfqsnHX9XUbdlOeIyYdPcIYcIcE1MIlJDlVlnqgj7tuvv9n3DMms
 lb69FMV7+cykkWKI2pCYLeGlxme7VHielHqVP7Ysk0awDsWKJe4hF3/W9ruPuslrdOjAUWtLmxz
 wa+qvA1lMc87pGi0LtcSKB6K8MXOhtgtF/7zPGn9WraTkTrfir7ngvVBXVHSDv5TC4n5mXbbcX/
 06/Z69DNI25hxWa0/P0Ud3b9zU4c+BmIJsrV5hb+Gt7xjhBEqDARmxcVU6Gu0e/olLjyBjLorHi
 P+gtFSkjY0IFAK6LDeQ==
X-Proofpoint-GUID: m935Q-dYoW1axD9Ss0cfegog49ldnZbM
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb881f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kwaLHQ4QKy_weq3lhsQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: m935Q-dYoW1axD9Ss0cfegog49ldnZbM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX0zmzGiuGjzpA
 kmXnSWxtzHMceyd6zWld9/k5m3zkPVyfHTOp+qbQzxBm7X32ipRketjtVIEY17ORIJdBmZuOgFP
 NRlumdC83eOl5CyOWCdiuDiG/ZSGRuw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the MXL-based selection of the register width out of
riscv_cpu_gdb_read_register() into a helper, so it can be
reused by the following patch.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261007232326.66240-8-philmd@oss.qualcomm.com>
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


