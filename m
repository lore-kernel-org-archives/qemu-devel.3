Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EC1C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUvmm-000732-M7; Tue, 30 Jan 2024 16:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rUvmk-00072Z-VE
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:36:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rUvmi-0003AE-Ee
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706650606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSHt61PaZMBy+GTDt1iPdVJdrazh+KY3deItt0o4tt4=;
 b=cm8gn0mRj7Y0fvxKP81DThJaRHJtxhN9wY0An3kDNTtPAI8FdpR75YUEsDEhBpkpFAdnXt
 LWrSbt9OJAJ3I8P93AWW/+m1VgCgY2O4Z1nrNAcDW9eDQW1gUn2pm9sDm/IYRCaPalDYvc
 IKwo7DXZqNL0pQSGGJtdgNoCIS6fr0E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-Gpl3VB3uNXC5ZFLtEfHThw-1; Tue, 30 Jan 2024 16:36:44 -0500
X-MC-Unique: Gpl3VB3uNXC5ZFLtEfHThw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29072b2ac68so3000011a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 13:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706650603; x=1707255403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSHt61PaZMBy+GTDt1iPdVJdrazh+KY3deItt0o4tt4=;
 b=IpFBZyVobK5kITJgSkTc1oUIln8j+1xbqF9WloyliNl0wr30KFHN632ktqgIemLlKw
 Vmp2OXLbthINzUrj3zuH5D9R5uEL0c9vJg1XFxKHuxt6Uyn+8WLxh4N0ymeowqZCbKOt
 cAr5My/eyD31JhoHbaWcK9at6poCQD1D7lHDzO2etSsoT5vgsRwGGsnSQIqn2MALwIHr
 InzZBO9lFELq/nawtV8Mbtk0bfvIpIB1I80enLrc1+EIwEL/G8HKnM74KnG7vi+mjRK7
 NlJOBdBChjjbW6hP7bHocOOjNpGsZimWelWnOVRr7pK1ZPftxw5E8s3h3twtI0KUIjfE
 Ijpw==
X-Gm-Message-State: AOJu0YxLeBVL7BllUbhP6y7T2qlGTWD/GkITvwoHFW15rFonxeXgItLF
 bhpaCyrAvoQTehWLWeVho5I8fP9vMWfyaPsAuI6cw7oU8oedMI2OlurVmIZyCHNjn3MDPYiczjt
 rD0IHNEKvYeb6+lpCo6zc/8wLxS2vqilzlCk3eG/TbmgtI4+FoRbyEurWbZTyzdKcLuk4/0/r/b
 fOWlnuEHIYmALHjwLiN6mJkt0jhwo=
X-Received: by 2002:a17:90a:a083:b0:293:d395:f638 with SMTP id
 r3-20020a17090aa08300b00293d395f638mr6869329pjp.8.1706650603165; 
 Tue, 30 Jan 2024 13:36:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSINDjRPxCsp+u/n8SIB5N4NY/uYdgWux7KaaHyukQxQbM5loRSuyfxTus0M45/1YhfLR/PUmhvp0ienG6Nzo=
X-Received: by 2002:a17:90a:a083:b0:293:d395:f638 with SMTP id
 r3-20020a17090aa08300b00293d395f638mr6869309pjp.8.1706650602810; Tue, 30 Jan
 2024 13:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20240125160835.480488-1-npiggin@gmail.com>
 <20240125160835.480488-3-npiggin@gmail.com>
In-Reply-To: <20240125160835.480488-3-npiggin@gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 30 Jan 2024 16:36:31 -0500
Message-ID: <CAFn=p-aB94Y+WSJOdHOsxmrrETy-W76KK4z1qY05QCq2dzV=zg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] scripts/replay-dump.py: Update to current rr
 record format
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 25, 2024 at 11:09=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> The v12 format support for replay-dump has a few issues still. This
> fixes async decoding; adds event, shutdown, and end decoding; fixes
> audio in / out events, fixes checkpoint checking of following async
> events.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  scripts/replay-dump.py | 132 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 98 insertions(+), 34 deletions(-)
>
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index d668193e79..35732da08f 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -20,6 +20,7 @@
>
>  import argparse
>  import struct
> +import os
>  from collections import namedtuple
>  from os import path
>
> @@ -63,6 +64,10 @@ def read_byte(fin):
>      "Read a single byte"
>      return struct.unpack('>B', fin.read(1))[0]
>
> +def read_bytes(fin, nr):
> +    "Read a nr bytes"

Existing problem in this file, but please use """triple quotes""" for
docstrings.

> +    return fin.read(nr)
> +

Does it really save a lot of typing to alias fin.read(1) to
read_bytes(fin, 1) ...?

>  def read_event(fin):
>      "Read a single byte event, but save some state"
>      if replay_state.already_read:
> @@ -134,6 +139,18 @@ def swallow_async_qword(eid, name, dumpfile):
>      print("  %s(%d) @ %d" % (name, eid, step_id))
>      return True
>
> +def swallow_bytes(eid, name, dumpfile, nr):
> +    "Swallow nr bytes of data without looking at it"
> +    dumpfile.seek(nr, os.SEEK_CUR)
> +    return True
> +

Why bother returning a bool if it's not based on any condition? Add an
error check or just drop the return value.

> +def decode_exception(eid, name, dumpfile):
> +    print_event(eid, name)
> +    return True
> +

I suppose in this case, the return is to fit a common signature.

> +# v12 does away with the additional event byte and encodes it in the mai=
n type
> +# Between v8 and v9, REPLAY_ASYNC_BH_ONESHOT was added, but we don't dec=
ode
> +# those versions so leave it out.
>  async_decode_table =3D [ Decoder(0, "REPLAY_ASYNC_EVENT_BH", swallow_asy=
nc_qword),
>                         Decoder(1, "REPLAY_ASYNC_INPUT", decode_unimp),
>                         Decoder(2, "REPLAY_ASYNC_INPUT_SYNC", decode_unim=
p),
> @@ -142,8 +159,8 @@ def swallow_async_qword(eid, name, dumpfile):
>                         Decoder(5, "REPLAY_ASYNC_EVENT_NET", decode_unimp=
),
>  ]
>  # See replay_read_events/replay_read_event
> -def decode_async(eid, name, dumpfile):
> -    """Decode an ASYNC event"""
> +def decode_async_old(eid, name, dumpfile):
> +    """Decode an ASYNC event (pre-v8)"""
>
>      print_event(eid, name)
>
> @@ -157,6 +174,35 @@ def decode_async(eid, name, dumpfile):
>
>      return call_decode(async_decode_table, async_event_kind, dumpfile)
>
> +def decode_async_bh(eid, name, dumpfile):
> +    op_id =3D read_qword(dumpfile)
> +    print_event(eid, name)
> +    return True
> +
> +def decode_async_bh_oneshot(eid, name, dumpfile):
> +    op_id =3D read_qword(dumpfile)
> +    print_event(eid, name)
> +    return True
> +
> +def decode_async_char_read(eid, name, dumpfile):
> +    char_id =3D read_byte(dumpfile)
> +    size =3D read_dword(dumpfile)
> +    print_event(eid, name, "device:%x chars:%s" % (char_id, read_bytes(d=
umpfile, size)))
> +    return True
> +
> +def decode_async_block(eid, name, dumpfile):
> +    op_id =3D read_qword(dumpfile)
> +    print_event(eid, name)
> +    return True
> +
> +def decode_async_net(eid, name, dumpfile):
> +    net_id =3D read_byte(dumpfile)
> +    flags =3D read_dword(dumpfile)
> +    size =3D read_dword(dumpfile)
> +    swallow_bytes(eid, name, dumpfile, size)
> +    print_event(eid, name, "net:%x flags:%x bytes:%d" % (net_id, flags, =
size))
> +    return True
> +
>  total_insns =3D 0
>
>  def decode_instruction(eid, name, dumpfile):
> @@ -166,6 +212,10 @@ def decode_instruction(eid, name, dumpfile):
>      print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
>      return True
>
> +def decode_shutdown(eid, name, dumpfile):
> +    print_event(eid, name)
> +    return True
> +
>  def decode_char_write(eid, name, dumpfile):
>      res =3D read_dword(dumpfile)
>      offset =3D read_dword(dumpfile)
> @@ -177,7 +227,7 @@ def decode_audio_out(eid, name, dumpfile):
>      print_event(eid, name, "%d" % (audio_data))
>      return True
>
> -def decode_checkpoint(eid, name, dumpfile):
> +def __decode_checkpoint(eid, name, dumpfile, old):
>      """Decode a checkpoint.
>
>      Checkpoints contain a series of async events with their own specific=
 data.
> @@ -189,14 +239,20 @@ def decode_checkpoint(eid, name, dumpfile):
>
>      # if the next event is EVENT_ASYNC there are a bunch of
>      # async events to read, otherwise we are done
> -    if next_event !=3D 3:
> -        print_event(eid, name, "no additional data", event_number)
> -    else:
> +    if (old and next_event =3D=3D 3) or (not old and next_event >=3D 3 a=
nd next_event <=3D 9):
>          print_event(eid, name, "more data follows", event_number)
> +    else:
> +        print_event(eid, name, "no additional data", event_number)
>
>      replay_state.reuse_event(next_event)
>      return True
>
> +def decode_checkpoint_old(eid, name, dumpfile):
> +    return __decode_checkpoint(eid, name, dumpfile, False)
> +
> +def decode_checkpoint(eid, name, dumpfile):
> +    return __decode_checkpoint(eid, name, dumpfile, True)
> +
>  def decode_checkpoint_init(eid, name, dumpfile):
>      print_event(eid, name)
>      return True
> @@ -212,15 +268,23 @@ def decode_clock(eid, name, dumpfile):
>
>  def decode_random(eid, name, dumpfile):
>      ret =3D read_dword(dumpfile)
> -    data =3D read_array(dumpfile)
> -    print_event(eid, "%d bytes of random data" % len(data))
> +    size =3D read_dword(dumpfile)
> +    swallow_bytes(eid, name, dumpfile, size)
> +    if (ret):
> +        print_event(eid, name, "%d bytes (getrandom failed)" % (size))
> +    else:
> +        print_event(eid, name, "%d bytes" % (size))
>      return True
>
> +def decode_end(eid, name, dumpfile):
> +    print_event(eid, name)
> +    return False
> +
>  # pre-MTTCG merge
>  v5_event_table =3D [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
>                    Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
>                    Decoder(2, "EVENT_EXCEPTION", decode_plain),
> -                  Decoder(3, "EVENT_ASYNC", decode_async),
> +                  Decoder(3, "EVENT_ASYNC", decode_async_old),
>                    Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
>                    Decoder(5, "EVENT_CHAR_WRITE", decode_char_write),
>                    Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
> @@ -242,7 +306,7 @@ def decode_random(eid, name, dumpfile):
>  v6_event_table =3D [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
>                    Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
>                    Decoder(2, "EVENT_EXCEPTION", decode_plain),
> -                  Decoder(3, "EVENT_ASYNC", decode_async),
> +                  Decoder(3, "EVENT_ASYNC", decode_async_old),
>                    Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
>                    Decoder(5, "EVENT_CHAR_WRITE", decode_char_write),
>                    Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
> @@ -266,7 +330,7 @@ def decode_random(eid, name, dumpfile):
>  v7_event_table =3D [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
>                    Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
>                    Decoder(2, "EVENT_EXCEPTION", decode_unimp),
> -                  Decoder(3, "EVENT_ASYNC", decode_async),
> +                  Decoder(3, "EVENT_ASYNC", decode_async_old),
>                    Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
>                    Decoder(5, "EVENT_SHUTDOWN_HOST_ERR", decode_unimp),
>                    Decoder(6, "EVENT_SHUTDOWN_HOST_QMP", decode_unimp),
> @@ -296,32 +360,31 @@ def decode_random(eid, name, dumpfile):
>
>  v12_event_table =3D [Decoder(0, "EVENT_INSTRUCTION", decode_instruction)=
,
>                    Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
> -                  Decoder(2, "EVENT_EXCEPTION", decode_plain),
> -                  Decoder(3, "EVENT_ASYNC", decode_async),
> -                  Decoder(4, "EVENT_ASYNC", decode_async),
> -                  Decoder(5, "EVENT_ASYNC", decode_async),
> -                  Decoder(6, "EVENT_ASYNC", decode_async),
> -                  Decoder(6, "EVENT_ASYNC", decode_async),
> -                  Decoder(8, "EVENT_ASYNC", decode_async),
> -                  Decoder(9, "EVENT_ASYNC", decode_async),
> -                  Decoder(10, "EVENT_ASYNC", decode_async),
> -                  Decoder(11, "EVENT_SHUTDOWN", decode_unimp),
> -                  Decoder(12, "EVENT_SHUTDOWN_HOST_ERR", decode_unimp),
> -                  Decoder(13, "EVENT_SHUTDOWN_HOST_QMP_QUIT", decode_uni=
mp),
> -                  Decoder(14, "EVENT_SHUTDOWN_HOST_QMP_RESET", decode_un=
imp),
> -                  Decoder(14, "EVENT_SHUTDOWN_HOST_SIGNAL", decode_unimp=
),
> -                  Decoder(15, "EVENT_SHUTDOWN_HOST_UI", decode_unimp),
> -                  Decoder(16, "EVENT_SHUTDOWN_GUEST_SHUTDOWN", decode_un=
imp),
> -                  Decoder(17, "EVENT_SHUTDOWN_GUEST_RESET", decode_unimp=
),
> -                  Decoder(18, "EVENT_SHUTDOWN_GUEST_PANIC", decode_unimp=
),
> -                  Decoder(19, "EVENT_SHUTDOWN_GUEST_SUBSYSTEM_RESET", de=
code_unimp),
> -                  Decoder(20, "EVENT_SHUTDOWN_GUEST_SNAPSHOT_LOAD", deco=
de_unimp),
> -                  Decoder(21, "EVENT_SHUTDOWN___MAX", decode_unimp),
> +                  Decoder(2, "EVENT_EXCEPTION", decode_exception),
> +                  Decoder(3, "EVENT_ASYNC_BH", decode_async_bh),
> +                  Decoder(4, "EVENT_ASYNC_BH_ONESHOT", decode_async_bh_o=
neshot),
> +                  Decoder(5, "EVENT_ASYNC_INPUT", decode_unimp),
> +                  Decoder(6, "EVENT_ASYNC_INPUT_SYNC", decode_unimp),
> +                  Decoder(7, "EVENT_ASYNC_CHAR_READ", decode_async_char_=
read),
> +                  Decoder(8, "EVENT_ASYNC_BLOCK", decode_async_block),
> +                  Decoder(9, "EVENT_ASYNC_NET", decode_async_net),
> +                  Decoder(10, "EVENT_SHUTDOWN", decode_shutdown),
> +                  Decoder(11, "EVENT_SHUTDOWN_HOST_ERR", decode_shutdown=
),
> +                  Decoder(12, "EVENT_SHUTDOWN_HOST_QMP_QUIT", decode_shu=
tdown),
> +                  Decoder(13, "EVENT_SHUTDOWN_HOST_QMP_RESET", decode_sh=
utdown),
> +                  Decoder(14, "EVENT_SHUTDOWN_HOST_SIGNAL", decode_shutd=
own),
> +                  Decoder(15, "EVENT_SHUTDOWN_HOST_UI", decode_shutdown)=
,
> +                  Decoder(16, "EVENT_SHUTDOWN_GUEST_SHUTDOWN", decode_sh=
utdown),
> +                  Decoder(17, "EVENT_SHUTDOWN_GUEST_RESET", decode_shutd=
own),
> +                  Decoder(18, "EVENT_SHUTDOWN_GUEST_PANIC", decode_shutd=
own),
> +                  Decoder(19, "EVENT_SHUTDOWN_SUBSYS_RESET", decode_shut=
down),
> +                  Decoder(20, "EVENT_SHUTDOWN_SNAPSHOT_LOAD", decode_shu=
tdown),
> +                  Decoder(21, "EVENT_SHUTDOWN___MAX", decode_shutdown),
>                    Decoder(22, "EVENT_CHAR_WRITE", decode_char_write),
>                    Decoder(23, "EVENT_CHAR_READ_ALL", decode_unimp),
>                    Decoder(24, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp)=
,
> -                  Decoder(25, "EVENT_AUDIO_IN", decode_unimp),
> -                  Decoder(26, "EVENT_AUDIO_OUT", decode_audio_out),
> +                  Decoder(25, "EVENT_AUDIO_OUT", decode_audio_out),
> +                  Decoder(26, "EVENT_AUDIO_IN", decode_unimp),
>                    Decoder(27, "EVENT_RANDOM", decode_random),
>                    Decoder(28, "EVENT_CLOCK_HOST", decode_clock),
>                    Decoder(29, "EVENT_CLOCK_VIRTUAL_RT", decode_clock),
> @@ -334,6 +397,7 @@ def decode_random(eid, name, dumpfile):
>                    Decoder(36, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkp=
oint),
>                    Decoder(37, "EVENT_CP_INIT", decode_checkpoint_init),
>                    Decoder(38, "EVENT_CP_RESET", decode_checkpoint),
> +                  Decoder(39, "EVENT_END", decode_end),
>  ]
>
>  def parse_arguments():
> --
> 2.42.0
>

I'll leave the rest alone for now.

--js


