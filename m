Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9316ACD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgv9-0008Pz-60; Wed, 03 Jun 2026 04:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wUguw-0008Ft-UM; Wed, 03 Jun 2026 04:25:39 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wUguu-00037s-U3; Wed, 03 Jun 2026 04:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780472049; bh=IyKmmrjRSTjCqBDoc+8xadhMTG5L1N02ixZuIixlXx4=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=YeSOi6Xqw7Yfd/346AHn6217vygwFhzGF86Bt62i2cBhw9GByiQ9EOnq+J26wS7DU
 d4MiIlx1sQHmTdl9a1AWBD9mcfW6lRx6HN/gzvhLENaVlHSy1zZekHRm1u50ptEiwp
 tjUjB5m/Lj1CBmFxF7BCNiwxxdzzewT/0ewtRbE4=
Received: by be1-3.in.mailobj.net [192.168.91.13] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:33:16 +0200 (CEST)
X-EA-Auth: M/fRqN/leJFbwiNTuUieuG/HxgMTHxj/Wl4kZgVxu5tyooH2zG2a/HNeBF6Ktipcw51Y6KXHf2sAqMKjlXRVpLHJDb6o5q+C
Message-ID: <1d838357-b2f2-4967-8401-a6d95cc337cb@mailo.com>
Date: Wed, 3 Jun 2026 09:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/38] MAINTAINERS: Drop stale F: from "New World
 (mac99)"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-16-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-16-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
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

On 3/6/26 08:40, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we deleted
> hw/pci-bridge/dec.[hc].  Update it now.
> 
> Fixes: b1fbf24259 (remove DEC 21154 PCI bridge, 2022-11-29)
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>


