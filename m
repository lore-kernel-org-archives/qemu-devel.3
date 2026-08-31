Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D4AC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x10Wz-0002Jw-EQ; Mon, 31 Aug 2026 07:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1x10Ww-0002JJ-TS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:50:26 -0400
Received: from va-2-38.ptr.blmpb.com ([209.127.231.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1x10Ws-0000ID-GW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1788177001;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=fazG+qJAphHySqt0q2TOL3Y5pYodsiDtOJdzQF2QXHM=;
 b=vwT6Wq518WACKy0IASW/FRWQKSEbEc+9FBo+E4zredUk7uoI4K7lXi+UowCkGjPsW0u6N2
 402prwD96r+/n+Ih0ORWvciYMM5BFPD9h8hpemNTMWBPZvcOefQ3PTlgOD+cKhHU+aZdHp
 cl0bc876ll0488l6xELb/noLbgGX8ddgr/G9zSOz7J6NdKCgdPGgAEvoI6hu2YTHGz7DWf
 bytOUNBy7IK7WtrItfwT6AjiIMsK4vCxzifQspZ60DvC+fGC3MXejsGeDzIQNgAiwMNz+V
 IqPwSvaE23AN8usVcK3mQ9U0DK2iUr/s/pqXGlDGaHr/6HLjjUPzdOdmbXy+aw==
Date: Mon, 31 Aug 2026 19:49:54 +0800
In-Reply-To: <877bl6eoqv.fsf@draig.linaro.org>
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Subject: Re: KVM/QEMU community call tomorrow - agenda items?
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
References: <877bl6eoqv.fsf@draig.linaro.org>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 "Albert Esteve" <aesteve@redhat.com>, 
 "Alberto Faria" <afaria@redhat.com>, 
 "Alessandro Di Federico" <ale@rev.ng>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Anton Johansson" <anjo@rev.ng>, "Markus Armbruster" <armbru@redhat.com>, 
 "Brian Cain" <bcain@quicinc.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, 
 "Chao Peng" <chao.p.peng@linux.intel.com>, <cjia@nvidia.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <cw@f00f.org>, 
 <dbarboza@qti.qualcomm.com>, 
 "Demi Marie Obenour" <demiobenour@gmail.com>, <dhedde@kalrayinc.com>, 
 "Eric Blake" <eblake@redhat.com>, <eblot@rivosinc.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "Eduardo Habkost" <eduardo@habkost.net>, 
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>, 
 "Auger Eric" <eric.auger@redhat.com>, <felipe@nutanix.com>, 
 <helge.deller@googlemail.com>, "Alyssa Ross" <hi@alyssa.is>, 
 <iggy@theiggy.com>, "Warner Losh" <imp@bsdimp.com>, 
 <jacob.oursland@gmail.com>, "Jan Kiszka" <jan.kiszka@web.de>, 
 "Jason Gunthorpe" <jgg@nvidia.com>, <jidong.xiao@gmail.com>, 
 "Jim Shu" <jim.shu@sifive.com>, 
 "Joao Martins" <joao.m.martins@oracle.com>, 
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>, 
 "Luc Michel" <luc@lmichel.fr>, 
 "Manos Pitsidianakis" <manos.pitsidianakis@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, 
 <matthieu@minio.io>, "Max Chou" <max.chou@sifive.com>, 
 "Mark Burton" <mburton@qti.qualcomm.com>,  "Ho, 
 Nelson" <nelson.ho@windriver.com>, 
 "Paul Walmsley" <paul.walmsley@sifive.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>, 
 "Peter Maydell" <peter.maydell@linaro.org>, 
 "QEMU Developers" <qemu-devel@nongnu.org>, 
 "Roberto Campesato" <rbc@meta.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>, 
 "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>, 
 "Bernhard Beschow" <shentey@gmail.com>, 
 "Stefan Hajnoczi" <stefanha@gmail.com>, "Thomas Huth" <thuth@redhat.com>, 
 <utsingh@redhat.com>, "Wei Wang" <wei.w.wang@intel.com>, <z.huo@139.com>, 
 "LIU Zhiwei" <zhiwei_liu@linux.alibaba.com>, <zwu.kernel@gmail.com>, 
 <peterx@redhat.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
X-Lms-Return-Path: <lba+26a956a67+21206b+nongnu.org+xiangwencheng@lanxincomputing.com>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS;
 Mon, 31 Aug 2026 19:49:58 +0800
Message-Id: <413b9ba2-20cf-4af6-9998-be46da277c84@lanxincomputing.com>
Mime-Version: 1.0
Received-SPF: pass client-ip=209.127.231.38;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-38.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

On 8/31/2026 3:24 PM, Alex Benn=C3=A9e wrote:
>=20
> Hi,
>=20
> The KVM/QEMU community call is at:
>=20
> https://meet.jit.si/kvmcallmeeting
> @
> 01/09/2026 14:00 UTC
>=20
> Are there any agenda items for the sync-up?
>=20

Hi,

How about discussing the patch[1]:
"virtio: Add aligned ld/st accessors for vring".

As pointed out in the patch, this has been a long-standing issue. It is=20
now necessary to introduce atomic accessors for fields that require=20
atomicity, such as the avail_idx field in virtio. This support is=20
especially crucial for architectures like RISC-V, which do not natively=20
support misaligned memory accesses.

I'm particularly eager to receive more suggestions for it.

Thanks,
--
BillXiang

[1]=20
https://lore.kernel.org/qemu-devel/20260821100856.1794011-1-xiangwencheng@l=
anxincomputing.com/

