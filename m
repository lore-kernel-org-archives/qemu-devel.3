Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3884FE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 11:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt241-0004Re-UK; Thu, 19 Feb 2026 06:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vt240-0004RR-HS
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vt23y-0002Wx-E4
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771499956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VQ4ZrNL9Qa/cscOHEjIGN/9BDBmCD3BxFkmi6QtEHQ=;
 b=SIVb2748i/Ts34y7i1maum7uOGN/6cOyg+63qjIzsnntPwKe5/ouYy6E6YPDLtT6CfExqD
 SrcajwaonXUUHziXkoxSoCYZyQxqOoXMGIYQUKiRgKxjBhpm1G15wErMsHMdOWobrHM6xO
 1GrO+BezbzSaUgHI3wwzM75sqZMv8Sw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-fwC7tGckP3yzDryWcJajFg-1; Thu, 19 Feb 2026 06:19:15 -0500
X-MC-Unique: fwC7tGckP3yzDryWcJajFg-1
X-Mimecast-MFC-AGG-ID: fwC7tGckP3yzDryWcJajFg_1771499955
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-506a1999e44so74000511cf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 03:19:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771499955; cv=none;
 d=google.com; s=arc-20240605;
 b=ODm3h1uxXK+B+3el8p51U1snckQlE5eHd9CdLQLjoFA+t1/aMrJkqzLM+iMkvtObK0
 KK5mx9+gQ9oL9apwF1HhM4zZ8J9gbwhgODPiGzb6EtKwBo2wHtlowu3cWKGNZTSOiyn4
 9OyyGyyAphhbR0haOGXvHRAtwfvidHoYbRIp1dZdEqZYnGbm0QEAQUrQ712tQpHGwRz5
 9SZfziqsX7JeanBOgzLLoZXWViwCYFfaCLSGBOkBqUTfIENfxtcv20lSIUjFK1QXyQrw
 44GGc6SwDNYvRGPzw6lk9v1NP/dc5c0wvAHUgYU15wDuIfCSWAW17Vx4mTBRlvw/9lOQ
 ZF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/VQ4ZrNL9Qa/cscOHEjIGN/9BDBmCD3BxFkmi6QtEHQ=;
 fh=xKPEKhc79kIoOhKRWWOf4y/lXIshDJcjR9Ux+Wcslus=;
 b=crKm2PCXVeXhaZ8r7UgnCoTQm6hbgbxAkWbvGsZ6pHKhecO778NB6+WnR2PYIAsNRA
 W43U14ejkRi7j98A9zwmzhKzWB+P6vzFjzgfygtPV8MwFoY0RpXg0FlM3S+XiH+TDo9U
 mWkmeVMlJp1ynGqDY2wAmHl5rqFL9XO4QeHghC+Xo2N4gbyGE8akRVnH2ki65NUhWKuZ
 0ZqCiB3J8dm8RGzWC9EWsTYT89AQrYjIupy+BSR9BL6eR8WdQmeT2qbyIxUiuP6L/5Nj
 Vfj8HtfwffQL9SzVUyBNdBtAUuICxMJdirT2pY1VwiTtl5+N52UKc1VLNGADDildvPih
 HqMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771499955; x=1772104755; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VQ4ZrNL9Qa/cscOHEjIGN/9BDBmCD3BxFkmi6QtEHQ=;
 b=ERQJ81Sli4NvxPxJSXFdzEZTCJIG+b0BTgJ0UuX7aeQkc/m7AV7iF7wAJJ6bQBkzUW
 FwPpqeKdyMGvNjRDjYxlaIumZ7Zf0F4DrRtEXDDmlWS1Vamkg25dyhDJsMATAM1tfO9n
 Z4FEPD3fCT3SwlbYPa3w7/Lv225n5UwsJZhnpzlyfzehPVno8JDQOHam1mGslH/HPQjk
 H8D8w0AG7U5DXh+1tJovO9DbLlVpsCZhc7DkFmhSdDInMgvNDMmmrW9LkNNIN9UlN57O
 qR9BbPYZVxpPrDinpDS9Cn2dK6RIFLMZDvXftk8w/MZEbRqSeHMXh3+vvGC/9Ns/+i/1
 hoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771499955; x=1772104755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/VQ4ZrNL9Qa/cscOHEjIGN/9BDBmCD3BxFkmi6QtEHQ=;
 b=cEvmSWzXKvguzp0zqivr85OWeXGAZj80gbO+kKZu6johZwx5ZiXd5w6r8UA5NkHfia
 HXUfJ6W70JrmgClWhGiqqVRHX75YGkCnrMmCN4b8ckW3YTB6Q53w6GVvcAtqyEQHkcGQ
 Vq5ObXYD4/GYeVpKCDtogzBwOiIgPMm55meZ9ifnlpNA9hHFuVnLJGgnXI5s8LfUBnNH
 AEeGtR9Xzon1gVg017wMhVHWxZF3SLdhJDrqC0bE9QUl+Enr/6Mt+L89Z6SG/n3SeJyy
 lIDxGZFe8jcrKtY4eS7nhLoE7TO4O7cQElj2iRFD70ZFD4+6gQL68FmWhyUc21qhXNAz
 5lEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqEmi8XJ74qPPT84Y1hptms9u0Aq7FtNcDCxvW8vndjfvbapZqQaaAxj4ITrEEZJU0pzLaphfS0wTO@nongnu.org
X-Gm-Message-State: AOJu0Yxb1/uuYSqw2OJVhf0w2eSSgKsO77ioEdmK9FClQeZk875upgdK
 WegNbrqSwQdqXv/pQZOt7oa4uYNQqerFNdpM4gnCAgOay6uTSapigjhHVXIyWhaCpLys3TvD6mp
 pz8xpJtWS+b5YBJCWoZqYsClaWsS49sTOT+Wunlt5tTTN7I3D0s4Vu76S/x1YBbFILMi5bIelFG
 PJxdmqzGTzCJLDF7uu6OlTufN2EQ5WSy4=
X-Gm-Gg: AZuq6aItg7PH6olRBPsxCOgEkiWvDyKMjXaMCW4dwl2vb342kOcJwrKUnbqmQquiMRB
 WFU3VM4UHhKrjPvmCwCPfz6wjpb9xAkNJ+E37zym8KbOpGWmOeqXOWvh+tDsl7XP+YB5c2O7Vqj
 9cpgzAzFYx8mfV1SyjccAF5LKJzp4vewu6+NP6NHSKF7tpTa7LWQRyFz+9JI3pVQhgOYElSxOsi
 JEFxQr7sG8srVipV+5u4ITabYOsg0p5aoC/
X-Received: by 2002:a05:622a:11cb:b0:501:466b:5141 with SMTP id
 d75a77b69052e-506e91922f3mr64949941cf.18.1771499954801; 
 Thu, 19 Feb 2026 03:19:14 -0800 (PST)
X-Received: by 2002:a05:622a:11cb:b0:501:466b:5141 with SMTP id
 d75a77b69052e-506e91922f3mr64949711cf.18.1771499954340; Thu, 19 Feb 2026
 03:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-28-anisinha@redhat.com>
 <3b4b7b7b-7fcd-46ce-bdcb-cd1a30cf5276@xen.org>
 <793B549F-F866-4BF5-ABAF-A0537BA8713B@redhat.com>
 <bb43a79b-9ca9-49c4-ae88-f71991c97a58@xen.org>
In-Reply-To: <bb43a79b-9ca9-49c4-ae88-f71991c97a58@xen.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 19 Feb 2026 16:49:03 +0530
X-Gm-Features: AaiRm506Zoxs0GZihV_siDPWZ6Z4Xw_WEeLFqs6Vl0xxw-3lK7Pz4L_z7LOIjiM
Message-ID: <CAK3XEhNHb6D=Moq=wcsFPDX2Dr_TBe7D9Z1EM4J5w3k+hobpuw@mail.gmail.com>
Subject: Re: [PATCH v5 27/34] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
To: Paul Durrant <xadimgnik@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 4:15=E2=80=AFPM Paul Durrant <xadimgnik@gmail.com> =
wrote:
>
> On 19/02/2026 10:31, Ani Sinha wrote:
> >
> >
> >> On 19 Feb 2026, at 3:09=E2=80=AFPM, Paul Durrant <xadimgnik@gmail.com>=
 wrote:
> >>
> >> On 18/02/2026 11:42, Ani Sinha wrote:
> >>> On confidential guests KVM virtual machine file descriptor changes as=
 a
> >>> part of the guest reset process. Xen capabilities needs to be re-init=
ialized in
> >>> KVM against the new file descriptor.
> >>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>> ---
> >>>   target/i386/kvm/xen-emu.c | 50 ++++++++++++++++++++++++++++++++++++=
+--
> >>>   1 file changed, 48 insertions(+), 2 deletions(-)
> >>> diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
> >>> index 52de019834..69527145eb 100644
> >>> --- a/target/i386/kvm/xen-emu.c
> >>> +++ b/target/i386/kvm/xen-emu.c
> >>> @@ -44,9 +44,12 @@
> >>>     #include "xen-compat.h"
> >>>   +NotifierWithReturn xen_vmfd_change_notifier;
> >>> +static bool hyperv_enabled;
> >>>   static void xen_vcpu_singleshot_timer_event(void *opaque);
> >>>   static void xen_vcpu_periodic_timer_event(void *opaque);
> >>>   static int vcpuop_stop_singleshot_timer(CPUState *cs);
> >>> +static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_ms=
r);
> >>>     #ifdef TARGET_X86_64
> >>>   #define hypercall_compat32(longmode) (!(longmode))
> >>> @@ -54,6 +57,30 @@ static int vcpuop_stop_singleshot_timer(CPUState *=
cs);
> >>>   #define hypercall_compat32(longmode) (false)
> >>>   #endif
> >>>   +static int xen_handle_vmfd_change(NotifierWithReturn *n,
> >>> +                                  void *data, Error** errp)
> >>> +{
> >>> +    int ret;
> >>> +
> >>> +    /* we are not interested in pre vmfd change notification */
> >>> +    if (((VmfdChangeNotifier *)data)->pre) {
> >>> +        return 0;
> >>> +    }
> >>> +
> >>> +    ret =3D do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR);
> >>> +    if (ret < 0) {
> >>> +        return ret;
> >>> +    }
> >>> +
> >>> +    if (hyperv_enabled) {
> >>> +        ret =3D do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR_=
HYPERV);
> >>> +        if (ret < 0) {
> >>> +            return ret;
> >>> +        }
> >>> +    }
> >>> +    return 0;
> >>
> >> This seems odd. Why use the hyperv_enabled boolean, rather than simply=
 the msr value, since when hyperv_enabled is set you will be calling do_ini=
tialize_xen_caps() twice.
> >
> > I am not sure of enabling capabilities for Xen. I assumed we need to ca=
ll kvm_xen_init() twice, once normally with XEN_HYPERCALL_MSR and if hyper =
is enabled, again with XEN_HYPERCALL_MSR_HYPERV. Is that not the case? Is i=
t one or the other but not both? It seems kvm_arch_init() calls kvm_xen_ini=
t() once with XEN_HYPERCALL_MSR and another time vcpu_arch_init() calls it =
again if hyperv is enabled with XEN_HYPERCALL_MSR_HYPERV .
>
> Yes, it has to be assumed that XEN_HYPERCALL_MSR is correct until
> Hyper-V supported is enabled, which comes later, at which point the MSR
> is changed. So you only need save the latest MSR value and use that in
> xen_handle_vmfd_change().

ok hopefully this looks good
https://gitlab.com/anisinha/qemu/-/commit/7f7ba25151b6a658c54f95a370f1970c0=
1a6269a

sending this out to minimize churn and to make v6 as close to the
merge worthy as possible.


