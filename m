Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82A606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=0SOTwkvY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzbP-0005SV-Pr; Sun, 08 Nov 2026 04:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbM-0005QT-2h
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:16 -0500
Received: from st-2004d-snip6-11.eps.apple.com ([2a01:b747:3001:201::29]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbJ-0005xf-1N
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:15 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 EB88F18001AC; Sun, 08 Nov 2026 09:54:07 +0000 (UTC)
X-ICL-RepId: 01a1ba94-5ca3-7b77-bccb-37dca97d5be2
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGA11UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131649; x=1825667649;
 bh=sUt0fEx6J1fWs/w8UUJBklUDwgy8uZtIMoJkf1ciHBg=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=0SOTwkvYd0OMoTxhyvdfvfEQhsFhjjoCcpD2ZhumQuhvl3SoBwYeA+A8lve1BGnWzUD1tSHb/TZyZfoBXAGlyE6OFevzLWvRKdcIiRQi51HoBBeuzKYPWBqLwwuD1z0Jk26zG8jZBxSAQ9kYb8EKQFE78StJALFfsUnu1cvhXUbV0DNkQrUIRBJYYzYLZvTOScenflnw1ElT7gYMKXW0wvrDMJvEX9nW0o/++XHyqAqDbnOq+N/awZxuZlc4AyoYd5xhlll4LvLe4MtasOTDhyTSIf7bXo8zeWLofUC7jQzt5sFa7oYSWaG4WkIe7ErK4JHnbImMWZc0eOMUvgo32g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 6A81918001B5; Sun, 08 Nov 2026 09:54:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 00/13] Whpx fix 0 patches
Date: Sun,  8 Nov 2026 02:53:50 -0700
Message-ID: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX1C7HI2yEiHY+
 aUideBkkdqsCGq9gBL2N+e2fQrB8nYUKVNBqAAbhIqcDXHKMN+Cao9CXt/xPl+hL0IUV80YojnS
 zLsrGOaB5wCGD7NtlVnH8U9U0TI1kQLMDfsNY1yzXdgF27Ucx9/1MZ2ecP4gRahHtprZYzSem9+
 pfOD+8mR0UZxF8aIV1ZCrNjk1U63e9AzKcE8fUXrMBko3FMWGa/EOadnq/dxfLv6JmMvuREvCI5
 jsDQN/QGVDGec2yQTt8fTJrwY8pYfZvAI73N0UTxPJ69zTL4d3dinN4OJKHz9Mv01t30AXDmIC5
 AvFlWP89qs4tSTX/LBM3GWNLZMiEITXxRa0R47m5UpRWpOb/XqbWny4MxQ4loE=
X-Proofpoint-GUID: cVdsFA0RmvF-v6GaDr2pOEo1Z7LgRfOd
X-Authority-Info-Out: v=2.4 cv=BNu+bVQG c=1 sm=1 tr=0 ts=6af046c0
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xNf9USuDAAAA:8 a=NEAV23lmAAAA:8
 a=NYuFA6trRCS36QocvEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cVdsFA0RmvF-v6GaDr2pOEo1Z7LgRfOd
X-JNJ: AAAAAAABWlLq9vtXb/tIrHx3B3vNrha6HMsIV11IzRmEwIIqjDSRvTDjqj3FGYrfMj+MBk
 llp9vsI5zGZUOB24C4vTysj5FGit2UZMXzevyLD3tcZ/4v3/JtiKcLVS762R6HKGHceCzw
 dTgrabjEUMb6qZBYu43FZ9tgVSIsO6iFNQSOVdUYg7TWHDl75JxVzsi3lADoLATldoxYgv
 8GFINYawfnCGy1dht9bvJnLG5xRGs2idI2NKL+oLsUcigGkQW/uexyIsXHxBaxQPJ4JZCs
 7XgzICWeXO6Hpcv7JgRXI1wDuDmzVsazHhrsYjiQofSXYB6VD+obJkue+1FGbHt4m5gRGP
 LqlHYIcL46Dp6H06wMKmN3yWwwnhM+waspVx1Plcrmw1DpiH8ZWz6jTljIGzsvI1UmDy/6
 1897ubBwP0yYgugNzBa9EKPxHKvbPZDUOiMnapXovmFtXGfti3KnBevwMAzg/Tmht9JWA4
 /R6WcX0uUrGDVsRDQ1ckzjAqKwe/33WiH7vG3xR3QDlvsl0DOvXr6M1x7oR+PyEmI3CVOf
 GLLtcFseFRtbkJcnp+ZZ8LZ4bRiEk02Q+6zQP4oONjjNiN/JNphqm26wtlgK4spzHocxQz
 cJiUMzowifcTP6yRUKMMvvpjTxNw8xfdpMQJCW8g8b1V1SWd6enq9jIsyfEfpCvRfoKWkS
 rYVLraQk4T64Vm7IMcKWovB71C5TDfBn4ePqqgZqIpam/BgzlBGn6zEuRXTQqSpfmR3ryY
 9vpAuxMhI64b9Z+NNxHpjun5TNh+zuIAOW44Qsi0PwO7+p1rRV1KZll6BZOrI1ALxGoF25
 zF1R8y6NZPokicYPJZ/raf4t7c2jxdOHzqVbv2WEqjg7ZB90T1KYRKK0cahZfWd2+JSCuL
 6fvoNe3BC4GKJ19XIELQ6anbf9GvSD/XdLcIEj+fWPk4fcEfZ0ro7n45SCKR3+yQlphmyj
 Bwk6/daTB0NCdrSIVVIr8xTWTS1qQ2jRQV51ttTMErpHLfrdI1KjdP82dAjKldXbv9mgcT
 CAzp02SfoaZyDdbrRyKmv5pGUvSoMNMaSY4kE0iqRJ0gPmFSxoEseNJQVY3YvYXuJ2/p5K
 aJO9v79w/VA1tujqzklpEDGuTJOBi2gJTjwRjqz9riCwiQerNpIazBTshsHFKcHfz1PoWJ
 ++HMa0GBUtV9hfhLLBwEv05CJVKklcVI8XgUOdoQce8SN/HmEcRWPBhkUuMGWE0egvlQdQ
 HhZ36LBhzoslDadNlMq9QDpjOb2DZCxXlvSDPzyugHufC/HG
Received-SPF: pass client-ip=2a01:b747:3001:201::29;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:

  Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)

are available in the Git repository at:

  https://github.com/mediouni-m/qemu tags/whpx-fix-0-pull-request

for you to fetch changes up to 2bf35950b54c1db9a6de6eb47b42cf843c6bd282:

  whpx: i386: also save debug registers (2026-11-08 02:48:18 -0700)

----------------------------------------------------------------
whpx: QEMU 11.2 pull request

This is a cut-down version of the "whpx: i386: updates for QEMU 11.2" patchset
with fixes for QEMU 11.2.

These include:

- fixing reset
- CPUID fixes (leaf 0xd)
- handle systems where nested virt is advertised but not working
- xsave fixes

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


