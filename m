Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7657FC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwrc-00046G-C2; Tue, 25 Mar 2025 01:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twwrb-000466-F0
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 01:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twwrY-0001K9-Qj
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 01:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742880605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bYlxFuWV7pDVJWezFSva/6+FcSgxHD/Te5BvRTTcELU=;
 b=K11ePKdzYma2eQ9y5b4q4SjRik3YRZnruV98dHZvvuug//JmDxHXJA3kFVuAUO7s/eAfwx
 ArhYayDxWX427nVFDgpRGjPR85D/ekA+7mIxuURBRBi+F2PGDZxM/MpuY080Tdrh4dzpFq
 TeQQE0nkmcGui/enrZluIAa8mfIyqaI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-MHFbZ6TuPlGP4Dqo3UU_Rg-1; Tue, 25 Mar 2025 01:30:02 -0400
X-MC-Unique: MHFbZ6TuPlGP4Dqo3UU_Rg-1
X-Mimecast-MFC-AGG-ID: MHFbZ6TuPlGP4Dqo3UU_Rg_1742880601
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac384a889easo556394666b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 22:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742880601; x=1743485401;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bYlxFuWV7pDVJWezFSva/6+FcSgxHD/Te5BvRTTcELU=;
 b=rAnZGoTFITNw2Qr7/5s7rQ4PdSByrvA3/kK1n1FtPfpBCC6OZ6DPe3Ep1kNJRv3FAY
 P9j/gziBzs6+OvJDhS+/PR99LkMrkUqJM2hxcacKS59tmU8x1IjQnQC0pBNoQxlcDaUL
 cBowdBzF4oPlx0azHQqjlKI6bILEOqKQe32rm94ObqL39JflCONQZFfWnCiIzmhgGlmQ
 1ucSAFMuc2ouMWYvVouozwpfsWNofnNzPh1zwIVbOs9Jy+nJlsa1jzdENAgZ2V+epSQS
 M08LyfFZTYKng4U/Blyd0PgIz7tqQPxusXFHcMKSWTDXAeqlEaoYz/FnqicBCTDZjigp
 cZKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs7MG1omaOAldVmzKRZHkOGrJf71ZugmYmGzKDCqQ9ALvMkSABpEGjuNslSnYjiO7EUi6dmNhEtInx@nongnu.org
X-Gm-Message-State: AOJu0YzvLskZ6jXsi0s4G7qjEpFo1E4fc5EetpoYYoBcn/3D/hREr3Uq
 EMrlKe4yHLzlNMrj6xhDrWDou1QCLfe7J/W0wUh6KAslIJuMPZdHByDVvn+xAspyfbM9xEu+fBY
 4+JP4ATEW1LR3e82dgAyn9G7ARWMglmsYFBCrBwGnOKjC8KPI7lqM
X-Gm-Gg: ASbGnctTWam6izq/8WvcFzrOM70ViYQQc16VFHImUO8gexVJ3C6CQWy/AF3lQJaENv3
 dSvpPcTD4XTcGGmUCI+hivCIsTGAsfhU0A5Yo4gZU+Y8LNAIhexbxUydqJDY2SPnzCK789YLT3w
 v/Q/m4f/d4ipKzEdrfU/tnmj1fSDSUAbzesR80XVE093AyOahUPAtWDV/hoKwv4ldhDisSbWShu
 2+Az6M488IqBH59fGie7Pe2ADlC0RkGzqioZCwDrNbWWNFZrQFwvatTQsqL9wAnB0wVJQwq4KMW
 h0C22WLonTt+osr2ZVqwj7iQ93yWzi6RGYNDYfhj5Mh4
X-Received: by 2002:a17:907:c23:b0:ac1:edc5:d73b with SMTP id
 a640c23a62f3a-ac3cdb96185mr1834969466b.8.1742880600721; 
 Mon, 24 Mar 2025 22:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyHLn2RslQ1fzVhvhxuk5Co1sXMcxcIYFAI/axP/YY6Ukz6TTUinRvNu9v4vlnTr76Mfr9Jg==
X-Received: by 2002:a17:907:c23:b0:ac1:edc5:d73b with SMTP id
 a640c23a62f3a-ac3cdb96185mr1834967366b.8.1742880600250; 
 Mon, 24 Mar 2025 22:30:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-54.web.vodafone.de. [109.42.49.54])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd95122sm792534466b.177.2025.03.24.22.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 22:29:59 -0700 (PDT)
Message-ID: <cb0f437d-c050-46e6-a436-49281f8a92c9@redhat.com>
Date: Tue, 25 Mar 2025 06:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] target/s390x: Register CPUClass:list_cpus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-7-philmd@linaro.org>
 <fb9e488b-b6c4-4270-aeaf-d5bbffa942c4@linaro.org>
 <793cf6ca-3aaa-4aad-a625-43f21feca6ef@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <793cf6ca-3aaa-4aad-a625-43f21feca6ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 24/03/2025 20.04, Philippe Mathieu-Daudé wrote:
> On 24/3/25 20:02, Richard Henderson wrote:
>> On 3/24/25 11:58, Philippe Mathieu-Daudé wrote:
>>> Register s390_cpu_list() as CPUClass:list_cpus callback
>>> and remove the cpu_list definition.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/s390x/cpu.h | 3 ---
>>>   target/s390x/cpu.c | 1 +
>>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> I really think this has to be merged with the previous.
>> I strongly suspect that it either doesn't compile separately,
>> or doesn't function as desired.
> 
> It does compile, because "cpu.h" includes "cpu_models.h".
> 
> I don't mind squashing if Thomas is OK.

I don't mind either way!

Reviewed-by: Thomas Huth <thuth@redhat.com>


