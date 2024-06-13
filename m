Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE07C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 18:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHouT-00028u-93; Thu, 13 Jun 2024 14:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHouQ-00025b-V7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 14:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHouP-0005g2-9d
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 14:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718302247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BF28LEHN0LbmtQ/msIN/gqzbUl8lOYYK25Y7E1l0/A8=;
 b=IDZ/Nk4z4hPJnXVkPCxfgZ83+fTDUj7LlxX65Bjl3DfDupC95TSlRxx+2ozrno3YCWupfk
 2WKxrL8oaN1AvYghwkMjUeaIzFH0g5lmNHhS82nrc5telBLQOLtwX6oS871Hs2T0pVGFgb
 YGV+4eXzjqoPFinc+eIz06Jb/1WkTWo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-RJs0e1_BMMWz_V11krj3bw-1; Thu, 13 Jun 2024 14:10:45 -0400
X-MC-Unique: RJs0e1_BMMWz_V11krj3bw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b0762cfd0bso3047226d6.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 11:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718302243; x=1718907043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BF28LEHN0LbmtQ/msIN/gqzbUl8lOYYK25Y7E1l0/A8=;
 b=JBp+DadPbxjuECrHkm9/2PB/OkAplzeyNEC7E4lMpTti0I6YkHD1NJqJY11xZ64cGm
 lOepNDE8/vOxYyGCdBOZM9EbOYIG7hxFiZ9uOmWISscV4+HdIF3ViUtrfuHQlRABPmmR
 qlC9BN+49A/o6IF+62YTI27YodM0BcwTscgal9DwAkhRfVZAmCiugsiH9Ej3Z4woSxFx
 x9VylbLdAM8D4zLQhS1Kfzwacd3HIlj+g9UCDRAneqA7jlB6OsMHuhzxLgP37z/f39K/
 U4s80RIqMqkMKxFQoyeFT/JUzCsGHLHUFDPBZQgl2rH9NXoI1csGyz1qdc+NA4/XNJre
 RamA==
X-Gm-Message-State: AOJu0YxA6DbTUjZM+Eqp5ZKqayLjaPV3gy6th0fMK9mUpVsurdtHh48v
 CMoDZG5SPdDhbgJi8OG6CiNbhvXepxdvRb3KbjsjjKguyQwmkWLW6nYcP+W8B+9loTXe9T9pFz1
 Trh2Lh/P9HZ+0Qn199+/zvqjpQIo36UfLGh+9LRSAXzisvYPvqjw+
X-Received: by 2002:a05:620a:272a:b0:795:493f:9f3f with SMTP id
 af79cd13be357-798d269f370mr26705085a.4.1718302243162; 
 Thu, 13 Jun 2024 11:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcTeMK8SCZvjWSwxapJH6u0A0GoLRJ3o0OOKsOTx9QZ0iNBj/HMHpzlVAu4S3hQI+3Nyjqvw==
X-Received: by 2002:a05:620a:272a:b0:795:493f:9f3f with SMTP id
 af79cd13be357-798d269f370mr26701285a.4.1718302242481; 
 Thu, 13 Jun 2024 11:10:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc0cf98sm72328685a.80.2024.06.13.11.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 11:10:42 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:10:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH 4/4] migration/postcopy: Add postcopy-recover-setup phase
Message-ID: <Zms2IDg_6B0vhwuv@x1n>
References: <20240612144228.1179240-1-peterx@redhat.com>
 <20240612144228.1179240-5-peterx@redhat.com>
 <8734pgdhf5.fsf@suse.de> <Zmsc5pXGs4dLfiLB@x1n>
 <87tthwbvy7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tthwbvy7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 13, 2024 at 02:21:04PM -0300, Fabiano Rosas wrote:
> >> > @@ -3666,7 +3716,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
> >> >  {
> >> >      Error *local_err = NULL;
> >> >      uint64_t rate_limit;
> >> > -    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
> >> > +    bool resume = migration_in_postcopy();
> >> 
> >> Here you're expecting just PAUSED or RECOVER_SETUP, right? We'll not
> >> reach here in any of the other postcopy states.
> >
> > I think here it must be RECOVER_SETUP after this patch.  I changed it to
> > use the helper as I think that's cleaner (precopy doesn't allow resume),
> > and we don't need such change if the state machine trivially changes again.
> >
> 
> Intent matters for anyone reading the code in the future. I would use
> the state explicitly, but I don't have a strong opinion, feel free to
> ignore.

Neither do I; let me switch back then if it helps in some form.

-- 
Peter Xu


