Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7877C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSpn-00079a-6A; Mon, 29 Jul 2024 12:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSpk-00071D-RZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:02:49 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSpj-0008EM-5Q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:02:48 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so5653959a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722268965; x=1722873765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7EoLioqNJ8qb9Tt0vLZUQEfqqg6erHdokc14VF5HS88=;
 b=YbREPQVSoheXmnaSzxk2oR/xgJ1nMICyKHEhbEhHLr5CjqekvP+sktqSoc8kWP3ZxC
 ZKbTfYT+GZ3X1LlDPX1l6LJEEPvj1iOlTfUgigQEgxc+dGD0JLGnjpNjmx3Thd8n4va4
 6GyH6mbxdIGUGAls+6qzLm4WOe2rVExM7r9+lPZlHuZ+7yQVhS++0vOA/QEXlSap5CMe
 A4BaTgH6bdxVZMyzuKP2PzfmWB0Jc6GTXqZo9i17VaEBKdQgqEQZeo2uitEvlkupkdeB
 OWlt2n4hHfSvlTuD6Yzx8jvfU62fhu/IX9yJn5Tuino4IEQu1Bae88aQEoqfgRM83+Nz
 x3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722268965; x=1722873765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7EoLioqNJ8qb9Tt0vLZUQEfqqg6erHdokc14VF5HS88=;
 b=T6zOiXzAh0Q53Y4j747MU2/krZQXK7PwD2VOZfUB1Ys/0em6yd6Rnus+DFD1fklLzK
 Cd4HoyDae8Ze50KXOyN616JSpMovGtLs2HzGDgKqPBMpblgUwdOIb2QFTNdC//GlTTDl
 7fLBjL0EwSxwWy4MXPi2VxE5fbwDd3XhqrHNGBqqr/bKPzbk1VXKI56UnRWlaR84r15O
 5E1VdMm4WKn8QVYmzGT2/plCRTocRCXldYyQXgTetIdEE8ENH2QcJ2EGwNOWeiHs12wn
 Y2AOWjZM0n21znantrArvIJnOcr36Lgg1tagCqzHBEhmF+1niaWyI06AeWQtp49sGN3a
 vvYg==
X-Gm-Message-State: AOJu0Yxj5NuE3rex/4r3Nf58gzMWbqsHSGM/xtzklD43e84zlCzI2kTf
 Bz5CdZ9dmiKS0n3Wsdk4fmlKeT96mBEE+b1XgGU/JAJztR3AKCbUpSz9gq9hZdk95N4IMnBNcPy
 Y8ChnhFeBtIbUWuqzRUY7EKAcxoLusHkhhhJ7KJ8CaBULgJAv
X-Google-Smtp-Source: AGHT+IEVkdIm1DDPnISggq+kTxuGQ5HqcX7937ItXM+05rJSGhR1FDlGy+5jtOnkLSnUOpAneCCkaWFJRUTa/bPRMUw=
X-Received: by 2002:a50:cd48:0:b0:57c:8027:534d with SMTP id
 4fb4d7f45d1cf-5b021f0d957mr5110556a12.27.1722268965236; Mon, 29 Jul 2024
 09:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240723162525.1585743-1-peter.maydell@linaro.org>
In-Reply-To: <20240723162525.1585743-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 17:02:34 +0100
Message-ID: <CAFEAcA9ou6z6UDaGTO_8T58bdC-LoNj2hqbu+YFLFO0pWqqJNg@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Remove dead assignment to ss in
 do_interrupt64()
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 23 Jul 2024 at 17:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Coverity points out that in do_interrupt64() in the "to inner
> privilege" codepath we set "ss = 0", but because we also set
> "new_stack = 1" there, later in the function we will always override
> that value of ss with "ss = 0 | dpl".
>
> Remove the unnecessary initialization of ss, which allows us to
> reduce the scope of the variable to only where it is used.  Borrow a
> comment from helper_lcall_protected() that explains what "0 | dpl"
> means here.
>
> Resolves: Coverity CID 1527395
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I'll take this via target-arm.next since I'm doing a pullreq
anyway, unless you'd prefer otherwise.

thanks
-- PMM

