Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4FBC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 10:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukgoG-0007K1-UA; Sat, 09 Aug 2025 06:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ukgo2-0006Vi-RA
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 06:28:10 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ukgnz-0002ti-CG
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 06:28:06 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 579ARtUN057805
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 Aug 2025 19:27:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZWWBOldRQeUOMUA2ex8babqxKbMGUfc4fLuQjjlyQe4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754735275; v=1;
 b=DeEd1CM1nW26WLgtg2KFZo2qSPtUjM/l2r/Rye/ThgiH3N0/ZLzPYYnj0xZxyPzC
 rsULWVC/vcYO0Tf8W8JGrpXF5iMOUOLayS/XaQ6v3gN02rj2qsFlzvbIRRgza/1N
 5HMo0t3lYD1mKGkGgsjqM1N90VM502F6msZobqrZphgEU+w33HgMiBta9ATfMyRb
 l8v7GR2oHPOVjGhi6Nk46dUCj7orBtzapJOqprqu57mXwuw1xonCTMfsO1K8+QTe
 Kx8m5XAc/T25/6Qz2bLaS77Z3R8//mK427qvuT6/8FKJJRo6Q/f/c2D5cLc5zVaa
 HDpVaUTd58Tg2VP3k4N1cg==
Message-ID: <baeed4ff-9366-482c-9b08-85e0fdcc6ebb@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 9 Aug 2025 19:27:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] error: Kill @error_warn
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-13-armbru@redhat.com>
 <fcd5c891-b3c5-4b7d-a0ed-0e776d55ad5e@rsg.ci.i.u-tokyo.ac.jp>
 <875xewucar.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <875xewucar.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025/08/09 17:30, Markus Armbruster wrote:
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
> 
>> On 2025/08/08 17:08, Markus Armbruster wrote:
>>> We added @error_warn some two years ago in commit 3ffef1a55ca (error:
>>> add global &error_warn destination).  It has multiple issues:
>>>
>>> * error.h's big comment was not updated for it.
>>>
>>> * Function contracts were not updated for it.
>>>
>>> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>>>     error_prepend() and such.  These crash on @error_warn, as pointed
>>>     out by Akihiko Odaki.
>>>
>>> All fixable.  However, after more than two years, we had just of 15
>>> uses, of which the last few patches removed eight as unclean or
>>> otherwise undesirable.  I didn't look closely enough at the remaining
>>> seven to decide whether they are desirable or not.
>>>
>>> I don't think this feature earns its keep.  Drop it.
>>
>> I want to note that the following patch series temporarily use &error_warn during its conversion to add errp parameters:
>> https://lore.kernel.org/qemu-devel/20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com/
>> ("[PATCH v10 00/27] migration: propagate vTPM errors using Error objects")
>>
>> I think this series needs to be rebased on top of the migration change.
> 
> Thanks for the heads-up.
> 
>> I'm not sure if seven uses are insufficient to keep it.
>>
>> I also have a general impression that perhaps a special error destination for error_report_err() is more useful. Today, there are many functions use Error, but there are also functions that still follow old error handling patterns. When legacy functions call functions with Error, a common pattern is to use error_report_err() and return -1.
> 
> You mean like &error_fatal less the exit(1)?

Yes, that's what I meant.

> 
>> "[PATCH 01/12] monitor: Clean up HMP gdbserver error reporting" and "[PATCH 09/12] ui/pixman: Consistent error handling in qemu_pixman_shareable_free()" are examples that will benefit from error_report_err() as an error destination. The migration patch series I mentioned earlier can also use one.
>>
>> Perhaps it is nicer if there is an infrastructure shared by the special destinations. In particular, we can have common solutions for the three problems you pointed out:
>>
>>> * error.h's big comment was not updated for it.
>>>
>>> * Function contracts were not updated for it.
>>
>> For these two problems, they can refer to "special error destinations" instead of listing them, and delegate explanations of them to corresponding ones.
>>
>>>
>>> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>>>    error_prepend() and such.  These crash on @error_warn, as pointed
>>>    out by Akihiko Odaki.
>>
>> For this problem, Error can tell that it is a special destination by leaving msg NULL, for example. ERRP_GUARD() then rewrites errp it is not &error_abort and msg is NULL.
> 
> As I wrote, the defects are all fixable.  However, there has been so
> little use of &error_warn, and so much of it has been unclean or
> otherwise undesirable.  It's obviously prone to misuse.  I think we're
> better off without it.
> 
> See also the memo "Abuse of warnings for unhandled errors and
> programming errors" I posted yesterday.

It is insightful. The cover letter can have a reference to it and this 
patch can have similar description.

However I still have a few counterarguments:

A reason of the &error_warn usage may be caused by the complexity
to deal with unhandled errors and programming errors. If so, adding 
mechanisms to ease that may naturally sufficiently reduce the wrong 
usage added in the future.

The "&error_fatal without exit(1)" may be good enough for unhandled 
errors. For example, "[PATCH v10 00/27] migration: propagate vTPM errors 
using Error objects" would not have used &error_warn if there is the 
"&error_fatal without exit(1)".

There are also warn_report*() functions which also have the same 
problem. A comprehensive solution needs to deal with them all. Removing 
all of them will do but may not be practical. Another possibility is 
that to write a documentation telling warning should be avoided for 
unhandled/programming errors and let all refer to it.

I agree that there is little valid usage of &error_warn and removing it 
may not cause a problem at all, but it is still nice if there is a 
reasoning for the removal, ideally addressing these counterarguments as 
well.

