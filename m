Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E62C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvnX-000175-Sl; Wed, 20 Mar 2024 09:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmvnW-00016m-02
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmvnG-0000V0-Bm
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710940545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHPHIJGvn/8X+JXs0HRdKTFulwQJyL+u/3kk1jywDQQ=;
 b=c5hveBeH6dAb5bfVUr3XG8qDbBANXLgVQGNQmzEeuqhzanjyCpxAf/X3wh+mVY7mZepYFO
 jSaKmhw9xTu1S+EfiOtMf1aRzzOkBlTAMtSPX3KX0p58UVPZh5tZiAoPAp+tfzmQf2Tmwz
 SAaa3Pys2t/xInMN1QU6atBRm/ulM6c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-Vu6AoWgxMqyeliaENgnyiA-1; Wed, 20 Mar 2024 09:15:43 -0400
X-MC-Unique: Vu6AoWgxMqyeliaENgnyiA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7830635331bso178940985a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 06:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710940543; x=1711545343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHPHIJGvn/8X+JXs0HRdKTFulwQJyL+u/3kk1jywDQQ=;
 b=jOIlnSDGuhOdtasv6LxlDZWbTEU3wjeT1Xuh5lJX47bMFx/CICokkDTpDmunQLjvU5
 BI7UD2giW9xhup9lsFDySLLkSasmOaD0hTwVQWm8cbXgtHugdJN+XpovuvafRvKW3Bmx
 98B9vD8DMmdqXhBVVJDe64auu7qNArTkezVhIZmFJIZKnAJFttFOC+YRsZ/YEXDt5uD2
 wJVB0DnGAxYw46Bkk/Gk8S/ce4SeZlyVdklupGBb1H02sSWhl30TAh6e6CF4lzsSHsSE
 YF61vq1YDQhWg+XLtNgnGpL+XDEOEeHo/AHKu8H7sJy3F3nAVbp0+pocwsoHt/Z8sztn
 JyyA==
X-Gm-Message-State: AOJu0Yz2McC271CKyDvlEmj/eMiuPBEZ1uEAVsXxkNA8xYkMVs7eY9LV
 Z2uhRwko7oiLcQQvADjA06MLeNQzCXTOqSuH+HQbXqoACLB6uDUTrn/N1KcLYxBoQTbTGm0WaY6
 TI74ZAc61b2JHcThNfnE+e5S0X7avu2Kuy3KyJmVM1cweikKNt9wG
X-Received: by 2002:a05:620a:40d4:b0:78a:2a9a:46e6 with SMTP id
 g20-20020a05620a40d400b0078a2a9a46e6mr27870qko.4.1710940543234; 
 Wed, 20 Mar 2024 06:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNIiQPkvQUGZQ+0L1bnapy0+rAVQ0v9yzDuDinW7lmkOrxHE9l6hJCq2t9P0j1qLX/BI/QhQ==
X-Received: by 2002:a05:620a:40d4:b0:78a:2a9a:46e6 with SMTP id
 g20-20020a05620a40d400b0078a2a9a46e6mr27841qko.4.1710940542870; 
 Wed, 20 Mar 2024 06:15:42 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 g20-20020ae9e114000000b00788428c2a97sm1032331qkm.64.2024.03.20.06.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 06:15:42 -0700 (PDT)
Date: Wed, 20 Mar 2024 09:15:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, farosas@suse.de
Subject: Re: [PATCH 1/2] tests/qtest/migration: Ignore if socket-address is
 missing to avoid crash below
Message-ID: <ZfrhfOLpjcOySS__@x1n>
References: <20240319204840.211632-1-het.gala@nutanix.com>
 <ZfoKSgJ9LN1Q7R1V@x1n>
 <56ed1452-87ed-4cfb-912f-b15bc74609c1@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56ed1452-87ed-4cfb-912f-b15bc74609c1@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 20, 2024 at 10:47:18AM +0530, Het Gala wrote:
> It won't crash IMO, the next function SocketAddress_to_str for a non-socket
> type would return an proper error ?

Both SocketAddress_to_str() and SocketAddress_to_qdict() will crash with a
NULL pointer passed in right now.

Thanks,

-- 
Peter Xu


