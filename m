Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBA1D148B3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkNq-0003IY-1O; Thu, 08 Jan 2026 02:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkNm-0003GA-OT
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkNk-0001iU-9v
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767857071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4KLP8vZO0iY7Bp22e40wtc84wAgqb/ruKYyUz9MmTLw=;
 b=KJ7mb9x5R/kgU7FnjGENlzkHaCserJJuD2YKFifc5E3lXCsvPJ28oHuDoMYrTuZ1AhYdbF
 tROb5CmDUHUA21qE1TQ0NGRBF5CHg/0owMqD1Yz50A12DKdS7uxNQORJiXx0zK/EnqmCku
 mc0roRTVSFPTlaKrVo1Mz+8GlQIkzxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-LIXDnGK-P_ea7xP3NLmGsg-1; Thu, 08 Jan 2026 02:24:28 -0500
X-MC-Unique: LIXDnGK-P_ea7xP3NLmGsg-1
X-Mimecast-MFC-AGG-ID: LIXDnGK-P_ea7xP3NLmGsg_1767857067
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so1509153f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 23:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767857067; x=1768461867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4KLP8vZO0iY7Bp22e40wtc84wAgqb/ruKYyUz9MmTLw=;
 b=XP2Hw436Higd8gll3t1C4y5DmpuRWzT7gIkNqSEhhNzWgrpYstVs9DcNvkwH2kLWGk
 z/HwCPtfKOuc4xUZ/3r9e7i+kkQGHoOh22gIghGiVcV3zH1VcM2twcBtu/imBdjlG4Uq
 cMA4Rw4Hb58H64dNnUEJ3k7D421qZBGne4m9Gzy+y2fFBq6pjL9NeGgOtfZCh87mBh4C
 0XobNzGHwh5XpR2ODQcETRicMiWnijes/vH7mdQIkA9YBVOtj+GFwI8fnXsb/IfbU3+n
 qvjvvscNSW4C8g1dIlkbILrS0u0FGhw+7soPIAtu8EDaDOb+c/ydQVHhfGlVcu1H1/55
 /jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767857067; x=1768461867;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KLP8vZO0iY7Bp22e40wtc84wAgqb/ruKYyUz9MmTLw=;
 b=HiLx4T3M2Gw9EkFG2ynMuYuS4ETfF5W2oy4PK+rjLD1q4EgW4N+eb/X463njRXVxq4
 06ibPkp+sqM3N9M0jVKrawVikE+evc98GCfmxPknetXBVlAM7uqwZGeF4pXZaYqh2Svh
 hLwf3oMBB7CaOSgsChM+4371IpG7vP4PMrp4/kWRN61JExVEFVbLTkeUgctUrc4FXgwo
 KeGlge5Ko1HucFqEbXeZjtdMCjPjAoincnu6+wuIZYrAIJzVjx2zHjX54pqXwHbc5h4t
 yfdrva7K9U2X7RrTdsF7C+nzAxUbUwZKEB3WWirCzEpw2zKv7J+hqSAReIHMuu0tmGi6
 ryyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeJ0wOltmhkV51S95QOLRYyP5qlzIacYFEVj6LeFFgvSo6BOAwF5YAO6ZBTwRDz6tfZXNW3g2JrbcB@nongnu.org
X-Gm-Message-State: AOJu0YwekIL05vxkoBDgg14ZiAXnvL6IxAYFZk0P5EqQ7WTi9Lp5fN7x
 kyRKhcx0WEz2NBmLhx7sbuVfW5vNxhsIBhFN/W1AaJ7+nEdAYqV7bjVps9Bnf532Fq+gvr1i5QP
 XX+Eh3KrtaUQh9TFlDee2G1rhXYnLeAC35ykPe65LCcm40d0XPNdNeipY
X-Gm-Gg: AY/fxX7HRzt5YzpmdfqEwVjAqTucNOstFF/Mnu2l0RG3se+Zhmb2gtqOdANiPh/mMKy
 nfTZyTQYiRrZ7OC5JNRtVADDQRNhz6ptpjbx9mrjVTFvNtEBEKm+gC4KXeve3vkyYfoNDRuDxt2
 0yu6K9xByOkQk91gcaweEszo6P1GhaufBvCYKpM/S+u8g14V1IY/3bfnjlLlaQf3WIr0oNeJ+hZ
 X0rqcKy0Syhn9e4ffFD8cgDjgyzP2ZbD074Qs/oL62ALjABk0Ad4I1k4paAylfOgBFQk1GfoFM0
 esOYDEEQXmUIqh0c5xNv2b3yBOhTFSTldhzylAnWzg+RpU8nh5qfm6NlTN11KD9xB2olHVCCZbD
 NlkWwAqY=
X-Received: by 2002:a05:6000:310d:b0:431:4b7:a309 with SMTP id
 ffacd0b85a97d-432c377cea4mr7184572f8f.20.1767857067465; 
 Wed, 07 Jan 2026 23:24:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkCO6NMUu4qIm4S0cYKa30wmD8qtkkZwnzo446wBL21F+bqsKqrppD7GlA9kwg4yF+Zn2uBA==
X-Received: by 2002:a05:6000:310d:b0:431:4b7:a309 with SMTP id
 ffacd0b85a97d-432c377cea4mr7184555f8f.20.1767857067119; 
 Wed, 07 Jan 2026 23:24:27 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5edd51sm14582962f8f.29.2026.01.07.23.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 23:24:26 -0800 (PST)
Message-ID: <4f742d66-5c08-4f5c-9df4-2c8e19da600e@redhat.com>
Date: Thu, 8 Jan 2026 08:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] target/s390x: Use address_space_ldl_be() in
 read_table_entry()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
> Keep address_space_read/write() API to access blob of memory.

Maybe rather: "address_space_read/write() is meant for accessing random 
amount of memory blobs"? ... the "Keep" initially confused me here, since 
you don't keep it in this patch.

> When the access size is known, use the address_space_ld/st()
> API which can directly swap endianness.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/mmu_helper.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


