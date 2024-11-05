Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4992ED36122
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 19:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Pgu-0004Gx-5p; Tue, 05 Nov 2024 14:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8Pgs-0004GC-Qo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 14:58:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8Pgq-0007OT-65
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 14:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730836690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7dNNs+flz+uxOzowrcf4TMLvA9P3NrXcnnPK234DfQ=;
 b=CUI7Lyny1NBZEZyOO/4ADeUfV64js2dpfV2DnAlfkFeup9cV2bYM0TG5by2D/eO1NH/8k3
 Hq6OBVc7IL/Lb8yQQRVBn/nqoRk4XzKnNnDmfYNE4ZvJ6tVPJ6ajMvlJd9upCnNQW9pN2G
 pBiNo2ygL7runX3lEK3dGUOBXYOZOJA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-DXZ_Mgv8PEWkwHC9RbYMuQ-1; Tue,
 05 Nov 2024 14:58:01 -0500
X-MC-Unique: DXZ_Mgv8PEWkwHC9RbYMuQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C9C8195609D; Tue,  5 Nov 2024 19:58:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.127])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35A2A1955F40; Tue,  5 Nov 2024 19:57:58 +0000 (UTC)
Date: Tue, 5 Nov 2024 20:57:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 05/27] qemu-img: create: refresh options/--help
Message-ID: <Zyp4xJcwf-gwOacy@redhat.com>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
 <20240927061121.573271-6-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927061121.573271-6-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 27.09.2024 um 08:10 hat Michael Tokarev geschrieben:
> Create helper function cmd_help() to display command-specific
> help text, and use it to print --help for 'create' subcommand.
> 
> Add missing long options (eg --format) in img_create().
> 
> Remove usage of missing_argument()/unrecognized_option() in
> img_create().
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index e8234104e5..7ed5e6d1a8 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -132,6 +132,32 @@ void unrecognized_option(const char *option)
>      error_exit("qemu-img", "unrecognized option '%s'", option);
>  }
>  
> +/*
> + * Print --help output for a command and exit.
> + * syntax and description are multi-line with trailing EOL
> + * (to allow easy extending of the text)
> + * syntax has each subsequent line indented by 8 chars.
> + * desrciption is indented by 2 chars for argument on each own line,

s/desrciption/description/

I would also suggest writing @syntax and @description as we do in other
places to indicate that we're talking about parameter names here rather
than normal English words.

> + * and with 5 chars for argument description (like -h arg below).
> + */
> +static G_NORETURN
> +void cmd_help(const img_cmd_t *ccmd,
> +              const char *syntax, const char *arguments)
> +{
> +    printf(
> +"Usage:\n"
> +"\n"
> +"  %s %s %s"
> +"\n"
> +"Arguments:\n"
> +"  -h, --help\n"
> +"     print this help and exit\n"
> +"%s\n",
> +           "qemu-img", ccmd->name,
> +           syntax, arguments);

The last two lines should easily fit on a single one.

> +    exit(EXIT_SUCCESS);
> +}
> +
>  /* Please keep in synch with docs/tools/qemu-img.rst */
>  static G_NORETURN
>  void help(void)
> @@ -530,23 +556,48 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
>      for(;;) {
>          static const struct option long_options[] = {
>              {"help", no_argument, 0, 'h'},
> +            {"quiet", no_argument, 0, 'q'},
>              {"object", required_argument, 0, OPTION_OBJECT},
> +            {"format", required_argument, 0, 'f'},
> +            {"backing", required_argument, 0, 'b'},
> +            {"backing-format", required_argument, 0, 'F'},
> +            {"backing-unsafe", no_argument, 0, 'u'},
> +            {"options", required_argument, 0, 'o'},
>              {0, 0, 0, 0}
>          };
> -        c = getopt_long(argc, argv, ":F:b:f:ho:qu",
> +        c = getopt_long(argc, argv, "F:b:f:ho:qu",
>                          long_options, NULL);

Can we please keep the same order in long_options and in the options
string?

>          if (c == -1) {
>              break;
>          }
>          switch(c) {
> -        case ':':
> -            missing_argument(argv[optind - 1]);
> -            break;
> -        case '?':
> -            unrecognized_option(argv[optind - 1]);
> -            break;
>          case 'h':
> -            help();
> +            cmd_help(ccmd,

Is this new help text copied from somewhere or is it written from
scratch? I couldn't find the source if it was copied, so I'll treat it
as new and compare it only with the generic help text and the man page.

> +"[-f FMT] [-o FMT_OPTS] [-b BACKING_FILENAME [-F BACKING_FMT]]\n"
> +"        [--object OBJDEF] [-u] FILENAME [SIZE[bkKMGTPE]]\n"

This is yet another order. It also seems to miss -q.

The existing documentation has this:

create [--object OBJECTDEF] [-q] [-f FMT] [-b BACKING_FILE [-F BACKING_FMT]] [-u] [-o OPTIONS] FILENAME [SIZE]

Which is a fourth different order and description. It would probably be
good to consolidate on a single option and way to name parameter
placeholders.

> +,
> +"  -q, --quiet\n"
> +"     quiet operations\n"
> +"  -f, --format FMT\n"
> +"     specifies format of the new image, default is raw\n"

s/format/the format/

I would suggest "(default: raw)" as the format to use for defaults. It's
a bit easier to read when it's clearly not part of the sentence.

> +"  -o, --options FMT_OPTS\n"
> +"     format-specific options ('-o list' for list)\n"

Do you mean '-o help'?

> +"  -b, --backing BACKING_FILENAME\n"
> +"     stack new image on top of BACKING_FILENAME\n"
> +"     (for formats which support stacking)\n"

"stacking" isn't terminology we use elsewhere. Maybe "create image as a
copy-on-write overlay on top of BACKING_FILENAME (not supported by all
formats)"?

Not sure if it's worth having the parenthesis at all, many options of
qemu-img will only work with some formats.

> +"  -F, --backing-format BACKING_FMT\n"
> +"     specify format of BACKING_FILENAME\n"

-f said "specifies" (which sounds a bit better to me), let's stay
consistent. Same s/format/the format/, too.

> +"  -u, --backing-unsafe\n"
> +"     do not fail if BACKING_FMT can not be read\n"

BACKING_FILENAME?

Maybe "don't try to open BACKING_FILENAME for verification"?

> +"  --object OBJDEF\n"
> +"     QEMU user-creatable object (eg encryption key)\n"

s/eg/e.g./

Most other options start with a verb. Maybe "define a user-creatable
object"?

> +"  FILENAME\n"
> +"     image file to create.  It will be overridden if exists\n"

overwritten?

If you have one full stop in it, I think we should have one at the end,
too: "...if it exists.\n"

> +"  SIZE\n"
> +"     image size with optional suffix (multiplies in 1024)\n"

Powers of 1024?

The existing help is a bit more explicit about the supported suffixes:

"  'size' is the disk image size in bytes. Optional suffixes\n"
"    'k' or 'K' (kilobyte, 1024), 'M' (megabyte, 1024k), 'G' (gigabyte, 1024M),\n"
"    'T' (terabyte, 1024G), 'P' (petabyte, 1024T) and 'E' (exabyte, 1024P)  are\n"
"    supported. 'b' is ignored.\n"


> +"     SIZE is required unless BACKING_IMG is specified,\n"
> +"     in which case it will be the same as size of BACKING_IMG\n"

"it will default to the same size as BACKING_IMG"?

> +);
>              break;
>          case 'F':
>              base_fmt = optarg;
> @@ -571,6 +622,8 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
>          case OPTION_OBJECT:
>              user_creatable_process_cmdline(optarg);
>              break;
> +        default:
> +            tryhelp(argv[0]);
>          }
>      }

Kevin


