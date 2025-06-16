Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1FFC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRBMj-0002Zf-QV; Mon, 16 Jun 2025 11:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1uRBMg-0002Yy-P7
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:03:14 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1uRBMa-0003WI-OA
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=a5m9XCB4wcWxgkem6ZZqI0cx0G+T/qKg2WFGpGVAfys=;
 b=ee/xWOnzBfmhQRVHzrOQGAogYhQ0oANSJ0Gv4zT2avQrpx9tmyYB7wxEwc6E6R
 E3OLo+3b2h/r15gP2W0sJ8H7QMfevM4LeLrmxVc/OoctH18Ihnrl2voKFO2j06VB
 pa2ZQZKznEHcyeep8URe0N8T4Lb6DKzB11sHRe94SKdwU=
Received: from [192.168.8.103] (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgB3jUwYMlBokDLIAA--.29958S2;
 Mon, 16 Jun 2025 23:02:48 +0800 (CST)
Message-ID: <10b42a91-aea8-462b-95ca-ee7404ded299@yeah.net>
Date: Mon, 16 Jun 2025 23:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
To: Markus Armbruster <armbru@redhat.com>
Cc: Chao Liu <lc00631@tecorigin.com>, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, balaton@eik.bme.hu,
 qemu-devel@nongnu.org
References: <cover.1749800810.git.chao.liu@yeah.net>
 <87frg0w7rb.fsf@pond.sub.org> <7b5c0278-e2e9-4632-845b-73bf53c79525@yeah.net>
 <87h60fd9vv.fsf@pond.sub.org>
From: Chao Liu <chao.liu@yeah.net>
In-Reply-To: <87h60fd9vv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgB3jUwYMlBokDLIAA--.29958S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4DtF1xZF4rKw1xGw4xCrg_yoW8AF48pF
 y5Aa4DKan7JFyxXr1kt3WIqFy2yF1rtrZ5Wr1UKrWv9rn0yryxtr4xK3yY9F97Crs7Ar12
 vr4Yy3y7uFn8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsF4_UUUUU=
X-Originating-IP: [223.64.204.89]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiBAduKGhQKzEU0gAAsh
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 2025/6/16 22:44, Markus Armbruster wrote:
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
> 
> [...]

The main purpose of this patch is not to make the memory-region tree 
output easier for programs to parse.

Instead, it's to make the output clearer when there are many memory 
regions in the machine.

Right now, we use spaces for indentation, which makes it hard to see the 
hierarchy clearly — I want similar to how the tree command works.

During discussions with multiple threads, we also looked into more 
details, like avoiding the use of special characters.



