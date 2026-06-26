Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ABAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBVZ-0003LO-7G; Fri, 26 Jun 2026 14:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBVR-0003IS-O6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBVP-0002NG-7g
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782499342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sKCoOHuUxkjUUkw5CtzU+kRPB7ZyObrW+LkV5z7rkTs=;
 b=E5N0oockTSHVcPMHWIIUjhg/jqVBExSN4FE8xYl5NF3YmmC73yMidHHwEtc1MWFXHTp4b5
 CAM9XwBQJR6qlc8D9sBncL9IjMaNV1koF8XV9mjMR3qCUwiF7FBHD+QLeF2/jQXTFd9qs+
 fvBt5OBSUJ+tQIBkoqufInh4La6a5EQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-1aYZEfM7NWWC7iINJEDMGA-1; Fri, 26 Jun 2026 14:42:21 -0400
X-MC-Unique: 1aYZEfM7NWWC7iINJEDMGA-1
X-Mimecast-MFC-AGG-ID: 1aYZEfM7NWWC7iINJEDMGA_1782499340
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46315372c3eso950693f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782499340; x=1783104140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sKCoOHuUxkjUUkw5CtzU+kRPB7ZyObrW+LkV5z7rkTs=;
 b=tgXI02CO+GYp6EByR/e68ezFMlaYAIdjxXVR2XqoyUgf4I5TPkYb6ccLP30W15EafS
 MW3cBK2idJYXIEUOMXhrppFoXjXRucoNiAkMsDgazTo7MFUx+mz08sHrrwGUdTML+JPT
 In/Pcouv3U375cV0rePZRLY1MWpiE1cXAMroOkbZndEdggpdaQwbQ0zzcRy1t2uSctiP
 CF0YV05ZS1WyDKIN6/DJTpyXgY+XGiJNKAcOjRS6Cx7u+HgKEKlJszgHVC0vYFDHkccB
 KvW5z1EQPfczDbpSmrWrcXwdjSlV9uep2gnqZkYr14JYkT+Z+iGlJVebke8H3Uf4JYQi
 Injg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499340; x=1783104140;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKCoOHuUxkjUUkw5CtzU+kRPB7ZyObrW+LkV5z7rkTs=;
 b=dEiNgdmCO4v2dM3eMexo689gP4QcVcFNclTkylVUnmgFRsGzdcdtjuSwrLapGJ680d
 ZzNY/1RXCShpBr2QfpISNpV+3et2X1ikghZNPt8JMvhBctFnYnqn3ySsTDuC8UbzzCco
 vsdBHhM/PXhCNFbWnsRp2kAdgKUsgwKaw4KMZOFY5vXxF6HkpW7ig0eOoKByElTYzu1Q
 2ezfDumgQelnpsS72XipEihN7DaK3sInKYzmQ1XyYB/ylYyp3ycVmgqBYc2FSvP/Th5V
 w0+Oyty21RA7LaBh8p34v0hueRtkM/g0hEoYGsA34LWj6YxMuc+sGzguJfpdiRM3Ey7S
 NLqA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4I6Q0L7Zyy1ESxczQ3JQ4leZ0z7gYzNpilYyAxH3whhZIflYS/MzHQITatShzIWNuKPMdUsUsk56l@nongnu.org
X-Gm-Message-State: AOJu0Yzaoj5gjA56wRZIUkOTXmThFDNiRoSwj3ggdEJ0KM06AWchGmPo
 v9VmixtHEkAQT4Z/jh3bAJBTIZjUTptoSMMFrlbDXTldqBk3nR59pbZ9Y1BFEpQmFEzKY6KVFtH
 lk5ttv4eOrRfpcLHYDmxjGyPvSumf5GXqsNqJ4MnjS2zQo8B2DiJGqBeC
X-Gm-Gg: AfdE7cmOZM8hi9JImF5lnTUS+8yX2gEnKwDw06ruUPJJXAQuwJ0CE+b53y9Lh8TsYwi
 4949Kwr5JiYMaLmtMQQcHMaDTw3VuWMzrGulUZHOdCcCe4c6qwf5c/ZgaJSywiEHXwYJ+47mKJS
 ZHnNCFV9Ps8MVon1o+NuCDVnN34vYvxK7yo4uRJKxr6qIhXSRKxeTVg4WfWudDf9qCYDmPO1zJe
 ZFwsKiCO+NinU7/bYpgIF6vh9VtPbfsKTpqZrAH5xYV8QLsXL3s3nQIIyeWb3jTjCPTL+KT3pEL
 xKULUAWOYds/2pMdMDyhtmMRY9c1Yrm7Fe4ELFdgcPiFZBKIZNwU9GTcvOK4ga2Ze5W49Pfgpmo
 tjY7zPUabYSrL7i+viW7qxy3/l7ZnmXCJYvXc0RuNBWbv5gbWKdSL
X-Received: by 2002:a5d:5f4c:0:b0:441:1e8e:d8fd with SMTP id
 ffacd0b85a97d-46dc12dfa46mr11775163f8f.29.1782499339942; 
 Fri, 26 Jun 2026 11:42:19 -0700 (PDT)
X-Received: by 2002:a5d:5f4c:0:b0:441:1e8e:d8fd with SMTP id
 ffacd0b85a97d-46dc12dfa46mr11775137f8f.29.1782499339522; 
 Fri, 26 Jun 2026 11:42:19 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46fc2ff9aaesm2916782f8f.26.2026.06.26.11.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:42:19 -0700 (PDT)
Message-ID: <aaae35f5-7d00-4c52-b680-5a51254286b3@redhat.com>
Date: Fri, 26 Jun 2026 20:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Update vfio-user spec to describe DMA access mode
 bits
To: Mattias Nissler <mnissler@meta.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Levon <john.levon@nutanix.com>
References: <20260602133829.305842-1-mnissler@meta.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260602133829.305842-1-mnissler@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_PH_SUBJ_META1=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/2/26 15:38, Mattias Nissler wrote:
> This makes the intended access mode explicit when registering DMA
> regions with the server. A new "file I/O" access mode is defined, which
> can be used if the file descriptor provided by the client doesn't
> support `mmap()`.
> 
> Signed-off-by: Mattias Nissler <mnissler@meta.com>
> ---
>   docs/interop/vfio-user.rst | 82 ++++++++++++++++++++++++--------------
>   1 file changed, 51 insertions(+), 31 deletions(-)
> 
> diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
> index 12deb25102..1c92f442d2 100644
> --- a/docs/interop/vfio-user.rst
> +++ b/docs/interop/vfio-user.rst
> @@ -604,27 +604,31 @@ Request
>   
>   The request payload for this message is a structure of the following format:
>   
> -+-------------+--------+-------------+
> -| Name        | Offset | Size        |
> -+=============+========+=============+
> -| argsz       | 0      | 4           |
> -+-------------+--------+-------------+
> -| flags       | 4      | 4           |
> -+-------------+--------+-------------+
> -|             | +-----+------------+ |
> -|             | | Bit | Definition | |
> -|             | +=====+============+ |
> -|             | | 0   | readable   | |
> -|             | +-----+------------+ |
> -|             | | 1   | writeable  | |
> -|             | +-----+------------+ |
> -+-------------+--------+-------------+
> -| offset      | 8      | 8           |
> -+-------------+--------+-------------+
> -| address     | 16     | 8           |
> -+-------------+--------+-------------+
> -| size        | 24     | 8           |
> -+-------------+--------+-------------+
> ++-------------+--------+------------------------+
> +| Name        | Offset | Size                   |
> ++=============+========+========================+
> +| argsz       | 0      | 4                      |
> ++-------------+--------+------------------------+
> +| flags       | 4      | 4                      |
> ++-------------+--------+------------------------+
> +|             | +-----+-----------------------+ |
> +|             | | Bit | Definition            | |
> +|             | +=====+=======================+ |
> +|             | | 0   | readable              | |
> +|             | +-----+-----------------------+ |
> +|             | | 1   | writeable             | |
> +|             | +-----+-----------------------+ |
> +|             | | 2   | access mode: mmap     | |
> +|             | +-----+-----------------------+ |
> +|             | | 3   | access mode: file I/O | |
> +|             | +-----+-----------------------+ |
> ++-------------+--------+------------------------+
> +| offset      | 8      | 8                      |
> ++-------------+--------+------------------------+
> +| address     | 16     | 8                      |
> ++-------------+--------+------------------------+
> +| size        | 24     | 8                      |
> ++-------------+--------+------------------------+
>   
>   * *argsz* is the size of the above structure. Note there is no reply payload,
>     so this field differs from other message types.
> @@ -634,6 +638,8 @@ The request payload for this message is a structure of the following format:
>   
>     * *writeable* indicates that the region can be written to.
>   
> +  * *access mode* bits indicate how the region is to be accessed by the server.
> +
>   * *offset* is the file offset of the region with respect to the associated file
>     descriptor, or zero if the region is not mappable
>   * *address* is the base DMA address of the region.
> @@ -641,16 +647,30 @@ The request payload for this message is a structure of the following format:
>   
>   This structure is 32 bytes in size, so the message size is 16 + 32 bytes.
>   
> -If the DMA region being added can be directly mapped by the server, a file
> -descriptor must be sent as part of the message meta-data. The region can be
> -mapped via the mmap() system call. On ``AF_UNIX`` sockets, the file descriptor
> -must be passed as ``SCM_RIGHTS`` type ancillary data.  Otherwise, if the DMA
> -region cannot be directly mapped by the server, no file descriptor must be sent
> -as part of the message meta-data and the DMA region can be accessed by the
> -server using ``VFIO_USER_DMA_READ`` and ``VFIO_USER_DMA_WRITE`` messages,
> -explained in `Read and Write Operations`_. A command to map over an existing
> -region must be failed by the server with ``EEXIST`` set in error field in the
> -reply.
> +There are several alternative access modes for the server to use when accessing
> +the region:
> +
> +* ``VFIO_USER_DMA_READ`` and ``VFIO_USER_DMA_WRITE`` messages, explained in
> +  `Read and Write Operations`_.
> +
> +* ``mmap()`` a client-provided file descriptor, then perform direct accesses to
> +  the underlying memory.
> +
> +* File I/O system calls (such as ``pread()`` / ``pwrite()``) against a
> +  client-provided file descriptor.
> +
> +The access mode bits in the flags field indicate which access mode to use. If
> +an access mode requiring a file descriptor is specified, but the client does
> +not provide a file descriptor, the server must fail the request with
> +``EINVAL``. If no access mode flag bit is set, the server should use ``mmap()``
> +based access if the client provided a file descriptor and message-based access
> +otherwise.
> +
> +On ``AF_UNIX`` sockets, the file descriptor must be passed as ``SCM_RIGHTS``
> +type ancillary data.
> +
> +A command to map over an existing region must be failed by the server with
> +``EEXIST`` set in the error field in the reply.
>   
>   Reply
>   ^^^^^

Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


