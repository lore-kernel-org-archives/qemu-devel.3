Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC49606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HGXQr6NT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTcj-00051W-Np; Mon, 23 Nov 2026 07:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVTcR-0004oe-RJ
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:58:14 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVTcP-0001z3-Mt
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:58:03 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67db1f6f50eso3215881d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 04:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795438679; cv=none;
 d=google.com; s=arc-20260327;
 b=HgWfp7MYh0DC+TN67Rg2mHOCC8TmuRSQC9+4Aj82STAjI2ZNwFzGh/XnjSDe+y/vME
 jS02S+slaOb6kFKP8KvzI1bczETZyR7XDs9V1H3VlYum7lqOCpozHyec+JVwojLwAVqq
 CVF+TRocP+lOZ0C5VICiJXNS5ediuzu0Rx528pYBjLL10VhUVqDXl7ajOjG/FDjeDZOi
 x0SoacXhGEEcb04pAncYINry6cnmmUcsZVmTy29HUGOmvaP9pcZm4TGmdfA3Q9F+1xGB
 VmPOu9kWQ18b1Ere24vFy2QVk0dJkSH1JwTAhvd/938IjpOowWo9XzA/TKzG56DiviU7
 mYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hu8FUX0r6Y9mGgQ0uGQnmIafzGx4PfIxy1jeuo4gOag=;
 fh=Nyj5mLAoud3gyse5oLzxQm0hGPyn/u+0UAu+tL3LdIo=;
 b=bVuPl9z73Rcf+6L/WWJqohEXuZh2ddQuMugsYU6EFJZz/qtjE3Qp36/07GEofaZjsV
 LA+zYsjmSLq9DcNB+WFNvm37ijruKohTwU6Mqo1tqJ2t+zuJzpT48Wb5OqKVwiMzfZn4
 kVwKFLqjhkKUUSIS0FkBh5Ve3CDzaNTWOzyLj65yLvxiqIBbs26WgHR+DqcYqur4gzl4
 4KUeeWHuRDvqHIK7Lx+sB3eJ1VtgnLcy2wAHNtPi0ly8bkoNQZKtYwV0cki+Fillsc69
 eddWCOs9RrbIJUjSSGZbrBLTHS5lQB4SidHorSKIhqQukyjcIpFSnDwKibipQqNXcR4r
 D1+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795438679; x=1796043479; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Hu8FUX0r6Y9mGgQ0uGQnmIafzGx4PfIxy1jeuo4gOag=;
 b=HGXQr6NT5SYSMyc/3EG/ebabmYlEzzo+mUBygnxJmC2+Od5vwvLElv3faiFlGL80vV
 Gyas8WWkicy/R0nWzkU6h546B7AkQMmfF2LSXQq5io+EEmp8YKCidfLgFS0GDZPs0YfP
 SytvfB+nMhiR1Y/uhnZXfr/rdZ1d01YNe/kpTpk42WeCpZStaHONDcfbNsNf6Vr5gntF
 Ph6c/8IF2GSJr9oPU3Nbda66Ss2kxlMnNLMvWchU9VcAY9O/QMXQUOE0XVp8xRG4uZXy
 FyOTpBkNk2lK5qJgLWCjLaF84KHVTzsYG+iwRrWR7fM8hQFHce1JZu7b017E07RFVjHl
 my/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438679; x=1796043479;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hu8FUX0r6Y9mGgQ0uGQnmIafzGx4PfIxy1jeuo4gOag=;
 b=qiz9N7Vt3tCgun+o2QgO+jpzRDNyclEIcIRyDSx0dNPqXwqZV2y1QdGk+kwj9mz7J3
 KfIMDspYWRZN6i4xs82docVw5rMD2bOU1c90dsnhojTVJjfZ2E9Dv2VgIW2QMFR2AtVy
 MfRmq2TZxRFi4XEZds1FFwu9ri+5GZR2XeWJIqkVqgIqzmVahbx2/PIc5GYYQlQvgCZ1
 8bbyA9rhwgsOqF4ye0u4QVneg6xyH3TtChFBpo43yMGl0b7HXKTBVifr0+Ta7VnJepw5
 95ohfQrWqQE4iIZ77FMTH2GvVWfmSch0jb56RC4KJeKRkqGzx1q/YV9BfgjE6qE773Hw
 u4tw==
X-Forwarded-Encrypted: i=1;
 AL+hErGdGAAYxrqQP7OFNvJQOD/b32ex4nQI8vk49yViAFPIbBoSKIPJGd3LzZAMwJUi+lBNHrzeVnRFQsXX@nongnu.org
X-Gm-Message-State: APuU4Z9z4AhHfxQMdUDSFqX/6lhfDuv6eTlNugWPzJ4sME0W1inwhapJ
 hf6U5/FuV+M9a/x/Pn1x2bSXWjAoLpoaa80GoUdbwI9+7siPVOV+KN5sx1iRTP7FjwzUKzVnRPY
 +fc3qIbt/j9ZHHm+3ktrEf/V6BXMiMWGJhQRO/2/TWA==
X-Gm-Gg: AZFdTZf7aLoit3/HOWsLXlzaozER+/QWUJYMIvqpk5XVbU0iHeBDPYM/F7tV10O+S+n
 StgJ+dSO9VkGXYOLQNBTD5wfUYerMgXSOCK0KpD9ktF/YtNsXAHCyv8Xn3NPiJQjddHxVLNKoJO
 ZdN6f3KJOyNpJSDeh5O3UObVKtlpd/+otLu0F4IMjarb9U7Mcfa8JvLyHza2qR7Jqrz/RAaPE8c
 5FhOTKIT0F/Y6X9mePi15cwGQpSIzyFWT0DHLqlyYHQu/JkqfM9ljxS+TIzIz9SdsTJLqwa+Ala
 C5k8qeuPe+/r7PWzMvanvY3C223kWrMoWiMGvGylqdgCn5l2bP2CmhXXnrYqjkuCZ+jJrnzpLkp
 ivl7UuvNh0kdz/UHYvlqz5XYNEJV6hagja9sQDxZaluRjieOOKJufREd+YG6rGh4FebkIRM4Xce
 kv9AxQ8+QtQ47BAJHVAgE88g==
X-Received: by 2002:a05:690e:1382:b0:67d:bda2:a517 with SMTP id
 956f58d0204a3-67df4491171mr4666173d50.90.1795438678993; Mon, 23 Nov 2026
 04:57:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165546.3050013-1-peter.maydell@linaro.org>
In-Reply-To: <20261119165546.3050013-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 12:57:47 +0000
X-Gm-Features: Aa3M54qvj66zCC07P2xuTaoolTcrv6gBDBrzB8ZIbOXdlEWfahsscwY4DJxFvv0
Message-ID: <CAFEAcA91WC+x80j3Lh4wyOgzU=tdu8AQqAcDaXtpghw6wUm72g@mail.gmail.com>
Subject: Re: [PATCH for-11.2] target/arm: Handle "PMU disabled" in migration
 validate functions
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 16:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In various test functions for VMSTATE_VALIDATE() fields, we check
> whether the migrated region number register is within bounds (i.e.
> less than the total number of configured regions).  These tests fail
> spuriously if there are zero configured regions, because then "x <
> cpu->pmsav7_dregion" is always false.
>
> When we allowed v6M CPUs to have PMSAv7 in commit 157f6c69edd06, this
> exposed a bug, because we now have a CPU which has PMSAv7 according
> to the pmsav7_needed() function but which is configured with 0 PMSA
> regions: the Cortex-M0.
>
> We could fix this by having pmsav7_needed() return false if there
> are 0 regions; however, the cpu/m-security vmstate struct does
> migration of the secure equivalents of these fields, and we also do
> a VMSTATE_VALIDATE that checks against the number of MPU regions
> there. Making those fields be migrated only if there is more than
> one region would be awkward (we'd need to pull them out into their

Just noticed that this should read "only if there is at least one
region".

> own vmstate struct), and it's unnecessary -- migrating something
> that's all zeroes and not used isn't a problem.

-- PMM

