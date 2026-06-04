Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527FFCD6E68
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV3Rb-0007hr-Hd; Thu, 04 Jun 2026 04:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wV3RY-0007hb-IT
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 04:28:48 -0400
Received: from smtpout4.mo537.mail-out.ovh.net ([51.210.91.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wV3RV-00074J-4s
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 04:28:48 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4gWHlQ0FMjz3wqx;
 Thu,  4 Jun 2026 08:28:33 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  4 Jun 2026 08:28:33 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.239])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gWHlP2Xd6z1xpG; Thu,  4 Jun 2026 08:28:33 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 8BACC2403076; Thu,  4 Jun 2026 08:28:32 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005653f962d-cdc7-4271-a076-dc15a9d51f7c,
 CF95B39D1A067B05C916C5BD8336C8853742392C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4696cf03-08ad-4de4-b782-4d5c253b2cef@kaod.org>
Date: Thu, 4 Jun 2026 10:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, jamin_lin@aspeedtech.com,
 komlodi@google.com
Cc: nabihestefan@google.com, philmd@linaro.org, qemu-devel@nongnu.org
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 3976959946577980438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFoN8fYWqbifFCP2HEd3MqSdAe7pmlgl9lmZJTkkYlWhMatiHCVkZktWUKxDQ2QaWRJlscKUONXMpTbGCLkVcBN4rndvUs3ZF8FeT257RhGXbBX8MVQlXyYqtuTTcgBpQ/JTOKX2osOJZbDzg9XPzTVr2gStLunnq/xg/jJmV09TQam+73/Cv8DJSpHUafMlMr52b0/s6JRvHVP06VLs7voK44miFasc6D2XOXV38qP0Eb2NrzJHVTABwIUbE0iK9U0zNnIBchXksFx1jMHTysJheqRHpK0lsUNwa3NgImPGNaVwsGCW7OvbIeU3vTEqRivsZhk6k5j1LqtBGZa/2jVBPwd8dI7emi3qDwAyJGyKyYJuzvlxFR8tBfgqrY1G83XmkbPKvKjHAoOlPJ9WcEJPt+qyT1jfSt/gLX1R6kSuNk1dVwoHcHNb1YZn0FhXKvrsVPiqJ3OYihzsq0oHA1SatCaHOehLamdWDmpDh+OCVGQbPIlaP/fPu6AMnQUk1V03XBazXF0J9ZFRVTsKX1+HkqLwnkvgo7ne+afyi17UVhu8s1XW9q6LcjjyK2ezoidR7/1f3I935uVbbPKiZ4C8ysjGWfG9kOHblhsS6YbpmUjpcDEVJ+imSQ6hg6uf1r3qqtL2SI1LybunTtuozkrkKMaQy24TwiVelm0kyD6CA
DKIM-Signature: a=rsa-sha256; bh=hq4ltNxk6U+eI00HX+saCxOK1oT1Mx2jAtegWwsO4rQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780561714; v=1;
 b=nQCgzeERlEokObb/yOdglyTeC7FQ/eNAEBtCBTf6tjaq3c4X9dCbyTVPiYuavQs+CNnY78WU
 gXPLbLSCXOUXficYN6185E9EpfY1OGysbkrklp1F/WciwfUEITbOLjLQ7wQzpevSIPdxdy5X6tz
 mEcCXe58fuYgfNL09oLSneM7DcHhdWvjt0LDb9/SK5rl6L3h/mYONL8SzFjfS2FL59kQdYSFkCY
 40Sc7i4oAdJqaomuJDxTCGMSpS6aLA/9fKiHRUlqa/cVhaslSenin+3gwGa7uR0lbsfxZMVghQj
 3yY7rIKZvuL4VsCCcheaW5lCHDsqlFoYF6JZDOkDyFbUw==
Received-SPF: pass client-ip=51.210.91.23; envelope-from=clg@kaod.org;
 helo=smtpout4.mo537.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 6/4/26 02:07, Jithu Joseph wrote:
> This series corrects the DesignWare I3C controller's advertised CMD/data
> FIFO depths and cleans up the misleading queue-capacity field names that
> made the bug easy to overlook.
> 
> The Linux DW-I3C master driver reads QUEUE_STATUS_LEVEL and
> DATA_BUFFER_STATUS_LEVEL at probe to learn the controller's queue depths,
> then rejects any transfer larger than what was advertised with
> -EOPNOTSUPP.  QEMU was resetting these registers to 0x02 / 0x10 instead of
> the real 0x10 / 0x40, so the guest believed the controller could only do
> 64-byte transfers and failed any I3C transfer with a payload larger than
> 64 B.  The backing FIFOs were already allocated at the correct size; only
> the advertised reset values were wrong.
> 
> Patch 1 fixes the reset values, and additionally drives the advertised
> depths from the queue-capacity configs in the reset handlers (per
> Philippe's review) so a configured override is no longer silently ignored.
> Patch 2 is a no-functional-change cleanup renaming the queue-capacity
> struct fields and device properties from _bytes to _words, since the
> values are word counts passed to fifo32_create() -- the old names were
> what made the depth bug slow to spot.  Patch 3 keeps the old _bytes
> property names working as aliases, since they are user-visible and shipped
> in v11.0.0.
> 
> Patch 1 is the actual bug fix and is tagged Cc: qemu-stable; it is kept
> self-contained (using the _bytes field names that exist in released
> branches) so it cherry-picks cleanly.  Patches 2 and 3 are master-only
> cleanup.
> 
> Note on the IBI queue capacity: unlike the cmd/resp and tx/rx capacities,
> it is not advertised to the guest through any status register (the
> hardware exposes only IBI occupancy via IBI_BUF_BLR / IBI_STATUS_CNT, not
> a depth), so it sizes only the internal fifo32 backing store and has no
> entry in dw_i3c_resets[].
> 
> Changes since v1:
>   - Patch 1: drive QUEUE_STATUS_LEVEL / DATA_BUFFER_STATUS_LEVEL from the
>     queue-capacity configs in the reset handlers, in addition to correcting
>     the reset-array values (Philippe Mathieu-Daude).
>   - New patch 3: keep the renamed _bytes properties working as aliases so
>     existing command lines do not break (Philippe Mathieu-Daude).
>   - v1: https://lore.kernel.org/qemu-devel/20260529014034.864722-1-jithu.joseph@oss.qualcomm.com/
> 
> Jithu Joseph (3):
>    hw/i3c: fix CMD/data FIFO depth reset values to match real silicon
>    hw/i3c: rename DW-I3C queue capacity fields from _bytes to _words
>    hw/i3c: keep _bytes aliases for renamed queue-capacity properties
> 
>   include/hw/i3c/dw-i3c.h |  6 ++---
>   hw/i3c/dw-i3c.c         | 58 +++++++++++++++++++++++++++++++----------
>   2 files changed, 47 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38


Jithu,

When you sent this v2, you did as a thread reply to :

   https://lore.kernel.org/qemu-devel/20260529014034.864722-1-jithu.joseph@oss.qualcomm.com/	

This confuses the b4 tool and, in consequence, Jamin's Reviewed-by
is not collected it seems.

Can you please resend as new thread ? If you can can collect Jamin's
Reviewed-by trailers it would be nice.

Thanks,

C.

