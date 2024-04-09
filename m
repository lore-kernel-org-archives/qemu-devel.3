Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E19C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruA5b-000731-Ql; Tue, 09 Apr 2024 07:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruA5Z-00072i-P1
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruA5X-0005sO-W5
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712663790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u2WSL8gcFM2MIVeq6BXRBnkCHQgPHTFhGO6Q5dWxaaU=;
 b=a7TDqwL+7ghQWSOhXkqgeSmgeoPoooxpJKRUU8LzfeF4tSoZyRegF6dV6LaCRgDbmW8q9b
 +uRVJQceDrLS3UxtBXZhvE51EsdWxDewDAZeB+cQl7LaFf87hjifOUGfgIwcRc9h6uiwy/
 c4/HtWHynYIfS3gCLWh3XdB/IRckiaw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-sFChTiexOC21sf-MtPw7Xw-1; Tue, 09 Apr 2024 07:56:28 -0400
X-MC-Unique: sFChTiexOC21sf-MtPw7Xw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6dea8b7e74aso1907051a34.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 04:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712663787; x=1713268587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2WSL8gcFM2MIVeq6BXRBnkCHQgPHTFhGO6Q5dWxaaU=;
 b=ReIfMVq46kUe8Dwwrc3uo91AZ3dMJEAKtTMy7qZTJxXm8oUzyJoNawCA8X0BPa6yiB
 THFXF9a7F2KS8NXXST/uh7sptwRQ3Iy3ugKMtP6FjwWOGyV24s4gzEQemQDeCYM8eq+V
 7EwGMGlajK0fDySfXoxiEtxgZeJFBDy1FC3E/R0s4ZbDmFdtzk/CEeXCRDRI+rkuKouB
 KLktrCkn838NROmY9KPNtHjO3mQKCyKLxib1qBOoqEq8GvgkaMQdRGbiIfXgORuPaFtE
 yW/tW/Tv0RDIPbFrI7SkoqlKxZ9XOTTietiHu5NLjIf2yPCCrVvTslZIG2af/GlzioRV
 ft6g==
X-Gm-Message-State: AOJu0YyuMysAQVA6hZPAX33Lrpeuu/n17yPsmsXx7+5IRRNeYRvmRQ3L
 E84+rNb4o7HnBXDZ0E9mM8bW4y/NrlfUyBZCCa2kWKcIe5PxO37CDl60XI2jY8BnIzSnh2K6PfN
 K+bb7ylJjwdoArRwHQeyvkbfcDqf4eXjZPHWsB8/6xQjtm591iv0q
X-Received: by 2002:a05:6808:2385:b0:3c5:dc47:99e9 with SMTP id
 bp5-20020a056808238500b003c5dc4799e9mr12642107oib.5.1712663787559; 
 Tue, 09 Apr 2024 04:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzMRX697NCu7GIHi6UPsmnLVYrO+la7hWsMICgUP9oAoxGlh3BWJO0ZBr66xmNGBYMeux2HQ==
X-Received: by 2002:a05:6808:2385:b0:3c5:dc47:99e9 with SMTP id
 bp5-20020a056808238500b003c5dc4799e9mr12642085oib.5.1712663787053; 
 Tue, 09 Apr 2024 04:56:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 du47-20020a05620a47ef00b0078bc4cad726sm4040554qkb.72.2024.04.09.04.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 04:56:26 -0700 (PDT)
Date: Tue, 9 Apr 2024 07:56:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com
Subject: Re: [PATCH v2 0/3] qtest/migration: Fixes around
 multifd_tcp_channels_none migration qtest
Message-ID: <ZhUs6DBA5dG5MvHk@x1n>
References: <20240409110011.174426-1-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409110011.174426-1-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 09, 2024 at 11:00:08AM +0000, Het Gala wrote:
> With the introduction of new patchset to have 'channels' as the start
> argument of migrate QAPIs instead of 'uri' (tests/qtest/migration: Add
> tests for introducing 'channels' argument in migrate QAPIs), a few minor
> issues got went unnoticed, which were caught while trying to introduce
> similar qtests in migration-test.c
> Fix multifd_tcp_channels_none qtest to actually utilize 'channels' arg
> in migrate QAPIs, fix double freeing of addr Qdict and typos in that
> patchset.
> 
> This patchset is built on top of (tests/qtest/migration: Add tests for
> introducing 'channels' argument in migrate QAPIs) 
> 
> Can find the build pipeline at : https://gitlab.com/galahet/Qemu/-/pipelines/1245462266
> 
> v1 --> v2:
> ---------
> 1. Split the second patch into different patches - One to deal with double
>    freeing of Qdict and other to add connect_channels inside
>    multifd_tcp_channels_none to actually use 'channels' arg.
> 2. use 'git commit --fixup' to improve commit message as well as
>    to inform on which commit is the fix meant to be.
> 
> Het Gala (3):
>   fixup! tests/qtest/migration: Add negative tests to validate migration
>     QAPIs
>   fixup! tests/qtest/migration: Add migrate_set_ports into migrate_qmp
>     to update migration port value
>   fixup! tests/qtest/migration: Add multifd_tcp_plain test using list of
>     channels instead of uri

queued, thanks.

-- 
Peter Xu


