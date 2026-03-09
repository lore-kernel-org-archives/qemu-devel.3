Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D731F4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdcw-0000mP-KW; Mon, 09 Mar 2026 12:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzdcv-0000ko-FT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:38:41 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzdcs-0007rV-Nu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:38:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 22F455969E7;
 Mon, 09 Mar 2026 17:38:36 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id dv7MOcAMaZuh; Mon,  9 Mar 2026 17:38:34 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 22B985969ED; Mon, 09 Mar 2026 17:38:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 213465969E5;
 Mon, 09 Mar 2026 17:38:34 +0100 (CET)
Date: Mon, 9 Mar 2026 17:38:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
In-Reply-To: <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
Message-ID: <f9c9d581-294d-a813-2cfd-584fb57af743@eik.bme.hu>
References: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
 <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
> On 3/5/26 9:15 PM, Pierrick Bouvier wrote:
>> When using llvm-addr2line in replacement of addr2line, it will output
>> zero sized symbols, which can shadow other binaries depending on where
>> there location is (happens with arm-trusted-firmware and its different
>> binaries). Thus, those symbols.
>> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   contrib/plugins/uftrace_symbols.py | 2 ++
>>   1 file changed, 2 insertions(+)
>> 
>
> This was merged into master (a8ff516c2f5ec05fb8b8bf4bceb88f49701f80d6).

I doubt the usefulness of such messages. People will know when pulling 
from git and this list already has high enough volume. If you think this 
is useful for contributors could you please send such mails off list only 
to involved parties?

Getting messages about patches being queued is useful for other 
maintainers and contributors to know the patches are picked up and then 
they will also see the pull request on the list and when the pull request 
got merged. Getting separate messages for each patch in a pull request 
does not add more info to that for people already following the list.

Regards,
BALATON Zoltan

