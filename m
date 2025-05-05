Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F695C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrsJ-00086z-CK; Mon, 05 May 2025 05:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrpI-0001dB-Gi
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrp7-0006d2-MO
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g9YW6SncAhjPe/BSryiLIxLEq28YOvj7fr1XNK3h+iI=;
 b=SGBdhm3RRgPEttUs4i3G105SXPe7yz9Q7D2YBAzakuwjBs6MOU/xJYSLHQ4oCldBVB8+m2
 +W9myD7aEClChUzFOsaKVpCodu6wlbgx7xvR7r8GWK4QZUcVGrY953DX7cD9H3cKknld36
 Bvv0XUhu8ILNNlkujyxV0g55DkGHyfU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-zTkij23FMw-SmXfDRdxqPQ-1; Mon, 05 May 2025 05:09:15 -0400
X-MC-Unique: zTkij23FMw-SmXfDRdxqPQ-1
X-Mimecast-MFC-AGG-ID: zTkij23FMw-SmXfDRdxqPQ_1746436154
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d01024089so27169995e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746436154; x=1747040954;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g9YW6SncAhjPe/BSryiLIxLEq28YOvj7fr1XNK3h+iI=;
 b=uzUUmFqKvCtR6ACC6UIKPUH7SHDQdpfVWxrTtBpbbHrP6VyXgGb+qthU5qFeEPr+Cz
 w+V94Lruq6pU8bXgAUB7kSORlVZ60KIP+/0H10NbhkmajeoiIxdbR4c1Df2koUzJsUa/
 RDz2n4C8GoK7DpzpMLcHuETJv61ALt0lWschNFwsLB6dblZjAjDlGKteZ06gBzR9771v
 PvGisYgvYy60PKuNS14p5QpGN/XQNKHVQ7Y37fdLKylI0CtuzWnkGG9fd2sMrfPW+d/C
 pRnE1G3al5N4UzWONfIiMKfPTqh07oo4anztRsxja4yAXT8Z6PIeDjkFxXLpOzuGqfgU
 FAmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWobziyTkqlTlZtXuPxOnT2/yAQKa4XRHArx8bM7hhq3PS+OmRmLmMb6wrFXPHOwCgY4TcqOj7Vwy1@nongnu.org
X-Gm-Message-State: AOJu0YzYPevODCjtcrmCnzWaQrYI1es92kbnPWRULf+s1BGq76U8qC6q
 JIEwXPIZNfjXFcpCMGjz6YYFuWyCaKNLFRMjdUTl+AZ6m2jYftL4W+fzrlT+IoR/3/FJgudcTrP
 QzL3ldCkEtYRmpwuFO0YsrxfxyrpEnValNamqxcjzLv2AAn45ndyZ
X-Gm-Gg: ASbGncuSBgCfeFDF2fCLFcU0gsH+4ylRN1TxS+GCwqAWEIcVuseKqvNbSBel/kz3Ni4
 vZaJVSBTkXrENa03x/215zX17oH1vBArYoBdYSfZEVOdiIf0bKPy3Lyw+jurXzFZg+SqUH5kGXV
 2YEluJSiPUEXMGS8ds3DLz7jXUaugbdgEhDtlBpHKU7BZ8/lOocwndekwuH0JIkNQ45nS8d2MTE
 1F9yTrr4xskQ6NP73zyOWSoyB6svb6zNwtjK4PHt8FNQaeOnNtyEAP1/AayCBHPIqKVZ0T1Zywv
 FN0HIEAHJrZyMU62QzyYuqz1UPpWvwnT3XX+eAjaD4spJg5n/A==
X-Received: by 2002:a05:600c:3b90:b0:43d:762:e0c4 with SMTP id
 5b1f17b1804b1-441c49375a2mr32588225e9.27.1746436154230; 
 Mon, 05 May 2025 02:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+KB4lY58EXqDvWKhfoe2BofT2JR3oP3QsuVkXIbOTViDW7AXfaXjl6B1VaPCHgyj8OnA8eg==
X-Received: by 2002:a05:600c:3b90:b0:43d:762:e0c4 with SMTP id
 5b1f17b1804b1-441c49375a2mr32588025e9.27.1746436153896; 
 Mon, 05 May 2025 02:09:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b28718sm173209085e9.36.2025.05.05.02.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:09:13 -0700 (PDT)
Message-ID: <527d0251-a268-4fbb-ab03-a0796df802e7@redhat.com>
Date: Mon, 5 May 2025 11:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] Report vfio-ap configuration changes
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
 <e35561c9-f104-4be0-8bf4-cae726118028@redhat.com>
 <8c8463d3-a1a2-476d-b9a0-fbbc0cb58c22@linux.ibm.com>
 <80435587-4601-4be7-859a-424b123e4828@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <80435587-4601-4be7-859a-424b123e4828@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 5/1/25 09:40, Cédric Le Goater wrote:
> On 4/30/25 22:55, Rorie Reyes wrote:
>>
>> On 4/28/25 5:29 PM, Cédric Le Goater wrote:
>>> On 4/25/25 07:23, Rorie Reyes wrote:
>>>> Changelog:
>>>> v7:
>>>> - Dropped initial commit for linux-header file vfio.h since I created two new commits
>>>> to address the changes made in v6
>>>> - Moved patches 6 and 7 to the beginning of the series after dropping the first patch
>>>>     - Because I dropped the initial commit for linux-header file vfio.h, I had to add
>>>> VFIO_AP_CFG_CHG_IRQ_INDEX
>>>> - Resyncing latest to v6.15-rc3
>>>> - Still need Thomas Huth's review of v5 changes for patch 6/6
>>>
>>> I checked the build without default devices.
>>>
>>> Applied to vfio-next.
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>> Hey Cedric, are my QEMU patches considered good for this series?
> 
> AFAICT, yes. They are reviewed and they build correctly.

Nope. The windows build fails. See :

   https://gitlab.com/legoater/qemu/-/jobs/9927170034

Please fix in v8.

Thanks,

C.




