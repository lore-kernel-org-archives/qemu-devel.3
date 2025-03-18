Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C245C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 10:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuUSA-00074V-1T; Tue, 18 Mar 2025 06:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tuUS7-00073Q-Oo
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:45:43 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tuUS6-0008H3-0Y
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742294737; x=1742899537; i=deller@gmx.de;
 bh=KrLNurgbaArcwczlNDm3KkVXMX/ZA32oyNwl/gb1jcI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AWs6ZcevXP4k+1wJti5A+g1oQGsgbg5Hpaw7O8AOUjvhoO0sRiqZlYZ5GoCM6qXG
 x0i7rNQHlO2k2Yeqvz6bt4G21IqiRM70TzJ2xkAyzw0Nco5Lk9Ndnd0JYsrUHBR/i
 JgnmA/8SVNbik1U2CgJ2u1/T4EjcFT0P76Bl6jyVI8XxIazZw3Yode5ziD5iHnxLg
 Tj8KqPfHEVu7yCYLOrDYOYB2qr57DTaN5P7SKUfRRmFLxKHU5/SZOuVOsgeV8aJfV
 rpPGT3Nz7AXmOKefhrTYWQtKpQDfkoPG3XRNODOu5r54IRdnqZ5z9vQ82BjPe7HQ+
 O0pmmmck0LM/eRfHeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.121]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1tdN0V27Tm-00WytN; Tue, 18
 Mar 2025 11:45:37 +0100
Message-ID: <8d9a17e3-c3b5-4b19-a253-6bde604d7d80@gmx.de>
Date: Tue, 18 Mar 2025 11:45:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Generic way to detect qemu linux-user emulation
From: Helge Deller <deller@gmx.de>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6ZhaBIBlsRhmQuQglvwX/pRNetoMii5OR2N1amm1a+wIf6hKQ9F
 WGeaMWUCGiAiX60ZFMU52MmaPFqT4PuPdGDqXEY+8cAlPBSP7qxiZ1lFQfAYnCptMVO5IRD
 ExPRRdWiLWqeptZUEj8zNvG5L955zo94Mvc6r6TnNQuATV1HSfnBbkkvxXvG0aIvSBqWlCq
 RLu2Hnt5vzoGU80vWTY9A==
UI-OutboundReport: notjunk:1;M01:P0:Cj2h1duEsAE=;IZ5sb+svY6UYTyi4umHP6MOpiNy
 h+9zCzNIJZ8x6SH47xBB1XzQH0314w6WHiSKG4R5h5wb5XZj0ZZzNrVuRNU0nTbClqNIXtRhE
 xfsYelNoutwavKHqFRinkWPFg8IWyHPdNr9dB19wZOwaqAkROD0V3IjNj+IjLcYQxtaqhHJXN
 +TujQF0sWWoVo/Y8tYjd+6GCYH63RAPenia49/BHA+0tXHuAre1CloAqiUC4EtadknPj7MNt5
 RskvDHPmCpzdzLMoiQ45cf8ujOgrPblT0mZmBcGxPldLFN6DlcGuyRsGiFPJDvJHfM1lBJ/0H
 brGELS9xnVhwBozvI1cEKMH358/fmNYu0a+XfuXlM76WQcKzGqN8U+CHJDAEB85KcUqxt6FVe
 9h/bebmfbeKX28hKUDTIR15rPwic7T48E4jzpCJYXw+iL3Lq8zxWvEbZY+D9US+0NY+4lkkyw
 YW4CygW43mCMQ34uyBhhxydXW5L6ibj/8pmqAfhS+hUExuifXW4Th87fqSt5p773w/bAO39RH
 SV7usYipjWE5BfUCJp4hvfkwYxbvyplCnqO6DTwPp27lnikJ9b2evOz3PElA08BQZlUg36GcL
 4MdgQ9EQ2eDyB6U++lTS3pSgO/9RCuYCRfjywSt+QMe1l8EFghHE1SPVCqIfi4imLd+Kbh5mS
 i8SBvdj5XxLpLDYeNI2resOqKcVHR8N2ZaNJKSSD7/DdUCPE3SrxiGtr4JcgkDrtcQ2LUE8pn
 wJdLP/Gyyh6QPfuGA+O+jkMGMDl+qwZp7LH/8kJWAEPgJBgCn++g/pWjy/+DqJiyQeSuyzkrO
 jBENuRvmFqRpvWgfapj72VKuvb9AuUjy7xAkjlfsDNA3QBe6mZiWKu+RFhTmHicAEHxFAMb13
 BNUUtfPPHZlaQyY4wj0hIXqDTLEPHOKzi0oSzrRrTZxJZa2XtGxZ1gCN48Y6xNwaUlLuup75K
 bJV6QwjySayUWAxfGBHPyLgIT2/+0kUX7kiirVvcKbX2ZeGIbpjNQY8RMenAowadzr1jMLy5M
 aCirXRhh5EIYCfXqQ23rg8ucS+b2VWHiabqo/HpyFTjoCkz6OrVWs3vLc2NlGx1bY1CoQ0pYd
 h41npiyjNgTqnA8dP81S/69ApHmF0GNtZBs1C9MFsr3uR6yEymtWlWeYhBLcpR/rBTsOqPiKT
 vUfvjBIfwX7bqr+L0noWB/WyDN53xjOyeWVQSnbSNXIo235lyC2nvD09iEBOcDpio8ZQe9ADe
 WkeBeRTZ+M5/3mKMCrgBRfPI3+EQAbOwt1zNYBsaL+E7Yjox3qIuI7kWzYTTTpc+9OcsxIfTm
 AANFNyh5yozkKcr0AdGv+WoietPzV3ls0qhXQ2f868CLkWeBXQYvDXXwq52zl9vTnYRNomfDl
 /2VFuOj3eO3PV+E6gddS1+QmJmQ6eSsv7eIpjxdSyYkYLjMHYr3Is/KUSyisO67SjeY7ICWj6
 jQFHgPAwkgukoBesuy7PkGRXJ7Vo=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/18/25 11:36, Helge Deller wrote:
> On 3/18/25 11:18, Andreas Schwab wrote:
>> Is there a generic way for a program to detect that is it being run
>> inside the linux-user emulation?
>
> Yes, having a reliable way to detect it would be good.

In qemu-user emulation we could change the return values of
"uname --processor" and/or "uname --hardware-platform".
Currently both always return "unknown", but in qemu we could
return the arch of the host.

Another possibility is to extend prctl(), but I think uname is
easier to handle in scripts and such...


> My current (unreliable) way to detect it is using uname.
> The kernel string and arch name don't match:
>
> (sid_hppa)root@paq:/# uname -a
> Linux paq 6.1.0-31-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.128-1 (2025-0=
2-07) parisc GNU/Linux
>
> (sid_hppa)root@paq:/# uname -r
> 6.1.0-31-amd64
>
> (sid_hppa)root@paq:/# uname -m
> parisc
>
> This is a qemu-linux-user parisc(hppa) emulation running on x86-64.
>
>> The purpose for that would be to work around limitations of the
>> emulation, like CLONE_VFORK being unsupported.
>
> yes, and robust futexes aren't supported either.
>
>> =C2=A0For example, python >=3D
>> 3.13 needs to avoid using posix_spawn in that case, because the
>> emulation of CLONE_VFORK as a true fork makes it impossible for it to
>> report errors back to the parent process.


