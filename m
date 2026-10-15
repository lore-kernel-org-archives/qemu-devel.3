Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A31FCC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEc8-0002G1-V9; Thu, 15 Oct 2026 02:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xHEc6-0002Fs-6X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:06:50 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xHEc3-00046m-8P
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:06:49 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69F66EYZ009619
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Oct 2026 15:06:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=OFoZIXc5UCEWWdnx8cri7CGFAGS9oskQqkjE45n7RD8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1792044375; v=1;
 b=MBf11zMXUNNwcxB2QKZYQcqC6S2U8Y97fPnwLjgLqR2fRhukz9ebRZEbjnPUfL62
 /9CYYgHRSWUIOw3UROypJAnDewgSShYN9Ylg7N/TxEgCUs49/SYZLN6Oe5dV/AGX
 XnyBYIj1/XWitV3NqzamLWwLiJzJT/uP8duJXl+TQPxO+llg7RwLrC/nLnyU500e
 YvFW8U5zmcue3c5QVSlaHC6BsBb9n2gMTcL9fHXNl5Ei03afZZUXMT2Wie8e53cL
 pHiVZJJm0td9/iKq8Z/eJLFT4iC7iPHWnsmtT7zOYD4fvSD8tdYF5+XqpQ+hIBC6
 7WpNZ3SccwBFIQWn4q6gcQ==
Message-ID: <969c6698-d23b-481c-a941-dc1a5a9b2d50@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 15 Oct 2026 15:06:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mst@redhat.com, maciej.szmigiero@oracle.com,
 sgarzare@redhat.com, mark.kanda@oracle.com, vsementsov@yandex-team.ru,
 clg@redhat.com, den@openvz.org, dongli.zhang@oracle.com,
 farosas@suse.de, peterx@redhat.com, dwmw2@infradead.org,
 philmd@oss.qualcomm.com
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

On 2026/10/12 19:28, Andrey Drobyshev wrote:
> v15 -> v16:
> 
>    * Patch 15:
>      - replace the errno filtering in vhost_dev_try_release_owner() with
>        a new 'owner_handed_over' flag in struct vhost_dev.  Release the
>        ownership only if it was handed over to us, and report any failure;
> 
>    * Patch 19:
>      - set 'owner_handed_over' in .post_load() on the CPR target;
>      - drop the redundant 'owner_reset' flag, use vhost_dev.owner instead;
>      - drop Stefano's R-b because of that.
> 
> v15: https://lore.kernel.org/qemu-devel/20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

All comments I raised are now addressed, and other parts of the series 
also look good to me. For the whole series:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

