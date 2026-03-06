Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A5CFCB60B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWrU-0005sg-6L; Fri, 06 Mar 2026 10:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyWrS-0005s4-V6
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:13:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyWrQ-00052I-Pv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:13:06 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS8ys3lbSzJ467H;
 Fri,  6 Mar 2026 23:12:21 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id ACB3340587;
 Fri,  6 Mar 2026 23:12:59 +0800 (CST)
Received: from localhost (10.48.149.21) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 15:12:58 +0000
Date: Fri, 6 Mar 2026 15:12:57 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <gourry@gourry.net>, <lizhijian@fujitsu.com>,
 <anisa.su887@gmail.com>, <armbru@redhat.com>, <david@kernel.org>,
 <imammedo@redhat.com>, <linuxarm@huawei.com>, <mst@redhat.com>,
 <nifan.cxl@gmail.com>, <peterx@redhat.com>, <philmd@linaro.org>,
 <pbonzini@redhat.com>, <venkataravis@micron.com>,
 <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v7 2/3] hw/cxl: Allow cxl_cfmws_find_device() to filter
 on whether interleaved paths are accepted
Message-ID: <20260306151257.0000461a@huawei.com>
In-Reply-To: <20260306121151.883-3-alireza.sanaee@huawei.com>
References: <20260306121151.883-1-alireza.sanaee@huawei.com>
 <20260306121151.883-3-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.149.21]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

On Fri, 6 Mar 2026 12:11:50 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Extend cxl_cfmws_find_device() with a parameter that filters on whether the
> address lies in an interleaved range. For now all callers accept
> interleave configurations so no functional changes.
> 
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


