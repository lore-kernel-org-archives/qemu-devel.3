Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF20D41D52
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 05:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAjSA-0004ib-R9; Tue, 12 Nov 2024 00:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tAjS7-0004i7-La
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 00:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tAjS6-0004If-63
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 00:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731389310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0cpccIjpFxDWECk21DgBAahSfJS1J1ZhQXmJR4Ugfnc=;
 b=FPk+OClop3xTrKjDQJbzjxJ8kAMiIe7slYYrNGSo+746Nk+6A5/6f++DB8DEsup+uDOnMs
 A1QnuPM3sfKDxRhyopGD4WEmG3bJrdNaDWm4JfmES4QkKEXxiCF34YXXfdfqeWNKb9jBi3
 HyATlsqyCGFXnNQzSwKV9bRLxmtFx1E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-S4Vl7E29OJq6MG5wNd6snQ-1; Tue, 12 Nov 2024 00:28:28 -0500
X-MC-Unique: S4Vl7E29OJq6MG5wNd6snQ-1
X-Mimecast-MFC-AGG-ID: S4Vl7E29OJq6MG5wNd6snQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so3000346f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 21:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731389307; x=1731994107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cpccIjpFxDWECk21DgBAahSfJS1J1ZhQXmJR4Ugfnc=;
 b=lh5N/rJJxj4yBjHigLBXSYsnoZH61/lKfoVcShLfz4XLfD2LYpUevxB2hLQo6bkEDx
 wKf6WPgVmlr6djOvWy4v3DpB2dFlPeo8wAbDXX9t3p6g8JIxTj64UcXsEqTzhNOMzzq9
 bo4VUi56q07XgWEbT74d+k3mR4CnXR7zPDgTjAjG1WG2cs3RcAsissPL4W3Oj2n26Vgh
 FI7UGg8QWsVnVXU+YE10Dk8TXnWlHcZlVWB0afS+WDF9iqoCRpDDFQG5Ud2r1nigIGHz
 z7dJV/SYeDDR6IW5goH9Ws2iLk0qobnZDMrZfLt+ENi0dHmE+LCGxojul26rVXXMpN1p
 t1JQ==
X-Gm-Message-State: AOJu0Yxf8Er1Q2KMncBGFnO6CjzH51AWnMJoXWub5qssMFhc/33ARYQJ
 wjPKD6c9hutzAAGrhXGukKjeRsCcOJpxJgJnLHjgUKo2Mu5O0cwOOGMulDZqOv1NNNwLhRq7oMd
 6lzcGfx7tB7QMglepPfo+wjN6Ke74xmWno4KxJDnXRJseGkx92PsQkIw0nwob87Jb7oLWma2XfX
 thk4K4aRo/WyDqPXSkTD3UyzGZFAw=
X-Received: by 2002:a05:6000:20ca:b0:381:f587:40c4 with SMTP id
 ffacd0b85a97d-381f5874181mr8425816f8f.21.1731389307452; 
 Mon, 11 Nov 2024 21:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvduCeEM6H3Xv8sqcar/W9cpltePWSjgdoTMg2x0SQriWnFg2LX7BpMb1u6AdN7euOGvwBxByYolIx6neSc24=
X-Received: by 2002:a05:6000:20ca:b0:381:f587:40c4 with SMTP id
 ffacd0b85a97d-381f5874181mr8425810f8f.21.1731389307098; Mon, 11 Nov 2024
 21:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-6-pbonzini@redhat.com>
 <SY0P300MB1026324D1571BBD2E001536695592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB1026324D1571BBD2E001536695592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Nov 2024 06:28:14 +0100
Message-ID: <CABgObfZUURf_QpdtqzmGF567Uk8obxdQ1P_WeVN1Ag=uG+J46A@mail.gmail.com>
Subject: Re: [RFC PATCH 05/11] rust: cargo: store desired warning levels in
 workspace Cargo.toml
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>, "Wolf,
 Kevin" <kwolf@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nondevel.org
Content-Type: multipart/alternative; boundary="0000000000009e35230626b07c3a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000009e35230626b07c3a
Content-Type: text/plain; charset="UTF-8"

Il mar 12 nov 2024, 04:17 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

> Making a universal unexpected_cfgs apply to the whole workspace may lead
> to a lengthy cfg list when more devices in Rust are added. As cargo does
> not allow overriding workspace-defined lints once inherited, I think it
> better to keep unexpected_cfgs crate-specific.
>

Is it possible? I thought you cannot override at a finer granularity once
you have a "workspace = true" line.

Based on the experience with C we shouldn't have many cfgs, but if it's
possible I would definitely make unexpected_cfgs specific to qemu-api.

Paolo

> --
> Best Regards
> Junjie Mao
>
>

--0000000000009e35230626b07c3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 12 nov 2024, 04:17 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Making a universal =
unexpected_cfgs apply to the whole workspace may lead<br>
to a lengthy cfg list when more devices in Rust are added. As cargo does<br=
>
not allow overriding workspace-defined lints once inherited, I think it<br>
better to keep unexpected_cfgs crate-specific.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Is it possible? I thought you=
 cannot override at a finer granularity once you have a &quot;workspace =3D=
 true&quot; line.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Based =
on the experience with C we shouldn&#39;t have many cfgs, but if it&#39;s p=
ossible I would definitely make unexpected_cfgs specific to qemu-api.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
</blockquote></div></div></div>

--0000000000009e35230626b07c3a--


