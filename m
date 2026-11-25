Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13027606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dP7If5/E;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZNIq8YWQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWKee-0007Kc-G6; Wed, 25 Nov 2026 16:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWKed-0007Jt-8i
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 16:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWKeb-0004J0-BB
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 16:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795642547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CenIeRKnp5i/E92FDXSDR7xDv/MMC9GDo8aRmN7foQA=;
 b=dP7If5/E1rvh4zIAu+UTqD2HcBz9goNcbRPF+Y8gxHqqOJQDl0niRtSRaHgxiKj0KRChB7
 gORnzmZ5lDfFCuukYQBG7Wgy0NMeFPWd1vzfE/xSsmjvvCUCGpi1Y94svvAFunxi7wZChq
 DSVtQTC54lsPCQs9Lna/MYvrGQ//1WU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-dP9euCOBMJiebgPq-LVwKA-1; Wed, 25 Nov 2026 21:35:45 +0000
X-MC-Unique: dP9euCOBMJiebgPq-LVwKA-1
X-Mimecast-MFC-AGG-ID: dP9euCOBMJiebgPq-LVwKA_1795642545
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55ba5fccc4aso25252071cf.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795642545; x=1796247345; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CenIeRKnp5i/E92FDXSDR7xDv/MMC9GDo8aRmN7foQA=;
 b=ZNIq8YWQGAUfALQ5JzDJo0Fj5c4BALFvEvzFTs1JtdGyIM11yKOCaCTNZObQlW1nFF
 j5AS9omtUfNtU/H9/jj5jLPv0wknL8WkRk3/NYeJhlFJbaZiQ3qrQn+ppNtWQpprVqM1
 uwd+8K4Wil/LojstGvUW8Dpjy4MWEECBwj2XCdyouBf6BbqHwpGNZcz6xr+O3c15dtN9
 quJ3ahW1CBANsGuiNw3L15kE9Hz6ez+m/oN4e4IvId0rGoHO2b092fZZ1wpyI+WksBSd
 ChTt9z+BCwvS0JvGJwhuJMwwMaBBE7T0+ilSZROQfzDQ1DeLipBiXTLCwSLk+JKCCKvF
 Szhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795642545; x=1796247345;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CenIeRKnp5i/E92FDXSDR7xDv/MMC9GDo8aRmN7foQA=;
 b=z6K2P3ff7DEGDxJqoKEg5kxlrK3uDDUTQ1UBQxKn5cLSsJlseW0M7ccnZ3ZDfopB90
 yvQO35FCmNP43r4kMlueuEvdPTyJzCfcB5i6o50+lin6PdpGOa1KGKKs2tG2MHxna6FU
 9QZ9Q04qCMpScP/QvP5Yi3OUkQKOVgs7dUBQzjRCamD1V3Q5Du/W9q8Ip3O6Qr4YMo/v
 cVJZPwZt4vtSbCxW0DPKwQEyqUKRg7bNmV+WUc26F5HjTaKxS7g/fQvinVwy9zoosi0P
 hzNMyij26uNIp0PqlNcuyrhNYg8PjtSjYNy0MPNq1W3fg6sPW5cc5cQFr/9HeBgyOUPF
 CJyQ==
X-Gm-Message-State: APuU4Z8+wsPjGc1kpqJwKuf8b2exC0CZl1qVDl/E4r4G1pDl1WRRRFgY
 77Zo5QhcYe+YClvFWZnX9yt0g4DCxEGKoh+lSpMQt4KQWuUv4wDF3kx+P0Y1OT/Z0Gp+5FcIyTq
 BHZTuvbIx2YcgPULaW6MWHuR/V/mI+eOqKOO7SYgagdfAquGbstx8xiim
X-Gm-Gg: AZFdTZe8m71/ndfSUUsFZqUhWLHucw2nSUWjzCr1C4nU4UKirG6rRs+BnXgoNmWPbKu
 80tULjYzXvH6VZKpcjCYbx9ZTuLs46pnqdBDSZs4tsYCEABBBdQ0G0U5h6fdV5eEt07XAU1IGgO
 CbrEzAytNzZz+yed5V9LZk0I198EaNC713Lj1e6muJnaRrrjtCPwj75i6Eer2IOaXGfaPx7dZHS
 NKoqc8iA9+zCBvjT1yleAksNs+WFADOZ248ehu2RLWCk32n7rMfHP2gdnmgbGVGzt18pYWfsrVC
 rcCS/WvoOJoJMz6uVc+RJkcu3rpesiGXHwFFzs+NHmnflOyLtquEKDYAlNFO3mGGsAIKnx1bQrm
 gpBvrZvn4TntQTNqJNiaOtY+qmf79iG3jnRWJu/iH0x0k
X-Received: by 2002:a05:622a:4d8f:b0:534:20b8:5d1b with SMTP id
 d75a77b69052e-55d76a209abmr333062461cf.38.1795642544720; 
 Wed, 25 Nov 2026 13:35:44 -0800 (PST)
X-Received: by 2002:a05:622a:4d8f:b0:534:20b8:5d1b with SMTP id
 d75a77b69052e-55d76a209abmr333061951cf.38.1795642544197; 
 Wed, 25 Nov 2026 13:35:44 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349d0e35sm172042706d6.20.2026.11.25.13.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 13:35:43 -0800 (PST)
Date: Wed, 25 Nov 2026 16:35:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org
Subject: Re: [PATCH for-12.0 4/6] arm/machine: Move all VMSTATE_VALIDATE()
 usages into post_load
Message-ID: <awdUrv2aKcfsPKVb@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-5-peterx@redhat.com>
 <CAFEAcA_KaLtY21hnfAJimgdNFRiRBOLupsbshHpvXG7URgcKrQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_KaLtY21hnfAJimgdNFRiRBOLupsbshHpvXG7URgcKrQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 12:20:00PM +0000, Peter Maydell wrote:
> On Fri, 20 Nov 2026 at 12:49, Peter Xu <peterx@redhat.com> wrote:
> >
> > To pave way removing VMSTATE_VALIDATE(), move all four such uses into a
> > post_load hook instead.
> >
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: qemu-arm@nongnu.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  target/arm/machine.c | 45 +++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> 
> I think I'd put all of these validity checks into the top level
> cpu_post_load hook, rather than spreading them out across the
> vmstate structs (and expand out the _validate functions rather
> than retaining them). That also lets you drop the comment about
> there being an ordering constraint between subsections.

Will do. I'll add one pre-requisite patch to convert arm's cpu_post_load()
to use errp version first.

-- 
Peter Xu


