Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E76DC3814E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTfz-00081T-Po; Thu, 04 Jul 2024 17:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sPTfy-00080F-1m
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:07:34 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sPTfr-0007Zz-EP
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:07:33 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240704210717epoutp0447ffa72caa96516c94b9e46a36b5d91a~fHpvpzPQR3035230352epoutp044
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2024 21:07:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240704210717epoutp0447ffa72caa96516c94b9e46a36b5d91a~fHpvpzPQR3035230352epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1720127237;
 bh=KiPDM8qTrMQVgBQLbgRFhZKMskYWD8aQewkO/261lSw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oh2Vv5gM+bMHF9OU3T07zWaf/ZF/8hRBGpEFbYYqhWDV9KfoBYTinnigfy4LFXeGN
 NET4/r+0AQals4sPU4884VMkkqDs33geHujjFZZD0FEWNYrinKb1zzedcYNz6FXTuN
 ZsEOwwU4cdo5qMpL6U+5NKfNjIhyEKd0drYsiLeI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20240704210717epcas2p3d815cd9768c781e69502e2714681a234~fHpvW5oRk0049200492epcas2p3J;
 Thu,  4 Jul 2024 21:07:17 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.69]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4WFTjw3vP7z4x9Px; Thu,  4 Jul
 2024 21:07:16 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 01.D6.56241.40F07866; Fri,  5 Jul 2024 06:07:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20240704210715epcas2p37ec2ae9879e2c43d38ab29ddf7abff35~fHpt7GgFE0049200492epcas2p3F;
 Thu,  4 Jul 2024 21:07:15 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240704210715epsmtrp1f991050a5c74837ab379c7f91079d68b~fHpt6McC22806128061epsmtrp1K;
 Thu,  4 Jul 2024 21:07:15 +0000 (GMT)
X-AuditID: b6c32a43-993ff7000000dbb1-d3-66870f041797
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CE.EE.07412.30F07866; Fri,  5 Jul 2024 06:07:15 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240704210715epsmtip26cbcf122c7d9c75f70b6905eadec7091~fHpts2nT51710517105epsmtip29;
 Thu,  4 Jul 2024 21:07:15 +0000 (GMT)
Date: Fri, 5 Jul 2024 05:54:53 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, qemu-block@nongnu.org,
 j-young.choi@samsung.com, minwoo.im@samsung.com
Subject: Re: [PATCH] hw/ufs: Fix mcq register range determination logic
Message-ID: <ZocMHW8uNMUx0xc2@localhost>
MIME-Version: 1.0
In-Reply-To: <6dcb63036f3b35c833de752d1472d08bf4a9c289.1719996804.git.jeuk20.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmhS4Lf3uawbdZMha9/VvZLPqezGGy
 uL/1GqPFs9MHmC1mvWtnszjeu4PFgc1j56y77B5Prm1m8ujbsooxgDkq2yYjNTEltUghNS85
 PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaLGSQlliTilQKCCxuFhJ386m
 KL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjeNdX9oJHbBXrP95k
 b2B8w9rFyMEhIWAicWB1dBcjF4eQwA5GiZ1/9rFBOJ8YJR5928gM4XxjlDj07hVQBydYx6Se
 s1BVe4ESrTeZQRJCAs8ZJbqmiIDYLAIqEptapzOB2GwC6hINU1+xgNgiAsoSly+9YwSxmQWq
 JeZO2QYWFxZwlzjZ+wzM5hXQkLg26QEThC0ocXLmE7A4p0CsxM/3P1hAFksI3GKXaHiyhAXi
 IheJ1x/aoa4Tlnh1fAs7hC0l8bK/Dcqulvi/5BITRHML0KFLV7JBJOwlpnWcYIG4KFNi1+7f
 LJCAUZY4cgsqzCfRcfgvO0SYV6KjTQiiU1ni46FDzBC2pMTyS6+hJnpIbNx5GxpyGxgltm04
 xzaBUW4Wkn9mIdk2C2gss4CmxPpd+hCmtMTyfxxIogsYWVcxiqUWFOempyYbFRjC4zc5P3cT
 IzgZajnvYLwy/5/eIUYmDsZDjBIczEoivFLvm9OEeFMSK6tSi/Lji0pzUosPMZoC42Yis5Ro
 cj4wHeeVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cB03fjGIyFX
 t11M4fuyHy1jdf5ocWvJ3ymF2x5eOsdeW6ta+l1QsULlBd+vjT6BS7ZNm6+xaNssxRXnmlbz
 864/9TagS2uSJhPfa71ZOn9fHlLqsLHtnqCpZ6Uo4X+1Kzgzjz1lxt3vU3K/Vl08dttrRUHz
 D48N2aeZPPTPb1eLs1c3urOc61O7VPrDbp6FSvMVD/Hr34s71WD8z3duOVdTr+DZp1/8Xm5g
 6fj8dusOx9ib+rcuv9SfZiGV3DTJfkH1/0XKanc2py2QM5E847LtBEve4UCLCVZK258krBKS
 8y5qDdbmkg60TpMv5L25LaN485/N1UX2H0yZpE6u6/wYPOG47qJ9U/3+ct+9fP63EktxRqKh
 FnNRcSIAxIboIg8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvC4zf3uawa3vWha9/VvZLPqezGGy
 uL/1GqPFs9MHmC1mvWtnszjeu4PFgc1j56y77B5Prm1m8ujbsooxgDmKyyYlNSezLLVI3y6B
 K2PVxi7GgkUsFYen9TM3MB5l7mLk5JAQMJGY1HOWrYuRi0NIYDejRPuBZjaIhKTEvtM3WSFs
 YYn7LUdYIYqeMkqcuPYZLMEioCKxqXU6E4jNJqAu0TD1FQuILSKgLHH50jtGEJtZoFpi7pRt
 YHFhAXeJk73PwGxeAQ2Ja5MegPUKCWxglNi11w8iLihxcuYTFohedYk/8y4BXcoBZEtLLP/H
 ARLmFIiV+Pn+B8sERoFZSDpmIemYhdCxgJF5FaNkakFxbnpusmGBYV5quV5xYm5xaV66XnJ+
 7iZGcDhraexgvDf/n94hRiYOxkOMEhzMSiK8Uu+b04R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
 Gs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpgurT52OS7V1bMPB6wsiLejeV2csul6q1XG9mP2FkK
 q+9z+bL96P5HO40u5k16W1O2PK7gbYNR2Y13pqt2LtFQO9bMf2mSgLHZkV/TDAquP97mJ5Lx
 nT/y46QjZ0/5W5xZyPal8rXVaivnLYzM12z5t36NN3gxdXvd/aNTb+5ZXD/HIHtylv/z5dWN
 GxX07wvd21gs/+Lheu78o+ofL7/5uYAxfNnhRmm90NqNNs0Jpxv9WPY6vj76dvIR+V1v/iY8
 2xNrl9Pj49d7+9Y7z5h2tQWbQt2lls9WYw3viX9Y9JNXf3PEpA/CZfrPA5e3xmTNXlBy9ICe
 z+62HObj+jknNNWyXBy/zS1Lu3lbwuqD/RIlluKMREMt5qLiRACsU7FR1gIAAA==
X-CMS-MailID: 20240704210715epcas2p37ec2ae9879e2c43d38ab29ddf7abff35
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_188d96_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240703085445epcas2p46c71128d3bbd516d3779781c6e2b2f58
References: <CGME20240703085445epcas2p46c71128d3bbd516d3779781c6e2b2f58@epcas2p4.samsung.com>
 <6dcb63036f3b35c833de752d1472d08bf4a9c289.1719996804.git.jeuk20.kim@samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=minwoo.im@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_188d96_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On 24-07-03 17:54:10, Jeuk Kim wrote:
> The function ufs_is_mcq_reg() only evaluated the range of the
> mcq_op_reg offset, which is defined as a constant.
> Therefore, it was possible for ufs_is_mcq_reg() to return true
> despite ufs device is configured to not support the mcq.
> This could cause ufs_mmio_read()/ufs_mmio_write() to overflow the
> buffer. So fix it.
> 
> Fixes: 5c079578d2e4 ("hw/ufs: Add support MCQ of UFSHCI 4.0")
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_188d96_
Content-Type: text/plain; charset="utf-8"


------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_188d96_--

