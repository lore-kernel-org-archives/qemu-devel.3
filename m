Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40841D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3pq-00013d-Sp; Mon, 01 Dec 2025 08:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQ3pl-00013Q-0O
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:20:53 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vQ3pj-0008Ko-5r
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:20:52 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 34A0A5969FA;
 Mon, 01 Dec 2025 14:20:48 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id fU6aqyCHqdV8; Mon,  1 Dec 2025 14:20:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3C0F15969F6; Mon, 01 Dec 2025 14:20:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3A2F95969F4;
 Mon, 01 Dec 2025 14:20:46 +0100 (CET)
Date: Mon, 1 Dec 2025 14:20:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>
Subject: Re: [RFC 08/24] audio: add QOM module-objects for each backend
In-Reply-To: <20251201112309.4163921-9-marcandre.lureau@redhat.com>
Message-ID: <f25c53b4-3f47-242f-0e39-778fa0bc3f35@eik.bme.hu>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <20251201112309.4163921-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-839563834-1764595246=:31615"
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

--3866299591-839563834-1764595246=:31615
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 1 Dec 2025, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> This will allow to use QOM and the dynamic object module loading.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> audio/audio_int.h   |  2 ++
> audio/alsaaudio.c   | 39 +++++++++++++++++++++++++++++++++++++++
> audio/dbusaudio.c   | 36 ++++++++++++++++++++++++++++++++++++
> audio/dsoundaudio.c | 36 ++++++++++++++++++++++++++++++++++++
> audio/jackaudio.c   | 36 ++++++++++++++++++++++++++++++++++++
> audio/noaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
> audio/ossaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
> audio/paaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
> audio/pwaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
> audio/sdlaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
> audio/sndioaudio.c  | 36 ++++++++++++++++++++++++++++++++++++
> audio/spiceaudio.c  | 36 ++++++++++++++++++++++++++++++++++++
> audio/wavaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
> audio/coreaudio.m   | 36 ++++++++++++++++++++++++++++++++++++
> 14 files changed, 473 insertions(+)

This patch is entirely QOM boiler plate... Are the empty functions really 
needed? Could this use OBJECT_DECLARE_SIMPLE_TYPE instead to cut this 
down?

Regards,
BALATON Zoltan
--3866299591-839563834-1764595246=:31615--

