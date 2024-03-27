Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D480AC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTQF-0006AB-S0; Wed, 27 Mar 2024 09:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cb512937bb1ca346be0c+7521+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rpTQD-00069b-VW; Wed, 27 Mar 2024 09:34:29 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cb512937bb1ca346be0c+7521+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rpTQB-0006tp-H7; Wed, 27 Mar 2024 09:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=a+mnVz+I2LBdh7f3Jeku0JCwAoJyIxFVfnocz+i6RMc=; b=q+v5/FPbwtAD6uQ9dCHGbJREjz
 H800nx781N9tH0ZcPPk9yn5Ape1VheAXWcyBkwRNqKh4v/J6DHpXEnVP9Qz74WQNMJbQVIsdax39L
 DlLF3RislEyl4kLLjeTkS7dO2SAN6YZChYNLRkkTF2vkDLvc9T3y0pW/3wF6+9ZO7wnocnQ00G53r
 KBhD2vc3Jo90OAxsDRunIY0TlD0Q9Lwepy7zWNB83EJpkEV4zhYDQ6il5F8K101e8mWUJhr+G9rSb
 4A+Q6ifEF4oA7e6058Z6Vrd6MQkld5/dNz/qhri2QxMR/MFmkWIOk/jAPxDKuKeFdMgjEPMoFD8rB
 Bv2BC0qg==;
Received: from [2a00:23ee:1868:3da7:4441:744d:10c:c781] (helo=[IPv6:::1])
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rpTQ2-00000000H0t-3z9v; Wed, 27 Mar 2024 13:34:19 +0000
Date: Wed, 27 Mar 2024 13:34:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Anthony PERARD <anthony.perard@cloud.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH-for-9=2E0_v2_?=
 =?US-ASCII?Q?09/19=5D_hw/block/xen=5Fblkif=3A?=
 =?US-ASCII?Q?_Align_structs_with_QEMU=5FA?=
 =?US-ASCII?Q?LIGNED=28=29_instead_of_=23pragma?=
User-Agent: K-9 Mail for Android
In-Reply-To: <76ae46e6-c226-49d0-890e-c8fd64172569@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-10-philmd@linaro.org>
 <76ae46e6-c226-49d0-890e-c8fd64172569@perard>
Message-ID: <F096E89B-FB3B-4E06-B5A4-C28A285C07D6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+cb512937bb1ca346be0c+7521+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 27 March 2024 13:31:52 GMT, Anthony PERARD <anthony=2Eperard@cloud=2Ecom=
> wrote:
>On Tue, Nov 14, 2023 at 03:38:05PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Except imported source files, QEMU code base uses
>> the QEMU_ALIGNED() macro to align its structures=2E
>
>This patch only convert the alignment, but discard pack=2E We need both o=
r
>the struct is changed=2E

Which means we need some build-time asserts on struct size and field offse=
ts=2E That should never have passed a build test=2E


