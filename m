Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB2EC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvpAL-0001DW-9Y; Mon, 17 Aug 2026 00:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvpAH-0001DB-IG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:41:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvpAF-0004Po-7U
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:41:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLDB011386175
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mO3kJxTInQpsGQEOlJruho+JC+FwU9gA5rw/Ui2bzWI=; b=L9UB4gM4RsXHXGfT
 PTxDoWPNrOCPf+IvZeHnaV8WM+ZWIwm1qG9LCSpXL3hulT8f0CFG/B9dAPBBBp+1
 7Oji1o3SVQFHGybHc+NQu3ZO8jFOFdm5dHkiEw4GLVDn+35unbMNRTf9wrcDHrb4
 7hn0WC0W8bIpWH1IVIscxcQuQakhLRBlAc55tYBQwTz0HlC7VeH5DmQR9L2ejjZu
 enNkiSQgp0ZXneBkn7AiEzSJ5EsHa9fgNCTY+vjyeODYyVtpuYbusKpcaOijZsWo
 sBUGGC4MDJlI+KabpKJmZRnGTHOc9DB1h0/hruyW79IOp4vNNbpkhG/0n30AF8mn
 heYBNg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3mx4rtwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:41:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa3d9dfbso274544985a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786941691; x=1787546491; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mO3kJxTInQpsGQEOlJruho+JC+FwU9gA5rw/Ui2bzWI=;
 b=U/cbc1ZRgY+4p968Brt/bVeCUrHvArlEDI170N8bHQJSv5rVSNYCPYiMQ5N1fNAKKi
 v+zGI9VbmzdHsO60tG+8ZTQ4QLEK06LgKYQt3FVoVvJxiocn/4KfCLrix1b2i7JYQbFr
 WDqrNvioZPVBf9C7F5qjfRD2bt6RqYPTprmtTU5OEqQjmI+mYfs/jyx+vXEr74JqCymU
 2fzl0Ks05vWiYbSprOZDKxbZAKr4G0gUueva1waSVpmfqjeOfngMsFmvxCCNXD1bz2mP
 Y1AAy+4Y5KKZ6vESDxS3y0un0cFe6IOKrvh/vEtY1KYYmxAcuCPMBT9V7LigNBWNvaCc
 4XNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786941691; x=1787546491;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mO3kJxTInQpsGQEOlJruho+JC+FwU9gA5rw/Ui2bzWI=;
 b=BCI/9UaskPzENR+4rqPC94Th0dtyyGblHAoPwmM8dx4+ZgG7arU6XhXdYciTFAzvrh
 mUujUD9RlfrV3ip19tJV4B28r3QBRNNLlAg63FoOJURcToTIoCYQaBDC/8xg3aNG9cGk
 VJ7VFEjURY7tngXOfXZps3NA2EaUXZoFLydsC1fM62nSUA2qYigcVzYwPoM2spIzugAP
 0/B4O8SmJRYz+wPh5ZfeDnQBslgOB1UHgEStir0dVHTmsBScxVOUmvw/WMnT9byk/Ptg
 e7L+ELDIow70foVmKHJvR+v9waD1qjFaQNYbyj8utNovaqa9i5HtPb59eYRibREv01go
 hqwA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6PSr6dZCMUkpTfMF4M2RJV1W8cGh8vemPaR6joIiJxGHK1mdjDLJ1AVIZGarpwHKQIDCtQzw7Srhc@nongnu.org
X-Gm-Message-State: AOJu0Yw0jv0p0rjVqBq1edJwCHFQaiVUrJYOnlc4aj7ac6BQM+6V9rX5
 tq8xzUZTW9bc5kxxa7CTLblZM4wl13lx4sjxDQ9hB+hXJPWrHLEri2Tcqqn1rMs0/Cej3eM0V/W
 WZlL+Y7XOj6nqEmmkAqBQ/lMYSiAhYOdALE1CjMLmDb5vsQOKt/62OJGltQ==
X-Gm-Gg: AR+sD110mF7dFHlgbAcFlQ97mogb3f7PiK4fxAytMLdfkE/u4NBlNyUaGJhC2e1NcOr
 6Guk5WeEUa/uRrDGm37vj0QS7DquWnSak5HNB0U0DdBrIZmX1LdC5OJUbvQjhNQPHTYGodI0rg6
 MX8b5ByvUHW1SIALIMxJuCRu3WSdbKcTbXdybK0XQdxzsP/exC6IXcktTe9R0oHSn0JZLK4IU9U
 ++36JlcNjmb3poYaiJVK4p0I/tsdi7P1tWUCN5ZbrqV9HWhAdEiwacUKWsbH3QIj5+p/cTBsvN/
 4RQILIA0e3hO2U4BYZwtav7TX8RUp12HP/9maznVZRq+rAfkFvzoSL7Y8HpD3acCFR6JZaFVaNt
 s5yrefwYoyMkcKWKu5yOzwSKWLtwhaZ/I0/U=
X-Received: by 2002:a05:622a:e10d:10b0:52d:99e8:46b7 with SMTP id
 d75a77b69052e-52d99e893e3mr91313771cf.22.1786941690695; 
 Sun, 16 Aug 2026 21:41:30 -0700 (PDT)
X-Received: by 2002:a05:622a:e10d:10b0:52d:99e8:46b7 with SMTP id
 d75a77b69052e-52d99e893e3mr91313641cf.22.1786941690282; 
 Sun, 16 Aug 2026 21:41:30 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b7840esm558809f8f.29.2026.08.16.21.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:41:28 -0700 (PDT)
Message-ID: <27fdd807-549b-41ba-9a6b-64ddf4b8b0ce@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] target/hexagon: Add an errno mapping
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
 <bf030fc808d220374abfbd5714154f733ce9826f.1784568922.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <bf030fc808d220374abfbd5714154f733ce9826f.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YXLcH6nmpJGZRQw7aCCq9RGv7THG09nf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX/2/a5C9BsC+q
 DyPhOH1Jt8+B5P3uesq2Syf1/n07gu9QtHf7qfZazm/m6NGRusFibwISy7GB2RCLHiMH3TckhNU
 C8bau9hY5HXcc5S/8UMrOX1CKCiowzc=
X-Proofpoint-GUID: YXLcH6nmpJGZRQw7aCCq9RGv7THG09nf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX9JvuTwxCjvsr
 uXzONoefWkxZIAFTpmd1qcK6uaVkjiNP4ALo0s4UF7GLG7hHPny12F7AgDaLd+RgWHXinOkLJ85
 JdlbR0elHL64mAmz9GRzFGY/snVS3hSqJLCOdWwfmF+tsyYRyhyBnwL2VjqPeWQd3oeW5OpxhZJ
 0MLcZL1lWmNPvSF6HhF7Jc6FhoQeVmWSomc0Xqlm8klQWuf4BQ7ZQ6ageYo/H8coVqZWchUNriB
 btS5R+lhye+3eUKWzIKeod5PoorO4V4FPXN9h7tmw73bsFhVlObSMJxraksRGG3ZJteCDXTbSp7
 CGXr8I5F5hQohGOv5P45aIyuM4nt5TvHromaUWRtE5kkuQnVRTFCCoiEZvoqefH26ajwb2wwzcy
 b6r0yx/3GwkKMEtrV2OQcvFra34rsIpMRRRvDviePgKJhIdi2esWFURCQ2mxfm5AHBzcG8FFSyJ
 uU9ssKQs5Te9edI4rXA==
X-Authority-Analysis: v=2.4 cv=Y6XIdBeN c=1 sm=1 tr=0 ts=6a8290fb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=InKhW32kZ_QPl15BW0EA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170033
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

On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> The Hexagon semihosting ABI defines its own errno values
> which may differ from the host's.  Translate host errno to
> the Hexagon-specific values before returning results to the
> guest so that baremetal programs see the expected error codes.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   target/hexagon/hexswi.c | 75 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 63 insertions(+), 12 deletions(-)
> 
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index 564a11e557a..d93789e39c7 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -154,12 +154,63 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
>       hexagon_peek_memory_range(env, addr, count, retaddr);
>   }
>   
> +/* Hexagon semihosting errno values */
> +#define HEX_EINVAL          22
> +#define HEX_ERRNOS \
> +    HEX_ERRNO(EPERM,        1) \
> +    HEX_ERRNO(ENOENT,       2) \
> +    HEX_ERRNO(EINTR,        4) \
> +    HEX_ERRNO(EIO,          5) \
> +    HEX_ERRNO(ENXIO,        6) \
> +    HEX_ERRNO(EBADF,        9) \
> +    HEX_ERRNO(EAGAIN,       11) \
> +    HEX_ERRNO(ENOMEM,       12) \
> +    HEX_ERRNO(EACCES,       13) \
> +    HEX_ERRNO(EFAULT,       14) \
> +    HEX_ERRNO(EBUSY,        16) \
> +    HEX_ERRNO(EEXIST,       17) \
> +    HEX_ERRNO(EXDEV,        18) \
> +    HEX_ERRNO(ENODEV,       19) \
> +    HEX_ERRNO(ENOTDIR,      20) \
> +    HEX_ERRNO(EISDIR,       21) \
> +    HEX_ERRNO(EINVAL,       HEX_EINVAL) \
> +    HEX_ERRNO(ENFILE,       23) \
> +    HEX_ERRNO(EMFILE,       24) \
> +    HEX_ERRNO(ENOTTY,       25) \
> +    HEX_ERRNO(ETXTBSY,      26) \
> +    HEX_ERRNO(EFBIG,        27) \
> +    HEX_ERRNO(ENOSPC,       28) \
> +    HEX_ERRNO(ESPIPE,       29) \
> +    HEX_ERRNO(EROFS,        30) \
> +    HEX_ERRNO(EMLINK,       31) \
> +    HEX_ERRNO(EPIPE,        32) \
> +    HEX_ERRNO(ERANGE,       34) \
> +    HEX_ERRNO(ENAMETOOLONG, 36) \
> +    HEX_ERRNO(ENOSYS,       38) \
> +    HEX_ERRNO(ELOOP,        40) \
> +    HEX_ERRNO(EOVERFLOW,    75)
> +
> +/* Map host errno to hexagon semihosting errno */
> +static void semi_cb(CPUState *cs, uint64_t ret, int err)
> +{
> +#define HEX_ERRNO(NAME, CODE) case NAME: err = CODE; break;
> +    switch (err) {
> +    case 0:
> +        break;
> +    HEX_ERRNOS

IMHO defining the target-specific semihosting values as TARGET_foo
like done in target/xtensa/xtensa-semi.c is more readable long-term.

> +    default:
> +        err = HEX_EINVAL;
> +        break;
> +    }
> +    common_semi_cb(cs, ret, err);
> +}


