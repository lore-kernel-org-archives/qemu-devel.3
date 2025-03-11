Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3333C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1r1-0007lt-MT; Tue, 11 Mar 2025 11:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts1qt-0007l3-Ik
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts1qr-0003TJ-AB
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jgu8qPYJ79uKLKuCiFqnnNcREPa5T/sGIJMERlEBIyU=;
 b=bCSEerr463RX7hJhEs5ihWI/SX0hZCKM+zXeUvsMiHhWWMh0mANgR/JsVCGhgsE4GypQit
 oqhjhns6c0XtFNXnVmrVreA2F7EPVoiD8vEPPCA/Abq4NNWau6dmLBGzz9CI+Io48Ng4nz
 /Tj62vb8Q+DOl3NPapdJkbJQ7nniP0E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-YClUtxfpNsWKlRTmL-Yf-w-1; Tue, 11 Mar 2025 11:49:02 -0400
X-MC-Unique: YClUtxfpNsWKlRTmL-Yf-w-1
X-Mimecast-MFC-AGG-ID: YClUtxfpNsWKlRTmL-Yf-w_1741708141
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so21914325e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708141; x=1742312941;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jgu8qPYJ79uKLKuCiFqnnNcREPa5T/sGIJMERlEBIyU=;
 b=geHox1xqWGSgla/ADZ1hBNc4OFctQiy3six0vYCkhqEHTbEPF4YizLM5Drreejfovb
 el6CrE5qfjBX7zFMhYUmSqabh8VQfqSKA5YA5mCe1lRuhqUXjIn3qsdR+rePJaldayxU
 zL1ZfeUng8ll1Nyi1bUredVsFdkfcOCxlo2sU2pE296/7IPoeoXcihmfGqvBtz8PAZfP
 MduxHeYX1nkA6EytALKr8RIbQJcoieu6pOvCs3nf7uLWrGB2vwLbv8TG6YsnjGBRqyAM
 coqmF2tKBDhk6/XPL/n719R8qSY3wfVK21gXGKeSYkOvl8eHTCGVyre+PxC8Nieg+/O6
 tJqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIyi2YOvo0uuoZXMyUowR6jdIr9N2nq/0IaAP4LmowInJzycCLOan7K/H4XU2P8Zdl9KULhqmFtlOg@nongnu.org
X-Gm-Message-State: AOJu0Yy9zgEmPaigugRgka5Po2oSa/bWYe+Di9q5Qdvqa7JG6D3TPdqv
 AysUJ/vW8brQBqdMl+RjIZJJzUlq7uLwcqM2vI6q8QSFtllUazSZtR6oivpbSWPbQfbEo3608s/
 AxTPYMB2x8mrk2HTEu5UdL8YyY/x5AMEnm/5xSSFDGyu4Icjen5/d
X-Gm-Gg: ASbGncsoc3iUfCy+14No61bL0CGBmr7w8mNrzavoct+FK5F+f/58BcC8U3ai4sFRonY
 bB8WYGmZ+0vqzB5EfwBCyRRS+7gDMxjd7OuruytSTxIMffIx/nvkFy8BlFWW23dQ6f40YPMTWRE
 p+9dbgJdTac2shUnfO+MThClOSH2vTUd3phGdUIwMCKnHWl2oBuwVLrjYKAiSuaDnj4AYPAZPBH
 Py9XeMp1U/ig3P7p4oNxPGWhXU5Ie/G3488s6VwA/je9AytgPF1J03nTqngLP7i+J+vbsTC/W34
 woB2k/Q/GF9f17l+V6GoovyQOFFAFHYtGmWylPqCKnQb6NA9RBf4nA==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-43cdfb7db88mr129305895e9.29.1741708140823; 
 Tue, 11 Mar 2025 08:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbdp28rvif/Vv+N5rBxqvLe6tQQJ/G2f85yUlYbetMSliTJEkCxTWmY56ZDrmJR3C3yilA1Q==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-43cdfb7db88mr129305665e9.29.1741708140458; 
 Tue, 11 Mar 2025 08:49:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c106a1asm18420643f8f.100.2025.03.11.08.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:48:59 -0700 (PDT)
Message-ID: <f4288963-702a-4625-975a-02498f688ceb@redhat.com>
Date: Tue, 11 Mar 2025 16:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v3 0/8] hw/vfio: Build various objects once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>
References: <20250311085743.21724-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/11/25 09:57, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> Here are the VFIO cleanup patches ready enough for 10.0,
> with Richard and Eric comments from v2 addressed.

I dropped the previously applied patches from the v2 series and
applied this v3 in vfio-next instead.

> I'd prefer the rest (of v2) to wait for 10.1.

yes.


Thanks,

C.


  
> Thanks,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (8):
>    system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
>    hw/vfio/spapr: Do not include <linux/kvm.h>
>    hw/vfio/common: Include missing 'system/tcg.h' header
>    hw/vfio/common: Get target page size using runtime helpers
>    hw/vfio: Compile some common objects once
>    hw/vfio: Compile more objects once
>    hw/vfio: Compile iommufd.c once
>    hw/vfio: Compile display.c once
> 
>   include/exec/ram_addr.h    |  3 ---
>   include/system/hostmem.h   |  3 +++
>   hw/ppc/spapr_caps.c        |  1 +
>   hw/s390x/s390-virtio-ccw.c |  1 +
>   hw/vfio/common.c           |  9 ++++++---
>   hw/vfio/iommufd.c          |  1 -
>   hw/vfio/migration.c        |  1 -
>   hw/vfio/spapr.c            |  4 +---
>   hw/vfio/meson.build        | 27 ++++++++++++++++-----------
>   9 files changed, 28 insertions(+), 22 deletions(-)
> 


