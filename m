Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6FCC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1retm3-0007eV-Ph; Tue, 27 Feb 2024 04:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1retm0-0007dZ-MK; Tue, 27 Feb 2024 04:29:16 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1retlv-0005qK-SO; Tue, 27 Feb 2024 04:29:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc139ed11fso27719295ad.0; 
 Tue, 27 Feb 2024 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709026149; x=1709630949; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWTgJRYgvI21lPpMuFeQfi7lJtJQ/o0xx5pPPjByJQc=;
 b=CSQHjU2FCoaSnQZ0IoStwlT+h5UsBLqkPRt3fCifGh/LI2aM00WcahIIEu8Gynlvb1
 ycCK3PoAQC6zkgstcEe14oZlRKxhrmZ3veEuPSTPDYtmWTT9uQOjR5YLon71m+0ba0RK
 n1R+MkYwV4FWUuISGV8HbiqtARh0/QOXomiC81r63v58EfSfpDG1EQyH5JsIj22sK0ea
 pwFAbSkpU7GMHkdjlxd08Q/C2A/sn3oKpgmzVlI2VocnM5tUW5yd/ssfK5ls0RQiITkx
 G639XEWOO1taBUB1ZAzEr3sf8ecgwrqykY2Y2/TtpEXN8Ca2Cs805Af7VFMuBI1V/SlF
 29bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709026149; x=1709630949;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yWTgJRYgvI21lPpMuFeQfi7lJtJQ/o0xx5pPPjByJQc=;
 b=d3g2ZgVG1TTp9+zDKE0IxNnoPqBCx+4LmJ/D7/NM6W8JKblcbq/JRbb81rLuNhqFnd
 s9IpEh3iLQ+4XVel2CMgNnyF1PCGH6VCMqvzU4BzikYMCqLAWjzA5NnUr6A78160w4+T
 Kn9JKX6ndMijW0aEK9ApcmW3vqunFFuRpcRylyMtOwfx0+B2UwoH3/gKgdNyarq+sGPh
 XWYEk2hkmfxh60gKIK8HsSvmbtYAKW4mDmzOeMCRXPqVwq5fSxnyZJUJn7rUYw5yQWjd
 pB1u0mWwu3/iBP/BCgedUZbUyR3Ejum+Ytocw+LFenCfosXHJ7xn0QaakjOn/+2WST5C
 WX9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKpsENIJ2vTYbRD63/2u8iJnj34oBD0rWrnxzWX+hgWPhZSHz6r7EtIU2N0ak9tWBM3zgv0q6uDaRI8BMujLCIYyQUe6lus2fH8GHvhyhwTNV8/EGRnaRGulI=
X-Gm-Message-State: AOJu0YzL2AW/1LXrJf9h2Xup5Qd6ckrngw0+iwlf/axpzcGmhF1pTTlY
 hsOttsfyJpHDsd20sAsPAzk/P4CGLphKi+6LqYwPYIJSlQWXuSCv
X-Google-Smtp-Source: AGHT+IER7BFh/bAvVKOvZHRMFPRdg2Cz/UeMV/ioREcxJ/HwQOQ/t+7Tf67gkVBQaZ4jGKeULMOn+A==
X-Received: by 2002:a17:903:191:b0:1dc:b323:6f97 with SMTP id
 z17-20020a170903019100b001dcb3236f97mr3718232plg.27.1709026148501; 
 Tue, 27 Feb 2024 01:29:08 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 v14-20020a1709028d8e00b001db81640315sm1085653plo.91.2024.02.27.01.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 01:29:08 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 19:29:01 +1000
Message-Id: <CZFR7EN29EWC.EK4AP0CCTQJI@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 05/15] spapr: nested: Document Nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-6-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-6-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Feb 20, 2024 at 6:35 PM AEST, Harsh Prateek Bora wrote:
> Adding initial documentation about Nested PAPR API to describe the set
> of APIs and its usage. Also talks about the Guest State Buffer elements
> and it's format which is used between L0/L1 to communicate L2 state.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

v2 is upstream in Linux now, I suppose you could reference that too?

Otherwise looks okay

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  docs/devel/nested-papr.txt | 514 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 514 insertions(+)
>  create mode 100644 docs/devel/nested-papr.txt

