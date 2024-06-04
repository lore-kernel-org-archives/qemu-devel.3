Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10C1C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 16:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEWns-0003Xa-QV; Tue, 04 Jun 2024 12:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sEWnh-0003W7-O5
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 12:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sEWnf-0008Ki-3W
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 12:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717517653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UnROTFROxTWpMRLqgQkgZbR0BbuFYUGh9y+qPHXSvzA=;
 b=Mx057frJ0EgBuWAr86/MGSgUjXxFRG96n0MY13iqvGnzzOkTnCMwSenq++t0qkhsDgiUEe
 aowIpM4hFqnp9Atw/1nTSN5N+E3E/Gd8j5b9mjq6Rv4HoFbns6uGesFgm11lvol8bsv0ak
 ddqhGassxFd00+tJlqY9J4FxWPSPj/o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-pUd9Vr9zN5aXT0q_vwdESg-1; Tue, 04 Jun 2024 12:14:12 -0400
X-MC-Unique: pUd9Vr9zN5aXT0q_vwdESg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52b95e7decfso2395080e87.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 09:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717517651; x=1718122451;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UnROTFROxTWpMRLqgQkgZbR0BbuFYUGh9y+qPHXSvzA=;
 b=N1eD2dBOi5VeOkC9v9/JWGFwpu93qBnZ1rEMhThHMsxhoCksJFBb56NHOyDYq9q1Er
 cLz44P/y4akZKviFLQ+XWrtWoSN+65gKGq3cOABYkGSA2BpGJnbF44l/u9qZ27jtNcJs
 gXMVmtbNTDSxzxyBK9WhU3Fxwa5okNaYvlQy5P/m6ymuUhOzaTSnFf/9mgNbqVNu3mgW
 +Rns3mgC3vqZFXQIhfucQHnYXEusGGM6AJFJ/luv+QCU4AGNILgNO/VDccNDBhGOlsFz
 n7Jh/wCCR3mbvdB8lGYbYGQXJ3Xp3nPB9QaArrts9qPeB5v/IukXbUX8RDSTV1Lw2N/F
 ehKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIZb5RYGAw1xTAbYDgNKnTFqHgI55jKB5QqQaexUjVYTqi12EKk2UBLqNg8j4bLr03FYao5mZik/o9HTIeEQQhlxiBv4M=
X-Gm-Message-State: AOJu0YweplPIwNTvH07cnQzNJAYHjckyGq1EfyDlnbbwy4HIInbVN2yI
 K5crdaWq5of7N+7f2LmqZsvD7LDAJQenoHs/XTKg9hPKdTfXt3C37fJsHCe0uSBnPDNQtQqwxd6
 gRiYtA87/3ip1rH6PIC2gyEI4LeuZEwAM822USuzV6TJXmwj68TWW
X-Received: by 2002:a05:6512:3da4:b0:52b:8342:e0fe with SMTP id
 2adb3069b0e04-52bab4f5eeamr4947e87.48.1717517650272; 
 Tue, 04 Jun 2024 09:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPPv8OfXW1q+6TlbrnnnTzv7PekCrT6N6s+BuxyRrfrf0EkrIzf46wezjRnzqSEHBFNI3Fjg==
X-Received: by 2002:a05:6512:3da4:b0:52b:8342:e0fe with SMTP id
 2adb3069b0e04-52bab4f5eeamr4924e87.48.1717517649867; 
 Tue, 04 Jun 2024 09:14:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b?
 (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de.
 [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214a4aab93sm19795935e9.0.2024.06.04.09.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 09:14:09 -0700 (PDT)
Message-ID: <1b06eb8d-f6be-4e2b-929b-2f65edf16237@redhat.com>
Date: Tue, 4 Jun 2024 18:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n> <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
 <Zld-iWfa3_yEWgn6@x1n> <ea8eb67e-583d-41cd-a545-ab18c032a99b@oracle.com>
 <ZljCHgwJhGcFiP1J@x1n> <e6d5f123-37ad-4d77-8536-f7f85213073d@oracle.com>
 <Zl46MIO30mGrtsQk@x1n> <Zl6-f245q-M7A62J@redhat.com> <Zl85o3w6ncv63zG5@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zl85o3w6ncv63zG5@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 04.06.24 17:58, Peter Xu wrote:
> On Tue, Jun 04, 2024 at 08:13:26AM +0100, Daniel P. Berrangé wrote:
>> On Mon, Jun 03, 2024 at 05:48:32PM -0400, Peter Xu wrote:
>>> That property, irrelevant of what it is called (and I doubt whether Dan's
>>> suggestion on "shared-ram" is good, e.g. mmap(MAP_SHARED) doesn't have user
>>> visible fd but it's shared-ram for sure..), is yet another way to specify
>>> guest mem types.
>>>
>>> What if the user specified this property but specified something else in
>>> the -object parameters?  E.g. -machine share-ram=on -object
>>> memory-backend-ram,share=off.  What should we do?
>>
>> The machine property would only apply to memory regions that are
>> *NOT* being created via -object. The memory-backend objects would
>> always honour their own share settnig.
> 
> In that case we may want to rename that to share-ram-by-default=on.
> Otherwise it's not clear which one would take effect from an user POV, even
> if we can define it like that in the code.
> 
> Even with share-ram-by-default=on, it can be still confusing in some form
> or another. Consider this cmdline:
> 
>    -machine q35,share-ram-by-default=on -object memory-backend-ram,id=mem1
> 
> Then is mem1 shared or not?  From reading the cmdline, if share ram by
> default it should be ON if we don't specify it, but it's actually off?
> It's because -object has its own default values.

We do have something similar with "merge" and "dump" properties. See 
machine_mem_merge() / machine_dump_guest_core().

These correspond to the "mem-merge" and "dump-guest-core" machine 
properties.

But ...

> 
> IMHO fundamentally it's just controversial to have two ways to configure
> guest memory.  If '-object' is the preferred and complete way to configure
> it, I prefer sticking with it if possible and see what is missing.

... I agree with that. With vhost-user we also require a reasonable 
configuration (using proper fd-based shared memory) for it to work.

> 
> I think I raised that as the other major reason too, that I think it's so
> far only about the vram that is out of the picture here.  We don't and
> shouldn't have complicated RW RAMs floating around that we want this
> property to cover.

Agreed. And maybe we can still keep migration of any MAP_PRIVATE thing 
working by migrating that memory? CPR will be "slightly less fast".

But the biggest piece -- guest RAM -- will be migrated via the fd directly.

-- 
Cheers,

David / dhildenb


