Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC39DC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzMUa-0004wh-BA; Wed, 26 Aug 2026 18:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMUZ-0004w7-La
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:53:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMUX-0000bW-Ot
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:53:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QM4A943208776
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5lPVtJpWnw3ic30LeYAwkpTAo1eOed6G6lKtEXyef4c=; b=h3uhkvRGc9Nym/iE
 PuPuB8jME9zK1i2Eg8LnfZILTa6974yuWDLqRPE4/FNdre2Ppe4uLxgLaCxcsfD/
 svnXX/IbDoN07Qy804EYcsFu1Mt0sx8QTHhIT0srzXuKKlc0Y27djKpy2lAHYOpV
 NVO1bPpqoe9C56I1gSSM6PwIyH3xJSta9JspPNMOdTnfIaCzydRUlw/1z0KZdFZE
 O75H1BIE3PrsRTBBqIUjil+sOjvVn+KCDrJoQhX+YopBKe6FZxrpwi3LxKKEDqRc
 tJEsy3gWSFXyW3mwCmFT7mG2Dgtr4DcvCfThMZK54FvSqoel3M8Iv1e7psIIAn6l
 X+pM7Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5g3mw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:53:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so2101832a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787784787; x=1788389587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5lPVtJpWnw3ic30LeYAwkpTAo1eOed6G6lKtEXyef4c=;
 b=EFTEK9kwzm+2ppy8U7JrnOtiSf6urnYOiYhqO1rmE5x2Qiz9ryetB/NsTygWmzUQak
 8/edHvX7HavnZcT0OdTP8bBmbWGpeCMgFSGZ2jcc5+LZucN7pFHmrQ7HogmdE808JtfX
 IXCUTbMsYmKHu6MZe5KqgxyAzb6Ma/SzjgDmMyidNx4FX0XPy4kDaKYUT3FQWmhKYvph
 E0IyY9pnvymRY5nmqzGG668WsZjhg9tNc7QuSUGiCJ/P9bfRtovwlxRoL6sFztlJA0PC
 6SolMJTKB15N0WEibvxFhDqQSvQZi3rEn3CgpseJuUHt2UGyo0t1yheGKlKka1MM3DkP
 5GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787784787; x=1788389587;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5lPVtJpWnw3ic30LeYAwkpTAo1eOed6G6lKtEXyef4c=;
 b=KAIs78RFUcS/tIfhkwSYfg5t0b9n4NjquoZoMzkTVo28l3IFllZxkkgmOPvvJZrd8g
 oDv49qW1MgGe9tj/uKnv//dLHvli6AFtSJ7CTugg+5nfTpl3puTUojHOOkWs2iGJr4aV
 E60rmPVBwyi6zMsVhiwHT8qE8utICZv3wGHKeXadFFAR1fqbQu19K2vRyg8VXVLOrjR4
 b2ZkBxOP65d8/ds7xarNO+Y4fbln03pz3sfCXbHSL+ICuS0/VpteGN0BviQRyQZGRYCr
 niYiQlzPviGOvASNSN9inl0JHONeB+opp5n+lMkVv4IUirgaqHRzjN6IXsQCkOdsixVi
 gRPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Royba4sF62cHhs3ArandHT9ynGOxkPQhtgzfvgj2b9I9F7Y5b11MVZocoVlIn/j2gcV+SYRqEYJ6HiJ@nongnu.org
X-Gm-Message-State: AFuF++kDMPtlLNhykbE7FMVLdKIu8DojIcI7+YOVVNEkS5CT14MLiyXi
 2Gyu93f0EhGyPlJrWfnlX6ScnmMc/qforSmv6U1f96/U3ompYZ9wyG5hu9mMOZ+389biy7J5DtF
 YsihGkdnAUo7FrmzZdVGId21PxtlgcuyxwgNFkFwLBqaiOmO4aCPKZ03AbQ==
X-Gm-Gg: AR+sD12ES70IgiWXh9RT6Nzufgfog7auZJFBaXbxSMRLme0ODdhp4Q8tgIYiWQaRzT4
 hDafn5oAkQznkwrPfrOlblz+thzU0PwFyrdpuf3EUiljMT1gvko0NWeq7G7hccJCyIvVDnYGrEK
 BvGbvaRrdFnZ9XpkPNhCvlY9eYfywJy0zfgTZsy+JCK+PSe/0s9uoySjcfeFNDMuyKMhQQ3DIOu
 buU2U8vQ86ZN1Zforoml/uAklDzk+VcHC1tL8QtptN9zB36IAI3aPx26h6otkyl303HMx35GeDD
 OIqbyNKvBFpOJkdSi6rwqbUsPZ1UZz2dlFd3bw+xc6GpvpwJk2U5Jp4TSvXQsnHV2fXTymnqG+0
 RM8Y12De1/JPsmHU/vrKwCPhFB7OG2YIJOuZ8WTckCYgQ9FtXwymzgAGxBnOtZNRPOtSK
X-Received: by 2002:a17:90b:4484:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-3966d5bc8b2mr16241859a91.16.1787784786994; 
 Wed, 26 Aug 2026 15:53:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4484:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-3966d5bc8b2mr16241797a91.16.1787784786580; 
 Wed, 26 Aug 2026 15:53:06 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8f467c9sm11199815c88.7.2026.08.26.15.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 15:53:06 -0700 (PDT)
Message-ID: <7001658a-d688-441d-8c19-a4fa3abb5500@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:53:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] target/hexagon: fix store-conditional on
 big-endian hosts
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
 <4fc8afeddfd0dabc6c50688b24901ebab1867b12.1787586642.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4fc8afeddfd0dabc6c50688b24901ebab1867b12.1787586642.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pTqASxaXk-IoP7o3CTP18U_Mnrh64NAf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5MyBTYWx0ZWRfX8ECGgeVKtHCa
 +06DC67LiaweV5DRgq8xhFbXxWqiWjSY2sAHj4ZC5vZqUvNhQZI934DUyjlVG+K0aKnKYnFv0bt
 NHv+wqeU3ugPkjRcpnGx+EuC/L39nN0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5MyBTYWx0ZWRfX/xPLHyjMG74u
 ZRrMMRvZVLucSJqyhLVltZlDocCISIqgOewpm9ZrKI+W6LguL6D2i7u91rbu7/nC+LOAiDN2Y+1
 xzvLOFLGbOFSgybgxsDk3z0smx27LpCP8FunieXcwQSOn8Zl7SrpRTQeh5D6VXd3AylRpkvGm26
 AWnOUrrv7TjWagpnjG2xUIp+TR8YqgSs4EGsoWVZe+BddwPBNQR5CAksphOfOh70PkCa87xZgue
 kYcEmVfpvc08jq/sDJA8TrxZU9/xDLpIqnBuEWfDI6MtLmXuRWW3znxKXaVwn7HfUkXGIB6dLfY
 Z24P6/jO29cvx9ihN7gVaG1SEf8tReLhiBeNP0UJcRKbmKJoitj1E7t6X1QXWuMupaV+C48HI3K
 4K+Cow1e6yphhnshE4CpUb5HQeV8ExQZwdfx/6qNoBI6RJ+HzI9kyBm6MgCnQlIbQkuWxiifXZS
 1U9QqUWFFFrhbVpuTuw==
X-Proofpoint-GUID: pTqASxaXk-IoP7o3CTP18U_Mnrh64NAf
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8f6e53 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=GerPsNgqwoWV0720KYUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260193
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

On 8/24/2026 8:58 AM, Matheus Tavares Bernardino wrote:
> gen_load_locked4u() and gen_load_locked8u() read guest memory with an
> explicit MO_LE, but gen_store_conditional4() and
> gen_store_conditional8() are missing that, so we wrongly access guest
> memory in host byte order.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/genptr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

