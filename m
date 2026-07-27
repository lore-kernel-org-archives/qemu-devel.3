Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9676EC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woH0G-0003na-82; Mon, 27 Jul 2026 04:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1woH0E-0003n3-Lz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1woH0D-0006Gr-9c
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785142079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vrF4VRHtybrXoarfKc7lVgALmoH8Hdj/KPP9O0tx5KY=;
 b=VxQO3IMYEeXzfI1eSOhjLDJfmFTAAOeYY9kZfp+5eOB/6UkhxZkJYZdJIBuvuQ181d8DFE
 l7O/MKIsNU2gNVAXhAQJi5wt4C8NeTW7QxNmICs+GNIx11cR2n74GTjKKZeFLED7qflku9
 WmHbmref9tOy0Qff34sragSX3xqErTM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-xwQxAvbkMtqtoTvQTiez_w-1; Mon,
 27 Jul 2026 04:47:58 -0400
X-MC-Unique: xwQxAvbkMtqtoTvQTiez_w-1
X-Mimecast-MFC-AGG-ID: xwQxAvbkMtqtoTvQTiez_w_1785142077
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04C50180063D
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:47:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6D9E19560AB
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:47:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27BF321E6920; Mon, 27 Jul 2026 10:47:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] scripts/qapi: reject empty enums
In-Reply-To: <20260724130044.1369843-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 24 Jul 2026 15:00:42 +0200")
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-3-pbonzini@redhat.com>
Date: Mon, 27 Jul 2026 10:47:54 +0200
Message-ID: <87a4rc24zp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Raise an error if an enum has no members.  Such enums cannot be populated
> with a valid value, and therefore they can only be used as optional
> members.  But QAPI leaves out optional members from the serialization
> protocol, and therefore the existence of the enum is completely pointless.
>
> The same limitation is not extended to an enum whose members are all
> compiled out; these can still be useful as optional members.  However they
> cannot implicitly block usage of parent structures because, by virtue
> of having only conditional members, they are "enums with conditional
> first item" and must therefore be optional.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This one definitely needs to update docs/devel/qapi-code-gen.rst,
because that one has

    Nothing prevents an empty enumeration, although it is probably not
    useful.


