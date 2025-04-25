Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27730C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8E1B-0005JY-7X; Fri, 25 Apr 2025 04:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u8E13-0005IV-P7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:02:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u8E11-0006TZ-Bw
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:02:33 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B948845021;
 Fri, 25 Apr 2025 10:02:21 +0200 (CEST)
Date: Fri, 25 Apr 2025 10:02:21 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Message-ID: <1169529009.5681.1745568141083@webmail.proxmox.com>
In-Reply-To: <aAjhZOK_ztcRZS5T@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-6-dietmar@proxmox.com>
 <aAjhZOK_ztcRZS5T@redhat.com>
Subject: Re: [PATCH v3 5/9] h264: new vnc option to configure h264 at server
 side
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
Received-SPF: pass client-ip=94.136.29.106; envelope-from=dietmar@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

> Overloading one config option to both turn h264 on/off,
> an choose encoding is not very desirable.
> 
> IMHO there should be a "h264=<bool>" option to turn it
> on/off, and a separate flag to choose the encoder.

will do that.
 
> Do we even need to give a list of encoders, as opposed
> to just choosing the desired encoder ?

How do you know if the encoder is available? If we use a list,
we can simply loop through and use the first available. This way 
we can also test for (and prefer) hardware encoder...

- Dietmar


