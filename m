Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA5C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 18:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43XO-0003Gg-MV; Mon, 06 May 2024 14:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s43XJ-0003Bh-ML
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:58:06 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s43XF-0004wq-RR
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:58:05 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5aa20adda1dso1656814eaf.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715021880; x=1715626680; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ns2SdD9EmyR22mmOBfadu4mpM/K4DmgM6mgxNkvP04Y=;
 b=m2+rgNd2iSZKl4HsNQh51El4RReEiFOmCKY6deb+OfIrk8VUeJvh+yfnoI/Nlgup9Y
 pBnWjUXpFOLyMUbhy8GY8QJ/c7nJijMHrbNsDbSSLeQSRjRZah2QtIy1kCFl08VhOUlT
 UhpOJrEeLZsncnixPpbVlXLjYg0Xs7Iwopx8taCAX1r5JhrEMRCa3fhjXw34n5FpBiHr
 j6hFoQW9sKC1ICLzG0lth7JnaQxWeC5kSA3neO/MeUpeArIT8EFt3yGOR8p44u2w6Tnw
 83doMTAR5JcoFSvSyxFBxBrvqici9XTto1pkDTHuXMprqNDjatD5c8W1TyOftmXPDuEO
 8RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715021880; x=1715626680;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ns2SdD9EmyR22mmOBfadu4mpM/K4DmgM6mgxNkvP04Y=;
 b=AjsDytdj9UrKSNCijsAle0cOfKXyCJM3w1ZdBHUce1ukIVDT0ZB0gcKRVAKscmZ/5v
 6bxHq6SCyMVxJuJ4MGXEUHXMoyNNBHeVDklJR+nRXjpY2HYpg0z7/xJsupDViSWWNB+8
 Gbe+8h7xgyUUAoUcw0InNZuA/vVkdOZx4C3u68ZXajy7AOM8DIBo65ai2pPOkeuGFGxK
 nel8MIwDmDcDR4tqGvwXkEDboj59ycF1XbztxqDMb4jVBH0D5r4Cxe3p+qkx9Qaogf/A
 pEem3pjuuKHYcuIXQYlQSpVMdmYNdOYlx1oykxmUP250KnJ169VOIAiwYRS7x0vbJWdi
 4zZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxev2TkCXaW4IEq+8auQx+FrTmQCzSinb8t9nVQupoljCBcE5QqzGwqEOkN/KdGajkZuE6odsUyZ7fiDtGuN17zDUqE1U=
X-Gm-Message-State: AOJu0YzMLVGM4GGEAz4DFZfXmlmCoJk95EDcvERafpSfEo7H4OwtgAwt
 yHJ/FsisNv7Rc4zhHFnNBnXBsnHZg+FCB92uJUv8X4z562mXeff+
X-Google-Smtp-Source: AGHT+IEWjVrGit4BHR7Zh928sHbIat4s7DybdyAmye8gMKIodKE1coeSw9znhLXflIxsmyanqr33Vw==
X-Received: by 2002:a4a:44c1:0:b0:5b2:9d0:4d91 with SMTP id
 o184-20020a4a44c1000000b005b209d04d91mr4501585ooa.1.1715021879550; 
 Mon, 06 May 2024 11:57:59 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:b108:eb17:4557:755d])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a4ae849000000b005a4c3d44cadsm2067993oom.38.2024.05.06.11.57.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 May 2024 11:57:59 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>,
	<qemu-devel@nongnu.org>
Cc: <ale@rev.ng>,
	<bcain@quicinc.com>
References: <20240506183117.32268-1-anjo@rev.ng>
 <20240506183117.32268-5-anjo@rev.ng>
In-Reply-To: <20240506183117.32268-5-anjo@rev.ng>
Subject: RE: [PATCH 4/4] target/hexagon: idef-parser simplify predicate init
Date: Mon, 6 May 2024 13:57:57 -0500
Message-ID: <067e01da9fe7$4ffddd30$eff99790$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJLdJdU/DG86JVEEIa8gVqwbMNhjgGHqreksJynbIA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc34.google.com
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
> Subject: [PATCH 4/4] target/hexagon: idef-parser simplify predicate init
> 
> Only predicate instruction arguments need to be initialized by
idef-parser.
> This commit removes registers from the init_list and simplifies
> gen_inst_init_args() slightly.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/idef-parser/idef-parser.y    |  2 --
>  target/hexagon/idef-parser/parser-helpers.c | 20 +++++++++-----------
>  2 files changed, 9 insertions(+), 13 deletions(-)

> diff --git a/target/hexagon/idef-parser/parser-helpers.c
> b/target/hexagon/idef-parser/parser-helpers.c
> index bae01c2bb8..33e8f82007 100644
> --- a/target/hexagon/idef-parser/parser-helpers.c
> +++ b/target/hexagon/idef-parser/parser-helpers.c
> @@ -1652,26 +1652,24 @@ void gen_inst(Context *c, GString *iname)
> 
>  void gen_inst_init_args(Context *c, YYLTYPE *locp)  {
> +    /* If init_list is NULL arguments have already been initialized */
>      if (!c->inst.init_list) {
>          return;
>      }
> 
>      for (unsigned i = 0; i < c->inst.init_list->len; i++) {
>          HexValue *val = &g_array_index(c->inst.init_list, HexValue, i);
> -        if (val->type == REGISTER_ARG) {
> -            /* Nothing to do here */
> -        } else if (val->type == PREDICATE) {
> -            char suffix = val->is_dotnew ? 'N' : 'V';
> -            EMIT_HEAD(c, "tcg_gen_movi_i%u(P%c%c, 0);\n", val->bit_width,
> -                      val->pred.id, suffix);
> -        } else {
> -            yyassert(c, locp, false, "Invalid arg type!");
> -        }
> +        yyassert(c, locp, val->type == PREDICATE,
> +                 "Only predicates need to be initialized!");
> +        char suffix = val->is_dotnew ? 'N' : 'V';

Declarations should be at the beginning of the function per QEMU coding
standards.

> +        EMIT_HEAD(c, "tcg_gen_movi_i%u(P%c%c, 0);\n", val->bit_width,

Since you know this is a predicate, the bit_width will always be 32.  You
can hard-code that instead of using %u.

> +                  val->pred.id, suffix);
>      }
> 
>      /* Free argument init list once we have initialized everything */

Taylor



