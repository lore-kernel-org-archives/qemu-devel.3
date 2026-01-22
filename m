Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B315D3EE64
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viud4-0004Nj-Ct; Thu, 22 Jan 2026 08:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viucx-0004Mf-Lg
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:21:36 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viucw-0007EK-24
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:21:35 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7941578064bso6410357b3.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 05:21:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769088093; cv=none;
 d=google.com; s=arc-20240605;
 b=an0c5v4GqNQEYOOh/S73l8YIcot+RyKvQnBxRuDUGUsepg6ZayCH61pFddOx/p43o5
 1sDp1P69CH+jGazIiO16qqOoAqCQjIHsLSmIHWhp+kjy5SMvgE+c33vS4hqbC1fUD0AJ
 dhxQ3lBbCLAfzGaltCPU02G4KcCS3GKI9GRWpPEYhaMqAoPdji+4UIkJHDFGdOM4Akb9
 v5k38mte+gWldbShdoWm2+Ijh+qFFKuzGyrDMxWMm2qemLWs+XTpXmCtIMznMN2hVcaH
 qx1SimYx3vI3A14osZtAlGS4HJ4Q2+1ynSqJgzCXXZWhH5SpovGXeFz0Oui7gCCEY/Pc
 9EDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KnwO9NheAJh+DNaX5x09u2jznRhjsocyW+YOHcf5s1I=;
 fh=l34yKrB0yromHHDUji8ziQOfQo4HrJ0cM0LWNUDHuFA=;
 b=F90QOLgJvWJJEm2Qn9Fun0HgzdCEcTKJctMflgNXesvRwqdT5wUR0hSt73KierWPS4
 LMFLYEx/JI84ydAjh8f9JB3M5pJIRov/sQV18oPbE+zxj0I7TN/HsdWhW3psnbK4zcch
 Hl9rxpoDRnQtHmgC47ceDeduKpupjU7d73F7bxoOK/ruFUCCf/jQVGduxQU72fJHyD+x
 pvYzULQGnUpX3UYa8p6JrbdbSb9o9PwaUdd3E9nip1sPwi848OCH3v4Gh+MpXdAmFA5M
 ILHHGHHqOkzBMoEQtXb++BrTSylogJKWEqj+57yjbFFAdRySxuKJ3LilXIO6B5fxPddN
 0btQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769088093; x=1769692893; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KnwO9NheAJh+DNaX5x09u2jznRhjsocyW+YOHcf5s1I=;
 b=kHCsWlW1tyov46t7iFOZJC+tzE6+Mr/AG/gHZFyQZulrl7W7boPjCrBleo3oyPcXHO
 PcP1S9qb8x9t7W0pFFHbOyer2++H9wlDm6whwM+DJCtMqJ56n5a4eu3jFU0G7QLvoFq/
 hFL/oKv2HJjtqFL3W1z0aaPT2jGBfNziB2M3RSxjJ3j70Gw6CHbi+ugxVRvjppqTd7g3
 4EjXPHWC5RCwB9Ulk7WfeWmFxNB2EwVrl/h041+tiiKbYq/DlUgxx67Wp8rhiyFYHH+L
 99aYLpQfFcZjRB+UnTGvTz7mHapmYWJVR//OljVvr48WKe2fHy0HnJtaQAKCHxEjRo9R
 BpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769088093; x=1769692893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnwO9NheAJh+DNaX5x09u2jznRhjsocyW+YOHcf5s1I=;
 b=DfS/6UXmhZYLzWBiGJQpDQytbK25zIJpKpuqWLH4zAn7Cndf0Em4NGOKiaUGQfgIL3
 0TgVEGFLJIWBloQHhZSm7cOEBxiRdcGuFUIRd/qGv6MKrcF2N72TwTv7oKpWESrP9fXg
 dVU+CSFkiCfYktolYwuRl6ByKrG3un4UnxPhyXeqWKKujCfIn0RkbmIlT+qMjjQsjAiu
 iqqkBn57xFaA7p5vCX54/EqA7Ej9eknC7hwWzw6KwTJr9iTmkV9Tr677SBV24m/ktmIc
 ij5kPBnFCaoN5yQhpDIhkfR3EPIqiBfhC4QFiDosuP/3fqG3FOjj+KvIP0XBSk46K/27
 tSxg==
X-Gm-Message-State: AOJu0YwomEc0oVHabSVVlceOr8xQyodbJtTpzek0WhqhhtN7SnKH0POe
 JAtyQ3pI06csTr69D+W9YfOhYiDQLdP006EJehHM9D74hNxNF7nT8HqUOFZY7x+jlbpCl8OYiOb
 TjqiD8StEmbkp5oIVrj/C2iF6Cme3ma1m8gKOFV86rw==
X-Gm-Gg: AZuq6aLNqY+JO+eA70AZ2wmUjUfuutOsj9ndY/AR/PghfPeYeQViy7wZRM6lnEvmdgF
 jp0E7J5KzPWPzPIn2hJDdh8yunVtb3t+ci/cjmcY5lIos0F9vPgWAOdVIhvbhtWzSHhfITuZshT
 VEiHL2+BnfxqqzF1qazuD2N+BP8Yi20ixSi3wYTiGPwdBtg6tW0RvQysp8VyWtRpQxZzHI2RNaI
 InoX62UaNqCJ3pcHSP+3XYiU3Nxfw4XT+xel0k8YfzK4Kl414DO0bjIvHXQQdqXl1n9cw==
X-Received: by 2002:a05:690c:c4f1:b0:794:30a5:14d3 with SMTP id
 00721157ae682-79430a515c5mr9814377b3.42.1769088092578; Thu, 22 Jan 2026
 05:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20251223142959.1460293-1-peterx@redhat.com>
 <20251223142959.1460293-18-peterx@redhat.com>
In-Reply-To: <20251223142959.1460293-18-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 13:21:21 +0000
X-Gm-Features: AZwV_Qiuw-soIx2w07Sa4RFQixkh2SY7nEDVwVYOornHXgSwuZlI0Xuw66lBcr8
Message-ID: <CAFEAcA9aU2aYCi1R8VkZntDrat3620jbJoZQm76mciM9+7+DCw@mail.gmail.com>
Subject: Re: [PULL 17/31] migration: Add a qdev property for StrOrNull
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 23 Dec 2025 at 14:32, Peter Xu <peterx@redhat.com> wrote:
>
> From: Fabiano Rosas <farosas@suse.de>
>
> The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
> was done about eight years ago so the migration code could make use of
> qdev properties to define the defaults for the migration parameters
> and to be able to expose migration knobs for debugging via the
> '-global migration' command line option.
>
> Due to unrelated historical reasons, three of the migration parameters
> (TLS options) received different types when used via the
> query-migrate-parameters QMP command than with the
> migrate-set-parameters command. This has created a lot of duplication
> in the migration code and in the QAPI documentation because the whole
> of MigrationParameters had to be duplicated as well.
>
> The migration code is now being fixed to remove the duplication and
> for that to happen the offending fields need to be reconciled into a
> single type. The StrOrNull type is going to be used.
>
> To keep the command line compatibility, the parameters need to
> continue being exposed via qdev properties accessible from the command
> line. Introduce a qdev property StrOrNull just for that.
>
> Note that this code is being kept in migration/options.c as this
> version of StrOrNull doesn't need to handle QNULL because it was never
> a valid option in the previous command line, which took a string.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Acked-by: Peter Xu <peterx@redhat.com>
> Link: https://lore.kernel.org/r/20251215220041.12657-4-farosas@suse.de
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/options.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Hi; Coverity thinks there's a memory leak in this code
(CID 1643919). Now I know Coverity gets easily confused about
our visitor patterns, and I don't myself know the way they're
supposed to handle ownership of memory, so this should be
checked by somebody who does before adding any extra calls
to free. That said:

> +static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    const Property *prop = opaque;
> +    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
> +    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
> +
> +    /*
> +     * Only str to keep compatibility, QNULL was never used via
> +     * command line.
> +     */
> +    str_or_null->type = QTYPE_QSTRING;
> +    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
> +        return;

In this error-return code path, we don't seem to hand the
"str_or_null" pointer on to anybody, and we don't free it
either -- does this leak what we just allocated with g_new0() ?

> +    }
> +
> +    qapi_free_StrOrNull(*ptr);
> +    *ptr = str_or_null;
> +}

thanks
-- PMM

