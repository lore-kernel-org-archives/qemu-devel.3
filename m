Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A35BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjP46-0004m8-E9; Mon, 13 Jul 2026 18:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP45-0004lc-Nh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:23:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP44-0000Qa-Bf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:23:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9ZE72356059
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a6yJv6W+DNfF3BTTGZU6Tmld9pMs9/Kwpm1seBB6fOs=; b=BSgjNU6lTzbATF45
 V44oBo7spsx4MKUW7Xz9U0XI/8o+4pkTL27+nFJ8LjxIVzzLjRJ2wp/f6cfO6zgL
 YdLhGUOEkg2VCSxcSJlt+a0Nnd91kjTDxCjGWSo113uWJ1F2payqUuhuYUg6kkzJ
 jeRBDxqHzrYR17C5p506gyMUeBAMqQHqkTWSzFb6ucvUo0iJaz6gCh1Ey+15tSH/
 FxADwQbHfH20aMMu+nLo3nzqKkzNf+44BivL87iPGYh0YERe5+3nmi5KDhFLZjm+
 ikc2lsIblq3ZMHgRqDsLfJrOksxq+UalGV4Q7fHAD+i2Mu31GifjWNlKU2Vi565Q
 T4WI7w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4tqqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:23:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so4472248a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783981430; x=1784586230; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a6yJv6W+DNfF3BTTGZU6Tmld9pMs9/Kwpm1seBB6fOs=;
 b=HA7dEoY2FBCY9W3UUl0gEwUEK8mJ3nKPkq9VeMEA5mk1Roqm6GzyQ25xVHsegzifr4
 NATkgZmnz3mSs3Kg3nIIqG8rtHVc7WU000cCN2CaclIri8vdlp96banpVZiB1D0Cd+3E
 G5/Tbu8h1G/moc8Ws6GJvHLwySWMN22r5yMG2QP2xmyJIGiGoL376G7flkvHqae5b+j7
 ty1qEsyvQamUmt6w2w+jWwu7A6J3Ul/ANgL9zea2w6GEA0StwEpl9NeLv36YzQ5dSkS6
 WvV4I8Q/vWwmJRenCWTl3H4R71lN/ikz+ACWLQNvZGuz8C1KhsBqCS/pYnq0MlOXjSeW
 I8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783981430; x=1784586230;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a6yJv6W+DNfF3BTTGZU6Tmld9pMs9/Kwpm1seBB6fOs=;
 b=SiLfd5yh3j9AhRC+GPKIrcTbGzRfgTgDkw2iHMEA6OwbIN9h2t7odAzOr+aMWzt9le
 HJTrQqISoo2JDSdyfWEsssq3kZ5P4YD3RQy/6wVUkMC94QNwETsFhgqtgOI9uG3SytYG
 kA045N9zkv3ISViksFtlqLIbmum35l2Asgm9aQfQN5j136wmC1aHwjOoiF62HsPrCmoh
 4lkWmlgYPk2d90sIBqVUFQF1XK0UU9jCLI+KYhiDBE1D+snfKl1X2+soqUBC7QYEbI/f
 F7lz6X5uj0u5nqwVRl3KTsWxtjCTqmI16oEgd2IFZWdDpexEIScjz0br/uu9TouFwskN
 sMag==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0S9Wp+XV+pewlbxK3TvvU37Xjw5EjxCCCWKPtdNSBj6+R11uAntb0iPi4NkwxavWWttw7wob+Cn77@nongnu.org
X-Gm-Message-State: AOJu0Yxe8nJswpAfUHQqYWUhczm5ng5H3/WDHt+C8qf2VLxPUgVZpreP
 L5kJBQBPE8emwStbl1Idg1rDCzruOKGDG62QzuDR0WE2GfiCvOjff7tQlY/sj2rjWrWfg52cCfL
 ZjdWfwfvhrEl7HO+z3LZJJ9yqX/BS179D5QDO/4uhqp1FoBHHd3sc/TCNtA==
X-Gm-Gg: AfdE7cmGTmoCRw94fM1GDMqkPLefEwTFLcaM5sbptuEQZ73qgBpqOS07ebZv8OAr99A
 X/cl+7pLycmnCb/9hFtsHYtXbWT6/8plYy3hUwYV7e9fFbgHcKagVQb/N9YHpiCG+t69AI2KdsO
 VL/ukdtAeMt8ZiByERWeClan2S/QKfCXHBPk7JMxXUdbH/86lOtCpXiNEYZQ6I95FP/mZUx1Tk1
 aTIocOmTebs1Kk+8qOkr+k94x6ydfPkN3L/IEkcROpNw9zDOSlvIL6QfS6kxQd/EMnOuhWkeRAt
 Cc8hi3GI+Iqq8Jj8xtACzeAB1UV7X8TQa7MC02+iNpCK+X8pgVKv6rWLBJox3mQmR16piEyi8u8
 ct1LVSWpXWpEBuskLGzx31gRWZkWRfqq+Jpg1JfuVVMwY8neLT7bUycQWkMLJBkHUQWAgk93IXf
 WO98Y=
X-Received: by 2002:a05:6a21:6d8a:b0:3b4:3ef0:9132 with SMTP id
 adf61e73a8af0-3c110009b1emr12300662637.11.1783981430076; 
 Mon, 13 Jul 2026 15:23:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d8a:b0:3b4:3ef0:9132 with SMTP id
 adf61e73a8af0-3c110009b1emr12300630637.11.1783981429622; 
 Mon, 13 Jul 2026 15:23:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311a6115e61sm56799158eec.22.2026.07.13.15.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:23:49 -0700 (PDT)
Message-ID: <b5025914-ed2e-45b1-aa9c-90abe454654d@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:23:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] python/machine: support routing semihosting output
 to the test console
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <c366abf87494e1ccb10435028a9aeb0fb8362dfe.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c366abf87494e1ccb10435028a9aeb0fb8362dfe.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a556577 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=2vgDw2z3XyOUfvOsxLkA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyOSBTYWx0ZWRfX0i//5F9GJCXV
 OVy6FVZbGQKWwE+s6zdcB+53r1RCTofpoXpMXttNbPtc8oH2joeVeZSyIxqgPZF7dshnPBRhj4g
 ZqnhaG2dbxRjWNxxZro+h3BDHtu7F5I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyOSBTYWx0ZWRfX9RBo/VuxJKak
 V/Vu/thBQARBgRxmJFohOqvqEoForPmmXR+408FIkOgOPXSkD+Q+UURaIW0Q9SbPD4+3wF9EEIz
 B9sg32NLe1rCXp0iJBMgyFKItbjCKBV5w6V5p6jJFVOw0DXeXzfH/NMraKpbPLytPDkPJPHDxlA
 mnGtsIhvXoBfOfSDU4X4jYW2tEMSgGLkvxgqZbxktFC45i939NwYAsCp89+4hgd9kt+oEQk3qj5
 WoeDIOTSY291GtvvsmGAbInjxocj4vs+K54j946nK+b8iaZVBTo2ZXfburz07JlgbqM9ehQOWMy
 n4rooIitKsa6pbLhZ4anASHnaL8VvtIV1BtgjTZ/OeXqof3vN/WpZCoDxNyhYCHeXS3CywihnMq
 Z2NnJnmLxiJ8VNCUXneZIs+ekiW6ruoTllARp/88NhxdeIqWqX7D9w3It5IiCHig3k30p/anQT5
 vFYUN0rwI/JYMSVdnFQ==
X-Proofpoint-ORIG-GUID: v8ZdDygxmv1ry1XG6RoR87Vz1z-uhruj
X-Proofpoint-GUID: v8ZdDygxmv1ry1XG6RoR87Vz1z-uhruj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130229
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> The hexagon semihosting systests will wait for output on the semihosting
> console.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  python/qemu/machine/machine.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

