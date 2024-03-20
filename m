Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E106FC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvhF-0005C0-Va; Wed, 20 Mar 2024 09:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmvhD-0005AW-Ie
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:09:31 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmvhA-00071p-U7
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:09:31 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5688eaf1165so9750368a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710940167; x=1711544967; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRraJwP29+saB9sTWcZU+jSEmRlRY/GgiHVYDTj8WfM=;
 b=Rcj9gXMcUKTRKosMal3h4KcB9GrH4Hdk1IgdQhYZg+J6khBI42v3Um1+vQ4KrCShcn
 3P45MzhqYby5vN7yS6+F+3UmfTwiYVjB9Rl2nlPR88k8+zRSaCevYLggEj7/bmcfasHK
 uSMDtLN/1QcUQjBjLl5QRE188/71hMwsxTsPSwIkMLWkBREWDogd+Rdl9aYVlhGKkABK
 Pf6SroLjFaId/8Kd9Y7kxt0nHg14B8Kf5DoGlrEXar7I8Gt1ijRjwO7tPxZj4KvT8CYf
 76F0Ph9P6KUyv8ebdxN5cSrTXhux+BZ0jcMrPVVt/lXSvqfYOoynydvEWf8BxNlrbdtH
 bYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710940167; x=1711544967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRraJwP29+saB9sTWcZU+jSEmRlRY/GgiHVYDTj8WfM=;
 b=eq/boLWlcsPiTsOTDUyqXPt6z7QGXyBqtY2reaUItX0SvMBeTPJ/p2EwMKLoGRH3ec
 s8x8R67k9rUmIXbVsk+YUCicrn0EfTC1QiaFc39gjogN5ePqXJt9y9TNWwK4yGgfu4DQ
 Cpi7jJSJtPhZ7Or3IUZOSfnHKr0qJnIMHEI3pdj8BlyQjFcUf+cah1K8mD4Os4MpXFnI
 qsvZZjCGFMfsRn8f00QsG5jRlgn1qSwuwNMORcq4BpHgUSsGpnvoyWI6qKqpcevDtBZU
 Voyo5P7uYlghhXdHm4EQ594MNbkt02pBmMRWfsTxHiT/BTwku9ov06abnJi/FiswVoXx
 oPrQ==
X-Gm-Message-State: AOJu0YxlvmlZlec49dxsZLb2vUYsHMvlq4agOizKkivugex7X4OT/6aI
 XRNuf+N5famf/IhahMAWgVLQ+xKb7FR4wRzaqivL15x25fr3lIInzk/JKfi3PbfEitXK6rAPQ2Y
 0eIJj7ut5vXiYKcbtA0fJM27Fxwdbe7KsSPHB/Q==
X-Google-Smtp-Source: AGHT+IEVVoMrrMhoyvbMIB9gigmIoGH97vrcJ1vezQGQhbFeNENjkLST4/lbpk2hn7mDRsGlaqQgg73hKiSF8WXqmk4=
X-Received: by 2002:a05:6402:1588:b0:568:b41c:92aa with SMTP id
 ij8-20020a056402158800b00568b41c92aamr4680718edb.15.1710940167318; Wed, 20
 Mar 2024 06:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-2-philmd@linaro.org>
In-Reply-To: <20240220150833.13674-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 13:09:15 +0000
Message-ID: <CAFEAcA-eXk5OMXa+AgL8uzNp4KVvmOVdic6E_p3L+XLxvABdYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/nmi: Use object_child_foreach_recursive() in
 nmi_children()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 20 Feb 2024 at 15:08, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Replace object_child_foreach() and recursion by a single
> object_child_foreach_recursive() call.
> Propagate the returned value so callers can check it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

