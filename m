Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88426C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23ef-0002nY-FU; Tue, 08 Apr 2025 03:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23eW-0002lz-Kb
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23eV-0004iK-4v
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744098345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z021wYpsOrGHx6nYnlp7jyW4bRQBv+uZpZS8p217HX0=;
 b=MBI/U7ILkeSJXjXuIQ/c4wPz/TMyL6SMRXqVosHZJLUltMiUDqtHbZ4GdfI4qpIOJrmNHj
 uzJX+KoTC9SD+eOmkqpLppIr5zrTUyV5o0c8VJthZtqimHK5q7w4tWvqk98j32d+K+4/rG
 Zc5t2v/eByCqCL/KPhVGMfyjzwMXC7E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-YbQeocEpOI-HCUVmp-05gg-1; Tue,
 08 Apr 2025 03:45:44 -0400
X-MC-Unique: YbQeocEpOI-HCUVmp-05gg-1
X-Mimecast-MFC-AGG-ID: YbQeocEpOI-HCUVmp-05gg_1744098343
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23FA81955DCD
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:45:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D41631801752
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:45:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 76D2A21E6757; Tue, 08 Apr 2025 09:45:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: Re: [PULL 00/11] QAPI patches patches for 2025-04-08
In-Reply-To: <20250408072001.2518323-1-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 8 Apr 2025 09:19:50 +0200")
References: <20250408072001.2518323-1-armbru@redhat.com>
Date: Tue, 08 Apr 2025 09:45:39 +0200
Message-ID: <8734ejp04c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Here's my argument for taking this into 10.0.

The changes can be divided into four parts:

1. Address deficiencies right at the beginning of the three QMP manuals:

   * "QEMU QMP Reference Manual" section "Introduction" suffers from bit
     rot: much of the contents is useless or misleading.

   * The "QEMU Storage Daemon QMP Reference Manual" and the "QEMU Guest
     Agent Protocol Reference" lack a proper introduction.

   * "QEMU Guest Agent Protocol Reference" has a useless table of
     contents.

   * "QEMU QMP Reference Manual" and "QEMU Storage Daemon QMP Reference
     Manual" both have a needlessly ugly table of contents.

2. Render the example notation in these introductions properly.  This
   involves changing *one* line of code in docs/sphinx/qmp_lexer.py.
   This is the only code change, everything else is documentation.

3. Minor cleanup of rocker QMP documentation

4. Minor improvement of QAPI developer documentation


