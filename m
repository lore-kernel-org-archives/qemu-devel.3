Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A38C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 16:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2YKG-00058x-6J; Wed, 09 Apr 2025 12:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u2YKE-00058S-Jg; Wed, 09 Apr 2025 12:30:54 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u2YKC-0007Ti-Pm; Wed, 09 Apr 2025 12:30:54 -0400
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso7038940a12.2; 
 Wed, 09 Apr 2025 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744216251; x=1744821051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4woJl9tIpPlD5YThDMG0uDydQ1uuOTwX/x7PyZNEr7Q=;
 b=N8x/6Xjl85NcUEJIgp91eeQyPsMJ1iVK19gqNhengkXi7+6VLsjIpsDXlLgdbUSm8W
 oG8ZJkkJ5njeqqfIf6UPtAmrCcOHhtAdbAgawrztkr7Ol5CpjZqqlatrJ8+BPXPCWXkV
 k6M4UaVuMAQSWIeQQbnmLJ1FgpjckJ3AmrWbiEayNxk1hf181thCg61mHk6/flalSoeb
 x91BKChO3MVrFCn1wZctPWfoIaruaprvGNdE1zOGgy0zrnq7TyyvKS4b7G4Krrg/zl5Q
 5THNo3Q28MVhMbVSqNOd1YZFyEI1GvvDAnNHMsrj8J+GHOnW0oUipr0XOo1I1uv3YzV6
 51gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744216251; x=1744821051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4woJl9tIpPlD5YThDMG0uDydQ1uuOTwX/x7PyZNEr7Q=;
 b=rIBAzsJzGfdIANMgQv/E/zUyzczqrAae+BxhLAgKyZLdG5IJjLLV4ZlRgT7X8W2Ntw
 +uQ5FTsj9JVfMotug861uyurkYS0VBrUKLOeNdHevWqmC+MmruxTQk1WOHEdK4Famw9G
 +gWT1k+0qEKaGODuF0nrmzNfG5ibRZ5NSR2QQki4GcapVoZttHMynBV/unbhXroZVzhY
 hfg3FKVKtcXQTPoVdgN+Io9kQ6/2uLogj/S/A3DBRpjeTLch7gH7nFVseYhJ2WGBvyLt
 N4NAxqgpWOlgQWYsrFb+X1b1iC7xKhggcCNc0wtOxKffqPfbImam3c0BLykaLVNiV8Ii
 uF1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsDv00XOMNdCet+hW5KsaXCASNWLlsmgWY1yNuMY6Iwu/M1OI2KMz2Rkvvth2vKmXxbYgTpbY8pPcU@nongnu.org
X-Gm-Message-State: AOJu0YxQSk0LJE8NHATZtMlON/lT1wK79jWeafpGkDas9nEwcf646xKF
 IZID8i4BBbIPg52XRX1MIPBPdcOnF5os1E63QIZRRe8wJc28lq0=
X-Gm-Gg: ASbGncvrMJeh3elixRa9WA59ZXxnMoTFELlvCaX/ZNMNDswfBdp1iAmkd0ZAf33v3DQ
 l3jwTDb0q8v7zTrkwS8m5Ya4RFkVWt3kpD8DouoLmORIxZPqiD2RvNIT+suQZqjpUxIdnoJdrgE
 w1cfkPb53FG1bZM52xUZfYRQF0skDyFAjFaHuFmev6jIYP5z5dWBdLqHY33Nf8FNeDpzd2eWdSJ
 QDngf39PSXG+pTDq0dACG3ECBokt5EnkvtP966+vSW8xkppqT16d7FopBke/6ObNfN54ugOWyZP
 RBgkQwFeQnsz119Ofv8G1L8slxe0yn8oDHpG2WHz9u8wOQ==
X-Google-Smtp-Source: AGHT+IFNwVZ4canVCURKgsWm1V2HIS57xtX6EpStGV+xQY4piVQgrzAXrtllGIA7HjfrTsYbgAjaEg==
X-Received: by 2002:a05:6a21:31c8:b0:1f5:837b:1868 with SMTP id
 adf61e73a8af0-2015afe0c2bmr4924882637.29.1744216250520; 
 Wed, 09 Apr 2025 09:30:50 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.72])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a2d3aa63sm1264599a12.50.2025.04.09.09.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 09:30:49 -0700 (PDT)
Message-ID: <a76453a8-c35d-46f9-b0b4-4fe35a5153ba@gmail.com>
Date: Thu, 10 Apr 2025 00:30:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] vfio: add vfio_pci_config_space_read/write()
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-12-john.levon@nutanix.com>
 <ed4d5a1e-61dc-4041-a24d-c1a0bd49fa3e@gmail.com> <Z/aYPiAhqSaIrc/u@lent>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <Z/aYPiAhqSaIrc/u@lent>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x543.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/25 23:54, John Levon wrote:
> On Wed, Apr 09, 2025 at 11:51:09PM +0800, Tomita Moeko wrote:
> 
>> On 4/9/25 21:48, John Levon wrote:
>>> Add these helpers that access config space and return an -errno style
>>> return.
>>>
>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>> ---
>>>  hw/vfio/pci.c | 134 ++++++++++++++++++++++++++++++++++----------------
>>>  1 file changed, 91 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index ddeee33aa9..c3842d2f8d 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -964,6 +964,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>>>      }
>>>  }
>>>  
>>> +/* "Raw" read of underlying config space. */
>>> +static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
>>> +                                      uint32_t size, void *data)
>>
>> Returning ssize_t here might be better here to avoid casting issues,
>> though we would never read/write something exceeds INT32_MAX.
> 
> I considered this (and the later helpers in the patch), but most of the existing
> code already uses int. Happy to look at fixing the callers too (e.g.
> vfio_msi_setup()) if that's everyone's preference.
> 
> regards
> john

I checked the code, caller casts return of pread/pwrite to int because
the `count` argument, bytes read/write at most, they passed does not
exceed int. Given that uint32_t can exceed int, returning ssize_t here
and let callers to determine cast or not is better I believe.

Thanks,
Moeko

