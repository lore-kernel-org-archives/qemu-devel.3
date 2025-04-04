Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46C0C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fqw-000489-4H; Fri, 04 Apr 2025 08:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0fqt-00044z-63
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0fqg-0005Dg-Ce
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cjIGTwm0H7/7WStqyk/Ilkt1ON1hmYvaAkxrwYvs3Y=;
 b=aqCGyqD3wSEqiNelkVJuhaByi+K3asZEr2YQ3+pP0zZDBsyAgeqtmIXATbhbDqGE9iULLZ
 TdkwT/OGM6aCUpxBd/Cr+g7ZT5h788yEA1gwE2Xi1cIZ0ljDtuKj+BQxkOTF7/UcwdW/Ph
 bd1vIYK5OYw7RIoXRvHaZDN/0fsty88=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-EW_w5cHBO1ymsgAuP4SPgg-1; Fri, 04 Apr 2025 08:08:31 -0400
X-MC-Unique: EW_w5cHBO1ymsgAuP4SPgg-1
X-Mimecast-MFC-AGG-ID: EW_w5cHBO1ymsgAuP4SPgg_1743768510
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso883449f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743768510; x=1744373310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cjIGTwm0H7/7WStqyk/Ilkt1ON1hmYvaAkxrwYvs3Y=;
 b=p8iWiFTIAi8ULmiae6dX3B6jSqKlBrieIS56AkZkM8gPSj2jXTGdCk4MZUKbdsFCub
 CA6sewDkafe25p7Ef89UhnKK4YFbzfmtlt+UexL92bpT++8eg3EvhXAtV0UczlhFBP7d
 kCg+7hgVDznapTuWOnBw21K9QCNQig3jX9DQddtyBiNC3KjIQ7KXBhbMqXrYK2tpQU3a
 RaqvCwMD9eaxek8Dl6aKrTod56Pn+q4rr8RlxlL7tAEov2WYR5AKfkRoIpicFM6sfR/7
 jmn+B8kPcsRjtAGMiUF7TeRYttVASDq9Z4lPfkN/pXpzjjnJfwN26PcpuOxKtHfGuFAA
 n4Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp2/nXeSixCpXr22IAaezob4dCnIeC1XJaiBcbylthuRhgQfBsFQ9iPsHZJbduzYZgpIQ0ecxdPhIB@nongnu.org
X-Gm-Message-State: AOJu0YwIsMeVd1sFuxEjqD0qsemlplFntxfHE6ArlmwM0jOQwjNfbsaK
 Yj9E6OKUDH/fSjLZrAbUiTL8IooiNbDQsdAknXb8zbJAB8nl7w1xhYhft7fA15ee/KxrdRFJ4Xf
 BshbZMLUIYum6wEYBzDpEBXYtZehZ3v85ph9Ks4flyKc9SRHfAxDj
X-Gm-Gg: ASbGncs1o5EQSU7AUlPZ77hsrdWTxgchOGpaNjjiP3V+CrrfuGykk3xeqem7V64Uf3z
 vUBr9epC6Kxa2huAgEV2BNLA9Zs5tQMgvywLZQx2ue8XcSGdwGARsqIFYbQvfDFi4tvlKdtK2tR
 drae9V/s0/sgw3Z/K2sfem0HN7ZAYtgdmFE07BwezHbxkAHHmsVaL7/78SSCoF9rpXPD3CVATE4
 c6gmIk4b66OJQDPnb/aRY9rPUx2WtDc2RqMvxkhxrjk/k4mU1UZtuHwL4r8coI4dVrRHWVspVYJ
 XZ+TVtqlACSKFhQJtL1Mj+NAuIGvBQaZtrQL
X-Received: by 2002:a05:6000:2289:b0:391:39bd:a361 with SMTP id
 ffacd0b85a97d-39d0de16c83mr2364776f8f.18.1743768510320; 
 Fri, 04 Apr 2025 05:08:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzY2Ab1iweasNMhwltENnAO0ZYBpRv7aF9+D78HUbtDgXF2fjWwnMIBaop2mbsmQ/tpSwOOg==
X-Received: by 2002:a05:6000:2289:b0:391:39bd:a361 with SMTP id
 ffacd0b85a97d-39d0de16c83mr2364748f8f.18.1743768509994; 
 Fri, 04 Apr 2025 05:08:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226a12sm4147036f8f.83.2025.04.04.05.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 05:08:29 -0700 (PDT)
Date: Fri, 4 Apr 2025 14:08:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v6 3/6] hw/loongarch/virt: Fix error handling in cpu unplug
Message-ID: <20250404140828.6041ef56@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250321031259.2419842-4-maobibo@loongson.cn>
References: <20250321031259.2419842-1-maobibo@loongson.cn>
 <20250321031259.2419842-4-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 21 Mar 2025 11:12:56 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> In function virt_cpu_unplug(), it will send cpu unplug message to
> interrupt controller extioi and ipi irqchip. If there is problem in
> this function, system should continue to run and keep state the same
> before cpu is removed.

see my comment to 2/6, the same applies here.
(unless there is a good reason why it can fail)
 
> 
> If error happends in cpu unplug stage, send cpu plug message to extioi
> and ipi irqchip to restore to previous stage, and then return immediately.
> 
> Fixes: 2cd6857f6f5b (hw/loongarch/virt: Implement cpu unplug interface)
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 8563967c8b..503362a69e 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -958,6 +958,8 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>      hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
>      if (err) {
>          error_propagate(errp, err);
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
> +                             &error_abort);
>          return;
>      }
>  
> @@ -965,6 +967,10 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>      hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>      if (err) {
>          error_propagate(errp, err);
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
> +                             &error_abort);
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev,
> +                             &error_abort);
>          return;
>      }
>  


