Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF02C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 10:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0HbO-0002rg-Lx; Thu, 03 Apr 2025 06:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u0HbM-0002qL-VZ; Thu, 03 Apr 2025 06:15:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u0HbK-0000YU-DQ; Thu, 03 Apr 2025 06:15:12 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so1041375a12.1; 
 Thu, 03 Apr 2025 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743675306; x=1744280106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJL+HVgyFDaHDUBAUM2JzO3ixLihswVz3d4T3C855fk=;
 b=Vj6N7HcBii67YRjkJY0eQK3cxYUFzsa0CyXlEWGpvap1obe3Dc9V0FfG/tK9ZtgCyY
 pwC1lTwPs0RugYYEDO3KuMiz8wU3xxqpTlx19rCHaoPJrvGItENF/BHespTO1k7EYg7y
 oeJ/kzvfB2y7Dk0mqv463oWnTIDCgNFbERJPkaCHTCUGw59mIRvGtYwfknhrOcVFhVJ5
 ctAPN6W0ueicQh2FfYWHFcIWVweHzKW6j6QnWcck5qq6iGZpuApueMwur2Cvfdd8RG5w
 xJOzKBvIMeVr7VfscCcrkZS74sq1krXpM4FEJBdm50vt/aksjUkmOjpYLAVtYxSGSLyw
 gHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743675306; x=1744280106;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJL+HVgyFDaHDUBAUM2JzO3ixLihswVz3d4T3C855fk=;
 b=KksCEEp+8Imwn9iOxXlA3dBsR4QoU1SxCamFirft3i5VssoEHywFSltbkaflmVclDX
 SWJF8OutYOQC+EtqyUpd8ku9678MjRm43//d3Qh8tI1kTsXvvBvOjEoL4nRtxgMYN4FP
 sgbJIRR21u94rl19KjKRDqBTe4gkaSfn43KhXLqLlzb82qZMcCv6CuxHDNWpsn84CROg
 1M21wYswLCudkBbQckuRJmYtvQRotJapfRKcD0OVpXs+z3RDVIfnPITWd+RpjCf/wo7o
 8pH0u5T9sqZcxRGnFxncRQvtGEA/rmxNoi1aRRjILERoQPWNNirXECOkmtFa5HVqq6Wm
 zLFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ZegX4EpD9NoLiYfM6no5x2PLgJ36U8ya5SvAHSaOJ+iOh1hWGlbN+3XhEQj4bREpP6zc5QskqFk=@nongnu.org
X-Gm-Message-State: AOJu0YzueecWgdJqfGrbW9ITbHaJC3BKceAdl/FQMPPjKY0d2Tm6yhwV
 jpBWuZPYt6U4vVXdmLLUWaKcCV/CJ96axufZxKJ0IEIAHncrCrKF
X-Gm-Gg: ASbGnctVK99Vs7mjBhLmQ5KqaGWDoCIhal6pyAvMX7Cj61atN+kxs9fmUvJD+bkG7Q0
 1OOsFvx4ZT2LR1ZG3golX5RuaWWJfc3ubjmnwyceIrRxk5FILfmYI3FmpDEO3nAEQcZAE9T0psA
 BxqdJm2y3Mp/Yh77FgyshI84NuVYM9Mttv6qMMJfpNnr/1tMGcH+WvC/urVm18AcVUubW9qwcSB
 38ayIUZJyQUOnU2AfFLo75VBxdKlslyUsLBnm+yNWoXJqGjqiVkImbtjinb+byF76itr9H3BBVs
 7fIG+cgcdjHWGAnS7IciOwAOmt35akJQ/Bw2bo78
X-Google-Smtp-Source: AGHT+IFX/u0cZse001Sc2A3WOH7BdvHFq7ADYhtCae7I0adZm2wpdaPCA5dBcHMi3QjvLMX1DOmWCA==
X-Received: by 2002:a05:6402:320c:b0:5ee:497:67d7 with SMTP id
 4fb4d7f45d1cf-5ee049769bcmr16185509a12.34.1743675305857; 
 Thu, 03 Apr 2025 03:15:05 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f087ed1de4sm710051a12.24.2025.04.03.03.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 03:15:05 -0700 (PDT)
Date: Thu, 03 Apr 2025 09:46:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] rust/hw/char/pl011/src/device: Implement logging
In-Reply-To: <Z-07WTw4PHHKhfxU@redhat.com>
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-3-shentey@gmail.com> <Z-pdzUBa4CrBourR@redhat.com>
 <318E2A13-A163-434B-B18A-8A260CD3BC27@gmail.com>
 <Z-07WTw4PHHKhfxU@redhat.com>
Message-ID: <036F69F7-A83C-469D-82A5-071167CA651E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 2=2E April 2025 13:27:53 UTC schrieb "Daniel P=2E Berrang=C3=A9" <berra=
nge@redhat=2Ecom>:
>On Wed, Apr 02, 2025 at 09:33:16AM +0000, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 31=2E M=C3=A4rz 2025 09:18:05 UTC schrieb "Daniel P=2E Berrang=C3=A9=
" <berrange@redhat=2Ecom>:
>> >On Sun, Mar 30, 2025 at 10:58:57PM +0200, Bernhard Beschow wrote:
>> >> Now that there is logging support in Rust for QEMU, use it in the pl=
011 device=2E
>> >>=20
>> >> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> >> ---
>> >>  rust/hw/char/pl011/src/device=2Ers | 12 ++++++++----
>> >>  1 file changed, 8 insertions(+), 4 deletions(-)
>> >>=20
>> >> diff --git a/rust/hw/char/pl011/src/device=2Ers b/rust/hw/char/pl011=
/src/device=2Ers
>> >> index bf88e0b00a=2E=2Ed5470fae11 100644
>> >> --- a/rust/hw/char/pl011/src/device=2Ers
>> >> +++ b/rust/hw/char/pl011/src/device=2Ers
>> >> @@ -8,9 +8,11 @@
>> >>      chardev::{CharBackend, Chardev, Event},
>> >>      impl_vmstate_forward,
>> >>      irq::{IRQState, InterruptSource},
>> >> +    log::{LOG_GUEST_ERROR, LOG_UNIMP},
>> >>      memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOps=
Builder},
>> >>      prelude::*,
>> >>      qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, Re=
setType, ResettablePhasesImpl},
>> >> +    qemu_log_mask,
>> >>      qom::{ObjectImpl, Owned, ParentField},
>> >>      static_assert,
>> >>      sysbus::{SysBusDevice, SysBusDeviceImpl},
>> >> @@ -298,8 +300,7 @@ pub(self) fn write(
>> >>              DMACR =3D> {
>> >>                  self=2Edmacr =3D value;
>> >>                  if value & 3 > 0 {
>> >> -                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not imp=
lemented\n");
>> >> -                    eprintln!("pl011: DMA not implemented");
>> >> +                    qemu_log_mask!(LOG_UNIMP, "pl011: DMA not imple=
mented\n");
>> >>                  }
>> >>              }
>> >>          }
>> >> @@ -535,7 +536,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u6=
4 {
>> >>                  u64::from(device_id[(offset - 0xfe0) >> 2])
>> >>              }
>> >>              Err(_) =3D> {
>> >> -                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad =
offset 0x%x\n", (int)offset);
>> >> +                qemu_log_mask!(LOG_GUEST_ERROR, "pl011_read: Bad of=
fset {offset}\n");
>> >>                  0
>> >>              }
>> >>              Ok(field) =3D> {
>> >> @@ -567,7 +568,10 @@ fn write(&self, offset: hwaddr, value: u64, _si=
ze: u32) {
>> >>                  =2Eborrow_mut()
>> >>                  =2Ewrite(field, value as u32, &self=2Echar_backend)=
;
>> >>          } else {
>> >> -            eprintln!("write bad offset {offset} value {value}");
>> >> +            qemu_log_mask!(
>> >> +                LOG_GUEST_ERROR,
>> >> +                "pl011_write: Bad offset {offset} value {value}\n"
>> >> +            );
>> >>          }
>> >
>> >General conceptual question =2E=2E=2E=2E=2E  I've never understood wha=
t the dividing
>> >line is between use of 'qemu_log_mask' and trace points=2E
>>=20
>> I *think* it's the perspective: If you want to see any issues, regardle=
ss
>> of which device, use the -l option, i=2Ee=2E qemu_log_mask()=2E If, how=
ever,
>> you want to see what a particular device does, use tracepoints=2E
>
>I guess I'd say that the latter ought to be capable of satisfying the
>former use case too, given a suitable trace point selection=2E If it
>can't, then perhaps that's telling us the way we select trace points
>is insufficiently expressive ?

Tracepoints often encode some context in the function name, e=2Eg=2E the d=
evice name and the operation being performed=2E One could give up this cont=
ext information in the function names and pass it as arguments to generic t=
race_unimp() and trace_guest_error() functions=2E The drawback is that this=
 doesn't provide any advantage over the current logging functionality such =
as device filtering=2E That could be achieved by  trace_$device_$operation_=
{unimp,guest_error} functions which is a convention that has to be enforced=
 manually=2E

Best regards,
Bernhard

>
>With regards,
>Daniel

