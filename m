Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA81BEDF158
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 12:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqsSf-0008GV-ML; Fri, 13 Feb 2026 07:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqsSX-0008G3-Ti
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 07:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqsSV-0002Nu-Ry
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 07:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770986380;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3Av7dlkGn6BgFANq4D2HsgiZwLy1D0vfzVaQC1Jj6TY=;
 b=DAO2MX+w35ojXoctSwWFNI3e/pm8C62aDXtoZ4XKoTvZ7d+lINpLb10N3vnCca3BhH6ca2
 Nol0KlqLwLK9jTdVIaVqx1RiHX3+yiOipk4JFfZMnZqWRDCm3MwawCKlQFpcM53t4hdZlB
 qFXugekEcMPYIoEvrWrwwyFHChymcxY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-Ax9gyzvdMxu0t4JKOCQaTg-1; Fri,
 13 Feb 2026 07:39:37 -0500
X-MC-Unique: Ax9gyzvdMxu0t4JKOCQaTg-1
X-Mimecast-MFC-AGG-ID: Ax9gyzvdMxu0t4JKOCQaTg_1770986376
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 720A419560B2; Fri, 13 Feb 2026 12:39:35 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C91EC30001B9; Fri, 13 Feb 2026 12:39:32 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:39:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Oliver Chang <ochang@google.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: Re: A.I. generated patch (was: [PATCH] hw/9pfs: fix
 heap-buffer-overflow in v9fs_complete_rename)
Message-ID: <aY8bgYqj0rZFdvtW@redhat.com>
References: <E1vqq09-000FBe-2m@kylie.crudebyte.com> <3030453.e9J7NaK4W3@weasel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3030453.e9J7NaK4W3@weasel>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 13, 2026 at 01:25:57PM +0100, Christian Schoenebeck wrote:
> On Friday, 13 February 2026 10:56:05 CET Christian Schoenebeck wrote:
> > From: Oliver Chang <ochang@google.com>
> > 
> > When `v9fs_complete_rename` is called with `newdirfid == -1`, it attempts to
> > derive the directory name from `fidp->path.data` using
> > `g_path_get_dirname`. This logic assumes that `fidp->path.data` always
> > contains a null-terminated string representing a pathname.
> > 
> > While this assumption holds for the 'local' backend, the 'synth' backend
> > stores a `V9fsSynthNode *` pointer directly in the `V9fsPath.data` buffer.
> > When using 'synth', `g_path_get_dirname` treats this pointer as a string,
> > often resulting in a short string like ".".
> > 
> > The subsequent call to `v9fs_co_name_to_path` invokes `synth_name_to_path`,
> > which expects `dir_path.data` to contain a `V9fsSynthNode *`. It attempts to
> > read 8 bytes (on 64-bit) from the buffer. If `g_path_get_dirname` returned
> > a short string, this results in a heap-buffer-overflow read.
> > 
> > Fix this by checking for the `V9FS_PATHNAME_FSCONTEXT` flag in the export
> > flags. This flag indicates that the backend supports string-based pathnames.
> > If it is not set (as in the 'synth' backend), return `-EOPNOTSUPP` to
> > prevent invalid memory access.
> > 
> > Co-authored-by: CodeMender <codemender-patching@google.com>
> > Fixes: https://issues.oss-fuzz.com/issues/477990727
> > ---
> 
> Oliver, IIUIC your patch was auto generated by A.I. and AFAICS QEMU's current
> policies forbid any A.I. generated contributions in general:
> 
> https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content

This issue was previously reported to qemu-security where we have already
rejected inclusion of the patch on the basis that it was created using
AI tools which is not in compliance with our policy.

> It is also missing a Signed-off-by: tag BTW.

NB, signing off an AI (co-)authored patch is something we don't consider
valid per the policy.

> Technically the patch should better be generalized anyway, at least by moving
> the V9FS_PATHNAME_FSCONTEXT check to the beginning of the function, as
> renaming is only possible with pathname-based fs drivers.
> 
> Peter, would that be sane enough or would such a v2 patch considered as
> "derived from A.I content" as well?

Throw away the existing AI tainted patch, and write a clean patch
without reference to the original. It'll be a v1 patch at that
point.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


