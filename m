Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B849CAC59F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 22:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz0In-0000aS-Cd; Wed, 17 Sep 2025 18:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uz0Il-0000a1-Nz
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 18:06:59 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uz0Ij-0008RL-UC
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 18:06:59 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4b7b3202dceso3240111cf.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758146817; x=1758751617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBnd6wYKMR6LkG7jp2k6VZx6f6X79TTYvQ2uUqUZZOw=;
 b=fqf+i/Yit2NBNm9RIDWZuXBcyqrKPp7sljlBQKOQ1ZYY5tPXNmtsM5YZPFpPakpX12
 Qelt+oy4HSZLpePMj0RovO/drohPZQfHX83+vj3dPnMikLNCmRF/rEiHeUsDU1qGbNOn
 JKjZ33bG2ogCvgbxvWFBhhvidGoNwxDwYvDZjryvtm4LAO1dCn/pHyOkgfmHQgNQHogr
 pvHjvte4t+dTbB2bdtd+zn9kfNqAZE3oQynjGbbcJYnYeGN/f1jwAwASbLeOep8CTGuC
 rp8E5vOD8P3sWuq38CVGvwxJ10P8ZChBv0X+u+WhvD8Er3WLFzSG7l62QbrVnqE8sX0j
 fUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758146817; x=1758751617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NBnd6wYKMR6LkG7jp2k6VZx6f6X79TTYvQ2uUqUZZOw=;
 b=tMGXxzIW0YHhNh108mzD6frh10FIsJAtMJ6DGa2zDKoolAPHkUv1difETrD5z6kPcG
 oOyh2Mbc2vj3b/gyWOSDbBBiuXJcP8fJnKqgera+FCqGwAK6dsXIkE+dFCT5o4qFFhXF
 1737W3HufTLb7NSQ9gyplGbbJWBrBSB7jq41LzAXFEwPWqG0kV+ITIcRa+cxPu+ZhLnr
 m+ZR0YQvlnkSmq8VMs7OCv79O+S5ytj9XXecGRHscnhUeP5z+g/9qzDjz4g99mO8ow0S
 EX/Iw80KagqW8Vu6YaBPV02xyS6OoivqnjY7dRnv9i2JbcJxF2MArS3y2/tQnA9O5Cv+
 wgmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRaEJBojCjYrN9R5/mwe76oBsc86kW/8PrpFPN1gsm6JmhBEHYaDUiu+m/HscKS9mqjW3D+B6SEKRS@nongnu.org
X-Gm-Message-State: AOJu0Yy8NgFSUirgz4MBtvfJJbUIJV2xTzoA+9awbwupifeuf2k2S0i2
 s+aVlp8QPoH0HYW65xsJV5s9oUjIZNhLF4Mom9uPO7m+u29dGB7reIZd
X-Gm-Gg: ASbGncsEt4Bt8+r+Y7Hl8kQ3yhEfPfbYhXVIKNO+jx2HXF3IMCP3TAc0FQvnEYHAzyI
 5KrqSYvbeDDc1cn4k0Y7UwRVJna5YfgLcL69WdzuTTt1VyCXMGinTzFE58Jutelv13ziHvYSsHC
 E78cm2GGmRjyUn0XZ43wy2+mnVg5ZW02eVm53jPmG6zRZWeqlXXdR1qveh/D+aWZOhhtdsb7/p7
 sctR9h1PjghiqlnrxXe5GiG8dG7fqyQGhF1mw7liEc1c8OyfLWQlWrWCEso3ouY7z7nphdsVvl5
 KQuraRJdEe6ZSo+vAVrDhFVfjNBTvXKXraG8XgSXw7kUagGLQh8fT3SN7xqcGl7cDKvSmuXN5XH
 n/fmWhmVhCJVO/D/2ofkpDh4W8wLzrVDGUcJ5KQQ=
X-Google-Smtp-Source: AGHT+IECy4NZFaCdvSycDAOK4tS8Gu2TIeGKglrSanHp7voR/LvnoGENxsAT2NRYPpuUPv/IyOa6ww==
X-Received: by 2002:a05:622a:296:b0:4b7:a7b2:bbb with SMTP id
 d75a77b69052e-4ba6c1e5f4fmr51629701cf.64.1758146816783; 
 Wed, 17 Sep 2025 15:06:56 -0700 (PDT)
Received: from [10.5.0.2] ([86.48.15.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83625ee4071sm53603285a.4.2025.09.17.15.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 15:06:56 -0700 (PDT)
Message-ID: <00777028-aaf4-4607-80a7-d91ea9e9685a@gmail.com>
Date: Wed, 17 Sep 2025 18:06:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] export/fuse: Safe termination for FUSE-uring
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-4-hibriansong@gmail.com>
 <20250909193358.GE218449@fedora>
 <CAKWCU7VFbJius06j1pXvP_5aSpmhmaJq6Z41H4efWFmeMjr4OQ@mail.gmail.com>
 <ef822991-5af9-4ac7-9bcd-15f521579f8f@redhat.com>
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <ef822991-5af9-4ac7-9bcd-15f521579f8f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=hibriansong@gmail.com; helo=mail-qt1-x831.google.com
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



On 9/17/25 9:01 AM, Hanna Czenczek wrote:
> On 15.09.25 07:43, Brian Song wrote:
>> Hi Hanna,
> 
> Hi Brian!
> 
> (Thanks for your heads-up!)
> 
>> Stefan raised the above issue and proposed a preliminary solution: keep
>> closing the file descriptor in the delete section, but perform
>> umount separately for FUSE uring and traditional FUSE in the shutdown
>> and delete sections respectively. This approach avoids the race
>> condition on the file descriptor.
>>
>> In the case of FUSE uring, umount must be performed in the shutdown
>> section. The reason is that the kernel currently lacks an interface to
>> explicitly cancel submitted SQEs. Performing umount forces the kernel to
>> flush all pending SQEs and return their CQEs. Without this step, CQEs
>> may arrive after the export has already been deleted, and invoking the
>> CQE handler at that point would dereference freed memory and trigger a
>> segmentation fault.
> 
> The commit message says that incrementing the BB reference would be 
> enough to solve the problem (i.e. deleting is delayed until all requests 
> are done).  Why isn’t it?

Hanna:

If we place umount in the delete section instead of the shutdown 
section, the kernel FUSE driver will continue waiting for user FUSE 
requests and therefore won't return CQEs to userspace. As a result, the 
BB reference remains held (since the reference is acquired during 
registration and submission and only released once the CQE returns), 
preventing the delete operation from being invoked (invoked once the 
reference is decreased to 0). This is why umount must be placed in the 
shutdown section.

> 
>> I’m curious about traditional FUSE: is it strictly necessary to perform
>> umount in the delete section, or could it also be done in shutdown?
> 
> Looking into libfuse, fuse_session_unmount() (in fuse_kern_unmount()) 
> closes the FUSE FD.  I can imagine that might result in the potential 
> problems Stefan described.
> 
>> Additionally, what is the correct ordering between close(fd) and
>> umount, does one need to precede the other?
> 
> fuse_kern_unmount() closes the (queue 0) FD first before actually 
> unmounting, with a comment: “Need to close file descriptor, otherwise 
> synchronous umount would recurse into filesystem, and deadlock.”
> 
> Given that, I assume the FDs should all be closed before unmounting.
> 
> (Though to be fair, before looking into it now, I don’t think I’ve ever 
> given it much thought…)
> 
> Hanna
>
Stefan:

I roughly went through the umount and close system calls:

umount:
fuse_kill_sb_anon -> fuse_sb_destroy -> fuse_abort_conn

close:
__fput -> file->f_op->release(inode, file) -> fuse_dev_release -> 
fuse_abort_conn
(this only runs after all /dev/fuse FDs have been closed).

And as Hanna mentioned, libfuse points out: “Need to close file 
descriptor, otherwise synchronous umount would recurse into filesystem, 
and deadlock.”

So ideally, we should close each queue FD first, then call umount at the 
end — even though calling umount directly also works. The root issue is 
that the kernel doesn't provide an interface to cancel already submitted 
SQEs.

You mentioned that in fuse over io_uring mode we perform close in the 
shutdown path, but at that point the server may still be processing 
requests. While handling requests, it may still write to the FD, but 
that FD might not be /dev/fuse. I’m not sure how this gets triggered, 
since in fuse uring mode all FUSE requests are handled by io_uring, and 
our FUSE requests should be completed via io_uring. After shutdown 
closes the FD, it may call fuse_abort_conn, which terminates all request 
processing in the kernel. There’s also locking in place to protect the 
termination of requests and the subsequent uring cleanup.

That’s why I think the best approach for now is:

in shutdown, handle close and umount for fuse over io_uring;

in delete, handle close and umount for traditional FUSE.

>> Thanks,
>> Brian
>>
>> On 9/9/25 3:33 PM, Stefan Hajnoczi wrote:
>>   > On Fri, Aug 29, 2025 at 10:50:24PM -0400, Brian Song wrote:
>>   >> @@ -901,24 +941,15 @@ static void fuse_export_shutdown(BlockExport
>> *blk_exp)
>>   >>            */
>>   >>           g_hash_table_remove(exports, exp->mountpoint);
>>   >>       }
>>   >> -}
>>   >> -
>>   >> -static void fuse_export_delete(BlockExport *blk_exp)
>>   >> -{
>>   >> -    FuseExport *exp = container_of(blk_exp, FuseExport, common);
>>   >>
>>   >> -    for (int i = 0; i < exp->num_queues; i++) {
>>   >> +    for (size_t i = 0; i < exp->num_queues; i++) {
>>   >>           FuseQueue *q = &exp->queues[i];
>>   >>
>>   >>           /* Queue 0's FD belongs to the FUSE session */
>>   >>           if (i > 0 && q->fuse_fd >= 0) {
>>   >>               close(q->fuse_fd);
>>   >
>>   > This changes the behavior of the non-io_uring code. Now all fuse 
>> fds and
>>   > fuse_session are closed while requests are potentially still being
>>   > processed.
>>   >
>>   > There is a race condition: if an IOThread is processing a request 
>> here
>>   > then it may invoke a system call on q->fuse_fd just after it has been
>>   > closed but not set to -1. If another thread has also opened a new 
>> file
>>   > then the fd could be reused, resulting in an accidental write(2) 
>> to the
>>   > new file. I'm not sure whether there is a way to trigger this in
>>   > practice, but it looks like a problem waiting to happen.
>>   >
>>   > Simply setting q->fuse_fd to -1 here doesn't fix the race. It 
>> would be
>>   > necessary to stop processing fuse_fd in the thread before closing it
>>   > here or to schedule a BH in each thread so that fuse_fd can be closed
>>   > in the thread that uses the fd.
>>
> 


