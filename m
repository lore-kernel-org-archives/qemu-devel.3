Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB13C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvoz-00006X-Mj; Thu, 11 Apr 2024 10:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruvor-000067-4l
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:54:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruvop-0005pa-CU
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:54:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-416c4767ae6so12739955e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712847265; x=1713452065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i/KYfvrMFNJKui52jTgtyjSDfhz7doA4Av/pJx3IXoI=;
 b=Sp4BMbAQw+b1Yj3xzNv5ASJyftD6LkAQSzf2/VNDlxc7rYboHeh/w50Y2fayOl+TbW
 HPrZ9y7FOcNYIKFtm/0QXgGIDUpHY83S0arICuAD+CNUWTlXPRCt7R6HbKaMDq/hWgrL
 MXpEh2JzZrzbV7VWPp9H08xcz1fsIP4/J9Qogd/0FCm9rDmBBN14OOwrFuIadL7eoKNf
 imYuM+5UxxtJsfZfCBA21idi313eudN2VcoDGF/WRvKm2gnD16sDipNpbqlB14v0SYPh
 HaiTkkW0Y7C2XizjrSJ+ETfuiZUCtjHZyddBL64UBRyBN/BG95GqsrXfiDXcxv+qIjJZ
 EEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712847265; x=1713452065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i/KYfvrMFNJKui52jTgtyjSDfhz7doA4Av/pJx3IXoI=;
 b=G2DkKwhVug7JidLjCVgczgIwGdMt99irGguORf7dtDWU9Bbw81uIeElJWaRd/FQCc1
 +8a/SbKUssS59oVFuLfkcgJDQFRJSlf9nCqmjJ8mQiAurkbo+ejR8ctMxNBno6DKMMUz
 z/m4ID0Q1Px1acFsbpq3ZhhBAz0ptlkGoHGkASawMF8JeEB93RptMQcaC3EBRaTC4h9I
 qUOeJwazqkC00+tRGzlazopyKM89QjQgeoyxsj7Mn8hOFDCjoPw63io04SGIkdUQcBRx
 yjETNnYk+GCPoBU37vrg5F8Waj/CI1YzGkamcm9m2ywBn2WTfNyhK5QLIObdfX8+SB8v
 eYOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOZsfYAY81TD2ICF5Tp6TK+wSS2oXnYvge7wdzGwy60Vd+BIUNOR1rrkbj2wh1eQzuYw06T0XOElf9psfm+OGj5VnwGio=
X-Gm-Message-State: AOJu0YzvXcpiQ++676289kPyUtv4UHjt13tKtdqg5aKCcpPFQYEwjSrf
 7jhen85BRgIdrDJBsvs1qpHmQIC7O6VDZi5jpOCZfGlNBbQCSbhLOG8xw4jA2Gbw5LGuSbp9KVM
 HN5w=
X-Google-Smtp-Source: AGHT+IFQn37paZ/ecCxUBaue7MALOxz7ITqW3boEY9SR9mVXnX5E09DMKfo9PF8eOI0E1sHdfhjnhw==
X-Received: by 2002:a05:600c:b93:b0:416:c229:596c with SMTP id
 fl19-20020a05600c0b9300b00416c229596cmr30563wmb.10.1712847265153; 
 Thu, 11 Apr 2024 07:54:25 -0700 (PDT)
Received: from [192.168.120.175] ([92.88.171.159])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a05600c475000b00417e36953a0sm1292915wmo.20.2024.04.11.07.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 07:54:24 -0700 (PDT)
Message-ID: <17c09795-8dc9-4a80-9877-8c72e45c198c@linaro.org>
Date: Thu, 11 Apr 2024 16:54:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/flatload.c: Remove unused bFLT shared-library
 and ZFLAT code
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240411115313.680433-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240411115313.680433-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/4/24 13:53, Peter Maydell wrote:
> Ever since the bFLT format support was added in 2006, there has been
> a chunk of code in the file guarded by CONFIG_BINFMT_SHARED_FLAT
> which is supposedly for shared library support.  This is not enabled
> and it's not possible to enable it, because if you do you'll run into
> the "#error needs checking" in the calc_reloc() function.
> 
> Similarly, CONFIG_BINFMT_ZFLAT exists but can't be enabled because of
> an "#error code needs checking" in load_flat_file().
> 
> This code is obviously unfinished and has never been used; nobody in
> the intervening 18 years has complained about this or fixed it, so
> just delete the dead code.  If anybody ever wants the feature they
> can always pull it out of git, or (perhaps better) write it from
> scratch based on the current Linux bFLT loader rather than the one of
> 18 years ago.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/flat.h     |   5 +-
>   linux-user/flatload.c | 293 ++----------------------------------------
>   2 files changed, 11 insertions(+), 287 deletions(-)


> @@ -268,40 +115,7 @@ calc_reloc(abi_ulong r, struct lib_info *p, int curid, int internalp)
>       abi_ulong text_len;
>       abi_ulong start_code;
>   
> -#ifdef CONFIG_BINFMT_SHARED_FLAT
> -#error needs checking
> -    if (r == 0)
> -        id = curid;	/* Relocs of 0 are always self referring */
> -    else {
> -        id = (r >> 24) & 0xff;	/* Find ID for this reloc */
> -        r &= 0x00ffffff;	/* Trim ID off here */
> -    }
> -    if (id >= MAX_SHARED_LIBS) {
> -        fprintf(stderr, "BINFMT_FLAT: reference 0x%x to shared library %d\n",
> -                (unsigned) r, id);
> -        goto failed;
> -    }
> -    if (curid != id) {
> -        if (internalp) {
> -            fprintf(stderr, "BINFMT_FLAT: reloc address 0x%x not "
> -                    "in same module (%d != %d)\n",
> -                    (unsigned) r, curid, id);
> -            goto failed;
> -        } else if (!p[id].loaded && is_error(load_flat_shared_library(id, p))) {
> -            fprintf(stderr, "BINFMT_FLAT: failed to load library %d\n", id);
> -            goto failed;
> -        }
> -        /* Check versioning information (i.e. time stamps) */
> -        if (p[id].build_date && p[curid].build_date
> -            && p[curid].build_date < p[id].build_date) {
> -            fprintf(stderr, "BINFMT_FLAT: library %d is younger than %d\n",
> -                    id, curid);
> -            goto failed;
> -        }
> -    }
> -#else
>       id = 0;

I note 'curid' is not used, and 'id' is always 0, because

#define    MAX_SHARED_LIBS                 (1)

Having:

struct lib_info libinfo[MAX_SHARED_LIBS];

Maybe we can remove MAX_SHARED_LIBS entirely to simplify
further?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> -#endif
>   
>       start_brk = p[id].start_brk;
>       start_data = p[id].start_data;
> @@ -425,12 +239,10 @@ static int load_flat_file(struct linux_binprm * bprm,
>       if (rev == OLD_FLAT_VERSION && flat_old_ram_flag(flags))
>           flags = FLAT_FLAG_RAM;
>   
> -#ifndef CONFIG_BINFMT_ZFLAT
>       if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
> -        fprintf(stderr, "Support for ZFLAT executables is not enabled\n");
> +        fprintf(stderr, "ZFLAT executables are not supported\n");
>           return -ENOEXEC;
>       }
> -#endif


