Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37C4109024D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Fs3-0002nz-SF; Thu, 19 Mar 2026 12:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w3Fp2-0001kb-Q0
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 12:02:16 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w3Foz-0001mT-Iq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 12:02:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6566280778;
 Thu, 19 Mar 2026 19:01:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d57::1:20] (unknown
 [2a02:6bf:8080:d57::1:20])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id u1RvHI2AeeA0-BIpZ5rbe; Thu, 19 Mar 2026 19:01:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773936118;
 bh=QHqhu3ENGr448NtgY9djZUbZAjHw7TvfQx5mlmIGu0Q=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ltyLgKnk0Xk2kM4CNEWT+CTGT3WNA2tQi9H3+3iA6VOtAHbv3uvz1WH+NPGR/CLtD
 lw7MuEUgTllaqQTdMLgGroXl0+XTTw6v/z79/+HWObs4XxxdfqQQj0uDJKAYVEpSvR
 fByI/f93f0SR9zYP8mdmRWvLFsewwXHSVF2sxJcM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <74681855-1f27-4d31-a391-37aa04407919@yandex-team.ru>
Date: Thu, 19 Mar 2026 19:01:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/8] virtio-net: live-TAP local migration
To: jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, eblake@redhat.com, farosas@suse.de, peterx@redhat.com, 
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, davydov-max@yandex-team.ru,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, th.huth+qemu@posteo.eu,
 berrange@redhat.com, pbonzini@redhat.com
References: <20260319155333.260341-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260319155333.260341-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 19.03.26 18:53, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a new migration parameter "local", which allows to
> enable local migration of TAP virtio-net backend (and maybe other
> devices and backends in future), including its properties and open
> fds.
> 
> With this new option, management software doesn't need to initialize
> new TAP and do a switch to it. Nothing should be done around
> virtio-net in local migration: it just migrates and continues to use
> same TAP device. So we avoid extra logic in management software, extra
> allocations in kernel (for new TAP), and corresponding extra delay in
> migration downtime.
> 
> v13:
> 01: simplify extra "else if" to "else"
> 03: reword documentation (with Markus), drop r-b [sorry, but to be sure,
>      that it is OK for Peter too]
> 06: - reword documentation
>      - error-out instead of silently ignore
>        br=, ifname=, sndbuf=, vnet_hdr=, when mentioned together
>        with new incoming-fds parameter.
>      - fix stealing packages from TAP by source qemu process after
>        source STOP

Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
    "[PATCH v4 00/13] net: refactoring and fixes"

-- 
Best regards,
Vladimir

