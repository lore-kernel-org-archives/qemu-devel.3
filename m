Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB69CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 13:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNt1F-0002kn-7y; Fri, 15 May 2026 09:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNt19-0002k1-HX
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNt17-0007Pm-37
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778853351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wlnz3mDl5OFUyB9iCut8rHcPs56xvHFNAOA+VHWizWo=;
 b=APDeBBE0Z9+Yzx2nGV9q6SCFVO+mwYAmRBidW03YkAYDDWvem44du4LtZdfquVcoKXDhUQ
 AayYaPIMYL4uvQFvA9mAR15d5QroI4Dh7n98worf0LjEhZG+N+FpJwRnOCCvlEKhnwTb5a
 ++l40YuyQy1V9ylJ+TXbF9ALY5hrEq4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-dsEnc6N_NEaUkk3baUsk3A-1; Fri,
 15 May 2026 09:55:49 -0400
X-MC-Unique: dsEnc6N_NEaUkk3baUsk3A-1
X-Mimecast-MFC-AGG-ID: dsEnc6N_NEaUkk3baUsk3A_1778853348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C1DA18002D7; Fri, 15 May 2026 13:55:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B44E11800762; Fri, 15 May 2026 13:55:46 +0000 (UTC)
Date: Fri, 15 May 2026 15:55:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 1/1] qemu-img: add sub-command --remove-all to
 'qemu-img bitmap'
Message-ID: <agcl4DjbG7t17LqR@redhat.com>
References: <20260424105949.254757-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424105949.254757-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 24.04.2026 um 12:59 hat Denis V. Lunev geschrieben:
> From time to time it is needed to remove all bitmaps from the image.
> Before this patch the process is not very convenient. One should
> perform
>     qemu-img info
> and parse the output to obtain all names. After that one should
> sequentially call
>     qemu-img bitmap --remove
> for each present bitmap.
> 
> The patch adds --remove-all sub-command to 'qemu-img bitmap'.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
> Changes from v2:
> * rebased to the lastest head
> 
> Changes from v1:
> * rebased to latest head
> * adopted bitmap help to the new layout
> 
>  docs/tools/qemu-img.rst | 10 +++++---
>  qemu-img.c              | 53 ++++++++++++++++++++++++++++++++++-------
>  2 files changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 558b0eb84d..b0c798b77a 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -301,15 +301,19 @@ Command description:
>    For write tests, by default a buffer filled with zeros is written. This can be
>    overridden with a pattern byte specified by *PATTERN*.
>  
> -.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME [BITMAP]
>  
> -  Perform one or more modifications of the persistent bitmap *BITMAP*
> -  in the disk image *FILENAME*.  The various modifications are:
> +  Perform one or more modifications of persistent bitmaps in the disk
> +  image *FILENAME*.  Most operations require *BITMAP* to be specified;
> +  ``--remove-all`` operates on all bitmaps and does not take *BITMAP*.
> +  The various modifications are:
>  
>    ``--add`` to create *BITMAP*, enabled to record future edits.
>  
>    ``--remove`` to remove *BITMAP*.
>  
> +  ``--remove-all`` to remove all bitmaps.
> +
>    ``--clear`` to clear *BITMAP*.
>  
>    ``--enable`` to change *BITMAP* to start recording future edits.
> diff --git a/qemu-img.c b/qemu-img.c
> index c42dd4e995..22ddc7a627 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -87,6 +87,7 @@ enum {
>      OPTION_FORCE = 276,
>      OPTION_SKIP_BROKEN = 277,
>      OPTION_LIMITS = 278,
> +    OPTION_REMOVE_ALL = 279,
>  };
>  
>  typedef enum OutputFormat {
> @@ -5018,6 +5019,7 @@ enum ImgBitmapAct {
>      BITMAP_ENABLE,
>      BITMAP_DISABLE,
>      BITMAP_MERGE,
> +    BITMAP_REMOVE_ALL,
>  };
>  typedef struct ImgBitmapAction {
>      enum ImgBitmapAct act;
> @@ -5036,7 +5038,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>      BlockDriverState *bs = NULL, *src_bs = NULL;
>      bool image_opts = false;
>      int64_t granularity = 0;
> -    bool add = false, merge = false;
> +    bool add = false, merge = false, remove_all = false, any = false;

It's quite unclear what "any" is supposed to mean. From the code it
looks like it's set when a bitmap name must be specified (which is the
opposite of what I'd think of with "any").

Can we use something more descriptive like need_bitmap_name?

>      QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
>      ImgBitmapAction *act, *act_next;
>      const char *op;
> @@ -5052,6 +5054,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              {"add", no_argument, 0, OPTION_ADD},
>              {"granularity", required_argument, 0, 'g'},
>              {"remove", no_argument, 0, OPTION_REMOVE},
> +            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
>              {"clear", no_argument, 0, OPTION_CLEAR},
>              {"enable", no_argument, 0, OPTION_ENABLE},
>              {"disable", no_argument, 0, OPTION_DISABLE},
> @@ -5070,8 +5073,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>          switch (c) {
>          case 'h':
>              cmd_help(ccmd, "[-f FMT | --image-opts]\n"
> -"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
> -"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
> +"        ( --add [-g SIZE] | --remove | --remove-all | --clear | --enable |\n"
> +"          --disable | --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
>  "        [--object OBJDEF] FILE BITMAP\n"
>  ,
>  "  -f, --format FMT\n"
> @@ -5086,6 +5089,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>  "     with optional multiplier suffix (in powers of 1024)\n"
>  "  --remove\n"
>  "     removes BITMAP from FILE\n"
> +"  --remove-all\n"
> +"     removes all bitmaps from FILE\n"
>  "  --clear\n"
>  "     clears BITMAP in FILE\n"
>  "  --enable, --disable\n"
> @@ -5115,7 +5120,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_ADD;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            add = true;
> +            add = any = true;

One assignment per line, please.

>              break;
>          case 'g':
>              granularity = cvtnum("granularity", optarg, true);
> @@ -5127,28 +5132,38 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_REMOVE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
> +            break;
> +        case OPTION_REMOVE_ALL:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_REMOVE_ALL;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            remove_all = true;
>              break;
>          case OPTION_CLEAR:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_CLEAR;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>              break;
>          case OPTION_ENABLE:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_ENABLE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>              break;
>          case OPTION_DISABLE:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_DISABLE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>              break;
>          case OPTION_MERGE:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_MERGE;
>              act->src = optarg;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            merge = true;
> +            any = merge = true;

Same here.

>              break;
>          case 'b':
>              src_filename = optarg;
> @@ -5165,8 +5180,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>      }
>  
>      if (QSIMPLEQ_EMPTY(&actions)) {
> -        error_report("Need at least one of --add, --remove, --clear, "
> -                     "--enable, --disable, or --merge");
> +        error_report("Need at least one of --add, --remove, --remove-all, "
> +                     "--clear, --enable, --disable, or --merge");
>          goto out;
>      }
>  
> @@ -5184,10 +5199,14 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>          goto out;
>      }
>  
> -    if (optind != argc - 2) {
> +    if (any && optind != argc - 2) {
>          error_report("Expecting filename and bitmap name");
>          goto out;
>      }
> +    if (!any && remove_all && optind != argc - 1) {

Doesn't !any already imply remove_all? If both weren't set, actions
would be empty and we'd already have errored out above.

This probably means that remove_all can go away entirely because it's
only read in this condition.

> +        error_report("Expecting filename");
> +        goto out;
> +    }
>  
>      filename = argv[optind];
>      bitmap = argv[optind + 1];
> @@ -5225,6 +5244,24 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
>              op = "remove";
>              break;
> +        case BITMAP_REMOVE_ALL: {
> +            while (1) {
> +                const char *name;
> +                BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs);
> +                if (bm == NULL) {
> +                    break;
> +                }

while ((bm = bdrv_dirty_bitmap_first(bs)))?

> +                name = bdrv_dirty_bitmap_name(bm);
> +                qmp_block_dirty_bitmap_remove(bs->node_name, name, &err);
> +                if (err) {
> +                    /* Save name for proper error reporting */
> +                    bitmap = name;
> +                    break;
> +                }
> +            }
> +            op = "remove-all";
> +            break;
> +        }
>          case BITMAP_CLEAR:
>              qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
>              op = "clear";

Kevin


