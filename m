Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD19607673B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A6uaFcQc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDv-0003Yc-RG; Mon, 02 Nov 2026 09:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNtDQ-0003K6-Lw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:56 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNtDM-00008O-15
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:50 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c445c95d553so415464966b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 06:40:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793630446; cv=none;
 d=google.com; s=arc-20260327;
 b=HIt2WG+7asODz3iMXM6CW70TojA57IhC7YMJv7BuzLqATGA7s3RQOEzEgQbxYj36Se
 nTnxibbqQW8i5DJWO8aqeRF/81S+3b6JebcH2A+o19zipzO95WTpXPPfJVK7bB7VwDJD
 GtsqQY9QV8DwOEkkrZiC8iotpgIm+BlFqHVCSFg8xAototzSQdTt7aCDFFBsPqgTaM7p
 nZEuhq/YqXeQUq87AqPquPO5Cgtp+BlWvdgHWy270wPjtnVNqrRkvj1pZTNIF+QsVWJY
 QMHEkRbnbpFRNEuXDQPMfBOxJ78+Z2ABN9C/+gBr44ee4wXZ/Rr6h2r6ZGdl4gU7Oqwd
 ntdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=omGRZXLUsry+Yrt+trQcYtpE2GnV1tmkcw9KsTB9Gbo=;
 fh=4sbipowM06A2rl5+LJZRkzpBD7npyvc47QuPcga0ZdE=;
 b=D/gUhISaS6ySIk6ZCV97cWzchsimV2/T/xqM44XQL6nAJcZbjSoIJThqDRpv9RmY/N
 PhfufCJ6dnNoZ0pG/8mjbtTT0sKaeIi0sIOzEaMabnC415OSyvaokBhw3o6v/j8Eyupl
 lKPexW6f5Z4L+alC5gE760jDjPfWO/Rf26XiibJtRFj+fqKdevyq0jQkm7n9dD5HPXSr
 0SCcVGQ5cTL1DiAHCb6ikTlT1irs1yZM3RLvJy65Ov4E+JIbU5UmW6DmNyZXQEW7z8yM
 wi4gXxu+ZUFtqbqJg26B5Jg7Z0mJ6DVAJm+zMv5G3l//t8UqhgAcop1DZvfs+s4F62xZ
 BVew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793630446; x=1794235246; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=omGRZXLUsry+Yrt+trQcYtpE2GnV1tmkcw9KsTB9Gbo=;
 b=A6uaFcQc9Qve+xKq081dgF1EOwtoG8vILFqw0ilfUvX85TCMfCl/BYKkyvaBhKdBlg
 Tu26n8LNZB7fWqQ4OdKzQgncdY0BItHiVIYJYOKmLy5nL4Tg8PFqRgdrVUSIT5U9aGBY
 /DjdRPl0dsR9mZRXd1AlQ5tkEvnqbAtvni+53yjB6rNDx3HyX84+o9G0PgijIB8m2Pdc
 cI7+zyyZqiLk9YKBNrJUbn52ZSpDIRGG9Tg2er9J0RlrK/ox9cLTrZw3odoNkjmqiysV
 bFmgSVztMqMaFACapWQbPbtxOUauxKlSW65TPk0sFHv9jW1wu3bdOy1KWjaQHoUK2QRx
 SFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630446; x=1794235246;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=omGRZXLUsry+Yrt+trQcYtpE2GnV1tmkcw9KsTB9Gbo=;
 b=buu1llqK3E7kk7ExamC3/WNFWi3N6Gdn/bT0ayPlHePmTV/Ma3EBvjoRiU0mldP+k6
 q9my1n+Xz1H4OfvFSunEmDPf9BNpc20dl9aiTwXi06ZEm1pObTY/jG9ZxEa8TPp1NCnN
 WrDHgciIifNVcEPXTTaYlJOM+sWyfl9tDNy6nV2/ggZDcOzZ08UiVnpvNqGPh0ljzWtZ
 31V3gTQ4pe6xSFyfyxtmvq7nXCjbXduiEqtSWTDPUXru0Oce3WUi1yNa1wvQxvL/i1K/
 D3wLc1d2WdyYJoBg81AEWEP+MRyq5Go114tdFJgYWQ14pxV1fNpeOFKQymV4CWfl/ZCI
 x+LA==
X-Gm-Message-State: APuU4Z/rDgO8aDFrQ3u3nfF8fhfI4pWN58Dps/EP8PC0ij55555JPzJN
 avepPluuhKG9CfAh6CY6iWqhdF8WN4e+wMU3T46SX1ndidEZQiHoMQjwnV+HL78eumWGB0tl9mi
 NGk2F1asTDMLErAGbUjjy9EPoks1s21Y8oi0tVmljzQ==
X-Gm-Gg: AYBFou0vBvY+lVKzIapxbjTZIeVgZU2BedSJ+sk5qSFudDGrrJ+mF9dJpz/21KR4/kX
 ej2Y8pX4AQ/awzm4GJQirdkYa3Eq6FM8KnH0AAaLSbtItGDi93HGBTw3LsFKZEfsU8HTtDrCZae
 8OOpwJiRCZOHBhiW7rMrzS+1CxqCJm+M/INYd9eDNDmu25b6Ly22CThRaY8Es/7nXAcB5AsRITX
 c5S+SYLobjBjbFR9XvViiLAYkXB2ejNb9gGGfKq+kXCAx51oJIu+k8XaRYskr4SccqeokgCcKHy
 BRljVVC0TCgshUD1vvPgsriJxInOds5c1jOq0feyRE9dl4XQojZu8FloWznI1p7gj9z3MPraPGV
 IjNiIVFvcuvKPiD5bNOidCNrkbYj0tzyojKveboyX4Ol27EAu/42Yz4ISnFl9wdkK3TWNYwEYOg
 tSum4wVIk4lcqFrbkoXkZc
X-Received: by 2002:a17:907:fdcb:b0:c27:420b:7c79 with SMTP id
 a640c23a62f3a-c4ca7af1d9emr814258966b.48.1793630446144; Mon, 02 Nov 2026
 06:40:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030131554.41208-1-richard.henderson@linaro.org>
 <20261030131554.41208-14-richard.henderson@linaro.org>
 <CAFEAcA-Bb0PrHh4MCiWt8QZSAm-o=9ENiP-EBBVDrfU5WQCHAw@mail.gmail.com>
 <9463f02a-1d1a-407c-87cf-4dd8f8d00a4c@linaro.org>
In-Reply-To: <9463f02a-1d1a-407c-87cf-4dd8f8d00a4c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 14:40:33 +0000
X-Gm-Features: AclHuK8MQF10NPVb4qKzNT9E-x18uNElCEKG708VimGJjcu8F8_aX1yscAd5sRo
Message-ID: <CAFEAcA-XsHfHp8konU0XAxtTzw59i8A9n8Q1c-N=qJDjZV-fsw@mail.gmail.com>
Subject: Re: [PULL 13/19] tcg/x86_64: Introduce TCG_REG_NONE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 1 Nov 2026 at 15:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/1/26 03:30, Peter Maydell wrote:
> > On Fri, 30 Oct 2026 at 13:18, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Rather than hard-code -1, or compare < 0, use something
> >> more descriptive.  This also allows more use of TCGReg.
> >>
> >> Reviewed-by: Matt Turner <mattst88@gmail.com>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> >>   typedef enum {
> >> +    TCG_REG_NONE = -1,
> >>       TCG_REG_EAX = 0,
> >>       TCG_REG_ECX,
> >>       TCG_REG_EDX,
> >
> > This has resulted in Coverity producing a set of new complaints
> > (CID 1689946, 1689949, 1689951, 1689952, 1689953, 1689954,
> > 1689955), because it now assumes that variables of type TCGReg
> > can be -1, and that therefore code like:
> >
> >                  TCGReg reg = order[i];
> >                  if (tcg_regset_test_reg(set, reg)) {
> > (from tcg_reg_alloc_pair(), but the others are similar)
> >
> > might be buggy, because it hands a TCGReg to tcg_regset_test_reg(),
> > which uses it as a shift count without checking for the -1
> > possibility (which would be UB if it happened).
> >
> > Should we just mark all these as false-positives, or is it
> > worth maybe having operations that work on a TCGReg but
> > don't expect TCG_REG_NONE add assertions against that ?
> Ug.  I didn't want to have to add that many assertions.
> Maybe I should revert the few places that require -1 to int.
> Maybe I should use something other than -1.
>
> Perhaps all false positives for now?  If I adjust anything later, it'll
> refresh itself anyway.

I've marked them as false positives for the moment.

Incidentally, s390x uses 0 for TCG_REG_NONE, but that seems
to be because the instruction set really does have "0 in
register field means no register" in some places.

-- PMM

