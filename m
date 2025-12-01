Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AB8D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3Yr-0003ti-3W; Mon, 01 Dec 2025 08:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQ3Ye-0003sb-5h
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:03:13 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQ3YY-0005NF-8M
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:03:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 377FF5969F6;
 Mon, 01 Dec 2025 14:02:44 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BHl0eNn0DSd2; Mon,  1 Dec 2025 14:02:41 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CD5015969FC; Mon, 01 Dec 2025 14:02:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB1DD5969FA;
 Mon, 01 Dec 2025 14:02:41 +0100 (CET)
Date: Mon, 1 Dec 2025 14:02:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
Message-ID: <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1267199532-1764594161=:31615"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1267199532-1764594161=:31615
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 1 Dec 2025, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> The following patch series provides a GStreamer-based audio backend, which could
> ultimately allow QEMU to leverage the framework to support the various audio
> subsystems and simplify the audio handling logic (timing, resampling, mixing
> etc), as well as allow greater pipeline flexibility and customization.

While it's good to have a GStreamer backend to integrate well into systems 
already using that, this should not replace existing audio backends in 
QEMU. The reason is that GStreamer has extensive dependencies that I would 
like to avoid and still be able to use QEMU with just an ALSA or SDL audio 
backend that are much leaner and provide the needed functionality for most 
cases. Also when using jack you'd want to have a QEMU backend for it not 
going through multiple layers. So adding a GStreamer backend has its use 
as another audio backend but not as a replacement for QEMU's audio 
handling logic and backends.

Regards,
BALATON Zoltan

> The preliminary patches consist of additional cleanups started in QEMU 10.2, in
> order to make the code more modular and use QOM.
>
> Finally, the last patch introduces the "audio" rust crate that implements the
> GStreamer backend. See the TODO list in the commit message for the remaining or
> related work items.
>
> Please review and test!
>
> Based-on: https://gitlab.com/bonzini/qemu.git rust-cargo
> Requires meson from https://github.com/bonzini/meson.git cargo-object-full
>
> Marc-André Lureau (24):
>  rust: patch thiserror to work with meson
>  audio: remove obsolete/obscure functions
>  audio/dbus: make "dbus" the default backend when using -display dbus
>  qemu-options.hx: clarify default audio backend selection
>  audio: introduce AudioDriver
>  audio: simplify audio_init()
>  audio: move object creation to audio_driver_init()
>  audio: add QOM module-objects for each backend
>  audio: remove set_dbus_server from audio_driver
>  audio: lookup "audio-" object types, and realize them
>  audio: switch to module-object, drop audio driver registration
>  module: remove audio module support
>  audio: keep a strong reference on the backend
>  audio: make list type declaration private
>  audio: make create_pdos() private
>  replay: remove dependency on audio/
>  audio: make all the backend-specific APIs take the be
>  audio: make AudioBackend truely abstract
>  audio: split AudioBackend
>  audio: AUD_ -> audio_be_
>  audio-be: add common pre-conditions
>  audio-be: add some state trace
>  audio: split AudioDriver code in audio-driver.c
>  WIP: rust/audio: add GStreamer backend
>
> qapi/audio.json                               |   29 +
> ...dio_template.h => audio-driver_template.h} |   76 +-
> audio/audio_int.h                             |   50 +-
> include/qemu/audio-capture.h                  |   24 +-
> include/qemu/audio.h                          |  129 +-
> include/qemu/module.h                         |    3 +-
> include/system/replay.h                       |    8 +-
> replay/replay-internal.h                      |    2 +
> rust/audio/wrapper.h                          |   27 +
> audio/alsaaudio.c                             |   42 +-
> audio/audio-be.c                              |  276 ++
> audio/audio-driver.c                          | 1988 +++++++++++++++
> audio/audio.c                                 | 2248 ++---------------
> audio/dbusaudio.c                             |   57 +-
> audio/dsoundaudio.c                           |   37 +-
> audio/jackaudio.c                             |   37 +-
> audio/noaudio.c                               |   37 +-
> audio/ossaudio.c                              |   41 +-
> audio/paaudio.c                               |   37 +-
> audio/pwaudio.c                               |   37 +-
> audio/sdlaudio.c                              |   37 +-
> audio/sndioaudio.c                            |   37 +-
> audio/spiceaudio.c                            |   37 +-
> audio/wavaudio.c                              |   37 +-
> audio/wavcapture.c                            |    7 +-
> hw/audio/ac97.c                               |   42 +-
> hw/audio/adlib.c                              |   29 +-
> hw/audio/asc.c                                |   20 +-
> hw/audio/cs4231a.c                            |   18 +-
> hw/audio/es1370.c                             |   26 +-
> hw/audio/gus.c                                |   11 +-
> hw/audio/hda-codec.c                          |   26 +-
> hw/audio/lm4549.c                             |   20 +-
> hw/audio/pcspk.c                              |    8 +-
> hw/audio/sb16.c                               |   22 +-
> hw/audio/via-ac97.c                           |   20 +-
> hw/audio/virtio-snd.c                         |   36 +-
> hw/audio/wm8750.c                             |   42 +-
> hw/display/xlnx_dp.c                          |   14 +-
> hw/usb/dev-audio.c                            |   18 +-
> replay/replay-audio.c                         |   51 +-
> replay/replay.c                               |    2 +-
> replay/stubs-system.c                         |    8 +-
> ui/dbus.c                                     |   16 +-
> ui/vnc.c                                      |    4 +-
> Cargo.lock                                    |  572 ++++-
> Cargo.toml                                    |    6 +
> audio/coreaudio.m                             |   37 +-
> audio/meson.build                             |    2 +
> audio/trace-events                            |    9 +
> qemu-options.hx                               |   20 +-
> rust/audio/Cargo.toml                         |   29 +
> rust/audio/build.rs                           |   49 +
> rust/audio/meson.build                        |   75 +
> rust/audio/src/audio.rs                       |  516 ++++
> rust/audio/src/bindings.rs                    |   32 +
> rust/audio/src/gstreamer.rs                   | 1070 ++++++++
> rust/audio/src/lib.rs                         |   99 +
> rust/meson.build                              |    6 +
> .../packagefiles/syn-2-rs/meson/meson.build   |    3 +
> .../thiserror-2.0.17-include.patch            |   14 +
> .../thiserror-impl-2.0.17-include.patch       |   13 +
> subprojects/syn-2-rs.wrap                     |   11 +-
> subprojects/thiserror-2-rs.wrap               |   10 +
> subprojects/thiserror-impl-2-rs.wrap          |   10 +
> 65 files changed, 5862 insertions(+), 2494 deletions(-)
> rename audio/{audio_template.h => audio-driver_template.h} (90%)
> create mode 100644 rust/audio/wrapper.h
> create mode 100644 audio/audio-be.c
> create mode 100644 audio/audio-driver.c
> create mode 100644 rust/audio/Cargo.toml
> create mode 100644 rust/audio/build.rs
> create mode 100644 rust/audio/meson.build
> create mode 100644 rust/audio/src/audio.rs
> create mode 100644 rust/audio/src/bindings.rs
> create mode 100644 rust/audio/src/gstreamer.rs
> create mode 100644 rust/audio/src/lib.rs
> create mode 100644 subprojects/packagefiles/syn-2-rs/meson/meson.build
> create mode 100644 subprojects/packagefiles/thiserror-2.0.17-include.patch
> create mode 100644 subprojects/packagefiles/thiserror-impl-2.0.17-include.patch
> create mode 100644 subprojects/thiserror-2-rs.wrap
> create mode 100644 subprojects/thiserror-impl-2-rs.wrap
>
>
--3866299591-1267199532-1764594161=:31615--

