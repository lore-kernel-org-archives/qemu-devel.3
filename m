Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED66C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfl5p-0007g0-LJ; Thu, 29 Feb 2024 13:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl5n-0007dg-4A
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl5l-0004XK-Jh
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709231112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwWTqwix/dFR+GhOL3Z3zoL9KBd9h+uQgpNcgqh5go8=;
 b=IRJqpQBEYOx1ZznTxiIJ/DCirr/MWdZY0ltW7UPXrmxr+Pq1qGCAqXLJrYLEcMLQ86b0jr
 k9FRzd0JcOiB2KY8vGVxUHjSIOOtVl+djy0xSfoetjLKqV8XF/zAHiWQPgMi248z0xj9Ft
 3xwbR3K6v2EhW24rfqwi/LneGPOsXZM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ADwQvQUNNB6fFtqYT8racA-1; Thu, 29 Feb 2024 13:25:11 -0500
X-MC-Unique: ADwQvQUNNB6fFtqYT8racA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68f74aff2b0so11464406d6.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709231110; x=1709835910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwWTqwix/dFR+GhOL3Z3zoL9KBd9h+uQgpNcgqh5go8=;
 b=mXus9JwKHYu6xNFvzXw0JsaUA35vpp0O+TParKy0WKuAtnWjoy/3+6mKoD+/X/horC
 j6V1/Z03R/InDCbhsvIr7F1VuI1jtDpHnA0iQhGLmTivxlUPSTfa+wyg/9LiQsrPuCGp
 pd8nYcpGNb0JzNfWRXJbUUTn66wEU6SSeuw07X1cAKasvR4vsCB4gpNmLlZ8xVxT6pJz
 c4gbc7kbz2wZHcshRqOtMayecQ+n2FljA1jMnCsnrDIM8FgL46ohn6ZstAy4y2cYhC4P
 mibioNJ6vqpOPmXxivKEyX7jH3H+qIvz8eJOi4CGMApBJImddUOVOe4vh2jC78itIy9n
 2D1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8mzfg68zjxrfcReVEQ7NFofxhTGT/1hBTb1wYL9Wg+KwE7m7HRrvzvl4YWbqV6yhGNxfiRTDkwH3oZmeCqTigd0n/P7w=
X-Gm-Message-State: AOJu0YzTV0VBjqi73X9RKpJENi6wGwYieA9rrBDbcVe6WDoHodPHmygJ
 HqHP6k8614wOZ0M+qtCicfoJE1Ro/2FqTwo2bdDZQcXtBr6FolhHp4SiYfXVi3qJpL1VpOhRa8P
 q+bHEx9DSE8wBK4MvAo8jm3t7wAUqG7shR21Ia7jqNchMaytMWPlz
X-Received: by 2002:a05:6214:933:b0:68f:b7f0:65f4 with SMTP id
 dk19-20020a056214093300b0068fb7f065f4mr2641450qvb.63.1709231110486; 
 Thu, 29 Feb 2024 10:25:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnDTDQ8T5NIqsStFVR9MOaiFxAe7TdccdaUpHay9XrVf5JETTqV2Q0p2kYTczMMRnp/eaiXQ==
X-Received: by 2002:a05:6214:933:b0:68f:b7f0:65f4 with SMTP id
 dk19-20020a056214093300b0068fb7f065f4mr2641439qvb.63.1709231110208; 
 Thu, 29 Feb 2024 10:25:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 qp11-20020a056214598b00b0068fef74fdb3sm994819qvb.59.2024.02.29.10.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 10:25:09 -0800 (PST)
Message-ID: <2b516b6f-e655-4895-a82f-7d7ff11ce63d@redhat.com>
Date: Thu, 29 Feb 2024 19:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] hw/vfio/pci: Fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US, fr
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-11-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240229143914.1977550-11-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> In hw/vfio/pci.c, there're 2 functions passing @errp to error_prepend()
> without ERRP_GUARD():
> - vfio_add_std_cap()
> - vfio_realize()
> 
> The @errp of vfio_add_std_cap() is also from vfio_realize(). And
> vfio_realize(), as a PCIDeviceClass.realize method, its @errp is from
> DeviceClass.realize so that there is no guarantee that the @errp won't
> point to @error_fatal.
> 
> To avoid the issue like [1] said, add missing ERRP_GUARD() at their
> beginning.
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




