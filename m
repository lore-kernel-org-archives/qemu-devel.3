Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA701C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7ZZ-0004vR-La; Fri, 13 Jun 2025 12:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7ZX-0004us-HT
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:48:07 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7ZV-00075h-TR
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:48:07 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 7B94054F1
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833252;
 cv=none;
 b=w5M3XYPX+ua8Wjw0YMfCx7Pn1/dJvAMMHlaGymDI5LY7eIq2q0XyJVeHE8DwrNv2+L6oaVjv63+8n0ROOXg23b+YNUMHTg9lBofYunh8NGrf+gkwLQ0+LT2luADGM/Iy1d2sBw3nBCWkbNMY1QVFWxBRtYmUzwX5MTZ8JmpmpXpQI6lnL+saniSnd22lQ8JbFPbcGu7lb7nIiYyqYAKv3eh6F9FfZd9FMqhQbKhYb5ti/sKPxUs2wVJ9p20EQ2c0wMf9MpZWXK1ck9E+nDOkpK7bGuFD/Xhx9TApD7u7iBPMflhN01ANhA5/i+rhXl4isEw24zuKT3Suk1eNzfgDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833252; c=relaxed/simple;
 bh=B3lNwftSpS+tqV7UQ/I5Rae8w9BYde1GoHx5gGkQaMk=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=fI9RdfpzbqV426NPfFdRTn3vfMZsLwYWrt/XmNHnGcRxccgp+84nwH3URKEZ0ILnZ4Le0sfxZ/f9Vjlf39676Ny15iyy7pRXTYMI610I4HI8qSRYi474kqoZFlD+er7+gDXdaHgKsZsTdpNo/InyqOfEcjlvanwksWrb/T3XhW+pbDRV+wczUcn60L1bhvt2L/wRJrpHdDFgNKfirFAVrc51EsIYyqTgUwRVQbpVi9gXlLom0hRIb40TJpaDoID+e6d372Dx/PnWF9/hP+gQ5nUrv6/PxnPOn5HHpjjhUZh8us6Zoi6D4AmKLjAj1MlX4jGe6X95UaqSIRZ4xYjkBw==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833252;
 bh=B3lNwftSpS+tqV7UQ/I5Rae8w9BYde1GoHx5gGkQaMk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kq0y+GX0P0uIXb+PA+BX9JhJnQKDHWw9q/iCcdZRkP3VFemMUXtyWW9a+6wY+tIUK
 UL8f/KQYzif1l++Dh4kJ8xw90QlTkkMN6QgiZLydbbCDRoGjr97ImVwFPymZiiEYyo
 6gtEjKBwgC0lulG7pVAJ7ilz038pF6wn0Dw0nLXXT5rxOMa4EdKElu3+z8s+4pKTGl
 +mZwDQBSz6ztX1Pbh7+2Ejzl4QufV76o8KrCvy4Pj9BYEZ1iyOnojazB6dEtF7PcdX
 p6Tm8HRpkG/222gQL2+LlFacQ4iZyVoL31IcmCqw7Am7JeCmQ/o4bq/aoj0DMz+//C
 87/U8L20ZkJaw==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 7B94054F1;
 Sat, 14 Jun 2025 00:47:30 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/12] util/rcu.c: replace FSF postal address with licenses URL
Date: Fri, 13 Jun 2025 12:46:50 -0400
Message-ID: <20250613.qemu.patch.07@sean.taipei>
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

The LGPLv2.1 boiler-plate in util/rcu.c still contained
the obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 util/rcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/rcu.c b/util/rcu.c
index fa32c942e4..b703c86f15 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -20,8 +20,8 @@
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * License along with this library; if not, see
+ * <https://www.gnu.org/licenses/>.
  *
  * IBM's contributions to this file may be relicensed under LGPLv2 or later.
  */
-- 
2.49.0


