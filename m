Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812BEC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7B88-0006yX-Cs; Thu, 17 Sep 2026 08:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cduragoKCjQijQdbUoZXkWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--stanleyjhu.bounces.google.com>)
 id 1x7B84-0006yI-Kx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:22:16 -0400
Received: from mail-pf1-x446.google.com ([2607:f8b0:4864:20::446])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cduragoKCjQijQdbUoZXkWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--stanleyjhu.bounces.google.com>)
 id 1x7B80-0006PD-SN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:22:15 -0400
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-86ab8302b54so1031206b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789647729; x=1790252529; darn=nongnu.org;
 h=content-type:cc:to:from:subject:date:message-id:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OQ0Z7zyl95y+acgYthVoHqLS+wCAOAkGRaBvQONRVrk=;
 b=E6wUglAv5A1T/B7ljFMcbLWEKMAfd2cqVOPb+k9Od5slYkb09VQXpMbjcZpXxdQxHr
 Z41miEmIWM6YjnB89Pw5pjk0Ca3oD0INxdKvDR598YiMTnIsG/EpLtFHLgQ3mgubsjEa
 mc3WnHux5dG10TOYmmhVU8pF4WNx0QQJfwitfUqk0jjl3V2vdF7U/APYwr16ZikOCYuL
 rHlB3pOyG/UxIp82t+jinbjzXDcXHDQZmAvvjyGzgiWnuixiyW18uZRQ70HGfebh1kkn
 yL91HJBqu4ne4UzXgDMJsqELTankshsynOvP+545U7CGPiI0W3hwPAkOqlTrZcRLQ+6j
 a6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789647729; x=1790252529;
 h=content-type:cc:to:from:subject:date:message-id:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OQ0Z7zyl95y+acgYthVoHqLS+wCAOAkGRaBvQONRVrk=;
 b=YRfzBB8/6RR8DEtsq7TepH9sL7Rd/wOtupW1yRtTIT2J3fedWcTDMirscvc5dyAMJs
 tlvRuirlXvRGQVe1mDGYkrYE71Hb96JrfjEWbpoCdZPXUrSePpAKJGKbgejXd4G+szGf
 aKw1F85BaBTb90CMw0O1/t+TIzjOoL9L0tBk+CU40eRC0fDcHyFBzRCckyjJxGcJhMmi
 OH+rRs80REHA7SKxJw4AJ8BJLQZyNlJm91YnhPn7eb3HinayBVpwXQDvBLUTe2tLUoQ7
 veJbh02y0TuP6XLZrVkJWjw/J4wXMuatBNZT2bOelc9rFYAk/QykOldZieHJCkCmfj7W
 ruxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByC5ckOhJuIn5CVADsFithrlNQ3XXc6gda4EOCAuQZUqLb43INQZymIjJVmt4ZDiPOD2ppOTMlBXHnj@nongnu.org
X-Gm-Message-State: AFuF++l9IZJc7g8fV+f+jTRAsvGVWYoxWEO+4nslEjbbf7DKlV2tNiN8
 Yx/bM86ypvMcwEkQAjXDftFbwCQFmUjrKcW/NKwLViCeAwwnCR95lsUu8GNIhHWfbIJwAbnbl/R
 mGmlPZGnIqHXC8huQICJVPg==
MIME-Version: 1.0
X-Received: from pfoo3.prod.google.com ([2002:a05:6a00:1a03:b0:86a:80f1:b64b])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:419a:b0:874:706d:962f with SMTP id
 d2e1a72fcca58-874706d99f4mr185007b3a.33.1789647729143; 
 Thu, 17 Sep 2026 05:22:09 -0700 (PDT)
In-Reply-To: <21bbbab6-192b-4243-980e-4167b450c478@gmail.com>
References: <20260902081610.2290123-1-stanleyjhu@google.com>
 <21bbbab6-192b-4243-980e-4167b450c478@gmail.com>
Message-ID: <18d61b20acd45382.3137322e31362e3131332e313435.ea6a.0000sendgmr@google.com>
Date: Thu, 17 Sep 2026 12:22:09 +0000
Subject: Re: [PATCH v3] hw/ufs: Reset controller and MCQ state on HCE
 transition to 0
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Received-SPF: pass client-ip=2607:f8b0:4864:20::446;
 envelope-from=3cduragoKCjQijQdbUoZXkWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x446.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 03, 2026 at 03:06:42PM +0900, Jeuk Kim wrote:
> Thank you for your contribution.

> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

Hi Jeuk, Stefan, and all,

Gentle ping on this patch. It has held Reviewed-by from Jeuk for two
weeks:
https://lore.kernel.org/qemu-devel/20260902081610.2290123-1-stanleyjhu@google.com/

Could this please be queued for the next UFS or block pull request?

Thanks,
Stanley

