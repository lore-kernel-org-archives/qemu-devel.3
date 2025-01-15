Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EC8C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4nw-0000N0-K0; Wed, 15 Jan 2025 09:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whendrik@google.com>)
 id 1tY4nu-0000KZ-Tb
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:55:34 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <whendrik@google.com>)
 id 1tY4nt-0001tq-BP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:55:34 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-467896541e1so574121cf.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1736952931; x=1737557731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtYxyMK7e5WAvUpt+rv/hHD1QcgqU+JAsvBg2nFZoBM=;
 b=GGUsYMJuVNJHEKj/r4tmy29HMsPuif2Lq4k4z/wCBvZGQWvf7FoyGQb5Ct4FUNHyTX
 ipeXDB6OCS1BkcO9mEkhYmUtNIsfDOzHzq2Ks37HgKIDM98kBEIG16e0QM3Mqp+B+W/B
 MrvHNqnB46ikpMGD0bhiS4tyHmzJygc7l3wblah2YBnVK2f6H6dFRW4D82w3RMzFAt1a
 FjCjogHwl8GoF3BIdZ0cyYG2/NynP9KxXT8XcVxTEGDstTbto1kxTpG96e0dQ+T9StE9
 1o5rCv+YpbhQqByJ7Ip+hHud9CXA4CNR8Xh76TgRwzrbRsa6KqULmRzZCLzkUlzV4rBN
 msrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736952931; x=1737557731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtYxyMK7e5WAvUpt+rv/hHD1QcgqU+JAsvBg2nFZoBM=;
 b=FkFzINE3JTdESGQWAIWYbNG4uILeGiPIEqpYIgi0qgIunV92eOez+K8UkGxYHn9lZD
 l8TrNG5NcRu5w+XkwWNOLI4Pg3l4iyLi3NKOsBn54jss4APDvKn8p6RMcjWSRKvxuiFz
 QcWYNpcJJhjuUpQIj3CXo2WSOta1LRkVACTmZLeCa+/KeL+VCVuvT/nvuxaFpWj4WVqg
 JHDXJymuWyJcmu0CFHy652iZX/VopqTtamXNMrSDoZ8vjO9wLVjLXzybMAceMI53jmeZ
 uDaVNS2mrJ3Au9RO4aBi3THNt+/tPtNBsfViB4iLA1fa9Y2GWOTXdLyBdCC61zAxSmWt
 BwVg==
X-Gm-Message-State: AOJu0YxNOFIcjmsTN18VRuY7bkTAILJiO//N3XfAU+YNInu+0z1y1U7u
 dDDQbO9y2Ni4TXbn0LPbzl3XEKrch86mz0LfPbKKBkJ7WabiDs5WR1KGJw8fSoh18WTHQ2D2fu4
 LygGjVCdOYrTiLm/qpAd+aVab1bmiG9fgSM7o
X-Gm-Gg: ASbGnctkyaad6RRcaSRFrZDFgbPMHknLhUDGtl27z4mSahak2wutoOGzjDQxhnTDe6u
 cgck1c9Mn/XTwLeqd5qQotZYDlUlUE6g6vrI/clFkoacQ3E522FbZBf6gECKIHVSLmsPL
X-Google-Smtp-Source: AGHT+IE/Mqi6pgUZcupwTHECRbrODF0ZOX8j4zEAHUS0SMGWd/bFV6oYIisQBB/2nwgK386gx25Unw3iPr67GnC04Ts=
X-Received: by 2002:ac8:5f0c:0:b0:467:7f81:ade0 with SMTP id
 d75a77b69052e-46df57d5215mr3670151cf.24.1736952930916; Wed, 15 Jan 2025
 06:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
 <20241213172645.2751696-7-whendrik@google.com>
 <20250108133826-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108133826-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Hendrik_W=C3=BCthrich?= <whendrik@google.com>
Date: Wed, 15 Jan 2025 15:55:19 +0100
X-Gm-Features: AbW1kvYWeplLnKWI5peaJz-BgzYKYDBrIObWF1-MAmeGKgCyYEA-LKiNkq5_Fbs
Message-ID: <CAEX-0Wvor6Q-ekKa+Ze1JfbONPrETBGTZVP=swEHqGJVn1N96g@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] i386: Add RDT feature flags.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, zhao1.liu@intel.com, 
 xiaoyao.li@intel.com, peternewman@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=whendrik@google.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

On Wed, Jan 8, 2025 at 7:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Dec 13, 2024 at 05:26:43PM +0000, Hendrik Wuethrich wrote:
> > From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
> >
> > Add RDT features to feature word / TCG.
> >
> > Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
> > ---
> >  target/i386/cpu.c | 30 ++++++++++++++++++++++++++++--
> >  target/i386/cpu.h |  2 ++
> >  2 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index c6e6cff19d..6f14d6fc62 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -869,7 +869,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t v=
endor1,
> >            CPUID_7_0_EBX_CLFLUSHOPT |            \
> >            CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSB=
ASE | \
> >            CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSE=
ED | \
> > -          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES)
> > +          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES | \
> > +          CPUID_7_0_EBX_PQM | CPUID_7_0_EBX_PQE)
> >            /* missing:
> >            CPUID_7_0_EBX_HLE
> >            CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
> > @@ -906,6 +907,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t v=
endor1,
> >  #define TCG_SGX_12_0_EBX_FEATURES 0
> >  #define TCG_SGX_12_1_EAX_FEATURES 0
> >  #define TCG_24_0_EBX_FEATURES 0
> > +#define TCG_RDT_F_0_EDX_FEATURES CPUID_F_0_EDX_L3
> >
> >  #if defined CONFIG_USER_ONLY
> >  #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB =
| \
> > @@ -1063,7 +1065,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =
=3D {
> >              "fsgsbase", "tsc-adjust", "sgx", "bmi1",
> >              "hle", "avx2", "fdp-excptn-only", "smep",
> >              "bmi2", "erms", "invpcid", "rtm",
> > -            NULL, "zero-fcs-fds", "mpx", NULL,
> > +            "rdt-m", "zero-fcs-fds", "mpx", "rdt-a",
> >              "avx512f", "avx512dq", "rdseed", "adx",
> >              "smap", "avx512ifma", "pcommit", "clflushopt",
> >              "clwb", "intel-pt", "avx512pf", "avx512er",
> > @@ -1651,6 +1653,30 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS]=
 =3D {
> >          },
> >          .tcg_features =3D TCG_SGX_12_1_EAX_FEATURES,
> >      },
> > +
> > +    [FEAT_RDT_10_0_EBX] =3D {
> > +        .type =3D CPUID_FEATURE_WORD,
> > +        .feat_names =3D {
> > +            NULL, "l3-cat", "l2-cat", "mba"
> > +        },
> > +        .cpuid =3D {
> > +            .eax =3D 0x10,
> > +            .needs_ecx =3D true, .ecx =3D 0,
> > +            .reg =3D R_EBX,
> > +        }
> > +    },
> > +    [FEAT_RDT_F_0_EDX] =3D {
> > +        .type =3D CPUID_FEATURE_WORD,
> > +        .feat_names =3D {
> > +            [1] =3D "l3-cmt"
> > +        },
> > +        .cpuid =3D {
> > +            .eax =3D 0xf,
> > +            .needs_ecx =3D true, .ecx =3D 0,
> > +            .reg =3D R_EDX,
> > +        },
> > +        .tcg_features =3D TCG_RDT_F_0_EDX_FEATURES,
> > +    },
> >  };
> >
>
> Should these be made unavailable if rdt device is compiled out?

This doesn't seem to be happening in similar situations in the
surrounding code, so I don't think so.

>
> >  typedef struct FeatureMask {
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index a1ec2d5dde..2b5a5986de 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -678,7 +678,9 @@ typedef enum FeatureWord {
> >      FEAT_7_1_EDX,       /* CPUID[EAX=3D7,ECX=3D1].EDX */
> >      FEAT_7_2_EDX,       /* CPUID[EAX=3D7,ECX=3D2].EDX */
> >      FEAT_24_0_EBX,      /* CPUID[EAX=3D0x24,ECX=3D0].EBX */
> > +    FEAT_RDT_F_0_EBX,  /* CPUID[EAX=3D0xf,ECX=3D0].EBX (RDT CMT/MBM) *=
/
> >      FEAT_RDT_F_0_EDX,  /* CPUID[EAX=3D0xf,ECX=3D0].EDX (RDT CMT/MBM) *=
/
> > +    FEAT_RDT_10_0_EBX,  /* CPUID[EAX=3D0x10,ECX=3D0].EBX (RDT CAT/MBA)=
 */
> >      FEATURE_WORDS,
> >  } FeatureWord;
> >
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
>

