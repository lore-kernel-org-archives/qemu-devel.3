Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7BAC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7eB-0006vV-TC; Fri, 13 Jun 2025 12:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7e4-0006oq-Hc
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:52:50 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7e2-0007lm-L2
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:52:48 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 46C9C589F
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833534;
 cv=none;
 b=SFMxQ2LHQ5BgDm3fOyGIhesnkGPc/CbIzC2QHO3cUsl92U3t5uWkgEsrLU95ztxITpz5LDTuK9+FSiPaCz+K76qjXDefBpY8Zg2FRjdzEKzbdQxqEv/NmD386BGJzXTmySOhJPCR0Rpv1JHVl0aP9j4eWpPtmzPchaXuUK0ot0bPCnmupS52fQG4N665mWgSRUkb8Iy4I1NyajifnVUrHvXMmKk3fEUPDGBQdZd6OQv2IymzoSLO4+Wa05xuTPbHptecpew+63F40FGwgAgpKw4lTDbYCPimLeNJtR9nsE2HaqMzT1jFAPuFvFz6X+FkLvdyH7UUWaO5bpnu5VKyug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833534; c=relaxed/simple;
 bh=sfstiK4KUNvKFQhQsqsxED/c8nqjX8cyzRb3CFhyuYA=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=I7E+2nBSCl9c7CBUVyrfOC3VfASCRvLJAx8gFcbuCo74j73OFF8EReee2mh/VINwXwVySnWerotdJE1V6tXRqMkQmnqK5wjON6hnkEAi4VPmqNydzXHTfi6MZnlxrzaH5H2tjXjTZ+E8rj1atcLxkXeaIsYkCOf4IF9k73g9Lo4ReX8RqGYwQGatOihLEJPeYlygVIqRAgfUPnW2Kwgqndy9Vz8bq4b2yNZ0D2TVWxE/cE2NGKJsnR1KwDKryKSzaw7ir9wKbcZmCDGLkAomDN46zqJ0983KT8+aSfWV59Gmf1oXHai0xQyJK8joLnd6F9Ev/vxGt7Wx9esTBPdpag==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833533;
 bh=sfstiK4KUNvKFQhQsqsxED/c8nqjX8cyzRb3CFhyuYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=76U/Ts7Q5g/c7RjF5jxLlYy5nYp8zcmj3snyyAIhRnPr6LLXTCTI6BfDyZSm+Ehov
 d3iDDeY9dbwQK6mTvfCLPlG9OpJlf4QygR57oMFiXR4WQJTglMF72iS1DL0+8mvFFC
 oduM5JoaHsBII+rJFslM+FJoaRua1sTYmN3Jo6OYIg7xUdF245C9bVpUECYosytCcQ
 WGQ50XA/fTRkYRMfd2+61yykdJQ0y48EdaZlolMan/DPVdrbTD+9S0gL16jMvPCBAi
 09vUDh68FgBZFcMz+vTKSLngQytipaMeLgT6aoKoJRgN5TBci1KlUhvkuDqjFoydwp
 XqacnK9xWeH1Q==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 46C9C589F;
 Sat, 14 Jun 2025 00:52:11 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>
Subject: [PATCH 09/12] scripts: replace FSF postal address with licenses URL
Date: Fri, 13 Jun 2025 12:51:45 -0400
Message-ID: <20250613.qemu.patch.09@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613.qemu.patch@sean.taipei>
References: <20250613.qemu.patch@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The GPLv2 boiler-plate in scripts/device-crash-test still
contained the obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 scripts/device-crash-test | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index da8b56edd9..1ecb9663ae 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -16,8 +16,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+# with this program; if not, see <https://www.gnu.org/licenses/>.
 
 """
 Run QEMU with all combinations of -machine and -device types,
-- 
2.49.0


