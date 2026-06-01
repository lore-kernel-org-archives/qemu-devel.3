Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA16CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1vo-00064C-Ue; Mon, 01 Jun 2026 08:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU1vm-00063z-JC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 08:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU1vk-0002ol-W8
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 08:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780317583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmB1fssVcWQrJg6zd/ODLvwAzXBTPjvao4pMKJwoRy0=;
 b=ZU2OfvIG2IwPbrQRWm/1UymyjJGchi8QmJm+07uxF7wOtpF91Ae7Mjz0fDSgbcRigH6UxZ
 ZHOcuxYxEveGhX3z3ctMCVAa3jgkIbr7SxeLb8w05V9anbKain/C3Ipk9/id5Sta+3/mP6
 M0oJkJAGLqEgkpUszdUD6WuFf6GVKPc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-w06Lp8hPO-qyB2KHXAm6og-1; Mon, 01 Jun 2026 08:39:41 -0400
X-MC-Unique: w06Lp8hPO-qyB2KHXAm6og-1
X-Mimecast-MFC-AGG-ID: w06Lp8hPO-qyB2KHXAm6og_1780317581
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-460163035e3so223874f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780317580; x=1780922380; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WmB1fssVcWQrJg6zd/ODLvwAzXBTPjvao4pMKJwoRy0=;
 b=a0HUo2qZM4BFLjgwETyIIRubzyEWQWMllhh16Op7GMeUM7GCCNAj4YGpadyVHNbawT
 VJJsiMDE9AEvBckPJ8BpO3PWXxDEUnnx7zari921dhEjNaxBAPfHyONewyCtgpNPdGgx
 /fzYo+l1E/tLgqqlkfA/Na9Z9nEsjGkHoSj4YCuTkiLFuIH2x2o7boLLuRg0hfaCSv6b
 oPQoeTsUiycuDX2HHi8+HLU5Fq2ypTzXV1cXTe1TNsfcU5/1jfNTCiD8U41UX/d3TKsI
 DrrFS/iMoWix0u/mIDInuhM96ZunAok+xuKeimkJxYbqfzO3eVfe/ezOCoGpnCVIN23E
 eI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780317580; x=1780922380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WmB1fssVcWQrJg6zd/ODLvwAzXBTPjvao4pMKJwoRy0=;
 b=ZuYD1Rqa3WqfO5KZRShog8NXlS6dEB46DVVL+2xQMAs5xgZJpvgiPiT8ur2V2yD3jT
 FinEFmmgi/pcXzEOZPiOkJ/DtKYXDvGSMisN8YUwJxF5Z3qSuirdUvtV30hSTBZrOXPd
 28uLS25V4XfZOXt0xbSHU0RI3MOTqMW7yIezlKhbCuQiEQG6JtvH1DIT3kWKnosP01JF
 WlvJEL07VFqEnrRT/0n6XG/GoLWCv0rTrCYS2oS2162+c0+trCjAY2pLGvB24oqWwUtX
 DBbGew6YYbuZJ7FZmAHo/xgBWa+uQYr0ri1LJnCsnTLRMXHABq+gZ5pTh3V2MHhD+t0V
 9Yow==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uasGvu9Me9E933UCoUDh4jkDq5TDMbfk/WDhv6+Qzeal9TMRSIuVJYKI8xbHIZEDwW15nEvKQ/Wo6@nongnu.org
X-Gm-Message-State: AOJu0Yw3oANa1Vlog6H+e71jQaHRDTSY3S7QwZdqmuuu3+M9xaVl1WEE
 by8lvLErput2ASOJnR2u7Fmjea5jakUPoMUd4xOc7+WpcUPwJrqKHz4OPbaSt1Ycl3oqiKALoTA
 hEvLSTpE/XpFliNLwKSIY7Cpsto92ySanmAX3pQdPifl+0ZwSggXnfcZm
X-Gm-Gg: Acq92OH0KySOHn9tPTa9AYu4VHdkq1hkyA6DTc+PWcYu3aUaGOjyaxJBlSD+NdTFxT5
 D9hQbslZ3fS2JcycYqOSRdal17fZ27MLzaUpVxkYGk2EQBqEnfdzV/6fervOq88U4xrb5IjqA3p
 ErK/SlTDJniRMnYR6SUXV4uJg5PXByn/4rcmBKtCZBACV/p8BGv8PsYnfj8FGoZjVC/Dd27XQUr
 jEBxSViut/W50zWEl2BeUyjRVG4UKAqWlQBoBMXtTQYynvpcwkJ7UzbVcTzyhaq+TViAJYsy2FK
 pw7cOn1Yl8M22HWL9SoZ9oy+P24Atx+QlZgd3lh9txm7bnp8wMYLuObPF9axVXfd6AL+leYvtJi
 l2PRDqLlXG8sG+VKBXqBKvki6dnYOevRi2mfvdc0l0Qxaj5VUIdgyog==
X-Received: by 2002:a5d:58f6:0:b0:45e:e50e:3bc with SMTP id
 ffacd0b85a97d-45ef6b71573mr15860116f8f.29.1780317580342; 
 Mon, 01 Jun 2026 05:39:40 -0700 (PDT)
X-Received: by 2002:a5d:58f6:0:b0:45e:e50e:3bc with SMTP id
 ffacd0b85a97d-45ef6b71573mr15860036f8f.29.1780317579786; 
 Mon, 01 Jun 2026 05:39:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm26259386f8f.29.2026.06.01.05.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:39:39 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:39:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260601083628-mutt-send-email-mst@kernel.org>
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
>  But also because, in my opinion, separating
> the specification would improve development agility by decoupling
> specification development from QEMU's review and release cycles.

Generally for QEMU this will be less agility, unless I misunderstand
what is proposed)

Because presumably there will need to be spec releases then?

So
	new feature -> spec tree -> spec release -> qemu implementation -> qemu release

is surely longer that what we have now.

Whether there will be more agility for non qemu users will depend on
how often spec releases are cut.



-- 
MST


