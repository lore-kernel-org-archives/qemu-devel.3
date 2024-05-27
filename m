Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3939C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 19:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBfgP-0001IU-7H; Mon, 27 May 2024 15:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jojing64@gmail.com>)
 id 1sBfgN-0001Hh-Ip; Mon, 27 May 2024 15:06:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jojing64@gmail.com>)
 id 1sBfgL-0007D8-Ps; Mon, 27 May 2024 15:06:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so112125ad.1; 
 Mon, 27 May 2024 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716836811; x=1717441611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6kDVh2jhs9/9bIa8sVNxqOaKgOPI44teQ8a7Ld9+NbQ=;
 b=hVhdTORslOnYg9WGqyEPbskJCWDebYFbQvDKve8z+5sAbe5j70ucKMYo8jsa6YkZRs
 JIrTsndCI4vPZ2UzPDrxKzUqCBjUEliqc5tabiaEdVi0DKlV7cVtGb6I2xuaR9jmw/w+
 epBeeTVE0lHjdCbcSgZNsFSzjKYtcCQym/bHLZUuyEFZ9DsHKJUmoibae+IdcOFV2cko
 bfA701zUGzpz18CR6g1xG6viH/nWp+sJyQ8z1vrori4j1Jo13M2X2J4XP5B4MIF5tqJF
 +0CKmCEvT2CP5kIuAy9UA4SaLT1umzivCpuDtA8eNt79Ga4Wd9xsSHWdgB3EKqnrJIAI
 wEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716836811; x=1717441611;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6kDVh2jhs9/9bIa8sVNxqOaKgOPI44teQ8a7Ld9+NbQ=;
 b=opP/ZzY77d5CSMyVSh7nJkZruVO0NOo1tzSly6jA3MCDpCf3DS1F10GzKpwrvJRYgY
 t2m5zQ1IxtYl008N6QhRvQUFu3cSG9N0kb0fQXb/m6JP4HJL18GsgUui8SJ9ppw9C/j/
 mFbQL3j6xyMDe/nJ3XxDRis3S2Az2c6PgwKBPK5YjgHdSExlRVMM+4KW7d7fZjnOGwNG
 ezHSUPepbiN4IbyL952Qxfvx79Kz5zxebPv/bWETHlWfhe0/fbiuaIe5RrWll5diky81
 ue+DJ6CJenXYCFoxdoAPZfdQ7+ytQQ7AnUrZ/nRnHi7XctiEafBxAZ0ySM80MzA2aMmS
 lrbw==
X-Gm-Message-State: AOJu0Yxfg5e6kO9kfV3AZcg4bwCCfHI1dnKd7Hveur3jPhC23adGqmtd
 lHtrEWVtO+azfFdq+WOjHDLDI5/D9TQrdq0w11LIPs2AL/izKogKK5dEIw==
X-Google-Smtp-Source: AGHT+IFBnTVwpmR3/xSJ/NPXmBy6P7DgXK87gPpo6Zp1qZlRBnphDIESvQQkocb3jPOchpuJr+8/DA==
X-Received: by 2002:a17:902:e810:b0:1e4:fd4:48d0 with SMTP id
 d9443c01a7336-1f449900ab9mr119352965ad.62.1716836810772; 
 Mon, 27 May 2024 12:06:50 -0700 (PDT)
Received: from ?IPV6:2001:569:590e:4600:1ea1:182:f195:fb52?
 ([2001:569:590e:4600:1ea1:182:f195:fb52])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f4b8458009sm11102165ad.88.2024.05.27.12.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 12:06:50 -0700 (PDT)
Message-ID: <756f9dcb-4e9c-4c2f-bc8a-dcc7420a1839@gmail.com>
Date: Mon, 27 May 2024 12:06:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block snapshot issue with RBD
From: Jin Cao <jojing64@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, idryomov@gmail.com, pl@kamp.de,
 hreitz@redhat.com, peterx@redhat.com, farosas@suse.de
References: <8b639179-e567-469c-bd04-ee8dee12d7d2@gmail.com>
 <0e01a8e2-a543-4524-939c-05413fd99e86@gmail.com>
Content-Language: en-US
In-Reply-To: <0e01a8e2-a543-4524-939c-05413fd99e86@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jojing64@gmail.com; helo=mail-pl1-x629.google.com
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

Supplementary info: VM is paused after "migrate" command. After being 
resumed with "cont", snapshot_delete_blkdev_internal works again, which 
is confusing, as disk snapshot generally recommend I/O is paused, and a 
frozen VM satisfy this requirement.

--
Sincerely
Jin Cao

On 5/27/24 10:56 AM, Jin Cao wrote:
> CC block and migration related address.
> 
> On 5/27/24 12:03 AM, Jin Cao wrote:
>> Hi,
>>
>> I encountered RBD block snapshot issue after doing migration.
>>
>> Steps
>> -----
>>
>> 1. Start QEMU with:
>> ./qemu-system-x86_64 -name VM -machine q35 -accel kvm -cpu 
>> host,migratable=on -m 2G -boot menu=on,strict=on 
>> rbd:image/ubuntu-22.04-server-cloudimg-amd64.raw -net nic -net user 
>> -cdrom /home/my/path/of/cloud-init.iso -monitor stdio
>>
>> 2. Do block snapshot in monitor cmd: snapshot_delete_blkdev_internal. 
>> It works as expected: the snapshot is visable with command`rbd snap ls 
>> pool_name/image_name`.
>>
>> 3. Do pseudo migration with monitor cmd: migrate -d exec:cat>/tmp/vm.out
>>
>> 4. Do block snapshot again with snapshot_delete_blkdev_internal, then 
>> I get:
>>     Error: Block format 'raw' used by device 'ide0-hd0' does not 
>> support internal snapshots
>>
>> I was hoping to do the second block snapshot successfully, and it 
>> feels abnormal the RBD block snapshot function is disrupted after 
>> migration.
>>
>> BTW, I get the same block snapshot error when I start QEMU with:
>>      "-drive format=raw,file=rbd:pool_name/image_name"
>>
>> My questions is: how could I proceed with RBD block snapshot after the 
>> pseudo migration?

