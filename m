Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D27C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGKl-0004Wt-AY; Tue, 06 Aug 2024 05:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbGKj-0004O4-2H
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbGKh-0001A1-2m
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722935897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y59hN2s/MNY6Pe91xmrj92ENgow4G095yCJtbOBOOcs=;
 b=RHPVGvE7azHwxSXxKi2b4KSBp0KO2mTjLznSz4CzMtLyFjYrQYCRrjR1XhvCA1Q9kblHLb
 eNhrqPOdJC+1ujeU+LO3u6b/7BRdGyHq3qBv8lxnHIoanoUz2BSaQqJsfKp59zpdZHEHjq
 B3wF59ADO1ZgRcbBCa+XyMZCrwmwjaE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-ICtApOKcM8uVsxlnd2CBSA-1; Tue, 06 Aug 2024 05:18:14 -0400
X-MC-Unique: ICtApOKcM8uVsxlnd2CBSA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-428e0d30911so3709665e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 02:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722935893; x=1723540693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y59hN2s/MNY6Pe91xmrj92ENgow4G095yCJtbOBOOcs=;
 b=BucM8JDJ4HUXG3w13ZZMG/Iei9szD/8EKSn5QhIL3YDn3uMpNmOguOa7DG82nN9Qer
 zibRbtIe2fd7Bhh7oc2kMPcPpTWAB6gfpTrwQBf2X/2KCfKnjWmofB4GRPzczLqyd0xe
 ceillVnEq6dN+/ClYPIWqI4Tl6y15W1WX8kFOYGVjwH1VHrfvaCA9BC5yo/llNPK98pj
 zxOrhb1cY9K5A6GbV21aWgSkQP8xLO9gUFSyJXzBMB9B+B4YkERjSYj9kpWt5LhmwJRg
 tBoK7iTfY6tlN5VYP8keBcYxBB4iHve9AbPqJiDbOaISZFf3DYDhg6gGiqL2VoN4rsKg
 fqXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDQvKD8rRrzAQLJICQ2m8WFxXQN4yIgNCoTAyZyhODIa1sGdTNQ5rpCPuXXvi1yQt0AVWWbjwwIkKsekJbX4Mdv6JMyzk=
X-Gm-Message-State: AOJu0Yx1lYpL8ucZvnFfUjv2Wv0znui9kqP97OBUT3/slcZt8gdDn1Kz
 4q4QV3WiCEqWnUTJ1dXCCs+2rPkyVGdYzH3Tn8K97iu7os8xqYxB1EnRCQCNsvW0V5Vt8CJxBYl
 Jp1pigbJndGEJP9aOi/u7R6sqIV2X+oIWMt11YTRZu0vhnCL7Pv0Y
X-Received: by 2002:a05:600c:3caa:b0:426:622d:9e6b with SMTP id
 5b1f17b1804b1-428e6b7e5ddmr108736185e9.23.1722935893258; 
 Tue, 06 Aug 2024 02:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvysX2vltXK8sXDEyjf8yRaX+R57uey5E5z7HEyphW/MiuBtAMi/U71enPWHJ9RzN/4Bfl5A==
X-Received: by 2002:a05:600c:3caa:b0:426:622d:9e6b with SMTP id
 5b1f17b1804b1-428e6b7e5ddmr108735955e9.23.1722935892704; 
 Tue, 06 Aug 2024 02:18:12 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb64b84sm231279505e9.32.2024.08.06.02.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 02:18:11 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:18:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240806111809.10bc2406@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240806080928.5a04c550@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
 <20240805175617.000036ce@Huawei.com>
 <20240806080928.5a04c550@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 6 Aug 2024 08:09:28 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 5 Aug 2024 17:56:17 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:
> 
> > On Fri,  2 Aug 2024 23:43:59 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Add error notification to GHES v2 using the GPIO source.    
> > 
> > The gpio / external interrupt follows through.  
> 
> True. As session 18.3.2.7 of the spec says:
> 
> 	The OSPM evaluates the control method associated with this event 
> 	as indicated in The Event Method for Handling GPIO Signaled Events 
> 	and The Event Method for Handling Interrupt Signaled Events.
> 
> E. g. defining two methods:
> 	- GED GPIO;
> 	- GED interrupt
> 
> I'm doing this rename:
> 
> 	ACPI_HEST_SRC_ID_GPIO -> ACPI_HEST_SRC_ID_GED_INT
> 
> To clearly state what it is implemented there.
> 
> I'm also changing patch description to:
> 
>     acpi/ghes: Add support for General Purpose Event
>     
>     As a GED error device is now defined, add another type
>     of notification.
>     
>     Add error notification to GHES v2 using the GPIO source.
                                                  ^^^^
did you mean: GED?
>     
>     [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
>      rename HEST event to better identify GED interrupt OSPM]
> 
>     Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>     Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Regards,
> Mauro
> 


