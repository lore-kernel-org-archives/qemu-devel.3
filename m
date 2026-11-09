Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF6606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=HgI1xsXV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPSx-0004fb-5l; Mon, 09 Nov 2026 08:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSY-0004cz-SI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:58 -0500
Received: from st-2001g-snip6-11.eps.apple.com ([2a01:b747:3001:206::47]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPST-0004YD-6L
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:53 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 1A6BC1801375; Mon, 09 Nov 2026 13:30:39 +0000 (UTC)
X-ICL-RepId: 01a1c080-f7c3-77c6-89e6-9e888da8e987
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQdNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQABJAF4HWAdeDkELWBpZHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794231041; x=1825767041;
 bh=esa002n+umgb+uuAEw0alWBlRbDUr7KFNDpQLc54GuA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HgI1xsXVIrEBRUMQLivdTvfgUU7PTuDQES98hXfUq//UWzMenXPuKSRWqOnNxMgwtegM5UsGLqNAsl9Wob8cJBGrmV33fiK/JPEMsCtGiDlVsxB4Fq0U/P8KFw4Na9saUicS9fQXuPMsrGisVeBACdQeH8O7bJjN4yBYRjC20MzAgoEtqIPXQVQrkaWtpcbsA51PTLl3hQyCaWTRn9ARIP02MICAimInYKYo0ngjZYQybYFvW9VpUtUG+LUwdW9XbgmvqALjET/6Alk4FGRKQPmiRpwvzc9J/r5FyI8ZJ+PB/0Zq5NCCgS6uZjHLNEih0NMaPtQRTCkdtwoZyvTQUg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 10D3C1800E34; Mon, 09 Nov 2026 13:30:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Doug Cook <dcook@microsoft.com>
Subject: [PULL 1/7] target/i386/whpx: fix VMX capability MSR values
Date: Mon,  9 Nov 2026 06:30:29 -0700
Message-ID: <20261109133035.7985-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109133035.7985-1-mohamed@unpredictable.fr>
References: <20261109133035.7985-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3WckQtNHb1SXuUH6yxWRevFreVE0plJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfXzfFJWFVPuMwz
 8J7ejLvTAdzNzdyfsXI0DCnQ5MMSjWG8XgINJVjJ+ZioIJhkuXM7t0IuvbrcCDpcd+plOjL2E/l
 rb/a5JYBR4qSOllxf4/2Xfh9pwpRgKv8tqh8QyMBhzHcEJe2SjECIPWai12v/Vk1OLfQia8V/w8
 MsHy69PgWS4tdIPn4XnTYz/S/ufm4XQij7ZdE8daMV6Mo1iee7rVpDMPpxmLkua7LV4lS4ZlsO2
 7QnNED8L1ZVvATT+FvAMfqkFouwKywDqig1eqfWcADChddTzVTSDKpNbZteYkmZc0DqAX1JxDtu
 JIF0qt6E/G5DktPHDMA6zlMk7TTbkhgi2OIWKRfa2iurkaDuRzbS5PDjUYwQCY=
X-Authority-Info-Out: v=2.4 cv=WsQm8Nfv c=1 sm=1 tr=0 ts=6af1cb00
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=34rDk-nlojoYW5TMjDsA:9
X-Proofpoint-GUID: 3WckQtNHb1SXuUH6yxWRevFreVE0plJq
X-JNJ: AAAAAAABCD1O0WV59Vk+CrlKATS6d4d8Aj1P3KihRyYK0ceSQcy27fKWvq9KMwEanTQUW/
 SNI6V4qgm0lBABCweMCmgEkygb+tUiTo+T+iCxr+XN4XM4h8i5mwhqcDnY0FG5n2lDirYD
 ufv0u8seBvuOHyB7jsIevn9L6sN2ybBtxfWlU5V7DU2BEpeASllm5d7bsXvTpNdKsH4nKb
 3MRGpOuId+orE76ckGLjunhZdGrwRa7VCYRz0nShrrALgc4uJxVe0oWFyrnxZpyCopHuSF
 kaU3kDCrd+h7UaQo4YfEd7GFUxCGEFALCUzG9TImmgeLCSW28L0s/kGcz9Lby6/6xZJJu9
 PbBf/cDcvYr3YD31en6Qvsv8CF67k9Trn07ier82nIzJAQHySkn9Pdp+xgB+Yvs4iC7CGx
 Xf/uPv+FA9Pr4agpkjI6Vg9SzI3635JECXLYGU0S/RX2UhjCo3wd1TI4lxbEmyfn1bZp3b
 DVBS43vz9sJTPH0WWEvrgLVymK8+ngR13ggMVoyUj1TnJKQ9A4YiiJfSCZ6RaBP24XuZwA
 5ioINJOtwr/XHNmisPtuCTDAghi9PCDGKTOj+rK2LDYoJxTmj9MZMg17evtihPPQHccGIN
 UN4YUhwy/4CdCucWTU7fFjvZPnlLz2mkppHkR5q0y0mEgBfvr3Q13H8fTduExxjhGdm2q9
 heNJOGmnIrTdsohFyuZZ+VWzlV+MFeQJuM8SrBSx+GhHSe5vLfPi623ZsCRl09uMmWUQWA
 ==
Received-SPF: pass client-ip=2a01:b747:3001:206::47;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


