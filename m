Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F21606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HRIRKzjg;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OxDxRRFD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU55J-0004z3-6N; Thu, 19 Nov 2026 11:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU55G-0004yQ-GY
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:34:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU55F-0007l3-0z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795106039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XCSb5MiWwS6gseGMa77SFYerUnlhO9N48po/bsMFrpE=;
 b=HRIRKzjgsX3MBzeG8eNDX1YpkjQGcMJWlfKQ/k9sP6OJop2adraNjcYI/N6mn3vK4sjvsz
 1p6Zg8GevcKRTN4UVuupEzWn5BtwMSrzLC7GUA90wZc6tRi3hPQx0Xu9n3TSfrA2+jFxVH
 MLr5Z2CVXXaabT816CyOXpDlcBlDsyY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-0T7oFN_BOCSNSPrM5DgzPQ-1; Thu, 19 Nov 2026 11:33:57 -0500
X-MC-Unique: 0T7oFN_BOCSNSPrM5DgzPQ-1
X-Mimecast-MFC-AGG-ID: 0T7oFN_BOCSNSPrM5DgzPQ_1795106037
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-921052e3e92so335286d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795106037; x=1795710837; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XCSb5MiWwS6gseGMa77SFYerUnlhO9N48po/bsMFrpE=;
 b=OxDxRRFD3gPWovNV2qvFWNmtuMQpg3FNZUyNBlPOCww0Oglux+E+i0/e0G24X8g3TS
 +EgjNqfLLf0OtjkhCy7Zd++NiP20s1ra6xF9JMHxvvSSIWVPQvIsj3p44C1oN58b9DJW
 6nef7L4IHaKdiqxm43F8/Gaz8DEsCvweThnp9cmUeMiIh/X8dIB85xG9SFVSd/+/Jb+3
 FTNRtvABVnGoLWUf43Nz3NUUGA75uWoEroNMpEdg8a9M6DZiSX7SatDIm7CYlAp1xCz4
 5hUFW2CaEt7WtI65+3tabK7lYA4TPzgRrIA5pmNFFA6u+AHC9wywxzLPZmRrBY5qZNi4
 B1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106037; x=1795710837;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XCSb5MiWwS6gseGMa77SFYerUnlhO9N48po/bsMFrpE=;
 b=Y7ppd4DFM1GPIdNymWaCyidQ0+cX3lrmjJZGzi2rlwduzI/+fOVQZduRfTjiAPrQ3I
 cv9iT0cmTkQJGMglsHPeic9EOhZEfhHA46+j0s0hYx4jM2r9EaWyUOQwO5j57ZjCXMPw
 /TX1tJyYQjxkoxdPKgi7QN+mNMbqpCVOaFwSGm2FpTVKoZEwbTqwmPBeDw9+xFQVe+8B
 KHstrwBSHI6wSR02RAgASKJgETvt70WL5oj80HMh7QYVJNQkXJVh4DZiyOdBwEQMlJV5
 Ex77qzb9gY9h5OwjVVwBequEoLaIgfl2MimAfSGdxBd8QZvNPRzsXm+ha2a7jaq7QrUu
 jXKQ==
X-Gm-Message-State: APuU4Z8hKWZ41p/F9EcW1324U3htOdWRI8SmWl9WDOm2lkMlhznzHtfC
 f8LGDuk9QinB6xjkADr96ZnTwYP8F+sxKVkGCUafF+aijPyY9q0H7Y9NHTe6aP7DqDCB6tY6qcJ
 +hH6XaXtuKH947HpVIDdx/r1QGar+z4sGsebTRgtVf9M1+UzBIDw6khnB7brYqmMY
X-Gm-Gg: AZFdTZdIXIgj7CFlUDl7QJbRcqbj4Pn+sH4EwDDOcEcwahL9DgI+wUB++hU41Ic/twc
 rdPi12KV/KA9WYgAiBX8qUnvnwj7CMR7E5kF2XnPHVOeEgvz/8IMUD1U+6zweE/25LWfisFzJBX
 lFLj7j4enBMwq2O2YcXTtZFUjTg6jUb3yqpPnhL2nREg4OYPIhh2qjgNt9qOBNupo9ELtaf6282
 8Pt3T8gNFd4IiNzp79wZwVOjxkW5NoIGnAIJggaG3F7otKK2god6XUd3Qcs+FH3Cs/jczsmm+wa
 NeuZccIWvzIw3eh2IklMwoystevu9rGV6K/2ONIdSJS/fOD0KTdIDq4mXDrr8gKa7lDPNYAXCuw
 j5Y+GHvnp1k/ro83UXB1O1ATBcWX2hchHcdBIIzJ2nUrE
X-Received: by 2002:a05:6214:2522:b0:921:156f:7d5a with SMTP id
 6a1803df08f44-92134af6b50mr1160406d6.41.1795106037002; 
 Thu, 19 Nov 2026 08:33:57 -0800 (PST)
X-Received: by 2002:a05:6214:2522:b0:921:156f:7d5a with SMTP id
 6a1803df08f44-92134af6b50mr1159586d6.41.1795106036248; 
 Thu, 19 Nov 2026 08:33:56 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a24aa8sm1455006d6.42.2026.11.19.08.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:33:55 -0800 (PST)
Date: Thu, 19 Nov 2026 11:33:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: VMSTATE_VALIDATE failures on outbound migration
Message-ID: <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 03:37:43PM +0000, Peter Maydell wrote:
> Currently if a test function used by a VMSTATE_VALIDATE() macro
> fails during an attempted outbound migration, QEMU will die with
> an assertion failure. As an example of this, as of git commit
> 08c9bbb825148dec you can provoke one with the microbit machine type:
> 
> $  (sleep 1; echo 'migrate "exec:cat >/dev/null"'; sleep 3; echo quit)
> | ./build/arm/qemu-system-arm -M microbit -display none -monitor stdio
> -S
> QEMU 11.1.91 monitor - type 'help' for more information
> (qemu) migrate "exec:cat >/dev/null"
> qemu-system-arm: Output state validation failed: cpu/pmsav7/rgnr is valid
> qemu-system-arm: ../../migration/vmstate.c:817: vmstate_save_vmsd_v:
> Assertion `!(field->flags & VMS_MUST_EXIST)' failed.
> 
> Aborted (core dumped)
> 
> 
> I'm going to fix the bug which is causing this specific failure,
> but is it intentional/the right thing that we assert here rather
> than simply aborting the attempted migration ?
> 
> I can kind of see it either way:
>  * we can't do this migration, but the VM itself might be fine
>    and we might as well continue to let it run
>  * failing a VMSTATE_VALIDATE field check on an outbound migration
>    indicates that the device is in some unexpected state (i.e. one
>    which we would reject on input), which might also be a problem
>    for continued running of the VM; so err on the side of caution
>    and treat it like an assertion failure, killing the VM
> 
> I note that there is no documentation at all of VMSTATE_VALIDATE
> unless you count the one-liner comment
> "/* Validate state using a boolean predicate. */"
> 
> and we use it in exactly seven places. This is the kind of
> amount of usage where I feel like we should either be using it
> a lot more, or not at all :-)

I agree.

I think assertion isn't good here, it's just that it was since 2014 and
maybe we start to hit it only today?

One reason being that as you said the assert behavior isn't described and
not sure if it's always wanted, and also some corrupted device state may
not always imply the VM is fully doomed.

The other thing is I believe we have proper way to report errors now with
either pre_save_errp() or post_load_errp().  We should use them.

I'll prepare some patches to remove them, concurrently with your fixes to
be sent for the device.

Thanks,

-- 
Peter Xu


