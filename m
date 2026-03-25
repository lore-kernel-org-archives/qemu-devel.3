Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B701103A9A1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5LmC-00045D-HH; Wed, 25 Mar 2026 06:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5LmA-00044h-UQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5Lm8-0003d3-M4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774435665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n5563NUhpJMrSRtmtGEFEQKFzkGOr7PVi8Rm/7pSV/w=;
 b=hmPYul8sdBblAEr/zLA/Hu8NVTe6qoIDyRxjudfsNG9cZyMTLEcD/PskNkrSDg/2b32icN
 NeK+8Bye5y5UKN/yOQ9cjXDZdbrWMYQfwSiqvc/IKtMU59rIHavwfnK918/9JMRxxW7Q2A
 KjOc9/FIbiBv1Iv8eH0bBMV/GjMyvTk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-MdUAMhIBMfSeZZwVtCqAnQ-1; Wed, 25 Mar 2026 06:47:44 -0400
X-MC-Unique: MdUAMhIBMfSeZZwVtCqAnQ-1
X-Mimecast-MFC-AGG-ID: MdUAMhIBMfSeZZwVtCqAnQ_1774435663
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so31812095e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774435663; x=1775040463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=n5563NUhpJMrSRtmtGEFEQKFzkGOr7PVi8Rm/7pSV/w=;
 b=WmAIBlN5abdH75DAkcEdsditluLyZP/OZiQTiHBlku954Q01/ZWI8lIaHlypqrY5mH
 GqYlNgfRYUe81r7Cmhrn1uxnFYUlXGps/C09ZhTwKbO6HWBYsxiHtbWfQ0EwLflvNiql
 XWBjywbItg2eNulsJ8D+np2YAJ/usWcW3rFJO1MBjBrX8bs4mOVqx2zKjVBXB3A40xmo
 HbnZW1zz1tApFwCy3NtegVLQgbUd0j8KCueWrHASSqSVGiIAfooYdGbwH9h60FkitJvG
 L6xRL8Q4Cf+UFPd/2cIMz4kX1jkDCgCF8S/4+6RdVOQBuqr02Qd+eNNa+MnaK4ySMJyK
 qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774435663; x=1775040463;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5563NUhpJMrSRtmtGEFEQKFzkGOr7PVi8Rm/7pSV/w=;
 b=sFfvxDto1TNwKXKTlkLQ8+YAed0PLt6qRpt5Q/Qgm2NXMFsG2NmR1T4Vci/siKg2lF
 qMEaQJr571ATZ6VtRE2GBot6o5PfX5aPB4PVNmJqxzaX008W2aSbUvrrWdTsZKoz4Bxx
 MPecw3s/Ud+J9OS2O2Kljvj5kB/b8OQxlDxWmuR9QYqLvpvzAPoXClrLAJTO+lObxzXD
 LpTlSTypCpi8Ifhyumpb4lbyAY50W5tWvOX8gG7ZdGT4y3WNl3OG0GLFmP363abrh5ey
 klmSXWNO8kZnLmHvscb7+0aLuRk3ffE6qppR0WRPjJq0wiqNsER3WDqqDllZ6jT7fk/9
 iJYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt4LxOBZXnv+ghFa7krPKASnKZdSihQRrI+dphaul8SXC8dtEM0oKv2xXbZ4wrvfpvgpMT1rHzsrFU@nongnu.org
X-Gm-Message-State: AOJu0Yw87+ed46e18mWyDgnHbGB51BLaK8CiUN4qENSGBvV7qUQ3oDSt
 mH0YjrBezoymDvz6pmwU/yMvljiPhIVGSkrj7OyQubkciLydNkdq/DNqZtz/9jxxppH0kN5oLii
 JDGqsWLIoRNubrwOREDF/PoGZK4FTe29DGpphF+8u5J89zarYrVOQx1kf
X-Gm-Gg: ATEYQzyLyObQzxXoo6WtONThUTw+avhM6T5kFEn33i8YlL6m/Tf0K4rVbjsSjrob2j8
 ZFd1gAphy48Fb74JGd5d1X7eqqOwfH9WlsayOFCKmMztmqQnjS313brsJEz5fqoghG+L5sw3ZO5
 FslEHUcCQyev7lnrwAZAGZdvpUzEpRCZUjbIozi6IzsewCx3agc86HJWSqnljZK0egZlzA0lxmt
 3kcbg7mYNKofWxBtuuUkTR1DXQI8w9lrLsmW1sVD7X96KrumViPf/w0z71FQf2GSwiZkw2k7BWc
 4yoKa4DOmsI0sr0R2PW+q4FID2UB0utCus3hZO6Lx2HYnwXXudxhSg7nRdjoILRYIDyvhS+9r+z
 wHLNJllIt9h/i+K8b9A==
X-Received: by 2002:a05:600c:1e8f:b0:486:fcc7:d6a with SMTP id
 5b1f17b1804b1-48715feaad1mr43453595e9.13.1774435663163; 
 Wed, 25 Mar 2026 03:47:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1e8f:b0:486:fcc7:d6a with SMTP id
 5b1f17b1804b1-48715feaad1mr43452975e9.13.1774435662704; 
 Wed, 25 Mar 2026 03:47:42 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116c0c13sm256079375e9.7.2026.03.25.03.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:47:42 -0700 (PDT)
Message-ID: <93b00f05-0c59-4c53-bee6-0f0b874a7b28@redhat.com>
Date: Wed, 25 Mar 2026 11:47:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] target/riscv: Add big-endian CPU property
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
 <20260324164007.549397-2-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260324164007.549397-2-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 24/03/2026 17.40, Djordje Todorovic wrote:
> Add a "big-endian" boolean property to the RISC-V CPU configuration,
> defaulting to false (little-endian). This property allows machine
> models to configure individual HARTs for big-endian data operation.
> 
> The RISC-V ISA supports big-endian data accesses via the mstatus
> SBE/MBE/UBE bits, while instructions remain always little-endian.
> This property provides the configuration interface; subsequent
> patches will connect it to the CPU state and translation logic.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.c                | 1 +
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e56470a374..4537305dfe 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2641,6 +2641,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>   
>   static const Property riscv_cpu_properties[] = {
>       DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> +    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),

Note that there is also a DEFINE_PROP_ENDIAN available ... not sure whether 
it's a better fit here, though. Maybe mention in the patch description why 
BOOL is better than ENDIAN here?

  Thomas


