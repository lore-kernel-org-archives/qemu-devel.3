Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04157C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSaU-0006ZT-5F; Tue, 05 Mar 2024 06:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rhSaS-0006YX-HT
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:03:56 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rhSaN-00020B-Tm
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:03:56 -0500
Received: (qmail 23802 invoked by uid 484); 5 Mar 2024 11:03:30 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.749469 secs); 05 Mar 2024 11:03:30 -0000
Received: from nedpc1.intern.lauterbach.com (HELO [10.2.11.92])
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <alex.bennee@linaro.org>; 5 Mar 2024 11:03:28 -0000
Content-Type: multipart/alternative;
 boundary="------------1HBCzXk5TtmBmeOhS9H1Tb4o"
Message-ID: <76037a77-c8b2-4ee8-bbe3-0bf4f18cdf72@lauterbach.com>
Date: Tue, 5 Mar 2024 12:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/18] mcdstub: memory helper functions added
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian Boenig <christian.boenig@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-6-nicolas.eder@lauterbach.com>
 <87r0gv6wfc.fsf@draig.linaro.org>
Content-Language: en-US
From: "nicolas.eder@lauterbach.com" <nicolas.eder@lauterbach.com>
In-Reply-To: <87r0gv6wfc.fsf@draig.linaro.org>
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
--------------1HBCzXk5TtmBmeOhS9H1Tb4o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/02/2024 17:56, Alex Bennée wrote:

> I think there is some scope to re-factor some code that is shared with
> cpu_memory_rw_debug. In fact rather than using this to feed
> mcd_read_write_memory() maybe you really just want a
> cpu_physical_memory_rw_debug()?
>
> Although as you are going from vaddr anyway where does
> cpu_memory_rw_debug() fail for you?

Hi Alex, thanks for your feedback!

The reason I wrote the memory access the way I did is the following: 
Regardless of the state of the CPU, MCD always wants to be able to 
access all memory spaces (here secure and non-secure).

For example, if the CPU is currently in secure mode I still want to be 
able to perform a memory access via the non-secure memory space. This 
access should be successful, if a non-secure memory address is requested 
and unsuccessful, if a secure memory address is requested.

I could not get this decoupled memory access to work using the existing 
cpu_memory_rw_debug(). It only works properly when using the current 
main memory space (e.g. secure when the CPU is in secure mode).

I did not want to make changes to the existing memory functions because 
I think I could not have checked for all repercussions.

Best regards

Nicolas

--------------1HBCzXk5TtmBmeOhS9H1Tb4o
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>On 29/02/2024 17:56, Alex Bennée wrote:</p>
    <blockquote type="cite" cite="mid:87r0gv6wfc.fsf@draig.linaro.org">
      <pre>I think there is some scope to re-factor some code that is shared with
cpu_memory_rw_debug. In fact rather than using this to feed
mcd_read_write_memory() maybe you really just want a
cpu_physical_memory_rw_debug()?

Although as you are going from vaddr anyway where does
cpu_memory_rw_debug() fail for you?</pre>
    </blockquote>
    <p>Hi Alex, thanks for your feedback!</p>
    <p>The reason I wrote the memory access the way I did is the
      following: Regardless of the state of the CPU, MCD always wants to
      be able to access all memory spaces (here secure and non-secure).</p>
    <p>For example, if the CPU is currently in secure mode I still want
      to be able to perform a memory access via the non-secure memory
      space. This access should be successful, if a non-secure memory
      address is requested and unsuccessful, if a secure memory address
      is requested.</p>
    <p>I could not get this decoupled memory access to work using the
      existing cpu_memory_rw_debug(). It only works properly when using
      the current main memory space (e.g. secure when the CPU is in
      secure mode).</p>
    <p>I did not want to make changes to the existing memory functions
      because I think I could not have checked for all repercussions.<br>
    </p>
    <p>Best regards</p>
    <p>Nicolas<br>
    </p>
  </body>
</html>

--------------1HBCzXk5TtmBmeOhS9H1Tb4o--

