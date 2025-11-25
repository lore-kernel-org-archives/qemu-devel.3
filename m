Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BF0D0EE0F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 19:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNyp4-0008Qw-Ru; Tue, 25 Nov 2025 14:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNyp3-0008P1-9d
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:35:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNyp1-0004xJ-EA
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764099330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BEZgFjImgVFkwcD5O5nrZhJP8gCt8AEu9lMbiCNC3sc=;
 b=TCoUlhh4uqITxVm58qOHYyvQnmX53NEq7rsIGkY0t0vKBqxqbCyPQbAxMcIJHrxy0o/ZUN
 Gv5VA0SgEoUdDWYS0JCs82FyM2m5xLQC+8nAThr415kmuI5DL915QndZYGI7Fno4mKp1+6
 4DQP2ht6nbSqpINP1YUGBeo7JcKoqdE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583--6Z6COHFNLW69ghq8gfuQA-1; Tue, 25 Nov 2025 14:35:28 -0500
X-MC-Unique: -6Z6COHFNLW69ghq8gfuQA-1
X-Mimecast-MFC-AGG-ID: -6Z6COHFNLW69ghq8gfuQA_1764099328
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88050708ac2so185950076d6.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 11:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764099328; x=1764704128; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BEZgFjImgVFkwcD5O5nrZhJP8gCt8AEu9lMbiCNC3sc=;
 b=tmOoDwokiGW0vmbdyhKuQoL7DEVo56LEqChbIw+WZHQl5ZnyJNBBNNmjK6fysz0ivJ
 rWH3By/OoeNb+k6IdRq5II6sPaKWkIwF8Q+kCw2rusUgsnnx/dNTD+ma+kGAeM8wLnUf
 4nkn3t6vTiECx509EF5J0tJW3i4WDkKoBh1n7vYKrb/Uo5YeAPOkeguHBB7AwG/4KPtC
 faYbdZoQdots/xDZ4EaPL+54NarozZ7pu3IFZMD/+JrWiho7w+Rl1w2yVIX+2dsqRC/z
 979WCI6bquenZLj/pKV7E4W2pNiqKA0VLZ4lpSz28LMNfEqCto1pMHbpIQLV5E7z7X0Y
 o3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764099328; x=1764704128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEZgFjImgVFkwcD5O5nrZhJP8gCt8AEu9lMbiCNC3sc=;
 b=JNgHwIbas6GyJ8mc5A3Al08/GCrefLej9If4wseEpNtertGaZQ+kvh7VIDROut6xJI
 X94X4qkX2MdDPOIO5AiRZUfKe78gIOThRowbPTJTrlB4YzkWwdtxB3oNTncHtiXUDuV1
 pm1CQA5nPXrBLJ3IB/pMEHa7PT+aY8/UZKtr5Mxe0toghvZ0ktcminVn39WpMMetYQmu
 xr2tajcym4vJCkvcgIpG+bjpWOs5IhAlamOjZ2Jwr9JvFFl2neqi4W/ZYT/NMDnuOj+n
 wpvhumZKNdC/IKrs6TKIvFQMtOj3DoJYxPWH8HZPe8PYRdZ9/tmP3c7RXMIFULPxjnGl
 yKIQ==
X-Gm-Message-State: AOJu0Yw201WL3zGkT7IY8u/wsJmoRDYfEoCezSlf16m931LpysTByGlT
 V2GhpJDhJ4mFBi6SCaa4+/ql/XhlqmQjPVqIrJayQxmhfPZwB1LRcZ3z1cWIuVIiLbliwWJNhM5
 6lfhDVgYAnLVDF2mimIwf1Rhhtwkk0xscT8CRMNW/B9QNeiJ9UxQdBrb5
X-Gm-Gg: ASbGnct4FyYwRVF0GvcCXowTwL4h322BccV9b1xsW1ZUH4bwj732xyXBEoJ8tW7v6xW
 haOvzMQk9FE9Vdbv/Q8hWKtZ/PnMrecc2RV2P6IJXCepnLhPfVKWV8oE+99aEK06waToOh/X6Au
 iLLB3j+XwQfdR710eZr6B6hO4z8PUpqEmBKgzJEbZwstB9YTtwXukbZ9lF2ZlvaGAfrofw3UHC0
 mkyRBoOgeQsT2+WvJVcjk+vH0V1IZNQ3QVY0Q8XqbeZvNTAEufDm8Lgwbdv1rB7W+Ejmdd02KfC
 CIVzCzbL0K6suK+CsaS+4lZzIR+BdowucBRy3ms8cRjyeZL7BJMQ8/S83srF6gD7PRksyG6yogk
 WRNM=
X-Received: by 2002:a05:6214:3d12:b0:880:4cfb:ab5d with SMTP id
 6a1803df08f44-8847c3e4af4mr221684576d6.0.1764099328235; 
 Tue, 25 Nov 2025 11:35:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt0VAT4Ex/7I+JurOHlBAE3X+9cn+0bd2s716k/rjvhowZdIGWDAq/rDIfaZvIWfkrdWH2+A==
X-Received: by 2002:a05:6214:3d12:b0:880:4cfb:ab5d with SMTP id
 6a1803df08f44-8847c3e4af4mr221684026d6.0.1764099327690; 
 Tue, 25 Nov 2025 11:35:27 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e472ae1sm129431806d6.22.2025.11.25.11.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 11:35:27 -0800 (PST)
Date: Tue, 25 Nov 2025 14:35:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Pawel Zmarzly <pzmarzly0@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, michel@michel-slm.name
Subject: Re: [PATCH] migration: fix parsing snapshots with x-ignore-shared flag
Message-ID: <aSYE_rdMhH36KBxf@x1.local>
References: <20251125174649.257457-1-pzmarzly0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125174649.257457-1-pzmarzly0@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 25, 2025 at 05:46:49PM +0000, Pawel Zmarzly wrote:
> Snapshots made with mapped-ram and x-ignore-shared flags are
> not parsed properly.
> 
> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 29f016cb25..85fdc810ab 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4277,6 +4277,11 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
>          id[len] = 0;
>          length = qemu_get_be64(f);
>  
> +        if (migrate_ignore_shared()) {
> +            /* Read and discard the x-ignore-shared memory region address */
> +            qemu_get_be64(f);
> +        }
> +
>          block = qemu_ram_block_by_name(id);
>          if (block) {
>              ret = parse_ramblock(f, block, length);
> -- 
> 2.52.0
> 

Thanks for the patch, though the u64 was parsed in parse_ramblock()
instead.  Would you consider refactoring that function instead?

-- 
Peter Xu


