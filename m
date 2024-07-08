Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7C2C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 22:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQx2I-0001FL-3k; Mon, 08 Jul 2024 18:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sQx2G-0001Ek-Ev
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 18:40:40 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sQx2D-0004I7-ER
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 18:40:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5EE26611D9;
 Mon,  8 Jul 2024 22:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD9C4AF0B;
 Mon,  8 Jul 2024 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720478433;
 bh=4ls6Hf63iWX5WfFe6DkUcMHrn5wRaVTX9QAYAS/BBlk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=aES30YoX30ntTKIIzwmvLtPV3c13dJjt+p9+U+uWlqP5Pl81llgeJywYSDnlvUBWI
 vk1bZSkvW0cmxEKHj6S8wVc+U9YjWWDCBoDS4KaOaMEqVQ2jRqfmdRUqTpjkpp/aUN
 CvsGdfQewshpJs/ZHfwcvGGKN8FpchhxjGil6UuLAxmZrARJqCfQ4RezkIQqUP85M5
 +rmy4BxTe4/2+JlUijTv3GA+zPj5F2IpnLxmHL/wimIfTCMUKhyBYxRk6bhPpcd/v6
 P9SZrutKY57xblO2CAfNK2T3TWC1rATyLlb2JDTIRcIlH0wq5Bp8RtZTkDD+OgHVya
 qke2I6jzTjVZg==
Date: Mon, 8 Jul 2024 15:40:30 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Peng Fan <peng.fan@nxp.com>
cc: "stefano.stabellini@amd.com" <stefano.stabellini@amd.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Julien Grall <julien@xen.org>, 
 "oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, edgar.iglesias@amd.com, 
 sstabellini@kernel.org
Subject: Re: Question: xen + vhost user
In-Reply-To: <AM6PR04MB59412237BA10A23EB79D5C0E88D22@AM6PR04MB5941.eurprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2407081539380.3635@ubuntu-linux-20-04-desktop>
References: <AM6PR04MB59412237BA10A23EB79D5C0E88D22@AM6PR04MB5941.eurprd04.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

+Edgar

I don't think we are using vhost-user so I am unable to help, but adding
Edgar just in case

On Sun, 30 Jun 2024, Peng Fan wrote:
> Hi All,
> 
> I am trying to enable vhost user input with xen hypervisor on i.MX95, using qemu
> vhost-user-input. But meet " Invalid vring_addr message ". My xen domu cfg:
> 
> '-chardev', 'socket,path=/tmp/input.sock,id=mouse0',
> '-device', 'vhost-user-input-pci,chardev=mouse0',
> 
> Anyone knows what missing?
> 
> Partial error log:
> ================ Vhost user message ================
> Request: VHOST_USER_SET_VRING_ADDR (9)
> Flags:   0x1
> Size:    40
> vhost_vring_addr:
>     index:  0
>     flags:  0
>     desc_user_addr:   0x0000ffff889b0000
>     used_user_addr:   0x0000ffff889b04c0
>     avail_user_addr:  0x0000ffff889b0400
>     log_guest_addr:   0x00000000444714c0
> Setting virtq addresses:
>     vring_desc  at (nil)
>     vring_used  at (nil)
>     vring_avail at (nil)
> 
> ** (vhost-user-input:1816): CRITICAL **: 07:20:46.077: Invalid vring_addr message
> 
> Thanks,
> Peng.
> 
> The full vhost user debug log:
> ./vhost-user-input --socket-path=/tmp/input.sock --evdev-path=/d
> -path=/dev/input/event1 ./vhost-user-input --socket-path=/tmp/input.sock --evdev-
> ================ Vhost user message ================
> Request: VHOST_USER_GET_FEATURES (1)
> Flags:   0x1
> Size:    0
> Sending back to guest u64: 0x0000000175000000
> ================ Vhost user message ================
> Request: VHOST_USER_GET_PROTOCOL_FEATURES (15)
> Flags:   0x1
> Size:    0
> ================ Vhost user message ================
> Request: VHOST_USER_SET_PROTOCOL_FEATURES (16)
> Flags:   0x1
> Size:    8
> u64: 0x0000000000008e2b
> ================ Vhost user message ================
> Request: VHOST_USER_GET_QUEUE_NUM (17)
> Flags:   0x1
> Size:    0
> ================ Vhost user message ================
> Request: VHOST_USER_GET_MAX_MEM_SLOTS (36)
> Flags:   0x1
> Size:    0
> u64: 0x0000000000000020
> ================ Vhost user message ================
> Request: VHOST_USER_SET_BACKEND_REQ_FD (21)
> Flags:   0x9
> Size:    0
> Fds: 6
> Got backend_fd: 6
> ================ Vhost user message ================
> Request: VHOST_USER_SET_OWNER (3)
> Flags:   0x1
> Size:    0
> ================ Vhost user message ================
> Request: VHOST_USER_GET_FEATURES (1)
> Flags:   0x1
> Size:    0
> Sending back to guest u64: 0x0000000175000000
> ================ Vhost user message ================
> Request: VHOST_USER_SET_VRING_CALL (13)
> Flags:   0x1
> Size:    8
> Fds: 7
> u64: 0x0000000000000000
> Got call_fd: 7 for vq: 0
> ================ Vhost user message ================
> Request: VHOST_USER_SET_VRING_ERR (14)
> Flags:   0x1
> Size:    8
> Fds: 8
> u64: 0x0000000000000000
> ================ Vhost user message ================
> Request: VHOST_USER_SET_VRING_CALL (13)
> Flags:   0x1
> Size:    8
> Fds: 9
> u64: 0x0000000000000001
> Got call_fd: 9 for vq: 1
> ================ Vhost user message ================
> Request: VHOST_USER_SET_VRING_ERR (14)
> Flags:   0x1
> Size:    8
> Fds: 10
> u64: 0x0000000000000001
> (XEN) d2v0 Unhandled SMC/HVC: 0x84000050
> (XEN) d2v0 Unhandled SMC/HVC: 0x8600ff01
> (XEN) d2v0: vGICD: RAZ on reserved register offset 0x00000c
> (XEN) d2v0: vGICD: unhandled word write 0x000000ffffffff to ICACTIVER4
> (XEN) d2v0: vGICR: SGI: unhandled word write 0x000000ffffffff to ICACTIVER0
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_CONFIG (25)
> Flags:   0x9
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_GET_CONFIG (24)
> Flags:   0x1
> Size:    148
> ================ Vhost user message ================
> Request: VHOST_USER_SET_FEATURES (2)
> Flags:   0x1
> Size:    8
> u64: 0x0000010170000000
> ================ Vhost user message ================
> Request: VHOST_USER_SET_VRING_NUM (8)
> Flags:   0x1
> Size:    8
> State.index: 0
> State.num:   64
> ================ Vhost user message ================
> Request: VHOST_USER_SET_VRING_BASE (10)
> Flags:   0x1
> Size:    8
> State.index: 0
> State.num:   0
> ================ Vhost user message ================
> Request: VHOST_USER_SET_VRING_ADDR (9)
> Flags:   0x1
> Size:    40
> vhost_vring_addr:
>     index:  0
>     flags:  0
>     desc_user_addr:   0x0000ffff889b0000
>     used_user_addr:   0x0000ffff889b04c0
>     avail_user_addr:  0x0000ffff889b0400
>     log_guest_addr:   0x00000000444714c0
> Setting virtq addresses:
>     vring_desc  at (nil)
>     vring_used  at (nil)
>     vring_avail at (nil)
> 
> ** (vhost-user-input:1816): CRITICAL **: 07:20:46.077: Invalid vring_addr message
> 
> root@imx95evk:~#
> 

