Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6F8C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sic23-0003uT-L6; Mon, 26 Aug 2024 11:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sic21-0003tk-Dp
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sic1z-0006ZS-Rb
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724687602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TzDeVRsHP7HGHT5TYXiLRnIC8N/inVW3FZ6ky1MYjlA=;
 b=jJHx6qHjOxyUr1nhFc1GQ2CjkpMpfhH+uw/SMEYlFhdlyT5yk3XkCffhG5xCtv6w2TKXJ5
 ALCY23bxr8RvpNoe72AMeXHPrFYMgvg497Q6JOs541S2qrZoAxx4dy39fCMDRwemYzdfU9
 l4iN5cDnMsX71zUVAVIuO5KXMIQ4OZw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-3cy8Bjp-PxyyQJ5KSMhTrg-1; Mon, 26 Aug 2024 11:53:20 -0400
X-MC-Unique: 3cy8Bjp-PxyyQJ5KSMhTrg-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5d5ffdc9ed9so7106866eaf.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724687600; x=1725292400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzDeVRsHP7HGHT5TYXiLRnIC8N/inVW3FZ6ky1MYjlA=;
 b=D+njhee94KDUXhhYvitHb4ensR5u1C6+PLgaRLol7LBjZ2inx/qG79rWpFmmK+VFBK
 Vd/sQ9VeibV8tj536ckruKga2NgVv30z/NAmz1Ir3izwi1W5eRIOS3TWHSIpqg06H3yu
 lCAKq6QLqNwDUzHXATwqI/OQpJszkRrE4Z3O71RJ6QBDAknD9cKf3UJn7NlcHqoxcsYT
 2xB+tIS79lF5DsnBk8USuWN5sNiSHOKvnH49JnytTL6YcTJ+dteis++xprZrKZEin7gY
 VLl3BQ709VQkToN1UktRz/2Ul9oxPuSrgJDnqJjn1NzccYnrPgplT1RzjWXKhWicDIgj
 TXog==
X-Gm-Message-State: AOJu0YxzCq99EXdrl9I48KWmdgZR/3pybPOVEF/uXQwLZMncC7wHOIig
 9+7tA7cAIQYMcvQvXqyrHu/92Xmg/a+DGmBToBN4uCqbIycocXtSLnbfr6rIyP/fij5Rlyh03jL
 c/HcCZQEpF9keYfAUZUvvGg/6HPGs60gfWDANlg0xnxTac2eG6dUXFv/zJ6n9Rs0=
X-Received: by 2002:a05:6820:824:b0:5da:9bde:1c0b with SMTP id
 006d021491bc7-5dcc5d53986mr11671604eaf.0.1724687599807; 
 Mon, 26 Aug 2024 08:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZSN5mqnrKFXo3mjN6/KWysMGnnX/IRh9d324KlKsHgp5NGriMWg3htXNotL8Iy3mWXqHceg==
X-Received: by 2002:a05:6820:824:b0:5da:9bde:1c0b with SMTP id
 006d021491bc7-5dcc5d53986mr11671599eaf.0.1724687599533; 
 Mon, 26 Aug 2024 08:53:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162de7ffesm47291186d6.143.2024.08.26.08.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:53:19 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:53:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 09/16] migration/multifd: Remove total pages tracing
Message-ID: <Zsyk7ZkSSqV2ilvJ@x1n>
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823173911.6712-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Aug 23, 2024 at 02:39:04PM -0300, Fabiano Rosas wrote:
> The total_normal_pages and total_zero_pages elements are used only for
> the end tracepoints of the multifd threads. These are not super useful
> since they record per-channel numbers and are just the sum of all the
> pages that are transmitted per-packet, for which we already have
> tracepoints. Remove the totals from the tracing.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


