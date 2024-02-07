Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AF0C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYsc-0000dD-Uh; Tue, 06 Feb 2024 22:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXYsZ-0000bB-No
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXYsY-0003Qs-3G
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707277541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10WPJzYn5/eUUntVib/3AKY0p9kCf8lEtu2n2Gaj/sA=;
 b=WTClVuVs+0QtMeF6ifuWuhPEAjOWLt3yDJxnpxoSkRuP04nkoJ9+i5Lly0eusJg0r+2hOD
 JNLlXw5DsVttpZoiqPPwXR1z3uf11W+XlJVBl4k9ltFzo8woWP7ZQb6IZnVv0aqEMVo1wX
 6tcE3RAUgajlP6Sk2XK0nygQ1iaKoSM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-N4dDmO8_ODy8bQPutEvMtw-1; Tue, 06 Feb 2024 22:44:59 -0500
X-MC-Unique: N4dDmO8_ODy8bQPutEvMtw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so48694a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707277498; x=1707882298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10WPJzYn5/eUUntVib/3AKY0p9kCf8lEtu2n2Gaj/sA=;
 b=dqm1eAnSU5HwaU/5LZwJRQxEGUjU3e/H4CpTOLCJ2lTKfVlr2JYanpNo4omzq5B2fe
 VLpeXRBVnWYiSNzR4YfIXtjWBS62ssFSsIWgPcsTwhLXKaK6n/51PF/UAlgImofnyGMc
 tM5t8jW5HkR/KgBayvZzVgcwCN9wQ0G6H1KvN5lLWJpObzHaRYTwDYBJvLbjpF/w+euq
 8Lrtxm+BzBpjpICnt0Od8lyxOQTNAyZZ24IUianfEDSjGXv2UZemrBQXvI72rFP7yCV7
 4zgl4mB5Irfi/baTbd7/cCJ1qC9L/+5Vbrmlsk5kM0DgbW3UZPEOFgFZvfBg+I4KdocU
 gkbQ==
X-Gm-Message-State: AOJu0YybW7iIvR0aeJv5rQrN8dTpap+FPHR4mvy+L1UHiiZd4OmnU0x+
 +VbHwUyKTo18YKuwfgTh01hLY5AefkAKJrekifL+MiCmMcboWHFBzRgyzJmJwZHGcVA8VRYWOot
 7M+oCGd5/f/KK2rNj/PO5qAQ9FYpWX0MhZuWtAM2w78XR35SQH6jv
X-Received: by 2002:a17:902:ed0a:b0:1d9:ce37:414 with SMTP id
 b10-20020a170902ed0a00b001d9ce370414mr5024411pld.2.1707277498475; 
 Tue, 06 Feb 2024 19:44:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMwymV97qVTri7jSRv6nEBY6WoUU3PKmVrEM91Z1MCKD85+0ZAmCU9p9aj/8Xc/Y1hUXASBg==
X-Received: by 2002:a17:902:ed0a:b0:1d9:ce37:414 with SMTP id
 b10-20020a170902ed0a00b001d9ce370414mr5024392pld.2.1707277498148; 
 Tue, 06 Feb 2024 19:44:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVLnFIPRaWRK3nN8FuyW6ZqSgdCPxtDfH7EjPMi7GybaTqNyl6l+c0IjQxtPuRLCYXZpu0TYkskGlUjSiv3a9s=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 mn7-20020a1709030a4700b001d9ce370415sm310609plb.90.2024.02.06.19.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 19:44:57 -0800 (PST)
Date: Wed, 7 Feb 2024 11:44:52 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 1/6] migration/multifd: Add new migration option
 multifd-zero-page.
Message-ID: <ZcL8tLF7tmD0JpVV@x1n>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-2-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206231908.1792529-2-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 06, 2024 at 11:19:03PM +0000, Hao Xiang wrote:
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 819708321d..ff033a0344 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -874,6 +874,11 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @multifd-zero-page: Multifd zero page checking. If the parameter is true,
> +#     zero page checking is done on the multifd sender thread. If the parameter
> +#     is false, zero page checking is done on the migration main thread. Default
> +#     is set to true. (Since 9.0)

I replied somewhere before on this, but I can try again..

Do you think it'll be better to introduce a generic parameter for zero page
detection?

  - "none" if disabled,
  - "legacy" for main thread,
  - "multifd" for multifd (software-based).

A string could work, but maybe cleaner to introduce
@MigrationZeroPageDetector enum?

When you add more, you can keep extending that with the single field
("multifd-dsa", etc.).

-- 
Peter Xu


