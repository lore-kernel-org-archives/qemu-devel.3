Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBE2C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 13:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuAnB-0003cx-AN; Mon, 17 Mar 2025 09:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuAn9-0003cj-6E
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuAn7-0001O3-Mj
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742219165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vuh/zl0Q4DnFoQONO8zVwlQLgWb2gn63pRaa/gtDZUk=;
 b=h4c+8VFModqNXd6H/IMLgQAv7TR964GXcqgVNrP//44mlIY8dIOnidYd8ZV8K1xd7eS2SY
 xi3A0R8pdeRavKtlsf4rf4Ip/GFBe84Qvasrmo7lfhkRRmrhYBdhn9nw8GxS8P1S2AMzOx
 1J1StBMUCnjth59IE/nYZvpAHfEvKhU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-q5SotPDzPheeW9NCe_Ma3A-1; Mon, 17 Mar 2025 09:46:03 -0400
X-MC-Unique: q5SotPDzPheeW9NCe_Ma3A-1
X-Mimecast-MFC-AGG-ID: q5SotPDzPheeW9NCe_Ma3A_1742219162
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so1944626f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 06:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219162; x=1742823962;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vuh/zl0Q4DnFoQONO8zVwlQLgWb2gn63pRaa/gtDZUk=;
 b=t5SVYxLMBmZ9GX+Y3yEPjU1XeJt8ePgMauC7UJefWS7+KEqnbNWufmfXX7zFMggvmv
 kYLBxhj4VedV5x/zu7PfIkdxWJJPGsCC/AkcVxU6yPL6vXqhJNlQ7Cgr/msamlMfQohv
 mllhe/hJEHrfLNmwLHckKfxPFSRyAoC46uP3HgqKM3u5Tuzs2hNS1enuuZ2oHZKom5Hr
 o5B27vsNFBn4IHZiK5qy6jQF64e5jWQF4ubemj1qL4vzEDLhmeuqwQTmLDcxCaL/sZ+v
 mykBB3BV0ULwU+RAOpBatBNgpiA7hEHbwSGSrd0g2UcvTC35e5Lfi+mYhX22tYbdMecG
 Z6Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQthmGTk97wOf7UKFi5KjEqehFQgqMrx9csh3T/PUB0MKMPJqRwptTkUrh1hhyzuVp7N2xu2QguNy7@nongnu.org
X-Gm-Message-State: AOJu0YyuH5OwopwRD+y4FLuCczCxOd9rkBZ7mDqF2l8UqYOS7puXvRl2
 weKYYbolhysUYRFhyAbe+vexxonPYtYmqcUd/imQ+MbMV1HeyxJ4fTrfo2zG9aEiUazymX6cHdR
 edoA1rFIXIjXYwGqLXn0y10xFl9e1kjinXS4BVjgD7yI7foh28ARL
X-Gm-Gg: ASbGncuF34WqS5PmzsbH2XP4qaLXBFYMPc5Fj+g0QP3CZsKYxInnQLefcS4/QiQxmRP
 UJ3aErXuT7b9ooh6f13+OcFTNRoMu/9u9r91S69ibUw5WZU3WnQufbmFhNgVGaJ4efXw68bJ7nX
 riRn+eOBzg4COO+po1KRiCi6uqa6eHhdMeUri/190x/N2tVxsddCHRbFk4hyGYoNtOPX30fvHeR
 aSRDHMr42Gcu5PTNu+hW/6VGxmpe8owybtcytOFXhoRJKikyMXaGrNaef8gI/b8PM0GAkuX9dyW
 aD8T/yq/hsheoXK7z6t5z3n0L0lqpsVTnzqOyHCbBSG7RdM=
X-Received: by 2002:a5d:5986:0:b0:391:43cb:43e6 with SMTP id
 ffacd0b85a97d-3971ffb423fmr14786188f8f.51.1742219162323; 
 Mon, 17 Mar 2025 06:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwoA0pptp46xvB6U8RTMv+jr9oWnw8aGvA+GYzYn4YWeP8FSaZ1LGNLX9kbOXJyKJ14y7FAw==
X-Received: by 2002:a5d:5986:0:b0:391:43cb:43e6 with SMTP id
 ffacd0b85a97d-3971ffb423fmr14786163f8f.51.1742219161970; 
 Mon, 17 Mar 2025 06:46:01 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c82c2690sm14819075f8f.25.2025.03.17.06.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 06:46:01 -0700 (PDT)
Message-ID: <fabf6968-afb9-491f-83d0-b922c2603070@redhat.com>
Date: Mon, 17 Mar 2025 14:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hw/s390x/skeys: Introduce TYPE_DUMP_SKEYS_INTERFACE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Halil Pasic <pasic@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20250310151414.11550-1-philmd@linaro.org>
 <20250310151414.11550-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250310151414.11550-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 10/03/2025 16.14, Philippe Mathieu-Daudé wrote:
> The storage keys are part of the machine memory.
> 
> Introduce the TYPE_DUMP_SKEYS_INTERFACE type,
> allowing machine using storage keys to dump them
> when a DumpSKeysInterface::qmp_dump_skeys() callback
> is provided.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/s390x/storage-keys.h | 15 +++++++++++++++
>   hw/s390x/s390-skeys.c           |  5 +++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


