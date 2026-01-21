Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DD8C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYT6-0004vD-Ta; Wed, 21 Jan 2026 08:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSz-0004rR-Lb
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:51 -0500
Received: from qs-2003l-snip4-11.eps.apple.com ([57.103.86.123]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSw-0001ER-BT
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:48 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 A6143180016A; Wed, 21 Jan 2026 13:41:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002905; x=1771594905;
 bh=c9xkU5JKUppgK3M6NvIGvHRbHv9MZvro5B1lYG+DJ2Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=G+UQ8ZVnMlJCXr0J1fLwY349WroNODI+TFYDGMTsuQV3TYd3PhLlpcqSs0cRk2Mv8JgZwkpa2sCZYeGo0NrYBXbUbST+MKuU+45D9zpPh7PaYv+qSHheryplHSgsXAaYGWPIi2FR0uRNsWqTXBZj79HhqNY9QK4lD+Z7THpWoYmQW4zkmAjzyYrEw1ZCydclJ4O3UF6Asf9wUL7kxUq8TAzgtYR0HAW17Q/7zjdaKNhPIbDoyCT5WC9tKcWeBW7m5M2ah/jBjw3iQTZuRaUgDYEZqO9kcN4qXjp7IHnpdrwDINFwM09tHVU/1OKuxQgbKCqYFtDimsCOWJDr13U//Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 CEB7B180014F; Wed, 21 Jan 2026 13:41:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v17 09/21] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Wed, 21 Jan 2026 14:41:00 +0100
Message-ID: <20260121134114.9781-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FMn7O4150PHulI8U6MEbuAkZGjYMxJPF
X-Proofpoint-ORIG-GUID: FMn7O4150PHulI8U6MEbuAkZGjYMxJPF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX01IX72lPSALN
 NLKyolT+5w8AAniMrUmbjf0vrdwisRQFNlclNMTxDPMjBiP2tTn0a6Fcptz5S6/psG8Zt+GfAUx
 AIotEBaG5kRe1Ekqb9iKltp6vgONMCRUL4r/KuaAhNXIWGrzC2gOVn/h0nJBRfd/ypOErCyiSjP
 81EQBoGf5C4kn1N97nTheCqXJRygrzaunwvakjTKjKzw+MVBoOi0HL5oDDOVvetp36YAGEyalvV
 YrSWw/NPABYaEZBuVxKoY5h4NTrL2S1a86GbjS8c+NCf/M/S1HKQu1t80fOxmoTuDz9tx2oO+8I
 AisUCbRTxajv86o41NG
X-Authority-Info-Out: v=2.4 cv=afhsXBot c=1 sm=1 tr=0 ts=6970d799
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABHiyEwmvyWiQ6BaXaAa+CFjYIjUJD1x+81PIQU7B2ac2U2wkmSXfoIu4dtZktEqY6E/GzE6wGbmSlDMv9uSJvMBHuTfcAxB7UuI8HvK/MaQjw3ApSAD255YD3C1oTk7fD7OMlJMtByxwVc2p9jc14fIfXy+kfdCp7o2MeA8id477SOAHQjreMB3jQsm145eDPqBCHQs9QbR7a7a4aFVaMhi2UL94L3ZLN/nhAJrjc1j5hububrWvyWdA6D6bE94T/JSuR8pncIBL/dVko0DwvjovtAvgH8qe5HOzexE4c/dsmiHrNtWd4y5t6xeaB7XfJi6ISccb23JHUE0c6/+G0fpFRuGRUyRvTsdmOhV2b9CZvGY/utafmugCpDV4jjJjAabxZdTJ9PeMo5gsEeNVTbRLWupbo4uo0UkBGh3S8yzPQRReTbXW6tMrPvkguD3hb8nQrwMif7RsO2eQoysuNbz2GldxMnz3xOlhKMy7GR2Jh8Ky1Mk4+Jk1BoRaooAu4VjoIUVMfH0pBApmJ8zj+AecFm8gf7Lde/GjmICwaXVbUIaUxwLLcOp76anNES7jy8LX4mlbu6Apyi14KMrkEexon9u52uqjv0EdCK4TOv2dTQS0xdUtz19dkx5k4fiC0uv3mmuMhfXhAJGnyjO9vCsQN41H8kNEUF/8LZHmIFejU4SxqqpR+8rYLvX1QFTL/xBy64i6lOpxnVf1T2gDJjZ/PxhhstUlGGvZdraW+L1SjdGaojNmjrJ5xPc4baxH5cqHQ5C9KZ1VDV9JsDAsBC5k8qWvHLamuChh7VFV+qr3b5wuRYTaZ7o7myHl709P6Y2kk0ERaoqxrdyiyq7BeySNk34rKr5XPKIFWnh0F8QDeEM9N6ccfisvo2O9HeslvS4+96rdAqPKmc/K8
Received-SPF: pass client-ip=57.103.86.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


