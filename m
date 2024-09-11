Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D27EE01FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCuq-0007YT-Sw; Tue, 10 Sep 2024 22:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCuo-0007XG-HU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:17:06 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCum-0001fW-UB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:17:06 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so3971849a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726021023; x=1726625823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KvMJ+Q8D2h80lu2qYRZsodicOCFCVJsntWCmeD0sNN8=;
 b=YwDoOrsQ3Y49168VfTjKlRzSw/M8l+s/UQHf85G/oxvHb2/PafbDvmFvItmbTwzwZu
 E7hZJxdcbWuF0nm7XLuB6in1VEtuL42kcCIn6SGg/1vQvD2zhrJ6xtQVqXsxRdD/55Of
 ejCjhJWVbfBohQUg04sFzW59oLZhzR8PyfbqyEYtb6jsFW9eSPvP/w1xI0E6zb4m94If
 0xq/iBgUy0dsPwW8pboh1kfnGROk5ovMrYjE4vv7/ajAya1FrvmLwIer5j58WGHcFxFl
 V7cmSsc7jiaxr1VNRf4jvBEBGtV6H/PoyQJsqb0KaR9B5fhKlozStIOfAF5+hI3FrRz4
 ec7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726021023; x=1726625823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KvMJ+Q8D2h80lu2qYRZsodicOCFCVJsntWCmeD0sNN8=;
 b=a0w9XuKuO0dEIml8jFe7fMJeXDSJ6DVNh56z+tgbtWHhwDQb38TyUlbpt1u/1Ah7d3
 I4dPv/7f85dr/EkXt5eOE055HofPRdNRRVo+jkT50bOgXag32Nn/79b06HRkKz8gRhIz
 5nJflR6u2hToKYn1KiExLBh+FHGjeVaSRXBCDXl1j5fcKeppPD/3UySgiocFM7P3fYTM
 lFUY08oFgvpBr+TEUUO78SoPt2waiuPzHMlE1eow9NaOJrRlnth0OgC0i+H7/TgwkuZ9
 7fL1vQfco9qgfAXl+QtKaH8svNO6MbLZABPks6MntqpEByEBXffDNTuDe3bwJ8+mkpyi
 rpUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJmDC4pNkyb9bLwACJ8zSomS+6al+HEsSZatR5KG5TBGMJfK/CFBbQQPKxkUFStidHgOZOQYiH37jv@nongnu.org
X-Gm-Message-State: AOJu0YxnAlFFBqhv2okA8drTOY8R0BV59wU00Yw/hMjXN29FgbSWwT35
 fppSUNE4cyZS9bSrGeb+9BGx8F1c7DBWj8I5Vbbe2u0xEL/dWRmJ6Zj9NRX4NCYtAZATNVHo2by
 Z
X-Google-Smtp-Source: AGHT+IE1ehz4paUZH43RzDkpW0WuomYZGAYRwjcqK/jeFsj3CIcIUfQlbIGXInj63emsg6FtWiWB6A==
X-Received: by 2002:a17:903:32c5:b0:206:9399:5dd7 with SMTP id
 d9443c01a7336-2074c713a20mr35555095ad.56.1726021022860; 
 Tue, 10 Sep 2024 19:17:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e3271csm54418945ad.78.2024.09.10.19.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 19:17:02 -0700 (PDT)
Message-ID: <5495c5f4-b5f7-48e8-87e4-2fde2c9eec1a@linaro.org>
Date: Tue, 10 Sep 2024 19:17:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/39] migration: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   migration/migration-hmp-cmds.c |  2 +-
>   migration/postcopy-ram.c       | 14 +++++++-------
>   migration/ram.c                |  6 +++---
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7d608d26e19..e6e96aa6288 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -636,7 +636,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>           visit_type_bool(v, param, &p->direct_io, &err);
>           break;
>       default:
> -        assert(0);
> +        g_assert_not_reached();
>       }
>   
>       if (err) {
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 1c374b7ea1e..f431bbc0d4f 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1411,40 +1411,40 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis)
>   
>   int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>   {
> -    assert(0);
> +    g_assert_not_reached();
>       return -1;
>   }


You've got patches removing extra breaks, but these returns are dead too.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

