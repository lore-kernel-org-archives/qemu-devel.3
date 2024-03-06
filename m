Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A177C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhur7-0003Ve-Uh; Wed, 06 Mar 2024 12:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhur6-0003V1-3I
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:15:00 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhur4-00088T-Lh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:14:59 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a4532f84144so151412566b.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709745296; x=1710350096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjsyNthJQ6LEz6SX9rxTBbqUR1TTwhwhwoVKkXhpUAw=;
 b=gsldvy/wb4MwcltD3VSvRWgGz3R486l6SZ/q0cf2CsfNjTEpKmjvCm9H529dO/iV2p
 KDhYuZ5SHDEdWTDF68QEaR3WEiJi9Bv0UDTZvzssuOY8FzwQpvV/6Z/OlbsStiLtBnZK
 XAvE6dLXManqCkOYrdI7VHPCzeWvUO3GWBu3Jfrq0QVxS/QTqwNlXXFLH36wFgaUTrsY
 t/BMwY97uQFb1USxgVFxwSet3YZAYc9bgYJmPz3OWjzbvQs1o3t6hKSFO6Ew4oRiN9Wb
 4rvFsB4qXCtKdxf5m9b0FOHIGLnlnIlNbA+ajtgF/DFfrgb4oTQC4JZIaiO/bSXvNa9d
 S8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745296; x=1710350096;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjsyNthJQ6LEz6SX9rxTBbqUR1TTwhwhwoVKkXhpUAw=;
 b=Fr5G6vJPY4kvCYS5yuGJr0vqbKUrYaZ9GxET3ltQdpOmA+6jA45hoj8ampdKhi5aLo
 d4lY9ZqQHkxeNwWE1wVCr7vXFRjKYi9BOUiyeM49eV7/EqtVFYShB5FYJhY2XOAr2fCj
 eKXSJeYmNT6X5UxGQreJRVhb824QlYJv9C0nLgWkvY1IGhgsGhZvgmrr9pgA8GAb81rQ
 O7ANRUaLPKFzxji8D9ePBRb1oknWPhd2We5ZIwIsLk4rfwUpPI/Fzjrd5ajkaEiy7qbe
 ATVKc9jysXpp5q7IDoh1lopRiCj/sqw0o9mQFEnCfqj9uuiSGW0yu1lfW3vxYYtuohnP
 nd4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEcdnVAm7TSeTLRmyg4l9RWJU0KpMq7W1vssC//NIwxPHZLmsdg2vyEKE7WVg0oz4/diZ0x/mLIyFZ10zNncKFzuEoWyA=
X-Gm-Message-State: AOJu0Yweu/KjB5TRq+9LXgI3D8Qc6HFD9LUag0gycirNA37VbpKDhrF0
 uHeuxVgUFdJ3kao2LeLq3oTAxnYM4Xpwf/WD/BpeEkaVc3bA9dSk9ynLraP7VWU=
X-Google-Smtp-Source: AGHT+IEzDMCAv1jmeGC0ooiGaix7vjr0dWNnW+e2K3+cHwRyHziRS4ipyA3ZMUpeB9SviZ5lAMKGMA==
X-Received: by 2002:a17:906:b154:b0:a45:da1:9375 with SMTP id
 bt20-20020a170906b15400b00a450da19375mr7102659ejb.30.1709745295992; 
 Wed, 06 Mar 2024 09:14:55 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 m26-20020a17090607da00b00a441ff174a3sm7372337ejc.90.2024.03.06.09.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 09:14:55 -0800 (PST)
Message-ID: <68c4a4ad-cc49-4917-b1d6-d0f28b611c05@linaro.org>
Date: Wed, 6 Mar 2024 18:14:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 10/19] hw/xen: Rename 'ram_memory' global
 variable as 'xen_memory'
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, David Woodhouse
 <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-11-philmd@linaro.org>
 <84F1C2D8-4963-4815-8079-B44081234D41@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <84F1C2D8-4963-4815-8079-B44081234D41@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 14/11/23 16:49, David Woodhouse wrote:
> On 14 November 2023 09:38:06 GMT-05:00, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
>> To avoid a potential global variable shadow in
>> hw/i386/pc_piix.c::pc_init1(), rename Xen's
>> "ram_memory" as "xen_memory".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Well OK, but aren't you going to be coming back later to eliminate global variables which are actually per-VM?
> 
> Or is that the point, because *then* the conflicting name will actually matter?

Eh I wasn't thinking about running 2 Xen VMs in the same QEMU process,
but this is a good test case. I was thinking of running a Xen guest VM
and another TCG VM in the same process.

So IIUC xen_memory should be part of PCMachineState.

> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks!


