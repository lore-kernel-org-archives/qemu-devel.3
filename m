Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E85C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFt-000323-IJ; Thu, 28 Aug 2025 13:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure1M-0006nx-T7
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:54:37 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure1G-0002c2-B1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:54:35 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71e6f84b77eso7460357b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392867; x=1756997667; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JW2JnaFdjrTZzgzA/D58gJjllxVMbOErVtZmGYqnoU0=;
 b=zAZtuQy9PT3SBNd69YH4yjdBdDE3sGXOj7h3j69APkzdd+Xd6tJgwLuEmR6BwSKqA5
 CNSot2sXeHTqPJYM2YiNF3E0sxMo1BpDXpsW5+3CrJB8K8xNmMAa1p+pm12uH+Q5lCka
 Qiosh+zGC0rbyOAPIvMJD2wCeAey3BKNYj88eEreboh7M2MFL8ILMlK7UTK20N1aFjD1
 cUs8vgNMsmcTqwU/jvJOklf/B8ypchdoBYLQwWW4kPpxkGznYsB2rCtSUuHKyfamwS/Y
 98HhvDU3+K5S2DQ9uthW454eoWTVO1aCp0+kUJMELl/cR8t3IjWVvV6B/zlNJ3DMxQNn
 CtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392867; x=1756997667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JW2JnaFdjrTZzgzA/D58gJjllxVMbOErVtZmGYqnoU0=;
 b=m52xKfFMyiRuTAgEw4+4ghw//pnaQNVB6TamMtL11kjfPox4TrOVtDf2Lfch2Zz+2X
 9Cl5VcgAm+kcl6o3VIoXZl67BLCEYRMVdYTxESXEr6e+p1KF7jbsjGFX3MM33usqMF34
 lo4YU0kG0I2CTsbkbhPIi5nIvQ8MqEDAvsMm6zAJF02gjZVT0Hj4K6rm0rOLfDkaqvAj
 Q8fy4jZtTKo9KQKGZyuvcX5bherJUS3M8f03XnT1hjjSdbsqmDVKJYGbpY4kTDJUl09q
 eEf1Ig64isggz0LR/HkZH2w9IDhEpkl4gsNSwDKixonNiKtydVQ6yxLghCoOBRJpCgw3
 ryKA==
X-Gm-Message-State: AOJu0YyIBllN022TWY0LMrEcURfrCmYmJuuRA9t039TMPHyxpFZOX5Z4
 tcqaP270BH3qR84AtN2VYma+aGM6+bGriewXq8Nx/yRmNcDXGx9kQiLmgebr7dU1b/Rm87cWInd
 3mvhpl//Vv7l0Dc8sppIJ58I0w3XecmfG4+SViCj3LFz+oRL8pmG5
X-Gm-Gg: ASbGncvInt3z0z+Fb5IBIOexgo4usAzfxQ/FtmfbvOyKW3rRPEQxO47VgrAXT/HinON
 Tsn1pbg5s1C93uuT8ah9QA0cIE5J9KNQpzRF1ZB87CjjHQ9wbdviwDPq5+r8O2MSdYUglVGt4mk
 8Ps3Eh/SQnymSmIkeBbvPFVX8RxJdYdRpCL0uJq5NynJZH3VKtYwEcEwL7dLgchXZuKYQ/yXMhN
 d1MMtMyDAlwhCO1n8I=
X-Google-Smtp-Source: AGHT+IGy1U7O1trOADtqZZ4/GNP/EUTBOF0dbrSWiyh31ZJnrIkpbxOeQvdR+HZeop168EWeo3kNrZosgFY/yYtQvC4=
X-Received: by 2002:a05:690c:628a:b0:721:a4af:9ed8 with SMTP id
 00721157ae682-721a4afa039mr2626647b3.36.1756392866859; Thu, 28 Aug 2025
 07:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-44-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:54:15 +0100
X-Gm-Features: Ac12FXy5XcvW9xmJpNzwnwU3Xz_An5JcRe8kqM2jrWl2yjBwkoG0NAOSZt6krqo
Message-ID: <CAFEAcA_qvJ7WuTf_Vkxz1EEJ9DZ0Zw2Yit4TwOMAouJVVz=yog@mail.gmail.com>
Subject: Re: [PATCH v3 43/87] linux-user/microblaze: Fold target_pt_regs.r* to
 an array
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Separately enumerating all 32 registers is not helpful.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

