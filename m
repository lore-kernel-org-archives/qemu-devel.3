Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA43C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2Sq-0003rf-1q; Thu, 06 Feb 2025 09:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tg2Sm-0003pD-4x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:02:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tg2Sk-0006s6-Ni
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738850556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uTfV84G3ykd/UdF8Tex0lOaRk2R9Xgmon2HAY9eca48=;
 b=cF9LFmM4QjlLBBSMRx3i3yLId84wI/cvaETK+WO6xWqF+qOJiaJQ/OXUADBnoai5WIluUX
 LW6Dv/+dDxcFLcj/P+HQY8Dls0e+5KcSDUGkbp/Qj6B73V7qhm7OLps2VQa6I02fcP4LIj
 HOUgkQsiXI0ZumM1F3EsU2oHBTUmSaw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Z5m36DCpNvyNonel7P1yYw-1; Thu, 06 Feb 2025 09:02:35 -0500
X-MC-Unique: Z5m36DCpNvyNonel7P1yYw-1
X-Mimecast-MFC-AGG-ID: Z5m36DCpNvyNonel7P1yYw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dbe6a1ba6so274311f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 06:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738850554; x=1739455354;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTfV84G3ykd/UdF8Tex0lOaRk2R9Xgmon2HAY9eca48=;
 b=WO4NTNXl6rLezBQAGDjkzqoRenTb6b3Zj4nT5Td5DFCOUb9GQS6w3X/6/jBTlGA0nf
 wL34XwVj31l18IE3FAQgMbrcTYYFOS8Ag1ydU6K1xo5fAALWx1YS/oXjdtGmYkG+PsoQ
 z49BHqsMHeS0nlduXns9VA5hzFFGNts2NcWYXS87LXwF/41J3LcevllCiYjsvO+e6YQf
 4nWcJQmIXqaWENFiY88QNsscxQcb0PGH6Itce1oXbMgkTj7ZgO0qaOoxjvG6nYNKo8zt
 PAi6RqgGXfoBiwJ6yeU1i8AwqvUWayy5gJqc7x7+oDGZfrmIblRFx5AwTwXpq89uS0Wk
 bmYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2qOm1ZfWqi+y0/EnVlBn1u4D6rMprR/INwVRK5OBORTJ8yvxz9EgD/DEjFdEeHOk/tu2W4RSCDcST@nongnu.org
X-Gm-Message-State: AOJu0YwlJzbUqQwe0PGLGJYTdt84Z9GlNMIT3atxa6h9B13nPHVynErK
 dYsE3UNUWBlLBEGRZI6m4gUYApiAV2NzeP56Yn3ysQ2XEuLf2LyLgKz5CXI9LgfZyiGuDvuq0+E
 wT4t5Xg6BZXScuYe7org4EWGgYfRfkxs1/lFIBp6ou8U733PMD4s6
X-Gm-Gg: ASbGncuoqqE0qdhyRcc4DMncfQ25O6dk2T/KYaR//mUPtCH3Hq6Q+vACM+S+eN3MV3K
 InatqmUyAecco2YaGBd2t1jQ0kunRoV+fIDAHAPGCTjjuBpL6XzF8aq1XSd7Zea6T81buQABQRi
 Yr3cg3Mkf5AqKIVxiRTCwpb4zNyN40yL4Dp4bDbHVYAr/RblDr2NkxKlKn1cMSa1BkGD6Shk9HU
 OlulhtM7EoKutm0s+1LmNOsmaEQ+Ql87uNzUi17mZe+Z7ZEACBAv5JcWgsewLrbp6CehVvN1wam
 d63gh9Kkf1FfZrGHFBvNrkw9i7CPg51feibu
X-Received: by 2002:a5d:64ab:0:b0:386:4a16:dad7 with SMTP id
 ffacd0b85a97d-38db48867c7mr5161107f8f.10.1738850553681; 
 Thu, 06 Feb 2025 06:02:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwsZNdXY69WhhbzipfYXO+00FJsR6yMiIx/gTy2K9xPJgW6yPn+QUrwUlMA1xOSbB+TMtkgw==
X-Received: by 2002:a5d:64ab:0:b0:386:4a16:dad7 with SMTP id
 ffacd0b85a97d-38db48867c7mr5160991f8f.10.1738850552648; 
 Thu, 06 Feb 2025 06:02:32 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1ddaesm1788201f8f.85.2025.02.06.06.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 06:02:32 -0800 (PST)
Message-ID: <a327bfb0-99ba-4f31-83f3-cc42faae90b7@redhat.com>
Date: Thu, 6 Feb 2025 15:02:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/16] tests/functional: Run cross-endian microblaze
 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250206113321.94906-1-philmd@linaro.org>
 <20250206113321.94906-17-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250206113321.94906-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 06/02/2025 12.33, Philippe Mathieu-Daudé wrote:
> Ensure microblaze machines can run cross-endianness by
> running all tests on all machines.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_microblaze_s3adsp1800.py   | 6 ++++++
>   tests/functional/test_microblazeel_s3adsp1800.py | 6 ++++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


