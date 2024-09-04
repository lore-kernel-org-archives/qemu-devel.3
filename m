Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BF9CD4F32
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 20:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slx3c-0008N8-PT; Wed, 04 Sep 2024 16:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slx3a-0008MZ-Kl
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slx3Z-0000la-7e
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725483408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5tRR6IrjwMPhp8XdzXoaz4olRdtT9CWt9HgGHxwkNsk=;
 b=Oqet+h1EiA4y+5/eyDGBVG5Da23FgUMrwbq74R3sgwnQVUDI3+wvyaukJBhYXB2Q1UEUfC
 FSs+dYZ2pyMTZdqu1QIrPcVmkqhYP8521WHpSEa8drIpBozKsDN0Lw8OEfwGI4KQ1IDiIU
 URJbPa1d3FI0Z5qr6obg89bb/j7f1yM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-_aQ_xSqfPneFlN-ZliV90Q-1; Wed, 04 Sep 2024 16:56:47 -0400
X-MC-Unique: _aQ_xSqfPneFlN-ZliV90Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c360967e53so573506d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 13:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725483407; x=1726088207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tRR6IrjwMPhp8XdzXoaz4olRdtT9CWt9HgGHxwkNsk=;
 b=kqjPomnnCIr0ubhMZuH5xFfOnbK5CU4RU+XNn3kvuU6q2BULMkIydqR1sl0GOMcf1C
 ab8kU6f9dvLNz1hnUw3QX4YPAkMnnolT1ExTDBnzFtmxP//ONtJlVKv+mfXQo+Eir/Xz
 SoKiBNoPoDOcuAeEnp5cdNVd4A8Y7TkiMQYhBrwHgW4HyTl78DrN3QIQh7RTq/Pg6Bpf
 EkMie1vkPrwGl2DQw21t93wuMEf6vKjis1fCn6Ibiz7Q0XCmDTsGOS/YomlSs3EKhijI
 jz8mMgtZmO1bq66c1ZLrwXhsfx/wZsBqaS8hstRVA6UJIUb3dRDsRdsvBnfWxJEnSyRe
 aoAg==
X-Gm-Message-State: AOJu0YzHXU5kKcj4ONQp39hclncTshkWAvvfIHo499TSfvfAftx665E4
 jekQU8UIGeBNtTq0jy8UPa+1Z2QfVdAjaQPL8PfIsrYYCuhxmA5S0C+YpqXfPSGU6yFVSey/gUt
 RZyPzJXwquqhVfU2PxrX+wkTRV39zoPcLUUFfo06rqXy72c8erNlm
X-Received: by 2002:a05:6214:5bca:b0:6c5:13f0:2419 with SMTP id
 6a1803df08f44-6c513f02cc6mr56512496d6.24.1725483406822; 
 Wed, 04 Sep 2024 13:56:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBxKxn7jLEcnN5xsfUzoNbQuFUsmEGZIEBCGBolj3zGGI8PjSGMhH4lQ3Mv4wMg5qicsVc/g==
X-Received: by 2002:a05:6214:5bca:b0:6c5:13f0:2419 with SMTP id
 6a1803df08f44-6c513f02cc6mr56512346d6.24.1725483406434; 
 Wed, 04 Sep 2024 13:56:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5204189acsm1785696d6.110.2024.09.04.13.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 13:56:45 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:56:44 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 2/4] KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
Message-ID: <ZtjJjEpoQq-k58ry@x1n>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-3-peterx@redhat.com>
 <06d4a880-79a5-4cba-b318-aeb8aec7e5e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06d4a880-79a5-4cba-b318-aeb8aec7e5e1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Wed, Sep 04, 2024 at 10:39:19PM +0200, David Hildenbrand wrote:
> On 04.09.24 21:16, Peter Xu wrote:
> > Make the default max nr_slots a macro, it's only used when KVM reports
> > nothing.  Then we put all the rest macros together later soon.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   accel/kvm/kvm-all.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 991c389adc..e408dbb753 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -69,6 +69,9 @@
> >   #define KVM_GUESTDBG_BLOCKIRQ 0
> >   #endif
> > +/* Default max allowed memslots if kernel reported nothing */
> > +#define  KVM_MEMSLOTS_NUM_MAX_DEFAULT                       32
> > +
> 
> Any reason for the "NUM" vs. "NR" in there?

Sure, let me do s/NUM/NR/ all over.

> 
> Something that resembles KVM_CAP_NR_MEMSLOTS would be a bit ore consistent,
> because the 32 is essentially the fallback if the capability is not
> supported.
> 
> Apart from that makes sense
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks,

-- 
Peter Xu


