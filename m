Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801EEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS13g-0006MJ-3K; Thu, 11 Jul 2024 17:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sS13e-0006Jq-P9
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sS13c-0005bZ-7S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720732223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BBjenzPFcBpGzGugkcuzzvbWd0Rr6jff4//ogrPloxg=;
 b=alcCwJ4EYRh03x3uw2J/YtKFPC8sfLU4bIbr2l/Y3ZegIK2sF0oWYT0rL5dcScFiPiD2vZ
 R0Ham1l62Zg4DcRbisqQXcpGT/8okk/dRM725GhxbbAe9Z8sM8OUuu09zpuXfzIhJcbPA7
 QpiB1C62PvcouF3UBmn+czi864I58mc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-x9_tjGErPpyutKfSGTZbbg-1; Thu, 11 Jul 2024 17:10:22 -0400
X-MC-Unique: x9_tjGErPpyutKfSGTZbbg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-70b12d4d4f4so1077743b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720732221; x=1721337021;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BBjenzPFcBpGzGugkcuzzvbWd0Rr6jff4//ogrPloxg=;
 b=B87miFmKPb6FM1KQ6Cu5Pjl3qkRpZFkqAIRMDmBeu9LmMPI3ApBpM0a3PTJLn4i5s5
 7q539Ew0GVK+kqwGP3tlCqiBDR6wL5xO+kBHJ6gt3zoVDYd7TQTXD5cFcfGJhb6YDVKJ
 kPXOR9JYuuSaJNEc0TLjPIXS+zge25EMjJwHpQ7Wf2EJPe5Lk72R/nTC9mv0z+leUOEo
 X1MUducj6ES0raHdLSGhtoyD1KTNmg9rl8e9/15F/PY8xUrej1lKJOZMIgPOAxXmrrjq
 aC9elu+TGeAq2fFRxgvmq1lVPJOm3xVjOVTWeUM1MsZmoE9aADs2MvTqk+ZqfpwtL4x2
 0IKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzN8FzlpzuWj7KU2juyHEJGGj7QKXbSCi+5vccm0AeNPNmOx2Z60qCILM0leFIzyVnjEqTBa7HrT17FTZmAhal9rS0nWc=
X-Gm-Message-State: AOJu0Yw1bAEYo8WFXQcwxOK1/k7HdkRQ8NUfTBLS/Xv3qw6w5rIjzn2L
 bItkEBZAHRRtAkVdN9Bo4KhzsBOZoGeXiH3knypGi0lJfwI8W0PC+r9FLEfadr0Jv8TnTm+zpxM
 kRg59q7Oay7j0Y5m7sqe8tiiMv63ErUCzmuJuEP6VEAnyU3Ev3P/S
X-Received: by 2002:a05:6a00:3ccf:b0:70a:f22d:caeb with SMTP id
 d2e1a72fcca58-70b434f1eecmr12440820b3a.4.1720732221243; 
 Thu, 11 Jul 2024 14:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0RkwPrHT/X5wVzMoFZDwFNgchf60btsb48x3Xz8EyHZjx8mqJ62RvyQDD/B2/wlN9U42okQ==
X-Received: by 2002:a05:6a00:3ccf:b0:70a:f22d:caeb with SMTP id
 d2e1a72fcca58-70b434f1eecmr12440573b3a.4.1720732215897; 
 Thu, 11 Jul 2024 14:10:15 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c5ed4sm6156921b3a.65.2024.07.11.14.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 14:10:15 -0700 (PDT)
Message-ID: <3d93bd6b-7ca2-44e0-839b-a504a76b79a0@redhat.com>
Date: Thu, 11 Jul 2024 23:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: filter deprecated features based on
 model expansion type
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240711203254.49018-1-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240711203254.49018-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11.07.24 22:32, Collin Walling wrote:
> It is beneficial to provide an interface to retrieve *all* deprecated
> features in one go. Management applications will need this information
> to determine which features need to be disabled regardless of the
> host-model's capabilities.
> 
> To remedy this, deprecated features are only filtered during a static
> expansion. All deperecated features are reported on a full expansion.
> 
> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   target/s390x/cpu_models_sysemu.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 977fbc6522..76d15f2e4d 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -211,7 +211,15 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>       bitmap_zero(bitmap, S390_FEAT_MAX);
>       s390_get_deprecated_features(bitmap);
>   
> -    bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
> +    /*
> +     * For static model expansion, filter out deprecated features that are
> +     * not a subset of the model's feature set. Otherwise, report the entire
> +     * deprecated features list.
> +     */
> +    if (delta_changes) {
> +        bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
> +    }
> +

This would likely be the only interface where we expose "more" features 
than a CPU model actually understands? I guess it wouldn't be that bad 
because disabling unsupported features will just work, even if the CPU 
model is not aware of them.

So no strong opinion.

Just noting that libvirt cannot really rely on that information because 
the behavior would change between QEMU versions? Maybe not an issue.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


