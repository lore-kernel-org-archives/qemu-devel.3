Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E940FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 07:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjaIs-0006ed-7v; Mon, 11 Mar 2024 03:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rjaIr-0006e9-6L
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rjaId-0006JB-Cz
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710142938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NdKaBwIYTS5kAgFX4EAlzXqT8OITpef6c+klwQHgjk8=;
 b=PZvq3kev1fkubX4GY1tBNBfrwGrUOKTrqy6AlKuPUvYN/uziLW7t2uyo5bvGZ6FXDd2fzn
 kfqf5u/ZyK4gzhl6tmnMLnpFLlypaFvMUyQiiz2kA+GQvYSkS1dutBUAz8I4+GC8Vz+7oN
 QAb0bZQhdDI1W/5Di9GHO52kidOEqTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-ZBpkOo2sN8KzB-llBNOFzA-1; Mon, 11 Mar 2024 03:42:16 -0400
X-MC-Unique: ZBpkOo2sN8KzB-llBNOFzA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4132cf5b950so1162745e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 00:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710142935; x=1710747735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NdKaBwIYTS5kAgFX4EAlzXqT8OITpef6c+klwQHgjk8=;
 b=Tie8icDBENQj3TqEnKzDWBrTJzm1AaeUE9VYIoDkaXb5UhjSem4wpbH370WF4ZLXGE
 blgE7PRb2XMadxDLmksHMtTmRIWgKqzbw9CakLQ/sQ294L/5JaNN+kW0uhh5EUSrd86n
 CJyFpziZTmxDKaq19RNO7BBTqqwYSaAg8Awnn4GkUMr5VNbqEinoALnQK+xXzj0XpAfJ
 loFkr2Ro7lNRaLbPHO8oecy2LbKub/ghI7JGXpNsO444ou6mUYOojTD9AxQO3L+1fb/0
 jfiQ58rzw0nnGGc3FANMp00fE5ohxmvZCQ9RMPt+JjiJGsWouhhcBkahJvEEANFW9KhP
 tWMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTc5biTHzJjK+9H0PzdWFZ/SSnh9fPk5Rxm36k3PQM2cG3YS/OccpJE/ld/M19ZO+tZkUVSb075bYPowis/rk9IXZbBek=
X-Gm-Message-State: AOJu0YxCpr18iUGe+wr3hKluFlBKUcbgHE7Bo/0n3JhnkANYun91CjHN
 uK6sJ7+kkGv1qAFkVlVDsmuVmhDVBj858J46CXWhjIBSXrOw0GlyQJh8xu6bs+zyrzeOO9GHtDV
 HlTaAJPJv218882VO97JQQzAbWh3BsXpVvR5C1Au8levGhfpSsFST
X-Received: by 2002:a05:600c:4f50:b0:412:ee33:db93 with SMTP id
 m16-20020a05600c4f5000b00412ee33db93mr5147968wmq.3.1710142935823; 
 Mon, 11 Mar 2024 00:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaC+vmNUs5IeDU5nUBD1wW16ZGHUDGeZPHVSeY+NX35mFIgdWI8bksTsuSE/th1aPIErPZAw==
X-Received: by 2002:a05:600c:4f50:b0:412:ee33:db93 with SMTP id
 m16-20020a05600c4f5000b00412ee33db93mr5147942wmq.3.1710142935527; 
 Mon, 11 Mar 2024 00:42:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 m38-20020a05600c3b2600b00412b6fbb9b5sm14797294wms.8.2024.03.11.00.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 00:42:15 -0700 (PDT)
Message-ID: <8c190ff9-137e-4f1e-ba74-b4beaaa90e7f@redhat.com>
Date: Mon, 11 Mar 2024 08:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/29] target/s390x/cpu_models: Fix missing
 ERRP_GUARD() for error_prepend()
Content-Language: en-US, fr
To: Zhao Liu <zhao1.liu@linux.intel.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
 <20240311033822.3142585-30-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240311033822.3142585-30-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/11/24 04:38, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As the comment in qapi/error, passing @errp to error_prepend() requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> ...
> * - It should not be passed to error_prepend(), error_vprepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> 
> ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added [1].
> 
> In target/s390x/cpu_models.c, there are 2 functions passing @errp to
> error_prepend() without ERRP_GUARD():
> - check_compatibility()
> - s390_realize_cpu_model()
> 
> Though both their @errp parameters point to their callers' local @err
> virables and don't cause the issue as [1] said, to follow the
> requirement of @errp, also add missing ERRP_GUARD() at their beginning.
> 
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>       ("error: New macro ERRP_GUARD()").
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



