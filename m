Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8781FC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZCC-0008Le-Lr; Wed, 10 Jul 2024 11:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRZC9-0008GT-DU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:25:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRZC7-0000SE-Ny
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:25:25 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58e76294858so1762619a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720625119; x=1721229919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EQcXXOjSPU2L2AmoCxFymt6j88iRIYAXTxqv8JQnQ3Y=;
 b=Yn3WHtiC0XptgUVZKZNvz56VbzP+Q4yMU4Df4QN5j+DCcTgj9m05FQDpchHRjbOexB
 d/kNrRZp346/foi94D/GEDtnggkDi243h0dBz2d81QU06E1l6iFvMvBcYYNGmDWqyQ4a
 qae90cSc0kB+PG9a17XDki9G5hIxUrXFCn46ZLrQ/o7BcxP1671Oihsb6kQCLvs5TCZq
 aJ8yFpXq4fugVA9yRw1bQC7fTHqJkaG3Dsdt07dKwsrN1b/K5J+hNlZFjapWy9wvKore
 bd7BSoNu40ZXG5XBlWkxXbpBLZsAkkJno7i2W1vkjnDaHbeH/m2qK0U9+fTiQY+vypia
 ZXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720625119; x=1721229919;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQcXXOjSPU2L2AmoCxFymt6j88iRIYAXTxqv8JQnQ3Y=;
 b=Lki0mwCQBCghOzKgXLuV3N2uTmp6j7369D46jNL2R3RR4ROc6wo276bGT+OJIevvkq
 I9WItUzggBKG2F+YfjUGt80FoNDLeOJWQeG+x/rGC5TLrfDXUWlLsFzL3WvcGtF0i+2q
 VxVZeM6KkiME1Q4mtlFM22xvZFqDK+EUwZiGWkO60sZxWIHnv6DQ3RXO+67bXq+mA23Y
 m2e4lk9/GsZf4lGUCi9PDUr+v1WSJxW+kMrRjB0cJDmjzK+m+Kq3dKemxmE4rmv7PHan
 TDCZ3Lw7n1lNOVRdVrYdmnN6nzp9uRLl+eszbdwlqIdIPt+J8MySz5ztpZ75G8rmoAeZ
 WMGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6HPKqviUzTf2Nu9Ep+CUdiMt7N7bfOdiX94zpo//e7kTOM5ONhAv0Xe3a4YymO7z5cVqVqGIU7KfLQTvaXrMIbgHEiHM=
X-Gm-Message-State: AOJu0YyRCL+NgXntUUwk62I1O7GIbV6m4int/hJ4dEPQuw3fTEK8ed4j
 i2cLf3pj9zvHfS2vaKEdptb7tvP8+aFQnb54GKOaAqblGLys2RuWjc8n3/XTrrg=
X-Google-Smtp-Source: AGHT+IEG1KcV9Pqk46FPhDhJJTJm5aq4tnEpcVOJu4e3Yd2dCSoqdgPFbmUAHw0vB6I+KFnhrhExPw==
X-Received: by 2002:a17:906:2b52:b0:a77:d4e1:f66e with SMTP id
 a640c23a62f3a-a780d2673f2mr376394766b.20.1720625118758; 
 Wed, 10 Jul 2024 08:25:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a797e158f5csm53242666b.218.2024.07.10.08.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 08:25:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 47D0C5F937;
 Wed, 10 Jul 2024 16:25:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/avocado: Remove non-working sparc leon3 test
In-Reply-To: <20240710111755.60584-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 10 Jul 2024 13:17:49 +0200")
References: <20240710111755.60584-1-thuth@redhat.com>
Date: Wed, 10 Jul 2024 16:25:17 +0100
Message-ID: <87o775qnfm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> The test has been marked as broken more than 4 years ago, and
> so far nobody ever cared to fix it. Thus let's simply remove it
> now ... if somebody ever needs it again, they can restore the
> file from an older version of QEMU.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

