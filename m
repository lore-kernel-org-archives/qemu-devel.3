Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95104C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 06:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUi5I-0007wV-5c; Tue, 30 Jan 2024 01:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rUi5D-0007vp-7M
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 01:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rUi4w-0003lX-5L
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 01:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706597921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WxClyGfTwtX4VdpMs8ZKjWC1wWhym4mhBekitpn5oGQ=;
 b=Zn3eI2m1/xrmzd9zXuSSKw14o42Fhq27WxFg/Rluyb5cQv3Ng3i5HKt35L0caQ02lw/m/F
 GRTjFYj60bR+sudXPh068KrNG58seo5XSyzGRMxQ9+DrAKZP+cnfRJMB0FyRHEGv2MjLZl
 gj95UbPxTq79XlGimapU+0hm5ZlhnpA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-WJqBpmaKPyipp1UgM5XgSg-1; Tue, 30 Jan 2024 01:58:39 -0500
X-MC-Unique: WJqBpmaKPyipp1UgM5XgSg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2cf4bc64f69so30886631fa.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 22:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706597918; x=1707202718;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxClyGfTwtX4VdpMs8ZKjWC1wWhym4mhBekitpn5oGQ=;
 b=ToCXMcHVjHULyHS4rjFxDPUYx4/U35xvBYndzS31JBJNBz3w54/4TKEIc7BQmjogSa
 DknxoRZH++1uhM7DdQ0kwa3r1lhBTmlxeYEH8lAiDPXjyam8MIFh4bTm1CZa1cbWe4aq
 0sAWkVOGcYzdDHP3Q6nyiNHq0YvKtRjyhkpX1hYf4+Wd1Rea1ZWp7W2aVlQVpXgA09td
 +5i4t8cLeFPTPQ1/CCdvdnYpgxI5hLLUiCuuEdTSWmRqyojktR+3nrctaeoswl0njDC3
 35uDdhHKlDYIzIIK3st72cQ0IVhwGPUAlvznh7T/Uc2YIHzERcVmKefWcNtG5QE3mf4A
 ObUw==
X-Gm-Message-State: AOJu0YyCvktegiCuw47LmMR5f5u46ZiAQQStBvEZx1sJ4g4HbYbAdnFD
 KCq+HmGd7/D/hX30IGD8EnwoGR9QpalrjU82H65Jsmx+Fgy/8lt1dlD0HzaqvtZKziypoSmVhmp
 j4QQJKkphBSW2tlgXtmoi6Jc2nl4MvA4m4F00yLWBpDGmhGA8G8rY
X-Received: by 2002:a2e:938b:0:b0:2d0:5658:d09 with SMTP id
 g11-20020a2e938b000000b002d056580d09mr988121ljh.5.1706597917861; 
 Mon, 29 Jan 2024 22:58:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+x6TT71sIaEQRTIqcubKYhTlOFHrRFaj4IEtc9dn+gav7TRxTJFq4dmIXyquHhsAkkjxqJA==
X-Received: by 2002:a2e:938b:0:b0:2d0:5658:d09 with SMTP id
 g11-20020a2e938b000000b002d056580d09mr988113ljh.5.1706597917533; 
 Mon, 29 Jan 2024 22:58:37 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 bm10-20020a0564020b0a00b0055f411d6014sm296972edb.42.2024.01.29.22.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 22:58:37 -0800 (PST)
Message-ID: <5e7464a5-209e-457f-b661-e67332cd28b5@redhat.com>
Date: Tue, 30 Jan 2024 07:58:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] tests/qtest/pvpanic: add tests for pvshutdown event
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
References: <20240129-pvpanic-shutdown-v5-0-f5a060b87c74@t-8ch.de>
 <20240129-pvpanic-shutdown-v5-6-f5a060b87c74@t-8ch.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240129-pvpanic-shutdown-v5-6-f5a060b87c74@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 29/01/2024 20.28, Thomas Weißschuh wrote:
> Validate that a shutdown via the pvpanic device emits the correct
> QMP events.
> 
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   tests/qtest/pvpanic-pci-test.c | 39 +++++++++++++++++++++++++++++++++++++++
>   tests/qtest/pvpanic-test.c     | 29 +++++++++++++++++++++++++++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
> index b372caf41dc0..e1c05d383219 100644
> --- a/tests/qtest/pvpanic-pci-test.c
> +++ b/tests/qtest/pvpanic-pci-test.c
> @@ -85,11 +85,50 @@ static void test_panic(void)
>       qtest_quit(qts);
>   }
>   
> +static void test_pvshutdown(void)
> +{
> +    uint8_t val;
> +    QDict *response, *data;
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev;
> +    QPCIBar bar;
> +
> +    qts = qtest_init("-device pvpanic-pci,addr=04.0");
> +    pcibus = qpci_new_pc(qts, NULL);
> +    dev = qpci_device_find(pcibus, QPCI_DEVFN(0x4, 0x0));
> +    qpci_device_enable(dev);
> +    bar = qpci_iomap(dev, 0, NULL);
> +
> +    qpci_memread(dev, bar, 0, &val, sizeof(val));
> +    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
> +
> +    val = 4;

Could you use PVPANIC_SHUTDOWN here instead of the magic value?

> +    qpci_memwrite(dev, bar, 0, &val, sizeof(val));
> +
> +    response = qtest_qmp_eventwait_ref(qts, "GUEST_PVSHUTDOWN");
> +    qobject_unref(response);
> +
> +    response = qtest_qmp_eventwait_ref(qts, "SHUTDOWN");
> +    g_assert(qdict_haskey(response, "data"));
> +    data = qdict_get_qdict(response, "data");
> +    g_assert(qdict_haskey(data, "guest"));
> +    g_assert(qdict_get_bool(data, "guest"));
> +    g_assert(qdict_haskey(data, "reason"));
> +    g_assert_cmpstr(qdict_get_str(data, "reason"), ==, "guest-shutdown");
> +    qobject_unref(response);
> +
> +    g_free(dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
>       qtest_add_func("/pvpanic-pci/panic", test_panic);
>       qtest_add_func("/pvpanic-pci/panic-nopause", test_panic_nopause);
> +    qtest_add_func("/pvpanic-pci/pvshutdown", test_pvshutdown);
>   
>       return g_test_run();
>   }
> diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
> index ccc603472f5d..ff1f25f46586 100644
> --- a/tests/qtest/pvpanic-test.c
> +++ b/tests/qtest/pvpanic-test.c
> @@ -58,11 +58,40 @@ static void test_panic(void)
>       qtest_quit(qts);
>   }
>   
> +static void test_pvshutdown(void)
> +{
> +    uint8_t val;
> +    QDict *response, *data;
> +    QTestState *qts;
> +
> +    qts = qtest_init("-device pvpanic");
> +
> +    val = qtest_inb(qts, 0x505);
> +    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
> +
> +    qtest_outb(qts, 0x505, 0x4);

dito, use PVPANIC_SHUTDOWN instead of 4 ?

(as a separate clean-up, we should maybe also introduce a #define for 0x505 
one day, but that's something for another patch)

> +    response = qtest_qmp_eventwait_ref(qts, "GUEST_PVSHUTDOWN");
> +    qobject_unref(response);
> +
> +    response = qtest_qmp_eventwait_ref(qts, "SHUTDOWN");
> +    g_assert(qdict_haskey(response, "data"));
> +    data = qdict_get_qdict(response, "data");
> +    g_assert(qdict_haskey(data, "guest"));
> +    g_assert(qdict_get_bool(data, "guest"));
> +    g_assert(qdict_haskey(data, "reason"));
> +    g_assert_cmpstr(qdict_get_str(data, "reason"), ==, "guest-shutdown");
> +    qobject_unref(response);
> +
> +    qtest_quit(qts);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
>       qtest_add_func("/pvpanic/panic", test_panic);
>       qtest_add_func("/pvpanic/panic-nopause", test_panic_nopause);
> +    qtest_add_func("/pvpanic/pvshutdown", test_pvshutdown);
>   
>       return g_test_run();
>   }
> 

With PVPANIC_SHUTDOWN instead of 4:
Reviewed-by: Thomas Huth <thuth@redhat.com>


