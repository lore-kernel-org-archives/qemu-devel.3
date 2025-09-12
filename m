Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2DDCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 20:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxAhi-0004gh-B5; Fri, 12 Sep 2025 16:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uxAhg-0004gW-7G
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 16:49:08 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uxAhe-0002tr-2C
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 16:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1757710142; x=1758314942; i=deller@gmx.de;
 bh=q3qs7tqwRhtvJViioBfpgcBRQCC0msytLTfryK7PdWo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nBMACXs0tOHX/qqtSNeAD9KCDHFoh5dqAKWDYZ1dQpMr+6RleoovOtuYLGuX6B73
 09aQFRpXdL3GOtQ59wG56Xx25cSCNLkuGio8nTSnB9VYgqlj2AFNkSzCbpNS9BCsk
 b/LAYXmcI4mc7MzyTzDK5VnA0sdi9EHISs0alvSlwM+do/ocTCzd8gzLfPyl5NcOb
 3XZtN0H4Wp4xRRpnWQJyz/kotZeZrltm3bRA5DpyClBKpsrJPVj3TwW6FcQevlf7W
 1dr1mQqXatbu2tP2CLXAcTHXwreOdYvkNqUyZoOMQ6dfP+6EZkNzv6CiayA3XSxXU
 Fr+Sg2V0TgzBu1TykQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.58]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1uXm660pBs-00qGK3; Fri, 12
 Sep 2025 22:49:02 +0200
Message-ID: <9d4ae773-0414-4701-a59e-85873da26bf9@gmx.de>
Date: Fri, 12 Sep 2025 22:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: seabios-hppa: is it acpi-aware?
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>
References: <c6aa3d2a-dfc6-4303-9a47-e0e2c3ffb2a5@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <c6aa3d2a-dfc6-4303-9a47-e0e2c3ffb2a5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ujtJG+Wbu23ar48BifRpfZASEnkv9NHuBuzj0z/JThwJ+WiVta6
 NQuRInluLX7THW4/0X+EeaO4Hiyk0nUY5u4KxhDPQPFgcFOL+2mkvueuUoEjh3JZwH5zUjb
 YVdjEXvA/Af/1hbYnnLzbIiBUZgEGvLtuKCoiKFOzbbDdsymcoUzSWjwkiOHNPvGpDJ21Pf
 RLFnORGxc0oC7XW/nhLOQ==
UI-OutboundReport: notjunk:1;M01:P0:MU+z6quB2ms=;CtOiWY/P/dpl6m1ywYEGcIRmF+P
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/12/25 22:35, Michael Tokarev wrote:
> Does seabios-hppa needs ACPI?

No.
 =20
> When building, it embeds the acpi tables (src/fw/acpi-dsdt.hex etc).

That table can be dropped.
If you come up with a patch to build without, I'm happy to
apply it.

Helge

