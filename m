Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7EE106ACD6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kxJ-0005JP-Px; Thu, 12 Mar 2026 14:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0kx8-0005I5-RU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0kx5-00069E-Tq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773340805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysd8F6NWK+sJwoIRQiRh4QFTp0FsMbrQfj5Wrf6OKnI=;
 b=POqXk+xzgE7+LGsLV8NepbvdLD0AhDOvnUbw1KO/HJPBqU4eusf9cqr9N+tHsyzbwQ4MXg
 l5PG9wLEX0+Mz1mdhM+end6R9sbz8EK7XolYXxHs8/R0by+m/oZfrouXmfUTFPWTGRgiih
 ZpCB7QK5X1WJDd5PRvUziyC0Pbd7k20=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-X7Ij8o-cNsSEWJdGX_BGlQ-1; Thu, 12 Mar 2026 14:40:04 -0400
X-MC-Unique: X7Ij8o-cNsSEWJdGX_BGlQ-1
X-Mimecast-MFC-AGG-ID: X7Ij8o-cNsSEWJdGX_BGlQ_1773340804
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899e5c9edb9so109085566d6.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773340804; x=1773945604; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ysd8F6NWK+sJwoIRQiRh4QFTp0FsMbrQfj5Wrf6OKnI=;
 b=awpX+Wau2+fhc7/FQhy6CpRFfPmg91/eVhAoQxi8hwvU7E25cWLKuJ1OlpeV7ayQjy
 fKOQIcEm8JKwTVsdEDDIekTafspUEwjyVvyveRDUMasOPCSu2H2cIzSGh0Zw/ta8Chn0
 R1oN9hNyjVIXS9fZ0OVexMCezyGVpgmCAuKZwrY4g4mQw7QmQDbeRYx7k7JxAdbQxhw0
 e7ehNYSHMK3ADoQt7KK3hOnZECAuRQNT5a+LFhb8HfEPPMVDkNz82cO8n6wVbP2bT8RO
 FpMNtau+N+hZ14IKUtOzWJ71NN+Yq8/Znuvb0lvt+XwS3GLQhwAVLqggMJbWHPS46QDL
 hLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773340804; x=1773945604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysd8F6NWK+sJwoIRQiRh4QFTp0FsMbrQfj5Wrf6OKnI=;
 b=cnuAJLEifgMluL+hHDAxo7vE34a8pkJ4XP5hyIQHgJnTU6inxmmg3Kq3Flr4xvQp5y
 EU73gyLgOV6fOhkM1u76EGu1ToVSfqUHvM1qKRV3ARlya6Mz8gp8bAZHtDsed4Xtq0fu
 ISUgT18LZTXmk/63aqGW9OJgZ+/UPNIs9oLNohO38N0kH/EkrXLQPFJkea5SWnJHwnpX
 2icujWwvLZ05FSK0anBXPAVoDTe4W5ElK4qThVrlhpy7URvh+JIA+1afP/NpeluCBAUL
 mzo031FN4zFkj2mmMckmGqNm1/gSuV8I/Z3uT8WpOI5MFoUUL6LT5SjL4AVkhyRwOcbC
 5SdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4HYHDbyEUbAXPSxTvHiFyyd/FxpbRZ0InK/GyxPWAMg6brlqN+V8VFilbVZ9TG12CM71jvPzSuttw@nongnu.org
X-Gm-Message-State: AOJu0YwnaFyzS5mmkOXFJ/B9u87wngBdbGV9wP4M9Qfx6vN9fmqsoOf3
 JWRsF0ffKl1n2KOEnldQtLlpumXX8FuE6YS8idVqGWOAgLGA6ZI+g++kKSoO5XQ+RXSm5qVCw5v
 Jp3xyjpZNgW83tEwdbP9bqgpnuRcJ6CamkqNWelF7afVYr+fIjrXqP43Hl6sifT7y
X-Gm-Gg: ATEYQzxXXrk6hSy34gaTCCN7NFZEI+HZxqJdum3HBBXOQh2kiiLEyGf6B96Pqkg2HnU
 GHZjsLYlbupWSU1HfzmDjmZrCohWbDHRlEXBgEJoixGyv7kTJRGxGxxqctNSurc/j/jDQd1bl5j
 X2BOmMjTTdg6wzQ+xTJt6EMzPEW9ENbOgiA4rCgs96M7aCWz+HJ2Aa+Ihxeygd745Yb+uGwoZ1Z
 qdxPRGfXzDR1mwQclF5qS9lHMZ/ML8OMy82qATnOl2xet6a4EONMgf/AbpSt835q2YogAuNhKUF
 u9wkyuLHQ/+WI4vd4hi8Hv9GN0gqCoD+UA0qvrU7J3vkXIh1m1af3w3Ub8b3IrXEYGujjg/sQsO
 9fGw5czeYUT/TlQ==
X-Received: by 2002:a05:6214:2506:b0:899:f22a:7d79 with SMTP id
 6a1803df08f44-89a72a1bebbmr68198516d6.16.1773340803723; 
 Thu, 12 Mar 2026 11:40:03 -0700 (PDT)
X-Received: by 2002:a05:6214:2506:b0:899:f22a:7d79 with SMTP id
 6a1803df08f44-89a72a1bebbmr68197996d6.16.1773340803206; 
 Thu, 12 Mar 2026 11:40:03 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65d16395sm39418496d6.48.2026.03.12.11.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 11:40:02 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:40:01 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 chenyi.qiang@intel.com, Farrah Chen <farrah.chen@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] memory: Set mr->ram before RAM Block allocation
Message-ID: <abMIgThCxU1gnMqZ@x1.local>
References: <20260312063420.973637-1-xiaoyao.li@intel.com>
 <abLf8EW3M7XCBh2K@x1.local>
 <92fcc6f0-655f-5726-1758-b2429911f0d8@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92fcc6f0-655f-5726-1758-b2429911f0d8@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 12, 2026 at 07:04:06PM +0100, BALATON Zoltan wrote:
> On Thu, 12 Mar 2026, Peter Xu wrote:
> > On Thu, Mar 12, 2026 at 02:34:20PM +0800, Xiaoyao Li wrote:
> > > Commit 2fb627ef2f48 ("memory: Factor out common ram region initialization")
> > > introduced a helper function memory_region_set_ram_block(), which causes
> > > mr->ram to be set to true after the RAM Block allocation by
> > > qemu_ram_alloc_*().
> > > 
> > > It leads to the assertion
> > > 
> > >   g_assert(memory_region_is_ram(mr));
> > > 
> > > in memory_region_set_ram_discard_manager() being triggered when creating
> > > RAM Block with the RAM_GUEST_MEMFD flag.
> > > 
> > > Fix this by restoring the original behavior of setting mr->ram before
> > > RAM Block allocation.
> > > 
> > > Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3330
> > > Reported-by: Farrah Chen <farrah.chen@intel.com>
> > > Fixes: 2fb627ef2f48 ("memory: Factor out common ram region initialization")
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > 
> > Thanks for the report.  This is fast..
> > 
> > Almost agreed with the fix, except that it duplicates the lines all over
> > the places.  Would it be better to introduce memory_region_init_ram()?
> 
> First sorry for breaking this, I checked that qemu_alloc_ram did not refer
> to these fields but missed this use much deeper in the call stack. The
> memory_region_init_ram name is already taken so can't call it like that.
> Since all the different memory_region_init variants call different
> qemu_ram_alloc variants there does not seem to be a way to set this without
> addining an additional line. Previous versions of the series had
> memory_region_setup_ram() that set these mr fields then qemu_alloc_ram and
> then error_propagate was called last. We could bring back
> memory_region_setup_ram but it's the same additional line everywhere so this
> seems to be a simpler fix. I don't see a way to avoid this duplication other
> than maybe changing qemu_ram_alloc to put it somehow within that but that
> does not seem to be simple. I can try to think about it some more but so far
> I could not find a simpler fix.

We can call it memory_region_init_ram_internal(), or something else.

The point is to avoid duplicating the same line all over again.. with these
call sites s/memory_region_init/$NEW_NAME/ where $NEW_NAME set ram=true.

Thanks,

-- 
Peter Xu


