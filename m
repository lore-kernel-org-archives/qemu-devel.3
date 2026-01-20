Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7522CD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viD4x-0001by-6N; Tue, 20 Jan 2026 09:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1viD4T-0001Ow-28
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:51:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1viD4Q-00007L-KL
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768920660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoACEDNkFlXzoChXLraeiX9PL89XSvoNlQcmvRvpFug=;
 b=OybAiJtAPTZLabuIDC1iBkT1Qq3CMRe5XsvGDz2iaQb8TI5Day27pTC5dvFvqEmHhSrVqy
 j3uZ2UsGA+il6P9aQWgcY9aNenVVxE1H/kcHAaooMtKQ06G/WjjoOSp3NPFGVImr9WMYKY
 R26Y2sCpAmE3cfIblvK56884FGuj5tk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-gSgW3csCPx2KMwDMDlGqvA-1; Tue, 20 Jan 2026 09:50:59 -0500
X-MC-Unique: gSgW3csCPx2KMwDMDlGqvA-1
X-Mimecast-MFC-AGG-ID: gSgW3csCPx2KMwDMDlGqvA_1768920658
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso50896035e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768920658; x=1769525458; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yoACEDNkFlXzoChXLraeiX9PL89XSvoNlQcmvRvpFug=;
 b=ogpY+VXGRWN7jDnF/BOLMzDlc5D6gQBqn6OCjTpBWGMAZHGnJa87V2J96BqesbzhI2
 0aZ3BR4Ylor69gr1H4NX+b8/pbx+K6ya2zl1e8khJerTli4wRoUfVNxV0LMK9V4KNcXa
 Z7YqZt3U9RlEvnzPSv76qClKdgXrqq1+rdK288Mk5L8D+4E0Qg3kJNzP/os0ABt57c5/
 AHQceajMYrJS+jFNqT6jSGj6s3DcRIcWaCBC2WD79wDwItU/FsCbqFP1WQlm8KH07GGW
 kfu2dBl+1F9XCjP6itp/uM1wLpL8Hvm3f2F/DxHZXJK/fJZStgYQ+SBZg9+HqWKrGZNr
 NCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768920658; x=1769525458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yoACEDNkFlXzoChXLraeiX9PL89XSvoNlQcmvRvpFug=;
 b=NeCJK5IRa5aZAUKovWqInmI/rv/TAkya7p9k70CTaLcX7Qh+oPUc1yXbh4g/RUA/l6
 TTeLTVv63nZcYFsAHCB2yEcKZ7xA50gnSOVHUDyCoTroL7AGoAoMI5ioxlul0DmT64EZ
 zz5TDSg5OM5GmtSXvEs1ivuJZ5Sm7kATnemBrB9j5Qcd6Z28aZ1ecdG7GvYLflkCkBjF
 w8QrgPo9eXqqj9mxfbMt5YYntumAZ970UELHZFVfa+dcZicl+wOjQ9gGmfAnMacEFm+h
 BHAKmY/d25V8B2jOsmaCMHvgiz4jZlEmjNC5zPhSMSpeKFDmWEXI0g9IMj7whTZoFdS4
 G/jQ==
X-Gm-Message-State: AOJu0Yx5NusxfZCh/I/s1/OBEjgb7x9kqOhejYd6PIQDopRf3cLnYsQB
 CYf7mSe+L8fYsSw+8YQZfxuvVm4Gn4G25VJ+pfMj0745TGY/u/KQF4aFDdInLFi69Wo1dntyXQY
 SZ1LCdtvgjFJ49EH2nfU35ZxlX2YZ7Own1b62tQPxhreHivECkANgqN86
X-Gm-Gg: AY/fxX4YG7LPgcCnVIdEfit+0FVoBC5oc1jgtfnyybGGjZ+6gDGk4nBrW7YuyYDY5up
 V7hKrzVOwp5giGS6vlcK8yFgSif/+HsGQ7Aw/6JCIGk1cLJfXGweoUpOU4rG5T19OU1X5zdK0FU
 qADXWaOkUz+ig821rw3J94CC8ZV6esykz0r7tEVcGH1rvN35S7iXc/bvFeAc3VaioI5c8n7tbFC
 ANGYOOQZI7EJ3fgrCLZ85I9vSXyCyhml9q+ZpxWRkRHvPDvwdpV/wR/udImzYGzmrQtrnaUHnpc
 c5y4KgggUBUHyrdTxemoixXuDc4MDSeTWRNlHWGHlLinT91I8sGNuTcLusctxys7YcceIJal4JX
 jiCgPENA5A8NoTK0=
X-Received: by 2002:a05:600c:8b75:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-4803e7e8531mr31560985e9.22.1768920657857; 
 Tue, 20 Jan 2026 06:50:57 -0800 (PST)
X-Received: by 2002:a05:600c:8b75:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-4803e7e8531mr31560775e9.22.1768920657406; 
 Tue, 20 Jan 2026 06:50:57 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997df75sm29995689f8f.29.2026.01.20.06.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:50:57 -0800 (PST)
Date: Tue, 20 Jan 2026 15:50:55 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2] docs/system/igvm.rst: Update external links
Message-ID: <aW-V9HJspxXbQH7K@leonardi-redhat>
References: <20260119-igvm-documentation-fix-v2-1-b2f6174e3f4f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260119-igvm-documentation-fix-v2-1-b2f6174e3f4f@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 19, 2026 at 03:25:43PM +0000, Jim MacArthur wrote:
>* Fixes link to AMD64 Architecture Programmer's
>Manual and bumps version to 3.43.
>* Updates link to buildigvm to new home on GitLab.
>
>Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3247
>Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>---
>Fixes broken links for the AMD64 Architecture Programmer's Manual and
>buildigvm.
>---
>Changes in v2:
>- Changed link to buildigvm as supplied by Stefano Garzarella
>  <sgarzare@redhat.com>
>- Link to v1: https://lore.kernel.org/qemu-devel/20251230-igvm-documentation-fix-v1-1-865750a66cc8@linaro.org
>---
> docs/system/igvm.rst | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
>index 79508d9588..9db8ae43d2 100644
>--- a/docs/system/igvm.rst
>+++ b/docs/system/igvm.rst
>@@ -166,8 +166,8 @@ References
> ----------
>
> [1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
>-  Rev 3.41
>-  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>+  Rev 3.43
>+  https://docs.amd.com/v/u/en-US/24593_3.43
>
> [2] ``buildigvm`` - A tool to build example IGVM files containing OVMF firmware
>-  https://github.com/roy-hopkins/buildigvm
>\ No newline at end of file
>+  https://gitlab.com/qemu-project/buildigvm
>
>---
>base-commit: c1c58cee16380f81f88fbde6b12f247b376839e2
>change-id: 20251230-igvm-documentation-fix-6a937c2cb9fc
>
>Best regards,
>-- 
>Jim MacArthur <jim.macarthur@linaro.org>
>

Thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


