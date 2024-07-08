Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC685C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqtf-0004g6-EN; Mon, 08 Jul 2024 12:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQqtd-0004YK-Ej
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQqtb-00081f-Fc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720454838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6bd3iREXvZJwAcklUhxiIZH/kcEcSNo/AoU1IEuaXw=;
 b=Fiazx9y5k1VvX9NlWj8O7lqi+htRKMeMZHWQ/YcjTMP5dvu5WkNFseXH/W8O56w1/MllEO
 vGpJKx10ZAhQv2zNFdGuW3EEmtr15BCV0Xj9n8YUBk5JitPcQn+F+te/XycJDtB5G7CSRV
 a2ZczzG6sH6gYL8ju248eJp1DxYmsuY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-NMeczBh7NfiO0g8iJxB_WQ-1; Mon, 08 Jul 2024 12:07:17 -0400
X-MC-Unique: NMeczBh7NfiO0g8iJxB_WQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367a531a2f0so1972947f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720454836; x=1721059636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6bd3iREXvZJwAcklUhxiIZH/kcEcSNo/AoU1IEuaXw=;
 b=aw6DPigcFbeF2PtBFEGPj9QMr7wQE+QVx+MKGiUbg11gH1qiwJaoZ2gjUMahXN+4vL
 /jDO0cQzw25TP6wwRgG+LLzNoRIrX1/nna0KoyDvwqCn71z9wdrgi8h/APyuE1F/EwLg
 fr/Ry5BaxCVq5pR9WjoPF9+yHdXluRdkpxgfcv4AxGVk2EN9CG4i5m4ibli5b82wbvIk
 wZNh/WQsw3hQcwaMxZJtb/z/0oxrrwEsACIzVh6kmbztzvsXTq2j3o7mbviS3tXp9LBK
 Cwep7rnQ2PG6PxFSkh46oWVJPv06+v2zhCxkVvZFiaQqenW5FF4ebchxJDryH1f5Z9kQ
 lUzg==
X-Gm-Message-State: AOJu0Yx0CcDLysUOJL+5ayi1ZXo5wNPCecGXSirYgrAJhz3mfT3qiaIH
 pHF3eiJvooAt2+zIrt0YAv9sUh1uAZM2cCSx7Nht5fyxdzgDc/rZ8y7wKdv2cbDxpLQzkDT1bfq
 41L+aRR+vpWUbo8+hEwpxlrQRmeVFBleC5Cw7RG/C7gCtwYodRsSGZ6+lDb32su6x2agMzJepnS
 1fuk6PONprwcnpjjStHuZw4+U54TI=
X-Received: by 2002:a05:6000:1e4c:b0:363:7788:b975 with SMTP id
 ffacd0b85a97d-367ceaca9bamr30992f8f.52.1720454835789; 
 Mon, 08 Jul 2024 09:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEJ8IMxGw5zwJDQRpZ2I1p2Xc0/CVlOPyTD9gI955A36NR3/ixx584K6oq8ncv0GPND3dp0Ut6YuI+TNeyJ3s=
X-Received: by 2002:a05:6000:1e4c:b0:363:7788:b975 with SMTP id
 ffacd0b85a97d-367ceaca9bamr30971f8f.52.1720454835394; Mon, 08 Jul 2024
 09:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <e5adf20524dc5fcc9ffedf0b65c496a4a1594186.1720094395.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <e5adf20524dc5fcc9ffedf0b65c496a4a1594186.1720094395.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jul 2024 18:07:02 +0200
Message-ID: <CABgObfYststf1dgdtZjEHA6vUf8TjxAGezAoZhnKc+3QxsDAEw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/7] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 4, 2024 at 2:16=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> +ARM PL011 Rust device
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +S: Maintained
> +F: rust/pl011/

No need for this, since it's covered by rust/. If (when) it replaces
the main one, the PL011-specific stanza will be assigned to ARM
maintainers (while you keep covering it via rust/).


> +if with_rust
> +  subdir('rust')
> +endif

Should be in patch 3.

> +subdir('pl011')

As I said before it should be handled via Kconfig, but let's do that
after the initial merge. However...

> +correctness =3D { level =3D "deny", priority =3D -1 }
> +suspicious =3D { level =3D "deny", priority =3D -1 }
> +complexity =3D { level =3D "deny", priority =3D -1 }
> +perf =3D { level =3D "deny", priority =3D -1 }
> +cargo =3D { level =3D "deny", priority =3D -1 }
> +nursery =3D { level =3D "deny", priority =3D -1 }
> +style =3D { level =3D "deny", priority =3D -1 }
> +# restriction group
> +dbg_macro =3D "deny"
> +rc_buffer =3D "deny"
> +as_underscore =3D "deny"

... repeated lints really suggest that you should use a workspace and
a single cargo invocation to build both the rust-qapi and pl011
crates, which I think is doable if you can run bindgen just once.

> +use core::{mem::MaybeUninit, ptr::NonNull};

Let's remove at least this unsafety.

> +#[used]
> +pub static VMSTATE_PL011: VMStateDescription =3D VMStateDescription {
> +    name: PL011_ARM_INFO.name,
> +    unmigratable: true,
> +    ..unsafe { MaybeUninit::<VMStateDescription>::zeroed().assume_init()=
 }
> +};
> +
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
> +    assert!(!obj.is_null());
> +    let mut state =3D NonNull::new_unchecked(obj.cast::<PL011State>());
> +    state.as_mut().init();

This is fine for now, but please add a

// TODO: this assumes that "all zeroes" is a valid state for all fields of
// PL011State. This is not necessarily true of any #[repr(Rust)] structs,
// including bilge-generated types. It should instead use MaybeUninit.

> +}
> +
> +qemu_api::module_init! {
> +    qom: register_type =3D> {
> +        type_register_static(&PL011_ARM_INFO);
> +    }

Can you make the macro look like

   MODULE_INIT_QOM: fn register_type() {
     ...
   }

so that it's clear what "register_type" is, and so that it's easier to
extend it to more values?

> +    #[doc(alias =3D "clk")]
> +    pub clock: NonNull<Clock>,

It's null when init() runs, so please use *mut Clock.

> +    #[doc(alias =3D "migrate_clk")]
> +    pub migrate_clock: bool,

Please put all properties together in the struct for readability.

> +}
> +
> +#[used]
> +pub static CLK_NAME: &CStr =3D c"clk";
> +
> +impl PL011State {
> +    pub fn init(&mut self) {
> +        unsafe {
> +            memory_region_init_io(
> +                addr_of_mut!(self.iomem),
> +                addr_of_mut!(*self).cast::<Object>(),
> +                &PL011_OPS,
> +                addr_of_mut!(*self).cast::<c_void>(),
> +                PL011_ARM_INFO.name,
> +                0x1000,
> +            );
> +            let sbd =3D addr_of_mut!(*self).cast::<SysBusDevice>();
> +            let dev =3D addr_of_mut!(*self).cast::<DeviceState>();
> +            sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
> +            for irq in self.interrupts.iter_mut() {
> +                sysbus_init_irq(sbd, irq);
> +            }
> +            self.clock =3D NonNull::new(qdev_init_clock_in(
> +                dev,
> +                CLK_NAME.as_ptr(),
> +                None, /* pl011_clock_update */
> +                addr_of_mut!(*self).cast::<c_void>(),
> +                ClockEvent_ClockUpdate,
> +            ))
> +            .unwrap();
> +        }
> +    }
> +
> +    pub fn read(&mut self, offset: hwaddr, _size: core::ffi::c_uint) -> =
u64 {
> +        use RegisterOffset::*;
> +
> +        match RegisterOffset::try_from(offset) {
> +            Err(v) if (0x3f8..0x400).contains(&v) =3D> {
> +                u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize]=
)
> +            }
> +            Err(_) =3D> {
> +                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offse=
t 0x%x\n", (int)offset);
> +                0
> +            }
> +            Ok(DR) =3D> {
> +                // s->flags &=3D ~PL011_FLAG_RXFF;
> +                self.flags.set_receive_fifo_full(false);
> +                let c =3D self.read_fifo[self.read_pos];
> +                if self.read_count > 0 {
> +                    self.read_count -=3D 1;
> +                    self.read_pos =3D (self.read_pos + 1) & (self.fifo_d=
epth() - 1);
> +                }
> +                if self.read_count =3D=3D 0 {
> +                    // self.flags |=3D PL011_FLAG_RXFE;
> +                    self.flags.set_receive_fifo_empty(true);
> +                }
> +                if self.read_count + 1 =3D=3D self.read_trigger {
> +                    //self.int_level &=3D ~ INT_RX;
> +                    self.int_level &=3D !registers::INT_RX;
> +                }
> +                // Update error bits.
> +                self.receive_status_error_clear =3D c.to_be_bytes()[3].i=
nto();
> +                self.update();
> +                unsafe { qemu_chr_fe_accept_input(&mut self.char_backend=
) };

Please add a comment here like

// TODO: this causes a callback that creates another "&mut self".
// This is forbidden by Rust aliasing rules and has to be fixed
// using interior mutability.

Paolo


