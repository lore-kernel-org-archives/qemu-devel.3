Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05897C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXKRF-0007bk-H0; Fri, 26 Jul 2024 08:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXKR1-0007MS-BY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXKQx-0002sv-Dl
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721998349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yezTynRGclrUQSM6OY+EIuWUKqt9v7YX+5YM6Gwd5wc=;
 b=Y80U90/KV7Emc6aNkZVrIMn4Zo2dZy+3PZPZSJAF3rfj2zQXyfWhPt8sp3kT9jVUs1sXp5
 NNCP1d2P9EuIX5KDvRYbajTehofCZbx84doWVu+l95y+5pja99wkKMOSq87v8MFQCnp4MC
 dbU2FJoUOa+sPJPx7ma2scC5uNe/dJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-IvNDODDNNg6wSeUbPkayzQ-1; Fri, 26 Jul 2024 08:52:25 -0400
X-MC-Unique: IvNDODDNNg6wSeUbPkayzQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427df7c3a2aso15020035e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 05:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998344; x=1722603144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yezTynRGclrUQSM6OY+EIuWUKqt9v7YX+5YM6Gwd5wc=;
 b=lRlqz+l145FrJxOUJjXNHlnL3jwxi3OPUywqMEDivu2I3QTgeBV5YqGxm1dAzjrtdI
 i5dbH730RJt43pFxJ5VZnp316aRTFm/0zCkhUHDQPmfhSre5UnIWrezEE6hA96Px+au7
 KB2wgvhs26i8zGwPqR67kMF552LgtaG7jqhYfrPYlZTaMx1h6rmio2lNhsuATzC1RjW/
 uZJ5P2qGgP306I9vfrLxtX+1GtWv0d3d55OQJYtVec/mqwp/Y1+Wb8tApL2zOBIpApgN
 49nNxiOh45WHJdWuR3ZNC0ltCDoSMqqZ5pulM0y2VgLxbZdrChThTNPAc3rGmOOEZGZh
 9PgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdwD466FrZ4F+Nv4fESRkVQHpvst4JDtPo4asQFef8hhv2HT5kcDr7VksJMNzAc7T3uwG2h2IYMOrko+czFtzN+in3sdc=
X-Gm-Message-State: AOJu0YyMoiUSW0ktq6o0Y1V05TPY1J2Sb2m3jfcMdnHcAEXRdrnXo5WO
 Q8TMH6M0EV7NtItfVfY4KgAXNpljxlXqJWqwWosZuTNHVZVj619+PvlmLzH1/QTlYoWB2T2Pt9Q
 tKoAFQAm1CzYNLj1NlbLB5PqrbrUygjtW7FGw1az+7CkRrG7L60TK
X-Received: by 2002:a7b:cc13:0:b0:426:6876:83bb with SMTP id
 5b1f17b1804b1-42806b94444mr35917385e9.17.1721998343798; 
 Fri, 26 Jul 2024 05:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeZtYe8A1GZTEmL+i7voXFimPt8dBDRrCiuydzX4tPFYqbNapaldNesLi/P0+Gt5ylw7JbVQ==
X-Received: by 2002:a7b:cc13:0:b0:426:6876:83bb with SMTP id
 5b1f17b1804b1-42806b94444mr35916735e9.17.1721998341579; 
 Fri, 26 Jul 2024 05:52:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36863b45sm5219141f8f.107.2024.07.26.05.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 05:52:20 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:52:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
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
Message-ID: <20240726084836-mutt-send-email-mst@kernel.org>
References: <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
 <20240726015613-mutt-send-email-mst@kernel.org>
 <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 09:35:51AM +0100, David Woodhouse wrote:
> But for this use case, we only need a memory region that the hypervisor
> can update. We don't need any of that complexity of gratuitously
> interrupting all the vCPUs just to ensure that none of them can be
> running userspace while one of them does an update for itself,
> potentially translating from one ABI to another. The hypervisor can
> just update the user-visible memory in place.

Looks like then your userspace is hypervisor specific, and that's a
problem because it's a one way street - there is no way for hypervisor
to know what does userspace need, so no way for hypervisor to know which
information to provide. No real way to fix bugs.

-- 
MST


