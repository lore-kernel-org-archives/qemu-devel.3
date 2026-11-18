Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD09606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hwlKyzur
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTimI-0002yq-KP; Wed, 18 Nov 2026 11:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTimG-0002y2-8j
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:44:56 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTimE-0000Yf-9K
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:44:55 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3b094e649d3so832719a91.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 08:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795020292; x=1795625092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xwTU6SidLn/Lf6Y0YpDQoNnJtYweqL7WV5JpvHEoEvo=;
 b=hwlKyzurUSkTHSNAIG2TWRCKCTtz5mtYxxNUGquc/pO2ss0kwP2SsXmTM7aRaYZEw6
 SbqxBzem5GfrLQcLuPbc4XStnOkcUFBfUmE7RJP1GeHLhasS6QCGkXYNlbs2qc8OVicx
 HhCLNIKmYb7cze9aJ19j0qmbqbB3GvdzE1P3L6aMW8fci/R4wrGErEcVeF5YJNx//shO
 +XdlSUcPm5T5Bi81OqGw3KWD4PrqwEX0LBxoutWH4lFYmBqKj2V00ZXL1eXyCKq+r7Wi
 wVTUgAPDtReBj23EFlnfl/HTAwZAQZC4fB5movDMB4Pj6DW112ofsrCUWT8LjJWfFE7Z
 VSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020292; x=1795625092;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xwTU6SidLn/Lf6Y0YpDQoNnJtYweqL7WV5JpvHEoEvo=;
 b=jKmazJcfsdcY54ft3AVnUK4yQ3/FD52Bp8qJkLFh23So6pD+x4w4sB7OqeaO39LKRL
 9afXozCGrwK80F8PPSvabBzEFoeBLrXB+xfigX366+SHJ1Q5yJTY4kAnScSdlTHpYsMK
 ALZR5bRGEux3zHaxpYdoorIVt0VWeO1FVdOnjFVWLNxFCAAlM8p+Q5Qtlh/vqJqQZHzt
 K7W7VyZ08kWL+xfqOP1Cbc3MHmxvGzreQRP8M8nRzvpsmGiVz94akR8XFmsiH10Qsp8A
 lpy0Ur3l7y5Pu5PN7dGDBZyHsDHlUbaQRw8kb8G4KOwHDe4/LGgOHm9qn9Gb6XHgiZh4
 EPEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEdSTFnLlFWOggHT+Ch+gry6uKZNPZ6NPGmOQOEF2NvD5+6t7ZkKTq07syAn00o7T9HIhhAH0XPesXi@nongnu.org
X-Gm-Message-State: APuU4Z+Oc7HU7smPl+pSLEM9ZgO0/jwRPh0JJcnaum+TLcXUKAkAXJ2a
 9+z+ZfawLLj+Zj0vtf0pCOY2NizjUgqvSOdz2P8lR/3urunEq6IrXR3omQvFPQC6m07eDEu+Kwy
 n/anF
X-Gm-Gg: AZFdTZfKV393CBdbox2RlgbHKxJJLr6XMO7DaCb25YaJdeCiNnRHGlXiyt+p/1pntfO
 MXbnNjQ2pVho6vWZbBkhgrXZPdu+HZzdvfKh68zBQtUnEAFtjNZdXUQ4+ix9rQNygSKzhW4wO2v
 dLaIKKs/ifHD1WN2y2xemxD7JZ49mCkGU0QBKFqTejsGt1slj+WfNwmfTskUINU3TqBokAg9XCk
 8Cco4R+Me+K5lHuse4XlVxdvdFwOCCXw9OyxRhIBUL9MChbyvGF0aGaHJDmB5OBk3Eo1coHWiig
 iAvDZBnZD8FyCna6Qo3BOt6Cxg31bsT6/Dm5lUm2gY2rZ4w6DZzmGtsQIB60OayNeQAK6V4USnw
 Aj9yhGaJbwD5Nb+MBtpWkcziO/u1gfN3vF0LRdhca+2n5LqzqILVdlKaWkKY7Anbl0iEjziGFaa
 mxTAZtiOCWJ5DMD0RZ6P8KVNr0FOrdpka4JLRN1l7NG+IO0mOba7i50bCTaJQSPaeHqVahTiQn+
 +/LKUmB0EAmI4O9SMS9WvKTiasyx2AdAWtqJllXXog6hXk8XtQAffhe4UVxanQ5vhJ1Oy7P/OAd
 B+rHe8RRPAc1ALDJppMiclvMSvupfd3b8REjINSVSWe/Fpu5Oaehd5+DMl36StDTAavIHcg=
X-Received: by 2002:a17:90a:c106:b0:3b3:b8f1:f152 with SMTP id
 98e67ed59e1d1-3b3d0641feamr3149771a91.2.1795020292442; 
 Wed, 18 Nov 2026 08:44:52 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3f6be0617sm31770a91.13.2026.11.18.08.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:44:51 -0800 (PST)
Message-ID: <fc40727d-c46c-4fa7-9b30-992e48f7ff43@linaro.org>
Date: Wed, 18 Nov 2026 08:44:50 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Test CF_NO_GOTO_PTR in cflags, not in TB flags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, mattst88@gmail.com,
 Anton Johansson <anjo@rev.ng>
References: <20261117080843.8314-1-philmd@oss.qualcomm.com>
 <97ba694e-756a-4e6f-93d4-85fb316149d5@linux.ibm.com>
 <a15a57a4-4520-46b4-83cb-2b8c872ff028@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <a15a57a4-4520-46b4-83cb-2b8c872ff028@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/18/26 06:33, Philippe Mathieu-Daudé wrote:
>> Hi Philippe,
>> Thanks for addressing the review comments brought up by Anton and Matt 
>> on the original patch :
>> https://lore.kernel.org/qemu-devel/20261104163854.87398-1- 
>> richard.henderson@linaro.org/
> 
> Amusing, I was not aware of this patch, we figured it within a 2 week
> interval :) The ppc_tr_tb_stop() path is not updated however. Richard,
> do you rather respin your patch with the ppc_tr_tb_stop() change or
> keep this one?
Keep this one, Phil.

r~

