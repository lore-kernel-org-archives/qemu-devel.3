Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2488C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 11:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg0lA-0006CP-9i; Fri, 01 Mar 2024 06:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rg0l7-0006CB-OH
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 06:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rg0l5-0006OC-PX
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 06:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709291333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zweSLfU93Ib/bb3/oZ+x1M2ndvj1R5k1C7KWPPoXEE=;
 b=cTGZAzxhkM+VZNxBq4k/svZoLUwewIviB33y24iAHTsY79W0S6LCy8xw8VM7Vm+JAr0IbV
 /ZZMV67CA+VAClYL5e7Kr58Sjh3OYYC/Pf7qtaNLUJ7uw/XNKdgpIEPm0d8NA6pUQaYtoU
 WmGWGM66fgvHEPYNlg6BzHbyV0LJ8fQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-p04_iCCkPEW8o2WapyoE5Q-1; Fri, 01 Mar 2024 06:08:51 -0500
X-MC-Unique: p04_iCCkPEW8o2WapyoE5Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d62d3ae0cso10776585e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 03:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709291330; x=1709896130;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9zweSLfU93Ib/bb3/oZ+x1M2ndvj1R5k1C7KWPPoXEE=;
 b=Qg4uxD6C+hK6Z/tk8ZSzUK5Hm0XGOPuy48E8l62yroNg2iLqVNsLvwus6MvD8bpKIf
 727XBRcuaoFQYB0BKnUjxucm4hppyCapa6EtRSP26rJd88p0EXyCgxJ6e/RLePGTJWF+
 gix/5GsJtVChlNI3FDgVwimRs/FOX3sJwBkfw5CnDTCQGokEIRWy+KymyJ0RxFBTn+HP
 c6QpdjI0XoNNAFKTVsDz+8ElRs3A23ElgKTcIjg80V5WvNtq0Uxc6DumeRKfFJGnKcJJ
 bEWcd659a2eYIKV4cA8mRrn0zMxSrVaKHyWg1O4M58U6haEiM9rQ2mrYC5z1oEoxRNhC
 eKQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ1sEUKWVTlCJXfXWqi2/FPbt4Nj4rWtybH+3/yUXaKdePzBwkCy/LuTKXId9nn2AgOchN0S9n//Cbk3JTtAzcOZ1BcDo=
X-Gm-Message-State: AOJu0YxnQmSAqTHec/ReQy39YzfTxoujfuKZs6tQykkCOe10pwhaxZxU
 1x21++0y+qe/KqqqMk5cp0Qe40IpUBu4uH68fx7Tr2L20OlZ2ZBwj19jIKoNCAobMMExhdMcfKf
 Ktc9RqWo1k4iKiuAHHEypoiAzj9shJwsEE+W3SOGxg0bEoKRN0Cod
X-Received: by 2002:adf:ec0e:0:b0:33d:82ae:67f8 with SMTP id
 x14-20020adfec0e000000b0033d82ae67f8mr1065547wrn.50.1709291330520; 
 Fri, 01 Mar 2024 03:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIQ30Mvjbb6ckSymyNAylBwmLnxmuTxSYmgXXtMUuluZqHERQFQmowzwmO3+tm8WhJAWOwPQ==
X-Received: by 2002:adf:ec0e:0:b0:33d:82ae:67f8 with SMTP id
 x14-20020adfec0e000000b0033d82ae67f8mr1065527wrn.50.1709291330184; 
 Fri, 01 Mar 2024 03:08:50 -0800 (PST)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 l18-20020adfb112000000b0033d4deb2356sm4261073wra.56.2024.03.01.03.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 03:08:49 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 12:08:49 +0100
Message-Id: <CZID7GHAWHXR.2UTDU0T1RHPX4@fedora>
Subject: Re: [PATCH v3 2/3] tools: build qemu-vmsr-helper
From: "Anthony Harivel" <aharivel@redhat.com>
To: "Paolo Bonzini" <pbonzini@redhat.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: <mtosatti@redhat.com>, <qemu-devel@nongnu.org>, <vchundur@redhat.com>
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-3-aharivel@redhat.com> <Zbf0Fbhmg0tvMbxK@redhat.com>
 <CABgObfaRGL8eOs6NRBjEMjTa_7UGyAn+Pic2GP=XbE+Qg-oBCQ@mail.gmail.com>
In-Reply-To: <CABgObfaRGL8eOs6NRBjEMjTa_7UGyAn+Pic2GP=XbE+Qg-oBCQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

Hi Paolo,

> > > +static void compute_default_paths(void)
> > > +{
> > > +    socket_path =3D g_build_filename("/run", "qemu-vmsr-helper.sock"=
, NULL);
> > > +    pidfile =3D g_build_filename("/run", "qemu-vmsr-helper.pid", NUL=
L);
> > > +}
> >
> > We shouldn't be hardcoding /run, we need to honour --prefix and
> > --localstatedir args given to configure.  /var/run is a symlink
> > to /run so the end result ends up the same AFAIK
>
> Indeed; just copy from scsi/qemu-pr-helper.c.
>

When I copy the same as compute-default() of scsi/qemu-pr-helper.c, the=20
helper is listening to "/var/local/run/qemu-vmsr-helper.sock".

Problem is /var/local/run is 700 while /run is 755.

So I would need to adjust the qemu-vmsr-helper.service to give=20
the --socket=3DPATH of qemu-vmsr-helper.socket (i.e=20
 /run/qemu-vmsr-helper.sock)

Problem is when I do that , I fall into the case:=20
"Unix socket can't be set when using socket activation"

So I'm a bit confused what to do about that.

> > You never answered my question from the previous posting of this
> >
> > This check is merely validating the the thread ID in the message
> > is a child of the process ID connected to the socket. Any process
> > on the entire host can satisfy this requirement.
> >
> > I don't see what is limiting this to only QEMU as claimed by the
> > commit message, unless you're expecting the UNIX socket permissions
> > to be such that only processes under the qemu:qemu user:group pair
> > can access to the socket ? That would be a libvirt based permissions
> > assumption though.
>
> Yes, this is why the systemd socket uses 600, like
> contrib/systemd/qemu-pr-helper.socket. The socket can be passed via
> SCM_RIGHTS by libvirt, or its permissions can be changed (e.g. 660 and
> root:kvm would make sense on a Debian system), or a separate helper
> can be started by libvirt.
>
> Either way, the policy is left to the user rather than embedding it in
> the provided systemd unit.
>

During this patch test, when I run by hand my VM (without libvirt),
the vmsr helper systemd service/socket was like that:=20
[Service]
ExecStart=3D/usr/bin/qemu-vmsr-helper
User=3Droot
Group=3Droot

and=20

[Socket]
ListenStream=3D/run/qemu-vmsr-helper.sock
SocketUser=3Dqemu
SocketGroup=3Dqemu
SocketMode=3D0660

And it seems to works. So I'm not sure 100% what to do in my patch.

Should I follow the pr-helper systemd files anyway ?

Regards,
Anthony


