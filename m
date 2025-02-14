Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C31BC021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixHX-0005al-Sk; Fri, 14 Feb 2025 10:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tixHV-0005aC-Gj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tixHT-0004oC-9E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739545621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jr/nu0gmy2vwNLaPbJCFNJlI3FptA3Fz3pf+mSERcgM=;
 b=daDSVuDGYzd5QlF/SnpLNcvr3Jjl4UPHjvegWOxspXvDwOo5ViKvNgsi6Nb9vf4W14CgY4
 T1VTmrkgmVHDu8NYPeNbAnL2FDwMCSCQjDznhM9KUxigO93bGBBZOSlipuMRRl43WqQ5xW
 p0FQdTY9+GjeP2x0bD4h21n58ZQlGrc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-aKO2M2ZlP-OSJkNwqkHyYQ-1; Fri,
 14 Feb 2025 10:06:56 -0500
X-MC-Unique: aKO2M2ZlP-OSJkNwqkHyYQ-1
X-Mimecast-MFC-AGG-ID: aKO2M2ZlP-OSJkNwqkHyYQ_1739545613
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 643A51800878; Fri, 14 Feb 2025 15:06:47 +0000 (UTC)
Received: from gezellig (unknown [10.45.226.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1DAD300018D; Fri, 14 Feb 2025 15:06:25 +0000 (UTC)
Date: Fri, 14 Feb 2025 16:06:20 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, maz@kernel.org, Joel Stanley <joel@jms.id.au>,
 Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 sebott@redhat.com, Steven Lee <steven_lee@aspeedtech.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Troy Lee <leetroy@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 1/3] docs/cpu-features: Consistently use vCPU instead
 of VCPU
Message-ID: <Z69b7M8PkJ4AFtXP@gezellig>
References: <20250213135032.2987289-1-kchamart@redhat.com>
 <20250213135032.2987289-2-kchamart@redhat.com>
 <87v7tdpn5z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7tdpn5z.fsf@draig.linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 13, 2025 at 09:09:12PM +0000, Alex Bennée wrote:
> Kashyap Chamarthy <kchamart@redhat.com> writes:
> 
> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> 
> Should we add vCPU to glossary.rst?

Ah, I didn't notice this in the tree.  I can add as a follow-up later.

PS: I sent the patch while on a train, `git publish` was acting up.  My
apologies if duplicate copies of this patch series land on 'qemu-devel'.

> Anyway: Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> 

-- 
/kashyap


