Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EBBC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5ll-00026C-Gf; Fri, 29 Mar 2024 02:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rq5lf-00025M-UC; Fri, 29 Mar 2024 02:31:13 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rq5ld-0001dV-Hb; Fri, 29 Mar 2024 02:31:11 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e6e0867be8so768486a34.2; 
 Thu, 28 Mar 2024 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711693866; x=1712298666; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0E8q/Zmrn5qvCq6dNb3PeN8tdzYMaKK9p6StWoqhK60=;
 b=Ilm3N+a3+Yw1+B42emAZgLdb2+Nkv2kz47Ia6W38O1/yHVKWiwfrxF4AC97xBLiISV
 vGWEG9rFl0t7KnV/IUQfjt/6s4b6TiiMg7+OhFbGVd+Z34NZX/vPnnYAqWWlA1YVu/gp
 85IaE6bkECOBVSVBX2kBm8UPwyVqTfA87RViUIUoGB/TkFk6umxIl9v6njRUZ7fWj1E9
 HkZYz5Z9Lj01qaWNkzZxhLBHqj22KS9AixDKqDUejbKyxY/dzBfqCIJgbL+ksIMc8hmh
 t6Od8Bze0oPdps60Y/cilx3iocp7WJYhDCNk4ArJsEVlZruHYkr+JJVs0Crc6Sy3PhTp
 KPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711693866; x=1712298666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0E8q/Zmrn5qvCq6dNb3PeN8tdzYMaKK9p6StWoqhK60=;
 b=Dv5AVgkqLrozT+ovD7uMZdT17gp3y2jrUf76UDoVi0dSfIvUlca8PZvAJuHuCgrJuQ
 hsLlwsx5dPKZUxynrNyqZyKNVPgLVeItGkYvzbqYG1olr120dyVb1ulooOzbtl7gSrgn
 eNyA2PNBGtyiVomDfkD8m+Cldd7/YE4xsP+F8nexp0Q1wHotGFQqhdMhdPBKtc1NZyp4
 nunZyxYn0uHXQiFTXtwLmbSWK2hF05dRvJa3P+kwLioS1Kv3zpXLFPljV52SMdAIJj4I
 8qFTKArw2UsegO0N43F6aMUG8ecjiWaB3d4buKtw/hlbE4NT8nuUfoLnjmJQqoXU4b7P
 rXfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+wiZ/rUcTV3bX2tF4uils3QzLOEpAcacqHT1rcjbZR6zFNR0G7Uft8D/Q3kfq+mY21wB5eyHOdbzUrDLnatCTLHtr/bo=
X-Gm-Message-State: AOJu0Ywmuxkg5ndQfEzWBGrrPBkuahZfaMqdzgh/yQ2WoWYZN6teDTeA
 DNTQGejXauR+l/iSE5gleHSfEJs2deq/kL0XzO3/rNJ+Cw9A1HTvEqoZnNvTYkH1XstiXu0=
X-Google-Smtp-Source: AGHT+IGfe9Rz7xbf0jgEJjXv21CfYyk0trm7UzZwMBQ16L11oPi4AGI06QYJdGQuCtscod2RUgucZg==
X-Received: by 2002:a9d:4e8f:0:b0:6e6:b8e9:bec0 with SMTP id
 v15-20020a9d4e8f000000b006e6b8e9bec0mr1443499otk.12.1711693866401; 
 Thu, 28 Mar 2024 23:31:06 -0700 (PDT)
Received: from amjad-pc ([192.228.218.97]) by smtp.gmail.com with ESMTPSA id
 t62-20020a632d41000000b005dc85821c80sm2257526pgt.12.2024.03.28.23.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 23:31:06 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:31:02 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/3] ffvat: Fix reading files with non-continuous clusters
Message-ID: <ZgZgJlQQKTQAv7Gt@amjad-pc>
References: <20240327201231.31046-1-amjadsharafi10@gmail.com>
 <20240327201231.31046-4-amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327201231.31046-4-amjadsharafi10@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I noticed the issue in the commit message 'ffvat' should be 'vvfat',
I'll fix it in the next version.

On Thu, Mar 28, 2024 at 04:11:27AM +0800, Amjad Alsharafi wrote:
> When reading with `read_cluster` we get the `mapping` with
> `find_mapping_for_cluster` and then we call `open_file` for this
> mapping.
> The issue appear when its the same file, but a second cluster that is
> not immediately after it, imagine clusters `500 -> 503`, this will give
> us 2 mappings one has the range `500..501` and another `503..504`, both
> point to the same file, but different offsets.
> 
> When we don't open the file since the path is the same, we won't assign
> `s->current_mapping` and thus accessing way out of bound of the file.
> 
> From our example above, after `open_file` (that didn't open anything) we
> will get the offset into the file with
> `s->cluster_size*(cluster_num-s->current_mapping->begin)`, which will
> give us `0x2000 * (504-500)`, which is out of bound for this mapping and
> will produce some issues.
> 
> Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
> ---
>  block/vvfat.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index cb3ab81e29..87165abc26 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1360,15 +1360,22 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
>  {
>      if(!mapping)
>          return -1;
> +    int new_path = 1;
>      if(!s->current_mapping ||
> -            strcmp(s->current_mapping->path,mapping->path)) {
> -        /* open file */
> -        int fd = qemu_open_old(mapping->path,
> +            s->current_mapping->first_mapping_index!=mapping->first_mapping_index ||
> +            (new_path = strcmp(s->current_mapping->path,mapping->path))) {
> +
> +        if (new_path) {
> +            /* open file */
> +            int fd = qemu_open_old(mapping->path,
>                                 O_RDONLY | O_BINARY | O_LARGEFILE);
> -        if(fd<0)
> -            return -1;
> -        vvfat_close_current_file(s);
> -        s->current_fd = fd;
> +            if(fd<0)
> +                return -1;
> +            vvfat_close_current_file(s);
> +
> +            s->current_fd = fd;
> +        }
> +        assert(s->current_fd);
>          s->current_mapping = mapping;
>      }
>      return 0;
> -- 
> 2.44.0
> 

