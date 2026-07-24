Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A00FC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnNfX-00073s-88; Fri, 24 Jul 2026 17:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wnNfT-00073F-II
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 17:42:57 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wnNfR-0002v1-BD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 17:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784929369; x=1785534169; i=deller@gmx.de;
 bh=9aJK5l50SKlSWAzLTsOUYhgFPWToIjQbaOlJcbe2Ff4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Zx5O18NT4himmqoU2zLoSE/VxAAbvFFP2v90MQiCtueX7lt0RbvMe1iGfAPpndy9
 thVGE9/SNe+JXyTmpSU5iHhztsZP0txnDGutqeqnVDv6NTbyxyEKRJyzXkNH20WGD
 9k+jwfvLKHtmZ/DScLTNKxn/yavlPSn2P8sOuGpR+EjjZJz8pbVeKav3zX94jLYiu
 9SGFbZ6Mt27HnINxy+syBWhsfSRFSmKucrVxL4s1OSVPYqBF5bsfmH5HZQtd/3B1n
 M4MksIEFp6dNHuapS3Fc+hWiD4kKHaELcN5rI57nPAPlbkAlYmqy+qlyfDcaAOLwv
 stJMJl8beiqzkd9JEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1wmphb1uXi-00F7yr; Fri, 24
 Jul 2026 23:42:49 +0200
Message-ID: <a0adc88a-4405-46cc-b46c-6981f310db8f@gmx.de>
Date: Fri, 24 Jul 2026 23:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 no92 <leo@managarm.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20260724160105.3787888-1-leo@managarm.org>
 <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:an1uPd1SY/Bp8ZGAbLoJmCWQkHA2Uvz7/fmyu7/E0MvQxAyM8Sz
 jVETS4YujXGT7SxaInufTlc9O63gsgIRaZryJTWx3doUaP8pdgIbz34ib62D+KiBBLx48Hv
 BA6iya82FY43hm6yRbo5ZFszsuQ+6Zb+Hu/iyhYyVZUaMANt5VjNDqCDpR6uAYS92A+VOme
 CGeXqdIdp9mNz4ighQUGw==
UI-OutboundReport: notjunk:1;M01:P0:MGD2aTEiZvY=;H0974tpUtckZ+hFD3D8ZGS/Hjv0
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/24/26 18:48, Pierrick Bouvier wrote:
> On 7/24/2026 9:01 AM, no92 via qemu development wrote:
>> The members are declared as __kernel_pid_t in Linux UAPI headers.
>> Analogous members in struct target_shmid_ds (shm_[cl]pid) are also
>> declared as abi_int.
>>
>> Fixes: 1c54ff97bbde ("linux-user: fix and cleanup IPCOP_msg* ipc calls =
handling")
>> Signed-off-by: no92 <leo@managarm.org>
>> ---
>>   linux-user/syscall.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 3da5530d42..616d543c7f 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -4234,8 +4234,8 @@ struct target_msqid_ds
>>       abi_ulong __msg_cbytes;
>>       abi_ulong msg_qnum;
>>       abi_ulong msg_qbytes;
>> -    abi_ulong msg_lspid;
>> -    abi_ulong msg_lrpid;
>> +    abi_int msg_lspid;
>> +    abi_int msg_lrpid;
>...
>=20
> The change looks correct in itself.

No.
abi_ulong is wrong, but abi_int isn't much better either if you look at th=
e kernel sources:

grep -r __kernel_ipc_pid_t arch/

arch/sparc/include/uapi/asm/posix_types.h:typedef unsigned short         _=
_kernel_ipc_pid_t;
arch/sparc/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t __ker=
nel_ipc_pid_t
arch/m68k/include/uapi/asm/posix_types.h:typedef unsigned short __kernel_i=
pc_pid_t;
arch/m68k/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t __kern=
el_ipc_pid_t
arch/parisc/include/uapi/asm/posix_types.h:typedef unsigned short         =
      __kernel_ipc_pid_t;
arch/parisc/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t __ke=
rnel_ipc_pid_t
arch/arm/include/uapi/asm/posix_types.h:typedef unsigned short          __=
kernel_ipc_pid_t;
arch/arm/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t __kerne=
l_ipc_pid_t
arch/s390/include/uapi/asm/posix_types.h:typedef int             __kernel_=
ipc_pid_t;
arch/s390/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t __kern=
el_ipc_pid_t
arch/xtensa/include/uapi/asm/posix_types.h:typedef unsigned short       __=
kernel_ipc_pid_t;
arch/xtensa/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t __ke=
rnel_ipc_pid_t
arch/x86/include/uapi/asm/posix_types_32.h:typedef unsigned short       __=
kernel_ipc_pid_t;
arch/x86/include/uapi/asm/posix_types_32.h:#define __kernel_ipc_pid_t __ke=
rnel_ipc_pid_t
arch/sh/include/uapi/asm/posix_types_32.h:typedef unsigned short        __=
kernel_ipc_pid_t;
arch/sh/include/uapi/asm/posix_types_32.h:#define __kernel_ipc_pid_t __ker=
nel_ipc_pid_t
arch/powerpc/include/uapi/asm/posix_types.h:typedef short               __=
kernel_ipc_pid_t;
arch/powerpc/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t __k=
ernel_ipc_pid_t

So, we probably need to differntiate between platforms and use either abi_=
int or abi_short.

Helge

