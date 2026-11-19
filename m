Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8A606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xPQvgBG1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5JY-0000PB-U1; Thu, 19 Nov 2026 11:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU5JX-0000Om-0p
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:48:47 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU5JV-0004Tn-6j
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:48:46 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b4e18369c8so17248487b3.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:48:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795106924; cv=none;
 d=google.com; s=arc-20260327;
 b=oYQhFxO2sdHBnnSoClCGIls65THauU6f6ew9RuNg/Y/dUIUV2jkJFVTKDMg0Zkefjd
 3R7lxzSrOMDRTg0V7oI3GbvZk1034Rw3mbYODkn0vnI9+kT8c+Gae5TMYjGYXmw8XNAl
 d3GGWkyKbv4T8avK0re4JlAvKI6C6e7RfOBGECcSttLApnK0ykTHlJB90WazGFLaDrK9
 8oufjGjfrfd2HsHw9sucJ8/d5sq2ixXDscvGNDIgdLhpPhqfHlm8DZP+/XmZ0s6TUJeA
 ZRZpu6UcuANsG1+VnUR/ILOEmM6ao27mwbI1oBcM8OZgpC4NXlMTaAGrmy+Fc5ESiqD3
 GmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IvhSkC8okgKfKuEg19D0ret6PG0M7zmFKYS6DY3BJsY=;
 fh=jis90ebI1LXbWlN2f/uPaYiR3/160S3+nBo5cgb+Jhw=;
 b=gQXYHaM02YOzlqb+YlmpoMK6yQGSgGl6c/rdFtAp5AkJoZbMiKDh+xWA5Lbmvy/d1G
 DHhNjo2z4IUAobYVJxH57NcrV0sb8A7z6IkFdyBnBuzFSzkiUqPsSgOm6EEbRbSgvIK9
 cdE+6utVp8HzZsoTqVFqv9hjwo3okfuslVBmG1ZZD/XBDS5W1mjRKEwrqRDjfuefocQH
 49JfRPbX1L6v/HQfE7+vk94zMpat0wNH6Q50kYTgqZbyqHDUW0V//xtMU4gxmrM5BJN2
 P8PwQHjQ4E2Mmn9u7k7nCelO5IiA5a+UKTz1FymQaelRtg2MDIc+AvxBKQilmQRNLQw1
 iT0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795106924; x=1795711724; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IvhSkC8okgKfKuEg19D0ret6PG0M7zmFKYS6DY3BJsY=;
 b=xPQvgBG13wNnYPl8V+lUecCtWXdrte2J+ffWUyC84hai03p3yA7n36EDD6Hxu9vLQW
 8Jmv8xMYHe50WaXQ6KVBHVak+G6oYpaONJ9wwT1iPyjxvFIacMeloHWsdp+yTcfnPrPi
 zLYIUUS4/dqNYkcKzXpcReEfK0nOFEKHuQJH7hCvdcKKZcn6dzl9tWtoK7DM3Ajc1zxe
 A8pVAKDNcFA7BOxBDPN1OFN4/QkkzNIeF6Zh7oO/ZdTnqavBGOlGaeiMhoeVvrZ0URCk
 kCjksOtsKP9OkA3XEonNVwnddu00nX5QZY2OhJa+OGiusMGes5rTW6XW2hAYBGRXMwJO
 2zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106924; x=1795711724;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IvhSkC8okgKfKuEg19D0ret6PG0M7zmFKYS6DY3BJsY=;
 b=xAEvjzthSl1H9WgYcJdl0SalIHD5WZimKylD9lw/3zj32nnlmJWPMlCn0/teoWzix2
 9eoWIbjSWpTTveONTiKY0NmKNGLro5b/zSAUl1sUFnN7CD5f3HUrmiGczQetF1RKdzDM
 RHacZoI8oF0N3Xrhqhsflu5klBwBn9daAPtPDpnveI8wgMisyj6YcnSKj/RlndiFM4wQ
 uV/IGyI0YjYIp87rTDNVDFH0qoGKDS7IML5XSf/XicPKixrDByP+LDuiOXTzv/8sOh2N
 PnQYumqI8YwmEYeBJNxsiAdKdDDTOhfgtErAnNGD9LwnOqfQKvLEjBgmreBgfYj2I3gP
 rZ+w==
X-Gm-Message-State: APuU4Z+zJy9y9j12A97O40jIwUonxxq3zNCwWNtCSC57/VFxSU8RxVOj
 KGLQ4cx/qHJzQpr1BV+HUBQUbFPsLjnniXM1nMZyBf4YpHYzu0dIrqJMnX8Ke2nFQd6JJNu6Tc7
 yRXLE4Pd/GSUQJbm/BoyLVhbR5bA8fxVfqb7fwNE4/Q==
X-Gm-Gg: AZFdTZfaEoQa3WemFFr9UAezhSSelxtyINPM18Q/gLjQH2rSf0mrvHtgk4aQP+ltAOV
 w7Gq92Dp1GcBQn+Idk7prGk0GRnO7iJOKOLO+4uoYZYZUcNtbMOmrv2jhg3i2xizlg4C1d4Jud/
 TRcYVvtsV8EOP6d9oIWfYlz8esK+unEdRNsT9vsnJJ7nedqrm2Ejy9O8/kPH/HXJrRjB9jPQYat
 YOT2QsOdJCSO/uH6BT9KSWamNAharDduzc2o7YZZkbhfXsiY4KV3eNwrqtI8Jz4Gkxef8KPG8Xi
 ShDROtcGDsx2hSpTAGf2FoIfz64CRdlDY3UV1g3LlQR93zzU3VtTLRiN2xL5p/zApeQVZyccyVH
 EJ0HgvKgMAR5f6ZN1M4CushBVA6gESkke44WK890bjQWTiAmcpHRIphQjkCJ/unhu2LirV3Q6F4
 xUxm7WooVegfgxi9bG1k4KcQ==
X-Received: by 2002:a05:690e:11c5:b0:67d:ea8d:e43a with SMTP id
 956f58d0204a3-67df4468ebbmr23551d50.107.1795106923537; Thu, 19 Nov 2026
 08:48:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
 <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 16:48:31 +0000
X-Gm-Features: AclHuK9c-TrxuwXjtkXeqDXvhbo7V8q2XAeR4R3kGlPG6v8qfCqlBLJZClhRMbc
Message-ID: <CAFEAcA_8EAke9-dk-2HfkQ5BJyuODtcSK+DUcmYKRSKgEf=Wnw@mail.gmail.com>
Subject: Re: VMSTATE_VALIDATE failures on outbound migration
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 16:34, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Nov 19, 2026 at 03:37:43PM +0000, Peter Maydell wrote:
> > I'm going to fix the bug which is causing this specific failure,
> > but is it intentional/the right thing that we assert here rather
> > than simply aborting the attempted migration ?
> >
> > I can kind of see it either way:
> >  * we can't do this migration, but the VM itself might be fine
> >    and we might as well continue to let it run
> >  * failing a VMSTATE_VALIDATE field check on an outbound migration
> >    indicates that the device is in some unexpected state (i.e. one
> >    which we would reject on input), which might also be a problem
> >    for continued running of the VM; so err on the side of caution
> >    and treat it like an assertion failure, killing the VM
> >
> > I note that there is no documentation at all of VMSTATE_VALIDATE
> > unless you count the one-liner comment
> > "/* Validate state using a boolean predicate. */"
> >
> > and we use it in exactly seven places. This is the kind of
> > amount of usage where I feel like we should either be using it
> > a lot more, or not at all :-)
>
> I agree.
>
> I think assertion isn't good here, it's just that it was since 2014 and
> maybe we start to hit it only today?

We only hit it I think if either the validate function is buggy
or the device code is buggy. So we only hit it now because we made
a change in target/arm that exposed/created a bug.

> One reason being that as you said the assert behavior isn't described and
> not sure if it's always wanted, and also some corrupted device state may
> not always imply the VM is fully doomed.
>
> The other thing is I believe we have proper way to report errors now with
> either pre_save_errp() or post_load_errp().  We should use them.

The thing that occurred to me is that post_load_errp() only happens
after migration of the whole struct is done, and there might be
cases where you want to validate a field because you're about to
use it in a following field; for instance vmstate_hpet does:

        VMSTATE_UINT8(num_timers_save, HPETState),
        VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers_save, 0,
                                    vmstate_hpet_timer, HPETTimer),

and the hpet_validate_num_timers() function is checking the
incoming num_timers_save before we rely on it as the count
in the following VMSTATE_STRUCT_VARRAY_UINT8(). The use in
pcie_aer.c is also like that. However the uses in
target/arm/machine.c and hw/gpio/zaurus.c are just checking
incoming data for sanity and could be done in a post_load
hook instead.

thanks
-- PMM

