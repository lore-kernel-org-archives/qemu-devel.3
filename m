Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F178C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 15:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sY5ks-00018L-5l; Sun, 28 Jul 2024 11:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sY5kn-000167-9p
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 11:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sY5kj-0004mS-DV
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 11:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722180242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5bC7CjlZdsdHI4lvHiT2ExOZBWJ7XMhmuhfoptCNZqw=;
 b=dcT+0eM8BW7APhf0SQlvSFgEGeGTGM2vi8sD/0ZaVLUCS96cyeSh5EAC6kCj6QYNaxx/WI
 Afl6CtwiI08M/Tf1qwzRF1Pq9MnTpfkALAjRMU7knEbxZ2w1eWQBnxN9KIljmvF17lEMZ5
 kixlI7Ox6S1Mzcht22PUMcTldXuNNXU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-q6kKUKrvNi-YU1BWGd0X8w-1; Sun, 28 Jul 2024 11:24:00 -0400
X-MC-Unique: q6kKUKrvNi-YU1BWGd0X8w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e9557e312so2126017e87.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 08:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722180239; x=1722785039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bC7CjlZdsdHI4lvHiT2ExOZBWJ7XMhmuhfoptCNZqw=;
 b=UkECjARPSAcOaElQmNViUHMQrXEy0VjZJpoLhnegnkJdUmtkQFYSOMo8VIrYaSt2df
 B5QAcV9etMlZgQpc52uzqYsZU9evQtohDCWKyzNGZVqpomIZ/r6+HX8A8bzkhHX7PgYC
 CoM17vDjUr2fiRyC/87pGeELq/KnhUaNDzB00GJrjnZshCHT+xGohSZYJcgr3KYm7oDQ
 hQdMROYUj0iyCJis4xvCmeII19SZiYBOjDCjfIGznLloUjbOD4bTWLprjufdgH7+8Y5A
 72G8j8pDdYAh5bfhjmf00eKwIQo/uHFkxpbe7V+qxl6LRCfpsmbyIIbBuzKTUA5oDXy8
 gMTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy1kRTTLqzBPux7sLykArNybYafsUA1TBpnQy1m7OPGtXM1KBQic17+zkRfjbWmbusPcm8g61u4jQR7nRYQxXKreY/xJE=
X-Gm-Message-State: AOJu0YxYvliVN9288IUVWPaDD03HeoTmi9Tz3y4Gp4pgo5A+f+cnkQQI
 9HCSmIivyHLt3FeHexp+WjitrjJUD2KPSyBMq9xk0UcxeoCPCS/56GyXcWTz/0irtNOGvhSealG
 IhlNdH0MjYQ2UzPeDa/NSo55PZFXOz0ojtqgxnwwQB4790Kc6Jafx
X-Received: by 2002:a2e:be22:0:b0:2ef:1c0a:9b94 with SMTP id
 38308e7fff4ca-2f12edfddc0mr34329351fa.16.1722180238923; 
 Sun, 28 Jul 2024 08:23:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU13tBt+N37F7ob3Jx0ruuvo8+dsNp9muZtzaqjHOl31gS3qTrnO0jECcjoxvWesNrjNQyHQ==
X-Received: by 2002:a2e:be22:0:b0:2ef:1c0a:9b94 with SMTP id
 38308e7fff4ca-2f12edfddc0mr34329181fa.16.1722180238084; 
 Sun, 28 Jul 2024 08:23:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:98c4:742e:26be:b52d:dd54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428054b9196sm147521925e9.0.2024.07.28.08.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jul 2024 08:23:57 -0700 (PDT)
Date: Sun, 28 Jul 2024 11:23:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240728111746-mutt-send-email-mst@kernel.org>
References: <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240726174958.00007d10@Huawei.com>
 <811E8A25-3DBC-452D-B594-F9B7B0B61335@infradead.org>
 <20240728062521-mutt-send-email-mst@kernel.org>
 <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jul 28, 2024 at 02:07:01PM +0100, David Woodhouse wrote:
> On 28 July 2024 11:37:04 BST, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >Glad you asked :)
> 
> Heh, I'm not sure I'm so glad. Did I mention I hate ACPI? Perhaps it's still not too late for me just to define a DT binding and use PRP0001 for it :)
> 
> >Long story short, QEMUVGID is indeed out of spec, but it works
> >both because of guest compatibility with ACPI 1.0, and because no one
> >much uses it.
> 
> 
> I think it's reasonable enough to follow that example and use AMZNVCLK (or QEMUVCLK, but there seems little point in both) then?

I'd stick to spec. If you like puns, QEMUC10C maybe?


