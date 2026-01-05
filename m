Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E48BC79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcn8Q-0001eJ-0c; Mon, 05 Jan 2026 11:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vcn75-0000dM-DU
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 11:07:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vcn73-00028E-2x
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 11:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767629240;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GWvc0xeXQt25In2slS15dV8A6RI6XJwCVMMzgTQUAo=;
 b=QMbDHNwVhDy38hITCDv1FjJyZWT1DvWoR8Rxj+oooL6g+fKeWCsAm7Aj6LM8OCY6QQMUgE
 KCij8vY4spFtqBfmMt0VPcrAPruxiKIoGQd8cU2MhfWHobCQNaf1wsgNXjIWaryYI1lcIS
 kJw4Nxde8H+ELsKQgsXZlPJ1nkeg6H0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-kfRUhHtkObewfHBTOaWFIg-1; Mon, 05 Jan 2026 11:07:17 -0500
X-MC-Unique: kfRUhHtkObewfHBTOaWFIg-1
X-Mimecast-MFC-AGG-ID: kfRUhHtkObewfHBTOaWFIg_1767629236
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso398285e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 08:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767629236; x=1768234036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GWvc0xeXQt25In2slS15dV8A6RI6XJwCVMMzgTQUAo=;
 b=UwCHHAKH5LI7l/PdRz1alg5kKUkJrKnfGI9lALUE0bZyJHAAceL3LnRGgxFphKRMdr
 1j/wZ5/+zfoHSl8PVyf4eafVxDN2XPx5kz9E4HMQ8HjwKcisgLxRG9lwQqZMW1+Gcit2
 IWU0paBjNjsEfd3/693p9apr4eJcheoqbCzZ0evSJwSB2dd7YcaOs8tzwp9ijKXtHeQV
 yW2eymAWSzTnlZ4Hp/wpE8lYCzu5oCPLoxm4GV151I+u2n92p7OW20Eb6ML5tKVFbmMm
 MeP789EaC/4GJ0069LSqT12qqILilZWKJQzLTZT4LoL9i1Fs9MA/6h2W2QRdcgjzgp7A
 /1nw==
X-Gm-Message-State: AOJu0YyOqEMuulZzAYzjduk5B5o1s3vA9ydjNyDGTH/E8qAS/hZT2E1V
 tb3ppoPTKFOMjz85UMQOtnA75NS2QPTVZ+83Z5SSLgIwjVOQq544eIMoypl3DMX3+R21X6mwfzM
 tmmMgiNz5H+oXmFP5qS53vpL6IHvBxo5BFaLQRsfKrpEaeHfS+fo3sLzA
X-Gm-Gg: AY/fxX6aWGB9wkmwZroFMSsNmHv8yu0kpo/Hj9ToDQLIokBhgi0XUAeR9gxpgh1YEMX
 n1EM3dTgle4KNup3C18suSmnr4fzmnEE2sSx8f0SHu9ugw9QS1kBEfbS91Mq9kx4xlkVatYQvn6
 KiS/cafSy8qeq0QoXaLrH6WooJCYGRbAUkP8dp0RF/CreRD/8wpnWgIQyzryOtGmSHIVMBdAfrw
 EJs6g2nqp9vt5yLe2dsqqE67yqQjmjcGmqqgWM4IPj1kXvlwhU+98VAcDTJNUkvkB3NExPyIUN5
 BcuDxfdpmb/SoxOVIqnxdHV7yN5faazGOuxsIMkFRvIOIBXzwglYInTJJ1A8b1SJNR2RhhKj+7b
 kpTILWizQqkaro65PhG9RhhPFq1v6evUvnktINvU7FJyCIv/yfS7w2MxHGQ==
X-Received: by 2002:a05:600c:8b06:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-47d3b011b03mr444117385e9.19.1767629235933; 
 Mon, 05 Jan 2026 08:07:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6Ue7USFcKW8MKs3iBSEssrvpcBKLu2iCVLHa1rn3Fy3HK7OPf8D0BCNvbeM6MDibWE1zBDA==
X-Received: by 2002:a05:600c:8b06:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-47d3b011b03mr444117045e9.19.1767629235478; 
 Mon, 05 Jan 2026 08:07:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7ee2a3efsm1310465e9.7.2026.01.05.08.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 08:07:15 -0800 (PST)
Message-ID: <c2e28896-a3af-4dd2-8723-9add5f1b2a78@redhat.com>
Date: Mon, 5 Jan 2026 17:07:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/28] hw: arm: virt: rework MSI-X configuration
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, mohamed@unpredictable.fr
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <c6eafd44-3187-4c63-97b9-bd4bf96595c0@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <c6eafd44-3187-4c63-97b9-bd4bf96595c0@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 1/3/26 6:21 AM, Tao Tang wrote:
> Hi all,
>
>> Introduce a -M msi= argument to be able to control MSI-X support
>> independently
>> from ITS, as part of supporting GICv3 + GICv2m platforms.
>>
>> Remove vms->its as it's no longer needed after that change.
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/virt-acpi-build.c |   3 +-
>>   hw/arm/virt.c            | 110 ++++++++++++++++++++++++++++++++-------
>>   include/hw/arm/virt.h    |   4 +-
>>   3 files changed, 94 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 86024a1a73..f3adb95cfe 100644
>
> I’m trying to clarify the current status of ITS under TCG for the virt
> machine.(may be a stupid question...)
>
> The virt documentation states: "Note that ITS is not modeled in TCG
> mode." [1] 
this is outdated. I think ITS TCG support was introduced in 6.2.0

https://www.qemu.org/2021/12/14/qemu-6-2-0/

You can have a look at the emulaation code in hw/intc/arm_gicv3_its.c

Thanks

Eric


>
> However, when looking at hw/arm/virt.c, I don’t immediately see a hard
> prohibition of ITS under TCG; for example, the MSI/ITS logic appears
> to allow ITS depending on machine/version settings, and the series
> also keeps tcg_its.[2] [3]
>
>
> Could you please confirm the intended behavior today: is ITS expected
> to be modeled under TCG for the latest virt machine?
>
>
> [1]: https://github.com/qemu/qemu/blob/master/docs/system/arm/virt.rst?plain=1#L46
>
>
> [2]: https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L3490
>
> [3]: https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L3656
>
>
> Also, Mohamed’s recent work to support "GICv3 + GICv2m" (and to
> control MSI independently from ITS via -M msi=) looks like a very
> practical workaround for environments where GICv3 is needed but ITS is
> unavailable.
>
>
> Best regards,
>
> Tao
>


