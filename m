Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACC8C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjafi-0004qa-UZ; Tue, 14 Jul 2026 06:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjafe-0004oz-VJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjafd-0002oD-78
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784026044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQ3dQ1n5tCQBSG7SlIqJQBftmYve5Yicvpr6+M6czGE=;
 b=TDdmmRSujjWszMTjuJci9Ef3EapIN9JWvCDxH5bmC9pawgrVB1SC61532e6DBLaPr8dCB2
 6MJ+5HSQ75aINO/vZBWiQ48kR4n8sFIes7YJW0bEA/pjlkU1QRY/khFcHUWD53Luo2XlRf
 HTi+95IckqwpayFV8Z0p7hlHsigNHtY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-bjes10DyMyWOlpyaKll-Aw-1; Tue,
 14 Jul 2026 06:47:21 -0400
X-MC-Unique: bjes10DyMyWOlpyaKll-Aw-1
X-Mimecast-MFC-AGG-ID: bjes10DyMyWOlpyaKll-Aw_1784026040
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77E82195605A; Tue, 14 Jul 2026 10:47:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.162])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71F4E180049F; Tue, 14 Jul 2026 10:47:18 +0000 (UTC)
Date: Tue, 14 Jul 2026 12:47:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH] block: Print simple help text when calling "-blockdev
 help"
Message-ID: <alYTtDv4m1ikN6vH@redhat.com>
References: <20260710093654.466642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710093654.466642-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kwolf@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Am 10.07.2026 um 11:36 hat Thomas Huth geschrieben:
> From: Thomas Huth <thuth@redhat.com>
> 
> Other command line options like "-chardev", "-netdev" or "-device"
> already present the user with a list of available parameters, but
> when running "-blockdev help", there is currently only an error
> message. There is already the possibility to run "-drive format=help",
> but it does not seem to be documented, so this is not very useful
> for the average user. Let's improve this situation by providing
> the same list of available drivers when running QEMU with
> "-blockdev help".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Seems like a good idea to print at least some minimal help there.
However, I find the list from -drive format=help quite hard to read, and
repeating the same list twice for read-write and read-only doesn't help
either.

I don't expect we can change -drive because I seem to remember that
management tools look at it, but can we make -blockdev help more
consistent with the other examples you mention? Something like this:

    Available blockdev drivers:
      blkdebug
      blklogwrites (read-only)
      blkreplay
      ...

Ideally, I'd also love to have a way to show all the options a specific
driver offers, but that probably won't happen before Markus QAPIfies the
CLI. :-)

>  include/block/block-common.h |  1 +
>  blockdev.c                   | 15 ++++++++++-----
>  system/vl.c                  |  7 +++++--
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index 895ea175413..010c4425dcf 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -583,5 +583,6 @@ char *path_combine(const char *base_path, const char *filename);
>  char *bdrv_get_full_backing_filename_from_filename(const char *backed,
>                                                     const char *backing,
>                                                     Error **errp);
> +void blockdev_show_help(void);
>  
>  #endif /* BLOCK_COMMON_H */
> diff --git a/blockdev.c b/blockdev.c
> index 6e86c6262f9..3d179939205 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -475,6 +475,15 @@ static OnOffAuto account_get_opt(QemuOpts *opts, const char *name)
>      return ON_OFF_AUTO_OFF;
>  }
>  
> +void blockdev_show_help(void)
> +{
> +      qemu_printf("Supported formats:");

We should definitely talk about "drivers" rather than "formats" with
-blockdev. The help in -drive was added in QEMU 0.10 when "formats" was
actually still accurate, but it hasn't been for a long time.

> +      bdrv_iterate_format(bdrv_format_print, NULL, false);
> +      qemu_printf("\nSupported formats (read-only):");
> +      bdrv_iterate_format(bdrv_format_print, NULL, true);
> +      qemu_printf("\n");
> +}
> +
>  /* Takes the ownership of bs_opts */
>  static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>                                     Error **errp)
> @@ -541,11 +550,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>  
>      if ((buf = qemu_opt_get(opts, "format")) != NULL) {
>          if (is_help_option(buf)) {
> -            qemu_printf("Supported formats:");
> -            bdrv_iterate_format(bdrv_format_print, NULL, false);
> -            qemu_printf("\nSupported formats (read-only):");
> -            bdrv_iterate_format(bdrv_format_print, NULL, true);
> -            qemu_printf("\n");
> +            blockdev_show_help();
>              goto early_err;
>          }
>  
> diff --git a/system/vl.c b/system/vl.c
> index 061cbdf860b..40c0593154a 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2961,7 +2961,10 @@ void qemu_init(int argc, char **argv)
>                            HD_OPTS);
>                  break;
>              case QEMU_OPTION_blockdev:
> -                {
> +                if (is_help_option(optarg)) {
> +                    blockdev_show_help();
> +                    exit(EXIT_SUCCESS);
> +                } else {
>                      Visitor *v;
>                      BlockdevOptionsQueueEntry *bdo;
>  
> @@ -2974,8 +2977,8 @@ void qemu_init(int argc, char **argv)
>                      visit_free(v);
>                      loc_save(&bdo->loc);
>                      QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
> -                    break;
>                  }
> +                break;
>              case QEMU_OPTION_drive:
>                  if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
>                                               optarg, false)) {
> -- 
> 2.55.0

Kevin


