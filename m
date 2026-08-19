Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C7DC5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUVg-0007Wr-S5; Tue, 18 Aug 2026 20:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUVg-0007Wj-0b
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:50:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUVe-0003lP-Ja
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:50:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INl2mI1833054
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4JogeOo9gU2q5UYN3CjTvE1XrSCtBLXOPZZ2ilFI0WU=; b=YnxS+Ahb09dPGreR
 1MZV/cNTS3FmPQmH+LuNyzE8DcqQt9UInWcFKnwO9KLNDfgW7uaMqGy74TcJv4Cz
 k3Qs8M4Nev9iiaeSz919EK4NXtBZALDt+xb9rOvJUJfycQFBdRFhSG0SLaJvL5JP
 TPdxFrcOiqR8nH7I4vPKVsurXAZhQoTnb6iQtkcEpnkK3GubRb2uUfhfPSL7qCqr
 427SSMRc8nXevllu8LwrlcHZOmcSzp+J8nIZiDflQGbBzDTZ4+sEFb9l25W0O7aU
 gdOWhYYiBRXRUeyfH3hCE63PvHGO7+gEh9M6JK555HjVDrl87q80Pk+VkHeCDtrM
 y95xrw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm0k2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:50:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930dda91cbdso89801185a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787100624; x=1787705424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4JogeOo9gU2q5UYN3CjTvE1XrSCtBLXOPZZ2ilFI0WU=;
 b=gygEwe7zefRFhK5l3j1VpSL189wZewyqKys0UJXX/k3a4sXXAsMD2p6qfNath+i8be
 atbfhIVKgA7vzS2I9TLuFLdK/T7r/LcfB3R3F5WZAdn84gZkvZkgMsr0V5E5XYn1QRRl
 wG6dqrtVoUw0SQ9KnMdVf6jbQeuGahokF3B14zGP+QrCN4SLpUE6fpEeWfRDJeReesf+
 O4ZuJXoagRFtSy4DR11QQ0Dwumr/XHABI83Kqrndc+SeYMeiEZuFaXbDOkBahm69tt+Y
 loYRQovBnwjaxcqwfQ6EstoU6UpdWB+8jXHU3tsodREpW8DKNx33L3RZe3609EyG+u/E
 OCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787100624; x=1787705424;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4JogeOo9gU2q5UYN3CjTvE1XrSCtBLXOPZZ2ilFI0WU=;
 b=j52Mb+FjCOHLrf+qkx9uKH992OnFJaBtnJVoaiyZnf5obGPvzsTTHeCNjOo0dc1j2A
 kdoGhUGT1ccYwKLrX9655JuSIh5PTiL8QwSYcNtxImF4OBvmf9lAOd5I7EY5e7JunVRV
 Zi3Gu7f1vvmQnUxMBUn6osuRdJD1gBDxDd1z82oS05QB4EafNxH62j/CGluWX1ysWMTW
 PH1hz+NkX2WoIkYVz8H7Gtn/ct8qS0oKS8H0RFyIWcbiL1XRrcWVTo2J4cXJRgV/CR5b
 rYhaO/MkC6bVKcVOktgoXWsco66ptOJpkWk0Blh3IUu6G+KqGbxZBrt5nJsFyejBH62+
 eNOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB8aa0EiKcYEU21cthv8lZNf8/iOHuYLftnlkQzhKmDeLW3I/gJJ9IfGcG62lfD1L5ZY7YV4dq4t6Q@nongnu.org
X-Gm-Message-State: AOJu0YzCt4NF7UQn3gxplts5TxtaTPxJIDZgUDGUSVgUOA2WiBRlQUJL
 4egNxdzpCKMYJj2nCBOS4YeGu8ArfTh4ftoxRjrRdfDIK6jeHXeAnOCpZPWe7bCjgZhfuiwd8TZ
 2lOoGbXDeSYTExpeAsvF6QPCnvVpjDaVkLju/UrqUgofWw0LOmFO0d8vQrw==
X-Gm-Gg: AR+sD106b/yO4vxZ/15RfFWn1GwwVgW15JALFJTJqb5JfLBsWxNEVSmkG9Aha4hqmrT
 7ucPyo+C85lfFjIBTWVhHb6nE+g0eg41CClALWwig8miSR/dHPxjQv5wYqd7zVnRfbGV0tYwfzy
 v62CkdxClsK4QdlDs4r2RTJey/EK4+xOwOpAPnSGJnuuu1926U2pTSyL2qSHnaSYkjVc0ejN5w3
 DmBdk/5Etl7+viqi5Px7kzvY7TtBesj1YQm/p2R63SJjiNghDWRmx7nz23iJ4UQdDq7pUVZIzNi
 FaPY4gjmYRRzCqHC6BMs595MYQxxkU92hmqKMCjzfovUVNO5BIKEJaxjuxM/LowqfW7cmV7cOsR
 2tQCoT7Re7vLIzcZLibQDlUATw/txF7wKURs=
X-Received: by 2002:a05:620a:2602:b0:936:af9f:3f3b with SMTP id
 af79cd13be357-9371e65c865mr125477985a.44.1787100624309; 
 Tue, 18 Aug 2026 17:50:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2602:b0:936:af9f:3f3b with SMTP id
 af79cd13be357-9371e65c865mr125470685a.44.1787100623650; 
 Tue, 18 Aug 2026 17:50:23 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e09905sm20047355e9.4.2026.08.18.17.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:50:22 -0700 (PDT)
Message-ID: <7314744c-d684-482b-9034-244658d946f3@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 02:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] arm/mps: Remove 32bit define for MPS3_DDR_SIZE
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-4-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818172012.3052821-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JovA3_7ymcBUFKSrPB6ySdAp5fsrT4-U
X-Authority-Analysis: v=2.4 cv=bth8wkai c=1 sm=1 tr=0 ts=6a84fdd1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: JovA3_7ymcBUFKSrPB6ySdAp5fsrT4-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwMyBTYWx0ZWRfX6+tT/Z7f0dED
 S9Jitntvs+gUJ4EfbTqORocz2jxNBK61Lvg1YK8K7gIejxemiGI59xwaamkm7AGMjIwMekffs8a
 NSiQEJTbAe0YwXGSq21aqhnM8hF6/0ZgrHVYeeGZ79gYfoICZTy5/j8dmu1OeBE/syz/2YlhzoA
 Z1+RrGZ2KrWqJaNuY3t0bR/JocrKOyAlHo85UaaAdAxZVOisWQ2lcopJVBmwwSFFVORJYllYW6f
 0DRzzW+jnr/wPKBs6BTEQEtOPThozDbpOZDuUJi4GcgGYT5e+pU40sh/NWJYTm8vXwuc4cpSkD8
 IJiGZbSZZRQ5ZnA49A+1uUazGw8pUgSzA6rEBhX+MYEdG7ayauYbg92DE1mv9fyr3xoI50TOwT6
 V9jB/q7Rch6SmJWk/aH12Z9mQaPma1hNE9m8iTWM6uAMeuxLY3yJ9nN8bjlFh9crzESwgvUKxIN
 eR/Pk9TmiuqQs4pum9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwMyBTYWx0ZWRfX8hrFgvVeA6vd
 64+eM41J8vZKW6aMX4YJ/JP9fvJl2xZ2dIAlspO0v7gZz2nuwKsTU+6UQcJ/C1i8Px2EyGZIs6o
 69WPQXEVDJMM3lsbHH3RjTSbfLh61wE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190003
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 18/8/26 19:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system emulations.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/arm/mps2-tz.c | 9 ---------
>   hw/arm/mps3r.c   | 8 --------
>   2 files changed, 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

