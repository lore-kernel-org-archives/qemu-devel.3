Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBFEC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 09:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbzE-0008Mi-Qu; Mon, 11 Mar 2024 05:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tabba@google.com>) id 1rjbzD-0008MG-2b
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:30:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tabba@google.com>) id 1rjbyr-0001jN-Je
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:30:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e8e9a4edaso1702049f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710149397; x=1710754197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYwZNAyl9eI8xnn6G8iPccTROZ3bREOUqaEgbZaMdn4=;
 b=Ba6iGGtOrZRlnabXRdtjotfu1jFZ+AvNH7WjTkH2e86BZy5640kyGjHDfj2nh23BNM
 PImtht7waJV6tgMraJlO22nmPiXr2xSyLOwYtUXP4/uckHyij7j06P4c9nWBH9Qnip1F
 HIZyXuo/CV7M3HZTiYdOS3qhSBhmeiJKkxHO+MB95/ua2PFGiM3N64yp9i5Mck7GjeIB
 rK+uSMYupbJyIuZK2cF2TUADcO9bFv3edLV16x1CpJuVnMMCvK8z3DitwJ0rZ0g7AEFK
 Ll9m87yR+IiTbeoZn6U3nfks/KlAVx4qZUwuZWmhQfpHofgbCAHyf3VRLlY52pEktrhg
 T3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710149397; x=1710754197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYwZNAyl9eI8xnn6G8iPccTROZ3bREOUqaEgbZaMdn4=;
 b=S8g66EEk+pyWX71fx6LnRyW7XAwpLUzWmMSBQ04/lGg8AmJ50RX0SlJSCAm/zS/Rpw
 YUwG871hhokASP1mHlTM5U5kdXP3bmps5IJwRLvZ8h+qQKfSD+BOQs4uXYNJhc22ol2B
 P+5HloNaxmZDqi9RIKdjUusOykpq2qfxztXPJGG8tIHXX7Y/VkYf6D1UubkCJTYh420n
 IS1x6sWEhdMAwEgkqy7jLjc2crkSRngG+i3M939Em6lMUp7NfNAk4PSsYTUP0jXZqoXy
 M/OxRrxPOVuGMJNo8xbKJz14ChEQPzuTB6X4pUz8zYWZXvOcy/FHVd8Q09RjH9yveSk9
 HYDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdiKs9mbWs5IOs4tmwVLtVuibGSsSxd05NfXNAOr9h5Xj8GzWkYrY7TkgHlz6moQvkjhPbDbm9CVGFnwBSaRa+BctLb9Y=
X-Gm-Message-State: AOJu0YzgXUxFWplXk4b6j7/FgwTsoolci0K1NO/B0RZ5KDD0Gb+CmWDN
 TY1VBnoiu83979k43KBcBKD1xoVeE+fmodUuGuC4MOEkhHKhL2h3M4K5ujzXNqm+SAZ/s4+h8nI
 cYzwgH9FueiB9w6iuVyzRx8MYxXPg/1QP71xv
X-Google-Smtp-Source: AGHT+IHSfs26GHVI09JkKNk9HoDRqOW4oeQ0rJHE/UNYx/wsSmfgrD7ev79myOziiYJpopiGSTSS0pKlBEG+6nVcKtI=
X-Received: by 2002:a5d:5188:0:b0:33d:e1d2:2694 with SMTP id
 k8-20020a5d5188000000b0033de1d22694mr3718979wrv.63.1710149396551; Mon, 11 Mar
 2024 02:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <335E21FA-7F1E-4540-8A70-01A63D8C72FA@amazon.com>
 <CA+EHjTxpBM6LyqGfE_y--Uy1oR4oP7Ozcp3mBwFvAijOZe0i+Q@mail.gmail.com>
In-Reply-To: <CA+EHjTxpBM6LyqGfE_y--Uy1oR4oP7Ozcp3mBwFvAijOZe0i+Q@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 11 Mar 2024 09:29:11 +0000
Message-ID: <CA+EHjTyqjTHN+b42THuppBwabbbPTE7+s3+4gzELN=SVddVtDg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=tabba@google.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Mar 11, 2024 at 9:26=E2=80=AFAM Fuad Tabba <tabba@google.com> wrote=
:
>
> Hi,
>
> On Fri, Mar 8, 2024 at 9:05=E2=80=AFPM Manwaring, Derek <derekmn@amazon.c=
om> wrote:
> >
> > On 2024-03-08 at 10:46-0700, David Woodhouse wrote:
> > > On Fri, 2024-03-08 at 09:35 -0800, David Matlack wrote:
> > > > I think what James is looking for (and what we are also interested
> > > > in), is _eliminating_ the ability to access guest memory from the
> > > > direct map entirely. And in general, eliminate the ability to acces=
s
> > > > guest memory in as many ways as possible.
> > >
> > > Well, pKVM does that...
> >
> > Yes we've been looking at pKVM and it accomplishes a lot of what we're =
trying
> > to do. Our initial inclination is that we want to stick with VHE for th=
e lower
> > overhead. We also want flexibility across server parts, so we would nee=
d to
> > get pKVM working on Intel & AMD if we went this route.
> >
> > Certainly there are advantages of pKVM on the perf side like the in-pla=
ce
> > memory sharing rather than copying as well as on the security side by s=
imply
> > reducing the TCB. I'd be interested to hear others' thoughts on pKVM vs
> > memfd_secret or general ASI.
>
> The work we've done for pKVM is still an RFC [*], but there is nothing
> in it that limits it to nVHE (at least not intentionally). It should
> work with VHE and hVHE as well. On respinning the patch series [*], we
> plan on adding support for normal VMs to use guest_memfd() as well in
> arm64, mainly for testing, and to make it easier for others to base
> their work on it.

Just to clarify, I am referring specifically to the work we did in
porting guest_memfd() to pKVM/arm64. pKVM itself works only in nVHE
mode.
>
> Cheers,
> /fuad
>
> [*] https://lore.kernel.org/all/20240222161047.402609-1-tabba@google.com
> >
> > Derek
> >

