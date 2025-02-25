Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424C9C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtC1-0005Kb-QV; Tue, 25 Feb 2025 06:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmtC0-0005KA-31
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmtBy-000349-8D
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740483216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koOypSBQkaeqPAzy8kIkTGkjrlguhVfuAhbYp4pbhDU=;
 b=ZKVw7yfflsIyZ6guKNfsYVMd5OzFAt+NonZlenEedzYlha75pB7JVbfrG+UuhlBI3S41fk
 VLGiflF7641+tDNUPF22D1vi/K3mVMS/h/1q+DW3GPE3sV6EUcTjj3RFlqitUMXQKJK2kA
 55X8nUxbcEhMJOhbCvtviPndVr4I3Q0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-zyIbWBjJMgegEl4B5ZbD2A-1; Tue, 25 Feb 2025 06:33:34 -0500
X-MC-Unique: zyIbWBjJMgegEl4B5ZbD2A-1
X-Mimecast-MFC-AGG-ID: zyIbWBjJMgegEl4B5ZbD2A_1740483214
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394c0a58e7so44478535e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740483214; x=1741088014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koOypSBQkaeqPAzy8kIkTGkjrlguhVfuAhbYp4pbhDU=;
 b=VGWad90IcVWiCTjIuwGl0PTMGzYaL7NNk5pDoJCcC5nZl00+Zgf3hol98/IVXnFbkP
 ZS3ybGrm71lECMI3pAeyVWRWy9dzVeY+sG3dCdSe0q6vr6seiiv++Vvl91J/Ie6MEmJm
 z1mbgOQhmhPeH4sOKuI1E8kkUbnQSHYIJREehadfWwH2ne7sz79cdn3hIhn44jqC1Vg+
 8Z6ifJgp3jOmbpSbAKraR+4c5cEpnNwUF6Q59CP9k8XjyiC368WN7qC3kTFu1Eui25KG
 VC0wvx3sa6NGbpuY2L14xubJOD81HfQ+IkZ6WYt2WmbdduPoX8k7CInbOKJ7rv2M6CIN
 JhcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTQ3vQ4tutxad6S9G9lrg1iIXV3602N08Vith6ii6fjxFS2imuOyl9RmoYK38q7oWA6otsSMCzUBuE@nongnu.org
X-Gm-Message-State: AOJu0Yy6gyegQSv10IoAy+LN5+Nte+/R69XrjQOwPnbzjXDpxQuCwf59
 3dCAlzCW8leCBhmgG4DqcnsggSsW+5bjPZIYnFSxfvqjhDfZOWwETtG0NOgx3mBMBR6QDtdX5OA
 FIANs15lLkByrbWH6jxsKD3r5KHGwqf7vvfKBpB15RydINpGboa9W
X-Gm-Gg: ASbGncvVQEfSg09F8uqBNAf7jtSUWIXRiLhvwRfQwv1sUxnvcCimlkdU3XFkgNpJBqH
 w/7MBQcP8P74unh50o6MgzwStdxZ08DxFmma2GeMUzPYCH40RY9ERCrvcMmD7DNXygjiAkVskSX
 5KltGpCEdmHdgUPRD3OONcLsw52+PxniU089PWGNrHVemUeXSnnweFWd7X6pIvI3kZ2SUKAd/pt
 0WTTkJHhZae8SSMLWJDVA9H4aLW4yfzRxul83nHjETRS36iJEMFY57p0LkNd0CEcmCWqG0L4lGw
 +jqrmDNZJLAMjAvqE3nrfQK7YvqsV2AiUg0IhLJN5PirSyeH4fvQgIG5C37QHwk=
X-Received: by 2002:a05:600c:3b04:b0:439:9543:9491 with SMTP id
 5b1f17b1804b1-439aebcf126mr123007025e9.25.1740483213666; 
 Tue, 25 Feb 2025 03:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKv0Rb040W69aanjxzjRYk6wWRbquiAVsqiTHYubPS5jl1n3dQC5Q0A7tc4mRT5LeKPBlEjw==
X-Received: by 2002:a05:600c:3b04:b0:439:9543:9491 with SMTP id
 5b1f17b1804b1-439aebcf126mr123006795e9.25.1740483213286; 
 Tue, 25 Feb 2025 03:33:33 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce615sm138270955e9.5.2025.02.25.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:33:32 -0800 (PST)
Date: Tue, 25 Feb 2025 12:33:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffman <kraxel@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <20250225123331.69472379@imammedo.users.ipa.redhat.com>
In-Reply-To: <f35r3y76jdfjonw64yqpus6leeew26lmtct6wkyaazpaya6vny@nqgldtn3wlbg>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <xhprkjs2yj5yli65opi7md7gfylqxgdkiwap76stcxcx7jdpub@fauqiqm5giyi>
 <20250225112819.7cb8b32d@imammedo.users.ipa.redhat.com>
 <f35r3y76jdfjonw64yqpus6leeew26lmtct6wkyaazpaya6vny@nqgldtn3wlbg>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Tue, 25 Feb 2025 12:00:12 +0100
Gerd Hoffman <kraxel@redhat.com> wrote:

>   Hi,
> 
> > > See https://lore.kernel.org/qemu-devel/20250219071431.50626-2-kraxel@redhat.com/  
> > 
> > After looking at it, it seems to me that data will be in host byte order
> > and guest has no idea what that is.
> > Probably it should advertise byteorder as part of the structure,
> > and guest side should then do conversion if necessary.    
> 
> The structure is already defined and in use by edk2, so changing it is
> not an option.  Guest is little endian (there is no big endian UEFI).
> So simply declaring the struct fields being little endian byte order
> and convert them if needed on the host side makes alot more sense here.
> I'll fix the patch accordingly for v5.

given it's memcpy of blob it would be hard to do so in hardware_info_register(),
doing it in caller is error prone/constant source of bugs
(that was the case for ACPI tables until endianness conversion
was hidden behind API).

But if it's small number of places perhaps it's ok to do
conversion in the caller.

or alternatively instead of structure, build data as
a table, similar to aml_append(aml_int()) in ACPI,
which will take care of conversion.
Ugly? yes, but it takes care of endianness bugs,
as practice showed up.

PS:
if there is a doc for etc/hardware-info, then describe it
there as little-endian (so reader doesn't have to deduce
byte-order, it's ABI after all)
  
> 
> take care,
>   Gerd
> 


