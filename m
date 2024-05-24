Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2676C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 03:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sALhm-0002LB-11; Thu, 23 May 2024 23:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sALhk-0002Kn-4d
 for qemu-devel@nongnu.org; Thu, 23 May 2024 23:34:52 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sALhh-00014R-C5
 for qemu-devel@nongnu.org; Thu, 23 May 2024 23:34:51 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e52181c228so82014341fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1716521678; x=1717126478; darn=nongnu.org;
 h=cc:to:subject:message-id:date:references:mime-version:user-agent
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pSgOJi+rRq0Q1ybCxE8116LpKHtqLjc95czmULH9o0Y=;
 b=Yd1adpqqy2v9acODLhs3GbKwSZsmlI7qjNbbkM2zLFhvSVaFsFmOq/z4ZHI+QUO4dA
 IPgmgdZ1t+IudQjR9Qfn/53rbSUbotrL1T17J2X5wCwTsuTz4ngbFLJer+ljOQ2Jkw/p
 N7864AaP7KAy2mDkXb7TPcEn5AbVln6SimJ4Eec1D3NgnJeTuCVIzx0VlMV+Jh+acBCw
 4jgOT5Sktwdtwj4pTHnhD6OYnHrNw2VCTnSxDyZnMpoNM70w9mp4qhUfnhIxU4wCvTzV
 JjacP3pBS9JMTVp/m3RQL5W6T/AyY69gBDscIhfcqaKhHqNsBGHJr+SkhjLxuKq7kiGo
 U5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716521678; x=1717126478;
 h=cc:to:subject:message-id:date:references:mime-version:user-agent
 :in-reply-to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSgOJi+rRq0Q1ybCxE8116LpKHtqLjc95czmULH9o0Y=;
 b=pPTjBaMIW8JWJoAroQWvTQwVfa9IcMipA1BHJxUbmYOG2QWwmme0m7n6OwMn1tL2GD
 liS+klb9rfO7Y26Kw4VU1dL7XccDZi37KeRUI/6TfTIjsRzixmguNOF/HyNZ4XuVaffZ
 RVGATekXc3MUQd2QOmKglO+hI75Tp3wfzzPReahLvOSgbjeFeuStRs2zzJgtt/YbHRwy
 OiNPMGeEnM5e6QHw9xSWudvRzaQG1lekKy+SEr20N4XOI0VnuoMbCp+9uRxmBATwQRBA
 qpuBqXpo70KZvCccLRpAk5q29/KFtk4fN22Qi5z2pLCOvmtbCKQG7DXgtil93IeNdMi4
 2CkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeTZCYartfusy3z1LY8gxCvLnFLA3nPzF6O6AsN7+aQ+T002ou5JS34Vs+Q5s8W4pijMgbY83b2uxoIi0a1lcPtGi63II=
X-Gm-Message-State: AOJu0YwZadVWQ2a4/PXJQMfAsBXC2mqQDuf6TvZnqjF0vtOp53E78XD0
 18H7LoMpargOq7j99WHZFTcvBUAZaDesRRko72thG4m8xzjwomq2JfhhSj2WotA3wufNfHRsq6k
 9Mjwbw/4SSOxgV6Rulze/6dYGuRb8zC1rLJiiRg==
X-Google-Smtp-Source: AGHT+IH2ndcOCMbu5jDZ7uUsh3CbUxrluoRGldNdhcCROEChODfZ7s9HjHChROldB+0JnkeUS6lA/XTm7YLy73e7fsU=
X-Received: by 2002:ac2:5053:0:b0:51c:fd0a:7e34 with SMTP id
 2adb3069b0e04-52964ea9795mr402591e87.22.1716521677870; Thu, 23 May 2024
 20:34:37 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 23 May 2024 20:34:37 -0700
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
In-Reply-To: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
User-Agent: Mozilla Thunderbird
Mime-Version: 1.0
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
Date: Thu, 23 May 2024 20:34:37 -0700
Message-ID: <CAO5cSZBdV+K9ZYC-3=TM6xA1L6N3dAmANHw30F_oBP9nYXaO5w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Support persistent reservation operations
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="000000000000dc6d9306192ad823"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000dc6d9306192ad823
Content-Type: text/plain; charset="UTF-8"

Hi,

could anyone please review this series?

On 2024/5/17 17:52, Changqi Lu wrote:
> Hi,
>
> Please ignore the v2 series. Please review the v3 series instead.
> Thanks!
>
> v2->v3:
> In v2 Persist Through Power Loss(PTPL) is enable default.
> In v3 PTPL is supported, which is passed as a parameter.
>
> v1->v2:
> - Add sg_persist --report-capabilities for SCSI protocol and enable
> oncs and rescap for NVMe protocol.
> - Add persistent reservation capabilities constants and helper functions
for
> SCSI and NVMe protocol.
> - Add comments for necessary APIs.
>
> v1:
> - Add seven APIs about persistent reservation command for block layer.
> These APIs including reading keys, reading reservations, registering,
> reserving, releasing, clearing and preempting.
> - Add the necessary pr-related operation APIs for both the
> SCSI protocol and NVMe protocol at the device layer.
> - Add scsi driver at the driver layer to verify the functions.
> Changqi Lu (11):
> block: add persistent reservation in/out api
> block/raw: add persistent reservation in/out driver
> scsi/constant: add persistent reservation in/out protocol constants
> scsi/util: add helper functions for persistent reservation types
> conversion
> hw/scsi: add persistent reservation in/out api for scsi device
> block/nvme: add reservation command protocol constants
> hw/nvme: add helper functions for converting reservation types
> hw/nvme: enable ONCS reservations
> hw/nvme: enable namespace rescap function
> hw/nvme: add reservation protocal command
> block/iscsi: add persistent reservation in/out driver
>
> block/block-backend.c | 397 ++++++++++++++++++++++++++
> block/io.c | 163 +++++++++++
> block/iscsi.c | 443 ++++++++++++++++++++++++++++++
> block/raw-format.c | 56 ++++
> hw/nvme/ctrl.c | 324 +++++++++++++++++++++-
> hw/nvme/ns.c | 8 +
> hw/nvme/nvme.h | 44 +++
> hw/scsi/scsi-disk.c | 352 ++++++++++++++++++++++++
> include/block/block-common.h | 40 +++
> include/block/block-io.h | 20 ++
> include/block/block_int-common.h | 84 ++++++
> include/block/nvme.h | 99 +++++++
> include/scsi/constants.h | 52 ++++
> include/scsi/utils.h | 8 +
> include/sysemu/block-backend-io.h | 24 ++
> scsi/utils.c | 81 ++++++
> 16 files changed, 2193 insertions(+), 2 deletions(-)
>

--000000000000dc6d9306192ad823
Content-Type: text/html; charset="UTF-8"

<p>Hi,
<br>
<br>could anyone please review this series?
<br>
<br>On 2024/5/17 17:52, Changqi Lu wrote:
<br>&gt; Hi,
<br>&gt; 
<br>&gt; Please ignore the v2 series. Please review the v3 series instead.
<br>&gt; Thanks!
<br>&gt; 
<br>&gt; v2-&gt;v3:
<br>&gt; In v2 Persist Through Power Loss(PTPL) is enable default.
<br>&gt; In v3 PTPL is supported, which is passed as a parameter.
<br>&gt; 
<br>&gt; v1-&gt;v2:
<br>&gt; - Add sg_persist --report-capabilities for SCSI protocol and enable
<br>&gt;   oncs and rescap for NVMe protocol.
<br>&gt; - Add persistent reservation capabilities constants and helper functions for
<br>&gt;   SCSI and NVMe protocol.
<br>&gt; - Add comments for necessary APIs.
<br>&gt; 
<br>&gt; v1:
<br>&gt; - Add seven APIs about persistent reservation command for block layer.
<br>&gt;   These APIs including reading keys, reading reservations, registering,
<br>&gt;   reserving, releasing, clearing and preempting.
<br>&gt; - Add the necessary pr-related operation APIs for both the
<br>&gt;   SCSI protocol and NVMe protocol at the device layer.
<br>&gt; - Add scsi driver at the driver layer to verify the functions.
<br>&gt; Changqi Lu (11):
<br>&gt;   block: add persistent reservation in/out api
<br>&gt;   block/raw: add persistent reservation in/out driver
<br>&gt;   scsi/constant: add persistent reservation in/out protocol constants
<br>&gt;   scsi/util: add helper functions for persistent reservation types
<br>&gt;     conversion
<br>&gt;   hw/scsi: add persistent reservation in/out api for scsi device
<br>&gt;   block/nvme: add reservation command protocol constants
<br>&gt;   hw/nvme: add helper functions for converting reservation types
<br>&gt;   hw/nvme: enable ONCS reservations
<br>&gt;   hw/nvme: enable namespace rescap function
<br>&gt;   hw/nvme: add reservation protocal command
<br>&gt;   block/iscsi: add persistent reservation in/out driver
<br>&gt; 
<br>&gt;  block/block-backend.c             | 397 ++++++++++++++++++++++++++
<br>&gt;  block/io.c                        | 163 +++++++++++
<br>&gt;  block/iscsi.c                     | 443 ++++++++++++++++++++++++++++++
<br>&gt;  block/raw-format.c                |  56 ++++
<br>&gt;  hw/nvme/ctrl.c                    | 324 +++++++++++++++++++++-
<br>&gt;  hw/nvme/ns.c                      |   8 +
<br>&gt;  hw/nvme/nvme.h                    |  44 +++
<br>&gt;  hw/scsi/scsi-disk.c               | 352 ++++++++++++++++++++++++
<br>&gt;  include/block/block-common.h      |  40 +++
<br>&gt;  include/block/block-io.h          |  20 ++
<br>&gt;  include/block/block_int-common.h  |  84 ++++++
<br>&gt;  include/block/nvme.h              |  99 +++++++
<br>&gt;  include/scsi/constants.h          |  52 ++++
<br>&gt;  include/scsi/utils.h              |   8 +
<br>&gt;  include/sysemu/block-backend-io.h |  24 ++
<br>&gt;  scsi/utils.c                      |  81 ++++++
<br>&gt;  16 files changed, 2193 insertions(+), 2 deletions(-)
<br>&gt;</p>

--000000000000dc6d9306192ad823--

