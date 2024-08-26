Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32F0C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sibhI-0000cp-Sy; Mon, 26 Aug 2024 11:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sibhH-0000Lv-2l
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sibhC-0003mT-EX
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724686312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KvmsW/R/pRHV6r16TwJ5dlorJRdNnIKw+K2FnT7Gsu8=;
 b=I2QbcVPpyk6Ji2Bce2g1in4i1ekuDHduHZ/IPSvga5AIHf7utof3Xx199wGyC6I5cq6URX
 IjMIZZ9h1Wdy1N5nFQxXwV4pP3PrABvIgrGcvsJrHO+AfcDJCITzHvdx9oRiUziAL2c2q5
 B6PkaphLM+DpFR9Rx+O3vM7lOZDxgFA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-MOIa-_6iPCyjl7ph75U5GA-1; Mon, 26 Aug 2024 11:31:51 -0400
X-MC-Unique: MOIa-_6iPCyjl7ph75U5GA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4531a85d3e8so50910241cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724686311; x=1725291111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvmsW/R/pRHV6r16TwJ5dlorJRdNnIKw+K2FnT7Gsu8=;
 b=n0pXoQGTupv5c1pB7TPC8QrdBbZDr9izPKi2iUNbp19nbcWzoWcWzyyacHKbojjjn3
 JuOVXNHPWt7AdllIrf6KYXzge6tFqKy8nm1dEwV7KWvv8v1xVp6YykI7HswE58r5n6BR
 0Xj+/P4ZHnfCfB66/7a2D1R74UeESZd+jY73D4Mgl8PWwSjOU75DcS2rU7HD+RM2fsqt
 76Qbc7jrf10TuSc/4/hT7euEsPYPs1saHWa2cedFgqV5a0YkKq5KgIiESMpK2xf6cB09
 7OXBFuWLwmacfZrLTX5O3UM3xYO7XuQheHXZyhyQxSos6dwJYMEKyUbrRul48jULPAv8
 suxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0xEyEYWwRGH9LrO3WJw1swxlJqrRyRo2klXLQrH1MMUmDIGYksLt4SzNZqcvLhh1SrK0hcB7oOY0/@nongnu.org
X-Gm-Message-State: AOJu0YyFQyZXLa4a8Qe4zoZPD2mkXdYBmbTyiCET1kzNgjdTsCnrxpD1
 dg6nXSr6JLdRdsa+LmCUbizCy0Nh8nGvNz4/bzidy0gxWDxQdENF1lnJKvPkFmJxNjUwg54E4/z
 WcAaD0H9+283GYaIocMElkeFLofCAyo0YEV0IaR36wBQqp3gCf2nT
X-Received: by 2002:a05:622a:6205:b0:453:5f16:f35c with SMTP id
 d75a77b69052e-4550966fed8mr90573321cf.23.1724686311063; 
 Mon, 26 Aug 2024 08:31:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOuVc+7GDo5fXIrfj9zMLOMMCJCfUZtibRfah8YTf8K+KwgMqZg42kKMbOrHNPiXY9vYbNzg==
X-Received: by 2002:a05:622a:6205:b0:453:5f16:f35c with SMTP id
 d75a77b69052e-4550966fed8mr90572981cf.23.1724686310676; 
 Mon, 26 Aug 2024 08:31:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fdfc0475sm44887681cf.8.2024.08.26.08.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:31:50 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:31:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 5/7] memory: Clarify owner must not call
 memory_region_ref()
Message-ID: <Zsyf45wm2pI3bQ-I@x1n>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-5-a24c6dfa4ceb@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823-san-v4-5-a24c6dfa4ceb@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 23, 2024 at 03:13:10PM +0900, Akihiko Odaki wrote:
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/exec/memory.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index d79415a3b159..6698e9d05eab 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1220,6 +1220,7 @@ void memory_region_init(MemoryRegion *mr,
>   * memory_region_ref: Add a reference to a memory region
>   *
>   * This function adds a reference to the owner if present.
> + * The owner must not call this function as it results in a circular reference.
>   * See docs/devel/memory.rst to know about owner.
>   *
>   * @mr: the #MemoryRegion

Please consider merging all four doc pre-update patches into one.

Thanks,

-- 
Peter Xu


