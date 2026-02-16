Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EF9E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 17:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs2pp-0002Ir-38; Mon, 16 Feb 2026 12:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vs2pn-0002II-7H
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:56:35 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vs2pk-0001rz-F1
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:56:34 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 9ce62a630647843b9e8642e249457cd130d627116186ee729f889660d8ed5cd5 with SMTP id
 69935a4d064eedcf2f3aafea; Mon, 16 Feb 2026 17:56:29 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1771264588;
 bh=sjabOpJebOr56va9ZGWq2za1iwpNkDpLKiauQXxZTG4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=bnWaNLv9b4l1QmTOWFaNZhhQjShFRRyNcfvtIbJYBa6uEmDcv/OTAQt0T0XSya3MO
 25wGvsEXooPmXgZ/2OFnWr5unkdJ+HJFlnTJNL1eMha9Ig4wPofHvT4CNK5CBRzZwt
 1GhWD5pNvLLADICY0oBeGfdO+PsI4kiuvqlduYgHmliwbeEdh/pxbNAEgcaeqowkT8
 RZOzJSIe1P0FjmQwDWNWjdToES/GpPUDZtiMfa0vHL9x/VAO/cqz7gN8R/5LYQ6w6J
 ohecIPJ+ywUlQAt8CgilGoQ06cwMi+YhGsiuoKGsPSTkREh4PPBEfK3NBoHb3cLJqr
 y3vIhb5ozgRaw==
Message-ID: <6ab90f3e-261a-46b1-b241-9adc3c5ecb59@yodel.dev>
Date: Mon, 16 Feb 2026 11:56:27 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "rcu: Unify force quiescent state"
To: Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jim MacArthur <jim.macarthur@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260209120336.41454-1-thuth@redhat.com>
 <0e63016c-2ca3-4074-8a5e-db46f22d8eda@linaro.org>
 <745fbb72-a977-4ec4-84ea-eefc33cf33a8@rsg.ci.i.u-tokyo.ac.jp>
 <f64415bf-8c89-47ff-95b7-f362d51dc9bf@yodel.dev>
 <7dfb9920-540b-4586-afc6-a60bb96c2921@yodel.dev>
 <8c52b80e-2792-48e8-a9f0-c8766af2cfda@redhat.com>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <8c52b80e-2792-48e8-a9f0-c8766af2cfda@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/02/2026 23:20, Thomas Huth wrote:
> On 16/02/2026 02.12, Yodel Eldar wrote:
> ...
>> Thomas and Akihiko, if it's alright with you, could we delay the PR of
>> the revert at least until we sort this out? I realize the erratic
>> timeouts are gumming up the CI, but maybe we could reduce the deltas of
>> the git history in short order if it's not too much trouble? I can
>> submit the patch in one to two days; I just want to make sure it's done
>> correctly.
> 
>   Hi!
> 
> Sorry, but it has already been reverted:
> 
>   https://gitlab.com/qemu-project/qemu/-/commit/ 
> ddb4d9d1748681cfde824d765af6
> 
> ... but that should not be a big deal, simply submit the patch again 
> once you've got a proper fix for the problem.
> 
>   Regards,
>    Thomas
> 
> 

Ah, it was already part of that set! Thanks for letting me know. I
suppose that softens the sense of urgency with the fix; nonetheless,
I'll aim for sooner rather than later.

I'm inclined to squash the fix into the re-introduction (especially when
the fix is small in scope), or should they be separate commits since the
original patch and the fix touch different subsystems? For the latter, I
think the fix can precede the re-introductory commit (as suggested by a
quick cherry-pick and replay test run), so as to avoid poisoning
bisectability.

Yodel

