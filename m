Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234ADE68155
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 10:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHtW-0001pR-KH; Tue, 17 Feb 2026 05:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vsHtT-0001pD-LZ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:01:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vsHtR-0001hW-4c
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:01:23 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fFZsY2nLFzJ46bc;
 Tue, 17 Feb 2026 18:01:05 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 4FA0040572;
 Tue, 17 Feb 2026 18:01:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Feb
 2026 10:01:14 +0000
Date: Tue, 17 Feb 2026 10:01:13 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <lizhijian@fujitsu.com>, <anisa.su887@gmail.com>, 
 <armbru@redhat.com>, <david@kernel.org>, <gourry@gourry.net>,
 <imammedo@redhat.com>, <linuxarm@huawei.com>, <mst@redhat.com>,
 <nifan.cxl@gmail.com>, <peterx@redhat.com>, <philmd@linaro.org>,
 <ppbonzini@redhat.com>, <venkataravis@micron.com>,
 <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v3 0/2] Performant CXL type 3 non-interleaved regions
Message-ID: <20260217100113.000067f3@huawei.com>
In-Reply-To: <20260216145219.1959-1-alireza.sanaee@huawei.com>
References: <20260216145219.1959-1-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Feb 2026 14:52:16 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Hey everyone,
> 
> This is v3 of performant CXL type 3 regions set:
> 
> v2 -> v3: Addressing Zhijian Li. Thanks for the feedback.
> v1 -> v2: Mainly rebase.
> 
> Base: On top of Jonathan's tree -> https://github.com/sarsanaee/qemu-lab/commits/performant-v3-E/

Just to clarify - this is on top of the stuff I've posted as ready to
merge, not my full CXL qemu staging tree..  Assuming nothing shakes
out in review of this set hopefully we can merge this as well this 
cycle!

Jonathan


