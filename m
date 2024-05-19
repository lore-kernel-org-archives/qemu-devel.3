Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A029C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2024 15:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8iQl-0005sH-Pi; Sun, 19 May 2024 11:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8iQk-0005ql-Fy
 for qemu-devel@nongnu.org; Sun, 19 May 2024 11:26:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8iQi-0002Vg-Rk
 for qemu-devel@nongnu.org; Sun, 19 May 2024 11:26:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34dc8d3fbf1so1247934f8f.1
 for <qemu-devel@nongnu.org>; Sun, 19 May 2024 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716132391; x=1716737191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gzhbCWF1kyGHTwsUR/MogQJbsziupHZOGRWnzgLfLrw=;
 b=icVvQsqj+NM84OjHhXO3Y9gtHV5CyAdOG1FUfoaDLiHRBh+Es81CZaILhw6jIOrmLJ
 ZqsHeyycwQabIIcnsoybvVej0iLJzeNeurBm5kBsd3eTcpFrcE4rxhnatf02nlaz8vo5
 fESn8fAfYf626VOwWkVxyumDSMf6M1n1g8GlR86vkseXa0rP8fq6uE5ZCqC8BcyIhtyS
 rCAYvwImD1f5EG2jqUry4xueZT6PTyWZAVbI4aciW95nf9YgHypkWmv66AZWUPoYj/E3
 bZHB1BfWFsE9iX3PAjvwpZ+EKV/jNT/7zk+e8G4ixS7e+JhvB2fi2/pWiibSCD9MmSK9
 skdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716132391; x=1716737191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gzhbCWF1kyGHTwsUR/MogQJbsziupHZOGRWnzgLfLrw=;
 b=SGC7HDVJBo6NA/PMLkvg73Nwti0wE99iPMT1cQe0Eo/Ffw1q1ZTqOa3YGLIauu70EE
 EqZbDTf7oTjfhrqpzxKTbj/UbPyfMHAPAsIJOz3OyuK7Bgtk6U5hxoF5IUT0BI8O9PnE
 SpdhThwwP8xmv74Ap4oBhUNBjPz+K09S+nEF+paAGIJHfq53RACNhVOYuaEq36VyWv1Z
 ioe70rDVwxiMGmKF5MPiQPpYPlaV5gr0is+mOSHKT4RF519s4gkOHZpR208oELzyZ+W3
 TUfVh2vOa+6q3JWD80Gwfz8cKvIfeofsk2EL3FQloLIxcQ0KS42Mwx7bln9nvl637wUl
 1JlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzrp1Wde8GeqXhubWSkhdcDX9Rd0Dd/owk+OyY9dxtYKMr73Bfrv6nc4sHpQzTP8Ff+Ru1Fo78pjSDdXC1Ki3O1Gk2j0U=
X-Gm-Message-State: AOJu0YwqVg7bWo1iA6hQGdQhbVZmEOu0DOS9+BEJIt/AQeSvpYBwWib2
 xWYJtnLi2JcylAnm6LxERHvC7GDtCaqKKQuHWGg2/N+obB0pi4zB6QcWyxqDDUk=
X-Google-Smtp-Source: AGHT+IH5MIFU+qpiCbk1aNRhb9IncP3XmrIH4IQChjew45UPL+uGfQncuCKqpIbTmnjXYZNbp5/WYA==
X-Received: by 2002:adf:f1d2:0:b0:343:ae9b:36e0 with SMTP id
 ffacd0b85a97d-3504a954dabmr18733586f8f.43.1716132390635; 
 Sun, 19 May 2024 08:26:30 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc334sm26862561f8f.103.2024.05.19.08.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 08:26:30 -0700 (PDT)
Message-ID: <c220a44a-5265-4003-b386-cc633f21d44b@linaro.org>
Date: Sun, 19 May 2024 17:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A question regarding TARGET_ALIGNED_ONLY flag
To: Michael Rolnik <mrolnik@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <CAK4993hFKoQh14k1L4cMrHrDzBn23D59aM-PQJ3pu6uH4qfsGw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAK4993hFKoQh14k1L4cMrHrDzBn23D59aM-PQJ3pu6uH4qfsGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/19/24 16:23, Michael Rolnik wrote:
> Hi all,
> 
> Previously there was *TARGET_ALIGNED_ONLY* option that caused all memory accessed to be 
> aligned, now it seems to be removed.
> Is there a way to achieve memory access alignment with QEMU v9.0.0 when I am building a 
> custom target?

Explicitly add MO_ALIGN to the MemOp argument of tcg_gen_qemu_{ld,st}_{i32,i64,i128}.


r~


