Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7637C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 15:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbLxV-0006ZS-BM; Fri, 24 Jan 2025 10:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tbLxT-0006ZA-9W
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:50:59 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tbLxR-0006cK-Fg
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:50:59 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7be49f6b331so223019085a.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1737733856; x=1738338656; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=61trCC9x4jM90qFfnW/HSs7SoO12eYgtCwi7Oo5kifs=;
 b=Vysm6dQU8YA058SsdxrbKj6j3qCpnKN5+fN2g1cZEagNiNGgwyC80AV3tZ4eNibuOM
 lCBD7umZj+tWFkN5+qZSHhOl7aVce8U6clEVMc9PftjVpk1sM+gu5htpBWfmB2pL+Zj9
 A1dAuXt4hvNaj4ed1m0jTPxzhNWwsnpqa7Qm/hJUV+Z78byqFuNAmwzHq3mep8VhAZyg
 nV8C1lsV7zab0/XL//ut1VosQs0DrhfAnQ78CdMV3sV0OeIwO6ojgJZgbmebwuTxmqv/
 +CWUmOhI22hUhag5Bn5DChIWseBYNrJHZbTvzeKzHkaLjB2NRsgdgQDr5US+wb0kYUtE
 sSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737733856; x=1738338656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61trCC9x4jM90qFfnW/HSs7SoO12eYgtCwi7Oo5kifs=;
 b=hH4Q31ybvy0a7rlafTEhBjXTGc5WmaWO3EjQSaCjhTrgMT6ghNQykv8v5u4eHilduD
 Q8N2kZSB58fxILlcieUumWelLFI8NczX5uva0DXXWgd97eq9duhYHv4tO9XRj3/yPgpV
 80fSZUpRuS8Tc2p8zhHXgBFfGkarvEZD0QkUi9XXaivf0q6y/ddLBPof4VGS6AGMmzMN
 3vjZpIboahGwOUvsmPcxDsT0npEQyvbCKdZgUyIHdCFIXtxnDne4VB60vMtlKQoDEIms
 +L4q6oB+9w/2U45WQEvPmZiL2MWbMyBtZsp/xBm1R6cxJQG56+DPffpvUrpzspVPli5+
 AYbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULSxWX5/nls38FIT2bOBQIb5IxILmRrJOxuWHdz28cYZuyhqTQdbe+OSHQXOWPEN2jDhjUalZDeIrU@nongnu.org
X-Gm-Message-State: AOJu0Yz23AnUVcZX10lxJ2wQyZ8zi2peFaX0V3vtDszV8oo4U85MfAwf
 yihQkYZ96MkXYRyFw/wYb4FK6Op5UWP6yp63lRKAhFQU2OsLYzfuvQ1kavStIHEYOhRxczCeeJO
 n
X-Gm-Gg: ASbGnctZ8o50KMbZPfYdVBy5xKgEt4v9lIr7fA1yz+u7MtreTbiJmgWAh3f2JcZ6FQh
 3YYkqWi8jbR8L1xa+wuJ/KtD2xSCIsXLu3Ei70vJBWfEK5Jztsk4c4mp4jGgXfN/2qt6suMKjvC
 frbHZ86KrxVYOmVbSD5xbzmPxX+KYY9YHmE7qLSO7Si3p5fdDqPy2EUD1T/2JruEYEbifHy6sSy
 lu9j7UXmbJvmzhWoRQVwX17dXIvKv81yvqnzVSWuzaZC3nydDpmAYpvcZnzXvvcReCTYBHIwlpA
 XZn1rv3K04bAwSXgxckaI4nG30UgJaGpAo2mwDfqvMrRSkErrLe5wSumfEGjfR0=
X-Google-Smtp-Source: AGHT+IH6B6I+3rbq6Tn6tyUuzkiCv8vlO406YC2L0GZLd6JAwgeHpirp6HSaWJOWXBgWXV0MtT49WA==
X-Received: by 2002:a05:620a:472b:b0:7b7:142d:53b8 with SMTP id
 af79cd13be357-7be63287a97mr5504696585a.53.1737733855791; 
 Fri, 24 Jan 2025 07:50:55 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae992e7sm105520785a.61.2025.01.24.07.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 07:50:55 -0800 (PST)
Date: Fri, 24 Jan 2025 10:50:53 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 svetly.todorov@memverge.com, nifan.cxl@gmail.com
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <Z5O23R434TcP0fMo@gourry-fedora-PF4VCD3F>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-4-gourry@gourry.net>
 <20250124141246.000040b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124141246.000040b0@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x72f.google.com
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

On Fri, Jan 24, 2025 at 02:12:46PM +0000, Jonathan Cameron wrote:
> On Fri, 18 Oct 2024 12:12:52 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > From: Svetly Todorov <svetly.todorov@memverge.com>
> > 
> > Using a shared-memory bytemap, validates that DC adds, releases,
> > and reclamations happen on extents belonging to the appropriate
> > host.
> > 
> I'll carry this on my staging tree for now gitlab.com/jic23/qemu (latest date branch).
> I'll push out a bit later today.
> Few rebase related changes were needed. I've not tested it yet.
> 
> Also I have dropped the previous prototype device Niagara on basis this
> should give people a better platform to work with.
> 

Agreed.  Niagara was a good step to get here.

Let me know how I can help.

~Gregory

