Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93358C02184
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXOH2-0006D1-58; Mon, 13 Jan 2025 12:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOGt-000643-DE
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:30:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOGr-0006AY-G0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:30:39 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso3631441f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789433; x=1737394233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6UMwhXmNjZAdUkXjp0QmzSaxy/RvPOLp1C6Jdu4DK6M=;
 b=v74FM+l6SCjlvE12/M1w5EjQp1KaJKeWsOpVqOt38cl4NEkxNo3JjjWNbAGjbR8McV
 XPYCwciWfW78MA5D5kcjAYmd9Zht5v8PQ4Ftc5eZQOcfDzfK8dPQARaRHkPnAEMBalJr
 gw2lD+DGxTdoQ95ibg1N098ssXPWHJ0ykY0j4CCV6X7w7x7J/5gUt+vF6R8Dj/AyEK/o
 BuX/sDwi61QJG9UP6Se6jii20w8qc6qDUzMTpRo508H8byhIPoWx6gWvv+0MfKuFdg/1
 RFBoddClSihPS0tAtJFgapvI0O8u14E2b0aeJMDxG+T1yBZ0sU25muQOKHGJLIi2alyj
 BQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789433; x=1737394233;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6UMwhXmNjZAdUkXjp0QmzSaxy/RvPOLp1C6Jdu4DK6M=;
 b=MZ9OC/gE7iNxb26VVbYSiCaKnD7b4sVsnE4lDKJcmwy9EHP+mF1wfWqYZ3yu/DlAo7
 r3PZH/aSfF71VCaVBD/JNr93E/PB2D+74LXQRS4ZGBT87XK1VwweTtzZ7SIOitS3VszR
 I9Ho1A61fdvEe8nMHX9Bjnj3AJabPGYwQIuCXdUmsx+uVdOkMxCpxnSyG0IUyLm0KeOf
 xD3YiQjMNuCk1zSScBt5VtADeMB/vg45/8vLGoW30mezsQZfBUCt7fmyOcOY5dcjQHB3
 jvh64A+gr+UofTHIdQ7HOs0hiW3ZpEICkM9iyfGJLZme40iBoFM0lfh9D8YaAtqj1Koe
 KSGg==
X-Gm-Message-State: AOJu0YxM2sYKu9tImsYPWb7ZRMBIflN4pG13m9YzgnIbzykuuu+HxAAg
 vflMMDbWPDAys9FmEgg2tgGbdhvn8gClvJv/PfCLNFTLRbMsyIcBsir3su3sXEWOeQkhtcyCjmt
 7DdE=
X-Gm-Gg: ASbGncvp9qZ4zNgZjyzg3GaeHnYsD8smGuRzTLykiNoyqthEE0guUqO+k6usdraaSQF
 Dn+QDnrN/r3BUsDx7ZhI4+jJmR/wljqYv0qE/AKTtayLnFebM3QZadPvCW4wW0dCxLMYbIJoEW2
 qSxhyzl+IQYIDAwTjxYZfdxVvRwi2nVn/x/Vvtvkro9ftH0461jCY5UtVM89YMeYGJbJmppqndP
 IM85YvYcX3/vf8NY6V/Lhw9o36c/p0My2yU8LDpXi8eQvIEUlh4XENUAFr9JroA9Z3jiEleR3RZ
 jX0e67in28WFcKVHDJGKap1b
X-Google-Smtp-Source: AGHT+IF1qWUsh21LPAX3sqU697B05NGYKw4jqGmRGXJ10M5zOFGfOGca1l26k5uIbAwpuAhbTNOt3A==
X-Received: by 2002:a05:6000:712:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38a87305369mr17912376f8f.20.1736789433300; 
 Mon, 13 Jan 2025 09:30:33 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80d4sm12402945f8f.85.2025.01.13.09.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 09:30:32 -0800 (PST)
Message-ID: <5c5d7e11-0085-4543-be7c-b2ce61f7535f@linaro.org>
Date: Mon, 13 Jan 2025 18:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] hw/core: Unify hotplug decision logic
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250110091908.64454-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 10/1/25 10:19, Philippe Mathieu-Daudé wrote:

> Akihiko Odaki (6):
>    hw/qdev: Pass bus argument to qdev_hotplug_allowed()
>    hw/qdev: Factor qdev_hotunplug_allowed() out
>    hw/qdev: Introduce qdev_hotplug_unplug_allowed_common()
>    hw/qdev: Check DevClass::hotpluggable in hotplug_unplug_allowed_common
>    hw/qdev: Check qbus_is_hotpluggable in hotplug_unplug_allowed_common
>    hw/qdev: Check machine_hotplug_handler in
>      hotplug_unplug_allowed_common

Series queued.

