Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC014F4610F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fNz-0000ID-2r; Mon, 23 Mar 2026 09:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w4fNx-0000Ha-4U
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:32:01 -0400
Received: from smtpout3.mo534.mail-out.ovh.net ([51.210.94.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w4fNt-00021u-Vt
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:32:00 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4ffYhy1d2fz69WQ;
 Mon, 23 Mar 2026 13:21:22 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 23 Mar 2026 13:21:22 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.175])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4ffYhy0Q6mz1xrZ;
 Mon, 23 Mar 2026 13:21:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 4ECBE192363C; Mon, 23 Mar 2026 13:21:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004620c7fe3-9875-4aa9-b31a-5725d2cb4b05,
 8B0D7F005F29B12F9D17609CFFF4A06A7A5C7DDA) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <acd3bbe2-894b-4831-ae44-c2973f8199af@kaod.org>
Date: Mon, 23 Mar 2026 14:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] aspeed: Improve error handling and fix DMA issues
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260323125545.577653-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260323125545.577653-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4490651780870089752
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEa9EwvkjmjiMN6L8oASPu6Rf9zNGNroA7GEFa8KgjvqRb0o4UPApewJ38IUj5d5yHt4tsD8atNhMNLJ2QZ+6qZLAXRzGMGN99rb8P+WbXOXckexuRbwLRyaaxfuwypceN+hAZWLJzfQ/CXJdSUTtdoiepfclGunc+BcXSSN6gsqikNYq/fmilYFXQZ7rDrX+NCkRQVBTFOcGB+c5CQRrEHrUbP6idEdFqqzNHJFj5uaiG+GSzIDT5i65L0uBUrAqhL42DJMGWXoyiq2JEhuPtk7zFLOojLh9wyXpdxjWL7d+3Y1Xj77YUCR9sjKZcrLdXez0dyK91tE9DCl+1kNOWmolO72u+2xvsC9tCVbWf7M0dZyi2Ep3ZzgMKb2IGUE9wS3ogWRj6/CrdJ2b81hnGeVtGVIuXKGA8PxadiN38lJQBENg8g9JHRDHk30jVwLiMTeWcSXU9Yjr9K+hpyFEnHXg19bsyAXFsx7NhfEYAoPEt2g3QiMjC5ObDm+zaXnpQUaIqmdZ+KdEyxQtuvX5wKFvLGFsvMMzar7d2l7bm9vVCioB7g9neNsxtbT1iIzJMg1ZA0bDct6r7w/7LLtWpuzzKv8/VMPvp044q22WwoiBQqXz2gEUKGi6eR053vdLnP9MkhX+VDkDUrN/YtphdwZpBOjAGPrth5ixt7lOve0Q
DKIM-Signature: a=rsa-sha256; bh=Sd2LDt6iJjpg9K+BqRmWbxAd9PtWUhHNQiA1qE0AaNs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1774272082; v=1;
 b=B/LP7RaY6ENPAj/+DuOJ1I9cJ8yD5XlfAaXTHIIBUF/KLydVvU23XaYVzBaZZOXszu6zBsiv
 bVRw7H1hpVWJaKEixQdcMHN/JRBiWsl0Sg9oUzTAVZjHcw+E8YrbB5f+ZTa2vClY5h+sgZG4lkY
 CwXScHERgVus+uEX11r2ds8ZQYZcbNE0aYRVwfzH9ThiAVmKlBic8SsBs1xqzTMPyrVYq0kEuqm
 YI18swO8wRGWSLQuA6Q8iTFtoupL9rnzGnnIMncqCR7BmSVhp3rF/IBWnhTUgP6o0cp2Y2gJ39E
 CAtDekjewGEOwAfyoihx+9YM8WitB0PA77FWYa8FUY1fw==
Received-SPF: pass client-ip=51.210.94.142; envelope-from=clg@kaod.org;
 helo=smtpout3.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/23/26 13:55, Cédric Le Goater wrote:
> Hello,
> 
> This series addresses several error handling issues in Aspeed device
> models that could lead to guest-triggerable denial of service or
> incorrect behavior.
> 
> The first two patches improve DMA error handling by properly
> propagating memory transaction errors to the guest. The aspeed_smc
> patch converts memory operations to use read/write_with_attrs to
> return MEMTX_ERROR on invalid conditions, while the ftgmac100 patch
> checks DMA operation return values.
> 
> The third patch fixes an incorrect assertion in the aspeed_i2c model
> that could be triggered when firmware uses the RX_BUF_LEN_W1T bit to
> program DMA length fields separately, which is valid per the Aspeed
> datasheet.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3315
> 
> Thanks,
> 
> C.
> 
> Changes in v2:
> 
> - v1 was taking into account patch :
>    https://lore.kernel.org/all/20260224065556.3847942-14-jamin_lin@aspeedtech.com
>    Rebased on upstream
> 
> Cédric Le Goater (3):
>    hw/ssi/aspeed_smc: Convert mem ops to read/write_with_attrs for error
>      handling
>    ftgmac100: Improve DMA error handling
>    hw/i2c/aspeed_i2c: Remove assert
> 
>   hw/i2c/aspeed_i2c.c |  1 -
>   hw/net/ftgmac100.c  | 10 +++++++--
>   hw/ssi/aspeed_smc.c | 49 ++++++++++++++++++++++++++-------------------
>   3 files changed, 36 insertions(+), 24 deletions(-)
> 


Applied to aspeed-next.

Thanks,

C.


