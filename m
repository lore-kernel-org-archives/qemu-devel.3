Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3A606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=gvu0rvSR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBuz-0006uc-J5; Tue, 20 Oct 2026 11:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xJBuw-0006pQ-JA; Tue, 20 Oct 2026 11:38:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xJBut-0007D2-OL; Tue, 20 Oct 2026 11:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792510687; bh=VSn8KT5xjc2UznQXqt09K3q8P+O29mz1YertO15/uzg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gvu0rvSRSIsrmHQVlxL5XHm5JxK2fcZ/miox0R+c2BGMZNDumPChNummCIu9KxwPZ
 Z5zb72D7d9cUxHWY3tb0z/4bkLbNstgEjcs5gpENct6wo6NgCVpSvPiGZj9fOjPN1t
 ToV9/PzM0cb9kp64eFoyO0V62a6DZkb4mjud2iUli87GTq943QBjUfBmXGagh6tiBD
 OUDiVD6IOEMUd6ihXjS3SOkTh2eM5cJaYlG+V1D7Kc/TnllSWgeG39X127QWDrUxp/
 1+FwxF4HNVI67tiIP4VrO/gGNJB/PAYP7J04COqc1DySujsT4wnQ2A/Tky7/6rteN+
 EDIc2x8953UiQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1E0691DF3B5;
 Tue, 20 Oct 2026 18:38:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 92003446579;
 Tue, 20 Oct 2026 18:38:06 +0300 (MSK)
Message-ID: <d70fcc30-a9f7-4615-95de-610be38f9274@tls.msk.ru>
Date: Tue, 20 Oct 2026 18:38:06 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH not-so-trivial v2] treewide: use qemu_dup() instead of
 dup()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
References: <20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com>
 <as3lliIKDs6aTRnS@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <as3lliIKDs6aTRnS@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/26 11:02, Daniel P. Berrangé wrote:
> On Tue, Oct 13, 2026 at 12:01:58AM +0200, Filip Hejsek wrote:
>> Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.
>>
>> The following dup() instances were left unchanged:
>>
>>      FILE                     REASON
>>      util/osdep.c             implementation of qemu_dup
>>      migration/cpr-exec.c     fd is intentionally kept across exec
> 
> IMHO that should use qemu_dup() too, and then explicitly
> clear the O_CLOEXEC flag so intended behaviour is clear.
> Right now it looks like a mistaken failure to use qemu_dup.
> 
>>      tests/*                  left for future work
> 
> Why not fix them now ? There are only a few uses which look suitable
> to change.

I'd say let's apply this one and fix the rest later.

I don't see a big need to do that in tests/ - if not only for
consistency.

Thanks,

/mjt

