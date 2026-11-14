Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0DE606A334
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dABnvSxQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xS8fn-0004YT-2c; Sat, 14 Nov 2026 02:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xS8fg-0004Xl-GL
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 02:59:37 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xS8fe-0003KI-Sa
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 02:59:36 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e987a2ba0cso9465455ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 23:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794643172; x=1795247972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0rwWj9gIUdkkDpRP/VYAqHreahRQc9G/zfbFzVC9KrU=;
 b=dABnvSxQPbIGnPHpFA+vfCBmOuj/i/jkHqiU5ZSYc7AaxaloTqsyXqr24V8VeUuClp
 jJXUz/OjMkYmTNbSmJUdEfC41/SV2XMb/QPvGsZji/QReLuPEtvj1hdzLhzvUsaIYVYd
 QJk0V5WK3y12xGXdvZrd5Ku62J7kLWGTcD9jmBOakX5N5pXzng/sbI7OoRDbAQQ5PKrg
 gcobRKsn6Cfof8ZfK/W/k2vS62ukiJsa8Orzl0lb2Wx28NgZQEBaYvGdBnYPpjv16gfr
 tt5NX0Fs21yCng/NgkyxHmfmnsDU2YR29WyADAJNLNb1uvaSYlvbVeCIykMKl5GwODuE
 eX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794643172; x=1795247972;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0rwWj9gIUdkkDpRP/VYAqHreahRQc9G/zfbFzVC9KrU=;
 b=sFVG5uXuQSvfZxOMKz8PlahgTkgP/saZtXWf5rbFFEP1t+TJzmv+VOpIRmCxz3AVy4
 d3+OU0vV99Ws1V4maDZb0J6A73JphZW0w59HWJtYnTKX62De0kVNfa3j/IdtHaeZPeOa
 4CbI3HXtP+Yg7nSKaQwBoh5QyBlWZL/Ure23otGByRbBpeULbScTPUtMS+DFeix2+e8s
 SMbtUUU+92bPUOEbwsowV2Ojdrs5NIcZRCRt3f6oqEZ/qFdRMMdYZe4AtXi5Hudl2GoP
 Xi7cPzjB/lqaEM9+uodNi3HPRVEBmYyICxjKqJFt0l5/3ztneWH65i2mVUpK7St9dw9r
 9xfw==
X-Gm-Message-State: APuU4Z8BBcDG12//Elwiz0WZ7a/k/qCuYhUpnEsR2ND02WOcHBdXAHza
 lVCd8Uovou3dThL55cHWA+GwnzOKvjVQWbcn5LFKmPgziTDygaKGv8+r
X-Gm-Gg: AYBFou05EZ7LWhWbwQyO7zY0+qieIcu0hgIKicgz7xqux8FjBFEDOR8/nKgn0AyvB1S
 N6rBTTatQC7OSKN1wcXq02gpNh1J2No8ZpKgBh1pNfxbaLi6z2XG0d2KjrrxccF9DyUbMTtxWxn
 7g+28/xvqmjBjOWLZwvECFtzexWU1W37LpMfyYyzbsgd8JZf4NadcU32HruEv06e0DFeCWFCjZa
 t8NhIqN+sTUVYgfKGZjJY0AuFFil5PCes66koWoiLksbdFmnH455N66eG+KPZUqMSYfCYmeCwrw
 vyaxsIFXTkZa7wo2ZcVQWh3CykBgwbJYQkP7Ns8zc8mMpIUOewRYnj68vQxFRV/5kXe0d9Qh1Rf
 apTghw6/pYkQ7/hdXSgoe2PimqtHf5vVlal3bRcRi+jTZgM0gsezkayKugJMkzi5l2nYG8CU7Vz
 Jabzro6UTWOldc6n5Aokljj7zyGqp4YVpxf04xvPepyxwXQrCGJqQk9pUoWsdt8Dph6P4Is5t5v
 KA8WcqscXEbtpCwU76f1LV2Pax+LbMZOt5GV6qcHPBWUSKACt81US9tcRLHzpGfeausDV3LYNq5
 tQxDIf4AQvBn26B92BF9z/gKCudkuCLiV9R8ryM=
X-Received: by 2002:a17:903:22c1:b0:2e8:6ae2:75db with SMTP id
 d9443c01a7336-2ee0dc05d7bmr44955275ad.41.1794643172507; 
 Fri, 13 Nov 2026 23:59:32 -0800 (PST)
Received: from zhenbaii-ubuntu.. ([2406:da18:17db:6700:d3eb:66a0:6641:5037])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee17e14e5dsm16169815ad.4.2026.11.13.23.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 23:59:32 -0800 (PST)
From: WX Chen <wxchen0913@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	wxchen0913@gmail.com
Subject: Re: [PATCH v3] target/riscv: use gen_goto_tb for vsetvli
Date: Sat, 14 Nov 2026 15:58:02 +0800
Message-ID: <20261114075803.58854-1-wxchen0913@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <e54b27f6-7130-475c-b2b6-b7a477de48b3@linaro.org>
References: <e54b27f6-7130-475c-b2b6-b7a477de48b3@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=wxchen0913@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Did you mean TCG_COND_GEU? Surely dst very large results in vlmax.

Hi Richard,

Thanks for the review!

I think TCG_COND_NE is correct here. The `dst` value actually comes
from the previous `gen_helper_vsetvl(dst, tcg_env, ...);` call.

According to the definition of the `vsetvli` instruction, it will
set vl CSR and copy its value to a dst reg. The value of `vl` is determined
by the relationship between AVL and VLMAX:

AVL <= VLMAX:
    VL = AVL

AVL < (2 * VLMAX):
    ceil(AVL / 2) ≤ VL ≤ VLMAX

Otherwise:
    VL = VLMAX

So, `dst` here is either equal to VLMAX or smaller than it.
That's why TCG_COND_NE is used here.

Thanks,
Chen

