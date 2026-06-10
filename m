Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FABCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXL9b-0005C6-5I; Wed, 10 Jun 2026 11:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXL9U-0005B8-KY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXL9S-0004pN-1F
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781106452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CzYGT+uGNzkc2cwsc1SQmdTaEZP5jUXMfs98MSYX37c=;
 b=Fnr4C69qXJusfDXFdlaKEu8acTRmgZFEx8EIxFR7tbN/Km6nFJDLtT63YlRQjUyts+ghjX
 UzSYsy9Lk1n7Vz45q+xTkvTwADqQ8GjTkafEvLEBBHX2t+Rg7WBSMrstxTMF44pIBkwX7g
 DSWvXMstS+KYog3QQkCq6bQamVyXIIU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-mHyYzxm3OM2o_DDVdn4YAA-1; Wed, 10 Jun 2026 11:47:31 -0400
X-MC-Unique: mHyYzxm3OM2o_DDVdn4YAA-1
X-Mimecast-MFC-AGG-ID: mHyYzxm3OM2o_DDVdn4YAA_1781106450
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45eec2badc4so3534768f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781106450; x=1781711250; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CzYGT+uGNzkc2cwsc1SQmdTaEZP5jUXMfs98MSYX37c=;
 b=q21xkAyhY/P2PQAPX6fI58CScjOOspzvn35ZvvVdL4nUmEwTTpEM7xk3kzoIgYd2vd
 D592JwMlH7V0BHjvv5QGpBS2TsOJa+5+rYXEIMtT/F4/dKFEeHWy7sNxdDsxx3Rob7PW
 gpJeEP6KU6LAn7HOf0cH9kUYiF7uG9jwlBRcRKXsdwTuk3jWyvpkfKLJCa4/ckqUi4QG
 a/nepW4w+nq3o1kd4LKQDG0D9GdKMe6yYIbngb+cHNJXUFQlMJ0LMXFDcTitBlx36fTG
 Sm81sVCeyYoZ7MK4WMVQze9478m4NdhHFXMkxS5tqd1EDvT1G3mWN4zukWreNNG2+3Hg
 63MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781106450; x=1781711250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzYGT+uGNzkc2cwsc1SQmdTaEZP5jUXMfs98MSYX37c=;
 b=d+/NnpG4EjB5oUlSE60Is8oxikg8cTTavEPFfiFJlmEvC2o/jB2lDzE7al5QwvR5u+
 mv7TdXaaIP7f28vgPcwTIO2HjXdngTw9Qye5LWls6Z2NmnW7xMTqMztLzOqyR4Gx/6br
 Uq0l2C8fjnix8ceUQKcy7pDU88+t64ESBD65mfmSvqjdD1BnkRPfCHEdzuZE1qHwlQ3u
 PfAo2b9af4PHBE2iluVS3nLDoFMONSeFEMiKH7I3OyrVFbylOQD0Q+720oa4O8kscrTC
 FwfPHueE6afsxW447hUu+cHgjQ2sTUJCaAI8jbOwYEnyGva8TAIwQWMjCTOIWxrWAxD5
 FaXQ==
X-Gm-Message-State: AOJu0YzfutaJAd6wFVbCuLLendYUJWZrsOcxNJvVMpkO8/KVA1AYcL68
 faSp/uQ/Fi6r4TU/wXMoVU8+MChMNSXLWSjrEVe+VABE1S7k2PCBS8vEma6XX9Z8oMouPng9+Gl
 Kj8GwxRd+Oe1IE/IJFS80O3nbjjfqu+z9uhQlC3t/8sG4gkg9+ioU3EZc
X-Gm-Gg: Acq92OHzNirEzYidZBoAhQkdLvDNE/B2rPzDJSUw6LU/WE2RqtDGklKNlYc2O6lg95w
 mkz2A71h6aFBbFAx5tyirO3kGImgM+vLO3vlSCoSEvEcjJ2ckzb9eon2CXYnDzI1NSUjmpLTuBY
 q1XvCG9RuKiohZQZaXFsvtW5tT5jHEglZm/cd/uoMt6DZpIt3c4swbmVw/Jvn83gkiViL6F1iL5
 yVo2raGMvRHu0JuMEbQSOdLsOxhZcR4SJfVyrKVPjkv3QC406BQKRO+kpap1yt5Wz9lFFGGMJbw
 SVT52gku1o7CxHbFywDDKkokLjjYgBP1nXYz9i5B7VsoG13abO+eSfco09a4BhFHPCP/Xr8B3ve
 0B7fhI3n5gLosOupcOk+OTtMSsYqMivykOYKP9lyksaWOLyPwpoAJbroG0ihEwC/On67yow==
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id
 ffacd0b85a97d-460302dc4a8mr27394039f8f.3.1781106450153; 
 Wed, 10 Jun 2026 08:47:30 -0700 (PDT)
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id
 ffacd0b85a97d-460302dc4a8mr27393999f8f.3.1781106449721; 
 Wed, 10 Jun 2026 08:47:29 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f67c6sm70106416f8f.16.2026.06.10.08.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:47:29 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:47:26 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH v2 1/2] hw/i386/microvm: pack device tree
Message-ID: <aimFZtN9qURC4Reg@leonardi-redhat>
References: <20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com>
 <20260610-microvm_device_tree-v2-1-4fb44730c49f@redhat.com>
 <ail7WyMwmEBIquoM@dobby.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ail7WyMwmEBIquoM@dobby.home.kraxel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gerd,

On Wed, Jun 10, 2026 at 05:04:39PM +0200, Gerd Hoffmann wrote:
>  Hi,
>
>> +    ret = fdt_pack(ms->fdt);
>
>I'm wondering whenever this is the best place to do it, or whenever the
>igvm code should make a copy + pack it + place it in the directive, so
>we do not depend on the machine code to do the packing for us.  When
>doing a quick grep the packing seems to be a rare thing, there isn't a
>single call in all arm code for example ...
>

True, it's rather rare throughout the codebase. If we do this here, when
we will support other archs we would have to add `fdt_pack` to them as well.
Is this your concern?

Luigi


