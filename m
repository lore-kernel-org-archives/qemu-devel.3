Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64B1C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVotj-0001De-Qd; Mon, 22 Jul 2024 04:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sVoti-0001B4-J8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sVotg-0003aK-Ju
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721638793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/y7xSCwGc1J5Ir7ZI+sNuRPBjTMKYjecoutAJVBNdOo=;
 b=ewelpZUqPtZm45vNg6eUOzAVIivT9OjGh49upZ6xOq9a6SrV47eEQYfPzsarfhdjkIcjvp
 l5PZT0se7+qVCrbK3SJ7jarvpyaqG7UY6bsMChixf8Aby0lyr4hS/EIcYAsA3rwBimts2p
 HJkufw88RqPJoLWRFH/LuAQX9GS2Cw0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-vtOlOUsyMJmi_eQ7jWYGKw-1; Mon, 22 Jul 2024 04:59:50 -0400
X-MC-Unique: vtOlOUsyMJmi_eQ7jWYGKw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427e9c2f82cso2598325e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 01:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721638789; x=1722243589;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/y7xSCwGc1J5Ir7ZI+sNuRPBjTMKYjecoutAJVBNdOo=;
 b=MMRzd23Wcijjn0lQsZguhcla1kdsE1Uze8Iy5mCE90Cq+6RFfDAfRFwb6awy6qRKOy
 dIoG1DzCUA1aOCM6QAHPJpiYS54vug3nOq6b3Ah4tIeUAetYnYVbhawdMM8c3JVWHqu5
 d/jeeW7fswdG3nBruy4kYiVVkYjQUHss47ahCEtSQJoVqn1yjontLC0iTXwMBEDUhX/9
 kmI2a7MoikljBl5LjiFg2hBApMFiYhnJNpOlD5t8D4FFzGOulkAKp0Hbwy0BS566os8i
 nNr2ZUykiw1hIAdsS/gQRBGBUaFU4M1rzRZsBInQ25beqkHBXvSUG5laNT3SEk+iVvuh
 L7aQ==
X-Gm-Message-State: AOJu0YwDnO7hHL8llsXRy+8CQTk57fdnCxSZH8TWcrbif77uvj8r35ER
 urfbFn6HCZj1CPwTLqevxQ4dJ84wVbXmt7LHCW+hI9k58hniPPQWjF7QD0fkhxhLGj24o7ugJcH
 tM9fQKM5mNB3FDsK0JJBRnidIMJ8QIvv++dXQ0BWKpW/bSE/ztQDI
X-Received: by 2002:a5d:440f:0:b0:368:4626:1327 with SMTP id
 ffacd0b85a97d-369bae3f958mr3250396f8f.23.1721638789023; 
 Mon, 22 Jul 2024 01:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdg6wHGYW3VHOCdZF3nJw4Qj8Lg5wy1LBgo1WnaPAfSMIwLV2OEKtlwdiYdGaH/8NZ+4Z02g==
X-Received: by 2002:a5d:440f:0:b0:368:4626:1327 with SMTP id
 ffacd0b85a97d-369bae3f958mr3250383f8f.23.1721638788595; 
 Mon, 22 Jul 2024 01:59:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c727:7000:c050:e303:f8a7:6ed9?
 (p200300cbc7277000c050e303f8a76ed9.dip0.t-ipconnect.de.
 [2003:cb:c727:7000:c050:e303:f8a7:6ed9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878695b35sm7873295f8f.65.2024.07.22.01.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 01:59:48 -0700 (PDT)
Message-ID: <37d9e725-1be7-48e1-b621-3f657192f124@redhat.com>
Date: Mon, 22 Jul 2024 10:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zpk7Mf2c7LiNV2xC@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 18.07.24 17:56, Peter Xu wrote:
> Steve,
> 
> On Sun, Jun 30, 2024 at 12:40:23PM -0700, Steve Sistare wrote:
>> What?
> 
> Thanks for trying out with the cpr-transfer series.  I saw that that series
> missed most of the cc list here, so I'm attaching the link here:
> 
> https://lore.kernel.org/r/1719776648-435073-1-git-send-email-steven.sistare@oracle.com
> 
> I think most of my previous questions for exec() solution still are there,
> I'll try to summarize them all in this reply as much as I can.
> 
>>
>> This patch series adds the live migration cpr-exec mode, which allows
>> the user to update QEMU with minimal guest pause time, by preserving
>> guest RAM in place, albeit with new virtual addresses in new QEMU, and
>> by preserving device file descriptors.
>>
>> The new user-visible interfaces are:
>>    * cpr-exec (MigMode migration parameter)
>>    * cpr-exec-command (migration parameter)
> 
> I really, really hope we can avoid this..
> 
> It's super cumbersome to pass in a qemu cmdline in a qemu migration
> parameter.. if we can do that with generic live migration ways, I hope we
> stick with the clean approach.
> 
>>    * anon-alloc (command-line option for -machine)
> 
> Igor questioned this, and I second his opinion..  We can leave the
> discussion there for this one.
> 
>>
>> The user sets the mode parameter before invoking the migrate command.
>> In this mode, the user issues the migrate command to old QEMU, which
>> stops the VM and saves state to the migration channels.  Old QEMU then
>> exec's new QEMU, replacing the original process while retaining its PID.
>> The user specifies the command to exec new QEMU in the migration parameter
>> cpr-exec-command.  The command must pass all old QEMU arguments to new
>> QEMU, plus the -incoming option.  Execution resumes in new QEMU.
>>
>> Memory-backend objects must have the share=on attribute, but
>> memory-backend-epc is not supported.  The VM must be started
>> with the '-machine anon-alloc=memfd' option, which allows anonymous
>> memory to be transferred in place to the new process.
>>
>> Why?
>>
>> This mode has less impact on the guest than any other method of updating
>> in place.
> 
> So I wonder whether there's comparison between exec() and transfer mode
> that you recently proposed.
> 
> I'm asking because exec() (besides all the rest of things that I dislike on
> it in this approach..) should be simply slower, logically, due to the
> serialized operation to (1) tearing down the old mm, (2) reload the new
> ELF, then (3) runs through the QEMU init process.
> 
> If with a generic migration solution, the dest QEMU can start running (2+3)
> concurrently without even need to run (1).

I'll note (not sure if already discussed) that with the "async-teardown" 
option we have a way to move the MM teardown to a separate process, such 
that it will happen asynchronously.

-- 
Cheers,

David / dhildenb


