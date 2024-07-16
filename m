Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101C2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiSw-0004dW-Km; Tue, 16 Jul 2024 09:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiSn-00045k-FC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiSZ-0007Wo-TH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721137394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9psGEOlrWJb8OW0jgIXVgsqkq1DsnpX2JGAGsNa2T1s=;
 b=PCofHf8Zx+Fcb8fwAoDjtHK53G4ylftcEN/WmW/f3uowvmwInJ1nsTsyG3OSs/a85aLXn3
 LP/Z6Axd1PNXJyvNPIxRvcWMHFA2q63CUvRdfTSa+UL4ZxnUSkBvvA3H3fq490SW6YakGq
 XbkS88W40q1wWZhHv80mvpPlk3u9pYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-msENWES_MdueX2s1JuJDlQ-1; Tue, 16 Jul 2024 09:43:13 -0400
X-MC-Unique: msENWES_MdueX2s1JuJDlQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42796140873so35859985e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721137392; x=1721742192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9psGEOlrWJb8OW0jgIXVgsqkq1DsnpX2JGAGsNa2T1s=;
 b=Iizc05KuEQHEff7UERuZ4z4aX7lqdCpyqGATZf0qDG8JhihydhHA4AOz9j/gNE7rXT
 eD/qR/72t83MKDI6AUHC65wL29ZB3IhAF7roh2NqZyG2TKAh89moqQSIAs3qeMGctpA3
 NT+1NyD0XaNWIqtkXQS4euKxPjG5X7NYbGRFwPR1oN4NXzbR8w0B6sby8uUtEhZa+eo0
 csn0d7yrtNpYgm5uU9BqE9HlHfEWDh+EQ/99RUJnjVfRaSqk70QnXWwQcr/pTdMVf9cv
 d92qq2xD5w862hsC7j2AE0G9iCSAm2teRxUd9J9sXOi79TBb2dBraC/Tgi1b1TPPfyF1
 mFYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT5Hw15Fk2FP9OZ+QE1eXCkSyS2/mUIDPtC3sU9k9KO1KoEjsoq40vNpSxWvXIwb8FEbS5QvPeiVjMSO3JgORor0BY26w=
X-Gm-Message-State: AOJu0Yxqk9rZSHjRI32u9el+xAHEQxIqnyoxVPYPwfCmsqrbWVt65mSR
 WwmGxMuWXOrmq0XI/nnZdIkdhkYfBn1DoHGvRnNOEUct4U6iK67zpadp4W8uPpPTpPkU1D0GQg6
 BEp4WjIrStZmyMIuM2cAaCBLWm98chpyHKTHkYQs9e/c37SaLHoZr
X-Received: by 2002:a05:600c:3d8a:b0:425:7884:6b29 with SMTP id
 5b1f17b1804b1-427ba6991f7mr14098865e9.19.1721137392110; 
 Tue, 16 Jul 2024 06:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsAfXGkMJ8zQpegoBENwNU3dtdua0gCXiFZ4oaGgwkLCQX3A0lW2zz+6wOkOS69MIZ+RCa/g==
X-Received: by 2002:a05:600c:3d8a:b0:425:7884:6b29 with SMTP id
 5b1f17b1804b1-427ba6991f7mr14098715e9.19.1721137391675; 
 Tue, 16 Jul 2024 06:43:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2397f7sm164158875e9.9.2024.07.16.06.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:43:11 -0700 (PDT)
Message-ID: <7a3108f2-6ef4-4fde-8b99-5714bc70ecd5@redhat.com>
Date: Tue, 16 Jul 2024 15:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/vfio/container: Get rid of qemu_open_old()
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-5-zhao1.liu@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240715082155.28771-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/15/24 10:21, Zhao Liu wrote:
> For qemu_open_old(), osdep.h said:
> 
>> Don't introduce new usage of this function, prefer the following
>> qemu_open/qemu_create that take an "Error **errp".
> 
> So replace qemu_open_old() with qemu_open().
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: "Cédric Le Goater" <clg@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 425db1a14c07..38a9df34964a 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -600,9 +600,8 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           }
>       }
>   
> -    fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
> +    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>       if (fd < 0) {
> -        error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
>           goto put_space_exit;
>       }
>   
> @@ -743,9 +742,8 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>       group = g_malloc0(sizeof(*group));
>   
>       snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
> -    group->fd = qemu_open_old(path, O_RDWR);
> +    group->fd = qemu_open(path, O_RDWR, errp);
>       if (group->fd < 0) {
> -        error_setg_errno(errp, errno, "failed to open %s", path);
>           goto free_group_exit;
>       }
>   


