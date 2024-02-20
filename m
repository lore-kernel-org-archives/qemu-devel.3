Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFFDC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcV8t-0003sZ-Ao; Tue, 20 Feb 2024 13:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcV8Y-0003nU-8L
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:46:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcV8V-0007tf-W9
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708454795;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SFETm/m/y7pjDum5Cc4/Q1+5CdJyR6Zrf3UqNMIkQcQ=;
 b=WdQRy20Yab44a2swzJ3JdYKpGYgf7N/+/C7CsZyICpkEMQAjVJymJtaauPqeyroQ65Oagz
 DFGikbpuDAUafEbiPQMWR7CT1eJTMb42QHbt+wbMjB0HuCUVwMo3MmWcfOkGWDB9e9Jf8U
 khAvPQbil2SINgtQ76k08THGzcnKKkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-bbSbDIB0OLur2IDDvqaSZA-1; Tue, 20 Feb 2024 13:46:29 -0500
X-MC-Unique: bbSbDIB0OLur2IDDvqaSZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50356185A784;
 Tue, 20 Feb 2024 18:46:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ABF01C060AF;
 Tue, 20 Feb 2024 18:46:28 +0000 (UTC)
Date: Tue, 20 Feb 2024 18:46:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 22/23] qemu-img: implement short --help, remove global
 help() function
Message-ID: <ZdTzgmCVXu5N1R5r@redhat.com>
References: <cover.1707513011.git.mjt@tls.msk.ru>
 <e791b4d2a91baddca79811b7ceb71e7223796b4f.1707513012.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e791b4d2a91baddca79811b7ceb71e7223796b4f.1707513012.git.mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, Feb 10, 2024 at 12:22:43AM +0300, Michael Tokarev wrote:
> now once all individual subcommands has --help support, remove
> the large unreadable help() thing and replace it with small
> global --help, which refers to individual command --help for
> more info.
> 
> While at it, also line-wrap list of formats after 74 chars.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 148 +++++++++++------------------------------------------
>  1 file changed, 30 insertions(+), 118 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index e2c8855ff5..d9c5c6078b 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -94,11 +94,6 @@ typedef enum OutputFormat {
>  /* Default to cache=writeback as data integrity is not important for qemu-img */
>  #define BDRV_DEFAULT_CACHE "writeback"
>  
> -static void format_print(void *opaque, const char *name)
> -{
> -    printf(" %s", name);
> -}
> -
>  static G_NORETURN G_GNUC_PRINTF(2, 3)
>  void error_exit(const img_cmd_t *ccmd, const char *fmt, ...)
>  {
> @@ -154,114 +149,6 @@ static OutputFormat parse_output_format(const img_cmd_t *ccmd, const char *arg)
>      }
>  }
>  
> -/* Please keep in synch with docs/tools/qemu-img.rst */
> -static G_NORETURN
> -void help(void)
> -{
> -    const char *help_msg =
> -           QEMU_IMG_VERSION
> -           "usage: qemu-img [standard options] command [command options]\n"
> -           "QEMU disk image utility\n"
> -           "\n"
> -           "    '-h', '--help'       display this help and exit\n"
> -           "    '-V', '--version'    output version information and exit\n"
> -           "    '-T', '--trace'      [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
> -           "                         specify tracing options\n"
> -           "\n"
> -           "Command syntax:\n"
> -#define DEF(option, callback, arg_string)        \
> -           "  " arg_string "\n"
> -#include "qemu-img-cmds.h"
> -#undef DEF
> -           "\n"
> -           "Command parameters:\n"
> -           "  'filename' is a disk image filename\n"
> -           "  'objectdef' is a QEMU user creatable object definition. See the qemu(1)\n"
> -           "    manual page for a description of the object properties. The most common\n"
> -           "    object type is a 'secret', which is used to supply passwords and/or\n"
> -           "    encryption keys.\n"
> -           "  'fmt' is the disk image format. It is guessed automatically in most cases\n"
> -           "  'cache' is the cache mode used to write the output disk image, the valid\n"
> -           "    options are: 'none', 'writeback' (default, except for convert), 'writethrough',\n"
> -           "    'directsync' and 'unsafe' (default for convert)\n"
> -           "  'src_cache' is the cache mode used to read input disk images, the valid\n"
> -           "    options are the same as for the 'cache' option\n"
> -           "  'size' is the disk image size in bytes. Optional suffixes\n"
> -           "    'k' or 'K' (kilobyte, 1024), 'M' (megabyte, 1024k), 'G' (gigabyte, 1024M),\n"
> -           "    'T' (terabyte, 1024G), 'P' (petabyte, 1024T) and 'E' (exabyte, 1024P)  are\n"
> -           "    supported. 'b' is ignored.\n"
> -           "  'output_filename' is the destination disk image filename\n"
> -           "  'output_fmt' is the destination format\n"
> -           "  'options' is a comma separated list of format specific options in a\n"
> -           "    name=value format. Use -o help for an overview of the options supported by\n"
> -           "    the used format\n"
> -           "  'snapshot_param' is param used for internal snapshot, format\n"
> -           "    is 'snapshot.id=[ID],snapshot.name=[NAME]', or\n"
> -           "    '[ID_OR_NAME]'\n"
> -           "  '-c' indicates that target image must be compressed (qcow format only)\n"
> -           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and\n"
> -           "       new backing file match exactly. The image doesn't need a working\n"
> -           "       backing file before rebasing in this case (useful for renaming the\n"
> -           "       backing file). For image creation, allow creating without attempting\n"
> -           "       to open the backing file.\n"
> -           "  '-h' with or without a command shows this help and lists the supported formats\n"
> -           "  '-p' show progress of command (only certain commands)\n"
> -           "  '-q' use Quiet mode - do not print any output (except errors)\n"
> -           "  '-S' indicates the consecutive number of bytes (defaults to 4k) that must\n"
> -           "       contain only zeros for qemu-img to create a sparse image during\n"
> -           "       conversion. If the number of bytes is 0, the source will not be scanned for\n"
> -           "       unallocated or zero sectors, and the destination image will always be\n"
> -           "       fully allocated\n"
> -           "  '--output' takes the format in which the output must be done (human or json)\n"
> -           "  '-n' skips the target volume creation (useful if the volume is created\n"
> -           "       prior to running qemu-img)\n"
> -           "\n"
> -           "Parameters to bitmap subcommand:\n"
> -           "  'bitmap' is the name of the bitmap to manipulate, through one or more\n"
> -           "       actions from '--add', '--remove', '--clear', '--enable', '--disable',\n"
> -           "       or '--merge source'\n"
> -           "  '-g granularity' sets the granularity for '--add' actions\n"
> -           "  '-b source' and '-F src_fmt' tell '--merge' actions to find the source\n"
> -           "       bitmaps from an alternative file\n"
> -           "\n"
> -           "Parameters to check subcommand:\n"
> -           "  '-r' tries to repair any inconsistencies that are found during the check.\n"
> -           "       '-r leaks' repairs only cluster leaks, whereas '-r all' fixes all\n"
> -           "       kinds of errors, with a higher risk of choosing the wrong fix or\n"
> -           "       hiding corruption that has already occurred.\n"
> -           "\n"
> -           "Parameters to convert subcommand:\n"
> -           "  '--bitmaps' copies all top-level persistent bitmaps to destination\n"
> -           "  '-m' specifies how many coroutines work in parallel during the convert\n"
> -           "       process (defaults to 8)\n"
> -           "  '-W' allow to write to the target out of order rather than sequential\n"
> -           "\n"
> -           "Parameters to snapshot subcommand:\n"
> -           "  'snapshot' is the name of the snapshot to create, apply or delete\n"
> -           "  '-a' applies a snapshot (revert disk to saved state)\n"
> -           "  '-c' creates a snapshot\n"
> -           "  '-d' deletes a snapshot\n"
> -           "  '-l' lists all snapshots in the given image\n"
> -           "\n"
> -           "Parameters to compare subcommand:\n"
> -           "  '-f' first image format\n"
> -           "  '-F' second image format\n"
> -           "  '-s' run in Strict mode - fail on different image size or sector allocation\n"
> -           "\n"
> -           "Parameters to dd subcommand:\n"
> -           "  'bs=BYTES' read and write up to BYTES bytes at a time "
> -           "(default: 512)\n"
> -           "  'count=N' copy only N input blocks\n"
> -           "  'if=FILE' read from FILE\n"
> -           "  'of=FILE' write to FILE\n"
> -           "  'skip=N' skip N bs-sized blocks at the start of input\n";
> -
> -    printf("%s\nSupported formats:", help_msg);
> -    bdrv_iterate_format(format_print, NULL, false);
> -    printf("\n\n" QEMU_HELP_BOTTOM "\n");
> -    exit(EXIT_SUCCESS);
> -}
> -
>  /*
>   * Is @list safe for accumulate_options()?
>   * It is when multiple of them can be joined together separated by ','.
> @@ -5866,6 +5753,16 @@ static const img_cmd_t img_cmds[] = {
>      { NULL, NULL, },
>  };
>  
> +static void format_print(void *opaque, const char *name)
> +{
> +    int *np = opaque;
> +    *np += printf(" %s", name);
> +    if (*np > 74) {
> +        printf("\n ");
> +        *np = 1;
> +    }
> +}
> +
>  int main(int argc, char **argv)
>  {
>      const img_cmd_t *cmd;
> @@ -5893,10 +5790,6 @@ int main(int argc, char **argv)
>  
>      module_call_init(MODULE_INIT_QOM);
>      bdrv_init();
> -    if (argc < 2) {
> -        error_exit(NULL, "Not enough arguments");
> -    }
> -
>      qemu_add_opts(&qemu_source_opts);
>      qemu_add_opts(&qemu_trace_opts);
>  
> @@ -5909,7 +5802,22 @@ int main(int argc, char **argv)
>              unrecognized_option(NULL, argv[optind - 1]);
>              return 0;
>          case 'h':
> -            help();
> +            printf(
> +QEMU_IMG_VERSION
> +"QEMU disk image utility\n"

Add '\n'

> +"usage: qemu-img [standard options] command [--help | command options]\n"

Add '\n'

> +"Standard options:\n"

Add '\n'

> +" -h|--help - display this help and exit\n"
> +" -V|--version - display version info and exit\n"
> +" -T|--trace TRACE - specify tracing options:\n"
> +"   [[enable=]<pattern>][,events=<file>][,file=<file>]\n"

Similar to sub-command help, I tink it reads better as

 "  -h|--help\n"
 "      display this help and exit\n"
 "\n"
 "  -V|--version\n"
 "      display version info and exit\n"
 "\n"
 "  -T|--trace TRACE\n"
 "      specify tracing options:\n"
 "      [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
 "\n"



> +"Recognized commands (run qemu-img command --help for command-specific help):\n");
> +            for (cmd = img_cmds; cmd->name != NULL; cmd++) {
> +                printf("  %s\n", cmd->name);
> +            }

An extra "\n"

> +            c = printf("Supported image formats:");

Add a trailing "\n"

> +            bdrv_iterate_format(format_print, &c, false);
> +            printf("\n" QEMU_HELP_BOTTOM "\n");
>              return 0;
>          case 'V':
>              printf(QEMU_IMG_VERSION);
> @@ -5920,6 +5828,10 @@ int main(int argc, char **argv)
>          }
>      }
>  
> +    if (argc < 2) {
> +        error_exit(NULL, "Not enough arguments");
> +    }
> +
>      cmdname = argv[optind];
>  
>      /* reset getopt_long scanning */

Basically as an end result we get



qemu-img version 8.2.50 (v8.2.0-1219-g51870ffcbb)
Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
QEMU disk image utility

usage: qemu-img [standard options] command [--help | command options]

Standard options:

  -h|--help
      display this help and exit
  -V|--version
      display version info and exit
  -T|--trace TRACE
      specify tracing options:
      [[enable=]<pattern>][,events=<file>][,file=<file>]

Recognized commands (run qemu-img command --help for command-specific help):

  amend - Update format-specific options of the image
  bench - Run simple image benchmark
  bitmap - Perform modifications of the persistent bitmap in the image
  check - Check basic image integrity
  commit - Commit image to its backing file
  compare - Check if two images have the same contents
  convert - Copy one image to another with optional format conversion
  create - Create and format new image file
  dd - Copy input to output with optional format conversion
  info - Display information about image
  map - Dump image metadata
  measure - Calculate file size requred for a new image
  rebase - Change backing file of the image
  resize - Resize the image to the new size
  snapshot - List or manipulate snapshots within image

Supported image formats:
  blkdebug blklogwrites blkverify bochs cloop compress copy-before-write
  copy-on-read dmg file ftp ftps gluster host_cdrom host_device http
  https io_uring iscsi iser luks nbd nfs null-aio null-co nvme nvme-io_uring
  parallels preallocate qcow qcow2 qed quorum raw rbd replication snapshot-access
  ssh throttle vdi vhdx virtio-blk-vfio-pci virtio-blk-vhost-user virtio-blk-vhost-vdpa
  vmdk vpc vvfat

See <https://qemu.org/contribute/report-a-bug> for how to report bugs.
More information on the QEMU project at <https://qemu.org>.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


