Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA276606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=EJFflhgN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWsjV-0000wb-Tx; Fri, 27 Nov 2026 04:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWsjT-0000vM-Vb
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 04:59:07 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWsjR-0007uE-Mf
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 04:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795773530; bh=2ZIEBCaG6hjjHcPDXYJEiChiTruNyOidNGSz9zSHLCw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EJFflhgNJAj6MgzsHoxxD0hEqk1LjwuQkAr3peVsd+a7wqdmbCd9L5FIOySCsUT5E
 PAxNKINvLn0SQ2euS567QjD+6R9IuRFv78RZrGJEhcZnHPysqefseNKbDnKxQPETMb
 wVe7bb6SJTzxk/ALoUxZntdHz9whbVvA5MfmzHkE=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id A14EA20E27
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 10:58:50 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2264921E6A04; Fri, 27 Nov 2026 10:58:54 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: Re: [PATCH] tests/qmp-cmd-test: Simplify @qapi-type test
In-Reply-To: <20261117103629.2612744-1-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 17 Nov 2026 11:36:29 +0100")
References: <20261117103629.2612744-1-armbru@redhat.com>
Date: Fri, 27 Nov 2026 10:58:54 +0100
Message-ID: <871p86vbmp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Markus Armbruster <armbru@redhat.com> writes:

> test_qapi_type() checks that if @qapi-type is present, it resolves in
> output of query-qmp-schema.  Absent @qapi-type is reported with
> g_test_message except for child and link properties.
>
> The exception became useless when we implemented @qapi-type for child
> and link properties.  Drop it.
>
> Fixes: 6955264d5821 ("qom: Convert child and link properties to QAPI-aware registration")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Queued for 11.2.

