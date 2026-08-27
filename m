Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1224CC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzTOs-0000do-9J; Thu, 27 Aug 2026 02:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzTOo-0000bP-5L; Thu, 27 Aug 2026 02:15:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzTOm-0003zP-1k; Thu, 27 Aug 2026 02:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787811332; bh=pe7o/VHVWw0rn/1ItvaYCpNWHXAAWr6EwvSme8B78ao=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rJnYpFlRt8Ge9KE9tM8OxsD9CV8a/uJ/fxXpZKwBakFJWNowqaN6vhv8TJb7W2azp
 LzQZmbRMHEFbK8zKeSGrMLOYiE/BRSp2vEeR1WLTMLutGLBwMytSIqVUw8PjNSbnbh
 jUaWThYcfXG44xlZxCaKsN9AmQOA9nv28SpiFUhKr+h4phVNIYXuIWUaXAoJnRYNHR
 1MDDEeD35WhAB3rcwr9ai/7fIt32BlVSHIIRVR+/iqAoN54myVF8P977TPFy73t8T3
 SwQp3ITlgt5iq+YJP62qjzu2j28faFATe+okzINIJ5HNMbrqxf7OwpSqqi55osYy61
 XwKdSf1Gvl5Lg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 142251CEFCC;
 Thu, 27 Aug 2026 09:15:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5515A418E2D;
 Thu, 27 Aug 2026 09:15:34 +0300 (MSK)
Message-ID: <61d9eca3-8bb0-468c-b448-1e7f601a9dba@tls.msk.ru>
Date: Thu, 27 Aug 2026 09:14:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] IDE patches
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260826111524.3383479-1-den@openvz.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/26/26 14:15, Denis V. Lunev wrote:

> IDE patches
> 
> - fix the logical CHS translation a guest selects with INITIALIZE
>    DEVICE PARAMETERS: reject a translation the device may not accept
>    instead of dying on a division by zero, report the default
>    translation in IDENTIFY DEVICE words 1, 3 and 6 and the one in
>    effect in words 54 to 58, keep those words in sync when the
>    translation changes, migrate both the translation and the SET
>    FEATURES 0xCC revert flag, and return the power-on defaults on a
>    hardware reset rather than on every reset
> - harden the IDE and AHCI state a guest or an incoming migration
>    stream can reach: reject an out-of-range PIO transfer window on
>    load, refuse a PIO transfer with no command header, clear cur_cmd
>    when the command list is unmapped, treat a failed PRDT walk as a
>    transfer failure, reject a command header with an invalid FIS
>    length, and drain the ports on teardown so that a request cannot
>    outlive an unplug
> - report ATAPI UDMA5 with a matching standard and cable
> - extend the IDE/AHCI qtest coverage for all of the above

> ----------------------------------------------------------------
> Denis V. Lunev (28):
>        hw/ide: reject an unsupported CHS translation
>        tests/qtest/ide-test: cover a CHS translation with zero sectors
>        tests/qtest/libqos/ahci: allow a count and an expected error
>        tests/qtest/ahci: cover the sector count of INITIALIZE DEVICE PARAMETERS
>        hw/ide: report the default CHS translation in IDENTIFY DEVICE
>        hw/ide: name the retired IDENTIFY DEVICE words the device fills in
>        hw/ide: factor out the IDENTIFY DEVICE current geometry words
>        hw/ide: keep the IDENTIFY DEVICE current geometry in sync
>        hw/ide: restore the power-on device state before loading
>        hw/ide: migrate the logical CHS translation
>        hw/ide: migrate the power-on defaults revert flag
>        tests/qtest/ide-test: cover the CHS translation across migration
>        tests/qtest/ide-test: cover a rejected CHS translation in the stream
>        tests/qtest/ide-test: cover the IDENTIFY DEVICE geometry words
>        hw/ide: revert the CHS translation on a hardware reset
>        tests/qtest/ide-test: cover the CHS translation across resets
>        hw/ide: drop a redundant interrupt from INITIALIZE DEVICE PARAMETERS
>        hw/ide: reject an out-of-range PIO transfer window on load
>        tests/qtest/ide-test: cover the migrated PIO transfer window
>        hw/ide/ahci: refuse a PIO transfer with no command header
>        hw/ide/ahci: clear cur_cmd when the command list is unmapped
>        tests/qtest/ahci: regression test for a PIO write vs. engine stop
>        hw/ide/ahci: treat a failed PRDT walk as a PIO transfer failure
>        hw/ide/ahci: reject a command header with an invalid FIS length
>        hw/ide/ahci: drain the ports on teardown
>        tests/qtest/ahci: regression test for a request outliving an unplug
>        hw/ide: report ATAPI UDMA5 with a matching standard and cable
>        tests/qtest/ide-test: cover the UDMA5 identify words

Hi!

Are you sure only two changes from this series should be picked up to the
stable series --

   hw/ide: reject an unsupported CHS translation
   hw/ide: report the default CHS translation in IDENTIFY DEVICE

(I'm also picking up the test case:
   tests/qtest/ide-test: cover a CHS translation with zero sectors)

It feels like, at least,
   hw/ide: reject an out-of-range PIO transfer window on load
(with the test case) should be picked up too.

The ahci fixes seems to be good candidates as well.

Maybe some others?

Thanks,

/mjt

