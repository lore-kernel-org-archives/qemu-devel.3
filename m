Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB3606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ECopUWzS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSPZ-0000Kp-KV; Thu, 29 Oct 2026 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSPW-0000KX-Nb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:51:26 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSPV-0006wQ-7O
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:51:26 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6faddda49e7so1943131eaf.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793289084; x=1793893884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UcuXW3Cgmu871W29YkLZapelAJdUZMFiMG4nwNHzO5A=;
 b=ECopUWzSUIJUtCI7a+fLDf9Q85qu45O975iXNmDTOaKJwaJMH0J38V9sVctr+EQgmY
 8c0OxFkPIfxWrzEkdDLxxsVumIXIhPc+6n3Niz0S7IMoX+s36II68GTHxCoAfqAFcmeV
 v2cXK61HlCUayDyFQ5bv2TE/HN4MWkWjRt3L4VcfS3swv6kBzofYS6HKyCJqalO7myZ6
 k78tRy7okdZxKIclaluO26i5MutY3vzHy37QPxGjLVW+ARICB0TOuYWFyPxq3UOcnwLt
 m/LiBQ15bsiwZfgECV3tGwL14vffQ618QANiCZwA7/iDqBjbFtRpH4DkI/HnAv3akbox
 8jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793289084; x=1793893884;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UcuXW3Cgmu871W29YkLZapelAJdUZMFiMG4nwNHzO5A=;
 b=rjtiUsuttSvdStkVVcoaM0E454uHxgkUrZwVHrCaolk37J2L+bec+oR51QJnpIAFBx
 CKpEmDf3I9GTFu3EoRWIsKEo3jAz/PlgmR5MzUP4HGGX91P2dgczraQy5tc6uryxlSOu
 BkAOsOjG1vxo0KQa2JtXO5wPUaKxNHV7jxl1OJKDNcesVGIQ287jfRUbhhAv5O4nOqIn
 UU8rxH1kYgOBGkWKbHKj9+FIicuc9YyJ8Wi9YevdiL8yoemHONj+ANPdxHZOmyZXqeRF
 iWY9zjX5rLZhAk8U66whje2J1FROSOOXJciEN0+qR0yGfommk9jjaIoGax+hFSwuugBx
 W4jg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBLxGnn0/1Rf7sKUqvRKWZCccPM8bpF9U316fVfIa4eZ1/0/SJy89GhZiB+EQ2NtRvb1x0+PCCIUp3@nongnu.org
X-Gm-Message-State: AFq9FYIqv8eezLBUqOnSHw1psnKxSTJNu3uO+ADgsHJHMW+Vcmxg932f
 86GBqJ8BE1SR63UJqh1kcAFR/LXmbmflBvc5nl1GbiZJIMc/o+eB9+il81xCDjWhszI=
X-Gm-Gg: AYBFou0sJrUtWjORSykf8x0PUynEuS3brSM/pG+ILAYtpve9rm/QpHItrF5sGu5ZxuB
 avlK20f8348A3bOfcct15qQ/892cCH9jx8DZgEnpzl8JFvtyOE7tieTvmlFZ0zdwa5xi0mRdmMk
 E1ZkoVIvl8b9OX8h0d0aMOFoEsNIWuIvAHXWPRsulGBcjBJslFD5wddWvZtBHZ0PRClw3nSds+H
 vekQLvPTXl64SPgObOkZR1G7Qwj9U6sS5VTLPz5gvb/pRFpZIEw9GOQKelOBOUdqQXSUO3Ar9AP
 d3u4x+sRVbWQa+j9SzsL9Zhqt8vHvULuWl5Xmw+Htw4ONtKO54x2Z+ic4G8gvikm1dJ2BPvQtWX
 +nvPzBMk7Qq6m37KXV364ft3Ojlz5BiT/YmdWDZGx0/r0P0nLJZUv+xTYxmIjFehzAiIdk3NGIv
 60PlSqOwAahB/6/WKmMoABlVz5CkZYtxExwHul4OCakmfSWCaH7+QurOdnLjo4fzHtRluudino2
 AATlhA2/iXJeTRkJ/6VSfkMeALLiKgES+PAzFOH5tzZkdb4woTP2e1rhxztbJvduHMnZLduQY/L
 Kz+nGqA3SqTVL18BU5R9ewWT7bHGxrQHt+ONjvAS+9Uk
X-Received: by 2002:a05:6820:1381:b0:70e:78ba:11dc with SMTP id
 006d021491bc7-713f0bb00c5mr3240930eaf.17.1793289083759; 
 Thu, 29 Oct 2026 08:51:23 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a901fe4bbesm111337fac.5.2026.10.29.08.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 08:51:23 -0700 (PDT)
Message-ID: <be52ccd2-f368-41a7-83f8-dfe5c4409c4f@linaro.org>
Date: Thu, 29 Oct 2026 10:51:21 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
 <20261028163245.1031673-3-richard.henderson@linaro.org>
 <e366030c-f780-4e96-ba2d-558359013969@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e366030c-f780-4e96-ba2d-558359013969@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 16:12, Mark Cave-Ayland wrote:
> Does this also need a corresponding documentation update in docs/devel/ 
> tcg-ops.rst?
That's in patch 1.


r~

