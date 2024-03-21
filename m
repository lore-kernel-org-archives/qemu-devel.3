Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81509C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 11:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnH19-0006Ac-TW; Thu, 21 Mar 2024 07:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnH18-0006A8-E2
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 07:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnH16-0003Ia-12
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 07:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711022126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LW01aXFr/CJJgo5tHg7Uq2+QKp1CFGY5lkJGMFXCHQM=;
 b=A0cCNq6HPBNT7dA9+Wy2oPj5fDUNh96uLzUInLFlSpv5BCIC9MurvNOgvg3CV5WvigNNw8
 SryYIqkTZZJqPVEvDCB5HYdFVIrg7F9voY/PK2KLLojfGXDuN3W59iU/TLIh1YrjiQ/+9Z
 LY2hpZGqktrg+jojyP3FV05AHNIeMaw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-uN0i22iuNOCNZPavXgdUvQ-1; Thu, 21 Mar 2024 07:55:24 -0400
X-MC-Unique: uN0i22iuNOCNZPavXgdUvQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ec06aac83so459295f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 04:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711022123; x=1711626923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LW01aXFr/CJJgo5tHg7Uq2+QKp1CFGY5lkJGMFXCHQM=;
 b=C0SxI13vZaxXXILtFuyu8uhVBdFVPyQ/O/VSPHy+WiQxDGFZNQQjTTcQI0qxyV57Oh
 lmSaj6VhwGFBvQ9i3/uY7Mc6//ud5vcQbKml52l0X4qKDp8beIqlshEF+sXupBLpUnez
 rh0wq0bAj2SEzNFET9LAtKs8rclM4CrhTGe9oacNeFw5rOSCnFwijdLLxnaRHfp3ytM7
 GYoeOQN+sh3Av3S6MJxLgocR9VdcmhqpyzGlxECdqAakhue+g/6lZbS/u6bxIN/GSupg
 I7hYP/Uo+k3DV4AesNdc3P92zLgX+gPItWMaVmo4uw2LXhD7J6RyEYVTTLvLS97JTReC
 1REA==
X-Gm-Message-State: AOJu0YzacuELi8wJha2dsITPCFDqTkRCI0tl53XJcYTa+c64CUzwKWVs
 8wuEYsSxSyxwdvkSEK7sJGpaO8ODWSyn/ExH+ZVCQtHqJ5qhUWX1SqNzDKXcapM7ee2hXWgsEp1
 HiA6UiUzrIcr88t1uy8D9RsPrI0ounZBRcSw3EaYtC9AyW9CkOxxoTn+MhL/c/Oi1Y2W/gcaHeb
 5dfmKrOxA/zBl2wy6GTcDUnSOg1cE=
X-Received: by 2002:adf:e247:0:b0:341:89da:540c with SMTP id
 bl7-20020adfe247000000b0034189da540cmr5471492wrb.26.1711022123548; 
 Thu, 21 Mar 2024 04:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/U9KPB4fTTSmu1Ab8Wu5qZ+X6Fmu2YZSpAjjsl8dCQdTk6+SS90fsmopIr9Go4YLsm99/kOHh1ggTeqnrPUU=
X-Received: by 2002:adf:e247:0:b0:341:89da:540c with SMTP id
 bl7-20020adfe247000000b0034189da540cmr5471473wrb.26.1711022123189; Thu, 21
 Mar 2024 04:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-38-michael.roth@amd.com>
 <366370f2-3d2d-4d14-81db-11fddadc2f24@redhat.com>
 <20240320223244.5i7xufnc6u5wyvox@amd.com>
In-Reply-To: <20240320223244.5i7xufnc6u5wyvox@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Mar 2024 12:55:10 +0100
Message-ID: <CABgObfYRSMWdnLJ+iebj84_7w9CkCMX=BuvLYBeLYzPgTqHmVw@mail.gmail.com>
Subject: Re: [PATCH v3 37/49] i386/sev: Add the SNP launch start context
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>, 
 Brijesh Singh <brijesh.singh@amd.com>
Content-Type: multipart/alternative; boundary="000000000000db258206142a61c6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
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

--000000000000db258206142a61c6
Content-Type: text/plain; charset="UTF-8"

Il mer 20 mar 2024, 23:33 Michael Roth <michael.roth@amd.com> ha scritto:

> On Wed, Mar 20, 2024 at 10:58:30AM +0100, Paolo Bonzini wrote:
> > On 3/20/24 09:39, Michael Roth wrote:
> > > From: Brijesh Singh <brijesh.singh@amd.com>
> > >
> > > The SNP_LAUNCH_START is called first to create a cryptographic launch
> > > context within the firmware.
> > >
> > > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > ---
> > >   target/i386/sev.c        | 42
> +++++++++++++++++++++++++++++++++++++++-
> > >   target/i386/trace-events |  1 +
> > >   2 files changed, 42 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > > index 3b4dbc63b1..9f63a41f08 100644
> > > --- a/target/i386/sev.c
> > > +++ b/target/i386/sev.c
> > > @@ -39,6 +39,7 @@
> > >   #include "confidential-guest.h"
> > >   #include "hw/i386/pc.h"
> > >   #include "exec/address-spaces.h"
> > > +#include "qemu/queue.h"
> > >   OBJECT_DECLARE_SIMPLE_TYPE(SevCommonState, SEV_COMMON)
> > >   OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
> > > @@ -106,6 +107,16 @@ struct SevSnpGuestState {
> > >   #define DEFAULT_SEV_DEVICE      "/dev/sev"
> > >   #define DEFAULT_SEV_SNP_POLICY  0x30000
> > > +typedef struct SevLaunchUpdateData {
> > > +    QTAILQ_ENTRY(SevLaunchUpdateData) next;
> > > +    hwaddr gpa;
> > > +    void *hva;
> > > +    uint64_t len;
> > > +    int type;
> > > +} SevLaunchUpdateData;
> > > +
> > > +static QTAILQ_HEAD(, SevLaunchUpdateData) launch_update;
> > > +
> > >   #define SEV_INFO_BLOCK_GUID
>  "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
> > >   typedef struct __attribute__((__packed__)) SevInfoBlock {
> > >       /* SEV-ES Reset Vector Address */
> > > @@ -668,6 +679,30 @@ sev_read_file_base64(const char *filename, guchar
> **data, gsize *len)
> > >       return 0;
> > >   }
> > > +static int
> > > +sev_snp_launch_start(SevSnpGuestState *sev_snp_guest)
> > > +{
> > > +    int fw_error, rc;
> > > +    SevCommonState *sev_common = SEV_COMMON(sev_snp_guest);
> > > +    struct kvm_sev_snp_launch_start *start =
> &sev_snp_guest->kvm_start_conf;
> > > +
> > > +    trace_kvm_sev_snp_launch_start(start->policy,
> sev_snp_guest->guest_visible_workarounds);
> > > +
> > > +    rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
> > > +                   start, &fw_error);
> > > +    if (rc < 0) {
> > > +        error_report("%s: SNP_LAUNCH_START ret=%d fw_error=%d '%s'",
> > > +                __func__, rc, fw_error, fw_error_to_str(fw_error));
> > > +        return 1;
> > > +    }
> > > +
> > > +    QTAILQ_INIT(&launch_update);
> > > +
> > > +    sev_set_guest_state(sev_common, SEV_STATE_LAUNCH_UPDATE);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >   static int
> > >   sev_launch_start(SevGuestState *sev_guest)
> > >   {
> > > @@ -1007,7 +1042,12 @@ static int
> sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> > >           goto err;
> > >       }
> > > -    ret = sev_launch_start(SEV_GUEST(sev_common));
> > > +    if (sev_snp_enabled()) {
> > > +        ret = sev_snp_launch_start(SEV_SNP_GUEST(sev_common));
> > > +    } else {
> > > +        ret = sev_launch_start(SEV_GUEST(sev_common));
> > > +    }
> >
> > Instead of an "if", this should be a method in sev-common.  Likewise for
> > launch_finish in the next patch.
>
> Makes sense.
>
> >
> > Also, patch 47 should introduce an "int (*launch_update_data)(hwaddr gpa,
> > uint8_t *ptr, uint64_t len)" method whose implementation is either the
> > existing sev_launch_update_data() for sev-guest, or a wrapper around
> > snp_launch_update_data() (to add KVM_SEV_SNP_PAGE_TYPE_NORMAL) for
> > sev-snp-guest.
>
> I suppose if we end up introducing an unused 'gpa' parameter in the case
> of sev_launch_update_data() that's still worth the change? Seems
> reasonable to me.
>

Yeah, you most likely have the gpa anyway in the kind of board code that
calls UPDATE_DATA. It would put some challenges with migration to use gpas
everywhere instead of ram_addrs, but that doesn't use UPDATE_DATA and
there's no SEV/SEV-ES migration anyway.

>
> >
> > In general, the only uses of sev_snp_enabled() should be in
> > sev_add_kernel_loader_hashes() and kvm_handle_vmgexit_ext_req().  I would
> > not be that strict for the QMP and HMP functions, but if you want to make
> > those methods of sev-common I wouldn't complain.
>
> There's a good bit of duplication in those cases which is a little
> awkward to break out into a common helper. Will consider these as well
> though.
>

I would say especially in HMP do not bother since you have to start from a
QAPI union and not QOM objects. For QMP I am not sure but don't waste too
much effort in it. All I wanted to say is that the monitor is a fine place
to draw the line.

Paolo


> Thanks,
>
> Mike
>
> >
> > Paolo
> >
> > >       if (ret) {
> > >           error_setg(errp, "%s: failed to create encryption context",
> __func__);
> > >           goto err;
> > > diff --git a/target/i386/trace-events b/target/i386/trace-events
> > > index 2cd8726eeb..cb26d8a925 100644
> > > --- a/target/i386/trace-events
> > > +++ b/target/i386/trace-events
> > > @@ -11,3 +11,4 @@ kvm_sev_launch_measurement(const char *value) "data
> %s"
> > >   kvm_sev_launch_finish(void) ""
> > >   kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret,
> int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
> > >   kvm_sev_attestation_report(const char *mnonce, const char *data)
> "mnonce %s data %s"
> > > +kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%"
> PRIx64 " gosvw %s"
> >
>
>

--000000000000db258206142a61c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 20 mar 2024, 23:33 Michael Roth &lt;<a href=3D"=
mailto:michael.roth@amd.com">michael.roth@amd.com</a>&gt; ha scritto:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Wed, Mar 20, 2024 at 10:58:30AM +0100=
, Paolo Bonzini wrote:<br>
&gt; On 3/20/24 09:39, Michael Roth wrote:<br>
&gt; &gt; From: Brijesh Singh &lt;<a href=3D"mailto:brijesh.singh@amd.com" =
target=3D"_blank" rel=3D"noreferrer">brijesh.singh@amd.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; The SNP_LAUNCH_START is called first to create a cryptographic la=
unch<br>
&gt; &gt; context within the firmware.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Brijesh Singh &lt;<a href=3D"mailto:brijesh.singh@=
amd.com" target=3D"_blank" rel=3D"noreferrer">brijesh.singh@amd.com</a>&gt;=
<br>
&gt; &gt; Signed-off-by: Michael Roth &lt;<a href=3D"mailto:michael.roth@am=
d.com" target=3D"_blank" rel=3D"noreferrer">michael.roth@amd.com</a>&gt;<br=
>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0target/i386/sev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 42 +++=
++++++++++++++++++++++++++++++++++++-<br>
&gt; &gt;=C2=A0 =C2=A0target/i386/trace-events |=C2=A0 1 +<br>
&gt; &gt;=C2=A0 =C2=A02 files changed, 42 insertions(+), 1 deletion(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/target/i386/sev.c b/target/i386/sev.c<br>
&gt; &gt; index 3b4dbc63b1..9f63a41f08 100644<br>
&gt; &gt; --- a/target/i386/sev.c<br>
&gt; &gt; +++ b/target/i386/sev.c<br>
&gt; &gt; @@ -39,6 +39,7 @@<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;confidential-guest.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/i386/pc.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;exec/address-spaces.h&quot;<br>
&gt; &gt; +#include &quot;qemu/queue.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(SevCommonState, SEV_COMMON=
)<br>
&gt; &gt;=C2=A0 =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)<=
br>
&gt; &gt; @@ -106,6 +107,16 @@ struct SevSnpGuestState {<br>
&gt; &gt;=C2=A0 =C2=A0#define DEFAULT_SEV_DEVICE=C2=A0 =C2=A0 =C2=A0 &quot;=
/dev/sev&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#define DEFAULT_SEV_SNP_POLICY=C2=A0 0x30000<br>
&gt; &gt; +typedef struct SevLaunchUpdateData {<br>
&gt; &gt; +=C2=A0 =C2=A0 QTAILQ_ENTRY(SevLaunchUpdateData) next;<br>
&gt; &gt; +=C2=A0 =C2=A0 hwaddr gpa;<br>
&gt; &gt; +=C2=A0 =C2=A0 void *hva;<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt; &gt; +=C2=A0 =C2=A0 int type;<br>
&gt; &gt; +} SevLaunchUpdateData;<br>
&gt; &gt; +<br>
&gt; &gt; +static QTAILQ_HEAD(, SevLaunchUpdateData) launch_update;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0#define SEV_INFO_BLOCK_GUID=C2=A0 =C2=A0 =C2=A0&quot;=
00f771de-1a7e-4fcb-890e-68c77e2fb44e&quot;<br>
&gt; &gt;=C2=A0 =C2=A0typedef struct __attribute__((__packed__)) SevInfoBlo=
ck {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* SEV-ES Reset Vector Address */<br>
&gt; &gt; @@ -668,6 +679,30 @@ sev_read_file_base64(const char *filename, g=
uchar **data, gsize *len)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; +static int<br>
&gt; &gt; +sev_snp_launch_start(SevSnpGuestState *sev_snp_guest)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 int fw_error, rc;<br>
&gt; &gt; +=C2=A0 =C2=A0 SevCommonState *sev_common =3D SEV_COMMON(sev_snp_=
guest);<br>
&gt; &gt; +=C2=A0 =C2=A0 struct kvm_sev_snp_launch_start *start =3D &amp;se=
v_snp_guest-&gt;kvm_start_conf;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 trace_kvm_sev_snp_launch_start(start-&gt;policy, s=
ev_snp_guest-&gt;guest_visible_workarounds);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 rc =3D sev_ioctl(sev_common-&gt;sev_fd, KVM_SEV_SN=
P_LAUNCH_START,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0start, &amp;fw_error);<br>
&gt; &gt; +=C2=A0 =C2=A0 if (rc &lt; 0) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: SNP_LAUNCH_ST=
ART ret=3D%d fw_error=3D%d &#39;%s&#39;&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__=
, rc, fw_error, fw_error_to_str(fw_error));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 QTAILQ_INIT(&amp;launch_update);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 sev_set_guest_state(sev_common, SEV_STATE_LAUNCH_U=
PDATE);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0static int<br>
&gt; &gt;=C2=A0 =C2=A0sev_launch_start(SevGuestState *sev_guest)<br>
&gt; &gt;=C2=A0 =C2=A0{<br>
&gt; &gt; @@ -1007,7 +1042,12 @@ static int sev_kvm_init(ConfidentialGuestS=
upport *cgs, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 ret =3D sev_launch_start(SEV_GUEST(sev_common));<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 if (sev_snp_enabled()) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sev_snp_launch_start(SEV_SNP=
_GUEST(sev_common));<br>
&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sev_launch_start(SEV_GUEST(s=
ev_common));<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; Instead of an &quot;if&quot;, this should be a method in sev-common.=
=C2=A0 Likewise for<br>
&gt; launch_finish in the next patch.<br>
<br>
Makes sense.<br>
<br>
&gt; <br>
&gt; Also, patch 47 should introduce an &quot;int (*launch_update_data)(hwa=
ddr gpa,<br>
&gt; uint8_t *ptr, uint64_t len)&quot; method whose implementation is eithe=
r the<br>
&gt; existing sev_launch_update_data() for sev-guest, or a wrapper around<b=
r>
&gt; snp_launch_update_data() (to add KVM_SEV_SNP_PAGE_TYPE_NORMAL) for<br>
&gt; sev-snp-guest.<br>
<br>
I suppose if we end up introducing an unused &#39;gpa&#39; parameter in the=
 case<br>
of sev_launch_update_data() that&#39;s still worth the change? Seems<br>
reasonable to me.<br></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Yeah, you most likely have the gpa anyway in the kind of b=
oard code that calls UPDATE_DATA. It would put some challenges with migrati=
on to use gpas everywhere instead of ram_addrs, but that doesn&#39;t use UP=
DATE_DATA and there&#39;s no SEV/SEV-ES migration anyway.</div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; In general, the only uses of sev_snp_enabled() should be in<br>
&gt; sev_add_kernel_loader_hashes() and kvm_handle_vmgexit_ext_req().=C2=A0=
 I would<br>
&gt; not be that strict for the QMP and HMP functions, but if you want to m=
ake<br>
&gt; those methods of sev-common I wouldn&#39;t complain.<br>
<br>
There&#39;s a good bit of duplication in those cases which is a little<br>
awkward to break out into a common helper. Will consider these as well<br>
though.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">I would say especially in HMP do not bother since you have to start =
from a QAPI union and not QOM objects. For QMP I am not sure but don&#39;t =
waste too much effort in it. All I wanted to say is that the monitor is a f=
ine place to draw the line.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
<br>
Mike<br>
<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;%s=
: failed to create encryption context&quot;, __func__);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt; diff --git a/target/i386/trace-events b/target/i386/trace-events<=
br>
&gt; &gt; index 2cd8726eeb..cb26d8a925 100644<br>
&gt; &gt; --- a/target/i386/trace-events<br>
&gt; &gt; +++ b/target/i386/trace-events<br>
&gt; &gt; @@ -11,3 +11,4 @@ kvm_sev_launch_measurement(const char *value) &=
quot;data %s&quot;<br>
&gt; &gt;=C2=A0 =C2=A0kvm_sev_launch_finish(void) &quot;&quot;<br>
&gt; &gt;=C2=A0 =C2=A0kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uin=
t64_t secret, int len) &quot;hpa 0x%&quot; PRIx64 &quot; hva 0x%&quot; PRIx=
64 &quot; data 0x%&quot; PRIx64 &quot; len %d&quot;<br>
&gt; &gt;=C2=A0 =C2=A0kvm_sev_attestation_report(const char *mnonce, const =
char *data) &quot;mnonce %s data %s&quot;<br>
&gt; &gt; +kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) &quot;pol=
icy 0x%&quot; PRIx64 &quot; gosvw %s&quot;<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--000000000000db258206142a61c6--


