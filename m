Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC447C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79WD-0003sl-JH; Wed, 15 May 2024 03:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s79W1-0003PM-9B
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s79Vy-0004ll-TO
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715759849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJ60EhLSwaQyzcfeTGtD1Tj7k8Uo36YCURMWdDb65f4=;
 b=DNJOshsOHjOUP670323z8Fa3IMe8XZWZCvZ4H9WT6aAp4zIBBnZSsDh+cJn1MKclhS7MXO
 cDHSuVltBSpQ1zNm3fIJCIwgGdFjGoh/qDFqbPNZZf4NXENfXkW19N8a/i/AZMrl42O3bt
 FtSzelehKSUY5DUTZdyYBo67cEMKe44=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-X_gz7i69OrGYDF7rZDyxwQ-1; Wed, 15 May 2024 03:57:28 -0400
X-MC-Unique: X_gz7i69OrGYDF7rZDyxwQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34e0836d91eso4037679f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759846; x=1716364646;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJ60EhLSwaQyzcfeTGtD1Tj7k8Uo36YCURMWdDb65f4=;
 b=Oh73RmpfWKKTHKyj34XcKPtlHeZBbzSL5rLymSgphrEW5zL8YQqLu2GhUl8gDYi2+k
 kpiy/n/s1mO8qWdXxNQ7nwWxvF49K55peDTlE6RKCydFNdqlVs6S/rAHE8QEO4I891Nu
 JubkxvLlGUI26vOsu4TeEgg2td3qa2cNbEGycOUJc+7dLYC++CiTFelD6A9znnxUUNWT
 A/inYRisiW+6EiUV8TBqugZIeNllC2BXXp91/SSiMcmFn3/knkaebX0NwHHNKC5z+xpo
 Ngak7986FDsMMOXQ7+RSxAeeEA2ZcTNV1TijR9mJ/GvhPnu6zK8Uz1p+LoH3V/kDo23h
 xgng==
X-Gm-Message-State: AOJu0YxAlsKjy71wA0DrvBW/jZn4rh0YxS5Dynk7Qwn3M4TbcSmh+df6
 Z8Y2Z9DzWU1jncUQYtBxqf9S94tAMpwsCsfPxpd54Iqv4s20wnj2F5bkTvhXhv+EB6MjwdQBg9G
 +KjmDRDUTdnrxXs4FQ+CdXiFtijBiGLwXiBgwp/d3/mZ4R3224Sy67H+PQ8M3
X-Received: by 2002:a05:6000:150:b0:34a:a754:eb48 with SMTP id
 ffacd0b85a97d-3504a969261mr10747585f8f.48.1715759846385; 
 Wed, 15 May 2024 00:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/OfQLAdvWz1e0HWE7uyBfZ+1t6ImDBoKXBvCWWHHPuR4RIeOdQkVf0y7uNuFslQHG2A54pQ==
X-Received: by 2002:a05:6000:150:b0:34a:a754:eb48 with SMTP id
 ffacd0b85a97d-3504a969261mr10747567f8f.48.1715759845861; 
 Wed, 15 May 2024 00:57:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacf47sm15687506f8f.78.2024.05.15.00.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:57:25 -0700 (PDT)
Date: Wed, 15 May 2024 03:57:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH 00/11] maintainer updates (plugins, testing) pre-PR
Message-ID: <20240515035713-mutt-send-email-mst@kernel.org>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514174253.694591-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 14, 2024 at 06:42:42PM +0100, Alex Bennée wrote:
> This is mostly plugin related stuff which is all ready to go however
> I have a few miscellaneous testing updates which would appreciate the
> review.


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Thanks.
> 
> Alex Bennée (2):
>   tests/tcg: don't append QEMU_OPTS for armv6m-undef test
>   scripts/update-linux-header.sh: be more src tree friendly
> 
> Pierrick Bouvier (9):
>   plugins: prepare introduction of new inline ops
>   plugins: extract generate ptr for qemu_plugin_u64
>   plugins: add new inline op STORE_U64
>   tests/plugin/inline: add test for STORE_U64 inline op
>   plugins: conditional callbacks
>   tests/plugin/inline: add test for conditional callback
>   plugins: distinct types for callbacks
>   plugins: extract cpu_index generate
>   plugins: remove op from qemu_plugin_inline_cb
> 
>  include/qemu/plugin.h                 |  42 +++++---
>  include/qemu/qemu-plugin.h            |  80 ++++++++++++++-
>  plugins/plugin.h                      |  12 ++-
>  accel/tcg/plugin-gen.c                | 136 ++++++++++++++++++++------
>  plugins/api.c                         |  39 ++++++++
>  plugins/core.c                        | 109 +++++++++++++++------
>  tests/plugin/inline.c                 | 130 ++++++++++++++++++++++--
>  plugins/qemu-plugins.symbols          |   2 +
>  scripts/update-linux-headers.sh       |  80 +++++++--------
>  tests/tcg/arm/Makefile.softmmu-target |   2 +-
>  10 files changed, 508 insertions(+), 124 deletions(-)
> 
> -- 
> 2.39.2


