Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1EDC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXQ8-0002V0-EQ; Mon, 10 Feb 2025 12:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thXPu-0002Tl-Uk
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thXPr-0006NP-0P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739207868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IunDW41aW0MVgEphCwwofgJoPjdYZsbQLYEW05ADHBc=;
 b=Mkm1ntCktqdZWUuoqha2JroZCZVEOKUssGB6FOtPLPZvFBJIUfwPgvvdMQBzYfyW1Pyewm
 4iDit6y7XmbRWgDZvfvCg75Fp433+tX106rRh7A5SiNsfWKrBHFaCrbcvnXBSAiiQFkhjZ
 Kj+h1PBlc0LgAGrClIfc8w92mGK+uao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-bEam9Yt7MmS4Va_gM55nnw-1; Mon, 10 Feb 2025 12:17:47 -0500
X-MC-Unique: bEam9Yt7MmS4Va_gM55nnw-1
X-Mimecast-MFC-AGG-ID: bEam9Yt7MmS4Va_gM55nnw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dd8d11139so1415209f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739207866; x=1739812666;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IunDW41aW0MVgEphCwwofgJoPjdYZsbQLYEW05ADHBc=;
 b=Vilp9mZVg2NMFb1XGk5JxzeI4E+Uzg/IP12lq8CekUHNeGZdRi849McnkJV69XgrwV
 iUNyUIbX4NmgNx9bOGuizmgK7X7hmvSYfaEGE556LPJGE41qwknBmn+HBXxnn2Rq7ERC
 Y8PhH7vasiOpy9qjPoFjo62f76a+BowDJDevqRq8cIaU6aQ70vGK+KCD1vtK0oqhu/uh
 dKkj7RA2F9dwc8oj6uqFMeBn3xCBJUxPU+CX7AgW+pUyUvc+RX1hpuDqC7uaKhnhhL6z
 X/wKyI6LdfsYf34FiB8ToX4VWTnMhxPDzp8yKrLeawUx3pLH9HXrMYcnTfHLOFlqvJfL
 vhXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXznvznIm9qh5yZIgiqLar3P4Maj12rgqSDPm06jCaydUbwF8Kvs65JJSkDPVW9/BWf4I1cO/BL7if5@nongnu.org
X-Gm-Message-State: AOJu0YyIDvULI25KkSAfWoM7q6/Md9Zw6sKpSYrXk5j2PHGBT5kQbg9g
 gn45iEzGeERw79zohU1xDBiiZw41Yh8eR2cla8RF3PElnarIsnp182/+rZ3opECaomiwa/LMwQL
 OgEA25v8mYpp4dAguoRszoVC6ZnOzdFhaYOlkZfHmPQz60ZImTq+5
X-Gm-Gg: ASbGncu1mb+OUlzFMjzuY0ZnUvtwW+MydCJPIxYFN4Q2sTCKB2P7Xd8FOYEB7VdLyUw
 MGCT2gDGXjRfF9z8sgf3MVb1XG9RnL8OEVmFAu6cSkW0/e8DQa8KygfkFvHMYcTNALAMz9iwCq3
 Q5j6NWzjy+z+BoHXdf5x2YjuAm8CYXquYsqlTMhjjiJkzct17eihgRndvYeDCneGlA1Q0v89NrN
 AvkwIaFCyJ/5DmFx6laEt0NkOhk0BXidSgV++zYGZmO9ZWoSUqYQyLCwYWA7Z2P+8xkEH5cg/5U
 RHq/XX/YMrdaYvlDPrtcSf2bMw+Qqe8/bvs4fhljDgQ=
X-Received: by 2002:a05:6000:1445:b0:38d:d4ef:ae6a with SMTP id
 ffacd0b85a97d-38dd4efb1bbmr5652380f8f.29.1739207866316; 
 Mon, 10 Feb 2025 09:17:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxuPfXGs+Epy/dpmMQiRr8Td6+INguvlA6Txdm0oyMBB+tE1fwPgVn0QUCCTK195h/kxIIBw==
X-Received: by 2002:a05:6000:1445:b0:38d:d4ef:ae6a with SMTP id
 ffacd0b85a97d-38dd4efb1bbmr5652364f8f.29.1739207865949; 
 Mon, 10 Feb 2025 09:17:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd093e1ffsm8386876f8f.100.2025.02.10.09.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 09:17:45 -0800 (PST)
Message-ID: <7b17aa1e-034e-47ca-8da6-50740492bd31@redhat.com>
Date: Mon, 10 Feb 2025 18:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/33] vfio/migration: Multifd device state transfer
 support - basic types
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <eaf874f64709ab9ac88ef96d1656d9d9d423ec78.1738171076.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <eaf874f64709ab9ac88ef96d1656d9d9d423ec78.1738171076.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/30/25 11:08, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Add basic types and flags used by VFIO multifd device state transfer
> support.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index cbb1e0b6f852..715182c4f810 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -47,6 +47,7 @@
>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>   #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>   #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY (0xffffffffef100006ULL)
>   
>   /*
>    * This is an arbitrary size based on migration of mlx5 devices, where typically
> @@ -55,6 +56,15 @@
>    */
>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>   
> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
> +
> +typedef struct VFIODeviceStatePacket {
> +    uint32_t version;
> +    uint32_t idx;
> +    uint32_t flags;
> +    uint8_t data[0];
> +} QEMU_PACKED VFIODeviceStatePacket;
> +

Since this is a rather big change :

  hw/vfio/migration.c                | 754 ++++++++++++++++++++++++++++-

please introduce a new hw/vfio/migration-multifd.c file.

Thanks,

C.



>   static int64_t bytes_transferred;
>
>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
> 


