Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A81606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grp8IHbE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJU1D-0001jy-VC; Wed, 21 Oct 2026 06:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xJU1B-0001i9-M3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 06:58:01 -0400
Received: from mail-qk2-x03.google.com ([2607:f8b0:4864:34::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xJU1A-0004w6-6M
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 06:58:01 -0400
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-536403312b1so3968261cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792580278; cv=none;
 d=google.com; s=arc-20260327;
 b=Y2nWMRA1BBn93kOgA80lql2ElISSC6iy30x79w9OWP2VvzC2FDO0ss75TJeO+HMtx3
 WfL/YFTrY6XtWBWF/R3Hehk+65qqqYIPI4F6Mof72qdWIiaoRwK6HMme3oF36slJcQIW
 pFFwZ6PqbXiBarcQNiWhPz+Y8KNwl7Jnw4hR+I5H+RuzZJaL8dQLwB3Qnw0cRCfTL2e2
 NRuSpQFi+/qTVlSjICAJYT7fStYbaZqAbUGsyCheqJqkS/ifMbuzBNCtIVvNis+m+o1t
 Bbr0SHvdUQW2KAI7LirIV9DtWDoq4uUeJOGipfiIp/7bSPS8HFxdO4JxRYPmxB5ogbPl
 5DxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=CaGujWrrNY+S+A81htXSSo6B0AeBaa6HqKvQACYu7WU=;
 fh=Y8kL6bSa/yQz5RitO0pLCewP1xvaxsKKeL2RQ3HSwAM=;
 b=MjWPkd10Lbrl8XNDz1/osEO8LeLL1+CTQhbzrTHVVBf9fBYid5vfb1TAjukkw3TZUQ
 FhXC3E16+xBKcaE+qawBcISXKk5/J0f63tF2pWfbHZjgVylmknhTWp3Hj4keM0ll3G8b
 FIbSAXlQ8C+uPmH4QrVvVmmA3fxwLwyP4okTswZONwUawzLU2VydNNTRVKt3orzb/AkO
 aWw7dsQ75C/gZaeekFtXxHXsmjKLAkzaUj6JgvgGwsSvNoFZkAarq/wVsxG3IGMvFVA6
 EFjizuZfG1vHCkszLGOGsC63PQnC26z7rYpgs7migzBJ/JjPKXoB+tvIAPurEatkJYnK
 VDBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792580278; x=1793185078; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CaGujWrrNY+S+A81htXSSo6B0AeBaa6HqKvQACYu7WU=;
 b=grp8IHbEixiDy0z04QRfhZBkKx97s1lCc04agKx8NH7t+Ou3DmzPhxvPcciszAfif1
 pu32tbXA+zoWRYXLh2JZwCU9+7zim8AMAiIdZvhNbdb5+Qq/ZI3gMz/Cx9Mm4F8+pSLD
 qYlMTXF0f2ne47UUEs/U5Kb15s0BNOFBwYpQFgACn6UeSJ3UIkpeI16q2W0Twofl4RQA
 iAFGFRvwJNUvMpw6UeDsXYpvSPqExNhpK6vv0h8NoKzsRqUW9rcpSmCcGu0appd3OHon
 uM2hrHWBcIRrrgxx2AbqD4MMkvEvFNQXeGJuBpNC7tFeLD2GSl/hYmaIHxUOWOmvc3MY
 ODww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792580278; x=1793185078;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CaGujWrrNY+S+A81htXSSo6B0AeBaa6HqKvQACYu7WU=;
 b=pO26VzxpomH/7pMS0/QvPfHB4ZAzgkEQKodUXGeK2WqYyUoZiseeupRcTitFWKyYfu
 3cEMWpSOCcZHsakExqRESi2BK05lb6j/s5GLgzMi9Cy8uz+O/Liz6segn+v6Dn2JDgta
 zHS4uusvwbJYU236TMj/fGzFvRCnl2hwozWOxRdYxHWdn5MUZbhV3ek2Sb4aEB+o8C3b
 KlFx7H7Y/OCTc1MnTrre2piYlyzW/jg4aGjicodPEIFQ17WgtdBvLrfSu6YXwPQN1yu0
 z6NAKkjgSXp+f7FPrc7flB/hy/2DTXXqDRCmv96VeWEpkgjsrvzAOFL8vgbrW3o/J8JL
 2sEg==
X-Gm-Message-State: AFq9FYIfOXMQkZwuFjif+os8rPISIFyUpFqUJgM4hbGdz1iaVeYhJUBo
 PyYCvnPslJZpTmvUUCjHhrXEfgRJdyJMmX5WChZd97ufPe2eYULKIzN2GMuohtIP47OeBE4hqTt
 tiJEmzCPVfpEI53OIZmac1Z8qa7oAoOlVX4spJJg=
X-Gm-Gg: AYBFou2Nm57JkFErj7XaD9CNKVnEb8ZOYpLaGtmgRBUxOivwHg5oPOxQgyvgGhRircd
 P5X9QAL2MeNGDnEtVE1N0uPSEPj1rsrBIyFYhBo5QZWvOJlRCo7DfNr9QVOCK3sFdivqblhIkJY
 ABzWy6hEoYUHeKrmgj6OVfZMKhim2oUmxQHgq8lIRWdsrUnGbU2LTgVvHb1r5VIZ8oPQYfof4/F
 WQljyptdHeqMugElbcEUT5cu083xbn5HjeSeg4JGp/MQjjF+mm3b/BujxFZZOsAYWHpOUQSK05+
 gxffPvG39iKyWH8loj/xoBXhgY9bo5sLNTOCMJQM9TXDV8MYWTaXAaKdAVdJvTdQKrg1SmDEE43
 h85K75p6OBZyiPimE/75Xh2ix5Jcl5PnDTOHLBV+GWGvltHSvPg6gRwyBbvRLMzk3tbcbivLvAw
 40vDp6z5x59Q91ZA==
X-Received: by 2002:a05:622a:489b:b0:535:33a:c75d with SMTP id
 d75a77b69052e-5369b7bacf7mr21493871cf.32.1792580278271; Wed, 21 Oct 2026
 03:57:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: mdspan <mdspan.github@gmail.com>
Date: Wed, 21 Oct 2026 04:57:46 -0600
X-Gm-Features: AclHuK-GVBINpMSSm-8uJZTKcd-gWt3CJaB4RTiolHXCrTvXK1ySJtAG0ZOSnKg
Message-ID: <CALU8FV9KC48FC2FGahqSh2uEqyedy-QZAgZ9qgap147d=Hr-+Q@mail.gmail.com>
Subject: Re: [RFC] target/i386: design for TCG emulation of LAM
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com, 
 laurent@vivier.eu, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:34::3;
 envelope-from=mdspan.github@gmail.com; helo=mail-qk2-x03.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping.

Paolo, Richard: does masking in get_physical_address(), with TLB
entries kept per tag and INVLPG flushing all aliases through
tlb_flush_page_bits_by_mmuidx(), look acceptable to you? I have a
prototype of items 1 and 2 and can post it as an RFC series if that
would be easier to review.

Laurent, Helge: is linux-user support (item 3) welcome in the same
series, or would you prefer it separately?

Thanks,
Tim

