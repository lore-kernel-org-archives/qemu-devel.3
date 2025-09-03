Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCF8CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 04:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utejW-0004NF-42; Wed, 03 Sep 2025 00:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utejU-0004Mz-6O
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 00:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utejS-0003kE-Ad
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 00:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756872264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/RGguBZujshRv4/1HlbGnI1P1+l6b1rs0uEz1K/fv8=;
 b=gd+VODrhHBDoSKhSFU3e3ewiFlOCB2z3/XEPZYgecqjzhPeaveZ6Hgv6sLsTrZQQX9HQP/
 +5mNWbVHcUlohhEkuA1BsCIL/qmBwvZ6tTcEFrQ3oX1DUTyJJE+Yr0+/ikfCcJu+SxNEJ6
 WVGv5A0PUtbF9Yo0ClSyRAjk447uWRQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-77bCP_S-MciwTTdRC76oCg-1; Wed, 03 Sep 2025 00:04:18 -0400
X-MC-Unique: 77bCP_S-MciwTTdRC76oCg-1
X-Mimecast-MFC-AGG-ID: 77bCP_S-MciwTTdRC76oCg_1756872258
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-329dca88b5aso692732a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 21:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756872257; x=1757477057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/RGguBZujshRv4/1HlbGnI1P1+l6b1rs0uEz1K/fv8=;
 b=SG42mDcReblG6DHWBIB6dXBZnQdwxkqCibi2kUYupqoqvCddt+4qoi61fSN3h0xD1y
 Gb/Oj6HwUvQ+qttdOEm+7ndvX8yez3b+RwJP4RsYrRSUD/8gerZlT40QgQH7q1zOPDYM
 UFln83e98RvJ/W/K90JJKnL1kXSgAziriCw1+Fr+94qGIrjs7pq3uVLvRTX4+gJMmTin
 sU/Okxgd8WQAKIR7/z9Fh4D3d1A0SAd0V4nD+RzpGuSF0LY4JtQhleEiq9b6r47OXzU9
 /tgcdAR7z4QKBitic8fZ0xNBoP0wSIX0JQmD+BHblDG/yncnio6IP43WNw2/KnfqSqQG
 2mdQ==
X-Gm-Message-State: AOJu0YzfpBZavJzRcx2NecwzHtkX6C7EEpKoUXj8ezw8ZeTe4USaEbZ9
 O3W1H8axk/KmhGgqTWmHtP3kHnQ4Q5hAM8DNrXwCjWpi1KzCFlCaGYm3t/MUuwiVe04W7+SpUP1
 CkI2xMjNMhonrou8mB6AbBZJTRKD1GD+ApxlusCYCLTKgZN2dG2ZaCOL0K5ZgLw3Q1uPA153Tw8
 +MbFhrMgEZJ4sSGE91LuxgfSqaEVrqk74Ouas0UXdl/A==
X-Gm-Gg: ASbGncs504KxcWT3tR5rWORZIw9uyjLrOZv3nolqs7Fc/Vmq3AxjZ0ZC9XW5BgZnA+F
 pi9s52412ywU19JkXej1wrkGgvx6PkDkY6fdhKKOAlEug9QcE8n55C3OWrrHWmmF7rTjF6kH29c
 +8r2cklg2520x1CO67m8KOgg==
X-Received: by 2002:a17:90a:d44c:b0:329:e9da:35e0 with SMTP id
 98e67ed59e1d1-329e9da389emr4399748a91.11.1756872257185; 
 Tue, 02 Sep 2025 21:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2RyTjPBVcA7cDS/cmaTvKAPK9VMyrnxW51oKGHxL0s6z1lD/FyE7Ki81MqGdMSZsvOLLnULyOya0K0y2S5jc=
X-Received: by 2002:a17:90a:d44c:b0:329:e9da:35e0 with SMTP id
 98e67ed59e1d1-329e9da389emr4399721a91.11.1756872256749; Tue, 02 Sep 2025
 21:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-2-vsementsov@yandex-team.ru>
In-Reply-To: <20250823160323.20811-2-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 12:04:05 +0800
X-Gm-Features: Ac12FXycpuXEG4trI_nhS8SlFkGMExhXJ3ZKn-PSL_IEemxDil7AROgwIjYOfmI
Message-ID: <CACGkMEt0Dr0VZke58_93Cfqskrw3E2YuJDJC7d9bg+qjAqabRA@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] net/tap: net_init_tap_one(): add return value
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Sun, Aug 24, 2025 at 12:03=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> To avoid error propagation, let's follow common recommendation to
> use return value together with errp.

It would be better to have some words or links to explain why we need
to avoid error propagation.

>
> Probably, it would also be good to use bool as a return type
> (switching to true/false as success/failure instead of 0/-1). But
> seems almost all functions (including a lot of them with errp
> argument) have 0/-1 semantics in net/, so making exclusions doesn't
> seem good. If we want such a switch, we should update the whole
> net/ directory.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---

Thanks


