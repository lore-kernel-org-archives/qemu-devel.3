Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D85C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfHZ-0004jh-15; Tue, 19 Mar 2024 15:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmfHX-0004iC-Bh
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:37:55 -0400
Received: from jackal.cherry.relay.mailchannels.net ([23.83.223.95])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmfHU-0008QD-JH
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:37:55 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id A184E7A1FE5
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 19:37:49 +0000 (UTC)
Received: from outbound5b.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id CD47F7A2163
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 19:37:48 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710877069; a=rsa-sha256;
 cv=pass;
 b=+DBj37nOZx6KU03+V0hOkaqxUYQ4LS885LJpLooQzinfiwlUJxmkKD+fx4+XN0s/x+1tHP
 vp/LMnU3m1WQhK3eEuFIJczpJfZw3RJHf2u1MW++E4nJrjDS8WQTzH6IyzEwq/vOOcdpu4
 vVm6RU+4+6ps6qtutpfY80Y3UeJP89iVLrV9EVvYNA+0w23+bDrmX2Ib/MZ6hBqsVKelNk
 QRiXb9CYDsW+jIa+1aaST67b3Sml7jVOUMyWrcB6wTSohzLrC9PWOGVv5FbNCoZq4iljqG
 +qjlDhgffrQsUDsrW39tT1BnyL4e7Ji59ykQmxJAD7berh5T+6zFm6PDeb+v4w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710877069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=3UWNvEJrOv+0aI8AoULfGHnSBgcWW+W63G5QnTZ/BtI=;
 b=VAdB7WhjZAd+s8iDcdkrorZuKV8ecUCOLpPOjeVwR4HxykSyzxOgNWqcFtEeoLpodG1tAs
 tHHHTHkYKPxa2fF++2zUmGhA2r4Hmq3TnMBPf/OWqF2QqQ1TIrF/x7mPMJE3hMG1e8dJxN
 2TH21mFG+Q3JTNO4AJVVNOxqpcAhs/v1kdnjqUvS0/Pp8qf52gcjMAgi1jb42j6F0Aljrr
 9qrr3HKZhe4x/oiCtDzSGqvyWhq7ovvaUmiFTYTPj5rstCzrGGGLYhkXoWMq5JbC/iPczP
 dNdnOpH+i/PmzhSVZ8E0/nVc9RYgLA06qrpHOVBhLJSeIB9X46KGtYXfrj0asA==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-r2xsf;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Trail-Abiding: 3a59cb7210f75ea7_1710877069377_1673113155
X-MC-Loop-Signature: 1710877069377:3806998532
X-MC-Ingress-Time: 1710877069377
Received: from outbound5b.eu.mailhop.org (outbound5b.eu.mailhop.org
 [3.125.66.160]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.46.219 (trex/6.9.2); Tue, 19 Mar 2024 19:37:49 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710877034; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=DvWt83iYkUZhISKYAj9bqSrMkHK6BEl3L4bmWzBfMfQRuPuKoJegwvmUQsrFtrIJy7JujWC4oCbqR
 GPX5W/i0b0djvp58/aaxAKVwS+QRE47q7koGCKstxv29MJ/vew2faHtJYQZNcaYtUzzqYYoSFq+vgh
 2CUyV6SpH9Vz+iJzhUGfYF7wNHmbVGeLbgPWy2Y4IFHBFLrGeOo4ESkYnl9b7cLPacAUTXmr7w6Bfr
 Se/h34MbzV/zd0FILhGLwX0FvWhQS1PvqaNFeQ4hEZjgjriKiqHdyA8STVTI2zb+C0VLPB6y38IQzp
 csgD3vjxalyyr9c03kk/1XKay0ZJJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=3UWNvEJrOv+0aI8AoULfGHnSBgcWW+W63G5QnTZ/BtI=;
 b=ZJme6ADXE8GZxgSlTLW7uWpWxw4szHLVh5OFYJM9pGvrUv55gwiRpaN4old8tnEX/dVZOn+ML9NJg
 J1GRzOmPABsEOiVNH9bjwniu6hP5+k+woS/D/4nFjrlyPuGZAVeCB9qCSvCeGwwxE2n/oiFzPXJuBt
 fyQzErisFK8OpXITMloCXHujGL7K/1r42JH5nqDXkK6W87VKB1r8cP/RA0wLjPnkUHoKBPu69DfEYO
 HpPzJdqeUzrv15c5LTnY/5neaT4Vwh/GFaOuCSd5omNWRz7nrNxUpVXSQdO8Sp8+YQbOsqG4GglnAn
 XJBsMm2xuqw3snBp63HLqEDNNX6w94g==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=VB5JA7pF; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=3UWNvEJrOv+0aI8AoULfGHnSBgcWW+W63G5QnTZ/BtI=;
 b=H8MqxqQPCzMrIfiL4TWgUXLDfDp6xDq5/gBGsP0mtBY1hEGgofv0oblWY8mYd/gDT2MvTSn5+AFGM
 LastXAAZEYoUgAOBk4P39UYlIzjYQvJ37lCHPO3nNE6lU9e1p+EmNS4gbPDHRDmzYiWAvzuk9E28D7
 AEeD7OWFBKvzeRiA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=3UWNvEJrOv+0aI8AoULfGHnSBgcWW+W63G5QnTZ/BtI=;
 b=PdvlN/fXxPTe7LZW2sKV6XxUF6aADjhrjXjFBgPXvpKxfzEGbD/VmK9rmeFLyvx9FqDg/1At+waG5
 Y0hoT0EqQGyL9sDZTfosGKeaTeLcQtdlR29qJuR39aQo9TbJsQaS3YpacK6ahI9IdmUzc+SxqPuwa8
 IE59mEXwyNAn0qdS8vgC6GjBFANPRt0FBxNh7GzZU/pQEJjDG5E7ZSlya7Oa5duHLCAlMpg0mj2h9+
 lMaUJ9/vPaThR2s0ib4jkeP7nqtNXKyME5C2GYI4tW3JK6w/D8TXSzHXUCbUpzeFYRQ5dSW517yio+
 NBuwUrwDf8NH0o2NV/s7uIVnBO37OmA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 14736aa2-e628-11ee-b1e9-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 14736aa2-e628-11ee-b1e9-eda7e384987e;
 Tue, 19 Mar 2024 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3UWNvEJrOv+0aI8AoULfGHnSBgcWW+W63G5QnTZ/BtI=; b=VB5JA7pFz3/a5fgvBfaXk4KNmN
 4X7cTDQzeCSibbCgVPbm9Ro42OkXU63PF4r+CTMkJ8kjMXc9z30adP3ctNhS6CsYQefnoAf/g4Oqc
 nHxnDChvt5MuVukbBwyg0vWyvdaA3zSxqI6SLUJBDwuJxqAt4uBHv0THW/cnCbEl8kg2ZSQZO2F7r
 iHvHFqjD+vRxwCPAtfvqGiHuy7jhHXHlwkRjufxAHkdrgZCx+ORmKn08Xiiax5bqL8PA8qgnzHrVP
 lg0geR1NxU7j/z9ApKjNJP3Bzt7XH3xeYEwhaf6d/kolonukLUGV92ksj4Mk7gbFr9iMtcaan2aQx
 MbK7N/cQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmfHM-004X28-0d;
 Tue, 19 Mar 2024 20:37:44 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [RFC PATCH] target/hppa: Introduce and use IAQEntry
In-Reply-To: <87plvqc9ub.fsf@t14.stackframe.org> (Sven Schnelle's message of
 "Tue, 19 Mar 2024 20:14:52 +0100")
References: <20240319183319.379531-1-richard.henderson@linaro.org>
 <87plvqc9ub.fsf@t14.stackframe.org>
Date: Tue, 19 Mar 2024 20:37:43 +0100
Message-ID: <87le6ec8s8.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.223.95; envelope-from=svens@stackframe.org;
 helo=jackal.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sven Schnelle <svens@stackframe.org> writes:

> Hi Richard,
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> Wrap offset and space into a single structure, with
>> offset represented either as a constant or as variable.
>> This enhances copy_iaoq_entry to copy the space, and at
>> the same time simplifying the code.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> Sven, I think this might solve your branch-with-space-change issue.
>> There are a couple of places where it does appear as if we might be
>> losing a space change, with a branch within a branch delay slot.
>> I'm trying to solve this by keeping both queue entries together.
>
> Thanks! I've put that on top of the other changes i have for 64bit
> HP-UX, but it introduces a new problem:
>
>        * Checking configuration for consistency...
> WARNING: The disk at: 10/0/0/0.0.0 (QEMU_QEMU_HARDDISK) appears to contain a 
>          file system and boot area.  Continuing the installation will destroy 
>          any existing data on this disk.
>
>          Do you wish to cancel the non-interactive installation in order to
>          respond to the warnings above? ([y]/n): n
>   
>        * Loading configuration utility...
>        * Beginning installation from source: /dev/dsk/c0t2d0
> =======  03/19/24 13:59:53 EST  Starting system configuration...
>        * Configure_Disks:  Begin
>        * Will install B.11.11 onto this system.
>        * Creating LVM physical volume "/dev/rdsk/c0t0d0" (10/0/0/0.0.0).
>        * Creating volume group "vg00".
> vgcreate: Illegal path "".
>        * Creating logical volume "vg00/lvol1" (/stand).
> lvcreate: Illegal path "".
>        * Creating logical volume "vg00/lvol2" (swap_dump).
> lvcreate: Illegal path "".
>        * Creating logical volume "vg00/lvol3" (/).
> lvcreate: Illegal path "".
>        * Creating logical volume "vg00/lvol4" (/tmp).
> lvcreate: Illegal path "".
>        * Creating logical volume "vg00/lvol5" (/home).
> lvcreate: Illegal path "".
>        * Creating logical volume "vg00/lvol6" (/opt).
> lvcreate: Illegal path "".
>
> The 'illegal path' errors where not present before. I haven't done any
> debugging, as debugging hppa userspace in qemu is a really time
> consuming thing.

I'm seeing the same error with 32bit HP-UX 10.20 - so at least it's not
caused by my 64bit hacks. Linux seems to run fine, but Linux is also
utilizing address spaces not to the same extent as HP-UX.

