Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB7C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtjD-00059i-Lz; Mon, 05 Feb 2024 02:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rWthk-00038V-SJ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rWthi-0006HG-B1
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yH/HTwT/7idPrL8rJ6rVxSdm9aHrnfAw72vdabpyV1w=;
 b=bOGW9Of+SHb+KZs9w3OYiBXt+C+ZuKC1v4CUvqF2LLedfK3YARhR6CQ5kVmEby7ciXVVK3
 bPSzgm5f2FWtEttci03u/+swPlL1Ec4NONEWi3Qvw5AzRQNtXne49s0GVq0vpCUH76Jdup
 WqJgD5HN+mW0I6x/0WEoEwMx3sJFMxs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-w2lpcLIkOKWjW8K6HEBSAA-1; Mon, 05 Feb 2024 02:47:43 -0500
X-MC-Unique: w2lpcLIkOKWjW8K6HEBSAA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b1b431b3cso1351131f8f.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 23:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707119262; x=1707724062;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yH/HTwT/7idPrL8rJ6rVxSdm9aHrnfAw72vdabpyV1w=;
 b=LGlnuD+xSKz9/RcDcICIVMwE+Fg/kIE1dbxFHb7qoNs8FRJAUc4r+3GclCqJF21xU4
 vRm9AfkQfJNHx63uBqrv3JOTYdNOq/zwNTmM6TqU3ZoMnd324eauhnQgcGjUAUpCf1ml
 mX2+F9i+V551N1dNqTh7IvSF8J6mybPJwJU3FylVoq69GhbrVDKCpQxdC6yLQhRw8XAE
 5cgSDrjzcxxRgsbM5iWzGIZFSzkj7qhpGMbX5Fozswb40PSsKaGhQeXl3VS6aXxAhTFY
 zGwX2EVw0nASIbBYzOA2FDh0WI6IzjPEsHJRkVY9NGW1H/XIAaAbMZVCPXmdMLNuaiTb
 uTIw==
X-Gm-Message-State: AOJu0YwmuOl6nXUnZxgL592lw45ExzuTnMAVk09rGyln17I8weRDlIMW
 eJyB0eDg/1YFXwXndjpsbuHiLSWIWCOHZ7sh0rsBP3/Ph5E3bHoTe3xGv+wXiZ1jjJaDeovb2i3
 P/ZsZVehKHPlBs2/Tn77LopPZCf1gwGo+2yk6FdkhDrn20rHefiB1
X-Received: by 2002:a5d:4682:0:b0:33b:180d:edc7 with SMTP id
 u2-20020a5d4682000000b0033b180dedc7mr5543158wrq.17.1707119262610; 
 Sun, 04 Feb 2024 23:47:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwtnAxmf5MjSAQcEoYtXcLhXL9qA8v6IrULDwCPS0r/jofWBtqaBV6Z8k7ngvNIq3DiHF7iw==
X-Received: by 2002:a5d:4682:0:b0:33b:180d:edc7 with SMTP id
 u2-20020a5d4682000000b0033b180dedc7mr5543146wrq.17.1707119262082; 
 Sun, 04 Feb 2024 23:47:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU3HmU5jc38Z5Fp3XMDi00GaThIhGv6Q569yu8xTZpVOlMiydHt33LuWKHJbHovBYUvYPM9CwpjkJkjvTlMLjhyDyVSHe5f+i9Jb59RTAPix3oBEz5nKZ85kS7ad26QOxXHNWIFDz29Ox0KFF5Kp+3t
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 o4-20020adfe804000000b0033929310ae4sm7415845wrm.73.2024.02.04.23.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 23:47:41 -0800 (PST)
Message-ID: <613f883e-cf64-43e5-85b6-64381c46ffa2@redhat.com>
Date: Mon, 5 Feb 2024 08:47:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/cdrom-test: Add cdrom test for LoongArch virt
 machine
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20240205021318.3759925-1-maobibo@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240205021318.3759925-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 05/02/2024 03.13, Bibo Mao wrote:
> The cdrom test skips to execute on LoongArch system with command
> "make check"

Are you sure the test is marked with "skip"? ... it should at least test 
with the "none" machine...?

> this patch enables cdrom test for LoongArch virt
> machine platform.
> 
> With this patch, cdrom test passes to run on LoongArch virt
> machine type.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   tests/qtest/cdrom-test.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> index 0945383789..c8b97d8d9a 100644
> --- a/tests/qtest/cdrom-test.c
> +++ b/tests/qtest/cdrom-test.c
> @@ -271,6 +271,9 @@ int main(int argc, char **argv)
>               const char *virtmachine[] = { "virt", NULL };
>               add_cdrom_param_tests(virtmachine);
>           }
> +    } else if (g_str_equal(arch, "loongarch64")) {
> +        const char *virtmachine[] = { "virt", NULL };
> +        add_cdrom_param_tests(virtmachine);
>       } else {
>           const char *nonemachine[] = { "none", NULL };
>           add_cdrom_param_tests(nonemachine);

Anyway, using the virt machine is certainly better than the "none" machine, so:
Acked-by: Thomas Huth <thuth@redhat.com>


