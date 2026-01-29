Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9E2D358F1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 10:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlP5W-0004El-KB; Thu, 29 Jan 2026 05:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vlP5R-0004Bu-H3
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:17:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vlP5P-0005tB-M3
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769681833;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYEmg3LvTBmPuKe0W3PpoOqpLHQf8aCkTDSuccqSycQ=;
 b=JF/JDzHs2PYjsVgOK19LdTzcAxvehKor3G9fAVYi+v9qzI0vAU2Ej0mUomrcu9n4wDrwM/
 p2xf0n4WwplFoIevUHJlLFZThc4HB1he1XrMYfrwD46N2v4KKPnC7FrAiwdm0UAgFfT22j
 y3uRJCFPNHILOkR/+xN6pRAtwwJiy74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-65Q-BdK4OMqnQbK3ugqJ4A-1; Thu, 29 Jan 2026 05:17:12 -0500
X-MC-Unique: 65Q-BdK4OMqnQbK3ugqJ4A-1
X-Mimecast-MFC-AGG-ID: 65Q-BdK4OMqnQbK3ugqJ4A_1769681831
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4325b81081aso1492630f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 02:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769681831; x=1770286631;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYEmg3LvTBmPuKe0W3PpoOqpLHQf8aCkTDSuccqSycQ=;
 b=HxVc1J4biqFbyD4mNXJjGwQB63Rgugno1H2mSokDPM5+6JEs736DyyDWPMkkIX7Iy8
 mjlBiMOpj7ZrLpoVin6ztbYdrRuU1c2nNUyvve7TQ5mTHlQIiSX64TMfIfJhtR24YSjN
 IF6LvNwFbM/y1PQKC8GzIntHhy//udbit3ALRazoYVj+9WQdaRkO6ODH9WZd6sgoZ08p
 7oBGP6QvOgCSayeYb5deeQB3xHYQ/iVlNOYSNVw/Zbtr7mwj8+M/JDYKV2PQLIBPQ+hE
 Ru+kXvk+aZGJ8i3pqjkZRpz1rI1qtKxLkj5cujA5AnRhleKbQejeMFtGtFGqC7Kvqu9l
 sT1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5PtT1PsExiiLHgE1Pb39kZQ6sFaSOMiaT2i9js+CKlEHxdrh5MeZvr2nr4pZgMsJ2KOXkzrAKX89P@nongnu.org
X-Gm-Message-State: AOJu0Yym3hmEKVBuXQCUxixwCQVmPy9kXvL+fHBNZ/sXM99irlzJyQzC
 UYC3tk/nhQwJGxd6mpMDZjGvuACdHlXOkqHicAfMx1xU6p5+EN3NlbDwUXD3xrTNnuwyYJZ/7gt
 +/5K2JMM1npmytx0Uf7JP8XibUpX2ORLZLEZTRY7N5+7ETxUMXoV+AKKU
X-Gm-Gg: AZuq6aJ5Yuqi2nL2RssI5lIihgo8HdcSbAbxLV3Kxf2B5LuSQKYoqtegEokxTfnMvGr
 WL9wuZruBRRcPd1KQNT9s7kG7xSl3i3kxjc72O7GJbTGxonMvd+Ki9im6/lLVAqsM2amPNNxSzJ
 vNu3DnSLsWQVZzKb1POFvdz/tIHSqzF/UcyjIGCfU2mCK8nTwW8nWUZRWRZkBCsvJnzIWkLuz84
 /d2YsB1UJVh5dNQTTDcNz53dkkV9RY6nuKcNzUKwpDM7FwxpEi0A0zuxo6wd2AqAIK91Po07kTL
 7MAc3wkuySYP4ZlUqvr0cGMpcdUAcLHIsMgxOjqbrGMd9nmGEtTW/BLtC1H9aK36eOwc9dSxiFO
 o6sPjHzHARoinMw+4LjGdPNxsQejwCADhI61lD09+hiEtb5DXMi0/OlvXag==
X-Received: by 2002:a05:6000:3110:b0:430:fd0f:2910 with SMTP id
 ffacd0b85a97d-435dd0841e0mr13416192f8f.26.1769681830704; 
 Thu, 29 Jan 2026 02:17:10 -0800 (PST)
X-Received: by 2002:a05:6000:3110:b0:430:fd0f:2910 with SMTP id
 ffacd0b85a97d-435dd0841e0mr13416144f8f.26.1769681830266; 
 Thu, 29 Jan 2026 02:17:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm14532300f8f.13.2026.01.29.02.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 02:17:09 -0800 (PST)
Message-ID: <ee57ec0e-e1e5-4bb7-99b4-f61b68147b64@redhat.com>
Date: Thu, 29 Jan 2026 11:17:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] target/arm/cpu: Allow registers to be hidden
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-4-eric.auger@redhat.com> <87zf5zrnh4.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87zf5zrnh4.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 1/27/26 6:09 PM, Cornelia Huck wrote:
> On Mon, Jan 26 2026, Eric Auger <eric.auger@redhat.com> wrote:
>
>> More recent kernels sometimes expose new registers in an
>> unconditionnal manner. This situation breaks backward migration
>> as qemu notices there are more registers in the input stream
>> than supported on the destination host. This leads to a
>> "failed to load cpu:cpreg_vmstate_array_len" error.
>>
>> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
>> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
>> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
>> migration from a host kernel that features the commit to a destination
>> host that doesn't, fail with above error.
>>
>> Currently QEMU is not using that feature so ignoring this latter
>> is not a problem. An easy way to fix the migration issue is to teach
>> qemu we don't care about that register and we can simply ignore it
>> when syncing its state during migration.
>>
>> This patch introduces an array of such hidden registers. Soon it will
>> be settable through an array property.
>>
>> If hidden, the register is moved out of the array of cpreg which is
>> built in kvm_arm_init_cpreg_list(). That way their state won't be
>> synced.
>>
>> To extend that functionality to TCG, do the same in add_cpreg_to_list()
>> and count_cpreg().
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>>
>> ---
>> v2 -> v3:
>> - use kvm_regidx
>>
>> v1 -> v2:
>> - Move the property in a separate patch
>> - improve the commit msg
>> - change the trace point to just print info in
>>   kvm_arm_init_cpreg_list()
>> - improve comment in cpu.h (Connie)
>>
>> target/arm/helper: Skip hidden registers
>>
>> In case a cpreg is hidden, skip it when initialing the cpreg
>> list.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> This looks a bit weird, probably due to patch folding... but I'm happy
> to have my R-b apply to the whole patch :)

Oh yes I missed that. Nevertheless it is below the --- so I guess it is
not that much an issue

Eric
>
>> ---
>>  target/arm/cpu.h        | 20 ++++++++++++++++++++
>>  target/arm/helper.c     | 12 +++++++++++-
>>  target/arm/kvm.c        | 12 +++++++++++-
>>  target/arm/trace-events |  2 ++
>>  4 files changed, 44 insertions(+), 2 deletions(-)


