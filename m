Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535D9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 18:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzh4d-0006ML-SN; Wed, 24 Apr 2024 14:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1rzh4c-0006M8-Gd
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 14:10:26 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1rzh4Z-0004HU-9E
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 14:10:26 -0400
Received: from [192.168.178.59] (p5b151e52.dip0.t-ipconnect.de [91.21.30.82])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id AC96BDA08C8;
 Wed, 24 Apr 2024 20:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim;
 t=1713982219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eNtNU6IbKddJX9LoXarIEzD9HBVA12Znf1HRYTNnXfo=;
 b=eQDMTWEMZEJ/qJEVfouUoZd+fIReuB2itccrUcUKZHdq32vT6vfKzk0K5PTZSfeN05L4F7
 CjFCfa8LpXMCP0gKrKxNrJTJoQpltU7Chbsz6OW2+1+7SGRW1kyjejUB5ZDNYNs4PA0QwG
 lQwsEbURR8LBTrigu4a7I+iunTp34hLtCIzsIeODU6fNZuac+34WAUuUkS8enQ7fbdKeUr
 O5Ep4HiAfdpQ64gv+0yFM4KbGK2hLfQoZPJpEoEVNXqw//0A65mvhI7l74djdD9kOCd9KC
 7EzWrjOt/XVCNKE9qA6MX5GzufzsUN9No4uFsOpe+TN6HI4g7Tvom3NJuKhrQg==
Content-Type: multipart/alternative;
 boundary="------------y6Cd9GBMMx8ff12c0qiG7tI2"
Message-ID: <ec748687-93eb-48cf-af47-419a4389ed6e@weilnetz.de>
Date: Wed, 24 Apr 2024 20:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Timeouts in CI jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA92aivDF-LjSrtZH6o4UtgrtcWnM2wuPZA5VOiN6j7KMA@mail.gmail.com>
 <f5926850-670b-43fa-8011-c33ba45d8fc3@weilnetz.de>
 <9692cfcb-ef59-4cec-8452-8bfb859e8a6c@weilnetz.de>
 <50ee3a92-1bb5-4113-8558-281e78b0c2e3@weilnetz.de>
 <Zik8s6_iNM8u0SZ6@redhat.com>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <Zik8s6_iNM8u0SZ6@redhat.com>
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------y6Cd9GBMMx8ff12c0qiG7tI2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.04.24 um 19:09 schrieb Daniel P. Berrangé:

> On Wed, Apr 24, 2024 at 06:27:58PM +0200, Stefan Weil via wrote:
>> I think the timeouts are caused by running too many parallel processes
>> during testing.
>>
>> The CI uses parallel builds:
>>
>> make -j$(expr $(nproc) + 1) all check-build $MAKE_CHECK_ARGS
> Note that command is running both the compile and test phases of
> the job. Overcommitting CPUs for the compile phase is a good
> idea to keep CPUs busy while another process is waiting on
> I/O, and is almost always safe todo.


Thank you for your answer.

Overcommitting for the build is safe, but in my experience the positive 
effect is typically very small on modern hosts with fast disk I/O and 
large buffer caches.

And there is also a negative impact because this requires scheduling 
with process switches.

Therefore I am not so sure that overcommitting is a good idea, 
especially not on cloud servers where the jobs are running in VMs.

> Overcommitting CPUs for the test phase is less helpful and
> can cause a variety of problems as you say.
>
>> It looks like `nproc` returns 8, and make runs with 9 threads.
>> `meson test` uses the same value to run 9 test processes in parallel:
>>
>> /builds/qemu-project/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 1
>> --num-processes 9 --print-errorlogs
>>
>> Since the host can only handle 8 parallel threads, 9 threads might already
>> cause some tests to run non-deterministically.
> In contributor forks, gitlab CI will be using the public shared
> runners. These are Google Cloud VMs, which only have 2 vCPUs.
>
> In the primary QEMU repo, we have a customer runner registered
> that uses Azure based VMs. Not sure on the resources we have
> configured for them offhand.

I was talking about the primary QEMU.

> The important thing there is that what you see for CI speed in
> your fork repo is not neccessarily a match for CI speed in QEMU
> upstream repo.

I did not run tests in my GitLab fork because I still have to figure out 
how to do that.

In my initial answer to Peter's mail I had described my tests and the 
test environment in detail.

My test environment was an older (= slow) VM with 4 cores. I tested with 
different values for --num-processes. As expected higher values raised 
the number of timeouts. And the most interesting result was that 
`--num-processes 1` avoided timeouts, used less CPU time and did not 
increase the duration.

>> In my tests setting --num-processes to a lower value not only avoided
>> timeouts but also reduced the processing overhead without increasing the
>> runtime.
>>
>> Could we run all tests with `--num-processes 1`?
> The question is what impact that has on the overall job execution
> time. A lot of our jobs are already quite long, which is bad for
> the turnaround time of CI testing.  Reliable CI though is arguably
> the #1 priority though, otherwise developers cease trusting it.
> We need to find the balance between avoiding timeouts, while having
> the shortest practical job time.  The TCI job you show about came
> out at 22 minutes, which is not our worst job, so there is some
> scope for allowing it to run longer with less parallelism.

The TCI job terminates after less than 7 minutes in my test runs with 
less parallelism.

Obviously there are tests which already do their own multithreading, and 
maybe other tests run single threaded. So maybe we need different values 
for `--num-processes` depending on the number of threads which the 
single tests use?

Regards,

Stefan

--------------y6Cd9GBMMx8ff12c0qiG7tI2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Am 24.04.24 um 19:09 schrieb Daniel P. Berrangé:</p>
    <blockquote type="cite" cite="mid:Zik8s6_iNM8u0SZ6@redhat.com">
      <pre class="moz-quote-pre" wrap="">On Wed, Apr 24, 2024 at 06:27:58PM +0200, Stefan Weil via wrote:
</pre>
      <blockquote type="cite"><span style="white-space: pre-wrap">
</span>
        <pre class="moz-quote-pre" wrap="">I think the timeouts are caused by running too many parallel processes
during testing.

The CI uses parallel builds:

make -j$(expr $(nproc) + 1) all check-build $MAKE_CHECK_ARGS
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Note that command is running both the compile and test phases of
the job. Overcommitting CPUs for the compile phase is a good
idea to keep CPUs busy while another process is waiting on
I/O, and is almost always safe todo.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Thank you for your answer.<br>
    </p>
    <p>Overcommitting for the build is safe, but in my experience the
      positive effect is typically very small on modern hosts with fast
      disk I/O and large buffer caches.</p>
    <p>And there is also a negative impact because this requires
      scheduling with process switches.</p>
    <p>Therefore I am not so sure that overcommitting is a good idea,
      especially not on cloud servers where the jobs are running in VMs.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:Zik8s6_iNM8u0SZ6@redhat.com">
      <pre class="moz-quote-pre" wrap="">Overcommitting CPUs for the test phase is less helpful and
can cause a variety of problems as you say.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">It looks like `nproc` returns 8, and make runs with 9 threads.
`meson test` uses the same value to run 9 test processes in parallel:

/builds/qemu-project/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 1
--num-processes 9 --print-errorlogs

Since the host can only handle 8 parallel threads, 9 threads might already
cause some tests to run non-deterministically.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
In contributor forks, gitlab CI will be using the public shared
runners. These are Google Cloud VMs, which only have 2 vCPUs.

In the primary QEMU repo, we have a customer runner registered
that uses Azure based VMs. Not sure on the resources we have
configured for them offhand.</pre>
    </blockquote>
    <p>I was talking about the primary QEMU.</p>
    <blockquote type="cite" cite="mid:Zik8s6_iNM8u0SZ6@redhat.com">
      <pre class="moz-quote-pre" wrap="">The important thing there is that what you see for CI speed in
your fork repo is not neccessarily a match for CI speed in QEMU
upstream repo.</pre>
    </blockquote>
    <p> I did not run tests in my GitLab fork because I still have to
      figure out how to do that.
    </p>
    <p>In my initial answer to Peter's mail I had described my tests and
      the test environment in detail.</p>
    <p>My test environment was an older (= slow) VM with 4 cores. I
      tested with different values for --num-processes. As expected
      higher values raised the number of timeouts. And the most
      interesting result was that `--num-processes 1` avoided timeouts,
      used less CPU time and did not increase the duration.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:Zik8s6_iNM8u0SZ6@redhat.com"><span
      style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">In my tests setting --num-processes to a lower value not only avoided
timeouts but also reduced the processing overhead without increasing the
runtime.

Could we run all tests with `--num-processes 1`?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The question is what impact that has on the overall job execution
time. A lot of our jobs are already quite long, which is bad for
the turnaround time of CI testing.  Reliable CI though is arguably
the #1 priority though, otherwise developers cease trusting it.
We need to find the balance between avoiding timeouts, while having
the shortest practical job time.  The TCI job you show about came
out at 22 minutes, which is not our worst job, so there is some
scope for allowing it to run longer with less parallelism.</pre>
    </blockquote>
    <p>The TCI job terminates after less than 7 minutes in my test runs
      with less parallelism.</p>
    <p>Obviously there are tests which already do their own
      multithreading, and maybe other tests run single threaded. So
      maybe we need different values for `--num-processes` depending on
      the number of threads which the single tests use?<br>
    </p>
    <p>Regards,<br>
    </p>
    <p>Stefan</p>
  </body>
</html>

--------------y6Cd9GBMMx8ff12c0qiG7tI2--

