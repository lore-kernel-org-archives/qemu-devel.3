Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41050D3A696
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 20:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5sZ6-0001YC-M7; Tue, 29 Oct 2024 16:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5sZ4-0001Xz-Gr
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5sZ2-0000Vm-By
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730232698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mtvr8GVZiE0wc6HS2Qh6BjQJZ5oec/5TsFMOmIsz8w0=;
 b=YGSjR8X6K0fy/rLw2F0a0cPV7SC9D3gOpfG7hbRnn/eY1coO8JxCUn7xpeVx/D8XU0DLVg
 qk1ef5yeIWWvy00f8G9AdGK7punARxaKuQITN0rOmyO8LXZi02eWTam9oReiCP3xu7ak/j
 DXinULPIEckqYnYA1F906vqy5BSbJjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-I3pg-AE0PZekRvtegwet-g-1; Tue, 29 Oct 2024 16:11:23 -0400
X-MC-Unique: I3pg-AE0PZekRvtegwet-g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315d98a75fso44002755e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 13:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730232682; x=1730837482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mtvr8GVZiE0wc6HS2Qh6BjQJZ5oec/5TsFMOmIsz8w0=;
 b=jqDD+4xjt6ehM2xBQ0CDErskvei1KkJvKS8sJmEWJxRWrV0TKynWrsLuQvdTrFJ1LK
 y5hZeYC4LNM2N1yPVx8NtmlkpXnPIz1PAkbhDh0XstwZ/4upzW1gvofKABDNNY0jS+nj
 SfTgjWPUtzewx2k6TP2e1U/lDzBA8v5N5H/105MI5zSnJv09OYEERI3w590GVQhCqevz
 nZfaNWNB90ld9+93a4iNAIHTGnHs7Z3trqxT4EEDluv9D3QUQlaoYeNdTk+7L9Z9vvTh
 KFXmw5JWJn1ukhT2S+b7AlVelemRUEgd/SFgIQdvkmgraIcbjTrYfy099oodupfrDh/r
 RB1A==
X-Gm-Message-State: AOJu0YxV00bH+65rXpTqGzw4V3tVjGA/1WAjMkkQiTozengKYvi+kMa+
 i5R0ze4VD0EjLqQo7qPEE6xMhCw08lXul/G7dZ2xE63tmuwlmICY/CBVr8FbLQ2T4WUoJSdAdOU
 cLs5sL7G+3HEyJZlL6CoPiqzcjbS9fMkzmlYizhd7X8hfzAH5EVWQNbUDjHyxlIhi1wdVOkmHkD
 ONUpq+xnFTHlr2qMX8IIH5ymVzjnTldNQKiO/9V/nk
X-Received: by 2002:a05:600c:470b:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-4319ab94b8fmr111136855e9.0.1730232681774; 
 Tue, 29 Oct 2024 13:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF2vF2gkR7TRJC3H0+yySosKDr+agQPms1Q6WREZyvcTye9bGDA1fkZM4esq830oIjwPKgHYbvP1k95UtGLhQ=
X-Received: by 2002:a05:600c:470b:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-4319ab94b8fmr111136745e9.0.1730232681439; Tue, 29 Oct 2024
 13:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-8-pbonzini@redhat.com>
In-Reply-To: <20241029151858.550269-8-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Oct 2024 21:11:09 +0100
Message-ID: <CABgObfa1A2ax4a1ezJeqpdqgUjcRjoTRPb6bQn7FhP7Rn0z59Q@mail.gmail.com>
Subject: Re: [PATCH 7/8] target/i386: Add AVX512 state when AVX10 is supported
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com, zhao1.liu@intel.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Oct 29, 2024 at 4:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: Tao Su <tao1.su@linux.intel.com>
>
> AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
> are identical to AVX512 state regardless of the supported vector lengths.
>
> Given that some E-cores will support AVX10 but not support AVX512, add
> AVX512 state components to guest when AVX10 is enabled.
>
> Based on a patch by Tao Su <tao1.su@linux.intel.com>
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4c86a49ad05..b6799ddafa9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7166,7 +7166,15 @@ static bool cpuid_has_xsave_feature(CPUX86State *e=
nv, const ExtSaveArea *esa)
>          return false;
>      }
>
> -    return (env->features[esa->feature] & esa->bits);
> +    if (env->features[esa->feature] & esa->bits) {
> +        return true;
> +    }
> +    if (esa->feature =3D=3D FEAT_7_0_EBX && esa->bits =3D CPUID_7_0_EBX_=
AVX512F
> +        && (features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
> +        return true;
> +    }

Oops, a few syntax issues in this hunk. :(

The right version is at branch avx10-for-intel of
https://gitlab.com/bonzini/qemu/.

> +
> +    return false;
>  }
>
>  static void x86_cpu_reset_hold(Object *obj, ResetType type)
> --
> 2.47.0
>


