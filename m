Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19BAC79F9D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 14:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcloV-0002Rp-MK; Mon, 05 Jan 2026 09:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vcloT-0002Nb-Uh
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vcloS-0001ev-Fs
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767624243;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrbMLPteq1D7bC0IhGnfTnr8ZgF7Ruinx7XDjKUN9X8=;
 b=bgJHC3NRpqXd8lmrNTlWHQ3dnGyeycdIBtR93m6kDFyOI9CKM7+AB321A5wP0YTZ9kuWl8
 2RxHuOsDvuriCc6ad/Bys1FM0tmz4eHwjD67NoqO1mgaUisB9gZozBzWGChWH7wHY1vALm
 HqwGpAQgseghZgtJOcvPuhRuJVD35GQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-zOhvlzqePH-yRMx8BUlmNQ-1; Mon, 05 Jan 2026 09:44:01 -0500
X-MC-Unique: zOhvlzqePH-yRMx8BUlmNQ-1
X-Mimecast-MFC-AGG-ID: zOhvlzqePH-yRMx8BUlmNQ_1767624240
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d3ffa98fcso59745425e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 06:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767624240; x=1768229040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrbMLPteq1D7bC0IhGnfTnr8ZgF7Ruinx7XDjKUN9X8=;
 b=DHvD4BxuQi6x1lwdwqL8NDxzDFv2yK8lGy0yjr/PvIQqURhy/LIrSceajlCS3R+YmC
 65C1XFrnuvsMbNvvO4GjP8O0cmEUBoA4+bJG5Wp6ikeXYueIAd08AplEq+iUK+KBzPSS
 8uCpLtvGpWMJvEj4UrAT4pF0C41eZeCeEoZ/Zw0m5wL8Dxk2nfgK2nQBH5WSASIp8rVr
 wUWyBB1wtLhwYSWEmuRjD+qw3O+bmjupVa3GUPnL/cvMktU7l2AHje8NJ+0y8ZToe8uG
 qLPrFswbl+w5mFyA7R/rPUwuMYzYDI5HMTqCK8xI2091+kSi3zQwjfGGD/HorDmOygla
 uUDQ==
X-Gm-Message-State: AOJu0YzqMbTV5Ezpn6Ik1Jcs1c0xrBfNtOw7xZUMs8Kb7aRONbqs8vVi
 D4NI1DBggTJof+7/BsWApfNC8n7WMSJYqs/G9yXc2ncpOpYsoGHaN6YphMAm7ywoWq3XrB0xusl
 sGers7EkuePiMGdxYl2Ay2QrvjfGYq/uDcHdDozgiAwVHI65TuNWhaf9w
X-Gm-Gg: AY/fxX6B1ymuQqUmUrs6jSZOEPj27QDd/UoiL+gdkSf5icZHVdGURRmd9U/55EzV1HD
 Ab2cmH1MOMSKx0X8s9XkPpXXs3pxjtkTkMkrMcKkVXIozpbuXeuYntq9HCiJathQcd+up5X87Uy
 cPU5XE1sElcTmw0SJrq6efhaUdfnXReUeRORFrcS59KXUZRbJErD3AoFs8t5EorCk9lYF0l+ogF
 UhW3wNEqDbrGxdwIQLVsuNZ0KZZ0wyWft9Sv/rS904s/wjRvGGix9eaNnScW0NXJoNiZaJZ6O8M
 eu68qtcldqzLsvV6EZvN4qFIrCGB0yolWPgFJ7DUKwUvU/sYvNPcX4FNHWHtFtMPkZNCRtr8Qjk
 ma03a8fBuNPYh+FXLbbzybIcOK/b4rwd8NQV+dQUW+/+xzjPk5tm1PQ01Cg==
X-Received: by 2002:a05:600c:4e8f:b0:475:e007:baf1 with SMTP id
 5b1f17b1804b1-47d19591166mr589580885e9.34.1767624240236; 
 Mon, 05 Jan 2026 06:44:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBjNTyz38lnAv7zThbnk3FvEmJG68VRceH6W+yz9vlhT7kHrR7LsAVfE41N19OQYf2FoIZIw==
X-Received: by 2002:a05:600c:4e8f:b0:475:e007:baf1 with SMTP id
 5b1f17b1804b1-47d19591166mr589580625e9.34.1767624239831; 
 Mon, 05 Jan 2026 06:43:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm99781654f8f.33.2026.01.05.06.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 06:43:59 -0800 (PST)
Message-ID: <7175dff5-04e4-4a7c-bd71-9351181c40f7@redhat.com>
Date: Mon, 5 Jan 2026 15:43:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update VIOT maintainer
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, jpb@kernel.org
References: <20251230154844.325364-2-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251230154844.325364-2-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 12/30/25 4:48 PM, Jean-Philippe Brucker wrote:
> Unfortunately I can't contribute to QEMU for the time being, but Eric
> has offered to take on maintainership of the ACPI VIOT. Thank you!
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cbae7c26f8..a11338f1b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2174,7 +2174,7 @@ S: Maintained
>  F: hw/riscv/virt-acpi-build.c
>  
>  ACPI/VIOT
> -M: Jean-Philippe Brucker <jean-philippe@linaro.org>
> +M: Eric Auger <eric.auger@redhat.com>
>  S: Supported
>  F: hw/acpi/viot.c
>  F: hw/acpi/viot.h
>
> base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591


