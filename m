Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79622E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 10:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJVVR-0001MH-4u; Fri, 06 Dec 2024 05:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJVVP-0001M9-RU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:24:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJVVN-00046g-T8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733480651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f3YRh8Ry2KGPhX6csYnhxSV2wM8ZbGlEptkKb0YWa6Q=;
 b=gxCSSknAi7K4/N5uZwwzIm6Viamhoxc7Dmxvyfrvq2SAYzU6JwFlYzqXfnOsmsrcBP0vnu
 bDh7GkgQwktQjnMeTADDDHzRNA+odMSjwSfy2E2WcQLiGmfeo5i+HtAp35zG4XbMClqMfQ
 HIvHjrfz5LvcMaLA/GKVaZQIAg2D9mE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-vjLRF6cSNRSmJQKHNt6q6A-1; Fri, 06 Dec 2024 05:24:08 -0500
X-MC-Unique: vjLRF6cSNRSmJQKHNt6q6A-1
X-Mimecast-MFC-AGG-ID: vjLRF6cSNRSmJQKHNt6q6A
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8897ea603so34816876d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 02:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733480648; x=1734085448;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3YRh8Ry2KGPhX6csYnhxSV2wM8ZbGlEptkKb0YWa6Q=;
 b=fMz766jkrSLDfR0jKy3ohGwGgMZNxI8mf1s7jPxN4txaLXRVVhBhXgiNxtitp4/7y+
 ibXrUDwtVMnBHLAlmKiWnTbfIgIcyM4OAPKF0AjjI1zjMTKTzvmtVzwibCLKr3VL8ZMk
 /Pc6HTZaDiCzHz0CUQ1xxDfsF85/Tm+FgEtg2TU/Ta2a/YjirkSCcIwAei1VKACWyM/M
 wIvo/cklLj/zFNfuFiEMzx5s27qNirGp/LZe1aij/e4Ku/hadV8KrgPlfIb7BUxX53rN
 zDW/DTV/9q+/8Oj9YUkMk+n30Emk0XfT0aQtArL6aBr0Ek7QOeHHgOWNEaWxf7f7wnNv
 bRCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/kuwvN14oU6v+aV3zbYYJKOM2yhM7dktv6b/2GbThsaFcJLhz7xazTaG82KlsC+DKvtIK32DIlHEp@nongnu.org
X-Gm-Message-State: AOJu0Yzep0XiE44zjGh8Mn3mIrveP8OBeGVHorM7S7WKJrmO81YJTqoa
 vrWklBgAujHlHmVkmH3r+bZn3BepsDdCoohXMMVej4rK86R525QwKbagVEUivYZHhixPC0OZ4WG
 MVoqVAVcfmk/1G7BsbpRSXfzJgSwFMDuvfPNQvis2t33GYgnqVMwH
X-Gm-Gg: ASbGncvZ+7+KSgQK7GlZMIwcJ6A7/diGhdoLwxQG8KJ3d+EDPqpoGWg9d0r9FGP55tR
 tSC0r5VuDai/j1NL1IwyuFauU8Tm9THXbf+5hBFK1EYMvkHm3/rEK1QBU62E2X3xglnNBWL1rE6
 gZBUcgMbqHbe40abCS8/i1O+vI8Ezcjc7w9WTK1NJMYjOUxYC2YYcenM1TirH59h3Em7a3S2+jf
 Nww5cMqRN3eBzNc87yxtMcsuedmTGIOaUTyIRWfpQUxzhBF/1JrgNti1v1Wsuqre6LY2XXf0ZOA
 7FRNQo799uC3
X-Received: by 2002:a05:6214:c68:b0:6d8:a3f2:4cc with SMTP id
 6a1803df08f44-6d8e645ec95mr53667066d6.5.1733480648345; 
 Fri, 06 Dec 2024 02:24:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbVw05Qv2wO0/ajzNtPomq8yNybWwtu720n2BrnhB0Uzvzj4MccRoNIHR69iZyqstqs7J50w==
X-Received: by 2002:a05:6214:c68:b0:6d8:a3f2:4cc with SMTP id
 6a1803df08f44-6d8e645ec95mr53666736d6.5.1733480648036; 
 Fri, 06 Dec 2024 02:24:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dabfbd23sm17599776d6.115.2024.12.06.02.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 02:24:07 -0800 (PST)
Message-ID: <24db9184-16ac-4f95-ace3-b16fdc4bb82d@redhat.com>
Date: Fri, 6 Dec 2024 11:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_00/24=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <7605f22f-79a9-4e15-b2ae-05d83a52242a@redhat.com> <Z1IeUbDe2pMdyJfD@x1n>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z1IeUbDe2pMdyJfD@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hello !

[ ... ]

> Did you test also with commit 5504a8126115 and relevant patches reverted,
> per mentioned above [1]?  Or vanilla master branch?

I am on master and I didn't revert the "Dynamic sized kvm memslots array"
series, which we know has benefits for other VM configs and workloads.

For testing purposing, we could add a toggle defining a constant number of
memslots maybe ? and 0 would mean grow-on-demand ?

> I wonder whether it shows the same regression in your setup.

I didn't look at performance yet and downtime with mlx5 VFs was not a
big issue either. So I am expecting QE to share test results with vGPUs
under load.

Thanks,

C.



