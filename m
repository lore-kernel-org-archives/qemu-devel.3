Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A865CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqvm-00021A-Fl; Tue, 26 May 2026 08:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRqvk-0001zw-F2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRqvi-0006Aw-67
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779798640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4bVYAnF29BfAS5vKoHoo9LJQROKcbMWCEtI7vFdSs8=;
 b=IAaNqoHtsZjIaQt+5WszK1uKt3vq4/+jFZHhEJZgKnellDzifSfnWjly3bhC3o4R2x/kV9
 uJj7/qwTc7ms8DkPu1FAxo1RsBGq6vkSbsotO5xwraOJ37r9Sz8PosFcjrHXEsabrF/tBo
 5qCSb2ScP8zB26cKg87Y130oVUfRIZI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-u5SK9eXxOC-Yfn40Fjvqxw-1; Tue, 26 May 2026 08:30:39 -0400
X-MC-Unique: u5SK9eXxOC-Yfn40Fjvqxw-1
X-Mimecast-MFC-AGG-ID: u5SK9eXxOC-Yfn40Fjvqxw_1779798638
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44b186b715aso6555274f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779798638; x=1780403438; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a4bVYAnF29BfAS5vKoHoo9LJQROKcbMWCEtI7vFdSs8=;
 b=q8PtmSDoitb+DcjR7NSba63bqAWvAl8S5KdlqOZYbI4SDWP5D+9YuwOLUd7AFtcoZ+
 5fN8b11iR9Z8OqIaMuvf2IsvlXY3mb+jN/bnbtyG1WCN7pkpiOxtM+bxaGPANQMU0J3V
 9YusNom9/1PQPWlHzbm9ne0BSuz6wUhWjnpia9lEODolhdQ3YWkDfLRuibKg32zCrlXJ
 9tuVso5IMbdhV0YYN6sRRFIqtrxV+9xqLYZBFJbC0NSeg17BeUV4RMopuXpQnosXmeOd
 goJqEf35tHOsQ2raQyuoZlZ4X9XbPdtPXEGMxbew5fOYzZLJ/P2NBnERKppCR4YkUOa0
 fnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779798638; x=1780403438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4bVYAnF29BfAS5vKoHoo9LJQROKcbMWCEtI7vFdSs8=;
 b=lx2Ie63V0AHobzzRMf8I2uZgbQQGzVNwhkl7LlMQHhYXuR77DGEeBdagtwENbPduJo
 fyZ3WFZo6jmvTuesC7+2lAyrp6zSuQGgLWCAK2pebE9LBIzv39LLxRh7lhOfvQ3+FqjA
 Lw8tFPToNoiQrUwUnGkxU+y2iio5pZTPu7e0l+yLFAVUiw59OQ90E6BvqKMGECkCZt3U
 DdvfjckfPtz8hDwbM5dH2yOhbTE5uiCJJcFcNHKC5LcuClU30FWUQAEV5A9A/IPa3xhu
 3eiOE/S0IcecH/UdfHxeb56kyXaFgbPo2W/OMqOoucjMj+oqTlds3myeQV3/gC2ism0k
 eNZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ88P506KDxpxHUoyKw+LkMlKhpzfDW1fKbPg3JaRjdFJSM9HCrAWhuCDR8prE2Ii9CwAqA1AdfuyfGm@nongnu.org
X-Gm-Message-State: AOJu0Yw7Kn6MLhzA9v5mdlBCfnZMc202cn/R488Zwd9fMVInFFwA/Dec
 DmlZF2b2zDt6qQwOhzMvOVBqX2eA8skhcii8XEdwDHtTUilYJzYlAMhThNzJJe2PX+/St5zt1YM
 77vpTZbcCxNv8ymG/Itey0PaRboyudx/rNRepXqd1RMmiZCAJSWyNAwGTetEu43Bk
X-Gm-Gg: Acq92OHmHD/3SAxH1OgmYDT4jY8aBfFIkZKi1G/+6CjPpJF61TXoZ56ikBlMDo0AeYy
 GnZcOL71A8EEYw6ct3aDyYHF7+jvkxLk9kWO1EJC7DJLoCFc2R+yK8DVvcHpHFFZ/2ogfyIDaCa
 OOhu7yJ1TfrXhdjry0DwOOsGZjXgXseWcRpvvinykqctbM6zZse2mjea3ouhvHj+eK1NXeKmYvv
 8GkuSKwskb+FpkMmf/UiJuPvuQ1nVAneuCoyAg5EiR1bYDGgXb8bScgvsMW0RKbXqcy1amWKPGz
 9UIIwpp15RPvbzpp9qn406YPXi+mlk7wc+76dPbnN3WQP4ZpKhlpQkwy8cvj9/UsGOmWalAiXLW
 PsTczCw5HpBB4GTR7EfMJ33Nw1/quPNbyDBWlA1XZNkax8TIsQuI/uw==
X-Received: by 2002:a05:6000:4283:b0:45d:8c16:5566 with SMTP id
 ffacd0b85a97d-45eb38baadbmr29840754f8f.18.1779798637818; 
 Tue, 26 May 2026 05:30:37 -0700 (PDT)
X-Received: by 2002:a05:6000:4283:b0:45d:8c16:5566 with SMTP id
 ffacd0b85a97d-45eb38baadbmr29840696f8f.18.1779798637328; 
 Tue, 26 May 2026 05:30:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ed8873a35sm4383793f8f.14.2026.05.26.05.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 05:30:36 -0700 (PDT)
Date: Tue, 26 May 2026 08:30:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Hajnoczi, Stefan" <stefanha@redhat.com>
Subject: Re: on ai generated and code provenance
Message-ID: <20260526082814-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
 <CABgObfYSy-sctHcUW3hPxQZ8ZGOYHLi3HaW+FrEQ9kKitMAVZg@mail.gmail.com>
 <e875fb45-9697-a6d0-fbe0-d0531eb2c911@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e875fb45-9697-a6d0-fbe0-d0531eb2c911@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 26, 2026 at 01:27:40PM +0200, BALATON Zoltan wrote:
> Maybe clarifying this in the policy could be
> done although there will always be people who ignore documents.

One advantage of the linux style tags is that at least they differ
from whatever ai's put in by default. So whoever does it can get
banned pretty quickly.


