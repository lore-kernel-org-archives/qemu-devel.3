Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E95CC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to06Q-0002Mc-CX; Fri, 28 Feb 2025 08:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1to06O-0002MS-Sh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1to06L-0007bl-Qv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740748104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jivrn7Vdp6x4GL1b5ZxyJQKIN05Kj60F1xupGwdydvs=;
 b=ONtAW8x6SytFOAP7iYDc65MzHhZdEQ+Jr57bqx1GLWw7df0IMZ6ZQstHi5+eg2xdEGx5/+
 bDvjlvu3iHTQLya4oOQP2oE3orKgzuafVAHTYQLCE5XieIgaMbS+s8aPLGJb/slF8N+zmc
 f45p1OXTYPemp2xR8r05/yKzbrXAnqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-stR2WRM3Ml6uxenbIb5h9w-1; Fri, 28 Feb 2025 08:08:22 -0500
X-MC-Unique: stR2WRM3Ml6uxenbIb5h9w-1
X-Mimecast-MFC-AGG-ID: stR2WRM3Ml6uxenbIb5h9w_1740748101
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-439a0e28cfaso12309995e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 05:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740748101; x=1741352901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jivrn7Vdp6x4GL1b5ZxyJQKIN05Kj60F1xupGwdydvs=;
 b=Qx4mBzpE1qmZdLmGey6eIudop4rcWV4QJ8oQvOuGHvmwofdtoJOZPlmM/PuzLkRD2b
 G6BLip+mBszX1EmBPN77Aepeuz8KW5RgDjkDQZ5cGBqwg4D+H/vQ8VynUKg56loW3E9V
 OQ6+zxc0EpQuEU+22YnBKQt9ABA6Y6PffsMcONaUB2NkcwYPXlWmk5lwmOZGdJvHNIUn
 NISSy2GlbxR6ilkP96NnSwxzAA1X/sUm9y/iCgYlesWX+wCyZsVuSrMI/lBxOMMPQO3q
 BSMqGmOAm04PJkMMcdyR6jklyuBLIktzPi679gPRvKpZN4sDm7TOuLBcF1npVm2vSdNT
 U2CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR9Ru+iqRf5v3u5xjXPhRvVxdRHqE0Vu5hV2dpAdgGm/VWCsHo7+TqaNv7IouLWNpABivDoPxLIdcE@nongnu.org
X-Gm-Message-State: AOJu0Yw99nwHUV+XboxYNnC0o3V9S85UQmznajjK1LWS6yPr+mTKw/T/
 3w3dah5zWIIwQohyH2WqWaOihnJ37OSCVgpUJM0qweS9N3RIJ4kM7hMQ+GHNuKq46MCKojEloei
 GjCcSQeN0Fs+rWdOK482LFuzJGcGxgzMJI8mK5zkp9R6VYxbA6TICsiN6rHxk
X-Gm-Gg: ASbGncvEmh7RhkrDmV63Upg1CxlOVnhtrkJRTvXlY7NHLeHOvlpLu2KP5pzkiNjGbjw
 CcLQ6tbet3F0yit13CUKNLp8CwNebYdIRhvJYwoD5fvAz6EVJrH6rThcNdH9Fw4c9GZEHDZ29Ce
 3bgcBYyMbJ+Un+vWt6pBd/2+qN+wk5VCZ+i9zGD/LHWaYRC+cRD0oZS3R1Wf1Nv6UhRD2Hp1knt
 iJBArHFpnVg2XNRYxC9VSJ0zArDndwdkbAv/2pFrLshhO32WXmH+j/ZRU8Ud+peNoTzu0rEiYVn
 KnXjK2ppZRiXA4jY8uxRuSXFmRJVgP6g+3tgt6ioMq7drOrnu58UwLmuxHwsVs4=
X-Received: by 2002:a05:600c:1c93:b0:439:a1ef:c238 with SMTP id
 5b1f17b1804b1-43ba6704511mr27965355e9.13.1740748100809; 
 Fri, 28 Feb 2025 05:08:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdeugB0DYaeSGn2VbFG9q+ru+bR1PmY2MFJJnKraycPUMTshNrf3BW7rb+d9fMMTMfeMuzcA==
X-Received: by 2002:a05:600c:1c93:b0:439:a1ef:c238 with SMTP id
 5b1f17b1804b1-43ba6704511mr27964775e9.13.1740748100341; 
 Fri, 28 Feb 2025 05:08:20 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7ddesm5239888f8f.57.2025.02.28.05.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 05:08:19 -0800 (PST)
Date: Fri, 28 Feb 2025 14:08:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 18/19] docs: hest: add new "etc/acpi_table_hest_addr"
 and update workflow
Message-ID: <20250228140819.322e6390@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250228173608.0000779c@huawei.com>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
 <445f7d41b01ffc5bd79d6fd83bc7c4c621bcbc85.1740671863.git.mchehab+huawei@kernel.org>
 <20250228173608.0000779c@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 28 Feb 2025 17:36:08 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 27 Feb 2025 17:00:56 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > While the HEST layout didn't change, there are some internal
> > changes related to how offsets are calculated and how memory error
> > events are triggered.
> > 
> > Update specs to reflect such changes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> One minor editorial suggestion. With that or similar tidy up,
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

with nit below fixed,

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > ---
> >  docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> > 
> > diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> > index c3e9f8d9a702..4311a9536b21 100644
> > --- a/docs/specs/acpi_hest_ghes.rst
> > +++ b/docs/specs/acpi_hest_ghes.rst
> > @@ -89,12 +89,21 @@ Design Details
> >      addresses in the "error_block_address" fields with a pointer to the
> >      respective "Error Status Data Block" in the "etc/hardware_errors" blob.
> >  
> > -(8) QEMU defines a third and write-only fw_cfg blob which is called
> > -    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> > -    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> > -    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> > -    for the firmware. The firmware will write back the start address of
> > -    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> > +(8) QEMU defines a third and write-only fw_cfg blob to store the location
> > +    where the error block offsets, read ack registers and CPER records are
> > +    stored.
> > +
> > +    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
> > +    contains a GPA for the beginning of "etc/hardware_errors".
> > +
> > +    Newer versions place the location at "etc/acpi_table_hest_addr",
> > +    pointing to the GPA of the HEST table.
> > +
> > +    Through that such GPA values, the firmware can send back the guest-side  
> This confuses me.
>  Via those GPA values...? (maybe?)

it's not GPA here, it should be fwcfg.
Maybe something like this
 "Using above mentioned 'fwcfg' files,"

> 
> > +    allocation addresses to QEMU. They contain a 8-byte entry. QEMU generates
> > +    a single WRITE_POINTER command for the firmware. The firmware will write
> > +    back the start address of either "etc/hardware_errors" or HEST table at
> > +    the corresponding fw_cfg file.
> >  
> >  (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
> >      "Error Status Data Block", guest memory, and then injects platform specific
> > @@ -105,8 +114,5 @@ Design Details
> >       kernel, on receiving notification, guest APEI driver could read the CPER error
> >       and take appropriate action.
> >  
> > -(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> > -     find out "Error Status Data Block" entry corresponding to error source. So supported
> > -     source_id values should be assigned here and not be changed afterwards to make sure
> > -     that guest will write error into expected "Error Status Data Block" even if guest was
> > -     migrated to a newer QEMU.
> > +(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
> > +     when a SIGBUS event is triggered.  
> 


