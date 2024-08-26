Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477D3C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 06:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siT8j-0008By-6O; Mon, 26 Aug 2024 02:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siT8h-0008BS-Iy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:23:43 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siT8f-0006ej-Pr
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:23:43 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a86984e035aso422557066b.2
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 23:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724653420; x=1725258220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YO1hpka6mwhmELBhAV2cJopxGIt13GOvBJV4nqQ8K6U=;
 b=yQVPOwkIvZ+u2m4MrBovBl32GgwAQkRc6w6BgSdUkymGV/tlMFVL+m0EdyWVhADAFf
 bbBLtZfWiDMpZG/S+JKJvVhr+mHL5JR8Q2Zy45akReOWR+5gjjFcfMComTnQ1TY4sAhk
 mZp30Yae5J7SBaEQHYK+C5haLROfCJbsJBRAS/xMB6bxYpFsrz2yG3vX52ajxBsrcQc2
 5zbM5lbheYlo+X3MZr2bG9kRwGYAIAUbWQCm1r5cOSIUtPFuePFlxKvtPbhh0mLl+J3N
 Jzprs0uvOzPGLiYFHq0jUcCWERA9yvyZYHvRpXjRJPHPhqGrUXuk6n2lU3odGipI15PH
 2/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724653420; x=1725258220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YO1hpka6mwhmELBhAV2cJopxGIt13GOvBJV4nqQ8K6U=;
 b=cbF3TxU388O3GzOzyWtJ+jRa7dEm8yeoVvbm50GXMjKh7OFW92JLuJ6PYuE704d2i8
 QvDxD/Cfv89iuEvzvD81oL5lAQ4+YRW4rKtQfCEl05qVmauJ7Dbp8/zspGEnfGw6eyth
 /gp3IXF7/CBHOUr9Q1+RBUatXajRHhYEWHIFfNAhkCMo76b4ltHMz0QSV4weB9VbZOxi
 mXhowplE8Sn9YKIgXFO9zqSyQLJvuIZbG3pHOYMqq+ywe2Cs4RvApSA0C/chc3Gq4Yx6
 Nm6UADuLbvMb/O6e2tuCTG6Xd0ZbFBYClwkMn3tqo1VEcOICQaJwCc4bxhhVrc53BMhi
 L2pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIWFha0372za2FgQMJW3kdXN4DixpIGzxwnV4qlmI19dbzxzyjqJnPntmV+L+tAJaA8M79ru4qaYDF@nongnu.org
X-Gm-Message-State: AOJu0YzBMdwgHNK0S0HxOIQwgXiBN/dh97gF9eSf9IAJhaDOnQC8d3CU
 ovbTXo0+54WAgYowvcbyusUndQ9QE6DkrJsCBG0ukwV5Hmk5IAu1qXNAelBSFoo+6MWB+02puLw
 Z
X-Google-Smtp-Source: AGHT+IHphAyCIMdk0EExovi7NSn0R4OTM5iAUQLx5ZAPXIib/zXo5oWDaAi//TUAAsFAuOTc8G6yhg==
X-Received: by 2002:a17:906:db0c:b0:a86:ae95:eba3 with SMTP id
 a640c23a62f3a-a86ae95ef07mr528306966b.62.1724653419547; 
 Sun, 25 Aug 2024 23:23:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f4f4aabsm623044866b.204.2024.08.25.23.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2024 23:23:38 -0700 (PDT)
Message-ID: <1c096ef1-5a61-44a2-a4ad-b3eb8e5e5b94@linaro.org>
Date: Mon, 26 Aug 2024 08:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/16] migration/multifd: Isolate ram pages packet data
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-11-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240823173911.6712-11-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 23/8/24 19:39, Fabiano Rosas wrote:
> While we cannot yet disentangle the multifd packet from page data, we
> can make the code a bit cleaner by setting the page-related fields in
> a separate function.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/multifd.c    | 99 +++++++++++++++++++++++++-----------------
>   migration/trace-events |  5 ++-
>   2 files changed, 63 insertions(+), 41 deletions(-)


> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +static int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>   {
>       MultiFDPacket_t *packet = p->packet;
>       uint32_t page_count = multifd_ram_page_count();
>       uint32_t page_size = multifd_ram_page_size();
>       int i;
>   
> -    packet->magic = be32_to_cpu(packet->magic);
> -    if (packet->magic != MULTIFD_MAGIC) {
> -        error_setg(errp, "multifd: received packet "
> -                   "magic %x and expected magic %x",
> -                   packet->magic, MULTIFD_MAGIC);
> -        return -1;
> -    }
> -
> -    packet->version = be32_to_cpu(packet->version);
> -    if (packet->version != MULTIFD_VERSION) {
> -        error_setg(errp, "multifd: received packet "
> -                   "version %u and expected version %u",
> -                   packet->version, MULTIFD_VERSION);
> -        return -1;
> -    }
> -
> -    p->flags = be32_to_cpu(packet->flags);
> -
>       packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
>       /*
>        * If we received a packet that is 100 times bigger than expected
> @@ -511,13 +507,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>           return -1;
>       }
>   
> -    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
> -    p->packet_num = be64_to_cpu(packet->packet_num);
> -    p->packets_recved++;
> -
> -    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
> -                       p->flags, p->next_packet_size);
> -
>       if (p->normal_num == 0 && p->zero_num == 0) {
>           return 0;
>       }
> @@ -559,6 +548,40 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>       return 0;
>   }
>   
> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    int ret = 0;
> +
> +    packet->magic = be32_to_cpu(packet->magic);
> +    if (packet->magic != MULTIFD_MAGIC) {
> +        error_setg(errp, "multifd: received packet "
> +                   "magic %x and expected magic %x",
> +                   packet->magic, MULTIFD_MAGIC);
> +        return -1;
> +    }
> +
> +    packet->version = be32_to_cpu(packet->version);
> +    if (packet->version != MULTIFD_VERSION) {
> +        error_setg(errp, "multifd: received packet "
> +                   "version %u and expected version %u",
> +                   packet->version, MULTIFD_VERSION);
> +        return -1;
> +    }
> +
> +    p->flags = be32_to_cpu(packet->flags);
> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
> +    p->packet_num = be64_to_cpu(packet->packet_num);
> +    p->packets_recved++;
> +
> +    ret = multifd_ram_unfill_packet(p, errp);

Pre-existing but since you modify this code, maybe cleaner to
"unfill" all packet fields, then check for sane magic/version
and return error, to not let a packet half-swapped. Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
> +    trace_multifd_recv_unfill(p->id, p->packet_num, p->flags,
> +                              p->next_packet_size);
> +
> +    return ret;
> +}


