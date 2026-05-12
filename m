Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF77CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 07:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMhnm-0003EI-DD; Tue, 12 May 2026 03:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wMhnj-0003Dx-D1
 for qemu-devel@nongnu.org; Tue, 12 May 2026 03:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wMhnh-0005qf-Bw
 for qemu-devel@nongnu.org; Tue, 12 May 2026 03:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778571907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dxw+KC79cEhv7mq9KwE1xaDqZt0dlxWynsbKD1dkjqw=;
 b=MtyU1AKiEMElFR6v9MgIjpwaUjS6CEONBkIJ8djYCasiUoYs5i6JQnXqog7kbKmEs2zziK
 YqY0RxOvIle6lQakRlwX37FBRFYEezQHqs+4zT2fYhJQvZBl6uLOkOx1Yva7/8DHDUxkfe
 2+xgBld70Rm0FPMXs8KTsS9LA0lIkPg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-E4kmV6DEMmeBdzp-WVXE7g-1; Tue,
 12 May 2026 03:45:03 -0400
X-MC-Unique: E4kmV6DEMmeBdzp-WVXE7g-1
X-Mimecast-MFC-AGG-ID: E4kmV6DEMmeBdzp-WVXE7g_1778571902
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1EB4195608A; Tue, 12 May 2026 07:45:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81B201955D84; Tue, 12 May 2026 07:45:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2405B21E6A01; Tue, 12 May 2026 09:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH] MAINTAINERS: Update RDMA migration entry with M:
In-Reply-To: <20260511143026.1296485-1-peterx@redhat.com> (Peter Xu's message
 of "Mon, 11 May 2026 10:30:26 -0400")
References: <20260511143026.1296485-1-peterx@redhat.com>
Date: Tue, 12 May 2026 09:44:59 +0200
Message-ID: <87y0hpysuc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> We wanted to remove RDMA migration once but that didn't go further.  In
> reality, with the help of Zhijian it's in Odd Fixes stage, even if we just
> merged one new parameter for it, for performance improvements.
>
> Markus pointed out we'd better have at least one M: for it to match
> anything that is not orphaned.
>
> Remove the X: for Migration entry for RDMA files, then it'll start to cover
> RDMA migration again. Keep the separate entry so Zhijian can keep getting
> copied, and copy the M:s over to say someone is collecting patches.
> Logically these M:s aren't needed after removing X:, but make it clearer.
>
> Link: https://lore.kernel.org/r/5326b854-fcea-4af6-a479-792888a94a4d@fujitsu.com
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


