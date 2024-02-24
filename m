Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F686C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 13:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrsR-0006Dm-9L; Sat, 24 Feb 2024 08:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rdrsN-00062y-N2; Sat, 24 Feb 2024 08:15:35 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rdrsH-0003RM-M4; Sat, 24 Feb 2024 08:15:35 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so768673a12.0; 
 Sat, 24 Feb 2024 05:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708780523; x=1709385323; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oKbHXrrwryyGUnzL56T9Aq9CFvDNo3GnvRXArszKlXw=;
 b=OBvFHpd9DcI1mR5Ip1i/fq0DFHAz55T7ST4gVTca3M9uXXqSP51uEzbI5EgoRmeKjy
 IIFpLisAjBjrGufHnpgzmoMi5TCPgHrR18NaQQ6P2lxswMDP1t9atQ9pV8X68EFV0wVw
 Tf3NDpB9KGQhU16VFS+I+ifVaocgt7GyhZIWbIh/ft3hgcYBm9I/fzZN//r3yUgVXuqT
 zh9bu3H+npXsndhmVAXe0Z83nSvqG4Tn8GGUgFDS2qY2Nx7eAOwvNRB/bOlv8c5UYWKm
 Lchyd99APkJCCBioXBioiP4+OfXE0ddyaV143v4mz+etrfz4+olskHgHlSt+VZF+rWD8
 gGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708780523; x=1709385323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKbHXrrwryyGUnzL56T9Aq9CFvDNo3GnvRXArszKlXw=;
 b=UImG9NU4I0Jxg3IIN3qpCuwMxFonQD2v0zJeoYHG2b//YvOX6uc8yAOXlpnfDrViWg
 wmg/m1wC0FnpwoO6EBL0z5AFYbXrNPLXXGMMZnaPGmj6lQMesiTbFDGkBqTU58CVCV1v
 6OOJU3fgt94+KjgZB5tmv8R6TWjXd3UwYopXll9AcYUIVdTpz0yNQW2K+6gIWZT9W15s
 6gDHDOxxc4ohTDQX4+U418Wy8EqB2UcWkEw0PTLjtx6Y3nRCGTffhbGPVwkiZMSzE9IG
 pRzH1yLQUVjEa6QJLQ9agmlm4b9wLJBXkMzu365ueVyMLMBDxe3vNeYAqmoc/qzsVQl7
 0x3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo9omYHnym0ikcMLHV/xtvMUY7xWV9VZJx29+mJKZnpt5XVv+8HnYZEug3qWhUOh8k+vyDhfnnWI3/JTZj+aVc4uz4CB+us/5kIQKECmy8cA41Ppm0ZxzkW2dbgQ==
X-Gm-Message-State: AOJu0YyHU5PHIDyRM+gdSbPKjaEj/IcoOEGHczrG17FiHjqrCkSytDTY
 X296G0iZvW+XC7ejyaGrLqWefrPw2m3UoPQnoH+HabqYG2ShfkA4
X-Google-Smtp-Source: AGHT+IEl/3BLPptzMS8zyRa4S+36CeREYWkVi1HBdyB/CwF8xczjZ/9TRMOObRPItRkhzgLeKeLPCw==
X-Received: by 2002:a05:6a00:4588:b0:6e2:9ff2:19b1 with SMTP id
 it8-20020a056a00458800b006e29ff219b1mr2639668pfb.13.1708780523343; 
 Sat, 24 Feb 2024 05:15:23 -0800 (PST)
Received: from minwoo-desktop ([116.121.76.56])
 by smtp.gmail.com with ESMTPSA id
 g16-20020aa78750000000b006e45daf9e8bsm1087270pfo.153.2024.02.24.05.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 05:15:22 -0800 (PST)
Date: Sat, 24 Feb 2024 22:15:17 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] hw/nvme: fix invalid endian conversion
Message-ID: <Zdnr5bwJ/Lrh2Sdi@minwoo-desktop>
References: <20240222-fix-sriov-numcntl-v1-1-d60bea5e72d0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222-fix-sriov-numcntl-v1-1-d60bea5e72d0@samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 24-02-22 10:29:06, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> numcntl is one byte and so is max_vfs. Using cpu_to_le16 on big endian
> hosts results in numcntl being set to 0.
> 
> Fix by dropping the endian conversion.
> 
> Fixes: 746d42b13368 ("hw/nvme: Initialize capability structures for primary/secondary controllers")
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

Thanks,

