Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uxX/4Wwc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDnF-0006XC-1O; Fri, 23 Oct 2026 07:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKDnD-0006Wj-DV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:50:39 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKDnB-0007dG-SC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:50:39 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6768403e9bbso897840d50.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792756236; cv=none;
 d=google.com; s=arc-20260327;
 b=PEdHyT4iraGdG7xNuiK8YS9u1K+7GV6vs0Z4UEoQmL+4ENLTJpT9EFb9ouEpD/JFtN
 5N3IJO9NjxfdIweVq7Ah+3We/Elm09hgHkHd+xfMmhQTjy2RLwL/tn9Utl2gMOUqDuqu
 /yKY++UeHTfxReRu5lxWPZde2i4cJq/OvkiwEYi0mlO48hFOn9D+bw35myLhc2gyDCTq
 HWSCUlGZjhLqVy8ROUK6A7JIniKFO9h7k9yx/ar6cNGmANFQhX9y3YtbwuyQyUOT2uW2
 NdR6TXqcswPQO84zCD+BgIdTiSQh3nVPvBDRbhJIOip7bZflm7LKdfzouU2IG+NCxe6C
 Q2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HJX5aJ6EOY69DMLcMohvm1D6kKlyZ1YYP9/K9PR+cjA=;
 fh=v7GkZNMDit7OYETRRZQPxK00jPDHm89GSkx+aMy6LF4=;
 b=VHqPubdy0vxHcCz48obfEQpNMpLff/NawFRkjzl8pn8a90Zv5u7d8lE274UIVn3+lW
 0VwchHOir5eXInkvRKwaYZoMuhaqfJFuhfSPP810vL/tYyijlpvsrCGObOfO3T2nWPkT
 dbxAiplPWfcDdwqngXdeArKB6kM93d0JgFttjo3358OF/WUJufJBYFNuvHysbW6rW4HP
 Craf7symcRLjZ9X2atRPKg796C33lVSy+dXhDAORnfRtTveDsSE31fe1VfsA9oiwl8Av
 vDtDrxcR4b+oQQllEvOiK3KCYpetK7m06+qTBbD2Ys3oZ/oVUggvbhyU/c1l5051EbOI
 NgWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792756236; x=1793361036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HJX5aJ6EOY69DMLcMohvm1D6kKlyZ1YYP9/K9PR+cjA=;
 b=uxX/4WwcKcGktcTQNOJIQdfBmu+cKzjZnm1gDcQUD/UrimzV3bp0HinbumNeVbR6zq
 CcQlXmpj4UMLB82sRS1wPPulojwL7DqIhV+7YKW244lcvV+rUgS8ERFSZa36RhiPMKFq
 ZeG0yb9uUe76ATk+bRJ02XIEHFuB2KUF7JzrEmavt0xlca8hbDnFa16F+KyzDkqODE3F
 fIl7hKPmCNzPEJM4ZMJs8a0i8RA+dvyJWYVScAraHfXrs0RRGY3nk+tr2sNwBpgk7z1H
 uI4dS5zfg0ijuVuvOoO2MJDgV4kSLm61zqEPGmj33vJgH559TIVIL5IonZVDZsz0PROt
 FY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792756236; x=1793361036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HJX5aJ6EOY69DMLcMohvm1D6kKlyZ1YYP9/K9PR+cjA=;
 b=24BPrpVsxjmOMSRl/EUmsGnPGHF0XN0uiBy+pEW6Piuo9mr2WeuKnaYf1ZoqqES5qz
 6z7VPsefpmZHarMwcTY2QNReqTCqZrId7SIQzEP4UgM2Il9qYhlPJC1F0tXQwh4zM5hM
 f8qnjJ/x6wYqGEUpRYu3rCoRPhpVh/FcALU9VBtOvVwzuTLJD2WQjzATWPg52qN/Ngub
 DD9Q4bhH1wKopEZe0uWh+XfehI/fBmcsHsiGJ2l1mpwYRJTFLC9mW+uxPJlKXhChKq3H
 Scx4qIC2pZF5895weXAZTp/aMT2lR/Hf9mj3k8C8eTudpu+SdBN1BnW4U5qc5tw853hC
 T8bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPnM+SazOI81A8dsZ2IkYMifKEnMpPos/gbFbX2tWZVQkDdHNdYLPlWcLKlX12ixXTCn5kgI89WWVX@nongnu.org
X-Gm-Message-State: AFq9FYJM322lfWrF2sshe3kTHJIuW90AY3Z76nHXOb8jpp7iqysmGJIw
 ujk76YOKoxX0txi+S8ol+BR1t7piiZ/U+aTcmScrzOgNMx2G/DcCYKaxvhVLmSSiCiHhDiBNVap
 0MClHcscqxMgPWQu9wB4YZfL8DsnW+ruo7Ew4zdp2oA==
X-Gm-Gg: AYBFou3vd+JQXRdxTe8hDtH5sC9Dn0lEbXLPMdeEYe0UST2RAUBtVt9OZFWwEZkvM4z
 lxVPfnGQvgKAefTaasiqkuXjCWNRRDZ0rXEX025BvRWHVjXWBVlpEYpSfxHP4yuYWwnO/z3jbzz
 1TiFo3v07oyi8+aCespEulZYIxHpWPZgEq4Uphzd5yMXdK01f/uPQPQ/bmHSBO/azNRRzkxHMmn
 BqCU4O7xj149TxzHkwUprMWn/6OlXg/9jP6rUkE47GnyNnOYj+khjGLtFaJUJ5JYiRL56gteBCv
 2Ad3IEF9u6RnDE/ttsDQpIb5lufHmswpUQUw+Jj4tk9jEg5bF+e7L534DBArhGfxS7wZlXaW27G
 eadJQC2w2wjlGZECxC/092+QorwPMCkEyaOcmlxmRzonHZxxN0e7BXCHdG7iTAVRxSaB1dVb1Ru
 7Pw/kYzZcVfGXOHup1vVWcL5lecqDKbqakiRAeunf7SA==
X-Received: by 2002:a53:da04:0:b0:676:863f:8ed2 with SMTP id
 956f58d0204a3-67a35c43d91mr1196420d50.58.1792756236406; Fri, 23 Oct 2026
 04:50:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <attACqgQQ-Lxt5Pj@redhat.com>
In-Reply-To: <attACqgQQ-Lxt5Pj@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 12:50:24 +0100
X-Gm-Features: AclHuK_7ofiwimKEAs1WrOZxTSnj_NGsSA3Gx5feeBZQhEu4HY8-m2R0wSrQtgQ
Message-ID: <CAFEAcA-2Zkw-xhZ59nAfFOEbGz8W2XSOdi8d4eD5F8U4T1YE-Q@mail.gmail.com>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc,
 but not memory-backend-epc
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Fri, 23 Oct 2026 at 12:08, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> The memory backends are all implementing the UserCreatable
> interface, which provides a "complete" method where they
> could gracefully report lack of the feature via 'errp'.

I didn't realize UserCreatable was a thing. It seems unfortunate
that we have accumulated three different kinds of object
creation/destruction life cycle:

- instance_init / instance_finalize
- instance_init / realize / unrealize / instance_finalize
- instance_init / complete / prepare_delete / instance_finalize

-- PMM

