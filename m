Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3FCC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 02:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGrfV-0002bd-No; Mon, 10 Jun 2024 22:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sGrfT-0002aw-WB
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 22:55:28 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sGrfR-0001zc-Cu
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 22:55:27 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63947so672873a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 19:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718074521; x=1718679321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:references:mime-version:from
 :in-reply-to:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=Lwf1xaKXoEVyechDaqGNXQgHY63+pPB1WQguX8+ZFtk=;
 b=Kn6KHl5+qZu+fjOEYEukIO2+AZWWF/skg3fFyYmn/LLKYnnO8wFGKN6HgT2Ar2OqTX
 aIV8eYRC7dZNXX0TC+m3JGWE2Rz2uoOwbri1bW+lHK8r8W9/8V3g0mRy17SuO5+xOpzK
 69ik3IF2ZX/2AUJn242m7yH7Ll18zfcqWRu382NdtPXJ01MPlofADxKW4TZEeQpKQyE8
 6zDxYKCVyxpIFqx7i7EH7HwJPf1EFNW8d6f4TSK3DEhkqtMMWkpwF+aHXJfjr5T7Wj32
 btj7eLRFAgIwOUtlsgElgKHCYrWNINIpVMCIRVdQOnZHzx7CzgRh/ZDSE8iZeJSvOGXK
 g2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718074521; x=1718679321;
 h=cc:to:subject:message-id:date:references:mime-version:from
 :in-reply-to:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lwf1xaKXoEVyechDaqGNXQgHY63+pPB1WQguX8+ZFtk=;
 b=Phjj6qGjb5r6IviOwSR11tRAl0QpIFx7p9u/S+igN9gbO8RANSfpHaXjjOJxXLYf4y
 S/GDoNOFnbcMqJjgCBCxsKKtcEw1gFvcDv0LYkKZmTqwXRNpUmpoRDdR5zfFweNB9ZBo
 vxbwWM/tDpaQsh+moEgwUDLgr5m5kxZUX507Rpn3yRYvqYOaiqEmXZ6T8oO8k7tibxKG
 8z9ri3wVr9aQxOwWVbB1c6lazr3wAkLYCXRzV9Z71DkpC+1v71BfXZoy3T5a0wJrpc7W
 O+3bGq8Vu39Gpd3cq9TbTffOdImwUR7LnnjusbZIx4rgfJWJHrdMQZKKM/M5KBcEIJFq
 arnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0J2+Sqj3U5oaMcPT8Ucf0rb4NNKf1PiDJszRBSlRO/++lPQzCjYZtF5hNxD44T8bQN9zoG+oVF4g+aV/aYfvSYa9pAgA=
X-Gm-Message-State: AOJu0YysaJfXB9bEBWWeLa86rxdfXAKXC5PFS3G2x4j55lVnOesb3xKT
 iXwvrR/YBuaoyIIg+YKeCiNJGQIrXzfWN2AX9K5xexYW7PYnuO2/XDH+iCacVsePUd0xL/IjLv+
 ULoM/IDvmtVaFvIpAqtMZJ7vZQMCi2Fx3GoslUw==
X-Google-Smtp-Source: AGHT+IFrMP7Se5EDhnITQNkUFGOQlHvhDzjDlnypK5a/m3hXEuZ3CD6EkqqvpAbscXUX6HcZbMdBRhOCXmnm47IyqYE=
X-Received: by 2002:a50:9e62:0:b0:57c:7f3a:6c8e with SMTP id
 4fb4d7f45d1cf-57c7f3ac291mr3456736a12.11.1718074521238; Mon, 10 Jun 2024
 19:55:21 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 10 Jun 2024 19:55:20 -0700
User-Agent: Mozilla Thunderbird
In-Reply-To: <20240610171823.GA334653@fedora.redhat.com>
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Mime-Version: 1.0
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
 <20240610171823.GA334653@fedora.redhat.com>
Date: Mon, 10 Jun 2024 19:55:20 -0700
Message-ID: <CAO5cSZDWkoORC_LPib3b16+q8vRK7zUvzYeVp7SjZg0+EBeRNQ@mail.gmail.com>
Subject: Re:Re: [PATCH v5 00/10] Support persistent reservation operations
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com, 
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org, its@irrelevant.dk, 
 foss@defmacro.it, philmd@linaro.org, pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="0000000000008958b9061a9465ae"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--0000000000008958b9061a9465ae
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry, I explained it in patch2 and forgot to reply your email.

The existing PRManager only works with local scsi devices. This series
will completely decouple devices and drivers. The device can not only be
scsi, but also other devices such as nvme. The same is true for the
driver, which is completely unrestricted.

And block/file-posix.c can implement the new block driver, and
pr_manager can be executed after splicing ioctl commands in these
drivers. This will be implemented in subsequent patches.

On 2024/6/11 01:18, Stefan Hajnoczi wrote:
> On Thu, Jun 06, 2024 at 08:24:34PM +0800, Changqi Lu wrote:
>> Hi,
>>
>> patchv5 has been modified.
>>
>> Sincerely hope that everyone can help review the
>> code and provide some suggestions.
>>
>> v4->v5:
>> - Fixed a memory leak bug at hw/nvme/ctrl.c.
>>
>> v3->v4:
>> - At the nvme layer, the two patches of enabling the ONCS
>> function and enabling rescap are combined into one.
>> - At the nvme layer, add helper functions for pr capacity
>> conversion between the block layer and the nvme layer.
>>
>> v2->v3:
>> In v2 Persist Through Power Loss(PTPL) is enable default.
>> In v3 PTPL is supported, which is passed as a parameter.
>>
>> v1->v2:
>> - Add sg_persist --report-capabilities for SCSI protocol and enable
>> oncs and rescap for NVMe protocol.
>> - Add persistent reservation capabilities constants and helper functions
for
>> SCSI and NVMe protocol.
>> - Add comments for necessary APIs.
>>
>> v1:
>> - Add seven APIs about persistent reservation command for block layer.
>> These APIs including reading keys, reading reservations, registering,
>> reserving, releasing, clearing and preempting.
>> - Add the necessary pr-related operation APIs for both the
>> SCSI protocol and NVMe protocol at the device layer.
>> - Add scsi driver at the driver layer to verify the functions
>
> My question from v1 is unanswered:
>
> What is the relationship to the existing PRManager functionality
> (docs/interop/pr-helper.rst) where block/file-posix.c interprets SCSI
> ioctls and sends persistent reservation requests to an external helper
> process?
>
> I wonder if block/file-posix.c can implement the new block driver
> callbacks using pr_mgr (while keeping the existing scsi-generic
> support).
>
> Thanks,
> Stefan
>
>>
>>
>> Changqi Lu (10):
>> block: add persistent reservation in/out api
>> block/raw: add persistent reservation in/out driver
>> scsi/constant: add persistent reservation in/out protocol constants
>> scsi/util: add helper functions for persistent reservation types
>> conversion
>> hw/scsi: add persistent reservation in/out api for scsi device
>> block/nvme: add reservation command protocol constants
>> hw/nvme: add helper functions for converting reservation types
>> hw/nvme: enable ONCS and rescap function
>> hw/nvme: add reservation protocal command
>> block/iscsi: add persistent reservation in/out driver
>>
>> block/block-backend.c | 397 ++++++++++++++++++++++++++
>> block/io.c | 163 +++++++++++
>> block/iscsi.c | 443 ++++++++++++++++++++++++++++++
>> block/raw-format.c | 56 ++++
>> hw/nvme/ctrl.c | 326 +++++++++++++++++++++-
>> hw/nvme/ns.c | 5 +
>> hw/nvme/nvme.h | 84 ++++++
>> hw/scsi/scsi-disk.c | 352 ++++++++++++++++++++++++
>> include/block/block-common.h | 40 +++
>> include/block/block-io.h | 20 ++
>> include/block/block_int-common.h | 84 ++++++
>> include/block/nvme.h | 98 +++++++
>> include/scsi/constants.h | 52 ++++
>> include/scsi/utils.h | 8 +
>> include/sysemu/block-backend-io.h | 24 ++
>> scsi/utils.c | 81 ++++++
>> 16 files changed, 2231 insertions(+), 2 deletions(-)
>>
>> --
>> 2.20.1
>>

--0000000000008958b9061a9465ae
Content-Type: text/html; charset="UTF-8"

<p>Hi,
<br>
<br>Sorry, I explained it in patch2 and forgot to reply your email.
<br>
<br>The existing PRManager only works with local scsi devices. This series
<br>will completely decouple devices and drivers. The device can not only be
<br>scsi, but also other devices such as nvme. The same is true for the
<br>driver, which is completely unrestricted.
<br>
<br>And block/file-posix.c can implement the new block driver, and
<br>pr_manager can be executed after splicing ioctl commands in these
<br>drivers. This will be implemented in subsequent patches.
<br>
<br>On 2024/6/11 01:18, Stefan Hajnoczi wrote:
<br>&gt; On Thu, Jun 06, 2024 at 08:24:34PM +0800, Changqi Lu wrote:
<br>&gt;&gt; Hi,
<br>&gt;&gt;
<br>&gt;&gt; patchv5 has been modified. 
<br>&gt;&gt;
<br>&gt;&gt; Sincerely hope that everyone can help review the
<br>&gt;&gt; code and provide some suggestions.
<br>&gt;&gt;
<br>&gt;&gt; v4-&gt;v5:
<br>&gt;&gt; - Fixed a memory leak bug at hw/nvme/ctrl.c.
<br>&gt;&gt;
<br>&gt;&gt; v3-&gt;v4:
<br>&gt;&gt; - At the nvme layer, the two patches of enabling the ONCS
<br>&gt;&gt;   function and enabling rescap are combined into one.
<br>&gt;&gt; - At the nvme layer, add helper functions for pr capacity
<br>&gt;&gt;   conversion between the block layer and the nvme layer.
<br>&gt;&gt;
<br>&gt;&gt; v2-&gt;v3:
<br>&gt;&gt; In v2 Persist Through Power Loss(PTPL) is enable default.
<br>&gt;&gt; In v3 PTPL is supported, which is passed as a parameter.
<br>&gt;&gt;
<br>&gt;&gt; v1-&gt;v2:
<br>&gt;&gt; - Add sg_persist --report-capabilities for SCSI protocol and enable
<br>&gt;&gt;   oncs and rescap for NVMe protocol.
<br>&gt;&gt; - Add persistent reservation capabilities constants and helper functions for
<br>&gt;&gt;   SCSI and NVMe protocol.
<br>&gt;&gt; - Add comments for necessary APIs.
<br>&gt;&gt;
<br>&gt;&gt; v1:
<br>&gt;&gt; - Add seven APIs about persistent reservation command for block layer.
<br>&gt;&gt;   These APIs including reading keys, reading reservations, registering,
<br>&gt;&gt;   reserving, releasing, clearing and preempting.
<br>&gt;&gt; - Add the necessary pr-related operation APIs for both the
<br>&gt;&gt;   SCSI protocol and NVMe protocol at the device layer.
<br>&gt;&gt; - Add scsi driver at the driver layer to verify the functions
<br>&gt; 
<br>&gt; My question from v1 is unanswered:
<br>&gt; 
<br>&gt;   What is the relationship to the existing PRManager functionality
<br>&gt;   (docs/interop/pr-helper.rst) where block/file-posix.c interprets SCSI
<br>&gt;   ioctls and sends persistent reservation requests to an external helper
<br>&gt;   process?
<br>&gt; 
<br>&gt;   I wonder if block/file-posix.c can implement the new block driver
<br>&gt;   callbacks using pr_mgr (while keeping the existing scsi-generic
<br>&gt;   support).
<br>&gt; 
<br>&gt; Thanks,
<br>&gt; Stefan
<br>&gt; 
<br>&gt;&gt;
<br>&gt;&gt;
<br>&gt;&gt; Changqi Lu (10):
<br>&gt;&gt;   block: add persistent reservation in/out api
<br>&gt;&gt;   block/raw: add persistent reservation in/out driver
<br>&gt;&gt;   scsi/constant: add persistent reservation in/out protocol constants
<br>&gt;&gt;   scsi/util: add helper functions for persistent reservation types
<br>&gt;&gt;     conversion
<br>&gt;&gt;   hw/scsi: add persistent reservation in/out api for scsi device
<br>&gt;&gt;   block/nvme: add reservation command protocol constants
<br>&gt;&gt;   hw/nvme: add helper functions for converting reservation types
<br>&gt;&gt;   hw/nvme: enable ONCS and rescap function
<br>&gt;&gt;   hw/nvme: add reservation protocal command
<br>&gt;&gt;   block/iscsi: add persistent reservation in/out driver
<br>&gt;&gt;
<br>&gt;&gt;  block/block-backend.c             | 397 ++++++++++++++++++++++++++
<br>&gt;&gt;  block/io.c                        | 163 +++++++++++
<br>&gt;&gt;  block/iscsi.c                     | 443 ++++++++++++++++++++++++++++++
<br>&gt;&gt;  block/raw-format.c                |  56 ++++
<br>&gt;&gt;  hw/nvme/ctrl.c                    | 326 +++++++++++++++++++++-
<br>&gt;&gt;  hw/nvme/ns.c                      |   5 +
<br>&gt;&gt;  hw/nvme/nvme.h                    |  84 ++++++
<br>&gt;&gt;  hw/scsi/scsi-disk.c               | 352 ++++++++++++++++++++++++
<br>&gt;&gt;  include/block/block-common.h      |  40 +++
<br>&gt;&gt;  include/block/block-io.h          |  20 ++
<br>&gt;&gt;  include/block/block_int-common.h  |  84 ++++++
<br>&gt;&gt;  include/block/nvme.h              |  98 +++++++
<br>&gt;&gt;  include/scsi/constants.h          |  52 ++++
<br>&gt;&gt;  include/scsi/utils.h              |   8 +
<br>&gt;&gt;  include/sysemu/block-backend-io.h |  24 ++
<br>&gt;&gt;  scsi/utils.c                      |  81 ++++++
<br>&gt;&gt;  16 files changed, 2231 insertions(+), 2 deletions(-)
<br>&gt;&gt;
<br>&gt;&gt; -- 
<br>&gt;&gt; 2.20.1
<br>&gt;&gt;</p>

--0000000000008958b9061a9465ae--

