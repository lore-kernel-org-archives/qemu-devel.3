Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B764EC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrSa-0001l1-10; Mon, 05 May 2025 04:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrST-0001aG-Mq
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrSR-0002ur-C7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746434749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fkQSFRp4yHTXJnQw4G4QPCgf5vbvjL2V7nc/NXLjlhs=;
 b=EAUTqdqRQdhRttOe4AWYwMUUPmVgiMx+3MUFzGJvMMinj2Y0G8zj3ObIUphuoAkvcyayL3
 Xd3LG8dBi0bUoNALyb83fmOnnISEWKe4kQGc8BUnex/uqgrxwP9ZXGyxgrF7RXDqEwszOh
 e7z77nL6QSBURGe6eZY+LCwJw8RVb/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-OHi-MY8bN2i8KHoBLnvGNw-1; Mon, 05 May 2025 04:45:48 -0400
X-MC-Unique: OHi-MY8bN2i8KHoBLnvGNw-1
X-Mimecast-MFC-AGG-ID: OHi-MY8bN2i8KHoBLnvGNw_1746434747
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so6238595e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 01:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746434747; x=1747039547;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkQSFRp4yHTXJnQw4G4QPCgf5vbvjL2V7nc/NXLjlhs=;
 b=h6XqkHWjlMhV5h1WJ/xg+C3C4KgzuTfNir1UCGZ7KdYGyIe2f4C+ITksO0oyEvRlrU
 vqnmsa4LsHBjbbqvo+vtS0goFFMhfpGZ8Xbr3sRjGp+7f98L5H86Nnq9AmvtedMbwyq2
 SI9R4gADjOMh6mbxEteYcr8pwOon8gVthcKx9ATIUFVr0/fw5oI/qVATJvqwzUqB4/Mh
 Ks1ve1Ed9s05OGkMxawa+N/RqDbybp9W+GJwFSobx9qVcpmHFG6GSOeFVKComdmFz0vE
 EYQLEJd4k1vnk54cdtZnGehdSgZnEFd8EKUH6u7d2M+3Dtokw7rbmSVEZYkAL+IIHjq7
 5Sqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgL1qFvHeCJ8pG9uGyAvErcDYtYRgJ6ZrqzeU2UvLyKmK458orPcdU2QisDJZnDFINtpCMf4Ncaq+L@nongnu.org
X-Gm-Message-State: AOJu0Yw7Lg5GdUU//KC/Ghn0RWrGHL8IHDiTwOmYTQcLgmJAKeFX5i4R
 ClKvqDQUp3/i9UAX2Xd+6hTUQxxNbJj/zvFoT5YPFDIom8Cajd2n8ug9mAZ5sRjVSvabfL35Z6t
 FDGaTjbuFjOnagtzGVKeagvxCmAcs2DQfQq/RBoxkSStfZiBNg4mZlMEZSg+e
X-Gm-Gg: ASbGncu1bcZxKEEOXKm8jJfKT1ZRA6I0s5miDeLtLlskJ+FJm2DIEHW7fa9laZbLhBd
 somYddwovC6mB2b6pCPLD75DNoDhuGqZphe4VFvZShIf1REy6vpvvYWbm03nCNOh/N+PfgnpugQ
 tc2R2sH7TGamPPWnCi21yzE1vzzm+OBG/rOf4xQdaPuabIGHj4dkb5YKQrtN6/vSfLmAYC+G/UK
 YpmVLOqVDu5PMh8Q/nJonngHbcCzz+qYyLrF1I3TdeAFjDoRNxlgkmvvtPiRYln0JRTUyd52dlT
 KyR7+MwWdpDT3s8/ZxxpanrXh8Csy0zPuBWXQGetuiEdYrggqQ==
X-Received: by 2002:a05:600c:5303:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-441c1d5c568mr52179275e9.20.1746434747083; 
 Mon, 05 May 2025 01:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh8LZxiJFaGg5p40O8NiVqScdlZNFvY7sWqkJupwZgXhSRan6xZAOLUfdQMNKvyCR/caarVg==
X-Received: by 2002:a05:600c:5303:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-441c1d5c568mr52179125e9.20.1746434746720; 
 Mon, 05 May 2025 01:45:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a286b9sm125289735e9.28.2025.05.05.01.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 01:45:46 -0700 (PDT)
Message-ID: <a32344c7-85ff-4611-afd0-dac1b3e33497@redhat.com>
Date: Mon, 5 May 2025 10:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] vfio cleanup, pre-cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <1746195760-101443-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1746195760-101443-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/2/25 16:22, Steve Sistare wrote:
> Cleanup a few vfio functions prior to the introduction of CPR.
> 
> These were extracted from
>    https://lore.kernel.org/qemu-devel/1739542467-226739-1-git-send-email-steven.sistare@oracle.com/
> 
> Changes in V3:
>    * update to master
> 
> Steve Sistare (3):
>    vfio/container: ram discard disable helper
>    vfio/container: reform vfio_container_connect cleanup
>    vfio/container: vfio_container_group_add
> 
>   hw/vfio/container.c | 131 +++++++++++++++++++++++++++++-----------------------
>   1 file changed, 73 insertions(+), 58 deletions(-)
> 
> base-commit: 73d29ea2417b58ca55fba1aa468ba38e3607b583
> 


Applied to vfio-next with this change :

  vfio_attach_discard_disable() -> vfio_container_attach_discard_disable()

Thanks,

C.



