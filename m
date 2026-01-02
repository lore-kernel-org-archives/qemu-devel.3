Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD81FA3753
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 16:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbi1c-0005B7-3P; Fri, 02 Jan 2026 11:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vbi1Y-0005AK-Ud
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:29:12 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vbi1W-00022I-O4
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:29:11 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8b21fc25ae1so1231762885a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1767371347; x=1767976147; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lTOZGvT6mwk1lhfENg/flz4GQUJP9RmbTo/K+d9Dnxk=;
 b=Ggo+yn6bCHfBcKw+wQ0IlJ5cWrejniD6/l0Z5oef8bfwLj5MLmVO/z4x10vs9x7hnK
 brQSK3EhOP52MpKv6Wb9Lu/UcFLg5Ew544kHHXOACIJRJ+rXQUIpUAZtWIBNmZxBba13
 8ATLUlJCiZAJftYJHBTxOVE67isrhynSapp7g2ZBLvurIjFkUXmAvDa4lg7syT/YZZfE
 Vxk4IZRze6yDPfYLrJJaFmka7BKNU4dQhBJrL529PaVjdeSOZWYFcoSNxPrivjPO61Yn
 24WcLmczKgjHq4ohscKbMO6jrt1nhwP0r2VTCrz6hBkOsvlU/9M0bvLfHe2w31x5oQxx
 KFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767371347; x=1767976147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTOZGvT6mwk1lhfENg/flz4GQUJP9RmbTo/K+d9Dnxk=;
 b=guUnPyjvNaLfYr+XXmBwN8KjC16+uXukWnnn1lNQ/iFuJinedVR3XHoPG9CE9XSKid
 XWYrdsayHyaVOIx8gzNagZhwSqvmGvE+ONL5z2S6PdQOn4G0XbJwpJLClLCmWWDCsKQL
 QwNJFBU0FtY8hNOGiMJJ3E+UI1i9tD5ShB59L2N0RXuzoxxuTWDLmObAKjBYoRdISDQG
 JC+G5bp4T3YyDTgBTK3cKtvwq0BB0Z6ZPnJOcZZGAn9i0mQJvBx0U8wS3K50p2mXmzLv
 zn+MohaYhtrn3EFV0DL8iYM0bLDtUTNDpC66fZ1wE9q/khwR4Ht2ncpn7NVlfnqmtfUp
 ui2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVRKe/H187P2SleTK+rGgcJHDlXJy6ldqKgk8xFwAKf0pQXOPzrETNWKvDaRs70CXJkJnJxOjaBHRd@nongnu.org
X-Gm-Message-State: AOJu0YyN/7D0ESG/XQfLvbvg6YtOQmE0klVmB0v3gCXmRraNPOjNoaZz
 zNIs/SuXwOc4BqqtQs/KaKXk/wBvAMGM0MKxzirRllqDvepHqTOsQi7K0CW9xveUOJE=
X-Gm-Gg: AY/fxX59lirBymnBy4HLVkyOuOS0mp4m8LoOlBbskFAwdQxrF3aVH7QwprJ8Mzr6OxQ
 L006Nf+TLSzCVrSa29oSb/Y30REQILun5r85F+ydroTy7e3+KfeSI1DbinXZ2oglHxeXvcY6CMP
 VEgJ77e7NrW2r73gz2sbwQLWN9OkNXXZW8PMJjBE2b2VebPRHE+jrFIAtzB8ZPCsdJ1vZBucy/J
 om8g9UvsBEL78sLCsxWf4CPlvCuafAjQi+/+hPo/cf9ITtRGG0J7tXSmtRw67Av09H2mG5PKHoR
 /10M6k93jghiRcmMEToC0r76Yp+N2rLW7g97yDB21u1pWaQT6vjbaFacOQjGRdUaF/qfXCClZvL
 Y9bqVs4wgjTP4SyKveXJBuEAjqgC0N4TFeM7MBbYBYk3VDoJudG5ZKW4jGC0Ktnfw21RiEgnCTt
 Q0ORcHCGSoYDX0C2ZqRFcouuNBM3hUvFEP6hGCUAgRDX/6GdJGXL6n6YO5DPUiyQdeu+QFxQ==
X-Google-Smtp-Source: AGHT+IFwuG/FMIJNZ6wu7h6lz460Uqaur5cNplaEW3dJ4PizHDyTUkahxwUour76aUG+Tz92ncEhiQ==
X-Received: by 2002:a05:620a:1726:b0:8b2:5af3:7fe9 with SMTP id
 af79cd13be357-8c08fa99a33mr6675810285a.55.1767371347548; 
 Fri, 02 Jan 2026 08:29:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0973f0807sm3189752185a.41.2026.01.02.08.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 08:29:07 -0800 (PST)
Date: Fri, 2 Jan 2026 11:28:32 -0500
From: Gregory Price <gourry@gourry.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 david@redhat.com, jonathan.cameron@huawei.com, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <aVfyMLTBmnUR1BHb@gourry-fedora-PF4VCD3F>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <20260102140922.456f599e@imammedo-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102140922.456f599e@imammedo-mac>
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x736.google.com
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

On Fri, Jan 02, 2026 at 02:09:22PM +0100, Igor Mammedov wrote:
> That will let us later to have mixed memory on the node 

We were just discussing strongly-dissuading such a configuration from
a linux perspective, even if it's technically allowed.

If only because it makes reasoning about placement policy on such a node
completely impossible.

~Gregory

