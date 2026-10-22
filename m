Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3264606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F/PslWKz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrVK-0005vG-Qa; Thu, 22 Oct 2026 08:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xJrUy-0005rk-Q5
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:02:27 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xJrUs-00010o-44
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:02:18 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so255177766b.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792670532; x=1793275332; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pWU2Xl7mPKw0ooG9GxPHWEB9HXEjzbVoSU6y6PkyIis=;
 b=F/PslWKz/4Ru4Uw1r5DG23dtAG1UjW3x1wo+Vt7ydoq+fzkWcbEe5nTX02gw7nxbvy
 ouFAQej20iAtdVzjdJOKd4AcThn+wu4KlFS2HFLpT8P+r9wKAqitEwRD19f72ppM0ZOu
 HL0aLB/aXU2oU2y/O/DwHDPrObWxaGr992Yv9XZe2stjow9xKg989Dws55Y6SpowB/e1
 3aZWZcfFAHoPwZR1jpIdXChb3m0ikOxVbXFIFENIAnc9NFsdzFOMleoNsIwvwaLgu0Hw
 +TyJUWiGjnZjI7dh4lHVG156q2xyiP6xHxiXki4J5uCDBbk6IY15sPCJiTneaJxKcl1d
 10ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792670532; x=1793275332;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pWU2Xl7mPKw0ooG9GxPHWEB9HXEjzbVoSU6y6PkyIis=;
 b=BLq9A8SPTjtUioITPbi9RZLnMGfxkOvnG9L9M4c8Ofyivjmti0V9tq5XiOxCb5e78z
 8VNmorXyzCtMB+IEvxU+VGy7lvFcPwx36PrbIACU9pQmAsI7ns6QZGWxDRHim8rLgY0r
 SbvE6eIchc3854cE4CtR5LaQvQli6RoWpO/x3vjyQXzaARdKK5REJ6Zd3G1pfDS3RJLz
 04ZwSjxebteCAQ+0o0TsIGpQYY1UGDW27Gl7F4T8qPoAGkC1huJiiGAGKKTtFRc1zo8D
 hLRzpem+aeGyKLrxu6KIUw4HTAhgyYz1sHHTe7Qk1Z9G+3aBGIzHVlbjWLoic3E1+t4B
 nSaw==
X-Gm-Message-State: AFq9FYJzvzgZPS1bAHRTvhh9bfri+1jLLOslvLIBfrAUFQtH1iVG7IT5
 aVIr99dFWQpuh+xj7K+/1hxL4snqxhkXTjDuyylF0qYoQMp45SZzxa8agpSRs2/AXF0=
X-Gm-Gg: AYBFou0M8FxbrFm/EvoB+Wqf5ow65w0KcLkglg0zWKqtA2+V23dgRKAupuMz9+Fbxh/
 8/Ql7HOhnFpXM9c7JEGo7Y82mhCziEKPjv7D3nSYr7z23AQ9HJzUBy+uelOZODeeLdd5NG0zeJa
 jMVGZGRTDv/J8nATnxdvbZeh99KMvbkD2AYPIIyWrBqX9lFyJLFdRHTEdq4/e5KMfkAZVQaLC5U
 rxZJRXs0hzEEq8dUa0/bh6DZjJIp+MlJ3VDf3DlZrPECfdACUGUm2V1QNfVmAnITftGmdg5LHFP
 5sKPg+Xwn+jMtWpYWLYi2bcbXSKzqj9wxofsSK+QqOWcDT8gHRehtYkO0rqjttEcW1jpeHcVCGV
 dzgvKRq67LBqvzbT/VKfSBx8prk3KEYc6Bw1uhsbfYfHhy+ro29GJiL2zFK++qCu5fevrF/fIw/
 cA/5w5Ssfjo1ibR3owut2/3XYk3QGpI4UrCO0ABfT5cnP/O8xA2vAu1L3WzS45f+uQZt3Tg3iZ/
 BWay+s0BpHbj1bRB0gd0QjByohwfFERZ487Pr3dq1Qk3KWtfoQmZfaNoAdR8QnkuzxA0Kax6bN2
 EMInTlxBu5KxrzTFOB13L+iIeSx+BB0ZQVGBe//eWpPlc9KGliemYA==
X-Received: by 2002:a17:907:944c:b0:c2e:2baa:a642 with SMTP id
 a640c23a62f3a-c46796530d5mr508422466b.30.1792670531869; 
 Thu, 22 Oct 2026 05:02:11 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a4ffcddsm96172566b.14.2026.10.22.05.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:02:11 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:01:40 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] qga: implement 'guest-get-diskstats' for FreeBSD
Message-ID: <atn7JNVVVEWldZuV@tulp>
References: <20260901192732.46190-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901192732.46190-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Roman Bogorodskiy wrote:

> Implement the 'guest-get-diskstats' for FreeBSD.
> This implementation uses the devstat(3) library which is a part
> of the FreeBSD base system.
> 
> The build system is updated to link qga with `-ldevstat`.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
> ---
> Changes since v1:
>  - Replace the guest_diskstats_append() helper with a simpler guest_diskstats_info_new().
>  - Drop the unnecessary condition for ios_pgr.
>  - Drop the unnecessary guest_get_diskstats() wrapper.
>  - Jump to error on devstat_getdevs() as it does allocations.
> 
>  qga/commands-bsd.c   | 120 +++++++++++++++++++++++++++++++++++++++++++
>  qga/meson.build      |   3 ++
>  qga/qapi-schema.json |   6 +--
>  3 files changed, 126 insertions(+), 3 deletions(-)

ping?

