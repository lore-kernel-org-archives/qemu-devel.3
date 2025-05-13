Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEEEC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEryG-0000oJ-98; Tue, 13 May 2025 11:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uEryD-0000nT-NQ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uEryB-0000qB-T7
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747151701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mUQFWdF6kFe9d6XArj8QB92Y69q3nyIaETSGA3jRHiY=;
 b=XQ6mkEHmR5x2waPeSQ/fCYyyA5xuQGyRogb94yVgGx0Txb7nlxMdcZJT2dnrWrnSc6zFoi
 HusKBLPa7L9V80YVqSCvX4UxRRK7jhr+zPtnmr/ImpHzrZurhcN92VPE7S02ATCzfduHiL
 Nn4UkGwd6qtepqOwC8m4iKm1OGLYhio=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-L6eFuBIkNkaUBSCKF7W5CA-1; Tue,
 13 May 2025 11:55:00 -0400
X-MC-Unique: L6eFuBIkNkaUBSCKF7W5CA-1
X-Mimecast-MFC-AGG-ID: L6eFuBIkNkaUBSCKF7W5CA_1747151699
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 658511800370; Tue, 13 May 2025 15:54:58 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.238])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0961530001A1; Tue, 13 May 2025 15:54:56 +0000 (UTC)
Date: Tue, 13 May 2025 17:54:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 07/27] qemu-img: check: refresh options/--help
Message-ID: <aCNrThMpezno1o1Z@redhat.com>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
 <20240927061121.573271-8-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927061121.573271-8-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 27.09.2024 um 08:11 hat Michael Tokarev geschrieben:
> Add missing long options and --help output.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 08536553c7..1bd88fcf63 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -805,7 +805,9 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
>          int option_index = 0;
>          static const struct option long_options[] = {
>              {"help", no_argument, 0, 'h'},
> +            {"quiet", no_argument, 0, 'q'},
>              {"format", required_argument, 0, 'f'},
> +            {"cache", required_argument, 0, 'T'},
>              {"repair", required_argument, 0, 'r'},
>              {"output", required_argument, 0, OPTION_OUTPUT},
>              {"object", required_argument, 0, OPTION_OBJECT},
> @@ -813,20 +815,38 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
>              {"force-share", no_argument, 0, 'U'},
>              {0, 0, 0, 0}
>          };
> -        c = getopt_long(argc, argv, ":hf:r:T:qU",
> +        c = getopt_long(argc, argv, "hf:r:T:qU",
>                          long_options, &option_index);
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
> +"[-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]\n"
> +"        [--output human|json] [--object OBJDEF] FILENAME\n"
> +,
> +"  -q, --quiet\n"
> +"     quiet operations\n"

Let's keep the help text more in line with the terminology used in the
man page, even if shorter at times.

I would use the first sentence from it here: "Quiet mode - do not print
any output (except errors)"

> +"  -f, --format FMT\n"
> +"     specifies format of the image explicitly\n"

Maybe "format of the image (default: probing is used)"?

> +"  --image-opts\n"
> +"     indicates that FILENAME is a complete image specification\n"
> +"     instead of a file name (incompatible with --format)\n"

The man page has:

  Indicates that the source *FILENAME* parameter is to be interpreted as a
  full option string, not a plain filename. This parameter is mutually
  exclusive with the *-f* parameter.

A possible adaptation for qemu-img check specially:

  indicates that FILENAME is a full option string, not a plain filename
  (incompatible with --format)

> +"  -T, --cache CACHE_MODE\n"
> +"     image cache mode (" BDRV_DEFAULT_CACHE ")\n"

+"     image cache mode (default: " BDRV_DEFAULT_CACHE ")\n"

> +"  -U, --force-share\n"
> +"     open image in shared mode for concurrent access\n"
> +"  --output human|json\n"
> +"     output format\n"
> +"  -r, --repair leaks|all\n"
> +"     repair particular aspect of the image\n"

"repair errors of the given category in the image"?

> +"     (image will be open in read-write mode, incompatible with --force-share)\n"
> +"  --object OBJDEF\n"
> +"     QEMU user-creatable object (eg encryption key)\n"

"e.g."

> +"  FILENAME\n"
> +"     the image file (or image specification) to operate on\n"

To keep consistency with the above suggestion: "(or option string)"

> +);
>              break;
>          case 'f':
>              fmt = optarg;
> @@ -861,6 +881,8 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
>          case OPTION_IMAGE_OPTS:
>              image_opts = true;
>              break;
> +        default:
> +            tryhelp(argv[0]);
>          }
>      }
>      if (optind != argc - 1) {

Kevin


