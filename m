Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAFFC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvWX-0008JJ-Gn; Wed, 20 Mar 2024 08:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmvWT-0008Gy-K0
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmvWQ-0003Rr-LI
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710939501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M0fKxVqF0QMkNW08p3lEvYY3G+cqCO+f1iYO6r2IrV0=;
 b=AyLzfn39mur4MKy90q8nDu5QVYkzZFDStBiFV1+OB9f87+1ZMhayARHxkoBXSZAWmLwtgz
 0Qvz3nN64SvYhK2Wcz7JR57VHnBkP1ucsYfzAkpUDgKBcJT7zSgj9EG7rbIm3tPd/yB+dp
 SYyNOFOdTzYljJ7bRFSRWIyiQetI7N8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-p_mEZJNaM4evZxKNQ7SLkw-1; Wed, 20 Mar 2024 08:58:20 -0400
X-MC-Unique: p_mEZJNaM4evZxKNQ7SLkw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5158a57abd4so410966e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 05:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710939498; x=1711544298;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0fKxVqF0QMkNW08p3lEvYY3G+cqCO+f1iYO6r2IrV0=;
 b=cu4aDB2cVD/p3PS7ScgjbfW5IbnMblMUnfa/t49jT6XSsVozfuI6U0x2Um7/WVSFRX
 W1NyHqaKibpc9352mGDOdQp8EjMBjEOcHAwH81TqA0f/LqFMbiTLAzmUi7ceodwkMtJy
 5bwlPMSs5ZCY5GVKomMPdWmb7vLCEMoXqfa/7ukOnQZ5T7Wiy9XS5ZuQSOjF38xSOKyE
 1kD8vgYAr71YCXWADii9zg4nKZbC0y36l6qQtk66DuLJKGrIy2RRDhrWcP/SymadwoD/
 wxbcmSDLPuLbaoX3kPsJ49J+ddPgghgeqMqwnzI6cqjvsaZWMHD+XPQKm5IN3asiL0o9
 gsNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd6GYuyTg0gZqKhgzCBx2cutO9uL5dh8/2ljxZxupDhp67nJ/QHpWk52oq8PCvFbNtKUys7t05OvJSAeN5+LMqQ9TEqfU=
X-Gm-Message-State: AOJu0YyzuuQoI5pq2mZ2u1Y4SxP//2Y/DTqp0EzYof+XVXLGp+yq6GlC
 wwn6/D/41yujd9v3T3ayGhwUq2UNSLoenX4A35P3XjHte/Vt6rtI3lzIFEIf20Wp1gEhR9T0WII
 9sD/A+DiXOUNRBnAB7qX+oRmBfTqOwfajHQI76GFbzI8I4buyrG8I
X-Received: by 2002:a19:3804:0:b0:513:ec2a:8fd1 with SMTP id
 f4-20020a193804000000b00513ec2a8fd1mr1442029lfa.47.1710939498521; 
 Wed, 20 Mar 2024 05:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG95Q7DIpkise2QVbD2rcTNPi48IWJPocRUJi0nROGOFQeT50v8Uca8hdiOLHuMG/dWvQLDuQ==
X-Received: by 2002:a19:3804:0:b0:513:ec2a:8fd1 with SMTP id
 f4-20020a193804000000b00513ec2a8fd1mr1441958lfa.47.1710939496167; 
 Wed, 20 Mar 2024 05:58:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:c400:9a2:3872:9372:fbc?
 (p200300cbc709c40009a2387293720fbc.dip0.t-ipconnect.de.
 [2003:cb:c709:c400:9a2:3872:9372:fbc])
 by smtp.gmail.com with ESMTPSA id
 jh2-20020a05600ca08200b00413e63bb140sm2172298wmb.41.2024.03.20.05.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 05:58:15 -0700 (PDT)
Message-ID: <7f8aad63-b14f-4582-a9a7-c14b0d47bbc1@redhat.com>
Date: Wed, 20 Mar 2024 13:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/49] physmem: Introduce
 ram_block_discard_guest_memfd_range()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-12-michael.roth@amd.com>
 <750e7d5c-cc8b-4794-a7ef-b104c28729fa@redhat.com>
 <8498f23d-0e11-46a6-8519-fc3261457ec3@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8498f23d-0e11-46a6-8519-fc3261457ec3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 20.03.24 13:43, Xiaoyao Li wrote:
> On 3/20/2024 5:37 PM, David Hildenbrand wrote:
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
> 
> Michael is using the patch from my TDX-QEMU v5 series[1]. I need to fix it.
> 
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
>>>     next Patch.
>>>
>>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>>
>> I only received 3 patches from this series, and now I am confused:
>> changelog talks about v5 and this is "PATCH v3"
> 
> As above, because the guest_memfd patches in my TDX-QEMU v5[1] were
> directly picked for this series, so the change history says v5. They are
> needed by SEV-SNP as well.

Thanks, I was missing the context without a cover letter. These comments 
here likely should be dropped here.

-- 
Cheers,

David / dhildenb


