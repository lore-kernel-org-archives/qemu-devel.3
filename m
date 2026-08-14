Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6DEC5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 06:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wulmB-00006r-Uw; Fri, 14 Aug 2026 02:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1wulmA-00006h-LF
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 02:52:22 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1wulm9-0003EZ-1Q
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 02:52:22 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 8F09624002A
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 08:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
 s=1984.8680eb; t=1786690335;
 bh=gbbOOZ9edXRdO5oL5PUqsfy6kruH31DrN6E/HuLURsQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=ECkPobklzE8F2w7zX5P/DSpURU0HFTfC1+d1LZFkNU0v0fms3TUhfNhzBMldPOX4Y
 DGGo3hAPRu3VEBYVrXuSn7mfEwXVkC5f4+UVOLIMVE35R8AeMBQzwZ96XI1LiXhOVX
 EYqz78o2fYDhuGuGjNWJQfbLJy0MdN5B4tstGXKv2XjGMITmxN1IPtiEo7DhxJeRXk
 7m95RuOsM8cDOMI0zwtdNZgY+Q/dw6DR6wDa309ph/JAnkl6IuFUznyq5fZ1K+1Nx8
 84DghNrSdnVIY7R4HmPqlq9u42JtksfU5WJ94hCL1oyGrx6m6S2qc+2TrlXalbFI7q
 6/qZxVaIRe7+g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hLtFS5HW3z9rxK;
 Fri, 14 Aug 2026 08:52:12 +0200 (CEST)
Message-ID: <f48bdd6f-3afc-4aaf-b7e8-6fb2c5408e25@posteo.de>
Date: Fri, 14 Aug 2026 06:52:15 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] tests/functional/qemu_test: drop *args argument from
 .get_vm()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
 <20260729093146.1893719-3-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Thomas Huth <th.huth@posteo.de>
In-Reply-To: <20260729093146.1893719-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.de;
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

On 29/07/2026 11.31, Vladimir Sementsov-Ogievskiy wrote:
> It's redundant. Only one caller use it, and it may be simply
> substituted by .add_args().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/functional/migration.py          | 3 ++-
>   tests/functional/qemu_test/testcase.py | 9 +++------
>   2 files changed, 5 insertions(+), 7 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


