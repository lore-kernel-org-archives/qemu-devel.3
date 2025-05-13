Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF1FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 16:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEsRE-00008i-2h; Tue, 13 May 2025 12:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uEsRC-00006A-6N
 for qemu-devel@nongnu.org; Tue, 13 May 2025 12:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uEsRA-00045p-8N
 for qemu-devel@nongnu.org; Tue, 13 May 2025 12:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747153499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YebBsok5i+A924ivNfjiiyuvUq277Jm5+DXg2Fx5WjQ=;
 b=UTFzIvjLwfvqvONWLPHFEqgYUqQpFvv2vgGHxlNGHSDfNaUfoktBEiW5RwK2zYLzT8/B+i
 MuqBBCmgfY3av9N1kg+c9X05DpfPNOd9LhomLmslRoksgDBKTklOm5YB9CnZWvyl2wLtys
 l75mUp/rikLFZkGb3BbgRw7hRKUYSNM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-6QPpNNF3MzaBkogtzPazYg-1; Tue,
 13 May 2025 12:24:55 -0400
X-MC-Unique: 6QPpNNF3MzaBkogtzPazYg-1
X-Mimecast-MFC-AGG-ID: 6QPpNNF3MzaBkogtzPazYg_1747153494
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CF3418004AD; Tue, 13 May 2025 16:24:54 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.238])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2978418003FC; Tue, 13 May 2025 16:24:52 +0000 (UTC)
Date: Tue, 13 May 2025 18:24:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 09/27] qemu-img: commit: refresh options/--help
Message-ID: <aCNyUhzVfX6sQF0P@redhat.com>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
 <20240927061121.573271-10-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927061121.573271-10-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>  qemu-img.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 9157a6b45d..7a111bce72 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1048,24 +1048,50 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
>      for(;;) {
>          static const struct option long_options[] = {
>              {"help", no_argument, 0, 'h'},
> +            {"quiet", no_argument, 0, 'q'},
>              {"object", required_argument, 0, OPTION_OBJECT},
> +            {"format", required_argument, 0, 'f'},
>              {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +            {"cache", required_argument, 0, 't'},
> +            {"drop", no_argument, 0, 'd'},
> +            {"base", required_argument, 0, 'b'},
> +            {"progress", no_argument, 0, 'p'},
> +            {"rate", required_argument, 0, 'r'},

"rate-limit"?

>              {0, 0, 0, 0}
>          };
> -        c = getopt_long(argc, argv, ":f:ht:b:dpqr:",
> +        c = getopt_long(argc, argv, "f:ht:b:dpqr:",
>                          long_options, NULL);

Should we try to keep the order in long_options and in the getopt string
consistent? There doesn't seem to be any system behind the order we have
currently. Maybe keep common options (--help, --quiet) first, but then
order things alphabetically?

It doesn't really matter that much here, it would just improve
legibility of the code a bit. But I think in the help text, we should
definitely have a more obvious order so that users can find their option
without having to read everything.

Of course, this is a comment that applies not only to this patch, but to
all subcommands.

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
> +"[-f FMT | --image-opts] [-t CACHE_MODE] [-b BASE_IMG] [-d]\n"
> +"        [-r RATE] [--object OBJDEF] FILENAME\n"
> +,
> +"  -q, --quiet\n"
> +"     quiet operations\n"

Same as in the previous patch. After this one, I won't point out things
any more if I already commented on the same thing earlier in the series.
They should apply to all similar instances.

> +"  -p, --progress\n"
> +"     show operation progress\n"

The man page has "display progress bar" (even though it's not a bar).
Maybe make it "display progress information" in both places?

> +"  -f, --format FMT\n"
> +"     specify FILENAME image format explicitly\n"
> +"  --image-opts\n"
> +"     indicates that FILENAME is a complete image specification\n"
> +"     instead of a file name (incompatible with --format)\n"
> +"  -t, --cache CACHE_MODE image cache mode (" BDRV_DEFAULT_CACHE ")\n"
> +"  -d, --drop\n"
> +"     skip emptying FILENAME on completion\n"
> +"  -b, --base BASE_IMG\n"
> +"     image in the backing chain to which to commit changes\n"
> +"     instead of the previous one (implies --drop)\n"

"image in the backing chain to commit change to (default: immediate
backing file; implies --drop)"?

> +"  -r, --rate RATE\n"
> +"     I/O rate limit\n"

in bytes per second

> +"  --object OBJDEF\n"
> +"     QEMU user-creatable object (eg encryption key)\n"
> +"  FILENAME\n"
> +"     name of the image file to operate on\n"
> +);
>              break;
>          case 'f':
>              fmt = optarg;
> @@ -1099,6 +1125,8 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
>          case OPTION_IMAGE_OPTS:
>              image_opts = true;
>              break;
> +        default:
> +            tryhelp(argv[0]);
>          }
>      }

Kevin


