Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28C1C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 13:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueDBn-0005Rn-US; Tue, 22 Jul 2025 09:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ueDBm-0005PK-Ak
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 09:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ueDBj-00076K-GN
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 09:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753191463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0GBfnik5mBa8Rs8C7lbOymsLodgL5RVKdB0wvyAeKaQ=;
 b=WRLlTaKTB6UfJXtqV2u7wolbYcaE/bsWZwq2WrcMPJhmcolpBBv14blQfU6T0CUqWpdZnF
 6tP54Cq3LeYBseBH2wZDnIzZPMSEZUTrnpMFcwAUiskze+602o/TtkU0Qysm2DBU7oAZIx
 jcjc4jTABcXJRkPvKkH3HeL4yi46p2I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-ugeGBGTyMemSu8VxQN9BNQ-1; Tue, 22 Jul 2025 09:37:42 -0400
X-MC-Unique: ugeGBGTyMemSu8VxQN9BNQ-1
X-Mimecast-MFC-AGG-ID: ugeGBGTyMemSu8VxQN9BNQ_1753191457
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso3676618f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 06:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753191456; x=1753796256;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GBfnik5mBa8Rs8C7lbOymsLodgL5RVKdB0wvyAeKaQ=;
 b=t00Q5uNS7uZC0hSA2+6drK5WhHxCnVuV/5hgT22ydxEs2hmGXccIo4kHdLC/dQazRr
 nUB+9ml9L06X0u967pqr36JLadBMS+h45UzDUlh0QfB7xuB4OtPqUuDDsbFg5KEqJswJ
 Unw2uLR+wf6NYtr6bHUekJGWVNt+6D/AA1i61npYvK++kUEGMsse3GHceh7MnvN1LeBu
 0+cfaOEV572AQueyGow864mVS2iliMg26o+Pyj1pJ60FoFrguldXoqsOud5JWkX2TA/7
 iirMtbNXcrjgXNLW3KNr86iMGpRSNcXRLCOJX/hD8iIsgWqL+7/NgarIjIOM66qBI7UW
 wcVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdiz3cbpTfst31izHH1ioMndcGMau2PFfhg1E6UQFH2+5BZ7oArgLwG7QEDhGH+J3ORMYDwcVqI88o@nongnu.org
X-Gm-Message-State: AOJu0YyX2vTVTOjbF5DUyedtxqF5djlTehjLSXbd4qly70vx6fbIDmq5
 c5yz7BlHx3S5wW/Io524xwMHOs2iGa2vXZ//AA3gy0CSlgig2mOXDbkuXBPEmPCQ1OeohfjWHBK
 BK6Na8t9QqL9RIQDj5rOBIWNcWjOUYNtWCyooGSFosFWRKMVrpRH8g5j8
X-Gm-Gg: ASbGnctwI/y05AaHi1lJuF54HQZxiccf4DKZM+ue8uhdFokLkj692CJpMbxohpsnuti
 QufjwGd3hyhho1lVLabuPa4QCWlwPktMA8nbzFWnWnAaMGU9sZxXMKbczoiJ2cVBvBliEFJpBRp
 7aE7qQ/h0PTQgbE/EDI3DMhNrDcbbA1hZ6SeUvUeDPgxntLPcd30HvgO8hjhri2zQSepwWGoQB+
 i45vDcXc/xe6OTsc0jMLlinVy7S3YvMY/i6lxX4SkZSKpWBibddR4PQ0hQy8FeTB9ZGWugMSza8
 YxzowHjXxlia/4b2E7aU+X3kuo3fJkOvzHFXx+k/+tlg8hmZgoqNeA+09/WO0BjNudl2P+FtuYW
 Czw==
X-Received: by 2002:a05:6000:40ca:b0:3b1:8db7:d1fc with SMTP id
 ffacd0b85a97d-3b60dd4fb92mr21468015f8f.21.1753191456520; 
 Tue, 22 Jul 2025 06:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkEcx4tnOh+qy2rjq9Hgw+lrUshR4mQEogarAmOUzPqhKtaWgvBw2CbIY0kABUWEIObbqAgg==
X-Received: by 2002:a05:6000:40ca:b0:3b1:8db7:d1fc with SMTP id
 ffacd0b85a97d-3b60dd4fb92mr21467986f8f.21.1753191455960; 
 Tue, 22 Jul 2025 06:37:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4d807sm13651817f8f.73.2025.07.22.06.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 06:37:35 -0700 (PDT)
Message-ID: <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
Date: Tue, 22 Jul 2025 15:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/50] ppc queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+ Glenn, Michael, Caleb, Gautam

On 7/22/25 13:44, Michael Tokarev wrote:
> 21.07.2025 19:21, Cédric Le Goater wrote:
> 
>> ----------------------------------------------------------------
>> ppc/xive queue:
>>
>> * Various bug fixes around lost interrupts particularly.
>> * Major group interrupt work, in particular around redistributing
>>    interrupts. Upstream group support is not in a complete or usable
>>    state as it is.
>> * Significant context push/pull improvements, particularly pool and
>>    phys context handling was quite incomplete beyond trivial OPAL
>>    case that pushes at boot.
>> * Improved tracing and checking for unimp and guest error situations.
>> * Various other missing feature support.
> 
> Is there anything in there which should be picked up for
> stable qemu branches?

May be the IBM simulation team can say ?
I think this would also require some testing before applying.

Which stable branch are you targeting ? 7.2 to 10.0 ?


Thanks,

C.
  


