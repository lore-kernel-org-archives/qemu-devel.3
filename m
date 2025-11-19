Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A11CF258C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdc7-0001UY-RC; Wed, 19 Nov 2025 03:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLdbw-0001SE-G6
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLdbt-0001PT-B6
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763541136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gPVuk/sT4zE6r1azzUQorcbjnOiVwRZ/n3G9NSDFQY=;
 b=W0V3Th2CIw/PNwZ4gCLgfcyFWdpqyCwfkccrbeFprU3llKBTEWD9QZqKqV24IBmViukjkq
 y+AsWTFP8h3zWPYswNskcDljmEtJuUc01JkTvtjklHr9ow8QN94iNxkxjmu+KiFjlBmgrJ
 g3Iv8uwYqJz/K1J4m7ItN5PyHY6/OTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-E9bQfPWOPZe8CVVpx1bhfQ-1; Wed, 19 Nov 2025 03:32:14 -0500
X-MC-Unique: E9bQfPWOPZe8CVVpx1bhfQ-1
X-Mimecast-MFC-AGG-ID: E9bQfPWOPZe8CVVpx1bhfQ_1763541133
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779393221aso12508945e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 00:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763541133; x=1764145933;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gPVuk/sT4zE6r1azzUQorcbjnOiVwRZ/n3G9NSDFQY=;
 b=RVWNJWiYb6XjZQv/wnmlOlKrrOxnGXPgv0PeLvUyhnPgHUhuruLCmVwN5+ftgsJQPE
 5KS7uI+jqPyE435ocQRaXRS/5mdAXSMVoLwk1tjMeZwzC9y0SD9Vmv3symF51hJKahl3
 JNxlkVEc5cv9oNrj1++sHt2ae+pbd1yHStcGkrx01AxmlPpD2W8rh0jJSNhjEoSCl58n
 WzX1duko+lWMVZ/BlL2uJPf3uP3OCCcpUW2VBXfWs3/Fr6JgxCUl3bnVikXp0YIEF972
 KRkuk5FWicaCkRNqa329VLrgTwV8Do0ZYppSU3cPVFcI6J2x5n6ce/qPqEMXakHZ3eGz
 vVLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzPdQZRmfnHh7sQxcQ5Hk+q1bGh37mZfZX7c68E7cymX3kLDQkknE6yR1QpAfK91OymkXJIGksjwUL@nongnu.org
X-Gm-Message-State: AOJu0YxSgqP54DeJhvqbcHxDW8Zj6B10uRquhCJrJMeIEA1TjLkfyHvo
 l28iv7TKj1ZlTn2m+ruembq7oCJneXv2hXUwO57hwP/jfK8Lm2yVVqAroCqTH8OWbYq4kBuo9SQ
 jpGAy08GmXArdQTi58/i6Sk6jpmkv+4faJlFrfUDC+tYPdW9Meag0hklK
X-Gm-Gg: ASbGncupInLv+47k5gvtOwA5SFZ9o0+XKMzUdYAMhYFE/tiubQ56UVUC2/MZjDmE+kc
 CSVbanxoy+uqddtIBJ3becYELH+hS55jN51vITqBR0OxdjptuCKZ5XHqhoVCt28X0H/koOgPBRd
 WCJ4Ewy6DF/3BK6vQj5O5b+LZsGzgBXahNBuFLqkNBMk7r6tBSrRPAP7lfd+68TMMiT1EhUEcMv
 DvjC/GcObsCAYkAXsHIeDWddswAutaQuZsRynWoozJrOeTwzTWsRy9/nm2dwNl/386IGzKPHA53
 roFndDn4MQ/j3HDHFFG4Zh/qhQqrhKSZY0feJQbwdI7aAwUqfyHiERYDaXnY/u6/+ZSR0BcK7OX
 eCWhnqgtquXs3s796LEsRKFWma91+irg3KFxeMyzLAOCeyS8jFxDE+E/0kQ==
X-Received: by 2002:a05:600c:1c29:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-477b197ab30mr12981355e9.1.1763541133440; 
 Wed, 19 Nov 2025 00:32:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8KG/wESUYwc0SFV30ukmYmcBLk5m7c8dt391qHu8WxTy8KOn35j0jyWk0Y5cJscGmKitmwQ==
X-Received: by 2002:a05:600c:1c29:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-477b197ab30mr12981135e9.1.1763541133064; 
 Wed, 19 Nov 2025 00:32:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c961f6e64sm23194804f8f.27.2025.11.19.00.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 00:32:12 -0800 (PST)
Message-ID: <f724ffae-1fc6-417b-afb9-406b6d705ee9@redhat.com>
Date: Wed, 19 Nov 2025 09:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] target/arm/helper: Skip hidden registers
Content-Language: en-US
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251118160920.554809-1-eric.auger@redhat.com>
 <20251118160920.554809-5-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251118160920.554809-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/18/25 5:07 PM, Eric Auger wrote:
> In case a cpreg is hidden, skip it when initialing the cpreg
> list.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 27ebc6f29b..7e34b4803d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -236,8 +236,11 @@ static void add_cpreg_to_list(gpointer key, gpointer value, gpointer opaque)
>      uint32_t regidx = (uintptr_t)key;
>      const ARMCPRegInfo *ri = value;
>  
> +    if (arm_cpu_hidden_reg(cpu, regidx)) {
> +        return;
> +    }
>      if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
> -        cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
> +        cpu->cpreg_indexes[cpu->cpreg_array_len] = kvm_regidx;
I screwed up with this last minute change. This diff shall be removed.
I pushed the fix for now on

https://github.com/eauger/qemu/tree/mitig-v2

Sorry for the inconvenience

Eric



>          /* The value array need not be initialized at this point */
>          cpu->cpreg_array_len++;
>      }
> @@ -247,6 +250,11 @@ static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
>  {
>      ARMCPU *cpu = opaque;
>      const ARMCPRegInfo *ri = value;
> +    uint32_t regidx = (uintptr_t)key;
> +
> +    if (arm_cpu_hidden_reg(cpu, regidx)) {
> +        return;
> +    }
>  
>      if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
>          cpu->cpreg_array_len++;


