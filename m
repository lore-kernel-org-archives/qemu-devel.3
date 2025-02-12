Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F21C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEmy-0001fn-KH; Wed, 12 Feb 2025 10:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tiEmb-0001BL-G3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tiEmX-0005SH-WB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739374566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qeZTUcqqu45O4K6X6NPywDmOXkGQydK6D/wZdGnuJrM=;
 b=DIImid491zl9G/CSI3xt0d2hevHTlpo+12524qdrD86BlS8X9SYCQNcLCa6hhQyPpM9eAY
 qIEaFWp4vJOCAtk8moH6dfNFnHDtTFCvuAGFs47gaAMuAzu3Br/72pYDJgLnoqh+lU03JA
 PJW8rbfwArjt/NdY0ZmLUeIpxLK57UE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-j_5nqe4LOjmAlY5k47jhLw-1; Wed, 12 Feb 2025 10:36:05 -0500
X-MC-Unique: j_5nqe4LOjmAlY5k47jhLw-1
X-Mimecast-MFC-AGG-ID: j_5nqe4LOjmAlY5k47jhLw_1739374564
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394c747c72so12706245e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739374564; x=1739979364;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qeZTUcqqu45O4K6X6NPywDmOXkGQydK6D/wZdGnuJrM=;
 b=lnZA/9qgvbhDOeylh1LUuw20FPk4FfxnFYmNsKGW6PUTWJdSElCwOTGDPju7PiaBcO
 iZy4VlRDqdlSbRZUBopAxK9UnXt7jpVx2s+jeNyvrNniE6KyA8qDnAtPe8Jd7p3Te94X
 By0MO8XXF13aGdD9lEycSMmvaGjm4ZkNgsNdLRlRIFyA07ojWhnW3PyIjGii0DaimzF0
 ikxmt4AiY5rtqnhBXgZDKmRMd10Mgo/p1LqV32t3vOzNIn7rI/m40l36XvK5pUttXTPA
 ND+TbKrtZeGIZd2u/81VZNLFtVEscN4hV+8BSDEhl282Etiv4rCbKkYD4JKnsWn6+Jcu
 1myw==
X-Gm-Message-State: AOJu0YxUZOD0C3du6Xj9/L1svpNRWeycc5fc7sxXx28NZwYrqWgn/m3l
 feI/UJyor8/7xPtes1S/C83rT/YtvG2Dn2J1BVQDpY0xJhryI8+A4yqA9TUW6fSD2sSJKO7PNA6
 sYwNL8xoHkgDVHj4DRw50uPZ6DU0HpOFGvrVzONHBayeMMQFXhb3t
X-Gm-Gg: ASbGncuU4PLq93nWzB25RFXVCwU29yG6lv/J6h083Ds5CE9tsKrfBVpgf0usAG5FP3H
 tZ34XXjrQB773yjt8fb+YdbG6B9ZIfI5enf980FudmxIESNbnzPw4iVVBiF9VOG1qkvVpfMyUel
 MdcM5QEj3LjP2Dx0yTnVArdJrWeNX84u6UKrO1ACMIyi4xS8SadCG0J+CMVi46/x+bGtHAyXj07
 WPH+LjnzmTZzGqSk6FtysKu7w1Uy+CcSmWSne1Z0chYufpPW7S23Ohug8bAzTflbm+HnXgVnpe7
 LMc3NbHr9/RgAK7LHsd2CNwPRL+iGpbL4qxA03XEyKslRRN2JMxxB3Awy5ouueK3YaQZBRizbxZ
 gx3gCe2Lcn1m73drR0OqN37XLLP/EgA==
X-Received: by 2002:a05:600c:1d02:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-43959a919femr28314805e9.24.1739374564245; 
 Wed, 12 Feb 2025 07:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHapqm/TpZMznmnHCg9vDwK4X3zQtENir97D/BJXAPWOUCjLn4/BaRIXE6vjAykjEsOd49OKg==
X-Received: by 2002:a05:600c:1d02:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-43959a919femr28314475e9.24.1739374563763; 
 Wed, 12 Feb 2025 07:36:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:a600:1e3e:c75:d269:867a?
 (p200300cbc70ca6001e3e0c75d269867a.dip0.t-ipconnect.de.
 [2003:cb:c70c:a600:1e3e:c75:d269:867a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439507518dfsm24370205e9.1.2025.02.12.07.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 07:36:02 -0800 (PST)
Message-ID: <5aa66f1f-6e43-4f13-92bc-d4e21afe3a8e@redhat.com>
Date: Wed, 12 Feb 2025 16:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] memory: pass MemTxAttrs to
 memory_access_is_direct()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
References: <20250210084648.33798-1-david@redhat.com>
 <20250210084648.33798-6-david@redhat.com> <Z6y8lHluUzIt75Tg@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z6y8lHluUzIt75Tg@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

On 12.02.25 16:21, Peter Xu wrote:
> On Mon, Feb 10, 2025 at 09:46:46AM +0100, David Hildenbrand wrote:
>> We want to pass another flag that will be stored in MemTxAttrs. So pass
>> MemTxAttrs directly.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   hw/core/loader.c          |  2 +-
>>   hw/remote/vfio-user-obj.c |  2 +-
>>   include/exec/memory.h     |  5 +++--
>>   system/memory_ldst.c.inc  | 18 +++++++++---------
>>   system/physmem.c          | 12 ++++++------
>>   5 files changed, 20 insertions(+), 19 deletions(-)
> 
> This breaks mac builds.. I'll squash:

Hm, maybe not part of ordinary CIs ... or recent changes.

Thanks!

> 
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index aa1455b629..1554f3b801 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -137,7 +137,8 @@ static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
>                                            MEMTXATTRS_UNSPECIFIED);
>   
>       if (!ram_region || ram_region_length < length ||
> -        !memory_access_is_direct(ram_region, !read_only)) {
> +        !memory_access_is_direct(ram_region, !read_only,
> +                                MEMTXATTRS_UNSPECIFIED)) {
>           return NULL;
>       }
> 


-- 
Cheers,

David / dhildenb


