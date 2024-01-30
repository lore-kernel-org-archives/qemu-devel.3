Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E9CC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtsI-0007HR-Qb; Tue, 30 Jan 2024 14:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUtsH-0007HD-7V
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:34:25 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUtsF-0006im-Kt
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:34:24 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59a6f2eecf6so497114eaf.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706643262; x=1707248062; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0CvRLqTCzJ0AgIzxfXdNIE9ypfHTup9n0zpeW9FKuEU=;
 b=RTz8o1du+M3d7+FJT4HkouLeA1fsWp5sfss4iVWiHadtcSdgRxcawMqN2Mtnmr8sb0
 oAxEFpSt+X55AbB3CVTr4xZcFErsjI2lUatvg3XMsIpHUAOYEbmBxledpP+On5B+8KEC
 NeOEwmaFZXgY2RuJyVQ0VyMtv4LPWjp7Y0nRuymg3kVrrDlvTnzMRCpOkpDnluVGPkP1
 PGkDHndMWtFXbo7ZwlCgAdRY9lquliJG+Y3G2/7/rErf3850fGz73J9iiXHEilaYlqAT
 +eIq+3+pweoG6eOA7rHawovxMNxA39193FTIJIf5RI9W4yjF8xD4mTAd6Qf98OMO/cN5
 fQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706643262; x=1707248062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0CvRLqTCzJ0AgIzxfXdNIE9ypfHTup9n0zpeW9FKuEU=;
 b=reWgU2zG9jNV+AfxsEkGbq2f23y21vQVzmJD+2f/xQj6FZ/WzZFY9fZ6hHNx50t1/Z
 mHv9L3LmJ3GXzzq0N8bgSm7niOPtgWjGwNY3BooI4Px2/rqx1Mx52cXJUVoyLaJ27jMh
 vx7KHlYBBjRzJCVEZK6cCKECrgPoQlOzvbIFVq0vKHtiTa2EwMeeApOzh2S3Op168Jbv
 RGK1RmUmgQ0Axg8I9PwU7Y/cJh89n6wtnwb5lOWqNK2t6fvboFsyKT45A+kR84k5enwM
 1zr2uhfDMQGTlVmKnTyn60sSjS04SvJU8tE+MT8WHVW9Iky58yFI6rNpX62XIR5JFaA4
 86Ug==
X-Gm-Message-State: AOJu0YweXNrZFZ973AnrS/wVnkBc4+UOBpWRo4YJr5ORAK/I7ymKPCGW
 jM9Ne845MJkT0+s2JOZgchhHtEiUX03oNM8sRl4X08vXwp4fAUGl31GD9MS69I07AxUzLeE3Nby
 X8rsr3khmgYTBKezmYsNnFIKU70A=
X-Google-Smtp-Source: AGHT+IGImRyWXFYHGAlbvIzjSc8dtJi2NLXU7QQiMlyVarpvAImwdO/VtDgKy1UKIpBq2uBaW8PoGsIlCX9ByAURnMQ=
X-Received: by 2002:a4a:e60f:0:b0:59a:f1e:9b3d with SMTP id
 f15-20020a4ae60f000000b0059a0f1e9b3dmr6879315oot.2.1706643262457; Tue, 30 Jan
 2024 11:34:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <CAJaqyWdMNP3V=JL6C8SSbXV5AP_2O9SNJLUS+Go7AjVsrT1FdQ@mail.gmail.com>
 <CAJSP0QXMJiRQFJh6383tnCOXyLwAbBYM7ff-mtregO3MKAEC1A@mail.gmail.com>
 <CAJaqyWeKrjjMyRXo1LK4_2Q=HYKqd=omjDJ+by_=do9ppdCk3w@mail.gmail.com>
In-Reply-To: <CAJaqyWeKrjjMyRXo1LK4_2Q=HYKqd=omjDJ+by_=do9ppdCk3w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jan 2024 14:34:09 -0500
Message-ID: <CAJSP0QU09UCkV6Q6HfsB8ozaE0mMC1tCH02e5CEBMPC_=eyUOw@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Alberto Faria <afaria@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Bernhard Beschow <shentey@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Sean Christopherson <seanjc@google.com>,
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Eugenio,
Stefano Garzarella and I had a SVQ-related project idea that I have added:
https://wiki.qemu.org/Google_Summer_of_Code_2024#vhost-user_memory_isolation

We want to support vhost-user devices without exposing guest RAM. This
is attractive for security reasons in vhost-user-vsock where a process
that connects multiple guests should not give access to other guests'
RAM in the case of a security bug. It is also useful on host platforms
where guest RAM cannot be shared (we think this is the case on macOS
Hypervisor.framework).

Please let us know if you have any thoughts about sharing/refactoring
the SVQ code.

Stefan

