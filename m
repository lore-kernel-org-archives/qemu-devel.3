Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4D7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 18:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzhey-0008DQ-Gw; Wed, 24 Apr 2024 14:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzher-00088j-00
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 14:47:53 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzhen-0007Ft-UB
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 14:47:51 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so149084a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713984467; x=1714589267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CF8FF3yAYWLGLETNo31vU3YDHclWd63844j2vUSa1hk=;
 b=Z2YAPT1pN6ylojKAv/8qxR+0g9bPGUfl5ImQpuyvkxqeWFyyJCC8DgJvXx5bc5v2yx
 MzBQmcP8lFB2e2eLuMkPUOMCwnWm84SLJSJDcg24/GTIGQoxobQJzc0hb70Juib5Cu9U
 idM4pTE0duLIX94Al8xOWvqKsOd09FotNnTwslZCgLTtG91jSEwyZ/VKIQRT55GjLCgq
 QHgo3bQKFdQCW/Kke4TX7LPw7CxEPB+NBFpccdTBOFYScbU+y9z1MF/Z+tiVw8cxOL9H
 vFJIW59B4VlBwo4LjL6Cmw5tJ2XEGX5k/nxQLV3EclWRXTLhXTOUSMoRFQvGJnwW+jnH
 QlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713984467; x=1714589267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CF8FF3yAYWLGLETNo31vU3YDHclWd63844j2vUSa1hk=;
 b=RBHm6AjHvpvdMS7yZxtNpfyx1QTPbwc1Gj2KP1i+gTI3PPlQm8Ou6GIKfe5iP4s+Gb
 sWVs7Op1MFoJdB5g/TF8qKjS+qOMP+XjpeJjkU2NICGOKO7GGamrm43aO/9Fa0UzdPvO
 +57t5qTo0tL5IJpPHJVBB+Tk+1770Zqf+52omicL+LnIM7rSN7eqydP0l71taeeQIpo7
 QMFeTtqIM66mKaUyFmb6bVin5cntn1fwj+wZ8S2UfKtbLCLXVJifA1b8Om2Vti7pJ3B0
 xZ0sIsabgEIUg0JmFMcRn9ZITOxoUXanDAwBWUrlnIEtL/MHY/vi/yrnYueXF9DStjCc
 Vciw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzw2Vpohew3f3S7UgpCZeYJv+pArxQvHdMtUZHSoVX8m1uAHR7MG/TTRq0uu/3gJiVTknoDkGQo6ei/V6aBJTqUCOuESs=
X-Gm-Message-State: AOJu0YzEQ3GoXinmRdEvCgumnP2DYSxuGrp6N26u9Hv4NAAFfmbid7Sj
 KBbqfkE82dlozkQaoOeq6Y3Akm3JyrmBTusQJRMor2dvAMX7hX7mH+QMPhui4i0=
X-Google-Smtp-Source: AGHT+IGVx2WYc2OXzzf2ZxFJ0bYZxX51chHmwuA0BV/J+Ec3fMZDQIzjxIBswJjwMnQ7PB61fo2R+g==
X-Received: by 2002:a05:6a21:3a44:b0:1ad:80ed:41 with SMTP id
 zu4-20020a056a213a4400b001ad80ed0041mr3178009pzb.58.1713984467531; 
 Wed, 24 Apr 2024 11:47:47 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056a001b4700b006edcbbff2b0sm11772176pfv.199.2024.04.24.11.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 11:47:47 -0700 (PDT)
Message-ID: <bc432c6b-889d-4106-b8f8-ac0661be148e@linaro.org>
Date: Wed, 24 Apr 2024 11:47:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/25] QAPI patches patches for 2024-04-24
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240424081710.2907748-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/24/24 01:16, Markus Armbruster wrote:
> The following changes since commit c25df57ae8f9fe1c72eee2dab37d76d904ac382e:
> 
>    Update version for 9.0.0 release (2024-04-23 14:19:21 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git  tags/pull-qapi-2024-04-24
> 
> for you to fetch changes up to 060b5a9323e5f49c5edcb77c42e231065bbcc42e:
> 
>    qapi: Dumb down QAPISchema.lookup_entity() (2024-04-24 10:03:54 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2024-04-24
> 
> ----------------------------------------------------------------
> John Snow (22):
>        qapi/parser: fix typo - self.returns.info => self.errors.info
>        qapi/parser: shush up pylint
>        qapi: sort pylint suppressions
>        qapi/schema: add pylint suppressions
>        qapi: create QAPISchemaDefinition
>        qapi/schema: declare type for QAPISchemaObjectTypeMember.type
>        qapi/schema: declare type for QAPISchemaArrayType.element_type
>        qapi/schema: make c_type() and json_type() abstract methods
>        qapi/schema: adjust type narrowing for mypy's benefit
>        qapi/schema: add type narrowing to lookup_type()
>        qapi/schema: assert resolve_type has 'info' and 'what' args on error
>        qapi/schema: fix QAPISchemaArrayType.check's call to resolve_type
>        qapi/schema: assert info is present when necessary
>        qapi/schema: add _check_complete flag
>        qapi/schema: Don't initialize "members" with `None`
>        qapi/schema: fix typing for QAPISchemaVariants.tag_member
>        qapi/schema: assert inner type of QAPISchemaVariants in check_clash()
>        qapi/parser: demote QAPIExpression to Dict[str, Any]
>        qapi/parser.py: assert member.info is present in connect_member
>        qapi/schema: add type hints
>        qapi/schema: turn on mypy strictness
>        qapi/schema: remove unnecessary asserts
> 
> Markus Armbruster (3):
>        qapi: Assert built-in types exist
>        qapi: Tighten check whether implicit object type already exists
>        qapi: Dumb down QAPISchema.lookup_entity()

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


