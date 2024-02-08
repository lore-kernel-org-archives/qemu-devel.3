Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21C2C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 05:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXxGz-0002BO-A8; Thu, 08 Feb 2024 00:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXxGy-0002BE-0E
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 00:48:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXxGw-0005M8-JH
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 00:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707371309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABlSLnUo1GxUMlOsTFJgqs7KiT+3pIu4PqzK+sDMGvw=;
 b=FuOxRQvJkUEBQcDeDj9Phw/QxAf5BySgsfMSuxkEVG2orv2iu1Uq8w6ZPPFQQ6721AkI3g
 iDo4HZ3p23ZdUkVCqN7KVVzkckPkNuLV317KaRcM9xlTFZkhk8j8D1uwjcU9TiF8Z2OEGQ
 b3quuVao45mjatuNuLP88nqSTT+u4lY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Lj9QbFNeOeG-Kz3YR_77Hg-1; Thu, 08 Feb 2024 00:48:27 -0500
X-MC-Unique: Lj9QbFNeOeG-Kz3YR_77Hg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d9f83b7857so1017345ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 21:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707371307; x=1707976107;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ABlSLnUo1GxUMlOsTFJgqs7KiT+3pIu4PqzK+sDMGvw=;
 b=rqfLXmKWNPq47jmCk36TZwyJ3IZqxhUd3I6zUyFNucL8HliIlDmZPHltpcOEGrXoQr
 GK7j4YuuUUGRIIR18ZC/dZ0l0Ya7eJH7r95Thos8nO6zpImsmH9sArkG3/Xd9KvNjkf1
 KsiSHlVxSwagq1dr2ikID6uQ8+7ANvufGvr76o7b75V2mn6P+X3yu3F+74u7Okm4x6tg
 NVYt2Vnn0aPCWJctxy3+aTKB247lz04Cmkied/+84jzSmQxiZiB3BfTNlTGGCwVMdTHo
 KiEkcKNUF7ojPbeGzDLZbfR232Br1MKgK/w2TBwhpJ+cnmZ83qCpC1Cjcv30uDkyfdPt
 pzgg==
X-Gm-Message-State: AOJu0Yx8Nl+ZJOKOt1T8TlZvUalWgcakVorXnXIU2/yRCSpX9eslAICP
 729oK9YgFXvY0IYaiem8ZFk1hU60D1ogA4rfDAY6JG3hTrUMxEqa/3eNUIWvoq/U497wWAGZgVJ
 kLvQO/+7b8kbGAtVlWBeJASshznGz0PBDh0L/MWdzz7PX2e2sbMqf
X-Received: by 2002:a17:903:2449:b0:1d9:9c61:55f2 with SMTP id
 l9-20020a170903244900b001d99c6155f2mr8538188pls.2.1707371306848; 
 Wed, 07 Feb 2024 21:48:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEz6DVUh66s7aznEXshmnNDD4fdvYhIGSsE6O8Bd+BKKDIlYEJ4SPWmXKK7s1p7D67VwqBnw==
X-Received: by 2002:a17:903:2449:b0:1d9:9c61:55f2 with SMTP id
 l9-20020a170903244900b001d99c6155f2mr8538176pls.2.1707371306504; 
 Wed, 07 Feb 2024 21:48:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVqfKGbrT2pp4tBVTFiDHrOZwvLNQ4atqOfnDK+p6QwT9mcZI59pZ7dDPRll0xZ/+NriE5x/Zrj1CGT+3N8d0L/k4PYOCaLF2sr+SDeTbUE51NjTANkS9+dj7ybLWWmcCxupxkWKRXbvkLwVLMNNeWWUQ6u7ZAQC7Bupfgxr2+gE5JGaFQfuOYvOMG/heKVhpIP31taBqPXMlncWXvjA9q1mNPmblePTcRYbiaKWwlqm9EHuDnyiV3JRiYKW/p4QRES07wCJMbEXaJgh/2gpS0cmz+r
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 l2-20020a170902ec0200b001d9469967e8sm2455460pld.122.2024.02.07.21.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 21:48:26 -0800 (PST)
Date: Thu, 8 Feb 2024 13:48:20 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 03/14] memory: Add Error** argument to .log_global*()
 handlers
Message-ID: <ZcRrJIrInupeanqB@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-4-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207133347.1115903-4-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 07, 2024 at 02:33:36PM +0100, Cédric Le Goater wrote:
> @@ -2936,14 +2940,14 @@ void memory_global_dirty_log_start(unsigned int flags)
>      trace_global_dirty_changed(global_dirty_tracking);
>  
>      if (!old_flags) {
> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
> +        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward, errp);
>          memory_region_transaction_begin();
>          memory_region_update_pending = true;
>          memory_region_transaction_commit();
>      }
>  }
>  
> -static void memory_global_dirty_log_do_stop(unsigned int flags)
> +static void memory_global_dirty_log_do_stop(unsigned int flags, Error **errp)
>  {
>      assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>      assert((global_dirty_tracking & flags) == flags);
> @@ -2955,7 +2959,7 @@ static void memory_global_dirty_log_do_stop(unsigned int flags)
>          memory_region_transaction_begin();
>          memory_region_update_pending = true;
>          memory_region_transaction_commit();
> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
> +        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse, errp);
>      }
>  }

I'm a little bit surprised to see that MEMORY_LISTENER_CALL_GLOBAL()
already allows >2 args, with the ability to conditionally pass over errp
with such oneliner change; even if all callers were only using 2 args
before this patch..

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


