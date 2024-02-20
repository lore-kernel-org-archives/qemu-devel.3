Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E368C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcV3h-0007pQ-8M; Tue, 20 Feb 2024 13:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcV3e-0007or-Ct
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:41:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcV3Z-0007DB-2C
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708454488;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VZm5r6pciJhG3kTjI75c0UTB4r/bgx8am/Iv0miNqxg=;
 b=OWULESnrJMB2+UOKjb0mmoG5ZERwl+kJ7UpCbfrPS62QuXMlo+Ni9RGCnkyPa36vvWfj+C
 bj5PN+epqBW6p7BexDfK5UD5s9BG+OuvshTx9hGuf+9W3QMBzH8Sd2M2q+OioCUAmxFvxY
 2c34mW76CgprIvcxCJl6W2fip1qOI+U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-h_hLQ1nOP7GwMpk_UBWl1Q-1; Tue,
 20 Feb 2024 13:41:24 -0500
X-MC-Unique: h_hLQ1nOP7GwMpk_UBWl1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9AF01C07F2D;
 Tue, 20 Feb 2024 18:41:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B32A200B436;
 Tue, 20 Feb 2024 18:41:23 +0000 (UTC)
Date: Tue, 20 Feb 2024 18:41:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 02/23] qemu-img: refresh options/--help for "create"
 subcommand
Message-ID: <ZdTyUVIV0obAL1kG@redhat.com>
References: <cover.1707513011.git.mjt@tls.msk.ru>
 <43c69e56b65b39da7c9bd878fd9c6fad4f788c1a.1707513011.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43c69e56b65b39da7c9bd878fd9c6fad4f788c1a.1707513011.git.mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Feb 10, 2024 at 12:22:23AM +0300, Michael Tokarev wrote:
> Add missing long options (eg --format).
> 
> Create helper function cmd_help() to display command-specific
> help text, and use it to print --help for 'create' subcommand.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 05f80b6e5b..7edfc56572 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -126,6 +126,25 @@ void unrecognized_option(const img_cmd_t *ccmd, const char *option)
>      error_exit(ccmd, "unrecognized option '%s'", option);
>  }
>  
> +/*
> + * Print --help output for a command and exit.
> + * syntax and description are multi-line with trailing EOL
> + * (to allow easy extending of the text)
> + * syntax has each subsequent line starting with \t
> + * desrciption is indented by one char
> + */
> +static G_NORETURN
> +void cmd_help(const img_cmd_t *ccmd,
> +              const char *syntax, const char *arguments)
> +{
> +    printf("qemu-img %s %s"

I think we want an extra "\n" before & after 'Arguments:'

> +           "Arguments:\n"
> +           " -h|--help - print this help and exit\n"
> +           "%s",
> +           ccmd->name, syntax, arguments);
> +    exit(EXIT_SUCCESS);
> +}
> +
>  /* Please keep in synch with docs/tools/qemu-img.rst */
>  static G_NORETURN
>  void help(void)
> @@ -524,7 +543,13 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
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
>          c = getopt_long(argc, argv, ":F:b:f:ho:qu",
> @@ -540,7 +565,25 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
>              unrecognized_option(ccmd, argv[optind - 1]);
>              break;
>          case 'h':
> -            help();
> +            cmd_help(ccmd,
> +"[-f FMT] [-o FMT_OPTS] [-b BACKING_FILENAME [-F BACKING_FMT]]\n"
> +"	[--object OBJDEF] [-u] FILENAME [SIZE[bkKMGTPE]]\n"
> +,
> +" -q|--quiet - quiet operations\n"
> +" -f|--format FMT - specifies format of the new image, default is raw\n"
> +" -o|--options FMT_OPTS - format-specific options ('-o list' for list)\n"
> +" -b|--backing BACKING_FILENAME - stack new image on top of BACKING_FILENAME\n"
> +"  (for formats which support stacking)\n"
> +" -F|--backing-format BACKING_FMT - specify format of BACKING_FILENAME\n"
> +" -u|--backing-unsafe - do not fail if BACKING_FMT can not be read\n"
> +" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
> +" FILENAME - image file to create.  It will be overriden if exists\n"
> +" SIZE - image size with optional suffix: 'b' (byte, default), 'k' or\n"
> +"  'K' (kilobyte, 1024b), 'M' (megabyte, 1024K), 'G' (gigabyte, 1024M),\n"
> +"  'T' (terabyte, 1024G), 'P' (petabyte, 1024T), or 'E' (exabyte, 1024P)\n"
> +"  SIZE is required unless BACKING_IMG is specified, in which case\n"
> +"  it will be the same as size of BACKING_IMG\n"

This comes out as a bit of a wall of dense text.

I think we should have 2 space indent for options, and a further
4 space for continuations, and also put the description on its
own line.

eg so instead of getting:

$ ./build/qemu-img create --help
qemu-img create [-f FMT] [-o FMT_OPTS] [-b BACKING_FILENAME [-F BACKING_FMT]]
        [--object OBJDEF] [-u] FILENAME [SIZE[bkKMGTPE]]
Arguments:
 -h|--help - print this help and exit
 -q|--quiet - quiet operations
 -f|--format FMT - specifies format of the new image, default is raw
 -o|--options FMT_OPTS - format-specific options ('-o list' for list)
 -b|--backing BACKING_FILENAME - stack new image on top of BACKING_FILENAME
  (for formats which support stacking)
 -F|--backing-format BACKING_FMT - specify format of BACKING_FILENAME
 -u|--backing-unsafe - do not fail if BACKING_FMT can not be read
 --object OBJDEF - QEMU user-creatable object (eg encryption key)
 FILENAME - image file to create.  It will be overriden if exists
 SIZE - image size with optional suffix: 'b' (byte, default), 'k' or
  'K' (kilobyte, 1024b), 'M' (megabyte, 1024K), 'G' (gigabyte, 1024M),
  'T' (terabyte, 1024G), 'P' (petabyte, 1024T), or 'E' (exabyte, 1024P)
  SIZE is required unless BACKING_IMG is specified, in which case
  it will be the same as size of BACKING_IMG


we would get:

$ ./build/qemu-img create --help
qemu-img create [-f FMT] [-o FMT_OPTS] [-b BACKING_FILENAME [-F BACKING_FMT]]
        [--object OBJDEF] [-u] FILENAME [SIZE[bkKMGTPE]]

Arguments:

  -h|--help
      print this help and exit

  -q|--quiet
      quiet operations

  -f|--format FMT
      specifies format of the new image, default is raw

  -o|--options FMT_OPTS
      format-specific options ('-o list' for list)

  -b|--backing BACKING_FILENAME
      stack new image on top of BACKING_FILENAME
      (for formats which support stacking)

  -F|--backing-format BACKING_FMT
      specify format of BACKING_FILENAME

  -u|--backing-unsafe
      do not fail if BACKING_FMT can not be read

  --object OBJDEF
      QEMU user-creatable object (eg encryption key)
      
  FILENAME
      image file to create.  It will be overriden if exists

  SIZE
      image size with optional suffix: 'b' (byte, default), 'k' or
      'K' (kilobyte, 1024b), 'M' (megabyte, 1024K), 'G' (gigabyte, 1024M),
      'T' (terabyte, 1024G), 'P' (petabyte, 1024T), or 'E' (exabyte, 1024P)
      SIZE is required unless BACKING_IMG is specified, in which case
      it will be the same as size of BACKING_IMG


> +);
>              break;
>          case 'F':
>              base_fmt = optarg;
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


