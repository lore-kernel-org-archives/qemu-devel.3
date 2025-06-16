Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECE6C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 16:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRCNg-00011i-L6; Mon, 16 Jun 2025 12:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uRCNW-0000zk-3y
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 12:08:10 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uRCNT-00076D-C4
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 12:08:09 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 871C255BC02;
 Mon, 16 Jun 2025 18:08:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id kNt1dszGFg5S; Mon, 16 Jun 2025 18:08:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 730AC55BC04; Mon, 16 Jun 2025 18:08:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 70EF6745683;
 Mon, 16 Jun 2025 18:08:00 +0200 (CEST)
Date: Mon, 16 Jun 2025 18:08:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
cc: Chao Liu <chao.liu@yeah.net>, Chao Liu <lc00631@tecorigin.com>, 
 pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
In-Reply-To: <87h60fd9vv.fsf@pond.sub.org>
Message-ID: <c9fb8902-1be1-2ab3-b926-007933eb6475@eik.bme.hu>
References: <cover.1749800810.git.chao.liu@yeah.net>
 <87frg0w7rb.fsf@pond.sub.org> <7b5c0278-e2e9-4632-845b-73bf53c79525@yeah.net>
 <87h60fd9vv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-895894624-1750090080=:43703"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-895894624-1750090080=:43703
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 16 Jun 2025, Markus Armbruster wrote:
> Chao Liu <chao.liu@yeah.net> writes:
>
>> On 2025/6/16 13:55, Markus Armbruster wrote:
>>> Chao Liu <lc00631@tecorigin.com> writes:
>>>
>>>> From: Chao Liu <chao.liu@yeah.net>
>>>>
>>>> Hi, all:
>>>>
>>>> After several rounds of discussion, I think that adding a -t option to the
>>>> `info mtree` command, which enables the display of tree-like node characters
>>>> (e.g., +--, |--), is a better approach.
>>>>
>>>> As BALATON Zoltan pointed out, retaining space-based indentation for displaying
>>>> memory region (mr) nodes helps ensure that the output remains easily parseable
>>>> by other programs. This also provides better compatibility with existing tools
>>>> and scripts.
>>>
>>> If people really feed the output of HMP info mtree to parsers, we should
>>> probably provide the information via QMP.
>>
>> Thank you for your helpful advice. I think the next step is to try implementing "info mtree" via QMP first, and then have it called by HMP.
>>
>> I’ve added it to my to-do list, and I’ll try to implement it using QMP in the next phase.
>
> First question before you actually do that: use cases for feeding the
> information to programs?  You might have answers already; I'm not on top
> of prior conversations.

My request was to not make the output much wider than it is now as that 
would result in broken lines and less readable output. The comment was not 
about parsing output but keeping the result fit in not too wide terminals 
as 64 bit addresses makes it wide already. Thus replacing spaces with tree 
chars is OK with me as long as no new vertical space is added. The first 
version of patch increased vertical space. Using ASCII chars was request 
from somebody else but that makes the output look less nice so I'm not 
sure it worth the change with that. Maybe leaving current output then 
adding a separate tree mode with the original line drawing chars could 
satisfy all preferences.

Regards,
BALATON Zoltan
--3866299591-895894624-1750090080=:43703--

