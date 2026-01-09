Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDFCD16818
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veAqe-0003IW-ON; Fri, 09 Jan 2026 06:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1veAqd-0003I9-I2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:40:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1veAqb-0003vu-72
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767958803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVGzx2QwNIMve+nN0nYDMlWqzdRvwaE+NQwfUH9Ze/o=;
 b=FLD7Av65AP2cWsRRKt+mZUn1uTq7EQDmNVWGiLzmCgyE/7q025Lk5sOErLrWd8t1z3UXrJ
 TvcDo9IDXeCHAAvVLPRmDbC4qIFvW3d+++GtWQijKuhr8Zh9xNBeDDrN049qJ/jml6wac8
 uZSIXjaavV5JxiGgoGhieBB82F98mUg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-k-IOoX3LPwC2g47vK8XtsQ-1; Fri, 09 Jan 2026 06:40:02 -0500
X-MC-Unique: k-IOoX3LPwC2g47vK8XtsQ-1
X-Mimecast-MFC-AGG-ID: k-IOoX3LPwC2g47vK8XtsQ_1767958801
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b831e10ba03so633061466b.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767958801; x=1768563601; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MVGzx2QwNIMve+nN0nYDMlWqzdRvwaE+NQwfUH9Ze/o=;
 b=dEL9Cm6sRTrpADaouj+D/CbHkSYZvMZ0P4izNgAwxEqLXE0/wB+AD5d9gMZmbFREDV
 EOyOWpYCz0DsByvrEYFnmX/Ehf+sHxzMAsS6uaCULY6fS/5ybUf/tawo3W5xmjYUG2Rn
 Mif0mpsYzDKqKjV5m6ge8mNXM8mrzYMfGI/OrSU7FPVGRomm9cjEkJYrZ8E3y+VCTuLC
 yVHLMIS1p2/rk0ya3R3vPOBC2SK1mX/ZeCcRDk8U+tBgoHkwHdhdsRmSu/yFVP9NVF7k
 YunYXs3pIT+k8Difh5Bdf5Z3ZTYYxh+t/EkCzVwUmSMEcEFAMESGfqImh6gl5+nYMNCr
 lr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958801; x=1768563601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVGzx2QwNIMve+nN0nYDMlWqzdRvwaE+NQwfUH9Ze/o=;
 b=naDwlGKKlgpAhCu1V0SxItujjBoNEPMSZmG/dsOipXFpEowQclbGRuDmr2I3GUa91w
 +/LpoZQf2e2APmXxPPRtAKlMBemOgCj0tACUa6qYSgUU95aS7ynQZH8/aXy46IgwqRUa
 /34l5CSAx6JWpfTyxqNMX1vk7U4c/NUmy1Q1FnLm0ZKMZ9namcWBLRs2cbIdneMWJp1V
 1v/IvVZ11tQ7wvoNJnpAxFkMNuOvOWg5Hq7vugHALrZ18/ahDG5pFxDl7uXPfFwMNFKt
 mbcr4zGykrvbJCtc0psZVf9SxLzBqAVXyjpdqShClq2sCXiqXThyZIA+7oDG/2dsdCAY
 FVOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuZFawVT1w/xR+KutDBWcaWHvrNJyh3cM1iwlWsMzx3iNRXWc0PVr/jQZX6Fy2sFIkgKUp+kwtQ8LT@nongnu.org
X-Gm-Message-State: AOJu0YwBwWGxj8UFUmlcMjTYFbgMMtJpMU7I4HEJIeoLC+iw4JUGZsWQ
 rPj6KnDTzZhIrmun1r8Kdbo7k0X49xrpEQOtqdNG2jwvZHdLnAOSznPgNpkjDUHld6Oq5vqP+LX
 uqb2CHp1eSGjoZDDu4u7Zm3hW8mCet3Gh4Fk9ilX71tbkmMh91u0wTck7
X-Gm-Gg: AY/fxX4bFpsFxUgTX6gmTJ5PhJt8RLnsJothampfXsppFZcseIg87ehlnS4Xicj2SFE
 Cgr32bjDb7TPc0a2pQK/mlPwYeXzADdbunuWzszI/ieCgtqdl+Ndyin6Pv4QDu3TEE1xQnEoXHQ
 ZgIoyTe9KwDbo7GbM075FVofFqd0WIeVJh1PjCF8ChoV4yhgs3BVTFFDn5zds4jxkrACzvXpi7E
 ak+c0IxzVVvWg52j126wEpa+rkFCqjMfRBfeVJmrerUSODnWr77CDlVa+wpdWpizYQJ/kkoGr/B
 DOCA9cZRztKxlQ4TIS1oqGiaC/KdC1j0xLWVttqXhE9sjgY4S80RWhk1pQGOJ9fDCdcPT9K3GPv
 7dOvOBDn5aPVz3ZS0
X-Received: by 2002:a17:906:4fd1:b0:b76:63b8:7394 with SMTP id
 a640c23a62f3a-b8444fd4e55mr839481166b.51.1767958800785; 
 Fri, 09 Jan 2026 03:40:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjGbC16CoBMGxCG+CHK4mOMtYHxAl/hPvhg/TbU9BDf/EMPguVaz8d8tsm6eUXXw4VUKGo+g==
X-Received: by 2002:a17:906:4fd1:b0:b76:63b8:7394 with SMTP id
 a640c23a62f3a-b8444fd4e55mr839477766b.51.1767958799936; 
 Fri, 09 Jan 2026 03:39:59 -0800 (PST)
Received: from sgarzare-redhat ([193.207.180.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a51543fsm1062235566b.55.2026.01.09.03.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 03:39:59 -0800 (PST)
Date: Fri, 9 Jan 2026 12:39:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Ani Sinha <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 1/5] igvm: reorganize headers
Message-ID: <ioefbpwaopzgja4fslynfrwrsl4ybfyoqwzssw2da4ykw74zgt@zn64tdojictt>
References: <20251211105419.3573449-1-kraxel@redhat.com>
 <20251211105419.3573449-2-kraxel@redhat.com>
 <iaysdncdycow33aagzhxugt6cl5dbdx67o4m67to6qiklolew5@fqx5aivqrxkg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <iaysdncdycow33aagzhxugt6cl5dbdx67o4m67to6qiklolew5@fqx5aivqrxkg>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 11, 2025 at 12:13:32PM +0100, Luigi Leonardi wrote:
>Hi Gerd,
>
>On Thu, Dec 11, 2025 at 11:54:15AM +0100, Gerd Hoffmann wrote:
>>Add a new igvm-internal.h header file.  Structs and declarations which
>>depend on the igvm library header go into that file.
>>
>>Also declare IgvmCfg in typedefs.h, so the type can be used without
>>including igvm header files.
>>
>>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>---
>>include/qemu/typedefs.h        |  1 +
>>include/system/igvm-cfg.h      | 12 +-----------
>>include/system/igvm-internal.h | 26 ++++++++++++++++++++++++++
>>include/system/igvm.h          |  2 +-
>>backends/igvm-cfg.c            |  4 +++-
>>backends/igvm.c                |  2 ++
>>6 files changed, 34 insertions(+), 13 deletions(-)
>>create mode 100644 include/system/igvm-internal.h
>>

[...]

>
>Should we add `igvm-internal.h` to the MAINTAINERS file?

There is this entry in the MAINTAINERS file:

F: include/system/igvm*.h

It should already cover also the new `igvm-internal.h`, no?

Thanks,
Stefano


