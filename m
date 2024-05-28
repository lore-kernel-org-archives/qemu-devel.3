Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5554C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1Ph-0005x0-Cn; Tue, 28 May 2024 14:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jojing64@gmail.com>)
 id 1sC1Pf-0005wY-MZ; Tue, 28 May 2024 14:19:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jojing64@gmail.com>)
 id 1sC1Pd-0001oe-VG; Tue, 28 May 2024 14:19:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7007324a568so882956b3a.3; 
 Tue, 28 May 2024 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716920343; x=1717525143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2qcRzbrJfzFhar3JXjeEwkJ+x1ObCKv/9QMmr3jD/cM=;
 b=iKhDFugyEDKt+ZTc27+vWoRlSfUKqEW2OzPIaA4Au2eHK1oyMSJrqxYsqt2LJ6F/7D
 62nutyVqBs602Tz62sLTRXjRoAW5kCpR6zQoeQfJv3GWgBt79A6xYz8NJdE1sxGjuZI3
 ADQqSKsVwZ+w9b8XtEPmCvxF22O+/YyDVczIjw+lhIyY47r3K54Jg6rMIUlWbMwNEgUd
 g80EAofntGvZ921fQt3Dd5gPjY3KcdzjpkSPRmG7+EABqGEdI5OluXlurWMLpQ/CgU9R
 ESMGAahRBjNdKGi/rDLvzn6YM2CGg9jej+kIzpZz5dU6oHpg8yQdTsTvFXTxbkHLvsDV
 RXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716920343; x=1717525143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qcRzbrJfzFhar3JXjeEwkJ+x1ObCKv/9QMmr3jD/cM=;
 b=SP5nDh5hLhosKbNmG7cj3EN4dD9w+A32sji8fzArbCsMmmku9POZPo0IE5w+4gqJFt
 qpFfViq/vUiojiWmOSRC2rPz8BFRy50qzL1c4VQo6Qi5qpovUctY5JifsnNF/Fs81wlD
 kWLlBoLOoNi01lXEvlFOtYa/54OXyq5zcB1vbufGgyzHgPYonFymGM7nXKf2tI28WPj6
 kwBBBAi9bm+v2MlohNam/rv9PcE9x3A1wVdJBmQdVywu1YTMnyEwHohkPy91L8JaB/wN
 Zl/LhN/pqXwPoCQ+UfHkzVKOPQLNqi9PxWDViY22maiCS1MFCukeIhGcHB6h8stjpddH
 BJhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNM88ilq43FOgQZds0o/lPy+5x5324ZFXXMEltRserUDG/u/u38ByA7mVnd2Ku51ebtSo5sJ4N/8YM2FCda/+2BqUS1Vg=
X-Gm-Message-State: AOJu0YzcCvbtdxw/MgrLjCouOtWRGoU+0OE7u8sBcaLXgkej7awQu+6o
 8G8QUvrnWLbRCVNsZw0iCNgNcwruXJoJjq9Mm0hu0GH95sw2bBq7
X-Google-Smtp-Source: AGHT+IH7U/WOeTO7bxvcrsxP9X6aGX1SNFv6xqhujVqZNLwGIm5OutT012HUSglZPhlBIPyAvaOVBw==
X-Received: by 2002:a05:6a21:622:b0:1b1:f322:4c81 with SMTP id
 adf61e73a8af0-1b212d42ea6mr12858802637.36.1716920343362; 
 Tue, 28 May 2024 11:19:03 -0700 (PDT)
Received: from ?IPV6:2001:569:590e:4600:1ea1:182:f195:fb52?
 ([2001:569:590e:4600:1ea1:182:f195:fb52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-701d60b06e3sm1247134b3a.191.2024.05.28.11.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 11:19:02 -0700 (PDT)
Message-ID: <fb2ea759-1a7e-4c0e-ab0d-3ec4c04dc503@gmail.com>
Date: Tue, 28 May 2024 11:19:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block snapshot issue with RBD
To: Ilya Dryomov <idryomov@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 pl@kamp.de, hreitz@redhat.com, peterx@redhat.com, farosas@suse.de
References: <8b639179-e567-469c-bd04-ee8dee12d7d2@gmail.com>
 <0e01a8e2-a543-4524-939c-05413fd99e86@gmail.com>
 <756f9dcb-4e9c-4c2f-bc8a-dcc7420a1839@gmail.com>
 <CAOi1vP8nJVsvvsmG5Ac4sd+9NPA8v8t=7Sao0f7-qNb129p=OA@mail.gmail.com>
Content-Language: en-US
From: Jin Cao <jojing64@gmail.com>
In-Reply-To: <CAOi1vP8nJVsvvsmG5Ac4sd+9NPA8v8t=7Sao0f7-qNb129p=OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=jojing64@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Ilya

On 5/28/24 11:13 AM, Ilya Dryomov wrote:
> On Mon, May 27, 2024 at 9:06 PM Jin Cao <jojing64@gmail.com> wrote:
>>
>> Supplementary info: VM is paused after "migrate" command. After being
>> resumed with "cont", snapshot_delete_blkdev_internal works again, which
>> is confusing, as disk snapshot generally recommend I/O is paused, and a
>> frozen VM satisfy this requirement.
> 
> Hi Jin,
> 
> This doesn't seem to be related to RBD.  Given that the same error is
> observed when using the RBD driver with the raw format, I would dig in
> the direction of migration somehow "installing" the raw format (which
> is on-disk compatible with the rbd format).
> 

Thanks for the hint.

> Also, did you mean to say "snapshot_blkdev_internal" instead of
> "snapshot_delete_blkdev_internal" in both instances?

Sorry for my copy-and-paste mistake. Yes, it's snapshot_blkdev_internal.

--
Sincerely,
Jin Cao

> 
> Thanks,
> 
>                  Ilya
> 
>>
>> --
>> Sincerely
>> Jin Cao
>>
>> On 5/27/24 10:56 AM, Jin Cao wrote:
>>> CC block and migration related address.
>>>
>>> On 5/27/24 12:03 AM, Jin Cao wrote:
>>>> Hi,
>>>>
>>>> I encountered RBD block snapshot issue after doing migration.
>>>>
>>>> Steps
>>>> -----
>>>>
>>>> 1. Start QEMU with:
>>>> ./qemu-system-x86_64 -name VM -machine q35 -accel kvm -cpu
>>>> host,migratable=on -m 2G -boot menu=on,strict=on
>>>> rbd:image/ubuntu-22.04-server-cloudimg-amd64.raw -net nic -net user
>>>> -cdrom /home/my/path/of/cloud-init.iso -monitor stdio
>>>>
>>>> 2. Do block snapshot in monitor cmd: snapshot_delete_blkdev_internal.
>>>> It works as expected: the snapshot is visable with command`rbd snap ls
>>>> pool_name/image_name`.
>>>>
>>>> 3. Do pseudo migration with monitor cmd: migrate -d exec:cat>/tmp/vm.out
>>>>
>>>> 4. Do block snapshot again with snapshot_delete_blkdev_internal, then
>>>> I get:
>>>>      Error: Block format 'raw' used by device 'ide0-hd0' does not
>>>> support internal snapshots
>>>>
>>>> I was hoping to do the second block snapshot successfully, and it
>>>> feels abnormal the RBD block snapshot function is disrupted after
>>>> migration.
>>>>
>>>> BTW, I get the same block snapshot error when I start QEMU with:
>>>>       "-drive format=raw,file=rbd:pool_name/image_name"
>>>>
>>>> My questions is: how could I proceed with RBD block snapshot after the
>>>> pseudo migration?

