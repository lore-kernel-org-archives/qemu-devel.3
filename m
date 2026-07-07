Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E95C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh51E-0003Zc-06; Tue, 07 Jul 2026 08:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1wh51D-0003ZH-76
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:35:19 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1wh51B-0001DL-N9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:35:18 -0400
Received: from movement by movementarian.org with local (Exim 4.97)
 (envelope-from <movement@movementarian.org>)
 id 1wh513-0000000ATPV-2ZxI; Tue, 07 Jul 2026 13:35:09 +0100
Date: Tue, 7 Jul 2026 13:35:09 +0100
From: John Levon <levon@movementarian.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <akzyfcnwchjDV_to@movementarian.org>
References: <20260707105927.2776822-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707105927.2776822-1-berrange@redhat.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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


Thanks for pointing me towards this Cédric.

On Tue, Jul 07, 2026 at 11:59:27AM +0100, Daniel P. Berrangé wrote:

> Beyond the overall virt/non-virt use case classification, there are
> a number of scenarios which we have decided will not be treated as
> security issues. Start to document some of these to give consistency
> in our treatemnt of incoming disclosures.

"treatment"

> +* **vhost-user/vfio-user backends**. The backend processes have
> +  shared memory regions co-mapped with the QEMU process. The intent
> +  of the process separation is operational resilience & flexibility
> +  and allowing for independent software suppliers. There is not
> +  considered to be security boundary between QEMU and the vhost-user
> +  & vfio-user backends. Thus flaws in the backends which can cause
> +  crashes / undesirable behaviour in QEMU will **not** be treated as
> +  security flaws, but should be fixed as hardening bugs.

We're OK with this for vfio-user.

We don't have this properly documented - and we should - but practically
speaking, right now, the QEMU vfio-user client has at least some level of trust
in the server. It's something we would like to improve at some point, but we
could update this statement at that time.

(Note this is different to the VM itself which fundamentally trusts the server
implementation regardless.)

regards
john

