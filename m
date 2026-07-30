Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590F7C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTRR-0007aj-Na; Thu, 30 Jul 2026 12:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpTRN-0007aC-Rt
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpTRK-00043T-BM
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785428209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=imGQuj8oDeXGHBHdJARmbsmrdgPvMyTPHH3AKrJ7Its=;
 b=auS/Ej11GQkSYNBt14gTm+1FM51ZsvDq+sTy1JD1wjckmCwFO5DM5XS/rAjbyUIl6KMElz
 DZhqlosajEyId6xMcJV1vU/upmbKb1KcxMP6HDk/tOKut2v7RZ4p0mkoYzSPVtK24vZ0v/
 58Utkfphl7HeVBsR3G4qTKLqjEDwQ4I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-4cyPukKUM6iwS2aJ0aSoWQ-1; Thu, 30 Jul 2026 12:16:33 -0400
X-MC-Unique: 4cyPukKUM6iwS2aJ0aSoWQ-1
X-Mimecast-MFC-AGG-ID: 4cyPukKUM6iwS2aJ0aSoWQ_1785428186
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15e57a7f8cso216447866b.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785428186; x=1786032986; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=imGQuj8oDeXGHBHdJARmbsmrdgPvMyTPHH3AKrJ7Its=;
 b=iD4P0tK+eeBXyIQsq8YadVs1pPhoHAjsG1glZ7dGJK2GuNA6ArNNTFVkK5Fwo6L84I
 EffIDuMJ8lm1E5A2GdOhxY8FEBJd4ArIdy3FjYS9KZaEGSAdpA/i7BdEoSGsXYpChz6G
 bfGcCu8IKJfYtgiQUVC2aPsc0dq1U9uLHSf68krv6jqu8rcfIcOsDJWIWXXyJf4+D5jd
 /jgADVJCGTl0TvkSx77BMMyzcIW2mqq8qNwh5pG/PC13bACFmiGIYs8nxZRiDt/HcHvH
 DkP4eYjhvpxnLY80SnmLFKTQjhy+eJUzRsRctQydo1DchHtUnTnhm7yTI68mA80IUks6
 VKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785428186; x=1786032986;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=imGQuj8oDeXGHBHdJARmbsmrdgPvMyTPHH3AKrJ7Its=;
 b=KMyKUEFeGdZfKghjYvAUaaYDkvf4LRatpp+o0VOzeChogNtHfnwPk/jAlIur/t9M0g
 c9O/c13/Yg4q4DXJ6DxIvaSIk5Q/5pzpSbZWh9+OeqfrlCcnPPUUgriejICCWQXaE9NK
 qPlp9g1HxxLRhjkHOWAunYmU9UcinK+v8m6oIlk7qbi6bSTlAHfA/knVWlwrprvYc64l
 0HjHBZRMF7F9bupNb1YS2tENLGJjvJu+K5Z832U4+tTEEncf1Fo3W/IoSVvq6gIQlYh0
 H6EyLw57xrWHUl6uwKIDRYtWZlItmfuvZ9UDIligNnaJP5RbUYgrOTVEMj3Nh5LMRSA7
 9unQ==
X-Gm-Message-State: AOJu0YyaG4qhQBL5F4VSX5KO6Bip6S5o8F259D3Qs1EVK/da2BP5s8lA
 SZKfxs/EMWvcGOC+UjzoBBtWOMtYkZXL8OVpOnTuznq+o5osRJkLcho9QxJamjPQfvXOv4dyMUA
 QWXJKko5XgKeP3rPGMjLf6B01O1Uxixh+Hh+l39599g3eChu4EXbk6RA0
X-Gm-Gg: AR+sD12XmOzLElw7WzOT9emCxamgl6BEGRtzQhGlE3uzhbWgUMoRVcRfLFVUZydX2nw
 LcyLSeZFSyFYYSPz5Zyfmpno1DIj6mJG1b/0ZWRNf0mDm2KcQei26cQPMFGszOYc+Ov4mJv9p6F
 zgiYM+tSh9KV8is12elEFjRPcVc76hrZ7EXcF0tu0zjCDVwa85y6oD6CbzcAupoKEMByjZInPVV
 Dg8nY039IcP3OQAwaTpMVF99DrbMMrfZDew7RITBYrqea6SqFiajGJEeK3GBoNpnPRcS3IWZouC
 ozrMCjO5LM4m3rBhBLW1M290SDnbJ/S4dXvXEUWD1cQPvEd/WU4nFm+AnmAKg6l4WgYt
X-Received: by 2002:a17:907:3c93:b0:c1c:3b06:ed03 with SMTP id
 a640c23a62f3a-c1fa55a952cmr165184366b.23.1785428186221; 
 Thu, 30 Jul 2026 09:16:26 -0700 (PDT)
X-Received: by 2002:a17:907:3c93:b0:c1c:3b06:ed03 with SMTP id
 a640c23a62f3a-c1fa55a952cmr165182666b.23.1785428185751; 
 Thu, 30 Jul 2026 09:16:25 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8b6d814sm85185266b.34.2026.07.30.09.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:16:25 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:16:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 0/4] migration: Remove extra type-checking from vmstate
 macros
Message-ID: <amt407uotej1DZuy@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
 <amtbGkfKvPCJgDec@x1.local> <87v79wmqty.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v79wmqty.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 30, 2026 at 12:37:13PM -0300, Fabiano Rosas wrote:
> I can look at it all. Just a heads-up, I'll be off for a couple of weeks
> starting tomorrow.

Thanks.  I think it's fine we resolve this after your back, as long as
Michael is ok with it from vhost side.  It's not real CVE, so I hope it's
OK.

-- 
Peter Xu


