Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD65CCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 11:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up3PA-0003dg-Gv; Thu, 21 Aug 2025 07:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1up3P8-0003d0-Qz
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 07:24:27 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1up3P6-0007Ll-2s
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 07:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=H8gvyRwI3JTI6SJPHL2uSpHDk68BHhXMZgh/y/nmi+s=; b=tim9JaNm7wQc9QIsLsfOpZXCsS
 USLLsseRyRuTg4w8k16eTf4+udn/tgAlZVBaQzeWvVG6vlgHrQFiFzBx+iF7jLpC1jBLEGmi/olDK
 MPRZO1iLAxmRSIFyp1dzEBhfRHvandh6NfGkXD8+z6/N52kBPJbtBby25oZ/0qg5wWLEtisixnKDC
 X7hzvBX9cJHNdAeUxcG0XdL3OUACe5PgivJ7ozlNoFNWtHoFabjDm8mVBTY0CYh/80m0i/bennJNL
 ufry9iYY5SEBrFikpCLo516P2/ZNf1e4tir8GW4+d5v9lq6+NCGyDwmB7mRWyL958Lb8GXYf1Ti9l
 bumSazaErsY2Uzr1IE9R1zuiD8A1H3BPZVXzcEU3oCeGnEEeYKS0oQ/AT3IMYDM4zQoYtA0wBTpne
 QFsB90GmqKO3fBQZgasUe9i9KF01S0asimUQU6IazmOLl4bgj6UFG/lAFCbXQ+ANAlesQGU6IRNEe
 1OwG6JLa3k6EMmLGTAIu7FryXx0VUG1f8UgqFBJiGenekO8JlfO4R/Szbn3OcBoVFyJ1C+Pmx8BV4
 I2m2ARhdmztTY3NxsUXg7U/EFXQVW40nGXXXddqpthvUpHvX+uaB2wDniXFJRwJY/ikBKUjX5Ao3X
 WWcIVudTQTSjbFH9ZkGoAHEgMfgBUSwlX1hWorLks=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Mark Johnston <markj@freebsd.org>
Cc: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] 9pfs: Add FreeBSD support
Date: Thu, 21 Aug 2025 13:24:04 +0200
Message-ID: <2602995.s6eulQLtdm@silver>
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
> Changes since v1:
> - Handle extended attributes in the system.* namespace as well.
> - Fix a typo in a comment.
> - Clarify a comment.

Not forgotten. I just hoped there were other reviewers or testers in the 
meantime, but be it.

Like I said, I don't have FreeBSD system here to test this, so I am taking 
your word for now that you tested this and plan to bring this into QEMU when 
master re-opens for new features soon.

If you have some time to adjust the commit log message above, that would be 
great, otherwise I can also handle this on my end later on. Looks like that 
comment is not adjusted for v2 yet (i.e. "user." and not mentioning 
"system.").

/Christian



