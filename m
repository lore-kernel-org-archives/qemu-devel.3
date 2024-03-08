Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74541C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridSx-0001pY-HH; Fri, 08 Mar 2024 11:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ridSw-0001pQ-DP
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ridSu-0007OS-Tl
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709916779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bv1Si3i/IqMy5otxtj4GrXf1cd1ke5LDJxOwFGXzj80=;
 b=XsMwK1u3a283MZz09ZFjx3neeDnc1Zn95316lAmOm0Ts4HQnU72INfxTbH3GLmGEzYSIlx
 8CxiI4mab+GoxcreB+Iq7xQiV4URAt3ouQwQRtEiPOGvrYy5gS/JZusEzIgwM662P2zuwi
 jeTiLCJbY9ZKOudkABIzY83Y53UYmbw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-YV75_5D6OCydq2FS_jQOSA-1; Fri, 08 Mar 2024 11:52:58 -0500
X-MC-Unique: YV75_5D6OCydq2FS_jQOSA-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7d604e82b38so846551241.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709916778; x=1710521578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bv1Si3i/IqMy5otxtj4GrXf1cd1ke5LDJxOwFGXzj80=;
 b=umN+Ji0VsHDFNiPsqEd5nttM8caKnmhie83OMyFUe/9UB1vcZfw9tHB6wPcYf2e/jg
 kxVhYSqEzK8VrKc+Lf38/zOs85gCvBpm6z7gLVsomEdXXQBuatdagiS0lUIAlOeJg3a3
 GEAQYgOOBBWiBe7Kw++yJDVGF6MLUowv6vvO2d+orMRJxg2/W1v4xBVTAc15cuAGsVtO
 Ca8JUpndmKQM9RlaPXtTTRyjiW6Xkw+smC/TqgW0j8ttvBDSP8VMdoj4jfETjSDne3Q8
 /Bl49CZ/i+1KRWvQYCkXVEFhACX7LoQEVArnSNnqLmUcRAmLLJ9HUI1PAExUVhuurx2f
 Crow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd717D/VilmenjLKETj6Uxxmu3GE4+UHQ6yp/mUSWAcHbYVdq8dLCE7km/WQVYKM3z95GT6x/Yx3x9EjJxLO8ucUHgzno=
X-Gm-Message-State: AOJu0YybYi7j55rR5vgY9lkBvmmbU/XieRGV0La0ghkKEDKR1Le6f74G
 IKv50FSSiigidQROYsOhXstYrjfkZN6bYXDd5BhZB6nkzGt42XiTrUkE4uKzBSf36QdRNU6jbeN
 xBV6gAeguiYWalTBz85Z2oSG2isIf+pqS8DzqFOHsm45WSYAa1Zn3
X-Received: by 2002:a05:6122:50b:b0:4c7:b048:bb9c with SMTP id
 x11-20020a056122050b00b004c7b048bb9cmr11949594vko.15.1709916777973; 
 Fri, 08 Mar 2024 08:52:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtals9IefCwdSO9oLMgU+hKEmm7tcfEaoOpjpZ8iWwEpf3f/JVghgg6QUpRkEUr7/qOTdcFw==
X-Received: by 2002:a05:6122:50b:b0:4c7:b048:bb9c with SMTP id
 x11-20020a056122050b00b004c7b048bb9cmr11949520vko.15.1709916776232; 
 Fri, 08 Mar 2024 08:52:56 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9000:9100:7442:850e:5af1:aebf?
 ([2a01:cb19:9000:9100:7442:850e:5af1:aebf])
 by smtp.gmail.com with ESMTPSA id
 mc8-20020a056214554800b0069030b7dee3sm8830037qvb.30.2024.03.08.08.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:52:55 -0800 (PST)
Message-ID: <ef2b7486-54be-497c-a002-067493aa3a32@redhat.com>
Date: Fri, 8 Mar 2024 17:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/14] allow cpr-reboot for vfio
Content-Language: en-US, fr
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

On 2/22/24 18:33, Steven Sistare wrote:
> Peter (and David if interested): these patches still need RB:
>    migration: notifier error checking
>    migration: stop vm for cpr
>    migration: update cpr-reboot description
>    migration: options incompatible with cpr
> 
> Alex, these patches still need RB:
>    vfio: register container for cpr
>    vfio: allow cpr-reboot migration if suspended

Applied to vfio-next.

Thanks,

C.



