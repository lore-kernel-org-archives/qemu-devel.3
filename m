Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D5FC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 23:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiiDb-00046m-Il; Sun, 03 Aug 2025 19:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uiiD6-0003gL-G1; Sun, 03 Aug 2025 19:33:56 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uiiD4-00021E-CC; Sun, 03 Aug 2025 19:33:48 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3e3f6ae4d08so15902935ab.1; 
 Sun, 03 Aug 2025 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754264024; x=1754868824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=umLIgCX9/mXbQ/5dugNIpSLgaxODjd/07jiV+Ik2QYA=;
 b=ZrHPaRRu5XpfK4sqcIFl6D2jXPF0UaG0BP+DqIOHQHIUPlUWpR0QTlSYvmZgXvdsPt
 GnaX8e+Eo9FxN96HW9NAP+V893Tx85rUN6QOyQ1zJZ5HGEETTOXOJ/EUz629DNB+g0pL
 hwn/1cFH1kOl34horw9Ft1bg/Vq2vdK0uobR6F6UY1c+DVmVuLA7N0gvL4Fcf4JfhneA
 aX8vfGQRDLOqKywhrYK4uuIILvacZzM9Yo9cicNrxmwx3TEN7owTxEa7Y7J8gelIbBY+
 ReF6yJ+qZtlkONsOeG6/BVi4mlBNjGBq1Bf2r5tNaxiF9V83qjSi0I6/hnxSbi9UsQ/P
 beBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754264024; x=1754868824;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=umLIgCX9/mXbQ/5dugNIpSLgaxODjd/07jiV+Ik2QYA=;
 b=Si6yxKBW5mVpLX0ruGuXCzrZzMmWCfxT2beOag/spVjC1Wuat+dOaLEiZMRFfbyUsM
 8x97SNTbCLzfymuet1ZuzTcjJpJ4kJFTxWn8THnCPXmxEFR2JN7PtW1dDlSuYrjsVMQ3
 6/RIGPv69B749LEjIJFxcDSrpdcF43P70vZ8voz2ngUnMAcUlWwSdWZxL98RgFdZdCgA
 psVs+NAIE3vOq5JkQx5iv1mxUwiCZ7pbPJGAr4jZbJXOb08Mt+YSXoi9jKzuLz9/W/PS
 d4KY0TVO7irlyIvvDgmINH15Ivq7XE233Z084S3YnVkNO1Gvx+8TStk6Cxho+jkkKjOb
 oZyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjGiJ2EGjY3BNuca2SVW3MDbeschWlrsGWg/QAAwHRAgD0qlGsC9nBurna1S5RllPU/B33xef6Fw3a1Q==@nongnu.org,
 AJvYcCVl6/Vy6hIRPmACdO6TqzOCUpexhDOc8Sf3fa2ruy3toBVEj55h9KQgyp1mRIxD0JlyI5Q4d0Fd0WtJ@nongnu.org
X-Gm-Message-State: AOJu0YzRK/umVQEX8EQE26xwL6O4JxF5y5eHmvr9HKM/laXk7TT7CSAn
 f39cy7lk05p1vFnFJgIUggNoFD5d7+60E1Nh1T5Mm1rsBeiU8c85JHH+
X-Gm-Gg: ASbGncudEB+bF8UxWzsg76uwNCVwnipv5N6zdjB6XiVbSmsSxOgoeROCVloEDOS5koA
 H5VqlFpYRah10uEONPrwM8spGdm3y7DuuFCpLskTfUwOL2HumEUiy9Ro7XXw9Viqg6pgTrkAbhd
 04VuvKvHGJTJtKOKsFiviqS/sW+Rl1fhU8j5Z5mTeQ9o2MVu6W66gei0ooJo7NvjCr6lNGKxcM3
 Wnxnt8kL712tRNpeBmYD97O7bAivIg6lgND69bWPxBvYyXio7EQMnk7J+jLPMmpKXsSelQwjgUf
 S35Neo12AsP+RIueajSKv56SzQHNwbOS5nH3L4yzxdISKc3U+Vz5cyOC6a1dSk3xtzS5su71yIc
 IpMOo6yveRlicfck9hxNWUBiyRGbxtapG72Lg8WGue/963r/sO8AH5jmvzp4heS/ynZNpgft//0
 IEtgqHIVCRFcNCQSDajPhjng==
X-Google-Smtp-Source: AGHT+IFG8HT8tlA3SmTcNEGb4uSYY8IDz7xi2/cxHjFNqhAavrS9fuNWEJL3ylz/eF8INcQ44vIGnA==
X-Received: by 2002:a05:6e02:308e:b0:3e2:84aa:f473 with SMTP id
 e9e14a558f8ab-3e415d7504amr126115505ab.1.1754264023916; 
 Sun, 03 Aug 2025 16:33:43 -0700 (PDT)
Received: from [10.36.100.250]
 (wn-campus-nat-129-97-124-250.dynamic.uwaterloo.ca. [129.97.124.250])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e402b34285sm36964525ab.57.2025.08.03.16.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Aug 2025 16:33:43 -0700 (PDT)
Message-ID: <dc326a4b-f6fa-435a-b614-208e03f61556@gmail.com>
Date: Sun, 3 Aug 2025 19:33:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU/FUSE] Discussion on Proper Termination and Async
 Cancellation in fuse-over-io_uring
From: Brian Song <hibriansong@gmail.com>
To: bschubert@ddn.com, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
References: <3867ced7-efb7-4a0f-ac0f-465631950bdb@gmail.com>
Content-Language: en-CA
In-Reply-To: <3867ced7-efb7-4a0f-ac0f-465631950bdb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=hibriansong@gmail.com; helo=mail-il1-x12d.google.com
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



On 2025-08-01 12:09 p.m., Brian Song wrote:
> Hi Bernd,
> 
> We are currently working on implementing termination support for fuse- 
> over-io_uring in QEMU, and right now we are focusing on how to clean up 
> in-flight SQEs properly. Our main question is about how well the kernel 
> supports robust cancellation for these fuse-over-io_uring SQEs. Does it 
> actually implement cancellation beyond destroying the io_uring queue?
> 
> In QEMU FUSE export, we need a way to quickly and cleanly detach from 
> the event loop and cancel any pending SQEs when an export is no longer 
> in use. Ideally, we want to avoid the more drastic measure of having to 
> close the entire /dev/fuse fd just to gracefully terminate outstanding 
> operations.
> 
> We are not sure if there's an existing code path that supports async 
> cancel for these in-flight SQEs in the fuse-over-io_uring setup, or if 
> additional callbacks might be needed to fully integrate with the 
> kernel's async cancel mechanism. We also realized libfuse manages 
> shutdowns differently, typically by signaling a thread via eventfd 
> rather than relying on async cancel.
> 
> Would love to hear your thoughts or suggestions on this!
> 
> Thanks,
> Brian

I looked into the kernel codebase and came up with some initial ideas, 
which might not be entirely accurate:

The IORING_OP_ASYNC_CANCEL operation can only cancel io_uring ring 
resources and a limited set of request types. It does not clean up 
resources related to fuse-over-io_uring, such as in-use entries.
IORING_OP_ASYNC_CANCEL
-> submit/enter
-> io_uring/opdef.c:: .issue = io_async_cancel,
	-> __io_async_cancel
		-> io_try_cancel ==> Can only cancel few types of requests


Currently, full cleanup of both io_uring and FUSE data structures for 
fuse-over-io_uring only happens in two cases:  [since we have mark these 
SQEs cancelable when we commit_and_fetch everytime(mentioned below)]
1.When the FUSE daemon exits (exit syscall)
2.During execve, which triggers the kernel path:

io_uring_files_cancel =>
io_uring_try_cancel_uring_cmd =>
file->f_op->uring_cmd(cmd, IO_URING_F_CANCEL | IO_URING_F_COMPLETE_DEFER)



Below is a state diagram (mermaid graph) of a fuse_uring entry inside 
the kernel:

graph TD
     A["Userspace daemon"] --> 
B["FUSE_IO_URING_CMD_REGISTER<br/>Register buffer"]
     B --> C["Create fuse_ring_ent"]
     C --> D["State: FRRS_AVAILABLE<br/>Added to ent_avail_queue"]

     E["FUSE filesystem operation"] --> F["Generate FUSE request"]
     F --> G["fuse_uring_queue_fuse_req()"]
     G --> H{"Check ent_avail_queue"}

     H -->|Entry available| I["Take entry from queue<br/>Assign to FUSE 
request"]
     H -->|No entry available| J["Request goes to fuse_req_queue and waits"]

     I --> K["fuse_uring_dispatch_ent()"]
     K --> L["State: FRRS_USERSPACE<br/>Move to ent_in_userspace"]
     L --> M["Notify userspace to process"]

     N["Process exit / daemon termination"] --> 
O["io_uring_try_cancel_uring_cmd() <br/> >> NOTE Since we marked the 
entry IORING_URING_CMD_CANCELABLE <br/> in the previous fuse_uring_cmd , 
try_cancel_uring_cmd will call <br/> fuse_uring_cmd to 'delete' it <<"]
     O --> P["fuse_uring_cancel()"]
     P --> Q{"Is entry state AVAILABLE?"}

     Q -->|Yes| R[">> equivalent to 'delete' << Directly change to 
USERSPACE<br/>Move to ent_in_userspace"]
     Q -->|No| S["Do nothing"]

     R --> T["io_uring_cmd_done(-ENOTCONN)"]
     T --> U["Entry is 'disguised' as completed<br/>Will no longer 
handle new FUSE requests"]

     V["Practical effects of cancellation:"] --> W["1. Prevent new FUSE 
requests from using this entry<br/>2. Release io_uring command 
resources<br/>3. Does not affect already assigned FUSE requests"]



When the kernel is waiting for VFS requests and the corresponding entry 
is idle, its state is FRRS_AVAILABLE. Once a request is handed off to 
the userspace daemon, the entry's state transitions to FRRS_USERSPACE.

The fuse_uring_cmd function handles the COMMIT_AND_FETCH operation. If a 
cmd call carries the IO_URING_F_CANCEL flag, fuse_uring_cancel is 
invoked to mark the entry state as FRRS_USERSPACE, making it unavailable 
for future requests from the VFS.

If the IORING_URING_CMD_CANCELABLE flag is not set, before committing 
and fetching, we first call fuse_uring_prepare_cancel to mark the entry 
as IORING_URING_CMD_CANCELABLE. This indicates that if the daemon exits 
or an execve happens during fetch, the kernel can call 
io_uring_try_cancel_uring_cmd to safely clean up these SQEs/CQEs and 
related fuse resource.

Back to our previous issue, when deleting a FUSE export in QEMU, we hit 
a crash due to an invalid CQE handler. This happened because the SQEs we 
previously submitted hadn't returned yet by the time we shut down and 
deleted the export.

To avoid this, we need to ensure that no further CQEs are returned and 
no CQE handler is triggered. We need to either:

* Prevent any further user operations before calling blk_exp_close_all

or

* Require the userspace to trigger few specific operations that causes 
the kernel to return all outstanding CQEs, and then the daemon can send 
io_uring_cmd with the IO_URING_F_CANCEL flag to mark all entries as 
unavailable (FRRS_USERSPACE) "delete operation", ensuring the kernel 
won't assign them to future VFS requests.





