Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8480C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 10:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfzIR-0002XJ-9R; Mon, 19 Aug 2024 06:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sfzIM-0002VV-Rr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sfzIL-0002RK-8R
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724062042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ej+tM7S2A4ZUJqPfxKVO1cQbCHOqPsimMQhZdGPgPLw=;
 b=PJlBXj1AW9uZct3s3rXOrSrjrWmeJLNzMc1FWeG4pdtFMak0VJ+bxK4knF1BqitXX61Knx
 YiHhQ1pmIaBGNR4nyy87lryfptRT5FcvDFX59t0/ITbM5ph2Z1rr2fuS6oAPxfblCAW+9s
 W+QjltlcDkBkf5E9uo/hdZgZOEsie/4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-bQryX8CpOIaXZanz1bL3-Q-1; Mon, 19 Aug 2024 06:07:20 -0400
X-MC-Unique: bQryX8CpOIaXZanz1bL3-Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4518f9f8a9cso52406571cf.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 03:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724062040; x=1724666840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ej+tM7S2A4ZUJqPfxKVO1cQbCHOqPsimMQhZdGPgPLw=;
 b=Cn7/b4q52mIU9JpbhNueajj4brqGwR+upmwgLUUKybYi1t7B7q29NjmA/8wdC2I2zy
 bIVAXxv4BJ/o2FsJmPxVv/o5w5jBCgrNFuUNPdU46fpk5m4XXCzGXZwX5LdzqEMdJEB+
 Z8pOmMX2qeiE7oByyhifykb5kj/g7xkDFlD0x/tC3F/Q112D5HfadeWtfCjZwEjAtDvR
 cuDCogr4eP2UJn/rimWygqji+MMrULy4D9pZPiDPPElsnZ/d3UoWb7dW0tkviV4HaL4o
 iexSajtwLXY1Uke83qfExyZRTGyfqjeicm/eXzD8ZIqgfT7AQeeyVuT75YEQ257pgXL5
 0FpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF5TVVVFvDU654nvcYa3gi47u6CGK7Mh8oOlVi5PYgjTTCzdD4ggn9yQyX4+Is6nx3urpOlHQFvH6ntII8wQnuY87eVN4=
X-Gm-Message-State: AOJu0YwQA/wTrSh3QWGc4B6ilJGHtbvDB823eqlj3tQZUj+AAKDgVYdB
 OyRCotnGtCAP4EZFrgATAUwL/cDtd2OnoMREb23NwxDjiIYELz8/xZ6mH2st3YgHSDDk8kowDtP
 chuCGeMzaXKRIodo5Ocw7Wewg34i9BIS/16+G4Xtj+MV3USebmFA0
X-Received: by 2002:a05:622a:907:b0:454:b115:f73 with SMTP id
 d75a77b69052e-454b1151275mr96281091cf.45.1724062040336; 
 Mon, 19 Aug 2024 03:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs2i//XFacnEKI8fC4wtt6b/F5SQQDNlMZCmLhjmYocL5F9hbhl7hlbq8mcrWA2K0fEp4nKg==
X-Received: by 2002:a05:622a:907:b0:454:b115:f73 with SMTP id
 d75a77b69052e-454b1151275mr96280941cf.45.1724062040015; 
 Mon, 19 Aug 2024 03:07:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4536a04e66bsm39111691cf.73.2024.08.19.03.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 03:07:19 -0700 (PDT)
Message-ID: <c4959246-89fd-4541-b2aa-797a5c2bd70a@redhat.com>
Date: Mon, 19 Aug 2024 12:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/arm: Enable 'nested' SMMU in virt, sbsa-ref
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20240816161350.3706332-1-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240816161350.3706332-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 8/16/24 18:13, Peter Maydell wrote:
> This patchset enables support for nested (two stage) translations
> in the SMMU in the virt and sbsa-ref boards.
>
> Patch 1 is Cornelia's compat-machine machinery patch, which we
> need to make this change only happen for virt-9.2 and later;
> patch 2 is a trivial "missing comment update" change; patches
> 3 and 4 are the board changes.
>
> Enabling nested support should be transparent to guests, which
> will only enable stage 2 if they actually want it.
>
> thanks
> -- PMM

For the whole series:

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

>
> Cornelia Huck (1):
>   hw: add compat machines for 9.2
>
> Peter Maydell (3):
>   hw/arm/smmuv3: Update comment documenting "stage" property
>   hw/arm/virt: Default to two-stage SMMU from virt-9.2
>   hw/arm/sbsa-ref: Use two-stage SMMU
>
>  include/hw/arm/virt.h      |  1 +
>  include/hw/boards.h        |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  hw/arm/sbsa-ref.c          |  1 +
>  hw/arm/smmuv3.c            |  1 +
>  hw/arm/virt.c              | 19 +++++++++++++++++--
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 15 ++++++++++++---
>  hw/i386/pc_q35.c           | 13 +++++++++++--
>  hw/m68k/virt.c             | 11 +++++++++--
>  hw/ppc/spapr.c             | 17 ++++++++++++++---
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  13 files changed, 91 insertions(+), 13 deletions(-)
>


