Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA772C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOQ4-0000Wh-CS; Mon, 12 May 2025 04:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uEOPz-0000WE-M6
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uEOPx-0008Pl-9O
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747038103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kmFKtMGaSZlebErRM+GbRsBjgStmptw1cKL332o2Wx4=;
 b=QJkkwhLmnnanNDt55ohGrbLowk20omx32QA5uncZMkrK6A93MrB/Du1h8mon9wr1e6KYLm
 ebH7+lhLPHQhfRQ0jx8o1iT7RPqxJ/tbLJTEWblj3ukBv9DNo7llZHkzVbUXnnR0WNhX+9
 /sabrWuProZ9G+mPC8LQUJ7MjK006Ws=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-dNMVbXxEN3qMxbD33dDG5A-1; Mon, 12 May 2025 04:21:42 -0400
X-MC-Unique: dNMVbXxEN3qMxbD33dDG5A-1
X-Mimecast-MFC-AGG-ID: dNMVbXxEN3qMxbD33dDG5A_1747038101
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b2e56da1so1550069f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747038101; x=1747642901;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmFKtMGaSZlebErRM+GbRsBjgStmptw1cKL332o2Wx4=;
 b=XimBCo4BW8Gq66AqYkzDiSn4NJlsrsQ1FejefMMNMTG1a5CPZJHA8hgxGmvNz/06lx
 s8U7m85eIxlUXMQEUWP0MmFKBBgl0i5NI/OGgdLHUn20q/QRZlyeAj6Uq8SW7VHzXEmH
 FduYp+s5y3k9uu48Rs+KA0IrhMFoMMh3ue+oykaW9B5gG13in5fiidVVLVlYSaIivsMy
 QwisLOU06aoRExF+T7nINXHZywxJ7OGsJeYTNYeXE8nKd2d8ciFpDt1I5dbxXGlSHRvR
 cj+QViu+8aFtk7QSkMbLf1JySkEeeBYumaJ4qThO92kZdNKMtQJEJ74tpztvpLmCLfQ0
 NSJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBtld/QKQ222SUeQNUJX/bnJmZ/ZOI1tnNwWMO2JuGTDDvA6gOVw69nH95imPTsbRrNPXY8k2+bnxx@nongnu.org
X-Gm-Message-State: AOJu0YzSuUnGxc34zE2vvwQY2YmO3zIfCStCgyV1x6EovZZw8phD3G2u
 Vw672GaeCjtB0m0YFLFugzjpd7cinp/Kh+wc9MI4uPifyWBLu26J4KR7PobgUUd/m7HG88Wp+sJ
 XV3gxs0b3L8wdeQoVIk/gCy3tAqzMfzAp0Wpx9Db1VTnJXwBHg+AQ
X-Gm-Gg: ASbGncv+X+35dqpYFVvlFPu2joSE5jTpRXVkjq7Oor/TgTf9ocOZWPKauZU3iNE1h3B
 n+Qzy1mxKcHRa9owNhV8aaSu4LLIJ6ZmWCxf0ZaQ/zcZqWs8EVm+KJoir631SSWU9CeuwP/6hP6
 YF5OHUd/N/JYuRwIA+Y38gqBjaLqO1pEaX9CKsmwnu3fjP/eue0C94gPwp6kN5GFO5YdoRXM7Pt
 eJrUP2bLmn8oZkcl550yDPGLlVEtkCkAXlfgMxrYdj3bKgvuEmcT0KLkVjbmcDHQSYpm9HSU+7z
 wAgPjPDaWV+ANBj7MrcU1/14hd+qQHpzXjJRHK9E4lcDX2C0vA==
X-Received: by 2002:a05:6000:1449:b0:38f:4f60:e669 with SMTP id
 ffacd0b85a97d-3a1f6488094mr9593823f8f.29.1747038100913; 
 Mon, 12 May 2025 01:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjJNA5lceZcqWJGBPKdNh1wS8PeeDgj3mQBcRXtyeh1oKwlfwDLiV1uC2TJorNyCVgF5y2tQ==
X-Received: by 2002:a05:6000:1449:b0:38f:4f60:e669 with SMTP id
 ffacd0b85a97d-3a1f6488094mr9593806f8f.29.1747038100586; 
 Mon, 12 May 2025 01:21:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddde0sm11858212f8f.14.2025.05.12.01.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 01:21:40 -0700 (PDT)
Message-ID: <4d6f6a3b-ac4f-4cd0-aecc-c3fc67d931cf@redhat.com>
Date: Mon, 12 May 2025 10:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/23] tests/function/aspeed: Add functional test for
 ast2700fc
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250505090635.778785-1-clg@redhat.com>
 <20250505090635.778785-23-clg@redhat.com>
 <CAFEAcA8wmqAtcgfPvyMY8nujTWNCSC0DYO64aA5up-sTWCr_jA@mail.gmail.com>
 <ce9162f3-a3d3-4a76-a261-af16384ea82e@redhat.com>
 <CAFEAcA-OJmmKgLrd6P-+Kb=-Zh52GL0y+vfNLrivM97T4DDDwg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA-OJmmKgLrd6P-+Kb=-Zh52GL0y+vfNLrivM97T4DDDwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/9/25 17:27, Peter Maydell wrote:
> On Fri, 9 May 2025 at 15:32, Cédric Le Goater <clg@redhat.com> wrote:
>> In the ast2700fc machine and the fby35, each SoC has its own memory
>> region and, since there is no need for the global system memory
>> region, it's empty. But in some places, like
>> rom_check_and_register_reset(), it's a problem for the flattened
>> global view.
> 
> Generally speaking, board models should set things up so
> that the "main" SoC for the board uses the main system memory
> MR, rather than creating its own empty MR for that purpose,
> I think.

We can do that.
  
> But separately from that, it's weird to get into flatview_lookup
> with an empty FlatView here. We called memory_region_find(),
> which is a wrapper around memory_region_find_rcu(). That
> function doesn't make assumptions about where the MR it's
> passed is from: it walks up the tree of MRs to find the
> root MR, it looks up the AddressSpace for that root MR,
> and then it gets the FlatView for that AS and calls
> flatview_lookup(). If the FlatView we end up with doesn't
> have the MR in it, what's happened ?

The ROM created by the loader device does not have an associated
memory region.

Thanks,

C.


