Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6F9C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRty-0007t9-6N; Tue, 20 Feb 2024 10:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcRtv-0007sn-Py
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcRtu-0005jy-9P
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708442357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4e/nqx+uEGz8LcHxdWxE3X/+360t+eVItkH34I+Ez8=;
 b=KlSTTVGjNJ1f0s2fNfQaXwV7vqROYH6ySLI7YGrqtwhuKshPzVeWPHB7oui75oPgjZpT+4
 u4pM0VqAPEenAZywR4xZusJgl8Van5mANbKA2/lMA1cd+/7EYutgNsDGZOR/ebdQeotqdb
 JJ3SBsj5YL2nQzJilDPakCuC+/+3gBs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-8tk5LwUlPVqdWDFYemk6AQ-1; Tue, 20 Feb 2024 10:19:16 -0500
X-MC-Unique: 8tk5LwUlPVqdWDFYemk6AQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68f740ea9a8so34184376d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708442355; x=1709047155;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S4e/nqx+uEGz8LcHxdWxE3X/+360t+eVItkH34I+Ez8=;
 b=qj/Bo0kZTeuTAkfc0nboyWppQDOlg36EtwjP5jQocjVPIUQM9WqJxx57K3eHgDoTgd
 HLdJxCU062QRVIFLqpQ+N5obxafPUL/NuFRDrxbBn1qJ9ypgHTvKQrPNqobWm8WKhsmo
 //9J1NBOqgCxg+wMJ6fjxJR+zdF0Czj7NRelc73XRRgbrg5+AgLT20bV+JE2zTqWnu4+
 mSUMwhoH0+H6Yv0FD9xuvZhWoy3Pe/2g2K1QlD0XJcwcs00ojkOG7IANn7NoveMAt2cl
 BXkMPUD6omt85gxPepnDWh0IgbQjwRRN6qrJvBRJCFUKimvSZzC13gf22WD9NYShmxC5
 iGXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCtrbKDyuB3y0e8u6tFKobflZyrS+YWc/XyU0HfuvZ84yEWT7wAFS0iwcSgOVTRLbR90M+3PucMoKeulWIAEeiqv2s9u0=
X-Gm-Message-State: AOJu0YwNZuE+jY5L0Zi/1sT07w++ahCm73He+zouPohSYPZvZPn0p58+
 Xina/XHM2s8Jq4TWYESwwR/OiEHy8wraWOyKHHT84tLbfFRL42enQi2dnC9BS3ux6iKNdt4yama
 gA09CsebJOB5UaLn7vq1SupLdvU9CYvG/z6gzTDZzcHDMqy52mM4A
X-Received: by 2002:a0c:ab13:0:b0:68f:98dd:b5e8 with SMTP id
 h19-20020a0cab13000000b0068f98ddb5e8mr1552831qvb.8.1708442355640; 
 Tue, 20 Feb 2024 07:19:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCb/nso3EkCHVXEYUT3Ov6t6EXhvkK6riJlc6WP/AT2EHf/hl7TOjOLennnm/vXsEN1rCzjQ==
X-Received: by 2002:a0c:ab13:0:b0:68f:98dd:b5e8 with SMTP id
 h19-20020a0cab13000000b0068f98ddb5e8mr1552812qvb.8.1708442355434; 
 Tue, 20 Feb 2024 07:19:15 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 ks6-20020a056214310600b0068f2b9a6ec7sm4489395qvb.18.2024.02.20.07.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 07:19:15 -0800 (PST)
Message-ID: <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
Date: Tue, 20 Feb 2024 16:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240220150833.13674-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240220150833.13674-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/02/2024 16.08, Philippe Mathieu-Daudé wrote:
> Have s390x always deliver NMI to the first CPU,
> remove the @cpu_index argument from handler,
> rename API as nmi_trigger() (not monitor specific).

Could you please add some rationale here why this is needed / desired?

Thanks,
  Thomas


> Philippe Mathieu-Daudé (4):
>    hw/nmi: Use object_child_foreach_recursive() in nmi_children()
>    hw/s390x/virtio-ccw: Always deliver NMI to first CPU
>    hw/nmi: Remove @cpu_index argument from NMIClass::nmi_handler()
>    hw/nmi: Remove @cpu_index argument from nmi_trigger()
> 
>   qapi/run-state.json        |  5 +++--
>   include/hw/nmi.h           | 24 ++++++++++++++++++++++--
>   hw/core/nmi.c              | 24 +++++++++---------------
>   hw/hppa/machine.c          |  8 +++++---
>   hw/i386/x86.c              |  7 ++++---
>   hw/intc/m68k_irqc.c        |  6 ++++--
>   hw/ipmi/ipmi.c             |  3 +--
>   hw/m68k/q800-glue.c        |  6 ++++--
>   hw/misc/macio/gpio.c       |  6 ++++--
>   hw/ppc/pnv.c               |  6 ++++--
>   hw/ppc/spapr.c             |  6 ++++--
>   hw/s390x/s390-virtio-ccw.c |  8 ++++----
>   hw/watchdog/watchdog.c     |  2 +-
>   system/cpus.c              |  2 +-
>   hmp-commands.hx            |  2 +-
>   15 files changed, 71 insertions(+), 44 deletions(-)
> 


