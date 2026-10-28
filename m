Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3B606A33E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W2pFoEXv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6my-00070M-Sw; Wed, 28 Oct 2026 12:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xM6mw-0006y1-TT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:46:11 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xM6mu-0000no-JJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:46:10 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3ac65e845a8so12792071fa.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793205962; cv=none;
 d=google.com; s=arc-20260327;
 b=SBFZNbSNIk9ViykuqZ1BfcCUjI6jomZHSRf9TTzNnF56Sr4lfKfPqtdPQxt7DUxckt
 23s04FiW9D/3oAaWIHHvWvfe0IVd42odsmtY/VT19kliGi96rcv1ku8Eai2Q6kbVLavX
 eJNL7HIJk16ivv1XoAlwWD4M5Qh811jKV5YF7Ff6AZfN4gJ6Po8SsOauuIocFSKJunSt
 RTdv7dnXO+VSikXU1fjRo/Hu84o+yylB64S9+xUKK98E+uhDgXZYAMhuXEi0ipZp5v/f
 flCfk+ehR8HC9f/65WGisJWV3fJT4PoVkV/Iaf9ctbZrqoc8Gegeej0gnzlMoQakCPBR
 rPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CFmSqIHSMvt3kvSlEZ79Ape2tOpNoJ6Pb1zfdDDuss8=;
 fh=fMfr6U9vqZWyCHK3rqr7ZLaoP9Sdvf4Q6WFrB1e877c=;
 b=n34bUtQ+f/DlIj9HVYBMyq6JEkD1gHoXcEj3BZvHUoP9zBDpnPINbl5T+VaPSW8q1m
 JHYZvY/RFQ5OF2BGTlm2ZhyBKQvsAreWMmMIQ2R8XDwpbCkpg8EY6soASHDTbRmCpgu4
 9RbgoienfYyrF/6NCulDt3YMv1DCoeHRKcf4a0GCMEPuWKh/8sUd6Plie4KDh9vNV2n+
 BHNQh0qDC/A/hrfDe4ZUJ8H2pPsUihcTcWOFfwRyqXdwML9Cf3kY+zeF4K23GcJRbkaj
 EiIDGCIwoFr8IgrkrWe2dm5ad1K4JTWBsjfgZ0xGmjG9+/WRK88AE5k9ZV2me/SEnaDU
 xKEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205962; x=1793810762; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CFmSqIHSMvt3kvSlEZ79Ape2tOpNoJ6Pb1zfdDDuss8=;
 b=W2pFoEXvR3cDeIxjOFryS3rybXB5WL/veV8t77Uj1YsA8wkNwcvFVfahV90cTyZlzb
 8CyJeKC671PppgjYSl5uf3fW/v/PN6LmV6/Rv2pO2ton50ufrDxg2QYLNb2lWX0LheB0
 s9LjA+dbm3hFZv9ejquDN38mPZHhzDTDE5fPf4/Zx+dKfq4OKUSRFBfe5dXvVV5/5mhT
 WrT9z6D6ib6xY22dVCbseu9fQTv+mPrQxMAM5LXpvLoIZcOgOJaNVvqT07XW04LUvu0t
 1AkLcIRjlI5OV6ZW7eOJuVykooBZqnDE3S7AM84VaFmKIVwWHIWqykEya3awuSy6p/Kz
 06kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205962; x=1793810762;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CFmSqIHSMvt3kvSlEZ79Ape2tOpNoJ6Pb1zfdDDuss8=;
 b=Nqhv04aHN/x7LXNgVSLTPhaQri/wUpGZwQbbLCP1/UmbJQz/gQETIrwdjXcFzxGvcc
 SCrnO5mjPemD92yBlZDyG3QDjAQKdCrIJ6HevoogFK7hBv/WvdFN+63jPU8KGiE0Dlrp
 /rr3TyrTkgL07dIHpV/HzRPp1qwvyS+9Q1IDjfohmQpZhB2TOvT7GKBb+U8lP9jlHsNv
 5O0xhOHJgTMaA/BL9vgFW7YIVT2btnzC1QvmY6K8YJPR3gftFCO0ZN5c18p+rGpvOQn2
 /ljLY0ZNQWrE+1w/TYYvsasMBtIfI0PlMmYWRs+nmWnPvfz7P0iWiRP3dzugk67bCKY3
 ormA==
X-Gm-Message-State: AFq9FYKTrzxXW/pfnM59u3dy7ah4Qd+FbR3egAFkeGBvG3SqdGM07O84
 W2EEQj1A64eIMOCwNxChSAeq7rBtq41bRQlYMGM5JdjafgIJpgvY1sVp6UVZHG+toVikdcB07jg
 jZ5H+YwQduKz0J19lepzXcSrYDkVrByU=
X-Gm-Gg: AYBFou24UHT/l6KZgvwI/AyhOL3Tb1frWPuJ8JOIl0EKZepn7wMoonkgzbYeHvA6tNF
 8pqODrnxY3Hpiz+h2/feYD9StPGuCN9VBQHWZFa5Hmv1SkHzdR3mxOqg6YP1JpSENTsHit1M2Xp
 YWN+aOvIFjGm2lCDNkULEqhXFxJPFsPD1kC43X4XTyVqlSkhlV8EPePQSJpAjR0IIyCNKxHWK6B
 yRfcKpO97V+xHgkHuKxSK3DG9Q1Xa2RaPBJDg4z/Bee9th3Cur2gbtS7N79YxIZFnwtBpd5Ixbx
 ubsoXM2MDcpGTDuQpul/aPvkAPx4B5qHE3jJetV75q9agonAT+jxh77yhxL9vegiVZUOA/sBqou
 guiocIGQKcvL2BfW8iTpfpdKNd3BKMwJ8EnPkY+u7mP9zwwF2PpkxiL99eeNevxz6ro+L9fojab
 DRyfxFDwg3Im63N33mU/en9V7tn13mJbIuGvl//EfTkuhD4CRYerrB
X-Received: by 2002:a2e:a99c:0:b0:3a9:dba6:ae7d with SMTP id
 38308e7fff4ca-3aca57fd4aamr167481fa.15.1793205962137; Wed, 28 Oct 2026
 09:46:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
 <20261028163245.1031673-2-richard.henderson@linaro.org>
In-Reply-To: <20261028163245.1031673-2-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 28 Oct 2026 12:45:49 -0400
X-Gm-Features: AclHuK-mGoNHywS-f51iKrAC817_7UFamyFjVDW32_dcZYVzdPIZKDwGnKpEd1M
Message-ID: <CAEdQ38GejSDYZVLn2JCCriaO+u0BD5p=3q3KPeQGcPk457TVyQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] tcg: Add INDEX_op_lea
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The whole series is

Reviewed-by: Matt Turner <mattst88@gmail.com>

(everything except 6/16 was already Reviewed-by: me)

