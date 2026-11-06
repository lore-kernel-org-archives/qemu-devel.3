Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05999606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=lYFBqYaM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNLq-0004l7-IY; Fri, 06 Nov 2026 12:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xPNLW-0004cb-Bj; Fri, 06 Nov 2026 12:03:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xPNLU-0001Bq-1K; Fri, 06 Nov 2026 12:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793984594; bh=BXM+fkXqpHqwWC5hhFoP7QHiOXQANVdcTLfb8/sDgY0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lYFBqYaM/2o6GQldVCUI2bTJaJglfBSnYJ5oKUSf3HFvnT8eedQX8RsQFVm9qIwnS
 RFW0vfDtsLVcAZiFlLQbkGBOKg/709tpSTVF9bqcvdO3lyuZrQPlPS331WJQW21kL+
 ka3aC2tErWO070LV8vAoBFhWIrXBg2wktyQzOwh9L5bmvAAtt2NNCy0GAF3/LvpAWZ
 zt9sF2boucDKw1Ql1ydQppzew/Swj/aMPl8TvrY2SjTd/7isltJdcFjwSoVfyG9Dpq
 XwEbSatI38xBAhx4FLjNsxISdZLtS/wkSpeScdM7THpGGv80ezh0P4//ku5QINtd5K
 3H2HTu1jtN/8Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 228521E45CF;
 Fri, 06 Nov 2026 20:03:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 06821455C4E;
 Fri, 06 Nov 2026 20:03:14 +0300 (MSK)
Message-ID: <ef20aba0-a861-4acb-b5c2-1ebb37b9d31f@tls.msk.ru>
Date: Fri, 6 Nov 2026 20:03:13 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
To: Oleg Drokin <green@linuxhacker.ru>
Cc: mst@redhat.com, qemu-devel@nongnu.org,
 QEMU Stable <qemu-stable@nongnu.org>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
 <56f5cf1d-e221-465f-8993-866d744241ca@tls.msk.ru>
 <4365e62de77171ab81ade60344453ee67d73c74c.camel@linuxhacker.ru>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <4365e62de77171ab81ade60344453ee67d73c74c.camel@linuxhacker.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/6/26 11:53, Oleg Drokin wrote:
> Hi Michael,
> 
> these master commits fix bugs that are also present in 10.0.x and are
> not in staging-10.0 yet.
> - a2fbf1785b hw/ide/ahci: clear cur_cmd when the command list is
> unmapped
> - d7f16bad8f hw/ide/ahci: refuse a PIO transfer with no command header
> - 2713717148 hw/ide/ahci: treat a failed PRDT walk as a PIO transfer
> failure
> - 795af987ce hw/ide/ahci: reject a command header with an invalid FIS
> length

FWIW, https://lore.kernel.org/qemu-devel/61d9eca3-8bb0-468c-b448-1e7f601a9dba@tls.msk.ru/

(This patchset is marked as "Review later" in my queue.  I tend to avoid picking up
stuff when there's no agreement from the subsystem maintainer or the patch author).

Thanks,

/mjt

