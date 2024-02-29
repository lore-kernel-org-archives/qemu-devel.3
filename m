Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D1DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfl2X-0003fc-0s; Thu, 29 Feb 2024 13:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl2V-0003f3-Gp
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:21:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl2T-0003fS-St
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709230908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RbMWHEYWHtVmlvSOvu966micuAkdr7/UpmcVXaQJzMo=;
 b=hx6o50DaBQ6Lzm5oOChDHHrfstF0CJCDsWvI1eCHJQUcmXu7Rf4PUn3FlnQ15MCJusvcp5
 lgUGN2eqj0vw8JS7lMuz/0SULCE+8oShBsgleGYGL+9QSKA79ck0fW0/VSmaJeIXpTYW59
 wOveMb791ERudfs8E8AjA9V3EX9pgPE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650--zUlQwa9NPmCqOWNCbGGpA-1; Thu, 29 Feb 2024 13:21:47 -0500
X-MC-Unique: -zUlQwa9NPmCqOWNCbGGpA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68f7572bc3dso18193306d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709230907; x=1709835707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RbMWHEYWHtVmlvSOvu966micuAkdr7/UpmcVXaQJzMo=;
 b=ZstC29jELjwB/A7gIoe+yZXkX227QR2qVWwqWXnw2kUvFrrcHtt+VMFliQid80Pf5z
 tfzvij0wIqwPiU3dPz38WdDYVJpLELV/pLNuf6YB/ZBG5jpmfnY4Xcx8st6gAk9L1xdp
 VNUx6v9kPW+F0ZGsBPq7Ul5b965bbNWWHcVkfUKw0PlhelnU20Or5MVoBT98Q0jHmcKy
 p88qL0GPW52NtFud9OMaUI/0vBowFs7+a5frCjyB/vH0qIzYW5dFeaJx/XJ7rUqYw0TK
 mnH2Wnssxf00a7yAuolCxDJGoYHhx0+H9RqRwfvm09CAnoNbz4lZDBmBRL/zdNZzbW1c
 bcQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCBA2bD0MG1pNWKSOsVurnOkzNIozFMTIvwWrxJTuvfox+kOWEbONTcbvGD5GSdtmMHOBz6vH96ZtEzJeM4P0TzlGzfMk=
X-Gm-Message-State: AOJu0YxVsShBtQIBg2ONYsWkzJayK4k5dHf83R59TuK0tg3ea6B8MCAy
 4RKt8HGdhRsjsoK8vkxepDXbO1c8BZiWAKwBVhL5XrHV/xoqlIAZ99LmGcj/8Pz58DHwTsltu/+
 1vmlwOGpQmHqushtZPTqB5y1czZFctzRxtgjjYeXwGzd5NW9B+Lxa
X-Received: by 2002:a0c:ca86:0:b0:690:2f5c:f0ce with SMTP id
 a6-20020a0cca86000000b006902f5cf0cemr3196696qvk.24.1709230907008; 
 Thu, 29 Feb 2024 10:21:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElb3G+f3YJZitPdHbC7Mf21S763T133zK3rE7+5zBIEC9pU5FNT6kLUx/lsAJEvKMPQeCnFw==
X-Received: by 2002:a0c:ca86:0:b0:690:2f5c:f0ce with SMTP id
 a6-20020a0cca86000000b006902f5cf0cemr3196672qvk.24.1709230906726; 
 Thu, 29 Feb 2024 10:21:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 qp11-20020a056214598b00b0068fef74fdb3sm994819qvb.59.2024.02.29.10.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 10:21:46 -0800 (PST)
Message-ID: <f085db0b-a174-4c51-bc4a-db8dbd2f28f9@redhat.com>
Date: Thu, 29 Feb 2024 19:21:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] hw/vfio/container: Fix missing ERRP_GUARD() for
 error_prepend()
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-7-zhao1.liu@linux.intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240229143914.1977550-7-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello,

On 2/29/24 15:39, Zhao Liu wrote:
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
> ERRP_GUARD() could avoid the case when @errp is the pointer of
> error_fatal, the user can't see this additional information, because
> exit() happens in error_setg earlier than information is added [1].
> 
> The vfio_get_group() passes @errp to error_prepend(). Its @errp is
> from vfio_attach_device(), which @errp parameter is so widely sourced
> that it is necessary to protect it with ERRP_GUARD().
> 
> To avoid the issue like [1] said, add missing ERRP_GUARD() at the
> beginning of this function.
> 
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>       ("error: New macro ERRP_GUARD()").
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: "Cédric Le Goater" <clg@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


