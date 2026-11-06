Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94E606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZZ0wlZAr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPH0Y-0004K7-6I; Fri, 06 Nov 2026 05:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPH0W-0004JS-IC
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 05:17:16 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPH0V-0002Qr-5S
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 05:17:16 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b300713befso2812727b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 02:17:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793960233; cv=none;
 d=google.com; s=arc-20260327;
 b=LeoErImwRaqqgk4j1An9W3QOOqEtIQnbTZjqNtrFpHZG1WHNxlV6LSv06bb2LWQ/a8
 Ohu2B6yGykv2CoS/eJVG3il6xiDaHTTiM6OvlJYKaPw7+fd9Sf/Uc9qn8JbCB8uKDIXh
 ITwo+pmK+5GdMIJHTRakHvPJtWmug75W/DREeZ/YqT+l7vfv5Mh1OoYOflhGbT7tvM6I
 +GEMrgIA75/nTX+jBQuWqro2jDgzus4A5/NTzAXDG3ez0B+LpzMP+BF0+gGOPX4A9Oa2
 krXKhej1IQJP/GmXhI0aGhCjZkI7SroliTURQSJtZa++TXmV9v+RHj6pd6VCoEM4QRGs
 frFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8JiP1HZ5jqDc19LWi0j5uNbDe2RE4+Cuc5hpV6CtR3A=;
 fh=IDReqLhkZJkHW58Mk83Kmh9hNGiP4g+t6QuoziuXbiw=;
 b=b7ujGoP2CqolS/6FQ3VkLkblzUfhH8R0D41KN2eaF3T7g6yqO1NqoZGLhB0LYu1R7b
 6LNrKeNH0V0XShN7FyTaWog0bos2ZoQif0b+/xaNh9wIBBBWg8aeFfnqh7HtWfPjrpgV
 YcLFD6GdAxkvwXxtTePsN47QPJm4WDlvPLRU84CNPsCsilK95QF23j43tsFuGNEZF2TU
 n9vACnT4m+nSfnFjZNcdvQcRNhdA9E5l2PfjBoNd0ACbo9NpLyHWJh4uftARUtQDBGUM
 D6mQp3hKjwRsQ5c8BF2sWoNfMLu43sYgMNmXoHAm4nYtE76E/s2tq3WZDMPQfbXJZHgb
 U+sw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793960233; x=1794565033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8JiP1HZ5jqDc19LWi0j5uNbDe2RE4+Cuc5hpV6CtR3A=;
 b=ZZ0wlZAraFfaHA7XbozgTHwNn0VjFIYP2psMJTrPGPoQkB01eeUmMIK3g56CvfTfhJ
 rDsigrj4w6N6Dt38SS9dEZXQ3jys+CnSw0ucKp3pA09wY7mBSCS/2w13woE14QiV88dU
 OyUjU88EwHxTBliehC3t1mRMG0mjxibawhijv0ji/oRPqc6ruDrJ04vKF2ixwarDtpLb
 gp2JaahHOhSNGmQxEB3Wo/g/ggd0ldCu1YBJOeUjQHitUySwMW+BJlwD7eHtocnn45C8
 DPdhgm8K/WkTamBTdZ30Hf8CYX6lNL2At2HHpa6NBU2kZo7e2efE8xq1v4qc7YXbveVN
 hOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793960233; x=1794565033;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8JiP1HZ5jqDc19LWi0j5uNbDe2RE4+Cuc5hpV6CtR3A=;
 b=H1BMirzDZ8plf9jHwZd3wvwDOaYWBppb5lNFtPSj5cI5awAWwMTJ61g4UxqaJDKZcE
 59zCoHwFDVQVxio0LjTPTt/umLIsN2TQ0MuE9N6IYWhA4MN9V+yejqU8+pNMVxTqzTnB
 kUoiQZ+GjB/AtdlcXv5YKsa6qJpH+MciQC6coRfxn1U6LNdQOYDDBta228J/yv2g3zlT
 nRK3FKAsibpkdDHqOboqWs/m97VuaYUpKubgTpQ8z4v/FzZoRuvKWVMqsAECOpLrafKb
 vp8tanzrmDgUNdcKVkAwwQ6fMPkGlJ0DZuZZzuRJc/Sa3EN/DgyIIBnFcDJeRyjhTe5r
 QdQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFbcaOLwl82IXAUnkTdfwz5mFJHCKC8JrZV0W+meAD+A7hTTX/5W0XrEJapLPy8JnqZmK881lsO6e9J@nongnu.org
X-Gm-Message-State: APuU4Z+BSTaEN0751N/mv/A24U+wH6dIfOjsOuG1Tv7tZkl3fupBLp1O
 ONGDB8Utn9D1Y69dyWhlTfWtV1xKOqzzbxYku3pJGhE/ycoxfYVPOcnKrEaC5SXaPjlsXkVKJ7N
 5mcyyVUW3bc+uDD+FbiuOQMSwoCth67uG1a9dHySD5Q==
X-Gm-Gg: AYBFou0eL8wiKBnIabdiqk5dD3er0R0vDJESYItZ8syvVr4kXl30kkKRkg0qTCMTf4h
 MUGueRwEJtfK0w6d716JKhNZ3UzTAy4VWsJh8jmA9SAU2IqB9nwLhixvztYx/16rocUTHbOTZvk
 jHUfcZV7qC0+QLmNQCb2kp+xB1yAdl8KcMimq9q1MiKp6oRMFKDvFRuIFdtgVFW81lxDgVqhDUa
 bToLK/EkdQhyJwaisHFCFzXo6ppYPVTT2McCu/5BkCw4vX0R8fBNTa+12ZGjlZmAss+7pYeFlw/
 ok+21OM8JiSM9C4Tx9MTvG/bm59ee0hsKgb9FIwyBiKkJheYW9m2WwLySFXykAGruyQv2RYuctC
 4s7qX7HYMId8WWWT+0mviC0muLtvZ4PurgBfCqq6Jrcyv8XjwE1U2GQ+Y6quaVDpWAc1lxLG8q/
 jzpXJGSxps6gAIAcBJ8lxObA==
X-Received: by 2002:a05:690c:9e:b0:8b0:df71:44cf with SMTP id
 00721157ae682-8b34193db2amr11785307b3.15.1793960233360; Fri, 06 Nov 2026
 02:17:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cfcac305-df2d-4b95-b27a-21518cb73841@tls.msk.ru>
 <au2cGqMNssHcxCXd@redhat.com>
In-Reply-To: <au2cGqMNssHcxCXd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 10:17:02 +0000
X-Gm-Features: AclHuK_2lNiPLURDJ_b9QV7KhHssIEzqVcr-B9MprKXzfmRg4heI_0XE5TgtDvI
Message-ID: <CAFEAcA9HfbL-VTB7uG2cdMT6FcHtkog+TRRPcQY-yH3Qtkg=7A@mail.gmail.com>
Subject: Re: fixes for stable qemu series
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Oleg Drokin <green@linuxhacker.ru>, 
 qemu-devel <qemu-devel@nongnu.org>, QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 09:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Fri, Nov 06, 2026 at 12:15:06PM +0300, Michael Tokarev wrote:
> > Hi!
> >
> > What's the way you use to find these patches, with security impact or n=
ot?
> >
> > I usually quickly screen all new commits in the master branch, and ofte=
n
> > catch things which aren't marked for-stable, - not everything of intere=
st
> > is marked as such.  I also tend to remind the maintainers about these
> > markings.  But my resources here are limited, I can't try to understand
> > every patch, even description of it.
> >
> > How do you perform a security review?
>
> FWIW, with our new security triage process, we should be fairly
> reliably getting issues in gitlab tagged with CVE::Assigned, if
> they have been accepted as an in-scope security issue and had a
> CVE assigned.

I think in this case we're talking about #4802 (confidential),
and the problem is that the commits in question were not given
a CVE or tagged for stable, because it wasn't realised at the time
that they were fixing a bug.

-- PMM

