Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D24C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEA5Q-0002Fn-3r; Mon, 03 Jun 2024 11:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sEA5O-0002FT-N6
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sEA5M-0006Aj-Cw
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717430338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjZRTgn9qmVT/sBREieCS/gpAzmHNex6NjTyRRTZkmQ=;
 b=fAtxvsrv+pg0+eOgwsVnF/aKlDvGuBuOg4rL0WqqmQJmabI6fQyWUrpQnnTpvrFL3Qm3ZL
 bXjwACxOzWRr10oM0Bl68/QBlyARDJ5HWsKk49qaAlW2PnzunfjGQx15+Pb1qcl/7pijlC
 O8ZTK1oRkK6yXJTJhRJZoMPZcLMAUgQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-p9PpwOVIMLSf2zD5XmVGSg-1; Mon, 03 Jun 2024 11:58:57 -0400
X-MC-Unique: p9PpwOVIMLSf2zD5XmVGSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC95C8058D8;
 Mon,  3 Jun 2024 15:58:56 +0000 (UTC)
Received: from localhost (unknown [10.39.194.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 955341C0654B;
 Mon,  3 Jun 2024 15:58:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Pankaj Gupta <pankaj.gupta@amd.com>, Michael Roth
 <michael.roth@amd.com>
Subject: Re: [PATCH 3/4] linux-headers: Update to current kvm/next
In-Reply-To: <20240603131141.834241-4-pbonzini@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240603131141.834241-1-pbonzini@redhat.com>
 <20240603131141.834241-4-pbonzini@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 03 Jun 2024 17:58:55 +0200
Message-ID: <874jaam30g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 03 2024, Paolo Bonzini <pbonzini@redhat.com> wrote:

> From: Pankaj Gupta <pankaj.gupta@amd.com>
>
> Also brings in an linux-headers/linux/vhost.h fix from v6.9-rc4.
>
> Co-developed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Message-ID: <20240530111643.1091816-3-pankaj.gupta@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  linux-headers/asm-loongarch/kvm.h |  4 +++
>  linux-headers/asm-riscv/kvm.h     |  1 +
>  linux-headers/asm-x86/kvm.h       | 52 ++++++++++++++++++++++++++++++-
>  linux-headers/linux/vhost.h       | 15 ++++-----
>  4 files changed, 64 insertions(+), 8 deletions(-)

Hm, I'm not sure updating to kvm/next is a good idea ("current kvm/next"
does not mean anything without a commit hash anyway.) I think we should
only update to something that's in Linus' tree already... how stable is
kvm/next?


