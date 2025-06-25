Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BFDC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 09:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUMTr-0004Sa-D3; Wed, 25 Jun 2025 05:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUMTo-0004RK-JB
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUMTm-0003Id-VX
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750843901;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4kb+ErCz0mhW0bKU7GDl25eFlTih4IPbtlUUppkujA=;
 b=NiKbfKUIeJRzAYJBgAjIEYxr9QRhN6pXSBL0QWjjhKYgNJA/ViQbZ/GV1OgC55dAij2PFV
 ZJ+mqDdASV1EEYmSOBoN88776b5+eGZdfjoeD07BK+xLOaW9M20gMPuQCRg2Dj4E4f1tte
 XLeUQnUaSd8lIEQMD9o2NrIppGsnrbM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-qx9JupMHPKOD96hENbAeSg-1; Wed, 25 Jun 2025 05:31:39 -0400
X-MC-Unique: qx9JupMHPKOD96hENbAeSg-1
X-Mimecast-MFC-AGG-ID: qx9JupMHPKOD96hENbAeSg_1750843898
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso3426175e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 02:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750843898; x=1751448698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4kb+ErCz0mhW0bKU7GDl25eFlTih4IPbtlUUppkujA=;
 b=ZBPAz97gTFDdLpC0KeD9dHrjI1Sd0ejv2XkyxburUq4LhJ4fxn+tDatjkK4KiX9tvB
 iQwyxZYH2fO3cUMdgY6aPlp7ErzBAgOXUvACugAVJE6vai2A+p+2lBBZ8YY7jdvcb+oL
 TDK+HJdbdVqEhUPKunAgAnea24LmLGiVciqVbu/LgiuTI2Zpzz+0bbzyTcPTzXEga5aX
 iU3JujtPENq3ogbmb+ua6xSmRrJE6oPtLT6IczqdyDHV3YoPyP0lKqiUceN/Dn/KOoeA
 xXEDOyStfmVGIRmtZEfU3lOqZewU2MCJVh49zpgD0ErNn6S8+FR2wbWxH2aDpZAVfLyM
 xF5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2UzQyZwo8lToGP2yH+s9L8ZJz8p9ZHLTVpp89y/1Boi4EsgiS53cR6MSPeiW4ALehQC88Qre6J+HR@nongnu.org
X-Gm-Message-State: AOJu0YxMqq3tobqZjKSdriYJnbkGl0BNtRJIQCodkaez02POb3yaSWXT
 ip6qphCCRt2RpxFu4/RSD+XwaTptrCnbeeA5dJxkMWBhIlMQQdb04bmsIZTYEwBPbLThsMsWSHB
 m98OwkSft3X4fUP9pY+ooR/CTadNuxHhA9D45YAi7Tbq32NCB0reOWU3I
X-Gm-Gg: ASbGncuhvgKv2QT8HkVsI87ZaASwQLkTYHMRvjKtiwrzs7nC/BkNHTMChm0kkKgMmvk
 +/djFkhx4lTned7KKeVgv1WXIZN30Zu220kuelyC76HTrT/n3Iz8rtjaMopv1jUnNvOY8TTEEPL
 lJ1P7WBOx32WzOfEYzcxcCuWOxS2ToA1rp3oZ6QALjAd8q2WM/urUapTiXG58eeCVqUu8sHKGNn
 hwwjf7gM0rfrxgb7fVAa9xrJZndfcsNr8PQFHGp+pXLSIqdJMRr8QNelU/QxjjRgJLfvTI+Sdqc
 KNkTkokh3FFNmmtcl6gdD991M+SuEQM7mrt994UO6wmZiTaXWg/N+uB/Jc09sljT8qg8Zg==
X-Received: by 2002:a05:600d:108:10b0:453:79cb:7c86 with SMTP id
 5b1f17b1804b1-4537b722e5cmr41194865e9.3.1750843898169; 
 Wed, 25 Jun 2025 02:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXitgn9o5HGaBbsL83/BsZlB9vIxZ2oB5zHbv3/LG2dAPZPrsPMW3HFNeDWIB+0JpmJcK0Q==
X-Received: by 2002:a05:600d:108:10b0:453:79cb:7c86 with SMTP id
 5b1f17b1804b1-4537b722e5cmr41194605e9.3.1750843897660; 
 Wed, 25 Jun 2025 02:31:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538236694esm14290065e9.28.2025.06.25.02.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 02:31:36 -0700 (PDT)
Message-ID: <3bf1b8eb-4ce2-4d33-9aa0-9c9f4c1afa17@redhat.com>
Date: Wed, 25 Jun 2025 11:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/14] arm/cpu: Add sysreg generation scripts
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, agraf@csgraf.de,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250617153931.1330449-1-cohuck@redhat.com>
 <20250617153931.1330449-13-cohuck@redhat.com> <87h60e1ies.fsf@redhat.com>
 <de402ecb-8d45-4e42-a805-cd3aaef8dc93@redhat.com>
 <aFvAEXWi7PUbVAud@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aFvAEXWi7PUbVAud@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

On 6/25/25 11:23 AM, Daniel P. Berrangé wrote:
> On Wed, Jun 25, 2025 at 11:16:22AM +0200, Eric Auger wrote:
>> Hi Connie,
>>
>> On 6/17/25 5:45 PM, Cornelia Huck wrote:
>>> On Tue, Jun 17 2025, Cornelia Huck <cohuck@redhat.com> wrote:
>>>
>>>> diff --git a/scripts/arm-gen-cpu-sysregs-header.awk b/scripts/arm-gen-cpu-sysregs-header.awk
>>>> new file mode 100755
>>>> index 000000000000..f92bbbafa727
>>>> --- /dev/null
>>>> +++ b/scripts/arm-gen-cpu-sysregs-header.awk
>>>> @@ -0,0 +1,37 @@
>>>> +#!/bin/awk -f
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +# arm-gen-cpu-sysregs-header.awk: arm64 sysreg header include generator
>>>> +#
>>>> +# Usage: awk -f arm-gen-cpu-sysregs-header.awk $LINUX_PATH/arch/arm64/tools/sysreg
>>>> +
>>>> +BEGIN {
>>>> +    print "/* SPDX-License-Identifier: GPL-2.0-or-later */"
>>> FWIW, checkpatch.pl chokes on this:
>>>
>>> ^* matches null string many times in regex; marked by <-- HERE in m/^* <-- HERE /"$/ at scripts/checkpatch.pl line 1389.
>>> ERROR: Saw unacceptable licenses '*/"', valid choices for QEMU are:
>>> GPL-2.0-or-later
>>> GPL-2.0-only
>>> LGPL-2.1-only
>>> LGPL-2.1-or-later
>>> BSD-2-Clause
>>> BSD-3-Clause
>>> MIT
>>> total: 1 errors, 0 warnings, 76 lines checked
>> so don't we need to improve checkpatch.pl to silence this error?
> Its regex gets confused by the trailing " after the comment end. We
> could fix it, but ignoring the error is also valid as this is a
> highly unusual file that's not likely to be common through our
> source tree.
Makes sense. We are good then.

Thanks!

Eric
>
>
> With regards,
> Daniel


