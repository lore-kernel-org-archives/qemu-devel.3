Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0C5FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHREe-0007oD-Ui; Mon, 27 Apr 2026 15:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHREZ-0007nr-G2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:03:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHREU-0002gv-Ce
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:03:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RHfLpI1237530
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ym6qo9dzu3to9RJeVtkMBicHBJ0/dq9yHAm9EERIARA=; b=fgI04QuKUULMfrV5
 m67y0SGHNrtkFNFylSSpTxnroHoNH2+04DukO7cuohedA6mJNcwwhhWpq37Jajja
 prDyJIowuX4cy1f0m+/W3StOMb7uYb3SuTHNuv+/5eKUuW6z93m0mZBZhKmE2UX/
 AnKTbChItA3qpOmAmkCO9Zh12kqkLAAxwg37nm9Wp5rPcZpo1trc1xC68PGhzltC
 xXZZD0rNKxidDk2qXBkG4JGALzJAOzo2ZmitMDvWdRKHL9pNaVVhmVHhppdBtsiQ
 YtMppI5d0BKHvC4a+yTFE4YraChbyD3lEkaTiqThhsUzqIB7TyhE7kE17D1RKQfk
 mRPHBg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4hryn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:02:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso13710451eec.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777316579; x=1777921379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ym6qo9dzu3to9RJeVtkMBicHBJ0/dq9yHAm9EERIARA=;
 b=AOvUsTR9g8Ix9pPxPAjlV/9gP7RkvAica70Xt62gvuoJEfgw+qzCD8s/3c4o4Xh++E
 88qomguRnRQfb6xwlNVnoXjB/IKUzDq3CZB+eMU4Be+jkpM+28OyS6odJaSLksN9bLET
 extM2JJ+o4I3lMXi8av8AYmD2DvXbLjPzYXn/9rg6/pO0lCLEzwm5qhyYI4jFnpJjjE5
 VZFYojuyRzLZvKXcEF2TGqdBe8yZhWXphXY5AZUi/LsMbWufk8eVYOXZYJBCLwdYWRBN
 5MJf4XS1sels49izWgwObzND9voFzmrnzMw0SYgeCNq0mr22BtousAN16D6J9CEPUfyx
 i5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777316579; x=1777921379;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ym6qo9dzu3to9RJeVtkMBicHBJ0/dq9yHAm9EERIARA=;
 b=FzKi8j9dof4JySzSwBYn9EbGgMaa1Eragjn5c79oF5k3z6xU7sdlaSRmTgmp+5hLeL
 +nD+dbavB8ukGha3UE/gMsr8/oXVXOqYM0QPcaI6t1GIhgBL0ThiVgFZCqTrSSWToDWE
 TNzX/vzOTDFc4p58t0SPESjIRsj3lYryHpQ0VgV4i5RtzbzX3Lhy2owSUnZzTEAvu7D9
 P4322gM9lVCNZ8zcspTp2FJF1DuXp1/OE7XtQWO4n8cZPgIM5Y375IyoYpuXbEyKaL/a
 BKYZirnVW4tMqDb0vUoVkeALJNfwXt7bZMKDHHfoW/mT6F3aEBMYnEsJaNd1ZQhowIHL
 Kjug==
X-Gm-Message-State: AOJu0YyHehQdauW60iCi+Gju6MbefjK9UmlfzPU6dS9qMACblScgSLAo
 yDiF9SEeVM3XL3MfxMOWhpLSrI42d8wXPPi6nvpEmcVwtTVqBsDgwkMlsP7QU02oa3ngo13fMvu
 oNuhXkAlSJoplfmk1cRye5H/ABsAj1aIrWtvuUniT5zD4xHLNWEA4CTbVug==
X-Gm-Gg: AeBDieupggoxd/26ukMnEB089DjlRDaGFwXalWUZlELq1dhomoHnMGUM/iFP0BqihO3
 haGAFFwNnU+O5hZncirJd+qHkf4ROX2aJM1JdUMAb0goh4Hi9WfYlUVkpiY58Xhe/kX9J5rJ+aS
 u4cpZQHhQkK0St74pcvLOnS+S9/qgCkEkS4ZtrzpK18PHF5n+nHAQOSi3vPFQNijLTsmyti3gwz
 e82jolTd68hLaFQk16zbuiR5/67mRg031UhBG10Wy9qPRupr16EW8tJaV92jBBW6YYY8fo8yrDn
 EFkWnmaK1foImxoIHpoQhI5laN44R0oIDRPB90CVXHcE2n8aZNnrhjKO5m1PHLcax31GX4RBX2H
 +G+j0/eywQTQvfFog7akziJBHeAzxVjmW8vCUigbApi0fvtaSJtTpVR0cd7VieKp0V/MsAFU/Kl
 d7T9xBksQ9voNHtKiP79tRtLWJ
X-Received: by 2002:a05:7300:a148:b0:2cf:28e8:d784 with SMTP id
 5a478bee46e88-2ed0a0a7a51mr51669eec.19.1777316578815; 
 Mon, 27 Apr 2026 12:02:58 -0700 (PDT)
X-Received: by 2002:a05:7300:a148:b0:2cf:28e8:d784 with SMTP id
 5a478bee46e88-2ed0a0a7a51mr51640eec.19.1777316578094; 
 Mon, 27 Apr 2026 12:02:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed09fb64d7sm160721eec.9.2026.04.27.12.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 12:02:57 -0700 (PDT)
Message-ID: <bbb398c6-6bb6-4710-afce-c40b7b70cdce@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:02:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] linux-user: Filter /proc/*/task/ to hide
 QEMU-internal threads
To: Ali Raza <elirazamumtaz@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de
References: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
 <20260424-master-v2-1-8b50b5c063ed@gmail.com>
 <c4c6e1cd-1236-4bcb-9fab-a65b20304922@oss.qualcomm.com>
 <CALrERebJhL8LPgphbDBPy_PHUt-Z8CSC+ogSOMeWfa+3TeBh1Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CALrERebJhL8LPgphbDBPy_PHUt-Z8CSC+ogSOMeWfa+3TeBh1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gmk9CB4tYdSOw5rZC6-mmagQlqO-3LrR
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69efb2e3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=s9S1oCkgw40gJMijNmQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: Gmk9CB4tYdSOw5rZC6-mmagQlqO-3LrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIwMyBTYWx0ZWRfX14aDknn0vB3n
 BYjZnI/JOcivwbdYpK6XfK8iQMVlayKxWBCKB8Ed/7DQTx5ZL0idqWYXyD9bn0n7yjd1cZLmq7I
 gZO6ZVA43J8VB048ZmahtWimqYfkyKDmofi2ojqWq8DvZxLZqLYnXLQW9OFAXWZBfy36NSUJbpw
 HHzNzMZUd0+T8/T3OyFfT2KFCmK6TfBMx8LjpiPHKE3MUQa+P9aneFgC+u18RNJ/7f2ogHm6iJ5
 pBhY1i/cAEt4HlZ1FWoKBOGBhWqm+voaRqhq9MxOMdKdQqNOAC2z77c9ti6/0578BXnj6qzFSLT
 BBD3C2PJQAtvS4UWGZW23eHZjN6ykRNoxs3Qpkog++nobl681gx1/9fuhn0UC6Pj3h7JYvcMZ48
 v36YIktWpI6jUFQFuRJbuV0Lwllg2pLaEBOpCtyqG+FnUzwGeWrqfOpQ7+d0tCDg30/E30a+9ka
 GuqbHsdG/+m84NBpydg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270203
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

On 4/27/2026 11:58 AM, Ali Raza wrote:
> On 4/27/26, Pierrick Bouvier wrote:
>> It seems like this patch does two different things:
>> - fix issue when all entries are filtered
>> - add mechanic to filter non-guest threads
>>
>> It would be more reviewable to implement this in two different patches.
> 
> Good point. I will split this in v3:
> 
>   patch 1: refactor do_getdents()/do_getdents64() to wrap the body in
>           an outer retry loop. Pure refactor with no functional change
>           (without a filter installed, the inner loop always produces
>           an entry per non-EOF host batch, so the outer loop exits on
>           the first iteration and behavior is identical).
> 
>   patch 2: add the fd_trans tag for /proc/<pid>/task and the
>           actual entry filter.
> 
>> I guess it does not protect from opening directly a specific thread
>> file, but there is no reason someone knows the id without performing a
>> getdents first.
> 
> Correct, and this is intentional. The libcap PSX deadlock we are
> fixing only happens via /proc/self/task/ enumeration, so closing the
> direct-open path is not required to fix the bug. It would also be
> hard to do soundly: a guest can already obtain a non-guest TID via
> /proc/self/status (Tgid/PPid), gettid() in a host signal handler,
> etc., and blanket-filtering those would break legitimate uses. Happy
> to revisit if you can point me at a concrete attack/correctness path
> that direct open would expose.
>

Yes I don't think it's worth solving this as long as a real world use
case doesn't require this kind of filtering.

> Thanks for the review,
> Ali


