Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CFCC71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAAw-0007nI-7d; Mon, 16 Jun 2025 09:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1uRAAl-0007mq-Ak
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:46:51 -0400
Received: from mail-m16.yeah.net ([1.95.21.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1uRAAc-0000mC-WF
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=r6qMdGH9R3vGJgRi0ixioQwlBdPEwIcR3i2XKKFkfEk=;
 b=YfPvidzT9DPZZmT7T5GoPnaws4MhXaBNLs/e6vZxgv4ljaXhmG3FSBrVcPVfJ2
 a8Nhl53aCU3aRyyJ5DxknWC9ZIAWd8FdH33tBZ7Kco/N/9dbcglDDIhnv/V7hOkV
 2ZTbrSnM+cjcEF0cMgs54Vo+yBS9JPxC0YqBH0U/AG46k=
Received: from [192.168.8.103] (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgD3XzwFIFBoxy3DAA--.40708S2;
 Mon, 16 Jun 2025 21:45:42 +0800 (CST)
Message-ID: <7b5c0278-e2e9-4632-845b-73bf53c79525@yeah.net>
Date: Mon, 16 Jun 2025 21:45:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
To: Markus Armbruster <armbru@redhat.com>, Chao Liu <lc00631@tecorigin.com>
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, balaton@eik.bme.hu, qemu-devel@nongnu.org
References: <cover.1749800810.git.chao.liu@yeah.net>
 <87frg0w7rb.fsf@pond.sub.org>
From: Chao Liu <chao.liu@yeah.net>
In-Reply-To: <87frg0w7rb.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgD3XzwFIFBoxy3DAA--.40708S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4kJw4fKw1kZrWDCFW8Crg_yoW8GrW7pF
 yUAa1Dtan7XFy5XF1kt3WSqFy2vFW3Gr98KF4DKF929Fn8CFyIqr4xKrWF9F9rurs7Aw12
 vFW5t343A3Z3XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjq2NUUUUU=
X-Originating-IP: [223.64.204.89]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiNQY3X2hQIAbvvgAA3U
Received-SPF: pass client-ip=1.95.21.16; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/6/16 13:55, Markus Armbruster wrote:
> Chao Liu <lc00631@tecorigin.com> writes:
> 
>> From: Chao Liu <chao.liu@yeah.net>
>>
>> Hi, all:
>>
>> After several rounds of discussion, I think that adding a -t option to the
>> `info mtree` command, which enables the display of tree-like node characters
>> (e.g., +--, |--), is a better approach.
>>
>> As BALATON Zoltan pointed out, retaining space-based indentation for displaying
>> memory region (mr) nodes helps ensure that the output remains easily parseable
>> by other programs. This also provides better compatibility with existing tools
>> and scripts.
> 
> If people really feed the output of HMP info mtree to parsers, we should
> probably provide the information via QMP.
> 

Thank you for your helpful advice. I think the next step is to try 
implementing "info mtree" via QMP first, and then have it called by HMP.

I’ve added it to my to-do list, and I’ll try to implement it using QMP 
in the next phase.

>> Users can choose between:
>>
>> - Without '-t': The default format using spaces for indentation, suitable for
>>    scripting and parsing;
>> - With '-t': The tree-style format using visual characters, ideal for
>>    human-readable output.
>>
>> This way, both usability and compatibility are preserved.
> 
> Maintaining compatibility is a choice in HMP, not a requirement.  I'm
> not judging, mind.


