Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423DBC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5ic-0001Mu-4G; Thu, 25 Jan 2024 14:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rT5ib-0001Ml-9H
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:48:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rT5iZ-0007xq-Rq
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706212133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sdcd+8NuW0mkMumBAi7O/0l9rRG2hGj0Pxoe4i7o4bE=;
 b=RLBe6/LlQsIUrl4kK0fs8jRfarUjHRT52K8cudWfahxc785HJfApGcu44jZTiuylk8woG7
 SU0j8dLT2kCBgcNYYgoUuBRamKB9ATfJGt57tq27GadqgeU0cgzLwEY9z0q8F3k3P6Czfi
 uzv3GDqmxo535RJa75do3aNcDPhQoX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-6zaVG8OHPCWzz37aaUVTQw-1; Thu, 25 Jan 2024 14:48:48 -0500
X-MC-Unique: 6zaVG8OHPCWzz37aaUVTQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 074DC185A783;
 Thu, 25 Jan 2024 19:48:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9A68D38;
 Thu, 25 Jan 2024 19:48:46 +0000 (UTC)
Date: Thu, 25 Jan 2024 13:48:45 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org, 
 jsnow@redhat.com
Subject: Re: [PATCH 0/7] qapi qmp: Documentation fixes
Message-ID: <hozt5yxggkrqdlmzvunrqkxnjxylu44jaxe7fv2n6eh23ft4hd@vmvkhydox4x6>
References: <20240120095327.666239-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120095327.666239-1-armbru@redhat.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

On Sat, Jan 20, 2024 at 10:53:20AM +0100, Markus Armbruster wrote:
> Markus Armbruster (7):
>   docs/devel/qapi-code-gen: Fix missing ':' in tagged section docs
>   docs: Replace dangling references to docs/interop/qmp-intro.txt
>   qapi: Fix dangling references to docs/devel/qapi-code-gen.txt
>   docs/interop/bitmaps: Clean up a reference to qemu-qmp-ref
>   qapi: Fix mangled "Returns" sections in documentation
>   qapi: Indent tagged doc comment sections properly
>   qapi: Fix malformed "Since:" section tags (again)

For the series:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


