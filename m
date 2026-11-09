Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A950606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=po/Lodkf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW4x-0008B1-Lr; Mon, 09 Nov 2026 15:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackyli@google.com>)
 id 1xQW4v-00086W-LO
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:34:57 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackyli@google.com>)
 id 1xQW4t-0007th-SP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:34:57 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b56c90b38eso3454a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794256494; cv=none;
 d=google.com; s=arc-20260327;
 b=EJQ6MMWVPbw9sCO1UA+fRUQQ/Hr+fN9ETSaCMGje0+UEWE89pdbKqaYS3oGT24NHjl
 53usj96jEKwcrL7tKLw0XumAKqap0x4+n10PMn9NhGcGZdHJ4DbUSQa7KVMjrTFjr7ca
 +WKQIp4T6lyQ96pCFA0ZSsTFob340ft1kfZwbbc4JFiOn1sxytWSWafngtsu3Bzp4cS6
 xvV50amNVOJW0bhEaC5D6LpAfFywFyXO8fnIo1nJWYPuQddahTBLJQ/iWHrYN7bbmHWc
 gKpg7DJbYUsM4jeWMf0XrQ66FJ+X198DN6ldQydKuCslI32g/v+71UDr1eSNIAAMc/23
 Snjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9u3/rYByX8eVYRmHYfD33g0tR7bxTZ5dSd8rv5zn2pI=;
 fh=ZYLk3aNWt2IIxZJkGZ+PohXDgK5bFAz2IBhNcFTbLnQ=;
 b=ojxwDcIqFSrK0KRiozLl+JTCF+sqnkYZuEmTQyEIMJg6Dvp8nZpvR3vkrDDNK1EbCR
 VZINO+r6CiG0Pa5KRk4/oubxtaDe7Pp1QG/bITltxv0xq14/Yd0xTmbPQ9Ram/AXGdE2
 eUdVhmbnQXJE/1vJSkbkUaATSJGSUhuGAvRlgDsboVTwsUm+FnQMWrKIefr3+KN953BT
 sYCvMbY/LAHxRNz5wdB336j+BAyLLVF3HDj64Bfkt05Eu3wfPZiZ5jEE/FwZ6/DL4/2j
 WoJjcw06YTiIrEv46DkHvQHiNMbt5VWOVmR1KqYoAW3hWQR1pIgMZrdIePwLwd4a6rrs
 TD9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794256494; x=1794861294; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9u3/rYByX8eVYRmHYfD33g0tR7bxTZ5dSd8rv5zn2pI=;
 b=po/Lodkf5lJ6AioJFLBt7ymDQCYVlzDbSr0evuVKAVl3y08FZ2S19KXzav34cSSHtc
 lSLqu8HA4DyUC+yTO8+fYlhdAHAhagM0/d+1lZUjU69LLG2YqPBkmshTjOuzFi7TOFl2
 ArhaBslXMGZ/sXGW2CK+fxcCQ+aE9gzsYod1s2i8XfC3RG+6xpzBZCjRl21bjE7QJKqA
 n0BRTi262Gsg8UtBYnvUNLAUt5dKuzLbKMuCER2CnjXrT2Y81pN85cGOOEmrR3VtYic9
 kmIgpxyDBqO7EawyGAPin3+i9Ut26niaxLUxTVzW2uzgO10QHm2C9ppwkuuXS4AeN/24
 Dl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256494; x=1794861294;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9u3/rYByX8eVYRmHYfD33g0tR7bxTZ5dSd8rv5zn2pI=;
 b=2r8pGaHfTVMBaBwLD+BhkEKPYUvDPOM7bPDL345l/cWZxMrh4T728uBR1cpspnlqsw
 5spaZJa/b8w/srwzjEwdubJXYzqG8bQunURyiZphCnSaVYP4OaZ5ilWC60PodLGwFon9
 r8rP1W57qRGpvenLBlkfvInAzcUgN8GmNstwDXD8QkTQ0i+eKJ8vxji3Vfm8DC2HPB+v
 z7JGFMwsTvQ+51HZnQW6Lp+I0sL33cr5ohTnLWzkdvHGYsaoWantv97+GtztWOCISg0s
 P4oL0lAccU0zhc0hXD7LyMFVl+jBPeV+KTTrcJdl5oRjereC1rW2jL27HA4eeZJzkjgc
 b/NA==
X-Forwarded-Encrypted: i=1;
 AL+hErHA5lU1x7mmRdG54/IUNjA5z7KYtqbe7vLNv/OcbdyDp678TE002IEEGrbSMVCtlcofaNqSCQPtZYwc@nongnu.org
X-Gm-Message-State: APuU4Z/WLmYWax1kWd54qetU6n90suR8UeSaWFp4kMRp8lwbkjJhICC8
 fbEXis4TklmYwyxGxu2S4v9Na6mGkuRyZ29w9+F+1AilAh3kpdCJLhNKNYwPmUwN9v4fx2YbSWc
 gnMTLSdMBm6VZw4Cot0vynN+bvuHaOQ1EhmbGAzE=
X-Gm-Gg: AYBFou2sfOrmj/3CqyHjlo5NylaTpGi5V59q75S3zrvIvh8AtngnX3VlWUelaFPujSJ
 FWtOEoseIPPEDiyxpLv7NAKzvxE0pMr8czrngTMQQvBhxYRcxwnPSPYLIZ6myo8AI++0va2ft51
 W5T1q8vHy7TE2Q37VDDzuGxn7vZ+ro7P6tQ9JyAYlog9DviG7Kje5NUpFU5zNlOWcWFBJrErNOB
 96lyJWEY8GK7SAzFRVKh1wefXISzPFsMs4pcPEcFty9mb72viEra81NyYOfpKJESpU85WshuCA3
 96nBtNiTzKC23nSGrQo1LHkDMr+hdes8S9AHGYL5BxS6782u8pvAd89EqlFYueUUZ+kXf1Q3WbT
 djj+oDlB0cDZCvrPtczrg9LVfzrRSv74JgbBu2R0MTWQV4EAznF8CXGeGGPQudm4Wz73vYsr5Oa
 VNRY2Kj1DdaAIlIqQ=
X-Received: by 2002:a05:6402:a6c7:10b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b757679a25mr11807a12.0.1794256493443; Mon, 09 Nov 2026
 12:34:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
 <20260818-feature-pkey-dev-v1-6-8c0ef96a4da9@google.com>
 <b360f0c6-b4fb-4e32-ad75-1b50a8c8a0ad@intel.com>
In-Reply-To: <b360f0c6-b4fb-4e32-ad75-1b50a8c8a0ad@intel.com>
From: Jacky Li <jackyli@google.com>
Date: Mon, 9 Nov 2026 12:34:42 -0800
X-Gm-Features: AclHuK-EiagYwmBWPxUnhfzsYflLnWduTA8NJAEDllfRxo55u5DmLTzix-qh-VY
Message-ID: <CAJxe5cuGCyLTxYEPR-o+acCA9VVUwXgzFPbS6+d2GvLK7SmC2w@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] kvm: Implement SIGSEGV sentinel for Pkey recovery
To: Dave Hansen <dave.hansen@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=jackyli@google.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 8/18/26 14:55, Dave Hansen wrote:
> On 8/18/26 13:44, Jacky Li wrote:
>> +    if ((fpstate_64->sw_reserved.xstate_bv & XSTATE_PKRU) == 0) {
>> +        return false;
>> +    }
> It's subtle, but this wouldn't quite work for pkru when in its init
> state. I guess the argument is that pkru=0 wouldn't cause a SIGSEGV in
> the first place so this code wouldn't ever get run. But, if it were me,
> I'd probably warn or _something_ if I ended up with
> (xstate_bv&XSTATE_PKRU)==0.

Right, that was the reasoning: a real SEGV_PKUERR implies PKRU != 0.
Agreed it shouldn't fail silently though. v2 will check XSTATE_BV[PKRU]
in the XSAVE header, and warn and fail closed (i.e. not treat the fault as
recoverable) if it's clear.

> I'd probably also at least _check_ for the compacted format. Basically
> make sure that XCOMP_BV==0, too. This isn't strictly necessary. But it
> would help me win a bet with a colleague, so would be much appreciated! ;)

Will do -- v2 also checks XCOMP_BV==0 before trusting the standard-format
PKRU offset from CPUID. Happy to help you win that bet. :)

