Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7F5CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1JT-0000Lx-WB; Thu, 21 May 2026 07:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wQ1JS-0000LY-1O
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wQ1JO-0000uq-2j
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779361892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INh+V5hHibHDk2Hqobss9ELj54NQNaDB6mzx1D1c3SE=;
 b=E+JH/atwnVIDD6d5XyhOmmelftpNI+jcwNdTlo3d2Tr4sLN18RBPhGljMPYgTCsV911NRW
 jONWgtaFMJLrlothoQ0x/MV39GdnSQ8nWbLpFBx77V7F9ZQ4iYs3rXFV9zm4kYmXv+Chlw
 1mWWEDWUTyS9Yg5N4qmcZzAXPJ0oRXk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-X_U45vAhNfO2ScAHKRxW-g-1; Thu,
 21 May 2026 07:11:30 -0400
X-MC-Unique: X_U45vAhNfO2ScAHKRxW-g-1
X-Mimecast-MFC-AGG-ID: X_U45vAhNfO2ScAHKRxW-g_1779361890
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C02EE18005B8; Thu, 21 May 2026 11:11:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E0841681; Thu, 21 May 2026 11:11:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE5BC21E6A01; Thu, 21 May 2026 13:11:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  jasowang@redhat.com,  lvivier@redhat.com,
 sbrivio@redhat.com,  samuel.thibault@ens-lyon.org
Subject: Re: [PATCH 3/4] qapi/net: Wean SLIRP off QAPI type String to
 improve documentation
In-Reply-To: <177813267025.2413233.2433763734158027693.b4-review@b4>
 (marcandre lureau's message of "Thu, 07 May 2026 09:44:30 +0400")
References: <20260506105421.2461117-1-armbru@redhat.com>
 <20260506105421.2461117-4-armbru@redhat.com>
 <177813267025.2413233.2433763734158027693.b4-review@b4>
Date: Thu, 21 May 2026 13:11:26 +0200
Message-ID: <87tss1nhk1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

marcandre.lureau@redhat.com writes:

> On Wed, 06 May 2026 12:54:20 +0200, Markus Armbruster <armbru@redhat.com> wrote:
>> String's doc comment is useless.  Replace its use in NetdevUserOptions
>> by identical types with hopefully useful documentation.
>> 
>> While there, add a non-doc commment explaining why the port forwarding
>> interface is problematic.
>
> commment -> comment

Fixed, thanks!


