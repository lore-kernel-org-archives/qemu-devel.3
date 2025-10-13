Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1474CCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8B2e-0001iI-TM; Mon, 13 Oct 2025 01:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1v8B2d-0001iA-HX
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:24:15 -0400
Received: from submarine.notk.org ([2001:bc8:3310:100::1])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <asmadeus@codewreck.org>) id 1v8B2a-0000Ka-80
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:24:14 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 894B814C2D3;
 Mon, 13 Oct 2025 07:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1760333050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/miwYTsDRBvjsObNr5XeLc01jPF/7GbRiEJiMflLRc=;
 b=eqr8YwzUXF2PyjZgDb0grNPFBA8/3gF65QxDY6VplRcmONAycVbR0carSGHjYjORx5+I9M
 JXUeP1LS5hFVydPbTiSlQc3lMnZT+fAAxzwrGwzMzsM9Clgy5bT6FlcIBpqUIfyCSr6bPO
 hBcKD1Qm1qYQ5K1t2XiQpx1juPza5iWm6jOHmg6Jsc5lltfg+cE6Y+w5d8hAL3tmLz8aOe
 qHVbBGTTLO9lLJdHGsekErlpQJVMUhVGamlUe9F9WTUVQirZft+FG4o05NWJcp8QTywTEo
 /bM+51qYcTVQL+xWQtLo0BI+ja9MfFwEinL1S2/HM5CEMhJHZGUKQ3cVTCjRrQ==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6fc33ef3;
 Mon, 13 Oct 2025 05:24:03 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:23:48 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH RFC v5 07/12] qmp: add chardev-window-size-changed command
Message-ID: <aOyM5Gv3tZ5THfaA@codewreck.org>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-7-89e3c6727060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250921-console-resize-v5-7-89e3c6727060@gmail.com>
Received-SPF: pass client-ip=2001:bc8:3310:100::1;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek wrote on Sun, Sep 21, 2025 at 01:45:37AM +0200:
> +##
> +# @chardev-window-size-changed:
> +#
> +# Notifies a chardev about the current size of the terminal connected
> +# to this chardev. The information will be forwarded to the guest if
> +# the chardev is connected to a virtio console device.
> +#
> +# The initial size is 0x0, which should be interpreted as an unknown size.

Actually coming back to this: what does that "initial size" mean?

If there had been a qmp command to get the current size I'd understand,
but this is set-only as far as I can see, so there is no initial size?

(not that it matters)

Thanks,
-- 
Dominique Martinet | Asmadeus

