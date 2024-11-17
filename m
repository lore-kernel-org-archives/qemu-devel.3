Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC25CD68BF2
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 07:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCZte-0003p0-Us; Sun, 17 Nov 2024 02:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tCZtb-0003oK-VK
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 02:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tCZtY-0003Ea-Rh
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 02:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731829231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A47I1OwfzW9N5sRdtj6GdpVl3AjZq2JzQ8BrETv9PSc=;
 b=DI25VNEKgbYGhGOzzNi+DjzoET/a6YADsr+bzJ5wUWchdlOI79tx5UngIJVRQJGFJ3GFvu
 /r6DiitAVk9s0AdZbm5v5PKrdVUp625/uHAY9xc5eP3kAsvfrubef3Ut+KMMNP9CJK7WGM
 QhlMtsVUzL2GFLfQEa/nFmukPW+OVIw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-JxfSYlfLNnqm9bmDuOmoPw-1; Sun, 17 Nov 2024 02:40:27 -0500
X-MC-Unique: JxfSYlfLNnqm9bmDuOmoPw-1
X-Mimecast-MFC-AGG-ID: JxfSYlfLNnqm9bmDuOmoPw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3824395a677so104581f8f.0
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 23:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731829226; x=1732434026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A47I1OwfzW9N5sRdtj6GdpVl3AjZq2JzQ8BrETv9PSc=;
 b=GMR5SVLetjy75jLDaiYZAs1joaDbRZdfs/EJ69otL5xFdLvmfhosSi39Gl2Zl2RS4C
 JQh4yfJ9ul9as6abUO9k5+tIExmToLmJxiQsJKF3vl1joDZVyWkTuakxaht54KE72FZQ
 Vxq3XWh9U49wZvOSKBxXwOsrNEKh2CCi+Ee4vXcqj2PZLsnumVX7tdWdxhBNbqnfz8qb
 /gBm73tTjIKADQBCg6YovNAmN84H6uRr/FalNo/iR4gq1Zkk+1AB+8SKfjGXqslmBmD4
 RP60D/yOIAfbpr2KplSYbYY10AZ9eFRTSkVheU+AekpGHD6VVXSh82KvikAgBh8AqplT
 8MXw==
X-Gm-Message-State: AOJu0YzTyktSJkMEeVHFvo0WM1hJJ5vD9A2AKvLo29/gAONmn7kIV4hV
 TQ/oVCzg5zswXozxvc3xdn0CU4f230u/f/cpAldvVyXZ9DeSkhASfrnlLjEo8QRZY82gD/c1Lt/
 yQ9Bc94zhrd8BenQ4XNEAvdEUlla/fta3XHDRqADI28YiD0LDe0e+kmXb7mjRzbkuFtcf5kkKib
 jG7Zen0QL6iXvyxz5DnB8Wli9mK3s=
X-Received: by 2002:a5d:6d82:0:b0:37d:51b9:7f3b with SMTP id
 ffacd0b85a97d-3822590b6e9mr6977900f8f.11.1731829226627; 
 Sat, 16 Nov 2024 23:40:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEIkyhbJXi19WtGz1mwlL4asrDOMCbr/Gx+9Eo+qga0fcbFfW3LL7gGceFOUbO4osC8gpBqo980/NblQW/PJg=
X-Received: by 2002:a5d:6d82:0:b0:37d:51b9:7f3b with SMTP id
 ffacd0b85a97d-3822590b6e9mr6977875f8f.11.1731829226254; Sat, 16 Nov 2024
 23:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
In-Reply-To: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Nov 2024 08:40:00 +0100
Message-ID: <CABgObfa8Qx7RzZK=VLFmsiEM=ExDb4T1WS4WzYc6D3ACuwc3fw@mail.gmail.com>
Subject: Re: [PATCH v2] rust/pl011: Fix DeviceID reads
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d7cfd2062716e90b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.121,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.696,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000d7cfd2062716e90b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 16 nov 2024, 23:18 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> -    const PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d,
> 0xf0, 0x05, 0xb1];
> -    const PL011_ID_LUMINARY: [c_uchar; 8] =3D [0x11, 0x00, 0x18, 0x01,
> 0x0d, 0xf0, 0x05, 0xb1];
> +    /// Value of `UARTPeriphID0` register, which contains the
> `PartNumber0` value.
> +    const fn uart_periph_id0(self) -> u64 {
> +        0x11
> +    }
> +
> +    /// Value of `UARTPeriphID1` register, which contains the `Designer0=
`
> and `PartNumber1` values.
> +    const fn uart_periph_id1(self) -> u64 {
> +        (match self {
> +            Self::Arm =3D> 0x10,
> +            Self::Luminary =3D> 0x00,
> +        }) as u64
> +    }
> +
> +    /// Value of `UARTPeriphID2` register, which contains the `Revision`
> and `Designer1` values.
> +    const fn uart_periph_id2(self) -> u64 {
> +        (match self {
> +            Self::Arm =3D> 0x14,
> +            Self::Luminary =3D> 0x18,
> +        }) as u64
> +    }
> +
> +    /// Value of `UARTPeriphID3` register, which contains the
> `Configuration` value.
> +    const fn uart_periph_id3(self) -> u64 {
> +        (match self {
> +            Self::Arm =3D> 0x0,
> +            Self::Luminary =3D> 0x1,
> +        }) as u64
> +    }
> +
> +    /// Value of `UARTPCellID0` register.
> +    const fn uart_pcell_id0(self) -> u64 {
> +        0x0d
> +    }
> +
> +    /// Value of `UARTPCellID1` register.
> +    const fn uart_pcell_id1(self) -> u64 {
> +        0xf0
> +    }
> +
> +    /// Value of `UARTPCellID2` register.
> +    const fn uart_pcell_id2(self) -> u64 {
> +        0x05
> +    }
> +
> +    /// Value of `UARTPCellID3` register.
> +    const fn uart_pcell_id3(self) -> u64 {
> +        0xb1
> +    }
>  }
>

In your reply to V1 you wrote:

> Eh, there's no real reason to do that though. I prefer verbosity and
> static checking with symbols rather than indexing; we're not writing C
> here.

I don't see what C has to do with it. Of the three extant options for
DeviceId, you can write them in both C and Rust and they would look pretty
much the same.

I explained the real reason: it's much harder to verify/review the
correctness of independent functions instead of two arrays of four
elements, because consecutive elements are four-five lines apart. There is
also a lot more repetition in writing four match expressions instead of one=
.

Given Peter's remark on rejecting writes, personally I see no reason to
switch away from Index; but I understand that you felt it was an important
change, so I am trying very hard to find a middle ground that is more
readable than both the old code and your proposal here, and combines the
advantages of both. Please try to listen.

         match RegisterOffset::try_from(offset) {
> -            Err(_bad_offset) =3D> {
> +            Err(_) =3D> {
>                  eprintln!("write bad offset {offset} value {value}");
>              }
> +            Ok(
> +                dev_id @ (PeriphID0 | PeriphID1 | PeriphID2 | PeriphID3 =
|
> PCellID0 | PCellID1
> +                | PCellID2 | PCellID3),
> +            ) =3D> {
> +                eprintln!("write bad offset {offset} at RO register
> {dev_id:?} value {value}");
> +            }
>              Ok(FR) =3D> {
> -                // flag writes are ignored
> +                eprintln!("write bad offset {offset} at RO register
> UARTFR value {value}");
>              }
> -            Ok(RIS) =3D> {}
> -            Ok(MIS) =3D> {}
> +            Ok(RIS) =3D> {
> +                eprintln!("write bad offset {offset} at RO register
> UARTRIS value {value}");
> +            }
> +            Ok(MIS) =3D> {
> +                eprintln!("write bad offset {offset} at RO register
> UARTMIS value {value}");
> +            }
>

Please use a single "dev_id @ (...)" pattern instead of duplicating code.

Paolo

             Ok(ICR) =3D> {
>                  self.int_level &=3D !value;
>                  self.update();
> diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.r=
s
> index cd0a49acb9..1f305aa13f 100644
> --- a/rust/hw/char/pl011/src/lib.rs
> +++ b/rust/hw/char/pl011/src/lib.rs
> @@ -111,6 +111,22 @@ pub enum RegisterOffset {
>      /// DMA control Register
>      #[doc(alias =3D "UARTDMACR")]
>      DMACR =3D 0x048,
> +    #[doc(alias =3D "UARTPeriphID0")]
> +    PeriphID0 =3D 0xFE0,
> +    #[doc(alias =3D "UARTPeriphID1")]
> +    PeriphID1 =3D 0xFE4,
> +    #[doc(alias =3D "UARTPeriphID2")]
> +    PeriphID2 =3D 0xFE8,
> +    #[doc(alias =3D "UARTPeriphID3")]
> +    PeriphID3 =3D 0xFEC,
> +    #[doc(alias =3D "UARTPCellID0")]
> +    PCellID0 =3D 0xFF0,
> +    #[doc(alias =3D "UARTPCellID1")]
> +    PCellID1 =3D 0xFF4,
> +    #[doc(alias =3D "UARTPCellID2")]
> +    PCellID2 =3D 0xFF8,
> +    #[doc(alias =3D "UARTPCellID3")]
> +    PCellID3 =3D 0xFFC,
>      ///// Reserved, offsets `0x04C` to `0x07C`.
>      //Reserved =3D 0x04C,
>  }
> @@ -137,7 +153,11 @@ const fn _assert_exhaustive(val: RegisterOffset) {
>                  }
>              }
>          }
> -        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS=
,
> MIS, ICR, DMACR }
> +        case! {
> +            DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS,
> MIS, ICR, DMACR,
> +            PeriphID0, PeriphID1, PeriphID2, PeriphID3,
> +            PCellID0, PCellID1, PCellID2, PCellID3,
> +        }
>      }
>  }
>
>
> base-commit: 43f2def68476697deb0d119cbae51b20019c6c86
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>
>
>

--000000000000d7cfd2062716e90b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 16 nov 2024, 23:18 Manos Pitsidianakis &lt;<a h=
ref=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis@linaro.or=
g</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">-=C2=A0 =C2=A0 const PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x=
00, 0x0d, 0xf0, 0x05, 0xb1];<br>
-=C2=A0 =C2=A0 const PL011_ID_LUMINARY: [c_uchar; 8] =3D [0x11, 0x00, 0x18,=
 0x01, 0x0d, 0xf0, 0x05, 0xb1];<br>
+=C2=A0 =C2=A0 /// Value of `UARTPeriphID0` register, which contains the `P=
artNumber0` value.<br>
+=C2=A0 =C2=A0 const fn uart_periph_id0(self) -&gt; u64 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x11<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Value of `UARTPeriphID1` register, which contains the `D=
esigner0` and `PartNumber1` values.<br>
+=C2=A0 =C2=A0 const fn uart_periph_id1(self) -&gt; u64 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (match self {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Arm =3D&gt; 0x10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Luminary =3D&gt; 0x00,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }) as u64<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Value of `UARTPeriphID2` register, which contains the `R=
evision` and `Designer1` values.<br>
+=C2=A0 =C2=A0 const fn uart_periph_id2(self) -&gt; u64 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (match self {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Arm =3D&gt; 0x14,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Luminary =3D&gt; 0x18,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }) as u64<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Value of `UARTPeriphID3` register, which contains the `C=
onfiguration` value.<br>
+=C2=A0 =C2=A0 const fn uart_periph_id3(self) -&gt; u64 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (match self {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Arm =3D&gt; 0x0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Luminary =3D&gt; 0x1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }) as u64<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Value of `UARTPCellID0` register.<br>
+=C2=A0 =C2=A0 const fn uart_pcell_id0(self) -&gt; u64 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0d<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Value of `UARTPCellID1` register.<br>
+=C2=A0 =C2=A0 const fn uart_pcell_id1(self) -&gt; u64 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xf0<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Value of `UARTPCellID2` register.<br>
+=C2=A0 =C2=A0 const fn uart_pcell_id2(self) -&gt; u64 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x05<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Value of `UARTPCellID3` register.<br>
+=C2=A0 =C2=A0 const fn uart_pcell_id3(self) -&gt; u64 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xb1<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">In your reply to V1 you wrote:</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">&gt; Eh, there&#39;s no real reason to do that though. I pref=
er verbosity and</div><div dir=3D"auto">&gt; static checking with symbols r=
ather than indexing; we&#39;re not writing C</div><div dir=3D"auto">&gt; he=
re.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t see what=
 C has to do with it. Of the three extant options for DeviceId, you can wri=
te them in both C and Rust and they would look pretty much the same.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">I explained the real reason: i=
t&#39;s much harder to verify/review the correctness of independent functio=
ns instead of two arrays of four elements, because consecutive elements are=
 four-five lines apart. There is also a lot more repetition in writing four=
 match expressions instead of one.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Given Peter&#39;s remark on rejecting writes, personally I see n=
o reason to switch away from Index; but I understand that you felt it was a=
n important change, so I am trying very hard to find a middle ground that i=
s more readable than both the old code and your proposal here, and combines=
 the advantages of both. Please try to listen.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match RegisterOf=
fset::try_from(offset) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Err(_bad_offset) =3D&gt; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Err(_) =3D&gt; {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eprintln!(&qu=
ot;write bad offset {offset} value {value}&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ok(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_id @ (PeriphID=
0 | PeriphID1 | PeriphID2 | PeriphID3 | PCellID0 | PCellID1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | PCellID2 | PCell=
ID3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) =3D&gt; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eprintln!(&quot;wr=
ite bad offset {offset} at RO register {dev_id:?} value {value}&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ok(FR) =3D&gt; {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // flag writes are=
 ignored<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eprintln!(&quot;wr=
ite bad offset {offset} at RO register UARTFR value {value}&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ok(RIS) =3D&gt; {}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ok(MIS) =3D&gt; {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ok(RIS) =3D&gt; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eprintln!(&quot;wr=
ite bad offset {offset} at RO register UARTRIS value {value}&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ok(MIS) =3D&gt; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eprintln!(&quot;wr=
ite bad offset {offset} at RO register UARTMIS value {value}&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Please use a single &quot;dev_i=
d @ (...)&quot; pattern instead of duplicating code.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ok(ICR) =3D&gt; {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.int_leve=
l &amp;=3D !value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.update()=
;<br>
diff --git a/rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">lib.rs</a> b/rust/hw/char/pl011/src/<a h=
ref=3D"http://lib.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">lib.r=
s</a><br>
index cd0a49acb9..1f305aa13f 100644<br>
--- a/rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">lib.rs</a><br>
+++ b/rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">lib.rs</a><br>
@@ -111,6 +111,22 @@ pub enum RegisterOffset {<br>
=C2=A0 =C2=A0 =C2=A0/// DMA control Register<br>
=C2=A0 =C2=A0 =C2=A0#[doc(alias =3D &quot;UARTDMACR&quot;)]<br>
=C2=A0 =C2=A0 =C2=A0DMACR =3D 0x048,<br>
+=C2=A0 =C2=A0 #[doc(alias =3D &quot;UARTPeriphID0&quot;)]<br>
+=C2=A0 =C2=A0 PeriphID0 =3D 0xFE0,<br>
+=C2=A0 =C2=A0 #[doc(alias =3D &quot;UARTPeriphID1&quot;)]<br>
+=C2=A0 =C2=A0 PeriphID1 =3D 0xFE4,<br>
+=C2=A0 =C2=A0 #[doc(alias =3D &quot;UARTPeriphID2&quot;)]<br>
+=C2=A0 =C2=A0 PeriphID2 =3D 0xFE8,<br>
+=C2=A0 =C2=A0 #[doc(alias =3D &quot;UARTPeriphID3&quot;)]<br>
+=C2=A0 =C2=A0 PeriphID3 =3D 0xFEC,<br>
+=C2=A0 =C2=A0 #[doc(alias =3D &quot;UARTPCellID0&quot;)]<br>
+=C2=A0 =C2=A0 PCellID0 =3D 0xFF0,<br>
+=C2=A0 =C2=A0 #[doc(alias =3D &quot;UARTPCellID1&quot;)]<br>
+=C2=A0 =C2=A0 PCellID1 =3D 0xFF4,<br>
+=C2=A0 =C2=A0 #[doc(alias =3D &quot;UARTPCellID2&quot;)]<br>
+=C2=A0 =C2=A0 PCellID2 =3D 0xFF8,<br>
+=C2=A0 =C2=A0 #[doc(alias =3D &quot;UARTPCellID3&quot;)]<br>
+=C2=A0 =C2=A0 PCellID3 =3D 0xFFC,<br>
=C2=A0 =C2=A0 =C2=A0///// Reserved, offsets `0x04C` to `0x07C`.<br>
=C2=A0 =C2=A0 =C2=A0//Reserved =3D 0x04C,<br>
=C2=A0}<br>
@@ -137,7 +153,11 @@ const fn _assert_exhaustive(val: RegisterOffset) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, =
CR, FLS, IMSC, RIS, MIS, ICR, DMACR }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case! {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DR, RSR, FR, FBRD, ILPR, IBRD, L=
CR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PeriphID0, PeriphID1, PeriphID2,=
 PeriphID3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCellID0, PCellID1, PCellID2, PC=
ellID3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
<br>
base-commit: 43f2def68476697deb0d119cbae51b20019c6c86<br>
-- <br>
=CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=CE=
=B8=CE=AE=CF=84=CF=89<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000d7cfd2062716e90b--


