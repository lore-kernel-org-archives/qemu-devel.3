Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAFAC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 18:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43XP-0003Jh-S3; Mon, 06 May 2024 14:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s43XN-0003D8-Ca
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:58:09 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s43XK-0004xR-IX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:58:07 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5aa1bf6cb40so1681699eaf.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715021884; x=1715626684; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0TXSMVzZM6M7T+GPklPOiQ00Gsxnlir1MpB4uIkdFrw=;
 b=WYIw8VViRmPWycDAXcu6q9hjk1XqZ8p0+rHKo34kaltLKzASS7baKA+Fn2NGijDs6I
 V3Rzw3piBlckVLo1/hJct0ea4rZNxj+RmahH9W58T58m2Y6ZOiviTQbYL9zqyn1pT+3Q
 RURwgRbX4tIjHRROIh5uQg0X3s4W+kN0TFJ5t03vaaI1PjEZM4Wh5MHjC+riPVJMJH6A
 Q24o1+L98F1myQtJvJVPzubRNe1tT5kPNthWykYcRAxAYqc+qDIebJB9Ev88ZDeN/j9I
 boJmXrQE/kVfcIAthbQE9JlcVsDtWth8LxFNAZAraoGtC2RObOHsH+jd0qC6pTbsjkNZ
 iC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715021884; x=1715626684;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0TXSMVzZM6M7T+GPklPOiQ00Gsxnlir1MpB4uIkdFrw=;
 b=CeGov+TINVUpumlB2h8GPKWiXJXz1i/QLt9+LJ5QZmArB+7al9a64JC/DE2Ar8lh0y
 a399HynnZ9OBKHHJdlNRShgPEcoQRmpwSPU4qTeaq4N3/JSZMm8mHMraHRqpGpcqQr7A
 Qd8ELgQHft63s5R/2zUt8/kzTcxCWGkG+THIkYXgLQJTjPY58JR0ylmnVXj7HPN0Q8Iz
 4tvCgxGZArcEick0Glz6/OjGMl41pFA95nkLAnQGkX/KL6IOcGfU4BmPaC6rpNwEBWg8
 kEIuTbl8cgljRcyMysDh6/vFILtDY+CVYAjK/3MpKsCZfmn9LkG1uOcPbGP8+syW9yMS
 kwbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkOMe/hnFuYgR7fPX9RJh9vIBSHMgaDyOOn50Jbxshsxm10IGD41xmQJJhTiv8Dv+wJcThGRuR2g9GPPDcyEa/YN1C0kw=
X-Gm-Message-State: AOJu0YzImgWp3o9CYT2C1lPxvCgWUTRRZYCEzqtobQLOZWqS4SKkMWRa
 zBZmz51r+jbjGgkFLOhOwHyIBBf2SmtkiVUPWdqb9cMjtHZ3ypmA
X-Google-Smtp-Source: AGHT+IFx+s/V/RswGpNLVVvBol5BcEgtIz85Cr2Z9A4lRWz0YBKa4iysq03G8Lq+NvLH4bAwiEL8WQ==
X-Received: by 2002:a4a:4bc6:0:b0:5a9:cef4:fcea with SMTP id
 q189-20020a4a4bc6000000b005a9cef4fceamr11650149ooa.1.1715021881860; 
 Mon, 06 May 2024 11:58:01 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:b108:eb17:4557:755d])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a4ae849000000b005a4c3d44cadsm2067993oom.38.2024.05.06.11.58.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 May 2024 11:58:01 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>,
	<qemu-devel@nongnu.org>
Cc: <ale@rev.ng>,
	<bcain@quicinc.com>
References: <20240506183117.32268-1-anjo@rev.ng>
 <20240506183117.32268-4-anjo@rev.ng>
In-Reply-To: <20240506183117.32268-4-anjo@rev.ng>
Subject: RE: [PATCH 3/4] target/hexagon: idef-parser fix leak of init_list
Date: Mon, 6 May 2024 13:58:00 -0500
Message-ID: <067f01da9fe7$51597590$f40c60b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJLdJdU/DG86JVEEIa8gVqwbMNhjgHc4CmKsJn8l4A=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc2f.google.com
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



> -----Original Message-----
> From: Anton Johansson <anjo@rev.ng>
> Sent: Monday, May 6, 2024 1:31 PM
> To: qemu-devel@nongnu.org
> Cc: ale@rev.ng; ltaylorsimpson@gmail.com; bcain@quicinc.com
> Subject: [PATCH 3/4] target/hexagon: idef-parser fix leak of init_list
> 
> gen_inst_init_args() is called for instructions using a predicate as an
rvalue.
> Upon first call, the list of arguments which might need initialization
init_list is
> freed to indicate that they have been processed. For instructions without
an
> rvalue predicate,
> gen_inst_init_args() isn't called and init_list will never be freed.
> 
> Free init_list from free_instruction() if it hasn't already been freed.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/idef-parser/parser-helpers.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/hexagon/idef-parser/parser-helpers.c
> b/target/hexagon/idef-parser/parser-helpers.c
> index 95f2b43076..bae01c2bb8 100644
> --- a/target/hexagon/idef-parser/parser-helpers.c
> +++ b/target/hexagon/idef-parser/parser-helpers.c
> @@ -2121,6 +2121,13 @@ void free_instruction(Context *c)
>          g_string_free(g_array_index(c->inst.strings, GString*, i), TRUE);
>      }
>      g_array_free(c->inst.strings, TRUE);
> +    /*
> +     * Free list of arguments that might need initialization, if they
haven't
> +     * already been free'd.
> +     */
> +    if (c->inst.init_list) {
> +        g_array_free(c->inst.init_list, TRUE);
> +    }
>      /* Free INAME token value */
>      g_string_free(c->inst.name, TRUE);
>      /* Free variables and registers */

Why not do this in gen_inst_init_args just before this?
   /* Free argument init list once we have initialized everything */
    g_array_free(c->inst.init_list, TRUE);
    c->inst.init_list = NULL;


Taylor




