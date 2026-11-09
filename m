Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06730606A320
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=siLP5yyH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDRx-0005km-Qd; Sun, 08 Nov 2026 19:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRs-0005hg-T1
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:25 -0500
Received: from ci-2005j-snip6-11.eps.apple.com ([2a01:b747:3005:202::67]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRo-0006L5-51
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:24 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 97CC918007C8; Mon, 09 Nov 2026 00:41:13 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-85cc-75da-8efd-266f06174280
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeXBoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184875; x=1825720875;
 bh=YUS9ybTvpXnOZUbYJGaxV0xEl1oGX0LHMQUabJ4T/uQ=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=siLP5yyHqdgQx33UuOLyuDLPHOcNxYRfFauRQoNX+hAsCwWHbmPyWwG+qOOAb1F930Jb/zsD0XSLpJ99rl87bigQFXfBnJBC2PRVKKroyNgcEK2HNWJyz8LCbIiZyUKGtfY5xGsFZNz2BzyylBO1MM0oypaYh9msngjmBbm5TAJ6rRWDyW3H8u3Nc8uon1LKJx3ivw51VCVs1vWjb7/VgBr05wt9RG5OoN213qfWJSXWFyiwdpBNjBL4iL4WkbyD11+yi1wfXLF45w/xnyZAy3y0j50PnIc+oeR6/bDhmV0pfFYTd/rkmLgip5zmiWQCGGiWkLZEq+tmGPty+o6sVA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 4484518000B6; Mon, 09 Nov 2026 00:41:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org
Subject: [PULL 00/13] whpx: QEMU 11.2 pull request
Date: Sun,  8 Nov 2026 17:40:55 -0700
Message-ID: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfXwxvDm97sqZS5
 hZHSSm7hFsDqJEwfpjHMaWsPVDKQPfI7731zINdAPwZqRR6l9l2mrwONjoetptVaBYw4lgKbL4C
 LLS1aKEhktWSqc9+E6t6XOVIK+L65l4TUVv3tbiMLmf/2sD8mdyO/y0HXcOm2HA2l6XYas5YBVz
 WoGH8OyVI9bvsvxVC13ViU1d0fU7KagFL9pujrSdLTkdf+fayStnAMTMEZnnyKEhRZfGgmYvoer
 uu6NCZ0GQM1CZZ9mxgpU8Jst+BDUG/I7mlI/1foSN5cqZ3IAB9vnPlyApm1DuQtIgaDwCD5dJfP
 19NT0Z1GCMSqGWNQSe1o3qpIahUaRuoBoQniCEwem+qt8zjh9euvT5yrOROjvg=
X-Proofpoint-ORIG-GUID: aAomfvJsEp35sKbQyzklg7veHWJWew8r
X-Proofpoint-GUID: aAomfvJsEp35sKbQyzklg7veHWJWew8r
X-Authority-Info-Out: v=2.4 cv=CLcnnBrD c=1 sm=1 tr=0 ts=6af116aa
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8
 a=vYVKMePRV3DZNBV_nfYA:9 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABPjPA7lsDrgTR/0uLYxBmfyXCtXRMEOpR4Wb77MM6g/aVuPM5iekoOPrxgqDGAT
 8Yad7TrrTj69UG3GO1P2fyUgH+N7gHsY/r0ORL7Ud2AWdZPLmhm3w+CZWbRtV3e6H5Daiy
 m3JbBbFMDaV6kIOvgWyfA8E5odkN2ZsZnbcivCdum9kWfvREIcRxvMHsognnR8eOwoIviT
 tGF85ycM89//JYgPD6TwAyJ0RXaP0nitec9/Oyhqjdiwq/hVE6y0sUlkBb+tQZwK8w4mkz
 wXU8BOtyF5nn/h7vM4zUYpsY7Vbc4UXnFIRf5+Kw9oY/ReL7SoPPc5pJdtRLQJuTknskzK
 3aOkMTeSKLFFgf70uDA4yYYzDOWn599pjCOLZ/RWk9VakJB1NEtBAiGP4ddBxRkRHnW548
 v6cEV1qutX93EUCWLyH0Uf0iAJfSA8zJULx71zRnL9b4JDyTqTES1mMCQmQmwSctEcYoiC
 u6/MCOVTI1seUjJxm4xrm+P8U6rnJDetAHhjS/44fPkCg0i1y4DnnLszoKnVAEBbMLepGy
 dkMdNxLoLojR0FRmDMrtTPomd/xGwVLrmgIHMcTEyZtFUsn9wx/cKzjeRqaK0Z2wT57KiK
 bEvL5u15PI4HF4uWbCJS7QFt7/cxjuuMRSecOLk1uX5AWe6G88OzTFt5eKefd4j8PheYFH
 Z6q10BlsBX+iGLgI20V8xyQ5qG1EtEsNY0GSZ94zU2dBZPct3703Yc7MnZR5iN+bZn6X4o
 hOFLsPF5AeI+8taMXaYXS9C2Hc2C00ec7b5dkI+J7pJ61L8ET3TQz7GBKf59IEU9XQzQsW
 OQmQXc3s9cAb9ECDeFCaMt7G5FAFAMUr10Oxb3/sYL6pHGXjt/AUzIiCbEFZR3L1nKFvxu
 LKNoZfKmnjevdNNVGtdQ5Ej1ad7jZcjtl79tRVqbXyOBDxTsaYDqClqUvjvlohELN3Qved
 bWdipJfX4ff436IqK8qkr3bY+jGqeXp+LL4UxDSZAKwVtjD65uMLEe19SRsodTDS+5gFO6
 0L21Mvpg0XjHQ1/DKkGZHhwS0VHRsU3koiXZtysLowlw3yYOnEYQj6XgU1A8tIcRKlUCEa
 yRLk7quktOPHZVcpm3QGl+w6fonZObLfMq6FZSLKG1IculSANkILRtyXbZdbYUe1YhtznL
 tlu3VeTnRbWW4MMmAHeYm0r0FdKMAFZ3IlSH1Fpsj15aL0hTwx8xHxx67p90/HSIajS9Ne
 cVohr/MqYA2ZYJ6tRmlozE0vl1nwYCJNxyIQyGoPHthcHgW0
Received-SPF: pass client-ip=2a01:b747:3005:202::67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 71f25c75417d31c214ba2cd26b273c114fc99987:

  Merge tag 'pbouvier/pr/multi_target-20261106' of https://gitlab.com/p-b-o/qemu into staging (2026-11-06 12:28:21 -0800)

are available in the Git repository at:

  https://github.com/mediouni-m/qemu tags/whpx-fix-0-pull-request

for you to fetch changes up to f1ea9f2e15236020aff70e37e56f3443c9203052:

  whpx: i386: also save debug registers (2026-11-08 17:39:41 -0700)

----------------------------------------------------------------
whpx: QEMU 11.2 pull request

This is a cut-down version of the "whpx: i386: updates for QEMU 11.2" patchset
with fixes for QEMU 11.2.

These include:

- fixing reset
- CPUID fixes (leaf 0xd)
- handle systems where nested virt is advertised but not working
- xsave fixes

v1 -> v2:
- Adding Signed-off-by to all commits
- Rewording

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

Mohamed Mediouni (6):
  whpx: i386: get APIC state before VM save
  whpx: i386: fix TPR encodings for local APIC
  whpx: i386: save/restore xss
  whpx: i386: make nested virtualisation init failure non-fatal
  target/arm/whpx: handle processor reset
  whpx: i386: also save debug registers

 include/system/whpx-internal.h |   5 +-
 target/arm/whpx/whpx-all.c     |  10 +-
 target/i386/whpx/whpx-all.c    | 307 ++++++++++++++++++++++++++-------
 target/i386/whpx/whpx-apic.c   |  10 +-
 4 files changed, 266 insertions(+), 66 deletions(-)

-- 
2.54.0 (Apple Git-157)


