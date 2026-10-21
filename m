Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89779606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NeUheEVW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qq7ysYJ7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQm5-0007wh-7f; Wed, 21 Oct 2026 03:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xJQm2-0007sD-8p
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xJQm0-0001Rs-PX
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792567808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0fiaHK8efGPR8u3+d8Xn+CbdbXILFufcrbWGoANBEs=;
 b=NeUheEVWH7DXG902TcmcoGgMuSMibVR/Bx/b8uXm4awBIbUrEhBxotO1/eQm3eTDEh7unG
 y4rWjFXKAPglN/7MW8AtitbMTW/x5cYY+WQapqAcG6Ci49P+JRI42PGrx1VFuhtQd48HdF
 q/Mlb/n526VE30AElPMWwUyXIjV3/g8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-x_lCdu1OOh2dOUUYsfnILA-1; Wed, 21 Oct 2026 03:30:06 -0400
X-MC-Unique: x_lCdu1OOh2dOUUYsfnILA-1
X-Mimecast-MFC-AGG-ID: x_lCdu1OOh2dOUUYsfnILA_1792567805
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1d15e7bfaso2603045e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792567805; x=1793172605; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S0fiaHK8efGPR8u3+d8Xn+CbdbXILFufcrbWGoANBEs=;
 b=Qq7ysYJ7/6eLU/IUbX1Pq3h0SXy/ASOAsj6/i8Dp6ezeRPdVSu8ijn/7RAwWafJBkA
 cHUxtDGY5v1xRO1vcCMLLXBHfzr7wizlkEdJBPvCmul7r3lpRudLUIfBobPQmrEYsOPE
 cgNMW5PzrgXFUw19GSdV50TQqw2cfnE02VE1AtM3sgO33eMURrLsFVZ6jl4Va9XZD0tt
 yJGuwVNQmJkkA8Pygr0rzWg+qgslRX1xwIaQ/esrSmHM9S8nM0a+sD7EPRZpkh+CidzK
 THwHcCRsCpPD+WkF3fCikAdDZPnNnPJhzMbGEC3AQ8GTdbPS/I+3pW5NMijfGzFRYZ5g
 NAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792567805; x=1793172605;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S0fiaHK8efGPR8u3+d8Xn+CbdbXILFufcrbWGoANBEs=;
 b=GFf6XrjHi0ht6eXMAxB7Dqmq4QXONsRw12+BMpDs4BpSGuVONR7u0H6jtmkhrbibzZ
 muzhdHJeA4cQFjnP/Be14dA8MIxZxj9lyAAX80gKSpjLzaZKNGcarHIo59GziQe6/6I5
 MlRD3/sXiZOY6gRWOZgOw24Aq+aww/ARCGX3dEoa9yuMSqV4C+kvaFKB2Hkb0DYiY58U
 C3YgFDjtUZQvPehy4FjOCCPb0u9DuMhnpm5fOJBhluVABgO0k8KvQxxE3dyzcpa3N6Vi
 fNm6xtTlGCMBmWfID8hFexN3VLLTgzDwk92GOSDG7UsHeR3N2lWD/UdUhhS8fZjUYTtu
 q/IQ==
X-Gm-Message-State: AFq9FYLiJAGLe81lVWRUQdTkVg1XEcicEk/YGVbhpHW1IFnmFM0W+v0U
 16x/nM+IXHeTSDbxngZvTO/p34fXov/FlYjmW9afw+A0KGqkCz3u9BubsvleCVtcmgjY2gLmdSS
 gBjPq7k8gOF+OonbsYtt3Dgp8Ilh4ECP/Kyj7Z+55ucYBlgNd18OubaSb
X-Gm-Gg: AYBFou1sqUQm7yL1Uo6/akQIFQ9aJvY9YTfzy+gbUXms3rTkqkK8e754Fbto4pncI0B
 WwB8GC2tqk3h8SJ8eUsVlMe6cTGf70llakRxdaXyugm0+Zl1aGiqoNiORpTtglF1BJWqU9dzFTZ
 OHdwKsDvmMvXwNyabhODx93m1OVOwEfVvuYIVk7D4s3VCRHR9/NtfxPnn1otqX5OY1D5xZkxGmM
 798jWN+QYGcWPBPDL9HyBmH1ZOOV4194KixBYgsz/BlKSVvFzC1h87nCuFnZfG/s+s9vrFVfnjJ
 nkxXWTULWrTqqDI4S9pN5W4W5nXZc8TAVU8Lni6G9u/ZradF1PDg6Tvlx3bnTfHdOGn6WqTveDn
 icKs=
X-Received: by 2002:a05:600c:4689:b0:4a1:d73d:4137 with SMTP id
 5b1f17b1804b1-4a1fdd4da2emr21223035e9.28.1792567805291; 
 Wed, 21 Oct 2026 00:30:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:4a1:d73d:4137 with SMTP id
 5b1f17b1804b1-4a1fdd4da2emr21222385e9.28.1792567804781; 
 Wed, 21 Oct 2026 00:30:04 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.165.64])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25840115sm3588872f8f.48.2026.10.21.00.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 00:30:04 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:29:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] docs/system/igvm: document MADT, COMMAND_LINE and
 DEVICE_TREE directives
Message-ID: <athp2g--udybymp3@sgarzare-redhat>
References: <20261019-igvm_command_line-v3-0-29aeacbd6cd7@redhat.com>
 <20261019-igvm_command_line-v3-2-29aeacbd6cd7@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261019-igvm_command_line-v3-2-29aeacbd6cd7@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 11:12:47AM +0200, Luigi Leonardi wrote:
>The MADT and DEVICE_TREE directives were added without updating the
>list of supported directives. Document them, together with the
>COMMAND_LINE directive added in the previous patch.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> docs/system/igvm.rst | 8 ++++++++
> 1 file changed, 8 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


