Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7355C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQZo-0004Yf-AZ; Tue, 18 Feb 2025 11:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tkQZm-0004YD-RF; Tue, 18 Feb 2025 11:36:02 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tkQZl-0002AB-1W; Tue, 18 Feb 2025 11:36:02 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso8708517a12.3; 
 Tue, 18 Feb 2025 08:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739896559; x=1740501359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y39IuXLb8+Yv2MA9uCKmIr6MY5yiNZEZ7BG41cUuj8Y=;
 b=iwrlBRAsHN8WnNJxZnbbz6Y+F3jXMu4G2n+jjACwPbR45p78B2hKmTi8EaQQwSBD0A
 iVTwiIcL4BrXk3UmK9xAgAw9Hr2hwQvuw6YzQVgkRU2EX0CEOHAQaXh4jVodj7IVNZ6q
 0Z8tUZPRgCGOGqQOeXHWTtIk6Od4wgbIW8VFREfN9NagsdUyJsk3Y67nss2e2X391d/T
 GBztxjpKyTu290DO7K3pmPsQKFdhycGOyMcAevgpbuGNXTcKroG1xJGKhawziKUHL+jy
 UVt+5VTKYn7tzm+PDS5wc9LtNz5P69zhG2Qe0BjGLwC5U81u3Yt2XqeCwX0w9EOOsqpM
 AeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896559; x=1740501359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y39IuXLb8+Yv2MA9uCKmIr6MY5yiNZEZ7BG41cUuj8Y=;
 b=VBh9+/myLIv2PocVdkYGVHr+ejoJt3VLyB5wKx4ccCDPQFKzzYHA5ug+2aUP+TRo8Z
 vTiMneWoxdcwHkvkPVjaILH7191t+VpDUxGsDJ8h+6bVKvqR8cX5rM5sIakE9H+CAjgy
 N6O5SFJ2xB6KMSrsrUqpDXufCb/LfsJzlhNAjh51xjKWBgdENNTdo1t/mcVv06wOxLAV
 RlB5OnDU7kAkTpqlyP1XGuCbzBjtsbNLW2VMXcn03YldTb0rb4FtBsFMl+ZuidFix3i7
 vuMlJSD+ENnVYViGWNnzWfz2kNcdjs0LdNViOnej18O52Qk6DXP3kB9hEKs3saDa9UT2
 W/YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBjYcGwb0VEcYcgaw5kk/3DZ+3PN/vrrCDsiW/PiIuBCVRtcrOQi6oPU28KrTNCnrV+9LSiFs8IA==@nongnu.org
X-Gm-Message-State: AOJu0YxI5I3hV/lDXH/aXEpOwKdrZKmuo9kVj1R6TpU/aTbJBTsfYyuO
 5ST5Tw4Hg9gmnUVXUL78yeE/Sh4zyIY01nBbWxcdr6NNmsRcZx4VvZ+4KJLxpLuyjTaZE/CO5jL
 bG7HotBcSi8wGvLFJRH/q5mymJrGVXvmHBVk=
X-Gm-Gg: ASbGncuwca/vfrqyrAu0AbqdHgxvz8B+YgDkj7fDGMMjHEcd8oug0TdgV356gFZ5ziR
 v7upDdU3Xb8JvS1ExG5YpY5X82Yy15bP7hYanutyTuS/xEVrUO66v9L+y3CmOnkrmESMYJTOR
X-Google-Smtp-Source: AGHT+IGsi6pDp5KGIzXDY9W2Eu6c+PAcuUiMEkChzpkJPE4hiwDK0DmLJGWyZs2Hu/Why8gso05aXw6DKWENPyl43og=
X-Received: by 2002:a05:6402:5246:b0:5db:f5e9:6745 with SMTP id
 4fb4d7f45d1cf-5e035f4cbcemr15926636a12.0.1739896558995; Tue, 18 Feb 2025
 08:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20250218162618.46167-1-philmd@linaro.org>
 <20250218162618.46167-2-philmd@linaro.org>
In-Reply-To: <20250218162618.46167-2-philmd@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 18 Feb 2025 10:35:45 -0600
X-Gm-Features: AWEUYZngkCBYmTsrxRCCzUblDe0MPj8n_01v-kvqpONaymoS4p_xVYJeHIFfDo4
Message-ID: <CAJy5ezoHT1RehKYvLJtU7=0SR_Ahs2AUBpu==cqvo6zVj1+vXg@mail.gmail.com>
Subject: Re: [PATCH 1/8] accel/Kconfig: Link XenPVH with GPEX PCIe bridge
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, 
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Paul Durrant <paul@xen.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
 Juergen Gross <jgross@suse.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Thomas Huth <thuth@redhat.com>, 
 Jan Beulich <jbeulich@suse.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005856d9062e6d3cc9"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000005856d9062e6d3cc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:26=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> XenPVH requires the PCIe/GPEX device. Add it to Kconfig
> to avoid when configuring using --without-default-devices:
>
>   /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-pvh-common.c.o: in
> function `xenpvh_gpex_init':
>   hw/xen/xen-pvh-common.c:174: undefined reference to `gpex_set_irq_num'
>   /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in
> function `pci_dev_bus_num':
>   include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
>   /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to
> `pci_bus_num'
>   /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to
> `pci_bus_num'
>   /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to
> `pci_bus_num'
>   /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to
> `pci_bus_num'
>   /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in
> function `cpu_ioreq_config':
>   hw/xen/xen-hvm-common.c:412: undefined reference to
> `pci_host_config_read_common'
>   /usr/bin/ld: hw/xen/xen-hvm-common.c:428: undefined reference to
> `pci_host_config_read_common'
>   /usr/bin/ld: hw/xen/xen-hvm-common.c:438: undefined reference to
> `pci_host_config_write_common'
>
> Fixes: f22e598a72c ("hw/xen: pvh-common: Add support for creating
> PCIe/GPEX")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  accel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/accel/Kconfig b/accel/Kconfig
> index 794e0d18d21..4263cab7227 100644
> --- a/accel/Kconfig
> +++ b/accel/Kconfig
> @@ -16,4 +16,5 @@ config KVM
>  config XEN
>      bool
>      select FSDEV_9P if VIRTFS
> +    select PCI_EXPRESS_GENERIC_BRIDGE
>      select XEN_BUS
> --
> 2.47.1
>
>

--0000000000005856d9062e6d3cc9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Feb 18, 2025 at 10:26=E2=80=AFAM =
Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd=
@linaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_conta=
iner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">XenPVH requires the=
 PCIe/GPEX device. Add it to Kconfig<br>
to avoid when configuring using --without-default-devices:<br>
<br>
=C2=A0 /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-pvh-common.c.o: =
in function `xenpvh_gpex_init&#39;:<br>
=C2=A0 hw/xen/xen-pvh-common.c:174: undefined reference to `gpex_set_irq_nu=
m&#39;<br>
=C2=A0 /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: =
in function `pci_dev_bus_num&#39;:<br>
=C2=A0 include/hw/pci/pci.h:337: undefined reference to `pci_bus_num&#39;<b=
r>
=C2=A0 /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_b=
us_num&#39;<br>
=C2=A0 /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_b=
us_num&#39;<br>
=C2=A0 /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_b=
us_num&#39;<br>
=C2=A0 /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_b=
us_num&#39;<br>
=C2=A0 /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: =
in function `cpu_ioreq_config&#39;:<br>
=C2=A0 hw/xen/xen-hvm-common.c:412: undefined reference to `pci_host_config=
_read_common&#39;<br>
=C2=A0 /usr/bin/ld: hw/xen/xen-hvm-common.c:428: undefined reference to `pc=
i_host_config_read_common&#39;<br>
=C2=A0 /usr/bin/ld: hw/xen/xen-hvm-common.c:438: undefined reference to `pc=
i_host_config_write_common&#39;<br>
<br>
Fixes: f22e598a72c (&quot;hw/xen: pvh-common: Add support for creating PCIe=
/GPEX&quot;)<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.ig=
lesias@amd.com">edgar.iglesias@amd.com</a>&gt;</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0accel/Kconfig | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/accel/Kconfig b/accel/Kconfig<br>
index 794e0d18d21..4263cab7227 100644<br>
--- a/accel/Kconfig<br>
+++ b/accel/Kconfig<br>
@@ -16,4 +16,5 @@ config KVM<br>
=C2=A0config XEN<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0select FSDEV_9P if VIRTFS<br>
+=C2=A0 =C2=A0 select PCI_EXPRESS_GENERIC_BRIDGE<br>
=C2=A0 =C2=A0 =C2=A0select XEN_BUS<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div>

--0000000000005856d9062e6d3cc9--

