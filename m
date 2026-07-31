Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD45C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr3R-0007B7-ML; Fri, 31 Jul 2026 13:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr3P-0007Af-6o
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:29:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr3N-0005r9-Mx
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:29:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFNvrp105912
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LHkSrhxwhzP0pyEoTH9UIkxxOFLBvG2tRehzZk0har8=; b=CsyF4jApYpZPB29n
 EMc1VB1Sk156HR3IUGr8sZJEaCbiX2l5/iwLnebjARxOtbLERBf3owE3ppPVwJlz
 cKKDOwEkvHsBjIfDM6wuv8IRKqSL6kuN3gzRrXnLF17asFfRKb4WeqdVu9ajyrT3
 LD8s/qlJytugAQ2MBcMbnKJMfQotX2czAXcvJ4H54hjj3nAPuJxX+kpBokUzbmyO
 MAl3r40cm/1krtD+DMbpm0fjYWd63C9cYaSVC5JKPncWFAtojL4aBaiIubThs6vs
 RG7WC9USLcvp2/ZC+UH3O2koD1xxO/jhBK4tC14nMDxt8cR0HiQCpAyWyxEVhkkq
 Vy+FiA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru2u1k3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:29:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso1812153a91.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785518987; x=1786123787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LHkSrhxwhzP0pyEoTH9UIkxxOFLBvG2tRehzZk0har8=;
 b=V5z79fKz+ATzsIruzMrQZgU14vLjg/8Oc93zWa2xlpSoDW9RUYgavap7AWNrhN9A1P
 8iSAdUuzAFUqaUSHAGSOAzV+0YAFvS0ftv82vl2ZxzBlpngDhDhBlYqvPxOp3mYlOirQ
 VQLqvgiOT4JEv9OI29ZZF5FOrosaQuF+9FDGC2+Wr9xLYT/mLiaK8ULsgo+6MEbvCM6e
 JOTtQrYJyZ4u0Zs3rtsDCZ8zqnLYjYf6IMFEaNjju9n/fnWlrBT0Vsaf/myvugRVK4Ei
 jE34OiCKtFMJGa+uslqulE6h9YBWznuuEJexovi3N2JdLxtJ0oM7lI4dqVshQ5GU2Snl
 Lrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785518987; x=1786123787;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LHkSrhxwhzP0pyEoTH9UIkxxOFLBvG2tRehzZk0har8=;
 b=FK5EHIWWVpthPS9OR8dw9VMgbYem3VbmoSJsqO//0H5FVobfXVqbXCZZ23sPZZfk/V
 159eC5k8xWHRc5GJdFfPi7+PW8DBktkorQzK0v5qSzpRhi0xFeNMVf/cHh6UO8R4T4yE
 7NJCEFqU5sQTaS/n5RoAf9HsG5Lf1q12Qks0Yj/+fVa8HZfG5RGzlWCiAPZAbhtbJSZA
 lzsDxiW0gvBMtB5rXGOgYsoX87TZTIPUpxa2tvt2/0ZTt0MkV9tx5Z+/YfyXPN0rmI+n
 QfYrhTkVO58M+plddexYjnQHAyX6Vdf8MzE76MqywV3gCrd86ujsxylG/Z7xN3FeIaab
 k78Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAj41W8v4ScflJbs6kCVedQkUyCD7F0PVa91YO9zMy3r22Xz6LITXUdGJvD4k1VuvAgyqF9ouMjuCW@nongnu.org
X-Gm-Message-State: AOJu0Yzh65sBvdyUsqrY8LETCKQFIzHr3n8nQYCIkiyDf2cHs50BDzDA
 n4vORoCeq63nNONjLdYi4WVeCVaRzilEiZnAICjZVzs6kFMdshBg84U91Cuk80qccS18Fu9aGJk
 A1OntVAR/t2AyxZpfEYrDe0Vwx9HEKR8nX3CFVx9qKV9wasyHgkrnf8dUiA==
X-Gm-Gg: AR+sD11o83rU1nL+Sdaf5STrWDef6ThEvDIQd88EwggcU5AJGfTDhqx46iCgPAug5qg
 cc104t8dXyyUOqdYFYr8fJaY/aCVtNMhOKM5B9sLMDBXkRr7Y/mBHQ+mCgwJiDeeiWyLiXjOtZM
 ovtdEsysEFwJUElMR11cFxTo7WWQQ4m95CzR/JL1ncfzDTU0WFjXN0RbmCOyCWkmJ392dU2Czmv
 j4bR1hq3HQT04MIoN2YYLDHT2Gq9KCb5+hNLK877R30dFTYX1aKbt05sjNjPgqZ5YrE8GJ/TkiI
 xH69JZs88fSi/O6qoyYB3et8TFn1SgRmwTgaOdJMWNYim9/mgA6/jd36gbiR3rMF5TQV2Icb0N2
 rtPxmydTFxo3QAdJoY9faAZon6PWHT4s1sYqbBVAqdFNn5kIL+vYS9gQspNF79vD8iD4a
X-Received: by 2002:a17:903:32cf:b0:2cf:1536:3d41 with SMTP id
 d9443c01a7336-2d052411e61mr7417085ad.28.1785518987203; 
 Fri, 31 Jul 2026 10:29:47 -0700 (PDT)
X-Received: by 2002:a17:903:32cf:b0:2cf:1536:3d41 with SMTP id
 d9443c01a7336-2d052411e61mr7416885ad.28.1785518986671; 
 Fri, 31 Jul 2026 10:29:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b1594a5sm8398705ad.73.2026.07.31.10.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:29:46 -0700 (PDT)
Message-ID: <7d108a09-0303-43be-9674-7f78610e944b@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:29:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/18] hw/hexagon: move global registers to hex-subsys
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VyFUC_T4Jpx6sReIjNbyKppnFnJCxr7t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX6zx2PXJDvNQW
 06el1BrnujemYuqGXPFOL9ruCQPsrTijH+9/z0s5B9UuU7PZylrl/zjvCobIvZcooqw4+rcrs1i
 oScB3j5ADb84QYhl/2MXHtw2sMyG1RSOHzpfvIW8ZeVCspPzlRJ3p/rEPpPguNyq8MXXGJG+XMO
 wHImy+qVBrKUQq+DKZtFJb5Bk7WchtKsZPNsjfHQ0vFtisGEeh6tFOKrcRU6LflQ32Ob7Vxu7rD
 y1YTYS/BzqU+zPTJ5h2KziUxhG9xSzitAvy8kGjj6EaarnbYsptePeP5FyaaOJt0AcuU6l8sWyz
 8u07VRQnlo4LiF/HHwsHPuLMOB+u1C29z5csINgXMFi+uwhdnztuxvcAFrr11c7aPMqkHmmjWQj
 Ss2N8mzjxIn/aYnyFW1ROvc2h8xy2pjveJ04YEdLhlu1shlUOJ2ckjdZOKA0mSr+w2RWr63yoDX
 1Q+Obl5CkMFJcZTM0Ow==
X-Proofpoint-GUID: VyFUC_T4Jpx6sReIjNbyKppnFnJCxr7t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX2VPDoVFljj17
 El0KtrA+gScZNKeqwX30jqO60Um/34QRubTpNadcwxy1PWnsZe8TKO+llPU6X9mTSEMJiryQnmJ
 seI2J2XBghd4uTALVgcojOSLW315OI4=
X-Authority-Analysis: v=2.4 cv=b+uCJNGx c=1 sm=1 tr=0 ts=6a6cdb8b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=WTwBrr1ObBC17ozogrUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310134
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/29/2026 6:28 PM, Brian Cain wrote:
> Both machines create the global register device the same way, so let
> hex-subsys own it and link it to each CPU as it is realized.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hex-subsys.h |  6 +++++-
>  include/hw/hexagon/hexagon.h    |  1 +
>  hw/hexagon/hex-subsys.c         | 29 ++++++++++++++++++++++++++++-
>  hw/hexagon/hexagon_dsp.c        | 15 ++-------------
>  hw/hexagon/virt.c               | 23 +++++------------------
>  5 files changed, 41 insertions(+), 33 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

