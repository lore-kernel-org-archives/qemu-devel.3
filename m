Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B111C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 07:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXcRW-0005Lq-VP; Wed, 07 Feb 2024 02:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXcRV-0005Gi-Sa
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 02:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXcRT-0006Mk-5W
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 02:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707291237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v3wgAuDnNaczV+JRHTg8EBiKeiIYlnJbMZKzCvnuHgc=;
 b=C8ohILqV3cPO0fNb0REzZgDJsJgEfzxBczeFK9tTyrGAhL4Xjopj1s64KoZjtMR/dZuXdv
 6hfIAeQQIv0sx2P3cwdfVvEXjs/mIq89pGO9abzy+by4hr+YMTjpqZ/syczkSmIFmZOWux
 Pj5GvJKQhGfzjQcrGCSQwEz6PM93ZVY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-jHO3nHMaOJedXB0sbOhMew-1; Wed, 07 Feb 2024 02:33:56 -0500
X-MC-Unique: jHO3nHMaOJedXB0sbOhMew-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7858e5afdf9so36675385a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 23:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707291235; x=1707896035;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v3wgAuDnNaczV+JRHTg8EBiKeiIYlnJbMZKzCvnuHgc=;
 b=UkKSoZ9iruaa5vYXT15TjxAlzcQMgx6U/f91SdtW9QSZUKbab6LShaIFT6oT8fCKoI
 AWyDNOFX4/GoyPTRwkB1VIxKOHKDuzMdfs/AI6N6VbiI3xku+2qJSr649yt80Q02HoYI
 fBmlGvviYus9LBU/2CMgoVh4nTwvxhBJ0o4ZR+H62s+WM5qZMfTN6yCoe/2N07D4Fl0t
 BKcOV3isCEzreozEtEGA7hj2nGgB0tjUCxGUd+2TxM8qreFfTpN1gLP6FUUqU+MR/ZWr
 OOZpKeRrlIXD0+1t4heyOaXL8g6wg16ArOZWq9/OOw3t417YaVwGS3x/Wvrp9dPcm5JQ
 cUPg==
X-Gm-Message-State: AOJu0YzdnMWLBOpulw7FPqogx99dIoII6CiSeANjOR9aP+6IbO2TMm5J
 E/2IwTO6dZZP2vqUVeo7A9a9E844/FoRv+lGPJVv3Pgf8Y0rlpYDlB2ULAMjKgHAfCSioQjaqo0
 9kI+rad0leKTxDuxVNCBnu6zBvH50xaFowq+HXHqJFrXItsQWIiQe
X-Received: by 2002:a05:620a:1789:b0:785:90c1:88d6 with SMTP id
 ay9-20020a05620a178900b0078590c188d6mr4939076qkb.44.1707291235497; 
 Tue, 06 Feb 2024 23:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEweGtuhl7jW1MFFgwhq4qWW6b1tSaTpYzvEpto4N+LV4ILcs3ZJsGaqwcu2Tm+WvGmLiPmA==
X-Received: by 2002:a05:620a:1789:b0:785:90c1:88d6 with SMTP id
 ay9-20020a05620a178900b0078590c188d6mr4939065qkb.44.1707291235263; 
 Tue, 06 Feb 2024 23:33:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUce+zJ2NFMQtPp/4ZPaCl7aW+Z90RrK6AmPrvcMF7wmFLoBrasSOKCdFLCBLDaN+Jkp4Utodt8P8xKrvB/RsyUS3sWoAqqDNoHn1/9axOQRsSpbscjGjJH9/WfkmQkU0IhF0ODS5kPVT9tzvgJqRWEmPvGVEDB4sPSCyl+/gHrLiTxH9jHyAhv
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de.
 [109.43.177.145]) by smtp.gmail.com with ESMTPSA id
 i20-20020a05620a0a1400b007853e4dc6e9sm288406qka.101.2024.02.06.23.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 23:33:55 -0800 (PST)
Message-ID: <6747ddca-02ca-444a-8b1c-b55c55c6a80d@redhat.com>
Date: Wed, 7 Feb 2024 08:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/qtest/npcm7xx_emc-test: Connect all NICs to a
 backend
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Nabih Estefan <nabihestefan@google.com>, Hao Wu <wuhaotsh@google.com>
References: <20240206171231.396392-1-peter.maydell@linaro.org>
 <20240206171231.396392-3-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240206171231.396392-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 06/02/2024 18.12, Peter Maydell wrote:
> Currently QEMU will warn if there is a NIC on the board that
> is not connected to a backend. By default the '-nic user' will
> get used for all NICs, but if you manually connect a specific
> NIC to a specific backend, then the other NICs on the board
> have no backend and will be warned about:
> 
> qemu-system-arm: warning: nic npcm7xx-emc.1 has no peer
> qemu-system-arm: warning: nic npcm-gmac.0 has no peer
> qemu-system-arm: warning: nic npcm-gmac.1 has no peer
> 
> So suppress those warnings by manually connecting every NIC
> on the board to some backend.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/npcm7xx_emc-test.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
> index f7646fae2c9..63f6cadb5cc 100644
> --- a/tests/qtest/npcm7xx_emc-test.c
> +++ b/tests/qtest/npcm7xx_emc-test.c
> @@ -228,7 +228,10 @@ static int *packet_test_init(int module_num, GString *cmd_line)
>        * KISS and use -nic. The driver accepts 'emc0' and 'emc1' as aliases
>        * in the 'model' field to specify the device to match.
>        */
> -    g_string_append_printf(cmd_line, " -nic socket,fd=%d,model=emc%d ",
> +    g_string_append_printf(cmd_line, " -nic socket,fd=%d,model=emc%d "
> +                           "-nic user,model=npcm7xx-emc "
> +                           "-nic user,model=npcm-gmac "
> +                           "-nic user,model=npcm-gmac",

Alternatively, use -nic hubport,hubid=0 in case we even want to run this 
test without slirp support, too (but currently there is already a check for 
this in the meson.build file, so -nic user should be fine, too). Anyway,

Reviewed-by: Thomas Huth <thuth@redhat.com>




