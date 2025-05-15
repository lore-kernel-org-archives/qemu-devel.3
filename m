Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEFCC54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTFw-00047C-6f; Thu, 15 May 2025 03:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFTFu-00046x-8i
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFTFs-0006EU-6q
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747295026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jFvKSla7qsixIHJoDhEQwNf4SKIuq/LcXxhEbevh+Cw=;
 b=M+mmRMXr+Ko1OGsqpgsAfp0lTse94+6rdGlHPNk0ukA8dvMsMfIjK5oN7VB9oZi+iEpfoN
 TRl7Xh1Wg99antGL70jom9UQHKTwOWsMZWGXpUeqXPTom2bcY1B4fz10zhKm78EsM/zfZ6
 chMFzERX4RjcDJSIjlnMjNCVtwnW7UE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-kEfq8GPYMOmlBEsj3x_5Bg-1; Thu, 15 May 2025 03:43:45 -0400
X-MC-Unique: kEfq8GPYMOmlBEsj3x_5Bg-1
X-Mimecast-MFC-AGG-ID: kEfq8GPYMOmlBEsj3x_5Bg_1747295024
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a3591847a5so88121f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 00:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747295024; x=1747899824;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFvKSla7qsixIHJoDhEQwNf4SKIuq/LcXxhEbevh+Cw=;
 b=p7dBwedgSCTPMd42CL0eQ2WKRbNm4iMEHm1ykryJj9QmJfgDC2aBcJRL7pQCUXW5gE
 DVCuA5ZTYIJ9BZYw8n4KXibpj2G6jFDzz3JyFo2QTFnEG1UoM157qDTbWlCvyKQVSIf7
 9sb0wRaHz4R2nLqB4sqNld09ss7LUwnxe0xltRI7OXkAeAaeMeSDA+k3+Er/rSu9akgZ
 AkrqtywqVSM17UMAKNn72UNyuEvcUwjn4Po3ARIDL39bxxfpXaxD5gIQLIMVK3nPeTSd
 ZaEKyKxy+An+dzpQayjA6j0/bLX9Af7ilmmdm1ty4+1Nfg/WQlPy4yzReCd8/UKN7iVi
 xfxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsK9/FiAnZn4xm/EP7qVYoikt1iRnZy3DHsqBQvxF4kV92rxjpHHq9sVrbsjVkRqhQFY8TU48AtgD/@nongnu.org
X-Gm-Message-State: AOJu0YzM91uXpLAGG6j8Ih/isYM837z1zzsWyHLHMGutSY4I7zW6Aitr
 De4PcwiVqALtJ6jY/oE0aDedSL4svotzATXuEgvS5drsgmho85nOP6sGZGIl6RO32ql5M90jPG/
 sFpquEkJZXCQ/vZ+EDPuDzqqwWGJ+jM9j8vbPijC1iVzjDyllUsMP
X-Gm-Gg: ASbGncsdOLN8JXoIoz6bPwXZbt1Vguw9kQqaTUXOlkWsSfDOu4rvxSBQno0IfKsKFn6
 bXjnhlrftVF/YaQ+TzQnzqC2bSHDBI4/UPPHrkhUQQZ9Lo1BD8cMZiRizt7mpx4zSIQXPpaLmiy
 eHAP5FLrakh2vQHIFPd9MPSjskBxyj85RXf4B0QpMVxxckV2kraPkk+iJ2B6hFBnfncPdFCRsKa
 jpbD4v3oAVXdr/1hFFtszFiBjC1R5UQ5pCq0gx+2kfT/MXVkIkjXUZbTtl4QpGMoqAqzcM0ZJOO
 wqeRypylMqbHWnlFL9afssIRd/8DXCoYY8e7T+Fq98T2HGvyBQ==
X-Received: by 2002:a05:6000:2408:b0:39c:30f9:339c with SMTP id
 ffacd0b85a97d-3a3496c1fa7mr5158795f8f.28.1747295023895; 
 Thu, 15 May 2025 00:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkDrlHo9epuW4F0GUKa4eAXBAhDEzbn5g8lxCf2Trz8RuPR765/7KFqli87ilJgLHbOsyNyw==
X-Received: by 2002:a05:6000:2408:b0:39c:30f9:339c with SMTP id
 ffacd0b85a97d-3a3496c1fa7mr5158771f8f.28.1747295023529; 
 Thu, 15 May 2025 00:43:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2ca47sm22001602f8f.73.2025.05.15.00.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 00:43:42 -0700 (PDT)
Message-ID: <f5008a93-7479-4dba-a51b-b1d0d8fe50d2@redhat.com>
Date: Thu, 15 May 2025 09:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 02/42] migration: cpr helpers
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-3-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Add the cpr_needed_for_reuse and cpr_open_fd, for use when adding cpr
> support for vfio and iommufd.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/migration/cpr.h |  4 ++++
>   migration/cpr.c         | 24 ++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 7561fc7..fc6aa33 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -18,6 +18,8 @@
>   void cpr_save_fd(const char *name, int id, int fd);
>   void cpr_delete_fd(const char *name, int id);
>   int cpr_find_fd(const char *name, int id);
> +int cpr_open_fd(const char *path, int flags, const char *name, int id,
> +                bool *reused, Error **errp);
>   
>   MigMode cpr_get_incoming_mode(void);
>   void cpr_set_incoming_mode(MigMode mode);
> @@ -28,6 +30,8 @@ int cpr_state_load(MigrationChannel *channel, Error **errp);
>   void cpr_state_close(void);
>   struct QIOChannel *cpr_state_ioc(void);
>   
> +bool cpr_needed_for_reuse(void *opaque);
> +
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>   
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 42c4656..0b01e25 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -95,6 +95,24 @@ int cpr_find_fd(const char *name, int id)
>       trace_cpr_find_fd(name, id, fd);
>       return fd;
>   }
> +
> +int cpr_open_fd(const char *path, int flags, const char *name, int id,
> +                bool *reused, Error **errp)
> +{
> +    int fd = cpr_find_fd(name, id);
> +
> +    if (reused) {
> +        *reused = (fd >= 0);
> +    }
> +    if (fd < 0) {
> +        fd = qemu_open(path, flags, errp);
> +        if (fd >= 0) {
> +            cpr_save_fd(name, id, fd);
> +        }
> +    }
> +    return fd;
> +}
> +
>   /*************************************************************************/
>   #define CPR_STATE "CprState"
>   
> @@ -228,3 +246,9 @@ void cpr_state_close(void)
>           cpr_state_file = NULL;
>       }
>   }
> +
> +bool cpr_needed_for_reuse(void *opaque)
> +{
> +    MigMode mode = migrate_mode();
> +    return mode == MIG_MODE_CPR_TRANSFER;
> +}


