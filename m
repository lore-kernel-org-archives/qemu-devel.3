Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B7606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FkrBMILm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN7VK-0006CQ-07; Sat, 31 Oct 2026 07:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xN7VG-0006Bz-QE
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 07:44:06 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xN7VE-0000Oc-Oe
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 07:44:06 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so2320394a12.2
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793447039; x=1794051839; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0E3AP4FnKFTAB7lKN5Mz9MpzlRhe5FHFHa2eJr9HoiQ=;
 b=FkrBMILmk/b8wviZ4JG/EQ5otX/QakTN5Qlfsr54oSBq3doq2VQxtG0WurRfI5OVVC
 l6KUJ6/mYy5u6Bbnniy6XN6UDp7bNdFr3hcZuGAHPqDmU5QAHdWpA59FxpAvJlBlwwHl
 pw+bb5elhPMLSkjjHByNcZJbcROXdDO0oCIst0mIQ54JgKcFwyTnOBiv1Hw74wC3o7Xq
 y2bTYweTUTsKSNbwRwho730w1HfKwp8gGQhdNAO3wnaCBVah2t8MILYAfh3e26h6/85h
 FgxivIqwJFBYtCBXANtU9zSI9BvlxAOuU3KEJx+nb+4aS83DgQIimPubmMCbJMTYS+DM
 OMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793447039; x=1794051839;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0E3AP4FnKFTAB7lKN5Mz9MpzlRhe5FHFHa2eJr9HoiQ=;
 b=2MBLeBaF80QIeIVYSZpcqrOL8yGt8zbALk0R3RkIAdS55HlnKaxiPOBkyYtzYOQ77L
 0A4C0LRPEPH61vwzoV51BPrMqOP/hdKwvgUNPQJXdBYjCtkPdynry9O8Uqu//qUggvEs
 KymnAI8CUOiDfEvBXVFDboC6qzQ64N0qgG5vmV1pUjveaKZAwCNqQqS5f3xIzTRB7ELl
 SCPR/f1wvSbQ9QeX4mxD2MQZMv4Bq6gpYeERQxvVHU8BAqHZ69ufFUyVu0Xwnv1ZsGM4
 ndt/H2J6H5RE1GJghlgUBtXHTsPZo7oweRSGRmi+6tJKVewXngTWB2gxz84Bheg9xTPG
 5XHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaLrJSi+pVKDyO3OXCoefVrJhjU5Lsmz2CBeza/0Me9AFF1j5IgxzITXKJ72/wa0aogHklaGnZyCJ1@nongnu.org
X-Gm-Message-State: AFq9FYJZ1iVDkIAiZEUpHfcGdC+FH+PjZZk3IxbOT3XFuT0GpBcIetBM
 24ek/NDMiRUSxutou8YUq4Kqnd2xsNJXsby9aQDvFgiyhmTajHZorxJq
X-Gm-Gg: AYBFou2FX9Kn+xhbZ0Djku1Se5moSOSG2QMJ8+r5neL1OXucfQnGxpznHD6epZTzSEv
 YtvVzNu4v4eLFjCoQ407wkq40QEiV2u5c+Ig8GQjNeltA/2/Egg56PFHu7sBGz4laHeoZdT5Nhx
 0/ZjFG+hu7oWZwZFz2l7q1dWVem8+Qqa+z0S9dhhqUBdUAgfUrSAt5Vxsj47sxh0Oe6EqpwBwso
 4Jbid6HU3grnH2JGQKdHrtMS6D6B86d4ZFA7stXCC4dAuxmykyJPlV6Txxn6/T0pNFFp9Dz1qwX
 y1AWizgiJDpjrFX2ijLJ6Ui67hWsYDLBGmHC/+dRLyDl1OtrCVuVbly28+40HoHlA7LRSrB/eQm
 Srt2NL2/aqbK7CE/3GLAyFc16fmWXfvLn1bnZWmBsj+UD7yE91NWBlslO/vY5Ebt4LAVmhc7EjA
 VSoNrG0un47+m9hPjOWCdn8jnfKittrOnbnLlFgKXyMgTX1r+kOeyoZmNczMfopa0KB0+Z0Ewav
 1ip/9GabDRdVbqzv5ndsUs6ZFSRVlf3Q51iybl+x1mJj2gb1S5BGRRGQxWc9w7BKxmLoinfk9wy
 fnguHH9A+ErSYEXfnmL9YAz2GrYJu5vnscsmPiE4F4ajc6G5DlqptFttbqeaPmQ06UuknkgRdwE
 tnwXk0WJKrRvv3hLR1ejaLlUa2g==
X-Received: by 2002:a17:907:96a9:b0:c46:2a05:b257 with SMTP id
 a640c23a62f3a-c4ca7a4066emr418316166b.23.1793447039012; 
 Sat, 31 Oct 2026 04:43:59 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca0e6d9sm960706a12.23.2026.10.31.04.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 04:43:58 -0700 (PDT)
Date: Sat, 31 Oct 2026 12:43:00 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qga: fix uname() return value check in guest-get-osinfo
Message-ID: <auXURBeWoOtLaauB@tulp>
References: <auUjFweAHtj1YSFt@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auUjFweAHtj1YSFt@humpty.home.comstyle.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Brad Smith wrote:

> qga: fix uname() return value check in guest-get-osinfo
> 
> POSIX only specifies that uname() returns a non-negative value on
> success. Solaris returns 1, so guest-get-osinfo treated every
> successful call as a failure and reported a stale errno.
> 
> Check for a negative return value instead, as linux-user/uname.c
> already does.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  qga/commands-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index dcc683f6c9..23abaf1956 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1322,7 +1322,7 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>  
>      info = g_new0(GuestOSInfo, 1);
>  
> -    if (uname(&kinfo) != 0) {
> +    if (uname(&kinfo) < 0) {
>          error_setg_errno(errp, errno, "uname failed");
>      } else {
>          info->kernel_version = g_strdup(kinfo.version);
> -- 
> 2.56.0
> 
> 

Reviewed-by: Roman Bogorodskiy <bogorodskiy@gmail.com>

