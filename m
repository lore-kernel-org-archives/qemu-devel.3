Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C378C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAvZ-0006Be-Eu; Wed, 29 Jan 2025 11:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdAvJ-00067e-Ce
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdAvH-0000lO-By
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738168093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZIPg1eKEiMXEzqmCeyUBf+s/54UmKdKqedFuyEWAu2M=;
 b=NFbT19l9UImD4hQ3luyo9StLwkMR7vp+pL792/N6Klpr9XmuM4+TmWSjiLskngbXM5wjwK
 Dbj05BIgRZMgXid4WvTweWcfIyY4bydFM9jQYzTUWxVjDO5TqggPCISAOoynXuVmxVtTYs
 JvbcLr4A2YrmmzP67TWJco5DuUpEB/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-Mx3mfhFiMN-lFmvFe-Q83g-1; Wed, 29 Jan 2025 11:28:11 -0500
X-MC-Unique: Mx3mfhFiMN-lFmvFe-Q83g-1
X-Mimecast-MFC-AGG-ID: Mx3mfhFiMN-lFmvFe-Q83g
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so50624645e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 08:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738168090; x=1738772890;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIPg1eKEiMXEzqmCeyUBf+s/54UmKdKqedFuyEWAu2M=;
 b=gD8kukFrszAIJ4F1qqleUvH0ZwbmTykJyF4tY8vkN8aIz1CeLoWgDqY4u6t3g2asM1
 D3xhpiaii0lgr+5UpnsultDdMsr6PibZYg5pMI7sGmlM+Pzv7WwQdgOvrAf6e2dGcyBk
 6FB+Dr7YNoBZkOxpFx7EachYPFk1dDcaZ/AYLJ/t+luUCFxtGE6NbhjYTqp5YHo6uL1B
 0Xg2VpRtRTsWDdwCMkiGempdJP9YWfn20IupJOVlm/OlBTNuHTtdbCJ1LpJ7dYApxVXq
 DhlA1SKEHBRmVFyIU9rvbifO/YJAdcZljMXNa8EGYLEWR4nnAeKCjF9IFRCcvJGtMvq+
 JmgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHR7f3gFGa5xfzBJ/qgleDfzPOyn2WwJGAExkOVsngs5gSXvl4QIT9RtU+HS3D917EEF+0TQxEXkvp@nongnu.org
X-Gm-Message-State: AOJu0YzLWg7Tuw8dlGQG6/Iv7l27Qio+QeRpEx0coPGrkEIbP47+l7Nz
 3KPvi+Hc6vo1+CHep5zhvF1C2wBHtVxL45CGaCoOd9ZZf2L+nb4F8vV6lhvLrKKRYJjamum8rZC
 gg/1WUf0ibe8PeEu1Um6t2C6C4XJixZWv/MjoJ6pULpITntsizFE4
X-Gm-Gg: ASbGncvOW1krqW6iwDswgPgH9DZYJo97BgssbTYf8Meop7F4g8rH9wtZR0gYgh02oL9
 X5TyuTUay1tRGErgrdSaBqWYXIudxnAYEv9SHWePvqXsCaC9AZP+yF3yjhDx9kr0POiBvsxgNZY
 CTMNZuzh6zslSslFU5kBi5mFCWgVRZPLMil2fj925Cma7CPUSnuWA5zlo3cpSyIVBmvdIuC9KDi
 gwn8t58+CbHuGDInvASlynUWIXt+g4ym+r4XzWaAKXYJbUBa51wDRlWyz85seP5L2pdhsAxuvPd
 6/hu1BI494IlCcpzNqq4k1Eu4A0JYa+XgQDijopUMoI=
X-Received: by 2002:a05:600c:5252:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-438dc3ca9cfmr33225505e9.13.1738168090548; 
 Wed, 29 Jan 2025 08:28:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSmdq6ih9VoZUdi46ubWRKWFlCPOAtkVUyGDGTGXJlgwKWHDo67pE8j7JFJZ8F/TfgJSCVpA==
X-Received: by 2002:a05:600c:5252:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-438dc3ca9cfmr33225305e9.13.1738168090049; 
 Wed, 29 Jan 2025 08:28:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188a61sm17728283f8f.52.2025.01.29.08.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 08:28:09 -0800 (PST)
Message-ID: <815ec281-f4b0-43e4-ba56-1400d16dfe21@redhat.com>
Date: Wed, 29 Jan 2025 17:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tests/functional: Introduce a new test routine for
 OpenBMC images
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250129071820.1258133-1-clg@redhat.com>
 <20250129071820.1258133-2-clg@redhat.com>
 <98b2cdec-dcd2-44bf-a81e-91521e2bd446@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <98b2cdec-dcd2-44bf-a81e-91521e2bd446@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On 1/29/25 08:58, Thomas Huth wrote:
> On 29/01/2025 08.18, Cédric Le Goater wrote:
>> The OpenBMC images currently used by QEMU to test the Aspeed machines
>> are rather old. To prepare an update to the latest builds, we need to
>> adjust the console patterns. Introduce a new routine to preserve the
>> current tests.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/aspeed.py | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
>> index b52358bb8c61..51c821944842 100644
>> --- a/tests/functional/aspeed.py
>> +++ b/tests/functional/aspeed.py
>> @@ -23,6 +23,24 @@ def do_test_arm_aspeed(self, machine, image):
>>           self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
>>           self.wait_for_console_pattern("systemd[1]: Set hostname to")
>> +    def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
>> +                                   cpu_id='0x0', soc='AST2500 rev A1'):
>> +        hostname = machine.removesuffix('-bmc')
>> +
>> +        self.set_machine(machine)
>> +        self.vm.set_console()
>> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>> +                         '-net', 'nic', '-snapshot')
> 
> "-net nic" is the default anyway, so unless you also use "-nodefaults", I think you can simply drop that?

OK. Will do.

Do you want a resend for that ? Unless you prefer this series
to go through you tree, I will amend before sending PR.


> 
>> +        self.vm.launch()
>> +
>> +        self.wait_for_console_pattern(f'U-Boot {uboot}')
>> +        self.wait_for_console_pattern('## Loading kernel from FIT Image')
>> +        self.wait_for_console_pattern('Starting kernel ...')
>> +        self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
>> +        self.wait_for_console_pattern(f'ASPEED {soc}')
>> +        self.wait_for_console_pattern('/init as init process')
>> +        self.wait_for_console_pattern(f'systemd[1]: Hostname set to <{hostname}>.')
>> +
>>       def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
>>           self.require_netdev('user')
>>           self.vm.set_console()
> 
> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks,

C.



