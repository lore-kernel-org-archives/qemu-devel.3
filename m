Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE6606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c2IBzBxj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIrgM-0002xi-8x; Mon, 19 Oct 2026 14:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xIrgJ-0002wa-C0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:01:55 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xIrgH-0003pc-3t
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:01:54 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c423b145922so222211666b.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792432910; x=1793037710; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j0gFGrwsCvUI9JuPy7BKuyVfRsyT2ZCkzD/y1UF1gbs=;
 b=c2IBzBxjIRuR1eLxs+rLnyAp5F+xbUOZCWIOm2kCBuilcprrj5k3wZAoXs/j5oJC1j
 9NH77wgnIE6omKW/CLx/bFYaQrIAvdwBmUispH03oc4Rq5NIanD3rDxVKEx2yjzGEq0p
 6983ZRXFLsVzsIOkLnfQjO9tTpbePMoLJTPvVoYaP7FfS51zqshxzv7PUUWalFL1TZg4
 8aRz+SLGEKWw/EGpZnDJZeUYNdMOYVHkNVQVso2lJWQ2Nbhk4nusM2srCGpuMLs1EigR
 ktoIJszu6RmTqXxf4z3OLoW0SRKrQLPFfY6sXuE/gQlx7SFJ+DaHqBZbrWS9zJRr+1p/
 Wbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792432910; x=1793037710;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j0gFGrwsCvUI9JuPy7BKuyVfRsyT2ZCkzD/y1UF1gbs=;
 b=X+3Qc7+f0VcRtxVGLtnsCwGe4HkwYHiYXXcvgPE6fyAq9wDaMaeWv2tTw1m5XVp7Wu
 pcUPoMfo0Nba7evHnC0omB/2YgjYsY88sLolV4DYwfwMTI3LcyCenIt24b5Fwpommoj/
 7yMCId+zcLkWxUPhaU5CEglOJMqDDH9P+1rjV9ZIDXv9ihKo6C8N8ewiLxYyDzbO4ia+
 U2IUBDk1oWoocpj3a60ZH8qLcAMyzTGDshwkRypszXG3CV8g3WlmeU59CJDQNE5+3uHX
 wXse5+oCtCF8kW3ofucDhuQx/9eL82i6/lWEok1Dhc/ubrvrk8EYtjkSixJ08oP35VKF
 eSSA==
X-Gm-Message-State: AFq9FYL49r5fiz3gp0rEOkKB7+t63YLcANiAbVIB8RU3+BiBlQnTHMpm
 ejW+ct7MxCF96KYUJmjqWVN5ULWC1vrnN9Xgq4O4rs0F5AClrSAuS2vy
X-Gm-Gg: AYBFou1rDFCgqYX2d6TfWDWSh/6obwjDlIVbNHmiawSzX5wUG9/rWPR7DTy75mqz+ap
 VsNOnYpvFu03bsU8uM4hv68W8jZDArqmBY2w0y5gLxgON4+jEYTgPPcQux2ZoscPT1pPBrOk79X
 skQ3u+xIDpVq4G/HlvWLKlTz9pibe0t9zonArqO3QF/qm6PhkYXcTCfb4OktzZAL92chTKh9eSr
 XpIp43N5v1XwnH2p+JJHGeHz2dIuGSXICa5CEkTVb0hYPyzKUlwdHdZGBol0FB4Brx76tDb2oQi
 Q79/XQaigr+ti0vd+b0XwNx0EcjFIz8Czn5kOgiLlQZ9FAcVjQLND6ovKHA6vjA/hI00NwC9IzT
 +tuAd6suiSA3znZHGAwiYPwl32pwAr595F78n8Rwj7D1nCaoFCS2/O0GHI+2Nup8hMnxkNE64/w
 bvlKMkFPDRZ1/19TdWgaUyQb24mX9VRyizxHPnsWDvFon3qzkmR8AN8wQ7TZ9vr7ynXpcV3+UW+
 QsqKRpfvSyyP2MnTFnQ1sPO/k9zb6ZT3UUSHNzL9N4Mrox4E5c3Ji2MUgtt5RXjhaiUnst3
X-Received: by 2002:a17:907:d643:b0:c2e:7da8:f54f with SMTP id
 a640c23a62f3a-c419f80267amr630196366b.38.1792432909583; 
 Mon, 19 Oct 2026 11:01:49 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4091eb2f8asm395173266b.72.2026.10.19.11.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:01:47 -0700 (PDT)
Date: Mon, 19 Oct 2026 20:01:26 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Alex Samorukov <samm@net-art.cz>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] qga: set FreeBSD virtio-serial channel to raw mode
Message-ID: <atZa9uV7Xxdmgn-R@tulp>
References: <20261017201905.12211-1-samm@net-art.cz> <atUGjXcdSBqQWAIx@tulp>
 <8b44d41b-4f0b-4346-837a-243a77734463@net-art.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b44d41b-4f0b-4346-837a-243a77734463@net-art.cz>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Alex Samorukov wrote:

> 
> On 18.10.2026 19:49, Roman Bogorodskiy wrote:
> > > 
> > Interestingly, the issue does not apply to libvirt (bhyve and qemu
> > drivers) talking to the guest agent, likely because libvirt terminates
> > guest agent commands with '\n'.
> > 
> > Either way, I have tested this change on:
> > 
> >   - FreeBSD 16-CURRENT amd64 guest under libvirt/qemu
> >   - FreeBSD 14.4 amd64 guest under libvirt/bhyve
> >   - FreeBSD 15.0 aarch64 guest under libvirt/bhyve
> > 
> > and did not notice any regressions.
> > 
> > Tested-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> 
> Thank you for testing, i was also curious how it was tested/working before,
> and now i know :) I found this when was troubleshooting why time in
> UTM/FreeBSD is always wrong.
> 
> Hopefully it will be committed soon.

FWIW, there's another issue I noticed with setting time which I tried to
address here: https://patchew.org/QEMU/20261015142342.50436-1-bogorodskiy@gmail.com/

