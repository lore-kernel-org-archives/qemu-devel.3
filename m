Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE72C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 22:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pUw-0004YA-Af; Wed, 08 May 2024 18:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pUv-0004Y2-EZ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:10:49 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pUt-0002Vf-RL
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:10:49 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-572baf393ddso2231139a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715206245; x=1715811045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+YR4jXtNvdEQo8GrbDGmvutAU7puCjh48YVn1Fz0U4=;
 b=ed8XZ62aUMKj9FtMaBPtEmav9WBWrjClrVGf/j+Fv0tuXXYseqelu5IKQAyzXXXiuo
 9a4zfv8Doqo8//Jucb9GHRudlzQYPDkmJf/FOuzCnUWBEzjJ+1as8DBeBss04oMEQXdF
 ousih39MB49q/dhvupNPTe9SMX9tJBXXJh4hwXJpsvTGpo8fVIBupoHN9l61x9bW6Gv4
 qhEldR3CFhY7ceLH6xkToYuhQ+sUF9CKrZmUIHMCJhB+jzN84DzFBON+M3ob1gLkjgqb
 uZrIAvk1oZr2h4WQxG29nE0vz79bW6fiX+cvaeG76f4rr1bNPzWYPXemounEus+E+04C
 SKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715206245; x=1715811045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+YR4jXtNvdEQo8GrbDGmvutAU7puCjh48YVn1Fz0U4=;
 b=uyoJEDbKR5LCQGzwDGBar86PsQbQjF7yMiBrmDU7uWh6Tc3w7xvaukc+5EecEMDqFa
 mmJZRoZ+LRXJ4xciotLeN3/dNw4tZNNnYRfG+iRlkfLld6TullmkgEfYbZTuIDeqRFRU
 vYYxsmpZBUp3qllegTYO/2up4/Qmlvo1y+yccAqH4LWWq8PkwNtHnxZ6IWzBuI80AJPa
 xtIQKE1tYTuYYvq+X62fW8kc0Kq3lUN8i0nzcd2J/9AxO2qTOMzeheW+Ntf7qHbXHnh3
 z8XFBgRpF1CZYqJKa8JrL2z7Xg2rq+aytwoEHIqMYj7X5EsgvXGwsQgUqxK4h+3qtiio
 6ffA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzzId2XnTIj4MJE/nGrIlKsrD3MkFFGSEHrM0w12sfFE8St6Xu/HRYr3i5aIS88TZg7a7cXzSG+EZ8Cw8b1UntV5rP1Ew=
X-Gm-Message-State: AOJu0YxVQUSr9M32WPxIX1J+H7R+gG1Jf1LKqAkdixOIQMaxldc6armc
 HFPSWA+dbrx4tMYkW7BvDQKGw1cmLCEkuEAdxtk+WqjdDuu7mOxWBNNmC5TS+FY=
X-Google-Smtp-Source: AGHT+IEV6NcFplKqEzHYQ5PeHUJ+LemfrYuvqHO1FOryiZGnIimFQpTjp0cT2/9OzdFa3kJUh0BdVw==
X-Received: by 2002:a17:906:714a:b0:a59:c944:de4 with SMTP id
 a640c23a62f3a-a5a115beb08mr69135466b.2.1715206244647; 
 Wed, 08 May 2024 15:10:44 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d367sm6643466b.45.2024.05.08.15.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 15:10:44 -0700 (PDT)
Message-ID: <b758cfc9-aa45-471d-841c-532821d5faa5@linaro.org>
Date: Thu, 9 May 2024 00:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] X86: Alias isa-bios area and clean up
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <20240508175507.22270-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508175507.22270-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 8/5/24 19:55, Bernhard Beschow wrote:

> v3:

> * Add comments for bios memory regions (Phil)

> Bernhard Beschow (6):
>    hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
>    hw/i386: Have x86_bios_rom_init() take X86MachineState rather than
>      MachineState
>    hw/i386/x86: Don't leak "isa-bios" memory regions
>    hw/i386/x86: Don't leak "pc.bios" memory region
>    hw/i386/x86: Extract x86_isa_bios_init() from x86_bios_rom_init()

Patches 1-5 queued, thanks.

