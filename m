Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743FCC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1q8-0006VJ-V4; Tue, 27 Aug 2024 15:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergio.durigan@canonical.com>)
 id 1sj1F6-0000sn-HJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:48:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergio.durigan@canonical.com>)
 id 1sj1F4-0007Vm-H9
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:48:36 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88ABF3F2F2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1724784511;
 bh=7aVRiNgtIQrpl+6j9IJwv+ByTfx7MOBn6Z2ESed44D0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
 MIME-Version:Content-Type;
 b=HOnNU5ivLUKwy/kb/K9VF2a+QMYMI6ITccs6arP4WXopXqeii0o8/c6IAJOg61eo4
 juq2ZhRuVhWEcB653DFeGHFYUwjn3kXHqwyqROeQhasfxITl4+Vh3CAettK0+2WJ2H
 OkUr0qOMisS0HaE+lRTBnijccHJRAHMflUGpoDjq7gYm4nkjmx9RUPzrTBkll1Jmig
 rnQhXBmfRsJH0iW2wpNQSRYO+oNeRLbYndKTlb3scxeQ2kik1VA8cnbnKbXa17Gygc
 5GWvFZPBL8uw04lSgeuZUUWyGUi8A0ElUl31OEtB5qfXFPajLoMS1i8mJAPdYK1jP5
 WxDpXN0e5pzBg==
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d4335cceso1086318285a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 11:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724784510; x=1725389310;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aVRiNgtIQrpl+6j9IJwv+ByTfx7MOBn6Z2ESed44D0=;
 b=DTJVJ73Vansa2jwBidN4cUH1rcPsiK6CONHRgLTv0IhRO7V1gQZ/ytoTM3oVtTeS28
 9vBAR1pQkjUIgBYOS6MUq+kCH2v7i4Xy3k9caNQzi2Dk9WiogrJoqe9QKD6sfo041uAY
 akwNERdZbms81hZg9TMgq1+YhJ6NqfK9kksSHq1igVelCid1rLMdB3vkJCpkWvaNArnO
 B3gFDoup4lUUOflwYClND3Fzatt3ReduQNM4+uEsUSFPvEwYgPqhaeCgUKwOhPRLx/l7
 w2vSD5GLbGEkSEOHbEmMxhHcTf2RfF0ezPBaDOwUnim6Wlo+THn/4ltcw6/K5ebtkXjR
 qR/A==
X-Gm-Message-State: AOJu0YzQNAeK4ZgVgmaQmR7PdW0r+LokSyvpAT/8TxoweWb1Fd7QE+/T
 ARN3OdkcQL7fQUu3NrSES0fCZg1lyo/YSjwnrPWVtpe629l/qpGARBExWYLYtbUey3uZS4KjY61
 NV/X2B5qr9i8aT2lU9LmqdLZrZ1RAcwmmgxyrhkSWGz1ez8Z4gJ92khDKAWu55Li6zeoL4dbjUz
 WR
X-Received: by 2002:a05:620a:2556:b0:7a6:50a4:291c with SMTP id
 af79cd13be357-7a7f328d0f8mr17966185a.14.1724784510261; 
 Tue, 27 Aug 2024 11:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELnda12+fZMDF2xeThd9uQ53RZYgjeQxXiDZ8OelBbXcL12QOgmf60chtbvB/BOX9P+qWRCw==
X-Received: by 2002:a05:620a:2556:b0:7a6:50a4:291c with SMTP id
 af79cd13be357-7a7f328d0f8mr17963485a.14.1724784509972; 
 Tue, 27 Aug 2024 11:48:29 -0700 (PDT)
Received: from localhost ([2607:f2c0:edc2:500:d40d:699e:db17:1848])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f347b15sm575442685a.44.2024.08.27.11.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:48:29 -0700 (PDT)
From: Sergio Durigan Junior <sergio.durigan@canonical.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [ANNOUNCE] QEMU 8.2.6 Stable released
In-Reply-To: <1721203806.547734.831464.nullmailer@tls.msk.ru> (Michael
 Tokarev's message of "Wed, 17 Jul 2024 11:10:06 +0300")
References: <1721203806.547734.831464.nullmailer@tls.msk.ru>
X-URL: http://blog.sergiodj.net
Date: Tue, 27 Aug 2024 14:48:29 -0400
Message-ID: <87ikvlrede.fsf@canonical.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=sergio.durigan@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Aug 2024 15:26:49 -0400
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

On Wednesday, July 17 2024, Michael Tokarev wrote:

> Hi everyone,

Hey Michael,

> The QEMU v8.2.6 stable release is now available.
>
> You can grab the tarball from our download page here:
>
>   https://www.qemu.org/download/#source
>
>   https://download.qemu.org/qemu-8.2.6.tar.xz
>   https://download.qemu.org/qemu-8.2.6.tar.xz.sig (signature)
>
> v8.2.6 is now tagged in the official qemu.git repository, and the
> stable-8.2 branch has been updated accordingly:
>
>   https://gitlab.com/qemu-project/qemu/-/commits/stable-8.2
>
> There are 23 changes since the previous v8.2.5 release, including
> a fix for CVE-2024-4467 (qemu-img info command lack of input validation).
> This is supposed to be the last release in 8.2.x series.
>
> Thank you everyone who has been involved and helped with the stable series!

We talked on IRC but I thought I'd drop this email and make it official.
Ubuntu 24.04 Noble ships QEMU 8.2.x and it would be great if the
stable-8.2 series were to be maintained for a longer period of time.  I
can try helping with review/backporting as time permits.

Thanks for working on this.

-- 
Sergio
GPG key ID: E92F D0B3 6B14 F1F4 D8E0  EB2F 106D A1C8 C3CB BF14

