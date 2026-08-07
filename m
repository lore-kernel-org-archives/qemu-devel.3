Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1541C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMx0-00007y-N4; Fri, 07 Aug 2026 11:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsMwz-00007o-RI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:57:37 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsMwy-0004jU-1c
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786118250; x=1786723050; i=deller@gmx.de;
 bh=k+hqYcxqyB2SnJ3D4ahikZSipO6CmfotrFNRAUW7oKA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=h3oJvYjECBLkQL/tWUvnlG6UiDI37sj5+5dWcB497uvBeWmNaUiDOCJZXQ3kwfAy
 U9XvWgEeruuBTcPLyx1pm/zVHjgb7KYI7RmrC7V5RRGmr2EzVMdfS6IcV0ryW2TXw
 OmAYlVxpGzMdA0//A2bRpQGz3Ed6PgR78ezOEDdmRk1AyYKEmCfUv1MvTUI8faehf
 gdpLruP52oPOB7PqUleANM5vJLArP6daeYmw9YJH9ja13XYRv/Tn1BRMw8KCPbJGq
 fXtgIxP+gIs8yUseiprOLQlUyQuCjSxV3CLhEl82TiFdKNSn1NL4c6ecBnK9AAJDl
 KZWDgu/dEv4fnhYFmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUqL-1wkReP1yU3-00DKTq; Fri, 07
 Aug 2026 17:57:30 +0200
Message-ID: <c1922cbc-d53b-4390-8348-cfa81bd2f735@gmx.de>
Date: Fri, 7 Aug 2026 17:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] linux-user: support writing floating-point registers
 to a core dump
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, pierrick.bouvier@oss.qualcomm.com
References: <20260805172329.3121925-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260805172329.3121925-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5C5oWLJ3aLji2PuKrbBiBTTQ1Opp5GxcfLYj3hSnSvoUm6VbbQh
 JvXL8vcRO7h7PyRWkx+leZHsetPNhhF6HDGLZiBmMkdkZTdwTXqyCwBkK1SYYdlJCyD7CAb
 gSyBojkY1U6D9gZNtiXiseuBnMMvyUzskkgyiZPhk9EkYzPScJXM+HdBzwXKT4EeWikVVrA
 /HiwAhF/KZ0m3X+oQk0Xw==
UI-OutboundReport: notjunk:1;M01:P0:rYeM9XXouTQ=;m8adRmfJBnMvh2KJM0RgwreT9lt
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/26 19:23, Matt Turner wrote:
> Write an NT_FPREGSET note for targets that opt in: a target_elf.h that
> defines HAVE_ELF_CORE_FPREGS and target_elf_fpregset_t, and supplies an
> elf_core_copy_fpregs() beside the existing elf_core_copy_regs().
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Reviewed-by: Helge Deller <deller@gmx.de>


