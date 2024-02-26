Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4909DC54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rec3o-0001Ft-B7; Mon, 26 Feb 2024 09:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rec3l-0001EO-Oj
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:34:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rec3g-0006LB-T6
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708958060;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MwJ0+BYWkc2eh7iDVk+5cu5cv6XU5bQ9na6gXAM21F4=;
 b=Or0cqZT0ZAoOx2OglkcJbGLrlsYdNKZXeWKsYm7Dw6UReU3N6PCGlQcsPXoCw3HaEtAGxj
 ou2BgpLzrzAIDIBiPNrAAlxI03AmadqSVMWZAZbirnk89QdYK/0p0ylRGqoM0P7PZmnIge
 CuDygpr9eQngrvjul/KODubGvU6gu6M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-SuQ7yQjIM6OvETUHfi7w8g-1; Mon, 26 Feb 2024 09:34:16 -0500
X-MC-Unique: SuQ7yQjIM6OvETUHfi7w8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7522E1064C6C;
 Mon, 26 Feb 2024 14:34:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE8488CE8;
 Mon, 26 Feb 2024 14:34:14 +0000 (UTC)
Date: Mon, 26 Feb 2024 14:34:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 06/28] qemu-img: create: refresh options/--help
Message-ID: <ZdyhZAve4WtPnmkc@redhat.com>
References: <cover.1708544927.git.mjt@tls.msk.ru>
 <20240221211622.2335170-6-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221211622.2335170-6-mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 22, 2024 at 12:15:47AM +0300, Michael Tokarev wrote:
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
>  qemu-img.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 38ac0f1845..7e4c993b9c 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -132,6 +132,31 @@ void unrecognized_option(const char *option)
>      error_exit("qemu-img", "unrecognized option '%s'", option);
>  }
>  
> +/*
> + * Print --help output for a command and exit.
> + * syntax and description are multi-line with trailing EOL
> + * (to allow easy extending of the text)
> + * syntax has each subsequent line indented by 8 chars.
> + * desrciption is indented by 2 chars for argument on each own line,
> + * and with 5 chars for argument description (like -h arg below).
> + */
> +static G_NORETURN
> +void cmd_help(const img_cmd_t *ccmd,
> +              const char *syntax, const char *arguments)
> +{
> +    printf(
> +"Usage:\n"
> +"  %s %s %s"

For the global help there's an extra '\n' after 'Usage'. It would be
good go be consistent in this between global and per-command help.

$ ./build/qemu-img --help
qemu-img version 8.2.50 (v8.2.0-1677-g81b20f4b55)
Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
QEMU disk image utility.  Usage:

  qemu-img [standard options] COMMAND [--help | command options]
...snip...

vs

$ ./build/qemu-img info --help
Display information about image.  Usage:
  qemu-img info [-f FMT | --image-opts] [-b] [-U] [--object OBJDEF]
        [--output human|json] FILENAME
...snip...


I wonder if we should repeat '[standard options]' for the
per-command help too ?


> +"\n"
> +"Arguments:\n"

In the global help you called it 'Standard options', so for
consistency lets use 'Options:' here too.

> +"  -h, --help\n"
> +"     print this help and exit\n"
> +"%s\n",
> +           "qemu-img", ccmd->name,
> +           syntax, arguments);
> +    exit(EXIT_SUCCESS);
> +}
> +
>  /* Please keep in synch with docs/tools/qemu-img.rst */
>  static G_NORETURN
>  void help(void)
> @@ -530,23 +555,48 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
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
> +"[-f FMT] [-o FMT_OPTS] [-b BACKING_FILENAME [-F BACKING_FMT]]\n"
> +"        [--object OBJDEF] [-u] FILENAME [SIZE[bkKMGTPE]]\n"
> +,
> +"  -q, --quiet\n"
> +"     quiet operations\n"
> +"  -f, --format FMT\n"
> +"     specifies format of the new image, default is raw\n"
> +"  -o, --options FMT_OPTS\n"
> +"     format-specific options ('-o list' for list)\n"
> +"  -b, --backing BACKING_FILENAME\n"
> +"     stack new image on top of BACKING_FILENAME\n"
> +"     (for formats which support stacking)\n"
> +"  -F, --backing-format BACKING_FMT\n"
> +"     specify format of BACKING_FILENAME\n"
> +"  -u, --backing-unsafe\n"
> +"     do not fail if BACKING_FMT can not be read\n"
> +"  --object OBJDEF\n"
> +"     QEMU user-creatable object (eg encryption key)\n"
> +"  FILENAME\n"
> +"     image file to create.  It will be overridden if exists\n"
> +"  SIZE\n"
> +"     image size with optional suffix (multiplies in 1024)\n"
> +"     SIZE is required unless BACKING_IMG is specified,\n"
> +"     in which case it will be the same as size of BACKING_IMG\n"
> +);
>              break;
>          case 'F':
>              base_fmt = optarg;
> @@ -571,6 +621,8 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
>          case OPTION_OBJECT:
>              user_creatable_process_cmdline(optarg);
>              break;
> +        default:
> +            tryhelp(argv[0]);
>          }
>      }
>  
> -- 
> 2.39.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


