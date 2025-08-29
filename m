Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14306CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNXf-0004q7-QX; Sat, 30 Aug 2025 11:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1us2jG-0000TI-RC
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 13:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1us2jD-0000s0-Qa
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 13:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756487849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NyoG+jTPiaHvw5W43Q/uXfIw3nFf8bdzhU2ft+D8mqY=;
 b=afsj4APpl139o+pePcW4Lp2r78+5uOtFUXkWRU0ZeA+Wz4glK6H1RvYOx65J0N2i3wxrfF
 JCdNNxqgrrr2CDg83AWwbkcEt+OoUsX2diqUF5j8gTr9h9cJ0iBfeMbJe1zyeuiJBHLzEz
 B5u4vfmz+K5KPaQQd3pvji0IrlO43zY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-9dnvgvd0Ma61K0DXtVQiLw-1; Fri, 29 Aug 2025 13:17:28 -0400
X-MC-Unique: 9dnvgvd0Ma61K0DXtVQiLw-1
X-Mimecast-MFC-AGG-ID: 9dnvgvd0Ma61K0DXtVQiLw_1756487847
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70deedd1deaso43116526d6.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 10:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756487847; x=1757092647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyoG+jTPiaHvw5W43Q/uXfIw3nFf8bdzhU2ft+D8mqY=;
 b=tLFcoTwlPAjyYV0Cz1KIUiOg/k824g0x9tAPENIjgRyV6mfwHdCEJr7tBdUoOA7nVI
 lnN9jy/vanwcE6vW3dFo9NO6cLjItE9eAAT8fqWwh8oo2ZEBaa16PY9Enh+zxMIOfCjK
 RphesqBnpW0mbeOCrgTnvRXrCF4JuRUWcMwEMePIcaCIByR05FxO4kDGhy2b9PR4Xnb4
 kjGrUT4vMSuZta8MrJmBuNbCyY0Oj93MRfrGfJdyFc/w172hbtYcDAU1ijnb0G53uiyq
 UNmcM6TDQsXwRsQB+S+qmH3WUFyFFOxJBYB17sFLiCIQK8jVshY73RDzerzT1A3ilS1d
 59/g==
X-Gm-Message-State: AOJu0YyTpJ4RE+18cfYcK6uLyplQjm/tnyfvmF0JEuLXXDdT4cilP1z9
 Vb6mKoToiU4T7rxVa7fwKBISxE/M+HXA4SZ4GAhjs3IZoRPZZkBzFTDB6QoO6NsbVFx4qMEehaA
 95d+k2vihv08P8X8QBy2VmMf+R46R0XihWTAD2Nmg/zjyUfI6Ya+qJwDI
X-Gm-Gg: ASbGnctNT8s1/upnwSLDveti5zz/wfI3O1O6zrQd9lplADeybiAefo26nemdYWsdY8X
 1z2IS+FrJnTOwrLB+v2GlHJUaJ5dspMGDwS2+UL1oH0K18rmS+8Y1JPZ/jyL5JTptvGxV2nxY8N
 zNB5Va2NBDwXJrShic4d1l2MOnWMXDFSfctUFwAWM967XdBhv40Jf8oLhF3gDLxtV8LjtEu28WV
 ebK8L6h4GJvgF8vTEkuYGkz1sQTHS4CkkrrrVLaij9c3D+DGY2zxHkWoEABmL0GeHHf9uM1JbY4
 4264f7W5zRoldINgMB6Xwolls7FyoI3n
X-Received: by 2002:a05:6214:ac4:b0:70f:a04f:232f with SMTP id
 6a1803df08f44-70fa0501905mr30981376d6.30.1756487847270; 
 Fri, 29 Aug 2025 10:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0isj4/pPMsT6kKTzXfXM6IHttoNCQXShvDZsX2TlebzejybwgMpPrqWj5S26kCpEInm4qBw==
X-Received: by 2002:a05:6214:ac4:b0:70f:a04f:232f with SMTP id
 6a1803df08f44-70fa0501905mr30981006d6.30.1756487846792; 
 Fri, 29 Aug 2025 10:17:26 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70e62528a9asm19362806d6.62.2025.08.29.10.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 10:17:26 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:17:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
Message-ID: <aLHgmt7vDbmWCS24@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-6-peterx@redhat.com>
 <a7f72cc7-d5ec-4a9e-a1a1-d77f376c5ce4@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7f72cc7-d5ec-4a9e-a1a1-d77f376c5ce4@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 29, 2025 at 11:29:59AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > For that, qemu_loadvm_state() and qemu_loadvm_state_main() functions need
> > to now take a "bql_held" parameter saying whether bql is held.  We could
> > use things like BQL_LOCK_GUARD(), but this patch goes with explicit
> > lockings rather than relying on bql_locked TLS variable.  In case of
> > migration, we always know whether BQL is held in different context as long
> > as we can still pass that information downwards.
> 
> Agree, but I think it's better to make new macros following same pattern, i.e.
> 
> WITH_BQL_HELD(bql_held) {
>     action();
> }
> 
> instead of
> 
> WITH_BQL_HELD(bql_held, actions());
> 
> ..
> 
> Or I'm missing something and we already have a precedent of the latter
> notation?

Nop.. it's just that when initially working on that I didn't try as hard to
achieve such pattern.  Here we need to recover the BQL status after the
block, so I didn't immediately see how autoptr would work there.

But I tried slightly harder, I think below should achieve the same pattern
but based on some for() magic.

Thanks for raising this, early comments still be welcomed or I'll go with
that.

===8<===

static inline void
with_bql_held_lock(bool bql_held, const char *file, int line)
{
    assert(bql_held == bql_locked());
    if (!bql_held) {
        bql_lock_impl(file, line);
    }
}

static inline void
with_bql_held_unlock(bool bql_held)
{
    assert(bql_locked());
    if (!bql_held) {
        bql_unlock();
    }
}

/**
 * WITH_BQL_HELD(): Run a block of code, making sure BQL is held
 * @bql_held: Whether BQL is already held
 *
 * Example use case:
 *
 * WITH_BQL_HELD(bql_held) {
 *     // BQL is guaranteed to be held within this block,
 *     // if it wasn't held, will be released when the block finishes.
 * }
 */
#define  WITH_BQL_HELD(bql_held)                                \
    for (bool _bql_once = \
             (with_bql_held_lock(bql_held, __FILE__, __LINE__), true);  \
         _bql_once;                                                     \
         _bql_once = (with_bql_held_unlock(bql_held), false))           \

static inline void
with_bql_released_unlock(bool bql_held)
{
    assert(bql_held == bql_locked());
    if (bql_held) {
        bql_unlock();
    }
}

static inline void
with_bql_released_lock(bool bql_held, const char *file, int line)
{
    assert(!bql_locked());
    if (bql_held) {
        bql_lock_impl(file, line);
    }
}

/**
 * WITH_BQL_RELEASED(): Run a task, making sure BQL is released
 * @bql_held: Whether BQL is already held
 *
 * Example use case:
 *
 * WITH_BQL_RELEASED(bql_held) {
 *     // BQL is guaranteed to be released within this block,
 *     // if it was held, will be re-taken when the block finishes.
 * }
 */
#define  WITH_BQL_RELEASED(bql_held)                                    \
    for (bool _bql_once = (with_bql_released_unlock(bql_held), true);   \
         _bql_once;                                                     \
         _bql_once =                                                    \
             (with_bql_released_lock(bql_held, __FILE__, __LINE__), false)) \

-- 
Peter Xu


