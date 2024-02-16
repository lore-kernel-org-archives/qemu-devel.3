Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538D0C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 19:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb3cW-0005G9-Bw; Fri, 16 Feb 2024 14:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb3cT-0005Fa-DI
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:11:33 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb3cR-00008O-Sf
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:11:33 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so25069095ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708110690; x=1708715490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bBISSJit/N4hh3ww4hIBwFXSFEh9tHvcj9GTccyFBa4=;
 b=dylO7WDavE6WALdoOeeT2GsTsAqyiQFjkAaZMqAMG9mYKTeeUoA3b2pl5S3gw0hC9s
 n0Y44VjusSZrvS84pLkiTUluMnz7TErUfYuB++V06o6cPO9f6AyUtlmn+b4naoBu4f/0
 yOEwY9a2J7PnUTiZmw16BrhVwduZ3c3/jdGL3be+Cv1pfDU+7ujzACbRjM2WRAJrVS+Z
 nNCiFGa0Hfa2D8lj/2XD19BF5v8Dskp8A6rED5FyR6p0Q1sLUEtbwDfYjxd5tkj4uOLd
 qlQSJVL0BGikMN6ZV5rKV9JhIXKgnu9viTu8YDHeDkS9+P5WxepFSr3PuriM2Gr7fnbS
 Ywkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708110690; x=1708715490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBISSJit/N4hh3ww4hIBwFXSFEh9tHvcj9GTccyFBa4=;
 b=vWuHb3FxFqtx3n+54n4BV/RIXm7H0+IGoRwOKpPGdSmUFAbmsfxbrWAVK1fC7gKVbl
 MP0m2DMX0c2896GSBZ949qJLSS5Kol2ABAEsGz73fn3SJZOV0cnYyuPn4p7FnyxWAvii
 Nxkxgz5GiRvLk52bKNW9gDVruuh59ULbLd+XycXoUyaiovq3IYeQEXVmlM1M5SPrjzoK
 je8IXD2JFBuKCY8r7OeaBoNhejdqiNp6HGO0unb094VasyN1dxKSlbvX6BFA6tw6cVO4
 SuO8mKNc8q7rJ/fc/qzTB1yxtN0cpkzhZPxCY88cO4DrxIQPwcxF38SSSxKnOoHSo5kn
 O9GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPgKRql6Dw4FJAt7PgRx/vveegurE9BwJsUCQK8Rqk5OZUSsZiuAE8qLXLQiBOq5x1K3qP+eILxs7T1Jt21f+9ugpOyzg=
X-Gm-Message-State: AOJu0YzGkrnv1M0+cV+zU9zXPOubZgR9cHh1IiaplD6wQqpQlZPzXOJo
 PcDD7Bc6J3yCYZQRF7gMCe8NXd6z9dYuyxgIk3eT2iqczhfEjeIn0AnrFu68i+g=
X-Google-Smtp-Source: AGHT+IEtpzGHwBt+MmradEVt9d6icCk1dOM9aQ+NzuazR0ozaQsOcvLJBg07a8EEE5nXCiAfmZCWcQ==
X-Received: by 2002:a17:903:264e:b0:1db:94a9:f9f7 with SMTP id
 je14-20020a170903264e00b001db94a9f9f7mr4130132plb.20.1708110690222; 
 Fri, 16 Feb 2024 11:11:30 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 h4-20020a170902eec400b001d9fc826522sm200826plb.239.2024.02.16.11.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 11:11:29 -0800 (PST)
Message-ID: <f9ab9e5d-4a52-42e0-93df-924cafd900ad@linaro.org>
Date: Fri, 16 Feb 2024 09:06:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] trans_rvv.c.inc: write CSRs must call
 mark_vs_dirty() too
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240216135719.1034289-1-dbarboza@ventanamicro.com>
 <20240216135719.1034289-2-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216135719.1034289-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/16/24 03:57, Daniel Henrique Barboza wrote:
> In the Vector spec section 3.2 [1]:
> 
> "When mstatus.VS is set to Initial or Clean, executing any instruction
>   that changes vector state, including the vector CSRs, will change
>   mstatus.VS to Dirty."
> 
> ldst_us_trans(), ldst_stride_trans(), ldst_index_trans() and
> ldst_whole_trans() will change vector state regardless of being a store
> op or not. Stores will set env->vstart to zero after execution (see
> vext_ldst_us() in vector_helper.c), and this is vector CSR state change.

In Initial or Clean state, it could be argued that vstart is already zero, so is there 
really a change to state?

OTOH, on the exception path out of a vector store, where we *do* set vstart != 0, we do 
not also set vs dirty.

Therefore I think that loads and stores need to manage dirty within the helper, alongside 
the management of vstart, or perhaps move the mark_vs_dirty call to *before* the call to 
the helper.


r~

