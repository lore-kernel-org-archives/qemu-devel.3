Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C34C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 19:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRzNn-00011m-46; Thu, 11 Jul 2024 15:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRzNl-00011B-Gt
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 15:23:09 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRzNj-00066O-SX
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 15:23:09 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58b447c519eso1718841a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720725786; x=1721330586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4dOBGlgCIk7eB0/8tEeAqCxhGayl1PSOEMP+AtkzCFg=;
 b=ha94CwKQKqSQEjH5LHEv76bFJ49fpjLqxRk6MNzR6TckMTDBOAmk4vyOD9mJaJDaRO
 3DzvIS1WNXukH0bRAptRQq0Bfp/eC0USOmo5CzfAAKfk+JjesK8ZoBzbmXDdOyCfbMZo
 CWZkBR0ChfaExXE1b0tkF+aOxIfgOwp/2i1UFTitd5KCHwTu7kbGiZOrg92yIqhm5I1G
 KrymwJShwTeqs0vOe7JVln3BdxqeMgSPRqJbp+2Ibz+M6/MwlcZJR0rMGI5FltRBwBD5
 rdEpRLxagkd9xN4jfxYy3D80pcD62QOzKSOU/pJYrE7B7jIrFoa0uQmKD783t/hIgOXY
 iRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720725786; x=1721330586;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dOBGlgCIk7eB0/8tEeAqCxhGayl1PSOEMP+AtkzCFg=;
 b=fFzhMnmnQJ0ilmyCK/x8+crtR3i3w2qwDusAT1nMjHKiGLaS2y4ChZgjxU2t7SFMqG
 hifUMIotVMQTqtNvUIWDXBvzP19bbQOwEc6KUW/zyZ7S0Ya1T502YhenyuSXqfbnV4rn
 pe7c9LybWGYlrgv6IxOikSMkgmTLRgKP+qslQg62tfXUJa25L3uxneltEkWREP4E+Z4K
 IuPTgGM00LjzEvsgq2cYqF2VU8S+5vU+YuDRi7bxQcMtimqFVMm9WL9fzjItPnHongDj
 /zMRpTOYbPPFr7QSjeDrwPR3gO7ccHSJ6789r3G9uvPB0qqe7szO+kdvq8ydSphPA2eq
 +SIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm8+zsKcoSjo9TIXTQJJ9ZgbK7o2uxwuVu+PJCvVUP+rDX0v55ccI392Cf7ujtho118EEOVkA2uYETnTW5zSdgzEydXvk=
X-Gm-Message-State: AOJu0Yx/f/YYDDcjjcGk5MvLWS7eq54NKTKCcKk8IfCwglVbZp/aku53
 MMCWJg+A4uHcrDzVvCjTjWbx9I+6Y1wJXTDVkWiue4p7LG+RhCbWQC521pHeoIk=
X-Google-Smtp-Source: AGHT+IEwOae9NeFwuuXpNer7Gt8ty2TWeizJSvH6P8tS+YFsZYRmFZGVV0SFgEpPjsMZ7926KT/UpA==
X-Received: by 2002:a17:906:6d8:b0:a77:eb34:3b4f with SMTP id
 a640c23a62f3a-a780b6b1db8mr601168666b.17.1720725785529; 
 Thu, 11 Jul 2024 12:23:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7ff0c8sm278548166b.133.2024.07.11.12.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 12:23:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 95F825F79A;
 Thu, 11 Jul 2024 20:23:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Ani Sinha
 <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Daniel P . Berrange"
 <berrange@redhat.com>,  John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method
 for downloading assets
In-Reply-To: <b07b165d-57be-4144-a3d3-19c4ae94c261@linaro.org> (Richard
 Henderson's message of "Thu, 11 Jul 2024 11:49:23 -0700")
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-6-thuth@redhat.com>
 <081298cb-536c-4487-b90c-b184b0f93ce7@linaro.org>
 <b07b165d-57be-4144-a3d3-19c4ae94c261@linaro.org>
Date: Thu, 11 Jul 2024 20:23:03 +0100
Message-ID: <877cdrraw8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/11/24 09:45, Richard Henderson wrote:
>> On 7/11/24 04:55, Thomas Huth wrote:
>>> +=C2=A0=C2=A0=C2=A0 def fetch_asset(self, url, asset_hash):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache_dir =3D os.path.expan=
duser("~/.cache/qemu/download")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not os.path.exists(cache=
_dir):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.=
makedirs(cache_dir)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fname =3D os.path.join(cach=
e_dir,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 hashlib.sha1(url.encode("utf-8")).hexdigest())
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.path.exists(fname) an=
d self.check_hash(fname, asset_hash):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn fname
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logging.debug("Downloading =
%s to %s...", url, fname)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subprocess.check_call(["wge=
t", "-c", url, "-O", fname + ".download"])
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.rename(fname + ".downloa=
d", fname)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fname
>> Download failure via exception?
>> Check hash on downloaded asset?
>
> I would prefer to see assets, particularly downloading, handled in a
> separate pass from tests.

And I assume cachable?

>
> (1) Asset download should not count against test timeout.
> (2) Running tests while disconnected should skip unavailable assets.
>
> Avocado kinda does this, but still generates errors instead of skips.
>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

