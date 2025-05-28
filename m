Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEAAC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKE8g-0004Qn-Qt; Wed, 28 May 2025 06:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steffen_hirschmann@web.de>)
 id 1uKE8a-0004P0-7s
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:35:57 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steffen_hirschmann@web.de>)
 id 1uKE8Y-0004xj-8U
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1748428540; x=1749033340;
 i=steffen_hirschmann@web.de;
 bh=V5e5hLSqomREFEodCMV1/OwlgVh/RVpEmQ2acxYIdQU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=omQnGpJZO6vFEjla8fHBurrpULnjjDbtU8h1rLCj32zuqB1Qu4Qrdo0PD0eK/lIr
 yTsVWrP1Z6711dMTYH5W72kVpyviGvCI6Y1o+CbqsPVM5xynhdGxv4iIpIc+92KRZ
 9Cl9dFC3V5Ln8YEldXCrGsy3z/mzPAX26DqTJ1iJpFIZdK/kGBomAJnOBhO7YmetA
 cZOc5xfYC6A0q9TvULFdThbx18uUFJmh2vkF4Y4d/hnR38k/DJmKmghJQCvLD4uS7
 +a+v9uRsMG35InHzwvNBNYYQCFsjSFKgffLscveZf53mhN1jcEkerj4pZxKOD/Bcd
 EaBMnmZxE5/3eSiumw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Obrian ([89.246.103.105]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgJK-1u6STe0eu2-00Cfrm; Wed, 28
 May 2025 12:35:40 +0200
Date: Wed, 28 May 2025 12:35:38 +0200
From: Steffen Hirschmann <steffen_hirschmann@web.de>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH RFC 1/1] TCG insn.c: Implement counting specific addresses
Message-ID: <aDbm-m2pasVXq7Bw@Obrian>
References: <20250430105937.191814-1-steffen_hirschmann@web.de>
 <20250430105937.191814-2-steffen_hirschmann@web.de>
 <875xhvbca5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <875xhvbca5.fsf@draig.linaro.org>
X-Provags-ID: V03:K1:SRkAFBn2BCFbDTtEvV9PxgcFygC6FXh2TbDD+t4n2ad0fesJISS
 apGQb3VdBeg/MYj7N21YUM+NzH0XGA0ax8BoKypA1n5dIGxxFRguAqT6ezeYB6KaCc1mmhc
 sQi4A8u5YPDs3pp4SL4qS21AX+siIJZmiSRqfJvz5UAonhOx3jyup+JhzXTSENdPNw6WJDB
 4eukbI6VNeguuKoEyOduA==
UI-OutboundReport: notjunk:1;M01:P0:Na/FdEHY7io=;CGFy1wvBcF4wqdrZpwOX6QFBQE1
 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
Received-SPF: pass client-ip=212.227.15.4;
 envelope-from=steffen_hirschmann@web.de; helo=mout.web.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sorry, my first message seems to not have made it out...

Thanks for the review, I posted a v2 patch to the list.

On Tue, May 20, 2025 at 03:13:38PM +0100, Alex Benn=E9e wrote:
> This seems reasonable. Do you have any specific use cases where this
> information is useful?
In an embedded application with Tensorflow-lite micro that uses CMSIS-NN
as backend.
I optimized some compute kernels in the backend (think of matrix
multiplication) for a Cortex-M core. Since these compute kernels are
leaf functions (every helper is properly inlined), I used this patch to
count the number of executed instructions within the kernels.

Greetings,
Steffen


