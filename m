Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E47C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 14:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyr8-0000PF-9e; Wed, 02 Apr 2025 10:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tzyqy-0000OM-Q7; Wed, 02 Apr 2025 10:14:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tzyqq-0003mV-Q5; Wed, 02 Apr 2025 10:14:03 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 723494E6069;
 Wed, 02 Apr 2025 16:13:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GNMjZdQ41POn; Wed,  2 Apr 2025 16:13:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7879F4E6067; Wed, 02 Apr 2025 16:13:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 763A074577C;
 Wed, 02 Apr 2025 16:13:51 +0200 (CEST)
Date: Wed, 2 Apr 2025 16:13:51 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] rust/hw/char/pl011/src/device: Implement logging
In-Reply-To: <318E2A13-A163-434B-B18A-8A260CD3BC27@gmail.com>
Message-ID: <9296d4f2-c23b-e55e-b8d5-7f14f0eb15c1@eik.bme.hu>
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-3-shentey@gmail.com> <Z-pdzUBa4CrBourR@redhat.com>
 <318E2A13-A163-434B-B18A-8A260CD3BC27@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1695914318-1743603231=:8978"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1695914318-1743603231=:8978
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 2 Apr 2025, Bernhard Beschow wrote:
> Am 31. März 2025 09:18:05 UTC schrieb "Daniel P. Berrangé" <berrange@redhat.com>:
>> General conceptual question .....  I've never understood what the dividing
>> line is between use of 'qemu_log_mask' and trace points.
>
> I *think* it's the perspective: If you want to see any issues, 
> regardless of which device, use the -l option, i.e. qemu_log_mask(). If, 
> however, you want to see what a particular device does, use tracepoints.

I'd say that traces are like debug printfs that you don't normally want to 
see but may be interesting for developers for debugging a specific device 
model or QEMU part so you can enable the relevant ones for that device or 
part. Logs are something you want to notify the user or admin about and is 
not tracing internal operation of a device. But there may be some overlap 
as some logs could be converted to traces but they are under log for 
historical reasons as previously there were debug printfs controlled by 
defines in devices that were later converted to traces and logs that could 
be controlled in run time which were used for some traces before trace 
points existed. Then were probably kept as logs just to not change the 
command line because it's easier to type -d in_asm then say -trace 
enable="tcg_in_asm" or something like that.

Regards,
BALATON Zoltan

>> The latter can be
>> optionally built to feed into qemu log, as well as the other dynamic trace
>> backends.
>
> The use of qemu_log() in qemu_log_mask() seems like an implementation detail to me. Theoretically, qemu_log_mask() could use a different backend if this got implemented, and wouldn't require code changes throughout QEMU.
>
> Best regards,
> Bernhard
>
>>
>> Is there a compelling reason to use 'qemu_log', that isn't acceptable for
>> trace probe points ?
>>
>> This is an indirect way of asking whether qemu_log_mask should be exposed
>> to rust, or would exposing tracing be sufficient ?
>>
>> With regards,
>> Daniel
>
>
--3866299591-1695914318-1743603231=:8978--

