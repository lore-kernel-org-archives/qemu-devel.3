Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A3CCCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmTl-0000mY-3r; Fri, 16 Oct 2026 14:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS3-00079v-Bt
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS1-0000YP-MO
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG3YXi3260302
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Rr+mH5OKHub
 WSF+q04SoQLr92hoSziIdeTaoq4ksUlo=; b=p4sUeZiMa4jFWGS0H3VLvDRDhjR
 CY0WIQbexzuJHwrqxnHo2dWF0NoUvwty6q6RJ6DLpEfmNmdYiJRR2jmDOfGNaAFP
 ypPVjhzzpjsNLn2t9y9w+Kb6hJvn8WHYz57NaWqY5P4F7zPt4K/DebDDYVJbBBxH
 wub/BVm+V1zFgq55T1JDMTBx+3gIwjumsu1U/h6omMaVi1vzHfTqqOSmq9AlN1WI
 By9Y12MEfYJUhqGVhGvVrGvR/rORfprt5EQMGShqfhD4G8hTe1+44pvUB5+3yNZN
 f4zl0IugImKAhzV+iJzNp22PduXPB/RxiXmnLSbFFkuYR9dHsjJFf2YYfoA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450gdv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac450b74b0so303076a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174480; x=1792779280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rr+mH5OKHubWSF+q04SoQLr92hoSziIdeTaoq4ksUlo=;
 b=KKuRt6B6Hw8FHQkG4PwpIZNCSpCNMabj06FfLIdSBXD8/gwDSqzA9JHH5c0DOu4Jxk
 D2KX+dArSxpsiCRDLnk6hBxmODL7cnDdzsgKaLf41ZvQjih1aN9pjQUTPbBtq+gDkk4c
 +Lw++ikXIC/O6TztzBM2ukEqY3B2zlddBMWeG2nP6r6pkuurKk54b8oGsbfc6k/tTapz
 IfD58wqMJ6+UwK1p6UoZFGc2RykXAy6OnJTFtAPukQgLbIhI+Zb7tCnSeuDC8J501uz3
 CZK0oME/cb9nsip4AjzECKGvJTKvxhuHXNi2EIgyQPnaTZl1ZHu0aeNsGK1YAdK31MWW
 shDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174480; x=1792779280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rr+mH5OKHubWSF+q04SoQLr92hoSziIdeTaoq4ksUlo=;
 b=R3heP9e81SntNq2lf+cEi9fYuiOJbjyf8vA+Tx3GGOlzViYiMPnoWa5lZY3BVyxGyR
 Pp8yi7o2obTEC4OgZidx+/C9cWGLoCUiuHG7HcqhMXbbmuj22jwY8f9KGbKEhnTvazs4
 2ycLf2WA8y9Gd+VhbDYrUG/nV+Or0jSeaOSrbxgIY5PjQ4txw+62aMkeFcJwAcg94EDB
 6H7x32U+DavlLs+lLXqI+EDwPjrsFkPU0yN38i+kMxk06JlrLpXfhyn3Qh9gOWwRzIVW
 2g5x5qNL3kiatO+T6DfAgaJ7+kravoJiXp4KjFTk4ESQsBGE5DHZiLzY4aGdpEWCCH7z
 Lotg==
X-Gm-Message-State: AFq9FYJztpFNyOmnfdghwv+hty/15bTVL96SN+4xN2ncFTQ+bP+bDECl
 UXrJSuZ6XV+uzUVg8ULNCJ6VeapJSVGCqQwjehXxFzlftoCnbCHCh0gP+DLXeEjSjDE2Y/95xcu
 4/tEvYUO666D8PcFoN25lxf5Fn9vRxQsmSJwOqN+6PqyZWBV67wEymrVwKEoI2xuPWg==
X-Gm-Gg: AYBFou3QRro2A13Dr9hbjmPWQt9p5FdSu8YbvqRj0VztqFd6FpZChHQDIlKawM0z5dR
 +MABQXNVwe5YRl36ozk+ZXfZdvDUVImhI37D89JDOSEL9nHwk5lL2aJfgYzZVbI6/aqVvZde7mN
 gV2xyYKhQJpdlsNRDX2LGrQISrbBfd5dSu+v4zWUuYkr3lBpQW4mp/DqFKHqje9maPwG6lDt3gV
 cYFb0xuwDATp+xwkmyzHTGXYPrBFhgi03dZbA19aP1QHtEVWawVWupaSO/EugwCaUWEnUHH7A4j
 TMvuz8jHUtfnKOg37FrPJeBUbhmCap6AJVLbO+fDAClRZxhv9twwOBh2WJD/i1zBBQSLuQ2p86q
 36Qlkkw8tjGbXWwtOUE990uM74AyCWmCnj4ZDtQAhJ2zM9OY1zY1D+c0MeeVLg1A=
X-Received: by 2002:a17:90b:1c88:b0:3ac:17c:6e8a with SMTP id
 98e67ed59e1d1-3acef4fec74mr531635a91.51.1792174479754; 
 Fri, 16 Oct 2026 11:14:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1c88:b0:3ac:17c:6e8a with SMTP id
 98e67ed59e1d1-3acef4fec74mr531621a91.51.1792174479284; 
 Fri, 16 Oct 2026 11:14:39 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 16/23] target/arm: implement get_note_size sysemu op
Date: Fri, 16 Oct 2026 11:14:03 -0700
Message-ID: <20261016181410.191743-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S7rjNA9VWJzTLHwuXg2gFiejWwFXA1qu
X-Proofpoint-GUID: S7rjNA9VWJzTLHwuXg2gFiejWwFXA1qu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX92W5zNE8MzxY
 QY3qaAyqWpWggLuYQpLvaXTfpQ3YddwJIPOuYErbcaXEmyRcjEtefjhcWEAwbOYPjIac8aRIC95
 meK01exmH4Kf9DE+wIFlZTkMUU6Vo66pflO2AHAzInLsLhs9lF2RvgzQ9gS/S8Gq4mDWMJDb238
 5+/o3nXfxsggo7wkAetntpVG7cUgUrl16Q8Oy5X/QdEhlxOEJL9SpHArip2xv7oqJT9270C9zL4
 SEbE73P0oJl+6AywcYYnebSfKxk+YqaGUjjdBenbcMFqERyHC2abZ147kf19MtZWkAm70L71tQE
 0JvpD62xqQmqCldtC1PtWPiHwFMBQ26LOMY+orkqSABbpmwWPQrYpT1vSVO/tr/UALuxivOxhzP
 PPEiRqHicm/CQl9gnp4zPEBeTlXXNNbaapuuSKLSExUnome5Cy3nBud02jTKw/vNoNtR5q4ST7O
 mfOE4shk9JT6XG3aBCw==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad26990 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Vcmh8FhFDDEcUw5d5KwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX25TMj2mcAlZz
 e9t/DtC5XpJC8IrfUC/FPpzcxnAdikhwBqQeo7vTKdHTctyEG1wzBXBYYAylOUfmg+hv58IZ124
 SNOP1rri3cr1amFB06ZBtrrvqtVa3VA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/arch_dump.c | 10 ++++++++--
 target/arm/cpu.c       |  1 +
 target/arm/internals.h |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 181691b81c6..60456e81bf8 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -432,9 +432,10 @@ int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t arm_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus)
 {
-    ARMCPU *cpu = ARM_CPU(first_cpu);
+    ARMCPU *cpu = ARM_CPU(cs);
     size_t note_size;
 
     if (class == ELFCLASS64) {
@@ -452,3 +453,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return arm_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7bf0c5e74f8..73fdc6e460f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2570,6 +2570,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
     .get_dump_info = arm_get_dump_info,
+    .get_note_size = arm_get_note_size,
     .internal_is_big_endian = arm_cpu_internal_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 61b0bbf1ba8..8e4b8f585e2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -440,6 +440,8 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 extern const struct SemihostingCPUOps arm_semihosting_ops;
 int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks);
+ssize_t arm_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.47.3


