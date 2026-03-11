Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E581125811
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NyY-00034u-MU; Wed, 11 Mar 2026 14:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w0NyW-00033j-3e
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:08:04 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w0NyU-0002uz-D4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:08:03 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 a8ccd0bcda0aa330ef475c8a55a2c4da82a545dbae874159e3564d95b69cf6a3 with SMTP id
 69b1af80fc41d7a42a109b00; Wed, 11 Mar 2026 18:08:00 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773252479;
 bh=1U7/vjK2LA6Phidiuu9ZV2hcGkPsOeOxCVzmz3nA/VE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=JTJTk9M27Bdk5i2dD0nBmu58rfzfseN57kQZsRDRSKd6YH1DYXE1+Kfckia6ND3Wr
 yTVoTcoRzzKey298u+knL0BY55n1yRPXe4/AvdWriDdCQKcC/GBFGuCgem/AcR+qhd
 ziQATesiOthIXctdQb4hFrLSdlfTtfFafF8313cp6+Jlpoqj8KAWJu81M0Rf0fSycX
 4Sm1Mc1Rd3ADqb6V5vHTCR0Fp1cbROGF3McZgZMbQDp8RqEB6NgQT+uVmJygr7QdTu
 Q2Tx0Ypw8mF1M2UMMi97jcTECIYs8uCvuvLAH8oX943t8UTjJ5JnGHfuyF3lWbYSjc
 kwubCwE95alhA==
Message-ID: <e833b8b3-b00e-4a71-a40c-85d92654a177@yodel.dev>
Date: Wed, 11 Mar 2026 13:07:58 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 05/15] hw/alpha/typhoon: Create instance_init and
 class_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-5-4375b00a85ff@yodel.dev>
 <0ab6bb36-0938-4ab9-a769-e0aa364c40e2@linaro.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <0ab6bb36-0938-4ab9-a769-e0aa364c40e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Philippe! Thanks for commenting here and your review
of Patch 10.

On 11/03/2026 07:43, Philippe Mathieu-Daudé wrote:
> On 10/3/26 23:31, Yodel Eldar wrote:
>> Define the Typhoon class and instance initializers.
>>
>> Add "cpu[*]" link properties in the instance_init of Typhoon.
>> Setting these cpu link properties will occur in a later commit.
>>
>> Note: This is one step towards splitting typhoon_init() into the
>> instance_init and realize hooks. typhoon_init() currently takes
>> a fixed cpus array as a parameter; that array will be removed soon.
>>
>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> ---
>>   hw/alpha/typhoon.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
> 
> 
>> +static void typhoon_pcihost_init(Object *obj)
>> +{
>> +    TyphoonState *s = TYPHOON_PCI_HOST_BRIDGE(obj);
>> +
>> +    int i;
>> +    for (i = 0; i < 4; ++i) {
>> +        g_autofree char *name = g_strdup_printf("cpu[%d]", i);
>> +        object_property_add_link(obj, name,  TYPE_ALPHA_CPU,
>> +                                 (Object **)&s->cchip.cpu[i],
>> +                                 
>> qdev_prop_allow_set_link_before_realize, 0);
>> +    }
>> +}
> 
> Hmm this machine is modelled using quite legacy style. The Typhoon
> PCIHost object shouldn't have direct access to CPUs but only expose
> IRQ lines, then the board layer wire these lines to CPUs.

Yeah, by inheritance the Typhoon is a PCI_HOST_BRIDGE, but
it's doing much more than that, so it's currently tightly
integrated with the CPUs.

I narrowly limited the scope of the series, so I hadn't even
considered decoupling the CPUs before your comment, but now
that I've been looking at it more closely: AFAICT there are
three nexuses we'd have to disentangle (please let me know
if I missed anything):
  (1) the CPU interrupts you mentioned
  (2) the timers that live in the CPUs (for now)
  (3) returning the cpu index when reading the MISC register

I think (1) and (2) are relatively straightforward: connect the
wires as you suggested with the IRQ handler in the cpu, and move
the timers into TyphoonState, respectively. (3)'s a bit trickier
IMHO: I suppose we could keep using current_cpu for (3) since
resolving (1) and (2) already lets us eliminate TyphoonState's
cchip.cpu, but it would be nice to remove that, too.
Open to suggestions. WDYT?

Thanks,
Yodel


