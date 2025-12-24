Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE18E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPpd-0003p7-Uf; Wed, 24 Dec 2025 09:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPoa-0003VZ-FO
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:26:17 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPoT-0006Kv-Mt
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:26:08 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b728a43e410so1102036766b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 06:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766586364; x=1767191164; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A372ZdRxGvYCj4eLyeuk2dNu7PCYAJNxfaa506SwjbQ=;
 b=ZQc2AJzAxSjTU5CFQc/BGANA7Ylgl7o9xGutqBb7Hgsxzowp7VzKf581nMG5ZYdL9Q
 2nQhBSR/E0u7lLCIgHMWAtl+hFuj7DHkNocnvlc2HhHUfVXp7JZanSzVYgC6ULq85vxv
 po2qHloUioTWcTfSoQp9D7GvUkJ7dky0Efsdu2uhtz4F6lXQlB+4Yh+vvPERreoKJykw
 zjYJ1WrKeghb+CkCymHdP/gDnGNF035JBPFCWqvPqzu3+PzMkQKnSzKfO1j9rsPoDMTx
 yRhkj7OJ3aZBRt0GhLG3ysJLfXdkZ60V3p3NyBViOsR0WjyzH7svMBdy5kt6F1vvEO9b
 j/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766586364; x=1767191164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A372ZdRxGvYCj4eLyeuk2dNu7PCYAJNxfaa506SwjbQ=;
 b=xAgirM4+qzSg6TmYHPK2RaHUgR0lhuNELZ0oksNFBT4XQWUIeg0fjCw5VwmwCNORrQ
 xs8DrP5AMWlvnNr034CBNNL2gRoRVR1hHaKBorlwMa8Cltm5Ja7XMyUs+F4x8LPW49/x
 eR+oUZsFhALw+mce4AmtmM6RTONCGma7TY3jJFzAS2HyWLCxRanSt/HzXT1dsdYS7IzE
 cki4XS48QA3fLURpPA66Nr4cu6Hqmu1m7WxYmKHlw97UUleJpibpLU6sM0LOGy7FU2dJ
 q1+PBNhnWs2ECMV5vntIAs19ugEh64Kd25obI/U/Db2W8HwwfZg2rspHYDgU0mq57vZq
 FgwA==
X-Gm-Message-State: AOJu0YwH6IlthF25Qo4rdPMJ+uBpHyjWoLxUGPjSIXQJjy4qce7yB8/8
 FvOUbkMkTTxWL4/R46srCvlzJEaiCPeVEETwnT7ER+OZuBWutVt2KA8L6DQvQ0yj4cCRVlv3TSH
 D1yHNvOtJZnwwcqPsXiTmHQQwAgqJozbmqL6ser0B9A==
X-Gm-Gg: AY/fxX6ijIPiT4uF6z9JlYFUOkNfrICMfZx1j6yzdoG9VSm5EoFgoLdKNfEVpGZiAj1
 VRfapfYDusRUzqosWcetJR8o/tWRf0av3F+NPCAMDP/TFD9iO6esDV2Wm1YT2oh8B75mj6KfzFp
 Slot4KpxQyeb/sQFWHmlXAqgE3UVUXTd7K/DgHTUvgSNT3j3Wh/whNme5UvZGWvBrl0jy64cd3z
 q5gHBXxPAPqKaHffFKj29XnnrSVOX8qvJAcJKOG2p/MyrSpXYopyZUsuKM1QWNZUXRJ3hk=
X-Google-Smtp-Source: AGHT+IHN1AN67Pz+zD7Jpd4dklo7bAm7KW+3LcjnhS09W90R6ohBEvbQ85seWLRV4mIOFsAahr/jysodY/a0jnDXbpY=
X-Received: by 2002:a17:906:c145:b0:b79:f984:1557 with SMTP id
 a640c23a62f3a-b8037180307mr1894445366b.46.1766586363567; Wed, 24 Dec 2025
 06:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20251224134644.85582-1-philmd@linaro.org>
 <20251224134644.85582-8-philmd@linaro.org>
In-Reply-To: <20251224134644.85582-8-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 16:25:37 +0200
X-Gm-Features: AQt7F2p0MVL9vho_iDpnT9577RMEKAoVCeoNLltHU_qLfFiQ39NNbHXXPh9IZdc
Message-ID: <CAAjaMXZiYtyc1ucfs5hqxwqVFNNE-ebJeQvd4KZfZwdrBTegXg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] rust/system: Stop exposing bogus
 DEVICE_NATIVE_ENDIAN symbol
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-rust@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 24, 2025 at 3:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> We want to remove the bogus DEVICE_NATIVE_ENDIAN definition
> (by only having it explicit, either big or little one). Stop
> exposing it to rust devices to avoid it spreading further.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/system/src/memory.rs | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
> index 4b3316bf767..4e06c16a0b5 100644
> --- a/rust/system/src/memory.rs
> +++ b/rust/system/src/memory.rs
> @@ -78,12 +78,6 @@ pub const fn little_endian(mut self) -> Self {
>          self
>      }
>
> -    #[must_use]
> -    pub const fn native_endian(mut self) -> Self {
> -        self.0.endianness =3D device_endian::DEVICE_NATIVE_ENDIAN;
> -        self
> -    }
> -
>      #[must_use]
>      pub const fn valid_sizes(mut self, min: u32, max: u32) -> Self {
>          self.0.valid.min_access_size =3D min;
> --
> 2.52.0
>

