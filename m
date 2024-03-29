Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8BCCD128D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBdG-0005TS-DA; Fri, 29 Mar 2024 08:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <constantine.gavrilov@gmail.com>)
 id 1rq9u1-0005uQ-DA
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:56:05 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <constantine.gavrilov@gmail.com>)
 id 1rq9ty-0003QH-4K
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:56:03 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-515caffe2bcso1062838e87.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711709760; x=1712314560; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yctuxWyV9pvjkQ1TjtRgtXZ9ae/nJqoAOj6PDg31JE=;
 b=cSI48lXdrYFzns+giUaQIKID+DltL5pBJx3On6Wqei0z9HsK5lSMTUt7C4OehzJhnr
 YUy0dU6J38zpF5dCpdEqBQ6mnigcQXjMAm5Tgx66opalz07+oKu6RICro1p+LN5epuR4
 /X9RNYq8Fb7d991+VoWWXt2ivCtmCpZyziU60ixY26WJe5u2FVD9RK4ss01PI+FDy1XS
 I5jsu6QKpRMR2WgkspOuaJ8D+Lfhh1L5SfuosNZl5P6ZMTKHcuLW3D3EMOykNV73a2+H
 5yRJSMA7WtQOIXeai60X0zgyCVuOJ5j0/LODMIx1zWkvS4M8LEAsLlO2yYmDoT0y2WSP
 DQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711709760; x=1712314560;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yctuxWyV9pvjkQ1TjtRgtXZ9ae/nJqoAOj6PDg31JE=;
 b=bjJ7YP9tyZuiKwixBSb6NoWGyjWtrtWaAQovoX95/SgB1YT/QQ5B6dWfiCpOKCQoBQ
 5NzCrRfztGwbSEo8dAK//CVizWjxqXP6R04d/3s/6bMyvT+GUzbNJn9aORo5MU44+h0l
 hD6clAXN8xyeCSdtLptqntcKy5z9OW1Vb5iBvXVby0X4GHRB4AmegcpBY0lbIN8Xcds0
 QYhnkGWnHDy2loxWSjYuuRlVd9CBJYla+27jSYaUm1Sv9PADl8wPlFU+bAVnHq5Cbp+1
 Hh/bgn83SHVekCvhJ9Glv7SpOonko0vi2TAKousAbJ0yClsv6cZu3+5n/SymEfeFIj8u
 7PVg==
X-Gm-Message-State: AOJu0YzP+jjguyC5Zo/qUweMaowseGTV8TQ9AXqU+EsuavnVwzZ8Twqv
 Kg8ng/34uuIPuunozHRmzKPpZZ+jf4Ee4li1nJ025OT0nCcyvFJFcssazofoU0FF5zq/5QHpPSW
 19O5udfqdRfMs86Z5w+li2Zk0wZkJoMwy
X-Google-Smtp-Source: AGHT+IHnD1fHZ1Uu0k5F1fCrCss/S4axgDvaip/WIA3MIMDghIUsZRv+zF/4iCIEHON3ul68QP0XPY2vCCRJn91QEWg=
X-Received: by 2002:a19:6902:0:b0:513:d484:da51 with SMTP id
 e2-20020a196902000000b00513d484da51mr1328053lfc.65.1711709759580; Fri, 29 Mar
 2024 03:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAAL3td3sAwRv4AUZ0492wTVJ9qVUevM1FU2u_xxp93jCOi1K4g@mail.gmail.com>
In-Reply-To: <CAAL3td3sAwRv4AUZ0492wTVJ9qVUevM1FU2u_xxp93jCOi1K4g@mail.gmail.com>
From: Constantine Gavrilov <constantine.gavrilov@gmail.com>
Date: Fri, 29 Mar 2024 13:55:48 +0300
Message-ID: <CAAL3td3UQ37Sgkj5RtENvq6kWTs1iK+HqfoHF9d5KMLoyES83g@mail.gmail.com>
Subject: Re: QEMU NVMe Emulation does not seem to work without Shadow Buffers
 Config
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=constantine.gavrilov@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Mar 2024 08:46:51 -0400
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

Please ignore. The issue was on my side.

On Fri, Mar 29, 2024 at 1:07=E2=80=AFPM Constantine Gavrilov
<constantine.gavrilov@gmail.com> wrote:
>
> I am trying to write a custom NVMe driver and I tested it with QEMU
> NVMe emulation on Fedora 39.
> I have not tried to set shadow buffers, even though the controller
> reports such support.
> What I see is the following:
> 1. Only the first command in the Admin queue generates interrupt and
> completes (Identify Controller command).
> 2. Any subsequent command does not complete (no CQE even if polling
> CQ) and does not generate an interrupt.
>
> I have a suspicion that the implemented shadow buffers config support
> causes this behavior.
>
> Any ideas?
>
> --
> ----------------------------------------
> Constantine Gavrilov
> Systems Architect
> ----------------------------------------



--=20
----------------------------------------
Constantine Gavrilov
Systems Architect
----------------------------------------

