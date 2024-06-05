Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2EFC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 12:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEpLk-0003Lg-FQ; Wed, 05 Jun 2024 08:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEpLj-0003Kz-4N
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:02:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEpLe-0004V2-Ii
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:02:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvQzJ20sYz6K9cq;
 Wed,  5 Jun 2024 20:01:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3A5441408F9;
 Wed,  5 Jun 2024 20:02:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 13:02:26 +0100
Date: Wed, 5 Jun 2024 13:02:25 +0100
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Get rid of unused cfmw_list
Message-ID: <20240605130225.00006431@Huawei.com>
In-Reply-To: <20240531061317.865673-1-lizhijian@fujitsu.com>
References: <20240531061317.865673-1-lizhijian@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 31 May 2024 14:13:17 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> There is no user for this member. All '-M cxl-fmw.N' options have
> been parsed and saved to CXLState.fixed_windows.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Hi Li,

Applied to my tree with slight change to patch title
to hw/cxl: Get rid of unused cfmw_list

I aim to send a group of more minor changes like this for upstream
in the next week or so.

Btw, to make it easy to spot QEMU patches in patchwork so that
the kernel maintainers can ignore them - when posting to linux-cxl@vger.kernel.org
[PATCH qemu]
marking for patches is helpful.

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-host.c    | 1 -
>  include/hw/cxl/cxl.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index c5f5fcfd64d0..926d3d3da705 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -335,7 +335,6 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
>      for (it = cfmw_list; it; it = it->next) {
>          cxl_fixed_memory_window_config(state, it->value, errp);
>      }
> -    state->cfmw_list = cfmw_list;
>  }
>  
>  void cxl_machine_init(Object *obj, CXLState *state)
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b686441..e3ecbef03872 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -43,7 +43,6 @@ typedef struct CXLState {
>      MemoryRegion host_mr;
>      unsigned int next_mr_idx;
>      GList *fixed_windows;
> -    CXLFixedMemoryWindowOptionsList *cfmw_list;
>  } CXLState;
>  
>  struct CXLHost {


