Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C68C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 06:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFFI-0003F1-PY; Mon, 15 Jul 2024 02:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTFFA-0002us-1N; Mon, 15 Jul 2024 02:31:30 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTFF8-0000IL-FZ; Mon, 15 Jul 2024 02:31:27 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso2342655a12.0; 
 Sun, 14 Jul 2024 23:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721025083; x=1721629883; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVRZB5WwE5p0SELqCmw/YkHNB16dGeg/n+sVn1d43PI=;
 b=mjW8Rg6mIJ0uf6OPGzaTQm8Tqs/4MN+0hwH4DPOAUXoXYtnq+PnC94+ZgGD+wQY8pC
 ikLWSsppf2XJAq4v46DtyxlQiK1Mdz1JSHTLtz4j8GBLU/PXLkQslkKfgKgF3RnPGJo+
 Dw9ZFiuc7Lj8KEWt8yh/BppbGyGZ0snRlulGgaNsU+EMHKmqtV3MlZnQG63V9wFeFJYr
 X4uSYp3sKYuNKExicb+2/v7DXmLweZoiSGCK/r4syDU14Rb5MUVGV3J19TsV2E8qV+AA
 QuWQMOIT9H0MVvCTpuRztnLgNJSrR3rI6of/N8/MUk5vLqhpuuPxJwCHXbaxvUeANxCm
 lOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721025083; x=1721629883;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qVRZB5WwE5p0SELqCmw/YkHNB16dGeg/n+sVn1d43PI=;
 b=hZS7SffQec9akLknYj28l9Vp9PTsAfFLceQ2Ficc10YkQnAYKSVdd1Tyey628xF9ut
 DXlzZ1FKF535lCy7ELmeWH8ca7G4Uq+WG6gwcbVLRMv/Hh+a8BivWFqd8O/WmKzWnbKi
 kx147VkoJHoA+pdsJpocW+wOwt9WKub1TL8X61Pmllnx7ZwUVQ4z4wTeasasN7BaXfl+
 q+SrgWS3Fe4Xcdcl5lHAMzcysgEeZAWUh9rpid2pG20zuhTqtIqJTSUhA/6MQiNEbKpP
 Z55WUJHdUx9z2OxZFzG2TltCEidtcJpDxPwgWPDDTnAu0OBje7CwEJtnevfydQVUuQVT
 F5cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbia6VVHaEdg4XHuL9i8de4MmUDPYLnE19lw1FceLVEQYWXKKccCfPlPnDXeUL+X6b+QAW2SW+Xc9ajzVH9urq1uSON5pxBc9QJtsM3Tl7aZuwH6zfM5gNPoU=
X-Gm-Message-State: AOJu0Yysh/MSV98aGW1M4bUgcpuMrLrITQChsqvDefpFRk0sDECmPLLt
 b5eLO5anmrKTzQH4NlU4aHz22KxDxPCL5Kbk/8zBKYosKYBpEbTb
X-Google-Smtp-Source: AGHT+IFCGHLGmIkF3tRyQX2jaALQ9tXnhmW1KIA5Oud+LnX9kXPQyLP4plo0Yq6RSo5a70CYDJ3RCw==
X-Received: by 2002:a05:6a20:918c:b0:1bf:70c:b542 with SMTP id
 adf61e73a8af0-1c2984cab89mr23811229637.43.1721025083273; 
 Sun, 14 Jul 2024 23:31:23 -0700 (PDT)
Received: from localhost ([1.146.120.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caedbfad6asm3543936a91.15.2024.07.14.23.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 23:31:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 16:31:17 +1000
Message-Id: <D2PWH1VZ9PO2.32WUGZQK6YD2U@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 10/19] ppc/pnv: Add a big-core mode that joins two
 regular cores
X-Mailer: aerc 0.17.0
References: <20240712120247.477133-1-npiggin@gmail.com>
 <20240712120247.477133-11-npiggin@gmail.com>
 <4f0e918b-336f-4423-bc48-25607662eabc@kaod.org>
In-Reply-To: <4f0e918b-336f-4423-bc48-25607662eabc@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat Jul 13, 2024 at 5:19 PM AEST, C=C3=A9dric Le Goater wrote:
> On 7/12/24 14:02, Nicholas Piggin wrote:
> > POWER9 and POWER10 machines come in two variants, big-core and
> > small-core. Big-core machines are SMT8 from software's point of view,
> > but the low level platform topology ("xscom registers and pervasive
> > addressing"), these look more like a pair of small cores ganged
> > together.
> >=20
> > Presently the way this is modelled is to create one SMT8 PnvCore and ad=
d
> > special cases to xscom and pervasive for big-core mode that tries to
> > split this into two small cores, but this is becoming too complicated t=
o
> > manage.
> >=20
> > A better approach is to create 2 core structures and ganging them
> > together to look like an SMT8 core in TCG. Then the xscom and pervasive
> > models mostly do not need to differentiate big and small core modes.
> >=20
> > This change adds initial mode bits and QEMU topology handling to
> > split SMT8 cores into 2xSMT4 cores.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
>
> Looks good. See some proposal below,

[snip]

All make sense, thank you will do.

Thnaks,
Nick

