Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5248BC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEtu4-0004jz-0x; Wed, 05 Jun 2024 12:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEtu2-0004jh-ND
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:54:22 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEtu0-0004zr-UA
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:54:22 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70264bcb631so172370b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717606459; x=1718211259; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeTd4psRyme9sFrQ4affrpkQ5eknWGVuEK3swcpxqFk=;
 b=u0Au39uVUfzqS/tGOw32bd3NdNvUxqfNFMtqd87F6IxDjxPcH1PLck10aetSv1jR5g
 YnwdIaG1OHIbjIvMPVHHbLfMQor7VhautlSVClZoo7hhhL/jFUGspcRdiF8UrCxLLe/C
 vR+YA6W8K+20g7lN8HbuweeA2agHuqtkNAPD8pxH+Uu920Au1K8VMdgXbOwbYTo35VJ9
 DmzA+OZ5SRHOQ3Nh/OLEKVs1zVyp+QO8AWIUsnkV2n3ER6kBGmchJj9itZkKxaJr1LQP
 SMMSZpUQFXpgDnWxoK/bs9ivQBr051Vj1X02rGRBKX3LHWRpEqM0nj/WzM4in6lWJwsy
 gAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717606459; x=1718211259;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yeTd4psRyme9sFrQ4affrpkQ5eknWGVuEK3swcpxqFk=;
 b=D2w6lM9yXu2JWSDFCcbRL9k0U7eJTp7h4wbfoa7KDj4b5LODpwwL2c9k0dpSBUgIHn
 A0+W8rncjVh6d9XwrVTw/YZEZQcYeWxZ629Tf4x7UAJndXwNBo2ZJv4LanccwPdpTvSH
 xu+Zg4M3yuSu34z7LOfRFpFQ+HPS/Sf0bQtC2V5hGQg2mj6ocf+e9HXcnR0k4+dYE5/g
 z6DZt5CXwWgaEIIasKdvGmxuzSGnEe1eX0JX6GNc9/hEt5iD6aEtlWrQBIUPKWzjPphV
 bra/AefzvpUOvlNaCirNKupI+hoM91xlggjYMcvosTlzjY1DelUOGehAnrEJ8eaxBLs2
 8PRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOxu+8rlD0xxGX3mlQJ0pO05RlGIQsgSmr/Fm0emzcQ7Sh0TDdKwzrc48O6XsfDxffpjXEmsm0LBYU0nTyWEa4hZTzjKY=
X-Gm-Message-State: AOJu0Yzatr2SwAK6wpzyQ6wznoq7/XzsLRvh13Q1tB615y+fgQ66hNXK
 cKdCOejLQt3S0wlE6q6m0n40bZBdpdEzVyWME+FdijkSyNbvrsab1StSPjaByythXWknFjXGKb+
 LA6ejeJSxIVGsYh9mHfQ5zFhOeiYst14JQbmEA99N1erX
X-Google-Smtp-Source: AGHT+IFYXktoKlmtRv7+XVY5YlE5rOCipZyBROwQnOZyygDRPLqUOxPUN9k+RkHzjtZfWOr9saMuyA==
X-Received: by 2002:a17:90b:19cd:b0:2bd:d4be:82d5 with SMTP id
 98e67ed59e1d1-2c27db561fbmr2973717a91.37.1717606458917; 
 Wed, 05 Jun 2024 09:54:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806bd536sm1744119a91.45.2024.06.05.09.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 09:54:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------e2wd67kP4o9F5jnykq52IEBe"
Message-ID: <4d097eaf-d555-41a7-8c3f-c2abe8a51ab6@linaro.org>
Date: Wed, 5 Jun 2024 09:54:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 36/46] bios-tables-test: Add data for complex numa test
 (GI, GP etc)
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
 <61cbf56ef1c5dd9dbe6bd6625f6c8d2a82c5697f.1717527933.git.mst@redhat.com>
 <2eefcbdb-ad41-465a-9c14-1dc15bfff94a@linaro.org>
 <20240605162733.00007d8d@Huawei.com>
 <3a1c870c-f708-482d-802a-d3230b398c28@linaro.org>
 <20240605170845.000000dc@huawei.com> <20240605171136.00003879@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240605171136.00003879@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is a multi-part message in MIME format.
--------------e2wd67kP4o9F5jnykq52IEBe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 11:11, Jonathan Cameron wrote:
>>> Sure.  By what incantation do I produce a dump?
>>
>> If you still have the /mnt/aml-GHR602 above then either upload that somewhere or
>> iasl -d /mnt/aml-GHR602
>> should generate you a suitable text file.  However generic ports are fairly recent
>> so you may need a newer iasl from acpica-tools to decode.
>> It will moan if it doesn't understand the content.
>>
> make check-qtest-x86_64 is how I get the test to run in the first place.

Ah, I see, the file is not cleaned up on abort.
For the record, I attach the dump.

> Alternatively, this 'might' be sufficient if my guess for the problem
> is correct. Thanks!
> 
>  From 956df037f024783f19b6b00e5e280484380227a0 Mon Sep 17 00:00:00 2001
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Date: Wed, 5 Jun 2024 17:01:36 +0100
> Subject: [PATCH] hw/acpi: Fix big endian host creation of Generic Port
>   Affinity Structures
> 
> Treating the HID as an integer caused it to get bit reversed
> on big endian hosts running little endian guests.  Treat it
> as a character array instead.
> 
> Fixes hw/acpi: Generic Port Affinity Structure Support
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Maybe this is the only problem?  I don't have a setup to test
> so any help would be appreciated.
> ---
>   include/hw/acpi/acpi_generic_initiator.h | 2 +-
>   hw/acpi/acpi_generic_initiator.c         | 6 +++++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> index 1a899af30f..5baefda33a 100644
> --- a/include/hw/acpi/acpi_generic_initiator.h
> +++ b/include/hw/acpi/acpi_generic_initiator.h
> @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
>               uint16_t bdf;
>           };
>           struct {
> -            uint64_t hid;
> +            char hid[8];
>               uint32_t uid;
>           };
>       };
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 78b80dcf08..c2fb5ab2ef 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -150,8 +150,12 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
>           build_append_int_noprefix(table_data, handle->bdf, 2);
>           build_append_int_noprefix(table_data, 0, 12);
>       } else {
> +        int i;
> +
>           /* Device Handle - ACPI */
> -        build_append_int_noprefix(table_data, handle->hid, 8);
> +        for (i = 0; i < sizeof(handle->hid); i++) {
> +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> +        }
>           build_append_int_noprefix(table_data, handle->uid, 4);
>           build_append_int_noprefix(table_data, 0, 4);
>       }

Yes, this fixes the abort.
Merge the declaration of i into the for loop?


r~
--------------e2wd67kP4o9F5jnykq52IEBe
Content-Type: application/gzip; name="aml-6SC2O2.gz"
Content-Disposition: attachment; filename="aml-6SC2O2.gz"
Content-Transfer-Encoding: base64

H4sICGKWYGYCA2FtbC02U0MyTzIACw5yDOFgYmBgTHPyd/YIVnCKCHBWAAJGBgYGEBtEgzAc
CKDzmRlR+axMyHxGDQY0wIWQw6pOAEp/YMaujgXGZEGjGfDbix0MdnWsCgzQ8BVA1Q+l2RQY
GIDRx2BmaGDgGeDs6IAmz6jBiq5nAozPjOQEAD/9VBgIAgAA

--------------e2wd67kP4o9F5jnykq52IEBe--

