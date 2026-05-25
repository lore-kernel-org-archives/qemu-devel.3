Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1F3CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRO78-00089f-65; Mon, 25 May 2026 01:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wRO76-00089S-BH
 for qemu-devel@nongnu.org; Mon, 25 May 2026 01:44:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wRO73-0006D5-3e
 for qemu-devel@nongnu.org; Mon, 25 May 2026 01:44:32 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64P5iHSc087468
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 25 May 2026 14:44:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=YdFomS6we7dImNt0mqgL6vb5Bcu1tOcU+XszKJSSuzw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1779687857; v=1;
 b=RV0GU+C/Tu+HU/5mxgPKIdbQUyzukf/T8fDdvnyiiflKPxDhZ/C6gzc6Y/djdfFp
 nw4dCZLNw27N2j/ww+9tsxBRMLb6GauKgeRZzAoRIOtJUsuEsnd8AtHiglKae6sV
 533sKlsfioX3iuXdhauDRFk43ZKOiW/eYMHVCm0uSo0iAZsNzt9wGMaCs4w3vj41
 6AapDDq5cn8Lqh18w0aTJISzkFpLydEhEFf6u6ukD8ORuOYP0R9iV9v0KkYbTpu0
 ROZAwJZ92kh12HFx6TBHrBSDO8PV3A+c3Vr8IofK1T5kKOQO6NPIot6IQh8+OQf5
 ytLOSmQvQXpAfJnV6B5/+g==
Message-ID: <fa0112ca-b388-45d7-8ff5-525ab9bb9635@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 25 May 2026 14:44:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/38] Ui patches
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
 <CAJSP0QXoxZgG4Chk53upHtWXZH-+nvoU041bHe+bHwgFsg353Q@mail.gmail.com>
 <CAJ+F1CKNGvPfc0kL-7D61_Fd3Eh1HSAS_nY3FgA8yQC_WsT2Rg@mail.gmail.com>
 <CAJSP0QUaHNrjN0G9aRTuT+HLeiQACnihW3d0ws8-LzBd_SRi6A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJSP0QUaHNrjN0G9aRTuT+HLeiQACnihW3d0ws8-LzBd_SRi6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/05/25 6:32, Stefan Hajnoczi wrote:
> 
> 
> On Sun, May 24, 2026, 17:13 Marc-André Lureau 
> <marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com>> wrote:
> 
>     Hi
> 
>     On Mon, May 25, 2026 at 12:31 AM Stefan Hajnoczi <stefanha@gmail.com
>     <mailto:stefanha@gmail.com>> wrote:
>      >
>      > On Thu, May 21, 2026 at 9:56 AM <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>> wrote:
>      > >
>      > > From: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>      > >
>      > > The following changes since commit
>     3f129ea545f16e82b5e43fcc3866b134b7cc4dfc:
>      > >
>      > >   Merge tag 'pull-vfio-20260520' of https://github.com/
>     legoater/qemu <https://github.com/legoater/qemu> into staging
>     (2026-05-20 16:53:28 -0400)
>      > >
>      > > are available in the Git repository at:
>      > >
>      > > https://gitlab.com/marcandre.lureau/qemu.git <https://
>     gitlab.com/marcandre.lureau/qemu.git> tags/ui-pull-request
>      > >
>      > > for you to fetch changes up to
>     95df9ffa98a785e4e9368018a72e643e77328ed1:
>      > >
>      > >   ui/gtk: Fix focus loss on re-attachment with single VC
>     (2026-05-21 17:53:43 +0400)
>      > >
>      > > ----------------------------------------------------------------
>      > > UI pull request
>      > >
>      > > - ui/input: Decouple internal and QAPI input events
>      > > - VNC OOB fixes
>      > > - vt100 fixes
>      > > - GTK focus fix
>      > >
>      > > ----------------------------------------------------------------
>      > >
>      > > Akihiko Odaki (29):
>      > >   ui/input: Introduce QemuInputEvent typedef
>      > >   ui/input: Remove QAPI wrappers from QemuInputEvent
>      > >   ui/input: Store QKeyCode directly in QemuInputKeyEvent
>      > >   ui/input: Use Linux key codes for internal key events
>      > >   ui/input: Prohibit sending KEY_RESERVED
>      > >   ui/console: Add qemu_text_console_put_linux()
>      > >   ui/kbd-state: Use Linux key codes
>      > >   hw/arm/musicpal: Use Linux key codes
>      > >   hw/char/escc: Use Linux key codes
>      > >   hw/display/xenfb: Use Linux key codes
>      > >   hw/input/adb-kbd: Use Linux key codes
>      > >   hw/input/hid: Use Linux key codes
>      > >   hw/input/ps2: Use Linux key codes
>      > >   hw/input/virtio-input: Use Linux key codes
>      > >   hw/m68k/next-kbd: Use Linux key codes
>      > >   replay: Use Linux key codes
>      >
>      > Please take a look at this replay failure:
>      > https://gitlab.com/qemu-project/qemu/-/jobs/14521293731#L842
>     <https://gitlab.com/qemu-project/qemu/-/jobs/14521293731#L842>
>      >
>      > If the issue is caused by this pull request, please resend with a
>     fix.
>      >
>      > If the issue is not caused by this pull request, please let me
>     know. Thanks!
> 
>     Oh I missed it, despite running CI tests with ci.variable=QEMU_CI=2
>     (https://gitlab.com/marcandre.lureau/qemu/-/pipelines/2543698396
>     <https://gitlab.com/marcandre.lureau/qemu/-/pipelines/2543698396>) What
>     should I use instead?
> 
> 
> I'm on my phone right now and can't dig into the details, but you can 
> run the functional-system-centos test locally to verify your branch.
> 
> 
>     In "replay: Use Linux key codes" patch, we'd need something like:
> 
>     diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
>     index 081aaa36c5e..ce1031b4ad4 100755
>     --- a/scripts/replay-dump.py
>     +++ b/scripts/replay-dump.py
>     @@ -398,6 +398,9 @@ def decode_end(eid, name, dumpfile):
>       # EVENT_AUDIO_IN has changed
>       v13_event_table = v12_event_table
> 
>     +# EVENT_ASYNC_INPUT has changed
>     +v14_event_table = v13_event_table
>     +
>       def parse_arguments():
>           "Grab arguments for script"
>           parser = argparse.ArgumentParser()
>     @@ -416,7 +419,10 @@ def decode_file(filename):
>           # see REPLAY_VERSION
>           print("HEADER: version 0x%x" % (version))
> 
>     -    if version == 0xe0200d:
>     +    if version == 0xe0200e:
>     +        event_decode_table = v14_event_table
>     +        replay_state.checkpoint_start = 30
>     +    elif version == 0xe0200d:
>               event_decode_table = v13_event_table
>               replay_state.checkpoint_start = 30
>           elif version == 0xe0200c:
> 
>     I can squash and resubmit, or does someone want to revisit it?
> 
> 
> Yes, that's fine.

This fix looks good to me too. Thank you for fixing this.

Regards,
Akihiko Odaki

