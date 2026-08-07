Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FF8C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKAd-0007J5-9U; Fri, 07 Aug 2026 08:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wsKAc-0007In-0q
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 08:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wsKAa-0001CF-3q
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 08:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786107566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TyQBrT9dY9tRlNWIBb6513byGlEnK78b1jObvv/MajY=;
 b=PZ1DU8FXTn/uJgmCugQuODzVo0kwikhCBGdSmOJ9V1yNRcPRLwdMKyWjs+EGePYCDUxdHi
 30Q4D8XsadVfiak2le6+7jUV8DFK5LPUH4WEs6yrxip3UVNUshpkpwKqAKoqyoXFkjekCY
 /Ij8ehzVH/uMgg9+ShGmKC5aqmK4qAo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-HmvQmV98NCuV0Ynt4Di1MQ-1; Fri, 07 Aug 2026 08:59:25 -0400
X-MC-Unique: HmvQmV98NCuV0Ynt4Di1MQ-1
X-Mimecast-MFC-AGG-ID: HmvQmV98NCuV0Ynt4Di1MQ_1786107564
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so28408256d6.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786107564; x=1786712364; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TyQBrT9dY9tRlNWIBb6513byGlEnK78b1jObvv/MajY=;
 b=PzlAKg5QP9X32fJrFQbCUa1uci2SMK1zXKECUtmHRqCBz6rb3WjcupcyAQ3B98RhLF
 HS12LAQyuREYk/1nHKA1NJe5PPhMQat3UdQHZoiS1yhslw2zP4Fr2NzmELjnoq2XnWIb
 iaQQrv2iRtFdd0swiWBqot1lYfV7zFsnGByN9Z7vwQHSKsNE8DqR9IXZ+PUwoyjRayKS
 GXqXQrcwVunGFttfZwqyOmGJVwdSlcCKJZN6Uf7aRAzcSDpQsjzSu51cbLktjRSqYmn0
 exvMNua9imZROrIekmFzPi7c0EE5714xQ4YIn572w/WFUyJfOkKxe5d6BUkw8Q7x9NbR
 dayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786107564; x=1786712364;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TyQBrT9dY9tRlNWIBb6513byGlEnK78b1jObvv/MajY=;
 b=iPWO4lktc7SVUxQBkMkGYLvh+ZXT/SrDfF5KSTqoQ0z+zo5l4HdWSHNGfUp7UzMaP6
 1ug3twzK7u4xK2GCjrNmAPPNuzrgHWQClAJkaNR9d3Qa71wq5KNdUojtCSkRepyEQH7T
 HlCI51PJxB5vBIVSWOjGRpHSpO9KwpwprEfdv3VpFCHIHraJIaQ7xXlK1Ddv1KpUGq2U
 0fwWMt84UiX1B8qqGU0rXFyDV8hCYRuG2mLW+pkvo/m4/g2WrFpqf3Pn7UtMBt1QOsfw
 HJVXURAS9/tkirxuI8K7e1lOGwhq8+kcll5vQTpuJLHTSBu1G2YpJ5DeSQBuSA7WS50U
 7ugg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4JaTGslDpef63JIhZ/tpkmcVgxNbyM1MVwzUWsK2fU8+fJnIIHKEPbJ2P7raWnRXocJhEwXipKPDO@nongnu.org
X-Gm-Message-State: AOJu0YwBfavxEXYKr15aiThBBjz7JI9Iweworq35sheQwEAWaWEtm0fP
 /RqRC10Oe+MSJnN5CEs6vZH8cER8wiC3uRUrmNJ0iP0Vuu9p3NhLTIDTMlj5EeWabhm3hFFVmcD
 vhvY2x2BiF8gKEAiv+RT9KxpE6g+DDJLc+tyCbFQw4h5ZjdHEbNyqo+wz
X-Gm-Gg: AR+sD13PvhhixKIg4wAyrfknCPDD4ZdNmtLFlUM9lUg8Nu+2V5RT7hlJhcGBdjgQrYw
 A0wMdPlR1WJsQaPyQsCdZSA15NFyYio4o0GvzK0esDi1C0w9pqxcodB/SsD6v25sTwdbdSDsBYP
 jtuLWXV3mjEH5Xgzj6PZJzQyKwZDXAGoExV1dhzi50rg8KaNFwdKXgTfKc0o3nB7oI/bv61I5xF
 pRZh9m9u8PyNKbWBMoplrSwsLU6ZABq+6u9ET3c5affOKU/iyLc+j4xKBs+z7mWPgCpxYHllDLh
 6r2M52Gdv7a6qmEHWXf1GJI4J1uOacDrJvyBCaZC46DnsIOTZSEaCM3rvdm/jN8zOryP
X-Received: by 2002:ad4:5c8b:0:b0:8f7:40b8:e8ab with SMTP id
 6a1803df08f44-9088108f7dfmr250634196d6.3.1786107564490; 
 Fri, 07 Aug 2026 05:59:24 -0700 (PDT)
X-Received: by 2002:ad4:5c8b:0:b0:8f7:40b8:e8ab with SMTP id
 6a1803df08f44-9088108f7dfmr250633416d6.3.1786107563921; 
 Fri, 07 Aug 2026 05:59:23 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a9331213sm8059546d6.41.2026.08.07.05.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 05:59:23 -0700 (PDT)
Date: Fri, 7 Aug 2026 08:59:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH v4 04/11] system/memory: add a tracepoint for
 memory_region_finalize
Message-ID: <anXWn4-q92ZUULDb@x1.local>
References: <20260807052559.50643-1-anisinha@redhat.com>
 <20260807052559.50643-5-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807052559.50643-5-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 07, 2026 at 10:55:46AM +0530, Ani Sinha wrote:
> cosmetic: add a tracepoint to track when memory regions are getting freed.
> Useful for debugging and tracking all freed memory regions.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


