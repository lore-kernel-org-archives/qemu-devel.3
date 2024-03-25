Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43217C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolr5-0003x9-FH; Mon, 25 Mar 2024 11:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rolqy-0003wj-NR
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rolqw-00056q-PI
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711378989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4n5hTCZfGhmRe/93Daqk0Q+pzqxUPQ87+zx4n9kwBlk=;
 b=hHS22jyK8yMJwWAeBeV8qwdkb3Fn8a3w9g0h3YpaoNaV7+0T+Fp3LcP9YEmak/7tLqggmr
 Zckhgg/1emTfWavG/5/3zGro5nhWricZE0cTo85ccxF+jL9htePay9TJII/O4jQ0z/mLk6
 3pXOHBF3mA7wArOhvzVKvaJiPPauBBs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-umGS81wCO0qVfIKGMix9kw-1; Mon,
 25 Mar 2024 11:03:05 -0400
X-MC-Unique: umGS81wCO0qVfIKGMix9kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7163129ABA0A;
 Mon, 25 Mar 2024 15:03:05 +0000 (UTC)
Received: from localhost (unknown [10.22.8.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E317200A384;
 Mon, 25 Mar 2024 15:03:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
In-Reply-To: <20240325141422.1380087-2-pbonzini@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-2-pbonzini@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 25 Mar 2024 16:02:59 +0100
Message-ID: <87ttku73rw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 25 2024, Paolo Bonzini <pbonzini@redhat.com> wrote:

> Add 9.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/boards.h        |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  hw/arm/virt.c              | 11 +++++++++--
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 17 ++++++++++++++---
>  hw/i386/pc_q35.c           | 14 ++++++++++++--
>  hw/m68k/virt.c             | 11 +++++++++--
>  hw/ppc/spapr.c             | 17 ++++++++++++++---
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  10 files changed, 83 insertions(+), 13 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


