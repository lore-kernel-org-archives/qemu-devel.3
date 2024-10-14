Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E80D1812A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0N3q-00048H-CF; Mon, 14 Oct 2024 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm-bounces.nedprod.com>)
 id 1t0N3n-00047k-9G
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:32:39 -0400
Received: from sc-ord-mta126.mtasv.net ([50.31.156.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm-bounces.nedprod.com>)
 id 1t0N3l-0001fl-Iu
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=pm20241004;
 d=pm.mtasv.net; 
 h=From:Date:Subject:Message-Id:To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Date:From:Message-ID:Reply-To:Sender:Subject:To:CC; 
 t=1728919957; x=1729006357;
 bh=0Oz9ClTsKCZOXGJePFgW8GyvU6fLPgSk6sUrEy/2bB4=;
 b=dgroa9B6zUn/m78IE0OfF6UnyfrseFrMK00m4Q0DgPBB6GbHjAOIOas4I0QtuCnkd9iMUtXK1fMk
 jw7uzeiAJGABGJXe+BRBlGlmbntWGchReJ4fg9oLz2waFx+N7jV6fNg4w3F56c1iGUFGXx6VkqBE
 ZLDuT5axxl0v95fU73McNxHoOyskyhto7a/4UiR66Q0LLjsBIN0tlcdLiLJEpE7q0eS+mfUF37tx
 YWjh3FxIh/m2iGiTPNQzyxW95PdxB4WDkHNMC+/eyYqrUgxDGV9e/1iBsxjwSmMn1h70WgbLwvGh
 s9029MruLxUYR+jFK4XNkC4UfkUUcuMgyDE1MQ==
Received: by sc-ord-mta126.mtasv.net id h1ksp83864oo for
 <qemu-devel@nongnu.org>;
 Mon, 14 Oct 2024 11:22:35 -0400 (envelope-from
 <pm_bounces@pm-bounces.nedprod.com>)
X-PM-IP: 50.31.156.126
X-IADB-IP: 50.31.156.126
X-IADB-IP-REVERSE: 126.156.31.50
DKIM-Signature: v=1; a=rsa-sha256; d=nedprod.com; s=20210726175555pm;
 c=relaxed/relaxed; i=s_sourceforge@nedprod.com; t=1728919355; x=1729092155;
 h=date:date:from:from:message-id:reply-to:sender:subject:subject:to:to:cc:
 feedback-id:mime-version:content-type:content-transfer-encoding;
 bh=0Oz9ClTsKCZOXGJePFgW8GyvU6fLPgSk6sUrEy/2bB4=;
 b=exlQ0WU6p4TNEAvQc3DHNDW0i1gfCG98KJV5P8ZivoGApWtBYogBF2XfMp0tcW1f5v01/6PAbmA
 l7xYEAYWiFkHyUNth88rcwUV0wMsHHDNw7I/CBxovxQOILpVrRYW7nYykCNAHjNouDOSfjBtQBIcy
 VDYY8pxr8PFq9Kf0Yco=
Date: Mon, 14 Oct 2024 15:22:35 +0000
Subject: Patch for GDB to aid debugging qemu coroutines
Message-Id: <f0ebccca-7a17-4da8-ac4a-71cf6d69abc3@mtasv.net>
To: qemu-devel@nongnu.org
User-Agent: Mozilla Thunderbird
Feedback-ID: s8148012-_:s8148012:a214946:postmark
X-Complaints-To: abuse@postmarkapp.com
X-PM-Message-Id: f0ebccca-7a17-4da8-ac4a-71cf6d69abc3
X-PM-RCPT: |bTB8MjE0OTQ2fDgxNDgwMTJ8cWVtdS1kZXZlbEBub25nbnUub3Jn|
X-PM-Message-Options: v1;
 1.6-V0DNsY91f21xZbjynqyA.rOOL5NB6MZIhdcFC42PwvIW8w_f7HPxGFQIvyjqjyrRNhIODlmO1u-XH32I-ZonfucwKoUGSsUePRNwle4oEF92DsYBIcADWOzRG1kcDrQnArNAtBHHkAdntNI4waL-kyDuE3SzEtARCGq_K7FB8VkoOGIM-g8ZzisB4xftRDMOmdfBizS_DgPe70jTidIIV
MIME-Version: 1.0
X-PM-MTA-Pool: transactional-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=50.31.156.126;
 envelope-from=pm_bounces@pm-bounces.nedprod.com; helo=sc-ord-mta126.mtasv.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Niall Douglas <s_sourceforge@nedprod.com>
From:  Niall Douglas via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

A couple of weeks ago I posted a patch to GDB adding support to the=20
Linux backend for user space threads such as qemu's coroutines:

https://sourceware.org/pipermail/gdb-patches/2024-September/212028.html

Within the patch is an example of how to maintain data structures within=20
userspace for GDB's custom libthread_db.so backend to parse, and indeed=20
the creation of a custom libthread_db.so.

In our codebase here, we measure approx a 3 nanosecond overhead added to=20
context switching using setjmp/longjmp. If one uses a faster=20
implementation such as Boost.Context, 5 nanoseconds is added. This is=20
probably low enough it can be left turned on even in release binaries.

With a suitable GDB, a suitable custom libthread_db.so and an inferior=20
emitting the right data structures, qemu coroutines would appear in=20
GDB's `info threads`. You can switch into their currently suspended=20
state, examine their backtraces and current local variables etc.

I'll stay subscribed here for a few weeks in case anybody has any=20
questions, but I figured you guys might find this support as useful as=20
we have so I ought to let you know of its existence.

Regards,
Niall Douglas


