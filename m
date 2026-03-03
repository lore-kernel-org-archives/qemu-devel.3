Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A453EDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXIF-0007iv-UN; Tue, 03 Mar 2026 16:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxXID-0007ig-1y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxXIA-0005qP-QK
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772573313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9nkRjC4w6gdMipVmaH+SWgaMfofvXt8znyp0jQo8ho=;
 b=eBW2+sR/p9tOu1BL0phZk15JaWCUaHDbuD4Nzdxy92MxpMw5qy5fqBLE7fDE84IISp47+S
 36O2TSZsjarZ+KnBjDnbxBma5nwHKF7osI+ivc2KxKp67dM1+Od7zLQKc58DNzyUmuKlf7
 NPxsbYHlJ1BKLuhGsCVhywX+B8wdGoQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-e-MfOq0HNiqVexK0_0ekjw-1; Tue, 03 Mar 2026 16:28:31 -0500
X-MC-Unique: e-MfOq0HNiqVexK0_0ekjw-1
X-Mimecast-MFC-AGG-ID: e-MfOq0HNiqVexK0_0ekjw_1772573311
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899eacb58a5so321237696d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 13:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772573311; x=1773178111; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z9nkRjC4w6gdMipVmaH+SWgaMfofvXt8znyp0jQo8ho=;
 b=brovyIOZHC/Ca1JJ66jhmVBBcUEyrATQy8hsr3Y0vfJsrsemJOuV4ZhHGNi8XWNn7W
 d0/nrY8UzaIo6lVLKL+vSuq5D6BjVXQq/888JozW9ZLngu2+lf1Y/GjXc+fvIWz3lUtz
 AtFNzuQxAiYnzzEHRpQ//rcGbAcu2O54WE8hBVC/Yl2IFhz0sAoyNySZWWQRHxUUBZKY
 VIu5oQ+ymQcNz0mGnj6SE26JxQ4G/HeAGNNntHfx1WE65YBRyLsUMqzvWF2RZXfi7Bwc
 YksoXgycHmC91ooQFuuJ2nsoon45gnH0OOnF/OpxgpuIl7rTobNxe8u+0J7pxMtCjwFl
 Vd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772573311; x=1773178111;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z9nkRjC4w6gdMipVmaH+SWgaMfofvXt8znyp0jQo8ho=;
 b=AmjlzBYEqI5S/FlLfOeViET+yxpWU6MnzhkVKSEH2PbXdI6oAOLFuc+zYLHE7OyFWI
 mPQZkX0HeZl6XJfJSjdt7ioAaIPemgJAyVUjY5QYzZf7jg6NbkqETG6alQsI3m5z1ibh
 TTuYjjyJKdiP8pdHC5iE/xQVbFlrvsiI9HPubz4eZ6oMVoCuaRfd3Hm/YfLGdt12BfVZ
 6ozePNRurtI6AfApcoczwQpvhfiOPLDmiNj5AFP5snLM66e6vgM6Bs1tCwcv6Y2Ca8c5
 pPzUCvYlsMBn5JYpM2FG/DZhX2CMhZJxNuB8+vZci8s8QNTGZ4eOHfQLNuE4a/11V+i0
 cuqg==
X-Gm-Message-State: AOJu0YyNIg8ccqf3A9AcCnusLt44GBromOPQCnTW5Axk6fS3Jr2x8X/S
 BrwUPdnQ2e4/opRhoNLwBBudnbDcwVq1XIjfbhn93kTkSpc6ddx2w3E8eXf2qEbsdw5ktUXvimH
 uuDbqZQgwppkoi4BDNy6QDS1DHGTgqFi7niZgSKp1/CUt4OBDKfhibFsb
X-Gm-Gg: ATEYQzwP/Cl9LcVOjA+jTc2VrUFuDDQ7QV2VlCLfUWfrPiXzLekD3xKdVuuKBwGkThc
 lJeo1rKOH1XwAfGgvCfUcOqIcucObvMDhhZFeGtx9dbgdO3mtVXSatPMrWfEx1Xa8CpNMBPiLe+
 eKB53vBJj0Jf7fHaFFDOGw5KOxAVmm6a8dg70I6/4+1W9EvCDPsZcq03UUpP1qdvvA4vBNPw27X
 7LVJ5bxKlr6MGTXpdNPn9Bnd4ZaOZeuPHme3wG3lA/hL6Y0M0yCIbXqoJE2XdhK20bxW1W99QY8
 6QQcZgiuU9EDBlGl6uzEGmiXvUCwCyMSOLyi0HpNjiidhMRBQnb8D0j5Qgj88/xaj2XbKs96ToW
 aO4c7wybSLgRh+A==
X-Received: by 2002:ad4:4eea:0:b0:899:f354:331 with SMTP id
 6a1803df08f44-899f35405b5mr152384356d6.16.1772573310874; 
 Tue, 03 Mar 2026 13:28:30 -0800 (PST)
X-Received: by 2002:ad4:4eea:0:b0:899:f354:331 with SMTP id
 6a1803df08f44-899f35405b5mr152384056d6.16.1772573310431; 
 Tue, 03 Mar 2026 13:28:30 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c7374600sm141516446d6.29.2026.03.03.13.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 13:28:30 -0800 (PST)
Date: Tue, 3 Mar 2026 16:28:18 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 00/15] Make RamDiscardManager work with multiple sources
Message-ID: <aadScmxkeyWBFLeg@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 26, 2026 at 02:59:45PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> This is an attempt to fix the incompatibility of virtio-mem with confidential
> VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> 
> The first patches are misc cleanups. Then some code refactoring to have split a
> manager/source. And finally, the manager learns to deal with multiple sources.
> 
> I haven't done thorough testing. I only launched a SEV guest with a virtio-mem
> device. It would be nice to have more tests for those scenarios with
> VFIO/virtio-mem/confvm.. In any case, review & testing needed!
> 
> (should fix https://issues.redhat.com/browse/RHEL-131968)

Hi, Marc-André,

Just FYI that this series fails some CI tests:

https://gitlab.com/peterx/qemu/-/pipelines/2361780109

Frankly I don't yet know on why rust fails with this, maybe you have better
idea..  So I'll leave that to you..

===8<===
error: unused import: `InterfaceClass`
  --> rust/bindings/system-sys/libsystem_sys.rlib.p/structured/lib.rs:23:15
   |
23 | use qom_sys::{InterfaceClass, Object, ObjectClass};
   |               ^^^^^^^^^^^^^^
   |
   = note: `-D unused-imports` implied by `-D warnings`
   = help: to override `-D warnings` add `#[allow(unused_imports)]`
error: aborting due to 1 previous error
===8<===

The other thing is this series will generate tons of checkpatch issues,
almost only line width issues and unmaintained files, so they're trivial.
It seems to me it'll be nice if this series can land 11.0.  We have one
more week.

Please take a look when repost, thanks!

-- 
Peter Xu


