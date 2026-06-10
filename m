Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D43FCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKU3-00037w-GZ; Wed, 10 Jun 2026 11:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wXKU1-00032b-38
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:04:45 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wXKTu-0004Zm-LZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781103845; x=1781708645; i=deller@gmx.de;
 bh=GdC6IS2xYuS4I9jsX4qVmiUnTMVIrSo8j9ibNeN9JS4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Cbz8ZvjEbuGUIQdbOXuw/5cNtHkcPvFvfkjRlJBmOdp1zwqNplQxhf91WUkzZp8V
 thVxtzPEZ3M5VFJ3tCP9QjD33xJy+2rSrRtTmjDTBRUCu3fz43EVp6eSOw+GLd10u
 gmhOmWT8+aTiSLEgItYUVRK4OGyJwIL3Qt1Qv/iKVUjPLj/ZNsNM3lLW17sYCTIoY
 NpmC+129WqBZKt19N8cjFRsUhhrU91BDBYWFd46Dp1/jPFDjx1GfO7Ebe12+dARgt
 PqObKYk0E+Em17aPG8XANF84AuRHPScoA8vr0WUHMS/8te81wq1K+T/GUD2aTKX/i
 teHP4ZUCWhBeuhDUXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQic-1wQ8va30HW-003Vhd; Wed, 10
 Jun 2026 17:04:05 +0200
Message-ID: <e27a97dd-2fe2-4101-bd21-2771ac3435ea@gmx.de>
Date: Wed, 10 Jun 2026 17:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 2/8] linux-user/strace: add fsmount series of syscalls
To: Stefan Hajnoczi <stefanha@gmail.com>, Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Xinhui Yang <cyan@cyano.uk>
References: <20260609163807.6083-1-deller@kernel.org>
 <20260609163807.6083-3-deller@kernel.org>
 <CAJSP0QXMKQnPpdZq+HBb1G-K2RBGc_2wadn-O0x_9gnvk7w1uQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QXMKQnPpdZq+HBb1G-K2RBGc_2wadn-O0x_9gnvk7w1uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:24h7/tqYWTJOg0F9vbOehw4bLwYtD8jJN6axLBgxC9P5KxTeZvw
 wj7qS2nu6cPB6hldmZidZz7L7eRu7fG8PfhEfxZOBzNntAGoxXl9hvtsWTb2EImbhOppZGT
 9DQtz5KjP6yNR6gMT9/H16r37wGTFWDVJ/F04MZc6fqTKDQQoMnW/4ton8HkvxK+BLYJ6+8
 qLCC5fCbTroC5ov3Ggrqg==
UI-OutboundReport: notjunk:1;M01:P0:ALY4f20RtFo=;gfnauz53UV6mGQY8BguL1KunWsR
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

On 6/10/26 16:56, Stefan Hajnoczi wrote:
> On Tue, Jun 9, 2026 at 12:39=E2=80=AFPM Helge Deller <deller@kernel.org>=
 wrote:
>>
>> From: Xinhui Yang <cyan@cyano.uk>
>>
>> Following the addition of fsmount(2) series of syscalls in the syscall
>> handler, strace support is added, with a dedicated function to print th=
e
>> parameters of fsconfig(2), which contains parameters that can be
>> interpreted as multiple types.
>>
>> Snippet of the strace dump when running `mount -t tmpfs tmpfs /media`:
>>
>> 18 fsopen(tmpfs,1) =3D 3
>> 18 read(3,0x407fcf1c,8191) =3D -1 errno=3D61 (No data available)
>> 18 fsconfig(3,FSCONFIG_SET_STRING,"source","tmpfs",0) =3D 0
>> 18 read(3,0x407fce3c,8191) =3D -1 errno=3D61 (No data available)
>> 18 fsconfig(3,FSCONFIG_CMD_CREATE,NULL,NULL,0) =3D 0
>> 18 read(3,0x407fce3c,8191) =3D -1 errno=3D61 (No data available)
>> 18 fsmount(3,1,0) =3D 4
>> 18 read(3,0x407fce3c,8191) =3D -1 errno=3D61 (No data available)
>> 18 statx(4,"",AT_EMPTY_PATH|AT_STATX_SYNC_AS_STAT,0x1000,0x407fee98) =
=3D 0
>> 18 move_mount(4,,-100,/media,4) =3D 0
>> 18 read(3,0x407fcfcc,8191) =3D -1 errno=3D61 (No data available)
>> 18 close(3) =3D 0
>> 18 close(4) =3D 0
>>
>> Signed-off-by: Xinhui Yang <cyan@cyano.uk>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>   linux-user/strace.c    | 105 ++++++++++++++++++++++++++++++++++++++++=
+
>>   linux-user/strace.list |  15 ++++++
>>   2 files changed, 120 insertions(+)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index 2cbaf94c89..d861f311f6 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -4344,6 +4344,111 @@ print_statx(CPUArchState *cpu_env, const struct=
 syscallname *name,
>>   }
>>   #endif
>>
>> +#ifdef TARGET_NR_fsconfig
>=20
> This #ifdef is not tied to the host's available syscalls (the syscall
> table that TARGET_NR_fsconfig is generated from ships in the QEMU
> source tree). As a result, this code will be compiled even when the
> host lacks fsconfig(2) and the associated FSCONFIG_* constants.

Yes, of course you are right.
I had hoped fixing the syscall itself (patch #1) is sufficient, but of cou=
rse it's
not. I'll add the relevant check in here and resend the patch series.

Thank you!
Helge

 =20
> Please see the following CI failure:
>=20
> ../linux-user/strace.c: In function =E2=80=98print_fsconfig_cmd_name=E2=
=80=99:
> ../linux-user/strace.c:4352:10: error: =E2=80=98FSCONFIG_SET_FLAG=E2=80=
=99 undeclared
> (first use in this function)
> 4352 | case FSCONFIG_SET_FLAG:
> | ^~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4352:10: note: each undeclared identifier is
> reported only once for each function it appears in
> ../linux-user/strace.c:4355:10: error: =E2=80=98FSCONFIG_SET_STRING=E2=
=80=99
> undeclared (first use in this function)
> 4355 | case FSCONFIG_SET_STRING:
> | ^~~~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4358:10: error: =E2=80=98FSCONFIG_SET_BINARY=E2=
=80=99
> undeclared (first use in this function)
> 4358 | case FSCONFIG_SET_BINARY:
> | ^~~~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4361:10: error: =E2=80=98FSCONFIG_SET_PATH=E2=80=
=99 undeclared
> (first use in this function)
> 4361 | case FSCONFIG_SET_PATH:
> | ^~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4364:10: error: =E2=80=98FSCONFIG_SET_PATH_EMPTY=
=E2=80=99
> undeclared (first use in this function)
> 4364 | case FSCONFIG_SET_PATH_EMPTY:
> | ^~~~~~~~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4367:10: error: =E2=80=98FSCONFIG_SET_FD=E2=80=99=
 undeclared
> (first use in this function); did you mean =E2=80=98CONFIG_GETTID=E2=80=
=99?
> 4367 | case FSCONFIG_SET_FD:
> | ^~~~~~~~~~~~~~~
> | CONFIG_GETTID
> ../linux-user/strace.c:4370:10: error: =E2=80=98FSCONFIG_CMD_CREATE=E2=
=80=99
> undeclared (first use in this function)
> 4370 | case FSCONFIG_CMD_CREATE:
> | ^~~~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4373:10: error: =E2=80=98FSCONFIG_CMD_RECONFIGURE=
=E2=80=99
> undeclared (first use in this function)
> 4373 | case FSCONFIG_CMD_RECONFIGURE:
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> ../linux-user/strace.c: In function =E2=80=98print_fsconfig=E2=80=99:
> ../linux-user/strace.c:4408:10: error: =E2=80=98FSCONFIG_SET_FLAG=E2=80=
=99 undeclared
> (first use in this function)
> 4408 | case FSCONFIG_SET_FLAG:
> | ^~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4409:10: error: =E2=80=98FSCONFIG_SET_STRING=E2=
=80=99
> undeclared (first use in this function)
> 4409 | case FSCONFIG_SET_STRING:
> | ^~~~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4410:10: error: =E2=80=98FSCONFIG_SET_BINARY=E2=
=80=99
> undeclared (first use in this function)
> 4410 | case FSCONFIG_SET_BINARY:
> | ^~~~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4411:10: error: =E2=80=98FSCONFIG_SET_PATH=E2=80=
=99 undeclared
> (first use in this function)
> 4411 | case FSCONFIG_SET_PATH:
> | ^~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4412:10: error: =E2=80=98FSCONFIG_SET_PATH_EMPTY=
=E2=80=99
> undeclared (first use in this function)
> 4412 | case FSCONFIG_SET_PATH_EMPTY:
> | ^~~~~~~~~~~~~~~~~~~~~~~
> ../linux-user/strace.c:4413:10: error: =E2=80=98FSCONFIG_SET_FD=E2=80=99=
 undeclared
> (first use in this function); did you mean =E2=80=98CONFIG_GETTID=E2=80=
=99?
> 4413 | case FSCONFIG_SET_FD:
> | ^~~~~~~~~~~~~~~
> | CONFIG_GETTID
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/14787411039#L3244
>=20
>> +static void
>> +print_fsconfig_cmd_name(int cmd)
>> +{
>> +    switch (cmd) {
>> +    case FSCONFIG_SET_FLAG:
>> +        qemu_log("%s%s", "FSCONFIG_SET_FLAG", get_comma(0));
>> +        break;
>> +    case FSCONFIG_SET_STRING:
>> +        qemu_log("%s%s", "FSCONFIG_SET_STRING", get_comma(0));
>> +        break;
>> +    case FSCONFIG_SET_BINARY:
>> +        qemu_log("%s%s", "FSCONFIG_SET_BINARY", get_comma(0));
>> +        break;
>> +    case FSCONFIG_SET_PATH:
>> +        qemu_log("%s%s", "FSCONFIG_SET_PATH", get_comma(0));
>> +        break;
>> +    case FSCONFIG_SET_PATH_EMPTY:
>> +        qemu_log("%s%s", "FSCONFIG_SET_PATH_EMPTY", get_comma(0));
>> +        break;
>> +    case FSCONFIG_SET_FD:
>> +        qemu_log("%s%s", "FSCONFIG_SET_FD", get_comma(0));
>> +        break;
>> +    case FSCONFIG_CMD_CREATE:
>> +        qemu_log("%s%s", "FSCONFIG_CMD_CREATE", get_comma(0));
>> +        break;
>> +    case FSCONFIG_CMD_RECONFIGURE:
>> +        qemu_log("%s%s", "FSCONFIG_CMD_RECONFIGURE", get_comma(0));
>> +        break;
>> +#ifdef FSCONFIG_CMD_CREATE_EXCL
>> +    case FSCONFIG_CMD_CREATE_EXCL:
>> +        /* Only available since Linux 6.6. */
>> +        qemu_log("%s%s", "FSCONFIG_CMD_CREATE_EXCL", get_comma(0));
>> +        break;
>> +#endif
>> +    default:
>> +        qemu_log("%s (%d)%s", "UNKNOWN_CMD", cmd, get_comma(0));
>> +        break;
>> +    }
>> +}
>> +
>> +static void
>> +print_fsconfig(CPUArchState *cpu_env, const struct syscallname *name,
>> +            abi_long arg0, abi_long arg1, abi_long arg2,
>> +            abi_long arg3, abi_long arg4, abi_long arg5)
>> +{
>> +    /*
>> +     * fsconfig(int fd, int cmd, char* key, void* value, int aux)
>> +     * Where:
>> +     * fd: file descriptor returned by fsopen().
>> +     * cmd: integer constant specifying a command.
>> +     * key: a string, can be NULL on certain commands.
>> +     * value: any data in a buffer, can be NULL, raw buffer or a strin=
g.
>> +     * aux: axillary values such as flags for FSCONFIG_SET_PATH.
>> +     */
>> +    int cmd =3D (int) arg1;
>> +    print_syscall_prologue(name);
>> +    print_raw_param("%d", arg0, 0);
>> +    print_fsconfig_cmd_name(cmd);
>> +    /* Process arg2 (key). */
>> +    switch (cmd) {
>> +    case FSCONFIG_SET_FLAG:
>> +    case FSCONFIG_SET_STRING:
>> +    case FSCONFIG_SET_BINARY:
>> +    case FSCONFIG_SET_PATH:
>> +    case FSCONFIG_SET_PATH_EMPTY:
>> +    case FSCONFIG_SET_FD:
>> +        print_string(arg2, 0);
>> +        break;
>> +    default:
>> +        print_pointer(arg2, 0);
>> +        break;
>> +    }
>> +    /* Process arg3 (value). */
>> +    switch (cmd) {
>> +    case FSCONFIG_SET_STRING:
>> +    case FSCONFIG_SET_PATH:
>> +    case FSCONFIG_SET_PATH_EMPTY:
>> +        print_string(arg3, 0);
>> +        break;
>> +    default:
>> +        print_pointer(arg3, 0);
>> +        break;
>> +    }
>> +    /*
>> +     * Process arg4 (aux).
>> +     * On FSCONFIG_SET_PATH and FSCONFIG_SET_PATH_EMPTY, aux can
>> +     * be either 0 or AT_FDCWD.
>> +     * On FSCONFIG_SET_BINARY, aux is an integer to state the length
>> +     * of the buffer pointed by arg3.
>> +     * Otherwise, it must be 0.
>> +     */
>> +    switch (cmd) {
>> +    case FSCONFIG_SET_PATH:
>> +    case FSCONFIG_SET_PATH_EMPTY:
>> +        print_at_dirfd(arg4, 1);
>> +        break;
>> +    default:
>> +        print_raw_param("%d", arg4, 1);
>> +        break;
>> +    }
>> +    print_syscall_epilogue(name);
>> +}
>> +#endif
>> +
>>   #ifdef TARGET_NR_ioctl
>>   static void
>>   print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
>> diff --git a/linux-user/strace.list b/linux-user/strace.list
>> index 6162a407f9..3a366b8cac 100644
>> --- a/linux-user/strace.list
>> +++ b/linux-user/strace.list
>> @@ -1722,3 +1722,18 @@
>>   #ifdef TARGET_NR_rseq
>>   { TARGET_NR_rseq, "rseq" , "%s(%p,%u,%d,%#x)", NULL, NULL },
>>   #endif
>> +#ifdef TARGET_NR_fsopen
>> +{ TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
>> +#endif
>> +#ifdef TARGET_NR_fsconfig
>> +{ TARGET_NR_fsconfig, "fsconfig", NULL, print_fsconfig, NULL },
>> +#endif
>> +#ifdef TARGET_NR_fsmount
>> +{ TARGET_NR_fsmount, "fsmount", "%s(%d,%d,%d)", NULL, NULL },
>> +#endif
>> +#ifdef TARGET_NR_move_mount
>> +{ TARGET_NR_move_mount, "move_mount", "%s(%d,%s,%d,%s,%d)", NULL, NULL=
 },
>> +#endif
>> +#ifdef TARGET_NR_fspick
>> +{ TARGET_NR_fspick, "fspick", "%s(%d,%s,%d)", NULL, NULL },
>> +#endif
>> --
>> 2.54.0
>>
>>


