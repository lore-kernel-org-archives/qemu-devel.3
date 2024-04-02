Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A43ECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrfyV-0007xb-If; Tue, 02 Apr 2024 11:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrfyP-0007x8-08
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:22:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrfyN-0005OX-2D
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:22:52 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56dcf805aa1so2223689a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712071368; x=1712676168; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uKc2kHgqBSITJmcUtq3y+FN0in1CPzzN73XEFk4o7Pc=;
 b=FMsulomjZFeYTe18atiTXTsgEVjeSCtqRxpHLsBq+vsft5bvXPWAzpxbf7h7W215ml
 t+uujV3St7zfdb5ZWOjsLEvZ5n7O0aKVmQ2ivZGc33cFepLb3smiewcKgGAC2un16rcF
 JBqosxwXoAtItdkPzYDD+viEow1KOtwFP04RK5ED9rgYZIh6Uj+/y+7Q1X0rZwtNPBQA
 io5mRqrle8sJSgNH3p8rQ+bcBQd8eTZkiR/5z0TlzG6UdQInn5I04iXd5rz0biFnMsF/
 6mlrPb3VgUGSt8ts5NEzCCQuIVFB3B94AbBba7RrClBf38FHtea4eZOEkvgMk1rbguFP
 WOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712071368; x=1712676168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uKc2kHgqBSITJmcUtq3y+FN0in1CPzzN73XEFk4o7Pc=;
 b=wGKvcl2NRkGdIH/nCSOQa2cbW+t0VqSr2swS+jCiRw88FJ6hwg5iaMS1fcouSp7DC6
 WQEU9OOIyRm7/6u6pVZOIdC5yOQ6zv+PCC4MJXkrP6uA5S7E4UbHncn/NUvKvTU9TG02
 izppOkxsreTGz5Q0m9LqSuvEJBAHXtzN2qXYdR1+NMwfVaSyYYyH3bTNP9Krxho+YTUj
 UNFTx04icdv1MuhQVdUCWnpaKGLTyDty4P9mG3/wIJGc7y4y3X2UPqcWHkg930lHmDI5
 HZYPxL8wL8GDO79WBP3BbhcGa3GWOwhGaA4Bz/goRTs7IzUvWBmnZL5sxUuFCe7qXlyN
 QSHw==
X-Gm-Message-State: AOJu0YwEz+6Id/MgMWRRdhN5PLenegL5XiPHP0Dj1sGrlOU3snh126e4
 lDJcfuRNg6SlP38sE0WHiyRhkBUChzqBDHh7reQqm7wYBH7VGN/o+Fei2Xi98R89JSRD/uVWCPs
 c+duIBHIFHCNe3Pqr8ZFfEYcAVEcU+KBryQ5Pkg==
X-Google-Smtp-Source: AGHT+IGcUDEoqUQKA2GZXuoHDS8p/i8AsWWbPWoKkSRk2U4rv4Um08RYCSeGamwRg65T1CwAvxKgGN+U4HWJ4JfU9yE=
X-Received: by 2002:a05:6402:26cd:b0:56b:c1c7:63cd with SMTP id
 x13-20020a05640226cd00b0056bc1c763cdmr9344725edd.31.1712071368306; Tue, 02
 Apr 2024 08:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240402131649.23225-1-pbonzini@redhat.com>
In-Reply-To: <20240402131649.23225-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 16:22:37 +0100
Message-ID: <CAFEAcA-J=BVW43TxFVCbn8YUQTtTAoa7FoRiEknB=UH2_yMNPg@mail.gmail.com>
Subject: Re: [PULL 0/7] lsi, vga fixes for 2024-04-02
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 2 Apr 2024 at 14:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit b9dbf6f9bf533564f6a4277d03906fcd32bb0245:
>
>   Merge tag 'pull-tcg-20240329' of https://gitlab.com/rth7680/qemu into staging (2024-03-30 14:54:57 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to eac4af186f6db46fc90ec571a855bd6fa4cb7841:
>
>   pc_q35: remove unnecessary m->alias assignment (2024-04-02 15:14:02 +0200)
>
> ----------------------------------------------------------------
> * lsi53c895a: fix assertion failure with invalid Block Move
> * vga: fix assertion failure with 4- and 16-color modes
> * remove unnecessary assignment
>
> ----------------------------------------------------------------
> Paolo Bonzini (7):
>       vga: merge conditionals on shift control register
>       vga: move computation of dirty memory region later
>       vga: adjust dirty memory region if pel panning is active
>       vga: do not treat horiz pel panning value of 8 as "enabled"
>       lsi53c895a: avoid out of bounds access to s->msg[]
>       lsi53c895a: detect invalid Block Move instruction
>       pc_q35: remove unnecessary m->alias assignment

This seems to break the avocado test
tests/avocado/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_netbsd

and it's consistent even with retrying the job:
https://gitlab.com/qemu-project/qemu/-/jobs/6529626987
https://gitlab.com/qemu-project/qemu/-/jobs/6528696711
https://gitlab.com/qemu-project/qemu/-/jobs/6529196532

The debug log says:

14:23:32 DEBUG| Transitioning from 'Runstate.CONNECTING' to 'Runstate.RUNNING'.
14:23:32 DEBUG| Opening console file
14:23:32 DEBUG| Opening console socket
14:23:32 DEBUG| >> =============================================================
14:23:32 DEBUG| >> OpenBIOS 1.1 [Mar 7 2023 22:21]
14:23:32 DEBUG| >> Configuration device id QEMU version 1 machine id 0
14:23:32 DEBUG| >> CPUs: 0
14:23:32 DEBUG| >> Memory: 128M
14:23:32 DEBUG| >> UUID: 00000000-0000-0000-0000-000000000000
14:23:32 DEBUG| >> CPU type PowerPC,604
14:23:32 DEBUG| milliseconds isn't unique.
14:23:32 DEBUG| Output device screen not found.
14:23:32 DEBUG| Output device screen not found.
14:23:32 DEBUG| Trying cd:,\\:tbxi...
14:23:32 DEBUG| Trying cd:,\ppc\bootinfo.txt...
14:23:32 DEBUG| Trying cd:,%BOOT...
14:23:32 DEBUG| No valid state has been set by load or init-program

and then the test times out because it never sees the NetBSD
console output it's waiting for.

Successful job for a previous pullreq:
https://gitlab.com/qemu-project/qemu/-/jobs/6527774374

Here the debug log says:

12:36:14 DEBUG| >> =============================================================
12:36:14 DEBUG| >> OpenBIOS 1.1 [Mar 7 2023 22:21]
12:36:14 DEBUG| >> Configuration device id QEMU version 1 machine id 0
12:36:14 DEBUG| >> CPUs: 0
12:36:14 DEBUG| >> Memory: 128M
12:36:14 DEBUG| >> UUID: 00000000-0000-0000-0000-000000000000
12:36:14 DEBUG| >> CPU type PowerPC,604
12:36:14 DEBUG| milliseconds isn't unique.
12:36:14 DEBUG| Output device screen not found.
12:36:14 DEBUG| Output device screen not found.
12:36:14 DEBUG| Trying cd:,\\:tbxi...
12:36:14 DEBUG| >> Not a bootable ELF image
12:36:15 DEBUG| >> switching to new context:
12:36:15 DEBUG| >> NetBSD/prep BOOT, Revision 1.9
12:36:15 DEBUG| Shutting down VM appliance; timeout=30
12:36:15 DEBUG| Attempting graceful termination
12:36:15 DEBUG| Closing console file
12:36:15 DEBUG| Closing console socket
12:36:15 DEBUG| Politely asking QEMU to terminate

This machine uses the lsi53c810 SCSI controller, and
it's failing to load from the CDROM, so my guess is the
problem is in one of the two SCSI patches.

thanks
-- PMM

