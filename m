Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72BBC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOls-0006rk-In; Mon, 13 Jul 2026 18:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOlr-0006rO-Dy
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:05:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOlp-0005x4-F6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:05:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9ZBa2356054
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xw8ueCsxe8MVMVjLH2nJDGF39zXK0AIoaBukl41DQV8=; b=OXizKvniMyvurtRD
 XmT5Hyw2IZ/P54/Uqf0IBs89mON05LnmGA37ftW1U3cKDvdL2nFac6sLz+jfq763
 SxYbeNRN/XyAbbcP864lWHeuwcwyR/MRHNvrMYSbswce7a9h0XtrlvNOzubHiA4J
 rvQxATSf1quKoHbMq+bhyAYjK9nXsy2D/dy8c67nz2xp3rVjrUXajHVJLARhsogA
 iJ2driJq92XsYBiN+uJundxTJxQGCYWA1bRqGAow80AoAImWY+Od6Zsi71LSHyvG
 q8DG7vBPvgVmNPtAoqgdRYB5J5FpAc/QRGP8SxH3AJmHIPE3AfhA9nIir2vnFyZR
 6l8Udg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4tpj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:04:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c890bac374eso9272161a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783980298; x=1784585098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xw8ueCsxe8MVMVjLH2nJDGF39zXK0AIoaBukl41DQV8=;
 b=IPXzZjYsvV56o73He8aG0hH1htFMk2mlu24Phq+W2Ykt2yszPdL4J7GJ7zuw2Lc6iA
 uEwMEq8gd02rithGJNBaVa4NwCMB5WToEx0oOewWTKJr+aEQxI+HmwtfFUCHhj5WoHJx
 zMDdIJ7rA6hoKfjngEZrAR1eEbgKVAhu8IfHpaP3DRdShPhvWocYzn/7lEQRUvRJ1uvq
 1PE4QsbDWW8PjGNke4Ml1XbPtpe3ErTYe6/kht15O1JL/sISNWXV7F9d1iAKfDUeJ86Q
 C4v+R9tdSv/KJoxre8d7RfXwekEwB3zOXv5qC+X7ZfKNR6kdmnTt68ylZf52muPFYx9D
 8h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783980298; x=1784585098;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xw8ueCsxe8MVMVjLH2nJDGF39zXK0AIoaBukl41DQV8=;
 b=M+xh0092llaFdqqf7dcXIcivqzq8pITR9iieubr6o6aX05zXjcwJM8xQemv+v0VGFN
 EuEqeTMy0uK2pQ4C5oYLzpAz4+Ykp8tS4xCeUTEQUgeFpCJJP87/GCIKGX52broMjmCf
 90ri6enYnDjEXZHm59GibbtqHJLfAdtMKhc2zILs9R27V1e0udWqx/+1Z62nVA0XgMvK
 POBlePe8g21MuTxkjv74FW6xZxTbtifiVhGEcBCFg2DcOzxXTHvLcX4GYPhg335KLJVt
 sKzmBB6I9kSQ2CFwkxBCtqoOVbS/tMWNzcqxjvM44WeEGXHF+WqzjO3+rP7rtZRK0FO1
 S96A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoclmnWEfnE07FgNOl+cZogtoxO+QdVPXq0zrPeoLb0EISRrQ/3QVNJELzIIob9/aweNMr1dBQG/EHA@nongnu.org
X-Gm-Message-State: AOJu0YyD8JV/BJU49MwmI1kqNsnSoKvf+HLXb6aO7WlfFRblL1TjKLyz
 dDQ4zOjHss7ksrFkKe8T2bY2DFLlGM55OCaJ+xYXzqzkNp8nVpAPj49Q8bKolmvdku3FtL1Feg6
 sAih8LEIOSJNpVdbdzVL6x4drBd7oZ+AcKH6dUugS7h2RPHuOlwwgTeISLA==
X-Gm-Gg: AfdE7cmY08GU/Yrrt2wIC8d9i8aGoI+hxb1YCLVXfjhxQOorHOlojEAC6gkIOsXE8Q8
 gnYcLaVWmKdUH47YfOnBijaoqpHwbR5jwWRL1O4bsoUnJnSeC5qiNjYNrc4d9iHjxuF+W80ibSM
 DZY9paa9FVcSBuUjm6m0PjjrhxOZ7bHHLnEelGCsSEfr3/3tdTbOWTaTSxLH/Y/ct9rZzEMtjgf
 3l4TtPTcXWVKRivkI6DcDVAsVCvur0DzgnfF+0s7lczIPA2MxStF+Z1J6TIJVDfU6cKCCwIk05V
 W3YgwWN+LgYWmIhObQee2l41fxyK7TIKtXpyXZXw3LVgcVwAsvONPTB/piGtxy/ZklPEObz1pSl
 u+n0RuwhfZUIR+S4+Zz4cvRWm3oEUC6jEHj/U53tFLIPo1uQW20G2ylS/ziYNZibVGNOtLBKYDI
 YF7o0=
X-Received: by 2002:a05:6a20:5491:b0:3a0:b781:4c78 with SMTP id
 adf61e73a8af0-3c11003090dmr14041572637.15.1783980298487; 
 Mon, 13 Jul 2026 15:04:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:5491:b0:3a0:b781:4c78 with SMTP id
 adf61e73a8af0-3c11003090dmr14041551637.15.1783980298086; 
 Mon, 13 Jul 2026 15:04:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b8a5992c9sm28391901c88.4.2026.07.13.15.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:04:57 -0700 (PDT)
Message-ID: <6b0eb6f1-598a-4002-84f1-d06a4f7dbbc1@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] semihosting: add APIs for chardev-aware guest fd
 routing
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <726a21863495a931183c24519cec26026eb01b14.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <726a21863495a931183c24519cec26026eb01b14.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a55610b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JhYl8rJLcmmNIEtEYJUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyNyBTYWx0ZWRfX5Z3SLWC4hW+R
 je9NgnBQLpsq7MxwpwSM6hRrXuIVt159orvQmbSWKfgg5bYTPB3UdMB+Ky8icVQXGDTyWkSyzzC
 RlTklCFXDS+jdQY3Xtzg1b5SidP1GpE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyNyBTYWx0ZWRfXxhQ+NV4X0lbi
 YhaFUmlkXXssvZYmPDzb359GNiU0PZAd3ZPlxLAkrimRitHtwPuVhoZ5uTHJ+Tq5Cth+FE32yg0
 41klOqqyVcXC/nu+S1RrqoTZz6cxsVD4ohD7Dcfk/HmQDjqnhyp0dddMEOmQ3iXjez3PGhqlHmh
 nLNlnlrQvq/RrDJR4dWX7ocQT4Gs2n4DsCyL60gAxJPIga46NGQtbebihMxtzQlaijKiJew+rwm
 w4FZxGC08QiNiaAyAB8ZEsaT3T3CIczg5yAv8i8tfLZbZt3MoGyMMHl5cxltzYaZG91k0RmzC2B
 xuojfKDmdiDyT/BCf1+3s3XxJdPUOX84iaS7g9OwlJTbK02N2NSIaoef3IjXFouUuCu+r94fJaw
 AkdrjJOYiuKN56XfKS/hL43aZOjiOJUM0ofo4UYeFwU5kAHLeQ9ys2LmWICEmAi3wCPpIdYbAVI
 LrYq5I8Vhyq8KCR6lrA==
X-Proofpoint-ORIG-GUID: cRiMTSgQKWdsymzgykBp4zgybBawe5DS
X-Proofpoint-GUID: cRiMTSgQKWdsymzgykBp4zgybBawe5DS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130227
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
> Add qemu_semihosting_console_has_chardev() to query whether the
> semihosting console is backed by a chardev, and console_guestfd()
> to initialize a guest file descriptor as GuestFDConsole.
> 
> These APIs enable callers to route semihosting I/O through a chardev
> rather than directly to host stdio.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/semihosting/console.h | 9 +++++++++
>  include/semihosting/guestfd.h | 9 +++++++++
>  semihosting/console.c         | 5 +++++
>  semihosting/guestfd.c         | 8 ++++++++
>  4 files changed, 31 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

