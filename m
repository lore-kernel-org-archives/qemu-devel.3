Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E6ECD6E49
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScRz-0002W5-4U; Thu, 28 May 2026 11:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wScRo-0002NU-Kk
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wScRm-0006Mt-VR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779981296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/+bC7QjDQS+fTuqHVrJHYLhO5StgoEy46exv+WFnTk=;
 b=Mllv15p2N3nOuEwzGqWNgjndyqZdM/OgYV2d3Bofzw8IL1KGYfO5F5Z4WtdqvKB2JfDCDh
 pKQr4PccydJ6owJe5C8b/4DI6KzCk+cKJ4U/AnHPio/zjfjsiB5/oFfskpREvgEwdUgAOE
 Qdm88CKjTq09gPoN7rb+MZWGDldISN0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-eJ4SCdB2OcuDSUYVM89_bw-1; Thu, 28 May 2026 11:14:54 -0400
X-MC-Unique: eJ4SCdB2OcuDSUYVM89_bw-1
X-Mimecast-MFC-AGG-ID: eJ4SCdB2OcuDSUYVM89_bw_1779981294
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45eec27f5a5so369270f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981294; x=1780586094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/+bC7QjDQS+fTuqHVrJHYLhO5StgoEy46exv+WFnTk=;
 b=c4Lc7ScGfliczkedYUQ8iaNiN6z4w92b+1i03gE2EUz90009eWotifFXD8y4nGlsFc
 8Kq7RkOddzHvHAUAQ8DZ71SDuXve0V9btNzCMivMJT/7usnb6KLPuK3xnKxUwbnmQ8zp
 e2hviBabeyWFhef5nuvkgJLywhUOmZAlAdkxExl+2t3DmTjibdFgKwxBtq4YwDjvThTc
 xszS+GjjcuHCWPg8MuwUEVKxqIUMQBJJwCkdG/I6ZgXmsObM8cm9L6FswjggoVviLm7T
 hlDxKTYf9oxQSUkBrt9yY9S5eSBwS/W2mctBPArxtr53P3Et3X1d6Y8M/9DrRD0tCS02
 P0CQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Huj5Yioy+qhfyP6Amlw1F5WFIKpHFJjwk+ja0Dvwp/CYdCu6FiJCf4lrIUCkIF1zStv3zU9vsqlRW@nongnu.org
X-Gm-Message-State: AOJu0YyWQPEo/iNJb8QoRcou47UkZWRzuRh0Q3rFUXlpyP1NJU4BSNUP
 fc2mTo8IRfCYLlqwCYrYQ+CioJpvzd/ncPm2OfQncrLLtkbmnmrAg/KzYBcF/lENY56ob3ixT6g
 mqGXYZ6S5cP1Bru6tkHyvOOVbnsBnAsMcXg96i4dU2PhdwDBGaIFmDHB9
X-Gm-Gg: Acq92OF5RQyAJervhOwTcxmvjNVf3yfHCnl3dQd1HycuMQ2YlNPe1agGqsUDiR3F3YD
 OdGsd45M6cHa6o2I9V1TftpZP4OeJN1OR+6nGYaCjrBmKH8kdeBruJgvXpgOz4SjqUV7BKPpaDE
 n1r5R74Rkc0Hcr1rBLpcCLPdaC5frV5Tmh7HF59o3Yb0zbcZNGYS8RoMC3ngl+YeFBDlkMvHSy4
 WailJO/q3zz6jddJau1Jo/pnXfgpe4A2TwJZ7mJx8vyzeK4oqySiFqJw3F8HoHtoYP1rhBMfyrc
 X8Wxh7SpYRsbuRkhcYHFUrmTFnh16uzB0hTdeFCFBHZzHipvDX+Iol4sx1nKPsJfoucTW5XCpW8
 bU59KggIHFpKH6e7yh3jg14i0/9ibfwXPC8RImQlqdD+BwBWFvfZUZD5DUT4KXTwYiJWR8EP/8j
 w/bJoP
X-Received: by 2002:a05:6000:400c:b0:45e:b2b7:1863 with SMTP id
 ffacd0b85a97d-45eb38a8507mr45091493f8f.16.1779981293669; 
 Thu, 28 May 2026 08:14:53 -0700 (PDT)
X-Received: by 2002:a05:6000:400c:b0:45e:b2b7:1863 with SMTP id
 ffacd0b85a97d-45eb38a8507mr45091427f8f.16.1779981293242; 
 Thu, 28 May 2026 08:14:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb549e79sm15071313f8f.7.2026.05.28.08.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:14:52 -0700 (PDT)
Message-ID: <6a402e30-91c1-4be7-aa93-0c287839bac2@redhat.com>
Date: Thu, 28 May 2026 17:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/18] target/arm/cpu: Expose writable ID reg field
 properties on the kvm host vcpu model
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-17-eric.auger@redhat.com>
 <30F66A6A-E26B-486C-81D1-8E1B2CCB558A@nutanix.com>
 <6c14a58a-60ab-419f-9395-ca3489f6cff8@redhat.com>
 <CA136979-E0CC-420E-9271-63CF27CD7DA5@nutanix.com>
 <2fd2057d-c74b-4bbe-b2d0-cb9ed092a37d@redhat.com>
 <6F6ECB0E-82A8-4FFA-8687-2D6E243A2096@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6F6ECB0E-82A8-4FFA-8687-2D6E243A2096@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/27/26 6:11 PM, Khushit Shah wrote:
>
>> On 27 May 2026, at 9:34 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> On 5/27/26 5:56 PM, Khushit Shah wrote:
>>> So you are saying, if I do, 
>>> -cpu host,sve=on,SYSREG_ID_AA64PFR0_SVE=0
>>> QEMU will still show sve capabilities to the guest?
>> Yes that's what I expect. Require more extensive testing though. That
>> could be way to handle coexistence of different levels of granulaity.
>> Lowest level applies first, overriden by legacy compositive options. I
>> guess if you plan to introduce other layers of compositive props you
>> will most probably handle this situation too.
>>
> I am sure this at-least does not work with sve, 
> because arm_cpu_sve_finalize() just takes looks at the PFR0.SVE field and If value is 0 sve is 'off' otherwise 'on’.
ID_AA64PFR0_EL1 SVE field is not writable if I am not wrong. Only
ID_AA64ZFR0_EL1.SVEver is

        ID_FILTERED(ID_AA64PFR0_EL1, id_aa64pfr0_el1,
                    ~(ID_AA64PFR0_EL1_AMU |
                      ID_AA64PFR0_EL1_MPAM |
                      ID_AA64PFR0_EL1_SVE |
                      ID_AA64PFR0_EL1_AdvSIMD |
                      ID_AA64PFR0_EL1_FP)),

Eric

>
> What you describe might work for legacy props backed by prop_* boolean variables in ARMCPU like pauth (backed by cpu->prop_pauth).
>
> I have not tested this. I maybe wrong if some prop ordering magic happens at machine level.
>
> My plan is to just parse properties in order they arrive in cmdline :)
>
> Warm Regards,
> Khushit


