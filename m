Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D43FC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdab0-00037O-3M; Fri, 23 Feb 2024 13:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rdaD3-0000Dd-2k
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:23:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rdaD0-0002XV-8c
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:23:44 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThJDs3f70z67M1h;
 Sat, 24 Feb 2024 02:19:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9900A14058E;
 Sat, 24 Feb 2024 02:23:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 18:23:35 +0000
Date: Fri, 23 Feb 2024 18:23:34 +0000
To: Richard Henderson <richard.henderson@linaro.org>
CC: Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] atomic.h: Reword confusing comment for qatomic_cmpxchg
Message-ID: <20240223182334.000014ca@Huawei.com>
In-Reply-To: <808e13f8-11da-4ec1-969d-d2495cbd3a88@linaro.org>
References: <20240223182035.1048541-1-peter.maydell@linaro.org>
 <808e13f8-11da-4ec1-969d-d2495cbd3a88@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Fri, 23 Feb 2024 08:21:42 -1000
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 2/23/24 08:20, Peter Maydell wrote:
> > The qatomic_cmpxchg() and qatomic_cmpxchg__nocheck() macros have
> > a comment that reads:
> >   Returns the eventual value, failed or not
> > 
> > This is somewhere between cryptic and wrong, since the value actually
> > returned is the value that was in memory before the cmpxchg.  Reword
> > to match how we describe these macros in atomics.rst.
> > 
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/qemu/atomic.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> > index f1d3d1702a9..99110abefb3 100644
> > --- a/include/qemu/atomic.h
> > +++ b/include/qemu/atomic.h
> > @@ -202,7 +202,7 @@
> >       qatomic_xchg__nocheck(ptr, i);                          \
> >   })
> >   
> > -/* Returns the eventual value, failed or not */
> > +/* Returns the old value of '*ptr' (whether the cmpxchg failed or not) */
> >   #define qatomic_cmpxchg__nocheck(ptr, old, new)    ({                   \
> >       typeof_strip_qual(*ptr) _old = (old);                               \
> >       (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \  
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As the person it confused ;)
> 
> r~


