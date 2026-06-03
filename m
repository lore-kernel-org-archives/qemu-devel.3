Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E13CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgux-0008Fr-Kw; Wed, 03 Jun 2026 04:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgur-0008F1-BF
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:33 -0400
Received: from msg-4.mailo.com ([213.182.54.15] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgup-000345-MX
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780471869; bh=77GOEmZV9qaEqRp03oAIJg97fniuxkfCRBHGFUAen9M=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=Qw4w4t9Zk+lG/pr1zAC0lHy9cfEAWmOcyEu1W6EN0n8ORoo4UNZTjg/nw8lHhKWB9
 mHvJ83iMVeFQghuVpg/pV4ZZlTdpNCd4BLa2BPNQWfhSb08xUf31vQqpmCiHaujtbD
 7KOgewM//kGskwTQNnvF2TCEbtKVrOtoh8P2pDwo=
Received: by be1-3.in.mailobj.net [192.168.91.13] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:30:56 +0200 (CEST)
X-EA-Auth: ciTW0JDk+KV2s118KBL7MiWzJ1uqpOdFxkmc58zf1K3oGiDW7yPJWKjdVpm4xCgZpd+qbW/CyA378BUgPXknY2wNuHo7qmMX
Message-ID: <00a44006-91ea-44d9-a43c-ba37f4dbcf1f@mailo.com>
Date: Wed, 3 Jun 2026 09:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/38] MAINTAINERS: Drop stale F: from "Overall KVM
 CPUs"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.15; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/6/26 08:39, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we moved the only file out of
> include/hw/kvm/.  Its new location is covered by "X86 TCG CPUs".  Drop
> the stale line.
> 
> Fixes: a09ef8ff0a (hw/i386: Rename 'hw/kvm/clock.h' -> 'hw/i386/kvm/clock.h', 2023-06-20)
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>


