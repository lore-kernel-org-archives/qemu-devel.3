Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F465C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU56u-0000t7-Tf; Wed, 17 Jul 2024 09:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sU56p-0000pj-W8
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sU56o-0006u7-Eg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721224457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJS5fKvJD7ge9tWHf2BAvXO7kx289tm4UKkm0QMu0sI=;
 b=jO4bvMwrxgbdcvJRgwaRgsIMo4NGTzE2oSCU8GIrEcgzNdP+HfR5aIis0zR9yxFyCcmvMZ
 q8io6+xq/sDPLzNB2lqEE2oxkizMiwCKWufhyFLWiB1JYPZscojIxTay/+xWYSmEhhFNPz
 m7IT/Tkgba4jsQsZrSmOrVOjTqWy+Bk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-D9DtLw4ZPj6Glmfb0TW3Ig-1; Wed, 17 Jul 2024 09:54:12 -0400
X-MC-Unique: D9DtLw4ZPj6Glmfb0TW3Ig-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4265464ddc9so4731855e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721224450; x=1721829250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJS5fKvJD7ge9tWHf2BAvXO7kx289tm4UKkm0QMu0sI=;
 b=KJkrymxTxcht3gG/d+cn6HcNzNgbm5ev/Qb9EqUhKIhFvYFy5a7AWbAsRuJL1WS1rX
 SK3EY68HBVnVmqHDz8vEz6ffOCmOO3JNvcGqXmJRwOl2ydSo8ABz4yFYvXlQBUFOQ4aa
 pv/g8awbLll40gwa1xIvLz6q2BUVXKTaq4PX21u1SJ5r1mBg8Ap14AfRjwWJalKwV7Ye
 Tkk1fbOcPW5TEufm9YtCjXCYE+xyTg0OpPKEVvJaScXCMKrXB5pnYFcEOWwxFz9oqcw4
 +v5c1KqC+mDCvCBd0FUH8jRoW89FP/QRV15nvKCFidYNdENNYOGfdPV06rs57zy2apa1
 8ooQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpsLJKEsrgywaQZNf3RkmY8gV4quVyt75v/gX2kpBwMgkK5hHarL57E4Ws1mXM1tOd30idEU1iXRv788K+VvWGl3Og4sU=
X-Gm-Message-State: AOJu0Yxi32GVBV2yXKPMVTqWbGTZhL4aYooaZC29zeLEMjCqLpCgWbxE
 g3xfQ+s/OyvgBAhMFHKIJxfNfeEkpQInlmohTur36g7TyCylN1Y6Xj2Qb9WsRKQPpsmotMCHucI
 AgkPv/c32lltPhpGVvDZQv8mvEVN+FX6a7wW3prdWnx55FP+mu0dK
X-Received: by 2002:a05:600c:34d0:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-427c290a187mr14452905e9.9.1721224449936; 
 Wed, 17 Jul 2024 06:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOOHDEc80qg6PI0gocku6E8plFkaKo7rz8okbY90FRKZynXabUaNJY9Em3+8yymLlnOWpAXQ==
X-Received: by 2002:a05:600c:34d0:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-427c290a187mr14452715e9.9.1721224449588; 
 Wed, 17 Jul 2024 06:54:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccbd2sm11787928f8f.49.2024.07.17.06.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 06:54:09 -0700 (PDT)
Message-ID: <9e0e1879-7859-44df-81a2-362323f9df01@redhat.com>
Date: Wed, 17 Jul 2024 15:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/machine_aspeed.py: Add eMMC boot tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240717130657.648701-1-clg@redhat.com>
 <e29093fb-d36f-4d77-ba1c-e277f2441d09@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <e29093fb-d36f-4d77-ba1c-e277f2441d09@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/17/24 15:49, Philippe Mathieu-Daudé wrote:
> On 17/7/24 15:06, Cédric Le Goater wrote:
>> The image was built using the process described in commit c8cb19876d3e
>> ("hw/sd/sdcard: Support boot area in emmc image") with artefacts from
>> the latest successful build of the IBM P10 BMC platform available on:
>>
>>    https://jenkins.openbmc.org/job/ci-openbmc/distro=ubuntu,label=docker-builder,target=p10bmc/lastSuccessfulBuild/
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/avocado/machine_aspeed.py | 38 +++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
>> index f66ad38d3503..1deb8472818f 100644
>> --- a/tests/avocado/machine_aspeed.py
>> +++ b/tests/avocado/machine_aspeed.py
>> @@ -439,3 +439,41 @@ def test_aarch64_ast2700_evb_sdk_v09_02(self):
>>           self.wait_for_console_pattern('nodistro.0 ast2700-default ttyS12')
>>           self.ssh_connect('root', '0penBmc', False)
>> +class AST2x00MachineMMC(QemuSystemTest):
>> +
>> +    timeout = 240
>> +
>> +    def wait_for_console_pattern(self, success_message, vm=None):
>> +        wait_for_console_pattern(self, success_message,
>> +                                 failure_message='Kernel panic - not syncing',
>> +                                 vm=vm)
>> +
>> +    def test_arm_aspeed_emmc_boot(self):
>> +        """
>> +        :avocado: tags=arch:arm
>> +        :avocado: tags=machine:rainier-bmc
> 
>            :avocado: tags=device:emmc


updated.

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +        """
> 
> $ make check-avocado AVOCADO_TAGS=machine:rainier-bmc
> Fetching asset from tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_ast2600_debian
> Fetching asset from tests/avocado/machine_aspeed.py:AST2x00MachineMMC.test_arm_aspeed_emmc_boot
> JOB ID     : ed89ecf5e166e7f636cc731c0242ba6e714fea39
> JOB LOG    : build/tests/results/job-2024-07-17T14.45-ed89ecf/job.log
>   (1/2) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_ast2600_debian: PASS (21.55 s)
>   (2/2) tests/avocado/machine_aspeed.py:AST2x00MachineMMC.test_arm_aspeed_emmc_boot: PASS (43.71 s)
> RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> JOB TIME   : 174.68 s
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Thanks,

C.


