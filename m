Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B072CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TIx-0002vL-HE; Mon, 29 Apr 2024 11:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1TIw-0002vA-CY
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1TIu-0004QZ-W7
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714405951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e0nqwEvXX66l0o6AmMWjYw1IPtFCD+7eR/mpJfV5IqY=;
 b=V/1cYm05U9uHGSXvEAbfq7kI1zevK2IDNU1FUfXwelOfkQJKH0QQIgIwHoCLa1b1Xqp4b+
 dzbzporxWPP6ZpbH+fSYGnyatOL1ygW8tVh0YlvLAcoYy26gtehliceHSF7KA+dN7m5SRe
 RpJTuaIiTYriJC8aV6dK/rK278fFFIw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-w0rjIiCYOLmTCZMaT8QANg-1; Mon, 29 Apr 2024 11:52:30 -0400
X-MC-Unique: w0rjIiCYOLmTCZMaT8QANg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2a303938023so1398722a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 08:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714405946; x=1715010746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0nqwEvXX66l0o6AmMWjYw1IPtFCD+7eR/mpJfV5IqY=;
 b=GljTUqhc/tiAlWtNYr3caZFk7ovt1Zv7bof8wtduo94edVCui+e94qzBuBqsMcG71B
 6CfvG4ai5xRqjDHYw19Iu6JR7zVucdJaFYaYJjNbZI5O1YDe5EAORjcLxc+5uaTFBAVc
 +qru8VnfQBoDevwJNxP6QB9ekGN4l+j9nftflYiTIflCUbAwxMvK5Aekl8XPeucen+2c
 yJp9G4qAwx1QkvjkdEzscETGvti0stgFm5EYOt6n5Laj+iNXINQQF/vMDeAf9qISgSg7
 VUO8vDxyVG91Whp0Ph5z36/cQrkF2rYV3G4l9kYeNLNtx39mdYast4wjgE/Ntsww1Eu9
 lS7w==
X-Gm-Message-State: AOJu0Yxm4zY31o8qVU0rXYyBi0okAuqjilRVpGhQuU7P2pJXPF9rj/Uu
 V8hE8I6r1IZ+jH03aGlxo/xfM7ZVm0kUmHGcprOtYKfuQNcR/2+wj49rz7CX7upaXUkpvBfG0JY
 CwBUBIR3R8J+RiGl6OsnBfssNXojgivUbNk/1AL2yYxwRa8Que9gr
X-Received: by 2002:a05:6a00:730c:b0:6ea:6f18:887a with SMTP id
 lq12-20020a056a00730c00b006ea6f18887amr12162108pfb.1.1714405945633; 
 Mon, 29 Apr 2024 08:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTpInTXUQGXHs37IVc3bF4pgm5v43K5cjuE6AQjuDJxOmjeI+z4FG474vMqQmHwLOVz3TnAg==
X-Received: by 2002:a05:6a00:730c:b0:6ea:6f18:887a with SMTP id
 lq12-20020a056a00730c00b006ea6f18887amr12162084pfb.1.1714405945197; 
 Mon, 29 Apr 2024 08:52:25 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ld2-20020a056a004f8200b006eaf43bbcb5sm19459846pfb.114.2024.04.29.08.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 08:52:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:52:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 3/6] migration: Remove 'blk/-b' option from migrate
 commands
Message-ID: <Zi_CNIYAi6UbxJ0j@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426131408.25410-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 26, 2024 at 10:14:05AM -0300, Fabiano Rosas wrote:
> @@ -2003,21 +1997,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
>          }
>      }
>  
> -    if (blk) {
> -        if (migrate_colo()) {
> -            error_setg(errp, "No disk migration is required in COLO mode");
> -            return false;
> -        }
> -        if (migrate_block()) {
> -            error_setg(errp, "Command options are incompatible with "
> -                       "current migration capabilities");
> -            return false;
> -        }
> -        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, errp)) {
> -            return false;
> -        }
> -        s->must_remove_block_options = true;
> -    }
> +    s->must_remove_block_options = true;

Can we drop this var too?  Perhaps with block_cleanup_parameters()?

-- 
Peter Xu


