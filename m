Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5978BC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 06:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4J9-0006Cw-28; Mon, 17 Mar 2025 02:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu4Ie-0005oH-Im
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu4IY-0000oD-Bn
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742194205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kdnn8FkUZO4a6qwLoBeEecTRo9TL7EwfSuxKTPZVTLg=;
 b=YZW6Bi5CX5jojlPO1ZAJIuVfOGql0pPoQZZzaue8LQk1rtczpQyjCmHPYxW8Pabyg2e/bV
 y9y6QeLjHbZcYirj3TRNtGubL1BlTqSUE5gAGa4yO+u1HIeIgInw9Z5qzKlLcclnUTuAWw
 9PfE9iu3bGh8X7KoBbeT1ps2H3i/1Zw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-wYeni29aPkWSQADXmOKZXw-1; Mon, 17 Mar 2025 02:50:03 -0400
X-MC-Unique: wYeni29aPkWSQADXmOKZXw-1
X-Mimecast-MFC-AGG-ID: wYeni29aPkWSQADXmOKZXw_1742194202
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39149cbc77dso2635339f8f.3
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 23:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742194202; x=1742799002;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdnn8FkUZO4a6qwLoBeEecTRo9TL7EwfSuxKTPZVTLg=;
 b=MkFtJXZ5NqJkI0jGKCq6qHvZhf3F0DUxFUo10P4OheLnJ8I4umUjqJGmpSl9Alff9n
 ZyYolaee2K7MtnHEhC8h/6+Di0cSnfL2uDxGq/uXcup4GOAPc9uIo0ixxo+bN/m6ikVj
 21zEIbeNJYfcTxrOUcSPndDcR450Sy4GEo7aoOJjoPQs756VQnLev7z2pAL2R0ijBrbn
 i0ezSip363uWJuaM4ltuHo3Rv8c0ZTzOnZJDnamgpthv8eI9ssY2Rzn5HPacucpCpeYG
 98zI/IufSqu4jYmyhqzInOxRNX0R3vPb9VRcCXzOI+evz29A7t2/2yHkD7ONw9rZeTCz
 79zA==
X-Gm-Message-State: AOJu0YxGER9t4SQsiVnDrvrP/qzpQN672CTZ6AU3gCto9moDyocpj5pe
 0sO8hvuFcrxtEHpuyhZ08ljC8Kj7mVGJyAWZj27RYP+kNHx6hE9reDVOB/wQZ3yQehhmNp2zKtJ
 8IO8XjLWtNQW6d68KhN1sxn3OTAernh1oWW+oe6ozCZPCb7ckrpmi
X-Gm-Gg: ASbGnctWNScTVtD725LKTo7AKr6hnZwPTJmjWti7eiEINESgG/Tr93WlycXfxHVvkQC
 94I+ZgaTm7Hq9aXD+L4h0iHwvXZZHlvQ+Q0KexBROSdG8wCOXacloNqBxzxzB+AlQqHvuvGkYhz
 wQVgLezCCDqk/oLZQaPzbNuHvwzUWwlU79ZLFQB+eZGvCQiKAVf/pISV/h6PoG8EbYmRvEYTq5O
 TyaKXuAp1ohs4GWpMnc//0aBTFbi7f/f/RQI3h/bp27skBNj7VR/g9GZMzyCmoN4NXHNXMh7W19
 UZPJX0087NspR97F7CA/x2TmhWiqckLMRbyk3zx+yR1y9BM=
X-Received: by 2002:a5d:648a:0:b0:391:2dea:c98d with SMTP id
 ffacd0b85a97d-3971dce07e1mr12207199f8f.8.1742194202088; 
 Sun, 16 Mar 2025 23:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGay3MILdiDWacIX30/mMaWcytsaXmvGw50xQaf6kUOAjnTq1kSxo/oDLDRbIUmhKOIHJGCTw==
X-Received: by 2002:a5d:648a:0:b0:391:2dea:c98d with SMTP id
 ffacd0b85a97d-3971dce07e1mr12207183f8f.8.1742194201756; 
 Sun, 16 Mar 2025 23:50:01 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a3dsm14084626f8f.74.2025.03.16.23.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 23:50:01 -0700 (PDT)
Message-ID: <982cba8b-72e6-49d9-80bb-05053c00819c@redhat.com>
Date: Mon, 17 Mar 2025 07:49:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system: Fix the information on how to run certain
 functional tests
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-arm@nongnu.org
References: <20250311160847.388670-1-thuth@redhat.com>
 <CAPan3WqXwAWeAqbQypF7PCXh_pjDUgbbiWwXkPSbXrFetfMZAQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAPan3WqXwAWeAqbQypF7PCXh_pjDUgbbiWwXkPSbXrFetfMZAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  Hi!

On 16/03/2025 21.21, Niek Linnenbank wrote:
> Hi Thomas,
> 
> On Tue, Mar 11, 2025 at 5:08 PM Thomas Huth <thuth@redhat.com 
> <mailto:thuth@redhat.com>> wrote:
> 
>     The tests have been converted to the functional framework, so
>     we should not talk about Avocado here anymore.
...
>     diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
>     index db87e81fec4..8b9448ca7b0 100644
>     --- a/docs/system/arm/orangepi.rst
>     +++ b/docs/system/arm/orangepi.rst
>     @@ -257,9 +257,9 @@ Orange Pi PC integration tests
> 
> Perhaps for consistency, we can also rename to 'functional tests' here.

Agreed, we don't use the term "integration tests" for this anymore.

> 
>       The Orange Pi PC machine has several integration tests included.
> 
> And same on this line.
> 
>       To run the whole set of tests, build QEMU from source and simply
>     -provide the following command:
>     +provide the following command from the build directory:
> 
>       .. code-block:: bash
> 
>     -  $ AVOCADO_ALLOW_LARGE_STORAGE=yes avocado --show=app,console run \
>     -     -t machine:orangepi-pc tests/avocado/boot_linux_console.py
>     +  $ QEMU_TEST_ALLOW_LARGE_STORAGE=1 \
>     +    meson test --suite thorough func-arm-arm_orangepi
> 
> I've tried to run on my Ubuntu 24.04.1 LTS based system using this exact 
> same command, but got this error:
> 
> $ QEMU_TEST_ALLOW_LARGE_STORAGE=1 meson test --suite thorough func-arm- 
> arm_orangepi
> 
> ERROR: Build data file '/home/user/qemu/build/meson-private/build.dat' 
> references functions or classes that don't exist. This probably means that 
> it was generated with an old version of meson. Consider reconfiguring the 
> directory with "meson setup --reconfigure".
> 
> The meson version I have installed via apt-get is 1.3.2-1ubuntu1. Only when 
> running using the 'meson' command from the pyvenv, it runs OK:
> 
> $ QEMU_TEST_ALLOW_LARGE_STORAGE=1 ./pyvenv/bin/meson test --suite thorough 
> func-arm-arm_orangepi

Oh, you're right! Thanks for catching it!

I guess I still had a "export PYTHONPATH=$HOME/qemu/python" in my 
environment, so I did not notice. Would you like to send a patch, or want me 
to do it?

  Thomas


