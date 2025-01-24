Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37894C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJko-0001Gp-7q; Fri, 24 Jan 2025 08:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbJkl-0001Fd-9N
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbJkj-0002x7-GY
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737725379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qdpgGilDnUOWUiGuoKAy0VLSV2IxQwO5L8RVJiJTu1c=;
 b=VFt+aXzDgd6D1vv6YZxffBI6XG9TMwEjAlT6Odn4STY/qrs3qhK+SR+FSe+onisLxw5oxO
 tMTJCZ/9jvVQHqlovgsd57kXGQm6RumqB/6D8KZ81xKqsbbppqq2mLLSJPi72ApMBVQB77
 oVXNb9yjHqxHvIsJgX4xvLVP3Wwe9b8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-_MAKcSdXMGWafrd2g7Rb5g-1; Fri, 24 Jan 2025 08:29:36 -0500
X-MC-Unique: _MAKcSdXMGWafrd2g7Rb5g-1
X-Mimecast-MFC-AGG-ID: _MAKcSdXMGWafrd2g7Rb5g
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8f8b9d43aso38727486d6.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 05:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737725376; x=1738330176;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qdpgGilDnUOWUiGuoKAy0VLSV2IxQwO5L8RVJiJTu1c=;
 b=vLMIpZ2jwoLET55OvGIAUxJWQlIHPpoWRCiQwhCaf+8Eg3onBx/yd6Jh6NraTMQef4
 xz7DyMgou7lF/iLiIfztw+82qFiDPUjC+iG3Ek2fzcUyYGOjHIyoCxd2RiSezGQea45h
 xBv9X304mwhI1+rRDy4rIG8+0ZrnBA9B1Q5A4AnUZXRBEeeofysw6116GRBIIJHvB9JA
 pjQjX9VYZgYjpShVYEorkZQOP8oT58IsJw0PesUeXTEeL6o7Nl1oT2LFqOshjl6OxCJA
 lIa499es4NHqHovDohw09cTYYH4YNc+cslzpHpFZTo5WPGQrG28MDVWQ6mi66wCWXd47
 5y4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkU8xc4BYczA9MT+fpkKYT/yfJ/lhREUBglUNFGhlr6YTeBrlOx97TGPPGwpq/NN9O2yvkL9gM62kk@nongnu.org
X-Gm-Message-State: AOJu0Yy+z0AvTDP16BOHkOA9dQayp6QUpYfIQqWbC38bIRPuXBDHPJ3N
 DN93mpeUmwn2F97DdhD/m5hXnlGbnuCH3X+59gFdundZFSRYYpNFSy5fgm3G/msnaAJ5P9n5ObT
 D/ZhLEXCstRDOLOsIzkTiBNh86xZ6Kbc7X6bovtVdZt9hwPAGjivM
X-Gm-Gg: ASbGncsQWLuWu3klRioxA/nhOhreQptKgctxzSOSqznF1Cv6BDO10iGKFq9e7xQHrXN
 WHb5gSF4+IWmAVbIGUHVX24qBFNpVXnjMkYqazihzy8WQegiEm/EbSFCm/h9QUnQJleQd+XLAtK
 Vyuror2j1iCtS8Am6RAZoL0wSLDSSFNyezE7VJogrLggx5dDNd+AZt3gOAsmUa7NhwbqnP2HKJ0
 xXatGt7Z3LykOtSOkJz0ul8d2hPRB6VJd0sPfreX7t9loVaorOMRw5iIQTfctigcqWnhYidu071
 NZqzpDnu3bUv+oQGjwdkGp7BNQ==
X-Received: by 2002:a05:6214:acc:b0:6dd:3c07:ae48 with SMTP id
 6a1803df08f44-6e1b224acf6mr498425916d6.37.1737725376101; 
 Fri, 24 Jan 2025 05:29:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF33nfNflRPPgLlBhtRnqnjpppODRSkFPyKxCi55RhGRh0OddiRTji+B0XQU5MOAXGP25ggLg==
X-Received: by 2002:a05:6214:acc:b0:6dd:3c07:ae48 with SMTP id
 6a1803df08f44-6e1b224acf6mr498425676d6.37.1737725375838; 
 Fri, 24 Jan 2025 05:29:35 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-134.web.vodafone.de.
 [109.42.48.134]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e205137058sm8619436d6.22.2025.01.24.05.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 05:29:35 -0800 (PST)
Message-ID: <d9094d1e-10bc-4b15-9efe-ebc8bab5d158@redhat.com>
Date: Fri, 24 Jan 2025 14:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/32] tests/functional/aarch64: add tests for FEAT_RME
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-16-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250110131754.2769814-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/01/2025 14.17, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> This boot an OP-TEE environment, and launch a nested guest VM inside it
> using the Realms feature. We do it for virt and sbsa-ref platforms.

  Hi,

FWIW, I just saw this test_aarch64_rme_virt test failing once. Looking at 
the console.log, it seems like the guest crashed somewhere at the end of the 
firmware or very early in the kernel:

EFI stub: Booting Linux Kernel...
2025-01-24 13:25:28,226:
2025-01-24 13:25:28,226:
2025-01-24 13:25:28,227: Synchronous Exception at 0x00000000BF526498
2025-01-24 13:25:28,227:
2025-01-24 13:25:28,227:
2025-01-24 13:25:28,228: Synchronous Exception at 0x00000000BF526498

I wasn't able to reproduce it afterwards anymore, but in case somebody runs 
into this later again and wonders if it is a later regression: It happened 
for me with commit cf86770c7aa31ebd.

  Thomas


