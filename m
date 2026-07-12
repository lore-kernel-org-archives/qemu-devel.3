Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A9DC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 08:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wipId-0005fh-Pk; Sun, 12 Jul 2026 04:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wipIb-0005fY-Ri
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 04:12:29 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wipIZ-000318-Rx
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 04:12:29 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 3E112240028
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 10:11:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783843877;
 bh=Do4WGfkX7XQkPnqf+Zd29nZs0vb7wDmt6eAQj82SDHE=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=DQaG3nZ9ATbSRYN5+3Ii9GQANok/+yrBQi2ZqHJ5KGSzLJl/EByl6ZKTaNPznAF8j
 +/Xx5kYtRKXMeBn0bCPpXQq4uH3ALBadH1+OaUtCJc/NVIg+AvQyEJELHp4bo5x2Yz
 PXjeWyPhlVrB+9jgh7PIkiifkGNaIZGubDCAGj6iUvYMvbd4oOyOkiGm8C8lrpbtON
 QJxvfdV78PtwJeVwtstNgu6kq0lgFN4HjWthWtQdf5509VQE9PwWGu+T8AeRc7/zNm
 WvyI2L7HC29+uwq2yuemAHJLiJr7/BK6bqLDMkqU1TcxsAPVaH7tjiwVrVd7Kgkte9
 AShyFQEHsOZ5w==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gydYv6gRzz9rxB;
 Sun, 12 Jul 2026 10:11:15 +0200 (CEST)
Date: Sun, 12 Jul 2026 08:11:16 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@mailo.com,
 ganeshredcobra@gmail.com
Subject: Re: [PATCH] tests/functional: fix querying available machines
Message-ID: <20260712101114.618e74f9@tpx1>
In-Reply-To: <20260710090317.498350-1-vsementsov@yandex-team.ru>
References: <20260710090317.498350-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout01.posteo.de
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

Am Fri, 10 Jul 2026 12:03:17 +0300
schrieb Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>:

> Aliases are not handled, and that's why tests used them
> are skipped, like this:
> 
>     PYTHONPATH=python:tests/functional \
>     QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 \
>     MESON_BUILD_ROOT=$PWD/build \
>     ./build/pyvenv/bin/python3 tests/functional/x86_64/test_hotplug_blk.py
> 
> TAP version 13
> ok 1 test_hotplug_blk.HotPlugBlk.test # SKIP no support for machine q35
> 1..1
> 
> Fixes: 0e7aa78b0bee50 ("tests/functional: use QMP to query available machines")
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/functional/qemu_test/testcase.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 4912a47a464..e4179d165c0 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -325,9 +325,12 @@ def set_machine(self, machinename):
>                  resp = tmp_vm.qmp('query-machines')
>  
>                  machines = resp.get('return', [])
> -                cls._machines = [
> -                    m.get('name') for m in machines if 'name' in m
> -                ]
> +                cls._machines = []
> +                for m in machines:
> +                    if 'name' in m:
> +                        cls._machines.append(m['name'])
> +                    if 'alias' in m:
> +                        cls._machines.append(m['alias'])

Thanks for the fix!

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>

