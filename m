Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C22FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI36i-0002gR-7R; Wed, 29 Apr 2026 07:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI36g-0002gC-Af
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI36d-0007jn-9A
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777462164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1G3qtObFZN0IpL3ksnpNH1qBy8V3S0xlMXbqRQ0D10=;
 b=Dhe/GHFGcy3ttbKF1eueCOX23wasmaGSjcWLgl41Xxiaz13r3aZoAoO1t37L1ECn+9LnxX
 H6JR3v6ADP9RVgxfovWY8Bypn9O9R+xJa9s/T3/Xz3DZ3rYVUSvDbBOwBmGn1c5FzOceaO
 XdeZ+mqknMyWzOLlAv4KklmLyd2qu0E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-YCwmO2h1P9OGIUtZ9-I18g-1; Wed, 29 Apr 2026 07:29:23 -0400
X-MC-Unique: YCwmO2h1P9OGIUtZ9-I18g-1
X-Mimecast-MFC-AGG-ID: YCwmO2h1P9OGIUtZ9-I18g_1777462162
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b7aba0af02so61812735ad.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777462162; x=1778066962; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F1G3qtObFZN0IpL3ksnpNH1qBy8V3S0xlMXbqRQ0D10=;
 b=cRl/IyLrCZ79IJBvzC22JDZeTW/UV6nVUAKgh+Jtnvi1JwmpaD++QuVRWvCddIsSLX
 ZHpKdDWPWNgPv7tnr72UzVsO6KYZPhhUQbgf82MjojoM5a5+gx/JV0Wz5BkL6BxTgx9W
 mjOBCILH2w6KVEr3QXLxO3zD7SHQcADGAjYgOuMW67WDeBkky57oj3Mj8sIvxiSeHgVh
 tQPEFqkgifz/pxqFqMBXW7lpqDgo4uaIVR2zb5sD+aUrxWVjXweAU21Jd/VeYNk5UDDg
 WjlnXhgkUFLB2y/upGAg5lVGDEf2xksoMvNaF3nFJD60zFtGYCVSfaSkSddcnyIa5hXo
 Gt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777462162; x=1778066962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1G3qtObFZN0IpL3ksnpNH1qBy8V3S0xlMXbqRQ0D10=;
 b=J4WSnO37VcAg/oxj/iCZu7erVvaFQmlFuKAKsgzDxIn9KM4Nbhd3cOIPjoyG/1CrYB
 j6e2ukR5usKXJJPXh0ai75dYTOOBjDkmhsmPsyK/uZ6jmKHyutTZBFokwNUjZQQDKwWD
 OW6Fu4WoZcBuXPl+nyqwsAXLjV3Lf3p8SVKDnnbDWzMLCS9LKFq7tkFAlP8bEL+MtXX+
 m/PWABGRUn6OE4XESFW/CaejSXeOgpeCbpRrrQITTRqggOKirKxQBY/PmJ5jWyzrGam9
 gG0BELci2WRQF1fB9itPrq4kAyR7gObFuhogf6zOGg88XmWBhfjhufK4WN80+h3AczDi
 V21g==
X-Gm-Message-State: AOJu0YzVzILetok9aePxWhDkaPWGB+LiLg/VLjPGuITzRZqtXmmCy2NH
 qaPOO6U7XQTPHgJq1qTCLrbIjU+QHRvDgdaPR+Q8ChlH7V/BzulCXs1CBtvh9+26p1/Gs4FKRU9
 J+zC2/RERyU8RqDHomJru5NcTxCdj9QnwiOwrFdq4uIcyevh/+TK35YNP
X-Gm-Gg: AeBDievmWTRgbT2iz7vaQI08g5anIALCCGz4DY3KgS85etYFPskzqYwHTlvLUgBEfNG
 zG9+d+yfntvWgBv74D/HQ7Y0EelZkaRXM3nX6NH/R9gAJ4dyWBdHmZ8sX/WEwkhgqow68vEoiZQ
 NDFSlNF2gU/aSvp04DEWmegxFmC3gZYgW2oJhxc+iqhFtSIEOQmNlc+jPG40sP88ypXXUSf/Qb7
 ov4OYEMIMIj6Fv7egMthAUCaHwvwoCMIGKGCSIl1+YZRppZ0MG1epK3u0zNsdmqnmHbInrWDIfj
 EZKx3ctn1k9/Q1OnR6wmg29138bBG0eFNp3uZyWg7J2m/FIkNMhr2FOSlkvH0nGNPas01LtQYiO
 /kj+Y5SJfsllmIRb1ieJBvYI=
X-Received: by 2002:a17:902:f244:b0:2b0:b016:773f with SMTP id
 d9443c01a7336-2b987323f6emr23318615ad.11.1777462161979; 
 Wed, 29 Apr 2026 04:29:21 -0700 (PDT)
X-Received: by 2002:a17:902:f244:b0:2b0:b016:773f with SMTP id
 d9443c01a7336-2b987323f6emr23318335ad.11.1777462161321; 
 Wed, 29 Apr 2026 04:29:21 -0700 (PDT)
Received: from fedora ([49.36.106.198]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98895ca58sm20188935ad.60.2026.04.29.04.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 04:29:21 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:59:16 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH 3/6] tests: Set sizes for arrays of expected TPM
 responses and requests
Message-ID: <afHrjFrMrxroKArd@fedora>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
 <20260428130718.1325177-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428130718.1325177-4-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On Tue, Apr 28, 2026 at 01:07:15PM +0000, Stefan Berger wrote:
> Set the sizes of byte arrays holding TPM requests and responses to avoid a
> terminating NUL byte to be added and to only compare the expected part of
> responses.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/qtest/tpm-tests.c |  4 ++--
>  tests/qtest/tpm-util.c  | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index 197714f8d9..dcbf5457ed 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -59,7 +59,7 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
>      tpm_util_startup(s, tx);
>      tpm_util_pcrextend(s, tx);
>  
> -    static const unsigned char tpm_pcrread_resp[] =
> +    static const unsigned char tpm_pcrread_resp[62] =
>          "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
>          "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
>          "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"

Can we define it as an initializer list instead of a string literal like
below?

static const unsigned char tpm_pcrread_resp[] = {0x80, 0x01, 0x00,
0x00,...};

This one avoids the null terminator.

static const unsigned char tpm_pcrread_resp[] =
          {0x80,0x01,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x00,0x00,0x00,
           0x00,0x16,0x00,0x00,0x00,0x01,0x00,0x0b,0x03,0x00,0x04,0x00,
           0x00,0x00,0x00,0x01,0x00,0x20,0xf6,0x85,0x98,0xe5,0x86,0x8d,
           0xe6,0x8b,0x97,0x29,0x99,0x60,0xf2,0x71,0x7d,0x17,0x67,0x89,
           0xa4,0x2f,0x9a,0xae,0xa8,0xc7,0xb7,0xaa,0x79,0xa8,0x62,0x56,
           0xc1,0xde};

static const unsigned char tpm_pcrextend[] =
          {0x80,0x02,0x00,0x00,0x00,0x41,0x00,0x00,0x01,0x82,0x00,0x00,
           0x00,0x0a,0x00,0x00,0x00,0x09,0x40,0x00,0x00,0x09,0x00,0x00,
           0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x0b,0x74,0x65,0x73,
           0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
           0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
           0x00,0x00,0x00,0x00,0x00};

static const unsigned char tpm_pcrextend_resp[] =
          {0x80,0x02,0x00,0x00,0x00,0x13,0x00,0x00,0x00,0x00,0x00,0x00,
           0x00,0x00,0x00,0x00,0x01,0x00,0x00};

static const unsigned char tpm_pcrread[] =
          {0x80,0x01,0x00,0x00,0x00,0x14,0x00,0x00,0x01,0x7e,0x00,0x00,
           0x00,0x01,0x00,0x0b,0x03,0x00,0x04,0x00};

> @@ -105,7 +105,7 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
>      tpm_util_startup(src_qemu, tx);
>      tpm_util_pcrextend(src_qemu, tx);
>  
> -    static const unsigned char tpm_pcrread_resp[] =
> +    static const unsigned char tpm_pcrread_resp[62] =
>          "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
>          "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
>          "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 2cb2dd4796..1a47099807 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -54,9 +54,9 @@ void tpm_util_crb_transfer(QTestState *s,
>  void tpm_util_startup(QTestState *s, tx_func *tx)
>  {
>      unsigned char buffer[1024];
> -    static const unsigned char tpm_startup[] =
> +    static const unsigned char tpm_startup[12] =
>          "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
> -    static const unsigned char tpm_startup_resp[] =
> +    static const unsigned char tpm_startup_resp[10] =
>          "\x80\x01\x00\x00\x00\x0a\x00\x00\x00\x00";
>  
>      tx(s, tpm_startup, sizeof(tpm_startup), buffer, sizeof(buffer));
> @@ -68,14 +68,14 @@ void tpm_util_startup(QTestState *s, tx_func *tx)
>  void tpm_util_pcrextend(QTestState *s, tx_func *tx)
>  {
>      unsigned char buffer[1024];
> -    static const unsigned char tpm_pcrextend[] =
> +    static const unsigned char tpm_pcrextend[65] =
>          "\x80\x02\x00\x00\x00\x41\x00\x00\x01\x82\x00\x00\x00\x0a\x00\x00"
>          "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00"
>          "\x0b\x74\x65\x73\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
>          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
>          "\x00";
>  
> -    static const unsigned char tpm_pcrextend_resp[] =
> +    static const unsigned char tpm_pcrextend_resp[19] =
>          "\x80\x02\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
>          "\x01\x00\x00";
>  
> @@ -89,7 +89,7 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
>                        const unsigned char *exp_resp, size_t exp_resp_size)
>  {
>      unsigned char buffer[1024];
> -    static const unsigned char tpm_pcrread[] =
> +    static const unsigned char tpm_pcrread[20] =
>          "\x80\x01\x00\x00\x00\x14\x00\x00\x01\x7e\x00\x00\x00\x01\x00\x0b"
>          "\x03\x00\x04\x00";
>  
> -- 
> 2.43.0
> 

Regards,
Arun Menon


