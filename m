Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D59EC48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX1QR-0000Wd-Le; Mon, 05 Feb 2024 11:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevans@FreeBSD.org>)
 id 1rX1QN-0000WO-Ng
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:02:24 -0500
Received: from mx2.freebsd.org ([96.47.72.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevans@FreeBSD.org>)
 id 1rX1QJ-0005gM-VY
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:02:23 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4TTB3D0MRWz3hMJ;
 Mon,  5 Feb 2024 16:02:16 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4TTB3C5XJnz4K6b;
 Mon,  5 Feb 2024 16:02:15 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1707148935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeqwqcUa5bG+Th4EOqBvWvSPKIQISKRhESLaE7WGjAM=;
 b=IVUOMtPCa/vTit/MnoLMElSs9TA+BBK4ERh+jOdoX1cs68oo6zVsHjWEKYpIZYya/MgVqr
 /T0zGoFz+TqbmcSUoSbd81eG0h6jsaTipOmC82c5w+oCnPX8aCA95DqZjBBGQN0IpVZv3U
 usGfjxJ2DbL6KeF0RzE1Y2FR2Hmltz40n5Q/03IaG4+6yGv3G+Dl2RVbaAt+Y3f01tYHj7
 ypgQ747EXA9xSHr2VH1UbV+pQhsZZ0zSnMIvJDYajCmx6+KwHiJd4DTJ+yG4yKf6dxrVDO
 2O7crfp+hNEsdcgGTFUIOf+WzlX9KvTCyr36Fv6lzxfmGIHV/c/FFLME0y+1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1707148935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeqwqcUa5bG+Th4EOqBvWvSPKIQISKRhESLaE7WGjAM=;
 b=aLPSX5IFec441wZqrhjyKGfyOuGW1zORGGZ8HiN13lI1UQiBwWUsekOcrn9MRYhS7QTkou
 q7SBVY36WoEwJtge1TyvpmvTjDRAjrUlrkAFt6+tBHDZMNUtNc6qCSpG7atsPy+bz3Y3R1
 potKPwBraug1fUrHgQglsXthu6EY6zwjai3gSNNCTR2zp3CbepXig9fpvtN52jUIJ9QLRY
 1xwkeO73vE7ZtnmddBJzlGk0kq/ounBoGNfbWHNDR9g9esvWSOrUrYZaJkRolRW+WCfUgs
 XA5FspcLPIXbDWhSe+8iESeY7HVgm27gIMU98P6EPc5du1zsnEz+cvqmRizzdw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1707148935; a=rsa-sha256; cv=none;
 b=SF0e0Bs7uFbW3U8mYbRRK7vPR7qsIuJP2TE6AhNwI2mVdL+WW6nDdBBQ7Ajx6loCiJc8yV
 UiEWscaS7WVfsMPM76YFwY+eUq6zsPVnHTZ9/djB9rEgKVECLIrBcPfBIHiAbKtmCMwPGV
 07GB3xuGrakMvwqbxKkCh+DqqUERUCFyNqGnbul0Azj5QcFHRktIBLfKmVIKZcymxo+XbJ
 bX+3IdJYrXSdP/Rhv+N1yXKVimcIFVcqWN3HihU4csDG42vSLv3MAi8m/u1WgS4sqt3RNA
 n8z9vav83FW+fCGeZyxTLApicmxAZeTjuup1xEjSS0u/gSZP2vPHYYcEXlew/w==
Received: from [10.9.4.95] (unknown [209.182.120.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: kevans/mail)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4TTB3B3Hkyz1Kp9;
 Mon,  5 Feb 2024 16:02:14 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Message-ID: <0d6bbca5-4f9b-4f46-b013-ce5ada32c5a8@FreeBSD.org>
Date: Mon, 5 Feb 2024 10:02:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] meson: Disable CONFIG_NOTIFY1 on FreeBSD
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240125194840.1564-1-iii@linux.ibm.com>
 <20240125194840.1564-4-iii@linux.ibm.com>
 <33c9ccef-fa8f-41e4-a7a1-17c3dffb9d9d@linaro.org>
 <Zbp4ekYJLQB-BIFo@redhat.com>
 <CANCZdfotNMgPadLA0o9+POcLeTN-rGoR+XkbqBHtjd+cZMy0Fg@mail.gmail.com>
 <ZcD_bnSRD2XSLIp5@redhat.com>
From: Kyle Evans <kevans@FreeBSD.org>
In-Reply-To: <ZcD_bnSRD2XSLIp5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=96.47.72.81; envelope-from=kevans@FreeBSD.org;
 helo=mx2.freebsd.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/5/24 09:31, Daniel P. Berrangé wrote:
> On Mon, Feb 05, 2024 at 08:23:41AM -0700, Warner Losh wrote:
>> On Wed, Jan 31, 2024 at 9:42 AM Daniel P. Berrangé <berrange@redhat.com>
>> wrote:
>>
>>> On Wed, Jan 31, 2024 at 05:24:10PM +0100, Philippe Mathieu-Daudé wrote:
 > [... snip ...]
>>>> On 25/1/24 20:48, Ilya Leoshkevich wrote:
>>>>> make vm-build-freebsd fails with:
>>>>>
>>>>>       ld: error: undefined symbol: inotify_init1
>>>>>       >>> referenced by filemonitor-inotify.c:183
>>> (../src/util/filemonitor-inotify.c:183)
>>>>>       >>>
>>>   util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive
>>> libqemuutil.a
>>>>>
>>>>> On FreeBSD inotify functions are defined in libinotify.so, so it might
>>>>> be tempting to add it to the dependencies. Doing so, however, reveals
>>>>> that this library handles rename events differently from Linux:
>>>>>
>>>>>       $ FILEMONITOR_DEBUG=1 build/tests/unit/test-util-filemonitor
>>>>>       Rename /tmp/test-util-filemonitor-K13LI2/fish/one.txt ->
>>> /tmp/test-util-filemonitor-K13LI2/two.txt
>>>>>       Event id=200000000 event=2 file=one.txt
>>>>>       Queue event id 200000000 event 2 file one.txt
>>>>>       Queue event id 100000000 event 2 file two.txt
>>>>>       Queue event id 100000002 event 2 file two.txt
>>>>>       Queue event id 100000000 event 0 file two.txt
>>>>>       Queue event id 100000002 event 0 file two.txt
>>>>>       Event id=100000000 event=0 file=two.txt
>>>>>       Expected event 0 but got 2
>>>
>>> Interesting. So In the "Rename" test, the destination already exists.
>>>
>>> BSD is thus reporting that 'two.txt' is deleted, before being (re)created
>>> Linux is only reporting 'two.txt' is created.
>>>
>>> I don't think we can easily paper over this difference. The easiest is
>>> probably to conditionalize the test
>>>
>>>   git diff
>>> diff --git a/tests/unit/test-util-filemonitor.c
>>> b/tests/unit/test-util-filemonitor.c
>>> index a22de27595..c3b2006365 100644
>>> --- a/tests/unit/test-util-filemonitor.c
>>> +++ b/tests/unit/test-util-filemonitor.c
>>> @@ -281,6 +281,14 @@ test_file_monitor_events(void)
>>>           { .type = QFILE_MONITOR_TEST_OP_EVENT,
>>>             .filesrc = "one.txt", .watchid = &watch1,
>>>             .eventid = QFILE_MONITOR_EVENT_DELETED },
>>> +#ifdef __FreeBSD__
>>> +        { .type = QFILE_MONITOR_TEST_OP_EVENT,
>>> +          .filesrc = "two.txt", .watchid = &watch0,
>>> +          .eventid = QFILE_MONITOR_EVENT_DELETED },
>>> +        { .type = QFILE_MONITOR_TEST_OP_EVENT,
>>> +          .filesrc = "two.txt", .watchid = &watch2,
>>> +          .eventid = QFILE_MONITOR_EVENT_DELETED },
>>> +#endif
>>>           { .type = QFILE_MONITOR_TEST_OP_EVENT,
>>>             .filesrc = "two.txt", .watchid = &watch0,
>>>             .eventid = QFILE_MONITOR_EVENT_CREATED },
>>>
>>
>> I agree this is likely the best course of action. Has anybody filed a bug
>> at https://bugs.freebsd.org?
> 
> I've not, and I'm not even sure I would class it a FreeBSD bug. Other
> than the fact that it differs from Linux behaviour, it feels like it
> is reasonble semantics to emit a 'delete' event in this scenario so
> that an event consumer can detect replacement of an existing file.
> 

FWIW, +1... unless we miss the follow-up notification that it's been 
created, I'd personally put it into the WONTFIX bucket pretty quickly.

Barring some kind of NOTE_COVER (bad name) that can be emitted if a file 
is simply replaced by another, a directory being reported as shortened 
then extended is a valid and useful representation of the situation 
(even if not completely accurate) to avoid consumers missing the action 
entirely.

Thanks,

Kyle Evans

