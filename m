Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAD7C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW7f-000852-LI; Mon, 10 Feb 2025 10:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1thW7d-00084g-06
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:54:57 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1thW7a-0005ap-Ij
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:54:56 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5de63846e56so3774895a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739202893; x=1739807693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j29WKxGUSTi+izgr39H82JynKI6CzNJl8GDB3M9pquI=;
 b=J2j8kSBdyGQJZAj+lzdfYmiQ2WniGsO8E6Bi/izNc0Zudn4PNCj9RsT2M6jANQUCrP
 Bbj64Jt2QffUnKIe2RBuQWH/MMDww56MGru9hww9swFf8CWPve4kLfPAf1IbplJhkEMD
 R+0YMt8ZkJcV3VfkixCHDS0Mx15bAQH1TWfY99/pQPeJnz3xgG4CLqQ/pdbGK8joZdLT
 Vi26W5z5mQPc4lvqmv/SUsOnLJNasUBbow0QAN4dKfRZs8wRwkKB41GY45sYDkAml7Xm
 8W1YOoJln0RKJ7yHf7FS3InI12bJKokk3bhXPd21Wg+ZPZoJOw+KpK8xEwyw/eODs0QK
 ZAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202893; x=1739807693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j29WKxGUSTi+izgr39H82JynKI6CzNJl8GDB3M9pquI=;
 b=KooxvbqIPM9A2NIIQwY4LbT4irmNDnloe6T93fY0O7M9ox6hJQXufvPIAsQIbgwLNi
 AP9uVXQKLLBOz7E1r7cXlsUbmn/6F40+s7Fu9PUrlI2bkQHQPzIrpdwxY7XDed9RKMcG
 mhL4viseVBR6HR6SSp8/5j9WyngW2+3zbswwlKfy4yj2neO+Bkvu91B8q8jz18AnGbId
 4orysNhh2nh4WMX37NjV1zDz9VPccAE/BFCdNxH1ipR4qgDnbQPli+GYCgeGsgMx+eZt
 nT0sbiL4CBou+IvXfg2Xv/ejMt/k/RcoLe9+TRQaqCSdXsFlqDC3C7vIoyUlReq6iKEK
 ZUaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvAhb0OFkoIDh2LNdP16DmIHulolMVCuac6Vv5fnYB6KBbd1BGJxkGmnpzFtDBiSv86ADWWRBbqwQ7@nongnu.org
X-Gm-Message-State: AOJu0YzYI+BgDkWhlRd7wVcE5kLlN61IYgXJul4y8c1mMoYhSwUFYO/Q
 Qqte6wRkFSn6nyo+N/aRZPPO0yQDndPlgIrrNXNYGgMfVot/sSD5F4uRyQBNpumuZeD4KPUVL5y
 9hLvXBzLA7mtI0k4gyfbw0IO2kLc=
X-Gm-Gg: ASbGnctypw8bKFryEpcLCXuQXSTzTRnGtNVDV75E0Wk8mpxCrr18L75t7AskRKjjIYc
 qDXbGn0uzKy/eeRGP2A023INIo+WAP1HsVAK1TmH6cR2DBSo4KVEPy/u08Y+teri3RjD7v/c=
X-Google-Smtp-Source: AGHT+IEuSkXcqA2SsvtXCxftBph1pQnl3lFf73NWgB+2kAslrpAQ0hig1CmXBDZOeDQkUHH6BXIOgMuQdD3YJqZ72XM=
X-Received: by 2002:a05:6402:5250:b0:5db:f5e9:6745 with SMTP id
 4fb4d7f45d1cf-5de9a0a42ddmr317503a12.0.1739202892703; Mon, 10 Feb 2025
 07:54:52 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <CAGxU2F7oh+a7nZp9MLh67ghKtkwFvHRNqNvFqjgVhBhbe4HK2w@mail.gmail.com>
 <CAGxU2F6mP7KfytKUQSoqvbmLyR2DRDVdmT1Gtyq=gOFv69CDXw@mail.gmail.com>
In-Reply-To: <CAGxU2F6mP7KfytKUQSoqvbmLyR2DRDVdmT1Gtyq=gOFv69CDXw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Feb 2025 10:54:38 -0500
X-Gm-Features: AWEUYZlZD7RKi-lUeQwekm16l-wZ9Y3-YVmhsg0BWwkM0Md0SibiuJv4MopSzcU
Message-ID: <CAJSP0QVY2hM3T41Z+X2aOGzRFPMmYgdzpbhOH65a=RYF=0WQEA@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>, 
 Rust-VMM Mailing List <rust-vmm@lists.opendev.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 kvm <kvm@vger.kernel.org>, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Bibo Mao <maobibo@loongson.cn>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Mon, Feb 10, 2025 at 9:55=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
> =3D=3D=3D vhost-user devices in Rust on macOS and *BSD =3D=3D=3D
>
> '''Summary:''' Extend rust-vmm crates to support vhost-user devices
> running on POSIX system like macOS and *BSD

Thanks, I have added it to the wiki:
https://wiki.qemu.org/Google_Summer_of_Code_2025#vhost-user_devices_in_Rust=
_on_macOS_and_*BSD

Stefan

