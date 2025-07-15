Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB6DC83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfuK-0001Rd-GN; Tue, 15 Jul 2025 09:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubfNz-0001lt-PT
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubfNx-0003gk-Te
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752584872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=im0RikVbuEy4U+8Il2ychPBa/i3sx1CSKG11zfEZvjY=;
 b=LplyuKoAb33gRXn+jrxNanRNq6ojrUnwT5JN9jjc8z9ZGal6u9Zfdo5kBHs7l/CTUQ5WIi
 2TxugXw0b8QLV6kqSb0jw0Vs1PRQAeHXJx2ZaIDR3lpMI4qQBSUCrGsno6yjZQkmBXpsM5
 Na5v0L1IDmyua8sjYNmETzAzJrbv+Sc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-cRYtQ_k7NA-H1B33fPXB6w-1; Tue,
 15 Jul 2025 09:07:49 -0400
X-MC-Unique: cRYtQ_k7NA-H1B33fPXB6w-1
X-Mimecast-MFC-AGG-ID: cRYtQ_k7NA-H1B33fPXB6w_1752584868
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88DAA195608C; Tue, 15 Jul 2025 13:07:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.84])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B74E93000198; Tue, 15 Jul 2025 13:07:45 +0000 (UTC)
Date: Tue, 15 Jul 2025 15:07:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 14/27] qemu-img: map: refresh options/--help
Message-ID: <aHZSnnkEftTBOY4l@redhat.com>
References: <20250531171609.197078-1-mjt@tls.msk.ru>
 <20250531171609.197078-15-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531171609.197078-15-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 31.05.2025 um 19:15 hat Michael Tokarev geschrieben:
> Add missing long options and --help output,
> reorder options for consistency.
> 
> While at it, remove unused option_index variable.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 57 ++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index f0d04a874d..f5820a7017 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3451,41 +3451,51 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
>  
>      fmt = NULL;
>      for (;;) {
> -        int option_index = 0;
>          static const struct option long_options[] = {
>              {"help", no_argument, 0, 'h'},
>              {"format", required_argument, 0, 'f'},
> -            {"output", required_argument, 0, OPTION_OUTPUT},
> -            {"object", required_argument, 0, OPTION_OBJECT},
>              {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> -            {"force-share", no_argument, 0, 'U'},
>              {"start-offset", required_argument, 0, 's'},
>              {"max-length", required_argument, 0, 'l'},
> +            {"force-share", no_argument, 0, 'U'},
> +            {"output", required_argument, 0, OPTION_OUTPUT},
> +            {"object", required_argument, 0, OPTION_OBJECT},
>              {0, 0, 0, 0}
>          };
> -        c = getopt_long(argc, argv, ":f:s:l:hU",
> -                        long_options, &option_index);
> +        c = getopt_long(argc, argv, "hf:s:l:U",
> +                        long_options, NULL);
>          if (c == -1) {
>              break;
>          }
>          switch (c) {
> -        case ':':
> -            missing_argument(argv[optind - 1]);
> -            break;
> -        case '?':
> -            unrecognized_option(argv[optind - 1]);
> -            break;
>          case 'h':
> -            help();
> +            cmd_help(ccmd, "[-f FMT | --image-opts]\n"
> +"        [--start-offset OFFSET] [--max-length LENGTH]\n"
> +"        [--output human|json] [-U] [--object OBJDEF] FILE\n"
> +,
> +"  -f, --format FMT\n"
> +"     specify FILE image format explicitly (default: probing is used)\n"
> +"  --image-opts\n"
> +"     treat FILE as an option string (key=value,..), not a file name\n"
> +"     (incompatible with -f|--format)\n"
> +"  --start-offset OFFSET\n"

-s, --start-offset

> +"  --max-length LENGTH\n"

-l, --max-length

> +"  --output human|json\n"
> +"     specify output format name (default: human)\n"
> +"  -U, --force-share\n"
> +"     open image in shared mode for concurrent access\n"
> +"  --object OBJDEF\n"
> +"     defines QEMU user-creatable object\n"
> +"  FILE\n"
> +"     the image file name, or option string (key=value,..)\n"
> +"     with --image-opts, to operate on\n"
> +);

Kevin


