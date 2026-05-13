Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E1DCD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 18:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNE7D-0007DT-44; Wed, 13 May 2026 14:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wNE7C-0007Cy-9S
 for qemu-devel@nongnu.org; Wed, 13 May 2026 14:15:26 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wNE78-00085A-AY
 for qemu-devel@nongnu.org; Wed, 13 May 2026 14:15:26 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 64A9A240027
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 20:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1778696120; bh=IjDHQIjW/u0U+A15sbVInEqAmezCEH/S8lSwV9+XN4E=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=UK728VlhwmV2P4HJ+NYspU65Ag6pmIx6SkK1JuTP5Z2qPRirnWkZKDaFulLAtka4k
 vTeOltpI8+yeYewibRMC+FPTzMfOBRimuZIVS9GsTucnVtTAILveeZ2aFAGxY74fwI
 Vi5T+GgVdAdsFleJE8uyOrj/upEzZq26lVxkvvc0TOrQSbIksfecMWvcYfpidL+6Pc
 Yjg2M6l7j864nCrr5A8E4f1urFebDwuibFG/qHQ8gMbngeOPYYyNLZBz2e5vqprJh7
 nH0sn8XymDdGMZ1K5QHKoTnjubdvunJHgs4qTgh9zqgR40BBE91ngqey9uOEU9DOyX
 S8RSZu/3zrbFA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gG1pb3Nx3z9rxG;
 Wed, 13 May 2026 20:15:19 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 Mateusz Nowicki <mateusz.nowicki@posteo.net>
Subject: Re: [PATCH 1/2] hw/nvme: add 'info nvme' HMP command
Date: Wed, 13 May 2026 18:15:20 +0000
Message-ID: <20260513181512.11032-1-mateusz.nowicki@posteo.net>
In-Reply-To: <87o6ijr0ho.fsf@pond.sub.org>
References: <87o6ijr0ho.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thanks for the reviews. v2 sent, with the meson.build trailing newline
fixed and your Acked-by tags picked up:

  https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.nowicki@posteo.net/

Mateusz

