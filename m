Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD387CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlHY-0005Ka-1M; Mon, 05 Oct 2026 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDlHX-0005KS-7n
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:11:15 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDlHV-00076l-DT
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:11:14 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6acbdbc1725so2682967a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791216671; cv=none;
 d=google.com; s=arc-20260327;
 b=a6y2rdXeF451tJCsJ79MsP2e6+7aa6lsRlz/F2fitvcWsDZ/2vHU6KdTpomP74gqT2
 M0ShriCMCOfGWW6NOjKXNaNR94ZFaiG8v5cQA4rBds1Awy51dNciQNpjWTl513SMVoM7
 xpL+ZDH0vPJ7YNRJ2+Aa5F+4NytzqPlKKJ8NiJdwurJPWtvKkGZnGkV9NLw0Pzdbjn30
 byNCOQzoohj8711GhKxdnwX4qjO+DsxScdInHRHF3h2GmlKc1lR5O3RLgX62D5Wg9yfV
 j8zdWlFUtZSqINbNc+rstuq/8axWRhdyj0GoxVdu1q0L/XzKudMd/uex2tzsUEk4NFt8
 lQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=TJH4KvIh7Qsn9EylEvnnzTGgLZ/gxhWOmlKL6PrS4vI=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=sCubcYJ5rokkQPe0Y9qkyxYICJOo1oXVyeg2vYXoVKaKnotG6xFls1/2TL+rn8/Tpo
 lCzh/Oc0R2jNtm5UWn4eZO6cpjN1p9WWMmyNZ6h11rMDFUYpkXZpdZ0Bl4KJWHGEotzb
 DuJCo6FhNmddwbHEFnCoB6ZS/7NNZr032U4aaSou1kvKqJY0VrQ5vIqMS7ajqvZfCgUB
 aW3dA/ddcVQG0q7JxPEVLI3FtL6KNr24zalSxvPzwd4xy/di57BHw0kPCpPRUeoOwa1U
 dUTvB2oz0FXe5zn8KiXXlCQ27cuKuIxeET08ibA0z4BPowZ31QAri8Y+j+XF9fTn20wv
 Vi4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791216671; x=1791821471; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TJH4KvIh7Qsn9EylEvnnzTGgLZ/gxhWOmlKL6PrS4vI=;
 b=IJKf8k4jkQpK20dFUNLchM/9uVl24KIAhWLPvkBe4MWxjUPRxRpowYHaq8rrRFQM7Y
 bdGUq965hEWUCFo3/uPkt5md4mZ/tiqe7F8B5TymJUzOBrzCRVj95Chh8XiazsgFSKQf
 m7aWQ10QdoSHAAzCX5rbSoDCqNZc6CwCwOpyoeVVwOLPlW+85UM3WYMkx+Z2Sx69FIs7
 gqBVM2ue1WedM2cB1yXQUtu4B1jnipePubomMi5kF+CoDvbRp00EMZR2SSzvwo9b3Cw0
 4hgSpnjASD14WrQqrK91m7awb2UAJeyDl0kTu74PxxVQtd6UpldpgzB2hxQi5Axa/7az
 ewKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791216671; x=1791821471;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJH4KvIh7Qsn9EylEvnnzTGgLZ/gxhWOmlKL6PrS4vI=;
 b=BjNKlvkt+R+ns8Op+Ln09a/jrnBLz9DTHKNaePTQGw9+i80dJX8wUnQiaUmhozU5Gz
 aVg1ccae3EQpIWmjDQ9Cd8ujsQeSsXEyT5jQWWVNZ9coMbtNcJYdxZguUB9riZCGWDK3
 fv75cpdmMlApkRAdK9GSQUREAhy5SCCmVh6J0GS9EveafplEMdIf6Dadq4L5tkkqHd29
 m3Rr5VUQrHWnTO5e1qS0m4c3Smb5WnW5n16W9zCxrgLC3lIzYNZMo+5b8xacpbUxZNq8
 BJ0xBfDcwLccJ3CFwrTa7BXMi5au4NpIp7U67QgYPNN1zUlrz4UmjrCHjMFOHY2AqPiX
 K9JQ==
X-Gm-Message-State: AFq9FYLv903fcjiHimOjBCdM24tyjxw7S8VtUx/kUDkJ/2JqV+YPqI8O
 zooNjyYrhDzPYRqOKly+nf3JIXa/RfevkPgIDL81haQ5H/rjr4pqFTGwWlqKL8u2F8XRPjk8K2c
 SR7aBuCevKt5aTqwNpjIaW/bt3Rmy8QE=
X-Gm-Gg: AYBFou0gkw8INcUosaSDWHJxdSV2aq7/PFTmAKN0eE/wOL8n5kFRTdefEzCSXSmHng5
 MVVcv4qeIjVWbfbgjXX/9BalOWmCG96KMkHpLUwZq6Z098c+/rpXxPdmmLWKYtuQ8baatprGWVY
 uunXoOGQohMnwsxKxcpOED/f2J1ZCZchhdTLi5fxawi4LsArwsThYHYJhlZV+1wLVRmoDZLmZ1Y
 h4JeVzdyFrzDpYXsUu09ItpdLOli5pbRVQT8++GPK+fZlsx3FSV7ddB3/6ptYk4yc5Z5wwbZvrE
 QmKHSRFyWOcCDfDq80vZuwGqIlo4gvcG+bhioeDvU/BWfMF2SFf7EaI=
X-Received: by 2002:a05:6402:438e:b0:6a5:f202:c1c7 with SMTP id
 4fb4d7f45d1cf-6afad8bd54dmr6037700a12.8.1791216670527; Mon, 05 Oct 2026
 09:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
In-Reply-To: <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 00:10:58 +0800
X-Gm-Features: AclHuK_UraKZBtVxb0WftPOEegjy3hubNZE4g9yva-OIUxamZAoNKA2kYCKNjC8
Message-ID: <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x536.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 6, 2026 at 12:03=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/4/2026 12:29 AM, Yonggang Luo wrote:
> > `TARGET_ARCH` identifies a base architecture, not necessarily the full
> > system-emulation target. For example, `mipsel-softmmu` uses `TARGET_ARC=
H=3Dmips`,
> > which caused `query-target` to report `mips` instead of `mipsel`.
> >
> > Generate `TARGET_SYS_EMU` separately. Softmmu builds use the full targe=
t name,
> > as `SysEmuTarget` enumerates system targets. User-mode builds use
> > `TARGET_ARCH`: user target names such as `aarch64_be` and `mipsn32el` d=
o not
> > have corresponding `SysEmuTarget` values. This means `mipsel-linux-user=
` now
> > reports the base architecture `mips` rather than `mipsel`; its executab=
le name
> > remains unchanged. Initialize `TargetInfo.target_arch` from this token =
and add
> > a qtest to check the `query-target` result against the target name of t=
he
> > running QEMU binary.
> >
> > Yonggang Luo (4):
> >   Revert "target-info: Statically initialize target_arch"
> >   Revert "meson: Add TARGET_ARCH to config_target_data"
> >   tests/qtest: check query-target architecture
> >   target-info: preserve full softmmu target identity
> >
> >  meson.build            | 11 +++++++++--
> >  target-info-stub.c     |  2 +-
> >  tests/qtest/qmp-test.c | 13 +++++++++++++
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> >
>
> Why should we do this for user binaries? Current work around
> single-binary only concerns system binaries, where all targets are
> correctly covered by what exists.

From my personal point of view, keeping target_arch as
SYS_EMU_TARGET__MAX for user binaries
is a better option. I am doing this is for replica of commit

"target-info: Statically initialize target_arch"

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

