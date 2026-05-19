Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5B8CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 11:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPIwn-0008Qe-Si; Tue, 19 May 2026 07:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wPIwh-0008PM-7s
 for qemu-devel@nongnu.org; Tue, 19 May 2026 07:49:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wPIwe-0003iZ-0r
 for qemu-devel@nongnu.org; Tue, 19 May 2026 07:49:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J7hFLF1146425
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 11:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=82xRTW4w/zuAvVx5lLGYIhQUvOzYmJfzQ/I
 r7Ofnt04=; b=cCYXpiDOZd/bFux5ONiektd/M7EDX0ZCTuVJFKDKGp3AUaq3dDt
 erIBog+4XTMLxIEQIlM9P21NG1jlf6+IoKxNlnwA6TTRkugZjXZmShKPNQE5v45b
 KQRRQopaobZFJVzLoHwp4hMLj+Rr28Bf5//8+q+JN1uplTzc02IAmEGYaGlMXrS+
 g3hZ0MgftQIOigk93UuzhXKQ3oOklIX3KDVPx2YIjA8aTz8bwLA3ECB/w6nMMJMB
 WDMgoZlN1rQbOZ53CseykvLKYsqH7LXzPiNZbRTtH+GhGlFkndlg1nTEjOIomLOe
 BvZJkGzseAuOZEuLzXVUjyKYa9SNVZeqP4w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8e7ejaes-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 11:49:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-913dbb7a318so730657385a.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779191344; x=1779796144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=82xRTW4w/zuAvVx5lLGYIhQUvOzYmJfzQ/Ir7Ofnt04=;
 b=D7ORdIQQLjooKcEAkcf6ITjE1KgrjJalS6Xg2lgdI440NDtcTT41iSK8udXFhOQwB2
 y702hLq++gP3mlZHbailxKpk9f+QblsxVcsNcWBlPUedjze8wePy+5NCAobIUZFvwIt6
 QZnHs6NuUsKQDK9ORjAohOscBYvEkg1oyEqy/ov2Ua+Jzj2eEvo+PCnqtE5qgr2hlbEd
 d/ToFs2Z81kS5Q3U7u6Ld6WvAM3WS6FBMpXv0sWGval4vN4/mHLMarwVF9LeRyu2R71J
 cH1ebMuBstMntgVf1CIelOur4Oo/FEOnxndZWHg3xtJi5lI55aMpPnnTX9xANxQvaZxq
 ss6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779191344; x=1779796144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82xRTW4w/zuAvVx5lLGYIhQUvOzYmJfzQ/Ir7Ofnt04=;
 b=gjUs5DhE2py+EjXw6Q1cfR6RTP10rvFJkHDwrBHP5Xgjy9INGO3BAMusVD0s9QtM/j
 uDwQgErF7LKao50Z/WAnO0uedgWBOoQK5O+8RcktgptkhbxyDGfjDvdI5o6I1PWw7SYF
 FCdzPhzQWQBx1bJkXMyQ/kIyJTjRvyrIvc18o8mrxC1nw+ZjVYsXlgh5nGd6MLHjBwgs
 zEF9hIxHSHjbCvb1MYlhUVX3a8ozdNJYu40NB/NzpGK8SQZJVjK8FNCcXl1jaVvHSSA2
 UBYUPM2heb2tGbfyqNgIl9zlCp6K1NtXrvCp2kqvZcYj9qOYC4dP66uHF2szZFRSSTLQ
 wd1w==
X-Gm-Message-State: AOJu0Yx+lFuPhRatft6gT9Rt1C1jeLpmjAW6K0YYfq+mwg5j2tUEBNYh
 so9NWXUVv8J3dKdSFyZEdqra5UOhdSWBN1Gs2TkVoxy/i1Dxs3sbbq+6yrtpIJTLe4E+iIMIKqE
 Qunbj/o8BMoL59tadNdEp5hHhcNAe4wi1JeeVe3KM8BXExRqWuLxz/dkX4IRcnsCrKg==
X-Gm-Gg: Acq92OFFetr3nOkzm6xClr6Hfaq8FI9p/J2d0tCo9klR1fVMz51BlflBf25etGs5HND
 TB2G7heJJDPeHVWDE3qLmBqdKHYgBcqq18sSCbK7dbBNEQRVtLZG6iyOHIIsqK6+ymjQLHrxIlh
 nYjnA0yG8Yh3Da+e/YPdrC+/7fapAGMmnevRK96QLnDOxe3uEzgpEzFosEfHEscKu38+on2RghV
 vgEAaYFeX5UqSHK9MvTfjgMP26w3k0Dusz7O2FqN+0q1TojmjsqBF10+hDKaFdg6pFJv5xuj4J9
 ef7lP8FXCLEUfapzTUSIcWJPt+VMdEjBUGbRscCfM7CALg3z7qSB5wjALpfL8CjqKBgXr8vaqMP
 BiF1yHcnQ05hbH1MktpV4nI7EGUF+H/746EVkV2Fg3kxfgTBv/sIOnrMb0EsH
X-Received: by 2002:a05:620a:576:b0:911:fba0:6d02 with SMTP id
 af79cd13be357-911fba06f95mr1769834285a.22.1779191343698; 
 Tue, 19 May 2026 04:49:03 -0700 (PDT)
X-Received: by 2002:a05:620a:576:b0:911:fba0:6d02 with SMTP id
 af79cd13be357-911fba06f95mr1769831485a.22.1779191343265; 
 Tue, 19 May 2026 04:49:03 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bc83bbf5sm1811123885a.28.2026.05.19.04.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 04:49:02 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv/tcg: disable svpbmt if satp_mode < sv39
Date: Tue, 19 May 2026 08:48:58 -0300
Message-ID: <20260519114858.316532-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rt316imK c=1 sm=1 tr=0 ts=6a0c4e31 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=MHX4bWYPuQW8d6Bq3KIA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Z2Qv0PDRabr8GQCzk_r8o-pzvYA_dfnR
X-Proofpoint-GUID: Z2Qv0PDRabr8GQCzk_r8o-pzvYA_dfnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExNiBTYWx0ZWRfX+LIkpyeiPJpc
 HiCBFI6BGXYJ3p3TonUFyzNwMbjaARQTTMfAqQmVNczj1HNuKREX/OelDSrGFcq3R9KQwo/iLc8
 w9xV9TodxA6goYClHp3AlFiV8AA9QmZlVt43csiqSvIvH35hhhf2h8I5CS6vTIgO25/hMY07yB1
 6DjCNhBGhkYVrQ6MFpt0DxASzlwtGgL8pObUpDhx1ZUKH+3rC1aMjtqqcpXKrICBLOkOMf3ZUvd
 h61QqrpUwY4t5GlNYdwNZ3Bz4oCSxcwylJL4KwbG2Is16fC7gV7ENzSKhKj0kcKgtSChKGgjMYd
 zMKHHekk5sfoSHv1M9+thIRQIbiHagVCo+r2wrpPe3xh6PxjzAc2lnfqcv/XKUXElcPBLkKSf5w
 5yfODYH4IQ1M3x+73tAynfWy9CRdStqZJB43tp3vKUaab2R54XQPkjI95O0kxYHQvOpqKMlTMDj
 8AiJYrKoOQR80fULpgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Priv spec chapter "Svpbmt Extension for Page-Based Memory Types, Version
1.0" mentions that "The Svpbmt extension depends on the Sv39
extension.".

We're not doing any satp checks when enabling svpbmt.  This causes
problems with the riscv32 'max' CPU that happens to be enabling svpbmt
even though it doesn't support the required satp mode.  In fact all rv32
CPUs are allowing menvcfg.PBMTE writes, which doesn't make sense for
them in any circunstance since svpbmt is not possible for rv32 at this
moment [1].

This also impacts rv64 CPUs that are running in satp 'bare' mode and are
reporting svpbmt in the riscv,isa.

All these problems can be solved by disabling svpbmt if satp_mode is not
at least sv39.  The problem reported in [1] goes away because we'll
never enable MENVCFG_PBMTE write mask in write_menvcfgh().  We're also
become consistent with how svpbmt is enabled for rv64.

In case the user enables svpbmt in the command line using an invalid setup,
not just disable svpbmt but also throw a warning:

$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb \
    -cpu max,sv39=off,sv48=off,sv57=off,sv64=off,svpbmt=on
qemu-system-riscv64: warning: svpbmt requires at least satp sv39, current satp mode: none

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3473

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3473
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a358d91ca5..5b3e36d9ab 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -887,6 +887,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_svpbmt && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
+        cpu->cfg.ext_svpbmt = false;
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svpbmt))) {
+            warn_report("svpbmt requires at least satp sv39, "
+                        "current satp mode: %s",
+                        satp_mode_str(cpu->cfg.max_satp_mode,
+                                     riscv_cpu_is_32bit(cpu)));
+        }
+    }
+#endif
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.43.0


