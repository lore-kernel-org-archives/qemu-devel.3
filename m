Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D09C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvON-000856-E0; Fri, 01 Aug 2025 15:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhthV-00036O-Ra
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:37:51 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhthT-00056Y-Ob
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:37:49 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71840959355so24849147b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069866; x=1754674666; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nDys9mqDbM7TTMlRpWcdwDT7wcX4XInRRFZ8zD4NRl4=;
 b=L9KDN7aImL+px6LrZ65SQp9P4wCp4jq9Pv9p+LKdcnXfC4fMbK4VThRNgMklg8I9VX
 XyF0/TyHoa65oUJDX2AqrX755tVUZ0i55PAj9//wG27oObA1rehFqgg7PnvvwkA2crh/
 Aq5z8HRv235L4P+mhPCLJv7R53w4mfqHUn9W1d18bUt7Q1HKD2ceq0xWL3szGoPS8K98
 hmcIwIJOKvQZKJyHOBMR5yW8xnuD+oFnH0/wCckbdUPLQd2JQd5R6akabM1fAP/ouaLW
 9P+lwfsMQp9ZHCeeyBq11nQSOhV+ck4qnD94DRNMaw/cG09R/9ta0TRrgmbPyttspcmV
 pxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069866; x=1754674666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nDys9mqDbM7TTMlRpWcdwDT7wcX4XInRRFZ8zD4NRl4=;
 b=S0zFcHKuKaOpj6wyqkEaAJBY6nFYSl9mufHLvHZ+Sr7QoCci2JqMxSoBeI5Yu7SXe9
 Y91+G9h1PSI71fL56e4LNLzWp2HKG7vb9ecbPJeFG0TqKrCVoiBK4xbzEEVBXNihiwjb
 GvQlxTs+adU7OWGAYmnTIDgTnzAULlLIpTt4CzgAmYRZFBurCFMN8QCRZZR2+KMSe6X9
 wHj4x6zcLGXSgMyl1T5sIvLvE3KKJQVuShjFEpjNjgnZFCND7rZfjOmj+ZxBclSSKIgG
 bEX2+x63vo3n9xXv5jP905w4cx7zPd81afsXpP+mATJaTCsnvN0dsXJDSrORAJ4VL0mc
 X9Sw==
X-Gm-Message-State: AOJu0YzCqdRrFTKOm6f9ygBNYoE4F1dflEGiOuh0QV+a2MmSRrayNnac
 +u3xiIhDX3AGbn125QGclsgFmtVLpt2K1BBuwRYjptFMegqfpKUUROFRZb+mMg9kxEDQFys166U
 by0+ufVAihza0HNLJym/PS1gRjxiO6f572LObFSEBNA==
X-Gm-Gg: ASbGnct6cDRFrphCIC1X+hABkUrDqW+/9Rs0WUybmPOwzuknmxGIz0m26PuamcEaEgN
 EQdA5ND/oZF79CTNJVLh+9h7x3ykUhZYCJQ2iwrDoOM/98U4h7R0KNnNMWPOsV3Z/XqW1nu+MKO
 8J9j/58D5LFDbQbzTNbR2qMm6G6i3q9gqjpztXjoI9lYXA021qvCDRi2ytXj/G8o7SVkv15PSXG
 MHHPPML
X-Google-Smtp-Source: AGHT+IGq5oXlpmOO0dfkwhkw+RiBUKpvAb46B1UAc5FSm9skR7GFSVrfFvOiwjGKLtwQbTpfePR9+3pw9G8yT5zcQNs=
X-Received: by 2002:a05:690c:300e:b0:71a:1dc1:b485 with SMTP id
 00721157ae682-71b7f0a644dmr6452787b3.20.1754069865982; Fri, 01 Aug 2025
 10:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-41-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:37:34 +0100
X-Gm-Features: Ac12FXx0bHlkSpeJMkuNRo2TAH3JXWLsRjSXwlm_pSmqWnrpoxlu5Qp9bfA9V6w
Message-ID: <CAFEAcA_bDTExL8P11_NbyHHqRLjgjeqZwHUKTRGHmGr8pQVT_A@mail.gmail.com>
Subject: Re: [PATCH 40/89] linux-user: Remove do_init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 30 Jul 2025 at 01:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All targets have been converted, so we can call init_main_thread
> directly.  Remove do_init_main_thread and HAVE_INIT_MAIN_THREAD.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

