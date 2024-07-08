Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC48FC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQnzs-0003bn-QI; Mon, 08 Jul 2024 09:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sQnzP-0003I1-VJ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:01:09 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sQnzN-0000Ty-1y
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:01:07 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240708130100epoutp034f603e8c5a2a718ce1ffc384e5e85134~gPmT1D9-o3173331733epoutp03_
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2024 13:01:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240708130100epoutp034f603e8c5a2a718ce1ffc384e5e85134~gPmT1D9-o3173331733epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1720443661;
 bh=RJ85eofAEtQ8l/AD50ikOpPStoax6lhjJ4W7KxwJ+cE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=csC8JP1s9HtvQJatXZqHozwBFl6CpJiADW2xQtBdiQ2G+DKC026GOyxj1uoTwsOpj
 wR4yS+n7mfHJoWEbNI3m0Sb0iEqwqbsNVquZ9bOKWf2A2yFI0upAsHpr9yPLIZ0vAC
 dlXQoO7MLS3qQ5quoBOl1bcIWuADpqEJupw7QODo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20240708130100epcas2p2965f972d6b7288500c3300f36ce2527d~gPmTTfnJz2413524135epcas2p2J;
 Mon,  8 Jul 2024 13:01:00 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4WHkkz651Fz4x9Pw; Mon,  8 Jul
 2024 13:00:59 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 F6.02.09806.B03EB866; Mon,  8 Jul 2024 22:00:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20240708130059epcas2p39490ae6a7825c3b1d640f45c2288de68~gPmSV1jDE0794907949epcas2p3B;
 Mon,  8 Jul 2024 13:00:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240708130059epsmtrp136bd05738142846627f7fb2a37354193~gPmSVClVc2472824728epsmtrp1T;
 Mon,  8 Jul 2024 13:00:59 +0000 (GMT)
X-AuditID: b6c32a47-c6bff7000000264e-df-668be30bd73b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2E.78.19057.B03EB866; Mon,  8 Jul 2024 22:00:59 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240708130059epsmtip26b1f1f727946b33a14c943b740c7c117~gPmSI5cTZ1610316103epsmtip2E;
 Mon,  8 Jul 2024 13:00:59 +0000 (GMT)
Date: Mon, 8 Jul 2024 21:48:31 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, minwoo.im@samsung.com
Subject: Re: [PATCH  v5 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Message-ID: <ZovgH9Pi+Ugz/nVQ@localhost>
MIME-Version: 1.0
In-Reply-To: <20240708113908.19535-3-clement.mathieu--drif@eviden.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmmS734+40g2PthhZ/1i5ktlh26TOT
 xYnnn5ktlr7dym7x7PQBZov/v16xWmzZ/43d4njvDhaLuT+vsVgsvnWe0YHL49+6xywei/e8
 ZPJ4cm0zk8fHp7dYPN7vu8rm0bdlFWMAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGh
 rqGlhbmSQl5ibqqtkotPgK5bZg7QbUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
 AvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IyVbx8zF5xkrZi8iLWB8QdLFyMnh4SAicTVPycZ
 uxi5OIQEdjBKPD2whQnC+QTkHLrBDOF8Y5RoOHaKHaZl3rW7UC17GSV27z7DDuE8Z5R4dboP
 bDCLgIrEoQd3wWw2AXWJhqmvwGwRARuJptM7wLqZBaYzS9ztuMcKkhAWiJR4fu4VE4jNK6Ah
 cXXPEXYIW1Di5MwnYM2cAm4Sm9++Y4M4YyaHxJxdIRC2i8SEnt3MELawxKvjW6BOlZJ42d8G
 ZVdL/F9yCew5CYEWRomupSuhBtlLTOs4AbaAWSBT4sy6n0AHcQDFlSWO3IIK80l0HP7LDhHm
 lehoE4LoVJb4eOgQ1FpJieWXXkNN9JB4/u0PNByvMkrs2T+XeQKj3Cwk78xCsm0W0FhmAU2J
 9bv0IcLyEs1bZzNDhKUllv/jQFKxgJFtFaNYakFxbnpqsVGBMTyyk/NzNzGCk62W+w7GGW8/
 6B1iZOJgPMQowcGsJMI7/0Z3mhBvSmJlVWpRfnxRaU5q8SFGU2A8TWSWEk3OB6b7vJJ4QxNL
 AxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUamOJ7mA946BoWfjjV/3vVOqZJ
 JSccYgyOFu/dc0HS4mXmYx4W/aae7x82ayrN/5Tx0GrWf8GbCallP8IWhk/c/eat1a0yT90N
 TjwX1tnOL/oRUl60e32ewwf/JcmfTl27cO3FMaWX3R1Tf3XPYpnbfm6LMPPtvvYavbqbXMzz
 lx3gnqJlfP13l7SRI+cL8TMf3c1OHtZT717yyHP1sh2Xrvw5E1/Bf177dUrInP2Priw8/nD6
 zDvcU3zFppUrWGXZpqUlOzW1MGTxa3b3KjBOV14rq9K+Oy87LJE97GpCWs+SB3HXiqYnbVzK
 MMNE42fd2tXXUsL1Y+9evf/t9AJz1kK32i0NnMuSWNzvzvr+aIESS3FGoqEWc1FxIgCam9Qj
 PwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvC734+40g3fTBS3+rF3IbLHs0mcm
 ixPPPzNbLH27ld3i2ekDzBb/f71itdiy/xu7xfHeHSwWc39eY7FYfOs8owOXx791j1k8Fu95
 yeTx5NpmJo+PT2+xeLzfd5XNo2/LKsYAtigum5TUnMyy1CJ9uwSujHN3JrIXvGCqeDNRtYFx
 M1MXIyeHhICJxLxrdxm7GLk4hAR2M0pc+nCLDSIhKbHv9E1WCFtY4n7LEVaIoqeMErtajzCD
 JFgEVCQOPbjLAmKzCahLNEx9BWaLCNhINJ3eATaVWWA2s8TpWTPB1gkLREo8P/cKzOYV0JC4
 uucIO8TUq4wSdz+eZoNICEqcnPkEbBIz0NQ/8y4BbeMAsqUllv/jgAjLSzRvnQ12BKeAm8Tm
 t+/YJjAKzkLSPQtJ9yyE7llIuhcwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiO
 Iy2tHYx7Vn3QO8TIxMF4iFGCg1lJhHf+je40Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvem
 CAmkJ5akZqemFqQWwWSZODilGphyBVe7Msg/sb6yLfHLO0GtxlOaZwpW+nkxHWqaUq73f+qr
 /IeJ1znfGJv+edn3YK7Fxw+TfJbOsBV2/G3GN7ElY00Dl8yfqNd5L+XeKFXvnqc2o0zp1cLp
 Z5ao+jadPXNMU225h8Tyht91sxjX6yXN0UyIlStsi9pp5F+jtDGP0WvLpQfZ3+LWrmEKjdDe
 7P2HVXGZ8eI229jv7NHSBtWM+547ODjfku6UbdKTDZiWFlmVnWbPm/DUJPuSH/sC0Va7y2e1
 arYutj9+46V8SFhb7JVZH4rTNnY+W3pNN+no7QZLvz/XBIN8gh706jWzKYdqTMj6o3l91qJ7
 ygLXop9+NBG8s/d2jn0Tc1GdnxJLcUaioRZzUXEiAGtNIEwSAwAA
X-CMS-MailID: 20240708130059epcas2p39490ae6a7825c3b1d640f45c2288de68
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----GYrZwOZf271lb0asq-_m8oi27wabo7t24X0BK_QM5T4hVeLi=_1a7f82_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240708114158epcas2p277593102571ef98ee26fe6ecefc367c5
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
 <CGME20240708114158epcas2p277593102571ef98ee26fe6ecefc367c5@epcas2p2.samsung.com>
 <20240708113908.19535-3-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=minwoo.im@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

------GYrZwOZf271lb0asq-_m8oi27wabo7t24X0BK_QM5T4hVeLi=_1a7f82_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 24-07-08 11:39:54, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> These 2 macros are for high 64-bit of the FRCD registers.
> Declarations have to be moved accordingly.
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

------GYrZwOZf271lb0asq-_m8oi27wabo7t24X0BK_QM5T4hVeLi=_1a7f82_
Content-Type: text/plain; charset="utf-8"


------GYrZwOZf271lb0asq-_m8oi27wabo7t24X0BK_QM5T4hVeLi=_1a7f82_--

