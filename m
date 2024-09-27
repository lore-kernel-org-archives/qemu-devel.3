Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D203CDD1B8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 14:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suCBx-00084P-VI; Fri, 27 Sep 2024 10:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1suCBv-00083t-97
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 10:43:31 -0400
Received: from mail-m16.yeah.net ([1.95.21.17])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1suCBr-0007XX-KO
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 10:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 From; bh=ALZBECrXNG2fIf74OBY7nYe5G87DilkzbqiOtCZ4azk=; b=XetygEu
 2dIi3hBVezJFaLy+m7Es3GoLuEaxikMCyjK+oyJFrDeuS9R6Ka0XYYXLc6DxToFy
 TuiFB2vNPJbbOtpcwnOQWAUfgKcG8ir7nlaREu0t9BYhgqHPH79At3uX9k5LAlaa
 eNbF4hFSXTwty78fnlb23n7haiWRxi7T1A58=
Received: from [192.168.1.27] (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgCXt+Z9xPZmTMs6AQ--.50452S2;
 Fri, 27 Sep 2024 22:43:10 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------tKrdrrMF4xOvByzALLZqtXhK"
Message-ID: <f3a856aa-52c0-43a0-be32-0610e38c8bcd@yeah.net>
Date: Fri, 27 Sep 2024 22:43:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 0/2] Drop ignore_memory_transaction_failures for
 xilink_zynq
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me
References: <cover.1727425255.git.chao.liu@yeah.net>
 <CAFEAcA8Kb-ym=Zd1TzcWuqRVbaKAG4TDF3VmZ8EfnBWW-B_Cyg@mail.gmail.com>
 <c9bfa6ba-7399-4edb-a882-7cb11e9d7b58@yeah.net>
 <CAFEAcA-Eod5HrhsNzPcrszTLS2G2+n=87svbfUEs8BhA=F_MwQ@mail.gmail.com>
From: Chao Liu <chao.liu@yeah.net>
In-Reply-To: <CAFEAcA-Eod5HrhsNzPcrszTLS2G2+n=87svbfUEs8BhA=F_MwQ@mail.gmail.com>
X-CM-TRANSID: M88vCgCXt+Z9xPZmTMs6AQ--.50452S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4UKrykGr1ftF4DJrW5ZFb_yoW5Gr4xpr
 Z5KFyUKrZ7Kryvyw4kXwsFqFZ8ArWF93y3GF48Gw109398uFyrZrW0k39Fvas8Arnaka13
 ZrWjqrs8Z3WqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07juCJPUUUUU=
X-Originating-IP: [117.173.247.123]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiCRhnKGb2kYRoDwABs9
Received-SPF: pass client-ip=1.95.21.17; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------tKrdrrMF4xOvByzALLZqtXhK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/27 22:20, Peter Maydell wrote:

> On Fri, 27 Sept 2024 at 15:03, Chao Liu<chao.liu@yeah.net> wrote:
>> On 2024/9/27 20:18, Peter Maydell wrote:
>>> On Fri, 27 Sept 2024 at 09:52, Chao Liu<chao.liu@yeah.net> wrote:
>>> Even if our test set is not sufficiently comprehensive, we can create an
>>> unimp_device for the maximum address space allowed by the board. This prevents
>>> the guest system from triggering unexpected exceptions when accessing
>>> unimplemented devices or regions.
>> What would be the benefit of doing that? If we're going to
>> say "we'll make accesses to regions without devices not
>> generate faults", the simplest way to do that is to
>> leave the ignore_memory_transaction_failures flag set
>> the way it is.
>> Introducing this flag provides a straightforward way to suppress
>> memory access exceptions by checking if the flag is enabled after
>> a CPU memory access failure; however,its primary purpose is to
>> ensure compatibility.
>> Since we can designate unimplemented device memory ranges with
>> "unimplemented-device," this represents a more standard approach in QEMU
>> for managing RAZ/WI behavior.
> I don't think that using a 4GB unimplemented-device is
> a "more standard" way to do this. We have a standard way for
> the board model to say "we don't know whether there might
> be existing guest code out there that relies on being able
> to make accesses to addresses where there should be a device
> but we haven't modeled it". That way is to set the
> ignore_memory_transaction_failures flag.
>
> There are two things we can do:
>
> (1) We can leave the ignore_memory_transaction_failures
> flag set. This is safe (no behaviour change) but not the
> right (matching the hardware) behaviour. The main reason
> to do this is if we don't feel we have enough access to
> a range of guest code to test the other approach.
>
> (2) We can clear the flag. This is preferable (it matches the
> hardware). But the requirement to do this is that
>   (a) we must make the best effort we can to be sure we've
>       put unimplemented-device placeholders for specific
>       devices we don't yet model (by checking e.g. the
>       hardware documentation for the SoC and board model,
>       the device tree, etc)
>   (b) we do the most wide-ranging testing of guest code that
>       we can. This checks that we didn't miss anything in (a).
>
> I don't mind which of these we do. What I was asking in my
> comments on version one of your patch was for how we were
> doing on requirement 2b.
>
> thanks
> -- PMM

I understand! I will provide more comprehensive testing methods
and results as soon as possible and will get back to you.

Best regards,
Chao Liu

--------------tKrdrrMF4xOvByzALLZqtXhK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>On 2024/9/27 22:20, Peter Maydell wrote:</pre>
    <blockquote type="cite"
cite="mid:CAFEAcA-Eod5HrhsNzPcrszTLS2G2+n=87svbfUEs8BhA=F_MwQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 27 Sept 2024 at 15:03, Chao Liu <a class="moz-txt-link-rfc2396E" href="mailto:chao.liu@yeah.net">&lt;chao.liu@yeah.net&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 2024/9/27 20:18, Peter Maydell wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Fri, 27 Sept 2024 at 09:52, Chao Liu <a class="moz-txt-link-rfc2396E" href="mailto:chao.liu@yeah.net">&lt;chao.liu@yeah.net&gt;</a> wrote:
Even if our test set is not sufficiently comprehensive, we can create an
unimp_device for the maximum address space allowed by the board. This prevents
the guest system from triggering unexpected exceptions when accessing
unimplemented devices or regions.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
What would be the benefit of doing that? If we're going to
say "we'll make accesses to regions without devices not
generate faults", the simplest way to do that is to
leave the ignore_memory_transaction_failures flag set
the way it is.
</pre>
      </blockquote>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Introducing this flag provides a straightforward way to suppress
memory access exceptions by checking if the flag is enabled after
a CPU memory access failure; however,its primary purpose is to
ensure compatibility.
</pre>
      </blockquote>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Since we can designate unimplemented device memory ranges with
"unimplemented-device," this represents a more standard approach in QEMU
for managing RAZ/WI behavior.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I don't think that using a 4GB unimplemented-device is
a "more standard" way to do this. We have a standard way for
the board model to say "we don't know whether there might
be existing guest code out there that relies on being able
to make accesses to addresses where there should be a device
but we haven't modeled it". That way is to set the
ignore_memory_transaction_failures flag.

There are two things we can do:

(1) We can leave the ignore_memory_transaction_failures
flag set. This is safe (no behaviour change) but not the
right (matching the hardware) behaviour. The main reason
to do this is if we don't feel we have enough access to
a range of guest code to test the other approach.

(2) We can clear the flag. This is preferable (it matches the
hardware). But the requirement to do this is that
 (a) we must make the best effort we can to be sure we've
     put unimplemented-device placeholders for specific
     devices we don't yet model (by checking e.g. the
     hardware documentation for the SoC and board model,
     the device tree, etc)
 (b) we do the most wide-ranging testing of guest code that
     we can. This checks that we didn't miss anything in (a).

I don't mind which of these we do. What I was asking in my
comments on version one of your patch was for how we were
doing on requirement 2b.

thanks
-- PMM</pre>
    </blockquote>
    <pre>I understand! I will provide more comprehensive testing methods
and results as soon as possible and will get back to you.

Best regards,
<span style="white-space: pre-wrap; word-break: break-word !important;">Chao Liu</span></pre>
  </body>
</html>

--------------tKrdrrMF4xOvByzALLZqtXhK--


