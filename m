Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B69ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 23:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGQYF-0000yB-Uk; Tue, 04 Nov 2025 18:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vGPKS-00040j-0c
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:16:40 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vGPKQ-0007Ig-Kb
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:16:39 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-640b2a51750so5554704a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762294596; x=1762899396; darn=nongnu.org;
 h=subject:date:cc:from:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=HTF7/P+G6vQPwKuUcJEOsNzczUX4QA4ntI8YilOM9Dc=;
 b=ZiERxoHOktMc9JhSgViCdkURq5hwuO1DxEYbrJ5VBPpowV9HGxOdoJnzzZzZfMvGeF
 qbiypVVntPCZTSjYXkcOPzRySP3T4Q24/TyT19RuaLzdIpQn0rYBIyq90rgtU5uuoBFR
 PK5zEl5otRIm43Cb+WSPJ0QPfh6kHXNg14wkR2vurmvLP4yyg7qwnk3gn47zn2ZTGLrP
 TD9P9qGPhEHVUE0aXMeVrNU+PxtJ2SMqoQL4QOYTNydWaGC8ECP2JGEFLMeo2lG7OPh6
 uNN7/85QiRz4XbDGqo+8FKfGpGbo1i3VhXhuXFElmdnDP9AhItnGF4cOmslzTPvvOlB0
 YMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762294596; x=1762899396;
 h=subject:date:cc:from:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTF7/P+G6vQPwKuUcJEOsNzczUX4QA4ntI8YilOM9Dc=;
 b=NNRNcmI8HmAjSSGqPeqzN5zCEBhwhPr/0rCG+A2+VnoQgC53jH8O5kJMGczum8HRJk
 ZZaHci3Bc8+GQUBod+9rHKwlzJkpv5vAREbZzx5ihmHdU4kLT9vjYwaTt5upGffphl9W
 W1K9y6hRCFt3w4QL4SuPC2rSSNkl+qsseb7isMRgGYxmvmpR58Iaq37Iue74F3J9nXSv
 he/Kg3cPOEJaOdzExQs7NNdJFYWCKTibowpXOXDz4FOMYfU9rV4kHn2SEUsRAhis7+55
 w2zRE8GqffB3asKZoxBb0RjuEHBtqYl5r3cKTbfBj1n4xaxMOxUXlSZaDAdF2WBNX9jI
 UK2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz46mceIFCgFlQyOs1jLbUYDawuZEPwJ2IEXNKTXRi9MjRZfJT0FNZIWMTJ5Bzv9GM0OjoBy1QW0rS@nongnu.org
X-Gm-Message-State: AOJu0YxRZW4t0aO083Egh2onHMgnioBnXH9K5l9uDMfgNU11yKeAd4PC
 nR9PJatlC12LxmQeHb13fmjY3IH497xzApdEwL4Nk1+FKXvJPtd2pBAYwaW3Vokk
X-Gm-Gg: ASbGnctLCN96h421TJNtX3nsBi7ZX6FRq8Smx7AVslZRPyQKUEefpiXEAnmlF7dJnbK
 adCVHoa5GK9srHmZ+xAWq5EcPLs35Rwv9A8lFD7ArqfD577rcfhGNYVyx3O2R6fFtoPUAm0/zfB
 FTJFz0taVn3X8lRxQiP+YhXE3EB/EGMLhjJT1xyKPmXASsTEYL/E4Uf+JEZEZJAK8ilU4ICJfUm
 zqplYgisytJnV6wQlIcETJPbC5oYTQKQOcRqeXqvKsij3A0ihcSOcpUp+QkRGQFhmp/QGiXUYA/
 8XZWb9kgmWu7m/XKJOcy6ZZXK0TM+/bhX+DTKXZkASfYfTfYb1J69jbo6up5I4HKMTRbzOpJMtx
 eQ+kCk8NCskI3JVabbYj7iA+/kKEXO39My+ZN7mRGyL2A8QOQhUDiZ2ZJOoVTpwvDvJE/zQ==
X-Google-Smtp-Source: AGHT+IFLT+J82dndokLlu4KCoMxp7Wq/VYM273XopMJagmtUvCKU5s/6MyZq+LcRVGs1B1Hqpuq2+g==
X-Received: by 2002:a05:6402:24ce:b0:640:bafb:3598 with SMTP id
 4fb4d7f45d1cf-64105b990b5mr643406a12.38.1762294595781; 
 Tue, 04 Nov 2025 14:16:35 -0800 (PST)
Received: from localhost ([149.200.120.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6805813sm3450824a12.14.2025.11.04.14.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 14:16:35 -0800 (PST)
Message-ID: <cddc5c730b912a058b54100b19adf552.rbalint@gmail.com>
From: Balint Reczey <rbalint@gmail.com>
CC: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Date: Tue, 4 Nov 2025 14:54:23 +0100
Subject: [PATCH 0/1] user: add runtime switch to call safe_syscall via libc
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=rbalint@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Nov 2025 18:34:58 -0500
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

Hi,

qemu-user implements calling signal-race-safe syscalls for the guest
in assembly directly to the kernel instead of going through the host's libc.

The proposed patch adds a switch to go through libc, which allows interposition
of libc's syscall(), even when the guest program is statically linked.

The motivation behind the change is intercepting statically linked binaries [1]
with firebuild [2], a build accelerator implemented in userspace.

I have tested the Linux changes, but not not BSD ones.
I think they are trivial enough to work and I'd like to port firebuild
to BSD, too, in the future.

Cheers,
Balint

[1] https://github.com/firebuild/firebuild/pull/1334
[2] https://github.com/firebuild/firebuild

Balint Reczey (1):
  user: add runtime switch to call safe_syscall via libc

 bsd-user/main.c             | 11 +++++++
 common-user/meson.build     |  1 +
 common-user/safe-syscall.c  | 57 +++++++++++++++++++++++++++++++++++++
 docs/user/main.rst          | 28 ++++++++++++++++--
 include/user/safe-syscall.h | 25 +++++++++++-----
 linux-user/main.c           |  9 ++++++
 6 files changed, 122 insertions(+), 9 deletions(-)
 create mode 100644 common-user/safe-syscall.c

-- 
2.43.0


