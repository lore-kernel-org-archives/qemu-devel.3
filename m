Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F5C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsWj-0004pi-KP; Thu, 23 Jul 2026 08:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmsWg-0004pE-0J
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:27:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmsWc-0006pJ-0O
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:27:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qeuJ3648898
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 12:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xNphbIzswM9eFwLcfCGZbRoQNelEB99q8hXmKnFIwF0=; b=FpxwZrfBb8LrKrGA
 839s7w3CeR03Z1WpZ5jK1d7k2M5RXY/nJyr6XyBxRwEYzlea9AYeyyYqJRZGiJl7
 3rTg5ljK0JG41rZ9LAbtuJMl6aKwM1BJbxWtyV+AAxwhREGFI5bKRyNcsT7ip96v
 HGyisxtikKiIIVzkYYWjeZq1s01dGfZJB+N5tJsiiEUi5scEzdKqn5279nNsv3Pd
 diRyebJgcFqM28yEGT5Ch7TtKoUPgNBPCxn7X6TNF/gUDRstB1dwvw8cyDGGbKVv
 HpqtmEbXxl8mwAu6RLzLun+PMFwdQE5Z50GTtpj5SIK+wPvvv0dI2Maa91muL7Qe
 leXyAg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk6c7k062-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 12:27:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso12029871cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784809659; x=1785414459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xNphbIzswM9eFwLcfCGZbRoQNelEB99q8hXmKnFIwF0=;
 b=VjoDK9WE7lSSBqHLHv2RK+Y4wMfJR4pDNft0JFC03o9ApRqHsWEzMg3IuSfDPcLSxe
 /SFfdUVDmMkkZtW6Ax2UjBPzo6ZDb5x7fCccKHA8UJLAm9zHU6yDu9Cu9w3w7IMlBZu8
 PoJKjAj7i8hmzQyYl3ungYVRNHM/lNr6wMgzTNcr9K3RfeQfYXoRwU6BvQOROGQF1nFn
 /s9gOkgPDA793xfZSMhv5gzYpRsRE+V8Mq41L9J/+DRYO6E73AOJMnJJadidcGf5n6X7
 848LIZ2/uBt3N+tx3cCcMLKHykZmtTbP5n/GzsOVMFb+PCucFn+1s+Gdho9A4c5zHOsW
 XA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784809659; x=1785414459;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xNphbIzswM9eFwLcfCGZbRoQNelEB99q8hXmKnFIwF0=;
 b=fBIlV8rzaQXdd2VW9u/8/b5lTmSG6ZS2/6gfQNuQwIxDlijV3UVjKJVkv6Y7U6ORzO
 o1Zi0aBiGXxAw2hya8QjjDFfnHZqX+SZHPsRzGZzX4LZdBqmHG3F7yuaViyhzKGPtoLe
 f45hIpviiUjo2YRWNMgRXowLgvEuI/TLPw/FDPTZOrf3xj3C8wT1vYxBUdR1SfZ8GFnx
 eCTpZs5yhsVIfVTSDQNKvDCi0D8Pjro5wdFmxT9v6m2aoBeRL5Ro86SKXqfIBkekRWtk
 e8A5sLqfwLFlDsXeiQb4yQZ857bxmdMpi3eoQw6SVCH2SsxtjNbr4MaH3UPpwHXVNKOH
 AJnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoefCDqKXVXEXur1A+mXf/m6Mr7Y8aR0ZQoVRTIt0+IL+D6TTnzIbB9LSub8eCLSXTcTsjSbZruk7KC@nongnu.org
X-Gm-Message-State: AOJu0YzP9jmq+8CySqmK4uwNlwCzFHx1OM5tm0sNxvbpLV03ZdGSWktu
 qNZBRoRwwPkNFoQdOxacpYAtbPRmSnvVDh5riRycrkI/N8CePPCAsPteGdVWny+mycXnhCfXkZx
 ENGe5BpA0mYRXYhw9z61oCIboVr3nSFVPNpdlhx/l6IHOWbpGPn3+BFSV4w==
X-Gm-Gg: AR+sD10E4VKf/efXH+JrbfotGnCM0nr2sJCDL4XqN+sCxvF/yoraTRhQCA5vf5uFry6
 TEg283vecezOUkXf9asDwltjYSiJ8CRIWvPZjn61PPn7O5ppyDLtbSEsSw9IReAae5B5tWap8fQ
 577V5i+vSrAHBKpAYqrDw0WvYoBeKGukMlz5k8gUdDhhr94iwIkEv4vsZeLRkki3+QPkYssXpv0
 Zw20yV0m2pWKg/bBinZt8dw5mmIT78fhmiv8FlKQQAwptQJusf2iE2NMCOcDOdZVEj6JLY5FS2s
 4hG7TFV3MXwgzz7bSmjJVvEQFhgzvntyptEEwx0yRlqDD8FAOcL4bkNiAUhF5dJet2y/fdIsD1R
 h19oxLWOG/EE+v6CEBZz9/52i3X7atJWi/5+B7oQdsgBVAT+NrzQ=
X-Received: by 2002:a05:622a:14e:b0:521:556:e492 with SMTP id
 d75a77b69052e-5283e02ea57mr25781251cf.88.1784809658668; 
 Thu, 23 Jul 2026 05:27:38 -0700 (PDT)
X-Received: by 2002:a05:622a:14e:b0:521:556:e492 with SMTP id
 d75a77b69052e-5283e02ea57mr25780841cf.88.1784809658152; 
 Thu, 23 Jul 2026 05:27:38 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm15665397f8f.34.2026.07.23.05.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 05:27:37 -0700 (PDT)
Message-ID: <d934b1b8-d639-420c-9974-f728fb752bbd@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 14:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vmware_vga: Don't allow guest to trigger long
 running loop in host
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
References: <20260723120020.330089-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723120020.330089-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -CiSJJ9CbgcbXOcQweO5f7_qt_GnQAkS
X-Proofpoint-ORIG-GUID: -CiSJJ9CbgcbXOcQweO5f7_qt_GnQAkS
X-Authority-Analysis: v=2.4 cv=baZbluPB c=1 sm=1 tr=0 ts=6a6208bb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=J_-Nd1mkAAAA:8 a=AbWGNAM0AYlVCVsMptEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyMyBTYWx0ZWRfXz84wq1gEiwqE
 8b2bKD7IaKJdHCsvo2p7XUBP43zNTaMj8QN1DadJw7MsAodDcJfcqK9cWla1Y1oO6aRC3tuOYSY
 ln2J654ZzmyZDYJMRUkS2d89FlqtFw8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyMyBTYWx0ZWRfX4f5NcWe7wC0i
 ONtWJjUMvZtro4GK4PdlkBkk96VjCFJLAS7NN4y5iYUfye9qoIKhVhrjYAojyJGxu/E1c0L2RpJ
 Fw6+fIY0qTgGNxe6b/kF3ohmuxPJxf/VsQFEKWaKFPDkoTm01TfecP1q11VIK5Ym2wskCCcxutm
 pQWdaQy8VV4RscdBFi0T/aY5vn9TjUn4bYjKAk/z/AXByFPBHlXCSH6VEfXQdkoK+NhIOLaQKTZ
 8Rdd/FYCtvSGwmoUQiEG2uP7t8s52yv7B47+ON7EGYNxhX1brw7RybD9Wii8HDwB+ltNZ1zW7TU
 Fj6zS11mOf0Zk3K/z6af/wW9BKX35HgjTTCEU8NIejRdvIvl6SRilOPmz4PYkfUViBbPwUSeiXg
 H+97PVzDs1nuel7t0BXiY3hwJIfJaDNarhS4C7zoRkcjQAlSqAziyUkRt4tH//0GbNqdKZj4o+x
 YPJFKJJ8euxdD5966sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230123
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Thomas,

On 23/7/26 14:00, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in vmsvga_fifo_run()
> basically does:
> 
>              x = vmsvga_fifo_read(s);
>              y = vmsvga_fifo_read(s);
>              args = x * y;
>              goto badcmd;
>              ...
> badcmd:
>              len -= args;
>              if (len < 0) {
>                  goto rewind;
>              }
>              while (args--) {
>                  vmsvga_fifo_read(s);
>              }
> 
> Thus by supplying huge values for x and y that overflow the result of
> the multiplication, the guest can trigger a long-running loop here
> that burns the host's CPU cycles.
> 
> Add some sanity checks so that this cannot happen anymore.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
> Reported-by: Feifan Qian <bea1e@proton.me>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
> Reported-by: Sunday Jiang
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/display/vmware_vga.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> index f6f9edfd1d9..04cc438cc02 100644
> --- a/hw/display/vmware_vga.c
> +++ b/hw/display/vmware_vga.c
> @@ -737,6 +737,9 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
>               vmsvga_fifo_read(s);
>               x = vmsvga_fifo_read(s);
>               y = vmsvga_fifo_read(s);
> +            if (x < 0 || x >= 32768 || y < 0 || y >= 32768) {

Maybe add a self-decribing definition instead of magic number?

   #define ALPHA_CURSOR_SAFE_LIMIT 32768 /* Arbitrary limit */

Otherwise LGTM.

> +                goto rewind;
> +            }
>               args = x * y;
>               goto badcmd;
>           case SVGA_CMD_RECT_ROP_FILL:
> @@ -776,7 +779,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
>               if (len < 0) {
>                   goto rewind;
>               }
> -            while (args--) {
> +            while (args-- > 0) {
>                   vmsvga_fifo_read(s);
>               }
>               printf("%s: Unknown command 0x%02x in SVGA command FIFO\n",


