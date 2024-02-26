Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FB8C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWJU-0008Af-PF; Mon, 26 Feb 2024 03:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWJT-0008AR-7U
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:26:15 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWJR-0005A4-Ox
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:26:14 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3e6f79e83dso285975766b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708935972; x=1709540772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QOzUZDx2s420OQricQ4kHdxIIxiP0tup/D4I5XI/bx8=;
 b=qFn5QjXcfcTg21GEJ0+pSVFRGYI+niro3igwy3fjrQkmpmcta/aBsszE9QkIh+b2uO
 lWTS88KKWt+N1GDL1v7js8Bb0ExcJuNFrB49QrwBywmDDP1DBrtdsC4levd8dhQZZEm5
 NUz3Pr7G6H9kbzmptEJkUvE8obdzM+rZW9LluNlfEaG51jJElmgvlpxsKRrXIZru1bmJ
 1dV41/E0hQIO67yiQBPUEA7Vd8N3f/nRmCFF8jjW9yTqHxlLcnR+UXc9O+cxZMzQrvuO
 WkbEESpEkLYzKnn30/e54jMYaOUT8S3genumPs/VBeKXGBL5QPEwUBoVlme+lBxmkj2t
 rE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708935972; x=1709540772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QOzUZDx2s420OQricQ4kHdxIIxiP0tup/D4I5XI/bx8=;
 b=H7Fvwl7kVecte3yyMcEtTSBDVNXN9TahXkLVUE0leMxjVrPq2b5plMdEgIOpJVIXc6
 iZ+QX4O3RYixCd/ro0MrMREKSTB8IR/k4oF+gyLoP4q68pUIY3YaYv/0Q094pVpMv1hp
 wY/Q9F/wilQJaUlaP83hTH3DniFtpu3oQiyGeWdb74S1KyUPZA8g7VlknIw7sLXbs8Ml
 OG3GvsrkzmrZifQRoq/gfcAr6jjomVBrN6g6CWQ3O4h5tQmeqipag3TBEez6sWWP/+Bs
 RFsxK2G0dhu5qgJbmiVrRMHCrGuH40XHq+9Z3zMVBPMly5bCDIvvrZpifevS1MYl6nX3
 Q+tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCl58FrK+GihLeu/ePqOj218o95Gvbck56Pe2KLfQmIQdf17SgwoZp77g9UDkvKwgV6zO+Rlv198A6OhWJSmytMbbIGYA=
X-Gm-Message-State: AOJu0YwLsFrUMD4TIlNpoHjiK1IcCpSNbJSsG9UmfB6ZmDVc72o7rvIa
 0CgsGz4gcRo6GBiDr85W5gc1rNgKsPyUFW1QEK1kTW7liGdAihQNqTPVbOMGrCo=
X-Google-Smtp-Source: AGHT+IEFArJrYPu+z2eTDWzuvVItasgglpdwNpdQlVB/8vhEIn6EU5g3b5Z4oERPPCAH3D5YhjVzEw==
X-Received: by 2002:a17:906:6bd0:b0:a43:16dd:cd5c with SMTP id
 t16-20020a1709066bd000b00a4316ddcd5cmr2282249ejs.27.1708935971921; 
 Mon, 26 Feb 2024 00:26:11 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a1709062bd900b00a3f63b267b0sm2184935ejg.101.2024.02.26.00.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:26:11 -0800 (PST)
Message-ID: <a6c3df86-12e3-4757-9609-08d79fc9fa33@linaro.org>
Date: Mon, 26 Feb 2024 09:26:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/i386/pc: Rename "bus" attribute to "pcibus"
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>
References: <20240224135851.100361-1-shentey@gmail.com>
 <20240224135851.100361-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240224135851.100361-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24/2/24 14:58, Bernhard Beschow wrote:
> The attribute is of type PCIBus; reflect that in the name. It will also make the
> next change more intuitive.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/pc.h     | 2 +-
>   hw/i386/acpi-build.c     | 2 +-
>   hw/i386/amd_iommu.c      | 2 +-
>   hw/i386/intel_iommu.c    | 2 +-
>   hw/i386/kvm/xen_evtchn.c | 2 +-
>   hw/i386/pc.c             | 8 ++++----
>   hw/i386/pc_piix.c        | 6 +++---
>   hw/i386/pc_q35.c         | 2 +-
>   hw/i386/x86-iommu.c      | 2 +-
>   9 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


