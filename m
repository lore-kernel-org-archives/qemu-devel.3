Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=jZZ/HErx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDRx-0005kL-A7; Sun, 08 Nov 2026 19:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRs-0005hi-T7
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:25 -0500
Received: from ci-2005c-snip6-2.eps.apple.com ([2a01:b747:3005:202::19]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRo-0006L1-4i
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:24 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 0B21F18007E6; Mon, 09 Nov 2026 00:41:13 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-87e9-7cac-ab36-dade25a13657
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0cZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeXxoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184875; x=1825720875;
 bh=esa002n+umgb+uuAEw0alWBlRbDUr7KFNDpQLc54GuA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=jZZ/HErx1MYgvAr676Ay7RaqmOCwYXBiUf3WwgCTcfA+o9gjbtoIbZgRNdAsfr9sL7T7BZSlUS7EJcdPy1vicUqdLqUNYLYcqqLIeHfru+90LCHpTbANnpUlVlPWizjqKnKJoRimqaX6ytN9vDOHKhwzIFM85c30HKBXQj1rwxwpbxBj5LBYA4e9FIViDia4mhooqUR38Y97Kk5+LqCUR8c10nMVik1DI9X9AuYuwgsa9QU1dwjuFRI6MYhxsetVDC180F51U0YmVlq7EVEYGuGpRACrgGsx095Xgq41UJUsGsiAXdjvY7Nui2s1KMpFkscCyRJe7OV8nQsAnIPH9Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 DE94418001C2; Mon, 09 Nov 2026 00:41:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Doug Cook <dcook@microsoft.com>
Subject: [PULL 01/13] target/i386/whpx: fix VMX capability MSR values
Date: Sun,  8 Nov 2026 17:40:56 -0700
Message-ID: <20261109004108.85808-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX1UfzGPdpjBWX
 scuEy6DXlZLcL9qUEaP5//YUzJsd1PdeuBFub4bO3fetJubCGtByfUO+6TqgdIxA1Nj2eAjo8GP
 Y201FiGTbdkspEvk2QFfpx6sm2E/p0uAQtJd4wlRme4lMMm9M7tDk5jd+MWygEk3efSAdgSR4lO
 Y/imRFJyAMfTGmGwc3EyIHyp9eChDL5aCztHbcbMoi3BMtLORax6j38o+TOvYuhFF/XRpk0Zieg
 gcb/Oyu6ALZ7UnsaZFwkCmgj0HtSNcRf0obsx5CC+p+Ig0kxJals8/JN69aHgh3KJC4yR8ltz3g
 U2ak/PpXlSAcBLg8aME3KIAC+87TJtgJ6B9uS5OdfsU+ppocUUWCsUS7qI3gB0=
X-Proofpoint-GUID: hMErI7nlpnR6_WUvw7fF6gSBB0IHhhpH
X-Authority-Info-Out: v=2.4 cv=BNu+bVQG c=1 sm=1 tr=0 ts=6af116aa
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=34rDk-nlojoYW5TMjDsA:9
X-Proofpoint-ORIG-GUID: hMErI7nlpnR6_WUvw7fF6gSBB0IHhhpH
X-JNJ: AAAAAAABt0vtPz8qpWIHUdSCHhU68ZLhCEqDciYsdPBkZDu/L+aAPeNMZ6UnnRwBEjStjA
 4fI4nq8vSg4a9qdVKn6ad4drPTjaQOAVDoNXGCI+RH68m+phk+yhcAWxa03TmSdi25ukqt
 Q41fga26grMumaQoiH5DsIE9bDBmJ5duUv66tdWEuZCYauh+YSjVPj5zfjMcQjoD7mJlOk
 Zgx7o+B4tSCfp540QV6e0Qe1//VtOXawg2nHEShw8a8LOs7ydcSTINXJNHrPz2r8e3ykiB
 iIbKdfj9xBOetvZdb4qmOgklBfajunxSwd7GtGUUBE7d5hY3tVcoUwb4/DsnGs1MMZ7qLu
 03FRr9iTa4fEVeOyL0vqyehBVXYAhbg0v5E785B/A1gn7sPLALhwogQPKbloasQWS6m0uB
 a/NbonRp5v969lP2eGBQsW0xBSTzq5zfj5v2IO5TZetQ2ODJ5UPWmBFjLb2gAAoIiEYXpR
 hKqXL3PyTXYMRHgOA3vNPDAowNCbAp1Vy3qDZdem3hO/LMsItePsz02qx81wXpn1o+reuC
 S4O+4vUlszXtFVF6UmiQCN6qK87HsMyVxVcrtbCT+DBEJplGLYpYMfeI2JQos+FsZo8FX3
 oTvTrVxlE0uWMni410OTjgFFGIhGpCN9ySJxWScyD9SGoNezjHPMn5HGesnS0qAmCSwOM0
 uDXkflgTJmjSEDO0rr0OcDJP5xPIE4kZVp7tLeTpKVEqT83HTPzCKqotRxKNQCtr/PFg+o
 XKQdh76t4kLy/V6eIy+900HmcVRrX4cL4u7C5yFChTl0xu9ysa4ZOpFEe3
Received-SPF: pass client-ip=2a01:b747:3005:202::19;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Doug Cook <dcook@microsoft.com>

whpx_get_supported_msr_feature() had two bugs in how it reports the
VMX control MSRs:

- MSR_IA32_VMX_TRUE_PINBASED_CTLS and MSR_IA32_VMX_TRUE_PROCBASED_CTLS
  were queried using the non-TRUE capability codes
  (WHvCapabilityCodeVmxPinbasedCtls and WHvCapabilityCodeVmxProcbasedCtls).

- For PROCBASED_CTLS2 and the four TRUE_* control MSRs, the raw
  allowed-0/allowed-1 pair was returned. The feature-word code expects
  only the bits that may be 1 but are not required to be 1. Apply the
  same transformation as kvm_arch_get_supported_msr_feature();
  make_vmx_msr_value() adds the must-be-one bits back afterwards.

As a result, with +vmx QEMU treated many VMX features the host does
support (secondary controls, EPT, VPID, MSR bitmaps, ...) as missing,
warned about each of them, and dropped them from the CPU model. The
guest itself reads the VMX MSRs from the hypervisor, not from QEMU,
so this did not change what the guest saw.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e3e672dcd1..3312dd8593 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1452,10 +1452,10 @@ uint64_t whpx_get_supported_msr_feature(uint32_t index)
         cap = WHvCapabilityCodeVmxEptVpidCap;
         break;
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
-        cap = WHvCapabilityCodeVmxPinbasedCtls;
+        cap = WHvCapabilityCodeVmxTruePinbasedCtls;
         break;
     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
-        cap = WHvCapabilityCodeVmxProcbasedCtls;
+        cap = WHvCapabilityCodeVmxTrueProcbasedCtls;
         break;
     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
         cap = WHvCapabilityCodeVmxTrueEntryCtls;
@@ -1474,6 +1474,31 @@ uint64_t whpx_get_supported_msr_feature(uint32_t index)
         if (FAILED(hr)) {
             return 0;
         }
+
+        switch (index) {
+        case MSR_IA32_VMX_PROCBASED_CTLS2:
+        case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
+        case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
+        case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
+        case MSR_IA32_VMX_TRUE_EXIT_CTLS: {
+            /*
+             * These MSRs hold the allowed-0 settings in the low half and the
+             * allowed-1 settings in the high half.  QEMU's feature words want
+             * only the bits that can be one but do not have to be one, so
+             * apply the same transformation as
+             * kvm_arch_get_supported_msr_feature(); make_vmx_msr_value()
+             * restores the must-be-one bits later.
+             */
+            uint32_t must_be_one = (uint32_t)val;
+            uint32_t can_be_one = (uint32_t)(val >> 32);
+
+            val = can_be_one & ~must_be_one;
+            break;
+        }
+        default:
+            break;
+        }
+
         return val;
     }
     return 0;
-- 
2.54.0 (Apple Git-157)


