Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D4AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2BN-00089b-F6; Wed, 20 Mar 2024 16:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rn2BK-00089F-Vy
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rn2BJ-0004bD-4f
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710965099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=012LzPJqZ7pcVFoiA92zIi0nHnXpZdtZrOPdZIgp9fg=;
 b=bGt2DppwaBmzPmoB94bID6bJxHFysC+PAx+ue53LtHLt5usSaCpwhpKw25h+N8lVZjNhYr
 9JGAkS1p5jmPNrp7NaDyw7aQjpitkw3Oa3d9/l2UXXRMm+3944ZcoxCoF5zPEdfRHdx0um
 cU3pDCzWsKFzPw1sZOUeBRm+ixNTRJM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-V9aSoalFNx2mZBCveUnh5A-1; Wed, 20 Mar 2024 16:04:56 -0400
X-MC-Unique: V9aSoalFNx2mZBCveUnh5A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41405226279so1220755e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 13:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710965095; x=1711569895;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=012LzPJqZ7pcVFoiA92zIi0nHnXpZdtZrOPdZIgp9fg=;
 b=LdKr0LzNfzxBrxfFza1rgkA01r46k2rj+Z+7jEXNAUN1/lFc4MmoyO1FhaiLF2GfOn
 Nru/mTLzS/aSrEgvpeSNPyC9erucz0mLyHrQb9rIlQOW7CJjUngXxYI3Jdt8tefsZFo0
 Z1spaqzzXgPyMHiHrFHQwCW7BByuMQ2IiUMKdObpXfFrq/1pMwt4Td/npgIeTe7sjvrj
 1Vbu+zIwdrUuYaJDsb6gRsm1wPhGdMArRbyvymDSJU9DbZ7GjHEDPwkk8YV0hgBNEn+V
 1f6rgdxruBSm4W28nmpHVjueWZ6stCXt9gUhViy14flXIIwXUAW/+WoSqN6V8FGTFmUf
 191Q==
X-Gm-Message-State: AOJu0YyHycYvxD5ditPKpQ7IAwsQToVF1WFL3XtPn6+uF1QqBWzw9mZk
 eAH27r5SLnJ/KOr2Y/yyY7wqJSopmHtXh7l4iFm+mbifCWw2LcB53NmJGwSc3ti69vPD3n1900H
 ZpxfZYzYhQFqtOPqIOkeqt4TffQa073fyA3D6D4j+TlIDSNeNLL0E
X-Received: by 2002:a05:600c:46cd:b0:412:f015:6fa6 with SMTP id
 q13-20020a05600c46cd00b00412f0156fa6mr5308414wmo.28.1710965094764; 
 Wed, 20 Mar 2024 13:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7phc8DqkQGsYqmpZpN1TJx58GypLGtl9t9SwS8/rTvEfh1EfGfwdMOiUYisd5DBWxmU5lNA==
X-Received: by 2002:a05:600c:46cd:b0:412:f015:6fa6 with SMTP id
 q13-20020a05600c46cd00b00412f0156fa6mr5308394wmo.28.1710965094347; 
 Wed, 20 Mar 2024 13:04:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:c400:9a2:3872:9372:fbc?
 (p200300cbc709c40009a2387293720fbc.dip0.t-ipconnect.de.
 [2003:cb:c709:c400:9a2:3872:9372:fbc])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c468b00b004133365bbc6sm3204459wmo.19.2024.03.20.13.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 13:04:53 -0700 (PDT)
Message-ID: <48cafaf1-83df-40f3-905a-472cb5f9256e@redhat.com>
Date: Wed, 20 Mar 2024 21:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/49] physmem: Introduce
 ram_block_discard_guest_memfd_range()
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-12-michael.roth@amd.com>
 <750e7d5c-cc8b-4794-a7ef-b104c28729fa@redhat.com>
 <20240320173802.bygfnr3ppltkoiq4@amd.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240320173802.bygfnr3ppltkoiq4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

On 20.03.24 18:38, Michael Roth wrote:
> On Wed, Mar 20, 2024 at 10:37:14AM +0100, David Hildenbrand wrote:
>> On 20.03.24 09:39, Michael Roth wrote:
>>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>>
>>> When memory page is converted from private to shared, the original
>>> private memory is back'ed by guest_memfd. Introduce
>>> ram_block_discard_guest_memfd_range() for discarding memory in
>>> guest_memfd.
>>>
>>> Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> "Co-developed-by"
>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
>> Your SOB should go here.
>>
>>> ---
>>> Changes in v5:
>>> - Collect Reviewed-by from David;
>>>
>>> Changes in in v4:
>>> - Drop ram_block_convert_range() and open code its implementation in the
>>>     next Patch.
>>>
>>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>>
>> I only received 3 patches from this series, and now I am confused: changelog
>> talks about v5 and this is "PATCH v3"
>>
>> Please make sure to send at least the cover letter along (I might not need
>> the other 46 patches :D ).
> 
> Sorry for the confusion, you got auto-Cc'd by git, which is good, but
> not sure there's a good way to make sure everyone gets a copy of the
> cover letter. I could see how it would help useful to potential
> reviewers though. I'll try to come up with a script for it and take that
> approach in the future.

A script shared with me in the past to achieve that in most cases:

$ cat cc-cmd.sh
#!/bin/bash

if [[ $1 == *gitsendemail.msg* || $1 == *cover-letter* ]]; then
         grep ': .* <.*@.*>' -h *.patch | sed 's/^.*: //' | sort | uniq
fi


And attach to "git send-email ... *.patch": --cc-cmd=./cc-cmd.sh

-- 
Cheers,

David / dhildenb


