Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDF6CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzeH-00037F-1T; Fri, 30 Aug 2024 07:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjzeF-00032J-OM; Fri, 30 Aug 2024 07:18:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjzeE-0007DX-7Q; Fri, 30 Aug 2024 07:18:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwFtR5t4sz6J7v8;
 Fri, 30 Aug 2024 19:15:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E469A140736;
 Fri, 30 Aug 2024 19:18:30 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 12:18:30 +0100
Date: Fri, 30 Aug 2024 12:18:29 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <quic_llindhol@quicinc.com>, <peter.maydell@linaro.org>,
 <marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <chenbaozi@phytium.com.cn>, <wangyinfeng@phytium.com.cn>,
 <shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH 0/2] Sbsa-ref CXL Enablement
Message-ID: <20240830121829.00005d79@Huawei.com>
In-Reply-To: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 30 Aug 2024 12:15:55 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> RFC because
> - Many contents are ported from Jonathan' patch on qemu virt design
> 
> - Bring plenty of PCDs values and modifying the original PCIE values
> 
> - Less experience and not particularly confident in ACPI area so this might be
>   stupidly broken in a way I've not considered.

Hi Yuquan,

So an opening question for you.  What do you want to use this for?
If the aim is to do full software stack verification, I'd be tempted to
make a slightly more complex setup from the start and have at least
2 CXL host bridges so that you can enable interleaving + probably 2 or
3 CFMWS so that you can test that interleaving.
Even then it won't meet my requirements which is to stress the software
stack but then that's not the aim of sbsa ref so fair enough.

What you have here looks good to me in general, just superficial
suggestions in the various patches.

Thanks,

Jonathan




