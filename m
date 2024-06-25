Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CBFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 08:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM1Qv-0002aY-7x; Tue, 25 Jun 2024 04:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sM1Qt-0002aO-Ot
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 04:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sM1Qs-0003wY-3d
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 04:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719303700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y0HTCcy6NLhXrOP8IELgMPu62J47QRpcUSUqlwV9PVg=;
 b=Z2YGRqppB3SAKtezIXkGTmY2DCVhTgjavfQQQ+vET7LBO9lqE1cp/XebJsGrPrjKhcdzun
 lBVXYf9KzalwpqdmeedsRNzlkWZc+nrwQD17WPv5BqXmV7F/kuefvmM+vo4W/jemTk3NHY
 yuaapm8/Joikp6LxD9TKztwouSIQzek=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-eJIdzqq-M-e9xYnSItyu6Q-1; Tue, 25 Jun 2024 04:21:38 -0400
X-MC-Unique: eJIdzqq-M-e9xYnSItyu6Q-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-797d167a402so762589085a.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 01:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719303697; x=1719908497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0HTCcy6NLhXrOP8IELgMPu62J47QRpcUSUqlwV9PVg=;
 b=EgR5V1qWDoEwrCzGhNQNu2pUrcu7/QtA4S2sj/uI7wAITgFD67hgSfQhTQwwJEZQ4F
 BV8qxgJaL6olgKZv12KGBcTlHW09Ytq9JhbtjetqgsvVTUxcix4y0bqKdf0LqitFLxWq
 Y+me5wrXS3OyBWFOuDQ8cNZQ9JPdjE/PCPbccF4YiNlc2eBlZJ0fFv34f35qKTTtbyXe
 UQP7VwktkK0gQINlCqoxh+17VBKIuzkz4Hz5tRr3blXfNOz963KWQlT63jrLtwfjacCV
 RYmSYpoAjVfhqH2alD4HxXGKB9nX6sQf6AEdm+7Nls6qyo1ePpebR+E+qazVll0ymUHV
 j/Qg==
X-Gm-Message-State: AOJu0YxJzgFy7I5bU9LuauKbfQ5M3Vu3ZmiSlBZu8DN7EYsPOpNkPP1L
 sksIL1ZnW+6pmmQq8FUbfWorLt/7ZhrYNHMu+YWwNWi0gWDPZqHbdFm3Oqi1SjNiLTi+4YIP6HE
 jhXlumEevVTGym/4z6+bImPfYqONCIUiS/yYAlEr6kvyZ2bBgJUiwje6TvIpkAJbBJNDbZ420UB
 12tNCvxEUDba6H3PAiF5YKSxQUkxNRXDowaNSx
X-Received: by 2002:a05:620a:4148:b0:797:92c:24df with SMTP id
 af79cd13be357-79be6f23e0fmr792704685a.69.1719303697443; 
 Tue, 25 Jun 2024 01:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPRN5fdyi2421Xm6gWwfbr5AA2jJ02sVXQ2Mbq6yox9bTFfEr42RV81NBRsIyqfLGu/rj0Dg==
X-Received: by 2002:a05:620a:4148:b0:797:92c:24df with SMTP id
 af79cd13be357-79be6f23e0fmr792701785a.69.1719303696862; 
 Tue, 25 Jun 2024 01:21:36 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.151.252])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bf657c4a2sm130696985a.36.2024.06.25.01.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 01:21:36 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:21:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi/qom: make some QOM properties depend on the build
 settings
Message-ID: <qtwn6peo5d27lfqx7ufae5cs6dk34kcmd72ylsjdtdqiwmwtw4@sxur6nvu2f6h>
References: <20240604135931.311709-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240604135931.311709-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

Gentle ping :-)

On Tue, Jun 04, 2024 at 03:59:31PM GMT, Stefano Garzarella wrote:
>Some QOM properties are associated with ObjectTypes that already
>depend on CONFIG_* switches. So to avoid generating dead code,
>let's also make the definition of those properties dependent on
>the corresponding CONFIG_*.
>
>Suggested-by: Markus Armbruster <armbru@redhat.com>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> qapi/qom.json | 21 ++++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)
>
>diff --git a/qapi/qom.json b/qapi/qom.json
>index 38dde6d785..ae93313a60 100644
>--- a/qapi/qom.json
>+++ b/qapi/qom.json
>@@ -222,7 +222,8 @@
> ##
> { 'struct': 'CanHostSocketcanProperties',
>   'data': { 'if': 'str',
>-            'canbus': 'str' } }
>+            'canbus': 'str' },
>+  'if': 'CONFIG_LINUX' }
>
> ##
> # @ColoCompareProperties:
>@@ -305,7 +306,8 @@
> ##
> { 'struct': 'CryptodevVhostUserProperties',
>   'base': 'CryptodevBackendProperties',
>-  'data': { 'chardev': 'str' } }
>+  'data': { 'chardev': 'str' },
>+  'if': 'CONFIG_VHOST_CRYPTO' }
>
> ##
> # @DBusVMStateProperties:
>@@ -514,7 +516,8 @@
>   'data': { 'evdev': 'str',
>             '*grab_all': 'bool',
>             '*repeat': 'bool',
>-            '*grab-toggle': 'GrabToggleKeys' } }
>+            '*grab-toggle': 'GrabToggleKeys' },
>+  'if': 'CONFIG_LINUX' }
>
> ##
> # @EventLoopBaseProperties:
>@@ -719,7 +722,8 @@
>   'base': 'MemoryBackendProperties',
>   'data': { '*hugetlb': 'bool',
>             '*hugetlbsize': 'size',
>-            '*seal': 'bool' } }
>+            '*seal': 'bool' },
>+  'if': 'CONFIG_LINUX' }
>
> ##
> # @MemoryBackendEpcProperties:
>@@ -736,7 +740,8 @@
> ##
> { 'struct': 'MemoryBackendEpcProperties',
>   'base': 'MemoryBackendProperties',
>-  'data': {} }
>+  'data': {},
>+  'if': 'CONFIG_LINUX' }
>
> ##
> # @PrManagerHelperProperties:
>@@ -749,7 +754,8 @@
> # Since: 2.11
> ##
> { 'struct': 'PrManagerHelperProperties',
>-  'data': { 'path': 'str' } }
>+  'data': { 'path': 'str' },
>+  'if': 'CONFIG_LINUX' }
>
> ##
> # @QtestProperties:
>@@ -872,7 +878,8 @@
> ##
> { 'struct': 'RngRandomProperties',
>   'base': 'RngProperties',
>-  'data': { '*filename': 'str' } }
>+  'data': { '*filename': 'str' },
>+  'if': 'CONFIG_POSIX' }
>
> ##
> # @SevGuestProperties:
>-- 
>2.45.1
>


