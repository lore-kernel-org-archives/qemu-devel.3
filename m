Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6921FC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 13:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtonK-0003Ei-AL; Mon, 08 Apr 2024 09:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1rtonG-0003CN-17
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 09:12:15 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1rtonE-00005I-BZ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 09:12:13 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4346e50ef62so15588571cf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712581931; x=1713186731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pgrFrBQO78cdY9i+K0Diy27ZfHZVfkTPqTJibFJRfuk=;
 b=hwmkFWrEiPgPQjVczl3RvMds4An22PhViJlfrzFTSjXUewa1X21HwZdQ0kFlw3t9Xk
 E+2GChrgRl7s0hm71YXuVw3F24Es73gcANGlmVWIRCbSmf2UDSiWQuqdN7DhR+cdFj5z
 zgelzQbhLdYpv0WQR6kjaNaCQliC51iPlTFsDOCEOMcEVxYy4KIDGQKrLexYGDOY/3Iq
 rOYbXFNgA55xjnxFjnW3+mB6yTwF3e+Vt4OYxpDHfy/6rPcaYEd/MnLxou8EVWW61UL1
 VY5lgP7K13m0ZkmR70G9fOctDVnGWH75hm+EmV0t7+7MvWEvZdOQ2jxmFpCZsH9GxUuO
 vkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581931; x=1713186731;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgrFrBQO78cdY9i+K0Diy27ZfHZVfkTPqTJibFJRfuk=;
 b=oGIUCQWt8gVkFCTO3ZtdjZi5Tpe2xWgZvfjZL7jdGNapunJIpfIi6tzwSJ13WQ4AmZ
 uz/qYjixfSdV4jJoeAbiBKZpPbOhek3PfXD8v7f+OutOWqQnwYFCpr65k8bT5hdpFYc8
 JxSTENsWdBpScM3IdxyOHNNH5dUVqst72gEOVmfbTqCdh3bVvWI4NEBdZtaDSsYxSUgf
 eVAhuvFmYARnrASN+2aLqV03mMyFZps6UJrlbkbaEYCJhtiyEAf+DxJ7RHtTUFTk+Nkd
 SWykHPV5+7g/JOp4H6u5dIX1PG4q+PbzjauCFYVKKsHySExBbZkAtkexIvujsdMMdi/H
 3Kwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXfDIW173P1YdWTv72o9mRJIHPWn92hNDKKHv9zlHxsr7ESzvE+svwpxWce1F6JW+AlG9SU1W09fnbYXAje1OSROBGcYA=
X-Gm-Message-State: AOJu0YyP2SuCqQZJDLFhFOWxBXEPOtbEC8iar4ZV+XsLQdDSAvQvrFwO
 LMTvN7mSVRRnyHgUt0xi44v0rd5ulig+4AuEe8vLw5a1TlvtkXxW
X-Google-Smtp-Source: AGHT+IFzyKXfFNcAq7GRRtXhaHFGIb+ScU/yAlMXeV1+dY/ujzqnSZbIVS4TeYP5N5o0569KsZkwVQ==
X-Received: by 2002:a05:622a:118c:b0:434:ae42:caef with SMTP id
 m12-20020a05622a118c00b00434ae42caefmr3054245qtk.10.1712581931265; 
 Mon, 08 Apr 2024 06:12:11 -0700 (PDT)
Received: from [10.95.144.96] (54-240-197-228.amazon.com. [54.240.197.228])
 by smtp.gmail.com with ESMTPSA id
 ir13-20020a05622a6dcd00b00434c25cb61bsm185792qtb.73.2024.04.08.06.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 06:12:11 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <90398ca3-6866-4e88-b16d-48eb3a47a9a5@xen.org>
Date: Mon, 8 Apr 2024 14:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
To: Ross Lagerwall <ross.lagerwall@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
References: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=xadimgnik@gmail.com; helo=mail-qt1-x831.google.com
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 04/04/2024 15:08, Ross Lagerwall wrote:
> A malicious or buggy guest may generated buffered ioreqs faster than
> QEMU can process them in handle_buffered_iopage(). The result is a
> livelock - QEMU continuously processes ioreqs on the main thread without
> iterating through the main loop which prevents handling other events,
> processing timers, etc. Without QEMU handling other events, it often
> results in the guest becoming unsable and makes it difficult to stop the
> source of buffered ioreqs.
> 
> To avoid this, if we process a full page of buffered ioreqs, stop and
> reschedule an immediate timer to continue processing them. This lets
> QEMU go back to the main loop and catch up.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>   hw/xen/xen-hvm-common.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


