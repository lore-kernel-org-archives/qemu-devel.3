Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29521C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgss0-0002Qm-Cl; Wed, 21 Aug 2024 17:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgsry-0002PX-75
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgsrv-0004k3-Ub
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724275670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0XoidRhsi54jzQiDQqbh17TwInqjyPKu/oFfVEqgQJg=;
 b=WbDG59hl9Byh89rPuMkWPb8hGLiUULrq60ComypkqVvg/g3nR3QAgg9VU+uFmkTS1YhxcF
 fJo0YMSlC1mXVtIvDGY/WjdAKLto56PE0RrpF0qi8h+31BXn73x6M6Co0MXnrZsbjG15I5
 sli9VJI8MrE6PPz+JJUzOZ3wO69yyck=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-2NYZaq_SN1ihD4CYwh9FjQ-1; Wed, 21 Aug 2024 17:27:48 -0400
X-MC-Unique: 2NYZaq_SN1ihD4CYwh9FjQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e166ac5178eso363953276.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 14:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724275668; x=1724880468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XoidRhsi54jzQiDQqbh17TwInqjyPKu/oFfVEqgQJg=;
 b=YoJb5fsvUfITQgiAt/HC81eLaBNjbJxc1NdcclGfYcYR0xQDdvPmeL+CguYqc+R4cB
 5jy6qzDY0TbpJ9SVk0GF6xNknnRl5kY8fs7I2I1HAnaviFaRyRXojaRzLK6j76Dlc2nM
 CTXIS0zJGdypbROTB5ELOIDZP6CzayucB9CWytmGbYwhu0Y90iQA2yizL6b2TlT25c19
 n5UEyQt6TsJZ41NReVj/NJfZ+yERRtGU/ti7LeJJO18276nfSYQN7BjdyyzQ/HnLG8kp
 NdApyUUE78IODg9g+J4y1vrFuNLSArU4E5HEBrboIfIOusCGpAJficDplKTkfPGO0ku1
 Uo5w==
X-Gm-Message-State: AOJu0YwXYtu0A/8dSKCvKfFuRtm9XEIlHhUdZuC9O9WXNUl7lTYprm/W
 elegPZNWFlXRxrr2lNoCP2/C0RYPkb4hMURF6ypOis4f6hZjdEkYQkqd7OauChqucQ+y0TEGm/H
 EPEcknfs8SmySw/nY9uOOiT6d8d+3R0QBHfnXuykt6Ms80ig+5QWS
X-Received: by 2002:a05:6902:2506:b0:e13:e8f9:1251 with SMTP id
 3f1490d57ef6-e16654956e6mr3990258276.30.1724275667958; 
 Wed, 21 Aug 2024 14:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4xqoeKhnynes/6sCDjLePJHDO0T40KmvZC4Ay37LafPx81uv+SpLdaHWVp0wOInerM3Twtw==
X-Received: by 2002:a05:6902:2506:b0:e13:e8f9:1251 with SMTP id
 3f1490d57ef6-e16654956e6mr3990239276.30.1724275667545; 
 Wed, 21 Aug 2024 14:27:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d76850sm971116d6.72.2024.08.21.14.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:27:47 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:27:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 07/14] migration/multifd: Replace p->pages with an
 union pointer
Message-ID: <ZsZb0JTNn8P-KQAu@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 09:35:09AM -0300, Fabiano Rosas wrote:
> We want multifd to be able to handle more types of data than just ram
> pages. To start decoupling multifd from pages, replace p->pages
> (MultiFDPages_t) with the new type MultiFDSendData that hides the
> client payload inside an union.
> 
> The general idea here is to isolate functions that *need* to handle
> MultiFDPages_t and move them in the future to multifd-ram.c, while
> multifd.c will stay with only the core functions that handle
> MultiFDSendData/MultiFDRecvData.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

[...]

> +static MultiFDSendData *multifd_send_data_alloc(void)
> +{
> +    size_t max_payload_size, size_minus_payload;
> +
> +    /*
> +     * MultiFDPages_t has a flexible array at the end, account for it
> +     * when allocating MultiFDSendData. Use max() in case other types
> +     * added to the union in the future are larger than
> +     * (MultiFDPages_t + flex array).
> +     */
> +    max_payload_size = MAX(multifd_ram_payload_size(), sizeof(MultiFDPayload));
> +
> +    /*
> +     * Account for any holes the compiler might insert. We can't pack
> +     * the structure because that misaligns the members and triggers
> +     * Waddress-of-packed-member.
> +     */
> +    size_minus_payload = sizeof(MultiFDSendData) - sizeof(MultiFDPayload);
> +
> +    return g_malloc0(size_minus_payload + max_payload_size);
> +}

Hmm I didn't notice the hole issue for sure..

For the mid term we really should remove this in one way or another.. what
I was thinking is mentioned in the other thread:

https://lore.kernel.org/qemu-devel/ZsZZFwws5tlOMmZk@x1n/

I hope we can simply statically define offset[] to be the max.

I don't think we must stick with size-per-packet, in this case IMHO we
should choose whatever is easier for us, and I never worried on regression
yet so far as long as the relevant n_pages is still relatively large. Not
to mention AFAIU for production use, x86/s390 always uses 4K psize, while
arm64 doesn't yet have a stable kvm-avail vcpu model, which might be a
bigger issue as of now to solve..

Let's see how it goes..

-- 
Peter Xu


