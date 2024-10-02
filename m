Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2928CF3198
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 06:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtIH-0002S6-Kz; Wed, 02 Oct 2024 02:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org>)
 id 1svtIG-0002Rp-Ma; Wed, 02 Oct 2024 02:57:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org>)
 id 1svtIE-0003ai-Nm; Wed, 02 Oct 2024 02:57:04 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XJQbH6pd6z4wbv;
 Wed,  2 Oct 2024 16:56:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XJQbG00JFz4w2M;
 Wed,  2 Oct 2024 16:56:57 +1000 (AEST)
Message-ID: <c39f54de-65f4-42a6-bde7-b5a4ea0c2056@kaod.org>
Date: Wed, 2 Oct 2024 08:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] ppc/spapr: remove deprecated machines specific
 code
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241001092910.1030913-1-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241001092910.1030913-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Harsh,

On 10/1/24 11:28, Harsh Prateek Bora wrote:
> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
> deprecated with reasons mentioned in its commit log.
> Removing the arch specific code for the now deprecated machine types.
> 
> v2: Addressed review comments from Cedric
> v1: <20240917060300.943496-1-harshpb@linux.ibm.com>
>   
> Harsh Prateek Bora (11):
>    ppc/spapr: remove deprecated machine pseries-2.1
>    ppc/spapr: remove deprecated machine pseries-2.2
>    ppc/spapr: remove deprecated machine pseries-2.3
>    ppc/spapr: remove deprecated machine pseries-2.4
>    ppc/spapr: remove deprecated machine pseries-2.5
>    ppc/spapr: remove deprecated machine pseries-2.6
>    ppc/spapr: remove deprecated machine pseries-2.7
>    ppc/spapr: remove deprecated machine pseries-2.8
>    ppc/spapr: remove deprecated machine pseries-2.9
>    ppc/spapr: remove deprecated machine pseries-2.10
>    ppc/spapr: remove deprecated machine pseries-2.11

LGTM, I had a few questions.

Please be aware that the next QEMU cycle will have more machines
to deprecate.

pseries-2.1          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.10         pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.11         pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.12         pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.12-sxxm    pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.2          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.3          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.4          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.5          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.6          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.7          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.8          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-2.9          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-3.0          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-3.1          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-4.0          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-4.1          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-4.2          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-5.0          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-5.1          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-5.2          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-6.0          pSeries Logical Partition (PAPR compliant) (deprecated)
pseries-6.1          pSeries Logical Partition (PAPR compliant) (deprecated)

Thanks,

C.


