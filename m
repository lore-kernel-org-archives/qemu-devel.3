Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE14C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVA3l-00022e-4H; Wed, 31 Jan 2024 07:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVA3f-0001z8-5e
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 07:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVA3d-0007ac-Fl
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 07:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706705471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1adi20XgDz8qlQPBo4K7MvT2oAJeeLghOaNhOswNzJ8=;
 b=JsBEjaeeItZWvSkgdHVCwohSve5atado7jKDB/p/HSDT/JZrDE0BNodyaPYnw2h0zO8hmz
 t64c5THbCeCdKm5XzfZFZzUPHO7lluGpTgbzPcGlscQlCgvxDd52ZlfY1lT5j8sskAf4iK
 qGJ/bzoin+wc/A9FIP/divK6DXjF6c0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-G1RT6zCRPvOAcSloWWy0OQ-1; Wed, 31 Jan 2024 07:51:10 -0500
X-MC-Unique: G1RT6zCRPvOAcSloWWy0OQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5102bbe883aso3544513e87.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 04:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706705468; x=1707310268;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1adi20XgDz8qlQPBo4K7MvT2oAJeeLghOaNhOswNzJ8=;
 b=k3pBWgUKUKRLYWKcqgAmpTynrjoRp0FaRJTlV5lZcU/MP2oJ5ul69O5w3LkSNs1k+b
 NReT2Hr/HgdIAPnKF0FUQ6tDxcT187QwUP9HcLNniMiD8hU4k0bKNLbEvkyiD7cTcFRM
 39qczoI5DwNr6G4muOqfm82nTsKRQzEGE7lfNZDrwGRRz/fqr1g5CX9Iuk2UpWue8+hv
 NtQcL1gZHLZ/aI0cf3oL3D594db1r0d4pXZUXRYnaEH3AbDM+U8IBHlZLmRvPqbIS9R/
 8eR+i6MobbX+J4EGHqiwhYsSUyI1wYyz/7+TxQiHaDeU1skg/8fyASYQRjUB+rZkfMNw
 t1yw==
X-Gm-Message-State: AOJu0YyxX0WH998G1zcq91yx3RArG5In1L0szjIFtGHJtwP7VjvQ1Bku
 HYllnFGqYKSbCK6RdzXjRCpDutjGaBx+WqBZbnVsaOBv/VLWP3urKx8J1MsS+HlLNPUlHJdE2ql
 jOHNgAanynexcf1E8yYobnw8Nx3K70TULEuyvL2dn9pLnVivCatuJ
X-Received: by 2002:a05:6512:33cb:b0:511:9dc:d8bf with SMTP id
 d11-20020a05651233cb00b0051109dcd8bfmr1325009lfg.67.1706705468765; 
 Wed, 31 Jan 2024 04:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpHvfFzvgug+uevF1W2gYbY6lLJQe5JNiv8sfOe6vXY4LgDH9sdwY+gwgrG+51JXmVnpvIqQ==
X-Received: by 2002:a05:6512:33cb:b0:511:9dc:d8bf with SMTP id
 d11-20020a05651233cb00b0051109dcd8bfmr1324990lfg.67.1706705468421; 
 Wed, 31 Jan 2024 04:51:08 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 fa1-20020a056000258100b0033af5716a7fsm5723563wrb.61.2024.01.31.04.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 04:51:08 -0800 (PST)
Message-ID: <628d5031-09b6-4295-86f0-4e07de149c2d@redhat.com>
Date: Wed, 31 Jan 2024 13:51:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/vm: Set UseDNS=no in the sshd configuration
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
References: <20240125194840.1564-1-iii@linux.ibm.com>
 <20240125194840.1564-2-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240125194840.1564-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 25/01/2024 20.48, Ilya Leoshkevich wrote:
> make vm-build-freebsd sometimes fails with "Connection timed out during
> banner exchange". The client strace shows:
> 
>      13:59:30 write(3, "SSH-2.0-OpenSSH_9.3\r\n", 21) = 21
>      13:59:30 getpid()                       = 252655
>      13:59:30 poll([{fd=3, events=POLLIN}], 1, 5000) = 1 ([{fd=3, revents=POLLIN}])
>      13:59:32 read(3, "S", 1)                = 1
>      13:59:32 poll([{fd=3, events=POLLIN}], 1, 3625) = 1 ([{fd=3, revents=POLLIN}])
>      13:59:32 read(3, "S", 1)                = 1
>      13:59:32 poll([{fd=3, events=POLLIN}], 1, 3625) = 1 ([{fd=3, revents=POLLIN}])
>      13:59:32 read(3, "H", 1)                = 1
> 
> There is a 2s delay during connection, and ConnectTimeout is set to 1.
> Raising it makes the issue go away, but we can do better. The server
> truss shows:
> 
>      888: 27.811414714 socket(PF_INET,SOCK_DGRAM|SOCK_CLOEXEC,0) = 5 (0x5)
>      888: 27.811765030 connect(5,{ AF_INET 10.0.2.3:53 },16) = 0 (0x0)
>      888: 27.812166941 sendto(5,"\^Z/\^A\0\0\^A\0\0\0\0\0\0\^A2"...,39,0,NULL,0) = 39 (0x27)
>      888: 29.363970743 poll({ 5/POLLRDNORM },1,5000) = 1 (0x1)
> 
> So the delay is due to a DNS query. Disable DNS queries in the server
> config.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/vm/basevm.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 61725b83254..c0d62c08031 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -423,6 +423,8 @@ def console_ssh_init(self, prompt, user, pw):
>       def console_sshd_config(self, prompt):
>           self.console_wait(prompt)
>           self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
> +        self.console_wait(prompt)
> +        self.console_send("echo 'UseDNS no' >> /etc/ssh/sshd_config\n")
>           for var in self.envvars:
>               self.console_wait(prompt)
>               self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)

Reviewed-by: Thomas Huth <thuth@redhat.com>


