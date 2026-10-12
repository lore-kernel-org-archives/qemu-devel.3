Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8873BCA9EDF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGbP-00071I-GQ; Mon, 12 Oct 2026 10:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGGbN-000716-6D
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:02:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGGbL-0005d7-6N
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:02:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0atE2679908
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NIuU6LrfdtuSmc9/nEQ0rKSBZ4Dqle6faEvnPayMiIA=; b=gNz0cbT+cSj0ycbo
 RwqKEKOK8QYzvce3oQ+wx6du7rgPR/iMj4zW959PVL4Z3P96XB7+1aBc+wOYmub5
 x7Mv+DfF1553bftoN4IV5msBaLvyCFA43p55IsGYvQhcEVs4a8M/0AvGCSQp0oTE
 iA9JkisLg2oyczidqZ+r/Cyof5X3EDssyn/qIoxSRRmqqCahJgzUFvtWMW4YIjMp
 qdhiyTzv5SZIxUmvXVbXbb7/pj70BOyXV2kZlADUV+UFUHy9T/pywiyv3nBfRPV1
 O/75xVRIQiUxQJ5T38BtFwqtAlzAfJSGQbfVbTOo147uCFAeFQW7Xl0UjVe2Co/5
 OcKTrw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1t8pj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:02:00 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7c39a674d83so4059957137.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791813720; x=1792418520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NIuU6LrfdtuSmc9/nEQ0rKSBZ4Dqle6faEvnPayMiIA=;
 b=DX5YNdCEfLv+bpgLinz3f1BwMpvqUA3J6wQ/jrGarEYMl5Sm6q6NLJ73JqdRMiLQVo
 UI4u4/YjAktRk1WHZd9RGLnrVSnUCD7RkpxWQUGB+5bEG0KoGzAS8JjgXh7Z6T8I6j1q
 pyjJp9tZ6AKdJ1BgEfKoQ36OccDa/BQvRs4siq+ltHSJDWnoOTES+whc6o9fTxk+kyVn
 KHaz5FB4/Jz+U9scDb5uwmNqD11KWhKPAkgG1vhL4RF3tUoq7qaQV9Jir/bBAsWjPU6m
 SEmqypABEvXZ7uvUxjPUZ70evL3sWzN03KqEBUwsx63FuRNqxEkFNM7WwbLJruIpmAXo
 rfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813720; x=1792418520;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NIuU6LrfdtuSmc9/nEQ0rKSBZ4Dqle6faEvnPayMiIA=;
 b=fogFzaR1n5YUmUNNQLa1v9W8oCunwwxbl5fqt0g9Ns+gHlsooOpXwra6evV/70ZVNF
 pZOXf8fup3PCTKPIrnX3hzro/mNFNltheKA45Q71luW2gj6A4J6bqqtGHhtFJCrNNLoS
 bIA9gErl7lnD9bXMIEQDtLGIDHro69/+Drr8pom/grJ7Nlo191wnTf9qpIkPqBja8jtL
 WdOqxkigR1pnU0TuObW0pLbUtQoxI2KHtWmB9WADJ8Wdbnddt2Ypsy4xKnfzWyimGMAL
 nXQzEJbuqBf5+DEgod9hntBnpzDkMQ6hIvRIJ/bde3zt6NQPxpFp5EFjvcjasqtjcEO0
 20Jg==
X-Forwarded-Encrypted: i=1;
 AKwUvByZcA5PfRmWvOuDIkgEojpZnWepDt36XDFdrZDAU+b/Mbz9S4ObNE5yuK1levx8Hu2uee/C/GlIbYV7@nongnu.org
X-Gm-Message-State: AFq9FYLJFWGiiLX9gnZ8zK5f7k7yPbWUc2z5taq6y3VhVyUMVr2KsYr2
 PKLK5zrD0BEm3QWXvnWscBo4ubrc8yCwMKXspUOiMnv67uu1Fa6kbJdW5esMGy/xMYOdTuL5FlF
 H/Gw2hp4Y4fUO1GbDGUb9owK131nDr59jhax+7eF2vm8dfzXZhd2XXMCuew==
X-Gm-Gg: AYBFou2c2y+M5bxtwVvHIn8DrikjAnrS+ty3A3NJ6YiTK/PlXxhE1TeKoBXMeov3J/d
 FWRVb5VfBuFETeB/JzBjqBSQ89U+c02qMTO3bCteteQp7HP88lBA2lLMmRmChnETFJepW0RSYKC
 j73uI3kdUzCzzy6nn7pdGcQd8rLvrmL4znpRr+Vn9yx98G2Y8f2yfK8jpDw2HtjD7Bjzq8IZlm8
 VcIg8PD6sonNiAf3YGShzxRydRBRdMIs4RCSYb86CsfNul7APTYT6d38hOzSnYqPTWuWgHjd3/S
 vIIVvMEsf7EaXMVGi7r4XC/D6veXkq6VCSLaCNpz14XMFVSxfnmeKsiHIA1Mh9wn/xHc41X+Egh
 pS33x/8/WzXRpDUl98Oo/GRGQGbT/L/EajITkFSIamwfwJ8G3xgAovUKGWbRQsmxwC6yi3SupxP
 qUiZQ=
X-Received: by 2002:a05:6102:3084:b0:7ca:5626:11e with SMTP id
 ada2fe7eead31-7cb3a10e7d8mr1457515137.36.1791813720212; 
 Mon, 12 Oct 2026 07:02:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3084:b0:7ca:5626:11e with SMTP id
 ada2fe7eead31-7cb3a10e7d8mr1457483137.36.1791813719683; 
 Mon, 12 Oct 2026 07:01:59 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b550ce8a5sm95938436d6.40.2026.10.12.07.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 07:01:59 -0700 (PDT)
Message-ID: <9b2e0d72-d0d7-40d2-9c48-b5878f1245dd@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 09:01:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-5-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q6NBABGtO5EVplrDa8btzFF2LB6VHHoM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfXzxxjYDmADQGk
 FLZMvXrq6NBmPE1igg6BLy7VUvCqhkWf+0ihuAJcX0SWc8fzjBmVsnDoUGhFMEFQhUBJDaS6Tp9
 +g+PmOvYyra/LKqa576A125wo+BZzLE=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acce858 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=iyC_-DbmcBz2VEbKfY0A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: Q6NBABGtO5EVplrDa8btzFF2LB6VHHoM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX7a6T4ikVTPi+
 Ar89wLFsardwh1ahfxZ3gX/AinOkskV9dKZe9zen/XfZNlO0rmz/55V4s7RSJLyUEkpo1HvsmO5
 KdkK5fRjdzrfMgls3nq0Xa2uKoIuWhVvobIwgHdGK2+qE7slZFgy6dxS1WUHFnMp5dOKeSjab6v
 u+//qIz0beiVTQfALxMCyHiL4ljIO1eXPcmNmAXH8m/zlvTyIo+HpqocR1ydm4VJaiSM+PEhzEQ
 Y5ptUWb1F8mdSAgl9Kiemul+Ge94nwv5BrvjsiK5k2v62Pu1G0VI+WA/Fvs4c/em1OYzj/sC0ld
 0e5TxSSuniWeMFAuk6kDXRhWPZO1yUMOi2r5yZ37avMgQSzcgg4sQCXJBkCovPug44fKEh9v06A
 aO8Mb9cxTIMVAjjBmyIyWFlTHaPXI/NLV/qzqLDMjZfD+vzczLUcCvIpXBqmrHXtDA+/yNCypys
 5InO53gJbygReKueCAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/9/2026 5:52 PM, Pierrick Bouvier wrote:
> We introduce this since upcoming semihosting ops will be in the same
> ifdef.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>   include/hw/core/cpu.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 328e30045ce..8160a301978 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -183,8 +183,10 @@ struct CPUClass {
>       /* when system emulation is not available, this pointer is NULL */
>       const struct SysemuCPUOps *sysemu_ops;
>   
> +#ifdef CONFIG_TCG
>       /* when TCG is not available, this pointer is NULL */
>       const TCGCPUOps *tcg_ops;
> +#endif
>   
>       /*
>        * Keep non-pointer data at the end to minimize holes.

