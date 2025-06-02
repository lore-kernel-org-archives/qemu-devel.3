Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7C7C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 10:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM2Jl-0006HQ-KF; Mon, 02 Jun 2025 06:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uM2Jf-0006Gg-GW
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uM2Jd-0005rs-Rx
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748859768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKMj/dmcZFnIoX+/jXJwdMyeYm/ORc0hdxg4CxCECwk=;
 b=Q0QXgeEHE8JrwbFxBCIH2P+xB/V/6ht8I78e6IoB03ZVh9k99z+qasneDXwSkG8HsKDQHP
 jFTDZeS2UIJvQ1F0QyW/SupSHCzEcvl9GJlBBrCOf+t70vzoFnGItp9mmpVCdGpV053WDH
 cCbO5J4RxW6s85uyML6N+ULhg1uTOyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Lsy6AbuwPg2-AyLbapAAIw-1; Mon, 02 Jun 2025 06:22:47 -0400
X-MC-Unique: Lsy6AbuwPg2-AyLbapAAIw-1
X-Mimecast-MFC-AGG-ID: Lsy6AbuwPg2-AyLbapAAIw_1748859766
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so10277595e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 03:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748859766; x=1749464566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKMj/dmcZFnIoX+/jXJwdMyeYm/ORc0hdxg4CxCECwk=;
 b=BqOn667ydfElydO/lSBQ3qJtWfEzHAcyhMX8hGhbuoH+WVo8fhC3My/H7cH1r9b18b
 aCxrpgdW58TC1AYjRyVnBfPH4kTaZuQvihnXZpN8MHTaevhrUBrklavciah6CgFpCK0g
 2tDVSusfiYvqNGqeCHyV45idLAjMGL5hDxzqqAXseXw8oruuwudKRlHswHC5d3+47Es3
 UY+kLmQTcYeIjUnouqSvjHZuQqPbPAyWilNi0q3ucFUdXH71u7LeFkuQorPb/EfTDKdP
 KKL31r/sHE9nHUD2TaffhuLr5jTX48ghtZK38581ySnoMRfThkMfEyxA+oQprLr7UZwu
 l4zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOPa/+/YXCG6D1VR08dpNB+h7gJSXb62BLEVzR5E4dALM+fa5uCi9rCIhggy3meoXPJ9PRAo046NqL@nongnu.org
X-Gm-Message-State: AOJu0YyS0uSdx1Csb4Ap4CxYSioYkwBZf2+jN67peBnZnU0YgC0v9iFz
 qj+onAn4nPa7T5GBVysw20lg968E+CU2t4USHEvGNrEYuPUkGtmBS2h0UGODGG+BSKXT+SEaw4C
 9FjK3rEv0FP9xQ1mA+gEO+wOZQ3IiIA429vm99ioqAMC4dafedV03iIx/
X-Gm-Gg: ASbGncvNI6Yhv2EmiOGcfI1gB9Op7PXomZhQs2evPb6Uzj7fKmfA7ktkKV/fEh7nOHq
 nuze1yFXO8cW/7g1FDRoYF3H8sp8CTLf4tFsz5SoN5itXHZdq+XDjGImxjm9Ebu+0AhB1uY7hz+
 2DA2OgHV1/DC+AViPbjzx1zuIwmy5DUT//eqcOnkyAmudBao7170WsRfR7mZtR7cUkx4VzSsFcG
 oh6ttOcYDmY6C2s8fAs2QFz1kKY3zeXUmGOg5BjPExUVLEEEN6YVABTA405HI84+qjfB+VrcKyx
 7OJ0dAi6mrRanA7/oeD73IjsqcVSUGkF
X-Received: by 2002:a05:600c:1c08:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-450d64e2cedmr95031915e9.6.1748859765969; 
 Mon, 02 Jun 2025 03:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeawgvYHwXYBD7Ncx6S/vt4KgrtY/j8BkA9OdXSa/4ZY4UEAQYaLMSnHOrNdPF14e7MUUAoA==
X-Received: by 2002:a05:600c:1c08:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-450d64e2cedmr95031585e9.6.1748859765515; 
 Mon, 02 Jun 2025 03:22:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb80f6sm115820455e9.28.2025.06.02.03.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 03:22:45 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:22:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/20] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250602122244.081a1960@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250530221810.694ce02e@foz.lan>
References: <cover.1747722973.git.mchehab+huawei@kernel.org>
 <aa74b756f633dbee5442cf4baa2c1d81a669d2f9.1747722973.git.mchehab+huawei@kernel.org>
 <20250528174212.2823d3de@imammedo.users.ipa.redhat.com>
 <20250530080120-mutt-send-email-mst@kernel.org>
 <20250530164903.0f9f8444@imammedo.users.ipa.redhat.com>
 <20250530221810.694ce02e@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 30 May 2025 22:18:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Fri, 30 May 2025 16:49:03 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 30 May 2025 08:01:28 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Wed, May 28, 2025 at 05:42:12PM +0200, Igor Mammedov wrote:    
> > > > On Tue, 20 May 2025 08:41:31 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >       
> > > > > Create a new property (x-has-hest-addr) and use it to detect if
> > > > > the GHES table offsets can be calculated from the HEST address
> > > > > (qemu 10.0 and upper) or via the legacy way via an offset obtained
> > > > > from the hardware_errors firmware file.      
> > > > 
> > > > 
> > > > it doesn't apply to current master anymore      
> > > 
> > > indeed. Mauro?    
> > 
> > Michael,
> > it's trivial conflict in machine compat,
> > could you fix it up while applying?  
> 
> IMHO, that's the best. The thing is, as code gets merged upstream with
> backports, conflicts happen.
> 
> I can re-send the series, if you prefer, as I'm keeping it rebasing it
> from time to time at:
> 	https://gitlab.com/mchehab_kernel/qemu/-/tree/qemu_submitted?ref_type=heads
> 
> (it is on the top of upstream/master)
> 
> But even that might have conflicts on your test tree if you pick
> other patches touching this backport table:
> 
> > -GlobalProperty hw_compat_10_0[] = {};
> > +GlobalProperty hw_compat_10_0[] = {
> > +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> > +};  
> 
> (this was the code when I sent the PR. When applying upstream,
> such hunk is now(*):
> 
>  GlobalProperty hw_compat_10_0[] = {
>      { "scsi-hd", "dpofua", "off" },
> +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
>  };
> 
> 
> (*) https://gitlab.com/mchehab_kernel/qemu/-/commit/08c4859f8c6f36d7dccf2b773be88847e5d1fe0c
> 
> If you still prefer that I resubmit the entire PR, let me know.

If it's the only patch that needs rebase and doesn't affect the rest,
I'd say there is no need to spam the list with whole series respin, 
just post rebased v10 12/20 as reply here

If it's more than that, respin series.

> 
> Regards,
> Mauro
> 


