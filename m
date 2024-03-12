Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA19C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6Lo-0007ZV-NR; Tue, 12 Mar 2024 13:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6Ll-0007Yk-Eb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6Lj-0002OL-0r
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710266137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqxg+bRkO1FTqkgtei/TrIiKOv15eEm0HgYedbw/mlY=;
 b=GM8lKYKSnxWux66ue+T6grbjFEWdUdN4yjhMhoYl0948RBh8T2xaFZ3XGGGMGbmLP+HfcM
 RDJOZiu8FLUkKxLceohAoNCh7CZsks6MylwIz939TqZA8LHUkpvE38l/SRoS1mGoJOkili
 G/zuWLHl4+CNobn4u0jPsL7IDrjIL/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-JgC7ftbkNyiPbFr3rSS7rA-1; Tue, 12 Mar 2024 13:55:36 -0400
X-MC-Unique: JgC7ftbkNyiPbFr3rSS7rA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e8b535e27so2049533f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 10:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710266135; x=1710870935;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rqxg+bRkO1FTqkgtei/TrIiKOv15eEm0HgYedbw/mlY=;
 b=nOa1oEhezUd8X6tXbxUE2brxSq8CxM3O3uV1BthxOjIuiWvSymcpjDEpJhv05k9sXw
 tHwjWFeaJC+qsbazaLOgxhNmCxQohhVptX2rfq9Z1HIeNiQnTcgzEC7vjWTnCK/dzTMc
 C32yjWOHMipgLm+WC8WlYpbsvL7WOVaxWT/n89bcTCLnsgl7NORnWY+k2tfkFs6dozAY
 Tf7XWeyqH02E/1xzeWmNIjZI/8I0/lMteQd/YzbWAKWAkaQEubg0H5hoKJS1wYEpEkMX
 Zpb3z2hD7nfNnbAuU7qKATH7fZ1Q0Z0NFkU6Q4AUGoM8WurvwNaaJp9/f/B0rnOwGh8i
 F2Iw==
X-Gm-Message-State: AOJu0Yz68TdfcSQFrAkImLUudO5JTmFGR+a0l5zhyOIlrscqcombplJS
 ch12RmDWmTrtn51PS5EOIb+g2wnElx/1v+BHlllfnB1euJyjT0s4S6OFj6xZ6UGOi3x5M3tWmee
 aXliYalm4tacgGWT1cU4s+9Z3yqbJTSDG2/oRBie3wXC4EPPeXhmS
X-Received: by 2002:adf:fa52:0:b0:33e:7b36:e17d with SMTP id
 y18-20020adffa52000000b0033e7b36e17dmr134234wrr.22.1710266134694; 
 Tue, 12 Mar 2024 10:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo+Bu45HprZlWraqjiPb4d/ft2m5DKXvU8LTRFNe44lyyVMqt2FGf1wz6R+e9UucANxOpo8Q==
X-Received: by 2002:adf:fa52:0:b0:33e:7b36:e17d with SMTP id
 y18-20020adffa52000000b0033e7b36e17dmr134216wrr.22.1710266134219; 
 Tue, 12 Mar 2024 10:55:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a5d6985000000b0033d6c928a95sm9609837wru.63.2024.03.12.10.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:55:33 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] docs/specs/pvpanic: document shutdown event
Message-ID: <20240312135414-mutt-send-email-mst@kernel.org>
References: <20240310-pvpanic-shutdown-spec-v1-1-b258e182ce55@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240310-pvpanic-shutdown-spec-v1-1-b258e182ce55@t-8ch.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On Sun, Mar 10, 2024 at 04:04:51PM +0100, Thomas Weiﬂschuh wrote:
> Shutdown requests are normally hardware dependent.
> By extending pvpanic to also handle shutdown requests, guests can
> submit such requests with an easily implementable and cross-platform
> mechanism.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas@t-8ch.de>


Okay I merged this to get us out of the bind.
Pls post a fixup patch adding something like (to be implemented)
so people reading this do not become confused.

> ---
> This patch was split out from my earlier pvpanic-shutdown series [0].
> The original series dropped the usage of the linux/pvpanic.h UAPI
> header.
> As we decided to keep the linux header [1] this first commit only adds
> the spec definition.
> Then a patch to Linux will add the new events to linux/pvpanic.h.
> After this the rest of the changes to QEMU will be submitted again.
> 
> [0] https://lore.kernel.org/qemu-devel/20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de/
> [1] https://lore.kernel.org/lkml/20240213053953-mutt-send-email-mst@kernel.org/
> ---
>  docs/specs/pvpanic.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
> index f894bc19555f..61a80480edb8 100644
> --- a/docs/specs/pvpanic.rst
> +++ b/docs/specs/pvpanic.rst
> @@ -29,6 +29,8 @@ bit 1
>    a guest panic has happened and will be handled by the guest;
>    the host should record it or report it, but should not affect
>    the execution of the guest.
> +bit 2
> +  a regular guest shutdown has happened and should be processed by the host
>  
>  PCI Interface
>  -------------
> 
> ---
> base-commit: f901bf11b3ddf852e591593b09b8aa7a177f9a0b
> change-id: 20240310-pvpanic-shutdown-spec-4ea2172529e8
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas@t-8ch.de>


