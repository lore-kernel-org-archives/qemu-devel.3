Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E928C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 05:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhjqk-0007TC-5D; Wed, 06 Mar 2024 00:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rhjqj-0007T4-3W
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 00:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rhjqh-0006Vh-Hb
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 00:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709702989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/R0GdTWXOkU/gU8Q4bgJFQWh+HWS3OWXk4lLAkqpsAA=;
 b=SfG5oIm7FRshBjfSSCC0o82aI0sH1omx223GMjJy7y7TW5YW39tLf1UYIustQeGtmDr2pm
 3Re6hJ8kvmwH9IwUnYJPe+eam3ypW5zfqjNocUEAIp9qzehw+KLrfas5mdJYL0z4gfUGr7
 ByETrcBjJD7LDxhwHWjmx+HbgEuYiW8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-yXSNIao4N9Ozkqc5Il7GUA-1; Wed, 06 Mar 2024 00:29:47 -0500
X-MC-Unique: yXSNIao4N9Ozkqc5Il7GUA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5c670f70a37so452176a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 21:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709702986; x=1710307786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/R0GdTWXOkU/gU8Q4bgJFQWh+HWS3OWXk4lLAkqpsAA=;
 b=Ua/OQSVtyLF/+Y+D1ouLVEhcZ4XBYPH9Us3y6D7u0Emebi9yvVj0v7r8hS1qflrxeN
 sm8YUO9Pdy+ptwZJ5OM61ZCv209ICUKxxGr2EFw6ozXvRGkxmoU2AS20xp6y/F+qPxfP
 6H8gWUHrKaq5+tEq9NF2eYG+H/ZE7RT/9VtpAnpnddp8FM55Nk457GKb2sXX1hGdqMGW
 JM+66zgIRzTLPU3a1VOZ/zeIPV4Lw/EBg+GmUQkwNldsq57qL3blAjNGHnvtNzdq0727
 Q5QnSkpHuKXp12AKdk41PDYfS2/SujC6mG5knbYDeCdW86D1AsKSM8NK0mX+7adZX/he
 CWgw==
X-Gm-Message-State: AOJu0Yw8HtxGVDjc+uyxB08fkMbhI8pKu+r1cS0Lc5L2KwKSh/JF6NYa
 VIR4C+14DEnbsnV3YPMqzSvv6IQTAWjrpGmivStpUdVgH6UtLpmBZ3TGWil/Emm9JBNEMhNxTDy
 GlC+rs02Mhxc16hZtwjCtizrrq8haROIl/z6B7SqymECuXoeQyqt7D4+7M1jQyEb5dcwo5xJ7Dq
 oErn19SMB9UStaZeaqgwVC+APrTEY=
X-Received: by 2002:a05:6a20:9151:b0:1a1:511b:edb2 with SMTP id
 x17-20020a056a20915100b001a1511bedb2mr4386737pzc.29.1709702986475; 
 Tue, 05 Mar 2024 21:29:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPshDxSKynKQVawAweCf1h9rcGRUEWBUwZ6S8c4Uuag+bryqZ9UuJqk2+nFqNnRYEGRadoZx2F1vayITWraIU=
X-Received: by 2002:a05:6a20:9151:b0:1a1:511b:edb2 with SMTP id
 x17-20020a056a20915100b001a1511bedb2mr4386726pzc.29.1709702986188; Tue, 05
 Mar 2024 21:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20240124104006.335166-1-lvivier@redhat.com>
 <CACGkMEtzqCA_x1hg-ddp0d-Q-+XLH01k2Pf0KziiYSeLmDwaXA@mail.gmail.com>
 <622dabbe-a215-476a-b72c-41d1103b7cb6@redhat.com>
In-Reply-To: <622dabbe-a215-476a-b72c-41d1103b7cb6@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Mar 2024 13:29:35 +0800
Message-ID: <CACGkMEuNHUgmujv+c=5+HOkqtOE8=Xf_GC3czug66ZhmEJp3vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] e1000e: fix link state on resume
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Laurent:

On Tue, Mar 5, 2024 at 6:07=E2=80=AFPM Laurent Vivier <lvivier@redhat.com> =
wrote:
>
> On 2/1/24 06:45, Jason Wang wrote:
> > On Wed, Jan 24, 2024 at 6:40=E2=80=AFPM Laurent Vivier <lvivier@redhat.=
com> wrote:
> >>
> >> On resume e1000e_vm_state_change() always calls e1000e_autoneg_resume(=
)
> >> that sets link_down to false, and thus activates the link even
> >> if we have disabled it.
> >>
> >> The problem can be reproduced starting qemu in paused state (-S) and
> >> then set the link to down. When we resume the machine the link appears
> >> to be up.
> >>
> >> Reproducer:
> >>
> >>     # qemu-system-x86_64 ... -device e1000e,netdev=3Dnetdev0,id=3Dnet0=
 -S
> >>
> >>     {"execute": "qmp_capabilities" }
> >>     {"execute": "set_link", "arguments": {"name": "net0", "up": false}=
}
> >>     {"execute": "cont" }
> >>
> >> To fix the problem, merge the content of e1000e_vm_state_change()
> >> into e1000e_core_post_load() as e1000 does.
> >>
> >> Buglink: https://issues.redhat.com/browse/RHEL-21867
> >> Fixes: 6f3fbe4ed06a ("net: Introduce e1000e device emulation")
> >> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >> ---
> >>
> >
> > I've queued this.
>
> Ping?

Plan to send a pull request with this by the end of this week.

Thanks

>
> Thanks,
> Laurent
>


