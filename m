Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FEEC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyuU-0005oa-5w; Tue, 12 Mar 2024 05:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rjyuS-0005md-NB
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rjyuR-0000Ti-0N
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710237537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0vOyGKNd60ezd9YR4EHU29lm1VRuZYwsUMveYQvYC7Y=;
 b=WcO3Q2qGuH/rewsESocR0SAcH0q2lesH/+WgBSGX821cSelVJ/z93CfvpxmWb1QbxtUi9i
 PI21xPIY11ZHI2FIvaD1zs8ChrRdwbBIOkmEFqT8dhqVVf7qIRSs6KxSJf4jE6BsgRe4AK
 EiyaToBKXOKkKzJxSbirYEnIW7vdhVA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-W5dXPdoOMeWIpKyn-fBDbg-1; Tue, 12 Mar 2024 05:58:56 -0400
X-MC-Unique: W5dXPdoOMeWIpKyn-fBDbg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4623e798aeso85299666b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 02:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710237535; x=1710842335;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0vOyGKNd60ezd9YR4EHU29lm1VRuZYwsUMveYQvYC7Y=;
 b=LzVEQkl19cJ9vj6nTkk+9oZNRpxVzk/9jRmCQCFx1U8Z9iCA4PlvAUgwoBF0gBuKEn
 Xnrj3u42FhhMLfYmBTEduQ01pXgE0t0/O2vYAQTk294IsAAxByeTnbMZa/WAV0YyIJ9y
 VHo8+bXVNKTrRIxtil9JtvYKsJ5QUuu7NC5vqJSwgsxc+JGQY5iURo/8qMqO22xUv7W7
 HCzNLJ7h36tDqfCanbVrnvL5s2+P6suNzUnGds5NuDWDC13UOXA6674b1ciHDjYxhdRm
 rAHBRl9Kq7wxUCg7I4avxVsYbg3es2nsnUFucKZbR6EihXAr36s+buRnSFmYTqgtoiM1
 lbWQ==
X-Gm-Message-State: AOJu0YyEhgvEB6r7Sr9QGZ01hT2Ng74K3TiPVw4d48CuAi0+Am86BfRP
 iHOW0dQZTVT41/R+9V81a3uktMOJ726wiJSsZWlLpOYSxv7n7ywh7VyMsLjTccwgR3Ol7iLmHe2
 tX3o9y1ROhckx80QhsgbULbc/g5xs/aE6PaEyejvXAMa9ObfWL+YA
X-Received: by 2002:a17:907:3ea5:b0:a45:bea5:806a with SMTP id
 hs37-20020a1709073ea500b00a45bea5806amr6633376ejc.68.1710237534969; 
 Tue, 12 Mar 2024 02:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFPnm2HNT546bRKISAA0anrGbCRe1oyLVhtyyTUAX2BKXQ81sphqiqTy9DI64ujf4KWJv00Q==
X-Received: by 2002:a17:907:3ea5:b0:a45:bea5:806a with SMTP id
 hs37-20020a1709073ea500b00a45bea5806amr6633357ejc.68.1710237534629; 
 Tue, 12 Mar 2024 02:58:54 -0700 (PDT)
Received: from [192.168.43.219] (lib59-h05-176-171-156-58.dsl.sta.abo.bbox.fr.
 [176.171.156.58]) by smtp.gmail.com with ESMTPSA id
 uz26-20020a170907119a00b00a45c9945251sm3672189ejb.192.2024.03.12.02.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 02:58:54 -0700 (PDT)
Message-ID: <5ca62745-deae-41b5-a9ef-2269a7220830@redhat.com>
Date: Tue, 12 Mar 2024 10:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] migration: Improve error reporting
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com> <ZerJDAdaakTCtECF@x1n>
 <Ze9ogyFZT73gB-La@x1n> <0a1c329e-e6ab-4329-815d-e6be3e64c2ae@redhat.com>
In-Reply-To: <0a1c329e-e6ab-4329-815d-e6be3e64c2ae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/12/24 08:16, Cédric Le Goater wrote:
> On 3/11/24 21:24, Peter Xu wrote:
>> On Fri, Mar 08, 2024 at 04:15:08PM +0800, Peter Xu wrote:
>>> On Wed, Mar 06, 2024 at 02:34:15PM +0100, Cédric Le Goater wrote:
>>>> * [1-4] already queued in migration-next.
>>>>    migration: Report error when shutdown fails
>>>>    migration: Remove SaveStateHandler and LoadStateHandler typedefs
>>>>    migration: Add documentation for SaveVMHandlers
>>>>    migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
>>>> * [5-9] are prequisite changes in other components related to the
>>>>    migration save_setup() handler. They make sure a failure is not
>>>>    returned without setting an error.
>>>>    s390/stattrib: Add Error** argument to set_migrationmode() handler
>>>>    vfio: Always report an error in vfio_save_setup()
>>>>    migration: Always report an error in block_save_setup()
>>>>    migration: Always report an error in ram_save_setup()
>>>>    migration: Add Error** argument to vmstate_save()
>>>>
>>>> * [10-15] are the core changes in migration and memory components to
>>>>    propagate an error reported in a save_setup() handler.
>>>>
>>>>    migration: Add Error** argument to qemu_savevm_state_setup()
>>>>    migration: Add Error** argument to .save_setup() handler
>>>>    migration: Add Error** argument to .load_setup() handler
>>>
>>> Further queued 5-12 in migration-staging (until here), thanks.
>>
>> Just to keep a record: due to the virtio failover test failure and the
>> other block migration uncertainty in patch 7 (in which case we may want to
>> have a fix on sectors==0 case), I unqueued this chunk for 9.0.
> 
> ok. I will ask the block folks for help to understand if sectors==0
> is also an error in the save_setup context. May be  we can still
> merge these in 9.0 cycle.

I discussed with Kevin and sectors==0 is not an error case, the loop
should simply continue. That said, commit 66db46ca83b8 ("migration:
Deprecate block migration") would let us remove all that code in
the next cycle which is even simpler.

Thanks,

C.





