Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A78606A331
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=Y8B0bcdC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOX4n-0007pR-DX; Wed, 04 Nov 2026 04:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOX4h-0007oL-OT
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:14:32 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOX4d-0007UJ-Rj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:14:30 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A49E6vb061635
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Nov 2026 18:14:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1ynPUAEKBzSg7Eo2IEbdhioT/Pt1CFxuYgqrXGnB5iI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793783647; v=1;
 b=Y8B0bcdCw207vOt29anePRQm4mo6npgLnj8xRej+bgIdA/gXIyj5l7VrbVVvmWii
 Cc9kIcOsXHKGaopfriVWxbpxGdC31YM2wOJ3GRnQBVLNoe+JRMS40n58PLkhNd5+
 18sl6GqcPRfWWr/wAWKVHUyd6iHK4dN1wUQq24BxoS0qzJ+PxAF0N/4UCbZqZeD1
 E0F66zxdz3T01E0TZ5xxjihYLB/F/HMLN+EU0OljTICFMLPLNFtr8LKkBBU3Fu1i
 m1Bw8CxGvqPSFgqhODlIDe1u1dnfWSUXuPvip4yPpU7mkxJmUJavDoRpGfFvaunO
 jvIKlWazml2T2bw6Jwfphg==
Message-ID: <10c48a35-82c7-439c-be8f-15b9dd89501b@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 4 Nov 2026 18:14:06 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
To: Weqaar Janjua <weqaar.janjua@packetfive.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com, lizhijian@fujitsu.com
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
 <20261029134859-mutt-send-email-mst@kernel.org>
 <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
 <20261030191556-mutt-send-email-mst@kernel.org>
 <20261031120516.2846639-1-weqaar.janjua@packetfive.com>
 <20261031135234-mutt-send-email-mst@kernel.org>
 <20261031185807.2866788-1-weqaar.janjua@packetfive.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261031185807.2866788-1-weqaar.janjua@packetfive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/01 3:58, Weqaar Janjua wrote:
> On Sat, Oct 31, 2026 at 01:54:08PM -0400, Michael S. Tsirkin wrote:
>>> My concern with
>>> virtio device is that it would hide the layer we want people to work with.
>>
>> People being the students?
> 
> Students in the context of training and skill building, and researchers
> from academia and industry working on rack-scale systems. It is also intended
> for upskilling and onboarding staff, and for developing and validating
> user-space and kernel-space code on a complete software-defined rack-scale
> ORV3 system. With virtio the transport and the driver are already defined, so
> there would be no device-specific PCIe driver for them to write, whether
> as a training exercise or as custom kernel-space PCIe code that industry
> and academic researchers develop and want to validate.

I have reviewed the series, and it looks interesting.

I am wondering if vfio-user might be better suited for your use case. 
While the code is clean and would serve well as teaching and research 
material, upstreaming it to QEMU requires integrating with QEMU's common 
infrastructure and meeting its architectural requirements, which is 
currently missing.

Specifically, the implementation bypasses QEMU's network stack, and 
migration is not fully implemented.

Fixing these issues is certainly possible, but it would require a 
significant effort from both you and the reviewers. Unfortunately, there 
is currently very little bandwidth for reviewing network patches; I only 
work on this in my spare time, and I haven't seen much activity from 
Jason recently either (unless I missed something).

Furthermore, fixing this might actually conflict with your goals. 
Tighter integration with QEMU internals would couple your device 
implementation more closely to QEMU, making it harder to keep pace with 
upstream development and increasing the codebase size. This extra burden 
may be undesirable if your primary focus is teaching and research.

Using vfio-user would save you the effort of upstreaming and keeping up 
with QEMU internal changes. One downside is that it does not support 
migration—though I suspect that isn't a requirement for your use case 
(though QEMU RDMA migration developers might be disappointed).

Regardless of the approach, you will still need to reserve the device ID 
by updating the documentation.

Regards,
Akihiko Odaki

