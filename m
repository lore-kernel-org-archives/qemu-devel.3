Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F5606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yaLY4PCn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoFC-0002yl-1N; Fri, 30 Oct 2026 11:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xMoEi-0002uu-GL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:09:46 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xMoEg-0007kr-I4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:09:43 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso1095771eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793372980; cv=none;
 d=google.com; s=arc-20260327;
 b=p2/O5oIocJxeRMtA8OOT1ffArsdZsd6GVPUgbUlviwjfcsUqZftVvXhc9DY5k5+1V+
 hzZb6XaBjLSsJU4xcl0tlEJGdrP4uS4yiMdfeR02r1zcD4E2flfln+OmW0XCotdq9EjL
 rBr/8gLGT4WVy20ZL3I+ErUbwTP6ele8Fw1bRXnz6fJxVztKnqfAe2HdCRLHruTpjxcu
 MWV5tBSfZkzQcMWdj1huuhfnCZPVHIumFVpj0gkmOxn3X7K0F8toTRI1SJNlGVf61nSI
 40FU+9zpOdB464Ky/SdOlt0Ev+btlu3sNFeW2fOuo7nCYez3+51HGJ3sYUwYTHfOp96G
 IM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0uvVMeQA1xBC/DaNwp/EJJHQs5VSjzRITfeTmxy4JxM=;
 fh=CmprLcZsa4QQ9ECzb2rxwQCxK9TBWXiZITMoY+eGPFw=;
 b=gEZfwZvD7sVVFXAH/hDVhjrimShALTqkW56mvd2zPjUviLCJyck0pXsFvDvh1ZUj63
 dBFpC3YE/iaLRfpEeRxgK0LPI6OVSkDb79rV78yQQ4NrKcWVahBk/O73Z57GpluSAPck
 VFTYkRJ+m9Y4Msj/fwr4wborU+0LtD2DJl/fJFkpib9Ibto43ngtJ3mLAGQhZnwLACH/
 6HNZOjJCYnUeC2BMchdkYX4RnmyS/BJN9Ecmp5j6PRh5gKQp9DTtyn+HnTIzkZaC+FZY
 MCt7oNkhVnyiRRP6BbXFUmGaz8pll2eyoBjyZl4aU5mCNXJvelQ9LoVxptg+6VZDs0TI
 aQNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793372980; x=1793977780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0uvVMeQA1xBC/DaNwp/EJJHQs5VSjzRITfeTmxy4JxM=;
 b=yaLY4PCn2flrcR8/hBrGPxToB1Pj8C6B9FRUsXUVogerHxiVn5z7AVRW05taozyS9w
 tqeKE3/qhZJbh6Rtcc2tuCyrr5u/h4h8MRONJD66Jn1ZDb6mizUXHCevbxcj80GF86a3
 sm0t8BVySkpHogTYXq+3f3XAxtLVmA8xaZWtC6DSGe3DnE8lcgkpZFIdmKTJlhiAAYQP
 CTbjNXWmFoVUa6uxE0thiuN5gvN8rlaK4JHl/yxTD52a8Hj86ocTOqVrUPK/Z+dI++iM
 YFgME2vOsBXB9yEc0M0EJPkK9Q5wU0pGQt87StFsV5C6fA80THMxLVD+EG5cop6hYbEm
 mStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372980; x=1793977780;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0uvVMeQA1xBC/DaNwp/EJJHQs5VSjzRITfeTmxy4JxM=;
 b=m4ElrCbyQxrgZD1ONPX8EWTTpTZYSz5j8FhwXZvIuavA5GNFyO7kaAqkWignTN06N1
 lx2nmrpXnPGBEsGmBeI9OBnP52RVRWGYZAwPjSfh9NN/IlYZmrl+EIuiMYdhsbngut2e
 QFJ0gfiMoq5p72Z7ofnN7EMKb5s+9ka/5IUSZI/iKdRxFgml9emVAKpmXiiFw6XSM57N
 RP+CliguNJEoGCv9kO9/BJKCedXAyamFE51gD5Db9vdrHTwlVZFa2BJq/pIoBU3W4Zu+
 33UyKSdzao5kIRmcwGi8UJspMzFGRDJgM+iqLlJ5c2k+9VeOY3RmvFK4UYcMPl8kfOJo
 ymwg==
X-Gm-Message-State: AFq9FYIln4Kyf4/6fBgiCqcrQgEX+rfFkGcjdjHLVru4og+2TqjBr+/2
 Mk3begwTiHtBXXsDFCS1Dw9uuRtOwtJNA6PZkpKGKvkMCZwQDON9oAmsUu14QDS5kK0mQPg2W6h
 NX6tdxuAMPVaQkL9uC0Vv484ar3c4E+0=
X-Gm-Gg: AYBFou0Pg3YpNzyTRGVEIRq3xb+DR2AT4TvENNvr9cuQrKlPhiQXUFqbOkKZ7sAj5hz
 BdQ945IzEe+qdi7nHG3GdL8snNlS/4fi+tUay+KM7R5uztpU3hH2r76chl6rYkOtilDlwP7l865
 ddv/0sgK4s5tC2SfEQif9zVbMZc8nlUxQgGzyw+xYGqTWRI69C0MxsReZWjvydZWSngKx+FtNKE
 TzpqwtJPaxDKpesznJFdLS72secbv7ymL5bltdwaRHPBLGdOd6IQjqBv4ayCzn3kHaGjh9jC1eY
 GRjn5X9NLoXGRFmBm5tX2h4Do5aQsyfez/xYVlLCqX9KlK7+p9djRCYWON9r34X6Iz51lcQC9ZC
 Xs1zngo7QEMlEqVx+4RIvwCtTtIeEkS3b9BO1h/SBKx8W2lxjP7k8XGt8R0bB3/UhDZ9RactVI2
 eeRyUJpAkL78Bo/eg=
X-Received: by 2002:a05:693c:409a:b0:369:f05d:6c67 with SMTP id
 5a478bee46e88-36a42364b83mr4308216eec.12.1793372980250; Fri, 30 Oct 2026
 08:09:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030141713.2841710-1-berrange@redhat.com>
In-Reply-To: <20261030141713.2841710-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2026 19:09:28 +0400
X-Gm-Features: AclHuK84ZzMqaZ2BEWD_PQZWDwue5nezHoUl34Lu_LuruyVZS42KExv7kOstR5M
Message-ID: <CAJ+F1CKzucXdJz9wBtu76cxt_BJn-GcFDN-LwmgZVo+_Lgb89w@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] qapi: last minute improvements/changes to -compat
 insecure-types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 6:18=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> This addresses various points raised by Markus about the current
> impl/design, that would need to be addressed before this is
> included in the release.
>
> NB, the 'warn' option will repeatedly warn on every violation
> which can be somewhat unpleasant. Figuring out a mechanism to
> make it a one-time warning is an exercise for the future, given
> limited time before release.
>
> Changed in v2:
>
>  * Expand docs to state 'warn' occurs repeatedly
>  * Various docs rephrasing changes
>  * Add error hint for security check
>
> Daniel P. Berrang=C3=A9 (8):
>   qapi: make 'CompatPolicy' the first arg in compat_policy_input_ok
>   qapi: add 'warn' option to CompatPolicyInput
>   qapi: rename 'insecure-types' to 'insecure-input'
>   qapi: drop CompatPolicySecurity and use CompatPolicyInput
>   qapi: rename compat_policy_check_security method
>   qapi: reverse arg order in compat_policy_security_ok
>   qemu-options: document -compat insecure-input parameter
>   qapi: print a message before aborting for -compat violations
>
>  docs/system/security.rst     |  2 +-
>  include/qapi/compat-policy.h | 12 ++++----
>  qapi/compat.json             | 27 +++++------------
>  qapi/qapi-util.c             | 57 +++++++++++++++++++-----------------
>  qapi/qapi-visit-core.c       |  4 +--
>  qapi/qmp-dispatch.c          |  2 +-
>  qapi/qobject-input-visitor.c |  2 +-
>  qemu-options.hx              | 37 +++++++++++++++++++----
>  qom/object.c                 |  8 ++---
>  9 files changed, 85 insertions(+), 66 deletions(-)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> --
> 2.56.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

