Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DCFC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUyN-0000kb-Ie; Mon, 26 May 2025 06:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJUyM-0000kH-6W
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJUyK-0002R9-HF
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748254939;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ten/ZjOtLjP7gEc/u55GHxW/oMTTj4AlrDqeyDkZJNw=;
 b=QFRYH3fMBkSiFjAEFG112SU5aDuwCLSmoNq7vTqyiEkPgN0RfvzG/utW+lnn37mLMu8jHe
 vV+k6RvK30jV5bS4XHlhzb4k9zeIQbDmnZPkFR0JcUOjdRWmYqR9Thf6jHnjQdhxGeLWfG
 QbVQIyrh3DbSQiANPrCQA7FeCmb2ZVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-ISB5KTWiOzynkkS92_ZDAw-1; Mon, 26 May 2025 06:22:16 -0400
X-MC-Unique: ISB5KTWiOzynkkS92_ZDAw-1
X-Mimecast-MFC-AGG-ID: ISB5KTWiOzynkkS92_ZDAw_1748254933
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a34f19c977so944241f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 03:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254933; x=1748859733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ten/ZjOtLjP7gEc/u55GHxW/oMTTj4AlrDqeyDkZJNw=;
 b=kZd4tdzR7GZYi9ZoEcz3pLDY3teLcMK7LE7fWd+iGTqiyPe5Zdydfjt2Q0q2KV25xr
 4fbvoDNwnCgSkCfl/cZLC5DqNKwldnPYeZPgR+LsXFnAvX1kHE98xbOY/wtEHU0GL83C
 OPLGqFWMXG+V6phYQBLqWk+5cLb8ST8PRByPapg4gZIrxDb2Svg6dbCk6rt3jgh2Q8Ce
 Wgs7k31UKap22DJ97Gi6F+T5PBxofyhy4pc+BsU2UmE4vrMvBZbv2WX6S94M2bLlgFtH
 dWBmfsAcaEzDrrrWHV+42Ws6qKMUZllimaAzgt+OdjO6QZPj2DKxggeX9vZOIgH0Kkex
 fcNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9OmNZRhAFn/6nciKoq6kySPgdSF5u4QUP8PP9eLJG5oMt35HOxXbhqKF9hiGpLh+mksYAp+U5Jris@nongnu.org
X-Gm-Message-State: AOJu0YzcZ5/j5uct/XNNKyPQamfQ/A3nBFAhlBWmVzhjRfJWuHiY/I3+
 v+P357akV5KEfAWHpylh26HkNeunzpu8aFDX1we7UyfSHKxiDl5oz+rgQpp3pwVqZF4dLdoXgAf
 s+UWGi7qEFasnPUVkBEzB1veQ7X4LwRsx35c5VCiunoo/AP/HtkahCBFe
X-Gm-Gg: ASbGnctq8hnlW1Ff/0RKHI12eeL2jd58EZXSaFTsHNCRoA2jzRYiDFXoeejxFgnKOz1
 5ZDeuQ8BLiBuco9q6nrjia9cKB8Yx0o8E7VshRcQKZ/O/rD1U1E4M7EU9xo9NPzGkdou28QNIQ4
 N/Bw9TgbBBAgwX/c86rfkbJo8j/1NszGBQotYK+ybcpwQQ2vYNLrrOhNzOoZLIlOMq4ZjvRlD75
 Y4Z3WPFDKWQgaYYX46mEemQeKoREQBR1j1pSOXQCG+EPeKja8KNFqS6arTkwehMvR80/Je6Fa3w
 Yq0YHOaAO+Cw4qguOAYENVGuqITmtN8K/bskD80BoSHQ4nIzEX8pqmD/lyo=
X-Received: by 2002:adf:e742:0:b0:3a4:c963:5fe6 with SMTP id
 ffacd0b85a97d-3a4c9636045mr5921276f8f.19.1748254933434; 
 Mon, 26 May 2025 03:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJZR8pNfDTNYZ4KpzVP+i1tpnlIcvgBiqKbA4z4sESP1lcV7uaZovqv+M74+oXjaaAcxa9Q==
X-Received: by 2002:adf:e742:0:b0:3a4:c963:5fe6 with SMTP id
 ffacd0b85a97d-3a4c9636045mr5921252f8f.19.1748254932984; 
 Mon, 26 May 2025 03:22:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d9f09622sm2089434f8f.98.2025.05.26.03.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 03:22:12 -0700 (PDT)
Message-ID: <ac596aa4-8345-460e-8828-4a4158dfbcd6@redhat.com>
Date: Mon, 26 May 2025 12:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tests/qtest/bios-tables-test: Prepare for changes in
 the ACPI tables
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
 <20250526053123.1434204-2-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250526053123.1434204-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Gustavo,

On 5/26/25 7:31 AM, Gustavo Romero wrote:
> This commit adds to the allow list the ACPI blob related to the base
> aarch64 'virt' machine and all of its variants, in preparation to adding
> the ACPI PCI hotplug feature, which changes the _OSC method, the GED
> device, and adds a couple of new methods, like the PDSM.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Cheers

Eric
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..abe00ad4ee 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,6 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT",
> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> +"tests/data/acpi/aarch64/virt/DSDT.topology",


