Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9F5C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnPCH-00005o-E3; Thu, 21 Mar 2024 16:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnPCB-00005G-7G
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnPC8-0001xT-3T
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711053562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjyu8Fzt1dpbvaD5N/5UL7bx8QXQvb/Wl7BpsWSHXQE=;
 b=NvrpZRCD8aRZKQ9GR+kKqbP7Z1jb+W8tS2T6BeisJSyn5CZzjK8bCnVKYezhYyEiQSTOF7
 MoElRGsVDRIZOs7/MdG5N0BvYPPTzFHTMOU5VGbw2qZr8/n0uYjVzaH6NnZphCuUnO3+db
 H/NxJIoYWEdcTI/N9j33JsDfwzC+9Tc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-YO76wnLjOW--JnTcC94KMA-1; Thu, 21 Mar 2024 16:39:20 -0400
X-MC-Unique: YO76wnLjOW--JnTcC94KMA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-430c9bbe925so2759341cf.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 13:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711053560; x=1711658360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjyu8Fzt1dpbvaD5N/5UL7bx8QXQvb/Wl7BpsWSHXQE=;
 b=mBkcR8+AYHVIfv9E4HBn5SjFpIASdSOlqSjaEB2IWSSnhmpc8XQG68nRL9eb+8I4Ib
 NyRym3P+cLJWdTa5eSDgyvRtlpVz6lEM82GyONQy/QBuP5FUY9hGHovhMkQ7pcqhJ6re
 Gq/Rm2Ye38sEAnN/cmNls8JxFdlbLWtxRc+y5zoWIV8uHQpY8sWqAzehG7SehBRIws/x
 MoLvNj0k7P0wxDWr0DshwX+OA6kBWv0KDJd0hwfBvlPVyXPwdAcLEadQ/s0O7QYrHchs
 uXCmfRn9IRWeq4r9QgO6DeH9WWqORYgPiriSXobtiLfyqxkaE7KWg4h/ZJJiUqAbbp61
 u1Zg==
X-Gm-Message-State: AOJu0Yzy3h5AHsAF/nZuG4o4d+43uJHtdeM6RukLF8gm3up7QSr2rUQd
 IdYEvoDanNiMoM3rOXbQZ/DPfBCfEhkyO5+NESVodI4vfOtj/CzcqFYF7MCHuOAyyQ5tpvWzZzk
 dd/aowA+qx9gdzwdnZHFehSIVlnkFYsKcBpBF2pkeerPFnx+RCkB8
X-Received: by 2002:ac8:57c3:0:b0:430:e974:b94d with SMTP id
 w3-20020ac857c3000000b00430e974b94dmr296965qta.3.1711053559958; 
 Thu, 21 Mar 2024 13:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHReVDECQ23mTgI9/oeTraRPPL1WMm3dVeQwht64vk7FWa2CEw73QkA/VKGa+Z/2Ioqc43GnQ==
X-Received: by 2002:ac8:57c3:0:b0:430:e974:b94d with SMTP id
 w3-20020ac857c3000000b00430e974b94dmr296941qta.3.1711053559536; 
 Thu, 21 Mar 2024 13:39:19 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 g10-20020ac842ca000000b004312a406460sm232705qtm.38.2024.03.21.13.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 13:39:19 -0700 (PDT)
Date: Thu, 21 Mar 2024 16:39:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH] migration/multifd: Fix clearing of mapped-ram zero pages
Message-ID: <Zfya9XpgJhCNc_z3@x1n>
References: <20240321201242.6009-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240321201242.6009-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
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

On Thu, Mar 21, 2024 at 05:12:42PM -0300, Fabiano Rosas wrote:
> When the zero page detection is done in the multifd threads, we need
> to iterate the second part of the pages->offset array and clear the
> file bitmap for each zero page. The piece of code we merged to do that
> is wrong.
> 
> The reason this has passed all the tests is because the bitmap is
> initialized with zeroes already, so clearing the bits only really has
> an effect during live migration and when a data page goes from having
> data to no data.
> 
> Fixes: 303e6f54f9 ("migration/multifd: Implement zero page transmission on the multifd thread.")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1222882269
> ---
>  migration/multifd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index d2f0238f70..2802afe79d 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -111,7 +111,6 @@ void multifd_send_channel_created(void)
>  static void multifd_set_file_bitmap(MultiFDSendParams *p)
>  {
>      MultiFDPages_t *pages = p->pages;
> -    uint32_t zero_num = p->pages->num - p->pages->normal_num;
>  
>      assert(pages->block);
>  
> @@ -119,7 +118,7 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
>          ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
>      }
>  
> -    for (int i = p->pages->num; i < zero_num; i++) {
> +    for (int i = p->pages->normal_num; i < p->pages->num; i++) {
>          ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], false);
>      }
>  }

Hmm, a challenging one even if it reads obvious.. :)

queued for 9.0-rc1, thanks.

-- 
Peter Xu


