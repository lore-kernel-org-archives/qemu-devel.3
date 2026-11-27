Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E7606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=dsdpwM9j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWveZ-00070E-S9; Fri, 27 Nov 2026 08:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWveX-0006zh-Qv
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:06:13 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWveV-0001TG-Va
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795784759; bh=fLJicMSiZr9tYe0grJESCi0JtmaIPRAjtzaaH7yF1YA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=dsdpwM9j6OiqOmldsSFgj0lQhrShWm11F9FvnQNEiGMLgBm/RKA4hUpwVJcbC5hW8
 +Cwvd9kbz7aXqoC2R3Ne93kS0zo1D0o3CeCUxOgCjem9yKpK1scJTRDN9ULV3fWJP4
 8Og7r1N/PTavkfzvnIZMHgtRtOO5gyzzmuhAOV2g=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id E2B8B204A6;
 Fri, 27 Nov 2026 14:05:59 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5D19C21E6A04; Fri, 27 Nov 2026 14:06:09 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org,  kkostiuk@redhat.com,  michael.roth@amd.com,
 dholler@redhat.com,  fdeutsch@redhat.com,  yvugenfi@redhat.com,
 kramdoss@redhat.com
Subject: Re: [PATCH v5 0/2] qga: Add Windows driver information commands
In-Reply-To: <20261119072437.1418565-1-eashurov@redhat.com> (Elizabeth
 Ashurov's message of "Thu, 19 Nov 2026 09:24:35 +0200")
References: <20261119072437.1418565-1-eashurov@redhat.com>
Date: Fri, 27 Nov 2026 14:06:09 +0100
Message-ID: <87qzg6s9tq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
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

Elizabeth Ashurov <eashurov@redhat.com> writes:

> This series introduces two new QGA commands for Windows:
> * guest-get-driver-packages: retrieve out-of-box driver packages
>   from the Windows Driver Store.
> * guest-get-driver-services: retrieve registered driver services
>   and their metadata from the Service Control Manager and driver binaries.
>
> Changes in v5:
> Rebase onto current master.

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

