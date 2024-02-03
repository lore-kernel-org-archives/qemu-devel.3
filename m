Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB9BC4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 21:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWNHq-0008OH-W7; Sat, 03 Feb 2024 16:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@gudrian.org>)
 id 1rWMXG-0008Sk-Tf
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 15:22:46 -0500
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@gudrian.org>)
 id 1rWMXE-0005Sf-VQ
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 15:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gudrian.org;
 s=s1-ionos; t=1706991761; x=1707596561; i=christian@gudrian.org;
 bh=8LSXYvnqySj4jmZlLLG0R9Nqpz+3Wtc3ZnMRakM9pSM=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=vZ5Eupq4IwIdmHP+cclSG5eVE8Rsbupp6aPAVLbkdUrAYcXVKtpYVVRQUqn5gP8e
 73qhNm+QkVMtum74mEim1ocr/6NCnRgMuR18nsauCWMqOtR4oUyV7y+tiZI6lsO+7
 HgIWu6bcFmWUUqNz1NF2y3pkw4mNV77GInZijEJqgzAODO4suCPGf7clJdWHHWSdV
 BWXd4NVM5xGuafVDp4ZjgpMDIYvvXxzzcc/o+RqFbmaJrRE35zA6SHFCdUL5brQaL
 GptdkU/HOGA1jH1oskEfH/NoIANgMqF2FgLxOOIemb0NvN8HFLrMrM+gELzKiAYd5
 qrdB2/yEu325DH83kA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.208] ([92.200.167.19]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnItm-1qn66H0if6-00jGW3 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024
 21:22:41 +0100
Message-ID: <7bf1170d-6440-5ae8-2a0d-5921db11a5ff@gudrian.org>
Date: Sat, 3 Feb 2024 21:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ehci: more than 16 ITDs
To: qemu-devel@nongnu.org
References: <441d024e-9d3f-b410-2e3c-3323af841b8e@gudrian.org>
 <2cc91c6e-7c1a-f7cd-2b7d-69136c98d832@eik.bme.hu>
From: Christian Gudrian <christian@gudrian.org>
In-Reply-To: <2cc91c6e-7c1a-f7cd-2b7d-69136c98d832@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eHE5Sn/X7quOy1TUOBoWoy4tbGWX02SNSqPFq8yEo29yBAjNeJ6
 INWETbzhRNeRWfTRWDN7W6OXQVLnVFN7zb99pP20B+ZJE4shj3Jkxdkr5ogO0sybzI0ENkR
 DXahG8K2ICkgr36SxMUYwFSsxzn/JSjgwNDQWTeSyL7E0sl1TY19uQnYGUwSbe2y/uxPBcB
 eRJoZo5v8ShDHnucIIrQw==
UI-OutboundReport: notjunk:1;M01:P0:gWx3N+BYRhs=;JGcVVMcjJzz123CkxHq3TethFNU
 qCnjSFHcDckucEqJvCG3QJJ6YfBGKiEv08864C4OcJAJ8iMU19KwJtty5A9hvQ6DseK59oxXN
 6dDuYUq7DoOs5dF+q1XMOI7torfhZHd+LOWXqYWpziMWfU5kZkbw6n7O8dXO+OXcHKzX8GQb+
 eH0LTo9atHhhpcQhKaBAmn3TQGlqzEbHQNGaLkl0E8UCM8+dp4GBUsHFfp8TXDAICbPAnLX+b
 j4HTccnNvH6CEBEsHCfFGC4ncNGBtcpoHMs95O2GDE5xA7Bce03OFGPhYaIJ6cqg+HcjVgL7f
 qVvbak0JHZ4UV7DLjTF5uQk9JTZX7jVxjZDmkWazW7Qk4RPhEoSp+Xaxm41miHeS0mw48EJIA
 OrxA74uVTNWseZGc8OJ796yWE0jDXu8bFnVnt6hneSB8X3ZGvCo2g8re9F5+E5M7dTmqebt/Z
 M7vLUjE1wm2AL9zx2eevmsJ3s70IQwa6dHKnDyMmfMQ8q5+PBF9+42A+c+SkqTw1aS8g6foiy
 wHqEBAGblhhSqxSWmXVYjbrz453vQ+zXNGMdmmi7FmgY3jtiup0f2mYOKLuunvNIhNXa4Lg+n
 3FU6+D7miutb2D6VlpeEQSXq+sskSOq+SqpNkhBHKWl4zV9AdIBUZ4JjtHpiSA9JgZMQo5c/u
 LbHQma82cXKibrwcPxG8cKSYImHZZZXtRvZQK2zfSRlPEiyLcnKwud3O49+dwRSX1vj5AJWhP
 Ab0u2JBmjd14W05YC0YqiZS2PF+ldgRDZwnD6ld5+Uw8h7BkKLq2k0=
Received-SPF: pass client-ip=217.72.192.74; envelope-from=christian@gudrian.org;
 helo=mout.kundenserver.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.509,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 03 Feb 2024 16:10:53 -0500
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


On 03.02.2024 21:06, BALATON Zoltan wrote:

> It's hard to tell, I don't know EHCI but there's a TODO comment near
> that error so maybe there's some EHCI feature not emulated that you
> may need to implement in QEMU there. I guess you'd need to check the
> EHCI specification or the docs of the actual chip that is emulated
> for info on how this should work.

I'll have a look at it. Meanwhile I've added dedicated debug output and
found out, that the 17th ITD only occurs occasionally. Could it be the
16 ITD limit has been arbitrarily chosen? The host machine is not
particularly powerful so that buffers might fill up to a higher level
than usually expected.

> Also to get more debugging info to see what's happening you can add
> --trace enable=3D"usb*" (or see qemu/hw/usb/trace-events for the list
> of trace points available that could be enabled individually) in case
> you were not aware of that.

Thanks for the hint. I indeed didn't know that. The audio hardware,
however, is particularly time sensitive during initialization and
requires a power cycle if anything appears strange to it. But I'll have
a try!

The refcount warning is triggered by inconsistent data structures in the
EHCI driver of the Linux kernel: while the 'periodic' array encodes a
structure type of 'ehci_qh' the pointer in the 'pshadow' array actually
points to a structure of type 'ehci_itd'. My hunch is I'm running into a
kernel race condition due to massively skewed timing conditions compared
with the original bare metal hardware (where the kernel runs just fine).

Christian

