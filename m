Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFC3D0C5E6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 08:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4G40-0006Ff-Ms; Fri, 25 Oct 2024 04:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4G3z-0006FP-FQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4G3x-0005rM-SO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729846373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ynha+bszeMKj97T+vfDq2GuBeePhL7RbKtGimONHWc=;
 b=iihuVPCA2ZDfOEt+adsqdGko1siKQfvsiqnaVWfPqmz5tWgBJg7CSer677KiLSeawCXZ+M
 bSkD9eqo8VU27AfdfqlXlfmjKoFwQQQGL0llbvf5Ak0FCNx85HIvmD+MoJ5sh0Z1X6dHSV
 AnF+jiJyFDhq6op0zy6YW5/bYp+XQwU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-XlFeZOdoN3ivV54PEVr99w-1; Fri, 25 Oct 2024 04:52:45 -0400
X-MC-Unique: XlFeZOdoN3ivV54PEVr99w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so12900825e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 01:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729846364; x=1730451164;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ynha+bszeMKj97T+vfDq2GuBeePhL7RbKtGimONHWc=;
 b=G9PO2LYyAfLapJ6kTtMItANTwUF6AiK3d4yStJyAZDOoo7aRPH5GnQzUzMEUwUqM/6
 ucpuoRwVC1/3Z/pN8RnRVun3VTgVKyrVGsgROzwTLTeSZrkDF6dxcGc1AtYZZtRTnLrp
 MTd2wEN6hdmBKE3TuWlvvi5Gcv7CwiHExZ85svi/J8k42h3ywyF8XIZlybfqHJ0ndw8X
 boe064MAn5dLhNcaKN3X8CXI3/Pi/TjryCmD33DtFRli6D1M8GRPIwTGJLyWvk0SninB
 3N5chm5a2NaUuapdsQEMr1giH/VuzE6SJjNcCPykDPsKkXEnzDX1tVfYwpyju0O/6FBz
 ZazA==
X-Gm-Message-State: AOJu0YwNi1D90gFbVWtPmMCE9Cdg4cHkWldDtOYxG58FHHCnGXp4zmc6
 A80UcKadvbDDPop8fdxC+v7eaPUNk8o5IjqKIdGMKTo/tq9GOPxtffPAZDnsoQEqgdMevA0RFGZ
 jwsgYbdEtPQwTVFIyfLav43/6brKkfhVT5R+ruIRLV9/cy5BZs+vPmKByTkpmKobLY0F9d1hLHM
 mZ6JaOVEvqIqVPlPsjre5KYCkujMO30IyBoaWy6g==
X-Received: by 2002:a05:600c:5114:b0:431:5f9e:3f76 with SMTP id
 5b1f17b1804b1-4318415bd5amr85060435e9.16.1729846363833; 
 Fri, 25 Oct 2024 01:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTR+etjbMnVeMS7ErzMBq7yhm8CnDQPT2Ive8yRnE//1ATTQNtFoqaxF0/TpuC/5W7GaN346naeoL2EhLYh8c=
X-Received: by 2002:a05:600c:5114:b0:431:5f9e:3f76 with SMTP id
 5b1f17b1804b1-4318415bd5amr85060275e9.16.1729846363487; Fri, 25 Oct 2024
 01:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241024123459.59350-1-pbonzini@redhat.com>
In-Reply-To: <20241024123459.59350-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 10:52:30 +0200
Message-ID: <CABgObfYYKcudft8Tm3+HO8dFELEJ488LAJqPyd8DC2JCamYUag@mail.gmail.com>
Subject: Re: [PULL 0/8] Misc fixes for 2024-10-24
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On Thu, Oct 24, 2024 at 2:35=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The following changes since commit f1dd640896ee2b50cb34328f2568aad3247029=
54:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2024-10-18 10:42:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5c952562af6717bb4d206dc2c7ba2daa2fcd899d:
>
>   qdev: make properties array "const" (2024-10-24 14:33:55 +0200)
>
> ----------------------------------------------------------------
> * target/i386: fixes for -cpu pentium3
> * qdev: allow making Properties arrays const
> * rust: enable rust in the Fedora system build job
> * sockets: Remove dead code
> * configure: Fix typo
> * stubs: avoid duplicate symbols in libqemuutil.a
> * remove erroneous file that breaks git clone on Windows
>
> ----------------------------------------------------------------
> Daniel P. Berrang=C3=A9 (2):
>       tests: add 'rust' and 'bindgen' to CI package list
>       ci: enable rust in the Fedora system build job

This has conflicts with master, will resend.

Paolo


