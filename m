Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63793C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 09:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbwL-0006nH-5u; Mon, 11 Mar 2024 05:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tabba@google.com>) id 1rjbwG-0006mX-2w
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:27:20 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tabba@google.com>) id 1rjbwB-0001EP-UJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:27:19 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d228a132acso52539781fa.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710149229; x=1710754029; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zth3mwh/cKPnkQ6EEGd+vNlUKFtCYJEHeMahy8I+ig=;
 b=AuMaL4xhj84NX9EFSMY0iwYOHUK9QJmuMpWMzjb3UheXziO4ZcaAzaWhwIITQyyJ73
 LyPWfKm7Kmzc/1o9qYoHOa+bH5uUyDXwKwMCJc2XkDsYHhcxYWmwvdub0BUXlQrKeIzy
 afjPo7MvYSvN8UamxN/TB0e7kIpuH8RzXIrv+BkBVJnRCsnkJYV5Ow/mmlh60NvSKSom
 1eJL6PqkfRbZCO5rtFug0PmQpd4QCduoAyFyutZrRo5d27yRRvxuOZ+hpt0fZkeMBgAb
 a/BkzIIYi6a5HRAGc7lp9jwtFDxnzyLzNFbtxit3qqH4SFqN1d+qN/yEdjY2sGrwASS5
 rlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710149229; x=1710754029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zth3mwh/cKPnkQ6EEGd+vNlUKFtCYJEHeMahy8I+ig=;
 b=Q0FdjJhQwqGHsqHyZTidVs5pu22NB4LRUGPtC8f0Fnp0px/JLVgT1q2YQ7dllzT5CZ
 vefpTwNO9mbvJNCWOw1RUFxovaGvzFuFZzF+6wACxjd4CVD6mvlPrNiYotFNBFZO2GiQ
 9W5SAXPnbe+PgWPKbdEIGC/sarkrkkTc+ULfbHsWqxARFrkx3K0oMaW/rXP+ky8S+guc
 8z0JAxAtaWp4UsnJm5uJSRyF+bod6W2bqer1AhgHRYeQxemFASu7ZncVRlKBIdb+C5g6
 IO+ets1Donn5ZQvJ3PPpBrG0YEERKQxpI4cx51CXIgXET7fI18sPrhqlihoE7XYVqCUE
 bsMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ytSszYxdo6Gi1lPGrZhG9v3+7z+1ce6SKxV0DK/AJeLO/LgfFk5J6Pe+gLefGiG3Ieyx1cq0523hGDki0GxgtdgU+1E=
X-Gm-Message-State: AOJu0Yy+q5p164IlHy3usqX2h/VUpRv9k2Mhf/w32V3YP4NYOaUSLIvS
 RIshd8xhtRIGvQHumccb/6HTaxV8qFexOWXGKcTELxgKyG/IYF5USNhF7X5F6pSn/HRJhp74BSY
 NrRD9fmpJ7YWcCkuVaMsOSKroiVbi+46iAZ1K
X-Google-Smtp-Source: AGHT+IFzr2Y971s9TIBNchuVSVv96nsdJjBYbviMit/edW0+/JwqZBjOrNfaM4862cuUg6dthFfgr61zIEYjCiYlE2E=
X-Received: by 2002:a05:6512:3baa:b0:513:b102:7d93 with SMTP id
 g42-20020a0565123baa00b00513b1027d93mr690098lfv.24.1710149229222; Mon, 11 Mar
 2024 02:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <335E21FA-7F1E-4540-8A70-01A63D8C72FA@amazon.com>
In-Reply-To: <335E21FA-7F1E-4540-8A70-01A63D8C72FA@amazon.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 11 Mar 2024 09:26:12 +0000
Message-ID: <CA+EHjTxpBM6LyqGfE_y--Uy1oR4oP7Ozcp3mBwFvAijOZe0i+Q@mail.gmail.com>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
To: "Manwaring, Derek" <derekmn@amazon.com>
Cc: David Woodhouse <dwmw2@infradead.org>, David Matlack <dmatlack@google.com>,
 Brendan Jackman <jackmanb@google.com>,
 "qperret@google.com" <qperret@google.com>, 
 "jason.cj.chen@intel.com" <jason.cj.chen@intel.com>, "Gowans,
 James" <jgowans@amazon.com>, "seanjc@google.com" <seanjc@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
 "Roy, Patrick" <roypat@amazon.co.uk>, 
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Kalyazin,
 Nikita" <kalyazin@amazon.co.uk>, 
 "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, 
 "mst@redhat.com" <mst@redhat.com>, "somlo@cmu.edu" <somlo@cmu.edu>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=tabba@google.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi,

On Fri, Mar 8, 2024 at 9:05=E2=80=AFPM Manwaring, Derek <derekmn@amazon.com=
> wrote:
>
> On 2024-03-08 at 10:46-0700, David Woodhouse wrote:
> > On Fri, 2024-03-08 at 09:35 -0800, David Matlack wrote:
> > > I think what James is looking for (and what we are also interested
> > > in), is _eliminating_ the ability to access guest memory from the
> > > direct map entirely. And in general, eliminate the ability to access
> > > guest memory in as many ways as possible.
> >
> > Well, pKVM does that...
>
> Yes we've been looking at pKVM and it accomplishes a lot of what we're tr=
ying
> to do. Our initial inclination is that we want to stick with VHE for the =
lower
> overhead. We also want flexibility across server parts, so we would need =
to
> get pKVM working on Intel & AMD if we went this route.
>
> Certainly there are advantages of pKVM on the perf side like the in-place
> memory sharing rather than copying as well as on the security side by sim=
ply
> reducing the TCB. I'd be interested to hear others' thoughts on pKVM vs
> memfd_secret or general ASI.

The work we've done for pKVM is still an RFC [*], but there is nothing
in it that limits it to nVHE (at least not intentionally). It should
work with VHE and hVHE as well. On respinning the patch series [*], we
plan on adding support for normal VMs to use guest_memfd() as well in
arm64, mainly for testing, and to make it easier for others to base
their work on it.

Cheers,
/fuad

[*] https://lore.kernel.org/all/20240222161047.402609-1-tabba@google.com
>
> Derek
>

