Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F446F47CD8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFtt-0000hI-L8; Thu, 05 Mar 2026 16:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyFtq-0000h9-Ie
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:06:26 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyFtp-0008L5-2e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:06:26 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8cb3e0093e3so819717185a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772744783; x=1773349583; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MBoEe4xqHc/rYoJIP2sBLmEhvLGIur2FtJK6Q+1QFRc=;
 b=f/LFSua15dA65IvKyl0KBSoqAPOkRQ2knIM5N59mcQg7tlSSsgFjY/kuN+970ipeE6
 tgXlBp/rOvIK/D9pqa6yln87lOqNwBPYAgCOBaKd6STAe6uoNRljy7+VFkkN8WIUhCN2
 DUM1SzuWvOvKOo7pRyeLd6c//nNYfTlzTYJ3wkB6X5zFqDYWs5mTdN6MmIEy3GX4ArWL
 yZNm72yz53uweIlMyJEAGC0SpYhQYBYGeENMh+hX0E3D0mOTE+txe06L5vWNeoVwXrTF
 ZUwvWl83cLGJxhUdcRblZrWyqxrxnPx8sSmhmZKWvS4QAavxA8ZN500lLZ/GiJo45U3O
 vbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744783; x=1773349583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBoEe4xqHc/rYoJIP2sBLmEhvLGIur2FtJK6Q+1QFRc=;
 b=hYx02w2Jecof8yi+OwlZF5pl5z75ZyO2UUyF4alptMtlNrpr7A06hUOo+TQEWMk1pT
 3FfTtCQcweFWQxvi3IJGFFldQ+s848gx7QcbBp9Pqk+9FpWmTzfTJAFAirvWyspdhy+J
 rPFRiMcTKAMMPGLyhPNsqineqwrtk+fpjX8rUN5NhnE6La7SR/zV+aAznDVEZp2XpWT2
 YNPkP31k6dw7tcvGRMVlXhIZIK9tsNxyE3Bs9aUyvWKFJUYZthKKTVs7ZAjY3xwYheTZ
 7ux5AAQPAiIadjWdEjVUZ5G5gQ9UxX9fmG5RRoybHd581Lujr47Gv8hOGHf0UvLEmXAV
 RS0Q==
X-Gm-Message-State: AOJu0YwTAe/wsFDqzcai49UsZlVtfJUToLaanPJiaYgU+7zZDFAH6q7w
 wnfzStN87xcW8bzRjAHaWHvmFnQfQny1FTyoaCks6L3+rKYPouWWTjSvudgPPQIhCZpJpYFjad1
 SLnOV
X-Gm-Gg: ATEYQzyOOAKb01iLNESq9PQlvhOb2wkk5RJ/wK6cxjrlyxXoKHDOXG6UMYttBAdnTME
 9InyxeA4v7iOTIFE0ZcvkmR/tdIR0jh5kinr/JszYhPci7BfiaiTcksbcRSYKYq3vGw6Js8dZIK
 btp2WV5lmPxv9+fI49uOHFQnjg/G2eShb4j77FEMm2HRQDSZKmiwbU3ad6AJ7I8p7Djus0qNlWn
 +ylJuRlt7ZlNLnzM1m6ojI7WwYVi61BGVDwrfyjfqEZL9uSoPv+2icvUQqNH2cGa1eh9tahJGF8
 Q0Ol3PjUnSVktIw4e7B8syJcP+RyhBBCIcuwQzUv9iyULaXdjMCJsbefBijDF/wNjsX9sUpDKlp
 kWCzNOBxRHH35qn/si+ampo1gvoSNrIeuX+JpRzrKkUfEsAImSjrNuOmzOctxthTaHcDznlcAX3
 5OyUbxkkFTliH1WthFc8gWz+fxXIL0mEZ9oWcUsyi8hTZBPzq8pMIMR7xMiNIXi+p73Cm5W3vhX
 HtUv+D8ow==
X-Received: by 2002:a05:620a:4481:b0:8b1:7c0c:e27f with SMTP id
 af79cd13be357-8cd5afd2140mr767391785a.82.1772744783468; 
 Thu, 05 Mar 2026 13:06:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm1921875285a.50.2026.03.05.13.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 13:06:23 -0800 (PST)
Date: Thu, 5 Mar 2026 16:06:21 -0500
From: Gregory Price <gourry@gourry.net>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, apopple@nvidia.com,
 dan.j.williams@intel.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v6 1/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <aanwTUHMIh5cJCiR@gourry-fedora-PF4VCD3F>
References: <20260226105023.256568-1-FangSheng.Huang@amd.com>
 <20260226105023.256568-2-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226105023.256568-2-FangSheng.Huang@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x72c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 26, 2026 at 06:50:23PM +0800, fanhuang wrote:
> +
> +            if (addr < x86ms->below_4g_mem_size) {
> +                if (addr + node_size <= x86ms->below_4g_mem_size) {
> +                    guest_addr = addr;
> +                } else {
> +                    error_report("NUMA node %d with memmap-type spans across "
> +                                 "4GB boundary, not supported", i);
> +                    exit(EXIT_FAILURE);
> +                }
> +            } else {
> +                guest_addr = 0x100000000ULL +
> +                            (addr - x86ms->below_4g_mem_size);
> +            }
> +

I missed this on my first go around

Should this be:

  guest_addr = x86ms->above_4g_mem_start +
              (addr - x86ms->below_4g_mem_size);

Or is there a reason for the hard-code?

~Gregory

