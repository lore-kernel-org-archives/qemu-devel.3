Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920FEC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8de-0000lT-E6; Tue, 12 Mar 2024 16:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk8dd-0000l3-24
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk8db-0002R1-77
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710274933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G22b7h8hJqoLPtZczLDPrp40rBZIXmk+72WxIOudHWA=;
 b=eird2MYObjHzVHLtH/qjYyyQm7PMFovuGnvIq8yxFXNfYl73bg8qoVnfnwGsxaWuBzoXxO
 k5zSYsPJv1fnuNPWNc+Ararq5NzhpoIUG6I0BAIGi3fSWgyy9NVEL5xyM2fpSI6YciwL2a
 EvldkzeOfQDgLGKM8PPvLdL1Qf2vOQE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-dRNtj8AZMtOYsB2O7V9cdg-1; Tue, 12 Mar 2024 16:22:12 -0400
X-MC-Unique: dRNtj8AZMtOYsB2O7V9cdg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-78825e5e374so39705685a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710274932; x=1710879732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G22b7h8hJqoLPtZczLDPrp40rBZIXmk+72WxIOudHWA=;
 b=pm4/n5/G2lzR9ZzFjPXEzj9u14/ZWhW/eQyRnIvdd2X/6ljdzgyuZwKWaPX8GNeAwN
 E8Ys9vqNAf3HlBsRCT86lv08jYKu+N31Ek3LvmT5W0FZCb6bjIsapIjsdA9zHn8626Ka
 s/FHhttvS1X38rrsRHOPEO3QyIirMzyE2Fo//QcIEYDRDxKktT8lx/246QKqbBeIXWfB
 CuUqQpIYkbmImjgbFo3uCDvCnlweQcHkjgQLS9PPxl3pDn01rJDCtkIa2h9XrLkVtRTU
 YMpjlY8gMtBUJ7LkBGvS99Eoge4XY4KjuW0v3HZCdgon5oOuO2j9kVtu7F9KtQA4BFSk
 dqsw==
X-Gm-Message-State: AOJu0Yzja49jEDXKGRHiV92Klwq0ylC6OATrz7zRr0ozNrQPXD3WHYop
 4aYJyqbI1VYZImK8ftfrkn0FsWU70+XGLjvYoOEgDa2f7Ig43QVqqjEwanEQCF5OtvXMy3Bd74t
 QTewDCklJUWGGppzT+E7OfU0+PTf8+BVEWLTl6KRY0wXTbdAct8Sx
X-Received: by 2002:a05:620a:1a1b:b0:788:23ac:f917 with SMTP id
 bk27-20020a05620a1a1b00b0078823acf917mr1172569qkb.10.1710274932024; 
 Tue, 12 Mar 2024 13:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAkwFP6he15Kr7+zx18PMZSbGtQZNzrxOLoEFXAxzqiRvVXETUc99iDrMXfgZPzDIJbTq5SA==
X-Received: by 2002:a05:620a:1a1b:b0:788:23ac:f917 with SMTP id
 bk27-20020a05620a1a1b00b0078823acf917mr1172540qkb.10.1710274931597; 
 Tue, 12 Mar 2024 13:22:11 -0700 (PDT)
Received: from [192.168.1.33] (92-184-107-91.mobile.fr.orangecustomers.net.
 [92.184.107.91]) by smtp.gmail.com with ESMTPSA id
 l2-20020ae9f002000000b0078860cacdefsm3643968qkg.77.2024.03.12.13.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 13:22:11 -0700 (PDT)
Message-ID: <1b9016a1-ad58-47ba-9dda-96095c1e59bc@redhat.com>
Date: Tue, 12 Mar 2024 21:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0] migration: Skip only empty block devices
Content-Language: en-US, fr
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20240312120431.550054-1-clg@redhat.com>
 <20240312184106.GC389553@fedora>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240312184106.GC389553@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/24 19:41, Stefan Hajnoczi wrote:
> On Tue, Mar 12, 2024 at 01:04:31PM +0100, Cédric Le Goater wrote:
>> The block .save_setup() handler calls a helper routine
>> init_blk_migration() which builds a list of block devices to take into
>> account for migration. When one device is found to be empty (sectors
>> == 0), the loop exits and all the remaining devices are ignored. This
>> is a regression introduced when bdrv_iterate() was removed.
>>
>> Change that by skipping only empty devices.
>>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Suggested: Kevin Wolf <kwolf@redhat.com>
>> Fixes: fea68bb6e9fa ("block: Eliminate bdrv_iterate(), use bdrv_next()")
> 
> It's not clear to me that fea68bb6e9fa introduced the bug. The code is
> still <= 0 there and I don't see anything else that skips empty devices.
> Can you explain the bug in fea68bb6e9fa?

Let me try. Initially, the code was :
     
     static void init_blk_migration_it(void *opaque, BlockDriverState *bs)
     {
         BlockDriverState *bs;
         BlkMigDevState *bmds;
         int64_t sectors;
      
         if (!bdrv_is_read_only(bs)) {
              sectors = bdrv_nb_sectors(bs);
              if (sectors <= 0) {
                  return;
         ...
     }
     	
     static void init_blk_migration(QEMUFile *f)
     {
         block_mig_state.submitted = 0;
         block_mig_state.read_done = 0;
         block_mig_state.transferred = 0;
         block_mig_state.total_sector_sum = 0;
         block_mig_state.prev_progress = -1;
         block_mig_state.bulk_completed = 0;
         block_mig_state.zero_blocks = migrate_zero_blocks();
     
         bdrv_iterate(init_blk_migration_it, NULL);
     }

bdrv_iterate() was iterating on all devices and exiting one iteration
early if the device was empty or an error detected. The loop applied
on all devices always, only empty devices and the ones with a failure
were skipped.
     
It was replaced by :

     static void init_blk_migration(QEMUFile *f)
     {
          BlockDriverState *bs;
          BlkMigDevState *bmds;
          int64_t sectors;
      
          block_mig_state.submitted = 0;
          block_mig_state.read_done = 0;
          block_mig_state.transferred = 0;
          block_mig_state.total_sector_sum = 0;
          block_mig_state.prev_progress = -1;
          block_mig_state.bulk_completed = 0;
          block_mig_state.zero_blocks = migrate_zero_blocks();
          
          for (bs = bdrv_next(NULL); bs; bs = bdrv_next(bs)) {
              if (bdrv_is_read_only(bs)) {
                  continue;
              }
     
              sectors = bdrv_nb_sectors(bs);
              if (sectors <= 0) {
                  return;
		
            ...
       }

The loop and function exit at first failure or first empty device,
skipping the remaining devices. This is a different behavior.

What we would want today is ignore empty devices, as it done for
the read only ones, return at first failure and let the caller of
init_blk_migration() report.

This is a short term fix for 9.0 because the block migration code
is deprecated and should be removed in 9.1.

Thanks,

C.
	


