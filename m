Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976F6D47CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgY3O-0005fY-BS; Thu, 15 Jan 2026 19:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3L-0005ee-53
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:03 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3J-0000pd-87
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:From:From
 :Subject; bh=yXE5DAzREVRncZzG8IcYN7w0EZxUVLrmRfKIU2gp0SY=; b=ReukTzBaKB6bP+GO
 Gj5ok2Obix3dC3N/ZEIbME4EVx3ILjPZ+t4oLWzCL9bF574x1oSmJzV3AD58iYYqMG5rxFapxHP6j
 o1DAAKyauT3Gk921EJMRS0754/mspzNZWBigHWkdUqTKsa2hn3FGektk+vRBnaBM3NpO2yiTWcJFF
 bz9Aji3wIcrYvDLwdB2E8ty565hys4w8qWDsOFoIgAZRfQToamp0NDbamVZ9AgwdUMuRYog0tscHq
 hmx0CjnhwxB2lraNmhq0ad6cQSV0zL6V41xFmdyoUrc1vWGXLTxptSUV8zf8dZu54W0wSJYwHL2nV
 zLhe1gEAFMG4kWjn1Q==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vgY3G-0000000F7wG-1pVd;
 Fri, 16 Jan 2026 00:50:58 +0000
From: dave@treblig.org
To: dave@treblig.org, armbru@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] HMP: hxtool sanity checks
Date: Fri, 16 Jan 2026 00:50:44 +0000
Message-ID: <20260116005050.376616-1-dave@treblig.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Hi,
  This adds a couple of sanity checks to hxtool to try and catch the
  type of mistake that Markus' patch fixes.
  (Included Markus' patch since otherwise the script correctly fails)

Dave

v2:
  Add brackets on the .name regexp
  Use snake_case for names.

Dr. David Alan Gilbert (3):
  hmp*hx: Move info docs
  hxtool: Split srst/erst add checks
  hxtool: Error on missing docs

Markus Armbruster (1):
  hmp-commands-info.hx: Move definition of "info accel"

 hmp-commands-info.hx | 33 +++++++++++++--------------------
 hmp-commands.hx      | 27 +++++++++++++++++----------
 scripts/hxtool       | 38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 65 insertions(+), 33 deletions(-)

-- 
2.52.0


