Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6B7C54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh2ZD-0002PJ-1R; Mon, 04 Mar 2024 02:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2ZA-0002OC-R7
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:16:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2Z8-0006qf-E9
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709536607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F+dTBzbN6KE6fb3XcgiKEDQEdaQMcjz+HkgpkWDdjAo=;
 b=d16KchZtG92BXe0Uc8iP2fLYlZ7m9SRph2I2YB0U4wfeEBm8Q2hdeMHwK2x7zkjHGTp75U
 uqbscUdJm8V1bgmE3bTyZfs9xO/lvgAW6QCFbD67vVRUBK0qBI34SGh8hVpVI+TlPINZ4n
 FHJSuJorc97d1f9wCCtMGOiW8URtFEQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-1SSeuVB2N0-8LHQ2NiIWZw-1; Mon, 04 Mar 2024 02:16:45 -0500
X-MC-Unique: 1SSeuVB2N0-8LHQ2NiIWZw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29a0b097af4so313423a91.1
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 23:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709536603; x=1710141403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+dTBzbN6KE6fb3XcgiKEDQEdaQMcjz+HkgpkWDdjAo=;
 b=ngJn/aHf4K7c4S6ZhCCBhbdCHxd6OE/tydw/Sz+dxWkrvTC79Wr41cOfGU2wZ9o6e9
 XfSoQWR0tMHwgdLXVq5ADXtR5bghih4fLgQ91Ii4qESd1NuIAeP4BfIZFy6Y/bKqoP6Q
 RuWjphYRvn9qH1fCsFQAWB6IL7NA8C6Vbkvn0U6YGk+C9AC24Z7ZbxdFCziUpGw3pbKq
 Ndgp2wUYVQYlB54/33I9B7o5rGiNnlA4slNCQsAoHcjijmgJuC2J0H8SwTamOr5gXl87
 VaXgS2mRD6B+xQsnTh/oomhayxxmon2Zdtro+Siei4xh6pf/5djr4Al1bYR1hFYEqABO
 Vd5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBf3W3tRhli9QVrsFwQrpilBzb6l6Eln1R6+jN7KW9JjEuSRxPWDLCuVYkWOvCHl4dJXfX9WJFXjW1bjKKZgo5hO0lyto=
X-Gm-Message-State: AOJu0YzS91+uLhvE3GpIfnpY111HtdnQvOSai2Bgi5zuD+n+iZmIdKGn
 LhGujryuaPyvrWf/RtUQet1uRvXaQlrUk7LqumMBIpI0Nf6iTY4hZD92XdKnzKHzUaoFB3siJxG
 mWB5ywlhf2m7covR5fxfTLhKpcyV0cQ/UzrZXQ3lYXqpa4yQiXswy
X-Received: by 2002:a17:90b:128a:b0:298:c3b4:f6ab with SMTP id
 fw10-20020a17090b128a00b00298c3b4f6abmr6731530pjb.2.1709536603251; 
 Sun, 03 Mar 2024 23:16:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDuT+OtVi7UTiErrZIFfMSJsOdr9yLvWV3ZBZXZifYksmXRtLz0C0fQ0HS8HJZAvbOKgTWLQ==
X-Received: by 2002:a17:90b:128a:b0:298:c3b4:f6ab with SMTP id
 fw10-20020a17090b128a00b00298c3b4f6abmr6731511pjb.2.1709536602851; 
 Sun, 03 Mar 2024 23:16:42 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 a23-20020a17090abe1700b0029b28e6ef26sm4636647pjs.11.2024.03.03.23.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:16:42 -0800 (PST)
Date: Mon, 4 Mar 2024 15:16:30 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/7] migration/multifd: Implement zero page
 transmission on the multifd thread.
Message-ID: <ZeV1TrOvERHN_LOo@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-3-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301022829.3390548-3-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

On Fri, Mar 01, 2024 at 02:28:24AM +0000, Hao Xiang wrote:
> -GlobalProperty hw_compat_8_2[] = {};
> +GlobalProperty hw_compat_8_2[] = {
> +    { "migration", "zero-page-detection", "legacy"},
> +};

I hope we can make it for 9.0, then this (and many rest places) can be kept
as-is.  Let's see..  soft-freeze is March 12th.

One thing to mention is I just sent a pull which has mapped-ram feature
merged.  You may need a rebase onto that, and hopefully mapped-ram can also
use your feature too within the same patch when you repost.

https://lore.kernel.org/all/20240229153017.2221-1-farosas@suse.de/

That rebase may or may not need much caution, I apologize for that:
mapped-ram as a feature was discussed 1+ years, so it was a plan to merge
it (actually still partly of it) into QEMU 9.0.

[...]

> +static bool multifd_zero_page(void)

multifd_zero_page_enabled()?

> +{
> +    return migrate_zero_page_detection() == ZERO_PAGE_DETECTION_MULTIFD;
> +}
> +
> +static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
> +{
> +    ram_addr_t temp;
> +
> +    if (a == b) {
> +        return;
> +    }
> +
> +    temp = pages_offset[a];
> +    pages_offset[a] = pages_offset[b];
> +    pages_offset[b] = temp;
> +}
> +
> +/**
> + * multifd_send_zero_page_check: Perform zero page detection on all pages.
> + *
> + * Sorts normal pages before zero pages in p->pages->offset and updates
> + * p->pages->normal_num.
> + *
> + * @param p A pointer to the send params.

Nit: the majority of doc style in QEMU (it seems to me) is:

  @p: pointer to @MultiFDSendParams.

> + */
> +void multifd_send_zero_page_check(MultiFDSendParams *p)

multifd_send_zero_page_detect()?

This patch used "check" on both sides, but neither of them is a pure check
to me.  For the other side, maybe multifd_recv_zero_page_process()?  As
that one applies the zero pages.

> +{
> +    MultiFDPages_t *pages = p->pages;
> +    RAMBlock *rb = pages->block;
> +    int i = 0;
> +    int j = pages->num - 1;
> +
> +    /*
> +     * QEMU older than 9.0 don't understand zero page
> +     * on multifd channel. This switch is required to
> +     * maintain backward compatibility.
> +     */

IMHO we can drop this comment; it is not accurate as the user can disable
it explicitly through the parameter, then it may not always about compatibility.

> +    if (multifd_zero_page()) {

Shouldn't this be "!multifd_zero_page_enabled()"?

> +        pages->normal_num = pages->num;
> +        return;
> +    }

The rest looks all sane.

Thanks,

-- 
Peter Xu


