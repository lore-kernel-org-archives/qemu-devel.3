Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C43D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXaQ-0007lL-I5; Thu, 29 Jan 2026 14:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZW-0006Md-Lo
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:55 -0500
Received: from ci-2007k-snip4-11.eps.apple.com ([57.103.88.113]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZS-00061s-VL
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:54 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 C2F8F18000AA; Thu, 29 Jan 2026 19:20:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714450; x=1772306450;
 bh=mBFnX+1GWKubPDZlgEM1plJqBHQoJzuLiKUgkg0UYPU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=IV4X4QAtAr6x4AP8rEPayxk63BT7tN0YdRzBQYfVNYbpTcuulwJuh42+TgW/TrxOgYtIxA11hjUU9fIScxE1X7/H1LJXXwgyz6q59H4gwhFfb9upQFVWODaMmugpZVSSjzhQrtdOwlwLRlcjRpgunCtQmRweFeOPF4gQGb7QdmhH4Sj2JJt0/8vSUfpoLillwuZkVXjsItM74ypQ4Q2DgW6AtgYZCxiGI20yzgdOvlBPOtYEXQ+5LxBOM+eZKn2qwEKhc/U3oG2hJzUmwv4f2s66D/Lqewt4be+mJtt1JvD8VLsQXNIL6jipAZqbHlS4VhvqpGQVUltjoI2FiAf+mA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 47D5418018B4; Thu, 29 Jan 2026 19:20:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 10/22] whpx: ifdef out winhvemulation on non-x86_64
Date: Thu, 29 Jan 2026 20:19:55 +0100
Message-ID: <20260129192009.14707-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AIzEqcgo57IvFJNMVjWwvNDBdWGQCj4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX/YWsRSdLJHTk
 qABCcwgnDXWlZPpykogsnd0JpJXTGXQte4O+sfl4ord7rkYjCrUQLnAyU3p2mpYbrDN1JLKhL4G
 Ee618sYM96OOLDIbcVUpfxLjSdaBBizfCpWVYVJGSeRAUj+0T6OVKMAMDByuchGLXE9GsYFHErX
 Y4S5WkqIHL74Pq5/sMG15mwZq/qbs2uP5FHPc9Qn+c+390C5mpqcVukxeU+EKZAzXHusR7x0g97
 RoUH9eP+Gss4OaYJMwAZ2ktB7c6n/7Gv6uiXxFVmjsAnmOtinpQEHGKFw40vx70Ec33pQYZZHSa
 wX0Kj4u9ypL2p+EA0ONMCaO/VK1cX0qQ1jYWSYtAX/yd8eHpdNgoKR00EmzVhk=
X-Authority-Info-Out: v=2.4 cv=R4kO2NRX c=1 sm=1 tr=0 ts=697bb310
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VExx-Oqz_yhFp4n2Ql0A:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AIzEqcgo57IvFJNMVjWwvNDBdWGQCj4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=940
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1030
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABCoLFaVQwilOKwGf4GTc37OiwlpsmMWbgZeDHRobLgGmVBUimnnC+xr+tMlvwvNjIfovKLXi9XEzgDWP36OqhTbimmvz2gQFHhkAqVWON4RT++TWhAtJ+a/QkPVwmgvpyy07ft1pfqzKwbm6T1ioawhSZ1NTSfvqCWNJe4jQjBWXKk1VW317bqKifTyNACN7mM0OFLO0r2uJMkbBX7GskY8pZJNlA1SRjMrmQuGrpv3qsmBuRlQkEH8ieASa40h83RCyrzXNbGA9HCAYeDst1lPfkyaX5yffK4IDuzZOc8050EkVwOlAPhBXACVTJ3B6FwpVgT1GslPR/Mp6/I5UgLe3hL6LswQNgeFA/jYrloTIPGsdzcZd8I1apmTlE3VCiwVk/jYw2dSJVegkvii4dvSCZeHKrEc4zq/T5cELU1anW4obcJyxyLpSaE6T33jzUNKLwtEW/6NR2CgZPGksyCIyUsup26c+eLfxZ3iD5yGplXmE6Uf9guj7eowwJVxXQvJnbeIZfMu9UVkIXyfh8KOx2uNdW8BTs9U+3e7hT0jlqPE+jwSJARhmrQDlTUPFzHXBi8k6RiRJB/v96vladiZaYb1NP5G91Zg3wIEMqBevdALdjLka7WROhHFyKNGmKROc2Yv5tasw0w/i30Yq5nj2phPOyu44ivgnXNdgdICpHWPlCg6JLDJ5VsZziFI+FsUMVzXYQK8K3cmttDfsF6BFw+nzCubntj2i9RRKskOq8fSFtmpxq6JBfSal5j97m7vhwehkDhdyiMhukSzn1r8AakdocYRJGMWVEsp9M4i2m20SXJiNuuaaYKHzq17dHWdjvuUzdA4W9ThRG9HsNUVhHZ8ODbIoQw/U=
Received-SPF: pass client-ip=57.103.88.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

winhvemulation is x86_64 only.

In the future, we might want to get rid of winhvemulation usage
entirely.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/whpx/whpx-common.c       | 14 ++++++++++++--
 include/system/whpx-common.h   |  2 ++
 include/system/whpx-internal.h |  7 ++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 0a6068fdde..c58344cb61 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -37,7 +37,9 @@
 bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
+#ifdef HOST_X86_64
 static HMODULE hWinHvEmulation;
+#endif
 
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
@@ -232,8 +234,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+#ifdef HOST_X86_64
     AccelCPUState *vcpu = cpu->accel;
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+#endif
     g_free(cpu->accel);
 }
 
@@ -408,8 +412,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
     case WINHV_EMULATION_FNS_DEFAULT:
+#ifdef HOST_X86_64
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+#else
+        g_assert_not_reached();
+#endif
         break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
@@ -535,11 +543,11 @@ bool init_whp_dispatch(void)
     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-
+#ifdef HOST_X86_64
     if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
         goto error;
     }
-
+#endif
     assert(load_whp_dispatch_fns(&hWinHvPlatform,
         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized = true;
@@ -549,9 +557,11 @@ error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
+#ifdef HOST_X86_64
     if (hWinHvEmulation) {
         FreeLibrary(hWinHvEmulation);
     }
+#endif
     return false;
 }
 
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index e549c7539c..8f171d1397 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,7 +3,9 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
+#ifdef HOST_X86_64
     WHV_EMULATOR_HANDLE emulator;
+#endif
     bool window_registered;
     bool interruptable;
     bool ready_for_pic_interrupt;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 041fa958b4..609d0e1c08 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,8 +4,9 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
+#ifdef HOST_X86_64
 #include <winhvemulation.h>
-
+#endif
 #include "hw/i386/apic.h"
 #include "exec/vaddr.h"
 
@@ -101,12 +102,16 @@ void whpx_apic_get(APICCommonState *s);
 
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
+#ifdef HOST_X86_64
 LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+#endif
 LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
 
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
+#ifdef HOST_X86_64
     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+#endif
     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
 
-- 
2.50.1 (Apple Git-155)


