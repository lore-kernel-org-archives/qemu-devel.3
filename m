Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E58E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt8rb-0002GQ-Vf; Thu, 19 Feb 2026 13:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1vt8rZ-0002GF-QF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:34:57 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1vt8rX-0001va-QF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:34:57 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98.2) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1vt8rN-0000000Cn3C-1whc; Thu, 19 Feb 2026 19:34:45 +0100
Message-ID: <dc328350-91aa-40a7-a28a-2aa2e54ad132@maciej.szmigiero.name>
Date: Thu, 19 Feb 2026 19:34:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 26/34] hw/hyperv/vmbus: add support for confidential
 guest reset
To: Ani Sinha <anisinha@redhat.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-27-anisinha@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
In-Reply-To: <20260218114233.266178-27-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 18.02.2026 12:42, Ani Sinha wrote:
> On confidential guests when the KVM virtual machine file descriptor changes as
> a part of the reset process, event file descriptors needs to be reassociated
> with the new KVM VM file descriptor. This is achieved with the help of a
> callback handler that gets called when KVM VM file descriptor changes during
> the confidential guest reset process.
> 
> This patch is tested on non-confidential platform only.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---

I have also tested this patch with a non-confidential Windows guest
with VMBus, including live migrating it a few times.

No regressions observed, so:
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Thanks,
Maciej


