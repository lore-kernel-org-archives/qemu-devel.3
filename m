Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25002E9E31B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqBtL-0007OM-L1; Wed, 11 Feb 2026 10:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vqBtJ-0007Nu-G4
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:12:33 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vqBtH-00035v-Hv
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:12:33 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 47e0964333549dd0ef84bfdffdba1b26ce21007ec1f225a30a3990930689c101 with SMTP id
 698c9c55a460b99e99f17fd6; Wed, 11 Feb 2026 15:12:21 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1770822741;
 bh=I7YY5+GYruHggsnpdzoJOPyF8KTohy5pXyh+lIa19o4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=cYmrTiFuBP+c+zvWShPIUqe2RGH1EfOZnn+gVXQUkcn0bkY7pmH62bhLKvleenET7
 r8dt4QiUdzIKZwQDAHTbY3vSmNv9H5Wa5Usv4Aum8YaZ7WoJLxCwABRGPcllItfohc
 kbob9zc+MXmktZ00fi63/+2CS4LrVM5apVQlmyCtcUfdOaR80pM0pBCMdXDgTODhdQ
 yt0gVmdUAOHqYrtPY6sDgE9kU+P7RIdvA+8VRxhecVMt5WHuRruBljsHbD+Zv1f0iN
 mdimNSFOW07jJ2Qd4suURxZYHzRDJYO/9yXnpG+VTBxnmwnrdyyrkbKpeqmX5M9UQG
 vidhRfxXoZkvA==
Message-ID: <f64415bf-8c89-47ff-95b7-f362d51dc9bf@yodel.dev>
Date: Wed, 11 Feb 2026 09:12:19 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "rcu: Unify force quiescent state"
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jim MacArthur <jim.macarthur@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260209120336.41454-1-thuth@redhat.com>
 <0e63016c-2ca3-4074-8a5e-db46f22d8eda@linaro.org>
 <745fbb72-a977-4ec4-84ea-eefc33cf33a8@rsg.ci.i.u-tokyo.ac.jp>
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
In-Reply-To: <745fbb72-a977-4ec4-84ea-eefc33cf33a8@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.57;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k57.kb8c70eb.use4.send.mailgun.net
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

+Ilya (author of mentioned commit)

Hi, all

On 10/02/2026 05:14, Akihiko Odaki wrote:
> On 2026/02/10 20:04, Jim MacArthur wrote:
>> On 2/9/26 12:03, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> This reverts commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85.
>>>
>>> The commit introduced a regression in the replay functional test
>>> on alpha (tests/functional/alpha/test_replay.py), that causes CI
>>> failures regularly. Thus revert this change until someone has
>>> figured out what is going wrong here.
>>>
>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3197
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   I just hit this again in the CI:
>>>   https://gitlab.com/thuth/qemu/-/jobs/13018713844
>>>   ... it's annoying, so I'd like to suggest to revert the offending
>>>   patch 'til someone fixed this.
>>>
>>
>> Hi Thomas,
>>
>> I am actively investigating this problem, but haven't made any 
>> important progress so far. It's looking like a timing bug which is 
>> annoying to track down. All I know for certain at the moment is that 
>> faking some of the values returned by qemu_clock_get_ns to be 
>> deterministic improves the failure rate, but does not remove it 
>> entirely. I'm fine with this being reverted for now; we can add it 
>> back in once we figure out what the true cause is.
> 
> Thanks for investigating this. Let's have the commit reverted until 
> there is some progress:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 

After the quiescence commit, timeouts were the only regression, until
f098c32db48 ("target/s390x: Fix infinite loop during replay") when the
replay test began failing with error, too; maybe this serves as a
diagnostic trigger?

Yodel

