Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D198FFD8746
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2SsU-00053I-O1; Tue, 17 Mar 2026 07:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2SsS-00052x-Qy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:46:24 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2SsR-0003bB-FW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:46:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D5EAD596A48;
 Tue, 17 Mar 2026 12:46:21 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 8lmB3-2Vr6hm; Tue, 17 Mar 2026 12:46:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D82EF5969F3; Tue, 17 Mar 2026 12:46:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D6EF45968DE;
 Tue, 17 Mar 2026 12:46:19 +0100 (CET)
Date: Tue, 17 Mar 2026 12:46:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 54/60] ui/console: rename public API to use consistent
 qemu_console_ prefix
In-Reply-To: <20260317-qemu-vnc-v1-54-48eb1dcf7b76@redhat.com>
Message-ID: <58fd247c-d4e7-cc42-de42-bd4333574439@eik.bme.hu>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-54-48eb1dcf7b76@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1189689760-1773747979=:98342"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1189689760-1773747979=:98342
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 17 Mar 2026, Marc-André Lureau wrote:
> Rename the display and graphic console public functions to follow a
> consistent qemu_console_ (or qemu_graphic_console_) naming convention.
>
> The previous API used a mix of prefixes: dpy_, graphic_hw_,
> graphic_console_, console_has_, and update_displaychangelistener().
> Unify them under a common qemu_console_ namespace for better
> discoverability and consistency.
>
> The main renames are:
> - dpy_gfx_*() / dpy_text_*() / dpy_gl_*() → qemu_console_*()
> - dpy_{get,set}_ui_info() → qemu_console_{get,set}_ui_info()
> - graphic_hw_*() → qemu_console_hw_*()
> - graphic_console_*() → qemu_graphic_console_*()
> - console_has_gl() → qemu_console_has_gl()
> - update_displaychangelistener() → qemu_console_listener_set_refresh()

Is the qemu_ prefix really needed here or if so would something shorter 
like qcon_ do instead of qemu_console_? With short line limits long names 
cause a lot of line wraps. I think just console_ as already used by some 
of these already would do and be less churn but no strong opinion on any 
of these.

Regards,
BALATON Zoltan
--3866299591-1189689760-1773747979=:98342--

