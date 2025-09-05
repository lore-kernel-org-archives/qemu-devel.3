Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5ACCA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUUC-0006h8-9e; Fri, 05 Sep 2025 07:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uuUU5-0006gH-0s
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:20:01 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uuUTw-0002gR-P4
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=b17pRwn5KLiL7q7nj3aTyiWlCuyji6QmPemLU7fpB/s=; b=wL36ziDK5j9a3nEnX3KVkChrWV
 mMXumcuOgNvWyMjPQr2DdUMT/MOFewLtDBJi/AzFjqd2A2QpgNlBnQPtZIzk1coLtvqHs4pkteO82
 7CKCW6pq03CVEJJDQRjXcZQ27LHdTL0rr3o45JcAgD3klG2HzSbD3r6QtliTvciqGX1+pqo9uVwtU
 NKqQA1Lutnv9ZLEFSW6rhD1MzBDdbz74MPOc85vmSRIZHYkObGJdrmIjUSjaZXWZY60FOcuQwo5jA
 VG5IJGmQs5aOJ/eS4dM6d7QlGo4xEcTDLfkqhcUizPXbEbPwHSyCe+uHb2PI9ZdjgBM1ttA7Fv50K
 grF/JzLKnpX84XnaTxexvWp8rMMZtozk2kUYYcP2tf/JhRE7LV6u6/y/B3SE57dZfjYS6fGQQSuXt
 x/ZD5INx802tQetawOhu6ie4qVz0MF+TMtu2DTNbiD62cchVabPrtgqWjVvBL1PyytQLJ4kwBdcsD
 DcbqBssyKJMfC8Xu0ahyifyvJk6FpKrwxjPvR7NgaCXPzP/RjPUp9YAmXByG/HJNTwifUlDaLs+sr
 gnSpLCd35z6ii1WRKOOwPQdJJlfD/yaPFuEddEj6G5tirEqWJJL68+wVqy2XzJ26i70rfwCP/vNHL
 SExyslQPscAW8RbF6HW5cyE5XhJKMELeXUE9pfzCQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Mark Johnston <markj@freebsd.org>
Cc: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] 9pfs: Add FreeBSD support
Date: Fri, 05 Sep 2025 13:19:39 +0200
Message-ID: <2537259.JahZeRKPxa@silver>
In-Reply-To: <aJOWhHB2p-fbueAm@nuc>
References: <aJOWhHB2p-fbueAm@nuc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wednesday, August 6, 2025 7:53:08 PM CEST Mark Johnston wrote:
> This is largely derived from existing Darwin support.  FreeBSD
> apparently has better support for *at() system calls so doesn't require
> workarounds for a missing mknodat().  The implementation has a couple of
> warts however:
> - The extattr(2) system calls don't support anything akin to
>   XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
> - Attribute names cannot begin with "user." on ZFS, so the prefix is
>   trimmed off.  FreeBSD's extattr system calls sport an extra
>   "namespace" identifier, and attributes created by the 9pfs backend
>   live in the universal user namespace, so this seems innocent enough.
> 
> The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
> filesystems.
> 
> Signed-off-by: Mark Johnston <markj@FreeBSD.org>
> ---

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



