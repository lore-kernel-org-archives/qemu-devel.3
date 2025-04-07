Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37637C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oHH-0002Uu-91; Mon, 07 Apr 2025 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1oEn-0007ni-Mc
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1oEl-0006SM-Ar
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744039089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RYS7hX1Aj2ZyquQBvdG1SzKzCeyask2GQM14+Pp5nQ=;
 b=fYGYiFoRFlQbJMH728euW3nhkOcQu/+ksRwMvjlZUjphmVL3/HkVFJd8XbfTtko++wYttY
 JWeW3Pi960wVZHumK+B3LuGx4NXxO+rPMdqystShBGItRbrf9m7/8Yy98RWlVduAQhEEvp
 YsT/WB3RfkWGQkKlfWQzaxE71sK32MM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-uLyymw2-NFiyh9cYyvg-Ig-1; Mon,
 07 Apr 2025 11:18:07 -0400
X-MC-Unique: uLyymw2-NFiyh9cYyvg-Ig-1
X-Mimecast-MFC-AGG-ID: uLyymw2-NFiyh9cYyvg-Ig_1744039086
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30B29180AF72; Mon,  7 Apr 2025 15:18:06 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 703371801766; Mon,  7 Apr 2025 15:18:03 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:18:00 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com, 
 kwolf@redhat.com, jsnow@redhat.com, peter.maydell@linaro.org, jiri@resnulli.us,
 qemu-block@nongnu.org
Subject: Re: [PATCH 00/11] qapi: Documentation improvements
Message-ID: <lurnrgddx4cxgqou3t524ffkeew3mzwxqrivyhudtqyg74sco2@xrsno4hnfide>
References: <20250404121413.1743790-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404121413.1743790-1-armbru@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Apr 04, 2025 at 02:14:02PM +0200, Markus Armbruster wrote:
> Markus Armbruster (11):
>   docs/devel/qapi-code-gen: Tidy up whitespace
>   qapi/rocker: Tidy up query-rocker-of-dpa-flows example
>   docs/interop: Delete "QEMU Guest Agent Protocol Reference" TOC
>   docs/interop: Sanitize QMP reference manuals TOC
>   docs/devel/qapi-code-gen: Improve the part on qmp-example directive
>   docs/sphinx/qmp_lexer: Generalize elision syntax
>   docs/sphinx/qmp_lexer: Highlight elisions like comments, not prompts
>   qapi/qapi-schema: Update introduction for example notation
>   qapi/qapi-schema: Address the introduction's bit rot
>   storage-daemon/qapi/qapi-schema: Add a proper introduction
>   qga/qapi-schema: Add a proper introduction

I noticed at least one typo and replied in-place, but overall the
series is good once you touch that up.  For the series:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


