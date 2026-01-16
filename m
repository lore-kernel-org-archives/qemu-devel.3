Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6521AC79FBE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkFu-0002tU-1b; Fri, 16 Jan 2026 08:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFr-0002sV-K0
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:47 -0500
Received: from ci-2003b-snip4-2.eps.apple.com ([57.103.91.143]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFq-00023l-5b
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:47 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 97D4D180020A; Fri, 16 Jan 2026 13:52:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LjsE9MwZeWl6ex5s4DyMRNt53cRORgqXLN74QeacFr9hx8z4sNsGKlWgDCcDSFn4jOMGhSQRX7OfJVtiXLvjkXQUa3jNjXGtYjK41okKlURRW//NhlScewk+FounwY4/jEYSnzxUBia3jWXoKq4XFjJ6hmX9n6Ngcbieo2T39Or7eVmyw+YulajeKqBGaqgbWzN5yOvC32TRqGfn5uzCdKGklTsVg+RteTwyBa1uzncOOu+rYwIUsDQMVIf5ZjT+KVinMhAcxUzGpz8chHDTlt8AQLxl2OuwuVxuTZe6AhRLMbDDpQTNYH2xKP7SMLRJyPeWclVQAFRs0VPQOvFe/w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 D89FD18007F1; Fri, 16 Jan 2026 13:52:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 01/26] target/arm/kvm: add constants for new PSCI versions
Date: Fri, 16 Jan 2026 14:52:10 +0100
Message-ID: <20260116135235.38092-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX2bV8hADP8fPk
 Aae/zPOFscAihtEVnAv/DSULSe1aMONwThXvLTzMHo5o1tv/cyQ4I8SOXN1RakQDQj7ciJqfvsC
 +ZAOtb69BYkjvSHaO7LO5L6anX1gNe8bMoaH7oZRQqmwQk2HuuJsXgU6wemLLZmjemRy5dxTRfC
 VmGSHaJZZzTJqI2/NMtgWNEHDb0tyOdO/OPDV+17BxCGZMOXbdC4e5jud8giW6HxHaoSjV3ezaV
 3HtsVeW1B5ffNCeouPHG/5nFB0MEcX55FS4qDEg39CN0AqKcKWg6BYO/9QOVcQtgVKvupK6Cdju
 vbojavULE6X/0gQjzXA
X-Authority-Info: v=2.4 cv=T8+BjvKQ c=1 sm=1 tr=0 ts=696a42ac
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=DAm2dGrMCKCYv6Tpj9cA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qgyhaYsES5xwQg6MLArLNa9_Yzyp8oDa
X-Proofpoint-GUID: qgyhaYsES5xwQg6MLArLNa9_Yzyp8oDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=939
 malwarescore=0 clxscore=1030 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABquP5xaAzWxHEwvIP8LPZLpAH9+37B7XOMrfemLHVzx5Fe2Xe3ePtlVUoWEORS2LvoSIMbkdPbOdNpIflLGmLg1KAT7sOxls6QDK03PcyyegCRHzHBRvYEi2q/LlnP6SGFRBH82Djp+oUYeXu+9czKbteA8KggqA3LnalUBY0F5Zz+dkAbs59qkCJJ5nFCHr+sXmNVxkqI5q4DipVO18X/SYekd5Una2g16bSWrt5nMXauRllq/CFu66aTjwnTlUtQPGyJNaBi9Pt7jAaXqaYhHumY8r00WI+t3ZdjqJOmhAty3xCO/fb8PyOc08a99tgYTY9XQAXxiz6AfS7tY7SC7UlyhTkt7go5pkQRJSyaPwM/u2D+YE57ZarW3ljw5r9vxzQKElfjq9J/bCXM9fUcTa+YRqaMRi012zd6X48JkV7Canv00dFoL65T6heJSdkz7nOaNcWGe1yqpjNS/RO9F+8yMaB50JKwzIXRyiS+lvAEdto5hammNy5+KYVv69sVWi9eM7r3WjPYVjR0t0uA63aM8KA4vD0Sp98XFBVKfMOCijwJETyucY77778YmH/9FFYFvY1wBXm2DEHEh1+W4/KXtIsB9bg8a8+XSUKGM1jvUrKffKacsgWKhA+b5vIXU05CXbsddfO7rxLGpdvqw1M1AfBS15ASP+i6vMtOJERmbTmNtdQD/CMkf3gJe1iKjKDyRK+JEuaVswBJfwpYfNVfFOdmyQpdPuWdsF2OZVeSsEQWZ9Haxw2/L4/eJuTVi+ZCn7UcKis85RFF7D2Q2cCQ+S/73rXAmMy6S3mkBMCSC+cVQY=
Received-SPF: pass client-ip=57.103.91.143;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.50.1 (Apple Git-155)


