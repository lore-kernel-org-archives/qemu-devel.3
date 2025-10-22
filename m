Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B087CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXXG-0003zZ-DI; Wed, 22 Oct 2025 08:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBXWn-0003p7-IV
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:01:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBXWk-00058K-Bi
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:01:16 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5D07C5972DF;
 Wed, 22 Oct 2025 14:01:12 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id LafugtJWKMJZ; Wed, 22 Oct 2025 14:01:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6823F5972DE; Wed, 22 Oct 2025 14:01:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 66EDC59703F;
 Wed, 22 Oct 2025 14:01:10 +0200 (CEST)
Date: Wed, 22 Oct 2025 14:01:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 39/42] audio: cleanup, use bool for booleans
In-Reply-To: <20251022065640.1172785-40-marcandre.lureau@redhat.com>
Message-ID: <64adbda1-d7dc-cd74-0268-cc36e9d7093f@eik.bme.hu>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022065640.1172785-40-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-62740332-1761134470=:88897"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-62740332-1761134470=:88897
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 22 Oct 2025, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Use slightly better types for the job.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> audio/audio_int.h      | 12 ++++++------
> audio/audio_template.h |  6 +++---
> include/qemu/audio.h   |  8 ++++----
> audio/audio.c          | 30 +++++++++++++++---------------
> 4 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index a97edd77dd..c804302e51 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -67,9 +67,9 @@ typedef struct STSampleBuffer {
>
> typedef struct HWVoiceOut {
>     AudioBackend *s;
> -    int enabled;
> +    bool enabled;
>     int poll_mode;
> -    int pending_disable;
> +    bool pending_disable;

I don't know if this is part of a state for migration but if not maybe 
it's better to also move pending_disable up before poll_mode to group the 
bools that enable/disable something together (and the struct may need less 
padding that way depending on what type by the compiler uses for bool).

Regards,
BALATON Zoltan
--3866299591-62740332-1761134470=:88897--

