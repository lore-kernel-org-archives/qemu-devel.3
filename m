Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A839FEDEBF9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXv2-0001Bk-4F; Tue, 03 Mar 2026 17:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco@valla.it>)
 id 1vxWyx-00036P-SL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:08:45 -0500
Received: from delivery.antispam.mailspamprotection.com ([185.56.87.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco@valla.it>)
 id 1vxWyu-0001Kl-TV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:08:43 -0500
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-nc2c.prod.antispam.mailspamprotection.com;
 s=arckey; t=1772572113; 
 b=VX3LoTOPSOSRhgqNEuktlrzrvvUumF8iSAdD7ijk8UFiRi3uyJFWzptxTvSS0yQcnm1Lz6v/12
 TyASbXZpNTLDMT0gfzM7Sij+TIktKGwepRCJaXOR/GRs0Lx/kB3IQMf6FuHRTFB7aZ9U6ZhQ+q
 2AmmXtAXpSr3bhBES4iKoc6ozmZ/1xBp+EPDh3yRg2cFcWxgHbI6bBLiI4h4fTMjb5YGkiv1K+
 iI5OITpw4R6M9ovrTtb/7nXheOD2tahwWUtepTa5a738XjyroOq3Jt60jmQc+2PF7tICKuAwV1
 y4OAUfjlbtUVx5U1Dy/RUbHdsWpH2fZM7oxL9KUD2A6hAw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-nc2c.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-nc2c.prod.antispam.mailspamprotection.com;
 s=arckey; t=1772572113; 
 bh=mHA1eNADjqCgGL1SqP8PCdGg4kVQw5jq9z2KBeNPtT0=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:Subject:
 From:MIME-Version:Date:Message-ID:DKIM-Signature:DKIM-Signature;
 b=FsJEVJ0M11mMxvPFYi3youcoJwG5x/7k9ST7HGUdRWBmrAujeqmePLtdLKPfDEQLQn3fLQmnEL
 pZVA8HtWrd7DAefKzsJsc/se1wDv/U16tJBY9R8hatBS6nVb5Z1LNzhBLNeWz4kmJy7ry0XC82
 8Rs0q0WchOxFC4k7t5R7ul+U6pcQvsoLRVp+PoDStzTTPydLlh4RZN6letFYAztzTfSl6vITYe
 p7wAUL/t8NcJ+MBZM8SAEXgqWNE6f4oCGw5lU4AublIjM5o+oyTygZj4W1RtXljMCsvoJCcYyg
 nBYve48UbQNsu1eOA4JNY8flcfRQJGz3kL83TGMlYUoesg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:MIME-Version:Date:
 Message-ID:Reply-To:List-Unsubscribe;
 bh=zGSOJOywtKePoj/LQyHFoAJ7E8nXEEGwE2gJCgYSpWk=; b=2hNBGaYdxVxgMuJ5FfTlwmpvmA
 Ejit9eeKfWsFLIOgPJsdUITHPlzPtxUs7lkfOCezB5A/D0PJNN/hmTJ7+gTYQRzXYah0k9/HPpeSj
 m9lqxPaiE7YGlwgHOGomYM1cxRaPrz23hZ1PsxsCU2f7dg1ixfOC87kW1R3Avam68DQI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-nc2c.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vxWyi-00000001cV3-2pv2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 21:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=zGSOJOywtKePoj/LQyHFoAJ7E8nXEEGwE2gJCgYSpWk=; b=g7RKJXLtkUDob/NZJhyumIgZJ/
 MsfKZCjhHewlB8zZOA6DW7DC6Y9PqrNXNaeUGochMxVX7ahAPoF6M+kVNdVnd21wpFLkZTuBJ691G
 z4kyk6QbRBtFm677DO3e/cx3dVBy+ocT7qvzrC2TQH4p2mMOX4jUhA+qXxYY8UEVA+PE=;
Received: from [82.57.88.19] (port=62022 helo=[192.168.178.65])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1vxWyb-000000001In-0rvj; Tue, 03 Mar 2026 21:08:21 +0000
Message-ID: <3d5402b2-fb99-47d2-bbb8-48dd6f202cbc@valla.it>
Date: Tue, 3 Mar 2026 22:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Francesco Valla <francesco@valla.it>
Subject: Re: GSoC 2026 Interest - virtio-rtc vhost-user device - Alberto H.
To: Alberto Hernandez Cardenas <alberto10pumas@gmail.com>,
 mvaralar@redhat.com, garzare@redhat.com
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, alex.bennee@linaro.org
References: <CAHLkteN0M6RXMsCwEWdaXdf26jDc49caYCQaOSjBqJUGNY0MhA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHLkteN0M6RXMsCwEWdaXdf26jDc49caYCQaOSjBqJUGNY0MhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: ffbb5a841c44f3d61be37ed2dd0c09ec
X-AntiAbuse: ID - ffbb5a841c44f3d61be37ed2dd0c09ec
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vxWyi-00000001cV3-2pv2-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-nc2c.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
Received-SPF: pass client-ip=185.56.87.12; envelope-from=francesco@valla.it;
 helo=delivery.antispam.mailspamprotection.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Mar 2026 17:08:42 -0500
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

Hi Alberto,

On 3/1/26 00:02, Alberto Hernandez Cardenas wrote:
> Hi Mentors and QEMU community,
> My name is Alberto, I am a computer engineering student from Mexico (UPIICSA).
> I want to participate in GSoC 2026 with QEMU.

Thanks for reaching out!

Judging from the people you wrote to (including me), I assume you are interested

in the virtio-rtc proposal.

> I already installed Fedora 43 and I compiled QEMU from source successfully. I
> am studying the code right now. I know C and I am learning Rust because I want
> to help with the new components of the project.
> I saw this issue on GitLab: *"Writing a large amount of data to the
> virtio-serial chardev device causes the channel to become
> blocked"* issue #3251 <https://gitlab.com/qemu-project/qemu/-/issues/3251>.
> I am very interested in this problem. I want to understand why
> |vsc->have_data| is causing a blockage. I think this is a good way for me to
> learn how QEMU works with devices.
> I have some questions:
>
>   * Is someone working on this issue right now?
>
Probably not, you can try to reproduce and comment the issue with you findings,

as a starting point.


>   * Can I try to solve this as a "test task" for my GSoC proposal?
>   * Do you have any other small tasks or "Bite Sized" issues for a new student
>     like me?
>
Bite sized issues on QEMU are listed at
https://gitlab.com/qemu-project/qemu/-/issues?label_name%5B%5D=Bite%20Sized


My advice would also be to take a look at the issues for vhost-device

at https://github.com/rust-vmm/vhost-device/issues, as that will probably

be a big part of the activity on virtio-rtc.


But don't forget to work on your application, which will be open March 16-31!


> I am very happy to learn and contribute to QEMU. Thank you for your time!
> Best regards,
> Alberto Hernandez Cardenas. (Nickname: betillo) 
> GitLab: alberto10pumas@gmail.com
Regards,
Francesco

