Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D399ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENMG-0006oG-0m; Wed, 07 Oct 2026 04:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEKZ9-0000KS-M3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:52:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEKYx-0000UX-94
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:51:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6974U9pG3264015
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 05:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jDqU1asXJVNklrJMBXsgkl0awJ724rKzgxqsm1RENOo=; b=bflIWJ6yJghTXTDP
 Ddaz3kCYbfcAaaE6sjzBi7izrIwz0+7ThU5MGFsDu3V28kL9REJdtiGSXd2U76D/
 1Xl4BokxmKXWL0oN556mkqRJXdWt6GhuRv+Zoduxm1BlmpB1v1Yds9nM210Dwvsi
 YDMcYWEvmO341CoSUdpQcFaOq6+E4Ij46vTxs6pFBSmQWYYjqarNM/03GX2oAJbV
 fr+qVN4tmPOH7zuqFpWw/R149MK6st/PgvSonRgxhFf1oKKxqJDyADokmn7fqH/a
 7Qucu/OM/SrHpD0I1q0zgGZQ7c3uXI0JQkDSJ6p78R8GvJ8VAQetLDNDN+/POrsD
 HBLmCw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c608rsj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 05:51:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso563256685a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791352290; x=1791957090; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jDqU1asXJVNklrJMBXsgkl0awJ724rKzgxqsm1RENOo=;
 b=O1yzfR8pI5iowo0eBNxFNpm5Az6APM7vkzceKFV/Iar3mrL5CbpeKrfLRrGW1u3oBk
 tgmtGKM+oyb6LN9UB7SgQu+Wt9tstZ4UFSShpKtmWn+n1RBkT3Qc5ceVQLQ2cqH84U0L
 O7QaPRLZ6ECKLR3UT41MJaj2SK23FUBvBZUAbOjCnhY9MSZadZUx7CWd39iiURf8AfwR
 wTSU/jJHOtQdi2bfPQinN4OcwjDWoyY8xAaURmXTKvASDJ/ZFEzhQA+1xK0y97bLpFS2
 4luOWhbahR/5O61+1BSRMqnasGbtJ5/LQx1RcqsLoL3a1ISF+kiyOj8ACadvBJ4DGdwx
 thfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791352290; x=1791957090;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDqU1asXJVNklrJMBXsgkl0awJ724rKzgxqsm1RENOo=;
 b=wCeyZHP7MnqFWLCmj+6yzJOLBN4qqswm+7zC5sSoxnUAssC58aZAl7J/kDbi1ASCpJ
 DwY/b+50eHKsedpChpOGHtNqHVfjXqftUHcqImzeWjlbUY9vedweBfmGgWGkKLV/HQ5R
 Tfy1uYgMKfm8vpvN8f9JxDglKpsJ7lqXoWmLSFH7jcHMZwk5UgBmc4H2V9E62wXS7350
 ljyob8pHJKIchmS0/ACnB1AKpyTjwQINSlyOfsMfUM5Ek6OCalJk/23lFcbd01Q+WO8e
 gGv33NjTUMmXdKOfXXL1LoPCJRi2T7hTJ7Ihut9eLHUT2Wu1r25iJ+g6x4hkc/OXqNxh
 DRTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy11Py+Et+PHrnd9QFPWPQpySaMaPEWSGEMYUg1PXoDx1IU/st7rUtpL1kzRtVDQymQu9ntKFITJy9C@nongnu.org
X-Gm-Message-State: AFuF++kkXzS4IqVyaUfR2ROmVzRARTgJJ5qPLX1Vaj7dOt+igNLNxQlV
 VU0Az+JpIygM7atacV7sSy/CN1t9GNjgi84+fjtocsIDl/TKi4td8WdQDjXogl+8JkxjF+bNJc5
 JhBQcJBRlI2skFmRSuulCnT/5fb00RLZ6aIL7Kxe5Vf1vD9P/5pBBc9IU2Q==
X-Gm-Gg: AYBFou3p3raO41B+/115orSUVyS0P2NGZhq9O/23hqN4YdycblEx/oHFVfWRlGRuPvl
 77xoOzi1cuU38q3A9+oyXer4E/702qDMZvJ4wpBd3yaDAHCB8zuxsiTzKy6t9+Idb/g2SHIIbc9
 eXFlcWg7EE7Sok8JAsltOBc941C1ih+o24te507DG97q7nzjiptZNHvy8fpokSVO2SqVeDvsunn
 wOxVBmdSaWJxw7pesVzbk2o3T7hNkno0duRbmqqDnZDg/Ic2ZendyR5nWoFKepClB3X36+W7W0X
 CShCnDFJguFPPap7/Mv50t4ywGhv6FJCd/ZDp4pD0uJpXD+3hKAuvImR16w3ppykc3gHWyyEaQN
 fElajy+N8kvP7Y1ekwzgjfLvuhV9WkkJT8g==
X-Received: by 2002:a05:620a:394e:b0:93c:290e:9e9c with SMTP id
 af79cd13be357-93e860404a9mr924133885a.16.1791352289926; 
 Tue, 06 Oct 2026 22:51:29 -0700 (PDT)
X-Received: by 2002:a05:620a:394e:b0:93c:290e:9e9c with SMTP id
 af79cd13be357-93e860404a9mr924128285a.16.1791352289477; 
 Tue, 06 Oct 2026 22:51:29 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18044c970sm18616775e9.4.2026.10.06.22.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 22:51:28 -0700 (PDT)
Message-ID: <d9f09744-4d92-47dd-a1da-6d20090662cc@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/27] target/sh4: Define exception vector constants
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
 <20261002175037.1747-7-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261002175037.1747-7-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ljgy5iq1gmEV-rNusknXgYGUDiSsp_L4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyMyBTYWx0ZWRfX3bBH5hu0odk1
 CZADTCs27h93yBpRXo56RwrOKRnZrnoes50+YIMwhAHLhQWG5u72i+OYA/fPrO4oFiHqjG6W/Z2
 f4Jl2RkWqIXgGUHWJi0of9pq96Ppj38=
X-Authority-Analysis: v=2.4 cv=PM+aavqC c=1 sm=1 tr=0 ts=6ac5dde2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=5KkIcTHh3hzyv8iDLVEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ljgy5iq1gmEV-rNusknXgYGUDiSsp_L4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyMyBTYWx0ZWRfX1gz2TgS2T0VR
 iO8/csJwwkoAeAM3TL+C4DJRmb3jbGAGew2azarN2adinNqcsdYltK1xUQwwF99sO3eNY5dX/+f
 KRI1nlpZNMTB+v9fwhYJ9YwgIg3MyK427NCf9LKAOZL1qDVt+txIaZmuq41XjALOlMSH0voSIQf
 wyPIZP2Z4jJNlDLxQN1/kvZ1tMo8GzQzONoc4k+D0Sig6NSstilIvFlJPDBixpXZFNxLgpKhmMw
 DUkkUfLoryMlAwHNdSGIQTk2oW7bGbNYNxDJnL134c/idFZ77dOu0pINfuPut5pmpzQhaf9hyQo
 ooT8GNxfAu2aZGm6JASlsxSrpEXaaXtP4gp2NWRL6YAtU/1VKsNPU4bAVZIg9wAuWUgEDca+lEy
 Qhv7xfdKyFSkpMHkUyUu/56K0Gmpa2OCXyyRXGOWUdotnsXFGd4X6cJFFuAj90Uc1cxP0FaD26r
 5Dn3wpoxx80qBqPPpHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070023
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/10/26 19:50, Yonggang Luo wrote:
> Name SH4 exception vectors and use the definitions throughout exception
> handling and exception raising.
> 
> Signed-off-by: Yonggang Luo <yonggang@gmail.com>
> ---
>   target/sh4/cpu.h       | 21 +++++++++++++++
>   target/sh4/helper.c    | 60 +++++++++++++++++++++---------------------
>   target/sh4/op_helper.c | 16 +++++------
>   3 files changed, 59 insertions(+), 38 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

