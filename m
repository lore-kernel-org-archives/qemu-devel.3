Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AC7C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 13:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNBZc-0004Za-Ts; Fri, 28 Jun 2024 09:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNBZc-0004ZR-0c
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 09:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNBZa-0002Ty-5t
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 09:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719581008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=457AYdAo8Uoa1L2d03c2fdm9cYfD/wq1KT/t5rcWt4Q=;
 b=Evh4LJO3DbpNRcgulcIK9tBnGnwpd4G8KRCLGcq61K9gbR6FUp8Jf5WPyW2tgQo/inb2Xs
 wbxvmSKJynEPGJf+nfiU0J5anLnszPEPMLntHqsPBRnc1n/TIlNEJs7eaVU16mA/hl+ZZF
 rAI45mT2TpGFXHiPczpLaNuAvfA2TxY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-w-jpTEJyMC6OFrvJZdppBA-1; Fri, 28 Jun 2024 09:23:26 -0400
X-MC-Unique: w-jpTEJyMC6OFrvJZdppBA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-362a0c1041dso379112f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 06:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719581005; x=1720185805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=457AYdAo8Uoa1L2d03c2fdm9cYfD/wq1KT/t5rcWt4Q=;
 b=s7lula38LwM6SNwe+l+O9Xg7CNyl0WFSXFqkHtptGOjWMiijDMzIpJvecakYhN4Ua/
 RC2kjVeu8OqIDPFmYNHI8yXhYHjJts/u+06PxBBXqDrbONFzf27JKC5CSQUgsh/FL6Hg
 Hz6iG0UxG+UakqDTUaggFP5wAI866cJZ6cRDblKGYw3KJTaqhGPoG7wCh9b/AhocyW5V
 K26yJa92FIaQr4lMbDoce8W+CExXLDigsWmcRqqgNyphn9IVGQ/QZ+tAN7vRQGwK+djb
 4syUHaARCPqIAUilD95rMmqRGf140l4KLTr0wa4+r5AKkiJC0Q8AwSu3DVLvmjGrnImS
 HD4A==
X-Gm-Message-State: AOJu0Yx2yGhK78eBIXr/f5F2Ddv2brObfopDZQf+/wB92B/v1w1F5Hwa
 +qD9lqq7aoLIxLhgbuKCaWbpyHfmHe8jpegsEf3KMH27A0BsQHANfeDcK8bj3mGJC/IGHsRIPwd
 FM0XOsSuQWAACcE36wqzO4ngvPHPCLHHlbpstX8WaiwT3GREYuSp4I2ZtlSTCd1Mc8bM7D0+NIC
 +ljrlYWbYEg7aBB2kWc522gIDnWtA=
X-Received: by 2002:adf:f351:0:b0:35f:2091:4f92 with SMTP id
 ffacd0b85a97d-366e7a6451bmr13652819f8f.67.1719581004997; 
 Fri, 28 Jun 2024 06:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHQKSMpi8QCsJHKvASnIXBnRt7vS0c+GcyEO/lL6DhZPUJ7+37LumZXReFNz+KiloRFP0qXR+WjJGNwEvbUGs=
X-Received: by 2002:adf:f351:0:b0:35f:2091:4f92 with SMTP id
 ffacd0b85a97d-366e7a6451bmr13652804f8f.67.1719581004696; Fri, 28 Jun 2024
 06:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240627140628.1025317-1-pbonzini@redhat.com>
 <20240627140628.1025317-3-pbonzini@redhat.com>
 <a8f5d517-7037-4146-824e-3f985774c780@intel.com>
In-Reply-To: <a8f5d517-7037-4146-824e-3f985774c780@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 28 Jun 2024 15:23:11 +0200
Message-ID: <CABgObfa24iTNt7V_VjsKYRhLyD3pt6oGDHEUFxe1A_A-4HF7MA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/i386: drop AMD machine check bits from Intel
 CPUID
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, John Allen <john.allen@amd.com>
Content-Type: multipart/alternative; boundary="000000000000f2ac8b061bf32684"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000f2ac8b061bf32684
Content-Type: text/plain; charset="UTF-8"

Il ven 28 giu 2024, 10:32 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> On 6/27/2024 10:06 PM, Paolo Bonzini wrote:
> > The recent addition of the SUCCOR bit to kvm_arch_get_supported_cpuid()
> > causes the bit to be visible when "-cpu host" VMs are started on Intel
> > processors.
> >
> > While this should in principle be harmless, it's not tidy and we don't
> > even know for sure that it doesn't cause any guest OS to take unexpected
> > paths.  Since x86_cpu_get_supported_feature_word() can return different
> > different values depending on the guest, adjust it to hide the SUCCOR
>
> superfluous different
>
> > bit if the guest has non-AMD vendor.
>
> It seems to adjust it based on vendor in kvm_arch_get_supported_cpuid()
> is better than in x86_cpu_get_supported_feature_word(). Otherwise
> kvm_arch_get_supported_cpuid() still returns "risky" value for Intel VMs.
>

But the cpuid bit is only invalid for Intel *guest* vendor, not host. It is
not a problem to have it if you run on Intel host but have a guest model
with AMD vendor.

I will check if there are other callers of kvm_arch_get_supported_cpuid(),
or callers of x86_cpu_get_supported_feature_word() with NULL cpu, that
might care about the difference.

Paolo

>
> > Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Cc: John Allen <john.allen@amd.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/cpu.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index deb58670651..f3e9b543682 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6064,8 +6064,10 @@ uint64_t
> x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
> >       } else {
> >           return ~0;
> >       }
> > +
> > +    switch (w) {
> >   #ifndef TARGET_X86_64
> > -    if (w == FEAT_8000_0001_EDX) {
> > +    case FEAT_8000_0001_EDX:
> >           /*
> >            * 32-bit TCG can emulate 64-bit compatibility mode.  If there
> is no
> >            * way for userspace to get out of its 32-bit jail, we can
> leave
> > @@ -6077,6 +6079,18 @@ uint64_t
> x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
> >           r &= ~unavail;
> >           break;
> >   #endif
> > +
> > +    case FEAT_8000_0007_EBX:
> > +        if (cpu && !IS_AMD_CPU(&cpu->env)) {
> > +            /* Disable AMD machine check architecture for Intel CPU.  */
> > +            r = 0;
> > +        }
> > +        break;
> > +
> > +    default:
> > +        break;
> > +    }
> > +
> >       if (cpu && cpu->migratable) {
> >           r &= x86_cpu_get_migratable_flags(w);
> >       }
>
>

--000000000000f2ac8b061bf32684
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 28 giu 2024, 10:32 Xiaoyao Li &lt;<a href=3D"ma=
ilto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On 6/27/2024 10:06 PM, =
Paolo Bonzini wrote:<br>
&gt; The recent addition of the SUCCOR bit to kvm_arch_get_supported_cpuid(=
)<br>
&gt; causes the bit to be visible when &quot;-cpu host&quot; VMs are starte=
d on Intel<br>
&gt; processors.<br>
&gt; <br>
&gt; While this should in principle be harmless, it&#39;s not tidy and we d=
on&#39;t<br>
&gt; even know for sure that it doesn&#39;t cause any guest OS to take unex=
pected<br>
&gt; paths.=C2=A0 Since x86_cpu_get_supported_feature_word() can return dif=
ferent<br>
&gt; different values depending on the guest, adjust it to hide the SUCCOR<=
br>
<br>
superfluous different<br>
<br>
&gt; bit if the guest has non-AMD vendor.<br>
<br>
It seems to adjust it based on vendor in kvm_arch_get_supported_cpuid() <br=
>
is better than in x86_cpu_get_supported_feature_word(). Otherwise <br>
kvm_arch_get_supported_cpuid() still returns &quot;risky&quot; value for In=
tel VMs.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">But the cpuid bit is only invalid for Intel *guest* vendor, not h=
ost. It is not a problem to have it if you run on Intel host but have a gue=
st model with AMD vendor.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">I will check if there are other callers of kvm_arch_get_supported_cpuid()=
, or callers of x86_cpu_get_supported_feature_word() with NULL cpu, that mi=
ght care about the difference.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Suggested-by: Xiaoyao Li &lt;<a href=3D"mailto:xiaoyao.li@intel.com" t=
arget=3D"_blank" rel=3D"noreferrer">xiaoyao.li@intel.com</a>&gt;<br>
&gt; Cc: John Allen &lt;<a href=3D"mailto:john.allen@amd.com" target=3D"_bl=
ank" rel=3D"noreferrer">john.allen@amd.com</a>&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/cpu.c | 16 +++++++++++++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 15 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt; index deb58670651..f3e9b543682 100644<br>
&gt; --- a/target/i386/cpu.c<br>
&gt; +++ b/target/i386/cpu.c<br>
&gt; @@ -6064,8 +6064,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86=
CPU *cpu, FeatureWord w)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ~0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (w) {<br>
&gt;=C2=A0 =C2=A0#ifndef TARGET_X86_64<br>
&gt; -=C2=A0 =C2=A0 if (w =3D=3D FEAT_8000_0001_EDX) {<br>
&gt; +=C2=A0 =C2=A0 case FEAT_8000_0001_EDX:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 32-bit TCG can emulate 64-b=
it compatibility mode.=C2=A0 If there is no<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * way for userspace to get ou=
t of its 32-bit jail, we can leave<br>
&gt; @@ -6077,6 +6079,18 @@ uint64_t x86_cpu_get_supported_feature_word(X86=
CPU *cpu, FeatureWord w)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r &amp;=3D ~unavail;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case FEAT_8000_0007_EBX:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu &amp;&amp; !IS_AMD_CPU(&amp;cpu-&=
gt;env)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Disable AMD machine chec=
k architecture for Intel CPU.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu &amp;&amp; cpu-&gt;migratable) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r &amp;=3D x86_cpu_get_migrata=
ble_flags(w);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div></div></div>

--000000000000f2ac8b061bf32684--


