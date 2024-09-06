Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7336BCE7AE6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 08:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smUKd-0004Bi-0b; Fri, 06 Sep 2024 04:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1smUKb-0004B7-61
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1smUKZ-00064C-TC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725611314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9o0TZ9XTq+4qS7f/dSySyCjBNEDB2OWLPpEND0rls+s=;
 b=PfoXCHdVEy6DAKuzcxgKSWrTKc4+mDjvqzDUaLMxxOeJzKvPl83cgDf1sxLpmdB1qzo4Uc
 RSBXgZWQGwMmMvIKVqzVKykyvMOchG/CSV314EIsgI4hD3unHaLDHaD2Zxz5a1ceP3tHGH
 6AuaDnCYKm5Yd2BG65a7S36KMTq3LM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-B9FsvZ_AMieTRNhjAuVD3g-1; Fri, 06 Sep 2024 04:28:33 -0400
X-MC-Unique: B9FsvZ_AMieTRNhjAuVD3g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42bbad819d0so13500485e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 01:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725611312; x=1726216112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9o0TZ9XTq+4qS7f/dSySyCjBNEDB2OWLPpEND0rls+s=;
 b=ld92V7JELSxcBXDvHpJjWKtKWKMXvpaukvxqejKH5EvDKdnMkV93gFIppJDlN8N0ID
 OG+QlC+V7jmJLr3NWUjWuMjNdKeFrfWMadHDbRp+Qj+QDAaeAfsV5hq73ale0m93ediJ
 azKIGgEiHA5SIgs0oXgYYLGy8mgBuHO9kT2T2iNnXET2lsWpAXBc/zKe+37HjvRGmYAB
 HxG/f4a0z9Aex2B7dp8crMwuvhCbvpZgsTD7VTwvS4k/xTV+Ek7wWdhWJ4g5pVTA70GW
 3S2ngQtZwkHBBfL6OvLvzgqKU8cSvTdclacEyWBoL747OE9IBwr/32fxmtkRN5CcNaRR
 nbCQ==
X-Gm-Message-State: AOJu0Yynb2bCCjPjyN64GSuyWsCbptzizUNu5PK0o33m+X0pVDt5X9t+
 h863kEc2wMCg0bhQsei7oBWkWBfYG4BQQihRAyKr2NbhpOwU0SSGSrjjAhfAhfZGgtyAZcrCaJr
 LPTzpAcys2/xqJ06fHRXeS8QOHW1VnTbj07zqz8FuI59i1it1IbFY
X-Received: by 2002:a05:600c:5487:b0:426:61af:e1d6 with SMTP id
 5b1f17b1804b1-42c9f9d3619mr12663455e9.29.1725611312144; 
 Fri, 06 Sep 2024 01:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBmBJPgSb0+O22IYfhl/dkRdyjbNQf2BmU9cFOuu3cngRFxhPJqpgmXzE10nYyZ3GKJsy/gg==
X-Received: by 2002:a05:600c:5487:b0:426:61af:e1d6 with SMTP id
 5b1f17b1804b1-42c9f9d3619mr12663045e9.29.1725611310941; 
 Fri, 06 Sep 2024 01:28:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:6afa:d56e:f70d:1d1b:3f10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca06003e8sm12658025e9.33.2024.09.06.01.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 01:28:30 -0700 (PDT)
Date: Fri, 6 Sep 2024 04:28:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: luzhixing12345 <luzhixing12345@gmail.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com
Subject: Re: [PATCH v2] docs: fix vhost-user protocol doc
Message-ID: <20240906042749-mutt-send-email-mst@kernel.org>
References: <20240805145703.24425-1-luzhixing12345@gmail.com>
 <20240906021045.20018-1-luzhixing12345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906021045.20018-1-luzhixing12345@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 06, 2024 at 10:10:45AM +0800, luzhixing12345 wrote:
> Hi, can someone help review this patch?
> 
> Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>

You got comments Aug 5, pls address them.


