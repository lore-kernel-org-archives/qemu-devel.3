Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B113606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fFp6AY0q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWGE-0007OX-QB; Mon, 09 Nov 2026 15:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackyli@google.com>)
 id 1xQWG6-0007MW-GC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:46:31 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackyli@google.com>)
 id 1xQWG2-0000uy-TZ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:46:28 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b71ee00f0dso466a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:46:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257185; cv=none;
 d=google.com; s=arc-20260327;
 b=SJFmzr5KsWIoQl8vmGBU0eQ+2ETqOu8uzOeYa8WbKCAWi82krJvBwyHY4Nf/EicQ8I
 l4XiZF8Q4aZKF4xXU4gVsUEtpUKF0IH3bsSHD2EJPjyzVZs2gC6W6DlpL2MCYHqGmDVl
 CZh76BFCXwLqDo9yyvsUmiX8FzO6FrINULXKdQ28J3tSyZ/KhHe57uECbgcHGw7yqFaa
 rxjKM5SW7J8x+69wOf+QA44eIk5abcB1q+WdqSHIlmxzaPAENeAvN21Y4CkVaVEa8dsO
 aAbffJ9BGDhvbtoFTy4KkII9j764z7z2F2Gk2qO+ORCVAq4O4EBYRaG4HrglvhaGYTaY
 T+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Uu3K6wTNGgm1zwzwRP7EeiHq4On5xub2lepnKvIKm/4=;
 fh=19rVzOIVk3RdKPt+lVIVQzEa6y6eWoIxhH/S62q455I=;
 b=VRN2owKw8PBq/JT/soUQY3PEcCW1eIxSrSLgHrVZHwg4qG5N9lw7HbZdq3biwFmWXC
 sPrCzNgXchYppEDdghrQvLgOIV0mVxmqBWB4yEMg+fDIsefiJ1ZNG6tKBcdLfp0Q0ib1
 CB9p5CAX258BqqBp/X+zViLXry+DV7qx+pOriN/+VgXCIYu2d4+Din7/tFPDwqtT4CRN
 BzUCEC7nGuHw/fyrUFg36nLg3+OChTR71bFM8TX/faVxuRX3c4f7g2tlkDR69902NXMs
 Fkar/7ioSk/i5QK5trzIkjDgAYXAfy13xAJJvr3MxtYjvZJ1ZlkhfpjsaPV0OFMNmVqo
 R8lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794257185; x=1794861985; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uu3K6wTNGgm1zwzwRP7EeiHq4On5xub2lepnKvIKm/4=;
 b=fFp6AY0qyLMDK2Paci49t41r5VLH9vXnSeEKqfin/0sSOtmsZibetOPWefe+hauB8s
 iHDpF/4c6fnWjlMTFF77OwePiZxbXxN5gGQi1bn9H1XerY1cqspiRW3OdZVVO0COCo+t
 LAh2xBIgfz9nCKgRFmbeZ2I2dutpl3SwflUDfYqRDX2RS9Rmaw9dImRZbxLsUE1MoZyn
 k79gnUQ7pAnQLcTE/eMrnbEXxZw9DDjEC+lTnvOWT56k9Bnag8+912bcfFOJlYtZbhbX
 G+o5ZleTDiGpnnEHhhVEGxJA0RxMtcp/bxziN4pyB+eNZrBBqxuQ2i2TK9TGynafcmN+
 n7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794257185; x=1794861985;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Uu3K6wTNGgm1zwzwRP7EeiHq4On5xub2lepnKvIKm/4=;
 b=lnF2BzpTYmBctzWXAZEM+YPoUyMQiUTXyY47H7iNaK3wqxZ+q8XHcAfusErNH8hMcu
 aF84Ma9j3doYNYA8Q2Nh0DL20SJDRFEGxT63lyeQ1D4ObyTKYzwfgiW7vHbBO4FeHfmn
 XVrCTg3/EigXW4E0lS+B3p0baU2lAK5fIjCgCSVNYiHnrT1aA3EyPq1ELUZy8s+cCDEm
 DcMOjB01AqJ5kTm78Qh8a7wxRDj0Ao3eRMSn0rs4ZUYki6TPedLbkPAJ/MR8XUirX7fx
 yvUTWQizcZn6AYrZHRpxhwzDD54wNgoySHmoXFgibP6UfIz6pjw51zaQad+FpiHBrnsb
 v6jA==
X-Gm-Message-State: APuU4Z8HWppqcQ5/fq2FeKlYWLhay765N1lzFNhSgWRyiru2my9nyujQ
 0B5+4TSLstgzbtK/9/CzsO11WFfpUwPBdW20rcLS8TwqDlWTFVr2dMt4DZQyZQJY1ndgfti4rTg
 bKl18taQOo6kE3AbGICxm9J2V/+0ZvJxuoV7BymMIDGClOgr1yofFgwS70w==
X-Gm-Gg: AYBFou3jdmu1j9qSCklNidijBLvK9uolGRBpcRxeViTgBItLU8bTXEgNTbT+fRfKRd6
 B4k2rC4LWgO4YZol2ol4Oz2i7cEzVEIBKYrrNXzNDs6TLaiC6PcTbkfTwK1/PdUH2JJXfqcSBgf
 zwMmpnXHXu0MtT1cxRzayCu0LQKrncrGEaxYOVEcvulU17ToRPkHvwImXxZKPc/RGsioSKD/S1C
 9BqmDBBsbIqezkaXONlxmjQRngVxrOATcmXoPkBqIsF9pvtkVjaIpsI3WOpZ6puPVyaLkjtxaVq
 aIz8G++I9wXLndvV22VlssSBSZ7EqJNLs0lQwe1tEbekpcRPfxNxslTUlhYvrS+RhThyzl3rMZf
 WahRINbkbiUh/kTuYusDoJ9DVQexWkbbs1GACDoGNklzazvZgt9fdzOjwoGWKtgJiNzGK
X-Received: by 2002:a05:6402:230f:b0:6b6:eccd:ce77 with SMTP id
 4fb4d7f45d1cf-6b75a42c3cfmr6765a12.9.1794257184735; Mon, 09 Nov 2026 12:46:24
 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
From: Jacky Li <jackyli@google.com>
Date: Mon, 9 Nov 2026 12:46:13 -0800
X-Gm-Features: AclHuK-EaKTK_W3z35T4yU7ijGPbdeY5ooy3Um9LzcWXfKIxay3zuRepOxUsniU
Message-ID: <CAJxe5csfx5Ubf15Pw4Mdk03tmEQtWxN11tfwY3tv006k-Nbgpw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Protect VMM from speculative attacks using x86
 PKRU
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Reiji Watanabe <reijiw@google.com>, Alexandra Sandulescu <aesa@google.com>, 
 Matteo Rizzo <matteorizzo@google.com>, David Kaplan <david.kaplan@amd.com>
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

Adding Alexandra, Matteo and David, who may be interested in this.

The full series is here:
https://lore.kernel.org/r/20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com

Any feedback is very welcome. I'm planning a v2 that addresses Dave's
comments.

