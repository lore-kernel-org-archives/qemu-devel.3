Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D68C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHLs-00086k-KO; Tue, 06 Feb 2024 04:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXHLp-00086P-Cx
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:02:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXHLn-0000Ke-Gc
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707210162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SgCpAJ+D0+581t9pr36pAO7o/zqH8x3MBDUpECAaHBQ=;
 b=AxNGzIhQ4p+toffXpr/OVsPNGjqhh+4sbvUntn0MaG6qEnbX6fTMdxt1KaQc9aFcR208Y7
 o+gLtGE/3iMSmEdMWsei2Fz64DUkesgwPLR7fccCKmZzSIy5aC7K/GYvlHHHgxGAl+qiYe
 sQiK0S8TNB/PyqPhjTMRgmopmz+MCWg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ER71jqlXN1SiY7Wo-rdEXw-1; Tue, 06 Feb 2024 04:02:39 -0500
X-MC-Unique: ER71jqlXN1SiY7Wo-rdEXw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d0c1968e51so371691fa.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707210157; x=1707814957;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SgCpAJ+D0+581t9pr36pAO7o/zqH8x3MBDUpECAaHBQ=;
 b=pS70ZMQy7qPpYt+uD5iZ2rKVXK60SzQxSZmb14hSgA1+NtDOvKEbD0iFDhRB5y65Kz
 XPRz/8s2nO9Ghbo6uiIl8g2/BgE34XAl+w11ibLpsNz0WkmqDa6F64PLLV37ndp+AHU8
 +DHMIoGgKFNMNb2WtpSE5uzUbbPaFtjEBxPEou/N+5zbIByX9Yfelw8oV2rFsydOVp3i
 zGHP3oUvwn0SrnZfw3WxtAdO6wgu/BWorPknv1v3iqdU7flF3eDWh95tD7hMN5qh6xLs
 TFaBS+GpZ+gTluTtXUan92YLILC0Sbsi2kNvJ92sVsuMp2rVN/T7t9dHbZsHpUN/4mia
 +yHw==
X-Gm-Message-State: AOJu0YxkPY7p4e/+wI52rh1iPO4ZiVSxoRQ2rg0kB7HUJaeI4l5AGVVN
 22PWLw3hgbet9mASV2I16aL2T2iH9D6Whj1SMuPc1qe592B2A+Fe+yLizG0qcr6Ln8CeEMe0+UD
 JkiXvwBpoLvXOPminBtz75Xma8vQQxK5DuLMlJpoVcP7Kb9gavY04
X-Received: by 2002:a2e:a23c:0:b0:2d0:a32a:a516 with SMTP id
 i28-20020a2ea23c000000b002d0a32aa516mr1276664ljm.44.1707210157685; 
 Tue, 06 Feb 2024 01:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUskRqe+FTLJ5n4oax4gdIQ+UTA4X65swd6EVFUNHJB6DoQb7x/Hwo6jwt6MxWTZ/7Ny+ORg==
X-Received: by 2002:a2e:a23c:0:b0:2d0:a32a:a516 with SMTP id
 i28-20020a2ea23c000000b002d0a32aa516mr1276640ljm.44.1707210157268; 
 Tue, 06 Feb 2024 01:02:37 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWRp37kLWAZvq5aBjDu8i6fB+VetTmkbPneTEPcI7npnYOi+j/Myyv1CJqrI0nC0QQfa6GPodBn6yLzLcjwZfMIiwgV6u6pda/o4OZMPXXWvQTwaHNWs4qT8GteiQt7kiEKyiYaNgLbbgr8KGsE+I/3mAsr/lPk4chBguCt+VgczpvNuqXXHh5J7HDhUWmjoxipyJu9e55exDFZ6Med3BvWwBZF8SlExojz5LT6B6lewAIjvEaJnQeyHDKWAyPbaAKBt1HSFyhRTdC73DFj2cRTO/cW8bo7h/tielKyn3v8J6rpH1aODPPJWXWCQnw7bAU4lar07qa1DePI3gm4804ioDmmh8h2Ej9FBWpD
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de.
 [109.43.177.145]) by smtp.gmail.com with ESMTPSA id
 n10-20020aa7db4a000000b0055ffe74e39dsm809050edt.85.2024.02.06.01.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 01:02:36 -0800 (PST)
Message-ID: <f6987f94-61ae-4f27-b4b6-5fa5f20752d9@redhat.com>
Date: Tue, 6 Feb 2024 10:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] meson: Link with libinotify on FreeBSD
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org
References: <20240206002344.12372-1-iii@linux.ibm.com>
 <20240206002344.12372-5-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240206002344.12372-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
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

On 06/02/2024 01.22, Ilya Leoshkevich wrote:
> make vm-build-freebsd fails with:
> 
>      ld: error: undefined symbol: inotify_init1
>      >>> referenced by filemonitor-inotify.c:183 (../src/util/filemonitor-inotify.c:183)
>      >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqemuutil.a
> 
> On FreeBSD the inotify functions are defined in libinotify.so. Add it
> to the dependencies.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   meson.build      | 23 +++++++++++++++++++----
>   util/meson.build |  6 +++++-
>   2 files changed, 24 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


