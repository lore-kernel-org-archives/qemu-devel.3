Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1E606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=UzyhprzC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPSr-0004eW-Kn; Mon, 09 Nov 2026 08:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSY-0004d0-Se
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:58 -0500
Received: from st-2001b-snip6-5.eps.apple.com ([2a01:b747:3001:206::10]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPST-0004YS-6g
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:53 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 300831801943; Mon, 09 Nov 2026 13:30:39 +0000 (UTC)
X-ICL-RepId: 01a1c080-f76a-704d-a1b0-6ba0593e6762
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQBNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQABJAF4HWAdeDkELWBpaHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794231043; x=1825767043;
 bh=SeHgtc3Qq1B5ko8uv9Cl8PmS08U6LcVGzQNYSGo2oTw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UzyhprzCkarQYTHqvXk7T2v+9+GsEbT+hoV20QFJlO1qW/DNuaQJsOTylm7+nxrLdL99JRTi3VU4GsupsQNvsicnHqpAVkkHEG6QbJedfASu85tEqitjMzGLTtyuWGdZaR+kFuwUe8XifTnlyk8mq9gl/0W2MzsmqEx7RlEYgr5h/Hv7UkHcXsJ6bUhtA9FBTQDlTl8hgEgNypdt6AqCE7OVN4CPFMLntsx81VLH+7oCV75DemtGUry4rmkWBaiR8nA9OMTLrYJs8A8SG1OEe722upexSdcH2sPraMvZnmQ3vk/CviSTHLJanVmqPMdnnabZz7xnhDtnqjsDVgqW4A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 76CB31801364; Mon, 09 Nov 2026 13:30:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 0/7] whpx: QEMU 11.2 pull request
Date: Mon,  9 Nov 2026 06:30:28 -0700
Message-ID: <20261109133035.7985-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ftnRpV4f c=1 sm=1 tr=0 ts=6af1cb00
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=R2t1_MV1qQijb8GiLDEA:9
X-Proofpoint-ORIG-GUID: o1Fd16Xr6Yv8J8tnFommhwPYw8lc0vW8
X-Proofpoint-GUID: o1Fd16Xr6Yv8J8tnFommhwPYw8lc0vW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX2Jr/Pg9EC9II
 bWPBJAni/qF5LIVJrO3odgNmaaG0DnLNsjvd/tM6/8uWotXWunFHQO/1CMde1smFUP148Mh1rzO
 dDug/8s3w/WWTy994SXKudk2AjVU3mr1uWesnMXTjUWdQlKz8pbTaPc4+mE3qJOqt3a3d6zezyZ
 KV4h8NzzlputAvrb91hkj1vcc9lqOLaFOWJeZ12h6Y2MwVXbbHSpd6T1ZUI/9e6Nb8nJ3NS1+jy
 2hRNuillVsAEeyiyyaGQHQGTMMPeINYg/kiIH5vucB5e4yzAWsbdjCla1eIj+/Lvc8DyBazuYfp
 cx6Vr8CHgYDrEUVWqOHuZiVH3Wjb/pF4oy4CGO4N6MsI8vFoyfEJBHMy/LBeS0=
X-JNJ: AAAAAAABpITKkSrh7FClutBvleAxkr5soI1plSCpJ1dW6WHe9XDcoS/27b84Ma9dHEM5iQ
 xHzBpeuFYbqACo8vvX2DzEnPOHGwYqrifZ/rmmc/P2eJsnyC5bvJ0EmIe0GU+wPnftr9ck
 CIVrYsWcLGtK2ujNhYNjz75quHNbons6O+pmOrqK6V7S9Zuy2KTuZITxkrerg3t28UXwH/
 hj0EqLaPraydEdXiJdm5dTZYW8e/Jb10yBmtExm4CMW/xH4ZBdS5q0DN7+uhzsJZJz+KPm
 m0MlHyxNfI10HFmYTltKOpHtk3+wDQ+BqZ1XUAIVgQx994SWa4Sj2tyowFf1z1j0D2b6f6
 z6UaMLK/dDCxI6dDxgRBnjrttCzhQ+7vtAhFW4JtmXK1Pk1Y3E0zRiyCeHy7HXn0BdQmeq
 w3MRXhacqYfx4U5916Yh7PJkR8/FENyLcIahzh2u/vkUzPKqfPk+eHlkESOTJamWKUqmuQ
 JiVVJIf2U6ojveF9cnj8Lo1dA9oUHEAqO6GeICF7ziIAvpQ5WhvziZnL4KrLe8YCZmJa3N
 pHL2YHYaW4yxg+NsXkzC3F1rPDdu65FRkhGnqdsCSaHc5v+FlFpiW+FdxrikeTChSO0BA1
 0U4BVbt0g1P4KuIGFfn0NSX2/CDOsmwJkAPFYrNcqW4Y5gPapSSG+JbwJlCSSG/C4KxDoY
 boxk4lSWKORa8WDTmOjEbufm2eHfjoTtj32kjmpOBgCGy/1rqh/CmsuK1aD0HlhJdm/QBs
 kwnQK/tItyMQSF7ImClBSyOfXPF9idch/VGFj9H28AELbItr2bKqirhws+bs+nNX6p7usk
 f3zGCUd1L1CJkHdyZcXcR6vu7MgDUAnvSbID++40foMQ2q/jBcWZMDdBVO+olEBDE89+Nj
 Vtx7EWi/BX0JDTXrSCFt5YFL358GeHgIBg/BMOMoGkJGbuI3jxokaL27jKqQQ7ITH9/tlE
 2yX2re5FmMBflieOOb7sk9LLSjbVwZzHOdYMhdfzMXiNYlSowRrsAfsg2OzS6fFeb/F3pJ
 aML+xUY4JnBcdv+OHsSE9zfaPqT+37PVOETBAjozCyEx0GTbekFlvOJ+NwjOuLAO7ifgQl
 Dy/CMVFfUwts7ekP6EJqlkthALhaUnR+nA7bxMXQlUg+fl6jFFComowAsb5e7qJgHChwOO
 3+oWdMfm5nWvuPZax5AuXlcNmDOH0=
Received-SPF: pass client-ip=2a01:b747:3001:206::10;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0

The following changes since commit 71f25c75417d31c214ba2cd26b273c114fc99987:

  Merge tag 'pbouvier/pr/multi_target-20261106' of https://gitlab.com/p-b-o/qemu into staging (2026-11-06 12:28:21 -0800)

are available in the Git repository at:

  https://github.com/mediouni-m/qemu tags/whpx-fix-0-pull-request

for you to fetch changes up to 1e682edf3fc3c5dcad9ba0cee214dbf54a3cb462:

  whpx: i386: fall back to xAPIC when the MSR exit bitmap is unavailable (2026-11-09 06:23:33 -0700)

These include:

- fixing reset on x86
- CPUID fixes (leaf 0xd)
- handle systems where nested virt is advertised but not working
- xsave fixes

v1 -> v2:
- Adding Signed-off-by to all commits

v2 -> v3:
- x86 only, and removed arm patch with pre-requisite not on the list...

This is a cut-down version of the "whpx: i386: updates for QEMU 11.2" patchset
with fixes for QEMU 11.2.

----------------------------------------------------------------
whpx: QEMU 11.2 pull request

x86 WHPX patches for the freeze.

----------------------------------------------------------------

Akshey Taneja (2):
  whpx: i386: do not require ProcessorFeaturesBanks on legacy Windows
  whpx: i386: fall back to xAPIC when the MSR exit bitmap is unavailable

Boden Randin (1):
  whpx: i386: avoid updating hflags for vmexits

Doug Cook (1):
  target/i386/whpx: fix VMX capability MSR values

Doug Cook (WINDOWS) (2):
  target/i386/whpx: whpx_get_xsave_state error handling
  target/i386/whpx: handle processor reset

Kostas Chatzikokolakis (1):
  whpx: i386: forward the dynamic EBX of CPUID[0xD] sub-leaves 0 and 1,
    not 1 and 2

 include/system/whpx-internal.h |   5 +-
 target/i386/whpx/whpx-all.c    | 234 ++++++++++++++++++++++++++-------
 2 files changed, 191 insertions(+), 48 deletions(-)

-- 
2.54.0 (Apple Git-157)


