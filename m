Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B407C47258
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 03:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTCcu-0006rG-Ie; Thu, 25 Jan 2024 22:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTCcr-0006nK-RJ
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 22:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTCcq-0004DT-F2
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 22:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706238687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/dXp5xz/KpykZsK1iV5BpbfoB+V6j50+VnbJ/tTBM2s=;
 b=DvuswWDWvPTqW2Nv0kA+vrEkdY2eGpIOcCZRF71gerUaZCrLCCBXXHU6eubB5ktjl3Cq0i
 uH2aV2ChxsTcwzPODqys+KdCbc+ZBHBW4CmBqT8d0n/djglwdZtzMInN6sCh/wKZNWHqxj
 44Vil8PWJg2V+bBOCoOAyIelf7cQ76k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-rMAKJS7lPqajCT87O6-_tw-1; Thu, 25 Jan 2024 22:11:25 -0500
X-MC-Unique: rMAKJS7lPqajCT87O6-_tw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2906fff7838so1087587a91.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 19:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706238684; x=1706843484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dXp5xz/KpykZsK1iV5BpbfoB+V6j50+VnbJ/tTBM2s=;
 b=QTdZu+POfvzXtkg3noxCvG9rh5TvgKRDAB/rQxjsAZK2Zyn3QbEQGL4Dx9mIMAWKxA
 BAp505qUWWOYqGbHmRxSb0KiF9NYfBXySYG0Xvz6cQQVdhV94B8X3fWDQ/aUYUMXBZ1V
 RTyJsJ0tVaV1TC5U9rsGhhuS4zj/bpCvOrIf7HH9wnA0x2hziB+t3T+LtcWm6YTsnwto
 8yc3WfSF90WSMuBsUVNvo5o5NJFNwjjyoUnpeInSLgB7Ie43X+S8FmAi0MkII4Vre6MK
 Zm2gJEN1LR2HKwm3n5RUBNRtdt8sOlxu9mVYeyPvWDtLvNUtr4lAydIIxm1GOWevvRSc
 a7Vw==
X-Gm-Message-State: AOJu0YyicpRP9/MPWYWX/hcs/Pej2tL2ekAHy5MRZrIqy1gSgFRR0mRM
 ITBH9ooW0VePGZrbKIjPjq4xrZmVXqgdYOUkYSk9Otfn0QmcOGQBI2qlxwiMEiZNF6PRQqthz9p
 VODwDb1HjW6xgVzHMmuLWKnEOWhi/Eu0817A9iSrr3SNgrHXhaZ/0
X-Received: by 2002:a17:90b:b01:b0:290:239b:8f8e with SMTP id
 bf1-20020a17090b0b0100b00290239b8f8emr1093845pjb.4.1706238684709; 
 Thu, 25 Jan 2024 19:11:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq5Sn+mRm6q+2iX9QCV7Oda04x5Dj5n/haeVKW0g7twwkTt7cLeXFrQqyK05n6rryJFJazHw==
X-Received: by 2002:a17:90b:b01:b0:290:239b:8f8e with SMTP id
 bf1-20020a17090b0b0100b00290239b8f8emr1093838pjb.4.1706238684424; 
 Thu, 25 Jan 2024 19:11:24 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001d752c4f180sm204742plb.94.2024.01.25.19.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 19:11:24 -0800 (PST)
Date: Fri, 26 Jan 2024 11:11:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 03/17] migration: Rename default_channel to main_channel
Message-ID: <ZbMi2f6spX29jJ_8@x1n>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-4-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125162528.7552-4-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 25, 2024 at 06:25:14PM +0200, Avihai Horon wrote:
> migration_ioc_process_incoming() uses the term "default_channel" to
> describe the main migration channel. Rename it to the more commonly used
> and informative term "main_channel".
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


