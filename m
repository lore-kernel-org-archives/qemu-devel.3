Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC7EC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udnyK-0001D5-Ko; Mon, 21 Jul 2025 06:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udnxh-0000vg-Ja
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:41:42 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udnxf-00019z-0U
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:41:36 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70e767ce72eso38161727b3.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753094493; x=1753699293; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+2r6LNE6tW9DE8SC5ADxypcwAmnesM6Ge6Ey+pgMtM=;
 b=WAh4Veen+jXStteaf4x+Ik5RNShWAruARhkdVpO4qerHoxlJjZIJwoyuc0AVnZ2eWN
 uh7d3k3d/qlFJ0yHGvTy92I3nc+eYUhXwZeEMIPUnXQ6cIMz9gAwUfZ1icYl1RLFmUOR
 FBP6UoIAruC7csAPM/W5YWo868BiwJzR0Iy1/npLC19A0l2N2ODSzKcI9sdhk/nxwyGq
 TIJ3Z5AVCc2J+sOtfgCF54xDr11dwU/jApg6iQXaW2hg0U06D1Hwftql4ELc8RfbxoXU
 XA107mxvIA28yN6i91g+chiZULrZOK/Ew18nlGoxa/R3V2DJ5jtUYOmyogcftP8Jucnk
 gXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753094493; x=1753699293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+2r6LNE6tW9DE8SC5ADxypcwAmnesM6Ge6Ey+pgMtM=;
 b=EJADiFSrAAr7vay2sz9p8L5jnwTv1L+QPySBmQz/7jz/shBD/z3ceG7zDEqzuvx3L7
 4YsOB0czdfe6HPW8xdyzfDvU0c2MESZdAsm0sg3R2PC/azaXwbdlUmh07etFS2+2xBSM
 rxmSE4S9MiglHpAUt1bmk+3Pby8Rcn5pAMu5sGqye2PSb5vdtaHgdHs61+u2la6ygkWk
 JyWBRjjBrGMqzi7ro8Up2993knMlfCG87D5nUbjObwqxVFS1evS4XYs73wEGcUbxP///
 L9vprVe5JVLwdt6ppeaMgeWeDzmFnlOwNTO6rfNysFk28+oM8B625/sjYHWaNgigIme5
 n/FA==
X-Gm-Message-State: AOJu0YxKCJzjSz9WRRkav83F4uWGpFuC8ODnY6IPSLZuS7bIYfnIQeuz
 Bvv0hXfF05UzcV30RXKQsrdtKVRAjW6sPAR2O3uu6/rXqaeyrEGkqMqXR0ka9bEVWLQ27M9qDhs
 FfMvwJfBEtKVF8G+Bn50SYhm3UgHOzLwF0zxfwXLGNg==
X-Gm-Gg: ASbGncuB30UZEaRQRcIhQNMjTo77D5C5gbcQ1rhnMsMT9Xxhf5oZ8HcVEWEqvaX706W
 8KrxCKNDIdEAI6mnuVGeEZs/mwDTene+f/mWzpT72K9HsDxo5R12lsf8SGlvMAz5I2lQMHq4Gh3
 pAvhLUXzzVGL/ANmtemEGvkCidzaeis78fWKWK2GhP8fVM7graFU0M7oj1daIUAxDSq3XyMoPTy
 xSxfKgj
X-Google-Smtp-Source: AGHT+IEs29TQvnEXT3kLb43asDqjzcesmuN9cgn533x9eRtZG9KEWYAroIzpkgV3HupkTPIxlM+CLUiHOGzhpijiZtM=
X-Received: by 2002:a05:690c:23c2:b0:719:53fd:79aa with SMTP id
 00721157ae682-71953fd7bc9mr142713137b3.22.1753094493183; Mon, 21 Jul 2025
 03:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250716172813.73405-1-philmd@linaro.org>
 <20250716172813.73405-4-philmd@linaro.org>
In-Reply-To: <20250716172813.73405-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jul 2025 11:41:21 +0100
X-Gm-Features: Ac12FXziqMPNmvRoaGEVCHceZysNoEU-vSgyXD0zuOxSduT7BdPUj4xtngA09vw
Message-ID: <CAFEAcA88O1KpH4V1EPKZSJ1qzLgoP98EP=QrWn=v_M5r3Xyy+w@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 3/3] hw/arm/virt: Warn when HVF doesn't report
 IPA bit length
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 16 Jul 2025 at 18:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Emit a warning when HVF doesn't return the IPA bit length
> and return -1 as "this accelerator is not usable", allowing
> QEMU to try with the next one (when using '-accel hvf:tcg').
>
> Reported-by: Ivan Krasilnikov
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/virt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ef6be3660f5..062812bf252 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3149,8 +3149,12 @@ static int virt_hvf_get_physical_address_range(Mac=
hineState *ms)
>  {
>      VirtMachineState *vms =3D VIRT_MACHINE(ms);
>
> -    int default_ipa_size =3D hvf_arm_get_default_ipa_bit_size();
> -    int max_ipa_size =3D hvf_arm_get_max_ipa_bit_size();
> +    uint32_t default_ipa_size =3D hvf_arm_get_default_ipa_bit_size();
> +    uint32_t max_ipa_size =3D hvf_arm_get_max_ipa_bit_size();
> +    if (!default_ipa_size || !max_ipa_size) {
> +        warn_report("HVF didn't report IPA bit length");
> +        return -1;
> +    }

Even if we avoid blowing up in this function, won't
hvf_accel_init() immediately fail in hvf_arch_vm_create()
and either exit(1) or assert() depending on what error
code it got back ?

It's unfortunate that there's no convenient way we can
check "hvf is basically going to work" in hvf_accel_init()
before we get into the machine-specific hook. "HVF didn't
report IPA bit length" isn't really a very good message
to report for "HVF isn't going to work at all here".

(More generally, I think the hvf code rather overuses
assert_hvf_ok(). I don't think the KVM code uses asserts
for error checking like this.)

thanks
-- PMM

