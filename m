Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661C7CCF2C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHoVk-0006SU-0H; Fri, 16 Oct 2026 16:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoVe-0006SB-GE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:26:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoVb-0000WT-EQ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:26:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJergg2635356
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a6jZGwesL+WZG6bZTHV/TCSciSf2ISHl3Xv5frVknmE=; b=AIGQI+msGnEAv/GF
 RtsLhBuZA3wEE/Cj+yOFzCrLxFMo/DPEYTi/9XS5mKgKu+UgDVB05qgbGBLIdJPN
 kLfDYqnxfzwImdMS00Q2j6leCz1St7LnFV8k6byXfWmhaDX62MgIhuxwe4jYITkM
 HF0AqQe8WemSe723IqmjseDLzJXvSOC2YXBn7tzjKv1qLeSk0PJ0MPVeuba1BWRI
 u0gyvl7gEMkRV97vZN3MlkL9C2EBC0Zn0JxLc/F6Ys9qHCAnAfKyPVy8kAn4pkul
 xM9vb8OXwBW4GXTLTPbXM7YnM54wikGs6ZOly+yraUcZqjGpcP5xmI9S81XvSNgn
 ouRvZg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmfa2nu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:26:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91792488228so6932006d6.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792182388; x=1792787188; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a6jZGwesL+WZG6bZTHV/TCSciSf2ISHl3Xv5frVknmE=;
 b=QDL8+u5Ad+n2LJSDJULbXfaQbz2p+EjxX5/mAic56njQFwucCMVyIcGPzKX+py2QGg
 n9qpG83KTVS+ttguIaCaUqQpbLoWv3oyPgK6hvpse3BBWZlsvxQ0j6yB3ikmFmL6dddA
 eGC8hn5VekU4Q9JQUk0gwJgV8xDh8IDkBjact92Xqh4rkNusjLzaFd5FhGvIDAFzxLaK
 EXvuZ8pb4JFmbVbwJvX3BSoEEE3CAgqi02lfwBcC+n/Xigx4ag2wXrhLFLpSd8cwXmAi
 Lsqrv4paKrGJkHwFHTqCTT7i8AkFmtmhRCZocNDSvpJ6AtoUkRza4+7KO6QxN2tLtkTi
 T8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792182388; x=1792787188;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a6jZGwesL+WZG6bZTHV/TCSciSf2ISHl3Xv5frVknmE=;
 b=pUKrF0W80j+ycvdqdxo82TMcy2TfV3SmFkspuSObOmkcrJ4nuxoYGe/94x7JnXaeqX
 oFvFzLeifvcBKFzpJnRncSVtwuYFybTXYn8WRTlNIHWPQL0A0yFzxrpaaoV1lQshH0tz
 o54/1j8GE9bvjDKJPJs3/JokVXNVhDYZDR1kbFWQVT38z9yP5u0h2jR5Bk6YEWdG6jj0
 UgIeaRu8isTijPNIdc9w9DLHVEXinYEyT7irrIjbrTIdJHtdV1z/Drl9qJKlG4lClE5N
 jVFsBHZqplPL/8tXGGS2fiIyph1f8FYmR0ROwNuUfGHXoqbQW5fdtXLqBIMJi/hdDbqL
 r+UA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhOfnhRVwzyu6MSebnSNq7MGee+rlnTj3Ffnnwtcy65q7gx7FKa/aWAv7jayh5KbsjmPJjHHXqm0sI@nongnu.org
X-Gm-Message-State: AFq9FYK0rAmicaGsOBq0abnAKGqF4JzUh3X7iRjTJdu5V/hIScCnS4HG
 GWKNWf6VkVdyQHdYfHcP4D3DwmBRvK7pks/AmHaAdTYhjik0VRzWwzbbztL8v/PjEUy8u+43VWE
 MleYuv9bMMC+vlXcRsGiDbFIIXtj13MjlIgyFFfNp5jrx8fmPKtDt/5PGFQ==
X-Gm-Gg: AYBFou2o0O2Hyq7txeNpBytdU4UpuShiGNXh92x8PpMbwXfjyjKuoJh/gpFvuxEAQ6W
 oKrwRlcgap8ROq/7Ro2pDrxs1qbs+zAxMtblOG2FjIYN1C9RZYQsK8TButUEUQqWYrCJQ+pk9Yx
 5qRT3fgA5smXX6h1uduNYcx58BUDIPRrmMN02KFQ9dY4VwF3qBjskgcCOVuJYNCikW0qY1VmdCO
 qZOQduOW0AdUHDYKeLR6CBxrtvcwagqV9fkEuq0FM4OTLXRzEC7H0gj/fBVyyx7ESDtk3xZrqbx
 lmQOWN6HRVY8xxtvAeQrberBxVof7ybQlacd+Yt1ZL5/ES2cA6dtIcuRj2CJrIQPvSCIgji0sEZ
 Pnbia974waTDLVew0SUXf2WLQuMeci49fgks=
X-Received: by 2002:a05:6214:19ce:b0:915:e9f2:8e5c with SMTP id
 6a1803df08f44-91bdf1762edmr21548786d6.33.1792182388405; 
 Fri, 16 Oct 2026 13:26:28 -0700 (PDT)
X-Received: by 2002:a05:6214:19ce:b0:915:e9f2:8e5c with SMTP id
 6a1803df08f44-91bdf1762edmr21548396d6.33.1792182387975; 
 Fri, 16 Oct 2026 13:26:27 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bccc721a8sm29554246d6.12.2026.10.16.13.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 13:26:27 -0700 (PDT)
Message-ID: <f9867694-79f8-41e2-b472-4e378bce367e@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 17:26:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] meson.build: add riscv64-softmmu to multi-target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016182751.264704-7-pierrick.bouvier@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016182751.264704-7-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: w1AjraP8w9GAQpLQbhQ5vrdNQYlzSk2Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX5bjmP08U0bsD
 DRKH5PYl4nxqGeEnHiZpwoNNqnJfTXP2p9ShC+45bwW9oaqz2nZZLKDilTehV775odZRJFYS1rq
 sfIP5zG1MKdGgpVGcJBOiVWPE0Sbd4A=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad28875 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fqiUxt-a0FkGlwhUzj4A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: w1AjraP8w9GAQpLQbhQ5vrdNQYlzSk2Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX4aiRcxeNpbQQ
 Lr3OWt8hoiMS2htabhxPQxi35Rc/KZRUZ5a6KZp79zi7EZUDBryysoXKNaFeaUd7ecINKJ43C2p
 p5PxqWB+Qa6K0YAoTIUIB16dG33mSSmBirig+0EJhneoUt39FtKNqhb9w+yVfayZRkY16tYyWqq
 lsQYqfyPmixSrBohFb4yjAwiyDieQ+ohIbj66I0g+UNWNLBVSvxhzR2LMqHmcjY2P+Q/dgQj9pf
 4Tn+389A4NIjXcJG1R29AeXX6q/VzZXJlv8WgJL9kl3i9F2Y3xG5UxyUAHiTw1JcLxu9iI/oX6o
 Ua/ZOzGy40K8ID7cyHa9dVmNFJPVnInfL81oRJhhjGhpPdwAiJbk2+W6TCaRbXlbI94p9r2i5eD
 i43ASiVeF3p7J1k2wPjxkO9/zd/mns25wC3lrNNkiVdZGeCaVdU7LFuB5h+UTUKgfiZr47y/jNq
 NG0I88drPKUWdfjGkwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 10/16/2026 3:27 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/meson.build b/meson.build
> index b67a97ab458..c76d1bba5b2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4280,6 +4280,7 @@ multi_target_supported_targets = [
>     'microblaze-softmmu',
>     'or1k-softmmu',
>     'rx-softmmu',
> +  'riscv64-softmmu',
>     'tricore-softmmu',
>   ]
>   


