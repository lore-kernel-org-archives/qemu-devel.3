Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E201C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsOA-0006Md-DY; Wed, 20 Mar 2024 05:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmsO8-0006ML-Sa
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmsNs-0005JA-BF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710927439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cXZV6rEbMyzNQrvbML6Ca+872q9ui7Bn+y/au3eyJA4=;
 b=JrSnTa8pp+pvwS8mQvWAaK7ERYy3fXXaEH6nHL6UBriqiwq8L5kMEroG4EtFllzCPKwLHm
 47iFeIai5h2dyAxmDlGg9PT2iEWzQlVsabHMMyrBwAOgafQJQvu+Y6M9Up+VMLNSXQMfpT
 CB1yA1esooSjjnEdrrF/4RVs2jg0WiM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-CWsM7bo6NNehDIefA8zOjw-1; Wed, 20 Mar 2024 05:37:17 -0400
X-MC-Unique: CWsM7bo6NNehDIefA8zOjw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513dda67cbeso3767369e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710927436; x=1711532236;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXZV6rEbMyzNQrvbML6Ca+872q9ui7Bn+y/au3eyJA4=;
 b=hnHZarHVc0EssZaTnuBpXuA9mxjOoJpKq0NfEMxR8omO9yQ8ehv/zbpvjrUHDIF9pT
 4Y4kujOIcBfb8tZaScNaIJak8v+UljkIF9fLosw9bnqHJ2sFvhlBXzlR8t+rUsmiUSm5
 sqkOrPCFLdtHPmxBkD/GNrIRfQJUklTARaKGWrBGier6JsLs2UfVvsbBOZgsk8fnME7D
 GQQ3rcMiGjtvlTKByswTuW1OffzC+3XwN3i6GrsXRdKbXa/blDVS4vL7gMv6wzb3pC9m
 cHX+bYIjbQQJMmDi8GX4aUj/u6dD2lRh953AQD/IGBpmo9gWvm2NHvFXjsDeaWZ812Bk
 OC7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfdYKJb9erhELTHsPhTwjie+saSdoDIn+VYvBbQZtHUXMmwyMhOWrdKPQNnAm9jaG4XLd10iZ3tkqSIf1+hp9E8vG/WIM=
X-Gm-Message-State: AOJu0Yyif7z6qbaFpcjAymkrUjG4dccxlPxZpB4ImNOsth+uMlifloUO
 2WkEc73NYeT8ODZQgJjrKf0OW2VOkE1wnaMo9iCbdzFwBVaU8QUBM11WAsk4ognm91a5+KhXXka
 ituuz60cfgEpTO5a5iiYfF701bSIPXAYjQiIYllkUFf+XCYCUZm8G
X-Received: by 2002:a19:3850:0:b0:513:1946:a771 with SMTP id
 d16-20020a193850000000b005131946a771mr12650329lfj.44.1710927436027; 
 Wed, 20 Mar 2024 02:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+KdpzZ1/8Z7wI4wJem/qrSLfe7KVPRuTvaPPfUZOLirdxW4UVV39YLSqnNJuQw6I2PrAbvw==
X-Received: by 2002:a19:3850:0:b0:513:1946:a771 with SMTP id
 d16-20020a193850000000b005131946a771mr12650306lfj.44.1710927435481; 
 Wed, 20 Mar 2024 02:37:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:c400:9a2:3872:9372:fbc?
 (p200300cbc709c40009a2387293720fbc.dip0.t-ipconnect.de.
 [2003:cb:c709:c400:9a2:3872:9372:fbc])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a05600c4e0200b004140837a0d4sm1647261wmq.3.2024.03.20.02.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 02:37:15 -0700 (PDT)
Message-ID: <750e7d5c-cc8b-4794-a7ef-b104c28729fa@redhat.com>
Date: Wed, 20 Mar 2024 10:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/49] physmem: Introduce
 ram_block_discard_guest_memfd_range()
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-12-michael.roth@amd.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240320083945.991426-12-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 20.03.24 09:39, Michael Roth wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> When memory page is converted from private to shared, the original
> private memory is back'ed by guest_memfd. Introduce
> ram_block_discard_guest_memfd_range() for discarding memory in
> guest_memfd.
> 
> Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>

"Co-developed-by"

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Your SOB should go here.

> ---
> Changes in v5:
> - Collect Reviewed-by from David;
> 
> Changes in in v4:
> - Drop ram_block_convert_range() and open code its implementation in the
>    next Patch.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>

I only received 3 patches from this series, and now I am confused: 
changelog talks about v5 and this is "PATCH v3"

Please make sure to send at least the cover letter along (I might not 
need the other 46 patches :D ).

-- 
Cheers,

David / dhildenb


