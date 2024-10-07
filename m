Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2B5CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 12:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmTq-0001MD-Si; Mon, 07 Oct 2024 08:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxmTm-0001Lq-6e
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxmTj-0006pp-E8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728302681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDvTPML+zvPwwlzhsWYV2slbFDVNQ20yEDdY3kYFdP0=;
 b=VuxGWWxyBRYhM4xYBfpTcv/99kh925/wbkndexBBMJIRPKh6Rt3ojSKW1IYA1+xejUA54g
 R/RBUa+O64K/9QuHTS2Pjnkbd8P+5n7S/vcMEGb+DzOdmLj9oZRxEuiyzfz/6zAsg2IOh4
 AJWjPJcpCLhLU0UvG8SBRQJuGtiMJ9w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-ThhruC72OlSw6xKty5BfIQ-1; Mon, 07 Oct 2024 08:04:39 -0400
X-MC-Unique: ThhruC72OlSw6xKty5BfIQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37cd1fb9497so2629341f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 05:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728302677; x=1728907477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDvTPML+zvPwwlzhsWYV2slbFDVNQ20yEDdY3kYFdP0=;
 b=dRPO8+zBb+JWV9m3xXgb2UWRfG00nZgmfvMMpW08bolZgeVPUK89l4SRLPDDRhKsIu
 HyXRUDVKG6TTMvL5Be940KNmXges0ZBWP/BBe8P5yfbuPUrZBuR9b0jdFCDwCCO17yW1
 B4gvpAy1TOEDNfiVC540Ha3zSpwqMrL2yPGSG34k2L82SVQtHZaPBsIRx01SoCr70IPK
 jhcS+G7X6po955YcxHVGhue20QarZPRCy2TNogiuFyOtv2yv+mBtmBpjouCEric775jv
 cWQYfoNF4xnMFe28umbbVfUQN5bdbIjCnh8uI76s9LHLkvUWV328ETyP5+znx2m84udA
 Cz7w==
X-Gm-Message-State: AOJu0YxGiq1VhPvBlOabnBFez5mP4fPvD+ejEPf/6OyskVCqHwTkhmXb
 8fInoQihk8eU+tsvOb7AIDrk99IosJ/mL0l+C0bKlSwD6tVmuHP1ljNcGWooThSv0QWyHaFDcmk
 bw0G0HPx2S7aAUjB5gel+sQZVILOAo93X8EnH5sBoJkxVmeuwzc4w8GCQPgmJ
X-Received: by 2002:adf:f185:0:b0:374:c64e:3ff1 with SMTP id
 ffacd0b85a97d-37d049f8707mr9451158f8f.17.1728302677456; 
 Mon, 07 Oct 2024 05:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCeS+XO3+H+I4899VqcnwDvTAc57rN7bWi4i12VZUxB31J20H/VOnffR8QTTg+a/en+AmzUw==
X-Received: by 2002:adf:f185:0:b0:374:c64e:3ff1 with SMTP id
 ffacd0b85a97d-37d049f8707mr9451136f8f.17.1728302677009; 
 Mon, 07 Oct 2024 05:04:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691a4absm5587555f8f.29.2024.10.07.05.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 05:04:36 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:04:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
Message-ID: <20241007140434.3c1a064c@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAFEAcA9weMO1Djm16fQB4JBDUCggXnOfzZ4cXHjqeMseXQRyEw@mail.gmail.com>
References: <20240819144303.37852-1-peter.maydell@linaro.org>
 <20240910110344.10e4805e@imammedo.users.ipa.redhat.com>
 <CAFEAcA_Rjiy1so28OVPpL=+++XuU+gSXhn-v_WHMcpc_wa_xMw@mail.gmail.com>
 <CAFEAcA94EdUOOk71nv4oFRJXNBM=62FCD9dfwVSWMS-VM_OZtw@mail.gmail.com>
 <20240920124551.56f1e832@imammedo.users.ipa.redhat.com>
 <CAFEAcA9weMO1Djm16fQB4JBDUCggXnOfzZ4cXHjqeMseXQRyEw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 3 Oct 2024 15:54:45 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 20 Sept 2024 at 11:45, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Thu, 19 Sep 2024 13:34:54 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > On Tue, 10 Sept 2024 at 10:38, Peter Maydell <peter.maydell@linaro.org> wrote:  
> > > >
> > > > On Tue, 10 Sept 2024 at 10:03, Igor Mammedov <imammedo@redhat.com> wrote:  
> > > > >
> > > > > On Mon, 19 Aug 2024 15:43:03 +0100
> > > > > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > > > > > @@ -83,34 +83,32 @@ vCPU hotplug
> > > > > >
> > > > > >        (QEMU) query-cpus-fast
> > > > > >        {
> > > > > > -          "execute": "query-cpus-fast",
> > > > > >            "arguments": {}
> > > > > > +          "execute": "query-cpus-fast",
> > > > > >        }
> > > > > >        {
> > > > > >            "return": [
> > > > > >                {
> > > > > > -                  "qom-path": "/machine/unattached/device[0]",
> > > > > > -                  "target": "x86_64",
> > > > > > -                  "thread-id": 11534,
> > > > > >                    "cpu-index": 0,
> > > > > >                    "props": {
> > > > > > -                      "socket-id": 0,
> > > > > >                        "core-id": 0,
> > > > > > +                      "socket-id": 0,
> > > > > >                        "thread-id": 0
> > > > > >                    },
> > > > > > -                  "arch": "x86"
> > > > > > +                  "qom-path": "/machine/unattached/device[0]",
> > > > > > +                  "target": "x86_64",
> > > > > > +                  "thread-id": 28957
> > > > > >                },
> > > > > >                {
> > > > > > -                  "qom-path": "/machine/peripheral/cpu-2",
> > > > > > -                  "target": "x86_64",
> > > > > > -                  "thread-id": 12106,
> > > > > >                    "cpu-index": 1,
> > > > > >                    "props": {
> > > > > > -                      "socket-id": 1,
> > > > > > -                      "core-id": 0,
> > > > > > +                      "core-id": 1,
> > > > > > +                      "socket-id": 0,
> > > > > >                        "thread-id": 0
> > > > > >                    },
> > > > > > -                  "arch": "x86"
> > > > > > +                  "qom-path": "/machine/peripheral/cpu-2",
> > > > > > +                  "target": "x86_64",
> > > > > > +                  "thread-id": 29095
> > > > > >                }  
> > > > >
> > > > > beside reordering, which seems fine, this hunk also introduces target change
> > > > > perhaps a separate patch for that?  
> > > >
> > > > What target change? It all says "target": "x86_64" both before
> > > > and after.  
> >
> > my mistake,
> > I should've said  '"arch": "x86"' instead, which is gone after the patch  
> 
> This is because the "arch" output member was removed
> from the query-cpus-fast output in QEMU 6.0. If we
> mention this also in the commit message, is that OK?
> 
> ======
> docs/system/cpu-hotplug: Update example to match current QEMU
> 
> The example of how to do vCPU hotplug and hot-unlpug in the
> cpu-hotplug documentation no longer works, because the way
> we allocate socket-id and core-id to CPUs by default has
> changed at some point. The output also no longer matches what
> current QEMU produces in some more cosmetic ways.
> 
> Update the example to match current QEMU. The differences are:
>  * the second CPU is now socket-id=0 core-id=1,
>    not socket-id=1 core-id=0
>  * the order of fields from the qmp_shell is now in
>    alphabetical order
>  * the "arch" member is no longer present in the query-cpus-fast
>    output (it was removed in QEMU 6.0)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ======

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> If that seems OK to you I'll send out a v2 with the updated
> commit message and the fix to the device_add line.
> 
> thanks
> -- PMM
> 


