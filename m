Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61744C05023
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 23:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxxRH-0006vs-EZ; Fri, 19 Apr 2024 19:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1rxxRF-0006vW-N6
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 19:14:37 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1rxxRE-0003IB-38
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 19:14:37 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4VLr7m4MRsz8PbP;
 Fri, 19 Apr 2024 19:14:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; s=default; bh=mxvbNq4zX
 4ON0WTAwlg9N2dYkJ0=; b=ZHBkEU1KITc315wuKZkj/yy9fe14URNqk972gsFjL
 lO3+DsL5r2K239S0yEciFpyvyCCBnZbQeSZsoc56wIdCC5BF/xY3HZVu8y8Tyqc/
 QEuKA6XJiRwmNg2Qf6miqkcpcF1ggDgqY/+iSFFOfpMD3to2tyRrhm3MLjQTvyIv
 ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=XqQ
 WkXZTSBeh4BNG/sBn+3Ve/7aH0tjSbTKTpEYmIAbDKycVQfVj4Bd9DJgMiyWfRBi
 lSiV4YASnvHGRPYXXlLKh0q4h7n0he1YR+SZft/tC1BXd2i+bvaZMgeKxnUDtxmd
 Jda+Pl1inYDGmyElQu3vQ+HDx4JB4mHZSZnTCiZM=
Received: from [IPV6:2001:470:b050:6:cc31:46d5:f26a:a82b] (unknown
 [IPv6:2001:470:b050:6:cc31:46d5:f26a:a82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4VLr7m3fsMz8PbN;
 Fri, 19 Apr 2024 19:14:28 -0400 (EDT)
Message-ID: <59c90771-3bef-4f35-bd3f-0cbf9d7551c5@comstyle.com>
Date: Fri, 19 Apr 2024 19:14:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs/system/target-sparc: Improve the Sparc
 documentation
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-5-thuth@redhat.com>
 <529ece4e-1de6-4941-bb75-c10997aad13c@ilande.co.uk>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <529ece4e-1de6-4941-bb75-c10997aad13c@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024-04-18 4:27 p.m., Mark Cave-Ayland wrote:
> On 07/03/2024 17:43, Thomas Huth wrote:
>
>> Add some words about how to enable or disable boolean features,
>> and remove the note about a Linux kernel being available on the
>> QEMU website (they have been removed long ago already).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 docs/system/target-sparc.rst | 8 ++++++--
>> =C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.r=
st
>> index 9ec8c90c14..9f418b9d3e 100644
>> --- a/docs/system/target-sparc.rst
>> +++ b/docs/system/target-sparc.rst
>> @@ -27,6 +27,11 @@ architecture machines:
>> =C2=A0 The emulation is somewhat complete. SMP up to 16 CPUs is suppor=
ted,=20
>> but
>> =C2=A0 Linux limits the number of usable CPUs to 4.
>> =C2=A0 +The list of available CPUs can be viewed by starting QEMU with=
=20
>> ``-cpu help``.
>> +Optional boolean features can be added with a "+" in front of the=20
>> feature name,
>> +or disabled with a "-" in front of the name, for example
>> +``-cpu TI-SuperSparc-II,+float128``.
>> +
>> =C2=A0 QEMU emulates the following sun4m peripherals:
>> =C2=A0 =C2=A0 -=C2=A0 IOMMU
>> @@ -55,8 +60,7 @@ OpenBIOS is a free (GPL v2) portable firmware=20
>> implementation. The goal
>> =C2=A0 is to implement a 100% IEEE 1275-1994 (referred to as Open Firm=
ware)
>> =C2=A0 compliant firmware.
>> =C2=A0 -A sample Linux 2.6 series kernel and ram disk image are availa=
ble=20
>> on the
>> -QEMU web site. There are still issues with NetBSD and OpenBSD, but mo=
st
>> +There are still issues with NetBSD and OpenBSD, but most
>> =C2=A0 kernel versions work. Please note that currently older Solaris =
kernels
>> =C2=A0 don't work probably due to interface issues between OpenBIOS an=
d
>> =C2=A0 Solaris.
>
> Just curious as to what current issues exist with NetBSD and OpenBSD?=20
> At least both my NetBSD and OpenBSD test images survive a casual boot=20
> test here with latest git.

I was just trying OpenBSD/sparc64 with 8.2 recently and found hme(4) does
not work. I tried with the NE2k driver as I remember adding the driver=20
to the
OpenBSD kernel before an hme driver existed and it sort of worked, but th=
ere
were still issues.

I'll re-test with 9 now and see what happens.

