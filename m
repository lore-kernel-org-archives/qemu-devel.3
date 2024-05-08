Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17F6C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4okW-0001e9-LH; Wed, 08 May 2024 17:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4okV-0001dn-4y
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:22:51 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4okT-00013e-Di
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:22:50 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a59a0e4b773so39492466b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715203368; x=1715808168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tXqHe/MV3BDh5ZPCOUmTruKZVVsG0iKlRzC+N1i2rbI=;
 b=ZmVo2G3hfujDK6rqAy/JAwD8JF51dtr9JvUK17lRUZ0O4EUMZBipemI6+srV6ak2F7
 YZZivOFjvefouUwKTAhVhHnDKcYwVQ2r0Xn4e7pBmq4q58CW0NtqnG0p5Y3L0ZFhhnjx
 //vdZG4/31224vDCyKdlk+xM+b0VXqlQsgCNAOhd/cR2ifdwSWri0Vv65aBMqaf7Ia37
 znNBUbfTIldi0zaAolGwC9KAI0lk9Mhco3KKEbHXT0gsVADv/Zbdk8at+XB8s51+KwM6
 uNPXhk6mgkNiBZfeWU8FXTZpjL437Y5G4b3KQswzRqAykzzRoJjvqbwmqrgUu9yBQ3Ek
 08IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715203368; x=1715808168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tXqHe/MV3BDh5ZPCOUmTruKZVVsG0iKlRzC+N1i2rbI=;
 b=mQKbpDY8uyiF7MU5RSTGTjoRSb3ZejgL0OP9kvpOYJDYNti/DETCwDxOHeT7zYaAdL
 3eRNHXzgJypznT809yJErHqmeRCR4hAqXRs+JwXvmC0RLucueIfJwa0c7P3oj9u1Rg/r
 s0E2V69TWFnKObYxx+B50J7aYU5XCxM/BFSCNrZOJm3bCRrOfFuRbH8b+BT0yuIHxjcO
 ocwurmtwLRmexbOblVcG/adjqXtCoX1hd1aee4EJZKGQhs8W5etd1FGvTUbvIlUWFE8s
 qZq6FmmgdjXlypYggmR5n1Z5EWVolmK43/EA6IQVaOST6LNfemekJQC9aLeeFemoDp9S
 YaGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHS92rC7KA8HIki0q879CfhWsmjgqxNTcEVBdkb4kQ5REkaTRXd3NpfHsV07hSx250GTsC5/PYrNZvEyFIuYkQmmIgI/c=
X-Gm-Message-State: AOJu0YyUJHJbFAfDZww8ZlUe0k87UMBt9udMKd510bST2+oiWQmhFTd7
 mxHftAHtVdZZFi7OkT/Y6oJORxIEelVDnUAGWkCbdRJL1Ypqaezqj9B4PS4MCas=
X-Google-Smtp-Source: AGHT+IGroSE0vQnuus8Xt2akGmQ0osUf+Z+E90stL3GdzxOMSqTEyy8AUWK+tv6jmUS35XD6w4M25Q==
X-Received: by 2002:a17:906:1c06:b0:a59:c7d7:8b0f with SMTP id
 a640c23a62f3a-a59fb9595f3mr201395866b.29.1715203367765; 
 Wed, 08 May 2024 14:22:47 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17892444sm3133766b.76.2024.05.08.14.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:22:47 -0700 (PDT)
Message-ID: <d38663b0-2f6f-4400-a590-aff76982df05@linaro.org>
Date: Wed, 8 May 2024 23:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] glib: Replace g_memdup() by g_memdup2()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20210903174510.751630-1-philmd@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20210903174510.751630-1-philmd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/9/21 19:44, Philippe Mathieu-Daudé wrote:
> Per https://discourse.gnome.org/t/port-your-module-from-g-memdup-to-g-memdup2-now/5538
> 
>    The old API took the size of the memory to duplicate as a guint,
>    whereas most memory functions take memory sizes as a gsize. This
>    made it easy to accidentally pass a gsize to g_memdup(). For large
>    values, that would lead to a silent truncation of the size from 64
>    to 32 bits, and result in a heap area being returned which is
>    significantly smaller than what the caller expects. This can likely
>    be exploited in various modules to cause a heap buffer overflow.
> 
> g_memdup() as been deprecated in GLib 2.68. Since QEMU defines
> GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_56, the deprecation
> is not displayed (on GLib >= 2.68 such available on Fedora 34).
> However the function is still unsafe, so it is better to avoid
> its use.
> 
> This series provides the safely equivalent g_memdup2() wrapper,
> and replace all g_memdup() calls by it.


> Philippe Mathieu-Daudé (28):
>    block/qcow2-bitmap: Replace g_memdup() by g_memdup2()
>    hw/hppa/machine: Replace g_memdup() by g_memdup2()
>    hw/ppc/spapr_pci: Replace g_memdup() by g_memdup2()
>    target/ppc: Replace g_memdup() by g_memdup2()

Thanks, patches 5, 11, 15 & 26 queued to hw-misc tree
adding the comment suggested by Eric on patch 5.

