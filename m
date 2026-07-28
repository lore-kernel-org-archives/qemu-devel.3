Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DF1C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonrq-0004va-4Y; Tue, 28 Jul 2026 15:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wonrk-0004uw-NW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:53:28 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wonri-0007ed-CM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785268403; x=1785873203; i=deller@gmx.de;
 bh=ejfCPWXVjMVQSMJUh/jfP9dObJsFT1eRhBVecq5qjOA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QdZyHgt3jYdPQSE3j7VmImGmV13T/kBd6GlMWOy1T3suwNfSwWECemXzV0d3mk3T
 gRUnYmfr0oUH9yZShO1et9mwHC42l3LqBND0k2Ll1qrxGBqopM0b0XtbwRX/vUkqT
 eMZmrRQkN0Wxb7ZBQKqxy7vMS9fODlT7pkCI07G/1jX4631cSDul1Zv0nt6QE87xF
 wPjHGuNkr/A07opfKQN9QwIgOYvFNo6QnFQ1/VH/Q3IG2XS5A87AHmrDHpu/0JBea
 iKwRx5PZ/9FQzWa1fBLV95Q2UCJVsyljNe/bqbrFnpIS76PypUkQNMqbIY73ECZWn
 peQXxWW0jYem4fkJrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1wmawV0R2W-007i0t; Tue, 28
 Jul 2026 21:53:23 +0200
Message-ID: <ad9b4545-7591-4973-801f-5b83420f5d38@gmx.de>
Date: Tue, 28 Jul 2026 21:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
From: Helge Deller <deller@gmx.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 no92 <leo@managarm.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20260724160105.3787888-1-leo@managarm.org>
 <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
 <a0adc88a-4405-46cc-b46c-6981f310db8f@gmx.de>
 <0207e5f3-3029-4f14-81ed-fb469a02e6fe@oss.qualcomm.com>
 <18f6f24c-4324-4883-aba2-9c4470514f29@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <18f6f24c-4324-4883-aba2-9c4470514f29@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5vIdR4mR7097m0I+QId+yBkYT9abQSehpVru7fhT1LoReEQ5kr+
 MEUsO0+7IyCui9u0nZrg+cW/FUdoyrL6zsY9NPUiBEZI24NgmKIZfTyBpR9aSF1KKys/mT2
 BfWwyCpfULnQ3NQ2ZQFw/XICBmstMxswMCcmK00Hs+5BuOC8lVqvPs92Acz3X7U5CgxX+GI
 heu5yaoOnFzuUJ1cFfPDQ==
UI-OutboundReport: notjunk:1;M01:P0:0YSU3AB3XI0=;ta3zfU6yqVnMgF9RijhH7vpZJbG
 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
 =
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/26/26 15:17, Helge Deller wrote:
> On 7/25/26 00:26, Pierrick Bouvier wrote:
>> On 7/24/2026 2:42 PM, Helge Deller wrote:
>>> On 7/24/26 18:48, Pierrick Bouvier wrote:
>>>> On 7/24/2026 9:01 AM, no92 via qemu development wrote:
>>>>> The members are declared as __kernel_pid_t in Linux UAPI headers.
>>>>> Analogous members in struct target_shmid_ds (shm_[cl]pid) are also
>>>>> declared as abi_int.
>>>>>
>>>>> Fixes: 1c54ff97bbde ("linux-user: fix and cleanup IPCOP_msg* ipc
>>>>> calls handling")
>>>>> Signed-off-by: no92 <leo@managarm.org>
>>>>> ---
>>>>> =C2=A0=C2=A0 linux-user/syscall.c | 12 ++++++------
>>>>> =C2=A0=C2=A0 1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>>> index 3da5530d42..616d543c7f 100644
>>>>> --- a/linux-user/syscall.c
>>>>> +++ b/linux-user/syscall.c
>>>>> @@ -4234,8 +4234,8 @@ struct target_msqid_ds
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong __msg_cbytes;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong msg_qnum;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong msg_qbytes;
>>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong msg_lspid;
>>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong msg_lrpid;
>>>>> +=C2=A0=C2=A0=C2=A0 abi_int msg_lspid;
>>>>> +=C2=A0=C2=A0=C2=A0 abi_int msg_lrpid;
>>>> ...
>>>>
>>>> The change looks correct in itself.
>>>
>>> No.
>>> abi_ulong is wrong, but abi_int isn't much better either if you look a=
t
>>> the kernel sources:
>>>
>>
>> I wrongly assumed the definition we had on bsd-user side was correct,
>> but didn't really think about checking it in linux sources, sorry.
I need to correct myself :-(

abi_int *is* much better than anything else.
Indirectly all current builds use glibc which switches to __msqid64_ds
instead of the old msqid_ds struct, and in there __pid_t is used, which
seems to be defined to int for all targets.

So, leo's patch is correct and I'll pull it into my linux-user next git tr=
ee as-is.

Thanks!
Helge

