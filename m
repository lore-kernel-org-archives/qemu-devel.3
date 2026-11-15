Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B4606A323
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVFckCod
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSjyd-0006s4-7F; Sun, 15 Nov 2026 18:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1xSjya-0006nm-EV; Sun, 15 Nov 2026 18:49:36 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1xSjyY-0003Ot-0T; Sun, 15 Nov 2026 18:49:36 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 875BE4116F;
 Sun, 15 Nov 2026 23:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B751A1F000C4;
 Sun, 15 Nov 2026 23:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794786572;
 bh=qWW4P24jsBI21+QGMPYutShOWDHRveLjfpUHbxn5DAI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nVFckCodOS+dlZblPS8C4hv753dYh6cSkwDLG7gsOWXijMP4R7IFCyxLIdBVdVDzg
 c6q3bAAfBd/d2mL/SfCRAQANM5KVS8HbM558k6SBCRhmFCZioKAk4MJYVavremk93w
 iTHaDho8T5siwXi2Vhjz4Iz7XC1JYcEKh5BQS+415f9V+bmQiGQzTR9bHoomyjyFef
 XVl38qUVMoOFlYYCxVaJKlogzsrgG/epItGNmMQ5w5I5ay6rembPZZVlxWzriB5vap
 1angRaAWiRmcm7gzw0WM2+wgVeD89O1RS6Ukk87EcKrZZNdOoTqJBfEe0mgpdU5djO
 phyl2W7Zg154w==
Message-ID: <f9a5a9e8-3e1d-49aa-9680-57aef03b42b6@kernel.org>
Date: Sun, 15 Nov 2026 15:49:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 9/9] scsi: add the sense codes of zoned block devices
To: Niklas Cassel <cassel@kernel.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
References: <20261112114918.1269168-1-cassel@kernel.org>
 <20261112114918.1269168-10-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261112114918.1269168-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=dlemoal@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 03:49, Niklas Cassel wrote:
> Add the sense codes that a zoned block device reports when a request
> violates the zone model (ZBC-3 and ZAC-3):
> 
>   ILLEGAL REQUEST, UNALIGNED WRITE COMMAND (21h/04h): a write that
>   does not start at the write pointer of a sequential write required
>   zone
> 
>   ILLEGAL REQUEST, WRITE BOUNDARY VIOLATION (21h/05h): a write that
>   crosses the end of the writable part of a zone
> 
>   DATA PROTECT, INSUFFICIENT ZONE RESOURCES (55h/0Eh): a request that
>   would open or activate more zones than the device allows
> 
> The IDE device is going to report them for zoned devices.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

