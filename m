Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3829C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 05:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMhSv-0000Lp-0i; Thu, 27 Jun 2024 01:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sMhSt-0000Lg-Ol
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 01:14:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sMhSr-0008SO-QG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 01:14:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-425624255f3so5007275e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 22:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719465272; x=1720070072; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buxv22AGs/1AbVjaY0jC8hEESu2CSpj9+GeRGFASzFU=;
 b=k2YSRd3cueF/ND7P7cy+LCPNXx1vhOfNycRhmvX4sum9XVB606ZAueARYi5Pxr+C7p
 cmDdjKmauKkABH1ZWVF+Mek2bZytl5h7awdSkgXqYqQ3T2qkeSRkUrYz9dufFAHdPXpS
 haIIA40FfWEX9ZcJ/EOKIsDjbT0mTmSjnT3tTCu4RI8wnnhNjqxeH1AyUX+jEJB2sfZP
 nDxEMPuXruaPlLHZj2RbuBCJznv6wX5aODiw065/KvzQ47BWP61idGbvT4/yBMFl2bSq
 RVD6o+fhi2eHp8xsW9u9ehtqUSZqlIYrtSINntlvaquqmBvovqZWnmixMoYkzZ/2iP7t
 q2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719465272; x=1720070072;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=buxv22AGs/1AbVjaY0jC8hEESu2CSpj9+GeRGFASzFU=;
 b=Owrq/ftdpHxpwn6jdqy11BzuX5B7ttznumuAVerogILT2grugQSH+7RqTK8aLth1iQ
 JfY1MHPqygqjv/CSPlK4aJteLHWlG1eYkGk/VEqP6ABrLiLsjfiEfLOyQWtmBEASF9Go
 nbIO3S7gM0ONpMTLqK0DLFwMy2ITGHg5Eexr4eTCjdsHbuYizV23fmzKHqokxJAs9PcA
 6oGyfTnj9ykXHpklto+PMcluWgl/nJjeFNPgENWA32m+NKn63si+zOh3yzV3r6JTw1LN
 KuF5cvsHvdNczfvuR6Bp0BKVssfqNKe+U6Lpt+K1bsxH19pNwQLlJ+lDSN2adqvHCXkZ
 a9JQ==
X-Gm-Message-State: AOJu0Yzp6Tp5Gg4l7ooBvxrhUPXzJF0N/I8tM9AQThXDtJZIXhJAgk1R
 wQjeHpB0qm/DJYKnNUNJRIWS8/9YubCmC1Ta+hI2lSfOTLPuixZe
X-Google-Smtp-Source: AGHT+IGlj8lOq53yzk/cDN18r/XyLGFqmLhppF9q4oR3Vb8rJrHunpTiLC6svcY62A6Kea5XCJ6R0w==
X-Received: by 2002:a05:600c:1c1c:b0:425:35a5:fad4 with SMTP id
 5b1f17b1804b1-425643719b2mr6479215e9.15.1719465271798; 
 Wed, 26 Jun 2024 22:14:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:136:9c60:df8c:dbac:5023:d101?
 ([2a01:e0a:136:9c60:df8c:dbac:5023:d101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bb6d28sm8839305e9.31.2024.06.26.22.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 22:14:31 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------C9HadnABbuI451cPngyhGe6Y"
Message-ID: <91a0dc7f-75d6-4376-8af3-3c34d012e364@gmail.com>
Date: Thu, 27 Jun 2024 07:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/intel_iommu: Block CFI when necessary
To: Yuke Peng <pykfirst@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240625112819.862282-1-pykfirst@gmail.com>
 <0baa7fcd-0b86-4ce0-88c9-4954363c2616@gmail.com>
 <CAHJVP30fNZvuc7MVwAvNZM6fY+zUCOJcsUsXo2i4pG844RgvDA@mail.gmail.com>
Content-Language: en-US
From: cmd <clement.mathieudrif.etu@gmail.com>
In-Reply-To: <CAHJVP30fNZvuc7MVwAvNZM6fY+zUCOJcsUsXo2i4pG844RgvDA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=clement.mathieudrif.etu@gmail.com; helo=mail-wm1-x329.google.com
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

This is a multi-part message in MIME format.
--------------C9HadnABbuI451cPngyhGe6Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 27/06/2024 07:08, Yuke Peng wrote:
> On Wed, Jun 26, 2024 at 2:15 PM cmd 
> <clement.mathieudrif.etu@gmail.com> wrote:
>
>     Hi,
>
>     On 25/06/2024 13:28, Yuke Peng wrote:
>     > According to Intel VT-d specification 5.1.4, CFI must be blocked
>     when
>     > Extended Interrupt Mode is enabled or Compatibility format
>     interrupts
>     > are disabled.
>     >
>     > Signed-off-by: Yuke Peng <pykfirst@gmail.com>
>     > ---
>     >   hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++++
>     >   hw/i386/trace-events          |  1 +
>     >   include/hw/i386/intel_iommu.h |  1 +
>     >   3 files changed, 30 insertions(+)
>     >
>     > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>     > index 5085a6fee3..dfa2f979e7 100644
>     > --- a/hw/i386/intel_iommu.c
>     > +++ b/hw/i386/intel_iommu.c
>     > @@ -2410,6 +2410,22 @@ static void
>     vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
>     >       }
>     >   }
>     >
>     > +/* Handle Compatibility Format Interrupts Enable/Disable */
>     > +static void vtd_handle_gcmd_cfi(IntelIOMMUState *s, bool en)
>     > +{
>     > +    trace_vtd_cfi_enable(en);
>     > +
>     > +    if (en) {
>     > +        s->cfi_enabled = true;
>     > +        /* Ok - report back to driver */
>     > +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0,
>     VTD_GSTS_CFIS);
>     > +    } else {
>     > +        s->cfi_enabled = false;
>     > +        /* Ok - report back to driver */
>     > +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG,
>     VTD_GSTS_CFIS, 0);
>     > +    }
>     You have the same comment in both branches of the if statement,
>     couldn't
>     we put it between 'trace' and 'if'?
>
>
> The reason I put the comment within the branches is that the function
> 'vtd_handle_gcmd_cfi'  is similar to the function 'vtd_handle_gcmd_ire'
> and  'vtd_handle_gcmd_te'. So for consistency, I also put comments
> within the branches instead of in front of 'if'. Besides, I think the 
> comments
> only explain the statement 'vtd_set_clear_mask_long'.
>
> The 'vtd_handle_gcmd_ire' function:
ok fine
>
> > /* Handle Interrupt Remap Enable/Disable */
> > static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
> > {
> >     trace_vtd_ir_enable(en);
> >
> >     if (en) {
> >         s->intr_enabled = true;
> >         /* Ok - report back to driver */
> >         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRES);
> >     } else {
> >         s->intr_enabled = false;
> >         /* Ok - report back to driver */
> >         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_IRES, 0);
> >     }
> > }
--------------C9HadnABbuI451cPngyhGe6Y
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27/06/2024 07:08, Yuke Peng wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAHJVP30fNZvuc7MVwAvNZM6fY+zUCOJcsUsXo2i4pG844RgvDA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">On Wed, Jun 26, 2024 at 2:15 PM cmd &lt;<a
            href="mailto:clement.mathieudrif.etu@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">clement.mathieudrif.etu@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <div class="gmail_quote">
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
            <br>
            On 25/06/2024 13:28, Yuke Peng wrote:<br>
            &gt; According to Intel VT-d specification 5.1.4, CFI must
            be blocked when<br>
            &gt; Extended Interrupt Mode is enabled or Compatibility
            format interrupts<br>
            &gt; are disabled.<br>
            &gt;<br>
            &gt; Signed-off-by: Yuke Peng &lt;<a
              href="mailto:pykfirst@gmail.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">pykfirst@gmail.com</a>&gt;<br>
            &gt; ---<br>
            &gt;   hw/i386/intel_iommu.c         | 28
            ++++++++++++++++++++++++++++<br>
            &gt;   hw/i386/trace-events          |  1 +<br>
            &gt;   include/hw/i386/intel_iommu.h |  1 +<br>
            &gt;   3 files changed, 30 insertions(+)<br>
            &gt;<br>
            &gt; diff --git a/hw/i386/intel_iommu.c
            b/hw/i386/intel_iommu.c<br>
            &gt; index 5085a6fee3..dfa2f979e7 100644<br>
            &gt; --- a/hw/i386/intel_iommu.c<br>
            &gt; +++ b/hw/i386/intel_iommu.c<br>
            &gt; @@ -2410,6 +2410,22 @@ static void
            vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)<br>
            &gt;       }<br>
            &gt;   }<br>
            &gt;   <br>
            &gt; +/* Handle Compatibility Format Interrupts
            Enable/Disable */<br>
            &gt; +static void vtd_handle_gcmd_cfi(IntelIOMMUState *s,
            bool en)<br>
            &gt; +{<br>
            &gt; +    trace_vtd_cfi_enable(en);<br>
            &gt; +<br>
            &gt; +    if (en) {<br>
            &gt; +        s-&gt;cfi_enabled = true;<br>
            &gt; +        /* Ok - report back to driver */<br>
            &gt; +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0,
            VTD_GSTS_CFIS);<br>
            &gt; +    } else {<br>
            &gt; +        s-&gt;cfi_enabled = false;<br>
            &gt; +        /* Ok - report back to driver */<br>
            &gt; +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG,
            VTD_GSTS_CFIS, 0);<br>
            &gt; +    }<br>
            You have the same comment in both branches of the if
            statement, couldn't <br>
            we put it between 'trace' and 'if'?<br>
          </blockquote>
          <div><br>
          </div>
          <div>The reason I put the comment within the branches is that
            the function </div>
          <div>'vtd_handle_gcmd_cfi'  is similar to the function
            'vtd_handle_gcmd_ire' </div>
          <div>and  'vtd_handle_gcmd_te'. So for consistency, I also put
            comments </div>
          <div>within the branches instead of in front of 'if'. Besides,
            I think the comments</div>
          <div>only explain the statement 'vtd_set_clear_mask_long'.</div>
          <div><br>
          </div>
          <div>The 'vtd_handle_gcmd_ire' function:<br>
          </div>
        </div>
      </div>
    </blockquote>
    <font face="monospace">ok fine</font><br>
    <blockquote type="cite"
cite="mid:CAHJVP30fNZvuc7MVwAvNZM6fY+zUCOJcsUsXo2i4pG844RgvDA@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>&gt; /* Handle Interrupt Remap Enable/Disable */<br>
            &gt; static void vtd_handle_gcmd_ire(IntelIOMMUState *s,
            bool en)<br>
            &gt; {<br>
            &gt;     trace_vtd_ir_enable(en);<br>
            &gt; <br>
            &gt;     if (en) {<br>
            &gt;         s-&gt;intr_enabled = true;<br>
            &gt;         /* Ok - report back to driver */<br>
            &gt;         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0,
            VTD_GSTS_IRES);<br>
            &gt;     } else {<br>
            &gt;         s-&gt;intr_enabled = false;<br>
            &gt;         /* Ok - report back to driver */<br>
            &gt;         vtd_set_clear_mask_long(s, DMAR_GSTS_REG,
            VTD_GSTS_IRES, 0);<br>
            &gt;     }<br>
            &gt; }<br>
          </div>
          <div> </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------C9HadnABbuI451cPngyhGe6Y--

