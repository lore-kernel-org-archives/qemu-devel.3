Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016FDCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5qZ-0004em-35; Tue, 23 Jun 2026 14:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wc5qH-0004cP-Jd
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:27:27 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wc5qF-0001Ls-Rp
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:27:25 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wc5q5-00000004mJt-1nlD; Tue, 23 Jun 2026 20:27:13 +0200
Message-ID: <8ea776eb-525f-4203-a1e8-35b16ad6cfa0@maciej.szmigiero.name>
Date: Tue, 23 Jun 2026 20:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] migration: emit SETUP notification before CPR
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, peterx@redhat.com, dongli.zhang@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
 <20260619105514.128812-2-andrey.drobyshev@virtuozzo.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <20260619105514.128812-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 19.06.2026 12:55, Andrey Drobyshev wrote:
> Devices register their own callbacks to MIG_EVENT_* notifications and
> process them accordingly.  But some devices, especially during CPR-style
> migration, might need to be aware and process SETUP event earlier on.  One
> such example is vhost-based devs, as they need to call RESET_OWNER ioctl
> before the target (in the cpr-transfer case) tries to call SET_OWNER.
> 
> Let's move SETUP notification to an earlier place in qmp_migrate().  Before
> this change, SETUP was firing shortly before migration thread creation, and
> FAILED notification balancing it was only fired from
> migration_iteration_finish() (ran in the thread).  But now by moving SETUP
> to earlier we widen the window.  Hence let's also add FAILED to
> migration_connect_error_propagate() and the special CPR-related case in
> migration_cancel(), to balance things out.
> 
> This patch is a rework of the change originally proposed by Steve and
> Ben at [0].
> 
> [0] https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com
> 
> Originally-by: Steve Sistare <steven.sistare@oracle.com>
> Originally-by: Ben Chaney <bchaney@akamai.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
Looks okay to me, but will wait on Peter and/or Fabiano opinion here,
since this is core migration code.

Thanks,
Maciej


