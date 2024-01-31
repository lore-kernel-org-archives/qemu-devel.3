Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEB8C48285
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 18:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVFEp-0002B5-UF; Wed, 31 Jan 2024 13:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rVFEo-0002Am-CQ
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rVFEm-0000fO-QT
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706725383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sDQ0yzMF/HrDShmPKAZIfOiqbAfoG8ZxqpcFIkOi1jQ=;
 b=ihe+s1iM3IAFlR7DOcuHLSn+BWjed8zNELmOYfSrJ+V7QxwjNl26sJQ8CS6sQXRguEkLpU
 n2wwhrai9ApRNcXgP2Cpu9TI/FioOHJ9wn/FRCG+Xj4JFehHyWWrk/ga+vVh7g2jwJXb6w
 Fr1OAR1xNgF3GAdsLNbaSSjAD9tM2/8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-vtwoH_NyO2mZ5jUUX6Xdwg-1; Wed, 31 Jan 2024 13:23:01 -0500
X-MC-Unique: vtwoH_NyO2mZ5jUUX6Xdwg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5110fdc81e0so8206e87.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 10:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706725380; x=1707330180;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDQ0yzMF/HrDShmPKAZIfOiqbAfoG8ZxqpcFIkOi1jQ=;
 b=i2iRuPhrgjeAMZpEwlCsV/ARiZ9eiLnoqtygb8xeNpi0xrWhSQVSK4CjHsP7pJrmnX
 nKcXjrS9XHPdzL5WgCXyLuEfHUpk9LiAOfnEhwDYbrfQqpGT1EkFTb7KwrrUEt8aMB6F
 tLzThoIM/jd0vJ+mH/KYM5+5GDF9xX/HppM8EVTJI7Daj+m+VwlG2LPXaP81iDTV2/Mq
 J2jQu0oue/24ixGIppnFfHmKSEm8nRPo1EUfh6epZbIEv+ZHJ25r/naBxjIT3O70uJ9d
 1w2uzVk7H9hYUorkUiuNmXSQ+sTaG+HXHN0E+jGc+Ubcqvw/rp3KE94ZwUhvclj2qPdR
 tNIw==
X-Gm-Message-State: AOJu0YxHLctEeOwIdDDGHAOS/V2q/HAxEeGykmlRKPeOucZA9IHm+Hie
 EvRBlBfsYrPnMJ5vSSwXOxCxn3IzyQtMgFfSCbfkxF0MAhEvoPKyaSnxeHNdE89aSPwqhOS8c+P
 iZu/PRvz4uKkTPb7OU1OaEXxuCIASdQ0QC2ZPjdp4YKhvqEYjxPUu
X-Received: by 2002:a05:6512:3590:b0:50e:ca86:658a with SMTP id
 m16-20020a056512359000b0050eca86658amr221493lfr.45.1706725380017; 
 Wed, 31 Jan 2024 10:23:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaK9jwRglidl8ZhFSsUcIBlKhdhs7+mb0lVPvrdfznZ/4PRLw5c3v9gUdSVoP2uzPCfzgO3Q==
X-Received: by 2002:a05:6512:3590:b0:50e:ca86:658a with SMTP id
 m16-20020a056512359000b0050eca86658amr221401lfr.45.1706725377589; 
 Wed, 31 Jan 2024 10:22:57 -0800 (PST)
Received: from [192.168.3.108] (p5b0c64a0.dip0.t-ipconnect.de. [91.12.100.160])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a7bc8c6000000b0040e621feca9sm2221478wml.17.2024.01.31.10.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 10:22:57 -0800 (PST)
Message-ID: <243002e8-7647-4638-98a4-520edf52802a@redhat.com>
Date: Wed, 31 Jan 2024 19:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] oslib-posix: initialize backend memory objects in
 parallel
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240131165327.3154970-1-mark.kanda@oracle.com>
 <20240131165327.3154970-2-mark.kanda@oracle.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240131165327.3154970-2-mark.kanda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31.01.24 17:53, Mark Kanda wrote:
> QEMU initializes preallocated backend memory as the objects are parsed from
> the command line. This is not optimal in some cases (e.g. memory spanning
> multiple NUMA nodes) because the memory objects are initialized in series.
> 
> Allow the initialization to occur in parallel (asynchronously). In order to
> ensure optimal thread placement, asynchronous initialization requires prealloc
> context threads to be in use.
> 
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

So, this LGTM. There might be ways to not rely on phases to achieve what 
we want to achieve (e.g., let the machine set an internal property on 
memory backends we create from the cmdline), but this should do as well.

I'll wait a bit for more feedback. If there is none, I'll route this 
through my tree (after doing a quick sanity test).

Thanks!

-- 
Cheers,

David / dhildenb


