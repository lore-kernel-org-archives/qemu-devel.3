Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE8FF01808
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ5O-0007is-4V; Fri, 06 Mar 2026 02:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4x-0007Z4-Uy
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:35 -0500
Received: from p-west2-cluster1-host8-snip4-10.eps.apple.com ([57.103.68.103]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4w-0006Ct-FC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:35 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 B87C618001A8; Fri,  6 Mar 2026 07:58:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783913; x=1775375913;
 bh=T09YaB2jPYeKCsoJalctReTDeuCKV9icg1YoMmiUMB4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Gc8DfRPUG5HSfCsYrvHvbu2CyucgwNfGdFxiDh4D9dWKfUCM7RZ60VMXx8oJF6YQnC7nQ+FqFAkBXrZe0ibHGlGFYF1UIyEG99Z34lr3DkVy3v+xiCN/cKZn26dEhqKNAodRB8zOv4cCgQcvnjWa4nEwPI9vfrZY5cEdaAM2cR442HCD7MoiEofRejirMys4tGgVispJXA2uBauX4pG6WHVrRrurGe/Lm3Ya9SyqxO5kdpyb8azmHeUUeEpt4EK9wJ41F8nWK2FCnKEJ0EkptKi4pZJFolSV25xk2y/6lIJR9ImRtF390h5xmFJPZP3/8O1ntBlvs8uGEMQYKXD3tg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 76745180019D; Fri,  6 Mar 2026 07:58:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 12/17] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Fri,  6 Mar 2026 08:57:51 +0100
Message-ID: <20260306075756.88922-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX0Jm/VvE4kEic
 NzuH0ga61xsZ+w+f19dpBLZYPToYUiWxc276W+BaXoMCpG3PSPDloiJUYumOLHUNTaM9k5P2U3T
 xzbOFrKYx/l1VvVLDPlQJyTXBCnp9OY/LOi9X/sr115k7FW7J4q447ulTUVt55NjHXzgJeGO+Zh
 Jx5oisNWybqZAaYuGzQv+RJ5TTFVfDo8/RWS0v7PdjS0ZevLKNzKo8qk3TJlYBaN/5s7qg6PNAO
 rZiFHfTZNS/nlpZE7D+h0Bsnzd/4q4XltWGbsQmSXLqtQMdqQ3HKvlu8goLH3b35TiEN+5Dmbzo
 HXs4l5rKuwhtVyRrQOtZKw6UwujP+stSWnYniYCxa9swRHf18JEd5Ef+NqaYUA=
X-Proofpoint-ORIG-GUID: UAWc0SqfZ2LGkMZd9GkLrhRB2Atoq32X
X-Authority-Info-Out: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69aa8928
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=vbFX7M0ab_H1AmF9bzsA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UAWc0SqfZ2LGkMZd9GkLrhRB2Atoq32X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=563 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABbsj9Fi+4zuZg/r9jlEV0CxyUxcj5lCuJdF6ug+8OgYQQAUKu76UTP48cGIu/gO8PgXF5qv6TvY/O9r7bmY9BuLHZPSoM95P/WfxYHu2M7tAeJdLiBmQdlFiC3uvncEHERcnHr9e4dZXy6wETGxgRAyWyJGttIF2JAciE9nrCrjC+RKt8bImU/yl8UqiEeJxvhpEmOVQe2B7jXyhix3RqmG0P1HlqW4bTcBvb4ID3PQ0w+Uy97StrSosoKWDFElxf+3h1oae3kh/XrzWWhmQiW7IU7RbL6L8eOIky70VCI+zibk09y3t6Qd5QLKfQIQi7aVzm0bHl5fW96SHubtyIotipK/1V7TesNpoagths9oog3Is+njWYRYqzbW2wAlZvWr5B5YOwbdR3KpbPA2LkBGVvpaFn6LIAvWD73RMcNLflWMKPDZRbQok8HgUXSkife4x8IYk0ztPqLDMBBrn9xWwwCtZalX0rpmPFdgnMtKH5gZA8sjjx+LA9N1ku/wDs5+6til4630MwY8UKdCZTRsMpWVc4dag4j/x7DsXOVoLvMHkhLndIRDpW2U7Q4sYUzrXriKS0PaivYc/U9ee94ynOuGuOmP5QcXEJf15w3j62oYDzQGMCMxC0JloqD+I6IHOXpW5JK48QScejA8R6eumAVjna4yvbxcew/VDeADXPT0LoccqoRhDwKtBmJK6XPUydbZGNZo+/VIUUQNr4XQpMFs7d60TySZ2hco8itFCwIXr/OMA=
Received-SPF: pass client-ip=57.103.68.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 212efab731..0c96119ab9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1647,6 +1647,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1937,6 +1938,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2344,6 +2346,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


