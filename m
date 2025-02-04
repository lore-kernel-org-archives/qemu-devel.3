Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A84C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfD2L-0001DC-3V; Tue, 04 Feb 2025 02:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfD2D-00017t-Fl
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 02:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfD2C-0004IT-4K
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 02:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738652866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uNjCgVuyeIElYttdKJKPR46f1EfWRRdzrsundMziGWI=;
 b=eSUgeYtXfntFkajoqLrthckq8jaB7m3hTrkpU9k1PYBwczWjWZBJ3h2/neLNZN6vBD/1Af
 mGOgXuG9iv+ZV0zi9LWLJoQmX2qB9vQiuT35Qlmp5rNidSxbM3SBnb3PqF7RYalJFRicvj
 qdfgCDmbRaI5bexvn/az3D5fvLw/0oc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-HKSegFoVOQO5wPvuhqMjYg-1; Tue, 04 Feb 2025 02:07:44 -0500
X-MC-Unique: HKSegFoVOQO5wPvuhqMjYg-1
X-Mimecast-MFC-AGG-ID: HKSegFoVOQO5wPvuhqMjYg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38da7135a19so197765f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 23:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738652863; x=1739257663;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uNjCgVuyeIElYttdKJKPR46f1EfWRRdzrsundMziGWI=;
 b=NpXf7HKqnpVNCSrLo++Qprwk9rUDNwN4GEGWnYKYIvph0T26Ff1zQa6Bajrzf5Neu6
 0ND8/BAJBjIOYkIG4AeipM1AIXw0Ih33lQq/CuWkkqmB2VLBLz081w4m6/1eJtA4pFE2
 NQeaScGFsAUxvoS5MX5LujOlgqj7AcmMiOEhop7gRu4F5WLl4zf6R9fHBuJPITM+yVQJ
 BVV2WwgRaDLL27eNvp+k6aAT3mKCNpKojQsLz/n6uW/g5YGCt/Y/9KHf5EAWoKdoYWEo
 Yo8FjlI8XFARhDZfGeRJV4hJdHcmCALVeHOWXSziPe8zXibFjBipvvEKSokFOLYG7fE/
 2UUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt8MMnrdgdNc/WJnj54TtwF3BbO7qUZeng1+CLXV1ykqGytrUS4bu5w8rkLhK0L+klbfZsbX+K3B6e@nongnu.org
X-Gm-Message-State: AOJu0YyqxNuft7Ct79KWKyeE3LRZb4xvkRPpsHg1a4JOUMO+Ze8o5Sxi
 kUlGoeR4IpVQ9fnglzww0oOZk/lLgQicaNyUGNETnV1hqm81Yc73odcWKPhhyNSgF/DcHGr4OHl
 6R6vGTAoPgVOYjVHJbfLCT1KvpHh5vJJdwF29szH61OjFPhIi9qXN
X-Gm-Gg: ASbGncsDm5wd9fSHVa4gLkWjLLxxuB5bRRziZyIYoV98eieswal7jWHyHsuSqc20bYo
 tkm1EPa+vwdL3xwbBKNapxEjqnAaa3j4svfv/g1at4G5km+AJQPeTf8YQRoXJTxJV9yfTzuFEml
 PAlwxi91D/clL5Jltrm1kBiCpca1jHmgAPlkd8zf0U8IcGAjXyUirUfsOSPAW7y7CG2reER7rrW
 2z1bbgZLXJV3kMk4peUG9RL/Awc+Q/8SjppFbf6ChkYnKNmt20cp7hP1uzI17uwEVdF7g2m5N/1
 RSH96SDBK0+aXejs3sDgch1qNOA8WLuM/bA1
X-Received: by 2002:a5d:6d86:0:b0:38a:518d:97b with SMTP id
 ffacd0b85a97d-38c519311d8mr19192009f8f.11.1738652863615; 
 Mon, 03 Feb 2025 23:07:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSn1LZCScag6to9Tp3UuDQTRV5bpNr9hgs/eMUBEsWbZP5j9P7I/HeqME+MxG7HqYfaGRiGg==
X-Received: by 2002:a5d:6d86:0:b0:38a:518d:97b with SMTP id
 ffacd0b85a97d-38c519311d8mr19191986f8f.11.1738652863259; 
 Mon, 03 Feb 2025 23:07:43 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102d2esm15119864f8f.33.2025.02.03.23.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 23:07:42 -0800 (PST)
Message-ID: <47db9d33-8fa4-4ebf-90c9-db6e252cc38e@redhat.com>
Date: Tue, 4 Feb 2025 08:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/3] hw/boards: Rename no_sdcard ->
 create_default_sdcard_drive
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org
References: <20241125181420.24424-1-philmd@linaro.org>
 <20241125181420.24424-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241125181420.24424-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/11/2024 19.14, Philippe Mathieu-Daudé wrote:
> Invert the 'no_sdcard' logic, renaming it as the more
> explicit "create_default_sdcard_drive". Machines are
> supposed to create a SD Card drive when this flag is
> set. In many cases it doesn't make much sense (as
> boards don't expose SD Card host controller),

This indeed shows the insanity of the previous state, thanks for tackling it!

> but this
> is patch only aims to expose that nonsense; so no
> logical change intended (mechanical patch using gsed).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
...
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 86fcf9c81f..5cec73ae68 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -285,7 +285,7 @@ struct MachineClass {
>           no_cdrom:1,
>           pci_allow_0_address:1,
>           legacy_fw_cfg_order:1;
> -    OnOffAuto no_sdcard;
> +    bool create_default_sdcard_drive;

Can we maybe still bikeshed about the naming here? The current name is a 
little bit long, and maybe we could "standardize" the prefix of the flags 
here a little bit. We already have one switch starting with "has_..." and 
some others starting with "auto_enable_...", so I'd maybe suggest one of 
those instead:

   has_default_sdcard
   auto_enable_sdcard

WDYT?

  Thomas


>       bool is_default;
>       const char *default_machine_opts;
>       const char *default_boot_order;


