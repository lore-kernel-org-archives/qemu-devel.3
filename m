Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51332C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVJJ-0007y8-HY; Fri, 08 Mar 2024 03:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1riVJA-0007vE-HA
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1riVJ4-0005Di-5I
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M04QNQnWmYIYT0iWaaRkAuJoHENv1qZkuCXE/Tpad94=;
 b=aITfJhtJ7l4vRntOHgkY9TYfrvhErpcjbLygpFo3u38HW/KF0cxKC/JzgNkgkzn9y4sgMk
 ypgbnMt+5Ctk2tqYo7ldcBLDypAn9lagM/tg7jK7empPYJJpRrD2VHFJUfRl6SxdTJQuh+
 YrlTF5sqy55Cn0uOoeUXhD4vHOuAmIg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-KGfh9Z_tPnyQ0tF2TYCxLw-1; Fri, 08 Mar 2024 03:10:11 -0500
X-MC-Unique: KGfh9Z_tPnyQ0tF2TYCxLw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29ba3ccfd2bso949157a91.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885410; x=1710490210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M04QNQnWmYIYT0iWaaRkAuJoHENv1qZkuCXE/Tpad94=;
 b=m2N1pZsAz0ounv64OzfizJm4k63M8V5H3MxWO57Ze9buBUhWOQ9SwC/lpUbTAtUM/f
 cZrSfUiHUHv3026VrZazc7mDqSRXczamB77Xkwn/CfqiTqxAndRq9CL7b2BFgX6gBLDe
 w3KxjoF/H0QnWRyyd3taUEPm4LoR96DW0OR52HJ/jztAQEIAtT9FbW5lNWquEBCcPSom
 12BeGjsQCN8tww3pEqdsPDc+G3Mey6k96o0Vl0zssvkocIoqUh7wm2Wur85rzFnV2pZW
 o0I5m+iZm25E1YvYCXIYhC/AoD/Pi8+WNlJbeAEDXeoUndIPKXgA52aQ4gaoa8E85sO4
 yYOA==
X-Gm-Message-State: AOJu0YzhqyG5z46g37IAoII3CNcGctEy5DZfh20/7r+sGSF3pVHcs79N
 o7xaIOF1xh6GzMj3J0B6eUDaaKBeWS605wMSzFwanRRbf4zBBYCjE4u56xH6wnvK2F0bvcsJqAu
 ljrjps0A3xdOXXaG2lUf4QIgsCGnysLp3IwFjsw2VdaJ2vpZlICEOEx4YUNH6CE35SLcaX0tt2k
 WCfEhpbEH+8CNL0QApLttHh4YwSaM=
X-Received: by 2002:a17:90a:c284:b0:299:8dac:e2eb with SMTP id
 f4-20020a17090ac28400b002998dace2ebmr16786062pjt.29.1709885410426; 
 Fri, 08 Mar 2024 00:10:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZT+zuQWOnkjafHBvxwTGg3DaefRmx/r0evoLN4rqN++KRejgeI26PIcgXhz7j32S+5HDWyq8znQGgiwkRKPg=
X-Received: by 2002:a17:90a:c284:b0:299:8dac:e2eb with SMTP id
 f4-20020a17090ac28400b002998dace2ebmr16786049pjt.29.1709885410165; Fri, 08
 Mar 2024 00:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20240124104006.335166-1-lvivier@redhat.com>
 <CACGkMEtzqCA_x1hg-ddp0d-Q-+XLH01k2Pf0KziiYSeLmDwaXA@mail.gmail.com>
 <622dabbe-a215-476a-b72c-41d1103b7cb6@redhat.com>
In-Reply-To: <622dabbe-a215-476a-b72c-41d1103b7cb6@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Mar 2024 16:09:58 +0800
Message-ID: <CACGkMEuCewG-RLNRrBP03-qrWO4w8Jg5L3ASAUbYcKXwBnwzUw@mail.gmail.com>
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
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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
>
> Thanks,
> Laurent
>

This fail CI at:

https://gitlab.com/jasowang/qemu/-/jobs/6348725267

It looks to me we can safely drop e1000e_autoneg_pause()?

Thanks


