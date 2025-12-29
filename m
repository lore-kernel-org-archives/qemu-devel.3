Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2627DD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAzl-0005F7-A4; Mon, 29 Dec 2025 06:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAzJ-00052E-5V
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:00:45 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAzH-0002tO-MV
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:00:32 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so1497774066b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006030; x=1767610830; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaScrPJCraYBbYBx0impQBs+ZteQMgxtxNRJoE5FS70=;
 b=IoD/gJp9zAuYD9sMiZ4uC5zvcSVl3XGWrLVpwLBQck/Njmm+6PokYYJEowEb3w25ou
 4PbDpd2dwijpkzWAOnDDrW3EUc9Dqla73ccoiayswycC1CkG5MJJQkdF+Njao2qMsdc1
 AX8AWEHk+JESZnbF1YDM+an1WVFeGB4CEvqbv4pr6i0bRWZgoHUft7B0IsXRdVEJYmYi
 S+YpCqpQSnUfx95dLpraFTlRVIu9modDOxlgefKXd9bUo8UgJL2MSz3NG8tvhOs73IOD
 tOyWxosZZ6yEbWmUyK1xV5IZkZbWWOITnJVGwfdL7faAo94HuUTUrQZOv2QPc1dV3RsG
 YlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006030; x=1767610830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FaScrPJCraYBbYBx0impQBs+ZteQMgxtxNRJoE5FS70=;
 b=AOrNO6ueW+WxHn3+TF6n/hKKgo/yF4/Rxp7xkJfsfzQ9T/OhH9Ele/2rJsGS1SkgcW
 aXadBaeJ46tkA5VMnB31Y6oimxn2WB18tOxH2sjj3BlLWelsCZW2twJKA+3Y9ANFGC6e
 Py3TDTsardNSkWTHkVYRwIHUartHHmDKpVzD2O/aHxP74Hc6Dxy6EoLl1Sz8CumR0vGQ
 44v32YljSKG56BN6F1Md8KelmsAlTbLJWefAdyCDuIhQ2XBDCByuqKme5G3d2U2MB1AG
 kwfzhUFJPz3vJScrXbHKoGdIa0xuAex/zqTNiC2tGhUfzzw7rluibS+s9PK8wIkQM8nj
 4qoQ==
X-Gm-Message-State: AOJu0YzUx8P8F7D6PqKYlGnq33HLAh0KXl6er/YsLZ/gmAcBB+lmkhur
 5qEqDz5dBv9QE4qN5M1GE5Gb0bgWFoechapttXmzuPExzKSAZ1s/geYLOTx5jK1xv6FrTei1FeH
 jLCJrRS/txnQ4UNrTUYMNGTZ8VkvN1rDsbzrjv/rW+Q==
X-Gm-Gg: AY/fxX7mSaP2hIhr6AER+/9eeVl+s5ucE8U3R8PoyIhTIjsfjWm9qIjTlr9gaqsrlmZ
 wmNcA1MQL8hvu/N8DglXXmNs1hQS1rGd0B8Mj7LIhSPYd1HGuSij0rpO+5nMTBrqou2gbRNrkmx
 4AXfZKchspuP47mpC36IrT27ePg2HX6Q+FG7U7eTPD7RHJpZaUkEJTDXGg0HHYDYE6Ss+MEBmqj
 bWlnng+l9vXgfFkkIzVsxazUT+S7NQeXNQ0qRBNp7zORdBHoW6H4EzIVMoMcehnrpf+i1/woeAt
 iAKDX39NTbyiqocSNqYsSqRT4bqKKj0PspmwtCQ=
X-Google-Smtp-Source: AGHT+IGMChuq4ueDEVEX5wYwR1VcbjAY2wih61U0jPNnD0XirMQBLe9LKWgj4Rn/NHqZ536I2AyfOmPwCMbwQ6jMPsc=
X-Received: by 2002:a17:906:9fd2:b0:b73:42df:27a with SMTP id
 a640c23a62f3a-b8036f2fa8fmr2860072666b.1.1767006029902; Mon, 29 Dec 2025
 03:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-3-philmd@linaro.org>
In-Reply-To: <20251224161804.90064-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:00:03 +0200
X-Gm-Features: AQt7F2pZTaHcfsK11S2wtD-1hIkHXgFM9XIo8z9V9-I2iK1sqV_hg9-JSSiDnFc
Message-ID: <CAAjaMXbETpkpiQC2QFgNedFOu7nbVY1oJEi5odYMy-y0da_pEg@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/openrisc: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jia Liu <proljc@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

On Wed, Dec 24, 2025 at 6:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The OpenRISC architecture uses big endianness. Directly
> use the big-endian LD/ST API.
>
> Mechanical change running:
>
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' target/openrisc/);
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/openrisc/gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
> index 45bba80d878..ca1592c6200 100644
> --- a/target/openrisc/gdbstub.c
> +++ b/target/openrisc/gdbstub.c
> @@ -50,7 +50,7 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8=
_t *mem_buf, int n)
>      CPUOpenRISCState *env =3D cpu_env(cs);
>      uint32_t tmp;
>
> -    tmp =3D ldl_p(mem_buf);
> +    tmp =3D ldl_be_p(mem_buf);
>
>      if (n < 32) {
>          cpu_set_gpr(env, n, tmp);
> --
> 2.52.0
>

