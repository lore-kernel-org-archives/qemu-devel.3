Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A035CD2E9DC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 11:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tASeM-0000wc-Tv; Mon, 11 Nov 2024 06:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1tASeL-0000wQ-Hz
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1tASeI-0003v8-Rc
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731324721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=77u+Ybamg3SnlOdGxfWreE39YrZ5znNWUcRYMfeQaGQ=;
 b=CHAR1d7JmFMVtC1RvrghrzrZxgFuuPi6d44zMxm7TMss9pb5ktfGSR9thheHn8DskzBp7K
 Zm7CIhZHw/o0cYbx3SL5LPcSXRrTMbxfIyHXNJjfb8lx7/cW9SzeyEeJoRUKhl7JHt/qID
 ZUMqVWga3pl4KPJ/8qTNyGHrXV5kOWE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-tm6PUGOQMEW61GF6DQTtkg-1; Mon, 11 Nov 2024 06:30:49 -0500
X-MC-Unique: tm6PUGOQMEW61GF6DQTtkg-1
X-Mimecast-MFC-AGG-ID: tm6PUGOQMEW61GF6DQTtkg
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e2fc2b1ce1so4469181a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 03:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731324649; x=1731929449;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77u+Ybamg3SnlOdGxfWreE39YrZ5znNWUcRYMfeQaGQ=;
 b=u1cIUlp0XrYItb4QL2Ti/nNU83rzfuCz2qmPTYPy2WE+MrRz2HrjwFBdRHO3BCiDUZ
 oiKbw10wcdSYdZQmOXmhwVHjAHHVtTtnwb9QUdlQL2bJS/uMiOBGb9W/9el0/4meBSnz
 nTwiiQgFohbZhsnhYwsjELtcizvpXWNM0q70GuFn18/spCUtlrk/9ygnZXBPqeZ6SFsy
 j9Frn5EiSfCTAtJqv3PHlrWv7Wadxyp+gImSx5+gziHwuI733SSzFqpgmjGOHolVoE2H
 Q+yq8Ly3EVDZfJEsPMDBHgWVZbUZ3L0mUfezTIr0o2+Jmxl6P/OEOMKsEB5NCY4nz707
 kNBQ==
X-Gm-Message-State: AOJu0YywbmjHPLHy4WnmatTrUzKgHBY6SmDo8RtSGAbpJCAx3WntuJMY
 LswfyAxmmkUR4sTgWU8PhQr20HkQfUXlc87OLajNtw+6h0YLc/x1IlTi9hl7MeE9zTj+NkJASuD
 61HXCr2LgyLlnoTEp4sa+TDgyCuGxheyc2Ztr7otjXZ1b1KQspXzyeUdBMtoJc5AIUOS89D5Gzn
 G0DWvPN0hDfCqjMhJfQLXbVPobRQQ=
X-Received: by 2002:a17:90b:4b91:b0:2e1:d5c9:1bc4 with SMTP id
 98e67ed59e1d1-2e9b165595cmr16936839a91.7.1731324648742; 
 Mon, 11 Nov 2024 03:30:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp1O3lcWasaSxqsXXJ2kJpW+jUn2xIDr+NNQgALpXc6Z+Q10vpHCVURpGHCiq0ZV5YkYlqt6Vrbr1BkrAdENY=
X-Received: by 2002:a17:90b:4b91:b0:2e1:d5c9:1bc4 with SMTP id
 98e67ed59e1d1-2e9b165595cmr16936815a91.7.1731324648467; Mon, 11 Nov 2024
 03:30:48 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Nov 2024 06:30:47 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20241110174359-mutt-send-email-mst@kernel.org>
References: <20241108230314.1980-1-slp@redhat.com>
 <20241110174359-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 06:30:47 -0500
Message-ID: <CAAiTLFWnWpWByKMF3Y4uFkch0raw9+3w8nnnm8Ez1gPr-M+0Eg@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/elfboot: allocate "header" in heap
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=slopezpa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Sat, Nov 09, 2024 at 12:03:14AM +0100, slp@redhat.com wrote:
>> From: Sergio Lopez <slp@redhat.com>
>>
>> In x86_load_linux(), we were using a stack-allocated array as data for
>> fw_cfg_add_bytes(). Since the latter just takes a reference to the
>> pointer instead of copying the data, it can happen that the contents
>> have been overridden by the time the guest attempts to access them.
>>
>> Instead of using the stack-allocated array, allocate some memory from
>> the heap, copy the contents of the array, and use it for fw_cfg.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>
> Wow. How did this ever work?
>

I guess, for quite a while, we were just lucky that memory region wasn't
touched by the time the FW in the guest uses it (possibly helped by the
fact this happens very early in the VM lifetime). In recent
versions/builds this is no longer the case.

Sergio.


