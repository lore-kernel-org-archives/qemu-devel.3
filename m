Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE2CC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfsq-0007a8-ES; Tue, 15 Jul 2025 09:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubfLe-0007cn-B6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubfLX-00039P-10
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752584717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PcKhgaeB9672f8wxmLlktnqyK/hhl145xDhHJi/S/4g=;
 b=LHwGsXm8OSeLu8kzJJKuwykNc1LtaztSv8xXy83cC8jPYkAnI8rjo/u0gEwdtz5BzKF6rv
 5gqubmM9IIajS5ixsutnqM6HHgEugdugoH9/c+sQzijxnf2vVuCEi+aHzpjFS1tw2ZtLbT
 OhpCj6Z7GYoyktHUhDOPAMHukhgMbFI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-myLVS3BEO1K8aPKzdxi1fw-1; Tue,
 15 Jul 2025 09:04:50 -0400
X-MC-Unique: myLVS3BEO1K8aPKzdxi1fw-1
X-Mimecast-MFC-AGG-ID: myLVS3BEO1K8aPKzdxi1fw_1752584684
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 878F2195609F; Tue, 15 Jul 2025 13:04:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.84])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA65518046C7; Tue, 15 Jul 2025 13:04:39 +0000 (UTC)
Date: Tue, 15 Jul 2025 15:04:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 13/27] qemu-img: info: refresh options/--help
Message-ID: <aHZR5AdddU3oodjj@redhat.com>
References: <20250531171609.197078-1-mjt@tls.msk.ru>
 <20250531171609.197078-14-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531171609.197078-14-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Add missing long options and --help output.
> Also add -b short option for --backing-chain, and remove
> now-unused OPTION_BACKING_CHAIN.

I think I wouldn't do this part, -b specifies a backing file name
elsewhere, so this feels a little inconsistent. Adding long options
everywhere is obvious, but overloading short options with more meanings
in different subcommands could be confusing.

> Reorder options for consistency.
> 
> While at it, remove unused option_index variable.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 54 ++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 5858304a62..f0d04a874d 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -65,7 +65,6 @@ typedef struct img_cmd_t {
>  
>  enum {
>      OPTION_OUTPUT = 256,
> -    OPTION_BACKING_CHAIN = 257,
>      OPTION_OBJECT = 258,
>      OPTION_IMAGE_OPTS = 259,
>      OPTION_PATTERN = 260,
> @@ -3217,50 +3216,65 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
>  
>      fmt = NULL;
>      for(;;) {
> -        int option_index = 0;
>          static const struct option long_options[] = {
>              {"help", no_argument, 0, 'h'},
>              {"format", required_argument, 0, 'f'},
> -            {"output", required_argument, 0, OPTION_OUTPUT},
> -            {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
> -            {"object", required_argument, 0, OPTION_OBJECT},
>              {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +            {"backing-chain", no_argument, 0, 'b'},
>              {"force-share", no_argument, 0, 'U'},
> +            {"output", required_argument, 0, OPTION_OUTPUT},
> +            {"object", required_argument, 0, OPTION_OBJECT},
>              {0, 0, 0, 0}
>          };
> -        c = getopt_long(argc, argv, ":f:hU",
> -                        long_options, &option_index);
> +        c = getopt_long(argc, argv, "hf:bU",
> +                        long_options, NULL);
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
> +            cmd_help(ccmd, "[-f FMT | --image-opts] [-b] [-U]"
> +"        [--output human|json] [--object OBJDEF] FILE\n"
> +,
> +"  -f, --format FMT\n"
> +"     specify FILE image format explicitly (default: probing is used)\n"
> +"  --image-opts\n"
> +"     treat FILE as an option string (key=value,..), not a file name\n"
> +"     (incompatible with -f|--format)\n"
> +"  -b, --backing-chain\n"
> +"     display information about backing chaing\n"
> +"     in case the image is stacked\n"

s/chaing/chain/

Also no need for the \n in the middle, the whole message fits in 80
characters.

Kevin


