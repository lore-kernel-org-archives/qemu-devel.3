Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E02C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBsP-0003Ob-Rf; Fri, 12 Apr 2024 04:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvBsO-0003OQ-3O
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 04:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvBsM-0004OW-Lm
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 04:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712908989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbdgDfRvQi2vhixie8/s65y+Az6KP8Euugnz4ck/tiM=;
 b=V+zzIqJ9WCTSdZ1sGqNrTYWBFBVfyXq6cAtTEJJc8IO7ZCsaeWhNA2orXGEDJkTZWF3z5R
 6R14x0nQlniqY2k9bxUP2BZBPFmDNDHiIvCp2WFCGo9jrBo5VPUq1vGt3jaX93A3wQ76u1
 Fzs1tBL9vLJJJyrRcLUFHH2j8kE55As=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-GC5GlGH9OHiqzp_bt_mG-g-1; Fri, 12 Apr 2024 04:03:07 -0400
X-MC-Unique: GC5GlGH9OHiqzp_bt_mG-g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-417db791f5eso3646815e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 01:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712908986; x=1713513786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbdgDfRvQi2vhixie8/s65y+Az6KP8Euugnz4ck/tiM=;
 b=aCtjNVGs5+vPTbpl5NTW7EB5BUpQ+lzZoMRFk8tlRfPiyGSmaz/prIeE8PuOwqFv3p
 PVpnXnLX9eq0Zf0rOHJHYwAfX5Rc3k/0oED7ipjbjWrHo7SGjWYLtw/hOJf9qzBURgvY
 EpYYvakkoUjCFVMfq6EOK/uJjLG3l1GFwRJeYYST7pzahn7N8WXG+vPR2O6siJGM1pIq
 hCOHcfutYa7G3InjeUjtZZf5BpWfFioeZ01YfOrFAMY+KAfoQsvhekIs1gpWtu1K0Vv6
 6vjFHdwSK+3CZc1hZHgL1HWg9S4wVqepA5JVo2s6EZ6SzYQAdXkqcjhyMsTQDVkgaWwH
 2bsw==
X-Gm-Message-State: AOJu0Yx36B9vwHyZ8YMz6JMB8cIL32iHpmIywOZHLUwuppLLncFSooIK
 O6fx+bPVA19ZwgSc7piO+s/Cee0g1ZnHAdM7s37QtVYk9bJTTDEuQpnYELIt6rDR0bAMUWzq00P
 teGff3rkorZsxat7Hquhfpuly1HR0FRPc0GbXi24ixwbZamBs7DD6f1AqTVLmQAHhhBp5engJKl
 Ez+hLL+8wy+Vl6LmdbqRuwURyV+/w=
X-Received: by 2002:a5d:59a5:0:b0:343:b295:4d99 with SMTP id
 p5-20020a5d59a5000000b00343b2954d99mr1649010wrr.56.1712908986486; 
 Fri, 12 Apr 2024 01:03:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7aqMPOP0DTQBVkLfWD19+835hybbew1SDXnQoq59fBQzjNAOmr4kCC2Ms01W4Bur+VZjF1/B+yDax3gHgngI=
X-Received: by 2002:a5d:59a5:0:b0:343:b295:4d99 with SMTP id
 p5-20020a5d59a5000000b00343b2954d99mr1648995wrr.56.1712908986222; Fri, 12 Apr
 2024 01:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <99185cfa61404dfa019a5e2c292b928791e85af5.1712848167.git.quic_mathbern@quicinc.com>
In-Reply-To: <99185cfa61404dfa019a5e2c292b928791e85af5.1712848167.git.quic_mathbern@quicinc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2024 10:02:54 +0200
Message-ID: <CABgObfa5NVGTTC=D09tomXf6FhYnbCt6wY_K=L32cWLXOhaJgg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix use of -j without an argument
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: qemu-devel@nongnu.org, martin@geanix.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 11, 2024 at 5:46=E2=80=AFPM Matheus Tavares Bernardino
<quic_mathbern@quicinc.com> wrote:
> +        $(if $(filter -j, $(MAKEFLAGS)) \
> +            ,, \
> +            $(or \
> +                 $(filter -l% -j%, $(MAKEFLAGS)), \
> +                 $(if $(filter --jobserver-auth=3D%, $(MAKEFLAGS)),, -j1=
)) \
> +        ) -d keepdepfile

This is more easily written as $(filter-out -j, $(or ...)).

I've sent a v2.

Paolo

>  ninja-cmd-goals =3D $(or $(MAKECMDGOALS), all)
>  ninja-cmd-goals +=3D $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
>
> --
> 2.37.2
>


