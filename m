Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FF4C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXal-0006bO-Qt; Mon, 29 Jan 2024 14:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rUXaj-0006Xy-4F
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rUXag-00078L-Jg
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706557604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qzq3sO+n7wCCgYAgkn/LJWbXacM/129ezBZMOdPLKYM=;
 b=h7VOd4IcvcAyGaf2DpYyGPqxjmCT1OkuvYS7lVkkaMPbauz2dWIqaWf6yGuw2q4z5yq0Vf
 hJnCmeO3l3jkS9d3hNzixZ+QwkXDn5na1BS0gkxsgsujiOJO40PELD+0TXp+mysCT3GLGN
 6cHSQxhoaLx0aIcXXvDX0EWROpIGoiM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-WYV0TH__OGSHY8qtSMSnXw-1; Mon,
 29 Jan 2024 14:46:37 -0500
X-MC-Unique: WYV0TH__OGSHY8qtSMSnXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFF273C2B61F;
 Mon, 29 Jan 2024 19:46:36 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D88C8492BE2;
 Mon, 29 Jan 2024 19:46:35 +0000 (UTC)
Date: Mon, 29 Jan 2024 13:46:34 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 michael.roth@amd.com, kkostiuk@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 1/5] qapi: Drop redundant documentation of inherited
 members
Message-ID: <me76g5nvk3kwkqarjqsbcf4j2hvufz4e7alrxxzo6wpcnpg6s3@epuohshrgeqq>
References: <20240129115008.674248-1-armbru@redhat.com>
 <20240129115008.674248-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129115008.674248-2-armbru@redhat.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 29, 2024 at 12:50:04PM +0100, Markus Armbruster wrote:
> Documentation generated for SchemaInfo looks like
> 
>     The members of "SchemaInfoBuiltin" when "meta-type" is ""builtin""
>     The members of "SchemaInfoEnum" when "meta-type" is ""enum""
>     The members of "SchemaInfoArray" when "meta-type" is ""array""
>     The members of "SchemaInfoObject" when "meta-type" is ""object""
>     The members of "SchemaInfoAlternate" when "meta-type" is ""alternate""
>     The members of "SchemaInfoCommand" when "meta-type" is ""command""
>     The members of "SchemaInfoEvent" when "meta-type" is ""event""
>     Additional members depend on the value of "meta-type".
> 
> The last line became redundant when commit 88f63467c57 (qapi2texi:
> Generate reference to base type members) added the lines preceding it.
> Drop it.
> 
> BlockdevOptions has the same issue.  Drop
> 
>     Remaining options are determined by the block driver.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json | 2 --
>  qapi/introspect.json | 2 --
>  2 files changed, 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


